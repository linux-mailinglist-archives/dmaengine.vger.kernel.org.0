Return-Path: <dmaengine+bounces-239-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AFF7F84B8
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 20:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465C81C2242E
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 19:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F1F39FF3;
	Fri, 24 Nov 2023 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="oe2kSsOs"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4886E35B4;
	Fri, 24 Nov 2023 11:26:30 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id C806B2CE00D5;
	Fri, 24 Nov 2023 20:26:28 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id KNT9NsVn8hlx; Fri, 24 Nov 2023 20:26:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 571CF2CE00D3;
	Fri, 24 Nov 2023 20:26:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 571CF2CE00D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700853988;
	bh=zqhIViRnFAruL/za3c8L0vX7XiguXIze1f1rq462g3c=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=oe2kSsOsQT+t8VLbc/jz6+b7+ZxSYy0gfL71v+ZaCSYkzikTavdFxZco7+kOxf8g8
	 7jCYG1JTDZRoprvdF8Jcu+QvZhQj4m/TYHqCwl3+zskImLA5nlTZHJWXgx7rbanu+h
	 LmJdQChYcLfKQKZBE5Z944suto2/mR2Qj0ff9KIEJtgqRXhSO5T0cq4E+pcGderoTw
	 8p2MJumWLfmoqYRV1+TdNc53aOxyCmj/B/Hp31eOYbK0omcYDrjzg33Sn3L67lDegk
	 ToBGYPFWB0v8aBXLkEqFmGxnYX6tU1wh18P0zP25boCb015HncK3Z6iQwDlXrhrBhF
	 wxIz9m/VIQoaQ==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id pbP_qd8M5zBS; Fri, 24 Nov 2023 20:26:28 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 22BF02CE00D1;
	Fri, 24 Nov 2023 20:26:28 +0100 (CET)
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
Subject: [PATCH v3 2/5] dmaengine: xilinx: xdma: Get rid of duplicated macros definitions
Date: Fri, 24 Nov 2023 20:25:55 +0100
Message-Id: <20231124192558.135004-3-jankul@alatek.krakow.pl>
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

These macros are defined earlier in the file.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma-regs.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-reg=
s.h
index 1f17ce165f92..7a169377b483 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -135,18 +135,6 @@ struct xdma_hw_desc {
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
--=20
2.34.1


