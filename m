Return-Path: <dmaengine+bounces-417-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB4880A4BA
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2961F20FAD
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609CB1D537;
	Fri,  8 Dec 2023 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="qIfwW8Zq"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74881706;
	Fri,  8 Dec 2023 05:50:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id A8CD42D00F54;
	Fri,  8 Dec 2023 14:50:12 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id JBQzyMXMEnKr; Fri,  8 Dec 2023 14:50:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 442862D00F53;
	Fri,  8 Dec 2023 14:50:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 442862D00F53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702043408;
	bh=rjl10Q6vv79c/VjetazpETH5QmjolDY1PkqfCQ5TdI0=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=qIfwW8Zq2rMbJovcgbhAbqJJlDriJFOLpZQktxxCg6SlU33Y4GEFA6lZ6nzPS1eCJ
	 ojqsFF8dfRF4O5R0WBzJVP9CO84ZTrOjM+fEHX7v0re+vxN08gmb5OcSOP6HgLqn14
	 86C0TKpsML47mxm2jQo5YKWx3g1ZMMN9+AoxsYWMM0gHxozJzoqK7OfZD4of/UdY6A
	 rKr0OyxP+aBeFwbyXIqxwMv5OujoUeQ392cXxb6EPd1OfTXbC3HwmBb8dCNxPGANAw
	 ealn4irlEid8mEJPnuz7qQvMVh/PY96hO50I9YgA0x5DNs83xXCVvhHOdX6IHlMedA
	 PR8n5QKqRIYbA==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ITpTl4yrV2e8; Fri,  8 Dec 2023 14:50:08 +0100 (CET)
Received: from localhost.localdomain (unknown [10.125.125.6])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 9C6F42D00F4D;
	Fri,  8 Dec 2023 14:50:07 +0100 (CET)
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
Subject: [PATCH v4 2/8] dmaengine: xilinx: xdma: Add necessary macro definitions
Date: Fri,  8 Dec 2023 14:49:23 +0100
Message-Id: <20231208134929.49523-3-jankul@alatek.krakow.pl>
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

Complete lacking bits describing the status/control register values.
Add macros describing the status/control registers.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma-regs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-reg=
s.h
index 0b17a931f583..b12dd60629f6 100644
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

+#define XDMA_CHAN_STATUS_MASK CHAN_CTRL_START
+
+#define XDMA_CHAN_ERROR_MASK (CHAN_CTRL_IE_DESC_ALIGN_MISMATCH |	\
+				CHAN_CTRL_IE_MAGIC_STOPPED |		\
+				CHAN_CTRL_IE_READ_ERROR |		\
+				CHAN_CTRL_IE_WRITE_ERROR |		\
+				CHAN_CTRL_IE_DESC_ERROR)
+
 /* bits of the channel interrupt enable mask */
 #define CHAN_IM_DESC_ERROR			BIT(19)
 #define CHAN_IM_READ_ERROR			BIT(9)
--
2.34.1


