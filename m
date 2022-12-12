Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2321649D11
	for <lists+dmaengine@lfdr.de>; Mon, 12 Dec 2022 12:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiLLLHt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Dec 2022 06:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiLLLHG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Dec 2022 06:07:06 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D8A11A10;
        Mon, 12 Dec 2022 02:54:35 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BCAsSrg019167;
        Mon, 12 Dec 2022 04:54:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670842468;
        bh=5eBEqont1Hh66nEc8s7Ovin4BNz2G7HwxSF5/nTvwu8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wwPlpXeP2kjAUlQZV7TSNXRiWQio9Xoq74GN0AKspkCWwBjfgnuSeU4Rh0TWF0qmk
         xmRqyd6VJf+zM9hPQ6ggrn1/tqEW3MJLIbsi5YFZAZEcNo5+J7UeYrSBHqiIZYiF2L
         9LbRP1iOpPg6X1hyZ5u8QT/06nIGyIv5pFkMdxQo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BCAsSR5026436
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Dec 2022 04:54:28 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 12
 Dec 2022 04:54:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 12 Dec 2022 04:54:27 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BCAsJVI035634;
        Mon, 12 Dec 2022 04:54:25 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/5] dmaengine: ti: k3-udma: Fix BCDMA for case w/o BCHAN
Date:   Mon, 12 Dec 2022 16:24:13 +0530
Message-ID: <20221212105416.3628442-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212105416.3628442-1-vigneshr@ti.com>
References: <20221212105416.3628442-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Reusing loop iterator fails if BCHAN is not present as iterator is
uninitialized

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/dma/ti/k3-udma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ce8b80bb34d7..aa50d46fa856 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4774,7 +4774,10 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 				irq_res.desc[i].num = rm_res->desc[i].num;
 			}
 		}
+	} else {
+		i = 0;
 	}
+
 	if (ud->tchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 		if (IS_ERR(rm_res)) {
-- 
2.38.1

