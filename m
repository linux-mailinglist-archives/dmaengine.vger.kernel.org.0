Return-Path: <dmaengine+bounces-185-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA17F52FF
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 23:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B51281300
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 22:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E71C6AC;
	Wed, 22 Nov 2023 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="QzalEWDB"
X-Original-To: dmaengine@vger.kernel.org
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Nov 2023 14:10:56 PST
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDCCB9;
	Wed, 22 Nov 2023 14:10:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 3A0782D00B62;
	Wed, 22 Nov 2023 23:10:54 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 7_61pp17CotE; Wed, 22 Nov 2023 23:10:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id BA0802D00B61;
	Wed, 22 Nov 2023 23:10:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl BA0802D00B61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700691053;
	bh=zqhIViRnFAruL/za3c8L0vX7XiguXIze1f1rq462g3c=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=QzalEWDBuAGVa1ZsyGuBY5GIO6DI2q0cyCpPEznHTAzEnx4cW8hyU2I5NDijb19+6
	 /5+gITOl16ULH/mXAMmZWBmzOpECtVf0+ktncgaPU2fYQxNMVgsyZq3nkGprJIFHf6
	 ODGGu9KTQXxoGJF02NwqAdf+3Eo28aZDyv92awIcmZkZrvYZgBqiOCqdhlYAeO4odP
	 LOIVFvzrzI7bIDEHSuSYwvKOGHZg5GGUdEqfXBZHspUYYfJmPvX+VR7IWGxJY/6V8L
	 ObZRn6J/9OWJnNdFsU0dVjo89cJzJNt1q/ls713GLjoC5uw1Ss/CYXylv0Jb95qfIL
	 0LuGAgnIjAXcQ==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id a-T0EIX3QnDb; Wed, 22 Nov 2023 23:10:53 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 81AD02D00B60;
	Wed, 22 Nov 2023 23:10:53 +0100 (CET)
From: Jan Kuliga <jankul@alatek.krakow.pl>
To: lizhi.hou@amd.com,
	brian.xu@amd.com,
	raj.kumar.rampelli@amd.com,
	vkoul@kernel.org,
	michal.simek@amd.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH 2/5] dmaengine: xilinx: xdma: Get rid of duplicated macros definitions
Date: Wed, 22 Nov 2023 23:09:18 +0100
Message-Id: <20231122220921.117428-3-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122220830.117403-1-jankul@alatek.krakow.pl>
References: <20231122220830.117403-1-jankul@alatek.krakow.pl>
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


