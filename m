Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3295F136F3D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jan 2020 15:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgAJOW5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jan 2020 09:22:57 -0500
Received: from olimex.com ([184.105.72.32]:43850 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgAJOW5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 Jan 2020 09:22:57 -0500
X-Greylist: delayed 655 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 09:22:57 EST
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <dmaengine@vger.kernel.org>; Fri, 10 Jan 2020 06:12:01 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list),
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 1/2] dmaengine: sun4i: Add support for cyclic requests with dedicated DMA
Date:   Fri, 10 Jan 2020 16:11:39 +0200
Message-Id: <20200110141140.28527-2-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110141140.28527-1-stefan@olimex.com>
References: <20200110141140.28527-1-stefan@olimex.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently the cyclic transfers can be used only with normal DMAs. They
can be used by pcm_dmaengine module, which is required for implementing
sound with sun4i-hdmi encoder. This is so because the controller can
accept audio only from a dedicated DMA.

This patch enables them, following the existing style for the
scatter/gather type transfers.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 drivers/dma/sun4i-dma.c | 45 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index e397a50058c8..7b41815d86fb 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -669,43 +669,41 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 	dma_addr_t src, dest;
 	u32 endpoints;
 	int nr_periods, offset, plength, i;
+	u8 ram_type, io_mode, linear_mode;
 
 	if (!is_slave_direction(dir)) {
 		dev_err(chan2dev(chan), "Invalid DMA direction\n");
 		return NULL;
 	}
 
-	if (vchan->is_dedicated) {
-		/*
-		 * As we are using this just for audio data, we need to use
-		 * normal DMA. There is nothing stopping us from supporting
-		 * dedicated DMA here as well, so if a client comes up and
-		 * requires it, it will be simple to implement it.
-		 */
-		dev_err(chan2dev(chan),
-			"Cyclic transfers are only supported on Normal DMA\n");
-		return NULL;
-	}
-
 	contract = generate_dma_contract();
 	if (!contract)
 		return NULL;
 
 	contract->is_cyclic = 1;
 
-	/* Figure out the endpoints and the address we need */
+	if (vchan->is_dedicated) {
+		io_mode = SUN4I_DDMA_ADDR_MODE_IO;
+		linear_mode = SUN4I_DDMA_ADDR_MODE_LINEAR;
+		ram_type = SUN4I_DDMA_DRQ_TYPE_SDRAM;
+	} else {
+		io_mode = SUN4I_NDMA_ADDR_MODE_IO;
+		linear_mode = SUN4I_NDMA_ADDR_MODE_LINEAR;
+		ram_type = SUN4I_NDMA_DRQ_TYPE_SDRAM;
+	}
+
 	if (dir == DMA_MEM_TO_DEV) {
 		src = buf;
 		dest = sconfig->dst_addr;
-		endpoints = SUN4I_DMA_CFG_SRC_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM) |
-			    SUN4I_DMA_CFG_DST_DRQ_TYPE(vchan->endpoint) |
-			    SUN4I_DMA_CFG_DST_ADDR_MODE(SUN4I_NDMA_ADDR_MODE_IO);
+		endpoints = SUN4I_DMA_CFG_DST_DRQ_TYPE(vchan->endpoint) |
+			    SUN4I_DMA_CFG_DST_ADDR_MODE(io_mode) |
+			    SUN4I_DMA_CFG_SRC_DRQ_TYPE(ram_type);
 	} else {
 		src = sconfig->src_addr;
 		dest = buf;
-		endpoints = SUN4I_DMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
-			    SUN4I_DMA_CFG_SRC_ADDR_MODE(SUN4I_NDMA_ADDR_MODE_IO) |
-			    SUN4I_DMA_CFG_DST_DRQ_TYPE(SUN4I_NDMA_DRQ_TYPE_SDRAM);
+		endpoints = SUN4I_DMA_CFG_DST_DRQ_TYPE(ram_type) |
+			    SUN4I_DMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
+			    SUN4I_DMA_CFG_SRC_ADDR_MODE(io_mode);
 	}
 
 	/*
@@ -747,8 +745,13 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 			dest = buf + offset;
 
 		/* Make the promise */
-		promise = generate_ndma_promise(chan, src, dest,
-						plength, sconfig, dir);
+		if (vchan->is_dedicated)
+			promise = generate_ddma_promise(chan, src, dest,
+							plength, sconfig);
+		else
+			promise = generate_ndma_promise(chan, src, dest,
+							plength, sconfig, dir);
+
 		if (!promise) {
 			/* TODO: should we free everything? */
 			return NULL;
-- 
2.17.1

