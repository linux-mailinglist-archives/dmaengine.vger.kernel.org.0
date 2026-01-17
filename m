Return-Path: <dmaengine+bounces-8322-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FEFD391B6
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jan 2026 00:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA5303003877
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 23:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C432DCC1F;
	Sat, 17 Jan 2026 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWWjZCoz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7521DB13A
	for <dmaengine@vger.kernel.org>; Sat, 17 Jan 2026 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768693177; cv=none; b=NKhZhH8TA4k8768LJ+emiZByHJYcst9Aq3NgDAU+gpA61N6lh5JFcEv3D41mYbEDknKHqtF/AQsm93CY1jkBzhYEgmgvJfsXyQDRWQaQ4aKS786n1FF+/IbtufbZ8ad9JaWiJYvjg2vjd2zfz8jN7H63Vvohuga4v/fpESMKbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768693177; c=relaxed/simple;
	bh=uFxpvwi5WIS01iDWVBv9fzd7rIhy6Z+OnDWqhQCjr/0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RRchK4grNwqhFznH9XC+lPcyriVE4A74ncgRZ7URaQyzP6lzR7Z/MIsr8DMbVpYaSe+UNGJ+KUo4f2hNkxzbNdWGdfG0YNW7VIgATEn4j3GEF9bPx+Qq95c+SCBWtNr6oWqjufVlg7tevJplf4BNhVNLFDYee21L38Mpz+h1xiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWWjZCoz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a09d981507so23077235ad.1
        for <dmaengine@vger.kernel.org>; Sat, 17 Jan 2026 15:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768693175; x=1769297975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zzuKtZVwPzoPi8a8zv97UqWKB+hwHmdg0yPtGr8XvwQ=;
        b=iWWjZCozieQOw06u5sVMoUYlc9LOhm4gsyw9ZvqgIl2a9HPpvuu7W4u3o72fpc7CPg
         o6elZxE+iilTtG5CIlmE6vrJzO7g5QAI/Sco7LU+UILmaWvHkJTTrw4VC1p5eYLIxITI
         IzLz/vveeP/tv30P6G1I4dBJkKAWIvquX5ddyCdbGj++E1s26x3D5h1N7uDe74ip3MVE
         hYKeOW+4TCz0V6oy+vnd4pp59VF0Ctg49FmporBvqPhAsPqunzy+JterlCUXahspdNby
         NENFO5jYqA3z/SyRHX7QIRw6ZSZG25PGuyL+6Ys4ZBiOXrnvxfGD9nNcv8EUvAJ6SuPx
         H2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768693175; x=1769297975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzuKtZVwPzoPi8a8zv97UqWKB+hwHmdg0yPtGr8XvwQ=;
        b=sZPAfFGXSt7cJ6751Awu38VOaNcqZiYfXYELesyctQYqIYBVmyi1NKNZXJgq1PQViL
         geSIN+OaJunVnH5pQ31QTbzie+VCdAgvXcjAPYXqoA4z10rjUbqIjuzwN5hiz6LL2UY8
         HB8OvHojH70DIvU5M7mNjMUzH9P40MfN3B7eXwXUX9oRwEBQNdROLYB8WP5Sm5fPjRTQ
         clbiI3ThaZYizTITDQ869SQNZLyvCQvORnvi8Q+fcdwTNETDjOiIRNbxc1+YasvMd5P+
         EYo+qP8RxtUi55LZk9eM/0ABGZX0uJvqmxaIU6xD5ub5nP9+gRbbHU32htssoSBh6kvD
         V0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCX4LxSX/wswHB8R3SedQ/gnK004SBd61EqbQ0BYc2k8LK6k0WPTLzvt+v/I+93wd47WmbcK5pogXrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLBRuK2L1jRr16+dEiNAB41PjmCvt40rMV3XwY6Y9BW26YmxxU
	DCRgxQmDpZzBWAujb4ORtP/j5cHJw6uG3j0zm2BqYi6N53x64MQuebang1x3JYJk
X-Gm-Gg: AY/fxX4w39YeIQNxjVxZkAYG8TmehibRMEbSq5sWcffx0qd40XfnVh0TWuh6+VqkGBb
	rmPLpK4md2eUThyL80BPwe8fTgQ9ItOTGweYy8iJTSbv7sDonk+GpbLrqaIZJW+YzGgTQQAbbFF
	IWdkqC85j1RYblp5QBJtLt0bjIU3ofcpg9Io5JMJxyk3dED5aJlfDG6gnjaiDgljP7zpLQbw3DN
	HP24B+43F4z0jEZXt2Ti/85VzLBZ+tBbTcFb+11Y70RaQqWSulbu97ccLSQMSZoqzbv6R3VwvJJ
	OzxMrugmYA9tCw8c16BLaTkTrbrC428iGlPZOn9VyEQb0WMpZ5buIha6cV9GETWz3clryYk7iBC
	D+QwWcv/P+UwEmcJOado9CvY2le8kBGAs/Fxcb8/MwOx4ld4U7Ya+zHSe2C4AdNEBC13IIpjtML
	2JP0BJo++eIQdrwLmZczD40mPEWqwKMap85/E=
