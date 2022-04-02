

// import 'dart:typed_data';

// import 'package:flutter/cupertino.dart';
// import 'package:vector_math/vector_math_64.dart';

// class SlideTransformPage implements Matrix4{
//   @override
//   Vector4 row0;

//   @override
//   Vector4 row1;

//   @override
//   Vector4 row2;

//   @override
//   Vector4 row3;

//   @override
//   operator *(arg) {
//     // TODO: implement *
//     throw UnimplementedError();
//   }

//   @override
//   Matrix4 operator +(Matrix4 arg) {
//     // TODO: implement +
//     throw UnimplementedError();
//   }

//   @override
//   Matrix4 operator -(Matrix4 arg) {
//     // TODO: implement -
//     throw UnimplementedError();
//   }

//   @override
//   Matrix4 operator -() {
//     // TODO: implement -
//     throw UnimplementedError();
//   }

//   @override
//   double operator [](int i) {
//     // TODO: implement []
//     throw UnimplementedError();
//   }

//   @override
//   void operator []=(int i, double v) {
//     // TODO: implement []=
//   }

//   @override
//   Matrix4 absolute() {
//     // TODO: implement absolute
//     throw UnimplementedError();
//   }

//   @override
//   double absoluteError(Matrix4 correct) {
//     // TODO: implement absoluteError
//     throw UnimplementedError();
//   }

//   @override
//   Vector3 absoluteRotate(Vector3 arg) {
//     // TODO: implement absoluteRotate
//     throw UnimplementedError();
//   }

//   @override
//   void add(Matrix4 o) {
//     // TODO: implement add
//   }

//   @override
//   List<double> applyToVector3Array(List<double> array, [int offset = 0]) {
//     // TODO: implement applyToVector3Array
//     throw UnimplementedError();
//   }

//   @override
//   Matrix4 clone() {
//     // TODO: implement clone
//     throw UnimplementedError();
//   }

//   @override
//   void copyFromArray(List<double> array, [int offset = 0]) {
//     // TODO: implement copyFromArray
//   }

//   @override
//   Matrix4 copyInto(Matrix4 arg) {
//     // TODO: implement copyInto
//     throw UnimplementedError();
//   }

//   @override
//   void copyIntoArray(List<num> array, [int offset = 0]) {
//     // TODO: implement copyIntoArray
//   }

//   @override
//   double copyInverse(Matrix4 arg) {
//     // TODO: implement copyInverse
//     throw UnimplementedError();
//   }

//   @override
//   void copyRotation(Matrix3 rotation) {
//     // TODO: implement copyRotation
//   }

//   @override
//   void decompose(Vector3 translation, Quaternion rotation, Vector3 scale) {
//     // TODO: implement decompose
//   }

//   @override
//   double determinant() {
//     // TODO: implement determinant
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement dimension
//   int get dimension => throw UnimplementedError();

//   @override
//   double dotColumn(int j, Vector4 v) {
//     // TODO: implement dotColumn
//     throw UnimplementedError();
//   }

//   @override
//   double dotRow(int i, Vector4 v) {
//     // TODO: implement dotRow
//     throw UnimplementedError();
//   }

//   @override
//   double entry(int row, int col) {
//     // TODO: implement entry
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement forward
//   Vector3 get forward => throw UnimplementedError();

//   @override
//   Vector4 getColumn(int column) {
//     // TODO: implement getColumn
//     throw UnimplementedError();
//   }

//   @override
//   double getMaxScaleOnAxis() {
//     // TODO: implement getMaxScaleOnAxis
//     throw UnimplementedError();
//   }

//   @override
//   Matrix3 getNormalMatrix() {
//     // TODO: implement getNormalMatrix
//     throw UnimplementedError();
//   }

//   @override
//   Matrix3 getRotation() {
//     // TODO: implement getRotation
//     throw UnimplementedError();
//   }

//   @override
//   Vector4 getRow(int row) {
//     // TODO: implement getRow
//     throw UnimplementedError();
//   }

//   @override
//   Vector3 getTranslation() {
//     // TODO: implement getTranslation
//     throw UnimplementedError();
//   }

//   @override
//   int index(int row, int col) {
//     // TODO: implement index
//     throw UnimplementedError();
//   }

//   @override
//   double infinityNorm() {
//     // TODO: implement infinityNorm
//     throw UnimplementedError();
//   }

//   @override
//   double invert() {
//     // TODO: implement invert
//     throw UnimplementedError();
//   }

//   @override
//   double invertRotation() {
//     // TODO: implement invertRotation
//     throw UnimplementedError();
//   }

//   @override
//   bool isIdentity() {
//     // TODO: implement isIdentity
//     throw UnimplementedError();
//   }

//   @override
//   bool isZero() {
//     // TODO: implement isZero
//     throw UnimplementedError();
//   }

//   @override
//   void leftTranslate(x, [double y = 0.0, double z = 0.0]) {
//     // TODO: implement leftTranslate
//   }

//   @override
//   Matrix4 multiplied(Matrix4 arg) {
//     // TODO: implement multiplied
//     throw UnimplementedError();
//   }

//   @override
//   void multiply(Matrix4 arg) {
//     // TODO: implement multiply
//   }

//   @override
//   void multiplyTranspose(Matrix4 arg) {
//     // TODO: implement multiplyTranspose
//   }

//   @override
//   void negate() {
//     // TODO: implement negate
//   }

