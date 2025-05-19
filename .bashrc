# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

alias codium="flatpak run com.vscodium.codium ."
alias files="nautilus . &> /dev/null & disown"

# Create an alias for the containerized AWS CLI
alias aws="podman run --privileged --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws --env AWS_ACCESS_KEY_ID --env AWS_SECRET_ACCESS_KEY --env AWS_SESSION_TOKEN --env AWS_DEFAULT_REGION --env AWS_DEFAULT_OUTPUT --env AWS_PROFILE --env AWS_CA_BUNDLE --env AWS_SHARED_CREDENTIALS_FILE --env AWS_CONFIG_FILE --env AWS_ROLE_ARN --env AWS_ROLE_SESSION_NAME --env AWS_WEB_IDENTITY_TOKEN_FILE --env AWS_ROLE_ARN --env AWS_METADATA_SERVICE_TIMEOUT --env AWS_METADATA_SERVICE_NUM_ATTEMPTS --env AWS_STS_REGIONAL_ENDPOINTS --env AWS_MAX_ATTEMPTS --env AWS_RETRY_MODE --env AWS_EC2_METADATA_DISABLED --env AWS_SDK_UA_APP_ID ghcr.io/alexstorm1313/aws-cli:latest $@"

# Enable tab completion for the containerized AWS CLI
complete -C "podman run --rm -i --entrypoint /usr/local/bin/aws_completer -e COMP_LINE -e COMP_POINT ghcr.io/alexstorm1313/aws-cli:latest $@" aws

eval "$(starship init bash)"
