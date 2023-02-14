Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051A46967E0
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 16:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjBNPVH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 10:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjBNPU5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 10:20:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916D2A141;
        Tue, 14 Feb 2023 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676388053; x=1707924053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0CtvDEh2vlSrMf1WczKNd8+6RrD0e9Y436UeDqUellw=;
  b=pfRUOKHQKX+tVxisQumrN42a6dqImZ24tmJINh/FCfKmVVcY6NYt7ntK
   TCEUHZzo5RMibLsaYCCfJob9yx5DCxDJJwEmSO/PPzskXixDNQFJiLXzB
   jb9ZKj6Y0kdnrfv9l+BnWDbYZcgQBj5FYixp7rhz3+9VsjFTPOUPSq2yt
   QjLm33iBNWFsEP/ZBYKFvzPjY0fgoHRxlhTtsRpCfk3v6J1bZsOYhGoxg
   il1e9TrwuNpZt/7sxJO0gYzkw+34G2OSU9wj7uI7lYUh/ArTkFiQ1VATq
   onc8ERjRXNzZYt7t8UgKqwyRT1I8ZFRBQepo5jOVqV7YiXmNQSmJwdRVs
   A==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669100400"; 
   d="scan'208";a="196877741"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 08:20:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:20:52 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 08:20:49 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@linaro.org>,
        <vkoul@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/7] dmaengine: at_xdmac: restore the content of grws register
Date:   Tue, 14 Feb 2023 17:18:24 +0200
Message-ID: <20230214151827.1050280-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214151827.1050280-1-claudiu.beznea@microchip.com>
References: <20230214151827.1050280-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In case the system suspends to a deep sleep state where power to DMA
controller is cut-off we need to restore the content of GRWS register.
This is a write only register and writing bit X tells the controller
to suspend read and write requests for channel X. Thus set GRWS before
restoring the content of GE (Global Enable) regiter.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index fa1e2e0da02f..34c004a4b23c 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2211,6 +2211,15 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 					return ret;
 				at_xdmac_device_resume_internal(atchan);
 			}
+
+			/*
+			 * We may resume from a deep sleep state where power
+			 * to DMA controller is cut-off. Thus, restore the
+			 * suspend state of channels set though dmaengine API.
+			 */
+			else if (at_xdmac_chan_is_paused(atchan))
+				at_xdmac_device_pause_set(atxdmac, atchan);
+
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, atchan->save_cnda);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
-- 
2.34.1

