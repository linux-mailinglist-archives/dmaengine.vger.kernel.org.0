Return-Path: <dmaengine+bounces-7927-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F3CCDA875
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5177C308B5DF
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A2E3559DB;
	Tue, 23 Dec 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="TqO1SVDy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DEE3557FA
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521281; cv=none; b=nRF05+OU49iboKXnvZQ+NCKdn3uYHVZvlZvIX+Vp3jm2r7A53HB2drbAg+qSEGhZ2GDyy6BkU++NWZ8G5tM5OdkOrWUTmyFM+qgxTOvdGWCeQGZ0EHURUIMqxxoWegKx0Wuo3hNlMVxL7sjCULB7qEsxAY7RM3ZpzHRdlYEKvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521281; c=relaxed/simple;
	bh=omWUVkHfDgWK8/wVYsqR1gmKx3uRcWW/S7wsFlqvQZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSGZFkC4a0W06lw4veAtkp8JHIg5zQKdPWJPk8aIe/My0Vh8/6NfE0AASu7Uk+OGPSrSl6tRqlqEIznBAn5mGBJBwTUGQW98y+sR+Xc4EP+Gm9s7D2D97Tv++R60xwt8JoLA12JSN9b5qo5kB3wPxSQRAL27E5wtfMtCS0zcfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=TqO1SVDy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso3543531a91.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521278; x=1767126078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe7/bfwW61qpTH+JIS3AKR1VkqKbIoFXot2V67cYu6g=;
        b=TqO1SVDyDPy6oeM2rbEwUbThg0ZMdnWKh7T7VD8KZSzOa/J3kT4ROyy/pl8C/wyVsx
         87KW2ws4VZeH2LmCpVD56F3zdAx5JXs6BVI4CuP0krQwFRfdL5t80ZUQoSqx/9VjCZ93
         2xHRYX+ZNHO4M/4rPr+tVC07JSbvH9LFNrnBQ7xv2se4nRY89nnVpeQCvPP5R7bR74dN
         8ViTbRe6BIWhzI31DQmgEro4hW0FWUc++XgR7MG6fQJ7WiTyuHPokC+8mh/pV6Sq6piW
         ZgBIqf3KQjUSOvTNzk6HjjuoWV62KCEhAtinLcS332mSds9tBcYhX9IcAH44WscTKXwf
         1cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521278; x=1767126078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pe7/bfwW61qpTH+JIS3AKR1VkqKbIoFXot2V67cYu6g=;
        b=GHJ2vfZDednlzZPDQf9xuLeMcWoom/1s/8UPfHkaxVAVGAsShER5F9HG8O2a0ucwdi
         dlM6kOb/XTLif1iRkm8I+y9xOwrqAuasht+SyrW/tw96ZQ4elArHQT6DZ5MBZGUrt+K4
         ZLQy0Iixkxegp94beb9E6QmTnbLMCRfW9327nAjX77CBsUHgwIPhvojzSqcWY1gEvSWo
         67iQ9oISQZc89a/aGnrheB98F3D47cl2Y5+5SaDmudhFCcWar/nIl4A58xT9eoIguZ+d
         rZq0EordMXUb1I4B1h5/Rfz7N4DI2EtnYeBomfnk2eCwRQzmR7860Z7u4llaIAwzPGlK
         Doag==
X-Forwarded-Encrypted: i=1; AJvYcCV/19sMSAUuuDS/ru/R2vYEf+8Hznxa1c/pAogqHpqIonWMMHxZQeri3bx0mRVeNJ7TEwvlrxOyOyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgFKvB5qFsrdYPDRkOE7LS3U9ulDX7HjLm2CJPOGIP5pU3D9oj
	zc2eHBBzHicJH/KiqKc8SiZb2sl4EZfDAXtUMXVm96rcCicCuUANW62Iz7NJzmIufaM=
X-Gm-Gg: AY/fxX7IYwbZ2goMJIqWz3fbICCVkN5JC7H438ERU9wigdCMwv5XcwjZhhFuG1BDtkR
	Ayepqv7I2F8ZD6LZkMKmXf3G2DhsLNnkzJmOn0QLFu2MpEbIcv3ziCUw1w37x5rpSKepvunJtbV
	Mmh2q9TzDvy/F6gyJ0tFrC7VzMHFUvJ+YuQ43V7oHBFxSCxGqljaUEJmGqsvAucL34bBLXmhj4H
	St2N24d1Ikx0rIw6QSOhGN5H/16HMoB4vPGNrYz6gE1A1Y8XZqq0XgK+pzq2eMVV4dkT5Mttxwi
	AZhQEQPEHPEPYvp70R9Lj4IbKVnwnpOL3GN5QN9mdknNmEoYf8QesBiXxow8bVCjlm6itD91aLN
	Tk8j22/u9lny+KNVM703Sa1W/LXkG9zBjUEC2yd3EJ5C6c9mT+VhZiqW8jQnw+sHqVtrcamKFzY
	bRtZymE3GU2WMz5+wOmFKPSJnGYpkZ9ZuburQqjgCvGB0TBdXaJuQRU2CbGgTCIFMpgTnwpdvbF
	YlDN3r3
X-Google-Smtp-Source: AGHT+IHeRAtPKwVz6qoPOdL+Osxtu3PLTheDOvUOr8YysaVV8Js4PDKym39wxYhmLqVHZ9ksN45wJw==
X-Received: by 2002:a17:90b:3c4e:b0:340:c60b:f362 with SMTP id 98e67ed59e1d1-34e921131a2mr14020700a91.6.1766521277662;
        Tue, 23 Dec 2025 12:21:17 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:21:17 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 11/15] dt-bindings: net: mscc-miim: add microchip,lan9691-miim
Date: Tue, 23 Dec 2025 21:16:22 +0100
Message-ID: <20251223201921.1332786-12-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223201921.1332786-1-robert.marko@sartura.hr>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x MIIM compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/net/mscc,miim.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mscc,miim.yaml b/Documentation/devicetree/bindings/net/mscc,miim.yaml
index 792f26b06b06..2207b33aee76 100644
--- a/Documentation/devicetree/bindings/net/mscc,miim.yaml
+++ b/Documentation/devicetree/bindings/net/mscc,miim.yaml
@@ -14,9 +14,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - mscc,ocelot-miim
-      - microchip,lan966x-miim
+    oneOf:
+      - enum:
+          - mscc,ocelot-miim
+          - microchip,lan966x-miim
+      - items:
+          - enum:
+              - microchip,lan9691-miim
+          - const: mscc,ocelot-miim
 
   "#address-cells":
     const: 1
-- 
2.52.0


