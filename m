Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7934E9C79
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbiC1QqL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242678AbiC1QqD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:46:03 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8C1B21E3D;
        Mon, 28 Mar 2022 09:44:16 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D0F2F1E494B;
        Thu, 24 Mar 2022 04:48:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru D0F2F1E494B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086526;
        bh=FMSz5zMuaHmaqav0lPq43UKO/Chw55VmoyBGraCce7Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=SL7h4pN9/6SGpVGqlT2MNtGklqb8g9EhQkzhNeIDpY9DiSkeIfsvD607yftsx9xEx
         aecc2asohi/6Ax+JhWfEjwGOjajMbsh9+LtHuQ967ClZeM6anpj/K8/s142RN2/Yf+
         yXHojAAlsXyMKoKHJ9+DKRtQalu3D887FcXybi00=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:46 +0300
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
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH 12/25] dmaengine: dw-edma: Fix DebugFS reg entry type
Date:   Thu, 24 Mar 2022 04:48:23 +0300
Message-ID: <20220324014836.19149-13-Sergey.Semin@baikalelectronics.ru>
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
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 3a899f7f4e8d..12845a2dc016 100644
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
2.35.1