X-Received: by 2002:a17:903:244d:b0:2a0:971b:151 with SMTP id d9443c01a7336-2a71754641cmr79563415ad.2.1768693175379;
        Sat, 17 Jan 2026 15:39:35 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291facsm5299460b3a.57.2026.01.17.15.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 15:39:34 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v2] dmaengine: dw-axi-dmac: fix alignment, blank line and non-useful return warning
Date: Sun, 18 Jan 2026 07:39:30 +0800
Message-ID: <20260117233930.9665-1-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the scripts/checkpatch.pl warning in
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:345
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:356
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:422
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:494
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:597
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1167
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1456
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1650

Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
Changes in v2:
	- rebase on top of 3c8a86ed002a "dmaengine: xilinx: xdma: use
	  sg_nents_for_dma() helper"
	- refactor the commit title

Reference to v1:
https://lore.kernel.org/all/20260104093529.40913-1-karom.9560@gmail.com/
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 493c2a32b0fe..c124ac6c8df6 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -342,8 +342,8 @@ static void axi_desc_put(struct axi_dma_desc *desc)
 	kfree(desc);
 	atomic_sub(descs_put, &chan->descs_allocated);
 	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
-		axi_chan_name(chan), descs_put,
-		atomic_read(&chan->descs_allocated));
+		 axi_chan_name(chan), descs_put,
+		 atomic_read(&chan->descs_allocated));
 }
 
 static void vchan_desc_put(struct virt_dma_desc *vdesc)
@@ -353,7 +353,7 @@ static void vchan_desc_put(struct virt_dma_desc *vdesc)
 
 static enum dma_status
 dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
-		  struct dma_tx_state *txstate)
+		   struct dma_tx_state *txstate)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	struct virt_dma_desc *vdesc;
@@ -419,6 +419,7 @@ static void dw_axi_dma_set_byte_halfword(struct axi_dma_chan *chan, bool set)
 
 	iowrite32(val, chan->chip->apb_regs + offset);
 }
+
 /* Called in chan locked context */
 static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 				      struct axi_dma_desc *first)
@@ -491,7 +492,7 @@ static void axi_chan_start_first_queued(struct axi_dma_chan *chan)
 
 	desc = vd_to_axi_desc(vd);
 	dev_vdbg(chan2dev(chan), "%s: started %u\n", axi_chan_name(chan),
-		vd->tx.cookie);
+		 vd->tx.cookie);
 	axi_chan_block_xfer_start(chan, desc);
 }
 
@@ -592,8 +593,6 @@ static void dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool set)
 			(chan->id * DMA_APB_HS_SEL_BIT_SIZE));
 	reg_value |= (val << (chan->id * DMA_APB_HS_SEL_BIT_SIZE));
 	lo_hi_writeq(reg_value, chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
-
-	return;
 }
 
 /*
@@ -1162,7 +1161,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 		axi_chan_irq_clear(chan, status);
 
 		dev_vdbg(chip->dev, "%s %u IRQ status: 0x%08x\n",
-			axi_chan_name(chan), i, status);
+			 axi_chan_name(chan), i, status);
 
 		if (status & DWAXIDMAC_IRQ_ALL_ERR)
 			axi_chan_handle_err(chan, status);
@@ -1451,7 +1450,7 @@ static int axi_req_irqs(struct platform_device *pdev, struct axi_dma_chip *chip)
 		if (chip->irq[i] < 0)
 			return chip->irq[i];
 		ret = devm_request_irq(chip->dev, chip->irq[i], dw_axi_dma_interrupt,
-				IRQF_SHARED, KBUILD_MODNAME, chip);
+				       IRQF_SHARED, KBUILD_MODNAME, chip);
 		if (ret < 0)
 			return ret;
 	}
@@ -1645,7 +1644,7 @@ static void dw_remove(struct platform_device *pdev)
 	of_dma_controller_free(chip->dev->of_node);
 
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
-			vc.chan.device_node) {
+				 vc.chan.device_node) {
 		list_del(&chan->vc.chan.device_node);
 		tasklet_kill(&chan->vc.task);
 	}
-- 
2.43.0


