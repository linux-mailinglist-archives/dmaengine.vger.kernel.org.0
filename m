Return-Path: <dmaengine+bounces-11964-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VQGhAFNcRmqtRgsAu9opvQ
	(envelope-from <dmaengine+bounces-11964-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 14:40:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9692E6F7C00
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 14:40:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=v7iBOY06;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11964-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11964-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A7C43086D58
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E92480DCA;
	Thu,  2 Jul 2026 12:34:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C3480336
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 12:34:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995679; cv=none; b=sGWW3Yys1On/ojwupaADmFCBaxXfi9/EhivI9T4J6qdSOxXusQpQOCAwGH/yEGkTVSl8jRpSXr2rCZoRJ3ZN6QFDFr7aQjMehsFNf5rRteWHbGuioS+r4r0gKZ2tdePOJtLby+9ioCdxHKN6gsCrp5xkmPVUX5D7dWNQixyKP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995679; c=relaxed/simple;
	bh=8YSaje5AV4kPQCsMP4vWF1lLi5i2xy0iu7LcoZemtfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDtr6vZNTuJjQ/uQMi9N233CH7xDCuXL8isY23afX3s6naqJ8YKYlaPqedK5Tqu2sOXO+gOSCo6TAR7ISM1uKn9Rs3iSqJ7R8SC4e7DLVRTTZO/TVe58D68ZQHJsgr3jlWj7lD3ZyIAhiFKx/8WLz+Yu5lU2nTKNaYpNzQ0NRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v7iBOY06; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 671F64E40C4A;
	Thu,  2 Jul 2026 12:34:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3BE685FF03;
	Thu,  2 Jul 2026 12:34:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C177A104C9552;
	Thu,  2 Jul 2026 14:34:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782995675; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dc5yOdlQfPlKctRu6sOAeSJPrhY/mzrh22CvXJGXHUM=;
	b=v7iBOY065oDwhKnaaIkZTMDePvNH+UW/2EvwmVlWgIr4H7tF/bHUHJrSbe3ftu1PgKzHP8
	1VjOw+ePkzPWkTe8t+o7nByh7F+8v6IwpaqfJfG11NTTgwjEPG6TCP91WhL7u9Kg+xwmlc
	uWQZfBhCrYNkHkva/PY0iVhFNlutiewor+RwMaGaUz/j9A773mlvnR7gmJ3CgvvJyc9J1N
	w7Ay+5hzwuIuw/RhsiTHCpAAkMn7X0xyXTpQAo2GoGhVKp/y1xmLxGsETZK2zL7IZzPzUg
	Vgbd+ozi79I7+PWa7mWc/yX73x5lHVlMwV4BkJGUBzEMnNYbaeIW97hZTCpENQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Thu, 02 Jul 2026 14:34:25 +0200
Subject: [PATCH v5 2/2] dmaengine: fsl-edma: Support dynamic scatter/gather
 chaining
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-fsl-edma-dyn-sg-v5-2-16787185be49@bootlin.com>
References: <20260702-fsl-edma-dyn-sg-v5-0-16787185be49@bootlin.com>
In-Reply-To: <20260702-fsl-edma-dyn-sg-v5-0-16787185be49@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11964-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:thomas.petazzoni@bootlin.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:benoit.monin@bootlin.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9692E6F7C00

Implement dynamic linking of scatter/gather transfers to enable
chaining multiple DMA descriptors without stopping the channel.
This avoids waiting for the channel to go idle if there is another
transaction already issued.

Add fsl_edma_link_sg() to dynamically link the last TCD of a previously
submitted descriptor to the first TCD of a new descriptor by setting
the scatter/gather address and the E_SG flag, and keeping the channel
active by clearing the DREQ bit.

Linking is done when the transaction is submitted by fsl_edma_tx_submit().
To do so, the .tx_submit() callback is overridden for non-cyclic
transactions prepared by fsl_edma_prep_peripheral_dma_vec() and
fsl_edma_prep_slave_sg(). This ensures that transactions are linked
in the order they are submitted.

Update fsl_edma_xfer_desc() to avoid re-initializing the hardware when a
transfer is already in progress, allowing seamless chaining of descriptors.

Modify the transfer completion handler to check the DONE flag in the
channel CSR before marking the transfer complete. Since this flag is
only available on SoC with the split registers layout, we only link
transactions for DMA controllers flagged with FSL_EDMA_DRV_SPLIT_REG.

Add trace event for scatter/gather linking operations.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/dma/fsl-edma-common.c | 90 +++++++++++++++++++++++++++++++++++++++----
 drivers/dma/fsl-edma-trace.h  |  5 +++
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index c10190164926..e2f480c8fe21 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -58,7 +58,10 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
 		list_del(&fsl_chan->edesc->vdesc.node);
 		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
 		fsl_chan->edesc = NULL;
-		fsl_chan->status = DMA_COMPLETE;
+		if (!(fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_SPLIT_REG) ||
+		    (edma_readl_chreg(fsl_chan, ch_csr) & EDMA_V3_CH_CSR_DONE)) {
+			fsl_chan->status = DMA_COMPLETE;
+		}
 	} else {
 		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
 	}
@@ -673,6 +676,68 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
 
