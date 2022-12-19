Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09B1650DCC
	for <lists+dmaengine@lfdr.de>; Mon, 19 Dec 2022 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiLSOri (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Dec 2022 09:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiLSOrR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Dec 2022 09:47:17 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8FF99587;
        Mon, 19 Dec 2022 06:47:04 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 272B2E0EB2;
        Mon, 19 Dec 2022 17:47:04 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=TCqeOz2FL8uEcpHHjdwrQW967mI61/OYbB3+Ru9K7WQ=; b=poV2GDjgK3yv
        QcqwnkXgDVoB+Skf1O93yfeYByhETT2XhUZHWn1Ckhncifu6t/G0Mr76+YLu4UgE
        xtBZZuo55YeQhgqdgqTR0CtFk3whhDej2Co6nz0OAh3gcV0G3SsBKhr4k0ljMV9S
        OFqVabOoibkKvDvJnGUVLVGJLtxaBt0=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 1C703E0E70;
        Mon, 19 Dec 2022 17:47:04 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Mon, 19 Dec 2022 17:47:03 +0300
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
Subject: [PATCH v8 04/26] dmaengine: dw-edma: Fix missing src/dst address of the interleaved xfers
Date:   Mon, 19 Dec 2022 17:46:35 +0300
Message-ID: <20221219144658.26620-5-Sergey.Semin@baikalelectronics.ru>
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
2.38.1


