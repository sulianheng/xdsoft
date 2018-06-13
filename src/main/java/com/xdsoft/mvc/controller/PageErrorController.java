package com.xdsoft.mvc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xdsoft.web.framework.annotation.PublicPage;

@Controller
@RequestMapping(value = "/pageError")
public class PageErrorController {
	@PublicPage
	@RequestMapping(value = "/unknown")
	public String unknown(HttpServletRequest request,
			HttpServletResponse response) {

		return "/pageError/error";
	}

	@PublicPage
	@RequestMapping(value = "/notFound")
	public String notFound(HttpServletRequest request,
			HttpServletResponse response) {

		return "/pageError/404";
	}

	@PublicPage
	@RequestMapping(value = { "/serverError", "/exception", "/throwable" })
	public String requestError(HttpServletRequest request,
			HttpServletResponse response) {

		return "/pageError/500";
	}

}
