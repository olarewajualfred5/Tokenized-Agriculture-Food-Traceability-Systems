;; Producer Verification Contract
;; Validates and manages food producers in the system

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))
(define-constant err-unauthorized (err u103))

;; Producer data structure
(define-map producers
  { producer-id: uint }
  {
    name: (string-ascii 100),
    location: (string-ascii 100),
    certification-level: uint,
    verified: bool,
    registered-at: uint
  }
)

;; Producer verification status
(define-map producer-verifications
  { producer-id: uint }
  {
    verified-by: principal,
    verification-date: uint,
    expiry-date: uint,
    status: (string-ascii 20)
  }
)

;; Counter for producer IDs
(define-data-var next-producer-id uint u1)

;; Register a new producer
(define-public (register-producer (name (string-ascii 100)) (location (string-ascii 100)))
  (let ((producer-id (var-get next-producer-id)))
    (asserts! (is-none (map-get? producers { producer-id: producer-id })) err-already-exists)
    (map-set producers
      { producer-id: producer-id }
      {
        name: name,
        location: location,
        certification-level: u0,
        verified: false,
        registered-at: block-height
      }
    )
    (var-set next-producer-id (+ producer-id u1))
    (print { event: "producer-registered", producer-id: producer-id, name: name })
    (ok producer-id)
  )
)

;; Verify a producer (admin only)
(define-public (verify-producer (producer-id uint) (certification-level uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (is-some (map-get? producers { producer-id: producer-id })) err-not-found)
    (map-set producers
      { producer-id: producer-id }
      (merge (unwrap-panic (map-get? producers { producer-id: producer-id }))
        { verified: true, certification-level: certification-level }
      )
    )
    (map-set producer-verifications
      { producer-id: producer-id }
      {
        verified-by: tx-sender,
        verification-date: block-height,
        expiry-date: (+ block-height u52560), ;; ~1 year
        status: "verified"
      }
    )
    (print { event: "producer-verified", producer-id: producer-id })
    (ok true)
  )
)

;; Get producer information
(define-read-only (get-producer (producer-id uint))
  (map-get? producers { producer-id: producer-id })
)

;; Check if producer is verified
(define-read-only (is-producer-verified (producer-id uint))
  (match (map-get? producers { producer-id: producer-id })
    producer (get verified producer)
    false
  )
)

;; Get verification details
(define-read-only (get-verification (producer-id uint))
  (map-get? producer-verifications { producer-id: producer-id })
)
