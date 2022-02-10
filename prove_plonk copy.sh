#!/bin/sh
HOME_DIR=$(pwd)
PTAU=$HOME_DIR/powersOfTau28_hez_final_14.ptau
cd $1

if [ ! -d dist ]; then
    mkdir dist
fi

cd dist/circuit_js 

START="$(date +%s%N)"

node generate_witness.js circuit.wasm ../../input.json ../witness.wtns

END="$(date +%s%N)"

echo "Witness generation time: $((END - START))"

cd ../..

START="$(date +%s%N)"

snarkjs plonk prove dist/circuit_final.zkey dist/witness.wtns proof.json public.json

END="$(date +%s%N)"

echo "Proving time: $((END - START))"

START="$(date +%s%N)"

snarkjs plonk verify dist/verification_key.json public.json proof.json

END="$(date +%s%N)"

echo "Proving time: $((END - START))"