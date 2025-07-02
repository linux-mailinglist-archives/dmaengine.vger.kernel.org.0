Return-Path: <dmaengine+bounces-5717-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97688AF6182
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 20:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D8E4E22D2
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2C23196AD;
	Wed,  2 Jul 2025 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Iz6hrVm7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBEA3196D6
	for <dmaengine@vger.kernel.org>; Wed,  2 Jul 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481574; cv=none; b=P5fS/AR0DCQb9HlqE/FGzN501Ox02rPd42sp3nTPaVj02EPHVUIBKiaYnQzDX1XlJp93yCb7TXfVCHU8Ei9XvFyfe9akczCZZT77paAUPKFaqQnJOwDX27IBST+o3jbTkMgwECIw4kaG9+mqYzaQnz6QJBJgYM7M0AjjEe1byAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481574; c=relaxed/simple;
	bh=AC1ZGqepD8ba3vU9mbjs5GP1sS+hEoxO5U/tJ71XQ34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTXay82ITlycqvh0ObAkaRO7dfGKJ0uantG+4HRyXD4CqfO7zvbdz2V8W0/BHFJIdqP5l5repVw1ZauamcwnjcmzAwTmZA2ksKef5moKkHTgKbO3zyWpA10Ss5h57hSieWKK1O3pQz4YELXA2+sP0n60SlLH3LJVTQi0M9PfuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Iz6hrVm7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2366e5e4dbaso1438765ad.1
        for <dmaengine@vger.kernel.org>; Wed, 02 Jul 2025 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481573; x=1752086373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvUZO7FvlWPW+SQ9YyArMTwQthW4Z2c8jZOVUNIjFN4=;
        b=Iz6hrVm7SFHDkNjapMU+73vWNMofHdkdJj/sac4I0iSABrshZYejXx7utVEKFAKh4i
         z9h+1ruz8HXmfCjyar+wP3Hbdaterm2s6cj/2cTU243YooXcUaHKKXA0ZoAGizfdTkgB
         ZFPwykC038hJhLRviJjhCHyZ1xqpOO7x76jDdNrNX4mSf1JMhc/x0iQ7xQm2b3MqOR5x
         Bftp4lE6DX0BP9ouVdYAU4WuAxnQuQxFN8AyAjl/jDLPGrXzUji4rPhajPWPa/Bo/3/l
         MEPXOxuPkkZbUbFm6f2AOUyOLyO+k+dktFZoVeCw1NfS7qTJ/+LgEGjIVtT/dhWFC+t5
         gbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481573; x=1752086373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvUZO7FvlWPW+SQ9YyArMTwQthW4Z2c8jZOVUNIjFN4=;
        b=P4Q1vHRyWRQHrUFA/gDqztcbyzUdhW7ajlNMpG/cYfrIQf/YxdP9af4cptxCx2O4cQ
         bTSfFwsw0pyyQVSMXJ8OYldTIIvnlgiorAjKDSwHabvpeZA7aOR8ErLD+0NG+YLN1kdx
         yyJkpgFKn2N5af+50ebsVzalSlAhxM388c6cIUtDFInQZQCrGSm6D0zUs41CkVSNBhXX
         rdr6HgiuSLgAYgAIfqu62kC9LmWaxSCA+ZVaXE4XsseP5+tgQl77mTpuVGzrDPnlDyTb
         WlwVGAQSEsoI0bRsR/q9Xmj+8NZOCNel63yuSMx5EdoJ4798AS+cBjZhsZUcx88ZYlj8
         31gg==
X-Forwarded-Encrypted: i=1; AJvYcCV370ZcPQCAAZV6M2oGHNbs9FUrWMvKiQV3+d0lkvjlcsC1RUkQBdYjylozqaVNMOohgOGeIYkSvh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxprDJCfPAQjgek//6iKQAoDfXNrsQhE1Tor5y47NzoWUZA4thh
	OJQ3oadbSGpZ0ROpQ6mnHSvlw+r8AHnTrqzl3quzmQEWim0DBaNsoFVPe1qE6IXiz7U=
X-Gm-Gg: ASbGncv0PLCxoLGaA+7qFpVBeS83zZAt5Wobz/sg9dVkMdoGFkG5FrpFRM2UGSPO6FO
	JWe36HFesAPIs2VuTTcedEaUYykRtwE9W1Gi+T1OcpP5430027tCt64TWAK1oj6p0gaQXkSAcb2
	oNcZPkxuwlSaCUO12l/fHm5+YuZOe4f9LLcPrBg/b7P98gmzHJuPRrP2WBrRvqnqUNQdvRf77gN
	urz21YNgWft+naZkGRv1MUHtIlkqUZvJd+XSSjiX9nJvAUhr3Gh9M9KMW8aTVxqz+hVKmkzacDr
	L4n/IVF1q38jOlQthW05MULF7kf2HVm/VbvUM6tvntOSteEhiPx1kKzj6rG3Fn0RG+eUrvZlhvI
	7oFNzz64Bi1ISbPNDoIvSZJo=
X-Google-Smtp-Source: AGHT+IHgAEOa6mf+31gGe4dh9PyI8zLR+UZCgE3uY8g7x79OUwcJ315/76XmuML+S/JTyWRQqdR46Q==
X-Received: by 2002:a17:902:f68b:b0:234:adce:3eb8 with SMTP id d9443c01a7336-23c793c0f84mr9871445ad.12.1751481572766;
        Wed, 02 Jul 2025 11:39:32 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:32 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 03/10] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Wed,  2 Jul 2025 20:36:01 +0200
Message-ID: <20250702183856.1727275-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702183856.1727275-1-robert.marko@sartura.hr>
References: <20250702183856.1727275-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the Microchip LAN969x ARMv8-based SoC switch family.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Place LAN969x under ARCH_MICROCHIP as suggested by Arnd and drop review
tags due to this

 arch/arm64/Kconfig.platforms | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index f2d5d7af89bf..083e9815259c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -165,6 +165,20 @@ menuconfig ARCH_MICROCHIP
 
 if ARCH_MICROCHIP
 
+config ARCH_LAN969X
+	bool "Microchip LAN969X SoC family"
+	select PINCTRL
+	select DW_APB_TIMER_OF
+	help
+	  This enables support for the Microchip LAN969X ARMv8-based
+	  SoC family of TSN-capable gigabit switches.
+
+	  The LAN969X Ethernet switch family provides a rich set of
+	  switching features such as advanced TCAM-based VLAN and QoS
+	  processing enabling delivery of differentiated services, and
+	  security through TCAM-based frame processing using versatile
+	  content aware processor (VCAP).
+
 config ARCH_SPARX5
 	bool "Microchip Sparx5 SoC family"
 	select PINCTRL
-- 
2.50.0


