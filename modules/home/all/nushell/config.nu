$env.config = {
  show_banner: false
  use_kitty_protocol: true

  edit_mode: vi
  cursor_shape: {
    vi_insert: line
    vi_normal: underscore
  }
}
def nsdc [
    before: path = /run/booted-system
    after: path = /run/current-system
]: nothing -> table {
  ^nix store diff-closures $before $after
  | lines
  | parse -r '^(?<pkg>[\w\.-]+): ?(?:(?<before>.+) → (?<after>.+?)),?? ?(?<size>[+-][\d\.]+ KiB)?$'
  | update before { str replace -a ", " "\n" }
  | update after  { str replace -a ", " "\n" } 
  | rename -c {before: ($before | path basename), after: ($after | path basename)}
  | update size {|row| if ($row.size | is-empty) {"0 B"} else {$row.size}} | into filesize size
}
