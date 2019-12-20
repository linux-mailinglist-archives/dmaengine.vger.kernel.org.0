Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B872B127B88
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 14:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLTNKy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 08:10:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58242 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLTNKy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Dec 2019 08:10:54 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBKDAjWP036270;
        Fri, 20 Dec 2019 07:10:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576847445;
        bh=CrGd70iz1Y/kL9JoOYs6SZJaCBp8X7flypShA4QWAzs=;
        h=From:To:CC:Subject:Date;
        b=waABWkBJtdDJEHDxFHywY6xfuLxvr9slMJ+wJ67viR8iJ+eTIEYrwvxkeR85iaf5O
         W/2/sXsqPFQ77lSTgRr5rkg3PXXNYkKEmCmuD1rtsEj+3wUa0zFymsJcNMjGdCA16e
         Sb/OrWPcQxhu6wEFpQ8W9+ZM3D/THLE19gHUub6k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBKDAjEm124875
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Dec 2019 07:10:45 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Dec 2019 07:10:44 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Dec 2019 07:10:44 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBKDAgAe035079;
        Fri, 20 Dec 2019 07:10:43 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alexandru.ardelean@analog.com>,
        <s.hauer@pengutronix.de>
Subject: [PATCH] dmaengine: virt-dma: Fix access after free in vcna_complete()
Date:   Fri, 20 Dec 2019 15:11:00 +0200
Message-ID: <20191220131100.21804-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

vchan_vdesc_fini() is freeing up 'vd' so the access to vd->tx_result is
via already freed up memory.

Move the vchan_vdesc_fini() after invoking the callback to avoid this.

Fixes: 09d5b702b0f97 ("dmaengine: virt-dma: store result on dma descriptor")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/virt-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
index ec4adf4260a0..256fc662c500 100644
--- a/drivers/dma/virt-dma.c
+++ b/drivers/dma/virt-dma.c
@@ -104,9 +104,8 @@ static void vchan_complete(unsigned long arg)
 		dmaengine_desc_get_callback(&vd->tx, &cb);
 
 		list_del(&vd->node);
-		vchan_vdesc_fini(vd);
-
 		dmaengine_desc_callback_invoke(&cb, &vd->tx_result);
+		vchan_vdesc_fini(vd);
 	}
 }
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

