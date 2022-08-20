Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B7259AE17
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbiHTM5s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 08:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346491AbiHTM5l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 08:57:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7332672861;
        Sat, 20 Aug 2022 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000260; x=1692536260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sflmIpqBLANq8bAUPBD8Pdw6bXciPP2rALFFtESeOuc=;
  b=xXU7vOJPyR6ba19yVhb0IMzlkp6rm1z02ehqC/zCbcy3QQt9my0GekA7
   mHoh7RWBtGnjj+Yqkdpj9So4gHNRGzHFkOvVckfyB5/NgrzIIqQu0iiDn
   wM9TqoteQHTnWotSKGGSrk+Mt7oq7cg1ct3rTRWJfSlceSBBqEeyDaQqK
   SLZUxloZoq4Pp0MvJW5lGIRz8hT+2y0PQUADIhOb08yqiNSRRv0DZXq9w
   6PLX7iMYVHP3qD6XU/jnrb6BhAPs0azOf+FMXWtZi1Cl9Ws0joOxUL96F
   f603RlvMqpFh/YkF3wgg0U5DAIAPZUGftG+9bOXoi2kiMlMIp/7hqSbwx
   g==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="170148921"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:57:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:57:39 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:57:36 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 05/33] dmaengine: at_hdmac: Remove unused member of at_dma_chan
Date:   Sat, 20 Aug 2022 15:56:49 +0300
Message-ID: <20220820125717.588722-6-tudor.ambarus@microchip.com>
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

The pointer to at_dma engine was never used, remove it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 91c6eafd96d8..085a990f8d5d 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -247,7 +247,6 @@ enum atc_status {
 /**
  * struct at_dma_chan - internal representation of an Atmel HDMAC channel
  * @dma_chan: common dmaengine channel object members
- * @device: parent device
  * @ch_regs: memory mapped register base
  * @mask: channel index in a mask
  * @per_if: peripheral interface
@@ -267,7 +266,6 @@ enum atc_status {
  */
 struct at_dma_chan {
 	struct dma_chan		dma_chan;
-	struct at_dma		*device;
 	void __iomem		*ch_regs;
 	u8			mask;
 	u8			per_if;
-- 
2.25.1

