Return-Path: <dmaengine+bounces-557-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E505B816CC0
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 12:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A7F281333
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 11:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109E437146;
	Mon, 18 Dec 2023 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="OGj7rcHG"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592451C69F;
	Mon, 18 Dec 2023 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alatek.krakow.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alatek.krakow.pl
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 55DF12D0186B;
	Mon, 18 Dec 2023 12:40:08 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id h2uf9FnBVTbJ; Mon, 18 Dec 2023 12:40:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 8DFDD2D0186A;
	Mon, 18 Dec 2023 12:40:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 8DFDD2D0186A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702899607;
	bh=FEcsprV3vVBU8tN4mn0OPH95yCWNxfshZ/vGB2JO2Kw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=OGj7rcHGESqG9XzXgjYZD6jqmhYxRGOTQHxns6/982zBeI6o49VexBzr5jne8dlLm
	 L2bxKzhVAC2AG9NPQbq8qqOo9a7TJC3JITt+bHk6gZIwuD8KzEwzsmYZFk69IqsFwA
	 TPJ762Poiu9TQdkX7CAP44dE3zfVF8JkKmlfuYGidA/M3EVmfwlZi6KrLUnDx4GKBp
	 1Bw1516M1v29DdH5r5ZDFbW28gP0LThp6870CjTTzcD7Tu0wO+3/7lyHqFgCCRzNet
	 6gtZ1lCdqREUb8yfxFi5UILpQwgS9gSdfJ6d9G+Vo989UP8/VHtFjlFCe5/y+SOFqo
	 LB9tzehhKWjlQ==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7pxWRintu_tT; Mon, 18 Dec 2023 12:40:07 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 021F82D01868;
	Mon, 18 Dec 2023 12:40:06 +0100 (CET)
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
Subject: [PATCH v5 2/8] dmaengine: xilinx: xdma: Add necessary macro definitions
Date: Mon, 18 Dec 2023 12:39:37 +0100
Message-Id: <20231218113943.9099-3-jankul@alatek.krakow.pl>
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

Complete lacking bits describing the status/control register values.
Add macros describing the status/control registers.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma-regs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-reg=
s.h
index 0b17a931f583..98117e8a466f 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -76,6 +76,7 @@ struct xdma_hw_desc {
 #define XDMA_CHAN_CONTROL_W1S		0x8
 #define XDMA_CHAN_CONTROL_W1C		0xc
 #define XDMA_CHAN_STATUS		0x40
+#define XDMA_CHAN_STATUS_RC		0x44
 #define XDMA_CHAN_COMPLETED_DESC	0x48
 #define XDMA_CHAN_ALIGNMENTS		0x4c
 #define XDMA_CHAN_INTR_ENABLE		0x90
@@ -101,6 +102,7 @@ struct xdma_hw_desc {
 #define CHAN_CTRL_IE_MAGIC_STOPPED		BIT(4)
 #define CHAN_CTRL_IE_IDLE_STOPPED		BIT(6)
 #define CHAN_CTRL_IE_READ_ERROR			GENMASK(13, 9)
+#define CHAN_CTRL_IE_WRITE_ERROR		GENMASK(18, 14)
 #define CHAN_CTRL_IE_DESC_ERROR			GENMASK(23, 19)
 #define CHAN_CTRL_NON_INCR_ADDR			BIT(25)
 #define CHAN_CTRL_POLL_MODE_WB			BIT(26)
@@ -111,8 +113,17 @@ struct xdma_hw_desc {
 			 CHAN_CTRL_IE_DESC_ALIGN_MISMATCH |		\
 			 CHAN_CTRL_IE_MAGIC_STOPPED |			\
 			 CHAN_CTRL_IE_READ_ERROR |			\
+			 CHAN_CTRL_IE_WRITE_ERROR |			\
 			 CHAN_CTRL_IE_DESC_ERROR)
=20
+#define XDMA_CHAN_STATUS_MASK CHAN_CTRL_START
+
+#define XDMA_CHAN_ERROR_MASK (CHAN_CTRL_IE_DESC_ALIGN_MISMATCH |	\
+			      CHAN_CTRL_IE_MAGIC_STOPPED |		\
+			      CHAN_CTRL_IE_READ_ERROR |			\
+			      CHAN_CTRL_IE_WRITE_ERROR |		\
+			      CHAN_CTRL_IE_DESC_ERROR)
+
 /* bits of the channel interrupt enable mask */
 #define CHAN_IM_DESC_ERROR			BIT(19)
 #define CHAN_IM_READ_ERROR			BIT(9)
--=20
2.34.1


