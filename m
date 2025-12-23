Return-Path: <dmaengine+bounces-7920-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C443BCDA7F1
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8E4F30CECD8
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86796286D60;
	Tue, 23 Dec 2025 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mknI3aHD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFE2F5474
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521219; cv=none; b=saF//TpnetqME2ekcTA1iesC3Rxq27yef3nceGOA8k8+W3Cvq+/CDxsYia2kB3T5lnOTkQb73uCBpexzwwkcpFM25pMVKwkb4KY3owhtN6Ix3H6DbP6CkC00ojuxXqn/gd26bmtu8G0GN7I0Z3Nu8VoILDX+yUZ5L4k2bx3WAmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521219; c=relaxed/simple;
	bh=GSmfufS+BjcFXAR7DhKTmRXgeyl65npdKjntCPPDfHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu843zYEoKRvyzwUEycZQHqIlzAqNsrot6oOr1KONfoS31351OxR/Nf/5+HERhGlS4ulbu5CYDKpNxOh6rn5mE+T7/2zu/ey0YhqE5O1yjpy6Tl/hkrKwglKZyZnUz5i/WDLBDr77MA0u1i15M9yeN8XCmZ4m4UGoLw+11dNHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mknI3aHD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ade456b6abso4458412b3a.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521215; x=1767126015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2FSF4N3N2MYzlByPoECc2cAz8v8tXyMKGpnQtUm3aY=;
        b=mknI3aHDk/xx6E1DXCAkhUtT53KYTa8H/fy7ZqYi5lMAYZ2pnjDOEBbpIn+PxzsEih
         Wi8gHCcxw6toR6SqJxa0bt8CxPRFrw2FGeuOBXtyqNd/OiX8LDNzXflhB1fmTCJggOR+
         YGkdiMbAf487Cc3/wOyoWB7V8JvpTpMJwDUOtBr7clyUt5ACpOC3y4DWtOmXN/0bgspv
         S+1LRRlkfT/LfRuRi8mvNfnDrTa7d0Rz3fVOwnNtuYqX9hOvYGnRNM8NwkprFzIiTiGt
         DCBGCog1PbUG/q40amKbvFtSJI3QV2PfA7L1Id37cDtu8ahGqYpYnBl3zRj+quKK05rp
         MSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521215; x=1767126015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2FSF4N3N2MYzlByPoECc2cAz8v8tXyMKGpnQtUm3aY=;
        b=fb9GKPwFMoMDJZr6Mn/t8NwhkNob2588cdpIBxNB+n1itmtSau/Mys+HUPDFXxIfLr
         /eoQwP7MO+PTxgwaxBaVUWklKBIafog0/cJt6cdHBCaJVicHbzojzygPPa1gsmPLCAMx
         7ONpAfXUy60B51iTLvJm6GornIMbC54ZA6WBemGFDWpdiLwVy0eerMC5da+VOrCh3qeO
         rFnY7WoikxqIhnaRo5ZEdGYmxkzKRlU+2OzR2Z6pIKGE0TfZfPYpbB+nCDAf4MGnUIb8
         jRiI6+EuP5cVx49wP3VXhOTMYqNHbCo55hskPxpOzZhpSo4TsLU8iM9rScPo1aXWcRlA
         lndw==
X-Forwarded-Encrypted: i=1; AJvYcCXFNwhIEcfabBN9RTomse3wbiCKu0F0N+R2oELURrN92LRoIEiq9ZbtTAnUDqSLA2+fo09GQSfNkcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2C/A9ovX4Qnscas5W+8L5fiR3U4SEr36cQLfo19xO0heVNA79
	VwMCBljyPX868pR1IEq22jMIH4czheXHsH8Z1nFoCY3nw9hFV45C/VUjLnIVntJ0P8U=
X-Gm-Gg: AY/fxX5JPilh1LhoLG0jRtc/kpUYDVlCHZ+bDZ9MH6Zw0x2W0u6EKjfIgysqH+ygZ5n
	PUGYPARD36jSALXDsoukkSbk7WJ7U47itM/Bpo2O/fmHAlB4jpV45Yz1XRDd8C77YQW7a5AJPW2
	rrinWOuKvIxncQvC8KKPHjexY0nNZ4KYyb0042iytZoFFEIU8irUhE1x8YroZvTcjEnu+85lt1M
	f7h0DZbWFe1v3rbkpxGp4B8H4eeQeRDinUxtKwkDv/UA/HveK8u9adKS1LW7Rb8QwlhXbOhXwU5
	ixVGSAXv1lUAo+3PwtRL9j3CG5BvCD71ZtsjqgsUpE4GMGcOJSuLG+v4PcMulV/cbytO55gVCZw
	f2S+7AMTI9qszCCE3S+Lv4rXC7L/7gBoe16U+H4wXSgzu/i7D1u4EOLajWuHNG2SxaE7zm5fQI9
	MJ01Jibpaq20U7b88RsGZkR/S8h+/C3M37EGLWVxFVb1nLHY8+ZJJO0CQrTIfp8ACI0tmrace1f
	Oa3K1HM
X-Google-Smtp-Source: AGHT+IHTipKQ2GYkfIzCrgEkT5HgaT5cetpxH7RTkCWDpkBy3UcCKVeG1Kf0FvBM/eI9Sln/VDayPg==
X-Received: by 2002:a05:6a20:9149:b0:347:67b8:731e with SMTP id adf61e73a8af0-376a77f12e8mr16762772637.14.1766521214766;
        Tue, 23 Dec 2025 12:20:14 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:14 -0800 (PST)
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
Subject: [PATCH v3 04/15] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
Date: Tue, 23 Dec 2025 21:16:15 +0100
Message-ID: <20251223201921.1332786-5-robert.marko@sartura.hr>
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

Document Microchip LAN969x USART compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 087a8926f8b4..375cd50bc5cc 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -24,6 +24,7 @@ properties:
           - const: atmel,at91sam9260-usart
       - items:
           - enum:
+              - microchip,lan9691-usart
               - microchip,sam9x60-usart
               - microchip,sam9x7-usart
               - microchip,sama7d65-usart
-- 
2.52.0


