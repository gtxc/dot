#!/usr/bin/env sh

set -e

# Place holder for status left/right
place_holder="\#{prefix_highlight}"

# Possible configurations
fg_color_config="@prefix_highlight_fg"
bg_color_config="@prefix_highlight_bg"
output_prefix="@prefix_highlight_output_prefix"
output_suffix="@prefix_highlight_output_suffix"
show_copy_config="@prefix_highlight_show_copy_mode"
show_sync_config="@prefix_highlight_show_sync_mode"
copy_attr_config="@prefix_highlight_copy_mode_attr"
sync_attr_config="@prefix_highlight_sync_mode_attr"
prefix_prompt="@prefix_highlight_prefix_prompt"
copy_prompt="@prefix_highlight_copy_prompt"
sync_prompt="@prefix_highlight_sync_prompt"
empty_prompt="@prefix_highlight_empty_prompt"
empty_attr_config="@prefix_highlight_empty_attr"
empty_has_affixes="@prefix_highlight_empty_has_affixes"

tmux_option() {
  value=$(tmux show-option -gqv "$1")
  default="$2"

  if [ -n "$value" ]; then
    echo "$value"
  else
    echo "$default"
  fi
}

format_style() {
  echo "#[${1}]" | sed -e "s/,/]#[/g"
}

# Defaults
# default_fg='colour231'
# default_bg='colour04'
# default_copy_attr='fg=default,bg=yellow'
# default_sync_attr='fg=default,bg=yellow'
# default_empty_attr='fg=default,bg=default'
# default_prefix_prompt=$(tmux_option prefix | tr "[:lower:]" "[:upper:]" | sed 's/C-/\^/')
# default_copy_prompt='Copy'
# default_sync_prompt='Sync'
# default_empty_prompt=''

main() {
  fg_color=$(tmux_option "$fg_color_config" "$default_fg")
  bg_color=$(tmux_option "$bg_color_config" "$default_bg")
  show_copy_mode=$(tmux_option "$show_copy_config" "off")
  show_sync_mode=$(tmux_option "$show_sync_config" "off")
  output_prefix=$(tmux_option "$output_prefix" " ")
  output_suffix=$(tmux_option "$output_suffix" " ")
  copy_attr=$(tmux_option "$copy_attr_config" "$default_copy_attr")
  sync_attr=$(tmux_option "$sync_attr_config" "$default_sync_attr")
  prefix_prompt=$(tmux_option "$prefix_prompt" "$default_prefix_prompt")
  copy_prompt=$(tmux_option "$copy_prompt" "$default_copy_prompt")
  sync_prompt=$(tmux_option "$sync_prompt" "$default_sync_prompt")
  empty_prompt=$(tmux_option "$empty_prompt" "$default_empty_prompt")
  empty_attr=$(tmux_option "$empty_attr_config" "$default_empty_attr")
  empty_has_affixes=$(tmux_option "$empty_has_affixes" "off")

  prefix_highlight="$(format_style "fg=$fg_color,bg=$bg_color")"
  prefix_mode="$prefix_highlight$output_prefix$prefix_prompt$output_suffix"

  copy_highlight="$(format_style "${copy_attr:+default,$copy_attr}")"
  copy_mode="$copy_highlight$output_prefix$copy_prompt$output_suffix"

  sync_highlight="$(format_style "${sync_attr:+default,$sync_attr}")"
  sync_mode="$sync_highlight$output_prefix$sync_prompt$output_suffix"

  empty_highlight="$(format_style "${empty_attr:+default,$empty_attr}")"
  if [ "on" = "$empty_has_affixes" ]; then
    empty_mode="$empty_highlight$output_prefix$empty_prompt$output_suffix"
  else
    empty_mode="$empty_highlight$empty_prompt"
  fi

  if [ "on" = "$show_copy_mode" ]; then
    if [ "on" = "$show_sync_mode" ]; then
      fallback="#{?pane_in_mode,$copy_mode,#{?synchronize-panes,$sync_mode,$empty_mode}}"
    else
      fallback="#{?pane_in_mode,$copy_mode,$empty_mode}"
    fi
  elif [ "on" = "$show_sync_mode" ]; then
    fallback="#{?synchronize-panes,$sync_mode,$empty_mode}"
  else
    fallback="$empty_mode"
  fi

  highlight="#{?client_prefix,$prefix_mode,$fallback}#[default]"

  status_left_value="$(tmux_option status-left)"
  tmux set-option -gq "status-left" "$(echo "$status_left_value" | sed "s/$place_holder/$highlight/g")"

  status_right_value="$(tmux_option status-right)"
  tmux set-option -gq "status-right" "$(echo "$status_right_value" | sed "s/$place_holder/$highlight/g")"

  # status_format_0_value="$(tmux_option "status-format[0]")"
  # tmux set-option -gq "status-format[0]" "${status_format_0_value//$place_holder/$highlight}"
  #
  # status_format_1_value="$(tmux_option "status-format[1]")"
  # tmux set-option -gq "status-format[1]" "${status_format_1_value//$place_holder/$highlight}"
}

main
