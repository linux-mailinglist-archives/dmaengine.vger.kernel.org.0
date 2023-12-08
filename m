Return-Path: <dmaengine+bounces-416-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAE280A4B8
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 14:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633241F21002
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8B51D537;
	Fri,  8 Dec 2023 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="meqXbC49"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BED1986;
	Fri,  8 Dec 2023 05:50:01 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id BE3052D00F54;
	Fri,  8 Dec 2023 14:49:59 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id eCCVI8fAe3PD; Fri,  8 Dec 2023 14:49:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 935302D00F52;
	Fri,  8 Dec 2023 14:49:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 935302D00F52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702043397;
	bh=2J1S9Zi1hgGr9QnLjCXNZLKTR1OT7hgWrVoPzTgU3fo=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=meqXbC49L2+LNgY7RDyOCE0x73UEbUFwYtZQm609vfFpXnHWTSG+in4MDHZ793YZq
	 3nvhgD5BOMIksZO8vyABq8v00iLeXGBzKlrYtOgKtsDQ/YoWx5Roe8JUFO06uVo5i5
	 gWoLauyo5OsJIfDqFRGdru1jbbITqnjUwryu3RAS9TQ7U/f0tQaNkd5/1HdpcBlwfn
	 eLe9ZkSyei37nzpc0fXGv7PUfI2hrRLI2V8MdvxJYSqtEFzd9XTIVbK49zCHLzkpG1
	 8LLCPoywu3VK2gP0gKdBpNk4Ai7EqRcauCEO+nyeDNq3s2x+8Zk0QXp3+YrJUym/op
	 8ZUZytOO6iJ8A==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id FWkyfP5pdvJN; Fri,  8 Dec 2023 14:49:57 +0100 (CET)
Received: from localhost.localdomain (unknown [10.125.125.6])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 0E75D2D00F51;
	Fri,  8 Dec 2023 14:49:57 +0100 (CET)
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
Subject: [PATCH v4 1/8] dmaengine: xilinx: xdma: Get rid of unused code
Date: Fri,  8 Dec 2023 14:49:22 +0100
Message-Id: <20231208134929.49523-2-jankul@alatek.krakow.pl>
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

Get rid of duplicated macro definitions, as these macros are defined
earlier in the file. Also, get rid of unused member
of 'struct xdma_desc'.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma-regs.h | 12 ------------
 drivers/dma/xilinx/xdma.c      |  2 --
 2 files changed, 14 deletions(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-reg=
s.h
index e641a5083e14..0b17a931f583 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -134,18 +134,6 @@ struct xdma_hw_desc {
 #define XDMA_SGDMA_DESC_ADJ	0x4088
 #define XDMA_SGDMA_DESC_CREDIT	0x408c

-/* bits of the SG DMA control register */
-#define XDMA_CTRL_RUN_STOP			BIT(0)
-#define XDMA_CTRL_IE_DESC_STOPPED		BIT(1)
-#define XDMA_CTRL_IE_DESC_COMPLETED		BIT(2)
-#define XDMA_CTRL_IE_DESC_ALIGN_MISMATCH	BIT(3)
-#define XDMA_CTRL_IE_MAGIC_STOPPED		BIT(4)
-#define XDMA_CTRL_IE_IDLE_STOPPED		BIT(6)
-#define XDMA_CTRL_IE_READ_ERROR			GENMASK(13, 9)
-#define XDMA_CTRL_IE_DESC_ERROR			GENMASK(23, 19)
-#define XDMA_CTRL_NON_INCR_ADDR			BIT(25)
-#define XDMA_CTRL_POLL_MODE_WB			BIT(26)
-
 /*
  * interrupt registers
  */
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 290bb5d2d1e2..ddb9e7d07461 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -78,7 +78,6 @@ struct xdma_chan {
  * @vdesc: Virtual DMA descriptor
  * @chan: DMA channel pointer
  * @dir: Transferring direction of the request
- * @dev_addr: Physical address on DMA device side
  * @desc_blocks: Hardware descriptor blocks
  * @dblk_num: Number of hardware descriptor blocks
  * @desc_num: Number of hardware descriptors
@@ -91,7 +90,6 @@ struct xdma_desc {
 	struct virt_dma_desc		vdesc;
 	struct xdma_chan		*chan;
 	enum dma_transfer_direction	dir;
-	u64				dev_addr;
 	struct xdma_desc_block		*desc_blocks;
 	u32				dblk_num;
 	u32				desc_num;
--
2.34.1


