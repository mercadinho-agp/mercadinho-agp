class ProdutoPdf < Prawn::Document
    def initialize(produtos)
        super(top_margin: 70)
        @produtos = produtos
        text "Listagem de produtos", size: 20, style: :bold
        table_items 
    end

    def table_items
        move_down 20

        lines = [['id','Nome','Descrição','Preço','Quantidade','Criado em']] +
            @produtos.map do |prod|
                [ 
                    prod.id, 
                    prod.nome, 
                    prod.descricao, 
                    prod.preco, 
                    prod.qnt, 
                    prod.created_at.to_s
                ]
            end
        
        table lines do
            row(0).font_style = :bold
            columns(3..5).align = :right
        end
    end


end