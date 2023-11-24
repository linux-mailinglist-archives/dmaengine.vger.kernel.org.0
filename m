Return-Path: <dmaengine+bounces-242-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86737F84BB
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 20:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235371C215FE
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 19:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF6739FF3;
	Fri, 24 Nov 2023 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="NXuMCyTf"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4443C30F6;
	Fri, 24 Nov 2023 11:26:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 433D32CE00DC;
	Fri, 24 Nov 2023 20:26:50 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id zks-Igk9_28N; Fri, 24 Nov 2023 20:26:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 9F68C2CE00DA;
	Fri, 24 Nov 2023 20:26:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 9F68C2CE00DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700854009;
	bh=iavZyvPckMzvsc4PJ76HGqTRtzDPAKaZ+PAcAb4Ooms=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=NXuMCyTfUxMoRSTat1fhRymXai4F4TUn3SdDVzUBue580t1n4Ul99zVtpOFwgxlu1
	 UIx9hQBXqR8ayg57kTDkhPKhT/miGEzjdqvF893OPPY4EK3ctxVOdaps8lkqHp4vxT
	 ZUA6Lr8RBSZn6chMlbRlaK2P+t6rs3/l3q3SkPxUn/9ZNR0st6yAIK8R4esh+/YlRy
	 AssQWo3rQ01MGme7859AEC4sHV+AWoDvy8l/cCocBAPMSUhMEVkmEEnJLV/3cG3aMx
	 /p1XUMBvqyEa2rQLKCDFOJy5ENIo2gBHRX8lDXGl4zykPd4D8Z4SR51zT2KCSH3ffd
	 EisC6gCVjD1Hg==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id slmmGsWKQuNK; Fri, 24 Nov 2023 20:26:49 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 63BBF2CE00D9;
	Fri, 24 Nov 2023 20:26:49 +0100 (CET)
From: Jan Kuliga <jankul@alatek.krakow.pl>
To: lizhi.hou@amd.com,
	brian.xu@amd.com,
	raj.kumar.rampelli@amd.com,
	vkoul@kernel.org,
	michal.simek@amd.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runtimeca39d@amd.com
Cc: Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH v3 5/5] dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
Date: Fri, 24 Nov 2023 20:25:58 +0100
Message-Id: <20231124192558.135004-6-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124192524.134989-1-jankul@alatek.krakow.pl>
References: <20231124192524.134989-1-jankul@alatek.krakow.pl>
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
index 6bf7ae84e452..d5cb12e6b8d4 100644
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
index de4615bd4ee5..d32ae93e18b6 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -735,9 +735,9 @@ static int xdma_alloc_chan_resources(struct dma_chan =
*chan)
 		return -EINVAL;
 	}
=20
-	xdma_chan->desc_pool =3D dma_pool_create(dma_chan_name(chan),
-					       dev, XDMA_DESC_BLOCK_SIZE,
-					       XDMA_DESC_BLOCK_ALIGN, 0);
+	xdma_chan->desc_pool =3D dma_pool_create(dma_chan_name(chan), dev,
+				XDMA_DESC_BLOCK_SIZE, XDMA_DESC_BLOCK_ALIGN,
+						XDMA_DESC_BLOCK_BOUNDARY);
 	if (!xdma_chan->desc_pool) {
 		xdma_err(xdev, "unable to allocate descriptor pool");
 		return -ENOMEM;
--=20
2.34.1


