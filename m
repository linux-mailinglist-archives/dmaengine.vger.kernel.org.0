Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC3B643F86
	for <lists+dmaengine@lfdr.de>; Tue,  6 Dec 2022 10:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiLFJPG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Dec 2022 04:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiLFJPF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Dec 2022 04:15:05 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DF01EEC7;
        Tue,  6 Dec 2022 01:15:01 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRF9v59Wbz8RV7N;
        Tue,  6 Dec 2022 17:14:59 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B69Em72018258;
        Tue, 6 Dec 2022 17:14:48 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 6 Dec 2022 17:14:50 +0800 (CST)
Date:   Tue, 6 Dec 2022 17:14:50 +0800 (CST)
X-Zmail-TransId: 2af9638f080a56acf900
X-Mailer: Zmail v1.0
Message-ID: <202212061714501297954@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <vkoul@kernel.org>
Cc:     <cai.huoqing@linux.dev>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkbWFlbmdpbmU6IHBwYzR4eDogQ29udmVydCB0byB1c2XCoHN5c2ZzX2VtaXQoKS9zeXNmc19lbWl0X2F0KCkgQVBJcw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B69Em72018258
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 638F0813.000 by FangMail milter!
X-FangMail-Envelope: 1670318099/4NRF9v59Wbz8RV7N/638F0813.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638F0813.000/4NRF9v59Wbz8RV7N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/dma/ppc4xx/adma.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 6b5e91f26afc..686c270ef710 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4299,9 +4299,8 @@ static ssize_t devices_show(struct device_driver *dev, char *buf)
 	for (i = 0; i < PPC440SPE_ADMA_ENGINES_NUM; i++) {
 		if (ppc440spe_adma_devices[i] == -1)
 			continue;
-		size += scnprintf(buf + size, PAGE_SIZE - size,
-				 "PPC440SP(E)-ADMA.%d: %s\n", i,
-				 ppc_adma_errors[ppc440spe_adma_devices[i]]);
+		size += sysfs_emit_at(buf, size, "PPC440SP(E)-ADMA.%d: %s\n",
+				     i, ppc_adma_errors[ppc440spe_adma_devices[i]]);
 	}
 	return size;
 }
@@ -4309,9 +4308,8 @@ static DRIVER_ATTR_RO(devices);

 static ssize_t enable_show(struct device_driver *dev, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE,
-			"PPC440SP(e) RAID-6 capabilities are %sABLED.\n",
-			ppc440spe_r6_enabled ? "EN" : "DIS");
+	return sysfs_emit(buf, "PPC440SP(e) RAID-6 capabilities are %sABLED.\n",
+			  ppc440spe_r6_enabled ? "EN" : "DIS");
 }

 static ssize_t enable_store(struct device_driver *dev, const char *buf,
@@ -4362,7 +4360,7 @@ static ssize_t poly_show(struct device_driver *dev, char *buf)
 	reg &= 0xFF;
 #endif

-	size = snprintf(buf, PAGE_SIZE, "PPC440SP(e) RAID-6 driver "
+	size = sysfs_emit(buf, "PPC440SP(e) RAID-6 driver "
 			"uses 0x1%02x polynomial.\n", reg);
 	return size;
 }
-- 
2.25.1
