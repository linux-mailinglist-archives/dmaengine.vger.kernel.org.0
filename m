Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACDE63A5CE
	for <lists+dmaengine@lfdr.de>; Mon, 28 Nov 2022 11:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiK1KNq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Nov 2022 05:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiK1KNq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Nov 2022 05:13:46 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8DC140C0;
        Mon, 28 Nov 2022 02:13:44 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ASADaZr000685;
        Mon, 28 Nov 2022 04:13:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669630416;
        bh=MH0nfhk/rrJvkX8RNPO9lJ+kIZfPS2vx/bwmVBJu7ZM=;
        h=From:To:CC:Subject:Date;
        b=H1r9g6CMcRyyOo0+2zAdhMCTvcIygIBOD7iFi+8gZInKO5y78ygv22kRozrhyysY/
         XMt4Tfxtt+NJ2q4t5kHOAdTdMMOI6AHTvgFrON2bhnLAZcFkVHQ6jgmVSL/kv1x/x4
         aAei4TDZ4ttyOyOARpH/D3Fq2JTN2Hv5Umm2czzI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ASADa5P106819
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Nov 2022 04:13:36 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 28
 Nov 2022 04:13:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 28 Nov 2022 04:13:35 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ASADY5N013234;
        Mon, 28 Nov 2022 04:13:35 -0600
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <vkoul@kernel.org>, <peter.ujfalusi@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma: drop loglevel for non-fatal probe deferral log
Date:   Mon, 28 Nov 2022 15:43:34 +0530
Message-ID: <20221128101334.512816-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
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

Change the log level from dev_err() to dev_dbg() for non-fatal probe
deferral log for getting MSI domain.
This makes the kernel log clean and we do not get recurring logs
stating: "Failed to get MSI domain".

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/dma/ti/k3-udma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ce8b80bb34d7..e540166cf4c7 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5344,7 +5344,7 @@ static int udma_probe(struct platform_device *pdev)
 	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_TI_SCI_INTA_MSI);
 	if (!dev->msi.domain) {
-		dev_err(dev, "Failed to get MSI domain\n");
+		dev_dbg(dev, "Failed to get MSI domain\n");
 		return -EPROBE_DEFER;
 	}
 
-- 
2.25.1

