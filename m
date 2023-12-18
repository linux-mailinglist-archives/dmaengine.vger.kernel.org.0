Return-Path: <dmaengine+bounces-560-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5E9816CE8
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42AA7B21CE3
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309AF405D0;
	Mon, 18 Dec 2023 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="KwrBueKy"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852C3D0DD;
	Mon, 18 Dec 2023 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 0C0D42D0186C;
	Mon, 18 Dec 2023 12:40:28 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Va4eSrGRR6VO; Mon, 18 Dec 2023 12:40:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id B4E872D0186B;
	Mon, 18 Dec 2023 12:40:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl B4E872D0186B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702899627;
	bh=hzel1/ce/1mP1V20RRQos9BIDs2j5BOkjFb4gEFtAeQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=KwrBueKy4tMDlYb+GHVFyiKUQXe89KVYvhYuoZmEACjYWolaFkshVXU9EgdByEY1X
	 SvQyZ5+I8OlXdFMTd1k6QJ+5edd+KnDavDF0iQ72wN/5TA5jRHRwFpjwKpbQ6+YXMC
	 +Y22ixURvIrN/XRn2WAB/KxGGdc3uAYQGQ6kUKirW0gkMhkAUs7ZOKEty1V1K/Tx9/
	 m7uqOHtZvQBMvuUJs+1EDyXU+u3sQFO47sET0RU6LLaEOmOdYJUnmYSV6BDd4vQk5k
	 WOpYDaMT8UuK4AODlOubZWCdN9mSQtUudqCLql8YX3aCQvnlgt68hSurmJBsZBQWP2
	 sbN0wSu+r05VQ==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id hiZwfRKIXf4w; Mon, 18 Dec 2023 12:40:27 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 7FF5D2D01868;
	Mon, 18 Dec 2023 12:40:27 +0100 (CET)
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
Subject: [PATCH v5 5/8] dmaengine: xilinx: xdma: Add error checking in xdma_channel_isr()
Date: Mon, 18 Dec 2023 12:39:40 +0100
Message-Id: <20231218113943.9099-6-jankul@alatek.krakow.pl>
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

Check and clear the status register value before proceeding any
further in xdma_channel_isr(). It is necessary to do it since the
interrupt may occur on any error condition enabled at the start of a
transfer.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 0c7350863873..9a1d2939a333 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -811,6 +811,18 @@ static irqreturn_t xdma_channel_isr(int irq, void *d=
ev_id)
 	desc =3D to_xdma_desc(vd);
 	xdev =3D xchan->xdev_hdl;
=20
+	/* Clear-on-read the status register */
+	ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &st)=
;
+	if (ret)
+		goto out;
+
+	st &=3D XDMA_CHAN_STATUS_MASK;
+	if ((st & XDMA_CHAN_ERROR_MASK) ||
+	    !(st & (CHAN_CTRL_IE_DESC_COMPLETED | CHAN_CTRL_IE_DESC_STOPPED))) =
{
+		xdma_err(xdev, "channel error, status register value: 0x%x", st);
+		goto out;
+	}
+
 	ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_COMPLETED_DESC,
 			  &complete_desc_num);
 	if (ret)
@@ -818,14 +830,6 @@ static irqreturn_t xdma_channel_isr(int irq, void *d=
ev_id)
=20
 	if (desc->cyclic) {
 		desc->completed_desc_num =3D complete_desc_num;
-
-		ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS,
-				  &st);
-		if (ret)
-			goto out;
-
-		regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_STATUS, st);
-
 		vchan_cyclic_callback(vd);
 	} else {
 		xchan->busy =3D false;
--=20
2.34.1


