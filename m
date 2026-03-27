Return-Path: <dmaengine+bounces-9694-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JUnLe24xmnoNwUAu9opvQ
	(envelope-from <dmaengine+bounces-9694-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 18:05:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2010E348097
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 18:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04A5F30500F6
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7943644BC;
	Fri, 27 Mar 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpDFaTla"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE93363084;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630672; cv=none; b=ILNOVBQD+6jTtFmjzTJ9YEAp2wekvFDjh1L9Bq3JDNT3/WayebN3Ggf/7w2L1Hx01rP1ffrRFyI5nOW7qfwBYG9TRNwswvNROGYUgFUESIqc2sLYw8c7jFdjeoMnxd/M3JCcbzcsgXgLgvSX+2vCe4FWV/F6W1s9cAT3I7vcu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630672; c=relaxed/simple;
	bh=bRskiND37H8zr+VsGdBTgwErj7Q7boGCxXn+DjuUp8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fACJtXQPA1FkNuWhECgRILu/ql4dyRYYfWfIBDdeaOvWCViDseIhclgqE0GvRQn396zq3YQ8z2sS12EZZQZzYAo92cJSpMiLE/zzHFuS8B3wyRrwgr3n96L+QYLGAwVoTlQ/UdOaZHzji4e3+JfhPQfdXsknGWFcpdMADwGikak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpDFaTla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99971C2BCB2;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774630672;
	bh=bRskiND37H8zr+VsGdBTgwErj7Q7boGCxXn+DjuUp8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NpDFaTlaXWJgjU4TbQrxYxCdnuQZkQkQ0mKSjoll9mkS9zBVuWnUU8WjiDBCmxzIW
	 Y1txuNUoAZyY2kIWiy4QLWq/C81drcuPPXZA5jnBunKN6UDu2EdVNqygpJqnKxPYs4
	 yX0vQcwVrjfQQtOxjHkHASl2WZtyrCKbzZ8U7LSX3ONGXn7waJjFwyXeZh0s6/Gv/p
	 FG7v0zXmmB3yiT4tuoWlpE8Tnod+wHjzTD9iZDQNxlqaNdeksPfR0qKnR7PqA6EkWb
	 R4JgzE7BbXfBsZW2GdA1KsYjBo7V32y5MCZ67Zdt71so79TEtzhth5x847KMisdTph
	 RbjuPzAc/1IxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8806810F2859;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 27 Mar 2026 16:58:40 +0000
Subject: [PATCH v2 3/4] dmaengine: dma-axi-dmac: fix use-after-free on
 unbind
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260327-dma-dmac-handle-vunmap-v2-3-021f95f0e87b@analog.com>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
In-Reply-To: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774630718; l=6083;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=wNR0oMrw1rZtsi8jCBNE5cHKX8fscvXjfWhQBVv80wM=;
 b=SKBxoXgda0GYVlhNewidU0+iQyqeuYD43xtQpNKW0k1sukH/ROqnRR76dXCn/DVTduLPpPA4f
 pR1KTZu6VhyCV/5BU7SWgWMUklipVMh4imabMsvPGScJy+mxNaXTQhR
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9694-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,analog.com:replyto,analog.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2010E348097
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nuno Sá <nuno.sa@analog.com>

The DMA device lifetime can extend beyond the platform driver unbind if
DMA channels are still referenced by client drivers. This leads to
use-after-free when the devm-managed memory is freed on unbind but the
DMA device callbacks still access it.

Fix this by:
 - Allocating axi_dmac with kzalloc_obj() instead of devm_kzalloc() so
its lifetime is not tied to the platform device.
 - Implementing the device_release callback that so that we can free
the object when reference count gets to 0 (no users).
 - Adding an 'unbound' flag protected by the vchan lock that is set
during driver removal, preventing MMIO accesses after the device has been
unbound.

While at it, explicitly include spinlock.h given it was missing.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 70 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 127c3cf80a0e..70d3ad7e7d37 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include <dt-bindings/dma/axi-dmac.h>
 
@@ -174,6 +175,8 @@ struct axi_dmac {
 
 	struct dma_device dma_dev;
 	struct axi_dmac_chan chan;
+
+	bool unbound;
 };
 
 static struct axi_dmac *chan_to_axi_dmac(struct axi_dmac_chan *chan)
@@ -182,6 +185,11 @@ static struct axi_dmac *chan_to_axi_dmac(struct axi_dmac_chan *chan)
 		dma_dev);
 }
 
