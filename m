Return-Path: <dmaengine+bounces-9676-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFxQGUA6xWkP8gQAu9opvQ
	(envelope-from <dmaengine+bounces-9676-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 14:53:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1076A336504
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 14:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C38630CC252
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AEE2F25E4;
	Thu, 26 Mar 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHBq9W3O"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B192C21C2;
	Thu, 26 Mar 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532251; cv=none; b=IBg1koJr/G/8/5oN1izLiqQkpuwkHiIuxghPR+hYuyO1n1epBi/rpAM8UjhVPpgtKvUlY2iIK/foFWX4i5Wcdkreu3dGZCbf7+HLjq7OgwQBiZDxqT6eAc6Tg+MQEnDvZn4U3YrKPnJc0Tp85b0Fj6wpnOOFMGvT4OmuC4x+zCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532251; c=relaxed/simple;
	bh=6V7xCJfEpHcsI1kelRuOtMsngH7oGbsYsxC25INvh04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhIR2Npn3BHNxOmTuQR6Xrn9olXn3Ua7ztktX8KCvg53BcYkOGKW81Sm5m2iKEgKKG8tFArj4oyrmbtF7FDCSpj8tJiRgEP20yphAfOisQ9iyN0rWH/4QtZzF9XfZT1Yd1XeMF6ClpECQntCswFe3IzboEvZt5oyw9feCX/oaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHBq9W3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FAA3C116C6;
	Thu, 26 Mar 2026 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774532251;
	bh=6V7xCJfEpHcsI1kelRuOtMsngH7oGbsYsxC25INvh04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RHBq9W3OCscv5bMzBpdAotxFSWc54Dcwb/1PTX4+vSyKOB0rnaI1KoNDRATFdCnT4
	 kL49FKoM1EGKsLor3ajGW33XwRyTO6JDdIqDs4IQ1vIYp8SNXvuGQJi+1ASjQd99W8
	 sBZMvLWwk06vtuXISlWbzk+X5NaUl5ih2jUuC2CLQ6iuwAzTH6djhHEHH5nAa6Dfe5
	 btPrlEVQwsJ0kUFC6jYeHALR6ckPybNccEy8JQ80NWbbJUrN8xuVFbS5XX6NRQZZdk
	 ysPsOTzlK92hXninJ8+2vegs4s5gJRVMr+IbPsHLOhRK8AilktAMzIQFLeODtbZ/Dp
	 kyLChkV4XlEzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD210A62CF;
	Thu, 26 Mar 2026 13:37:31 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 26 Mar 2026 13:37:36 +0000
Subject: [PATCH 2/2] dmaengine: dma-axi-dmac: fix use-after-free on unbind
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-dma-dmac-handle-vunmap-v1-2-be3e46ffaf69@analog.com>
References: <20260326-dma-dmac-handle-vunmap-v1-0-be3e46ffaf69@analog.com>
In-Reply-To: <20260326-dma-dmac-handle-vunmap-v1-0-be3e46ffaf69@analog.com>
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774532297; l=4725;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3oOip9GOTG6Og9wQ6FNEHbQ61iic0c2QfMR92xEdP2o=;
 b=/dP6+C3Zf6eLzl6gGhE28fBFM+vhQkt8yiwTx/pdRhKjPAKIBDlZ7VIyFRbvVpjz1pKBlMqRr
 QMBcTIqs95RDMJXuuvW5INrDOvaTyr8K6AxCH6rt7KpIpptsHBFS+hH
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9676-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,analog.com:replyto,analog.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1076A336504
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

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 47 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index df2668064ea2..99454e096588 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -176,6 +176,8 @@ struct axi_dmac {
 
 	struct dma_device dma_dev;
 	struct axi_dmac_chan chan;
+
+	bool unbound;
 };
 
 static struct axi_dmac *chan_to_axi_dmac(struct axi_dmac_chan *chan)
@@ -184,6 +186,11 @@ static struct axi_dmac *chan_to_axi_dmac(struct axi_dmac_chan *chan)
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
@@ -616,6 +623,11 @@ static int axi_dmac_terminate_all(struct dma_chan *c)
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
+	if (dmac->unbound) {
+		/* We're gone */
+		spin_unlock_irqrestore(&chan->vchan.lock, flags);
+		return -ENODEV;
+	}
 	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
 	chan->next_desc = NULL;
 	vchan_get_all_descriptors(&chan->vchan, &head);
@@ -644,9 +656,12 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
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
@@ -1206,6 +1221,14 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
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
@@ -1216,6 +1239,16 @@ static void axi_dmac_free_dma_controller(void *of_node)
 	of_dma_controller_free(of_node);
 }
 
+static void axi_dmac_disable(void *__dmac)
+{
+	struct axi_dmac *dmac = __dmac;
+
+	spin_lock(&dmac->chan.vchan.lock);
+	dmac->unbound = true;
+	spin_unlock(&dmac->chan.vchan.lock);
+	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
+}
+
 static int axi_dmac_probe(struct platform_device *pdev)
 {
 	struct dma_device *dma_dev;
@@ -1225,7 +1258,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	u32 irq_mask = 0;
 	int ret;
 
-	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
+	dmac = kzalloc_obj(struct axi_dmac);
 	if (!dmac)
 		return -ENOMEM;
 
@@ -1270,9 +1303,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_prep_interleaved_dma = axi_dmac_prep_interleaved;
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
 	dma_dev->device_synchronize = axi_dmac_synchronize;
-	dma_dev->dev = &pdev->dev;
+	dma_dev->dev = get_device(&pdev->dev);
 	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
 	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
+	dma_dev->device_release = axi_dmac_release;
 	dma_dev->directions = BIT(dmac->chan.direction);
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
@@ -1326,6 +1360,11 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* So that we can mark the device as unbound and disable it */
+	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_disable, dmac);
+	if (ret)
+		return ret;
+
 	ret = devm_request_irq(&pdev->dev, dmac->irq, axi_dmac_interrupt_handler,
 			       IRQF_SHARED, dev_name(&pdev->dev), dmac);
 	if (ret)

-- 
2.53.0



