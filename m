Return-Path: <dmaengine+bounces-6419-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D79B462AB
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 20:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B695E0EAC
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848D1283FF7;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE1WC3xm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA727FD59;
	Fri,  5 Sep 2025 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098131; cv=none; b=eDnbLwNYq2SQ84Vg6VFokSH/P9MFoAiWYNJe9ZhmnJj/Ww+urRp5Oecd3GTfVlc+vxkTlLvXz/iRN/C9rLsu1AWAzx/8tUQrAsiChlTeimtf/mp4gLI3bS/MY0//vbNrnkcDtM2qpSmLdtaGj76xA8Ud9FTyfQ8HvQ6BTcNaOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098131; c=relaxed/simple;
	bh=lxQ0PBEDBMqbgoT/wr1UNF+vxzeTB+WN2igvu5+vg6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzcFcJQPqbWVgX68bRAuhnviRHgmGUT2R71LT4nK2QsXxdnArg+ZfroraBUxo1W8xJK6n9XSRNOTVue7T8ytCiO8pyXmr88sNO1FjhB8y5XcwGMmT3Oli3hwl6M+YOgdGBvnUELpo0Q5ANgM0R14ufCTlK6YmqlmNVjCfyO6TFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE1WC3xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBC21C116C6;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098131;
	bh=lxQ0PBEDBMqbgoT/wr1UNF+vxzeTB+WN2igvu5+vg6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hE1WC3xmZOriWPx1nFi9okT2uGF1/1Q+RqVPaui5po+4SGVDcHAEwZAqStQ9GwVdq
	 /pxGhj4812kVjnoZA6v2COMq5EDi1AcoxuN03j+etgEo8DA32i0c35o9u2drz3IOLX
	 luK3nR23OcraTEWwZRCJcNy8hyx3TmbXm+wfh4Y9RTf6ZoljYiPt3NGxjpB+QsZQg8
	 bQ2gsPa2Cq3EEGcSMf8n3px5q8bFSg2OVLxYx6DQWLBIctOuW5QsolmSDBPM1z3250
	 iELolA5fIqtCs2Hp1g7KyLBuIAZj8ATAv/KouLP1QjCoSW4H3oLw6BKiLywRfksnDe
	 PFch8us+j/WNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A72CA101F;
	Fri,  5 Sep 2025 18:48:50 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 05 Sep 2025 13:48:34 -0500
Subject: [PATCH RFC 11/13] dmaengine: sdxi: Add DMA engine provider
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sdxi-base-v1-11-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
In-Reply-To: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757098129; l=12485;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=oicl0mAaS0xJnaRPITeh2PX2Yd+o4ZUX9+VqlDQ+2I4=;
 b=f4JgqMzOx0UfzHT/2tsJX1m9aMQnsbM3C/SEsrWL3bisPI70rFtEUkflIwWzjP81qRMg3/eng
 c3EzrtwAx24A2JEqJZ9kUp98FqdzqzzDg3ssgmcxTEy18QSEczJgu7x
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Add support for memcpy and interrupt capabilities. Register one
channel per SDXI function discovered for now.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/device.c |   4 +
 drivers/dma/sdxi/dma.c    | 409 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.h    |  12 ++
 3 files changed, 425 insertions(+)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index 61123bc1d47b6547538b6e783ad96a9c2851494e..e5e1593189993717cae311906885ae268385b28d 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -18,6 +18,7 @@
 
 #include "context.h"
 #include "descriptor.h"
+#include "dma.h"
 #include "hw.h"
 #include "error.h"
 #include "sdxi.h"
@@ -354,6 +355,8 @@ int sdxi_device_init(struct sdxi_dev *sdxi, const struct sdxi_dev_ops *ops)
 	if (err)
 		goto fn_stop;
 
+	sdxi_dma_register(sdxi->dma_cxt);
+
 	return 0;
 fn_stop:
 	sdxi_stop(sdxi);
