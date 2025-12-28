;; title: SIP-009 nft mint with 0.01 STX fee
;; version: Clarity 4
;; summary: A simple SIP-009 NFT smart contract on Stacks that mints NFTs for a fixed fee, where every NFT shares the same permanent image via a constant metadata URI, and mint fees are withdrawable only by a hard-coded owner wallet.
;; description: This contract implements a minimal, secure NFT collection on the Stacks blockchain. Each mint costs 0.01 STX, and all NFTs reference the same immutable metadata and image, ensuring visual consistency across the collection. The contract uses a sequential token ID counter, follows the SIP-009 standard, and includes an owner-only withdrawal function to collect mint proceeds. Designed as an MVP, it is lightweight, auditable, and easy to extend with features like supply caps, whitelists, or royalties.

;; traits
;;

;; token definitions
;;

;; -------------------------
;; Constants
;; -------------------------

;; owner wallet (CHANGE THIS FOR TESTNET OR MAINNET)
(define-constant CONTRACT-OWNER 'SP267C6MQJHPR7297033Z8VSKTJM7M62V375BRHHP)

;; Mint price: 0.01 STX (1 STX = 1_000_000 microSTX)
(define-constant MINT-PRICE u10000)

;; Static metadata URI (same for every NFT)
(define-constant TOKEN-URI "ipfs://QmYourMetadataHashHere")

;; -------------------------
;; Errors
;; -------------------------

;; Error: Not contract owner
(define-constant ERR-NOT-OWNER u100)

;; Error: STX transfer failed
(define-constant ERR-STX-TRANSFER u101)

;; data vars
;;

;; data maps
;;

;; public functions
;;

;; read only functions
;;

;; private functions
;;

