#!/bin/bash
set -e

if [ ! -f .next/BUILD_ID ]; then
  npx prisma generate
  npm run build
fi

exec npm start