RSpec.describe 'Icebreakers Homepage' do
  it 'begins with a valid doctype' do
    expect(parsed_html.children.first).to be_html5_dtd
  end

  it 'has a top-level <html> tag to enclose the document' do
    expect(parsed_html.child.name).to eq('html')

    expect(html_file_contents).to include('</html>')
  end

  context 'within <html>' do
    it 'contains a <head> tag to enclose the header' do
      head_tag = parsed_html.search('html > head').first

      expect(head_tag.name).to eq('head')

      expect(html_file_contents).to include('</head>')
    end

    context 'within <head>' do
      it 'contains a <title> tag to enclose the site title' do
        title_tag = parsed_html.search('html > head > title').first

        expect(title_tag.name).to eq('title')

        expect(html_file_contents).to include('</title>')
      end
    end
  end

  context 'within <html>' do
    it 'contains a <body> tag to enclose the body of the document' do
      body_tag = parsed_html.search('html > body').first

      expect(body_tag.name).to eq('body')

      expect(html_file_contents).to include('</body>')
    end

    context 'within <body>' do
      it 'contains a <header> tag to enclose the site header' do
        header_tag = parsed_html.search('html > body > header').first

        expect(header_tag.name).to eq('header')

        expect(html_file_contents).to include('</header>')
      end

      context 'within <header>' do
        it 'contains a <nav> tag to enclose the site navigation' do
          nav_tag = parsed_html.search('html > body > header > nav').first

          expect(nav_tag.name).to eq('nav')

          expect(html_file_contents).to include('</nav>')
        end

        context 'within <nav>' do
          it 'contains a <ul> tag to enclose the site navigation' do
            ul_tag = parsed_html.search('html > body > header > nav > ul').first

            expect(ul_tag.name).to eq('ul')

            expect(html_file_contents).to include('</ul>')
          end

          context 'within <ul>' do
            it 'contains a pair of <li> tags for linking to other pages' do
              li_tags = parsed_html.search('html > body > header > nav > ul > li')

              expect(li_tags.length).to eq(2)

              expect(html_file_contents).to include('</li>')
            end

            context 'within the <li> tags' do
              it 'each contains an <a> tag to link to another page' do
                a_tags = parsed_html.search('html > body > header > nav > ul > li > a')

                expect(a_tags.length).to eq(2)

                expect(html_file_contents).to include('</a>')
              end
            end
          end
        end
      end

      context 'within <header>' do
        it "contains an <h3> tag to enclose the site's title" do
          h3_tag = parsed_html.search('html > body > header > h3').first

          expect(h3_tag.name).to eq('h3')

          expect(html_file_contents).to include('</h3>')
        end

        context 'within <h3>' do
          it "contains an <a> tag to link back to the site's homepage" do
            a_tag = parsed_html.search('html > body > header > h3 > a').first

            expect(a_tag.name).to eq('a')

            expect(html_file_contents).to include('</a>')
          end
        end
      end
    end

    context 'within <body>' do
      it "contains a <main> tag to enclose the site's primary content" do
        main_tag = parsed_html.search('html > body > main').first

        expect(main_tag.name).to eq('main')

        expect(html_file_contents).to include('</main>')
      end

      context 'within <main>' do
        it "contains a pair of <div> tags to enclose the site's two main sections of content" do
          div_tags = parsed_html.search('html > body > main > div')

          expect(div_tags.length).to eq(2)

          expect(html_file_contents).to include('</div>')
        end

        context 'within the first <div>' do
          it 'contains an <h1> tag to enclose the main heading' do
            h1_tag = parsed_html.search('html > body > main > div > h1').first

            expect(h1_tag.name).to eq('h1')

            expect(html_file_contents).to include('</h1>')
          end

          it "contains a <p> tag to enclose the main site description" do
            p_tag = parsed_html.search('html > body > main > div > h1 + p').first

            expect(p_tag.name).to eq('p')

            expect(html_file_contents).to include('</p>')
          end
        end

        context 'within the second <div>' do
          it 'contains a pair of <h4> tags to enclose the ' do
            h4_tags = parsed_html.search('html > body > main > div > h4')

            expect(h4_tags.length).to eq(2)

            expect(html_file_contents).to include('</h4>')
          end

          it 'contains a pair of <p> tags to enclose the ' do
            p_tags = parsed_html.search('html > body > main > div > h4 + p')

            expect(p_tags.length).to eq(2)

            expect(html_file_contents).to include('</p>')
          end

          context 'within the <p> tags' do
            it 'each contains an <a> tag to create a new icebreaker' do
              a_tags = parsed_html.search('html > body > main > div > p > a')

              expect(a_tags.length).to eq(2)

              expect(html_file_contents).to include('</a>')
            end

            it "each <a> tag has an 'href' attribute of '#'" do
              a_tags = parsed_html.search('html > body > main > div > p > a[href="#"]')

              expect(a_tags.length).to eq(2)
            end
          end
        end
      end
    end

    context 'within <body>' do
      it "contains a <footer> tag to enclose the site's copyright details" do
        footer_tag = parsed_html.search('html > body > footer').first

        expect(footer_tag.name).to eq('footer')

        expect(html_file_contents).to include('</footer>')
      end

      context 'within <footer>' do
        it "contains a <p> tag enclosing the site's copyright information" do
          p_tag = parsed_html.search('html > body > footer > p').first

          expect(p_tag.name).to eq('p')

          expect(html_file_contents).to include('</p>')
        end
      end
    end
  end

  context 'w3c validation' do
    it 'is a valid w3c document' do
      validator = W3CValidators::NuValidator.new
      html = File.read('./index.html')
      results = validator.validate_text(html)

      error_messages = "Expected a valid w3c document but got:\n#{results.errors.collect{|e| e.to_s}.join("\n")}"

      expect(results.errors).to be_empty, error_messages
    end
  end
end
