Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7E166A09C
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jan 2023 18:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjAMRZH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Jan 2023 12:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjAMRX7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Jan 2023 12:23:59 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7291A4C75;
        Fri, 13 Jan 2023 09:14:45 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id E04AEE0F2F;
        Fri, 13 Jan 2023 20:14:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=ShlLyppeLQtb7T6fwIeGywjfZSVNMRyBEPj0UpV2Cxk=; b=g4NndmnTbR/O
        9TPYxPWkt8bjsKL2cUpaTSFzBjyGph5YVhUTPWVvImlqa/wdrpnHGsQGY4LXK+Sb
        emUZmj41YkhZonumS6dQJfHW1epKP9+XL24b8S3/oXMGZq+zblHkFSBAJTstcwSl
        +9ITOKRhhSCy9buXOfaGhT56kAIdtaY=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id C508DE0F13;
        Fri, 13 Jan 2023 20:14:37 +0300 (MSK)
Received: from localhost (10.8.30.26) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Jan 2023 20:14:37 +0300
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
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 24/27] dmaengine: dw-edma: Relax driver config settings
Date:   Fri, 13 Jan 2023 20:14:06 +0300
Message-ID: <20230113171409.30470-25-Sergey.Semin@baikalelectronics.ru>
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

Since the DW PCIe RP/EP driver is about to be updated to register the DW
eDMA-based DMA-engine the drivers build modes must be synchronized.
Currently the DW PCIe RP/EP driver is always built as a builtin module.
Meanwhile the DW eDMA driver can be built as a loadable module. Thus in
the later case the kernel with DW PCIe controllers support will fail to be
linked due to lacking the DW eDMA probe/remove symbols. At the same time
forcibly selecting the DW eDMA driver from the DW PCIe RP/EP kconfig will
effectively eliminate the tristate type of the former driver fixing it to
just the builtin kernel module.

Seeing the DW eDMA engine isn't that often met built into the DW PCIe
Root-ports and End-points let's convert the DW eDMA driver config to being
more flexible instead of just forcibly selecting the DW eDMA kconfig. In
order to do that first the DW eDMA PCIe driver config should be converted
to being depended from the DW eDMA core config instead of selecting the
one. Second the DW eDMA probe and remove symbols should be referenced only
if they are reachable by the caller. Thus the user will be able to build
the DW eDMA core driver with any type, meanwhile the dependent code will
be either restricted to the same build type (e.g. DW eDMA PCIe driver if
DW eDMA driver is built as a loadable module) or just won't be able to use
the eDMA engine registration/de-registration functionality (e.g. DW PCIe
RP/EP driver if DW eDMA driver is built as a loadable module).

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v8:
- This is a new patch added on v8 stage of the series in order to fix
  the tbot-reported build issues. (@tbot)
---
 drivers/dma/dw-edma/Kconfig | 5 ++++-
 include/linux/dma/edma.h    | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/Kconfig b/drivers/dma/dw-edma/Kconfig
index 7ff17b2db6a1..2b6f2679508d 100644
--- a/drivers/dma/dw-edma/Kconfig
+++ b/drivers/dma/dw-edma/Kconfig
@@ -9,11 +9,14 @@ config DW_EDMA
 	  Support the Synopsys DesignWare eDMA controller, normally
 	  implemented on endpoints SoCs.
 
+if DW_EDMA
+
 config DW_EDMA_PCIE
 	tristate "Synopsys DesignWare eDMA PCIe driver"
 	depends on PCI && PCI_MSI
-	select DW_EDMA
 	help
 	  Provides a glue-logic between the Synopsys DesignWare
 	  eDMA controller and an endpoint PCIe device. This also serves
 	  as a reference design to whom desires to use this IP.
+
+endif # DW_EDMA
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 08833f12b386..c062c8db472c 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -101,7 +101,7 @@ struct dw_edma_chip {
 };
 
 /* Export to the platform drivers */
-#if IS_ENABLED(CONFIG_DW_EDMA)
+#if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
 #else
-- 
2.39.0


