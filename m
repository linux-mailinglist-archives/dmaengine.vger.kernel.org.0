Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA79866A055
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jan 2023 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjAMRXH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Jan 2023 12:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjAMRWa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Jan 2023 12:22:30 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F0D2A1800;
        Fri, 13 Jan 2023 09:14:22 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id CA9F3E0F1F;
        Fri, 13 Jan 2023 20:14:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=Tx45rUBHoY/IsByRXGmLDUzcyD/t/V57Pwb7WAVxkr8=; b=FRFEF4hEpa30
        o5WHIa8irBVECooc7iFSTZNe0seOayNevSg5DU1rQKZtaQcjTFJy11BqIS6gRMDQ
        GzBMXQeOsJttkHSJAIs+vEf9L/FLuZMhWzmHpTvSBjIAJ0a+srPa0Mxc0nZbSJMD
        LdhjBx+8UH/O2n8YnRcxPjuedMPgARM=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id A7C2DE0F13;
        Fri, 13 Jan 2023 20:14:21 +0300 (MSK)
Received: from localhost (10.8.30.26) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Jan 2023 20:14:21 +0300
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
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v9 04/27] dmaengine: dw-edma: Fix missing src/dst address of the interleaved xfers
Date:   Fri, 13 Jan 2023 20:13:46 +0300
Message-ID: <20230113171409.30470-5-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
References: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.26]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The interleaved DMA transfers support was added in the commit 85e7518f42c8
("dmaengine: dw-edma: Add device_prep_interleave_dma() support"). It
seems like the support was broken from the very beginning. Depending on
the selected channel either source or destination address are left
uninitialized which was obviously wrong. I don't really know how come the
original modification was working for the commit author. Anyway let's fix
it by initializing the destination address of the eDMA burst descriptors
for the DEV_TO_MEM interleaved operations and by initializing the source
address of the eDMA burst descriptors for the MEM_TO_DEV interleaved
operations.

Fixes: 85e7518f42c8 ("dmaengine: dw-edma: Add device_prep_interleave_dma() support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index a8c1bd9c7ae9..778d91d9fc1b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -455,6 +455,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 				 * and destination addresses are increased
 				 * by the same portion (data length)
 				 */
+			} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
+				burst->dar = dst_addr;
 			}
 		} else {
 			burst->dar = dst_addr;
@@ -470,6 +472,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 				 * and destination addresses are increased
 				 * by the same portion (data length)
 				 */
+			}  else if (xfer->type == EDMA_XFER_INTERLEAVED) {
+				burst->sar = src_addr;
 			}
 		}
 
-- 
2.39.0


