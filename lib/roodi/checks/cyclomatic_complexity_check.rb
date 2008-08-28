require 'java'
require 'roodi/checks/check'
include_class 'org.jruby.ast.ForNode'

require 'roodi/jruby'

module Roodi
  module Checks
    # Checks cyclomatic complexity against a specified limit. The complexity is
    # measured by the number of "if", "unless", "elsif", "?:", "while", "until", 
    # "for", "rescue", "case", "when", "&amp;&amp;", "and", "||" and "or" statements (plus 
    # one) in the body of the member. It is a measure of the minimum number of 
    # possible paths through the source and therefore the number of required tests. 
    # Generally 1-4 is considered good, 5-7 ok, 8-10 consider re-factoring, and 
    # 11+ re-factor now!
    class CyclomaticComplexityCheck < Check
      def initialize(complexity = 8)
        super()
        @complexity = complexity
      end
      
      def interesting_nodes
        [DefnNode]
      end

      def evaluate(node)
        complexity = count_complexity(node) + 1
        add_error "#{position(node)} - Cyclomatic complexity is #{complexity}.  It should be #{@complexity} or less." unless complexity <= @complexity
      end
      
      def count_complexity(node)
        complexity_node_classes = [IfNode, WhileNode, UntilNode, ForNode, RescueNode, CaseNode, WhenNode, AndNode, OrNode]
        
        count = 0
        count = count + 1 if complexity_node_classes.include? node.class
        node.children.each {|node| count += count_complexity(node)}
        count
      end
    end
  end
end