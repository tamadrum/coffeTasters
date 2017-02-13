package org.apache.jsp.WEB_002dINF.jsp.index;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!DOCTYPE html5>\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<title>Caffe Tasters</title>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("  window.fbAsyncInit = function() {\n");
      out.write("    FB.init({\n");
      out.write("      appId      : '123663028120164',\n");
      out.write("      xfbml      : true,\n");
      out.write("      version    : 'v2.8'\n");
      out.write("    });\n");
      out.write("  };\n");
      out.write("\n");
      out.write("  (function(d, s, id){\n");
      out.write("     var js, fjs = d.getElementsByTagName(s)[0];\n");
      out.write("     if (d.getElementById(id)) {return;}\n");
      out.write("     js = d.createElement(s); js.id = id;\n");
      out.write("     js.src = \"//connect.facebook.net/en_US/sdk.js\";\n");
      out.write("     fjs.parentNode.insertBefore(js, fjs);\n");
      out.write("   }(document, 'script', 'facebook-jssdk'));\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("<h1>Caffe Tasters</h1>\n");
      out.write("<br/>\n");
      out.write("Quantidade cadastrada: ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${quantidade}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\n");
      out.write("<br/><br/>\n");
      out.write("<div\n");
      out.write("  class=\"fb-like\"\n");
      out.write("  data-share=\"true\"\n");
      out.write("  data-width=\"450\"\n");
      out.write("  data-show-faces=\"true\">\n");
      out.write("</div>\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else log(t.getMessage(), t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
