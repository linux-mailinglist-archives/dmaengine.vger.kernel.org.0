Return-Path: <dmaengine+bounces-9933-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH+wHFdN1mm8DQgAu9opvQ
	(envelope-from <dmaengine+bounces-9933-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 14:43:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F273BC555
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 14:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56BB73038520
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4933C060E;
	Wed,  8 Apr 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SenShctZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79A3C6A20;
	Wed,  8 Apr 2026 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652112; cv=none; b=ACmHTcBzdwgrotqqv6Lzxv2zGz9723RsfYcuNPE2rNYLBUEesECNvz41A2HEosinDBfgGBJkXB0XBGFKHniAaL2vEp+DRFoKpF4rTxjXBUE4+VHSuqnSRZIVG2ii6NPsl9EKUGWeI6a9n8xggMig4H58FjGsPQaJ/vqRumEMqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652112; c=relaxed/simple;
	bh=ROtjIbpyDk96T8F2lSYYl+HG6LSKvrDvDMFfMYQBlzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uJj6RxYM5FZxBi4JKZJU40iPEGBxlF74kS+YHZY8MAorjfJAR8BFCYOmnvyw9d8vZ9t9KA7n2Z/Wg1vo2q8NNh6VOxkAVqdYK32MmMpi26eJSZ28s0+unXdy226fbY7orDPIN5HOW9hKTlJjEj9pI2cTtgqT/2LORbzzAb+Df3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SenShctZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A850C2BCB3;
	Wed,  8 Apr 2026 12:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775652112;
	bh=ROtjIbpyDk96T8F2lSYYl+HG6LSKvrDvDMFfMYQBlzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SenShctZCFI+iZShB7HP4Jo/1XHOh/Stfz+hZvZjPxHJvv0zTb3+BgYJbAkdR79PO
	 ua/Vp7CP4/YiBFfHcqj+fnMf5qjxUqT6+jVkoHLZxIGe+xKe5gXW8+6z1izTi8aZN2
	 dPV6YpyZMTdAdqUUPMmLjfDNp3ypvARvj3Kelw9q7Emf8r8DVpHPn7oOtNHTQtuR7N
	 Z5xGqvCt0cLFFvCs5xFLetUN1iCgYNFE9EhsMPKXHmZcGqQMKwea5rt+SKwecGCvXX
	 01UhosLE2zGK5RI5QElIilwdLpCWQnLAATvYjPEYuAPgD/XT9AlwbTwTiZLdAlZ5Eh
	 rWGSwSpKv2Kyw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C31073C93;
	Wed,  8 Apr 2026 12:41:52 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 08 Apr 2026 13:42:43 +0100
Subject: [PATCH v3 4/4] dmaengine: dma-axi-dmac: Fig BUG() on vunmap()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-dma-dmac-handle-vunmap-v3-4-2456ad292154@analog.com>
References: <20260408-dma-dmac-handle-vunmap-v3-0-2456ad292154@analog.com>
In-Reply-To: <20260408-dma-dmac-handle-vunmap-v3-0-2456ad292154@analog.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775652161; l=5247;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KzDfaSnPpvy2D4wxKHW5ARqGw5aBbUaqGy+f36zi13Q=;
 b=thtB8sL05Q+PPK2j5gKDK5pSKysY9PnifHL08IQNkK48BKw/xnH8YOsi3efQhsWzJOrFEEMqS
 LauzH44E5UGDBV3H6MVzt8hKwA0+UhFqhzK1RsTfP+BA8RTTCQJW+WL
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9933-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]
X-Rspamd-Queue-Id: 04F273BC555
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nuno Sá <nuno.sa@analog.com>

For architectures like Microblaze or arm64 (where this IP is used),
DMA_DIRECT_REMAP is set which means that dma_alloc_coherent() might
remap (and hence vmalloc()) some memory. This became visible in a design
where dma_direct_use_pool() is not possible.

With the above, when calling dma_free_coherent(), vunmap() would be
called from softirq context and thus leading to a BUG().

