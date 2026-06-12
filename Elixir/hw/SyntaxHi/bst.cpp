#include <iostream>
using namespace std;

struct TreeNode {
    int value;
    TreeNode* left;
    TreeNode* right;

    TreeNode(int val) : value(val), left(nullptr), right(nullptr) {}
};

class BinarySearchTree {
private:
    TreeNode* root;

    TreeNode* insert(TreeNode* node, int val) {
        if (node == nullptr) return new TreeNode(val);
        if (val < node->value)
            node->left = insert(node->left, val);
        else if (val > node->value)
            node->right = insert(node->right, val);
        return node;
    }

    bool search(TreeNode* node, int val) const {
        if (node == nullptr) return false;
        if (val == node->value) return true;
        if (val < node->value) return search(node->left, val);
        return search(node->right, val);
    }

    // In-order traversal: left -> root -> right
    void inorder(TreeNode* node) const {
        if (node == nullptr) return;
        inorder(node->left);
        cout << node->value << " ";
        inorder(node->right);
    }

    void destroy(TreeNode* node) {
        if (node == nullptr) return;
        destroy(node->left);
        destroy(node->right);
        delete node;
    }

public:
    BinarySearchTree() : root(nullptr) {}

    void insert(int val)         { root = insert(root, val); }
    bool search(int val) const   { return search(root, val); }
    void inorder() const         { inorder(root); cout << endl; }

    ~BinarySearchTree()          { destroy(root); }
};

int main() {
    BinarySearchTree bst;
    int values[] = {5, 3, 7, 1, 4, 6, 8};

    for (int v : values) bst.insert(v);

    cout << "In-order: ";
    bst.inorder();

    cout << "Search 4: " << (bst.search(4) ? "found" : "not found") << endl;
    cout << "Search 9: " << (bst.search(9) ? "found" : "not found") << endl;

    return 0;
}
