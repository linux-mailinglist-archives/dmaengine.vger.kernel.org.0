Return-Path: <dmaengine+bounces-7919-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 325A2CDA7BE
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F2F30AE88E
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8414534D4C1;
	Tue, 23 Dec 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="UajBDKTY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A826434D3B5
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521208; cv=none; b=Xet/yJ9J71cmRmk/0l357XGV2LzhBEfcPwDV1FmYowYPCUVqUe3J8Kw+wdz2b5+RWB9kPDypAHOZTjRXJIcIz9CLagiBbh2VtYoWqkKTw+D8hCkXC872AUTdvzEXQXeOPtEWzADX/4ah98A/KFKM22okIjhyTfNaLZ/xFmDYQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521208; c=relaxed/simple;
	bh=lnkhvIt3TrOEyzf6TQ1BG1hfakQAvNrAup7QLQoickg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3OfYmPQ6SzJubvn7BBCzztqGXycraSnN8Yb6ucp0HQFwyKlJNw0PK61tV0oh71UrHyfw/IDu1APeMS6Cq6NY7HYl7acC2uQHrwfqWeJUDRtlITWQ9XUGmql3TiYjFSmvA2kGiB/8Nn50tDBkz5WsDGOiO2OCozJ9byW2d6W8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=UajBDKTY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7f121c00dedso7147775b3a.0
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521206; x=1767126006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akmDQhsi4smXKOu+AQ0134jZY6Y2uyR0jebUNjrF2nI=;
        b=UajBDKTYlKcruvSkRnlFr8tjHgo7vqKYdeF6g6i2LgrtBlAxi/x6/j2FzFA7aa8IFJ
         zCbk+kIU9UJjaY8OIT95qG20Y9itoXB0IHgRnrBEMTEvoYeZOBFiUZ+FDnpmRXib51JM
         VlieXBhkKajYtWxLUzmgiSHsdXHz3zT/Iqy7FF7c8goVaCwQ7p9fsGuBegWYWqK+Jb8n
         9jJK6EEPqAU5wS6uLrfhFlUXf2YYvHGfb6tTbrFyqsIqLuSPy6BdmhvfuxR/0v/GvHPn
         PnUCBlucC/3gAqVgR3ks06eKS/hQ6am0E1QuYjf8Chz+G9uMrPAlcGrBGz7oOlpk1iTI
         ZzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521206; x=1767126006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akmDQhsi4smXKOu+AQ0134jZY6Y2uyR0jebUNjrF2nI=;
        b=IPP2vfkXE0F8ewMqh2M3A6HNKcy5tewEcvCxsmYhogrhZfa0CZtzabKlWPurQTpwjR
         JPS4QcoVJGW4rjwTg5n4Hb0/RBS7LNHiBCPaCkhmZiWbqLqXA00hFZD7d/Lkw7yswYrQ
         +fh/L/z5U6fN0LXBoeVzGSFBZkhECjjcoEisbda2CFsroBFGj7XMmEBTkktjmfW2kOY2
         ZkkfOtOCEEyIYuxQ2BE2fe5bFo9zWfClVZUAyT5AR+wJScFlz3iPZE5HH9yk48FDGItj
         3nBBie0HIufIBkBG9F0I9YjWamS4Ocd+eNr4GHl4cRid+UF8PXl3zCwecvPkrPwd85c5
         rsTA==
X-Forwarded-Encrypted: i=1; AJvYcCXp2J6583+rErgthc4zZEwcHM52Qpd4mnkrgs6hhMNdbKfpOh4YrmmuBKgOGYZ7ON2ZMNzGCc9ESW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyltEOu/54+iNtvIvGZSfoJPDztA9IKL31NWaTra1ZdJtslaa9Z
	BDxC2ZuFEwDo4TtGBiPXAmRQjenUtsfR0WL3Ia1l31sVX5oqHxC/1/7BCEaMUGU2uhw=
X-Gm-Gg: AY/fxX6/R6o57hTKyZjb57eY5RGtZUKAPD72GY2u9gQXKqc+AzV0HUX5gaXzkyoabvF
	A/oL4+ysEqqm2kxetjWX8SfhYZNWxpV2sF2mtCLbb1X5Xbv5c0g5ajTg03w6LSQqtMAa2RlmRQO
	rxJ+GtDyv59a7LIuEG8ejJlOOqXaSoc4mxn8esXCsUvcOPlThc6ObMHPfG1J/WkgQEMMMgoEus9
	zNXlsj+lHoknazrUf6osM0Hj8fvP7saNt9PYEOsUGFRe6PWMyKbGRJ+6KkstFoFkHPd+5HQSqcl
	M1ejLldgbjNwNLk1EUKs6M9vWDbrAp1NH83JlqXmgGbIU9cl0un0p1ayQGvzzK/PbW4pNhl5+WS
	80m76+8FLJfJPCwC5zPfr6e8a7Xkat8jkMP8bRTdCDX2LdQDAJmbbCZlezR/6ePSOrnOEt+l24H
	w0uV7tx/VPLjBeMyTpTxyjgeNtiTR9Ph8HHx7PlelnPNMoHQyJ1wQZ3CvEW11yBpSsNh2Dxv/je
	PcDiags
X-Google-Smtp-Source: AGHT+IEAtWdhcWPCbENBvZFgr3c7IxJWeT0r5R2X+lgPN+f3cgKBnmk37uhjXoH7niVY6cpG/hJphA==
X-Received: by 2002:a05:6a20:9146:b0:34e:959d:e144 with SMTP id adf61e73a8af0-376aabf97b6mr15698314637.54.1766521205797;
        Tue, 23 Dec 2025 12:20:05 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:05 -0800 (PST)
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
Subject: [PATCH v3 03/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
Date: Tue, 23 Dec 2025 21:16:14 +0100
Message-ID: <20251223201921.1332786-4-robert.marko@sartura.hr>
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

Add binding documentation for Microchip LAN969x.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index c7d6cf96796c..5e5dec2f6564 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -20,6 +20,7 @@ properties:
       - const: atmel,sama5d2-flexcom
       - items:
           - enum:
+              - microchip,lan9691-flexcom
               - microchip,sam9x7-flexcom
               - microchip,sama7d65-flexcom
               - microchip,sama7g5-flexcom
-- 
2.52.0


