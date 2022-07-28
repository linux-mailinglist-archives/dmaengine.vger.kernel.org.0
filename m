Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A135841C5
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 16:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiG1Og0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 10:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiG1OfQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 10:35:16 -0400
Received: from mail.baikalelectronics.com (unknown [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 482DA49B55;
        Thu, 28 Jul 2022 07:34:36 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 489C95F8A;
        Thu, 28 Jul 2022 17:31:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 489C95F8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1659018693;
        bh=jfexZWKKgmMoKbQRWSmsZpAuHhXpqLZNAGbwd9rIFCk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=JwGP6lHgKp1hhhomwDh5DlQNweWvw6NNEWx3Ojbp9ZnCe3/c2SzX8YPaxBOWvlTBr
         z611TFt4TRi39DFX3i20VjOtdoEMMfrBOy1plHVVVn7x5OJCC4AjSi36kzC96fUwoH
         yr7uysvcoLAmtHbg26FieGegFRUweAsFI/yUtewY=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Jul 2022 17:29:08 +0300
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
Subject: [PATCH v4 23/24] dmaengine: dw-edma: Skip cleanup procedure if no private data found
Date:   Thu, 28 Jul 2022 17:28:40 +0300
Message-ID: <20220728142841.12305-24-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
References: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DW eDMA driver private data is preserved in the passed DW eDMA chip info
structure. If either probe procedure failed or for some reason the passed
info object doesn't have private data pointer initialized we need to halt
the DMA device cleanup procedure in order to prevent possible system
crashes.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 4f56149dc8d8..5736a537f4c8 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1040,6 +1040,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	struct dw_edma *dw = chip->dw;
 	int i;
 
+	/* Skip removal if no private data found */
+	if (!dw)
+		return -ENODEV;
+
 	/* Disable eDMA */
 	dw_edma_v0_core_off(dw);
 
-- 
2.35.1

