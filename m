Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AD1475737
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbhLOLBq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:46 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47834 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241931AbhLOLBo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566104; x=1671102104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wRIv3ubIX5xAKe7fyTIOsp2EcT/w6mzbj8LN+1DMbDQ=;
  b=Qvn34RVzvRxx8dy7yeQzNaoT/29mLwfDfGzYtGz/5CgxZVAwaUV4txW7
   orpS0HxDTnVqoczez3xDcmF3XuzN77gMxVJ0N2/J62hBxt74d7+PPwTbD
   29fliBAcI2zotPPUVtNggF8PDnJwIyHQHCKdYmAkL5Y5FnkyY92VP7RP9
   rnI/KCv7Q+LsXUok7c7mqK4MVqK1l8R2O3cwQ63x1cs9hP0rvErZKOZxo
   MBZxBbkwWlGUq+caUK7e+WC6rgitZY5KS95lhbDOBN4qWwojxxLE5t1q1
   bMu8vbrCAXF0yXKR6YFnErDAbGkb+C/UX1DOIVckJxV4VJ7G0I9PytBtk
   Q==;
IronPort-SDR: Fsz88XrgCtebLa3EfjLEQf4u+oi9crAkKTf3DVfGNDskAz0axCJ2nHMeZLPybHbqK2AfeUd2m0
 ac0NO21yMNuesZ4fQHC410CzbRr5PnAsA78colDNt3bKuntRpPj0cLmzt46xds/Hq/KCVSzmwA
 9bx9PLxwqsSSUsxNADoJpLGv4LcWOfW5evAQGa0/nK1pl24KPgG5weDNoQXjae7YUYyTUmkZNi
 19lWsopd1+rXYwe6E4FoJ/R7uHV+CUvxaTFXMEbOGA9JUl9mxD4InhogpfqzDclyrrnANQiK8I
 2Lc7ni0R4+8mCSqwAGSU4ekf
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="155559242"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:43 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:41 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 09/12] dmaengine: at_xdmac: Fix lld view setting
Date:   Wed, 15 Dec 2021 13:01:12 +0200
Message-ID: <20211215110115.191749-10-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

AT_XDMAC_CNDC_NDVIEW_NDV3 was set even for AT_XDMAC_MBR_UBC_NDV2,
because of the wrong bit handling. Fix it.

Fixes: ee0fe35c8dcd ("dmaengine: xdmac: Handle descriptor's view 3 registers")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 0b09ec752db4..6e5bfc9b3825 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -99,6 +99,7 @@
 #define		AT_XDMAC_CNDC_NDE		(0x1 << 0)		/* Channel x Next Descriptor Enable */
 #define		AT_XDMAC_CNDC_NDSUP		(0x1 << 1)		/* Channel x Next Descriptor Source Update */
 #define		AT_XDMAC_CNDC_NDDUP		(0x1 << 2)		/* Channel x Next Descriptor Destination Update */
+#define		AT_XDMAC_CNDC_NDVIEW_MASK	GENMASK(28, 27)
 #define		AT_XDMAC_CNDC_NDVIEW_NDV0	(0x0 << 3)		/* Channel x Next Descriptor View 0 */
 #define		AT_XDMAC_CNDC_NDVIEW_NDV1	(0x1 << 3)		/* Channel x Next Descriptor View 1 */
 #define		AT_XDMAC_CNDC_NDVIEW_NDV2	(0x2 << 3)		/* Channel x Next Descriptor View 2 */
@@ -402,7 +403,8 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 	 */
 	if (at_xdmac_chan_is_cyclic(atchan))
 		reg = AT_XDMAC_CNDC_NDVIEW_NDV1;
-	else if (first->lld.mbr_ubc & AT_XDMAC_MBR_UBC_NDV3)
+	else if ((first->lld.mbr_ubc &
+		  AT_XDMAC_CNDC_NDVIEW_MASK) == AT_XDMAC_MBR_UBC_NDV3)
 		reg = AT_XDMAC_CNDC_NDVIEW_NDV3;
 	else
 		reg = AT_XDMAC_CNDC_NDVIEW_NDV2;
-- 
2.25.1

