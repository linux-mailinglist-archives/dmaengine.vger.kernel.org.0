Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E527766D58A
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jan 2023 06:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjAQFTM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Jan 2023 00:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjAQFTF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Jan 2023 00:19:05 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6862927495;
        Mon, 16 Jan 2023 21:19:04 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30H5Iv1Z020132;
        Mon, 16 Jan 2023 23:18:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673932737;
        bh=xxpvyte8xzl5f5vxPL1FLw2ijhBS7X3ez0AbKJFIno4=;
        h=From:To:CC:Subject:Date;
        b=KGri07oPD8mrRlO2r8kJv/K9uwDFf+7E1gDXBE/hDBzvXF338fVW+hbtv+cDpijQR
         t4Ov8fz/6KJRv9hSmQdLVpBy6CvS3VFtyRidZgbmPWIKbCtQJ2kcdbC9Thn4/kz2Xl
         O/grTG/jZjk+CodAI1KNmmnVVtWQMnj/BKGMMaQc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30H5IvkG112351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jan 2023 23:18:57 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 16
 Jan 2023 23:18:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 16 Jan 2023 23:18:56 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30H5IuiY049602;
        Mon, 16 Jan 2023 23:18:56 -0600
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <vkoul@kernel.org>, <peter.ujfalusi@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH v2] dmaengine: ti: k3-udma: remove non-fatal probe deferral log
Date:   Tue, 17 Jan 2023 10:48:55 +0530
Message-ID: <20230117051855.29644-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Drop the non-fatal probe deferral log for getting MSI domain.
This makes the kernel log clean and we do not get recurring logs
stating: "Failed to get MSI domain".

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---

Changelog v1->v2:
- Removed print instead of dropping the loglevel
- Retained 'acked-by' from v1 patch

v1: <https://patchwork.kernel.org/project/linux-dmaengine/patch/20221128101334.512816-1-j-choudhary@ti.com/>

 drivers/dma/ti/k3-udma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index eb76f0e58536..7e23a6fdef95 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5376,7 +5376,6 @@ static int udma_probe(struct platform_device *pdev)
 	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_TI_SCI_INTA_MSI);
 	if (!dev->msi.domain) {
-		dev_err(dev, "Failed to get MSI domain\n");
 		return -EPROBE_DEFER;
 	}
 
-- 
2.25.1

