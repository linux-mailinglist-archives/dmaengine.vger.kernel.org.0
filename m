Return-Path: <dmaengine+bounces-563-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D196816CFD
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 12:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5F41F2641A
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 11:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C24184B;
	Mon, 18 Dec 2023 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="LB3tR+cW"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FF41C77;
	Mon, 18 Dec 2023 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 42AB22D01870;
	Mon, 18 Dec 2023 12:40:53 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id b4PkjW2spXRO; Mon, 18 Dec 2023 12:40:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id C38432D0186E;
	Mon, 18 Dec 2023 12:40:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl C38432D0186E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702899652;
	bh=sNlYkcgYiPMz7Dv9ePNXS0ND3ebl+/k4wfQd6xyfH1Q=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=LB3tR+cWMWKw8sGtUwzCLnqxaP2eZnmkd9BdLVuDyVqxY58NMWvoKLRFu/U+GgfTZ
	 67crnMKyCITrMKmaIqvbOLLPwzg0n6uoOyCbEcAuqrKaGS4W8QdGApnyddx5rG24tF
	 FI/LZLtiS5CQNKCcbVC4qzH6Va+uHZxDV+0JnZ8yYkAw4Ur+xcKBC4lIib6wAYc3el
	 dC8UnBMTB4ZJVaiwMzwDCaq0LuRJrazFj9zcaFMJSYhuZboRle+TaKr4sg0Row5Zg9
	 6oAPoyBRfrIgKy/hZe7RtA+Y2t4KHETLsbbWNbFRd5ZS97LVhNBrSY3+qVh9z79TzV
	 gud0kupY2l2uQ==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lAfsM8nc3qpc; Mon, 18 Dec 2023 12:40:52 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 8D8E32D01868;
	Mon, 18 Dec 2023 12:40:52 +0100 (CET)
From: Jan Kuliga <jankul@alatek.krakow.pl>
To: lizhi.hou@amd.com,
	brian.xu@amd.com,
	raj.kumar.rampelli@amd.com,
	vkoul@kernel.org,
	michal.simek@amd.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com
Cc: jankul@alatek.krakow.pl
Subject: [PATCH v5 8/8] dmaengine: xilinx: xdma: Implement interleaved DMA transfers
Date: Mon, 18 Dec 2023 12:39:43 +0100
Message-Id: <20231218113943.9099-9-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113904.9071-1-jankul@alatek.krakow.pl>
References: <20231218113904.9071-1-jankul@alatek.krakow.pl>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Interleaved DMA functionality allows dmaengine clients' to express
DMA transfers in an arbitrary way. This is extremely useful in FPGA
environments, where a greater transfer flexibility is needed. For
instance, in one FPGA design there may be need to do DMA to/from a FIFO
at a fixed address, and also to do DMA to/from a (non)contiguous RAM
memory.

Introduce separate tx preparation callback and add tx-flags handling
logic. Their behavior is based on the description of interleaved DMA
transfers in both source code and the DMAEngine's documentation.

