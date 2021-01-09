#include<GL/glew.h>
#include<GL/freeglut.h>
#include<iostream>

using namespace std;

// 改变窗口大小
void changeViewport(int w, int h)
{
    glViewport(0, 0, w, h);
}

// 渲染一个三角形
void render()
{
    glClear(GL_COLOR_BUFFER_BIT);
    // 线形
    glBegin(GL_TRIANGLE_STRIP);
    {
        glVertex2f(-0.8,-0.8);
        glVertex2f(0.8,-0.8);
        glVertex2f(0,0.8);
    }
    glEnd();
    glutSwapBuffers();
}

int main(int argc,char** argv)
{
    // 初始化
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH);
    glutInitWindowSize(800, 600);
    glutCreateWindow("HelloWord");
    glutReshapeFunc(changeViewport);
    glutDisplayFunc(render);
    // 测试glew
    GLenum error = glewInit();
    if (error!=GLEW_OK)
    {
        printf("GLEW CREATE ERROR");
        return -1;
    }
    glutMainLoop();
    return 0;
}