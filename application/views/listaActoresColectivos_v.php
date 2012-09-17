<div id="ListasActores" name="ListasActores"><!--Lista de Actores---->

	<ul class="button-group">
		<li><input type="button" class="small button" value="Agregar Actor" onclick="mostrarFormlularioCol()" /> </li>
		<li><input type="button" class="small button"  value="Eliminar Actor" onclick="esconderFormlulario()" /> </li>
    </ul>

    <form  method="post" accept-charset="utf-8" id="formEditarActor3">
			
        <input type="submit" class="small button" value="EditarActor" id="botonEditarActor" />
			<!--buscador de la lista de actores---->
			<div class="eight columns">
					<input id="actores_nombre" type="text"  name="actores_nombre" value="<?php echo set_value('actores_nombre'); ?>" placeholder="Nombre, Apellido" />
				</div>
				<div class="four columns">
					<input  type="button" class="small button" value="Buscar" title="Buscar" />
				</div><!--termina buscador de la lista de actores---->
			</form>	
			
			<?php echo br(2);?>	
			<div class="twelve columns">
				<b><div class="six columns">Foto</div>
				<div class="six columns">Nombre</div></b>
			<?php echo br(2);?>	
			</div>


<!------------Lista colectivo-------------------->
			
			<div id="listaActorColect" class="PruebaScorll">
                <?php if(isset($listaActores['colectivo']) != 'No hay actores en la base de datos '){ ?>
					<?php foreach($listaActores['colectivo'] as $index => $item):?> <!--muestra cada elemento de la lista-->
					
							<div id="elemento_<?=$item['actorId']; ?>" class="twelve columns borrar_select" onclick="mostarDatosListaElem(<?=$item['actorId']; ?>, 3)">
								<div class="five columns"><!--imprimo imagenes-->
									<?php echo img($item['actorId']);?>
									<?php echo br(2);?>	
								</div>
								
								<div class="seven columns"><!--Imprimo nombres-->
										<?=$item['nombre']?>
										<?php echo br(2);?>	
								</div>
							</div>
							
					<?php endforeach;?><!--Termina lista de los actores-->
                <?php } ?>
			</div>
					
   
			
		</div>
