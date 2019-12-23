Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAC7D129499
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 12:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfLWLFR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 06:05:17 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54064 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfLWLFQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Dec 2019 06:05:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNB58JQ085642;
        Mon, 23 Dec 2019 05:05:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577099108;
        bh=yfoeRD47afhb+LjeVfQOdleb+v6AX3JXFvJ9Nn4f53s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aeG/KIw1uwJy2AKeOrDQ6+4KERloMCKDQCtpeYGM9DihnfDRYyAS58Rc2KxQm+9XK
         wU6Ceq53+yx/+HWx6X1PtmX30AZIvxSurpFH3tNy4yoli7Z9uD/3JFs2GnEPcWUsQ+
         WxOpbu6x4intBld+hnXEvZkvFBsS7TfFBWVfYf/c=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNB58Ku037203;
        Mon, 23 Dec 2019 05:05:08 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 05:05:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 05:05:08 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNB4eMD025693;
        Mon, 23 Dec 2019 05:05:04 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <frowand.list@gmail.com>
Subject: [PATCH v8 06/18] dmaengine: Add helper function to convert direction value to text
Date:   Mon, 23 Dec 2019 13:04:46 +0200
Message-ID: <20191223110458.30766-7-peter.ujfalusi@ti.com>
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

dmaengine_get_direction_text() can be useful when the direction is printed
out. The text is easier to comprehend than the number.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/dmaengine.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 7f9a7150a632..9852ba7399db 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1537,4 +1537,23 @@ static inline struct dma_chan
 
 	return __dma_request_channel(mask, fn, fn_param, NULL);
 }
+
+static inline char *
+dmaengine_get_direction_text(enum dma_transfer_direction dir)
+{
+	switch (dir) {
+	case DMA_DEV_TO_MEM:
+		return "DEV_TO_MEM";
+	case DMA_MEM_TO_DEV:
+		return "MEM_TO_DEV";
+	case DMA_MEM_TO_MEM:
+		return "MEM_TO_MEM";
+	case DMA_DEV_TO_DEV:
+		return "DEV_TO_DEV";
+	default:
+		break;
+	}
+
+	return "invalid";
+}
 #endif /* DMAENGINE_H */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

