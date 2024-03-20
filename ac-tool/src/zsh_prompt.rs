use std::env;
use std::process::Command;

use chrono::Local;

pub fn zsh_prompt(exit_code: Option<usize>) -> String {
    use Color::*;

    let home = env::var("HOME").unwrap_or(String::new());
    let pwd = env::current_dir()
        .map(|p| p.to_string_lossy().to_string())
        .unwrap_or("<unknown pwd>".to_string());
    let pwd_abbrev = pwd.replacen(&home, "~", 1);

    let git_branch = current_git_branch();
    let now_str = Local::now().format("%H:%M:%S").to_string();
    let exit_color = if exit_code == Some(0) { Green } else { Red };

    format!(
        "{}λ ",
        merge_components(vec![
            (Magenta, Some(now_str)),
            (Green, git_branch),
            (Blue, Some(pwd_abbrev)),
            (exit_color, exit_code.map(|e| e.to_string())),
        ])
    )
}

/// Return the name of the current git branch iff in a repo.
fn current_git_branch() -> Option<String> {
    Command::new("git")
        .arg("branch")
        .arg("--show-current")
        .output()
        .ok()
        .filter(|output| output.status.success())
        .and_then(|output| String::from_utf8(output.stdout).ok())
        .map(|s| s.trim().to_string())
}

#[derive(Copy, Clone)]
pub enum Color {
    Reset,
    Blue,
    Green,
    Magenta,
    Red,
}

fn zsh_prompt_ansi(c: Color) -> String {
    use Color::*;
    let color_code = match c {
        Reset => 0,
        Blue => 34,
        Green => 32,
        Magenta => 35,
        Red => 31,
    };
    // Necessary for Zsh to correctly calculate cursor position.
    // Includes a space at the end.
    format!("%{{\u{001B}[{color_code}m%}}")
}

fn merge_components(components: Vec<(Color, Option<String>)>) -> String {
    let mut buffer = String::with_capacity(128);
    components
        .into_iter()
        .filter_map(|(color, maybe_str)| maybe_str.map(|str| (color, str)))
        .for_each(|(color, str)| {
            buffer.push_str(&zsh_prompt_ansi(color));
            buffer.push_str(&str);
            buffer.push_str(&zsh_prompt_ansi(Color::Reset));
            buffer.push(' ');
        });
    buffer
}
