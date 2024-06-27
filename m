Return-Path: <dmaengine+bounces-2565-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5878691AA66
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 17:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0AFB27F89
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 15:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3BD1990C5;
	Thu, 27 Jun 2024 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="pgtTPqKB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CA198A19
	for <dmaengine@vger.kernel.org>; Thu, 27 Jun 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500683; cv=none; b=S6Y9a9Bcgo8fFdXAf1LfYgguj/Fytz5S0uzIafrRnPYdGkufJqzhKTgE1lK0acJCfPQN3zAr4864CulmbQYqTRgKYoGm8hgp/GziiNiJLLHzcVldqfw93zVxih+nXfNroYOff7nL1sP5A+70f/Qr9VrEToc2z6QlLVRLiCS1xCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500683; c=relaxed/simple;
	bh=p5CJPkIQTWB8uzvXru7xjOtLt2s3gbP3ldoTOznVVpY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=obYYKSP8eKG9N0ImEf8RF/6Qk99Rf9O7oyzaivmtLFsPZGPRbHvj/RRl6zy6xrJ9zfn1v+11gTnF5TyBFMvsm0z0VZIc+CgraSWYDLzyVbW4siLQMYT2kb64TJIuBB5M3Ic0/2TOcbSo6gl/moTqHi9Z6vlOG9N5IYPtL/+fCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=pgtTPqKB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a724a8097deso653700166b.1
        for <dmaengine@vger.kernel.org>; Thu, 27 Jun 2024 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719500680; x=1720105480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kKU0V25b+NdpL5Nxb/CadexmGEKpxevd8xM2vqH8ko=;
        b=pgtTPqKBeqD6a1UpnlxO0z3jWiOiuYCn15T9DVKP2CPCAVZWVuBAEaKpMzsJ/GuzNd
         22sTQeYKPXnLTG9Blg+5811wxPeq6nWxvHM3uIoT/JL1FqqPuBuL4Mwfpyxz4N3jUX8K
         m3gkq0Ac4J6ylj1DK/Xg2g0kSj5/sBrWTkcQ5MR9HnL7HdTTYNDtgmAlrknxuyopMNJI
         1SPhfK5FxURpLMkGivJ44ew5jC9hnR7+7RdzNyCiMWBg22dameouI+pXijFug+KxhpWb
         EDeeoHr44kzklZiopaIvs6zKeipltm6kdgnYA4N4vUVMh/fQF/sQnIdvsXExrgifjK3J
         ncyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719500680; x=1720105480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kKU0V25b+NdpL5Nxb/CadexmGEKpxevd8xM2vqH8ko=;
        b=QHDmRUShKYDBYLXkW7/v/ea+GKpqkV0y3SVGGQluBlwy+yo6HWp1vE3heu/0KtrG+6
         nSyGNdCOKBXyDkMaWBJGRpa4nFMlySD9/tZGmqAOfQxciSlB8pH8lgbCjv+GWVp8w+od
         bHd8RhGoxP9EAHNXLYFpitvw4EDnRZDmH9dDv3pbj1GappqWKNt9zFX4b/e7ppSMMnke
         MYVYbrW4Sy28pKmTMGc3HaKmfibisSvROWh/2onOD5maf46se/3aXiUvcl9KRM+g0thr
         Ojc8cZYtKPeZhIrIRvzAmqhLk9Hi/qArLHR2x9r05eDR3DG4XvwC1w+RmACO8ws2nxeU
         PLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiBp7Z+5B+nJOCc91gdu8l2qx+brKLvfwfg8hzfDaRpSm5jYC8/4MLVaZ0adnDRk45nC6GvW7VXlXCk/x6EuAlwTDFq4CNf1Cg
X-Gm-Message-State: AOJu0YwuwjQsHQX5EMdtD0Zn6TQlzMEItVXIgFQ/9/n7E0wpRzdo7Gai
	0aQ/KbHC8G8J+XAVhxRtHAbg7DUS+9JX2BEHYG6c8pSIz5yin/n0IqeN+4u0wqI=
