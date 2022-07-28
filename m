Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42165841C3
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiG1OgZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 10:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiG1OfQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 10:35:16 -0400
Received: from mail.baikalelectronics.com (unknown [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C48F491C5
        for <dmaengine@vger.kernel.org>; Thu, 28 Jul 2022 07:34:36 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 46FD45F89;
        Thu, 28 Jul 2022 17:31:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 46FD45F89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1659018692;
        bh=fnw6YfcisLG+r+b0P4r7zw/J8l1QC0hxTccFKPF3fXM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=e5adPdkzsjCP0ijvoLABOK5sjEnMAqCJ5D5jY8i96ZdazuIn85+6flsVVJwMVMMtL
         DF2daGYGf+Jchu+ENwh6y5hxC5SwrxvpyCb3Y0Ru4MO7ODT77BACPMeRKeCiZXl6uw
         HT+hoRMui2gTM+PxNSBIdgWF/xTc2/HM4uegJYWo=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Jul 2022 17:29:07 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
Date:   Thu, 28 Jul 2022 17:28:39 +0300
Message-ID: <20220728142841.12305-23-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
References: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>

---

Changelog v2:
- Fix the comment a bit to being clearer. (@Manivannan)

Changelog v3:
- Conditionally set dchan->dev->device.dma_coherent field since it can
  be missing on some platforms. (@Manivannan)
- Remove Manivannan' rb and tb tags since the patch content has been
  changed.
---
 drivers/dma/dw-edma/dw-edma-core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 6a8282eaebaf..4f56149dc8d8 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -716,6 +716,26 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->status != EDMA_ST_IDLE)
 		return -EBUSY;
 
+	/* Bypass the dma-ranges based memory regions mapping for the eDMA
+	 * controlled from the CPU/Application side since in that case
+	 * the local memory address is left untranslated.
+	 */
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		dchan->dev->chan_dma_dev = true;
+
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+		dchan->dev->device.dma_coherent = chan->dw->chip->dev->dma_coherent;
+#endif
+
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

