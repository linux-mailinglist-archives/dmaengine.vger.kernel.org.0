Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6945C519217
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 01:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiECXFh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 19:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244131AbiECXEL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 19:04:11 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D083DF75
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 16:00:35 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 70B4716DA;
        Wed,  4 May 2022 01:51:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 70B4716DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651618311;
        bh=4e9cmuHuBiDIdato7BKqLnVJnuF18fszm+JCzcVUJxA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=MyoRhtLEKLiQcThP0ksI8GV23pqf74RrlitQkdhwDGtLCyxpz7SWdAcfMKeVnL15I
         JN0U0zcniuhtdAKyCYQCl6GntH9JhprBHg6vRMXw4sgHSkQ0WgWt0SJDSSlmPjS62w
         Wxno8Z0JLqEhGkrRWw55S0L/Xp/2KCiIV2h+ONIg=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 01:51:17 +0300
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
Subject: [PATCH v2 05/26] dmaengine: dw-edma: Fix missing src/dst address of the interleaved xfers
Date:   Wed, 4 May 2022 01:50:43 +0300
Message-ID: <20220503225104.12108-6-Sergey.Semin@baikalelectronics.ru>
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
---
 drivers/dma/dw-edma/dw-edma-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 04efcb16d13d..f0ef87d75ea9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -456,6 +456,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 				 * and destination addresses are increased
 				 * by the same portion (data length)
 				 */
+			} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
+				burst->dar = dst_addr;
 			}
 		} else {
 			burst->dar = dst_addr;
@@ -471,6 +473,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 				 * and destination addresses are increased
 				 * by the same portion (data length)
 				 */
+			}  else if (xfer->type == EDMA_XFER_INTERLEAVED) {
+				burst->sar = src_addr;
 			}
 		}
 
-- 
2.35.1

