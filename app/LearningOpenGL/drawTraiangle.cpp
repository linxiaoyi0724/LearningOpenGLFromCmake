////
////  drawTraiangle.cpp
////  DemoForDrawTriangle_20210424
////
////  Created by linxiaoyi on 2021/4/25.
////
//
//#include <stdio.h>
//#include <iostream>
//
//#include <glad/glad.h>
//#include <GLFW/glfw3.h>
//
//const char *vertexShaderSource = "#version 330 core\n"
//    "layout (location = 0) in vec3 aPos;\n"
//    "void main()\n"
//    "{\n"
//    "   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0f);\n"
//    "}\0";
//
//const char *fragmentShaderSource = "#version 330 core\n"
//    "out vec4 FragColor;\n"
//    "void main()\n"
//    "{\n"
//    "   FragColor = vec4(1.0f,0.5f,0.2f,1.0f);\n"
//    "}\0";
//    
//void framebufferSizeCallback(GLFWwindow *window, int width, int height);
//
//void processInput(GLFWwindow* window);
//
//int main(){
//    glfwInit();
//    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
//    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
//    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
//    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
//    
//    GLFWwindow *window = glfwCreateWindow(800, 600, "LearningOpenGL", NULL, NULL);
//    if(window == NULL){
//        std::cout << "failed to create window" << std::endl;
//        glfwTerminate();
//        return -1;
//    }
//    
//    glfwMakeContextCurrent(window);
//    
//    if(!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)){
//        std::cout << "Failed to initilize glad" << std::endl;
//        return -1;
//    }
//    
//    
//    glfwSetFramebufferSizeCallback(window, framebufferSizeCallback);
//
//    
//    float vertice[] = {
//         0.5f,  0.5f, 0.0f,
//         0.5f, -0.5f, 0.0f,
//        -0.5f, -0.5f, 0.0f,
//        -0.5f,  0.5f, 0.0f
//    };
//    
//    unsigned int indices[] = {
//        0,1,3,
//        1,2,3
//    };
//    
//
//    unsigned int VBO;
//    unsigned int VAO;
//    unsigned int IBO;
//    glGenBuffers(1, &VBO);
//    glGenBuffers(1, &IBO);
//    glGenVertexArrays(1, &VAO);
//    glBindVertexArray(VAO);
//    glBindBuffer(GL_ARRAY_BUFFER, VBO);
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, IBO);
//    glBufferData(GL_ARRAY_BUFFER,sizeof(vertice),vertice,GL_STATIC_DRAW);
//    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices),indices,GL_STATIC_DRAW);
//
//    unsigned int vertexShader = glCreateShader(GL_VERTEX_SHADER);
//    glShaderSource(vertexShader,1, &vertexShaderSource, NULL);
//    glCompileShader(vertexShader);
//
//    int success;
//    char infoLog[512];
//    glGetShaderiv(vertexShader,GL_COMPILE_STATUS,&success);
//    if(!success){
//        glGetShaderInfoLog(vertexShader,512,NULL,infoLog);
//        std::cout << "ERROR:SHADER::VERTEX::COMPILATION_FAILD\n" << infoLog << std::endl;
//    }
//
//    unsigned int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
//    glShaderSource(fragmentShader,1,&fragmentShaderSource, NULL);
//    glCompileShader(fragmentShader);
//
//    int successFragment;
//    char infoLogFragment[512];
//    glGetShaderiv(fragmentShader,GL_COMPILE_STATUS, &successFragment);
//    if(!successFragment){
//        glGetShaderInfoLog(fragmentShader,512,NULL,infoLogFragment);
//        std::cout << "ERROR::SHADER::FRAGMENT::COMPILATION_FAILD\n" << infoLogFragment<<std::endl;
//    }
//
//    unsigned int shaderProgram = glCreateProgram();
//    glAttachShader(shaderProgram,vertexShader);
//    glAttachShader(shaderProgram,fragmentShader);
//    glLinkProgram(shaderProgram);
//
//    int successProgram;
//    char infoLogProgram[512];
//    glGetProgramiv(shaderProgram,GL_LINK_STATUS, &successProgram);
//    if(!successProgram){
//        glGetProgramInfoLog(shaderProgram,512,NULL, infoLogProgram);
//        std::cout << "ERROR::PROGRAM::FRAGMENT::LINK_FAILD\n" << infoLogProgram << std::endl;
//    }
//
//    glVertexAttribPointer(0,3,GL_FLOAT,GL_FALSE,3 * sizeof(float),(void *)0);
//    glEnableVertexAttribArray(0);
//    glBindBuffer(GL_ARRAY_BUFFER,0);
//    glBindVertexArray(0);
//    
//    while (!glfwWindowShouldClose(window)) {
//        processInput(window);
//        glClearColor(0.2f,0.3f,0.3f,1.0f);
//        glClear(GL_COLOR_BUFFER_BIT);
//        
//        glUseProgram(shaderProgram);
//        glBindVertexArray(VAO);
//        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER,IBO);
//        glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
//        glDrawElements(GL_TRIANGLES,6,GL_UNSIGNED_INT,0);
////        glDrawArrays(GL_TRIANGLES,0,3);
//        
//        glfwSwapBuffers(window);
//        glfwPollEvents();
//    }
//    
//    
//    glDeleteVertexArrays(1,&VAO);
//    glDeleteShader(vertexShader);
//    glDeleteShader(fragmentShader);
//
//    glfwTerminate();
//    return 0;
//    
//    
//}
//
//void framebufferSizeCallback(GLFWwindow *window, int width, int height){
//    glViewport(0,0,width,height);
//}
//
//void processInput(GLFWwindow* window)
//{
//    if(glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
//    {
//        glfwSetWindowShouldClose(window, true);
//    }
//}
