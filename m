Return-Path: <dmaengine+bounces-418-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A9680A4BC
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24E71F213EB
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0E1D6A8;
	Fri,  8 Dec 2023 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="e+rz5+fJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CF31732;
	Fri,  8 Dec 2023 05:50:18 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id F3B862D00F54;
	Fri,  8 Dec 2023 14:50:16 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id DLBFkRLwkpfS; Fri,  8 Dec 2023 14:50:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id DC8352D00F53;
	Fri,  8 Dec 2023 14:50:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl DC8352D00F53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702043415;
	bh=mcPb4bswnj/lXIxkXo1POfN4/aAJkVGhbaTTroE83nI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=e+rz5+fJm44bC6IIucyl2Jc1VHz3ORzQW/Qlzlx+yNKm3fPoKGFwj7c/0+921syCG
	 0jP15pzOSMwQZqIlAS2i+up80FpTEwgKjDpBEnZMEJLRgsvmxTjklB2BkoxtH8VDpx
	 qRLKkGpFWx+LM8tEIb4E5ze61IeoH8N/bmNRz81gQz8MbVZ+LryjXpmOTpbToZ6Zqu
	 ym/r6GAON7TXnzV/Usd66a06eMr2IQ86ZBYMEJgSB75N3QPTGyqf7bWqlOVpANgloB
	 DYSmUzyYEPUbjSNTozYZxuur6NHXtASh5yv66A+LdJOor48cIrOiAbb1aFUg019o0P
	 XtknNVaiiHKkw==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id pcZGCCya3Src; Fri,  8 Dec 2023 14:50:15 +0100 (CET)
Received: from localhost.localdomain (unknown [10.125.125.6])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 3CCF92D00F4D;
	Fri,  8 Dec 2023 14:50:15 +0100 (CET)
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
Subject: [PATCH v4 3/8] dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
Date: Fri,  8 Dec 2023 14:49:24 +0100
Message-Id: <20231208134929.49523-4-jankul@alatek.krakow.pl>
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
 drivers/dma/xilinx/xdma.c      | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-reg=
s.h
index b12dd60629f6..2a224e3da672 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -64,9 +64,10 @@ struct xdma_hw_desc {
 	__le64		next_desc;
 };

-#define XDMA_DESC_SIZE		sizeof(struct xdma_hw_desc)
-#define XDMA_DESC_BLOCK_SIZE	(XDMA_DESC_SIZE * XDMA_DESC_ADJACENT)
-#define XDMA_DESC_BLOCK_ALIGN	4096
+#define XDMA_DESC_SIZE			sizeof(struct xdma_hw_desc)
+#define XDMA_DESC_BLOCK_SIZE		(XDMA_DESC_SIZE * XDMA_DESC_ADJACENT)
+#define XDMA_DESC_BLOCK_ALIGN		32
+#define XDMA_DESC_BLOCK_BOUNDARY	4096

 /*
  * Channel registers
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index ddb9e7d07461..1bce48e5d86c 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -741,9 +741,9 @@ static int xdma_alloc_chan_resources(struct dma_chan =
*chan)
 		return -EINVAL;
 	}

-	xdma_chan->desc_pool =3D dma_pool_create(dma_chan_name(chan),
-					       dev, XDMA_DESC_BLOCK_SIZE,
-					       XDMA_DESC_BLOCK_ALIGN, 0);
+	xdma_chan->desc_pool =3D dma_pool_create(dma_chan_name(chan), dev,
+				XDMA_DESC_BLOCK_SIZE, XDMA_DESC_BLOCK_ALIGN,
+						XDMA_DESC_BLOCK_BOUNDARY);
 	if (!xdma_chan->desc_pool) {
 		xdma_err(xdev, "unable to allocate descriptor pool");
 		return -ENOMEM;
--
2.34.1


