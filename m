Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC7110C781
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2019 12:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfK1LA5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Nov 2019 06:00:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54030 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfK1LAu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Nov 2019 06:00:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xASB0hNE117629;
        Thu, 28 Nov 2019 05:00:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574938843;
        bh=CKcG9c1OO85WzN6gvf89EFnzSlyAjbPZ3H9PIl/A58I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Nhm/SWhQvxYzNtp9zNt+bLuViQiqC2zk0b2HOIZQEB/JlLfDrH70PxbouaysEU1QQ
         Oz/DO0EB45Cy6Xl79sQ3rfTO+oUhqrMtp2J87jtpHotBE4DzR2pK+r6KM83PnOiwqk
         RaKoNvDHcz/eHO6GN7O2TnnBcoy4KODaTvLXH0Sw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASB0ha6007643;
        Thu, 28 Nov 2019 05:00:43 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 05:00:43 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 05:00:43 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASAxgJV073287;
        Thu, 28 Nov 2019 05:00:40 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v6 17/17] dmaengine: ti: k3-udma: Wait for peer teardown completion if supported
Date:   Thu, 28 Nov 2019 12:59:45 +0200
Message-ID: <20191128105945.13071-18-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128105945.13071-1-peter.ujfalusi@ti.com>
References: <20191128105945.13071-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Set the TDTYPE if it is supported on the platform (j721e) which will cause
UDMAP to wait for the remote peer to finish the teardown before returning
the teardown completed message.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c1450b0a8224..5073e44caaa0 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -85,6 +85,7 @@ struct udma_rchan {
 
 #define UDMA_FLAG_PDMA_ACC32		BIT(0)
 #define UDMA_FLAG_PDMA_BURST		BIT(1)
+#define UDMA_FLAG_TDTYPE		BIT(2)
 
 struct udma_match_data {
 	u32 psil_base;
@@ -1545,7 +1546,8 @@ static int udma_tisci_tx_channel_config(struct udma_chan *uc)
 	req_tx.tx_supr_tdpkt = uc->notdpkt;
 	req_tx.tx_fetch_size = fetch_size >> 2;
 	req_tx.txcq_qnum = tc_ring;
-	if (uc->ep_type == PSIL_EP_PDMA_XY) {
+	if (uc->ep_type == PSIL_EP_PDMA_XY &&
+	    ud->match_data->flags & UDMA_FLAG_TDTYPE) {
 		/* wait for peer to complete the teardown for PDMAs */
 		req_tx.valid_params |=
 				TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_TDTYPE_VALID;
@@ -2979,7 +2981,7 @@ static struct udma_match_data am654_mcu_data = {
 static struct udma_match_data j721e_main_data = {
 	.psil_base = 0x1000,
 	.enable_memcpy_support = true,
-	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST,
+	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
 	.statictr_z_mask = GENMASK(23, 0),
 	.rchan_oes_offset = 0x400,
 	.tpl_levels = 3,
@@ -2993,7 +2995,7 @@ static struct udma_match_data j721e_main_data = {
 static struct udma_match_data j721e_mcu_data = {
 	.psil_base = 0x6000,
 	.enable_memcpy_support = false, /* MEM_TO_MEM is slow via MCU UDMA */
-	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST,
+	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
 	.statictr_z_mask = GENMASK(23, 0),
 	.rchan_oes_offset = 0x400,
 	.tpl_levels = 2,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

