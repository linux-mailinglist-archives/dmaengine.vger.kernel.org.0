Return-Path: <dmaengine+bounces-5715-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4554AF6178
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 20:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8E717A492
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 18:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305A4315518;
	Wed,  2 Jul 2025 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Bn0x1cDx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450531550D
	for <dmaengine@vger.kernel.org>; Wed,  2 Jul 2025 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481562; cv=none; b=IkSk/rB377v6y+3cLuV7uR/OUY7FMdEmHWDq9cQ4MleTkHskqLCIBeWFUihMfIvUDvAsHXUIwCSpCXGqHVzt1X2FaYd5rPXL6OuEbfLvoYqeJn9yJj9uR3hk4DI3Vq9yfzGKSRh9PjOY+HzoyTJFZ7FJBa/tHBO+QVBhKY2bNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481562; c=relaxed/simple;
	bh=tW7URZQhTrd/hdL2o5zWTneayhc03kpXskiuPVh90E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGokmDVd9gXDiN2DhQtkKu/8Kzs0COpLfCd1+R6szrkH2mNdawza+v0aKBVwhYV6yHBUyBo/ALD0httd+kstS8Iy8Wo3v2coS4HM2GwRq6nAh0R7B4yVi9h648wjMadLGlbn4ZL8nSIq9A2kIGeqzArmn2TngkMOTSxLXyxztJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Bn0x1cDx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235d6de331fso62048785ad.3
        for <dmaengine@vger.kernel.org>; Wed, 02 Jul 2025 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481559; x=1752086359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q31LeQoPU5Tg6LIkWzfs/F/Xva89TsnkgnR1vxDISxQ=;
        b=Bn0x1cDxkzNZ3yMlNr80ct/PezqcXXpfItvYdING9ImrNE54igkwtZOReT7iHnHD/f
         85YLaxH2sDZffo3xGF82Vg4Y1CQFgw1q5iV9ZRiJxSxSrzINinChHg7f0XTzWVWrYCwR
         koohqbkRup3DfHZYQENTJtMIfTHwUnDhEswXqavLJt8ilt5d8G64skyehxlvpZCgqvVB
         TAX/RL/FRr/TQCE1m59oUxgmRrVZPHD2SHfIaFLm3G41GbqAoWMtq8l5VysU23eIjczv
         jdgfPNAbl7AmYQ/kwloBtR8ljEEnUMPDXNnBhTrC/HcQPYWAsoHOT3HBMvkoSR4JUBGc
         207Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481559; x=1752086359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q31LeQoPU5Tg6LIkWzfs/F/Xva89TsnkgnR1vxDISxQ=;
        b=C1e8qwByZbCXcibk2M0jFbckAwrt4Gb/IN9Ek7iV5W7Qlke/5YcQoGe//eJ2ARi8Ct
         aULwhhr89MSpWW5Njsz/WT65qdehfc2NtuE7G2iox9kwLzccH7L7P5Ce2//E8fgwjt1v
         Hx8MrGuTXqR5KCuZwfew3Evj8f98en3QnPY3wQWsb+HG9A79QX1AnnSvN5coQSjP5PHB
         t+4oyPF3TNBbIkgrDaqN2suosM0YybhZmw3VdrC724Tm0F7xlEYfq2cfr5e/jVAe9ncg
         +6WVdDv794KpxyU/9A4ZURP/9c6zv3tC6kB9YReT49QalOqTb2Pm9pJPffpNxxwzEQhm
         rd7g==
X-Forwarded-Encrypted: i=1; AJvYcCWfSNzK+SEoY6B1myCmsQwnZJfKZvgQrMVFKHFIeTtQoCN2ylEWvJS2XJhmY/AiKiuTUie6H5kDsOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwbXwbbM58dWYgBcGPLZdzmciEuY0f4cLSoMqfx+AM8nGK4oBs
	bQ2ggK5pa8mAZPocGRUOiWFiC5/1MexIQ3clZ8tuK6c6KazY2c5uGggg5ErEVzsBr6Y=
