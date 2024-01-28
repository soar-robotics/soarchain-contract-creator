#!/bin/bash

# GitHub repository URL
REPO_URL="https://github.com/soar-robotics/soarchain-contract-creator.git"


# Clone the repository
echo "Cloning GitHub repository..."
git clone "$REPO_URL" 

cd soarchain-contract-creator

# Display success message
echo "Repository cloned into: $LOCAL_DIR"
