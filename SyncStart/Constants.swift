//
//  Constants.swift
//  SyncStart
//
//  Created by 砚渤 on 2024/1/30.
//

import Foundation


let defaultScriptTemplate = """
#!/bin/bash

# SSH credentials and server details
SSH_USER={UserName}
SSH_HOST={Host}
SSH_PORT={Port}

# Local and remote paths
LOCAL_PATH={LocalPath}
REMOTE_PATH={RemotePath}

# Make intermediate directories if they don't exist on the remote server
ssh -p $SSH_PORT $SSH_USER@$SSH_HOST "mkdir -p $REMOTE_PATH"

# Rsync command for transferring the entire directory
rsync -avz -e "ssh -p $SSH_PORT" $LOCAL_PATH $SSH_USER@$SSH_HOST:$REMOTE_PATH

echo "rsync operations completed."

# SSH run python EntryPoint.py
ssh -p $SSH_PORT $SSH_USER@$SSH_HOST "cd $REMOTE_PATH/EI && python EntryPoint.py"

"""
