#!/bin/bash

# Final script to display collected next steps and finish setup
set -e

QUEUE_FILE="/tmp/chezmoi_next_steps_$$"

echo ""
echo "🎉 Chezmoi dotfiles setup complete!"
echo ""

# Check if there are any next steps to display
if [[ -f "$QUEUE_FILE" && -s "$QUEUE_FILE" ]]; then
    echo "📝 Next steps:"
    
    # Read each line from the queue and format it nicely
    while IFS= read -r step; do
        echo "   • $step"
    done < "$QUEUE_FILE"
    
    # Clean up the temp file
    rm -f "$QUEUE_FILE"
    
    echo ""
    echo "✨ Welcome to your new development environment!"
else
    echo "✨ All set! No additional steps required."
fi

echo "" 