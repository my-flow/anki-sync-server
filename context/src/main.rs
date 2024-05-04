use std::env;
use std::process::exit;

use bytes::Bytes;
use http_body_util::Full;
use hyper::{http::StatusCode};
use hyper_util::client::legacy::Client;
use hyper_util::rt::TokioExecutor;

#[tokio::main]
async fn main() {
    let port = match env::var("SYNC_PORT") {
        Ok(p) => p,
        Err(_) => String::from("8080"),
    };

    let path = match env::var("HEALTHCHECK_PATH") {
        Ok(p) => p,
        Err(_) => String::new(),
    };

    let client: Client<_, Full<Bytes>> = Client::builder(TokioExecutor::new())
        .build_http();

    let url = format!("http://localhost:{port}{path}").parse().unwrap();
    let res = client.get(url).await;

    res.map(|res| {
        let status_code = res.status();
        if status_code < StatusCode::from_u16(200).unwrap()
            || status_code > StatusCode::from_u16(499).unwrap()
        {
            exit(1)
        }
        exit(0)
    })
    .map_err(|_| exit(1))
    .ok();
}
