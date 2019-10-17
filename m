Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 344BDDA64E
	for <lists+dmaengine@lfdr.de>; Thu, 17 Oct 2019 09:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408101AbfJQHU0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Oct 2019 03:20:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36822 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408044AbfJQHUW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Oct 2019 03:20:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C58F1A0935;
        Thu, 17 Oct 2019 09:20:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2EB661A060C;
        Thu, 17 Oct 2019 09:20:17 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 80967402AE;
        Thu, 17 Oct 2019 15:20:12 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        k.kozlowski.k@gmail.com, fabio.estevam@nxp.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [PATCH] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A platform
Date:   Thu, 17 Oct 2019 15:09:23 +0800
Message-Id: <20191017070923.6705-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Our platforms with below registers(CHCFG0 - CHCFG15) of eDMA as follows:
*-----------------------------------------------------------*
|     Offset   |	OTHERS      |		LS1028A	    |
|--------------|--------------------|-----------------------|
|     0x0      |        CHCFG0      |           CHCFG3      |
|--------------|--------------------|-----------------------|
|     0x1      |        CHCFG1      |           CHCFG2      |
|--------------|--------------------|-----------------------|
|     0x2      |        CHCFG2      |           CHCFG1      |
|--------------|--------------------|-----------------------|
|     0x3      |        CHCFG3      |           CHCFG0      |
|--------------|--------------------|-----------------------|
|     ...      |        ......      |           ......      |
|--------------|--------------------|-----------------------|
|     0xC      |        CHCFG12     |           CHCFG15     |
|--------------|--------------------|-----------------------|
|     0xD      |        CHCFG13     |           CHCFG14     |
|--------------|--------------------|-----------------------|
|     0xE      |        CHCFG14     |           CHCFG13     |
|--------------|--------------------|-----------------------|
|     0xF      |        CHCFG15     |           CHCFG12     |
*-----------------------------------------------------------*

This patch is to improve edma driver to fit LS1028A platform.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b1a7ca9..611186b 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/sys_soc.h>
 
 #include "fsl-edma-common.h"
 
@@ -42,6 +43,11 @@
 
 #define EDMA_TCD		0x1000
 
+static struct soc_device_attribute soc_fixup_tuning[] = {
+	{ .family = "QorIQ LS1028A"},
+	{ },
+};
+
 static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 {
 	struct edma_regs *regs = &fsl_chan->edma->regs;
@@ -109,10 +115,16 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 	void __iomem *muxaddr;
 	unsigned int chans_per_mux, ch_off;
+	int endian_diff[4] = {3, 1, -1, -3};
 	u32 dmamux_nr = fsl_chan->edma->drvdata->dmamuxs;
 
 	chans_per_mux = fsl_chan->edma->n_chans / dmamux_nr;
 	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
+
+	if (!fsl_chan->edma->big_endian &&
+	    soc_device_match(soc_fixup_tuning))
+		ch_off += endian_diff[ch_off % 4];
+
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-- 
2.9.5

