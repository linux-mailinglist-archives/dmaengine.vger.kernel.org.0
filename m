Return-Path: <dmaengine+bounces-559-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E834816CDF
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 12:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E991DB23E66
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 11:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D15D3D0D3;
	Mon, 18 Dec 2023 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="FWxYioBt"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073C3B297;
	Mon, 18 Dec 2023 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 0B13A2D0186E;
	Mon, 18 Dec 2023 12:40:22 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VGIWlgQFWWGy; Mon, 18 Dec 2023 12:40:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id AC2D22D0186B;
	Mon, 18 Dec 2023 12:40:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl AC2D22D0186B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702899621;
	bh=C6InQ+4d15iDKyNcFXHPVTUZ8feoM5yp2MCadEFmw+g=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=FWxYioBtV+CuN4ZKXhsYKHaP1DEtyZoHbu0sQIka9w4vbLzIaIWQXW0XVWNm1P/nv
	 1/fhDgEi/C4Klm0ydTBuc0pKQToG88PHP1FjJm39JVH4Vufk7ZS6stkDzKllMpuqTh
	 l3Vu5lBmDhKEZoEA5AFx3FMOoG5Nd6aEk1NNTd4A5FxMO4cNC+wkrYYu2Ws3L2tPNC
	 zMiiroszXMqoHHMhLHsZOWGQJkogvmFLnCWC7f9t2bVsVjJlyrvqQDGM0XKKz9vWGr
	 Hzf677yCa5sJf5ZUpn7vA7wefwf+SX7wusmZxNNVNWo0UzmdwXQckusOUTXRJ346vB
	 MlBkucwOEiqeg==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id UDKqkfsa-b3i; Mon, 18 Dec 2023 12:40:21 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 7827E2D01868;
	Mon, 18 Dec 2023 12:40:21 +0100 (CET)
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
Subject: [PATCH v5 4/8] dmaengine: xilinx: xdma: Rework xdma_terminate_all()
Date: Mon, 18 Dec 2023 12:39:39 +0100
Message-Id: <20231218113943.9099-5-jankul@alatek.krakow.pl>
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

Simplify xdma_xfer_stop(). Stop the dma engine and clear its status
register unconditionally - just do what its name states. This change
also allows to call it without grabbing a lock, which minimizes
the total time spent with a spinlock held.

Delete the currently processed vd.node from the vc.desc_issued list
prior to passing it to vchan_terminate_vdesc(). In case there's more
than one descriptor pending on vc.desc_issued list, calling
vchan_terminate_desc() results in losing the link between
vc.desc_issued list head and the second descriptor on the list. Doing so
results in resources leakege, as vchan_dma_desc_free_list() won't be
able to properly free memory resources attached to descriptors,
resulting in dma_pool_destroy() failure.

Don't call vchan_dma_desc_free_list() from within xdma_terminate_all().
Move all terminated descriptors to the vc.desc_terminated list instead.
This allows to postpone freeing memory resources associated with
descriptors until the call to vchan_synchronize(), which is called from
xdma_synchronize() callback. This is the right way to do it -
xdma_terminate_all() should return as soon as possible, while freeing
resources (that may be time consuming in case of large number of
descriptors) can be done safely later.

Fixes: 49a701d8dc1e ("dmaengine: xilinx: xdma: Add terminate_all/synchron=
ize callbacks")

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index c22701e76b69..0c7350863873 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -379,12 +379,9 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
  */
 static int xdma_xfer_stop(struct xdma_chan *xchan)
 {
-	struct virt_dma_desc *vd =3D vchan_next_desc(&xchan->vchan);
-	struct xdma_device *xdev =3D xchan->xdev_hdl;
 	int ret;
-
-	if (!vd || !xchan->busy)
-		return -EINVAL;
+	u32 val;
+	struct xdma_device *xdev =3D xchan->xdev_hdl;
=20
 	/* clear run stop bit to prevent any further auto-triggering */
 	ret =3D regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_CONTROL_W1C,
@@ -392,7 +389,10 @@ static int xdma_xfer_stop(struct xdma_chan *xchan)
 	if (ret)
 		return ret;
=20
-	xchan->busy =3D false;
+	/* Clear the channel status register */
+	ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &val=
);
+	if (ret)
+		return ret;
=20
 	return 0;
 }
@@ -505,25 +505,25 @@ static void xdma_issue_pending(struct dma_chan *cha=
n)
 static int xdma_terminate_all(struct dma_chan *chan)
 {
 	struct xdma_chan *xdma_chan =3D to_xdma_chan(chan);
-	struct xdma_desc *desc =3D NULL;
 	struct virt_dma_desc *vd;
 	unsigned long flags;
 	LIST_HEAD(head);
=20
-	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
 	xdma_xfer_stop(xdma_chan);
=20
+	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
+
+	xdma_chan->busy =3D false;
 	vd =3D vchan_next_desc(&xdma_chan->vchan);
-	if (vd)
-		desc =3D to_xdma_desc(vd);
-	if (desc) {
-		dma_cookie_complete(&desc->vdesc.tx);
-		vchan_terminate_vdesc(&desc->vdesc);
+	if (vd) {
+		list_del(&vd->node);
+		dma_cookie_complete(&vd->tx);
+		vchan_terminate_vdesc(vd);
 	}
-
 	vchan_get_all_descriptors(&xdma_chan->vchan, &head);
+	list_splice_tail(&head, &xdma_chan->vchan.desc_terminated);
+
 	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
-	vchan_dma_desc_free_list(&xdma_chan->vchan, &head);
=20
 	return 0;
 }
--=20
2.34.1


