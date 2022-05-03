Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08990519201
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 01:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbiECXEx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 19:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243987AbiECXEI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 19:04:08 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C06567649
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 16:00:30 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5636016D7;
        Wed,  4 May 2022 01:51:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 5636016D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651618309;
        bh=dHnrw4Yo3Al5iA5h1bR5VD8xJ9NUF0bPsnyiAWzrWUw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=SPRK52L6rdgQhI+1MkBl7WUlb4Qadn5O30YG/R6wBSUpdgn90SGy+wChwcLNtejqr
         szoC/b/KLqAqfAIQMpYL0K+NSeR3LLxXPT5aORrlucAFInEUNrrB1wDp3bj84fq/l6
         mRumf8VzycfyyMJxDtKqtMpXyZrzVFHIaVgpfEV8=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 01:51:15 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v2 03/26] dmaengine: dw-edma: Release requested IRQs on failure
Date:   Wed, 4 May 2022 01:50:41 +0300
Message-ID: <20220503225104.12108-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
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

