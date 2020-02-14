Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1A015D47A
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 10:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgBNJOy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 04:14:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57610 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgBNJOv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Feb 2020 04:14:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01E9Emua117368;
        Fri, 14 Feb 2020 03:14:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581671689;
        bh=7WldpK8BcpshZwfcHpxXX7Yepvns9PLGRnzm9vRN7jY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yQMVKWkxK/HcHd/NvVhqrhPDt9Qtu/a3mY8/2sJwNEDancOhVNdySGln1LS0anj3k
         X3vNUp/DWFENnTGB9bQvAxe8jhXx476AEnVYq4TwmpFFhD0Ap215ogtGCPaafrQEjD
         2vU/TYQz/If+1CaChEtSZ+gD4O8JtXxAgY6dvqT4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01E9Emhm108958;
        Fri, 14 Feb 2020 03:14:48 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 14
 Feb 2020 03:14:48 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 14 Feb 2020 03:14:48 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01E9Ea41043021;
        Fri, 14 Feb 2020 03:14:46 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>
Subject: [PATCH v2 5/6] dmaengine: ti: k3-udma: Use the channel direction in pause/resume functions
Date:   Fri, 14 Feb 2020 11:14:40 +0200
Message-ID: <20200214091441.27535-6-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214091441.27535-1-peter.ujfalusi@ti.com>
References: <20200214091441.27535-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It should be possible to pause, resume and check the pause state of a
channel even if we do not have active transfer.

udma_is_chan_paused() can trigger NULL pointer reference in it's current
form when the status is checked while uc->desc is NULL.

Fixes: 25dcb5dd7b7ce ("dmaengine: ti: New driver for K3 UDMA")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 1dba47c662c4..9b4e1e5fa849 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -513,7 +513,7 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
 {
 	u32 val, pause_mask;
 
-	switch (uc->desc->dir) {
+	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
 		val = udma_rchanrt_read(uc->rchan,
 					UDMA_RCHAN_RT_PEER_RT_EN_REG);
@@ -2835,11 +2835,8 @@ static int udma_pause(struct dma_chan *chan)
 {
 	struct udma_chan *uc = to_udma_chan(chan);
 
-	if (!uc->desc)
-		return -EINVAL;
-
 	/* pause the channel */
-	switch (uc->desc->dir) {
+	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
 		udma_rchanrt_update_bits(uc->rchan,
 					 UDMA_RCHAN_RT_PEER_RT_EN_REG,
@@ -2868,11 +2865,8 @@ static int udma_resume(struct dma_chan *chan)
 {
 	struct udma_chan *uc = to_udma_chan(chan);
 
-	if (!uc->desc)
-		return -EINVAL;
-
 	/* resume the channel */
-	switch (uc->desc->dir) {
+	switch (uc->config.dir) {
 	case DMA_DEV_TO_MEM:
 		udma_rchanrt_update_bits(uc->rchan,
 					 UDMA_RCHAN_RT_PEER_RT_EN_REG,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

