Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3050C60C78B
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiJYJIL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJYJHI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:07:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF527B1B90;
        Tue, 25 Oct 2022 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688670; x=1698224670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nmkk4t5hZNIkDnSjkdy3tZsVaVAlGxAMmBXKHXLVS4U=;
  b=canLLWyEACaiB48FdCK4fAOPyswysjsV43meY18B47UpjYVU+itwkRd8
   Hzmhry7JKE5l8U49GTghe0mW0oS9mCxt40kttD9tB1cM3mlII3WFMnFP9
   K7L7ZAnHCXfifFxe/60Gp6lkOmdv65o1lr01vR868upXtXDlblhulnh22
   coICVJ5+1wxVHug5koJJg0lCUufUPiuxE71ET9P9HCJoqnoxocoOivHGR
   4ysb1Ys56yShWmCMAJYEeaYn2hbdhryY3vN8YcMurMqxJztKDBIcQPgvB
   O+bjMIcWew2dcRT2ua+FXyc/aGqD8Y4hLRYN9axrBlUka/kA9uekbfx/l
   w==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="186273160"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:29 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:26 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 26/32] dmaengine: at_hdmac: Set include entries in alphabetic order
Date:   Tue, 25 Oct 2022 12:03:00 +0300
Message-ID: <20221025090306.297886-27-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025090306.297886-1-tudor.ambarus@microchip.com>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
index 4e3c519e6079..a3fa8bffdb74 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -12,16 +12,16 @@
 #include <dt-bindings/dma/at91.h>
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
 
 #include "at_hdmac_regs.h"
 #include "dmaengine.h"
-- 
2.25.1

