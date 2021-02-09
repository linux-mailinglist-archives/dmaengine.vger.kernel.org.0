Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051E4314EA4
	for <lists+dmaengine@lfdr.de>; Tue,  9 Feb 2021 13:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhBIMF7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Feb 2021 07:05:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35016 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhBIMEd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Feb 2021 07:04:33 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 119C2jbm110314;
        Tue, 9 Feb 2021 06:02:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612872165;
        bh=CcqJPRpOCkiN0eB5gI+aMq6cKCTA5yx6UGev6u0FgxA=;
        h=From:To:CC:Subject:Date;
        b=p0HPfuCkv2B0SH8TFIyZFL129D1cgS4MOd6Ln+vvkb6ZssXFeWHZveDH93JAr6zyH
         IMIffaU/BWSjcrs1zkdUtbhbEWQEykyHYIVS63LXdyi7FHOWwSOh9Rf0nAeFx/W4kH
         2Y89CUbXZ42XQgaBL8tQ/waSqjzdaaFP7SZkjsYM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 119C2j3X002858
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 06:02:45 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Feb
 2021 06:02:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Feb 2021 06:02:45 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 119C2dpm110405;
        Tue, 9 Feb 2021 06:02:41 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dmaengine: ti: k3-udma: Fix NULL pointer dereference error
Date:   Tue, 9 Feb 2021 17:32:38 +0530
Message-ID: <20210209120238.9476-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

bcdma_get_*() and udma_get_*() checks if bchan/rchan/tchan/rflow is
already allocated by checking if it has a NON NULL value. For the
error cases, bchan/rchan/tchan/rflow will have error value
and bcdma_get_*() and udma_get_*() considers this as already allocated
(PASS) since the error values are NON NULL. This results in
NULL pointer dereference error while de-referencing
bchan/rchan/tchan/rflow.

Reset the value of bchan/rchan/tchan/rflow to NULL if the allocation
actually fails.

Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/dma/ti/k3-udma.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 298460438bb4..aa4ef583ff83 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1330,6 +1330,7 @@ static int bcdma_get_bchan(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
 	enum udma_tp_level tpl;
+	int ret;
 
 	if (uc->bchan) {
 		dev_dbg(ud->dev, "chan%d: already have bchan%d allocated\n",
@@ -1347,8 +1348,11 @@ static int bcdma_get_bchan(struct udma_chan *uc)
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
 
@@ -1358,6 +1362,7 @@ static int bcdma_get_bchan(struct udma_chan *uc)
 static int udma_get_tchan(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
+	int ret;
 
 	if (uc->tchan) {
 		dev_dbg(ud->dev, "chan%d: already have tchan%d allocated\n",
@@ -1372,8 +1377,11 @@ static int udma_get_tchan(struct udma_chan *uc)
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
@@ -1403,6 +1411,7 @@ static int udma_get_tchan(struct udma_chan *uc)
 static int udma_get_rchan(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
+	int ret;
 
 	if (uc->rchan) {
 		dev_dbg(ud->dev, "chan%d: already have rchan%d allocated\n",
@@ -1417,8 +1426,13 @@ static int udma_get_rchan(struct udma_chan *uc)
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
@@ -1472,6 +1486,7 @@ static int udma_get_chan_pair(struct udma_chan *uc)
 static int udma_get_rflow(struct udma_chan *uc, int flow_id)
 {
 	struct udma_dev *ud = uc->ud;
+	int ret;
 
 	if (!uc->rchan) {
 		dev_err(ud->dev, "chan%d: does not have rchan??\n", uc->id);
@@ -1485,6 +1500,11 @@ static int udma_get_rflow(struct udma_chan *uc, int flow_id)
 	}
 
 	uc->rflow = __udma_get_rflow(ud, flow_id);
+	if (IS_ERR(uc->rflow)) {
+		ret = PTR_ERR(uc->rflow);
+		uc->rflow = NULL;
+		return ret;
+	}
 
 	return PTR_ERR_OR_ZERO(uc->rflow);
 }
-- 
2.17.1

