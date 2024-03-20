use clap::{Parser, Subcommand};

mod zsh_prompt;

fn main() {
    let args = Args::parse();
    match args.command {
        Commands::Prompt { exit_code } => print!("{}", crate::zsh_prompt::zsh_prompt(exit_code)),
    }
}

#[derive(Parser)]
#[command(version, about)]
struct Args {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Print zsh prompt; pass $? to include exit code of last command
    Prompt { exit_code: Option<usize> },
}
