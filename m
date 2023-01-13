Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CAA66A07E
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jan 2023 18:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjAMRY3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Jan 2023 12:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjAMRXy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Jan 2023 12:23:54 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C34F9A4C73;
        Fri, 13 Jan 2023 09:14:43 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 9A41AE0F30;
        Fri, 13 Jan 2023 20:14:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=d7bJelLGSWZmM7IXBZfGb6iRBR8TCuRpsPrdqslUK5E=; b=v1Y4Zv1XgLQQ
        wxMzn5D0uXPjyNwJkp/fbevesPq7ksq6PhryOdRwg2DxVfs5h4yZftrKAw5eO1UD
        yWdWY4pahoZ1ThcOJQHMwhxAvJ9QSqi/gkky9BxnCPtrqp1dEegq+RDO3qIpi7lm
        3r3iHcqg08tEgzvxyCuvgOCBvi/ImnE=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 71B8CE0F13;
        Fri, 13 Jan 2023 20:14:38 +0300 (MSK)
Received: from localhost (10.8.30.26) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Jan 2023 20:14:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 25/27] PCI: dwc: Set coherent DMA-mask on MSI-address allocation
Date:   Fri, 13 Jan 2023 20:14:07 +0300
Message-ID: <20230113171409.30470-26-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
References: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.26]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The MSI target address requires to be reserved within the lowest 4GB
memory in order to support the PCIe peripherals with no 64-bit MSI TLPs
support. Since the allocation is done from the DMA-coherent memory let's
modify the allocation procedure to setting the coherent DMA-mask only and
avoiding the streaming DMA-mask modification. Thus at least the streaming
DMA operations would work with no artificial limitations. It will be
specifically useful for the eDMA-capable controllers so the corresponding
DMA-engine clients would map the DMA buffers with no need in the SWIOTLB
intervention for the buffers allocated above the 4GB memory region.

While at it let's add a brief comment about the reason of having the MSI
target address allocated from the DMA-coherent memory limited with the 4GB
upper bound.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>

---

Changelog v8:
- This is a new patch added on v8 stage of the series.
  (@Robin, @Christoph)
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3ab6ae3712c4..e10608af39b4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -366,7 +366,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 						    dw_chained_msi_isr, pp);
 	}
 
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	/*
+	 * Even though the iMSI-RX Module supports 64-bit addresses some
+	 * peripheral PCIe devices may lack the 64-bit messages support. In
+	 * order not to miss MSI TLPs from those devices the MSI target address
+	 * has to be reserved within the lowest 4GB.
+	 * Note until there is a better alternative found the reservation is
+	 * done by allocating from the artificially limited DMA-coherent
+	 * memory.
+	 */
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (ret)
 		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
 
-- 
2.39.0


