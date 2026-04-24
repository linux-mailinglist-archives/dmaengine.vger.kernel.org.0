Return-Path: <dmaengine+bounces-10117-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP11HtGq62nfQAAAu9opvQ
	(envelope-from <dmaengine+bounces-10117-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 19:39:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D52714620AD
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 19:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C980300B9DB
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEEC3E5588;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS7Mpja0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5373AD510;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052364; cv=none; b=PV54k3yXCa83pVaUI5E9hNFA88K8aw6jH6dmeKMc/Y6TF9avOnphGewQNFClTdw8KUkVsyqZzw4YzpujdKSGf+LgoCxAK/LnCAjNIJFQ5eBtRWSKY3yy0hpwWrxLPLjKKAEtUa0yKKqPCbKs/zcijMyJrtukHo49omGrB+B55rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052364; c=relaxed/simple;
	bh=5n0eTKt2Cl626iyJU0lxSbAm30fR29gcRRZy0D1Bo6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gI/ZyjO5IBZFdOVgRAA0ND5uMuVRkS1z6hoAGFGps6W/gtTUxiCuQnmdE2c4YURaSjZgZiRufMgOpmBitwlRuuXjsFZlbdYKHchs5g1dLK2//jKZgjuT/WmPbmO1QVFNVKaHWah/ODcwqTsZzyHt+Rlrb7b4J75tLemm4n+JoDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS7Mpja0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27EA7C4AF0C;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052364;
	bh=5n0eTKt2Cl626iyJU0lxSbAm30fR29gcRRZy0D1Bo6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KS7Mpja0XMIk3zBoxWxFgCX28C4an6iS0f6KkS0UYooRXbb5XHP+QBXtlIBbKikdW
	 d7so4QcW9VE5k7uZ7vVmbcznA6ndzoacJvgVB4yGc1ec2KcD4zkl7WJEyjuFSGWNpQ
	 0cmP836xqWajKDPRX8Sw5I6JPys8oNH4TdY6qsvdOXthGFNK5LwMasf4xo1PmCe/lh
	 rBvKw9/kktW0FaVAnv3ToXV8F4jhe8WQ4RRGHYie/+v1wJHVB0BsyQB8BuPjq6lC/O
	 U15E6DKjQr/Fcjq0CCvq9j32R0go4Wr2X0GK3R0+PV97nLpGv8eM8gUh8JR1S+il5C
	 WhQCuMsegpyjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206D4FED3F6;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 24 Apr 2026 18:40:17 +0100
Subject: [PATCH v4 4/4] dmaengine: dma-axi-dmac: use DMA pool to manange
 DMA descriptor
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260424-dma-dmac-handle-vunmap-v4-4-90f43412fdc0@analog.com>
References: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
In-Reply-To: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777052415; l=5323;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HqWNkCDI0VfeVEb5KKgxsi/P7bet+YEciX6Acpcld7Q=;
 b=zl7ajjc9sDfmd7eFj4L/AZLliMugd/RhFG9WpDr23VCMGb60Mi96x70gRoUaX5rapp93fPBEi
 A7DeYvKWXMEDxZGKSGhHVLKaKPD472buAM/tUPoTJ3pJ9f7cqph8lYP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Queue-Id: D52714620AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10117-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com]

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

Fixes: 3f8fd25936ee ("dmaengine: axi-dmac: Allocate hardware descriptors")
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
2.54.0



