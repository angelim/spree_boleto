Deface::Override.new(:virtual_path => "spree/layouts/admin",
                    :name => "add_boletos_to_admin_tab",
                    :insert_bottom => "[data-hook='admin_tabs']",
                    :partial => "spree/admin/boleto_docs/tab",
                    :disabled => false)
