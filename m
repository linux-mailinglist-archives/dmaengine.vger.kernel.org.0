Return-Path: <dmaengine+bounces-678-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33A2825285
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jan 2024 12:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A701C20D75
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jan 2024 11:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D52C857;
	Fri,  5 Jan 2024 11:00:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C1F2C84F
	for <dmaengine@vger.kernel.org>; Fri,  5 Jan 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=48ers.dk
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07EADE0012;
	Fri,  5 Jan 2024 11:00:05 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peko@48ers.dk>)
	id 1rLhvp-005kSX-0C;
	Fri, 05 Jan 2024 12:00:05 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH] dmaengine: xilinx_dma: check for invalid vdma interleaved parameters
Date: Fri,  5 Jan 2024 11:59:56 +0100
Message-Id: <20240105105956.1370220-1-peter@korsgaard.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: peter@korsgaard.com

The VDMA HSIZE register (corresponding to sgl[0].size) is only 16bit wide /
the VSIZE register (corresponding to numf) is only 13bit wide, so reject
requests not fitting within that rather than silently transferring too
little data.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index e40696f6f864..5eb51ae93e89 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -112,7 +112,9 @@
 
 /* Register Direct Mode Registers */
 #define XILINX_DMA_REG_VSIZE			0x0000
+#define XILINX_DMA_VSIZE_MASK			GENMASK(12, 0)
 #define XILINX_DMA_REG_HSIZE			0x0004
+#define XILINX_DMA_HSIZE_MASK			GENMASK(15, 0)
 
 #define XILINX_DMA_REG_FRMDLY_STRIDE		0x0008
 #define XILINX_DMA_FRMDLY_STRIDE_FRMDLY_SHIFT	24
@@ -2050,6 +2052,10 @@ xilinx_vdma_dma_prep_interleaved(struct dma_chan *dchan,
 	if (!xt->numf || !xt->sgl[0].size)
 		return NULL;
 
+	if (xt->numf & ~XILINX_DMA_VSIZE_MASK ||
+	    xt->sgl[0].size & ~XILINX_DMA_HSIZE_MASK)
+		return NULL;
+
 	if (xt->frame_size != 1)
 		return NULL;
 
-- 
2.39.2