@@ -362,6 +365,7 @@ int sdxi_device_init(struct sdxi_dev *sdxi, const struct sdxi_dev_ops *ops)
 
 void sdxi_device_exit(struct sdxi_dev *sdxi)
 {
+	sdxi_dma_unregister(sdxi->dma_cxt);
 	sdxi_working_cxt_exit(sdxi->dma_cxt);
 
 	/* Walk sdxi->cxt_array freeing any allocated rows. */
diff --git a/drivers/dma/sdxi/dma.c b/drivers/dma/sdxi/dma.c
new file mode 100644
index 0000000000000000000000000000000000000000..ad8515deba53898b2b4ea0d38c40042b566abe1f
--- /dev/null
+++ b/drivers/dma/sdxi/dma.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SDXI DMA engine implementation
+ *   Derived from ptdma code
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+
+#include "../dmaengine.h"
+#include "context.h"
+#include "descriptor.h"
+#include "dma.h"
+#include "sdxi.h"
+
+struct sdxi_dma_desc {
+	struct virt_dma_desc vd;
+	struct sdxi_cxt *cxt;
+	enum dma_status status;
+	bool issued_to_hw;
+	struct sdxi_cmd sdxi_cmd;
+};
+
+static inline struct sdxi_dma_chan *to_sdxi_dma_chan(struct dma_chan *dma_chan)
+{
+	return container_of(dma_chan, struct sdxi_dma_chan, vc.chan);
+}
+
+static inline struct sdxi_dma_desc *to_sdxi_dma_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct sdxi_dma_desc, vd);
+}
+
+static void sdxi_dma_free_chan_resources(struct dma_chan *dma_chan)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+
+	vchan_free_chan_resources(&chan->vc);
+	/* NB: more configure with sdxi_cxt? */
+}
+
+static void sdxi_dma_synchronize(struct dma_chan *c)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(c);
+
+	vchan_synchronize(&chan->vc);
+}
+
+static void sdxi_do_cleanup(struct virt_dma_desc *vd)
+{
+	struct sdxi_dma_desc *dma_desc = to_sdxi_dma_desc(vd);
+	struct sdxi_cmd *cmd = &dma_desc->sdxi_cmd;
+	struct device *dev = sdxi_to_dev(dma_desc->cxt->sdxi);
+
+	dma_free_coherent(dev, sizeof(*cmd->cst_blk),
+			  cmd->cst_blk, cmd->cst_blk_dma);
+	kfree(dma_desc);
+}
+
+static int sdxi_dma_start_desc(struct sdxi_dma_desc *dma_desc)
+{
+	struct sdxi_dev *sdxi;
+	struct sdxi_cmd *sdxi_cmd;
+	struct sdxi_cxt *cxt;
+	struct sdxi_desc desc;
+	struct sdxi_copy copy;
+	struct sdxi_cst_blk *cst_blk;
+	dma_addr_t cst_blk_dma;
+	int err;
+
+	sdxi_cmd = &dma_desc->sdxi_cmd;
+	sdxi = sdxi_cmd->cxt->sdxi;
+
+	cxt = dma_desc->cxt;
+
+	if (sdxi_cmd->len > MAX_DMA_COPY_BYTES)
+		return -EINVAL;
+
+	copy = (typeof(copy)) {
+		.src = sdxi_cmd->src_addr,
+		.dst = sdxi_cmd->dst_addr,
+		.src_akey = 0,
+		.dst_akey = 0,
+		.len = sdxi_cmd->len,
+	};
+
+	err = sdxi_encode_copy(&desc, &copy);
+	if (err)
+		return err;
+
+	err = sdxi_encode_copy(&desc, &copy);
+	if (err)
+		return err;
+
+	/* FIXME convert to pool */
+	cst_blk = dma_alloc_coherent(sdxi_to_dev(sdxi), sizeof(*cst_blk),
+				     &cst_blk_dma, GFP_NOWAIT);
+	if (!cst_blk)
+		return -ENOMEM;
+
+	cst_blk->signal = cpu_to_le64(0xff);
+
+	sdxi_cmd->cst_blk = cst_blk;
+	sdxi_cmd->cst_blk_dma = cst_blk_dma;
+	sdxi_cmd->ret = 0; /* TODO: get desc submit status & update ret value */
+
+	sdxi_desc_set_csb(&desc, cst_blk_dma);
+	err = sdxi_submit_desc(cxt, &desc);
+	if (err)
+		goto free_cst_blk;
+
+	sdxi->tdata.cmd = sdxi_cmd; /* FIXME: this is not compatible w/multiple clients */
+	dma_desc->issued_to_hw = 1;
+	return 0;
+free_cst_blk:
+	dma_free_coherent(sdxi_to_dev(sdxi), sizeof(*cst_blk),
+			  cst_blk, cst_blk_dma);
+	return err;
+}
+
+static struct sdxi_dma_desc *sdxi_next_dma_desc(struct sdxi_dma_chan *chan)
+{
+	/* Get the next DMA descriptor on the active list */
+	struct virt_dma_desc *vd = vchan_next_desc(&chan->vc);
+
+	return vd ? to_sdxi_dma_desc(vd) : NULL;
+}
+
+static struct sdxi_dma_desc *sdxi_handle_active_desc(struct sdxi_dma_chan *chan,
+						     struct sdxi_dma_desc *desc)
+{
+	struct dma_async_tx_descriptor *tx_desc;
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+
+	/* Loop over descriptors until one is found with commands */
+	do {
+		if (desc) {
+			if (!desc->issued_to_hw) {
+				/* No errors, keep going */
+				if (desc->status != DMA_ERROR)
+					return desc;
+			}
+
+			tx_desc = &desc->vd.tx;
+			vd = &desc->vd;
+		} else {
+			tx_desc = NULL;
+		}
+
+		spin_lock_irqsave(&chan->vc.lock, flags);
+
+		if (desc) {
+
+			if (desc->status != DMA_COMPLETE) {
+				if (desc->status != DMA_ERROR)
+					desc->status = DMA_COMPLETE;
+
+				dma_cookie_complete(tx_desc);
+				dma_descriptor_unmap(tx_desc);
+				list_del(&desc->vd.node);
+			} else {
+				/* Don't handle it twice */
+				tx_desc = NULL;
+			}
+		}
+
+		desc = sdxi_next_dma_desc(chan);
+
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+		if (tx_desc) {
+			dmaengine_desc_get_callback_invoke(tx_desc, NULL);
+			dma_run_dependencies(tx_desc);
+			vchan_vdesc_fini(vd);
+		}
+	} while (desc);
+
+	return NULL;
+}
+
+static void sdxi_cmd_callback(void *data, int err)
+{
+	struct sdxi_dma_desc *desc = data;
+	struct dma_chan *dma_chan;
+	struct sdxi_dma_chan *chan;
+	int ret;
+
+	if (err == -EINPROGRESS)
+		return;
+
+	dma_chan = desc->vd.tx.chan;
+	chan = to_sdxi_dma_chan(dma_chan);
+
+	if (err)
+		desc->status = DMA_ERROR;
+
+	while (true) {
+		/* Check for DMA descriptor completion */
+		desc = sdxi_handle_active_desc(chan, desc);
+
+		/* Don't submit cmd if no descriptor or DMA is paused */
+		if (!desc)
+			break;
+
+		ret = sdxi_dma_start_desc(desc);
+		if (!ret)
+			break;
+
+		desc->status = DMA_ERROR;
+	}
+}
+
+static struct sdxi_dma_desc *sdxi_dma_alloc_dma_desc(struct sdxi_dma_chan *chan,
+						     unsigned long flags)
+{
+	struct sdxi_dma_desc *desc;
+
+	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	desc->cxt = chan->cxt;
+
+	vchan_tx_prep(&chan->vc, &desc->vd, flags);
+
+	desc->cxt->sdxi = chan->cxt->sdxi;
+	desc->issued_to_hw = 0;
+	desc->status = DMA_IN_PROGRESS;
+
+	return desc;
+}
+
+static struct sdxi_dma_desc *sdxi_dma_create_desc(struct dma_chan *dma_chan,
+						  dma_addr_t dst,
+						  dma_addr_t src,
+						  unsigned int len,
+						  unsigned long flags)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+	struct sdxi_dma_desc *desc;
+	struct sdxi_cmd *sdxi_cmd;
+
+	desc = sdxi_dma_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	sdxi_cmd = &desc->sdxi_cmd;
+	sdxi_cmd->cxt = chan->cxt;
+	sdxi_cmd->cxt->sdxi = chan->cxt->sdxi;
+	sdxi_cmd->src_addr = src;
+	sdxi_cmd->dst_addr = dst;
+	sdxi_cmd->len = len;
+	sdxi_cmd->sdxi_cmd_callback = sdxi_cmd_callback;
+	sdxi_cmd->data = desc;
+
+	return desc;
+}
+
+static struct dma_async_tx_descriptor *
+sdxi_dma_prep_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
+		     dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct sdxi_dma_desc *desc;
+
+	desc = sdxi_dma_create_desc(dma_chan, dst, src, len, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->vd.tx;
+}
+
+static struct dma_async_tx_descriptor *
+sdxi_prep_dma_interrupt(struct dma_chan *dma_chan, unsigned long flags)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+	struct sdxi_dma_desc *desc;
+
+	desc = sdxi_dma_alloc_dma_desc(chan, flags);
+	if (!desc)
+		return NULL;
+
+	return &desc->vd.tx;
+}
+
+static void sdxi_dma_issue_pending(struct dma_chan *dma_chan)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+	struct sdxi_dma_desc *desc;
+	unsigned long flags;
+	bool engine_is_idle = true;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
+	desc = sdxi_next_dma_desc(chan);
+	if (desc)
+		engine_is_idle = false;
+
+	vchan_issue_pending(&chan->vc);
+
+	desc = sdxi_next_dma_desc(chan);
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	/* If there was nothing active, start processing */
+	if (engine_is_idle)
+		sdxi_cmd_callback(desc, 0);
+}
+
+static void sdxi_check_trans_status(struct sdxi_dma_chan *chan)
+{
+	struct sdxi_cxt *cxt = chan->cxt;
+	struct sdxi_cmd *cmd;
+
+	if (!cxt)
+		return;
+
+	cmd = cxt->sdxi->tdata.cmd;
+
+	if (le64_to_cpu(cmd->cst_blk->signal) == 0xfe)
+		sdxi_cmd_callback(cmd->data, cmd->ret);
+}
+
+static enum dma_status sdxi_tx_status(struct dma_chan *dma_chan, dma_cookie_t cookie,
+				      struct dma_tx_state *tx_state)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+
+	sdxi_check_trans_status(chan);
+
+	return dma_cookie_status(dma_chan, cookie, tx_state);
+}
+
+static int sdxi_dma_terminate_all(struct dma_chan *dma_chan)
+{
+	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	vchan_get_all_descriptors(&chan->vc, &head);
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	vchan_dma_desc_free_list(&chan->vc, &head);
+	vchan_free_chan_resources(&chan->vc);
+
+	return 0;
+}
+
+int sdxi_dma_register(struct sdxi_cxt *dma_cxt)
+{
+	struct sdxi_dma_chan *chan;
+	struct sdxi_dev *sdxi = dma_cxt->sdxi;
+	struct device *dev = sdxi_to_dev(sdxi);
+	struct dma_device *dma_dev = &sdxi->dma_dev;
+	int ret = 0;
+
+	sdxi->sdxi_dma_chan = devm_kzalloc(dev, sizeof(*sdxi->sdxi_dma_chan),
+					   GFP_KERNEL);
+	if (!sdxi->sdxi_dma_chan)
+		return -ENOMEM;
+
+	sdxi->sdxi_dma_chan->cxt = dma_cxt;
+
+	dma_dev->dev = dev;
+	dma_dev->src_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
+	dma_dev->dst_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
+	dma_dev->directions = BIT(DMA_MEM_TO_MEM);
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
+	dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
+
+	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
+
+	INIT_LIST_HEAD(&dma_dev->channels);
+
+	chan = sdxi->sdxi_dma_chan;
+	chan->cxt->sdxi = sdxi;
+
+	/* Set base and prep routines */
+	dma_dev->device_free_chan_resources = sdxi_dma_free_chan_resources;
+	dma_dev->device_prep_dma_memcpy = sdxi_dma_prep_memcpy;
+	dma_dev->device_prep_dma_interrupt = sdxi_prep_dma_interrupt;
+	dma_dev->device_issue_pending = sdxi_dma_issue_pending;
+	dma_dev->device_tx_status = sdxi_tx_status;
+	dma_dev->device_terminate_all = sdxi_dma_terminate_all;
+	dma_dev->device_synchronize = sdxi_dma_synchronize;
+
+	chan->vc.desc_free = sdxi_do_cleanup;
+	vchan_init(&chan->vc, dma_dev);
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+
+	ret = dma_async_device_register(dma_dev);
+	if (ret)
+		goto err_reg;
+
+	return 0;
+
+err_reg:
+	return ret;
+}
+
+void sdxi_dma_unregister(struct sdxi_cxt *dma_cxt)
+{
+	dma_async_device_unregister(&dma_cxt->sdxi->dma_dev);
+}
diff --git a/drivers/dma/sdxi/dma.h b/drivers/dma/sdxi/dma.h
new file mode 100644
index 0000000000000000000000000000000000000000..cdea77cd274043a76b658fa93716f6cea2867216
--- /dev/null
+++ b/drivers/dma/sdxi/dma.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Advanced Micro Devices, Inc. */
+
+#ifndef DMA_SDXI_DMA_H
+#define DMA_SDXI_DMA_H
+
+struct sdxi_cxt;
+
+int sdxi_dma_register(struct sdxi_cxt *dma_cxt);
+void sdxi_dma_unregister(struct sdxi_cxt *dma_cxt);
+
+#endif /* DMA_SDXI_DMA_H */

-- 
2.39.5