To fix it, use a dma pool that is allocated in
.device_alloc_chan_resources() and allocate blocks from it. The key
point is that now dma_pool_free() is used in axi_dmac_free_desc() to
free the blocks and that just frees the blocks from the pool in the
sense they can be used again. In other words, no actual call to
dma_free_coherent() happens. That only happens when destroying the pool
in axi_dmac_free_chan_resources() which does not happen in any interrupt
context.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 66 ++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 41898d594be7..d47ff27e1408 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/dmapool.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -147,6 +148,7 @@ struct axi_dmac_chan {
 	struct virt_dma_chan vchan;
 
 	struct axi_dmac_desc *next_desc;
+	void *pool;
 	struct list_head active_descs;
 	enum dma_transfer_direction direction;
 
@@ -648,11 +650,17 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
 
+static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
+{
+	for (unsigned int i = 0; i < desc->num_sgs; i++)
+		dma_pool_free(desc->chan->pool, desc->sg[i].hw, desc->sg[i].hw_phys);
+
+	kfree(desc);
+}
+
 static struct axi_dmac_desc *
 axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
 {
-	struct axi_dmac *dmac = chan_to_axi_dmac(chan);
-	struct device *dev = dmac->dma_dev.dev;
 	struct axi_dmac_hw_desc *hws;
 	struct axi_dmac_desc *desc;
 	dma_addr_t hw_phys;
@@ -664,22 +672,22 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
 	desc->num_sgs = num_sgs;
 	desc->chan = chan;
 
-	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
-				&hw_phys, GFP_ATOMIC);
-	if (!hws) {
-		kfree(desc);
-		return NULL;
-	}
-
 	for (i = 0; i < num_sgs; i++) {
-		desc->sg[i].hw = &hws[i];
-		desc->sg[i].hw_phys = hw_phys + i * sizeof(*hws);
+		hws = dma_pool_zalloc(chan->pool, GFP_NOWAIT, &hw_phys);
+		if (!hws) {
+			desc->num_sgs = i;
+			axi_dmac_free_desc(desc);
+			return NULL;
+		}
 
-		hws[i].id = AXI_DMAC_SG_UNUSED;
-		hws[i].flags = 0;
+		desc->sg[i].hw = hws;
+		desc->sg[i].hw_phys = hw_phys;
+
+		hws->id = AXI_DMAC_SG_UNUSED;
 
 		/* Link hardware descriptors */
-		hws[i].next_sg_addr = hw_phys + (i + 1) * sizeof(*hws);
+		if (i)
+			desc->sg[i - 1].hw->next_sg_addr = hw_phys;
 	}
 
 	/* The last hardware descriptor will trigger an interrupt */
@@ -688,18 +696,6 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
 	return desc;
 }
 
-static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
-{
-	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
-	struct device *dev = dmac->dma_dev.dev;
-	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
-	dma_addr_t hw_phys = desc->sg[0].hw_phys;
-
-	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
-			  hw, hw_phys);
-	kfree(desc);
-}
-
 static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
 	enum dma_transfer_direction direction, dma_addr_t addr,
 	unsigned int num_periods, unsigned int period_len,
@@ -933,9 +929,26 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_interleaved(
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }
 
+static int axi_dmac_alloc_chan_resources(struct dma_chan *c)
+{
+	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
+	struct device *dev = c->device->dev;
+
+	chan->pool = dma_pool_create(dev_name(dev), dev,
+				     sizeof(struct axi_dmac_hw_desc),
+				     __alignof__(struct axi_dmac_hw_desc), 0);
+	if (!chan->pool)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static void axi_dmac_free_chan_resources(struct dma_chan *c)
 {
+	struct axi_dmac_chan *chan = to_axi_dmac_chan(c);
+
 	vchan_free_chan_resources(to_virt_chan(c));
+	dma_pool_destroy(chan->pool);
 }
 
 static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
@@ -1238,6 +1251,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
 	dma_cap_set(DMA_CYCLIC, dma_dev->cap_mask);
 	dma_cap_set(DMA_INTERLEAVE, dma_dev->cap_mask);
+	dma_dev->device_alloc_chan_resources = axi_dmac_alloc_chan_resources;
 	dma_dev->device_free_chan_resources = axi_dmac_free_chan_resources;
 	dma_dev->device_tx_status = dma_cookie_status;
 	dma_dev->device_issue_pending = axi_dmac_issue_pending;

-- 
2.53.0



