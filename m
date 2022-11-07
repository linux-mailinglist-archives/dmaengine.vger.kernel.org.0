Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991846200A7
	for <lists+dmaengine@lfdr.de>; Mon,  7 Nov 2022 22:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiKGVOT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Nov 2022 16:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiKGVOF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Nov 2022 16:14:05 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE9BD3122E
        for <dmaengine@vger.kernel.org>; Mon,  7 Nov 2022 13:11:01 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 3B53AE0ED4;
        Tue,  8 Nov 2022 00:04:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=MetEG4KJHDXQMmx8MrKkAEmRRe2sA3yO4gTvl4rDKyY=; b=sM0oZqHn35WQ
        GEU9MjyH3nlmtRLMvBLnNdFrSMJfL5DHKBbJkKJ3vOJ4IkQEhs7sfVVkbVRQOX2t
        RXg+08O1Ed2wTu46E560C2/EyOLX/jeAjTlWVM9NR0wRVP1uayQzg9/uQTwjTvwG
        VPef+tT7PcWtBYDB5A58V3wJRxUTt5A=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 2CCFEE0ED3;
        Tue,  8 Nov 2022 00:04:52 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 8 Nov 2022 00:04:51 +0300
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
        caihuoqing <caihuoqing@baidu.com>, <linux-pci@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 10/24] dmaengine: dw-edma: Fix DebugFS reg entry type
Date:   Tue, 8 Nov 2022 00:04:24 +0300
Message-ID: <20221107210438.1515-11-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107210438.1515-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

debugfs_entries structure declared in the dw-edma-v0-debugfs.c module
contains the DebugFS node' register address. The address is declared as
dma_addr_t type, but first it's assigned with virtual CPU IOMEM address
and then it's cast back to the virtual address. Even though the castes
sandwich will unlikely cause any problem since normally DMA address is at
least of the same size as the CPU virtual address, it's at the very least
redundant if not to say logically incorrect. Let's fix it by just stop
casting the pointer back and worth and just preserve the address as a
pointer to void with __iomem qualifier.

Fixes: 305aebeff879 ("dmaengine: Add Synopsys eDMA IP version 0 debugfs support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 5226c9014703..8e61810dea4b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -14,7 +14,7 @@
 #include "dw-edma-core.h"
 
 #define REGS_ADDR(name) \
-	((void __force *)&regs->name)
+	((void __iomem *)&regs->name)
 #define REGISTER(name) \
 	{ #name, REGS_ADDR(name) }
 
@@ -48,12 +48,13 @@ static struct {
 
 struct debugfs_entries {
 	const char				*name;
-	dma_addr_t				*reg;
+	void __iomem				*reg;
 };
 
 static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 {
-	void __iomem *reg = (void __force __iomem *)data;
+	void __iomem *reg = data;
+
 	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
 	    reg >= (void __iomem *)&regs->type.legacy.ch) {
 		void __iomem *ptr = &regs->type.legacy.ch;
-- 
2.38.0


