Return-Path: <dmaengine+bounces-240-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAE57F84B9
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 20:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C461F20628
	for <lists+dmaengine@lfdr.de>; Fri, 24 Nov 2023 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547E39FF3;
	Fri, 24 Nov 2023 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="sx/kn3UN"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823BD384D;
	Fri, 24 Nov 2023 11:26:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 8B33E2CE00D8;
	Fri, 24 Nov 2023 20:26:36 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 3Wyw9UDK6470; Fri, 24 Nov 2023 20:26:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 31E232CE00D5;
	Fri, 24 Nov 2023 20:26:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 31E232CE00D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700853996;
	bh=H3UOebWbztiN0l07oDLxMwZHegqQNqhnZ63Q4IX1xxM=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=sx/kn3UN96dLfEqk3VI5IhC/VPJkWSSP8cPDmTa3yBW47VIS41J+/K/JtIjPZu1oK
	 R+CvpTMsUQo7vo+s2L86DfIwj+eFKJzVrn8wslUmbuYjyrEaiCOpTJdHh1AsbIvFY2
	 dLiV6VZFpoSJXn2X1/opmSStQg4/RFo0p8ctm9zFmt31ypU1tcYy0H83tifqGDOe5P
	 LCJblmPesz25d8VPRykHgqHrVrGhGgcjBohr5PvYEvMz12/AEnqJv7cpjbq3ukm1b+
	 EcLNMyXpAI4lvADuhrNkF1qDFH5zDN/vSp/nYsMhCEIaV49OgV/SDlAQD2agg2ypP7
	 33Y4goo7YCe6Q==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id OPjaALiZmbOG; Fri, 24 Nov 2023 20:26:36 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id F3C862CE00D3;
	Fri, 24 Nov 2023 20:26:35 +0100 (CET)
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
Subject: [PATCH v3 3/5] dmaengine: xilinx: xdma: Complete lacking register description
Date: Fri, 24 Nov 2023 20:25:56 +0100
Message-Id: <20231124192558.135004-4-jankul@alatek.krakow.pl>
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


