Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9759AE39
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347643AbiHTNBN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 09:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347321AbiHTNAf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 09:00:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB7EFD2C;
        Sat, 20 Aug 2022 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000356; x=1692536356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2axgLz0nRmKkBixXdLu5tutLhhODxz17yBGESR544rg=;
  b=HMrztd9aruCmBEv9O5nLMPKt+L/pmtSRFz2DJV8EZqMV+riozxuHCUlL
   O8JpvQ8j9aku+Y1e0pUTfOAAVnEHNUA8j8qfypqFKrkATDZwt/w7Z8oca
   I9/rlBFwrqUEAPkSLWNzGgFbOLteHy2tsePC85ovk1fwNxjAjnyn86iuH
   5UsZj8uVKFnqMgbKPqx78zmdyu007PsMcOQ6KrfEffdycHeKn3e2yL3JQ
   drv+mZ/uRAnVlOJNnnKpdda65YFzpe03c8+vTPCnvhQVwBsCaiUuBAxtf
   Vct3bPE+YOEK/NTumNYCGbWQKrLefDSSItbnVKixZDEJk8KVhRifSWe9m
   g==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="177043102"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:59:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:59:13 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:59:10 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 32/33] dmaengine: at_hdmac: Set include entries in alphabetic order
Date:   Sat, 20 Aug 2022 15:57:16 +0300
Message-ID: <20220820125717.588722-33-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820125717.588722-1-tudor.ambarus@microchip.com>
References: <20220820125717.588722-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's a good practice to set the include entries in alphabetic order. It
helps humans to read the code easier. Alphabetic order should also prove
that each header is self-contained, i.e. can be included without
prerequisites.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index e35b4b325452..a2b24b9e85ce 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -13,16 +13,16 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
-#include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/overflow.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include "dmaengine.h"
 
-- 
2.25.1

