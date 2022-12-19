Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507FF650DCA
	for <lists+dmaengine@lfdr.de>; Mon, 19 Dec 2022 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiLSOrj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Dec 2022 09:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiLSOrR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Dec 2022 09:47:17 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9701A63F9;
        Mon, 19 Dec 2022 06:47:03 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 04A22E0EAF;
        Mon, 19 Dec 2022 17:47:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=h43jggFkHbpSKEdtfUv/QU5I7Y2qMI4tAlStsWepeHc=; b=eg7dt+W5RwE3
        4R8F0w/E9guUa9lxTDYUeF42UKWyyCwg6ks7Dwso1mGV9i8vP3vnJbev4L/pYbzV
        M7ikX5fIBdj7f1uAwR/z4q8D6ZfNPrf2cBc+Tnqb7VDLmKMvc8DL6HVszIc+1drq
        10kk+8oGusMDevatskRoYdLpALgc+bI=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id ED682E0E70;
        Mon, 19 Dec 2022 17:47:01 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Mon, 19 Dec 2022 17:47:01 +0300
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
Subject: [PATCH v8 01/26] dmaengine: Fix dma_slave_config.dst_addr description
Date:   Mon, 19 Dec 2022 17:46:32 +0300
Message-ID: <20221219144658.26620-2-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219144658.26620-1-Sergey.Semin@baikalelectronics.ru>
References: <20221219144658.26620-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.14]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 include/linux/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c923f4e60f24..0c020682d894 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -394,7 +394,7 @@ enum dma_slave_buswidth {
  * should be read (RX), if the source is memory this argument is
  * ignored.
  * @dst_addr: this is the physical address where DMA slave data
- * should be written (TX), if the source is memory this argument
+ * should be written (TX), if the destination is memory this argument
  * is ignored.
  * @src_addr_width: this is the width in bytes of the source (RX)
  * register where DMA data shall be read. If the source
-- 
2.38.1


