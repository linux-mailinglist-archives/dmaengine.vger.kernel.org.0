Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE234B6231
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 05:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiBOElv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Feb 2022 23:41:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiBOElu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Feb 2022 23:41:50 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157610D7;
        Mon, 14 Feb 2022 20:41:39 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21F4fOjr014078;
        Mon, 14 Feb 2022 22:41:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644900084;
        bh=cscbZ7Of7ik0JUdp5AueLUkwQVQnWzMfZa+oyDa8h8A=;
        h=From:To:CC:Subject:Date;
        b=fn9+ldedesTOkifeGM/4B8fVG8Q7JrKyjl/I+Mb9yA9Ilq1ow5dYKFdC7nyjA+V8b
         SQIoT0wVy4FIo7E5w9WKD5gvIcC1/nOiTTFF8VBJWNJAuQ/wTW7TAN/bCLviWnmTqN
         7NpMdfjelY1ExBzdtHcF1YtHEny1ncZvMBuuuNpQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21F4fOvx085770
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Feb 2022 22:41:24 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 14
 Feb 2022 22:41:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 14 Feb 2022 22:41:24 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21F4fLtI130239;
        Mon, 14 Feb 2022 22:41:22 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] dmaengine: ti: k3-udma: Avoid false error msg on chan teardown
Date:   Tue, 15 Feb 2022 10:11:12 +0530
Message-ID: <20220215044112.161634-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In cyclic mode, there is no additional descriptor pushed to collect
outstanding data on channel teardown. Therefore no need to wait for this
descriptor to come back.

Without this terminating aplay cmd outputs false error msg like:
[  116.402800] ti-bcdma 485c0100.dma-controller: chan1 teardown timeout!

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/dma/ti/k3-udma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 9abb08d353ca0..c9a1b2f312603 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3924,7 +3924,7 @@ static void udma_synchronize(struct dma_chan *chan)
 
 	vchan_synchronize(&uc->vc);
 
-	if (uc->state == UDMA_CHAN_IS_TERMINATING) {
+	if (uc->state == UDMA_CHAN_IS_TERMINATING && !uc->cyclic) {
 		timeout = wait_for_completion_timeout(&uc->teardown_completed,
 						      timeout);
 		if (!timeout) {
-- 
2.35.1

