Return-Path: <dmaengine+bounces-562-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117DC816CFB
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 12:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF640283A13
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F82381B2;
	Mon, 18 Dec 2023 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="Mt9FtNaR"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620E45BFD;
	Mon, 18 Dec 2023 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 95BB32D01870;
	Mon, 18 Dec 2023 12:40:43 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ObOH1dHixr_c; Mon, 18 Dec 2023 12:40:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 327B72D0186E;
	Mon, 18 Dec 2023 12:40:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 327B72D0186E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702899643;
	bh=iRrOYs5fy78KBnzCcFa+LVG7TpXXk3UuSZKby9LxYVk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Mt9FtNaRGBmjVxcHb6hn2LcD07W2iTesGSFwJX0gxnp8IOBxZDXXSBbZaBhUbVN1Q
	 vO2f1I1uCfcC2jrr+jwYwJ/8AH6nxqIZ3y+V6LZonZK7c5gStuiSwyrvjW8Dwl/fNt
	 G/33n9tqry3oMAF1BTMf+rtgN8wZSZeSumiXlQQkD1ztjmwzkharRCgs8aWEl2DlJE
	 vHdpTQEZfAOqeELWmzE4bPtNho8fqI4fdY5+ZqYchmRP9mmtiQ/eXahJLPOes3TYNz
	 jQUvAqmncm2Nxvl3PVmbPea/pXg3x4sr83R/wZvppxnGAR/sMnHvw1CVUodmDU3eAh
	 tJIkqqtdNYGUA==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id siF46F4BckZb; Mon, 18 Dec 2023 12:40:43 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 033732D01868;
	Mon, 18 Dec 2023 12:40:43 +0100 (CET)
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
Subject: [PATCH v5 7/8] dmaengine: xilinx: xdma: Prepare the introduction of interleaved DMA transfers
Date: Mon, 18 Dec 2023 12:39:42 +0100
Message-Id: <20231218113943.9099-8-jankul@alatek.krakow.pl>
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

Make generic code generic. As descriptor-filling logic stays the same
regardless of a dmaengine's type of transfer, it is possible to write
the descriptor-filling function in a generic way, so that it can be used
for every single type of transfer preparation callback.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma.c | 101 +++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 9f8597ed9be2..618cc9af6eb9 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -542,6 +542,43 @@ static void xdma_synchronize(struct dma_chan *chan)
 	vchan_synchronize(&xdma_chan->vchan);
 }
