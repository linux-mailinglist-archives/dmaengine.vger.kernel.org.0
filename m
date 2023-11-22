Return-Path: <dmaengine+bounces-186-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE977F5301
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 23:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABA4281406
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ACA1D548;
	Wed, 22 Nov 2023 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="f4s1fWSQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D185E1A5;
	Wed, 22 Nov 2023 14:11:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id C22492D00B62;
	Wed, 22 Nov 2023 23:11:03 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id pdB1MUBkCbJE; Wed, 22 Nov 2023 23:11:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 8278E2D00B61;
	Wed, 22 Nov 2023 23:11:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 8278E2D00B61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700691063;
	bh=H3UOebWbztiN0l07oDLxMwZHegqQNqhnZ63Q4IX1xxM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=f4s1fWSQb78tnRN8iWTm6t5zobvN/vf5Y+pkArUjEzkaWzD6VOiUuNW6iQDsyJXTm
	 kfPax90sQk4wNCApvnYZfwy08Anb/vZYR5G/3J8vvbbHaelNO2pRiEnzukOL5N9sQN
	 A341E0ydkBBeZcEMgZN/q/+DtcgAYjBBC0QNYTzzmpaacYEnFxe6CVSaDds3UaUqoI
	 hO5OGNq0iN5PcEMxfqpYHTxcDDYvOcijYkxT6LRGtJ9tCDr/Qau6I3IzuTrNPlRGNH
	 +eE9d+dmlEwQq58xQuZJnOVZDx8btyBblyjqfdEbo5gnIyRYiDnT/fArCW3NuUI+tp
	 H9sk3TGlzZIQA==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id MVhGrBPj2ONb; Wed, 22 Nov 2023 23:11:03 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 4C4D32D00B60;
	Wed, 22 Nov 2023 23:11:03 +0100 (CET)
From: Jan Kuliga <jankul@alatek.krakow.pl>
To: lizhi.hou@amd.com,
	brian.xu@amd.com,
	raj.kumar.rampelli@amd.com,
	vkoul@kernel.org,
	michal.simek@amd.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH 3/5] dmaengine: xilinx: xdma: Complete lacking register description
Date: Wed, 22 Nov 2023 23:09:19 +0100
Message-Id: <20231122220921.117428-4-jankul@alatek.krakow.pl>
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

Complete lacking bits, that describe the status/control register values.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma-regs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-reg=
s.h
index 7a169377b483..654c5e41112d 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -102,6 +102,7 @@ struct xdma_hw_desc {
 #define CHAN_CTRL_IE_MAGIC_STOPPED		BIT(4)
 #define CHAN_CTRL_IE_IDLE_STOPPED		BIT(6)
 #define CHAN_CTRL_IE_READ_ERROR			GENMASK(13, 9)
+#define CHAN_CTRL_IE_WRITE_ERROR		GENMASK(18, 14)
 #define CHAN_CTRL_IE_DESC_ERROR			GENMASK(23, 19)
 #define CHAN_CTRL_NON_INCR_ADDR			BIT(25)
 #define CHAN_CTRL_POLL_MODE_WB			BIT(26)
@@ -112,6 +113,7 @@ struct xdma_hw_desc {
 			 CHAN_CTRL_IE_DESC_ALIGN_MISMATCH |		\
 			 CHAN_CTRL_IE_MAGIC_STOPPED |			\
 			 CHAN_CTRL_IE_READ_ERROR |			\
+			 CHAN_CTRL_IE_WRITE_ERROR |			\
 			 CHAN_CTRL_IE_DESC_ERROR)
=20
 /* bits of the channel interrupt enable mask */
--=20
2.34.1


