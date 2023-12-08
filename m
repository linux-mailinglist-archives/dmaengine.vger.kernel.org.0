Return-Path: <dmaengine+bounces-419-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E17980A4BE
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 14:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE20D1F21002
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD411DA24;
	Fri,  8 Dec 2023 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="atzC66+l"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86C0198D;
	Fri,  8 Dec 2023 05:50:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 062FF2D00F54;
	Fri,  8 Dec 2023 14:50:23 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id k_HF2D6S06dv; Fri,  8 Dec 2023 14:50:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id A8B3E2D00F53;
	Fri,  8 Dec 2023 14:50:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl A8B3E2D00F53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702043422;
	bh=TFnmjLQd7yXXz0FUvRgSBTsyp1BXgYpSk1S5kee4UxI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=atzC66+l8DJ2VM7fkAEiMMz09K3Rvni+JoCCnsWiZAan2akwW7A8dFiI6uqR0iGP5
	 gJ3mwl5weEHyTTTRNCt6F42dAsZrpvdGdlGRejwk/JO99ywhxZ33hgx847A7327YI9
	 7PTd7BfbtognPxwuKIVhc29MW4wiFD+Ee+AVt04HHkafbtfcuB+coMV8npHRzIi3sY
	 SHdJoWV2m4o7i+J7MjpFNtP6nQusRsdwISaHcVTt40m2vnHmVb43VRbyHsDiUNXT9R
	 9uO9jT1QvCvrSTbrmZj7pw7xyaYKA4kh5uxiyS9LFSbZEYT78Ch0cB5lMMta7F90dl
	 Rk2heYUiY8E8g==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id gTBO7jEdy2Ip; Fri,  8 Dec 2023 14:50:22 +0100 (CET)
Received: from localhost.localdomain (unknown [10.125.125.6])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 27C512D00F4D;
	Fri,  8 Dec 2023 14:50:22 +0100 (CET)
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
Subject: [PATCH v4 4/8] dmaengine: xilinx: xdma: Rework xdma_terminate_all()
Date: Fri,  8 Dec 2023 14:49:25 +0100
Message-Id: <20231208134929.49523-5-jankul@alatek.krakow.pl>
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

Fixes: 290bb5d2d1e2
("dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks")

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 1bce48e5d86c..521ba2a653b6 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -379,20 +379,20 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
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

 	/* clear run stop bit to prevent any further auto-triggering */
 	ret =3D regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_CONTROL_W1C,
-			   CHAN_CTRL_RUN_STOP);
+							CHAN_CTRL_RUN_STOP);
 	if (ret)
 		return ret;

-	xchan->busy =3D false;
+	/* Clear the channel status register */
+	ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &val=
);
+	if (ret)
+		return ret;

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

-	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
 	xdma_xfer_stop(xdma_chan);

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

 	return 0;
 }
--
2.34.1


