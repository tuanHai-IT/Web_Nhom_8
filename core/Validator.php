<?php
// core/Validator.php
// Reusable input validation — centralises rules instead of ad-hoc checks in controllers

class Validator {
    private array $errors = [];

    /**
     * Require a non-empty value.
     */
    public function required(string $field, $value, string $label = ''): self {
        if (is_null($value) || trim((string)$value) === '') {
            $this->errors[$field] = ($label ?: ucfirst($field)) . ' is required.';
        }
        return $this;
    }

    /**
     * Minimum string length.
     */
    public function minLength(string $field, $value, int $min, string $label = ''): self {
        if (strlen(trim((string)$value)) < $min) {
            $this->errors[$field] = ($label ?: ucfirst($field)) . " must be at least {$min} characters.";
        }
        return $this;
    }

    /**
     * Maximum string length.
     */
    public function maxLength(string $field, $value, int $max, string $label = ''): self {
        if (strlen(trim((string)$value)) > $max) {
            $this->errors[$field] = ($label ?: ucfirst($field)) . " must not exceed {$max} characters.";
        }
        return $this;
    }

    /**
     * Valid email format.
     */
    public function email(string $field, $value): self {
        if (!filter_var($value, FILTER_VALIDATE_EMAIL)) {
            $this->errors[$field] = 'Invalid email address.';
        }
        return $this;
    }

    /**
     * Two values must match (e.g. password confirmation).
     */
    public function match(string $field, $value1, $value2, string $label = ''): self {
        if ($value1 !== $value2) {
            $this->errors[$field] = ($label ?: ucfirst($field)) . ' does not match.';
        }
        return $this;
    }

    /**
     * Integer within range.
     */
    public function intRange(string $field, $value, int $min, int $max, string $label = ''): self {
        $v = (int)$value;
        if ($v < $min || $v > $max) {
            $this->errors[$field] = ($label ?: ucfirst($field)) . " must be between {$min} and {$max}.";
        }
        return $this;
    }

    /**
     * Check if validation has errors.
     */
    public function fails(): bool {
        return !empty($this->errors);
    }

    /**
     * Get all error messages.
     */
    public function errors(): array {
        return $this->errors;
    }

    /**
     * Get first error message.
     */
    public function firstError(): string {
        return reset($this->errors) ?: '';
    }
}
