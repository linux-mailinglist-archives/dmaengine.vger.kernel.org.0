Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C12714744
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 11:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfEFJLs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 05:11:48 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44052 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfEFJLh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 May 2019 05:11:37 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AD3041A024E;
        Mon,  6 May 2019 11:11:35 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C77381A0017;
        Mon,  6 May 2019 11:11:30 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 70EDE402C7;
        Mon,  6 May 2019 17:11:24 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>
Subject: [PATCH 3/4] dmaengine: fsl-edma: support little endian for edma driver
Date:   Mon,  6 May 2019 09:03:43 +0000
Message-Id: <20190506090344.37784-3-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190506090344.37784-1-peng.ma@nxp.com>
References: <20190506090344.37784-1-peng.ma@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

improve edma driver to support little endian.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
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

