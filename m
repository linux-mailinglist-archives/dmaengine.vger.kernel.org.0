Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E615E46D2AA
	for <lists+dmaengine@lfdr.de>; Wed,  8 Dec 2021 12:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhLHLpu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Dec 2021 06:45:50 -0500
Received: from www381.your-server.de ([78.46.137.84]:51728 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhLHLpu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Dec 2021 06:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=MSCoooSWTOObGbfrBw3mVYxfczZquyZLluvhHPEBvro=; b=hulgcaNmkbZ4XY7AM+pBJNKay5
        cS2SiYpRouUJ0zYLegMIq99exzunNZ49+OxLj2b5AOklp7jMJ+cUzLbb4GRHaHS4schm6tlVNVgDe
        9ukllDH2/rHCT5ifNdzaJArh/doX3uDsDXv8888W9WwAHNq7hljngE+8RaGd+IABVqj9+B01rGWxS
        FDNXe7t9Snfkd2oj9jRkCumUfAjemfpuFtGSj3S8TnqILBz1PYbnrAQbFhNI382lVcLaW9OVIRYgy
        uCMPwZQ6bNQUaIwgl1EKnwL8zmAWY3Mfde0JMfdYVxjWowMNfRKwkyNK+aka+0WeX0JVUfmdZZeRX
        ki1UZ4DA==;
Received: from [78.46.152.42] (helo=sslproxy04.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1muvKz-0003uV-AZ; Wed, 08 Dec 2021 12:42:17 +0100
Received: from [2001:a61:2ba4:ec01:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1muvKz-0003wB-3j; Wed, 08 Dec 2021 12:42:17 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] dmaengine: xilinx: Handle IRQ mapping errors
Date:   Wed,  8 Dec 2021 12:42:12 +0100
Message-Id: <20211208114212.234130-1-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26377/Wed Dec  8 10:23:25 2021)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Handle errors when trying to map the IRQ for the DMA channels.

The main motivation here is to be able to handle probe deferral. E.g. when
using DT overlays it is possible that the DMA controller is probed before
interrupt controller, depending on the order in the DT.

In order to support this switch from irq_of_parse_and_map() to
of_irq_get(), which internally does the same, but it will return
EPROBE_DEFER when the interrupt controller is not yet available.

As a result other errors, such as an invalid IRQ specification, or missing
IRQ are also properly handled.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/dma/xilinx/xilinx_dma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 61618148f9d4..cd62bbb50e8b 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2980,7 +2980,9 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	}
 
 	/* Request the interrupt */
-	chan->irq = irq_of_parse_and_map(node, chan->tdest);
+	chan->irq = of_irq_get(node, chan->tdest);
+	if (chan->irq < 0)
+		return dev_err_probe(xdev->dev, chan->irq, "failed to get irq\n");
 	err = request_irq(chan->irq, xdev->dma_config->irq_handler,
 			  IRQF_SHARED, "xilinx-dma-controller", chan);
 	if (err) {
@@ -3054,8 +3056,11 @@ static int xilinx_dma_child_probe(struct xilinx_dma_device *xdev,
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA && ret < 0)
 		dev_warn(xdev->dev, "missing dma-channels property\n");
 
-	for (i = 0; i < nr_channels; i++)
-		xilinx_dma_chan_probe(xdev, node);
+	for (i = 0; i < nr_channels; i++) {
+		ret = xilinx_dma_chan_probe(xdev, node);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.30.2

