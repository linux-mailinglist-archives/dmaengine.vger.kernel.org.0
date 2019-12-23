Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225E21294AD
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 12:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLWLFt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 06:05:49 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54126 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfLWLFt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Dec 2019 06:05:49 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNB5ZFA085741;
        Mon, 23 Dec 2019 05:05:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577099135;
        bh=ng3cV7nKixZ3AZqN/OwSxz60VqHNtc/YBatih0fgyMQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XZUoq1YXi/erDvwYIqGL6qdtHd+m9fNZb8p8b+bBv6xaV7VugHLqJ+qWU449yTDbi
         MqBjkP9SYDQDQUsourY93039b/8Y1S4rWLlpepHrcGHKNhQyd+APlzAaq1bezcDlBU
         25GofEN9F0dx5q71ILSUFDe54bLK1vZ9lIwOgB2c=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBNB5Z8W107267
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 05:05:35 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 05:05:35 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 05:05:35 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNB4eMK025693;
        Mon, 23 Dec 2019 05:05:31 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <frowand.list@gmail.com>
Subject: [PATCH v8 13/18] dmaengine: ti: k3-udma: Wait for peer teardown completion if supported
Date:   Mon, 23 Dec 2019 13:04:53 +0200
Message-ID: <20191223110458.30766-14-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191223110458.30766-1-peter.ujfalusi@ti.com>
References: <20191223110458.30766-1-peter.ujfalusi@ti.com>
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
Tested-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/dma/ti/k3-udma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 9974e72cdc50..c97c5f6f1e29 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -84,6 +84,7 @@ struct udma_rchan {
 
 #define UDMA_FLAG_PDMA_ACC32		BIT(0)
 #define UDMA_FLAG_PDMA_BURST		BIT(1)
+#define UDMA_FLAG_TDTYPE		BIT(2)
 
 struct udma_match_data {
 	u32 psil_base;
@@ -1587,6 +1588,13 @@ static int udma_tisci_tx_channel_config(struct udma_chan *uc)
 	req_tx.tx_supr_tdpkt = uc->config.notdpkt;
 	req_tx.tx_fetch_size = fetch_size >> 2;
 	req_tx.txcq_qnum = tc_ring;
+	if (uc->config.ep_type == PSIL_EP_PDMA_XY &&
+	    ud->match_data->flags & UDMA_FLAG_TDTYPE) {
+		/* wait for peer to complete the teardown for PDMAs */
+		req_tx.valid_params |=
+				TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_TDTYPE_VALID;
+		req_tx.tx_tdtype = 1;
+	}
 
 	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
 	if (ret)
@@ -3039,7 +3047,7 @@ static struct udma_match_data am654_mcu_data = {
 static struct udma_match_data j721e_main_data = {
 	.psil_base = 0x1000,
 	.enable_memcpy_support = true,
-	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST,
+	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
 	.statictr_z_mask = GENMASK(23, 0),
 	.rchan_oes_offset = 0x400,
 	.tpl_levels = 3,
@@ -3053,7 +3061,7 @@ static struct udma_match_data j721e_main_data = {
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

