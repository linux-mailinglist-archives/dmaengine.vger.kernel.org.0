Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9515040D
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 11:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgBCKSS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 05:18:18 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57928 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgBCKSS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 05:18:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 013AIB5n127276;
        Mon, 3 Feb 2020 04:18:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580725091;
        bh=77PyIHjs3pH2mbwM/5I/uOO043kgBRhE+aAAhTBWXeo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a9l2v3NkXRj7wORqyU6ijhLntqTbFlpV7U/Lng+VpPF3B3o87OEcvkdB29HEe2w3m
         laNqX64ywRbYi5wD3Pqn79jIbRlwYTEU2jCn/p+lew1tPysuNz768LUvknyCqSS2hD
         u5H4CFMqV4+yV5oR7iACdPs+CmsNs6sy4QSnhv24=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 013AIB7K092879
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Feb 2020 04:18:11 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 3 Feb
 2020 04:18:10 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 3 Feb 2020 04:18:10 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 013AI7mT040513;
        Mon, 3 Feb 2020 04:18:09 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>
Subject: [PATCH 1/3] dmaengine: Remove unused define for dma_request_slave_channel_reason()
Date:   Mon, 3 Feb 2020 12:18:04 +0200
Message-ID: <20200203101806.2441-2-peter.ujfalusi@ti.com>
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

No users left in the kernel, it can be removed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/dmaengine.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9f232b7618f1..6702df107d79 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1495,8 +1495,6 @@ static inline int dma_get_slave_caps(struct dma_chan *chan,
 }
 #endif
 
-#define dma_request_slave_channel_reason(dev, name) dma_request_chan(dev, name)
-
 static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)
 {
 	struct dma_slave_caps caps;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