+static struct axi_dmac *dev_to_axi_dmac(struct dma_device *dev)
+{
+	return container_of(dev, struct axi_dmac, dma_dev);
+}
+
 static struct axi_dmac_chan *to_axi_dmac_chan(struct dma_chan *c)
 {
 	return container_of(c, struct axi_dmac_chan, vchan.chan);
@@ -614,7 +622,12 @@ static int axi_dmac_terminate_all(struct dma_chan *c)
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
-	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
+	/*
+	 * Only allow the MMIO access if the device is live. Otherwise still
+	 * go for freeing the descriptors.
+	 */
+	if (!dmac->unbound)
+		axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
 	chan->next_desc = NULL;
 	vchan_get_all_descriptors(&chan->vchan, &head);
 	list_splice_tail_init(&chan->active_descs, &head);
@@ -642,9 +655,12 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
 	if (chan->hw_sg)
 		ctrl |= AXI_DMAC_CTRL_ENABLE_SG;
 
-	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, ctrl);
-
 	spin_lock_irqsave(&chan->vchan.lock, flags);
+	if (dmac->unbound) {
+		spin_unlock_irqrestore(&chan->vchan.lock, flags);
+		return;
+	}
+	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, ctrl);
 	if (vchan_issue_pending(&chan->vchan))
 		axi_dmac_start_transfer(chan);
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
@@ -1184,6 +1200,14 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
 	return 0;
 }
 
+static void axi_dmac_release(struct dma_device *dma_dev)
+{
+	struct axi_dmac *dmac = dev_to_axi_dmac(dma_dev);
+
+	put_device(dma_dev->dev);
+	kfree(dmac);
+}
+
 static void axi_dmac_tasklet_kill(void *task)
 {
 	tasklet_kill(task);
@@ -1194,16 +1218,27 @@ static void axi_dmac_free_dma_controller(void *of_node)
 	of_dma_controller_free(of_node);
 }
 
+static void axi_dmac_disable(void *__dmac)
+{
+	struct axi_dmac *dmac = __dmac;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmac->chan.vchan.lock, flags);
+	dmac->unbound = true;
+	spin_unlock_irqrestore(&dmac->chan.vchan.lock, flags);
+	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
+}
+
 static int axi_dmac_probe(struct platform_device *pdev)
 {
 	struct dma_device *dma_dev;
-	struct axi_dmac *dmac;
+	struct axi_dmac *__dmac;
 	struct regmap *regmap;
 	unsigned int version;
 	u32 irq_mask = 0;
 	int ret;
 
-	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
+	struct axi_dmac *dmac __free(kfree) = kzalloc_obj(struct axi_dmac);
 	if (!dmac)
 		return -ENOMEM;
 
@@ -1251,6 +1286,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->dev = &pdev->dev;
 	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
 	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
+	dma_dev->device_release = axi_dmac_release;
 	dma_dev->directions = BIT(dmac->chan.direction);
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
@@ -1285,12 +1321,21 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/*
+	 * From this point on, our dmac object has it's lifetime bounded with
+	 * dma_dev. Will be freed when dma_dev refcount goes to 0. That means,
+	 * no more automatic kfree(). Also note that dmac is now NULL so we
+	 * need __dmac.
+	 */
+	__dmac = no_free_ptr(dmac);
+	get_device(&pdev->dev);
+
 	/*
 	 * Put the action in here so it get's done before unregistering the DMA
 	 * device.
 	 */
 	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_tasklet_kill,
-				       &dmac->chan.vchan.task);
+				       &__dmac->chan.vchan.task);
 	if (ret)
 		return ret;
 
@@ -1304,13 +1349,18 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&pdev->dev, dmac->irq, axi_dmac_interrupt_handler,
-			       IRQF_SHARED, dev_name(&pdev->dev), dmac);
+	/* So that we can mark the device as unbound and disable it */
+	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_disable, __dmac);
 	if (ret)
 		return ret;
 
-	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
-		 &axi_dmac_regmap_config);
+	ret = devm_request_irq(&pdev->dev, __dmac->irq, axi_dmac_interrupt_handler,
+			       IRQF_SHARED, dev_name(&pdev->dev), __dmac);
+	if (ret)
+		return ret;
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, __dmac->base,
+				       &axi_dmac_regmap_config);
 
 	return PTR_ERR_OR_ZERO(regmap);
 }

-- 
2.53.0



