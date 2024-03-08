Return-Path: <dmaengine+bounces-1321-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F75D876C23
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 22:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0403B1F21C35
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF135FBB3;
	Fri,  8 Mar 2024 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fHPAY1k5"
X-Original-To: dmaengine@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB15E3A5
	for <dmaengine@vger.kernel.org>; Fri,  8 Mar 2024 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931646; cv=none; b=k5vyeFKgWH8V4/LLEfotYa0kJhHm/FMNJPISSGht2yIEEcHDVmriPqkbTQc2UE2cZVBxOHnlNm8Hdc8b/ojaqHM8p0/OVZkXzTwMza4/IAI5T4EFe/umrGEQTcBOeFza8BKB7NsdtbVK9AAqoPFTW9iPkgOszd5YvEVE+wZg+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931646; c=relaxed/simple;
	bh=h3ZwvO18NqzlYxQLvrQ+ixy5YP9uezWH5/IU5Z2QUJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISWsniMG87rcEGGE3CQAyXOtRb7YtTcc7Xn3vc1WxwpTP70BM37s05ALp4MRtgPO3Ib3hsneihJC4KIk1v/DUfqY6v+YV4JPEKrXsdrpxXkcXaUXkrf3kUS/mv+9sPpNPBs2jCaGhv0/kccsCBTL0JKA0S7pJ34HDUbuTJBz3uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fHPAY1k5; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709931643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ucTS9a0V+bG0ban2Mlf24ZePa15zebSakjUo97bJDM=;
	b=fHPAY1k5DxR4UlbR9W2J4KQi1tb2ggwkCtCcDAhfYJ/njlbkCp5JfxueFctt5mztZc0oO9
	1xgmywoHsxosTSN84IozbPv3HCnrdlzHmLUlHYvX+KiGzJOnExfFqYPGzoNjhriiSKKMAl
	YOAKPo0b8IgCpkchLLdk2rR7XVFvrL8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/3] dma: xilinx_dpdma: Remove unnecessary use of irqsave/restore
Date: Fri,  8 Mar 2024 16:00:33 -0500
Message-Id: <20240308210034.3634938-3-sean.anderson@linux.dev>
In-Reply-To: <20240308210034.3634938-1-sean.anderson@linux.dev>
References: <20240308210034.3634938-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

xilinx_dpdma_chan_done_irq and xilinx_dpdma_chan_vsync_irq are always
called with IRQs disabled from xilinx_dpdma_irq_handler. Therefore we
don't need to save/restore the IRQ flags.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/dma/xilinx/xilinx_dpdma.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index eb0637d90342..36bd4825d389 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1043,9 +1043,8 @@ static int xilinx_dpdma_chan_stop(struct xilinx_dpdma_chan *chan)
 static void xilinx_dpdma_chan_done_irq(struct xilinx_dpdma_chan *chan)
 {
 	struct xilinx_dpdma_tx_desc *active;
-	unsigned long flags;
 
-	spin_lock_irqsave(&chan->lock, flags);
+	spin_lock(&chan->lock);
 
 	xilinx_dpdma_debugfs_desc_done_irq(chan);
 
@@ -1057,7 +1056,7 @@ static void xilinx_dpdma_chan_done_irq(struct xilinx_dpdma_chan *chan)
 			 "chan%u: DONE IRQ with no active descriptor!\n",
 			 chan->id);
 
-	spin_unlock_irqrestore(&chan->lock, flags);
+	spin_unlock(&chan->lock);
 }
 
 /**
@@ -1072,10 +1071,9 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
 {
 	struct xilinx_dpdma_tx_desc *pending;
 	struct xilinx_dpdma_sw_desc *sw_desc;
-	unsigned long flags;
 	u32 desc_id;
 
-	spin_lock_irqsave(&chan->lock, flags);
+	spin_lock(&chan->lock);
 
 	pending = chan->desc.pending;
 	if (!chan->running || !pending)
@@ -1108,7 +1106,7 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
 	spin_unlock(&chan->vchan.lock);
 
 out:
-	spin_unlock_irqrestore(&chan->lock, flags);
+	spin_unlock(&chan->lock);
 }
 
 /**
-- 
2.35.1.1320.gc452695387.dirty


