Return-Path: <dmaengine+bounces-5714-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A18AF616E
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 20:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1CB07A38B8
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jul 2025 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57212E7BB1;
	Wed,  2 Jul 2025 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="rd1RwZ+5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29504248F54
	for <dmaengine@vger.kernel.org>; Wed,  2 Jul 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481554; cv=none; b=Z6KB5se+vZT02zeYTCit0uhFnIfj6qJeo9BxBZSsnmBZjioCN3+KYrvhhBBK6y2zwjeDDql70Gx3uZlHf0s5zGHCjqp53P+hY6JY/5LaNt2P27g+WMbxg27kLEHRsdUHki9TwKtl5rierVo6OPvmwF3jJlqS+rmeLKhDw36CCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481554; c=relaxed/simple;
	bh=xCRs4dzrc6WcXYmCwUPWRARDoPNR6pE48wQDzbnDrFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8ZvUOeGSKlwoXODe4JN1mRmPqEfSmklBCGHE7HdZZPO+yk1i47U6eh0P0zyFpMFCrOyyrDzzJlnXR8yr74CWnfqx+oGFPAbul1pCdtw6b6iLaxhDv2IqEs6dbH76NU/vs7wS2+3AgpqdE3Z81zW+j8LX3F1XtoprcAxpHLoVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=rd1RwZ+5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23c703c471dso2289005ad.0
        for <dmaengine@vger.kernel.org>; Wed, 02 Jul 2025 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481552; x=1752086352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0vokW/WVWIh/diYEqZYuuuvilgnskYyUw0dTfGNSpI=;
        b=rd1RwZ+5nubdEQxYyJFun87C00oSIIPar2SyPLa2/vR41WjfK5wDB9i1LDVOJDpgqF
         8mK9mxPgO5iLW9e81d87+vOykBOkJSpy5k4/eqbi8L6WlqU3ZpVUQToBsGfcbuVW53MR
         6m+g6CF3ijwp+YW7yc1A472ZsLTMAurLhw4fXlbLyrn3ZMKvAjlS3awXzBr9Y8qy+ys1
         J3mb8zyJv/tEcP1rp75BdLzpVC/urUFC6R2Wlgey/2IHxk2sarL33GYm5w55fyyzQbqO
         y2JPdIcPnxWB5UOYSMmDP0WDSsezjeOveo7nWLAxA1wJJ5JzuxQ81IQjOhix55O32dz6
         MXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481552; x=1752086352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0vokW/WVWIh/diYEqZYuuuvilgnskYyUw0dTfGNSpI=;
        b=dcKqtPCxgtj8ntwf0PNjqAZXjQPLohhnGjvaYZ6nj5Aq8eEbKb+a03YgYmInkOAvqZ
         ptAhDP0Pe46SROfJjXbrFgJFJIcJkvjL62PF6MOODHGAr2q6Yt+wMTDRgjecX2NyFRPz
         bLUG0uWDhTrTNlPRmD7TEgdeGjA7k6U0vHx46x930w0aQzOG7JUUeZWDk6mH4RzpXhSv
         t5uLvHr/9QgePTa2/aakkXaC4fUQa3Qkuua9zCoJEu9tmsM/zdcBH0LMu41SoVWh4XK8
         RvINZOSM1D2YRU+woVd3Euypg2NaNhfgwZxYcMmdPHuoi0YsgPYcqGQUadVWNz03Di3+
         pQyA==
X-Forwarded-Encrypted: i=1; AJvYcCUFpY6IFWfaVPHLHMooJPjavSKgZbOtrqlUb+fncvW8H8/jUJnqh2b6ByvrFicD+z4P1uVcFzLZzFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+ROpMXnLNArzIP60IOVizJbEmz6MT1uzDOiHwDG9riru8Lai
	4iEnUfVKxwWFOAb9UHN0c87wFZSUgSamCfpKYUA4D18pdpw0tQj/bNS4Vuxm3UzLExw=
X-Gm-Gg: ASbGncvM/Qnct7m2W1qYZrOuZ+1TJSOWrjluaDvMPmL3gT86s4ZQg1YViz2M24Cbfju
	HtnNLzrjIH+NlGiHGWmJGgJqbe6AQ/B1VNEOIYOVBzhW7oIA4JVDtagaEKgr6sRJg+DDNQGsDV6
	CJe8LpX7Yuqn5I8WMWK3yzn2+qAeoYuWAGLpNDQkWh7CqF8lZ58KIbg6UKaCuY7n83rbis4N9kJ
	11OhMPPD8qcj/CYsNfJrJOsP3y5UIVX+nC0984SLRceJjCAFaztJO4K0oyTl3GzuJu6T7B7zatE
	A2e/E+Hp8FUm59ov9gHxhmIp23q4Q8wIqX66vr1WJnAggEmH2qOAXOWn1DE6hlvWXdFU4HdMJqR
	j0E0lpjGOwvk22aThl1iC5ls=
X-Google-Smtp-Source: AGHT+IGquOgZW20g+Jug5sdpx4963ZXWIcFE/S5pAht3IG0Kq6KeWcjOPzHMuBzGwiWByDwygshOwQ==
X-Received: by 2002:a17:903:1105:b0:235:f059:17de with SMTP id d9443c01a7336-23c793f0bc4mr7420165ad.15.1751481552430;
        Wed, 02 Jul 2025 11:39:12 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:11 -0700 (PDT)
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
Subject: [PATCH v8 00/10] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Wed,  2 Jul 2025 20:35:58 +0200
Message-ID: <20250702183856.1727275-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds basic support for Microchip LAN969x SoC.

It introduces the SoC ARCH symbol itself under the ARCH_MICROCHIP symbol
which allows to avoid the need to change dependencies of the drivers that
are shared for Microchip SoC-s in the future.

DTS and further driver will be added in follow-up series.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Move to using ARCH_MICROCHIP as suggested by Arnd
* Dropped any review tags due to changes

Robert Marko (10):
  arm64: Add config for Microchip SoC platforms
  ARM: at91: select ARCH_MICROCHIP
  arm64: lan969x: Add support for Microchip LAN969x SoC
  mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
  tty: serial: atmel: make it selectable for ARCH_MICROCHIP
  spi: atmel: make it selectable for ARCH_MICROCHIP
  i2c: at91: make it selectable for ARCH_MICROCHIP
  dma: xdmac: make it selectable for ARCH_MICROCHIP
  char: hw_random: atmel: make it selectable for ARCH_MICROCHIP
  crypto: atmel-aes: make it selectable for ARCH_MICROCHIP

 arch/arm/mach-at91/Kconfig     |  4 +++
 arch/arm64/Kconfig.platforms   | 49 ++++++++++++++++++++++++----------
 drivers/char/hw_random/Kconfig |  2 +-
 drivers/crypto/Kconfig         |  2 +-
 drivers/dma/Kconfig            |  2 +-
 drivers/i2c/busses/Kconfig     |  2 +-
 drivers/mfd/Kconfig            |  2 +-
 drivers/spi/Kconfig            |  2 +-
 drivers/tty/serial/Kconfig     |  2 +-
 9 files changed, 46 insertions(+), 21 deletions(-)

-- 
2.50.0


