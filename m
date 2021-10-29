Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6780543FF2F
	for <lists+dmaengine@lfdr.de>; Fri, 29 Oct 2021 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhJ2PP2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Oct 2021 11:15:28 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39554 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhJ2PP2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Oct 2021 11:15:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19TFCvsi016093;
        Fri, 29 Oct 2021 10:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635520377;
        bh=R/nNWXbjMGq6QPxOTr3KsofR21GxSB50TrQUtZsacsY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sN48eKPo5QQvBAedi/fxkAXKpMs1U7qL+hlIiZE7Nblv4EA4+2n1ZhSUHC8wrlXt5
         yV41vBkeuJlTOq3uK0S5kcPFUHxXZSidCNTuAaMG/hGTINVAq2UT7X1dHC/4VfvRP5
         cz/ZabSyXgF7u3SMDpqxPf4h5Dlx1fvoDgGoOfBE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19TFCvJU015279
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Oct 2021 10:12:57 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 29
 Oct 2021 10:12:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 29 Oct 2021 10:12:57 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19TFCpTZ114593;
        Fri, 29 Oct 2021 10:12:54 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 1/2] dmaengine: ti: k3-udma: Set bchan to NULL if a channel request fail
Date:   Fri, 29 Oct 2021 20:42:50 +0530
Message-ID: <20211029151251.26421-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029151251.26421-1-kishon@ti.com>
References: <20211029151251.26421-1-kishon@ti.com>
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

Reset the value of bchan to NULL if a channel request fails.

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