=20
+/**
+ * xdma_fill_descs - Fill hardware descriptors with contiguous memory bl=
ock addresses
+ * @sw_desc - tx descriptor state container
+ * @src_addr - Value for a ->src_addr field of a first descriptor
+ * @dst_addr - Value for a ->dst_addr field of a first descriptor
+ * @size - Total size of a contiguous memory block
+ * @filled_descs_num - Number of filled hardware descriptors for corresp=
onding sw_desc
+ */
+static inline u32 xdma_fill_descs(struct xdma_desc *sw_desc, u64 src_add=
r,
+				  u64 dst_addr, u32 size, u32 filled_descs_num)
+{
+	u32 left =3D size, len, desc_num =3D filled_descs_num;
+	struct xdma_desc_block *dblk;
+	struct xdma_hw_desc *desc;
+
+	dblk =3D sw_desc->desc_blocks + (desc_num / XDMA_DESC_ADJACENT);
+	desc =3D dblk->virt_addr;
+	desc +=3D desc_num & XDMA_DESC_ADJACENT_MASK;
+	do {
+		len =3D min_t(u32, left, XDMA_DESC_BLEN_MAX);
+		/* set hardware descriptor */
+		desc->bytes =3D cpu_to_le32(len);
+		desc->src_addr =3D cpu_to_le64(src_addr);
+		desc->dst_addr =3D cpu_to_le64(dst_addr);
+		if (!(++desc_num & XDMA_DESC_ADJACENT_MASK))
+			desc =3D (++dblk)->virt_addr;
+		else
+			desc++;
+
+		src_addr +=3D len;
+		dst_addr +=3D len;
+		left -=3D len;
+	} while (left);
+
+	return desc_num - filled_descs_num;
+}
+
 /**
  * xdma_prep_device_sg - prepare a descriptor for a DMA transaction
  * @chan: DMA channel pointer
@@ -558,13 +595,10 @@ xdma_prep_device_sg(struct dma_chan *chan, struct s=
catterlist *sgl,
 {
 	struct xdma_chan *xdma_chan =3D to_xdma_chan(chan);
 	struct dma_async_tx_descriptor *tx_desc;
-	u32 desc_num =3D 0, i, len, rest;
-	struct xdma_desc_block *dblk;
-	struct xdma_hw_desc *desc;
 	struct xdma_desc *sw_desc;
-	u64 dev_addr, *src, *dst;
+	u32 desc_num =3D 0, i;
+	u64 addr, dev_addr, *src, *dst;
 	struct scatterlist *sg;
-	u64 addr;
=20
 	for_each_sg(sgl, sg, sg_len, i)
 		desc_num +=3D DIV_ROUND_UP(sg_dma_len(sg), XDMA_DESC_BLEN_MAX);
@@ -584,32 +618,11 @@ xdma_prep_device_sg(struct dma_chan *chan, struct s=
catterlist *sgl,
 		dst =3D &addr;
 	}
=20
-	dblk =3D sw_desc->desc_blocks;
-	desc =3D dblk->virt_addr;
-	desc_num =3D 1;
+	desc_num =3D 0;
 	for_each_sg(sgl, sg, sg_len, i) {
 		addr =3D sg_dma_address(sg);
-		rest =3D sg_dma_len(sg);
-
-		do {
-			len =3D min_t(u32, rest, XDMA_DESC_BLEN_MAX);
-			/* set hardware descriptor */
-			desc->bytes =3D cpu_to_le32(len);
-			desc->src_addr =3D cpu_to_le64(*src);
-			desc->dst_addr =3D cpu_to_le64(*dst);
-
-			if (!(desc_num & XDMA_DESC_ADJACENT_MASK)) {
-				dblk++;
-				desc =3D dblk->virt_addr;
-			} else {
-				desc++;
-			}
-
-			desc_num++;
-			dev_addr +=3D len;
-			addr +=3D len;
-			rest -=3D len;
-		} while (rest);
+		desc_num +=3D xdma_fill_descs(sw_desc, *src, *dst, sg_dma_len(sg), des=
c_num);
+		dev_addr +=3D sg_dma_len(sg);
 	}
=20
 	tx_desc =3D vchan_tx_prep(&xdma_chan->vchan, &sw_desc->vdesc, flags);
@@ -643,9 +656,9 @@ xdma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_=
t address,
 	struct xdma_device *xdev =3D xdma_chan->xdev_hdl;
 	unsigned int periods =3D size / period_size;
 	struct dma_async_tx_descriptor *tx_desc;
-	struct xdma_desc_block *dblk;
-	struct xdma_hw_desc *desc;
 	struct xdma_desc *sw_desc;
+	u64 addr, dev_addr, *src, *dst;
+	u32 desc_num;
 	unsigned int i;
=20
 	/*
@@ -670,21 +683,21 @@ xdma_prep_dma_cyclic(struct dma_chan *chan, dma_add=
r_t address,
 	sw_desc->period_size =3D period_size;
 	sw_desc->dir =3D dir;
=20
-	dblk =3D sw_desc->desc_blocks;
-	desc =3D dblk->virt_addr;
+	addr =3D address;
+	if (dir =3D=3D DMA_MEM_TO_DEV) {
+		dev_addr =3D xdma_chan->cfg.dst_addr;
+		src =3D &addr;
+		dst =3D &dev_addr;
+	} else {
+		dev_addr =3D xdma_chan->cfg.src_addr;
+		src =3D &dev_addr;
+		dst =3D &addr;
+	}
=20
-	/* fill hardware descriptor */
+	desc_num =3D 0;
 	for (i =3D 0; i < periods; i++) {
-		desc->bytes =3D cpu_to_le32(period_size);
-		if (dir =3D=3D DMA_MEM_TO_DEV) {
-			desc->src_addr =3D cpu_to_le64(address + i * period_size);
-			desc->dst_addr =3D cpu_to_le64(xdma_chan->cfg.dst_addr);
-		} else {
-			desc->src_addr =3D cpu_to_le64(xdma_chan->cfg.src_addr);
-			desc->dst_addr =3D cpu_to_le64(address + i * period_size);
-		}
-
-		desc++;
+		desc_num +=3D xdma_fill_descs(sw_desc, *src, *dst, period_size, desc_n=
um);
+		addr +=3D i * period_size;
 	}
=20
 	tx_desc =3D vchan_tx_prep(&xdma_chan->vchan, &sw_desc->vdesc, flags);
--=20
2.34.1


