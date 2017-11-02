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
      head = parsed_html.search('html > head').first

      expect(head.name).to eq('head')

      expect(html_file_contents).to include('</head>')
    end

    context 'within <head>' do
      it 'contains a <title> tag to enclose the site title' do
        title = parsed_html.search('html > head > title').first

        expect(title.name).to eq('title')

        expect(html_file_contents).to include('</title>')
      end
    end
  end

  context 'within <html>' do
    it 'contains a <body> tag to enclose the body of the document' do
      body = parsed_html.search('html > body').first

      expect(body.name).to eq('body')

      expect(html_file_contents).to include('</body>')
    end

    context 'within <body>' do
      it 'contains a <header> tag to enclose the site header' do
        header = parsed_html.search('html > body > header').first

        expect(header.name).to eq('header')

        expect(html_file_contents).to include('</header>')
      end

      context 'within <header>' do
        it 'contains a <nav> tag to enclose the site navigation' do
          nav = parsed_html.search('html > body > header > nav').first

          expect(nav.name).to eq('nav')

          expect(html_file_contents).to include('</nav>')
        end

        context 'within <nav>' do
          it 'contains a <ul> tag to enclose the site navigation' do
            ul = parsed_html.search('html > body > header > nav > ul').first

            expect(ul.name).to eq('ul')

            expect(html_file_contents).to include('</ul>')
          end

          context 'within <ul>' do
            it 'contains a pair of <li> tags for linking to other pages' do
              lis = parsed_html.search('html > body > header > nav > ul > li')

              expect(lis.length).to eq(2)

              expect(html_file_contents).to include('</li>')
            end

            context 'within the <li> tags' do
              it 'each contains an <a> tag to link to another page' do
                as = parsed_html.search('html > body > header > nav > ul > li > a')

                expect(as.length).to eq(2)

                expect(html_file_contents).to include('</a>')
              end
            end
          end
        end
      end

      context 'within <header>' do
        it "contains an <h3> tag to enclose the site's title" do
          h3 = parsed_html.search('html > body > header > h3').first

          expect(h3.name).to eq('h3')

          expect(html_file_contents).to include('</h3>')
        end

        context 'within <h3>' do
          it "contains an <a> tag to link back to the site's homepage" do
            a = parsed_html.search('html > body > header > h3 > a').first

            expect(a.name).to eq('a')

            expect(html_file_contents).to include('</a>')
          end
        end
      end
    end

    context 'within <body>' do
      it "contains a <main> tag to enclose the site's primary content" do
        main = parsed_html.search('html > body > main').first

        expect(main.name).to eq('main')

        expect(html_file_contents).to include('</main>')
      end

      context 'within <main>' do
        it "contains a pair of <div> tags to enclose the site's two main sections of content" do
          divs = parsed_html.search('html > body > main > div')

          expect(divs.length).to eq(2)

          expect(html_file_contents).to include('</div>')
        end

        context 'within the first <div>' do
          it 'contains an <h1> tag to enclose the main heading' do
            h1 = parsed_html.search('html > body > main > div > h1').first

            expect(h1.name).to eq('h1')

            expect(html_file_contents).to include('</h1>')
          end

          it "contains a <p> tag to enclose the main site description" do
            p = parsed_html.search('html > body > main > div > h1 + p').first

            expect(p.name).to eq('p')

            expect(html_file_contents).to include('</p>')
          end
        end

        context 'within the second <div>' do
          it 'contains a pair of <h4> tags to enclose the ' do
            h4s = parsed_html.search('html > body > main > div > h4')

            expect(h4s.length).to eq(2)

            expect(html_file_contents).to include('</h4>')
          end

          it 'contains a pair of <p> tags to enclose the ' do
            ps = parsed_html.search('html > body > main > div > h4 + p')

            expect(ps.length).to eq(2)

            expect(html_file_contents).to include('</p>')
          end

          context 'within the <p> tags' do
            it 'each contains an <a> tag to create a new icebreaker' do
              as = parsed_html.search('html > body > main > div > p > a')

              expect(as.length).to eq(2)

              expect(html_file_contents).to include('</a>')
            end
          end
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
