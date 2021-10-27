Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FEC43C26F
	for <lists+dmaengine@lfdr.de>; Wed, 27 Oct 2021 07:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhJ0F7G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Oct 2021 01:59:06 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35466 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhJ0F7F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Oct 2021 01:59:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19R5udar049773;
        Wed, 27 Oct 2021 00:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635314199;
        bh=G1G/nxbLKPZnpWOP2ZsyQlrDr5BUxyCaW1OxAXd1tp0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tLnA5QHXM6iX+ZPe17Ce072U03cysWR0MPUBoe/gMmgflQT4TORWpD4RBy7KprCdL
         cyUgmGzLvlQOir6hIqNVkHq+6iJjxtgidtM01s13CCufzHwo7KUH7pWXRCq+loMQTR
         IBw/ITTSNiYW8fdVjHVYWy/2iQiJgOxIN71+90Hg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19R5udE2105533
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Oct 2021 00:56:39 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Oct 2021 00:56:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Oct 2021 00:56:38 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19R5uRPL126251;
        Wed, 27 Oct 2021 00:56:35 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH v2 1/2] dmaengine: ti: k3-udma: Fix NULL pointer dereference error for BCDMA
Date:   Wed, 27 Oct 2021 11:26:24 +0530
Message-ID: <20211027055625.11150-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027055625.11150-1-kishon@ti.com>
References: <20211027055625.11150-1-kishon@ti.com>
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

