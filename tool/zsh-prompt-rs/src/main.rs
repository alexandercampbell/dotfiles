use std::env;
use std::env::args;
use std::process::Command;

use chrono::Local;

#[derive(Clone, Copy)]
#[allow(unused)]
enum Color {
    Reset,
    Bright,
    BlinkSlow,
    Underline,
    UnderlineOff,
    Inverse,
    InverseOff,
    Strikethrough,
    StrikethroughOff,
    Default,
    White,
    Black,
    Red,
    Green,
    Blue,
    Yellow,
    Magenta,
    Cyan,
    BgDefault,
    BgWhite,
    BgBlack,
    BgRed,
    BgGreen,
    BgBlue,
    BgYellow,
    BgMagenta,
    BgCyan,
}

fn ansi(color: Color) -> String {
    let as_str: &str = match color {
        Color::Reset => "[0m",
        Color::Bright => "[1m",
        Color::BlinkSlow => "[5m",
        Color::Underline => "[4m",
        Color::UnderlineOff => "[24m",
        Color::Inverse => "[7m",
        Color::InverseOff => "[27m",
        Color::Strikethrough => "[9m",
        Color::StrikethroughOff => "[29m",
        Color::Default => "[39m",
        Color::White => "[37m",
        Color::Black => "[30m",
        Color::Red => "[31m",
        Color::Green => "[32m",
        Color::Blue => "[34m",
        Color::Yellow => "[33m",
        Color::Magenta => "[35m",
        Color::Cyan => "[36m",
        Color::BgDefault => "[49m",
        Color::BgWhite => "[47m",
        Color::BgBlack => "[40m",
        Color::BgRed => "[41m",
        Color::BgGreen => "[42m",
        Color::BgBlue => "[44m",
        Color::BgYellow => "[43m",
        Color::BgMagenta => "[45m",
        Color::BgCyan => "[46m",
    };
    format!("%{{\u{001B}{as_str}%}}")
}

fn main() {
    let now_str = Local::now().format("%H:%M:%S ");

    let ansi_magenta = ansi(Color::Magenta);
    let ansi_green = ansi(Color::Green);
    let ansi_reset = ansi(Color::Reset);
    let ansi_blue = ansi(Color::Blue);

    let git_branch_str = &mut Command::new("git")
        .arg("branch")
        .arg("--show-current")
        .output()
        .ok()
        .filter(|output| output.status.success())
        .map(|output| String::from_utf8(output.stdout).unwrap())
        .as_mut()
        .map(|s| s.trim())
        .map_or_else(|| String::new(), |b| format!("{ansi_green}{b} "));

    let exit_code = args().skip(1).next().unwrap_or(String::new());
    let exit_code_color = ansi(if exit_code == "0" {
        Color::Green
    } else {
        Color::Red
    });

    let home = env::var("HOME").unwrap();
    let pwd = env::var("PWD").unwrap();
    let pwd_abbrev = pwd.replacen(&home, "~", 1);

    print!("{ansi_magenta}{now_str}{ansi_green}{git_branch_str}{ansi_blue}");
    print!("{pwd_abbrev} {exit_code_color}{exit_code}{ansi_reset} λ ");
}
