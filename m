Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB883BDFF1
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jul 2021 01:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGFX72 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Jul 2021 19:59:28 -0400
Received: from mx07-00376f01.pphosted.com ([185.132.180.163]:29154 "EHLO
        mx07-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229873AbhGFX72 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Jul 2021 19:59:28 -0400
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 166NVXxG032557;
        Wed, 7 Jul 2021 00:43:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=dk201812; bh=jEzXnVCx6Mdoe4csL3VU8+8+hZnGKEyYI8PFewbkI1M=;
 b=LJcl5MDXcbngG6r8j9Wr5x8qNBMikbxILVFP6QM1c+UP9GOKJ4FxgcqNEVfxHnZpuP57
 25LM9Iw9k3Lezfr4IhDrtktweiDaesEa6YUViRGtzxI2q/Ziqv9RMDwhoq3nyL+8bLuP
 bfyt0UG5NE73MGx9fQNmjb1g3MaMRFNDIiTt+jxPjhnsxOGOQNhh68szrvEAYH4tPtGU
 sH41PuOYvXDW0zOgOturvvElO/80kgvAFrlhtr4rTESoBhIe+g6Nn4wX0uHqsyHY8TOW
 GfKL+hk5DvrzoCYmRZ06FIeFv1H7QjW+tHcG2EGeuWoF35bmYpNJbCvmYE23DtDnGK3+ JQ== 
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com with ESMTP id 39ms1j08cm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Jul 2021 00:43:50 +0100
Received: from adrianlarumbe-HP-Elite-7500-Series-MT.hh.imgtec.org
 (10.100.70.86) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 7 Jul 2021 00:43:49 +0100
From:   Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <adrian.martinezlarumbe@imgtec.com>
Subject: [PATCH 2/2] xilinx_dma: Fix read-after-free bug when terminating transfers
Date:   Wed, 7 Jul 2021 00:43:38 +0100
Message-ID: <20210706234338.7696-3-adrian.martinezlarumbe@imgtec.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.70.86]
X-ClientProxiedBy: HHMAIL05.hh.imgtec.org (10.100.10.120) To
 HHMAIL05.hh.imgtec.org (10.100.10.120)
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: OF7SzEO7z0OEnT3wj26JgO7F4LdRNCJ4
X-Proofpoint-GUID: OF7SzEO7z0OEnT3wj26JgO7F4LdRNCJ4
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When user calls dmaengine_terminate_sync, the driver will clean up any
remaining descriptors for all the pending or active transfers that had
previously been submitted. However, this might happen whilst the tasklet is
invoking the DMA callback for the last finished transfer, so by the time it
returns and takes over the channel's spinlock, the list of completed
descriptors it was traversing is no longer valid. This leads to a
read-after-free situation.

Fix it by signalling whether a user-triggered termination has happened by
means of a boolean variable.

Signed-off-by: Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 0e2bf75d42d3..8258e9fcc179 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -394,6 +394,7 @@ struct xilinx_dma_tx_descriptor {
  * @genlock: Support genlock mode
  * @err: Channel has errors
  * @idle: Check for channel idle
+ * @terminating: Check for channel being synchronized by user
  * @tasklet: Cleanup work after irq
  * @config: Device configuration info
  * @flush_on_fsync: Flush on Frame sync
@@ -431,6 +432,7 @@ struct xilinx_dma_chan {
 	bool genlock;
 	bool err;
 	bool idle;
+	bool terminating;
 	struct tasklet_struct tasklet;
 	struct xilinx_vdma_config config;
 	bool flush_on_fsync;
@@ -1049,6 +1051,13 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 		/* Run any dependencies, then free the descriptor */
 		dma_run_dependencies(&desc->async_tx);
 		xilinx_dma_free_tx_descriptor(chan, desc);
+
+		/*
+		 * While we ran a callback the user called a terminate function,
+		 * which takes care of cleaning up any remaining descriptors
+		 */
+		if (chan->terminating)
+			break;
 	}
 
 	spin_unlock_irqrestore(&chan->lock, flags);
@@ -1965,6 +1974,8 @@ static dma_cookie_t xilinx_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	if (desc->cyclic)
 		chan->cyclic = true;
 
+	chan->terminating = false;
+
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return cookie;
@@ -2556,6 +2567,7 @@ static int xilinx_dma_terminate_all(struct dma_chan *dchan)
 
 	xilinx_dma_chan_reset(chan);
 	/* Remove and free all of the descriptors in the lists */
+	chan->terminating = true;
 	xilinx_dma_free_descriptors(chan);
 	chan->idle = true;
 
-- 
2.17.1

