# Get Node name from path (works with 3 characters only...)
[regex]::match($path, 'Corporate/(...)/').Groups[1].Value