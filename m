Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABDE4251C9
	for <lists+dmaengine@lfdr.de>; Thu,  7 Oct 2021 13:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhJGLPS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 07:15:18 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52560 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbhJGLPQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Oct 2021 07:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633605203; x=1665141203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hEtripnCOE0xsYLDlRIZuSzQPbXUlwmF5HeFZ+YxCas=;
  b=Cja10FpCes/5t8+yVN1QCCc6Q3wAchSsrgWvSsmk6foHa6Xmtv/wEMl/
   EJ7LbECV5YgvLnFaAtCQzigbGkO2HoQbHzGOXHDKpO+MCOUHLpdunO/lq
   BexvPiX2PWAr+mFL1rQbggWL1j23ovoOWNVa7MDwqtX4v5FCNAr+eopqj
   w08NTbzyTo0pzVPZDtXbq5Uk3Uj6V9JNHlGTYcx3uOAaL0MBcSi/uCg+J
   /mT3m/2jBjuFhrVqiDiHhpJsZEVHKc/eTRQMHoMluXFsEKHxEBwEaK6yW
   s/eVyEp9yTNzdt4y2rO1ufh7R9AwppA9OHZ9KG06OSWbiCNMUwZ8NcKnA
   A==;
IronPort-SDR: vbxXNVXHRUDIbuLsR4tU+ZGzCJIUpN1W3mj2tFpcbs5UTcnUa/mnL851UK/xDB9KsRcMQkYcmR
 Px03TSM7ILJTBq63eZwy5P16YRx6GIPTnF6NkY1YtCPoXm9evacTeUVgjohxjzlq/8/qS7GCUF
 DY9eZC0N25cbZ+WRRrJKrDNhu520MxQdtnTciBLWv5tSmts12rigCWI9CXHEPpQn/q1on0t2sr
 YvWHO5VtgQHgStpvVdqD3nG1yAwMRzfWm2AxweXsJ/TlEJwQizvKvi+cSZnl+2eLVaio8X9lUh
 n8CSrqVZ52KsvrBxjzkrmpgY
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="147120376"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2021 04:13:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 7 Oct 2021 04:13:22 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 7 Oct 2021 04:13:20 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/4] dmaengine: at_xdmac: fix AT_XDMAC_CC_PERID() macro
Date:   Thu, 7 Oct 2021 14:12:28 +0300
Message-ID: <20211007111230.2331837-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
References: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

AT_XDMAC_CC_PERID() should be used to setup bits 24..30 of XDMAC_CC
register. Using it without parenthesis around 0x7f & (i) will lead to
setting all the time zero for bits 24..30 of XDMAC_CC as the << operator
has higher precedence over bitwise &. Thus, add paranthesis around
0x7f & (i).

Fixes: 15a03850ab8f ("dmaengine: at_xdmac: fix macro typo")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index c66ad5706cb5..e18abbd56fb5 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -155,7 +155,7 @@
 #define		AT_XDMAC_CC_WRIP	(0x1 << 23)	/* Write in Progress (read only) */
 #define			AT_XDMAC_CC_WRIP_DONE		(0x0 << 23)
 #define			AT_XDMAC_CC_WRIP_IN_PROGRESS	(0x1 << 23)
-#define		AT_XDMAC_CC_PERID(i)	(0x7f & (i) << 24)	/* Channel Peripheral Identifier */
+#define		AT_XDMAC_CC_PERID(i)	((0x7f & (i)) << 24)	/* Channel Peripheral Identifier */
 #define AT_XDMAC_CDS_MSP	0x2C	/* Channel Data Stride Memory Set Pattern */
 #define AT_XDMAC_CSUS		0x30	/* Channel Source Microblock Stride */
 #define AT_XDMAC_CDUS		0x34	/* Channel Destination Microblock Stride */
-- 
2.25.1

