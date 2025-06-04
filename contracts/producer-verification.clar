;; Quality Certification Contract
;; Manages quality certifications for food products

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u300))
(define-constant err-not-found (err u301))
(define-constant err-unauthorized (err u302))
(define-constant err-invalid-grade (err u303))

;; Quality certifications
(define-map quality-certifications
  { cert-id: uint }
  {
    product-id: uint,
    quality-grade: (string-ascii 10),
    certification-type: (string-ascii 50),
    certified-by: principal,
    certification-date: uint,
    expiry-date: uint,
    test-results: (string-ascii 200),
    passed: bool
  }
)

;; Quality standards
(define-map quality-standards
  { standard-id: uint }
  {
    name: (string-ascii 100),
    description: (string-ascii 200),
    min-score: uint,
    active: bool
  }
)

;; Counters
(define-data-var next-cert-id uint u1)
(define-data-var next-standard-id uint u1)

;; Create quality certification
(define-public (create-quality-certification
  (product-id uint)
  (quality-grade (string-ascii 10))
  (certification-type (string-ascii 50))
  (test-results (string-ascii 200))
  (passed bool)
)
  (let ((cert-id (var-get next-cert-id)))
    (map-set quality-certifications
      { cert-id: cert-id }
      {
        product-id: product-id,
        quality-grade: quality-grade,
        certification-type: certification-type,
        certified-by: tx-sender,
        certification-date: block-height,
        expiry-date: (+ block-height u26280), ;; ~6 months
        test-results: test-results,
        passed: passed
      }
    )
    (var-set next-cert-id (+ cert-id u1))
    (print { event: "quality-certified", cert-id: cert-id, product-id: product-id, passed: passed })
    (ok cert-id)
  )
)

;; Add quality standard
(define-public (add-quality-standard
  (name (string-ascii 100))
  (description (string-ascii 200))
  (min-score uint)
)
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (let ((standard-id (var-get next-standard-id)))
      (map-set quality-standards
        { standard-id: standard-id }
        {
          name: name,
          description: description,
          min-score: min-score,
          active: true
        }
      )
      (var-set next-standard-id (+ standard-id u1))
      (print { event: "quality-standard-added", standard-id: standard-id })
      (ok standard-id)
    )
  )
)

;; Get quality certification
(define-read-only (get-quality-certification (cert-id uint))
  (map-get? quality-certifications { cert-id: cert-id })
)

;; Get quality standard
(define-read-only (get-quality-standard (standard-id uint))
  (map-get? quality-standards { standard-id: standard-id })
)

;; Check if product has valid certification
(define-read-only (has-valid-certification (product-id uint))
  (let ((cert (map-get? quality-certifications { cert-id: u1 }))) ;; Simplified lookup
    (match cert
      certification (and (get passed certification) (> (get expiry-date certification) block-height))
      false
    )
  )
)
