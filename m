Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC3462B0A7
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 10:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfE0IuI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 04:50:08 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53294 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfE0IuG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 04:50:06 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DF3D200B05;
        Mon, 27 May 2019 10:50:04 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ABA3A200AFC;
        Mon, 27 May 2019 10:49:58 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 73051402CB;
        Mon, 27 May 2019 16:49:51 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 3/7] dmaengine: fsl-edma-common: move dmamux register to another single function
Date:   Mon, 27 May 2019 16:51:14 +0800
Message-Id: <20190527085118.40423-4-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527085118.40423-1-yibin.gong@nxp.com>
References: <20190527085118.40423-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Prepare for edmav2 on i.mx7ulp whose dmamux register is 32bit. No function
impacted.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index c9a17fc..bb24251 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -77,6 +77,19 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
 }
 EXPORT_SYMBOL_GPL(fsl_edma_disable_request);
 
+static void mux_configure8(struct fsl_edma_chan *fsl_chan, void __iomem *addr,
+			   u32 off, u32 slot, bool enable)
+{
+	u8 val8;
+
+	if (enable)
+		val8 = EDMAMUX_CHCFG_ENBL | slot;
+	else
+		val8 = EDMAMUX_CHCFG_DIS;
+
+	iowrite8(val8, addr + off);
+}
+
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 			unsigned int slot, bool enable)
 {
@@ -89,10 +102,7 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-	if (enable)
-		iowrite8(EDMAMUX_CHCFG_ENBL | slot, muxaddr + ch_off);
-	else
-		iowrite8(EDMAMUX_CHCFG_DIS, muxaddr + ch_off);
+	mux_configure8(fsl_chan, muxaddr, ch_off, slot, enable);
 }
 EXPORT_SYMBOL_GPL(fsl_edma_chan_mux);
 
-- 
2.7.4