Since XDMA is a fully-fledged scatter-gather dma engine, the logic of
xdma_prep_interleaved_dma() is fairly simple and similar to the other
tx preparation callbacks. The whole tx-flags handling logic resides in
xdma_channel_isr(). Transfer of a single frame from a interleaved DMA
transfer template is pretty similar to the single sg transaction.
Therefore, the transaction of the whole interleaved DMA transfer
template is basically a cyclic dma transaction with finite cycles/periods
(equal to the frame of count) of a single sg transfers.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma.c | 107 ++++++++++++++++++++++++++++++++++----
 1 file changed, 98 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 618cc9af6eb9..9360b85131ef 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -83,8 +83,10 @@ struct xdma_chan {
  * @desc_num: Number of hardware descriptors
  * @completed_desc_num: Completed hardware descriptors
  * @cyclic: Cyclic transfer vs. scatter-gather
+ * @interleaved_dma: Interleaved DMA transfer
  * @periods: Number of periods in the cyclic transfer
  * @period_size: Size of a period in bytes in cyclic transfers
+ * @frames_left: Number of frames left in interleaved DMA transfer
  * @error: tx error flag
  */
 struct xdma_desc {
@@ -96,8 +98,10 @@ struct xdma_desc {
 	u32				desc_num;
 	u32				completed_desc_num;
 	bool				cyclic;
+	bool				interleaved_dma;
 	u32				periods;
 	u32				period_size;
+	u32				frames_left;
 	bool				error;
 };
=20
@@ -607,6 +611,8 @@ xdma_prep_device_sg(struct dma_chan *chan, struct sca=
tterlist *sgl,
 	if (!sw_desc)
 		return NULL;
 	sw_desc->dir =3D dir;
+	sw_desc->cyclic =3D false;
+	sw_desc->interleaved_dma =3D false;
=20
 	if (dir =3D=3D DMA_MEM_TO_DEV) {
 		dev_addr =3D xdma_chan->cfg.dst_addr;
@@ -682,6 +688,7 @@ xdma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_=
t address,
 	sw_desc->periods =3D periods;
 	sw_desc->period_size =3D period_size;
 	sw_desc->dir =3D dir;
+	sw_desc->interleaved_dma =3D false;
=20
 	addr =3D address;
 	if (dir =3D=3D DMA_MEM_TO_DEV) {
@@ -712,6 +719,57 @@ xdma_prep_dma_cyclic(struct dma_chan *chan, dma_addr=
_t address,
 	return NULL;
 }
=20
+/**
+ * xdma_prep_interleaved_dma - Prepare virtual descriptor for interleave=
d DMA transfers
+ * @chan: DMA channel
+ * @xt: DMA transfer template
+ * @flags: tx flags
+ */
+struct dma_async_tx_descriptor *
+xdma_prep_interleaved_dma(struct dma_chan *chan,
+			  struct dma_interleaved_template *xt,
+			  unsigned long flags)
+{
+	int i;
+	u32 desc_num =3D 0, period_size =3D 0;
+	struct dma_async_tx_descriptor *tx_desc;
+	struct xdma_chan *xchan =3D to_xdma_chan(chan);
+	struct xdma_desc *sw_desc;
+	u64 src_addr, dst_addr;
+
+	for (i =3D 0; i < xt->frame_size; ++i)
+		desc_num +=3D DIV_ROUND_UP(xt->sgl[i].size, XDMA_DESC_BLEN_MAX);
+
+	sw_desc =3D xdma_alloc_desc(xchan, desc_num, false);
+	if (!sw_desc)
+		return NULL;
+	sw_desc->dir =3D xt->dir;
+	sw_desc->interleaved_dma =3D true;
+	sw_desc->cyclic =3D flags & DMA_PREP_REPEAT;
+	sw_desc->frames_left =3D xt->numf;
+	sw_desc->periods =3D xt->numf;
+
+	desc_num =3D 0;
+	src_addr =3D xt->src_start;
+	dst_addr =3D xt->dst_start;
+	for (i =3D 0; i < xt->frame_size; ++i) {
+		desc_num +=3D xdma_fill_descs(sw_desc, src_addr, dst_addr, xt->sgl[i].=
size, desc_num);
+		src_addr +=3D dmaengine_get_src_icg(xt, &xt->sgl[i]) + xt->src_inc ?
+							      xt->sgl[i].size : 0;
+		dst_addr +=3D dmaengine_get_dst_icg(xt, &xt->sgl[i]) + xt->dst_inc ?
+							      xt->sgl[i].size : 0;
+		period_size +=3D xt->sgl[i].size;
+	}
+	sw_desc->period_size =3D period_size;
+
+	tx_desc =3D vchan_tx_prep(&xchan->vchan, &sw_desc->vdesc, flags);
+	if (tx_desc)
+		return tx_desc;
+
+	xdma_free_desc(&sw_desc->vdesc);
+	return NULL;
+}
+
 /**
  * xdma_device_config - Configure the DMA channel
  * @chan: DMA channel
@@ -811,11 +869,12 @@ static irqreturn_t xdma_channel_isr(int irq, void *=
dev_id)
 {
 	struct xdma_chan *xchan =3D dev_id;
 	u32 complete_desc_num =3D 0;
-	struct xdma_device *xdev;
-	struct virt_dma_desc *vd;
+	struct xdma_device *xdev =3D xchan->xdev_hdl;
+	struct virt_dma_desc *vd, *next_vd;
 	struct xdma_desc *desc;
 	int ret;
 	u32 st;
+	bool repeat_tx;
=20
 	spin_lock(&xchan->vchan.lock);
=20
@@ -824,9 +883,6 @@ static irqreturn_t xdma_channel_isr(int irq, void *de=
v_id)
 	if (!vd)
 		goto out;
=20
-	desc =3D to_xdma_desc(vd);
-	xdev =3D xchan->xdev_hdl;
-
 	/* Clear-on-read the status register */
 	ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &st)=
;
 	if (ret)
@@ -845,10 +901,36 @@ static irqreturn_t xdma_channel_isr(int irq, void *=
dev_id)
 	if (ret)
 		goto out;
=20
-	if (desc->cyclic) {
-		desc->completed_desc_num =3D complete_desc_num;
-		vchan_cyclic_callback(vd);
-	} else {
+	desc =3D to_xdma_desc(vd);
+	if (desc->interleaved_dma) {
+		xchan->busy =3D false;
+		desc->completed_desc_num +=3D complete_desc_num;
+		if (complete_desc_num =3D=3D XDMA_DESC_BLOCK_NUM * XDMA_DESC_ADJACENT)=
 {
+			xdma_xfer_start(xchan);
+			goto out;
+		}
+
+		/* last desc of any frame */
+		desc->frames_left--;
+		if (desc->frames_left)
+			goto out;
+
+		/* last desc of the last frame  */
+		repeat_tx =3D vd->tx.flags & DMA_PREP_REPEAT;
+		next_vd =3D list_first_entry_or_null(&vd->node, struct virt_dma_desc, =
node);
+		if (next_vd)
+			repeat_tx =3D repeat_tx && !(next_vd->tx.flags & DMA_PREP_LOAD_EOT);
+		if (repeat_tx) {
+			desc->frames_left =3D desc->periods;
+			desc->completed_desc_num =3D 0;
+			vchan_cyclic_callback(vd);
+		} else {
+			list_del(&vd->node);
+			vchan_cookie_complete(vd);
+		}
+		/* start (or continue) the tx of a first desc on the vc.desc_issued li=
st, if any */
+		xdma_xfer_start(xchan);
+	} else if (!desc->cyclic) {
 		xchan->busy =3D false;
 		desc->completed_desc_num +=3D complete_desc_num;
=20
@@ -865,6 +947,9 @@ static irqreturn_t xdma_channel_isr(int irq, void *de=
v_id)
=20
 		/* transfer the rest of data */
 		xdma_xfer_start(xchan);
+	} else {
+		desc->completed_desc_num =3D complete_desc_num;
+		vchan_cyclic_callback(vd);
 	}
=20
 out:
@@ -1163,6 +1248,9 @@ static int xdma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SLAVE, xdev->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, xdev->dma_dev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, xdev->dma_dev.cap_mask);
+	dma_cap_set(DMA_INTERLEAVE, xdev->dma_dev.cap_mask);
+	dma_cap_set(DMA_REPEAT, xdev->dma_dev.cap_mask);
+	dma_cap_set(DMA_LOAD_EOT, xdev->dma_dev.cap_mask);
=20
 	xdev->dma_dev.dev =3D &pdev->dev;
 	xdev->dma_dev.residue_granularity =3D DMA_RESIDUE_GRANULARITY_SEGMENT;
@@ -1178,6 +1266,7 @@ static int xdma_probe(struct platform_device *pdev)
 	xdev->dma_dev.filter.mapcnt =3D pdata->device_map_cnt;
 	xdev->dma_dev.filter.fn =3D xdma_filter_fn;
 	xdev->dma_dev.device_prep_dma_cyclic =3D xdma_prep_dma_cyclic;
+	xdev->dma_dev.device_prep_interleaved_dma =3D xdma_prep_interleaved_dma=
;
=20
 	ret =3D dma_async_device_register(&xdev->dma_dev);
 	if (ret) {
--=20
2.34.1


