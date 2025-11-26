#!/bin/bash

# Daily AI Idea Generation Script for IdeaSpot.ai
# This script runs daily to generate fresh startup ideas

# Configuration
API_BASE_URL="https://idea-browse.preview.emergentagent.com/api"
LOG_FILE="/app/logs/ai_generation.log"

# Create logs directory if it doesn't exist
mkdir -p /app/logs

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Start daily generation
log_message "🚀 Starting daily AI idea generation..."

# Call the AI generation endpoint
response=$(curl -s -X POST "$API_BASE_URL/ai/generate-test-ideas" \
  -H "Content-Type: application/json" \
  -w "HTTP_STATUS:%{http_code}")

# Extract HTTP status code
http_status=$(echo "$response" | grep -o "HTTP_STATUS:[0-9]*" | cut -d: -f2)
response_body=$(echo "$response" | sed 's/HTTP_STATUS:[0-9]*$//')

# Check if the request was successful
if [ "$http_status" -eq 200 ]; then
    # Parse the response to check if generation was successful
    success=$(echo "$response_body" | jq -r '.success // false' 2>/dev/null)
    
    if [ "$success" = "true" ]; then
        ideas_count=$(echo "$response_body" | jq -r '.ideas_count // 0' 2>/dev/null)
        log_message "✅ Successfully generated $ideas_count new startup ideas!"
        
        # Log the idea titles for reference
        echo "$response_body" | jq -r '.ideas_preview[]?.title // "Unknown title"' 2>/dev/null | while read -r title; do
            log_message "   💡 Generated: $title"
        done
        
        exit 0
    else
        message=$(echo "$response_body" | jq -r '.message // "Unknown error"' 2>/dev/null)
        log_message "❌ Generation failed: $message"
        exit 1
    fi
else
    log_message "❌ HTTP request failed with status: $http_status"
    log_message "Response: $response_body"
    exit 1
fi
