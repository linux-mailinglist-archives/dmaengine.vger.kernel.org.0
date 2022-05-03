Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69079519205
	for <lists+dmaengine@lfdr.de>; Wed,  4 May 2022 01:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiECXEy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 19:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243966AbiECXEI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 19:04:08 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE97765FA
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 16:00:31 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8552916DC;
        Wed,  4 May 2022 01:51:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 8552916DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651618312;
        bh=yyJl4C86rRjJF12iu156z23kD5CNtiThc1HugtLxv5M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=hW1V6makBQur5HqxprJhu5mniGdGM/xOA77SIwjKxW9npom9xRTCMKP7ksxwto87r
         CyXXF+4idAPVfEKaKLsoUzOB885ETmnD8+d1ssAv5Db6gkZ6JiRJU0kcVeQDg7t02v
         mJ/+iPefHk1EivVtS/Wp7d5wEBPP9lN/R3Ejg+9E=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 01:51:18 +0300
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
Subject: [PATCH v2 06/26] dmaengine: dw-edma: Don't permit non-inc interleaved xfers
Date:   Wed, 4 May 2022 01:50:44 +0300
Message-ID: <20220503225104.12108-7-Sergey.Semin@baikalelectronics.ru>
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

DW eDMA controller always increments both source and destination
addresses. Permitting DMA interleaved transfers with no src_inc/dst_inc
flags set may lead to unexpected behaviour for the device users. Let's fix
that by terminating the interleaved transfers if at least one of the
dma_interleaved_template.{src_inc,dst_inc} flag is initialized with false
value. Note in addition to that we need to increase the source and
destination addresses accordingly after each iteration.

Fixes: 85e7518f42c8 ("dmaengine: dw-edma: Add device_prep_interleave_dma() support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
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

