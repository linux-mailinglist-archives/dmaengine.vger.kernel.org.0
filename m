Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57244E9C77
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbiC1QqC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbiC1Qpw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:45:52 -0400
X-Greylist: delayed 4199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Mar 2022 09:44:08 PDT
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61D8A205CB;
        Mon, 28 Mar 2022 09:44:07 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 324381E493E;
        Thu, 24 Mar 2022 04:48:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 324381E493E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086521;
        bh=45B91bTRPDAiVVFXTWFyOKTO4rQMMJ7SJOEIZd4mBWc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dVfKrMhpppasdM6ZNQchY65q3OjcV7bv4h6qHkClv1TE0UUtDK5Dsl0/17AKVVv74
         EtW5Jl1AEs39t5gyGJzX8mqREeaGK3RMsA3uH2es9XaedS2ywgZyIFYCc7t9ZgxxGt
         hfDk87OB95UkS1yUXErO5TXCgfF9uFFyz19zEb8E=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:41 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/25] dmaengine: Fix dma_slave_config.dst_addr description
Date:   Thu, 24 Mar 2022 04:48:15 +0300
Message-ID: <20220324014836.19149-5-Sergey.Semin@baikalelectronics.ru>
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

Most likely due to a copy-paste mistake the dst_addr member of the
dma_slave_config structure has been marked as ignored if the !source!
address belong to the memory. That is relevant to the src_addr field of
the structure while the dst_addr field as containing a destination device
address is supposed to be ignored if the destination is the CPU memory.
Let's fix the field description accordingly.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 include/linux/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 842d4f7ca752..f204ea16ac1c 100644
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

