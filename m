Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D088339E17
	for <lists+dmaengine@lfdr.de>; Sat, 13 Mar 2021 13:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhCMMyD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 13 Mar 2021 07:54:03 -0500
Received: from www381.your-server.de ([78.46.137.84]:36978 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhCMMxi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 13 Mar 2021 07:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=z3QoH/g4KV9tJ/IP5eIssf5nCa9iLBczLjga/2/t/7s=; b=dGu0ZESZRTq74iMjElUSL56zk8
        mtTKuJieLFhxHxBhkoh2LETHSvxofZTtw9LFjGKgmPR5ZzAkE0pjv3+2uT5Hrs6FeLnC62Hg+vE6y
        q0mH82oZdQbu0rO/G22x1m1HUxL6EMa4ZoRA/uBUYa/1xJN6ftX5diPFod7NrQzBlAMIoVKUl4ksz
        6QCMHeaDf6VY5sEvYOd3dymFosg72zzi/Mc9CG6sgl8f1Bq45S81u21qh7+DxC7qjBtwt6HyK3bRZ
        c38Dc+xZ5NGMCzFqpVk8AiOHHLr71XhquYS7XbFD9ZVzKWAwczH6YF2p18EWQwhsF2V3NkqXJsetF
        GkLFgT8w==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lL3lu-0008BT-LG; Sat, 13 Mar 2021 13:53:34 +0100
Received: from [2001:a61:2aea:a901:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lL3lu-000RmU-Fe; Sat, 13 Mar 2021 13:53:34 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Shravya Kumbham <shravya.kumbham@xilinx.com>,
        dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] dmaengine: xilinx: Introduce synchronize() callback
Date:   Sat, 13 Mar 2021 13:53:11 +0100
Message-Id: <20210313125311.4823-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26106/Fri Mar 12 13:03:16 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Xilinx dmaengine driver uses a tasklet to process completed
descriptors and execute their callbacks.

Currently consumers of the DMA channel have to no method of synchronization
against this tasklet when using the Xilinx dmaengine drivers. This can lead
to race conditions when the consumer frees resources that are accessed in
the callback before the tasklet has finished running.

It is not enough to just call dmaengine_terminal_all() since on a
multi-processor system the tasklet can run concurrently to it and might
call the callback after dmaengine_terminate_all() has already finished.

To mitigate this issue implement the synchronize() callback for the driver,
which will wait until the tasklet has finished.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/dma/xilinx/xilinx_dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3aded7861fef..75c0b8e904e5 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2453,6 +2453,13 @@ static int xilinx_dma_terminate_all(struct dma_chan *dchan)
 	return 0;
 }
 
+static void xilinx_dma_synchronize(struct dma_chan *dchan)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+
+	tasklet_kill(&chan->tasklet);
+}
+
 /**
  * xilinx_dma_channel_set_config - Configure VDMA channel
  * Run-time configuration for Axi VDMA, supports:
@@ -3074,6 +3081,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.device_free_chan_resources =
 				xilinx_dma_free_chan_resources;
 	xdev->common.device_terminate_all = xilinx_dma_terminate_all;
+	xdev->common.device_synchronize = xilinx_dma_synchronize;
 	xdev->common.device_tx_status = xilinx_dma_tx_status;
 	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-- 
2.20.1

