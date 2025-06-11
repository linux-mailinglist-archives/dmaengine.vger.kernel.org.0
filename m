Return-Path: <dmaengine+bounces-5361-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6188AD5655
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8466A3A81D1
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31192836A3;
	Wed, 11 Jun 2025 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="QbPMM9gW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC4927E7C6
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646866; cv=none; b=rxRHAEnqcIzKY2zlqbNcqxn/BbCGwRQUcmuz7QOPACMGKCCspiO9IhBBKcxTgBV6hAIVIKEDkr5KRemWPQs5HAgBqBsly9bfsnDu8567WplaDmnbkmFSytLsslyLSkO/nsgVufItaveS5p+2a88o1K1h1LTlWK0R3Elpof3kLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646866; c=relaxed/simple;
	bh=OUo46ask5zEdNnxgtDRLYOxKjqeZYpKbIvKQrOHiQr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCEqdGx7kcYjVM8SRTDeI6P6dnWTi4qEJe2As7BCpWNm8XOSf4oDBl1PTF1nnZJBKFM57NcQnYcCBfZlG71vlufDi91JCxsUeTuRoSiHcxozit1dR4SNkp2Q9SUgv96k6aBq1RNVX6p6roPoXtDkoUByRdW50Lztukz3PpuAick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=QbPMM9gW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2363616a1a6so18970125ad.3
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749646864; x=1750251664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSKx+jiwSQ8DJGzzvr3skZPVBhTTim+uSj665SiqoD0=;
        b=QbPMM9gWoczJsDC0oLzWD3iFJK53GT6JRMtpLCBIDg+Ub+xFO9Jif9egm9lljW8vtR
         rWcjApI4GscBPCBAOcRJ8G2HP0YMlc5tCZ6RBzf/SD7XRdiwQbiaGNdX+vNcUv+UwVYM
         nnbFUE0yK8TjEh4/8+HlIDZjs+XVJsdOvYOf/JlO2Dk0aYZhUDpcia3u8+eUcNyubEdQ
         lNLHYmg5zsXzQh7NeJS1MBPhJIJHuasHIiVBTxN2mzoImm4t6Mm0GAF6qFsdN4FCk5gl
         KsMp1SOndgeKTghBNQKTTh0fiWiJcgFdkfekkyzZXiVZUP8gqbFJ4DWOvzhTx7IrVjRZ
         HRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646864; x=1750251664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSKx+jiwSQ8DJGzzvr3skZPVBhTTim+uSj665SiqoD0=;
        b=fnlDtJMfMLRZ33msPdtQ8nsviRBnK7gNc2fFbRw5dcQqKnpc6u/39z2mOOo0BnSyVp
         jnX2KMcrJiWe827dsH+7Fgm7fQHylaC5wtJHE0VQy4j0PGYc5XpTGPDtgcjLyEbQSjjo
         P2UUu3AN1ccKt4x4w7L3kwcBlZfoHIzKKLewZSMNmTmYAsDRms0MZyXNa+XRiMMNPlWB
         nXPdJX6d74pdODqIpLUNqTqUsfFR/EqEg7IFZU5S9p+KthhVwCywsrWEpXfsKPIn74Yk
         A5jmKQp9ot24SDPtv6l0XK1BTIcNSI6IJa030gMiFtj1BRfgxZ/4kWFuwEPiE6+LE1XR
         AiIw==
X-Forwarded-Encrypted: i=1; AJvYcCW1i3yCjQ7xLrN+EK4uqnLXhDAurOI4pOR+YDHdMXij8D0XbfkM/fzLAr7bdY8DuEUrXhQSpRapMxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF/56EvBsYZ+NYO+Sk7F0NP97M8ukih8x1XQ1LYHKy1KiqEKMW
	Ne6kw3p6WZw19O5f3vCnB2ZNlW6aVPj3xFQRfeAW4j4r4LQ9vmLBTWg6ADlipWhMwzs=
X-Gm-Gg: ASbGnctpSvypWYiBCj/SLzahFskUW0OUeuuGdSI0MSce5F9PdeRXqsrT2wpQC19afiN
	wAUMm/NNWhx3FndxULl4rKRj8qpIGQC5JHXOI6vvGdIbRn1FbYU/ztRsSQUxPhv+rlUK5xy3+M2
	uxthTHFdbtutFVUmgMZk37MznO6Mf3TnlHPeCeorRFJuRsy62a05sI3WH5x+xirl4AIwBVE9Uke
	zH+EA2cTc5quDgKl7URDF5R2gtM0nPXyy1WGbIG8D3sFmIyzftzqgJs3dTUmoiaD6TqnId/SRGz
	dwKghJ5jOVwbD9MQMITEJVMOYOn2qEeSvE7EFBDhQ3LwQ7DAlvBkDHoEPOuFJYmU4kGl/Nhle3a
	Brn7UQ1H2/GYxmT3unjLlieZNl1Vb9bC2
X-Google-Smtp-Source: AGHT+IHRhbcivXCxN135O16ueeb4/aUJWfnS89ixSiurI5FZ7uV83frEUoZkuyXDNWNmUKyh7r0P9A==
X-Received: by 2002:a17:902:c94d:b0:234:8c52:1f9b with SMTP id d9443c01a7336-23641b1553emr48488375ad.43.1749646862200;
        Wed, 11 Jun 2025 06:01:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:31a4:6520:3d67:ceb1:7c60:9098])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030925e3sm86984115ad.53.2025.06.11.06.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:01:01 -0700 (PDT)
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
Subject: [PATCH 8/8] riscv: defconfig: Enable MMP_PDMA support for SpacemiT K1 SoC
Date: Wed, 11 Jun 2025 20:57:23 +0800
Message-ID: <20250611125723.181711-9-guodong@riscstar.com>
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

Enable CONFIG_MMP_PDMA in the riscv defconfig for SpacemiT K1 SoC boards
like the BananaPI-F3 (BPI-F3) and the Sipeed LicheePi 3A.

According to make savedefconfig, the position of CONFIG_DWMAC_THEAD=m
should be in another place. It was updated in this patch.

CONFIG_DWMAC_THEAD was initially introduced into riscv defconfig in
commit 0207244ea0e7 ("riscv: defconfig: enable pinctrl and dwmac support
for TH1520")

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 arch/riscv/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 517cc4c99efc..83d0366194ba 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -134,6 +134,7 @@ CONFIG_MACB=y
 CONFIG_E1000E=y
 CONFIG_R8169=y
 CONFIG_STMMAC_ETH=m
+CONFIG_DWMAC_THEAD=m
 CONFIG_MICREL_PHY=y
 CONFIG_MICROSEMI_PHY=y
 CONFIG_MOTORCOMM_PHY=y
@@ -240,7 +241,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
-CONFIG_DWMAC_THEAD=m
+CONFIG_MMP_PDMA=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
-- 
2.43.0


