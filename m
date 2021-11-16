Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AAC45305A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhKPLZK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:25:10 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:18426 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbhKPLY0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061689; x=1668597689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WIpbBPu+LDILnDfRZxv4mO7fUQqnAghfChRhfJnCk4s=;
  b=qf5qY/GIbLzigIcQW/Fs/U7DdRvziok5U5LtBU/FMu64LC12WAYhGIl8
   fdRY8zwlW/h83fdNn05bAxaihgdxQamSoyohWw/8eE9t3k/JnUNpZv73e
   8c1JgDiqQdvt1AgWaVlL+UiaDqDpgXpdJTA7eO7sORaMe1gnLK4we/yuj
   OeVQSOtS3TryxcsK6P8p4pEudWjy+OTun0faTZidFW3KP3+43v78YAKxe
   p/L6aG5KntbFyryMTz3+4aGC5ueIhAlB3AGQY9dJJoZJxrdYBjaSqBdi2
   XOcWzAc/TdhNUUh3QSPeVFqWPWqqExsM6nyDMAHNp/ukZkZtnHGy/CCrd
   w==;
IronPort-SDR: UJTd3fqXcByB4684k5Xcsv1qqUyJGo9NJsIK5Ns6PXs1zkKvKFpIzlkMPqCh3Urt1ctD/I8QCR
 wc9Wkc0fuVKzAwd+2oxGAoYd2sPV6ENaCg2aOEp4YoloplUsu6K/tNFSjFUz3yVmRMuVAaXc2+
 X0oYi3La+NuzJYO2lOWgB9Zcczvbwa6FywPfEyFsff7bJ8dSrrQXNjuynbPW6uoLO3qFxFDewD
 /sJU1TPrfL5kIP7itZjd9w2+O8pE/LBvG2g3AvWQf67RzNSMM7tw2oZseu7dXc7AKzgNcdAyl3
 WL2a3tDBKzuhoDAM7aE6PTJG
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="152085434"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:21:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:21:21 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:21:18 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 11/13] dmaengine: at_xdmac: Fix lld view setting
Date:   Tue, 16 Nov 2021 13:20:34 +0200
Message-ID: <20211116112036.96349-12-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116112036.96349-1-tudor.ambarus@microchip.com>
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
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
index 89d0fc229d68..ba2fe383fa5e 100644
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

