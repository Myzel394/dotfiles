#!/bin/bash
# Doesn't work
#age -d ~/.config/secrets.txt.age | grep '^OPENAI_API_KEY=' | cut -d= -f2
grep '^OPENAI_API_KEY=' ~/.config/secrets.txt | cut -d= -f2

