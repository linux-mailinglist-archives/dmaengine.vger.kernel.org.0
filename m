Return-Path: <dmaengine+bounces-7631-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA15CBF441
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 18:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38E46301413D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1580E338F52;
	Mon, 15 Dec 2025 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="wuE/sKde"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76733A011
	for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816752; cv=none; b=iEAj3NGD4MurtrXttoKibBZYRXNfB7X7MD4Gz55SRGjTwMRzW2utwQ/cDrTsIfQxTB8GxRo83rbLDMz3LFh7+rhO7SBXxdObXUcFDQxnMZok8feWan3VyixDP3lW9kLLztjfuNp3qB0/+E+JIFPXdeVQmUoLsIWVwY1vl0QjLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816752; c=relaxed/simple;
	bh=yzcerxGw6ZEQ5EAWvF/XHa1fvQNZAbIc9+3T/p54DUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGYJiB+jsVDFpOz5o682iOQKQoBhZhQZme3/Svie9MULp3HEf9NVd0dwxttX1HfkvSmNnH6lOAQvIlFiaVWZ4nO0NK0j+CVVTGrjV8CiIOWl1JbSejr9NRxjnSuR27Iyd/LTyuRVoUf+NUs100kR+wD1N8boG4GsxgTFzE8G85A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=wuE/sKde; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477b91680f8so36980825e9.0
        for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816740; x=1766421540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7uXKaE9ntPCAZ2rjdGBHoMUGCXZvwAT6+sIs1szqdY=;
        b=wuE/sKdeZ1o995m+SXaS8gdLHPqBj9GX4ItZqDHLT/qyQVo6rZb3HQc/BcqB9c7y5T
         WAWKU5zNvBo3ukX5igI9stooGkl2JDOJfHn4J1f4AYJLQrPEKVd2idNvS1PnecZcOAyq
         mFoxp5oktt9oRgiksHv5Z4zX/eFmpFXWKx3IIax7Z8kiRoMB+FT6Ll34iiTLPHD+qAzV
         7re8uKM49/6YD+Lft9crtVxLMzWamLgsxkgI/dyKNTW413QTLQSC3Df6Xs8ax13SyOye
         EEfiPyAgiG/5/DD9prlU8lV/UkYUcRTK6gB78zSOSaMZ1IvI6Ok8OZ10nBaYz4uByJ64
         jtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816740; x=1766421540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B7uXKaE9ntPCAZ2rjdGBHoMUGCXZvwAT6+sIs1szqdY=;
        b=d84CTW35zCSL2U3Y8xACNZWBvax3dMaaDNki7yli0YSZCtgUdqigBKOlxEGw5N1exK
         OBhBmk9oUbpzJBNs2Mg9OD2iv4XHfSo8KCuDYclC2ZKPW3Ywsr1HievkOFNTmAWGu6Ge
         ZbCWocYPSvSGM0h4BLEZ+OWM63BT5CjfbzOvRhXQYM90KAXP873k8zJvaEVLFkRPir49
         8gnRgd/7Ja1ob8UywVCug5vLvf9W8c4OGi1TNn7yTmm2LnJgZ6H6a5CUenvYmlfSluD7
         PCsI/wa57y1w5DjTHN3acdxuRuw8U6l1HY447GIh//b7rwyvi6BgiAQjeL+LnYgWU8zy
         KXSw==
X-Forwarded-Encrypted: i=1; AJvYcCWSKvtzTgSWNH0TD1+Xgqf0EiVlPP0G9rTKpWmIN6hWNvp/RZKCL28HwVRqByztsXfXZxbYWzlNjWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcZiHcE4h5wuoMggTdHJg5cz8XAI6u1fWTAHWB9CwBAUrFUCt
	XnhEhTXxHxRq1k0BTjNT+M8pSkuVDrWGz+jjaAH22kLA5jAeRwU2jB2xfELf6SAQwsU=
X-Gm-Gg: AY/fxX4Q6LwqKZ9hBDMO0HlApSpS4708dXPE+Iuw3FdHo9OsI26Jb+sLjX9HF30Sx+5
	DUtbk/gl6A8L22rSRNl2Z9lOTbsC4jONG5sc0KryQ82ZfzMx2T6xtFcNu5y0A6ssAQ6gV3ZXhcV
	FaWJAXraq/uBa9DN/5KykNMDg6vP8MoyUjnlzy2PwFBL7W2kUoB5YMKIaAtuh5Tf/t2GKsVXQaZ
	rTZCaQIsIV9bTYnNoIi/ZZMWXOzbPYXWHVbk3TNuqvPWmIHA6K9MF+aImJ/98Vt4b8zWB+Pcggi
	z8rvcEfrCR9LYgCdQypJ+A+cOI1HNmf/SM/g4+Lke9GegtNhJc20NttFBjV+xIqBAmfoqYVvJMv
	v7Q1hBwOpYivN5xQvo1stad1y4DpSRFvOxKwbuOY8dkOsDUWJzpFbjrDyLjljVGP9gBvfFX4NnC
	BNg346EsJjuP4us2jH3CMBMcbUayZsVNfaTrRTaGWhSxB2
X-Google-Smtp-Source: AGHT+IE8U04tM1LjVUd6BjLQwQ0IIQCLbUIBLs6wp+cysOg55uq2vnToFSgCzvzZIateLKaG+nb0Ew==
X-Received: by 2002:a05:600c:46c4:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47a8f9046fcmr131388855e9.20.1765816740113;
        Mon, 15 Dec 2025 08:39:00 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:59 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com,
	Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com,
	tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com,
	kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org,
	mwalle@kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 14/19] dt-bindings: net: mscc-miim: add microchip,lan9691-miim
Date: Mon, 15 Dec 2025 17:35:31 +0100
Message-ID: <20251215163820.1584926-14-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215163820.1584926-1-robert.marko@sartura.hr>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x MIIM compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
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


