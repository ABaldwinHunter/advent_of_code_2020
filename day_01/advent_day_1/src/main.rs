use std::fs;

fn main() {
    // --snip--
    println!("In file {}", "../input.txt");

    let contents = fs::read_to_string("../input.txt")
        .expect("Something went wrong reading the file");

    println!("With text:\n{}", contents);
}
