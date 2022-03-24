Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119E34E9C95
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242645AbiC1QqG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242668AbiC1QqC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:46:02 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D9C021800;
        Mon, 28 Mar 2022 09:44:13 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 628F11E4942;
        Thu, 24 Mar 2022 04:48:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 628F11E4942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086523;
        bh=uq3F2gd1xa8DY2sr9sUsFpAH8Z8bBz3m4dAToaXUH6o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=mI9DKh9w99KIIw8tn06S7NW/fYsCyW6YFqluSU7cwLL88FLLTWcklGNw61NkBQHlB
         F5B3CwhdAaHiRBnpa4+FOvXmo+73AK84Goc/f3Jq/fihaLMyuwyIPrCMn2mQPmqjsP
         IZDIHFlCWug3Mw6Y/vu2kB8OUSZ0KIW4wZD7TBec=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:43 +0300
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
Subject: [PATCH 07/25] dmaengine: dw-edma: Don't permit non-inc interleaved xfers
Date:   Thu, 24 Mar 2022 04:48:18 +0300
Message-ID: <20220324014836.19149-8-Sergey.Semin@baikalelectronics.ru>
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

DW eDMA controller always increments both source and destination
addresses. Permitting DMA interleaved transfers with no src_inc/dst_inc
flags set may lead to unexpected behaviour for the device users. Let's fix
that by terminating the interleaved transfers if at least one of the
dma_interleaved_template.{src_inc,dst_inc} flag is initialized with false
value. Note in addition to that we need we need to increase the source and
destination addresses accordingly after each iteration.

Fixes: 85e7518f42c8 ("dmaengine: dw-edma: Add device_prep_interleave_dma() support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/dma/dw-edma/dw-edma-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 2010d7f8191f..f41bde27795c 100644
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

