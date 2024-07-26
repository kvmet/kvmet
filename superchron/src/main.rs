use anyhow::Result;
use clap::{ArgMatches, Command};
use crossbeam::channel as cb_channel;
use std::sync::{Arc, Mutex};
use std::thread;
use std::time::Duration;

enum CommandMessage {
    Start,
    Stop,
}

fn background_task(
    command_rx: Arc<Mutex<cb_channel::Receiver<CommandMessage>>>,
    periodic_rx: cb_channel::Receiver<()>,
) {
    loop {
        crossbeam::select! {
            recv(command_rx.lock().unwrap()) -> msg => {
                match msg {
                    Ok(CommandMessage::Start) => {
                        println!("Background task started");
                        // Insert dynamic loading & dispatching logic here
                    }
                    Ok(CommandMessage::Stop) => {
                        println!("Background task stopping");
                        break;
                    }
                    Err(_) => println!("Background task error: Failed to receive message"),
                }
            },
            recv(periodic_rx) -> _ => {
                // This block runs every 1ms.
                println!("High precision periodic task executing.");
            }
        }
    }
}

fn handle_cli(matches: ArgMatches) -> Result<()> {
    let (command_tx, command_rx) = cb_channel::unbounded();
    let command_rx = Arc::new(Mutex::new(command_rx));

    let (periodic_tx, periodic_rx) = cb_channel::bounded(0);

    if matches.subcommand_matches("start").is_some() {
        let command_rx_clone = Arc::clone(&command_rx);

        // Start a thread for the high-precision periodic task
        thread::spawn(move || {
            loop {
                // Signal the periodic task receiver
                periodic_tx.send(()).expect("Failed to send periodic tick");
                // Sleep for 1 millisecond
                thread::sleep(Duration::from_millis(1));
            }
        });

        // Start the background task thread
        thread::spawn(move || {
            background_task(command_rx_clone, periodic_rx);
        });

        command_tx.send(CommandMessage::Start).unwrap();
        println!("Background process started");
    } else if matches.subcommand_matches("stop").is_some() {
        command_tx.send(CommandMessage::Stop).unwrap();
        println!("Background process stopped");
    } else {
        println!("Invalid command. Use 'suchr start' or 'suchr stop'.");
        std::process::exit(1);
    }

    Ok(())
}

fn main() -> Result<()> {
    let matches = Command::new("suchr")
        .version("1.0")
        .author("Your Name <your.email@example.com>")
        .about("Starts and stops a background process for handling dynamic dispatch")
        .subcommand(Command::new("start").about("Starts the background process"))
        .subcommand(Command::new("stop").about("Stops the background process"))
        .get_matches();

    handle_cli(matches)
}
