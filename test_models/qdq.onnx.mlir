

module {
  func @main_graph(%arg0: tensor<1x1x4x4xf32>) -> tensor<1x1x1x1xf32> attributes {input_names = ["result.1"], output_names = ["34"]} {
    %0 = "onnx.Constant"() {onnx_node_name = "Constant_0", value = dense<0.00392156886> : tensor<1xf32>} : () -> tensor<1xf32>
    %1 = "onnx.Constant"() {onnx_node_name = "Constant_1", value = dense<0> : tensor<1xui8>} : () -> tensor<1xui8>
    %2 = "onnx.QuantizeLinear"(%arg0, %0, %1) {onnx_node_name = "QuantizeLinear_2"} : (tensor<1x1x4x4xf32>, tensor<1xf32>, tensor<1xui8>) -> tensor<1x1x4x4xi8>
    %3 = "onnx.DequantizeLinear"(%2, %0, %1) {onnx_node_name = "DequantizeLinear_3"} : (tensor<1x1x4x4xi8>, tensor<1xf32>, tensor<1xui8>) -> tensor<1x1x4x4xf32>
    %4 = "onnx.Constant"() {onnx_node_name = "Constant_4", value = dense<0.00392156886> : tensor<1xf32>} : () -> tensor<1xf32>
    %5 = "onnx.Constant"() {onnx_node_name = "Constant_5", value = dense<0> : tensor<1xui8>} : () -> tensor<1xui8>
    %6 = "onnx.Constant"() {value = dense<[[[[0.000000e+00, -1.000000e+00], [-1.000000e+00, 0.000000e+00]]], [[[0.000000e+00, -1.000000e+00], [-1.000000e+00, 0.000000e+00]]]]> : tensor<2x1x2x2xf32>} : () -> tensor<2x1x2x2xf32>
    %7 = "onnx.QuantizeLinear"(%6, %4, %5) {onnx_node_name = "QuantizeLinear_6"} : (tensor<2x1x2x2xf32>, tensor<1xf32>, tensor<1xui8>) -> tensor<2x1x2x2xi8>
    %8 = "onnx.DequantizeLinear"(%7, %4, %5) {onnx_node_name = "DequantizeLinear_7"} : (tensor<2x1x2x2xi8>, tensor<1xf32>, tensor<1xui8>) -> tensor<2x1x2x2xf32>
    %9 = "onnx.Constant"() {value = dense<-2.000000e+00> : tensor<2xf32>} : () -> tensor<2xf32>
    %10 = "onnx.Conv"(%3, %8, %9) {auto_pad = "NOTSET", dilations = [1, 1], group = 1 : si64, kernel_shape = [2, 2], onnx_node_name = "Conv_8", pads = [0, 0, 0, 0], strides = [1, 1]} : (tensor<1x1x4x4xf32>, tensor<2x1x2x2xf32>, tensor<2xf32>) -> tensor<1x2x3x3xf32>
    %11 = "onnx.Constant"() {onnx_node_name = "Constant_9", value = dense<0.00392156886> : tensor<1xf32>} : () -> tensor<1xf32>
    %12 = "onnx.Constant"() {onnx_node_name = "Constant_10", value = dense<0> : tensor<1xui8>} : () -> tensor<1xui8>
    %13 = "onnx.QuantizeLinear"(%10, %11, %12) {onnx_node_name = "QuantizeLinear_11"} : (tensor<1x2x3x3xf32>, tensor<1xf32>, tensor<1xui8>) -> tensor<1x2x3x3xi8>
    %14 = "onnx.DequantizeLinear"(%13, %11, %12) {onnx_node_name = "DequantizeLinear_12"} : (tensor<1x2x3x3xi8>, tensor<1xf32>, tensor<1xui8>) -> tensor<1x2x3x3xf32>
    %15 = "onnx.Constant"() {onnx_node_name = "Constant_13", value = dense<0.00392156886> : tensor<1xf32>} : () -> tensor<1xf32>
    %16 = "onnx.Constant"() {onnx_node_name = "Constant_14", value = dense<0> : tensor<1xui8>} : () -> tensor<1xui8>
    %17 = "onnx.Constant"() {value = dense<[[[[1.000000e+00, 0.000000e+00, 0.000000e+00], [0.000000e+00, 1.000000e+00, 0.000000e+00], [0.000000e+00, 0.000000e+00, 1.000000e+00]], [[1.000000e+00, 0.000000e+00, 0.000000e+00], [0.000000e+00, 1.000000e+00, 0.000000e+00], [0.000000e+00, 0.000000e+00, 1.000000e+00]]]]> : tensor<1x2x3x3xf32>} : () -> tensor<1x2x3x3xf32>
    %18 = "onnx.QuantizeLinear"(%17, %15, %16) {onnx_node_name = "QuantizeLinear_15"} : (tensor<1x2x3x3xf32>, tensor<1xf32>, tensor<1xui8>) -> tensor<1x2x3x3xi8>
    %19 = "onnx.DequantizeLinear"(%18, %15, %16) {onnx_node_name = "DequantizeLinear_16"} : (tensor<1x2x3x3xi8>, tensor<1xf32>, tensor<1xui8>) -> tensor<1x2x3x3xf32>
    %20 = "onnx.Constant"() {value = dense<0.000000e+00> : tensor<1xf32>} : () -> tensor<1xf32>
    %21 = "onnx.Conv"(%14, %19, %20) {auto_pad = "NOTSET", dilations = [1, 1], group = 1 : si64, kernel_shape = [3, 3], onnx_node_name = "Conv_17", pads = [0, 0, 0, 0], strides = [1, 1]} : (tensor<1x2x3x3xf32>, tensor<1x2x3x3xf32>, tensor<1xf32>) -> tensor<1x1x1x1xf32>
    return %21 : tensor<1x1x1x1xf32>
  }
  "onnx.EntryPoint"() {func = @main_graph, numInputs = 1 : i32, numOutputs = 1 : i32} : () -> ()
}