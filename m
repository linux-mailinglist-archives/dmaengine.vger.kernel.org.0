Return-Path: <dmaengine+bounces-7968-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D10ECE7DD5
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 19:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3250303C2A1
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 18:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9181033A703;
	Mon, 29 Dec 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="nrSYBFVg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A5339865
	for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033630; cv=none; b=hiEunGYGYmFB+ESFqwBKPR9/+qJ6jj5BNtD6ljIWs846TJsDxgTqp7StwsiwATwnFyANk2cSgYDPWJheImwd+ahoDieq8w127kVhukla/jJGNc24084LIP+G4FKF7wEZCPkioSHJe7jVKKBh2tg2ZTq9l6zdt9/g2S6NakL7MPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033630; c=relaxed/simple;
	bh=zUvrtsolEdengocgVlyXQxoSJXOg4mGPqcC0PLdIbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc+Vwoo7egipa1vEvkZGLm3vaP7xDqj7GhKLhiiG7MGSbcy+oQHXUV8wkV+xm7mi41YjvWocBxhVrIFeph2hxiYCSZ/yUvo/ClyZKnMjAt3hgJtIqvGZ9kE3UW+sqUVY/oQHbUafmXEIBBZAdQ83hQGjplLb95ofZzL2Ke2HZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=nrSYBFVg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so71140475e9.1
        for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033627; x=1767638427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=nrSYBFVgIwnAefLeDPgYgl8LqPiDckGltKlnnW75XVRuK+1yY9xg3gh3tZq8mkufWc
         bhWiM36cUBWMUAHYQq5VxaauBN1JBIGM1CoAC8bv+EjP4ME/nR6R7Y2d1Atbm5cJQNSE
         YakDsZ/R1kZY+j4wBQsd5PAXPwYKwrwuFRZtmYDWxrtbnG27rLcX1oBpHJzbZkBOJeRG
         /O8465TNdb93NZorMxyrz+2AaTqkqW0Uztj86TFG1zFVqHK9e3/M7xA6e6pQgFYtDjDu
         S5XivWOem/+RsxE7b3hkn3aI+uUJz/5pGcDpvkkbhxo4xpt3Fb/AMTvy+Y9k6ba8G5Sh
         L9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033627; x=1767638427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=BilCy+U31necc3Rk2tldt4lSK43DsHB82SETbABLO0JOS/ZCfKrRJJT97+TO5hCbi8
         CDEsONr5F6PpkcnzytUDPjQ9taBniOSUikp9b/BHhxlvuXtyQzT6ueSbx8xXLj62gw+K
         A2lKiUyHAYpyRd/y2pmGVkw4wdRtwXuQZAOzdoI+9WLKhcKQj2fGoMmkdz7z1K2wwc/q
         7X3VcjGTIZ7fLzuvAXpZ8KOApq8qMqdWLruqvyPNFgokp95MQvUcRuDHNGyeFCiL2qxI
         46lnmJFpo37UZSxGhHW/XzP9iLGX7hpf4+bRDOB9GU4fgvhvUtN+99ud+UgQQXJpTvQA
         cFHg==
X-Forwarded-Encrypted: i=1; AJvYcCWQou3SDIsx0Cm+0AEsJSy567zenLUpDXfH4Vx15fjpf8nshiV78e2FlIb/QmaUFAL+GCuZRSiIdXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4htg1iCcMWyIjCkD+JWeMdNLM3IxKvlKcT3Y1jsNk8CPPPDHl
	rtzdb3iZ+CDWzDCMF4Nc6ea7SkrAhf4yahhbbz/i8IqTmSswOM1tUbrF2kjZTSB99CY=
X-Gm-Gg: AY/fxX7++QSX96m69A2nzQra1vVbWmFEx0EyiBqRvd4JkIlSoI65IhrwQQAwcCbkS6k
	GroNlo7V5J5Jjd7n+/OLdDkVphY1cBsl13aKfCsr2U6KrSdEKtAfskWzEo68P1Q3MKEJMJxWoZ7
	iXNCfcAJjoNYXZAyP/9K366dicAs4OaE9Od2E8WGWTjm/FhkW+TdYMX5+E5HkMrKANBKeEJitVF
	ESlK63FWnuM8pKP8DppxS1FV1Hu3xyo25Cyg2mg+mD+ty/7H5K98BlPZQ4FZWZjjhC6+b2V8TWx
	krd6SRts9lGClwn57s47sKtjkfykPHqcyZslw7EwmMYNQSsybzTRa9clBTvMpRU9IAzOMeTDFUT
	CwAsFoWmixMTVrly+jUmNGilTRhW8An44MIfIVAfEHdm2o/Gs2R3P0JbzpI/hstYRArI+i5U0u5
	k5iuRbtYQXXVnE4oXXW+qjth6Hx0nf+5lmMxRYYTx84n5x2DaJWj0WAcUsvTElmZPpFeJN6uesY
	nqKRBn07B73USsc3YZpitQMqKlo
X-Google-Smtp-Source: AGHT+IHcFjQCCkIHzURsiMd4ZffbXQCjBanKlfgaAMAIAjZSkOlosZ6OaPn7ElCbfUOqooZC1IjlJA==
X-Received: by 2002:a05:600d:108:20b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-47d1c038664mr255230805e9.28.1767033626661;
        Mon, 29 Dec 2025 10:40:26 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:26 -0800 (PST)
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
	linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 07/15] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
Date: Mon, 29 Dec 2025 19:37:48 +0100
Message-ID: <20251229184004.571837-8-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229184004.571837-1-robert.marko@sartura.hr>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x AES compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
index 19010f90198a..f3b6af6baf15 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-aes
       - items:
           - enum:
+              - microchip,lan9691-aes
               - microchip,sam9x7-aes
               - microchip,sama7d65-aes
           - const: atmel,at91sam9g46-aes
-- 
2.52.0


