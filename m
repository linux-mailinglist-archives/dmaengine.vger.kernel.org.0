Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E59443FF31
	for <lists+dmaengine@lfdr.de>; Fri, 29 Oct 2021 17:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhJ2PPa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Oct 2021 11:15:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50362 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhJ2PP3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Oct 2021 11:15:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19TFCxBp108933;
        Fri, 29 Oct 2021 10:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635520379;
        bh=rdDdFvbaE0XRU6+3sBUbqqyRu7renUsUDF4c3pdtq2w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UCbsCTP6dfOinSiyvWQ30QImYFPkZSa80iIA1b97XM8qq/zrRLKLbcQke6vpHgsXk
         8m6clq5NPQbG/lKPMtk4zxfleziBuZ6sdyjjz3+2FeJyNbMvHGUhxU4BkcieEKTOAs
         cMQDN7XmZw3ThkKLk2uenQLH/JJozeo7Dk+7t9X8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19TFCxKV055262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Oct 2021 10:12:59 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 29
 Oct 2021 10:12:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 29 Oct 2021 10:12:59 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19TFCpTa114593;
        Fri, 29 Oct 2021 10:12:57 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 2/2] dmaengine: ti: k3-udma: Set rchan/tchan to NULL if a channel request fail
Date:   Fri, 29 Oct 2021 20:42:51 +0530
Message-ID: <20211029151251.26421-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029151251.26421-1-kishon@ti.com>
References: <20211029151251.26421-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

udma_get_*() checks if rchan/tchan/rflow is already allocated by checking
if it has a NON NULL value. For the error cases, rchan/tchan/rflow will
have error value and udma_get_*() considers this as already allocated
(PASS) since the error values are NON NULL. This results in NULL pointer
dereference error while de-referencing rchan/tchan/rflow.

Reset the value of rchan/tchan/rflow to NULL if a channel request fails.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/dma/ti/k3-udma.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 14ae28830871..041d8e32d630 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1380,6 +1380,7 @@ static int bcdma_get_bchan(struct udma_chan *uc)
 static int udma_get_tchan(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
+	int ret;
 
 	if (uc->tchan) {
 		dev_dbg(ud->dev, "chan%d: already have tchan%d allocated\n",
@@ -1394,8 +1395,11 @@ static int udma_get_tchan(struct udma_chan *uc)
 	 */
 	uc->tchan = __udma_reserve_tchan(ud, uc->config.channel_tpl,
 					 uc->config.mapped_channel_id);
-	if (IS_ERR(uc->tchan))
-		return PTR_ERR(uc->tchan);
+	if (IS_ERR(uc->tchan)) {
+		ret = PTR_ERR(uc->tchan);
+		uc->tchan = NULL;
+		return ret;
+	}
 
 	if (ud->tflow_cnt) {
 		int tflow_id;
@@ -1425,6 +1429,7 @@ static int udma_get_tchan(struct udma_chan *uc)
 static int udma_get_rchan(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
+	int ret;
 
 	if (uc->rchan) {
 		dev_dbg(ud->dev, "chan%d: already have rchan%d allocated\n",
@@ -1439,8 +1444,13 @@ static int udma_get_rchan(struct udma_chan *uc)
 	 */
 	uc->rchan = __udma_reserve_rchan(ud, uc->config.channel_tpl,
 					 uc->config.mapped_channel_id);
+	if (IS_ERR(uc->rchan)) {
+		ret = PTR_ERR(uc->rchan);
+		uc->rchan = NULL;
+		return ret;
+	}
 
-	return PTR_ERR_OR_ZERO(uc->rchan);
+	return 0;
 }
 
 static int udma_get_chan_pair(struct udma_chan *uc)
@@ -1494,6 +1504,7 @@ static int udma_get_chan_pair(struct udma_chan *uc)
 static int udma_get_rflow(struct udma_chan *uc, int flow_id)
 {
 	struct udma_dev *ud = uc->ud;
+	int ret;
 
 	if (!uc->rchan) {
 		dev_err(ud->dev, "chan%d: does not have rchan??\n", uc->id);
@@ -1507,8 +1518,13 @@ static int udma_get_rflow(struct udma_chan *uc, int flow_id)
 	}
 
 	uc->rflow = __udma_get_rflow(ud, flow_id);
+	if (IS_ERR(uc->rflow)) {
+		ret = PTR_ERR(uc->rflow);
+		uc->rflow = NULL;
+		return ret;
+	}
 
-	return PTR_ERR_OR_ZERO(uc->rflow);
+	return 0;
 }
 
 static void bcdma_put_bchan(struct udma_chan *uc)
-- 
2.17.1

