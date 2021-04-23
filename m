Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD19368A62
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 03:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbhDWBbN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Apr 2021 21:31:13 -0400
Received: from mx07-00376f01.pphosted.com ([185.132.180.163]:24284 "EHLO
        mx07-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236126AbhDWBbM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Apr 2021 21:31:12 -0400
X-Greylist: delayed 657 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Apr 2021 21:31:12 EDT
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 13N0xc8C008391;
        Fri, 23 Apr 2021 02:19:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=dk201812; bh=knSJFN6woQoqRmSWeKpa/mjHq3c7kZoaJanH8t7euhQ=;
 b=Lw9Abprj6+T2FmhbbI2QRgm0GhrGPHghEzB9+L9nv6CwmvhuoZx9uK8IT2XbM9Hsw4E9
 l40rkbf8EGWh9l9gUCj4jgjNaXUuPws9nMW431qXKyRYveCMWnc52ljvRlzvZXgSkuUW
 ya0vUAU2prTTpbfH65tv+ZAayzltV1PUSLtH3pZt3Up92UBw5QPc5+z2Q3cVZUwnSFR/
 lS3yUOYezfYPYyO6r4EzCxqy8UvDj0toLvrezIeN0cw2oiE3vakPCCIqEFuwlIn4EgaD
 rg5CG3lZ+MpHIT/9zFkLjtym9wECQBVQp9ld8D4aKbiZX36AncZBGTrmB+GEk3nqiCPB DA== 
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com with ESMTP id 382p9395yh-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 02:19:27 +0100
Received: from adrianlarumbe-HP-Elite-7500-Series-MT.hh.imgtec.org
 (10.100.70.86) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 02:19:26 +0100
From:   Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <adrian.martinezlarumbe@imgtec.com>
Subject: [PATCH 4/4] dmaengine: xilinx_dma: Add device synchronisation callback
Date:   Fri, 23 Apr 2021 02:19:13 +0100
Message-ID: <20210423011913.13122-5-adrian.martinezlarumbe@imgtec.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.70.86]
X-ClientProxiedBy: HHMAIL05.hh.imgtec.org (10.100.10.120) To
 HHMAIL05.hh.imgtec.org (10.100.10.120)
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: ZEYxpdMS8Vd_trDFtzcZW3ryaTVAgBZJ
X-Proofpoint-ORIG-GUID: ZEYxpdMS8Vd_trDFtzcZW3ryaTVAgBZJ
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This was required as an answer to a very unusual race condition, whereby a
thread waiting on a completion signaled in a callback triggered by
dmaengine_desc_callback_invoke might immediately attempt to release the
DMA channel whilst the channel lock was still free. This would cause the
remaining descriptors to be deallocated, and xilinx_dma_chan_desc_cleanup
to perform an invalid memory access when attempting to traverse the rest
of the channel's done_list.

Now, when releasing a DMA channel, it will wait until the tasklet has
finished.

Signed-off-by: Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 40c6cf8bf0e6..d4bad999e7f9 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -942,6 +942,13 @@ static void xilinx_dma_free_chan_resources(struct dma_chan *dchan)
 
 }
 
+static void xilinx_dma_synchronize(struct dma_chan *dchan)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+
+	tasklet_kill(&chan->tasklet);
+}
+
 /**
  * xilinx_dma_get_residue - Compute residue for a given descriptor
  * @chan: Driver specific dma channel
@@ -3235,6 +3242,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.device_tx_status = xilinx_dma_tx_status;
 	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
 	xdev->common.device_config = xilinx_dma_slave_config;
+	xdev->common.device_synchronize = xilinx_dma_synchronize;
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
-- 
2.17.1

