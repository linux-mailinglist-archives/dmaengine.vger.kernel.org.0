Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5387A43C25B
	for <lists+dmaengine@lfdr.de>; Wed, 27 Oct 2021 07:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhJ0Fz2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Oct 2021 01:55:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34936 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbhJ0Fz2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Oct 2021 01:55:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19R5r1o9048965;
        Wed, 27 Oct 2021 00:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635313981;
        bh=G1G/nxbLKPZnpWOP2ZsyQlrDr5BUxyCaW1OxAXd1tp0=;
        h=From:To:CC:Subject:Date;
        b=hr7y1xPwovUPqGpyuzRQ7cNuqiZfwI/pBe7SzbjOxH7BEHGUmzRS8am6MGWsLimv+
         fAwdHmSMFU55rQMwXS8+TJ1MQwCQcx12Hqdpk5Wt1k2yGiDEbU64gnAVsyBWKtFHGV
         urYXbAmGJEQ7clWW7XklMg0oEz2l8Estlc/WRXgo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19R5r1fr101478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Oct 2021 00:53:01 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Oct 2021 00:53:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Oct 2021 00:53:01 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19R5qvNN100051;
        Wed, 27 Oct 2021 00:52:58 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/2] dmaengine: ti: k3-udma: Fix NULL pointer dereference error for BCDMA
Date:   Wed, 27 Oct 2021 11:22:50 +0530
Message-ID: <20211027055254.10912-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

bcdma_get_*() checks if bchan is already allocated by checking if it
has a NON NULL value. For the error cases, bchan will have error value
and bcdma_get_*() considers this as already allocated (PASS) since the
error values are NON NULL. This results in NULL pointer dereference
error while de-referencing bchan.

Reset the value of bchan to NULL if the allocation actually fails.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/dma/ti/k3-udma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index a35858610780..14ae28830871 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1348,6 +1348,7 @@ static int bcdma_get_bchan(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
 	enum udma_tp_level tpl;
+	int ret;
 
 	if (uc->bchan) {
 		dev_dbg(ud->dev, "chan%d: already have bchan%d allocated\n",
@@ -1365,8 +1366,11 @@ static int bcdma_get_bchan(struct udma_chan *uc)
 		tpl = ud->bchan_tpl.levels - 1;
 
 	uc->bchan = __udma_reserve_bchan(ud, tpl, -1);
-	if (IS_ERR(uc->bchan))
-		return PTR_ERR(uc->bchan);
+	if (IS_ERR(uc->bchan)) {
+		ret = PTR_ERR(uc->bchan);
+		uc->bchan = NULL;
+		return ret;
+	}
 
 	uc->tchan = uc->bchan;
 
-- 
2.17.1

