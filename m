Return-Path: <dmaengine+bounces-423-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219BE80A4C8
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 14:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B631C20AF3
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44E13FE7;
	Fri,  8 Dec 2023 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="RxOSNy7A"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A8D172B;
	Fri,  8 Dec 2023 05:50:50 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 24D5A2D00F5E;
	Fri,  8 Dec 2023 14:50:48 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id pleziLCz3-db; Fri,  8 Dec 2023 14:50:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id A502D2D00F5C;
	Fri,  8 Dec 2023 14:50:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl A502D2D00F5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702043447;
	bh=ju/FSf2NR+b7FjguOOHsH9RocRGF7h6jkhh+cm1imXY=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=RxOSNy7AXe5HoVry27P4rhRVv/xcYk2CAY0NJeGLYJb52O3JPBlrTP858QY58iLDO
	 33kaOgqDkOL+K91gqyjUZ7DUQnJZYc/PbTrjDrAWt+zagfKL+rVtdRAl4zEdji9ipv
	 X4SstL6/R9sC1974CZOfHoNErHMQ69OwxWJM9PyLyH13XnHzzvgvYqMybg8R3x58ak
	 H0PbvWGA9oZ/+lORZ/JXOPaORH/+O8W3wjNb4UOBMWUM84bFCmUlghIV7jNvf9/dRy
	 ukU7yssVSuEhVS1whTLf0q375nyjQw4WX3xNqownmT+bsI9IcFE613rcXlYZoZ5xIr
	 KCExKwQ2HLAPw==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id PoYG8YP1WxHn; Fri,  8 Dec 2023 14:50:47 +0100 (CET)
Received: from localhost.localdomain (unknown [10.125.125.6])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 16DAB2D00F5B;
	Fri,  8 Dec 2023 14:50:47 +0100 (CET)
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
Subject: [PATCH v4 8/8] dmaengine: xilinx: xdma: Introduce interleaved DMA transfers
Date: Fri,  8 Dec 2023 14:49:29 +0100
Message-Id: <20231208134929.49523-9-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208134838.49500-1-jankul@alatek.krakow.pl>
References: <20231208134838.49500-1-jankul@alatek.krakow.pl>
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
(at a fixed address) and also to do DMA to/from a (non)contiguous RAM
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
 drivers/dma/xilinx/xdma.c | 103 ++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index c8ac047249bc..c7d4def4124b 100644
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

@@ -607,6 +611,7 @@ xdma_prep_device_sg(struct dma_chan *chan, struct sca=
tterlist *sgl,
 	if (!sw_desc)
 		return NULL;
 	sw_desc->dir =3D dir;
+	sw_desc->cyclic =3D sw_desc->interleaved_dma =3D false;

 	if (dir =3D=3D DMA_MEM_TO_DEV) {
 		dev_addr =3D xdma_chan->cfg.dst_addr;
@@ -682,6 +687,7 @@ xdma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_=
t address,
 	sw_desc->periods =3D periods;
 	sw_desc->period_size =3D period_size;
 	sw_desc->dir =3D dir;
+	sw_desc->interleaved_dma =3D false;

 	addr =3D address;
 	if (dir =3D=3D DMA_MEM_TO_DEV) {
@@ -712,6 +718,54 @@ xdma_prep_dma_cyclic(struct dma_chan *chan, dma_addr=
_t address,
 	return NULL;
}

+/**
+ * xdma_prep_interleaved_dma - Prepare virtual descriptor for interleave=
d DMA transfers
+ * @chan: DMA channel
+ * @xt: DMA transfer template
+ * @flags: tx flags
+ */
+struct dma_async_tx_descriptor *
+xdma_prep_interleaved_dma(struct dma_chan *chan,
+			struct dma_interleaved_template *xt,
+			unsigned long flags)
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
+	sw_desc->frames_left =3D sw_desc->periods =3D xt->numf;
+
+	desc_num =3D 0;
+	src_addr =3D xt->src_start;
+	dst_addr =3D xt->dst_start;
+	for (i =3D 0; i < xt->frame_size; ++i) {
+		desc_num +=3D xdma_fill_descs(sw_desc, src_addr, dst_addr, xt->sgl[i].=
size, desc_num);
+		src_addr +=3D dmaengine_get_src_icg(xt, &xt->sgl[i]) + xt->src_inc ? x=
t->sgl[i].size : 0;
+		dst_addr +=3D dmaengine_get_dst_icg(xt, &xt->sgl[i]) + xt->dst_inc ? x=
t->sgl[i].size : 0;
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
@@ -812,11 +866,12 @@ static irqreturn_t xdma_channel_isr(int irq, void *=
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

 	spin_lock(&xchan->vchan.lock);

@@ -826,9 +881,6 @@ static irqreturn_t xdma_channel_isr(int irq, void *de=
v_id)
 		goto out;
 	desc =3D to_xdma_desc(vd);

-	desc =3D to_xdma_desc(vd);
-	xdev =3D xchan->xdev_hdl;
-
 	/* Clear-on-read the status register */
 	ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &st)=
;
 	if (ret)
@@ -847,10 +899,36 @@ static irqreturn_t xdma_channel_isr(int irq, void *=
dev_id)
 	if (ret)
 		goto out;

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

@@ -867,6 +945,9 @@ static irqreturn_t xdma_channel_isr(int irq, void *de=
v_id)

 		/* transfer the rest of data */
 		xdma_xfer_start(xchan);
+	} else {
+		desc->completed_desc_num =3D complete_desc_num;
+		vchan_cyclic_callback(vd);
 	}

 out:
@@ -1165,6 +1246,9 @@ static int xdma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SLAVE, xdev->dma_dev.cap_mask);
 	dma_cap_set(DMA_PRIVATE, xdev->dma_dev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, xdev->dma_dev.cap_mask);
+	dma_cap_set(DMA_INTERLEAVE, xdev->dma_dev.cap_mask);
+	dma_cap_set(DMA_REPEAT, xdev->dma_dev.cap_mask);
+	dma_cap_set(DMA_LOAD_EOT, xdev->dma_dev.cap_mask);

 	xdev->dma_dev.dev =3D &pdev->dev;
 	xdev->dma_dev.residue_granularity =3D DMA_RESIDUE_GRANULARITY_SEGMENT;
@@ -1180,6 +1264,7 @@ static int xdma_probe(struct platform_device *pdev)
 	xdev->dma_dev.filter.mapcnt =3D pdata->device_map_cnt;
 	xdev->dma_dev.filter.fn =3D xdma_filter_fn;
 	xdev->dma_dev.device_prep_dma_cyclic =3D xdma_prep_dma_cyclic;
+	xdev->dma_dev.device_prep_interleaved_dma =3D xdma_prep_interleaved_dma=
;

	ret =3D dma_async_device_register(&xdev->dma_dev);
 	if (ret) {
--
2.34.1


