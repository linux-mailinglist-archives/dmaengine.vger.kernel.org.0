Return-Path: <dmaengine+bounces-10232-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLWYId1P+2mSZQMAu9opvQ
	(envelope-from <dmaengine+bounces-10232-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:27:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7AD4DC28E
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9EEB313002A
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20751480DD5;
	Wed,  6 May 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gg2YnvfC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEAF47F2C4;
	Wed,  6 May 2026 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076651; cv=none; b=KXuYNk+VoEIVJJfPueVbPp/M5ye/qSMoYsSWxP9uAJAfXE7nQwJcD27k95yIoIPvgGv1XIpTiQufmPd0N4HpnWEyxbWea5hNnwT8VuNYvl0HWCZaFF4Nqjhi7nO36stM9XHi3m5y7bGT9PI2RvZjVenylPt+GCoiZw+rruM49m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076651; c=relaxed/simple;
	bh=F9x43ZEfRU7wK83sMqGbjCkgc03IOGpd8Al76pMWLN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hYbmDuWSlnXY+E++LABhDXA+Mf0NhpHE9Zu1/40hIjs9ElRJwr6e1n1jGjk3LDHU+eX6PS/yaBjWbdda+rXUgvGXvu5mqv9O4PXM5Ck8JwM+WKkrJ8EoosyVpgKuhv/ClCXNUxjEvALqxKvHZkr7u4SRxKzjs85CXJrDbigu8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gg2YnvfC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 38BE81A3551;
	Wed,  6 May 2026 14:10:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E2A16053C;
	Wed,  6 May 2026 14:10:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87D4C107F1644;
	Wed,  6 May 2026 16:10:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778076647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oIGsjd/LijliH2kV2hyJFY2dEYw5fLzhdT3QlZJobf4=;
	b=Gg2YnvfCzTmyJlxv3sllWicBiCSCFKpJ/hcZbrYaNJArPV0bwNA2kju0Sqblfl3FkIQgfk
	NZz5kuHR7Y8emHbSwGgHq5nhysU+cbNbZgPRoVrjNV2LbvyydSLH0AWvDYK3oE0hKsAiDn
	D5Fz9TiOe1wIc706oRNKSh2dLFvR0g4ffYnevOYNk/vO11E7FPrtlKt8YcTp0bMiAgTbj8
	t5+jV6NJ1rkl6bEVhj0fEvg9oIiK1LPUWK+QkKXjZQAV2hD8CfSnKfU0RLTK3gsyDo2z8B
	6MhWMldMC9spu3qZFx5n+6q1Vl9plSrnQmmbfnXd8WoqF0WHat8LQN918Sa2Vg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Wed, 06 May 2026 16:10:35 +0200
Subject: [PATCH v2 1/2] dmaengine: fsl-edma: Implement
 device_prep_peripheral_dma_vec
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-fsl-edma-dyn-sg-v2-1-66439cdd414e@bootlin.com>
References: <20260506-fsl-edma-dyn-sg-v2-0-66439cdd414e@bootlin.com>
In-Reply-To: <20260506-fsl-edma-dyn-sg-v2-0-66439cdd414e@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: DF7AD4DC28E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-10232-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

Add implementation of .device_prep_peripheral_dma_vec() callback to setup
a scatter/gather DMA transfer from an array of dma_vec structures. Setup
a cyclic transfer if the DMA_PREP_REPEAT flag is set.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/dma/fsl-edma-common.c | 110 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-common.h |   4 ++
 drivers/dma/fsl-edma-main.c   |   2 +
 3 files changed, 116 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index bb7531c456df..26a5ecf493b9 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -673,6 +673,116 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
 
+struct dma_async_tx_descriptor *fsl_edma_prep_peripheral_dma_vec(
+		struct dma_chan *chan, const struct dma_vec *vecs,
+		size_t nb, enum dma_transfer_direction direction,
+		unsigned long flags)
+{
+	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	struct fsl_edma_desc *fsl_desc;
+	dma_addr_t src_addr, dst_addr, last_sg;
+	u16 soff, doff, iter;
+	u32 nbytes;
+	int i;
+
+	if (!is_slave_direction(direction))
+		return NULL;
+
+	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
+		return NULL;
+
+	fsl_desc = fsl_edma_alloc_desc(fsl_chan, nb);
+	if (!fsl_desc)
+		return NULL;
+	fsl_desc->iscyclic = flags & DMA_PREP_REPEAT;
+	fsl_desc->dirn = direction;
+
+	if (direction == DMA_MEM_TO_DEV) {
+		if (!fsl_chan->cfg.src_addr_width)
+			fsl_chan->cfg.src_addr_width = fsl_chan->cfg.dst_addr_width;
+		fsl_chan->attr =
+			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
+					      fsl_chan->cfg.dst_addr_width);
+		nbytes = fsl_chan->cfg.dst_addr_width *
+			fsl_chan->cfg.dst_maxburst;
+	} else {
+		if (!fsl_chan->cfg.dst_addr_width)
+			fsl_chan->cfg.dst_addr_width = fsl_chan->cfg.src_addr_width;
+		fsl_chan->attr =
+			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
+					      fsl_chan->cfg.dst_addr_width);
+		nbytes = fsl_chan->cfg.src_addr_width *
+			fsl_chan->cfg.src_maxburst;
+	}
+
+	for (i = 0; i < nb; i++) {
+		if (direction == DMA_MEM_TO_DEV) {
+			src_addr = vecs[i].addr;
+			dst_addr = fsl_chan->dma_dev_addr;
+			soff = fsl_chan->cfg.dst_addr_width;
+			doff = 0;
+		} else if (direction == DMA_DEV_TO_MEM) {
+			src_addr = fsl_chan->dma_dev_addr;
+			dst_addr = vecs[i].addr;
+			soff = 0;
+			doff = fsl_chan->cfg.src_addr_width;
+		} else {
+			/* DMA_DEV_TO_DEV */
+			src_addr = fsl_chan->cfg.src_addr;
+			dst_addr = fsl_chan->cfg.dst_addr;
+			soff = 0;
+			doff = 0;
+		}
+
+		/*
+		 * Choose the suitable burst length if dma_vec length is not
+		 * multiple of burst length so that the whole transfer length is
+		 * multiple of minor loop(burst length).
+		 */
+		if (vecs[i].len % nbytes) {
+			u32 width = (direction == DMA_DEV_TO_MEM) ? doff : soff;
+			u32 burst = (direction == DMA_DEV_TO_MEM) ?
+						fsl_chan->cfg.src_maxburst :
+						fsl_chan->cfg.dst_maxburst;
+			int j;
+
+			for (j = burst; j > 1; j--) {
+				if (!(vecs[i].len % (j * width))) {
+					nbytes = j * width;
+					break;
+				}
+			}
+			/* Set burst size as 1 if there's no suitable one */
+			if (j == 1)
+				nbytes = width;
+		}
+		iter = vecs[i].len / nbytes;
+		if (i < nb - 1) {
+			last_sg = fsl_desc->tcd[(i + 1)].ptcd;
+			fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
+					  dst_addr, fsl_chan->attr, soff,
+					  nbytes, 0, iter, iter, doff, last_sg,
+					  false, false, true);
+		} else {
+			if (fsl_desc->iscyclic) {
+				last_sg = fsl_desc->tcd[0].ptcd;
+				fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
+						  dst_addr, fsl_chan->attr, soff,
+						  nbytes, 0, iter, iter, doff, last_sg,
+						  true, false, true);
+			} else {
+				last_sg = 0;
+				fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
+						  dst_addr, fsl_chan->attr, soff,
+						  nbytes, 0, iter, iter, doff, last_sg,
+						  true, true, false);
+			}
+		}
+	}
+
+	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+}
+
 struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 205a96489094..0d028048701d 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -496,6 +496,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
 		unsigned long flags);
+struct dma_async_tx_descriptor *fsl_edma_prep_peripheral_dma_vec(
+		struct dma_chan *chan, const struct dma_vec *vecs,
+		size_t nb, enum dma_transfer_direction direction,
+		unsigned long flags);
 struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 36155ab1602a..6693b4270a1a 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -841,6 +841,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.device_free_chan_resources
 		= fsl_edma_free_chan_resources;
 	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
+	fsl_edma->dma_dev.device_prep_peripheral_dma_vec
+		= fsl_edma_prep_peripheral_dma_vec;
 	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
 	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
 	fsl_edma->dma_dev.device_prep_dma_memcpy = fsl_edma_prep_memcpy;

-- 
2.54.0


