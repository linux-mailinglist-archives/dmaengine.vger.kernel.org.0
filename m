Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94245150410
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 11:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgBCKST (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 05:18:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54098 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgBCKSS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 05:18:18 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 013AIFsb118145;
        Mon, 3 Feb 2020 04:18:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580725096;
        bh=QAD8MJEBJU3Ct4VsAMm9RYlxHl5Eot2UW/ytZA5ij2c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fDP89lzjz0/qmrgLHNqhnc66MpWL0QVHIpbxQisA9zIITw6usQo3ujzGn0AS4Enle
         ZVzOexmlYcfu9voWeP3mK6AVp4y33/sAuuxDSoJINvKeRb3XFEfYVdZZvxnMsimP23
         +j/6uCmJ/rcWOlfLdkpQSqxZxU1TNjN6u8cBoE0w=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 013AIF4j012117;
        Mon, 3 Feb 2020 04:18:15 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 3 Feb
 2020 04:18:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 3 Feb 2020 04:18:14 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 013AI7mV040513;
        Mon, 3 Feb 2020 04:18:12 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>
Subject: [PATCH 3/3] dmaengine: Encourage dma_request_slave_channel_compat() users to migrate
Date:   Mon, 3 Feb 2020 12:18:06 +0200
Message-ID: <20200203101806.2441-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203101806.2441-1-peter.ujfalusi@ti.com>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Users of dma_request_slave_channel_compat() can be migrated to
dma_request_chan() by correct dma_slave_map for the platform.

Start nagging users in hope that they will move.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/dmaengine.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 4c522bf6ac25..581f6822a7a5 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1547,6 +1547,10 @@ dma_request_slave_channel(struct device *dev, const char *name)
 	return IS_ERR(ch) ? NULL : ch;
 }
 
+/*
+ * Please use dma_request_chan() directly.
+ * Legacy support should use dma_slave_map + dma_request_chan()
+ */
 static inline struct dma_chan
 *dma_request_slave_channel_compat(const dma_cap_mask_t mask,
 				  dma_filter_fn fn, void *fn_param,
@@ -1554,13 +1558,16 @@ static inline struct dma_chan
 {
 	struct dma_chan *chan;
 
-	chan = dma_request_slave_channel(dev, name);
-	if (chan)
+	chan = dma_request_chan(dev, name);
+	if (!IS_ERR(chan))
 		return chan;
 
 	if (!fn || !fn_param)
 		return NULL;
 
+	dev_info(dev, "Please add dma_slave_map entry for %s:%s and migrate to"
+		 " dma_request_chan()", dev_name(dev), name);
+
 	return __dma_request_channel(&mask, fn, fn_param, NULL);
 }
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

