Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCD064D3C8
	for <lists+dmaengine@lfdr.de>; Thu, 15 Dec 2022 00:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiLNXxa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Dec 2022 18:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLNXxN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Dec 2022 18:53:13 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFA0215FFE;
        Wed, 14 Dec 2022 15:53:09 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 0FE34E0ED6;
        Thu, 15 Dec 2022 02:53:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=CMqRD5y1KwNE68dtSN0+jpInJ/I2HNrwqeLfpSXlN4g=; b=EASLnws44xhu
        l4e4Nk6Q5wtsJEjLgyj+PwPF4fPJ+8ud2o2NryEf7lHl8pfAFuooRMolfXcc2e7V
        J3101iDbI8vgXeI14P3+ea+3X7UHU8uBe5YJLzLiqipl6HmududA6tQRG3uAV2ZS
        1gUOVaXI8/XTSkSQy2YAMRh3n1Q7SbE=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 02D9DE0E6B;
        Thu, 15 Dec 2022 02:53:09 +0300 (MSK)
Received: from localhost (10.8.30.6) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Thu, 15 Dec 2022 02:53:08 +0300
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
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v7 02/25] dmaengine: dw-edma: Release requested IRQs on failure
Date:   Thu, 15 Dec 2022 02:52:42 +0300
Message-ID: <20221214235305.31744-3-Sergey.Semin@baikalelectronics.ru>
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

From very beginning of the DW eDMA driver live in the kernel the method
dw_edma_irq_request() hasn't been designed quite correct. In case if the
request_irq() method fails to initialize the IRQ handler at some point the
previously requested IRQs will be left initialized. It's prune to errors
up to the system crash. Let's fix that by releasing the previously
requested IRQs in the cleanup-on-error path of the dw_edma_irq_request()
function.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>

---

Changelog v2:
- This is a new patch added in v2 iteration of the series.
---
 drivers/dma/dw-edma/dw-edma-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c54b24ff5206..a8c1bd9c7ae9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -893,10 +893,8 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 						dw_edma_interrupt_read,
 					  IRQF_SHARED, dw->name,
 					  &dw->irq[i]);
-			if (err) {
-				dw->nr_irqs = i;
-				return err;
-			}
+			if (err)
+				goto err_irq_free;
 
 			if (irq_get_msi_desc(irq))
 				get_cached_msi_msg(irq, &dw->irq[i].msi);
@@ -905,6 +903,14 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 		dw->nr_irqs = i;
 	}
 
+	return 0;
+
+err_irq_free:
+	for  (i--; i >= 0; i--) {
+		irq = chip->ops->irq_vector(dev, i);
+		free_irq(irq, &dw->irq[i]);
+	}
+
 	return err;
 }
 
-- 
2.38.1


