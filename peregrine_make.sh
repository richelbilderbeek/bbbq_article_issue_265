#!/bin/bash
# Bash script to call make with sbatch
#
# Usage:
#
#   sbatch make.sh
#
#   sbatch make.sh all
#
#SBATCH --time=240:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=20G
#SBATCH --job-name=make
#SBATCH --output=265.log
module load R
echo "make $@"
make "$@"
