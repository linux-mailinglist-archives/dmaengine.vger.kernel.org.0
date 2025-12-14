Return-Path: <dmaengine+bounces-7613-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AACCBC17B
	for <lists+dmaengine@lfdr.de>; Sun, 14 Dec 2025 23:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D4F2301A71C
	for <lists+dmaengine@lfdr.de>; Sun, 14 Dec 2025 22:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AC52BDC0E;
	Sun, 14 Dec 2025 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq9TUJMP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F07265CA4
	for <dmaengine@vger.kernel.org>; Sun, 14 Dec 2025 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765752433; cv=none; b=TdyZQZuOMjAZFm3oR+E8CWCiuqkEevs0PFwtUrSHQ2IA0FU/cgtqExTmd+WK6JCWuKJKI7v0g4zc5sJdrIK5UKoCcNDA+Mz0KddFPhtp53p81IB1iqP1tuvyUE3D30NecLr0D2QzqZBAegzsmaJg3A9RhDxhWYRptcJd2JYyzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765752433; c=relaxed/simple;
	bh=akAwE7wcDd2SCjXGGhXqxByfTjxbJVFWLP9xLEGPGRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGa4Iczsr4yg+oAt4f3qOKrfvuyzmso4lc6Ptf7VFB1IvyJsbmTvq1bGys/y/uuOI5Hu1PtCENuCb/D8R04h+nkkr7HE8ue9TtVkMIuXklzvGCgALQoW+qWJbMxvo+SKe+jc9Cd3B6K0/Ex9H8iCoTKNJJCfyFHmY6rt30Laj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lq9TUJMP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0ac29fca1so7473315ad.2
        for <dmaengine@vger.kernel.org>; Sun, 14 Dec 2025 14:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765752431; x=1766357231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyPrePrVyIxKolVVQUdwjbRSU8L6ctwDY64qSpxJztc=;
        b=lq9TUJMPktWh/tomVqlPT/pHllAqjSg/V4/qrR0JPpcADriP0aknn+L2ODCqXc9aRp
         xqI8lmsG2Ffho7HyATH9pes1qwNMBF9rs6kkRfZvoBF0wehopkRDPXna/zkaymlzc7Hc
         Jhjdaafj3zy1wSjNh+rVHkZsG3wGTriAodlf/rBovav1zsHxTpx4gzvS4PqN4jH9QTfJ
         I0wlF3A8eS+EBf84I/5YRord1ai5CxNAK1N2kJvfFT0T/xHsLpjjgr3HZfkHNqTh8zA8
         rrBMdmMJJqyn1NfV5I3xm14w9VpVyur4FGNoQPLKCHro/B98XcMxkM7ApT1omRypy6Nj
         g9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765752431; x=1766357231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JyPrePrVyIxKolVVQUdwjbRSU8L6ctwDY64qSpxJztc=;
        b=wVeGk0ai6oQQiZr2fR4nPbDcTA5eTGNgUAauZ0IsEI9GoAEaq8QaeQCTjUiWuYafu7
         qAWtm+1QoZjJOeLWNT2C2Y3ET2a2BtfFBuVVOVQLdV/fE4JwigxMuZa3l4+pqnPFGd5W
         POlOiqewPtzSBGMqcFRvl66wuFssCnpOn0s3I8ZYpqWBe4LQs49CmiH1elG2l5J+5DB0
         Dkjg11BZssbCtOtyR3z56omhVA94a2ZP6Sp4+GgoafrlUPmx9lHwAAmQF9F/yjdetJ3k
         ZVzzMdSWa5gA0dXaDB/0MjQqdDWw/seYOwK1y/7ZJQL7u44+b/uhA8nyDrWDQEPYCmSo
         2cnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6U+llRzeU+8VTU8XPMi1bGya5pAyAq9bjNOBCzHLMDD7fdR3409ZYU6jaZe3Uc24ChtMlY8pEHio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLoohQPoeDJdtHZch0RZbZ5aMnEbbL0+edWwVRivDB/rLgjyV8
	E0TITh0VrjuHhvBpRMpYFGdQM2Tsh+W0L5+rwx4nNIZU0sl1Ziy/qOHe
