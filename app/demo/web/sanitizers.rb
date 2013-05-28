class Demo
  module Web

    module Sanitizers

      ID_TRAP = Ducktrap.build do
        extern do
          forward { |input| input.merge(:id => nil) }
          inverse { |input| input = input.dup; input.delete(:id); input }
        end
      end

      NEW_PERSON = Ducktrap.build do
        primitive(Hash)
        hash_transform do
          dump_key(:name) do
            fetch_key('name')
            primitive(String)
          end
        end
        add(ID_TRAP)
        anima_load(Models::Person)
      end

    end
  end
end
