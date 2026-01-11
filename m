Return-Path: <dmaengine+bounces-8196-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05925D0F090
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 15:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 632353009875
	for <lists+dmaengine@lfdr.de>; Sun, 11 Jan 2026 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474CF33F8C3;
	Sun, 11 Jan 2026 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BkO3z2rF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCCA500947
	for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140317; cv=none; b=Mv4UZwTnEkrmsd7lx8vqQ5vJZtC6EeAHUWEeqZwowqUI44gcYS3MtsBZGrS1P/6owwG4Oj6clYgD8qeJY5ERE4J1re66PHygeIXpj0IRijMB9oWdBWeen0DCdP01SW/87KX8HwGYXmu8RYBGDJ2XuNEwGFwq+FH2RBo3rASOVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140317; c=relaxed/simple;
	bh=XJxqouRZEHyqMQtDF2nj2CC7ybgayxpBpI1cIt6Nuko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gq6Ij0wC9Ba6uOddNygi1eZDIdrUYKnJRoY30ZlN1/lShrrRLz3mfflxAhUC2IOYMGGH7GYNIkGzJSniQLhRf5kFwcUPbb4gM86P+iiWnF43SiNGXWPYEzFWrQsvwNBs2ix9mws+oV8bIgHjn8bzwJ5qUzRlI8XaBstHL6FHPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BkO3z2rF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so7207798a12.0
        for <dmaengine@vger.kernel.org>; Sun, 11 Jan 2026 06:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768140314; x=1768745114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NCh2RDJxN8hiZ1nJoik35Pfikr6nPePDpNs7w6splE=;
        b=BkO3z2rFR8gLFu9KMsttbGGdCIwLHM9rD4383KQBSCw+CJ+lfOYeONmprcyoyZWmOU
         foix3ABm/QKUZPkXZQ02d3llbNlmYK1b5tc9qT1gTTv0gyY7qUa7qIefWRknEuSCSm4i
         dtOCIeiL/TlBE+Gfmpcvb0X5KY6ddxXob6/LF0uZxmTxV04l6TPHYYaxtu4hwIIp4UHa
         fmtFug7tDLjpgqcg6EFliBlyZwsk1p+jeIXItmgOOmkVnlOdQjQqKQsoa16x02wvvS3Q
         FmbIH2X9BIVh+p2zvY1E1z0YKmlJRqn0yUnTW1OtYT0tvX/SQ8j+q1FxVxl3md2KgMyv
         D8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140314; x=1768745114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NCh2RDJxN8hiZ1nJoik35Pfikr6nPePDpNs7w6splE=;
        b=ZxAG3zhjr31S55ErwFaX7sNv2YXXB0RLIRJ8iraLRCpFdb6lMm7cHL2mgppYlbpfOr
         HF0gLUd9r0pwXPh1S7QzRz0zSEJG1b17hFCIhFWvzcjJsUrGeZbIU7X/yxmyngtEYfZM
         rcwvjPsrKMmmv1JmNwp6vsvi766+a9l1qHbndDxgtCPXv6CCjHwaqvV7kmtxTFTCcZQd
         6b9ydnc0uUQTRitI+zjVuo6r4dhmRUJlF9dVrbi3sD2JGia0Vw9h+BGdnVdEQP14HZzc
         sYATOjm+bbyjpKeO3+HB5rC2AIEjyKvfZrrvrqGT3n0wd3RMiah2Ol8RsR+wd1etGk95
         fXxw==
X-Forwarded-Encrypted: i=1; AJvYcCWKqWN+/bS7dPivJ9MFH7R/UfVe+DXjZFeYrGSG5H9ZU5pYiOKZMTm06/hn5rfgZJi3Y2VjECmw/AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAT0AJr82pv7c/4PoujDsmtC5eNHTdnzp67MZl5JR1uYYxqMTK
	KHv/WsWKNnlQrQo6IvvTE746h1lmVv1QHpLlnbJtFj+8n3ZUYpK1u8UeS9DStCw9jJo=
X-Gm-Gg: AY/fxX61p4hghBW2x11akYFcCLawhrk58mGN+5N7Za8p01OQsUPgkxZ+9JucUbsRZgc
	/qik6WXJEsoO+BE6itC89WbH+7Ke2mLnFe4zBdyJ1QiMiUWeYMuLrDDi74A2T4GHc5HdIrYIW/H
	dSWhWkq9tmtWhjw5J+ZkKfBiP1li9I2HawpyOlYYs1q0xqRU3O6/GHLQ7wcwJMTagxMdKiqKsOG
	M434NEN4rIkB+WV7m+ONyGyEAz2QPiC+DQucNYhcZ4Sb5wKcjdt9g/KofcKawt+RsQmcOZrfYMN
	B6rAWHistnXCFrI3Q2eOgyNUnRHe3z59F6E63DTlkZVW+AkJ19qlI7QmQis4zLyl+0JLvh7teqE
	TNLPZ08C3HVXbxOMxj0NpdJePyJCG7zGw+O7BlzgSi9a1H0qGeC/ssLKUZxcvkiE6YZ9TVrcNEk
	SkFaPnRLPQwIvariPcAwLOtE4TEUHwr6X1wA==
X-Google-Smtp-Source: AGHT+IHX4kBq5in8WgxEwJr9XbVFlnt6AItwyKhU9py/NMR0woB2X72z7DmCdf3HQxhQaT3H7Zh1Jg==
X-Received: by 2002:a17:906:ef0b:b0:b84:365f:10b9 with SMTP id a640c23a62f3a-b844522a6cfmr1333268466b.29.1768140313496;
        Sun, 11 Jan 2026 06:05:13 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8709d11b90sm221829666b.12.2026.01.11.06.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:05:13 -0800 (PST)
Message-ID: <1658b580-cf63-4f57-be1f-0691cc4934c5@tuxon.dev>
Date: Sun, 11 Jan 2026 16:05:07 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] dt-bindings: rng: atmel,at91-trng: add
 microchip,lan9691-trng
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, vkoul@kernel.org, andi.shyti@kernel.org,
 lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr, Conor Dooley <conor.dooley@microchip.com>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-7-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-7-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN9696X TRNG compatible.

s/LAN9696X/LAN969X ?

> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
> Changes in v3:
> * Pick Acked-by from Conor
> 
>   Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> index f78614100ea8..3628251b8c51 100644
> --- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> +++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> @@ -19,6 +19,7 @@ properties:
>             - microchip,sam9x60-trng
>         - items:
>             - enum:
> +              - microchip,lan9691-trng
>                 - microchip,sama7g5-trng
>             - const: atmel,at91sam9g45-trng
>         - items:


