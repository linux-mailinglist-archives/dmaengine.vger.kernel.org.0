Return-Path: <dmaengine+bounces-9693-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OPDCqG4xmnoNwUAu9opvQ
	(envelope-from <dmaengine+bounces-9693-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 18:04:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5052E34804B
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 18:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C240C304B390
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417B43644C8;
	Fri, 27 Mar 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il4gd/Wt"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34083644A7;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630672; cv=none; b=U0ARKqfpM9VS+7qBNpt7gRItbg5p3Timv2UhYkdPW5DEYQblwYy3y+RUizI03fmm41N9qRljlJM2jzGTa5EU60sdu4PldF33G1mkScOYxG5Dw3WRyrVST07H08rs/beVOlsdzfBwuaMJYDqkKjlHXgMw1tpmL1JFPJcbGErE644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630672; c=relaxed/simple;
	bh=SsiVQydKDWPQwQpTdDBmaBONRxD+mD9a9QbQWIJhazo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LA8wQEaTY2fI5kXOwvbkXsCFrFGUzu+4HimgGE+I3gdNJR7jk6pD+fI6fWXycehTZvQWFh5dPusn5LHBUtWI9wDRA8lK1jCw/a7cp0BfEcST99JBsaxex/rbapGhN8pbFWSrjZA2IUdo0uCM+qzXYTnJsr4eZWHdZJuN4FK0jas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il4gd/Wt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0DF2C4AF09;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774630672;
	bh=SsiVQydKDWPQwQpTdDBmaBONRxD+mD9a9QbQWIJhazo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Il4gd/WtL8U2Gznpcys1LQA+hNVwaIyxfgioKs02SG1BsfnN4jeOvO4+gOkfhX6SO
	 pLGAI1Sw6g9fdZOaVDzclxMlltHsci6kiJrmyMAkyEL68MiOQvPA1JHQRRKKlnwGCL
	 ygsG9Le0W9rUkvOC16remp+0PRru7KofjIqAb3jeYPnW2ukv2omftKW9oZ3r1I8jms
	 EKyMzzVORzkjAeywJ8ha1AisEPHxaFykCOrwm5UGJ8J8EyX0mflJjqn3ITpF+hUu6H
	 3iHZeuZw/gZt+geVlrxvH92vT0oIi2A8gPfft9VLy0ccUsOpLoJ2dvUmwbiKMBw/45
	 zHqp1YhMJj4yA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9533E10F285D;
	Fri, 27 Mar 2026 16:57:52 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 27 Mar 2026 16:58:41 +0000
Subject: [PATCH v2 4/4] dmaengine: dma-axi-dmac: Defer freeing DMA
 descriptors
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260327-dma-dmac-handle-vunmap-v2-4-021f95f0e87b@analog.com>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
In-Reply-To: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Eliza Balas <eliza.balas@analog.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774630718; l=4336;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=iMbPiK/wOeXYmM5fOnDfGQN+n3bpnujjiiAlZriC4to=;
 b=ta7WMPtxj1EzNdcXn+Q4f3+NDIrTIPaL1n/IM6GuOTrYbw/cY9q/QRd8g71GNM1BDoEnmig7e
 2QWONkYu+2hC/3Aj+K0pwzvmqTwy/0+86nR3TGeyVpxNg4YsZC6xM3f
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9693-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]
X-Rspamd-Queue-Id: 5052E34804B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eliza Balas <eliza.balas@analog.com>

This IP core can be used in architectures (like Microblaze) where DMA
descriptors are allocated with vmalloc(). Hence, given that freeing the
descriptors happen in softirq context, vunmpap() will BUG().

To solve the above, we setup a work item during allocation of the
descriptors and schedule in softirq context. Hence, the actual freeing
happens in threaded context.

Also note that to account for the possible race where the struct axi_dmac
object is gone between scheduling the work and actually running it, we
now save and get a reference of struct device when allocating the
descriptor (given that's all we need in axi_dmac_free_desc()) and
release it in axi_dmac_free_desc().

Signed-off-by: Eliza Balas <eliza.balas@analog.com>
Co-developed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 50 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 70d3ad7e7d37..46f1ead0c7d7 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -25,6 +25,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 #include <dt-bindings/dma/axi-dmac.h>
 
@@ -133,6 +134,9 @@ struct axi_dmac_sg {
 struct axi_dmac_desc {
 	struct virt_dma_desc vdesc;
 	struct axi_dmac_chan *chan;
+	struct device *dev;
+
+	struct work_struct sched_work;
 
 	bool cyclic;
 	bool cyclic_eot;
@@ -666,6 +670,25 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
 
+static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
+{
+	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
+	dma_addr_t hw_phys = desc->sg[0].hw_phys;
+
+	dma_free_coherent(desc->dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
+			  hw, hw_phys);
+	put_device(desc->dev);
+	kfree(desc);
+}
+
+static void axi_dmac_free_desc_schedule_work(struct work_struct *work)
+{
+	struct axi_dmac_desc *desc = container_of(work, struct axi_dmac_desc,
+						  sched_work);
+
+	axi_dmac_free_desc(desc);
+}
+
 static struct axi_dmac_desc *
 axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
 {
@@ -681,6 +704,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
 		return NULL;
 	desc->num_sgs = num_sgs;
 	desc->chan = chan;
+	desc->dev = get_device(dmac->dma_dev.dev);
 
 	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
 				&hw_phys, GFP_ATOMIC);
@@ -703,21 +727,18 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
 	/* The last hardware descriptor will trigger an interrupt */
 	desc->sg[num_sgs - 1].hw->flags = AXI_DMAC_HW_FLAG_LAST | AXI_DMAC_HW_FLAG_IRQ;
 
+	/*
+	 * We need to setup a work item because this IP can be used on archs
+	 * that rely on vmalloced memory for descriptors. And given that freeing
+	 * the descriptors happens in softirq context, vunmpap() will BUG().
+	 * Hence, setup the worker so that we can queue it and free the
+	 * descriptor in threaded context.
+	 */
+	INIT_WORK(&desc->sched_work, axi_dmac_free_desc_schedule_work);
+
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
@@ -958,7 +979,10 @@ static void axi_dmac_free_chan_resources(struct dma_chan *c)
 
 static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
 {
-	axi_dmac_free_desc(to_axi_dmac_desc(vdesc));
+	struct axi_dmac_desc *desc = to_axi_dmac_desc(vdesc);
+
+	/* See the comment in axi_dmac_alloc_desc() for the why! */
+	schedule_work(&desc->sched_work);
 }
 
 static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)

-- 
2.53.0



