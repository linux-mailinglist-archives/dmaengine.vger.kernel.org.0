Return-Path: <dmaengine+bounces-556-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF131816CB5
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 12:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114B51C21BF1
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8051BDCD;
	Mon, 18 Dec 2023 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="nhv/Eihf"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE941BDD1;
	Mon, 18 Dec 2023 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id A0B932D0186A;
	Mon, 18 Dec 2023 12:39:54 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Mx8Z8RHDthnf; Mon, 18 Dec 2023 12:39:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 1E5EF2D01869;
	Mon, 18 Dec 2023 12:39:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 1E5EF2D01869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702899594;
	bh=N759/7W2UuYqap0Ll6FWIgn4ZQx1EOVZZXI1tKKVL24=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=nhv/EihfS9XbQbOuV6Jyd1Q2lrlMmzLi+/pMh7D22+lL+YmXE1E2fi9x4kZFSURQV
	 6e61W+oSCZK8nXPumaL1zpoS6efeG56Z7B6JSKISKLNe7Be0xdliZ5OameqhSKQjwq
	 Qde9XEnqlc5oHdEWeZxD3rwxtG3Myg38L/2FyaNgX3rjJ+XSzC+3xvlo2sFhK3fdfQ
	 JN5AWv0cbznMEIp7nRpv8aPRO5l97ktlQkvbcJkONUrwuCo/vUIWUxBEGGl7wRaD/g
	 OcBphnHZyjI566luw3JdZVfxXOu+OVZVr5jtSbkxwlAC4Asao8srl3g0Y73bP1yKgh
	 NFvI+2UUqyfzA==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xLBxOmbdUng6; Mon, 18 Dec 2023 12:39:54 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id D04F72D01868;
	Mon, 18 Dec 2023 12:39:53 +0100 (CET)
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
Subject: [PATCH v5 1/8] dmaengine: xilinx: xdma: Get rid of unused code
Date: Mon, 18 Dec 2023 12:39:36 +0100
Message-Id: <20231218113943.9099-2-jankul@alatek.krakow.pl>
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
=20
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
--=20
2.34.1


