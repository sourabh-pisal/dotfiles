export SSH_ENV="$HOME/.ssh/agent_env"

start_ssh_agent() {
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    chmod 600 "$SSH_ENV"

    source "$SSH_ENV" > /dev/null

    ssh-add ~/.ssh/id_ed25519 2>/dev/null
}

if [ -f "$SSH_ENV" ]; then
    source "$SSH_ENV" > /dev/null

    ps -p "$SSH_AGENT_PID" > /dev/null 2>&1 || start_ssh_agent
else
    start_ssh_agent
fi
