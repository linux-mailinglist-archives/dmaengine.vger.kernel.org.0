Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3C6EF057
	for <lists+dmaengine@lfdr.de>; Wed, 26 Apr 2023 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbjDZIjP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Apr 2023 04:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDZIjO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Apr 2023 04:39:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDCC3C1F;
        Wed, 26 Apr 2023 01:39:13 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33Q8d4uM116076;
        Wed, 26 Apr 2023 03:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682498344;
        bh=mbfL/rqfS3oPdl/DM6chwFP3C1ZthtsNfud9f4nprGQ=;
        h=From:To:CC:Subject:Date;
        b=Beqc1wD55xw7sq08Y1ugwSkfnoXN1QCwVQo6TSMud4+mMTenbw1LSOADNBEuyrUpb
         B5X+mt3WPLdRvssw85lsQTDohr98y5el6KHjgRVJjdGpl6sGJ301ZJwQFRjrevtkwf
         qR21UVF5Dk/YLBJLk0yshdrxDmiPnDxTfYSlNpPo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33Q8d4Aq121315
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 03:39:04 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Apr 2023 03:39:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 03:39:04 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33Q8d05b023883;
        Wed, 26 Apr 2023 03:39:01 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <vigneshr@ti.com>, <s-vadapalli@ti.com>
Subject: [RFC PATCH] dmaengine: ti: k3-psil-j721s2: Add PSI-L thread map for main CPSW2G
Date:   Wed, 26 Apr 2023 14:09:00 +0530
Message-ID: <20230426083900.102229-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

Add PSI-L thread map for main CPSW2G.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
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

