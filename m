Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64064E9CC0
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbiC1QqR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242935AbiC1QqE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:46:04 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76B17222A1;
        Mon, 28 Mar 2022 09:44:17 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8C8691E493D;
        Thu, 24 Mar 2022 04:48:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 8C8691E493D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086520;
        bh=AYgCGlj6XCp3KD2/KUlHJg+55HiFo50ys5cdSY8nwOc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Gdpk4DVTE1MY+dgZ0kGVMp67RyX8d1SyCg2QO2NJHj25IYEGxOxb8VC4cSyQcFRx4
         sxb20q0ugu4aEjTmpg69ImHd3ruWyaaxda/H8iMTCWfSg/qZlBV6hI7F5qPAIl5pvM
         TH40nEUw788A0bI+6t728iRMW+6lqKWGI7yOKtds=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:40 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account in resource mapping
Date:   Thu, 24 Mar 2022 04:48:14 +0300
Message-ID: <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
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

A basic device-specific linear memory mapping was introduced back in
commit ("dma: Take into account dma_pfn_offset") as a single-valued offset
preserved in the device.dma_pfn_offset field, which was initialized for
instance by means of the "dma-ranges" DT property. Afterwards the
functionality was extended to support more than one device-specific region
defined in the device.dma_range_map list of maps. But all of these
improvements concerned a single pointer, page or sg DMA-mapping methods,
while the system resource mapping function turned to miss the
corresponding modification. Thus the dma_direct_map_resource() method now
just casts the CPU physical address to the device DMA address with no
dma-ranges-based mapping taking into account, which is obviously wrong.
Let's fix it by using the phys_to_dma_direct() method to get the
device-specific bus address from the passed memory resource for the case
of the directly mapped DMA.

Fixes: 25f1e1887088 ("dma: Take into account dma_pfn_offset")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 50f48e9e4598..9ce8192b29ab 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -497,7 +497,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t dma_addr = paddr;
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, paddr);
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
 		dev_err_once(dev,
-- 
2.35.1

