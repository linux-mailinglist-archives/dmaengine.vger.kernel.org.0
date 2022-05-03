Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBFF51920D
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 01:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiECXFA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 19:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbiECXEL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 19:04:11 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2891612776
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 16:00:36 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A64761DFF8;
        Wed,  4 May 2022 01:51:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru A64761DFF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651618316;
        bh=2MYB16qpdIVrYxsByKyJJ05Sct/CcoC6KsAd6/vjIys=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=PDtLnmz1COmF8TSpSclu10F+ABKq5MTVExFJLBwY29ddKhcJVAFLkVJ2JKw+FV4lS
         dhWJrD4ukL+zx8zWdobnHNIHTkFRUwg+3qXPYW7PN8Xz8moNcQlDopo9N2fRJLEo6j
         ZNpGO38pQbF1B/daunsG0p1ZHh5rKZZwl2FvnZRw=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 01:51:22 +0300
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
Subject: [PATCH v2 10/26] dmaengine: dw-edma: Drop chancnt initialization
Date:   Wed, 4 May 2022 01:50:48 +0300
Message-ID: <20220503225104.12108-11-Sergey.Semin@baikalelectronics.ru>
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

DMA device drivers aren't supposed to initialize the dma_device.chancnt
field. It will be done by the DMA-engine core in accordance with number of
added virtual DMA-channels. Pre-initializing it with some value causes
having a wrong number of channels printed in the device summary.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index be466b781376..e9cb3056b6b7 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -823,7 +823,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
 	dma->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
-	dma->chancnt = cnt;
 
 	/* Set DMA channel callbacks */
 	dma->dev = chip->dev;
-- 
2.35.1

