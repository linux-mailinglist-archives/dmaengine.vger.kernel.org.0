Return-Path: <dmaengine+bounces-558-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7881816CD6
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 12:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBF31F24395
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ED43B78E;
	Mon, 18 Dec 2023 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="MyOOARhx"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223B39FFB;
	Mon, 18 Dec 2023 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id CB0B62D0186C;
	Mon, 18 Dec 2023 12:40:16 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id bDdscBx1haka; Mon, 18 Dec 2023 12:40:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id CB3CE2D0186B;
	Mon, 18 Dec 2023 12:40:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl CB3CE2D0186B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702899615;
	bh=kigQbZ6cbWkglz4+/r5I9p25DVWVAlGCZgXXB8MiuAQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=MyOOARhx2Yc9lzdHbbxlIeqh+8y3DqM/cAPrBvNuEbF+Db5WH45B/jZyLnum+k0P4
	 93MUfFZW49jgbw59ZfpZizEbmTxXOn1yWsUsXDE37D9fEipK8rclvZyLvISTiYN2jr
	 6AdXMRLBH0Kl/KCOj2XfCXZ9Guk4+Xq+kGsWv0nzi0oVIEfk5rvEicZOzFRsM+0cPv
	 +InC1ZK9pP2bpMFHppXO1tgct68zEPTcdhTOUiX3idwrf591cWX/r8BgW6LYCmjVMO
	 0Wa3d+aIsZcBkCTuxW0lBvadisPbHykmkjaVJLfNLOW8dRswsH6AQyi4TspTUB3hiy
	 Lbdjos4raJMFw==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Z4XuabPfu1Xz; Mon, 18 Dec 2023 12:40:15 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 75E422D01868;
	Mon, 18 Dec 2023 12:40:15 +0100 (CET)
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
Subject: [PATCH v5 3/8] dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
Date: Mon, 18 Dec 2023 12:39:38 +0100
Message-Id: <20231218113943.9099-4-jankul@alatek.krakow.pl>
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

According to the XDMA datasheet (PG195), the address of any descriptor
must be 32 byte aligned. The datasheet also states that a contiguous
block of descriptors must not cross a 4k address boundary. Therefore,
it is possible to ease the pressure put on the dma_pool allocator
just by requiring sufficient alignment and boundary values. Add proper
macro definition and change the values passed into the
dma_pool_create().

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma-regs.h | 7 ++++---
 drivers/dma/xilinx/xdma.c      | 5 ++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-reg=
s.h
index 98117e8a466f..98f5f6fb9ff9 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -64,9 +64,10 @@ struct xdma_hw_desc {
 	__le64		next_desc;
 };
=20
-#define XDMA_DESC_SIZE		sizeof(struct xdma_hw_desc)
-#define XDMA_DESC_BLOCK_SIZE	(XDMA_DESC_SIZE * XDMA_DESC_ADJACENT)
-#define XDMA_DESC_BLOCK_ALIGN	4096
+#define XDMA_DESC_SIZE			sizeof(struct xdma_hw_desc)
+#define XDMA_DESC_BLOCK_SIZE		(XDMA_DESC_SIZE * XDMA_DESC_ADJACENT)
+#define XDMA_DESC_BLOCK_ALIGN		32
+#define XDMA_DESC_BLOCK_BOUNDARY	4096
=20
 /*
  * Channel registers
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index ddb9e7d07461..c22701e76b69 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -741,9 +741,8 @@ static int xdma_alloc_chan_resources(struct dma_chan =
*chan)
 		return -EINVAL;
 	}
=20
-	xdma_chan->desc_pool =3D dma_pool_create(dma_chan_name(chan),
-					       dev, XDMA_DESC_BLOCK_SIZE,
-					       XDMA_DESC_BLOCK_ALIGN, 0);
+	xdma_chan->desc_pool =3D dma_pool_create(dma_chan_name(chan), dev, XDMA=
_DESC_BLOCK_SIZE,
+					       XDMA_DESC_BLOCK_ALIGN, XDMA_DESC_BLOCK_BOUNDARY);
 	if (!xdma_chan->desc_pool) {
 		xdma_err(xdev, "unable to allocate descriptor pool");
 		return -ENOMEM;
--=20
2.34.1


