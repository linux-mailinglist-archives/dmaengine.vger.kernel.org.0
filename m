Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B0A43C27D
	for <lists+dmaengine@lfdr.de>; Wed, 27 Oct 2021 08:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhJ0GDQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Oct 2021 02:03:16 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53002 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbhJ0GDP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Oct 2021 02:03:15 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2021 02:03:15 EDT
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19R5rDkE114991;
        Wed, 27 Oct 2021 00:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635313993;
        bh=jjoWNHqmoNbQOkWKgtA4LQGH4kaQ4d1y2qTsNbcQDJI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hhvUe0ByRxXR+JneiZF+yWn5GVqVcruQbhjJzP4blzCmOIHDBvNtUyjhKbc0s4LxZ
         pnFJVlGo94GY7wAvSeeaG2nvkkHj0nXD/1vC8uWq3DW1aAdDs35DaNeWanRlQjTOK/
         aTNPQDSv/mVhQuU5tmYe/+mCArmjQamnH2jfiI8M=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19R5rDhI060964
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Oct 2021 00:53:13 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Oct 2021 00:53:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Oct 2021 00:53:13 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19R5qvNR100051;
        Wed, 27 Oct 2021 00:53:11 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/2] dmaengine: ti: k3-udma: Fix NULL pointer dereference error for PKTDMA
Date:   Wed, 27 Oct 2021 11:22:54 +0530
Message-ID: <20211027055254.10912-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027055254.10912-1-kishon@ti.com>
References: <20211027055254.10912-1-kishon@ti.com>
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

Reset the value of rchan/tchan/rflow to NULL if the allocation actually
fails.

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

