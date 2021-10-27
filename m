Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C68843C261
	for <lists+dmaengine@lfdr.de>; Wed, 27 Oct 2021 07:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbhJ0Fzh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Oct 2021 01:55:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45758 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbhJ0Fzg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Oct 2021 01:55:36 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19R5rAEU104879;
        Wed, 27 Oct 2021 00:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635313990;
        bh=G1G/nxbLKPZnpWOP2ZsyQlrDr5BUxyCaW1OxAXd1tp0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yjGCEJZVPVOysgoVcy8aKuWnG6ccwFVHlP1vsgfW/y8wQUwN1YknuBQMAXVYaRu2O
         cja2MhnLi7XemHWsGuxeIjEUmOWuWAXadLeChKI+Qof/wJN+ITX5FLQmBh2TNg35UD
         LyFV4d65/A+7HFKMqOqioP0MSz5oqLAN+l9d3dn8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19R5rAXG126177
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Oct 2021 00:53:10 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Oct 2021 00:53:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Oct 2021 00:53:10 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19R5qvNQ100051;
        Wed, 27 Oct 2021 00:53:08 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 1/2] dmaengine: ti: k3-udma: Fix NULL pointer dereference error for BCDMA
Date:   Wed, 27 Oct 2021 11:22:53 +0530
Message-ID: <20211027055254.10912-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027055254.10912-1-kishon@ti.com>
References: <20211027055254.10912-1-kishon@ti.com>
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

