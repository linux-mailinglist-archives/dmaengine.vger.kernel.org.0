Return-Path: <dmaengine+bounces-7923-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD1ACDA9F2
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 509613005F24
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2491934EF0B;
	Tue, 23 Dec 2025 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="ZccbyyzW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B334EEEF
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521244; cv=none; b=PctwGLv0HCtwy+MAUnNmu559zbIsw7eypCm4s0Zy0DuGgd9GRN7UKRKSRi6Lig6qzonREiXiG5ZTMDJMDwAWi4u4f2+JYYZ8As717+QBDHwXfZrBwbSSCfHta2uwJPiyGUOgLR07p22UwRORWMiHuX3oZHCp1ycmuwXCkN+uPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521244; c=relaxed/simple;
	bh=FesjP41xiT0Kda2nCLhQhKtJNrqGgysPl3yJ23vj64A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjEb9pHkulLe//t/RZiJ+y+v8PDtFaiFHXM5UxcXCdS6OcKuSZLt9GmQDEbh1bkulZE8gz7z/TH0mm34lzSxl807JVSHQtFWWMKOag/uaiMdSA2GOpU5yD2vGoV4dZAFEZgez41DmYl8MueLzx9yg5pqawWRHRxeod4UYss0gy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=ZccbyyzW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so4802925b3a.0
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521241; x=1767126041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClyoGQdLbQ+NSakHU5SbIxGsiXAmeIUAvdUGZfMfHas=;
        b=ZccbyyzW2lxJMbJYlm/wBafWsE2XB2bAypOFFnOukvOGI4F8bnHvNijeGAjtavqUGB
         p0NANjErF7ofDVkrLy/JmBZttd7li18QNaynTXMtfLOpiv0nuWEKeVd6DYSHktO1ISNl
         6HyxFIVBPwLfGivhk+/vTFkVzBO162ZkHkA0Jkp141/OWZ4XiUFeOAFelEoZvX1rskGB
         Wmk7CX8M65WvlFHXo4cHRpqzkjaDkKV3yp4+zvmH9jj17QAzZ6OaiuFPVXcNUQshasmH
         a2wdlKOVQBgvLOgq5SEy9w7xvNTCfKQBAhS5xqnESy2htUeDknWhV2G8qFo/rgWWwYNn
         KE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521241; x=1767126041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClyoGQdLbQ+NSakHU5SbIxGsiXAmeIUAvdUGZfMfHas=;
        b=CyeCneTabfAhjlIiYeSwFAlmFDeT4egCCVHyfyA6ZFgdEdaXM2yTgUdN0PKwuQd0ON
         madjhQXLWgR1iaEoHXU511qBlz18T3JhdFSGqgBgcqMA629LXRHllAaxsqxqWNkM7laY
         6OOHp+KSqesRLUVymlL4muS+kCjaECY8Ck5XAE3U1j6Sx2WaEkjOVi9npAvlbgPrhxic
         jf9aFTojCYc1cezqrPY8cDkdnyp3V9gO0oH89mB7asTj8pX/++K9eMUreiBc/IIz6pJd
         T6VeWToU/xbJB4djovS5PyysI5XHMjpVCC7YuumUJennhvrvHgn7ZQZ8FpNRizfF8beF
         N2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXoN/tSNhpJmMPBznG7FhuWiUdXGRVXGCg6vZ86SoZc5+rSshRS6YJwdCd1rHEF0uDgVyGQ8G1OPnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKVhpwZwEMiP+J3Xiff5AiHD++HGdxUrJcYaPKlZ5oB8tDbhK
	Gc06LHCB8l949xxQtyA3w2xLlkhuLPLRgBhFZee1rigSlaZQwjnBH3KkzQnbpi6WoCA=
X-Gm-Gg: AY/fxX6GKoPEuieo9M4bzwikq30JdcQklKDSrPONqHhQnsIHoLSKy2Amq1itpAMqFuI
	q74Ikmhhcv25S/SwTK5IzdjMJrgnNLmRnYGwPeVUaWNM6/1QLH/PZPJTmplinD6drunoDMkUnYj
	IK75//1dA8t5g09ET2KTYkLx1M1phH/TcxplUZbF+Im8xFdg3ieYaTPVr9nTSuNq2UH5Iq8/6kS
	cXQ3cvrRb98QuoWKVsxqr50OrM+bL4ad4kGy3HgYV+LL/pzmBqIY/x3tWOboL6lanEED7ZOXMEN
	OrGjxq2WxBu2tEFzAb2za53hFoydqx43GhAB7wj1KWmRHXNEYk+OTcOXmm2RFzLTJUHwdqNxM4m
	ARC8xULpJNjltuu13W7Jf3PvNTMoF67yDO2Yi7V7hQMs7E37m+HMR8iq7fMJeWrPkbeh023gpZz
	gy+WJjEwfOsPVinjgFitNgvBTe9vI5Y2MuGc/uiGXHsFYZIc8BcwAn0VOclwKl5sABxozm5b4zG
	LkFU4dB
X-Google-Smtp-Source: AGHT+IGuoAHYa6yGZT2xpCk4O6bUCM8poDOiYCaAoun2Nvyagb0buXaCaJOvoitd+kEUFeEHxHKv2w==
X-Received: by 2002:a05:6a20:9185:b0:343:af1:9a57 with SMTP id adf61e73a8af0-376aa8e98d6mr14530108637.56.1766521241361;
        Tue, 23 Dec 2025 12:20:41 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:40 -0800 (PST)
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
Subject: [PATCH v3 07/15] dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
Date: Tue, 23 Dec 2025 21:16:18 +0100
Message-ID: <20251223201921.1332786-8-robert.marko@sartura.hr>
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

Document Microchip LAN9696X TRNG compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
index f78614100ea8..3628251b8c51 100644
--- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
@@ -19,6 +19,7 @@ properties:
           - microchip,sam9x60-trng
       - items:
           - enum:
+              - microchip,lan9691-trng
               - microchip,sama7g5-trng
           - const: atmel,at91sam9g45-trng
       - items:
-- 
2.52.0


