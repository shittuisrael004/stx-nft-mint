;; V1 SargeSmith NFT - Mainnet
(impl-trait 'SP2PABAF9FTAJYNFZH93XENAJ8FVY99RRM50D2JG9.nft-trait.nft-trait)

;; 1. Traits & Constants
(define-non-fungible-token sargesmith-nft uint)

;; The principal that deploys the contract becomes the owner
(define-constant CONTRACT-OWNER tx-sender)

;; 0.01 STX = 10,000 micro-STX
(define-constant MINT-PRICE u10000) 

;; Error Codes
(define-constant ERR-NOT-AUTHORIZED (err u403))
(define-constant ERR-STX-TRANSFER (err u101))
(define-constant ERR-MINT-FAILED (err u102))

;; 2. Data Variables
(define-data-var last-id uint u0)

;; 3. Read-Only Functions
(define-read-only (get-last-token-id)
    (ok (var-get last-id))
)

;; New: Get total minted (Same as last-id in this case)
(define-read-only (get-total-minted)
    (ok (var-get last-id))
)

(define-read-only (get-owner (token-id uint))
    (ok (nft-get-owner? sargesmith-nft token-id))
)

(define-read-only (get-token-uri (token-id uint))
    (ok (some "https://ipfs.io/ipfs/bafkreiekadhuwanfpql3hly3hklpkr6ftfz73zwevmtnsx6mk7rfnrgru4"))
)

;; 4. Public Functions

;; Mint function with 0.01 STX fee
(define-public (mint-nft)
  (let (
    (current-id (+ (var-get last-id) u1))
    (minter tx-sender)
  )
    ;; Charge the 0.01 STX fee
    (asserts! 
      (is-ok (as-contract (stx-transfer? MINT-PRICE minter tx-sender)))
      ERR-STX-TRANSFER
    )

    ;; Mint the token
    (try! (nft-mint? sargesmith-nft current-id minter))

    ;; Update the counter
    (var-set last-id current-id)
    
    (ok current-id)
  )
)   

;; New: Withdraw STX (Only the Owner can do this)
(define-public (withdraw-stx)
    (let (
        (balance (stx-get-balance (as-contract tx-sender)))
    )
        ;; Check if the person calling is the owner
        (asserts! (is-eq tx-sender CONTRACT-OWNER) ERR-NOT-AUTHORIZED)
        
        ;; Transfer all STX from contract to owner
        (as-contract (stx-transfer? balance tx-sender CONTRACT-OWNER))
    )
)

;; SIP009 Transfer
(define-public (transfer (token-id uint) (sender principal) (recipient principal))
    (begin
        (asserts! (is-eq tx-sender sender) ERR-NOT-AUTHORIZED)
        (nft-transfer? sargesmith-nft token-id sender recipient)
    )
)