Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC00546179
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jun 2022 11:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348724AbiFJJQQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jun 2022 05:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347288AbiFJJPN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jun 2022 05:15:13 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50339202D1C;
        Fri, 10 Jun 2022 02:15:11 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 0F07116A3;
        Fri, 10 Jun 2022 12:15:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 0F07116A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654852558;
        bh=AOzpzrUv0cjDgGcyDVNi0IQ1AeSIujyMW483On0uzW8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=gy5mDmuFUvwcAmJdkugvMKu/8giqUxMWY0aGB7yz+qGnLh4339SUmfrjYhE/mfRBX
         HODcHLYSJ/pK/MR0siidzuRMHhFUrftAGKM+cOhXTlNBwoA/qqTZN6+ohE1uea63pV
         AKT5NURVXgMhVgVpEKiFH0Lww7Wr4eIITCHpXO7o=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 12:15:05 +0300
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
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v3 02/24] dmaengine: dw-edma: Release requested IRQs on failure
Date:   Fri, 10 Jun 2022 12:14:37 +0300
Message-ID: <20220610091459.17612-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

---

Changelog v2:
- This is a new patch added in v2 iteration of the series.
---
 drivers/dma/dw-edma/dw-edma-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 07f756479663..04efcb16d13d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -899,10 +899,8 @@ static int dw_edma_irq_request(struct dw_edma *dw,
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
@@ -911,6 +909,14 @@ static int dw_edma_irq_request(struct dw_edma *dw,
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
2.35.1

