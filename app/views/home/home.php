<div class="row principal-container pt-5">
    <div class="col-12" id="container-content">

        <?php if (!$client->getActive()) : ?>
        <?php $this->loadView("home/", "welcome"); ?>
        <?php endif; ?>

        <?php if ($client->getActive()) : ?>
            <h1>Nenhum emprestimo encontrado</h1>
        <?php endif; ?>
    </div>
</div>