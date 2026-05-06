Return-Path: <dmaengine+bounces-10233-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O/gOuBN+2nWYwMAu9opvQ
	(envelope-from <dmaengine+bounces-10233-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:19:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A7C4DBFBE
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8186630EC31F
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89157481231;
	Wed,  6 May 2026 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nykStisR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E447F2E4;
	Wed,  6 May 2026 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076652; cv=none; b=BMrk+rXJqoV8vEjfIRZ7f+PLRuowbf9NF+v0tO5UqQHz5TDvc9WbdKYBYEx/JQGZhTT65rnVvu9OrCd87tD3BEYCJicDPtSdfRun/MDSRJBVfzCbDK2DcgiagUuR9suYyAp4Rw1ZzVMjkJ+FNRSrU/nQyFoe0MGC2pvboa9G6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076652; c=relaxed/simple;
	bh=1bwhwdfvJlIzsKkfaxkktge9gzD6L0rgkayWyCUNTsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k238fhRLz/t319EXTgXBRchvxZLCAK7yzv2iBKRq/qWheF1eyEHXqIf+RBFvGYH0ed/09vKkdjtDSsboN8NBji5ckeXfjXwmTq/kZs0hNYHK55DEX3+yyJIZCqfRlUelqXgWlO0v4jEWKgmtOdb8SkkogX+UabuO/uedSlCRSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nykStisR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 89D254E42C0A;
	Wed,  6 May 2026 14:10:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5FF9F6053C;
	Wed,  6 May 2026 14:10:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 851E4107F1B41;
	Wed,  6 May 2026 16:10:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778076648; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aQaOLDa6vezVg2B4JDopiCIwlU8Ntmkdr40yY+rXlOE=;
	b=nykStisR8Wi7ZQ9Eb4vjpnhsyAWt3tF0zF/p60/x5QJHZwFpkegkv5N8ceOoUo8issltIk
	3SX+bnsEmM6s5XU5Pj4GipTPb7nbhr9ZpJUabTYepuTNwplZvWmQhTQMblDmEWJylFkDbm
	cA8cnu8+3K+ooJTnedPeg47XOu7qOLVcMZtwGG/Uymvhf0Si6Xy+eMpdyPd/dHI8jOonyw
	boSDKMS3CNDwSj+L2TFzsviBEuCPe2oZnSs+VcYLd8OViURCumqgeiDqwg6yo3drrKhZPT
	E2bDdCx/+6ZnZvNawGpqOsLakUeerMcqV4K6DxyeuRtvEtMZOcbF7l1H+5aj7Q==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 06 May 2026 16:10:36 +0200
Subject: [PATCH v2 2/2] dmaengine: fsl-edma: Support dynamic scatter/gather
 chaining
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-fsl-edma-dyn-sg-v2-2-66439cdd414e@bootlin.com>
References: <20260506-fsl-edma-dyn-sg-v2-0-66439cdd414e@bootlin.com>
In-Reply-To: <20260506-fsl-edma-dyn-sg-v2-0-66439cdd414e@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 65A7C4DBFBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-10233-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

Implement dynamic linking of scatter/gather transfers to enable
chaining multiple DMA descriptors without stopping the channel.
This avoids waiting for the channel to go idle if there is another
transaction already issued.

Add fsl_edma_link_sg() to dynamically link the last TCD of a previously
submitted descriptor to the first TCD of a new descriptor by setting
the scatter/gather address and the E_SG flag, and keeping the channel
active by clearing the DREQ bit.

Linking is only done if the last TCD was set to disable the DMA channel,
to prevent corrupting cyclic transaction.

Update fsl_edma_xfer_desc() to avoid re-initializing the hardware when a
transfer is already in progress, allowing seamless chaining of descriptors.

Modify the transfer completion handler to check the DONE flag in the
channel CSR before marking the transfer complete. Since this flag is
only available on SoC with the split registers layout, we only link
transactions for DMA controllers flagged with FSL_EDMA_DRV_SPLIT_REG.

Add trace event for scatter/gather linking operations.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/dma/fsl-edma-common.c | 64 ++++++++++++++++++++++++++++++++++++++++---
 drivers/dma/fsl-edma-trace.h  |  5 ++++
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 26a5ecf493b9..7094c747defa 100644
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
@@ -673,6 +676,51 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
 
+static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fsl_edma_desc *fsl_desc)
+{
+	u32 flags = fsl_edma_drvflags(fsl_chan);
+	struct virt_dma_desc *vdesc;
+	struct fsl_edma_desc *prev_desc;
+	struct fsl_edma_hw_tcd *last_tcd;
+	u16 csr;
+
+	if (!(flags & FSL_EDMA_DRV_SPLIT_REG))
+		return;
+
+	guard(spinlock_irqsave)(&fsl_chan->vchan.lock);
+
+	vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
+					struct virt_dma_desc, node);
+	if (!vdesc)
+		vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
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
+
+	csr &= ~EDMA_TCD_CSR_D_REQ;
+	csr |= EDMA_TCD_CSR_E_SG;
+	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, csr, csr);
+
+	if (prev_desc == fsl_chan->edesc && prev_desc->n_tcds == 1) {
+		if (flags & FSL_EDMA_DRV_CLEAR_DONE_E_SG)
+			edma_writel_chreg(fsl_chan, edma_readl_chreg(fsl_chan, ch_csr), ch_csr);
+
+		edma_cp_tcd_to_reg(fsl_chan, last_tcd, dlast_sga);
+		edma_cp_tcd_to_reg(fsl_chan, last_tcd, csr);
+	}
+
+	trace_edma_link_sg(fsl_chan, last_tcd);
+}
+
 struct dma_async_tx_descriptor *fsl_edma_prep_peripheral_dma_vec(
 		struct dma_chan *chan, const struct dma_vec *vecs,
 		size_t nb, enum dma_transfer_direction direction,
@@ -780,6 +828,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_peripheral_dma_vec(
 		}
 	}
 
+	if (!fsl_desc->iscyclic)
+		fsl_edma_link_sg(fsl_chan, fsl_desc);
+
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
 
@@ -883,6 +934,8 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		}
 	}
 
+	fsl_edma_link_sg(fsl_chan, fsl_desc);
+
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
 
@@ -925,9 +978,12 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
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


