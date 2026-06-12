#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <sstream>
using namespace std;

/*
 * String utility functions.
 * Demonstrates: strings, preprocessor, operators, comments.
 */

#define MAX_WORD_LEN 100
#define VERSION "1.0.0"

// Reverse a string in place
string reverse_str(string s) {
    int left  = 0;
    int right = static_cast<int>(s.size()) - 1;
    while (left < right) {
        swap(s[left++], s[right--]);
    }
    return s;
}

// Check if a string is a palindrome
bool is_palindrome(const string& s) {
    string clean;
    for (char c : s)
        if (isalnum(c)) clean += tolower(c);
    return clean == reverse_str(clean);
}

// Split a string by delimiter
vector<string> split(const string& s, char delim) {
    vector<string> tokens;
    string token;
    istringstream stream(s);
    while (getline(stream, token, delim))
        if (!token.empty()) tokens.push_back(token);
    return tokens;
}

// Count word frequency
int count_occurrences(const string& text, const string& word) {
    int count = 0;
    size_t pos = 0;
    while ((pos = text.find(word, pos)) != string::npos) {
        count++;
        pos += word.size();
    }
    return count;
}

// Trim leading and trailing whitespace
string trim(const string& s) {
    int start = 0;
    int end   = static_cast<int>(s.size()) - 1;
    while (start <= end && isspace(s[start])) start++;
    while (end >= start && isspace(s[end]))   end--;
    return s.substr(start, end - start + 1);
}

int main() {
    string sentence = "  Hello, World!  This is a test.  ";
    cout << "Original  : \"" << sentence << "\"" << endl;
    cout << "Trimmed   : \"" << trim(sentence) << "\"" << endl;
    cout << "Reversed  : \"" << reverse_str(trim(sentence)) << "\"" << endl;

    string palindrome_test = "A man a plan a canal Panama";
    cout << "\n\"" << palindrome_test << "\" is"
         << (is_palindrome(palindrome_test) ? "" : " NOT")
         << " a palindrome." << endl;

    string csv = "apple,banana,cherry,date,elderberry";
    vector<string> fruits = split(csv, ',');
    cout << "\nFruits:" << endl;
    for (const string& f : fruits)
        cout << "  - " << f << endl;

    cout << "\nVersion: " << VERSION << endl;
    return 0;
}
