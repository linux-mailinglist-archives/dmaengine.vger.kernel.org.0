Return-Path: <dmaengine+bounces-420-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EF480A4C1
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 14:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C461C20DAA
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5899A1DA3A;
	Fri,  8 Dec 2023 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="O+7ppQEo"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3D81987;
	Fri,  8 Dec 2023 05:50:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 7AE802D00F59;
	Fri,  8 Dec 2023 14:50:30 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id CEtv42v9Dyji; Fri,  8 Dec 2023 14:50:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 382F12D00F54;
	Fri,  8 Dec 2023 14:50:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 382F12D00F54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702043430;
	bh=FJ8DQb20r8QyG+A0qxamCKht73H5yayCdeykyOFrSrg=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=O+7ppQEoir+pHUE7j22iCchirLRFQddVPlSYA2lVjANr2L0b1cZg11BAu52B+51cN
	 VieZhlDDf8ISDESQiWn0yt41YvESBe7urceXlvbBBL5rbpl01Ef6p2Qp4nWC8pjt+T
	 57pnMHiIb0Jzbl5vOJfEXTJoY8mUuXoGE9vC2TQDazQHMGOaM293TwEd+4yYTObrTh
	 VTMuKkNT1vUVqu3dssTlQPiK/ZDjXbNXMyUk8MFm7A7nchG7AGQ1lvh/SVU/pP6v96
	 8gBlP0Z3KPyo4zboHMCbLEIxDL6xErzcJSmeUd4zzX+Wg8+Q6LNE2dOqzAbxZj+rmx
	 DkGieyJv763OQ==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id uvm5zEZ6mtn7; Fri,  8 Dec 2023 14:50:30 +0100 (CET)
Received: from localhost.localdomain (unknown [10.125.125.6])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id A88112D00F4D;
	Fri,  8 Dec 2023 14:50:29 +0100 (CET)
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
Subject: [PATCH v4 5/8] dmaengine: xilinx: xdma: Add error checking in xdma_channel_isr()
Date: Fri,  8 Dec 2023 14:49:26 +0100
Message-Id: <20231208134929.49523-6-jankul@alatek.krakow.pl>
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

Check and clear the status register value before proceeding any
further in xdma_channel_isr(). It is necessary to do it since the
interrupt may occur on any error condition enabled at the start of a
transfer.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 521ba2a653b6..d1bc36133a45 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -812,21 +812,25 @@ static irqreturn_t xdma_channel_isr(int irq, void *=
dev_id)
 	desc =3D to_xdma_desc(vd);
 	xdev =3D xchan->xdev_hdl;

+	/* Clear-on-read the status register */
+	ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &st)=
;
+	if (ret)
+		goto out;
+
+	st &=3D XDMA_CHAN_STATUS_MASK;
+	if ((st & XDMA_CHAN_ERROR_MASK) ||
+		!(st & (CHAN_CTRL_IE_DESC_COMPLETED | CHAN_CTRL_IE_DESC_STOPPED))) {
+		xdma_err(xdev, "channel error, status register value: 0x%x", st);
+		goto out;
+	}
+
 	ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_COMPLETED_DESC,
-			  &complete_desc_num);
+							&complete_desc_num);
 	if (ret)
 		goto out;

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
--
2.34.1


