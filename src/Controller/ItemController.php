<?php

namespace App\Controller;

use App\Model\ItemManager;

class ItemController extends AbstractController
{
    /**
     * List items
     */
    public function index(): string
    {
        $itemManager = new ItemManager();
        $items = $itemManager->selectAll();
        return $this->twig->render('Item/index.html.twig', ['items' => $items]);
    }

    /**
     * Show informations for a specific item
     */
    public function show(int $id): string
    {
        $itemManager = new ItemManager();
        $item = $itemManager->selectOneById($id);

        return $this->twig->render('Item/show.html.twig', ['item' => $item]);
    }

    /**
     * Edit a specific item
     */
    public function edit(int $id): ?string
    {
        $itemManager = new ItemManager();
        $item = $itemManager->selectOneById($id);

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            // clean $_POST data
            $item = array_map('trim', $_POST);

            // TODO validations (length, format...)

            // if validation is ok, update and redirection
            $itemManager->update($item);

            header('Location: /items');

            // we are redirecting so we don't want any content rendered
            return null;
        }

        return $this->twig->render('Item/edit.html.twig', [
            'item' => $item,
        ]);
    }

    /**
     * Add a new item
     */
    public function add(): ?string
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {

            // transforming request input into JSON
            // note: adding `true` as a 2nd param to the `json_decode` function allows us to get an associative array
            $itemJSON = json_decode(file_get_contents('php://input'), true);

            // TODO failure behavior case JSON was not parsed correctly

            // this time, we dont clean $_POST but our JSON's data
            // $item = array_map('trim', $_POST);
            $item = array_map('trim', $itemJSON);

            // TODO validations (length, format...)

            // if validation is ok, insert and redirection
            $itemManager = new ItemManager();
            $id = $itemManager->insert($item);

            // header('Location:/items/show?id=' . $id);
            // return null;
            // we dont redirect and we dont return null but we return a stringified item instead
            return json_encode($itemManager->selectOneById($id));
        }

        return $this->twig->render('Item/add.html.twig');
    }

    /**
     * Delete a specific item
     */
    public function delete(): void
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = trim($_POST['id']);
            $itemManager = new ItemManager();
            $itemManager->delete((int)$id);

            header('Location:/items');
        }
    }
}
