Return-Path: <dmaengine+bounces-561-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B657816CF5
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 12:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4B42826CC
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 11:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89A42AA2;
	Mon, 18 Dec 2023 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="qu3DoTzS"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842CE4184B;
	Mon, 18 Dec 2023 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 5D1692D0186E;
	Mon, 18 Dec 2023 12:40:36 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id tu6U9_FKSmPL; Mon, 18 Dec 2023 12:40:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 0F8972D0186C;
	Mon, 18 Dec 2023 12:40:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 0F8972D0186C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702899636;
	bh=IeY0xEqvRU/tflVyxzoSpRy4NcybNFbv4E5J5gvXP2c=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=qu3DoTzSt12x3+ZlG1PDBTF0MtgreNiFQrhpnM5nHNh3qp09HJzA1DXhp7v1RGGe7
	 miabCs6OjDIdcDdcWgPUL/NkvfCnClZBLo6CsQF7Dd+9ire7yYiZjRRzkjR9dAgphX
	 +JyWDK+ttjIsq5952dsotzOvk393G8sGrStfYWk89vGSz+/hIjri9x3IXR4iBAEhtk
	 GBWUHF2F1tSbN5T37eY6UXSW1mH53kb8XpcHayr531c1AIK+qHEHtxdUDCTX+xpl2p
	 RTQHGKI8NAI+oyJg3Z/A+bzU8/t/YDw9ytW/1h/9P8A3g98xvuVFMioftkaFmdyqGa
	 GeVzUcBIpFGQw==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Zlyx9Lf6UWop; Mon, 18 Dec 2023 12:40:36 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id CC2DA2D01868;
	Mon, 18 Dec 2023 12:40:35 +0100 (CET)
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
Subject: [PATCH v5 6/8] dmaengine: xilinx: xdma: Add transfer error reporting
Date: Mon, 18 Dec 2023 12:39:41 +0100
Message-Id: <20231218113943.9099-7-jankul@alatek.krakow.pl>
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

Extend the capability of transfer status reporting. Introduce error flag,
which allows to report error in case of a interrupt-reported error
condition.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 9a1d2939a333..9f8597ed9be2 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -85,6 +85,7 @@ struct xdma_chan {
  * @cyclic: Cyclic transfer vs. scatter-gather
  * @periods: Number of periods in the cyclic transfer
  * @period_size: Size of a period in bytes in cyclic transfers
+ * @error: tx error flag
  */
 struct xdma_desc {
 	struct virt_dma_desc		vdesc;
@@ -97,6 +98,7 @@ struct xdma_desc {
 	bool				cyclic;
 	u32				periods;
 	u32				period_size;
+	bool				error;
 };
=20
 #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
@@ -274,6 +276,7 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num,=
 bool cyclic)
 	sw_desc->chan =3D chan;
 	sw_desc->desc_num =3D desc_num;
 	sw_desc->cyclic =3D cyclic;
+	sw_desc->error =3D false;
 	dblk_num =3D DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
 	sw_desc->desc_blocks =3D kcalloc(dblk_num, sizeof(*sw_desc->desc_blocks=
),
 				       GFP_NOWAIT);
@@ -769,20 +772,20 @@ static enum dma_status xdma_tx_status(struct dma_ch=
an *chan, dma_cookie_t cookie
 	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
=20
 	vd =3D vchan_find_desc(&xdma_chan->vchan, cookie);
-	if (vd)
-		desc =3D to_xdma_desc(vd);
-	if (!desc || !desc->cyclic) {
-		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
-		return ret;
-	}
-
-	period_idx =3D desc->completed_desc_num % desc->periods;
-	residue =3D (desc->periods - period_idx) * desc->period_size;
+	if (!vd)
+		goto out;
=20
+	desc =3D to_xdma_desc(vd);
+	if (desc->error) {
+		ret =3D DMA_ERROR;
+	} else if (desc->cyclic) {
+		period_idx =3D desc->completed_desc_num % desc->periods;
+		residue =3D (desc->periods - period_idx) * desc->period_size;
+		dma_set_residue(state, residue);
+	}
+out:
 	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
=20
-	dma_set_residue(state, residue);
-
 	return ret;
 }
=20
@@ -819,6 +822,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *de=
v_id)
 	st &=3D XDMA_CHAN_STATUS_MASK;
 	if ((st & XDMA_CHAN_ERROR_MASK) ||
 	    !(st & (CHAN_CTRL_IE_DESC_COMPLETED | CHAN_CTRL_IE_DESC_STOPPED))) =
{
+		desc->error =3D true;
 		xdma_err(xdev, "channel error, status register value: 0x%x", st);
 		goto out;
 	}
--=20
2.34.1