+static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fsl_edma_desc *fsl_desc)
+{
+	u32 flags = fsl_edma_drvflags(fsl_chan);
+	struct fsl_edma_hw_tcd *last_tcd;
+	struct fsl_edma_desc *prev_desc;
+	struct virt_dma_desc *vdesc;
+	u16 csr;
+
+	lockdep_assert_held(&fsl_chan->vchan.lock);
+
+	if (!(flags & FSL_EDMA_DRV_SPLIT_REG))
+		return;
+
+	vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
+					struct virt_dma_desc, node);
+	if (!vdesc)
+		vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
+						struct virt_dma_desc, node);
+	if (!vdesc)
+		return;
+
+	prev_desc = to_fsl_edma_desc(vdesc);
+	last_tcd = prev_desc->tcd[prev_desc->n_tcds - 1].vtcd;
+
+	csr = fsl_edma_get_tcd_to_cpu(fsl_chan, last_tcd, csr);
+	if (!(csr & EDMA_TCD_CSR_D_REQ))
+		return;
+
+	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, fsl_desc->tcd[0].ptcd, dlast_sga);
+	dma_wmb();
+
+	csr &= ~EDMA_TCD_CSR_D_REQ;
+	csr |= EDMA_TCD_CSR_E_SG;
+	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, csr, csr);
+
+	if (prev_desc == fsl_chan->edesc &&
+	    prev_desc->n_tcds == 1 &&
+	    !(flags & FSL_EDMA_DRV_CLEAR_DONE_E_SG)) {
+		edma_cp_tcd_to_reg(fsl_chan, last_tcd, dlast_sga);
+		edma_cp_tcd_to_reg(fsl_chan, last_tcd, csr);
+	}
+
+	trace_edma_link_sg(fsl_chan, last_tcd);
+}
+
+static dma_cookie_t fsl_edma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct virt_dma_desc *vd = container_of(tx, struct virt_dma_desc, tx);
+	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(tx->chan);
+	struct fsl_edma_desc *fsl_desc = to_fsl_edma_desc(vd);
+	struct virt_dma_chan *vc = to_virt_chan(tx->chan);
+	dma_cookie_t cookie;
+
+	guard(spinlock_irqsave)(&fsl_chan->vchan.lock);
+
+	fsl_edma_link_sg(fsl_chan, fsl_desc);
+	cookie = dma_cookie_assign(tx);
+	list_move_tail(&vd->node, &vc->desc_submitted);
+
+	return cookie;
+}
+
 struct dma_async_tx_descriptor *
 fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma_vec *vecs,
 				 size_t nb, enum dma_transfer_direction direction,
@@ -680,6 +745,7 @@ fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma_vec *ve
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	dma_addr_t src_addr, dst_addr, last_sg;
+	struct dma_async_tx_descriptor *tx;
 	struct fsl_edma_desc *fsl_desc;
 	u16 soff, doff, iter;
 	u32 nbytes;
@@ -779,7 +845,10 @@ fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma_vec *ve
 		}
 	}
 
-	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+	tx = vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+	if (!fsl_desc->iscyclic)
+		tx->tx_submit = fsl_edma_tx_submit;
+	return tx;
 }
 
 struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
@@ -788,9 +857,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		unsigned long flags, void *context)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	dma_addr_t src_addr, dst_addr, last_sg;
+	struct dma_async_tx_descriptor *tx;
 	struct fsl_edma_desc *fsl_desc;
 	struct scatterlist *sg;
-	dma_addr_t src_addr, dst_addr, last_sg;
 	u16 soff, doff, iter;
 	u32 nbytes;
 	int i;
@@ -882,7 +952,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		}
 	}
 
-	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+	tx = vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+	tx->tx_submit = fsl_edma_tx_submit;
+
+	return tx;
 }
 
 struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
@@ -924,9 +997,12 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 	if (!vdesc)
 		return;
 	fsl_chan->edesc = to_fsl_edma_desc(vdesc);
-	fsl_edma_set_tcd_regs(fsl_chan, fsl_chan->edesc->tcd[0].vtcd);
-	fsl_edma_enable_request(fsl_chan);
-	fsl_chan->status = DMA_IN_PROGRESS;
+
+	if (fsl_chan->status != DMA_IN_PROGRESS) {
+		fsl_edma_set_tcd_regs(fsl_chan, fsl_chan->edesc->tcd[0].vtcd);
+		fsl_edma_enable_request(fsl_chan);
+		fsl_chan->status = DMA_IN_PROGRESS;
+	}
 }
 
 void fsl_edma_issue_pending(struct dma_chan *chan)
diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
index d3541301a247..ac319d2dbb90 100644
--- a/drivers/dma/fsl-edma-trace.h
+++ b/drivers/dma/fsl-edma-trace.h
@@ -119,6 +119,11 @@ DEFINE_EVENT(edma_log_tcd, edma_fill_tcd,
 	TP_ARGS(chan, tcd)
 );
 
+DEFINE_EVENT(edma_log_tcd, edma_link_sg,
+	     TP_PROTO(struct fsl_edma_chan *chan, void *tcd),
+	     TP_ARGS(chan, tcd)
+);
+
 #endif
 
 /* this part must be outside header guard */

-- 
2.54.0


