#!/bin/bash

# Calculate the total number of nodes (subtracting 1 for the header row)
total=$(kubectl get nodes | wc -l)
total=$((total - 1))

# Count how many nodes are in "Ready" status
ready=$(kubectl get nodes | grep ' Ready' | wc -l)

# Count how many nodes are not in "Ready" status (also subtracting 1 for the header row)
notReady=$(kubectl get nodes | grep -v ' Ready' | wc -l)
notReady=$((notReady - 1))

# Display the counts
echo "Total nodes: $total"
echo "Ready nodes: $ready"
echo "NotReady nodes: $notReady"