//   @override
//   Vector3 perspectiveTransform(Vector3 arg) {
//     // TODO: implement perspectiveTransform
//     throw UnimplementedError();
//   }

//   @override
//   double relativeError(Matrix4 correct) {
//     // TODO: implement relativeError
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement right
//   Vector3 get right => throw UnimplementedError();

//   @override
//   void rotate(Vector3 axis, double angle) {
//     // TODO: implement rotate
//   }

//   @override
//   Vector3 rotate3(Vector3 arg) {
//     // TODO: implement rotate3
//     throw UnimplementedError();
//   }

//   @override
//   void rotateX(double angle) {
//     // TODO: implement rotateX
//   }

//   @override
//   void rotateY(double angle) {
//     // TODO: implement rotateY
//   }

//   @override
//   void rotateZ(double angle) {
//     // TODO: implement rotateZ
//   }

//   @override
//   Vector3 rotated3(Vector3 arg, [Vector3 out]) {
//     // TODO: implement rotated3
//     throw UnimplementedError();
//   }

//   @override
//   void scale(x, [double y, double z]) {
//     // TODO: implement scale
//   }

//   @override
//   void scaleAdjoint(double scale) {
//     // TODO: implement scaleAdjoint
//   }

//   @override
//   Matrix4 scaled(x, [double y, double z]) {
//     // TODO: implement scaled
//     throw UnimplementedError();
//   }

//   @override
//   void setColumn(int column, Vector4 arg) {
//     // TODO: implement setColumn
//   }

//   @override
//   void setColumns(Vector4 arg0, Vector4 arg1, Vector4 arg2, Vector4 arg3) {
//     // TODO: implement setColumns
//   }

//   @override
//   void setDiagonal(Vector4 arg) {
//     // TODO: implement setDiagonal
//   }

//   @override
//   void setEntry(int row, int col, double v) {
//     // TODO: implement setEntry
//   }

//   @override
//   void setFrom(Matrix4 arg) {
//     // TODO: implement setFrom
//   }

//   @override
//   void setFromTranslationRotation(Vector3 arg0, Quaternion arg1) {
//     // TODO: implement setFromTranslationRotation
//   }

//   @override
//   void setFromTranslationRotationScale(Vector3 translation, Quaternion rotation, Vector3 scale) {
//     // TODO: implement setFromTranslationRotationScale
//   }

//   @override
//   void setIdentity() {
//     // TODO: implement setIdentity
//   }

//   @override
//   void setOuter(Vector4 u, Vector4 v) {
//     // TODO: implement setOuter
//   }

//   @override
//   void setRotation(Matrix3 r) {
//     // TODO: implement setRotation
//   }

//   @override
//   void setRotationX(double radians) {
//     // TODO: implement setRotationX
//   }

//   @override
//   void setRotationY(double radians) {
//     // TODO: implement setRotationY
//   }

//   @override
//   void setRotationZ(double radians) {
//     // TODO: implement setRotationZ
//   }

//   @override
//   void setRow(int row, Vector4 arg) {
//     // TODO: implement setRow
//   }

//   @override
//   void setTranslation(Vector3 t) {
//     // TODO: implement setTranslation
//   }

//   @override
//   void setTranslationRaw(double x, double y, double z) {
//     // TODO: implement setTranslationRaw
//   }

//   @override
//   void setUpper2x2(Matrix2 arg) {
//     // TODO: implement setUpper2x2
//   }

//   @override
//   void setValues(double arg0, double arg1, double arg2, double arg3, double arg4, double arg5, double arg6, double arg7, double arg8, double arg9, double arg10, double arg11, double arg12, double arg13, double arg14, double arg15) {
//     // TODO: implement setValues
//   }

//   @override
//   void setZero() {
//     // TODO: implement setZero
//   }

//   @override
//   void splatDiagonal(double arg) {
//     // TODO: implement splatDiagonal
//   }

//   @override
//   // TODO: implement storage
//   Float64List get storage => throw UnimplementedError();

//   @override
//   void sub(Matrix4 o) {
//     // TODO: implement sub
//   }

//   @override
//   double trace() {
//     // TODO: implement trace
//     throw UnimplementedError();
//   }

//   @override
//   Vector4 transform(Vector4 arg) {
//     // TODO: implement transform
//     throw UnimplementedError();
//   }

//   @override
//   Vector3 transform3(Vector3 arg) {
//     // TODO: implement transform3
//     throw UnimplementedError();
//   }

//   @override
//   Vector4 transformed(Vector4 arg, [Vector4 out]) {
//     // TODO: implement transformed
//     throw UnimplementedError();
//   }

//   @override
//   Vector3 transformed3(Vector3 arg, [Vector3 out]) {
//     // TODO: implement transformed3
//     throw UnimplementedError();
//   }

//   @override
//   void translate(x, [double y = 0.0, double z = 0.0]) {
//     // TODO: implement translate
//   }

//   @override
//   void transpose() {
//     // TODO: implement transpose
//   }

//   @override
//   void transposeMultiply(Matrix4 arg) {
//     // TODO: implement transposeMultiply
//   }

//   @override
//   void transposeRotation() {
//     // TODO: implement transposeRotation
//   }

//   @override
//   Matrix4 transposed() {
//     // TODO: implement transposed
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement up
//   Vector3 get up => throw UnimplementedError();
  
// }