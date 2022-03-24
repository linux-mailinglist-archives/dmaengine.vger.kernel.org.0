Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF744E9CA6
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbiC1QqF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242660AbiC1Qpz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:45:55 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1F4421246;
        Mon, 28 Mar 2022 09:44:07 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 348211E495D;
        Thu, 24 Mar 2022 04:48:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 348211E495D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086535;
        bh=9SPPRQfYXqos/xXWWQfUIiy2dltWIdc2l/4SV3Of+L8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=U+76/BpfTNVjj2/LrtAZkiu6zTfxaNNdNJs1UFeTaUJPp9ltn5HI/uoY4fx2HJ8Hw
         cPbj+O+3w1WocZap4Q6GIfF5OCCb0sPoE+8/H9kPvuCO6gR3VCwkSKZ16DhDj51gWF
         JqYmjaH9/k0Ty6agwY3hQNMaxxpkLnkVF/E1rEKU=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:54 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 23/25] dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
Date:   Thu, 24 Mar 2022 04:48:34 +0300
Message-ID: <20220324014836.19149-24-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DW eDMA doesn't perform any translation of the traffic generated on the
CPU/Application side. It just generates read/write AXI-bus requests with
the specified addresses. But in case if the dma-ranges DT-property is
specified for a platform device node, Linux will use it to map the CPU
memory regions into the DMAable bus ranges. This isn't what we want for
the eDMA embedded into the locally accessed DW PCIe Root Port and
End-point. In order to work that around let's set the chan_dma_dev flag
for each DW eDMA channel thus forcing the client drivers to getting a
custom dma-ranges-less parental device for the mappings.

Note it will only work for the client drivers using the
dmaengine_get_dma_device() method to get the parental DMA device.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/dma/dw-edma/dw-edma-core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 72a51970bfba..ca5cd7c99571 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -716,6 +716,21 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->status != EDMA_ST_IDLE)
 		return -EBUSY;
 
+	/* Bypass the dma-ranges based memory regions mapping since the
+	 * inbound iATU only affects the traffic incoming from the
+	 * PCIe bus.
+	 */
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		dchan->dev->chan_dma_dev = true;
+
+		dchan->dev->device.dma_coherent = chan->dw->chip->dev->dma_coherent;
+		dma_coerce_mask_and_coherent(&dchan->dev->device,
+					     dma_get_mask(chan->dw->chip->dev));
+		dchan->dev->device.dma_parms = chan->dw->chip->dev->dma_parms;
+	} else {
+		dchan->dev->chan_dma_dev = false;
+	}
+
 	pm_runtime_get(chan->dw->chip->dev);
 
 	return 0;
-- 
2.35.1