X-Google-Smtp-Source: AGHT+IEDRv7diooeJV6LJXwf0EjCsVi9YKqxuCA0IYC1Rui0S1k3Zcq9kDuWbuWeuGO8t2Iv/ci0ng==
X-Received: by 2002:a17:906:d509:b0:a6f:5192:6f4d with SMTP id a640c23a62f3a-a7242c4dfd3mr693613366b.8.1719500679193;
        Thu, 27 Jun 2024 08:04:39 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7ca289sm67189066b.222.2024.06.27.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:04:38 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Chancel Liu <chancel.liu@nxp.com>,
	Corentin Labbe <clabbe@baylibre.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: [Patch v5 10/12] mtd: rawnand: lpx32xx: Request DMA channels using DT entries
Date: Thu, 27 Jun 2024 17:00:28 +0200
Message-Id: <20240627150046.258795-11-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
References: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move away from pl08x platform data towards device tree.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
Changes for v5:
- Added fallback dma channel request for backward compatibility with DMA with
  platform data instead DT

Changes for v4:
- This patch is new in v4

 drivers/mtd/nand/raw/lpc32xx_mlc.c | 26 +++++++++++++++-----------
 drivers/mtd/nand/raw/lpc32xx_slc.c | 26 +++++++++++++++-----------
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 677fcb03f9be..92cebe871bb4 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -574,18 +574,22 @@ static int lpc32xx_dma_setup(struct lpc32xx_nand_host *host)
 	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	dma_cap_mask_t mask;
 
-	if (!host->pdata || !host->pdata->dma_filter) {
-		dev_err(mtd->dev.parent, "no DMA platform data\n");
-		return -ENOENT;
-	}
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	host->dma_chan = dma_request_channel(mask, host->pdata->dma_filter,
-					     "nand-mlc");
+	host->dma_chan = dma_request_chan(mtd->dev.parent, "rx-tx");
 	if (!host->dma_chan) {
-		dev_err(mtd->dev.parent, "Failed to request DMA channel\n");
-		return -EBUSY;
+		/* fallback to request using platform data */
+		if (!host->pdata || !host->pdata->dma_filter) {
+			dev_err(mtd->dev.parent, "no DMA platform data\n");
+			return -ENOENT;
+		}
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		host->dma_chan = dma_request_channel(mask, host->pdata->dma_filter, "nand-mlc");
+
+		if (!host->dma_chan) {
+			dev_err(mtd->dev.parent, "Failed to request DMA channel\n");
+			return -EBUSY;
+		}
 	}
 
 	/*
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 1c5fa855b9f2..3b7e3d259785 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -721,18 +721,22 @@ static int lpc32xx_nand_dma_setup(struct lpc32xx_nand_host *host)
 	struct mtd_info *mtd = nand_to_mtd(&host->nand_chip);
 	dma_cap_mask_t mask;
 
-	if (!host->pdata || !host->pdata->dma_filter) {
-		dev_err(mtd->dev.parent, "no DMA platform data\n");
-		return -ENOENT;
-	}
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	host->dma_chan = dma_request_channel(mask, host->pdata->dma_filter,
-					     "nand-slc");
+	host->dma_chan = dma_request_chan(mtd->dev.parent, "rx-tx");
 	if (!host->dma_chan) {
-		dev_err(mtd->dev.parent, "Failed to request DMA channel\n");
-		return -EBUSY;
+		/* fallback to request using platform data */
+		if (!host->pdata || !host->pdata->dma_filter) {
+			dev_err(mtd->dev.parent, "no DMA platform data\n");
+			return -ENOENT;
+		}
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		host->dma_chan = dma_request_channel(mask, host->pdata->dma_filter, "nand-slc");
+
+		if (!host->dma_chan) {
+			dev_err(mtd->dev.parent, "Failed to request DMA channel\n");
+			return -EBUSY;
+		}
 	}
 
 	return 0;
-- 
2.25.1


