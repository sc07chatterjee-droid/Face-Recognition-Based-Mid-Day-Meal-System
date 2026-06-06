#!/bin/bash

# Definition of colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting Face Recognition App setup...${NC}"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
  echo -e "${RED}Error: Docker is not running.${NC}"
  echo "Please start Docker Desktop or OrbStack and try again."
  exit 1
fi
echo -e "${GREEN}✓ Docker is running${NC}"

# Check for backend .env file
if [ ! -f "backend/.env" ]; then
    echo -e "${YELLOW}Warning: backend/.env file not found!${NC}"
    if [ -f "backend/.env.example" ]; then
        echo "Creating backend/.env from example..."
        cp backend/.env.example backend/.env
        echo -e "${YELLOW}IMPORTANT: Please edit backend/.env and add your GEMINI_API_KEY before continuing.${NC}"
        # We don't exit here, we let the user know they might need to restart if they want real functionality
        # or we could pause. Let's pause to let them edit it.
        read -p "Press Enter to continue (or Ctrl+C to stop and edit the file now)..."
    else
        echo -e "${RED}Error: backend/.env.example also missing. Cannot create config.${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✓ backend/.env found${NC}"
fi

# Build and start containers
echo -e "${GREEN}Building and starting containers...${NC}"
docker-compose up -d --build

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Application started successfully!${NC}"
    echo "Frontend: http://localhost:80"
    echo "Backend: http://localhost:8000"
    echo "Logs: docker-compose logs -f"
else
    echo -e "${RED}Error: Failed to start application.${NC}"
    exit 1
fi
