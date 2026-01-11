use dep::keccak256::keccak256;

// Unconstrained helper function to pad bytes to 64
unconstrained fn pad_bytes(bytes: [u8], len: u32) -> [u8; 64] {
    let mut padded = [0u8; 64];
    let mut i = 0;
    while i < len {
        padded[i] = bytes[i];
        i += 1;
    }
    padded
}

// Accept password bytes and length, along with stored hash
fn main(password_bytes: [u8; 64], password_len: u32, stored_hash: pub [u8; 32]) {
    // Hash the password bytes using Keccak256 (only hash the meaningful bytes)
    let password_hash = keccak256(password_bytes, password_len);

    // Verify that the password hash matches the stored hash
    assert(password_hash == stored_hash);
}

#[test]
fn test_correct_password() {
    // Test with correct password
    let correct_password = "MySecurePassword123!";
    let password_bytes = correct_password.as_bytes();
    let password_len = password_bytes.len();
    // Safety: pad_bytes is unconstrained but safe - it only copies bytes up to len
    let padded_bytes = unsafe { pad_bytes(password_bytes, password_len) };
    let correct_hash = keccak256(password_bytes, password_len);
    main(padded_bytes, password_len, correct_hash);
}

#[test(should_fail)]
fn test_incorrect_password_should_fail() {
    // Test with incorrect password - should fail and verify circuit rejects it
    let correct_password = "MyPassword123";
    let correct_password_bytes = correct_password.as_bytes();
    let correct_hash = keccak256(correct_password_bytes, correct_password_bytes.len());
    let wrong_password = "WrongPassword";
    let wrong_password_bytes = wrong_password.as_bytes();
    let wrong_password_len = wrong_password_bytes.len();
    // Safety: pad_bytes is unconstrained but safe - it only copies bytes up to len
    let padded_bytes = unsafe { pad_bytes(wrong_password_bytes, wrong_password_len) };
    main(padded_bytes, wrong_password_len, correct_hash); // This should fail
}

#[test(should_fail)]
fn test_wrong_hash_should_fail() {
    // Test with correct password but wrong hash - should fail and verify circuit rejects it
    let correct_password = "MyPassword123";
    let correct_password_bytes = correct_password.as_bytes();
    let password_len = correct_password_bytes.len();
    // Safety: pad_bytes is unconstrained but safe - it only copies bytes up to len
    let padded_bytes = unsafe { pad_bytes(correct_password_bytes, password_len) };
    let wrong_hash = [0u8; 32];
    main(padded_bytes, password_len, wrong_hash); // This should fail
}

#[test(should_fail)]
fn test_partially_correct_password_should_fail() {
    // Test with password that's almost correct - should fail and verify circuit rejects it
    let correct_password = "MyPassword123";
    let correct_password_bytes = correct_password.as_bytes();
    let correct_hash = keccak256(correct_password_bytes, correct_password_bytes.len());
    let almost_correct = "MyPassword124"; // One character different
    let almost_correct_bytes = almost_correct.as_bytes();
    let almost_correct_len = almost_correct_bytes.len();
    // Safety: pad_bytes is unconstrained but safe - it only copies bytes up to len
    let padded_bytes = unsafe { pad_bytes(almost_correct_bytes, almost_correct_len) };
    main(padded_bytes, almost_correct_len, correct_hash); // This should fail
}
