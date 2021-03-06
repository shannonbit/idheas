<!---Encabezado de la página---->
<div class="twelve columns">
    <div class="panel" >
        <div div="logo" >
            <?php echo img('statics/media/img/system/logo.png');?>
        </div>
    </div>
</div>
<!---Termina el encabezado de la página-->

<!--Contenido de la página-->
<div class="two columns">				
    <dl class="nice vertical tabs">
        <dd class="<?=($is_active == 'actores') ? 'active' : '' ; ?>"><a href="<?=base_url(); ?>index.php/actores_c/mostrar_actor">Actores</a></dd>
        <dd class="<?=($is_active == 'casos') ? 'active' : '' ; ?>"><a href="<?=base_url(); ?>index.php/casos_c/mostrar_caso">Casos</a></dd>
        <dd class="<?=($is_active == 'reported') ? 'active' : '' ; ?>"><a href="<?=base_url(); ?>">Reportes</a></dd>
    </dl>
</div>
<div class="ten columns">
    <?=(isset($content)) ? $content : '' ; ?>
</div>
<!--Termina el contenido de la página-->
