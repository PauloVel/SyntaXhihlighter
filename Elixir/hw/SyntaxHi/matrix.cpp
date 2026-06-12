#include <iostream>
#include <vector>
#include <stdexcept>
using namespace std;

class Matrix {
private:
    int rows;
    int cols;
    vector<vector<double>> data;

public:
    Matrix(int r, int c) : rows(r), cols(c), data(r, vector<double>(c, 0.0)) {}

    double& at(int r, int c)             { return data[r][c]; }
    double  at(int r, int c) const       { return data[r][c]; }

    // Matrix addition
    Matrix operator+(const Matrix& other) const {
        if (rows != other.rows || cols != other.cols)
            throw invalid_argument("Matrix dimensions must match for addition");

        Matrix result(rows, cols);
        for (int i = 0; i < rows; i++)
            for (int j = 0; j < cols; j++)
                result.at(i, j) = data[i][j] + other.data[i][j];
        return result;
    }

    // Matrix multiplication
    Matrix operator*(const Matrix& other) const {
        if (cols != other.rows)
            throw invalid_argument("Incompatible dimensions for multiplication");

        Matrix result(rows, other.cols);
        for (int i = 0; i < rows; i++)
            for (int j = 0; j < other.cols; j++)
                for (int k = 0; k < cols; k++)
                    result.at(i, j) += data[i][k] * other.data[k][j];
        return result;
    }

    // Transpose
    Matrix transpose() const {
        Matrix result(cols, rows);
        for (int i = 0; i < rows; i++)
            for (int j = 0; j < cols; j++)
                result.at(j, i) = data[i][j];
        return result;
    }

    void print() const {
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++)
                cout << data[i][j] << "\t";
            cout << endl;
        }
    }
};

int main() {
    Matrix A(2, 3);
    A.at(0, 0) = 1; A.at(0, 1) = 2; A.at(0, 2) = 3;
    A.at(1, 0) = 4; A.at(1, 1) = 5; A.at(1, 2) = 6;

    Matrix B(3, 2);
    B.at(0, 0) = 7;  B.at(0, 1) = 8;
    B.at(1, 0) = 9;  B.at(1, 1) = 10;
    B.at(2, 0) = 11; B.at(2, 1) = 12;

    cout << "A * B =" << endl;
    (A * B).print();

    cout << "\nTranspose of A:" << endl;
    A.transpose().print();

    return 0;
}
