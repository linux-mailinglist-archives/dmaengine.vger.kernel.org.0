Return-Path: <dmaengine+bounces-3708-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BE39C41D3
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 16:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A25B235E2
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78B349625;
	Mon, 11 Nov 2024 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="pIxDSoE1";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="tpdpFNlq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9D53389
	for <dmaengine@vger.kernel.org>; Mon, 11 Nov 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338877; cv=none; b=Oe9JNy/sfSB1WGWbdGYBbqQ41p0OJsZJ1Hs4ryNtdazttshEOqsG21TwZDaFuYr+EyIPR2s5Ql4lFUJt8fev6FqzlC1UtKkZGpnbm24rF7msPZJfBKzwSSpjXAphrhCld5Z9lLcogEGB8N2ZDXyPJm9Bq+/Jz14SvAHfaT4XTCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338877; c=relaxed/simple;
	bh=fTCNwvEeSfhjAlvuRWQdxkiyNxbp4j2jCyOjW+GUYkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAynshUufBwhqEU0AY6/X56Iiekak+UPnk1Cr3C/io3LypFjyKlx4SPTLfBIJ3qCBQT6dw9Ik4ZdNj0EwjwsdHeu3Nrg3BSkjEfZ8nu6bZSeGhZp1zjTmMgbL3/JBQ44cP7qAzIOdN5Cl4LuTg7ft8Tm4L/jMJwQ4Ji/R2CTF48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=pIxDSoE1; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=tpdpFNlq; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 978E9E0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1731338873; bh=WocUvkzoYetonkZ1U60cm3ayMp335OIxYY+sfT5CN7A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=pIxDSoE1uTAxvfm/tAncMUn1hv0n9XqKHOvFcdLhfxiqVoajbTv8Eez2GTtC0CDvo
	 mxNDwqde9xGwpa+o3E7nXKomyjwmjsO0pYWnXus/xPw1PDVJzgiwjN6Kmd7b2Bj3K1
	 1ibcmdBmxz+b32D347orDhdVNXe4XgTVxW7qQRwU+djB3Aoaa3HFOh9DwOIYe99soe
	 Tz9zqrPMbuCK9td2dHjqFJKK1sllIjMDj4ziweIQTYiSozz8wgWctD7hYOWHtLXAVY
	 krkcZO/jS+cwTSq8R67qPlk2mTgcRYzHTKmt5JtPeD0kcAp5SNGzzMl9MK4XfHCcdG
	 00Xkno4gtrh3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1731338873; bh=WocUvkzoYetonkZ1U60cm3ayMp335OIxYY+sfT5CN7A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=tpdpFNlqaQEMVo6jvV66M/rFaNr94N8lm4Vt0NAkOvYVBs0qWj1edhAWBYn6ddq9H
	 +iqtX0JTzci5kILpX2SfFVVbHdbnALqstcgzcGolHeailoenLcBDdzWPS9UVqQs2Nr
	 JFVct7IMg+thpqalKufnBg3Pe2Z8z1ceDtldhfa4x/1j25w1Fbaz472dAHPvoEfeuS
	 yXvWBqKcpYZG4Xzq4Pv3yFVWESt/Ok4XHv3qb7FrUj6NL3EtsCvsz//YUApwOtqJ9A
	 Jr9wvIf5cNPMZL8wSLi4zWXDN9164GLfas2kuQo7PhYHrobQjmOdXTd8pTyATaR1IX
	 x84+nBfUrpZEQ==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux@yadro.com>, Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 2/2] dmaengine: sf-pdma: Fix possible double-free for descriptors
Date: Mon, 11 Nov 2024 18:26:00 +0300
Message-ID: <20241111152600.146912-3-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111152600.146912-1-n.proshkin@yadro.com>
References: <20241111152600.146912-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

sf_pdma_issue_pending() sets pointer to the currently being processed
dma descriptor in struct sf_pdma_chan, but this descriptor remains a part
of the desc_issued list from the struct virt_dma_chan.

Descriptor is correctly deleted from the list and freed in done tasklet,
but stays in place in case of an error during dma processing, waiting for
sf_pdma_terminate_all() to be called.

If the pointer to the descriptor is valid in struct sf_pdma_chan,
sf_pdma_terminate_all() first frees this descriptor directly, but later
uses it again in the vchan_dma_desc_free_list(), leading to mem management
errors (double-free, use-after-free).

Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 55b7c57eeec9..8fec11ad4f0b 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -145,7 +145,6 @@ static void sf_pdma_free_chan_resources(struct dma_chan *dchan)
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 	sf_pdma_disable_request(chan);
-	kfree(chan->desc);
 	chan->desc = NULL;
 	vchan_get_all_descriptors(&chan->vchan, &head);
 	sf_pdma_disclaim_chan(chan);
@@ -192,7 +191,6 @@ static int sf_pdma_terminate_all(struct dma_chan *dchan)
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 	sf_pdma_disable_request(chan);
-	kfree(chan->desc);
 	chan->desc = NULL;
 	vchan_get_all_descriptors(&chan->vchan, &head);
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
@@ -279,8 +277,10 @@ static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 	chan->status = DMA_COMPLETE;
 
-	list_del(&chan->desc->vdesc.node);
-	vchan_cookie_complete(&chan->desc->vdesc);
+	if (chan->desc) {
+		list_del(&chan->desc->vdesc.node);
+		vchan_cookie_complete(&chan->desc->vdesc);
+	}
 
 	chan->desc = sf_pdma_get_first_pending_desc(chan);
 	if (chan->desc)
@@ -295,7 +295,8 @@ static void sf_pdma_errbh_tasklet(struct tasklet_struct *t)
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
-	dmaengine_desc_get_callback_invoke(chan->desc->async_tx, NULL);
+	if (chan->desc)
+		dmaengine_desc_get_callback_invoke(chan->desc->async_tx, NULL);
 	chan->status = DMA_ERROR;
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
@@ -310,7 +311,7 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
 	writel((readl(regs->ctrl)) & ~PDMA_DONE_STATUS_MASK, regs->ctrl);
 	residue = readq(regs->residue);
 
-	if (!residue) {
+	if (!residue || !chan->desc) {
 		tasklet_hi_schedule(&chan->done_tasklet);
 	} else {
 		/* submit next trascatioin if possible */
-- 
2.34.1


