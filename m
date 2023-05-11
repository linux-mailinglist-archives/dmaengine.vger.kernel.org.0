Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1118F6FEA52
	for <lists+dmaengine@lfdr.de>; Thu, 11 May 2023 05:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEKDrW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 May 2023 23:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEKDrU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 10 May 2023 23:47:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4A140EE;
        Wed, 10 May 2023 20:47:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34B3l7tm053310;
        Wed, 10 May 2023 22:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683776827;
        bh=rJCvLxlRPHuv3JGrAvm/2ytti1ttzmc4qJx+Xdx07Mg=;
        h=From:To:CC:Subject:Date;
        b=X+u8AqYp066jOWy4CUhS9dBQeDXr4Iet2wT3QBZjyyhlnd2S9I+A2TOgS60GuSMd/
         tD7EOv3gxCe8OShmcjEaXdjJgvWhAoQF8WBkj0oxhbkFanzvdZ1DqJCBc6bkqv8ffo
         55fE0unyAALg1RJyWqi//ij3jmTdgXR5pVcCHjSE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34B3l7pq054128
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 May 2023 22:47:07 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 May 2023 22:47:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 May 2023 22:47:07 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34B3l4BF113960;
        Wed, 10 May 2023 22:47:05 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] dmaengine: ti: k3-psil-j721s2: Add PSI-L thread map for main CPSW2G
Date:   Thu, 11 May 2023 09:17:04 +0530
Message-ID: <20230511034704.656155-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

Add PSI-L thread map for main CPSW2G.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---

This patch is based on linux-next tagged next-20230511.

RFC patch at:
https://lore.kernel.org/r/20230426083900.102229-1-s-vadapalli@ti.com

Changes since RFC patch:
- Collect Acked-by tag from Peter Ujfalusi.

 drivers/dma/ti/k3-psil-j721s2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/ti/k3-psil-j721s2.c b/drivers/dma/ti/k3-psil-j721s2.c
index a488c2250623..1d5430fc5724 100644
--- a/drivers/dma/ti/k3-psil-j721s2.c
+++ b/drivers/dma/ti/k3-psil-j721s2.c
@@ -99,6 +99,8 @@ static struct psil_ep j721s2_src_ep_map[] = {
 	PSIL_PDMA_XY_PKT(0x461d),
 	PSIL_PDMA_XY_PKT(0x461e),
 	PSIL_PDMA_XY_PKT(0x461f),
+	/* MAIN_CPSW2G */
+	PSIL_ETHERNET(0x4640),
 	/* PDMA_USART_G0 - UART0-1 */
 	PSIL_PDMA_XY_PKT(0x4700),
 	PSIL_PDMA_XY_PKT(0x4701),
@@ -161,6 +163,15 @@ static struct psil_ep j721s2_dst_ep_map[] = {
 	PSIL_ETHERNET(0xf005),
 	PSIL_ETHERNET(0xf006),
 	PSIL_ETHERNET(0xf007),
+	/* MAIN_CPSW2G */
+	PSIL_ETHERNET(0xc640),
+	PSIL_ETHERNET(0xc641),
+	PSIL_ETHERNET(0xc642),
+	PSIL_ETHERNET(0xc643),
+	PSIL_ETHERNET(0xc644),
+	PSIL_ETHERNET(0xc645),
+	PSIL_ETHERNET(0xc646),
+	PSIL_ETHERNET(0xc647),
 	/* SA2UL */
 	PSIL_SA2UL(0xf500, 1),
 	PSIL_SA2UL(0xf501, 1),
-- 
2.25.1

