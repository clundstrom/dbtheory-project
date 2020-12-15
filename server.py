from api_setup import create_api

app = create_api()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)
