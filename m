Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3425841BD
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 16:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiG1OgW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 10:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiG1OfN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 10:35:13 -0400
Received: from mail.baikalelectronics.com (unknown [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D265141D03
        for <dmaengine@vger.kernel.org>; Thu, 28 Jul 2022 07:34:33 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id B3C2F16D7;
        Thu, 28 Jul 2022 17:31:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com B3C2F16D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1659018669;
        bh=bA4WQAY8CizPkO+9IE2AjYNnbT8/R2l+P47T/SmQGRk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FgO9ubxj/6bE6eSTuM+UaAneOB0ZrZl8UztyxMneRe46VWM2lF1DhyfjqbwuTtc9+
         G2pOQAvLQ9y+CnnaSpf5cwMGc/EgiBvu41wgcjZDVWKmAmYQSBtY/00fBLd8hak1r4
         DoR0VhryNyDoRLrz4hVcEpXmHdbbTSgSnIa6+FPE=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Jul 2022 17:28:44 +0300
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
Subject: [PATCH v4 01/24] dmaengine: Fix dma_slave_config.dst_addr description
Date:   Thu, 28 Jul 2022 17:28:18 +0300
Message-ID: <20220728142841.12305-2-Sergey.Semin@baikalelectronics.ru>
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

Most likely due to a copy-paste mistake the dst_addr member of the
dma_slave_config structure has been marked as ignored if the !source!
address belong to the memory. That is relevant to the src_addr field of
the structure while the dst_addr field as containing a destination device
address is supposed to be ignored if the destination is the CPU memory.
Let's fix the field description accordingly.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 include/linux/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b46b88e6aa0d..afa12e7beed3 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -395,7 +395,7 @@ enum dma_slave_buswidth {
  * should be read (RX), if the source is memory this argument is
  * ignored.
  * @dst_addr: this is the physical address where DMA slave data
- * should be written (TX), if the source is memory this argument
+ * should be written (TX), if the destination is memory this argument
  * is ignored.
  * @src_addr_width: this is the width in bytes of the source (RX)
  * register where DMA data shall be read. If the source
-- 
2.35.1

