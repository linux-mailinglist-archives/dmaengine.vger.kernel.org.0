Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02BC782740
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 12:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjHUKlA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 06:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjHUKk7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 06:40:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D17D9;
        Mon, 21 Aug 2023 03:40:52 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37LAeZQA059233;
        Mon, 21 Aug 2023 05:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692614435;
        bh=Ozlne59YLraqabgL+WJG3qc//rmNi/GH2L2V0xkKtsU=;
        h=From:To:CC:Subject:Date;
        b=Q8liWzOPPB4SI2rn0o1wF//KnAuDWQe250j6M9/it7mcvV451K/Tkja0e7NCZzrcx
         9h++jfWf0uzbqjTvidAri68gwAFj+J+8f+rm+PMa47EeqHpKhrOeOzV9Kjovnw7ZoB
         4LlP4oqu7n5gF0FVgXA6ZLcdbTYQDRQg5yJh2ypA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37LAeZVM001603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Aug 2023 05:40:35 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 21
 Aug 2023 05:40:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 21 Aug 2023 05:40:35 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37LAeVd1006179;
        Mon, 21 Aug 2023 05:40:32 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <j-luthra@ti.com>,
        <j-choudhary@ti.com>, <francesco@dolcini.it>
Subject: [PATCH] dmaengine: ti: k3-udma: Fix teardown timeout for cyclic mode
Date:   Mon, 21 Aug 2023 16:10:03 +0530
Message-ID: <20230821104003.3001021-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In cyclic mode, last descriptor needs to have EOP flag set so that
teardown flushes data towards PDMA in case of MEM_TO_DMA.  Else,
operation will not complete successfully leading to spurious timeout on
channel terminate.

Without this terminating aplay cmd outputs false error msg like:
[116.402800] ti-bcdma 485c0100.dma-controller: chan1 teardown timeout!

This doesn't seem to be problem with UDMA-P on J7xx devices (although is
a requirement as per spec) but shows up easily on BCDMA + McASP. Fix
this by setting the appropriate flag

Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
Suggested-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---

This complete reimplementation based on learning of HW behavior for problems
reported at
https://lore.kernel.org/linux-arm-kernel/20220215044112.161634-1-vigneshr@ti.com/

 drivers/dma/ti/k3-udma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 30fd2f386f36..02aac7be8d28 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3476,6 +3476,10 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
 	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
 	unsigned int i;
 	int num_tr;
+	u32 period_csf = 0;
+
+	if (uc->config.ep_type == PSIL_EP_PDMA_XY && dir == DMA_MEM_TO_DEV)
+		period_csf = CPPI5_TR_CSF_EOP;
 
 	num_tr = udma_get_tr_counters(period_len, __ffs(buf_addr), &tr0_cnt0,
 				      &tr0_cnt1, &tr1_cnt0);
@@ -3525,8 +3529,10 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
 		}
 
 		if (!(flags & DMA_PREP_INTERRUPT))
-			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
-					 CPPI5_TR_CSF_SUPR_EVT);
+			period_csf |= CPPI5_TR_CSF_SUPR_EVT;
+
+		if (period_csf)
+			cppi5_tr_csf_set(&tr_req[tr_idx].flags, period_csf);
 
 		period_addr += period_len;
 	}
-- 
2.41.0