X-Gm-Gg: AY/fxX6rmyfi9zV9KdO6qZ41Q/1HCD7bURxQTbBp4fPxdmjFYxzNM7biZMPORTohn02
	tNa/pGxtKj2G4ZnzjEfgCtMQnsyZFJYQPygBqU7rN8G5j3UOEcovPdGBYBFDj4RH4sc7H7lQ6WT
	a5LYy9/o5GqXyDD527FGrUJsQ/i7/7VvavTbohrCTLI3Kj4kaY8J6YQfdEn9Ds00eXXokXIvYfG
	veMj2JAusn8VutOxIUZGjmvrLmqenBmirsOI0gX+8LjsjqaeXS8mg9yO3QbrIHf5g2B90Hcpmxf
	0xx1c83UAqZ6/PlEGcM1+jgAtBpgSiiIqtnN2cbdcFxKoBBbABLi4kMCMh/z7uAqKynL+7jc8Ky
	9hy4VeK/F+0wkyhotnaRw9RPOFnTy/+7yUd2yyvnaclvzNbqjt7D4C0/sQ6ayyt/VV8Ug8ew7Fk
	/kLKqN8UEGRA==
X-Google-Smtp-Source: AGHT+IEU3uCYji7le46xC0e22HVzvq4FXx0kLGP2zcG2dgpXLhUjKAhMDK/pzyBxMtxqvDCTwIkxdQ==
X-Received: by 2002:a05:7022:e88e:b0:11b:af12:ba30 with SMTP id a92af1059eb24-11f34bde21bmr6149821c88.8.1765752431276;
        Sun, 14 Dec 2025 14:47:11 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb28dsm39517228c88.2.2025.12.14.14.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 14:47:11 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: "Anton D . Stavinskii" <stavinsky@gmail.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH v2 2/3] dmaengine: dw-axi-dmac: Add support for CV1800B DMA
Date: Mon, 15 Dec 2025 06:45:59 +0800
Message-ID: <20251214224601.598358-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251214224601.598358-1-inochiama@gmail.com>
References: <20251214224601.598358-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
the SoC provides a dma multiplexer to reuse the DMA channel. However,
the dma multiplexer also controls the DMA interrupt multiplexer, which
means that the dma multiplexer needs to know the channel number.

Allow the driver to use DMA phandle args as the channel number, so the
DMA multiplexer can route the DMA interrupt correctly.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 26 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..829aa6c05b5c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -7,6 +7,7 @@
  * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
  */
 
+#include "linux/stddef.h"
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -50,6 +51,7 @@
 #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
 #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
 #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
+#define AXI_DMA_FLAG_HANDSHAKE_AS_CHAN	BIT(3)
 
 static inline void
 axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
@@ -1360,16 +1362,27 @@ static int __maybe_unused axi_dma_runtime_resume(struct device *dev)
 static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
 					    struct of_dma *ofdma)
 {
+	unsigned int handshake = dma_spec->args[0];
 	struct dw_axi_dma *dw = ofdma->of_dma_data;
-	struct axi_dma_chan *chan;
+	struct axi_dma_chan *chan = NULL;
 	struct dma_chan *dchan;
 
-	dchan = dma_get_any_slave_channel(&dw->dma);
+	if (dw->hdata->use_handshake_as_channel_number) {
+		if (handshake >= dw->hdata->nr_channels)
+			return NULL;
+
+		chan = &dw->chan[handshake];
+		dchan = dma_get_slave_channel(&chan->vc.chan);
+	} else {
+		dchan = dma_get_any_slave_channel(&dw->dma);
+	}
+
 	if (!dchan)
 		return NULL;
 
-	chan = dchan_to_axi_dma_chan(dchan);
-	chan->hw_handshake_num = dma_spec->args[0];
+	if (!chan)
+		chan = dchan_to_axi_dma_chan(dchan);
+	chan->hw_handshake_num = handshake;
 	return dchan;
 }
 
@@ -1508,6 +1521,8 @@ static int dw_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	chip->dw->hdata->use_handshake_as_channel_number = !!(flags & AXI_DMA_FLAG_HANDSHAKE_AS_CHAN);
+
 	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
 
 	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
@@ -1663,6 +1678,9 @@ static const struct of_device_id dw_dma_of_id_table[] = {
 	}, {
 		.compatible = "intel,kmb-axi-dma",
 		.data = (void *)AXI_DMA_FLAG_HAS_APB_REGS,
+	}, {
+		.compatible = "sophgo,cv1800b-axi-dma",
+		.data = (void *)AXI_DMA_FLAG_HANDSHAKE_AS_CHAN,
 	}, {
 		.compatible = "starfive,jh7110-axi-dma",
 		.data = (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..67cc199e24d1 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -34,6 +34,7 @@ struct dw_axi_dma_hcfg {
 	bool	reg_map_8_channels;
 	bool	restrict_axi_burst_len;
 	bool	use_cfg2;
+	bool	use_handshake_as_channel_number;
 };
 
 struct axi_dma_chan {
-- 
2.52.0


