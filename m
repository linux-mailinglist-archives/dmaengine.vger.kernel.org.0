Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14E3453048
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhKPLYm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:24:42 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:18384 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbhKPLYR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061681; x=1668597681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4UJToV8z1d1CSnT1DHee/do0TBGgvnsbC5y36KVHVoA=;
  b=beaHuCj4NPRolv7fmus05vMwvS9/ovhXI+GrWRIENdaFTPKVFLXo+cLT
   pyjZh1jhvZ7z/A2tyKuWUfbm4P7smxgzfirkS1UofsfbRukQDjnDAHy0u
   si71DZUnZl5xSur66eWCQKmV0KaCzMXxTJBnbaOnYDBChDxxb//tTorrj
   aV5vSOZIsy0ymSmwCa/K9Ix7ythtg8ERwSjupo3e7pNp1fxYd3EhYpF6C
   WcV4LbYFFODl+kA251am7O3WgYTgCYmSHlZEPHrBpY31/nZ02mNReAw67
   qKofZrJvT1ItV6/wHoJTfTRNtSKdl5MHnVI4wLqoXMyPuJY9VyH82+FVQ
   w==;
IronPort-SDR: brqGcVkMu6p19txpv00wUnn71TVfCG/Ak3bOmAroJqg/zfSScjECH7yB/aGDZOqn11UT/OC+/Y
 ZjM9fxrvI+xa1qDd65NyoMUrh6YWfWdMAmOdRX1cwD0HWmGyKTZ2z2srUmjGY6ny/Ev1i80htW
 f0Xl/cmjWuPozpNSyhYy2tnnp92N7d2fuU05mZWpsnE8QpKQToEoA3YjoJs2oBpnZjvOONrd6R
 6lfSaoibxWsFaXg7ycpXfs5u5XuqtiEB+NFA/e9Ziq6KXqKNp4SXVIDpJ99PWH89R5D96hS4E5
 QcnZftuxmykH0PAmGLSC8s0t
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="152085416"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:21:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:21:18 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:21:15 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 10/13] dmaengine: at_xdmac: Remove a level of indentation in at_xdmac_advance_work()
Date:   Tue, 16 Nov 2021 13:20:33 +0200
Message-ID: <20211116112036.96349-11-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116112036.96349-1-tudor.ambarus@microchip.com>
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's easier to read code with fewer levels of indentation.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 81f6f1357dcb..89d0fc229d68 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1593,14 +1593,14 @@ static void at_xdmac_advance_work(struct at_xdmac_chan *atchan)
 	 * If channel is enabled, do nothing, advance_work will be triggered
 	 * after the interruption.
 	 */
-	if (!at_xdmac_chan_is_enabled(atchan) && !list_empty(&atchan->xfers_list)) {
-		desc = list_first_entry(&atchan->xfers_list,
-					struct at_xdmac_desc,
-					xfer_node);
-		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
-		if (!desc->active_xfer)
-			at_xdmac_start_xfer(atchan, desc);
-	}
+	if (at_xdmac_chan_is_enabled(atchan) || list_empty(&atchan->xfers_list))
+		return;
+
+	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc,
+				xfer_node);
+	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
+	if (!desc->active_xfer)
+		at_xdmac_start_xfer(atchan, desc);
 }
 
 static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
-- 
2.25.1

