Return-Path: <dmaengine+bounces-7971-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62CCE7D7B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 19:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B28B3001BE3
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0980733BBD0;
	Mon, 29 Dec 2025 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="js20qBKl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685533B6C0
	for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033636; cv=none; b=LHoZ1Uw4E5Uw1r5xIcdWaUZ2bwoSMRlkCFV65VZcjQUkdOBTmWY99Umyfu8Br+Wvlo8z/RWoUzWIb+Zy5QhX/VB5pCggepV0mor+9FOa7wGOfPEldPSxZP5PLoK+2ThjbLM2bgLwDFzsY+58XLrxmAVuW0euppsOUQa+7oop7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033636; c=relaxed/simple;
	bh=omWUVkHfDgWK8/wVYsqR1gmKx3uRcWW/S7wsFlqvQZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSm5aG1M65CIF2TglJviYynsxC74UwOzPEl6bMuJTtAWvBUVskx8/ty87HlVj/SQfogj1P4dmAUyZ8vmEq7sJhCnNo5oe/b5XlRU1u36/IE/WaCcYuiDnEEa/fJGV5RTYM+DpCKAvizMncApiyRNgOamQTqYSsk74eYjIQ1g9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=js20qBKl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so71189135e9.2
        for <dmaengine@vger.kernel.org>; Mon, 29 Dec 2025 10:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033632; x=1767638432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe7/bfwW61qpTH+JIS3AKR1VkqKbIoFXot2V67cYu6g=;
        b=js20qBKlOIc8p7LAg3ojQzBrDVa9hnJ3iwdqCsfn32yFz3aInQM6QoNK5N/ROzBK2F
         7GGCtwcKHJrg81RR8yBIoLsUREQkvIHNvhSZ1Uyooa1SkWmuCNLxf1fM7yTIF/tSA5xd
         VFlGqY3EMA41aCFoQleCr+F/kX/Bxmhq53oqbmeTatA6OX82TeqOt3nsr2uNqBEqrl0k
         nBsY0OfjmzG0AqlPzNx6ENwwoGPvY0sYVSF5LPWB3Vob0xzKohW7DvCBZ7tTFFYgAJ6C
         HU5bjhYy+qoTsm16Nc5dGsdDMwZMnkSPDCi/zwej+DFJ6pcf+YNfvG9ROfUQuUhCz1pP
         LuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033632; x=1767638432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pe7/bfwW61qpTH+JIS3AKR1VkqKbIoFXot2V67cYu6g=;
        b=mCHhidhj2MZJaFBWBmnEhQ/bVmbtOPjpXLKCKaCUSnq96f01tnVRNGcU2My2XYuCjz
         O05rXDU8By2aIskybJHOqsunYTPJNAIzqZw9VutN0/ToxCkrE2zvmQ7gyESNhhV/QuNF
         YWEwYm66TCDWfzt3xRrhjsfsL+KBA+kjnlN6upnVEhr/xlziXMd6q7KrnRZI/D9CWkGN
         48vHd6Q56Q1eDVKZ9ks8KF+Hi8nPDOvSdAAS3KASq9T6nS8ntVD3vjD4Ftt5bCelDddN
         9/ZDAYbB+jF/EMaur6TSqUWs8qddnn5qUMGaZWUS/3mM3l/o8kmYAPdeogyyBqsaLxx+
         RPiA==
X-Forwarded-Encrypted: i=1; AJvYcCX9taZ8P1ckifHuWhhYtQXzNnvz6u5PgyMnZyT9ZDF6FBHbWYdbLakRwKCoZ7OPrUjmTzdYfogSpaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygxCDxbtfFPh7nrBIJB9A6xVME4iGVUlyuO7cVu4mgWudSiwoQ
	3X0iboP623fXNE/h2zGPSxN5oBlBdseWbsX17LHVX8Rgpl9bg4fu2ozcN2VaDLIGdmY=
X-Gm-Gg: AY/fxX64ZwTE9z1ksIrxsjrOqp1Tp1bBtG79zg+jR7p6AdTwufQzjfYKutHMMiUuJIU
	kR+qRPXcvVKsW1YiDd7w6c9g7LItUB3khn9uj9muWX0ubgp+Go8WEOBNI8wmTXrreS7tiek5cZE
	wKNsnVbce6TBWhcpABwkIKCyC2tcW+BlImGd+GD7skRLiesyWvrLSC73ckqPNa7fsb39Br5jLz7
	qalwaMM7p348+6OJQGCkuf7ng1lG1B7Qkp+6vPezkh9Oo5ZJDJ2LTE08C4AA8j1bCtYcmC8fZzu
	P5GbrGkjJ7W4sZSQ5Hw/MSAxqqESvpqxfU9Cmwasn5HqcevqBUKDixdO2HaI6nVOFvBz10WlM0O
	u0Qs9UsOL6clLOMRvfjmLyEqI4VRMVGAGAOGyUxR20gmddw+T1fNwxEOuUPvtxPfcx40PkmSyWY
	+y3I6EWnc0Js26fnuVTPCz5lKt5msf8F0nrkWqh6d+dfRhnGhBPGcuP1yV5abnCkUQIhaA3xMrD
	9rN9eUvyKapfQ4f082VSI8HJkr2
X-Google-Smtp-Source: AGHT+IHMeEPdVuxCEsr3HbzwXW9O9zK0z+wZ0vfJLANR2lbSoc703JFfFuycpKgytpooUs272ghcDw==
X-Received: by 2002:a05:600d:108:20b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-47d1c038664mr255232695e9.28.1767033632356;
        Mon, 29 Dec 2025 10:40:32 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:32 -0800 (PST)
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
Subject: [PATCH v4 10/15] dt-bindings: net: mscc-miim: add microchip,lan9691-miim
Date: Mon, 29 Dec 2025 19:37:51 +0100
Message-ID: <20251229184004.571837-11-robert.marko@sartura.hr>
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


