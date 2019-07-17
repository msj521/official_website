package com.example.exception;
import org.springframework.boot.web.server.AbstractConfigurableWebServerFactory;
import org.springframework.boot.web.server.ErrorPage;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletResponse;

/**
 * 全局异常
 */
@ControllerAdvice //控制器切面
public class GlobalExceptionHandler{
    public AbstractConfigurableWebServerFactory container;
    //异常处理
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public void exceptionHandler(Exception ex, HttpServletResponse response){
        ErrorPage error401Page = new ErrorPage(HttpStatus.UNAUTHORIZED, "classpath:/static/error/401.ftl");
        ErrorPage error405Page = new ErrorPage(HttpStatus.METHOD_NOT_ALLOWED, "/error/405.ftl");
        ErrorPage error404Page = new ErrorPage(HttpStatus.NOT_FOUND, "classpath:/static/error/404.ftl");
        ErrorPage error500Page = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "classpath:/static/error/500.ftl");
        container.addErrorPages(error401Page,error405Page,error404Page, error500Page);
    }

}
