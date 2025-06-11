Return-Path: <dmaengine+bounces-5360-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3554AD5656
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E391E1266
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF428314E;
	Wed, 11 Jun 2025 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="eS4L6Oud"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88F283FEB
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646851; cv=none; b=O3jl8UhidKuTicrnKFXD0qZHXL6wIvdBdBdKMDQ9izv2jxZ3k4TvN2144B3UJzhQhMyi5Xqzgsn4VCKjX5X90CV9tbby7fXjSBtVXxg/aYm0siJPwY0oAU15NNKtY1rtB+Rg4bql3sRnh7pKOYoX6+iWmX4cS3bgNegpTakOTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646851; c=relaxed/simple;
	bh=BsrvoibobNdRj5bx2FV7FFPriwpl6oIPTWKF+TJb8js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUMcaaFjtX8Mmrr+iKAAtufvFhyLibefHuPM8zkKd7BWdnoatjc9Uepdy+sA8pNq46n3HJVQ/k5oGB42EbFZaFac3VDAkKnsLffeCCw6b6+kaLHSRKKGK9pTxSr9/qkOXAIy/+HVVFY1NC5UhzoRiHY7jcAapzx6FNks4rJHirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=eS4L6Oud; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234f17910d8so64285745ad.3
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749646849; x=1750251649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3Hj23NsfOD62jCqYZdTyo05Iy3n4LV0OoIjBt95NQs=;
        b=eS4L6Oud2XZqymAcK9cWsBA58MUdJwHnOAKjUBMAHBedEb/rJsHMyAqwAfCZYxGCbw
         ohON8Qudxhb4TmZVqYjp6hjl7GBOvILNAq1kOgSpMPlubG9zbr466afYz0IVzV6vb3Ge
         Nc5deyJkuuARgIuoOlErfV9TSAxQ/sBfLJHVcF3G9GmaP+egEhtPEe3BDj6MaejoCTbI
         DU26bIZ05CwEU6XjocTZgjGP8by9JeSWbOHsgMA9j3WbXPKoqi5WGWhtxoP+tjhDOk5u
         cX31cpD3oHAbSqq2aR7gCB4Vk7G2YEJ6w1LtmC/Kxf10QFv2a5QvF/l/6HsNKxrCyB8+
         kgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646849; x=1750251649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3Hj23NsfOD62jCqYZdTyo05Iy3n4LV0OoIjBt95NQs=;
        b=p7QQEe4D9kBrzPlBjG4pu9dKhs+DpepEW6AMCP+COGU9e6zOag4eOQFQhsTfLM4LVK
         /CigTMD1OtNA+hufkiuCb/hlpnSVzIUfG35YYY/fQbINbI4RXBJLS40Ry8MEzuevYS4J
         SQ3ZJcZC43dL9O+3XYkAvqAnojfxHYPfXoAzsyJlgqLZayRq3TOauD1ne+ThU9tyE6hM
         xNkulWifRm9tFQ5nXSNuDpmc4SnmP3C0b3Pqrut5VaeKRQc30KgATMAm1TnfK4TfP5n2
         9ed68TUemM/WAe4V7Cqw9mVfybVWpjMarVOfusZVWS+Eb8MQuL8Fg+yswujUhd7XSswm
         wVsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1n5LVDv/jmcSrtYEfJChB7HNdsSV0NFW6J1oJzeJPdq9P0RMvKU+pXydWhnAvv9flAvzwvZJ2pqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfEMb60n4qKN7IYsBmhchOv80y5FEGr+Jz61exx3fKc4JSYVy
	X8NSfgROtOpUrpw37RCN/XEZRirwQTz0vz63LrKS5VhL2X5WNkv0OVVj642NyHHuVY8=
X-Gm-Gg: ASbGncsFRDnB27S2q5cd80PEysGPzmaPwBCPaNpxcsBvzzV6sYKjcMMpbJ66SKq2yXk
	2h32N403tAteYg5s6XDU39gCYO3LINHfk+npEcG9Yp6iZgGDsd4ixHJK5DN7Y+CB6aMvzqG+Wkp
	5ihJMlI5pVJEHOKM8G2d7hvc4ui8kZ9Fd2qTGSLgSxk/CogSc8mEZPgJxEl4J1ReZGa4i0DMWcc
	CTEo5I6yfWDPPGCyG2WchZ9xIxJygfSiwR8ieXml5bCix44qEZEojE1e/kqS7i4kWzkgjGRS2iP
	ZOF2YCMehEfPaR7I+qHsF/sx9tqu9xhC+opqflsGj59gHIbOklf2+itm9l3GRujPNnnRPD5kZ/Q
	zj7KckOcPTXCFgnEXqmhSxQ==
X-Google-Smtp-Source: AGHT+IHVBo9LkzNee2JKYrKdwtZHZLkreGBOXP7vX/U81FjBHvUbwcdU17sovy3MyAgANjjIbprzmQ==
X-Received: by 2002:a17:902:fc85:b0:234:d1f2:da31 with SMTP id d9443c01a7336-2364260d38amr40073705ad.2.1749646848615;
        Wed, 11 Jun 2025 06:00:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:31a4:6520:3d67:ceb1:7c60:9098])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030925e3sm86984115ad.53.2025.06.11.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:00:48 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	emil.renner.berthing@canonical.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	joel@jms.id.au,
	duje.mihanovic@skole.hr
Cc: guodong@riscstar.com,
	elder@riscstar.com,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH 7/8] dma: Kconfig: MMP_PDMA: Add support for ARCH_SPACEMIT
Date: Wed, 11 Jun 2025 20:57:22 +0800
Message-ID: <20250611125723.181711-8-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611125723.181711-1-guodong@riscstar.com>
References: <20250611125723.181711-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the MMP_PDMA driver to support the SpacemiT architecture
by adding ARCH_SPACEMIT as a dependency in Kconfig.

This allows the driver to be built for SpacemiT-based platforms
alongside existing ARCH_MMP and ARCH_PXA architectures.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index db87dd2a07f7..fff70f66c773 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -451,7 +451,7 @@ config MILBEAUT_XDMAC
 
 config MMP_PDMA
 	tristate "MMP PDMA support"
-	depends on ARCH_MMP || ARCH_PXA || COMPILE_TEST
+	depends on ARCH_MMP || ARCH_PXA || ARCH_SPACEMIT || COMPILE_TEST
 	select DMA_ENGINE
 	help
 	  Support the MMP PDMA engine for PXA and MMP platform.
-- 
2.43.0


