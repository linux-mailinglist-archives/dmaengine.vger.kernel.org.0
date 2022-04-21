Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6F509850
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385384AbiDUG5I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 02:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385459AbiDUG5C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 02:57:02 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C49193E6;
        Wed, 20 Apr 2022 23:53:28 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23L6rPRe109706;
        Thu, 21 Apr 2022 01:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650524005;
        bh=So7jhvc/pnXSX8KuZD8w7ZNdHyBbCjCwlq8HpEYSAbQ=;
        h=From:To:CC:Subject:Date;
        b=nACfugG9oD3ibKfwrSJpURvGtoif3fj3F1SunWo3v+2HAMsRiQPjQr7XIXrOlJE9Y
         4sJF+jwyyH23o/aMsEMalU/V+bxOf/0KSFly8Ol6fTM7l0jlZ8lyNzWzc55kdYoxeY
         Vx0G+05rqm0hFvh5Bsmcd7nX/9K5iVYUoh1QFg98=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23L6rPNR109641
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 01:53:25 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 01:53:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 01:53:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23L6rO1X101513;
        Thu, 21 Apr 2022 01:53:24 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <dmaengine@vger.kernel.org>
CC:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH] dmaengine: ti: k3-psil-am62: Update PSIL thread for saul.
Date:   Thu, 21 Apr 2022 12:23:23 +0530
Message-ID: <20220421065323.16378-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Correct the RX PSIL thread for sa3ul.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---

The new updated PSIL threads have been tested on local am62x board.
Log is available here:
<https://gist.github.com/Jayesh2000/b0316190de3d9dbb8e98337106ebe24a>

 drivers/dma/ti/k3-psil-am62.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am62.c
index d431e2033237..2b6fd6e37c61 100644
--- a/drivers/dma/ti/k3-psil-am62.c
+++ b/drivers/dma/ti/k3-psil-am62.c
@@ -70,10 +70,10 @@
 /* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
 static struct psil_ep am62_src_ep_map[] = {
 	/* SAUL */
-	PSIL_SAUL(0x7500, 20, 35, 8, 35, 0),
-	PSIL_SAUL(0x7501, 21, 35, 8, 36, 0),
-	PSIL_SAUL(0x7502, 22, 43, 8, 43, 0),
-	PSIL_SAUL(0x7503, 23, 43, 8, 44, 0),
+	PSIL_SAUL(0x7504, 20, 35, 8, 35, 0),
+	PSIL_SAUL(0x7505, 21, 35, 8, 36, 0),
+	PSIL_SAUL(0x7506, 22, 43, 8, 43, 0),
+	PSIL_SAUL(0x7507, 23, 43, 8, 44, 0),
 	/* PDMA_MAIN0 - SPI0-3 */
 	PSIL_PDMA_XY_PKT(0x4302),
 	PSIL_PDMA_XY_PKT(0x4303),
-- 
2.17.1