X-Gm-Gg: ASbGncvnudmgKvuUztBUyMi6qMymFvMCUafuiT+aiCfQ/FHiDkoR+Qu2fbLKIHhCwTi
	V8Yhm01TM1pBMBvHxYID2a3hrk+X6+hNOB/2+J5YuLily2xJQGpDICfFfQEH2tpRogZmYAWk9j+
	UY8q6ybBn5gTaxPTxOYi+1I3bI4/6jZNv+8MaF8Ipi2gRvk0Pusu9+Cdrwa0DAUSOdsVlIz5UDx
	HDP+NOc/1nsDj45wtaTbLW4pPc29BYIsj7/hqCgtuIJasWrCwE0q2dq124VPtTRf+IgWyTTFu8/
	smw3SYUW2WY8wyuF/npalzKp9/uCqpHfld71sORRQUWx7IIT+1Oc2fLb4dJPVv9+YhXXa6Cc7lO
	KB6li1rYQ2ST+e82hvRyTXbg=
X-Google-Smtp-Source: AGHT+IG8v0jcBzSkhpF+tlpiIqvrqXtsy8Ix2HiJIAVnZ48c1CRxrkpXzqoHja1AlwcLL8cW97LJSQ==
X-Received: by 2002:a17:903:f90:b0:235:ea29:28da with SMTP id d9443c01a7336-23c7963ede5mr5982695ad.17.1751481559247;
        Wed, 02 Jul 2025 11:39:19 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:18 -0700 (PDT)
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
Subject: [PATCH v8 01/10] arm64: Add config for Microchip SoC platforms
Date: Wed,  2 Jul 2025 20:35:59 +0200
Message-ID: <20250702183856.1727275-2-robert.marko@sartura.hr>
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

Currently, Microchip SparX-5 SoC is supported and it has its own symbol.

However, this means that new Microchip platforms that share drivers need
to constantly keep updating depends on various drivers.

So, to try and reduce this lets add ARCH_MICROCHIP symbol that drivers
could instead depend on.

LAN969x is being worked on and it will be added under ARCH_MICROCHIP.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/Kconfig.platforms | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fc353dab2cf6..f2d5d7af89bf 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -119,20 +119,6 @@ config ARCH_EXYNOS
 	help
 	  This enables support for ARMv8 based Samsung Exynos SoC family.
 
-config ARCH_SPARX5
-	bool "Microchip Sparx5 SoC family"
-	select PINCTRL
-	select DW_APB_TIMER_OF
-	help
-	  This enables support for the Microchip Sparx5 ARMv8-based
-	  SoC family of TSN-capable gigabit switches.
-
-	  The SparX-5 Ethernet switch family provides a rich set of
-	  switching features such as advanced TCAM-based VLAN and QoS
-	  processing enabling delivery of differentiated services, and
-	  security through TCAM-based frame processing using versatile
-	  content aware processor (VCAP).
-
 config ARCH_K3
 	bool "Texas Instruments Inc. K3 multicore SoC architecture"
 	select SOC_TI
@@ -174,6 +160,27 @@ config ARCH_MESON
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
 
+menuconfig ARCH_MICROCHIP
+	bool "Microchip SoC support"
+
+if ARCH_MICROCHIP
+
+config ARCH_SPARX5
+	bool "Microchip Sparx5 SoC family"
+	select PINCTRL
+	select DW_APB_TIMER_OF
+	help
+	  This enables support for the Microchip Sparx5 ARMv8-based
+	  SoC family of TSN-capable gigabit switches.
+
+	  The SparX-5 Ethernet switch family provides a rich set of
+	  switching features such as advanced TCAM-based VLAN and QoS
+	  processing enabling delivery of differentiated services, and
+	  security through TCAM-based frame processing using versatile
+	  content aware processor (VCAP).
+
+endif
+
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
 	select ARMADA_AP806_SYSCON
-- 
2.50.0


