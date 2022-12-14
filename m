Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F9464D3F9
	for <lists+dmaengine@lfdr.de>; Thu, 15 Dec 2022 00:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiLNXyJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Dec 2022 18:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiLNXx0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Dec 2022 18:53:26 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B5A7511F5;
        Wed, 14 Dec 2022 15:53:25 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id D056AE0ED5;
        Thu, 15 Dec 2022 02:53:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=2P5zIEafAOu1EyjDFBiB1YmEXwVrq8QtBXlII/SZHN8=; b=VQ9fVGAWH9yI
        YIuNheh0n3mzDqpB1ud49IMFvAB1FxwL6IdXG13G5jZg/FGzxksWTsPbE7JaT+Ag
        TcEd0QWgIdEGomRl/91HhuI3KtTmKNAOd951fColo2l7JEublz5w9kV4381p0GaT
        A6I5F7cWbHDaGVJ8zUDw7O2okYFEB2Y=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id C3FF5E0E6B;
        Thu, 15 Dec 2022 02:53:24 +0300 (MSK)
Received: from localhost (10.8.30.6) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Thu, 15 Dec 2022 02:53:24 +0300
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
Subject: [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data allocation
Date:   Thu, 15 Dec 2022 02:53:03 +0300
Message-ID: <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.6]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DW PCIe Root Ports and End-points can be equipped with the DW eDMA engine.
In that case it is critical to have the platform device pre-initialized
with a valid DMA-mask so the drivers using the eDMA-engine would be able
to allocate the DMA-able buffers. The MSI-capable data requires to be
allocated from the lowest 4GB region. Since that procedure implies the
DMA-mask change we need to restore the mask set by the low-level drivers
after the MSI-data allocation is done.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v7:
- This is a new patch added on v7 stage of the series. (@Robin)
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 5762bd306261..1a3dae1f6aa2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -326,7 +326,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	u64 *msi_vaddr;
+	u64 *msi_vaddr, dma_mask;
 	int ret;
 	u32 ctrl, num_ctrls;
 
@@ -366,6 +366,13 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 						    dw_chained_msi_isr, pp);
 	}
 
+	/*
+	 * Save and then restore the DMA-mask pre-set by the low-level drivers
+	 * after allocating the MSI-capable region. The mask might be useful for
+	 * the controllers with the embedded eDMA engine.
+	 */
+	dma_mask = dma_get_mask(dev);
+
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
@@ -378,6 +385,10 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 		return -ENOMEM;
 	}
 
+	ret = dma_set_mask_and_coherent(dev, dma_mask);
+	if (ret)
+		dev_warn(dev, "Failed to re-store DMA-mask\n");
+
 	return 0;
 }
 
-- 
2.38.1


