Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D25546173
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jun 2022 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348733AbiFJJQR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jun 2022 05:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348687AbiFJJPR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jun 2022 05:15:17 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 448B01BD7EA;
        Fri, 10 Jun 2022 02:15:15 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 27B8916A6;
        Fri, 10 Jun 2022 12:16:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 27B8916A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654852560;
        bh=/n9orxSGiMPX6gfwBb0KWay6ug04nKNBLX2i3fdgk/g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=qGGQCK3yd7YmryAVWEXmP+QfPvptv0R0xfgbM9EJ3fWfxmLhNRHy+ypjdBN+oE0Sa
         w4LYMimc+yZzVZVBZMGv3N1XfXV2fEXrMacGXk+CXu+B6lX0eRHKVDfmMVnDoSFuut
         ECIHatLqfXJMHuTZUp/zMwrqjSuXoUoTrBPSzvQo=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 12:15:07 +0300
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
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v3 05/24] dmaengine: dw-edma: Don't permit non-inc interleaved xfers
Date:   Fri, 10 Jun 2022 12:14:40 +0300
Message-ID: <20220610091459.17612-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DW eDMA controller always increments both source and destination
addresses. Permitting DMA interleaved transfers with no src_inc/dst_inc
flags set may lead to unexpected behaviour for the device users. Let's fix
that by terminating the interleaved transfers if at least one of the
dma_interleaved_template.{src_inc,dst_inc} flag is initialized with false
value. Note in addition to that we need to increase the source and
destination addresses accordingly after each iteration.

Fixes: 85e7518f42c8 ("dmaengine: dw-edma: Add device_prep_interleave_dma() support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index f0ef87d75ea9..225eab58acb7 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -386,6 +386,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 			return NULL;
 		if (xfer->xfer.il->numf > 0 && xfer->xfer.il->frame_size > 0)
 			return NULL;
+		if (!xfer->xfer.il->src_inc || !xfer->xfer.il->dst_inc)
+			return NULL;
 	} else {
 		return NULL;
 	}
@@ -485,15 +487,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 			struct dma_interleaved_template *il = xfer->xfer.il;
 			struct data_chunk *dc = &il->sgl[i];
 
-			if (il->src_sgl) {
-				src_addr += burst->sz;
+			src_addr += burst->sz;
+			if (il->src_sgl)
 				src_addr += dmaengine_get_src_icg(il, dc);
-			}
 
-			if (il->dst_sgl) {
-				dst_addr += burst->sz;
+			dst_addr += burst->sz;
+			if (il->dst_sgl)
 				dst_addr += dmaengine_get_dst_icg(il, dc);
-			}
 		}
 	}
 
-- 
2.35.1

