#!/bin/bash
HOME_DIR=$(pwd)
PTAU=$HOME_DIR/powersOfTau28_hez_final_14.ptau
cd $1

if [ ! -d dist ]; then
    mkdir dist
fi

circom circuit.circom --r1cs --wasm --sym -o dist

cd dist/circuit_js 

node generate_witness.js circuit.wasm ../../input.json ../witness.wtns

cd ../..

snarkjs plonk setup dist/circuit.r1cs $PTAU dist/circuit_final.zkey 

snarkjs zkey export verificationkey dist/circuit_final.zkey dist/verification_key.json