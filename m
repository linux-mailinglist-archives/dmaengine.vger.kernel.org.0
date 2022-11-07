Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029906200AD
	for <lists+dmaengine@lfdr.de>; Mon,  7 Nov 2022 22:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiKGVO1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Nov 2022 16:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiKGVOG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Nov 2022 16:14:06 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 557F33204D
        for <dmaengine@vger.kernel.org>; Mon,  7 Nov 2022 13:11:01 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 6AF1DE0EE0;
        Tue,  8 Nov 2022 00:05:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=9h7dS4QrWKWOTqtPtbuvDyKihSQ7MoE9BsNBgXy0LMQ=; b=RmiTHmd4gupS
        ElXTwapE15dFptTAghkeGlWcEG1DYCY6IX3+Q36DeTwyOn4eVM3AD+rrIIGTYiim
        jLsuy3THF6jYQG6YBdKtLPrEQjneTEqmOtKjtWpUkpFkVXIPrmDLKPAlcoZRshHn
        TRa1uNdi886qIQQE3ys9rMNcLOAfiD0=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 5812DE0ED3;
        Tue,  8 Nov 2022 00:05:02 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 8 Nov 2022 00:05:01 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>, <linux-pci@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
Date:   Tue, 8 Nov 2022 00:04:36 +0300
Message-ID: <20221107210438.1515-23-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DW eDMA doesn't perform any translation of the traffic generated on the
CPU/Application side. It just generates read/write AXI-bus requests with
the specified addresses. But in case if the dma-ranges DT-property is
specified for a platform device node, Linux will use it to create a
mapping the PCIe-bus regions into the CPU memory ranges. This isn't what
we want for the eDMA embedded into the locally accessed DW PCIe Root Port
and End-point. In order to work that around let's set the chan_dma_dev
flag for each DW eDMA channel thus forcing the client drivers to getting a
custom dma-ranges-less parental device for the mappings.

Note it will only work for the client drivers using the
dmaengine_get_dma_device() method to get the parental DMA device.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Fix the comment a bit to being clearer. (@Manivannan)

Changelog v3:
- Conditionally set dchan->dev->device.dma_coherent field since it can
  be missing on some platforms. (@Manivannan)
- Remove Manivannan' rb and tb tags since the patch content has been
  changed.

Changelog v6:
- Directly call *_dma_configure() method on the child device used for
  the DMA buffers mapping. (@Robin)
- Explicitly set the DMA-mask of the child device in the channel
  allocation proecedure. (@Robin)
- Drop @Manivannan and @Vinod rb- and ab-tags due to significant patch
  content change.
---
 drivers/dma/dw-edma/dw-edma-core.c | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index e3671bfbe186..846518509753 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -6,9 +6,11 @@
  * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/of_device.h>
 #include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -711,10 +713,52 @@ static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
 static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	struct device *dev = chan->dw->chip->dev;
+	int ret;
 
 	if (chan->status != EDMA_ST_IDLE)
 		return -EBUSY;
 
+	/* Bypass the dma-ranges based memory regions mapping for the eDMA
+	 * controlled from the CPU/Application side since in that case
+	 * the local memory address is left untranslated.
+	 */
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		ret = dma_coerce_mask_and_coherent(&dchan->dev->device,
+						   DMA_BIT_MASK(64));
+		if (ret) {
+			ret = dma_coerce_mask_and_coherent(&dchan->dev->device,
+							   DMA_BIT_MASK(32));
+			if (ret)
+				return ret;
+		}
+
+		if (dev_of_node(dev)) {
+			struct device_node *node = dev_of_node(dev);
+
+			ret = of_dma_configure(&dchan->dev->device, node, true);
+		} else if (has_acpi_companion(dev)) {
+			struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
+
+			ret = acpi_dma_configure(&dchan->dev->device,
+						 acpi_get_dma_attr(adev));
+		} else {
+			ret = -EINVAL;
+		}
+
+		if (ret)
+			return ret;
+
+		if (dchan->dev->device.dma_range_map) {
+			kfree(dchan->dev->device.dma_range_map);
+			dchan->dev->device.dma_range_map = NULL;
+		}
+
+		dchan->dev->chan_dma_dev = true;
+	} else {
+		dchan->dev->chan_dma_dev = false;
+	}
+
 	return 0;
 }
 
-- 
2.38.0


