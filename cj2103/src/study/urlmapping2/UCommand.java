package study.urlmapping2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface UCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
