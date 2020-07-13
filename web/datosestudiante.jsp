<%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Estudiante</title>
        <%!
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_idestudiante;
            
            String s_nombre;
            String s_apellidos;
            String s_dni;
            String s_codigo;
            String s_estado;
            
        %>
    </head>
    <body>
        <form name="AgregarEstudianteForm" action="datosestudiante.jsp" method="GET">
            
            <table border="0" align = "center">
                <thead>
                    <tr>
                        <th colspan="2">Agregar Estudiantes</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Nombre</td>
                        <td><input type="text" name="f_nombre" value="" /></td>
                    </tr>
                    <tr>
                        <td>Apellido</td>
                        <td><input type="text" name="f_apellidos" value="" /></td>
                    </tr>
                    <tr>
                        <td>DNI</td>
                        <td><input type="text" name="f_dni" value="" /></td>
                    </tr>
                    <tr>
                        <td>Codigo</td>
                        <td><input type="text" name="f_codigo" value="" /></td>
                    </tr>
                    <tr>
                        <td>Estado</td>
                        <td><input type="text" name="f_estado" value="" /></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" value="Agregar" name="f_agregar" />
                            <input type="hidden" name="f_accion" value="C" />
                        </td>
                        
                    </tr>
                </tbody>
            </table>

        
        </form>
        
        
        <table border="1" cellspacing="0" cellpadding="" align = "center">
            <thead>
                <tr>
                    <th colspan="8">
                        Datos Estudiante
                    </th>
                </tr>
                <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>DNI</th>
                    <th>Código</th>
                    <th>Estado</th>
                    <th>Eliminar</th>
                    <th>Modificar</th>
                </tr>
            </thead>

        <%
            try{
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                
                s_accion = request.getParameter("f_accion");
                s_idestudiante = request.getParameter("f_idestudiante");
                
                if(s_accion !=null)
                    if(s_accion.equals("E")){
                        consulta = "delete from estudiante "
                                + "where idestudiante="+s_idestudiante;
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    }else if(s_accion.equals("C")){
                        
                        s_nombre= request.getParameter("f_nombre");
                        s_apellidos= request.getParameter("f_apellidos");
                        s_dni= request.getParameter("f_dni");
                        s_codigo= request.getParameter("f_codigo");
                        s_estado= request.getParameter("f_estado");
                        
                        consulta = "insert into estudiante (nombre,apellidos,dni,codigo,estado)"
                                + "values('"+s_nombre+"','"+s_apellidos+"','"+s_dni+"','"+s_codigo+"','"+s_estado+"') ";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        pst.executeUpdate();
                    }
                
                consulta= " Select idestudiante, nombre, apellidos, dni, codigo, estado "
                        + " from estudiante ";
                //out.print(consulta);
                pst = cn.prepareStatement(consulta);
                rs = pst.executeQuery();
                int num = 0;
                String ide;
                
                while (rs.next()) {   
                    ide = rs.getString(1);
                    num++;
                    %>
                    <tr>
                        <td><%out.print(num);%></td>
                        <td><%out.print(rs.getString(2));%></td>
                        <td><%out.print(rs.getString(3));%></td>
                        <td><%out.print(rs.getString(4));%></td>
                        <td><%out.print(rs.getString(5));%></td>
                        <td><%out.print(rs.getString(6));%></td>
                        <td><a href="datosestudiante.jsp?f_accion=E&f_idestudiante=<%out.print(ide);%>">Eliminar</a></td>
                        <td>Modificar</td>
                    </tr>                    
                    <%
                    }
            }catch(Exception e){
                out.print("Error SQL");
            }
        
        %>
        </table>
    </body>
</html>
