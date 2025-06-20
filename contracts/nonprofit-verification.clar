;; Non-Profit Verification Contract
;; Validates and manages non-profit organizations

;; Constants
(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_ALREADY_VERIFIED (err u101))
(define-constant ERR_NOT_FOUND (err u102))
(define-constant ERR_INVALID_STATUS (err u103))

;; Data Variables
(define-data-var next-nonprofit-id uint u1)

;; Data Maps
(define-map nonprofits
  { nonprofit-id: uint }
  {
    name: (string-ascii 100),
    description: (string-ascii 500),
    wallet: principal,
    verified: bool,
    registration-date: uint,
    verification-date: (optional uint)
  }
)

(define-map nonprofit-by-wallet
  { wallet: principal }
  { nonprofit-id: uint }
)

;; Public Functions

;; Register a new non-profit organization
(define-public (register-nonprofit (name (string-ascii 100)) (description (string-ascii 500)))
  (let
    (
      (nonprofit-id (var-get next-nonprofit-id))
      (caller tx-sender)
    )
    (asserts! (is-none (map-get? nonprofit-by-wallet { wallet: caller })) ERR_ALREADY_VERIFIED)

    (map-set nonprofits
      { nonprofit-id: nonprofit-id }
      {
        name: name,
        description: description,
        wallet: caller,
        verified: false,
        registration-date: block-height,
        verification-date: none
      }
    )

    (map-set nonprofit-by-wallet
      { wallet: caller }
      { nonprofit-id: nonprofit-id }
    )

    (var-set next-nonprofit-id (+ nonprofit-id u1))
    (ok nonprofit-id)
  )
)

;; Verify a non-profit organization (only contract owner)
(define-public (verify-nonprofit (nonprofit-id uint))
  (let
    (
      (nonprofit (unwrap! (map-get? nonprofits { nonprofit-id: nonprofit-id }) ERR_NOT_FOUND))
    )
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_UNAUTHORIZED)
    (asserts! (not (get verified nonprofit)) ERR_ALREADY_VERIFIED)

    (map-set nonprofits
      { nonprofit-id: nonprofit-id }
      (merge nonprofit { verified: true, verification-date: (some block-height) })
    )
    (ok true)
  )
)

;; Read-only Functions

;; Get non-profit details by ID
(define-read-only (get-nonprofit (nonprofit-id uint))
  (map-get? nonprofits { nonprofit-id: nonprofit-id })
)

;; Get non-profit ID by wallet
(define-read-only (get-nonprofit-by-wallet (wallet principal))
  (map-get? nonprofit-by-wallet { wallet: wallet })
)

;; Check if non-profit is verified
(define-read-only (is-nonprofit-verified (nonprofit-id uint))
  (match (map-get? nonprofits { nonprofit-id: nonprofit-id })
    nonprofit (get verified nonprofit)
    false
  )
)

;; Get next non-profit ID
(define-read-only (get-next-nonprofit-id)
  (var-get next-nonprofit-id)
)
