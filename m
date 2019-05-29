Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BE32D879
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2019 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfE2JHM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 May 2019 05:07:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47860 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfE2JHM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 May 2019 05:07:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4195A1A03CE;
        Wed, 29 May 2019 11:07:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 90DC51A11DD;
        Wed, 29 May 2019 11:07:04 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4E132402FA;
        Wed, 29 May 2019 17:06:57 +0800 (SGT)
From:   yibin.gong@nxp.com
To:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 2/8] dmaengine: mcf-edma: update to 'dmamux_nr'
Date:   Wed, 29 May 2019 17:08:42 +0800
Message-Id: <20190529090848.34350-3-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529090848.34350-1-yibin.gong@nxp.com>
References: <20190529090848.34350-1-yibin.gong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Update to 'dmamux_nr' instead of static macro DMAMUX_NR since
new version edma only has one dmamux.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 2 +-
 drivers/dma/mcf-edma.c        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 680b2a0..c9a17fc 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -84,7 +84,7 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	void __iomem *muxaddr;
 	unsigned int chans_per_mux, ch_off;
 
-	chans_per_mux = fsl_chan->edma->n_chans / DMAMUX_NR;
+	chans_per_mux = fsl_chan->edma->n_chans / fsl_chan->edma->dmamux_nr;
 	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
diff --git a/drivers/dma/mcf-edma.c b/drivers/dma/mcf-edma.c
index 7de54b2f..4484190 100644
--- a/drivers/dma/mcf-edma.c
+++ b/drivers/dma/mcf-edma.c
@@ -189,6 +189,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
 
 	/* Set up version for ColdFire edma */
 	mcf_edma->version = v2;
+	mcf_edma->dmamux_nr = DMAMUX_NR;
 	mcf_edma->big_endian = 1;
 
 	if (!mcf_edma->n_chans) {
-- 
2.7.4

