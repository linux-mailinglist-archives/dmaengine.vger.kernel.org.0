Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4331143C12
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2019 17:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfFMPdn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 11:33:43 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40766 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbfFMKfw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Jun 2019 06:35:52 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BFD9B1A0113;
        Thu, 13 Jun 2019 12:35:49 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C74081A038B;
        Thu, 13 Jun 2019 12:35:46 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C6079402A0;
        Thu, 13 Jun 2019 18:35:42 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org, leoyang.li@nxp.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [V2] dmaengine: fsl-edma: support little endian for edma driver
Date:   Thu, 13 Jun 2019 10:27:08 +0000
Message-Id: <20190613102708.21606-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Our platforms with below registers(CHCFG0 - CHCFG15) of eDMA
*-----------------------------------------------------------*
|     Offset   | Big endian Register| Little endian Register|
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

Current eDMA driver does not support Little endian, so this
patch is to improve edma driver to support little endian.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
Changed fo v2:
	- Add details fo comments.

 drivers/dma/fsl-edma-common.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 680b2a0..6bf238e 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -83,9 +83,14 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 	void __iomem *muxaddr;
 	unsigned int chans_per_mux, ch_off;
+	int endian_diff[4] = {3, 1, -1, -3};
 
 	chans_per_mux = fsl_chan->edma->n_chans / DMAMUX_NR;
 	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
+
+	if (!fsl_chan->edma->big_endian)
+		ch_off += endian_diff[ch_off % 4];
+
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-- 
1.7.1

