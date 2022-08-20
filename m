Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309E359AE3C
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347785AbiHTNBN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 09:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347158AbiHTNAf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 09:00:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C78A1C6;
        Sat, 20 Aug 2022 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000354; x=1692536354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lld3vah51r9NmmPsNHxT9mVmwu9BEfyoTnLOez1YBdk=;
  b=CdnqHwQPv6lpL2fNETbkeatBoScOpBdc1XNsQYtPNRMF1Kvhd1FGvzSJ
   hlBECGYDub6EZQKYlrqulKUkzAn5tKyN29K2PH7Pp8WM7Aje9z8D0vq7D
   J4/3+kjU6HaJJ3eigFjVE/xUhBnXeVyZoli/qaD1igu6wSvmJV+J7Bd5w
   8zAnUBlqIdjC8g1AhyyWLjbdlud5yj+o20GL6GHkdn2J+SDKvIYadsZaN
   2mLAC/Xs1DbDVmwB8PTj2DQTlv3coSneFobWMkOGmjCGVNfZIgTQf9kaI
   L5CUxM+FOTJTqzc2fOIe+Mi2XAtrOIJIxgCC54XFu+HuQ9Bj1cNu+8c9J
   A==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="109911995"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:59:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:59:10 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:59:06 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@gmail.com>
Subject: [PATCH 31/33] dmaengine: at_hdmac: Use pm_ptr()
Date:   Sat, 20 Aug 2022 15:57:15 +0300
Message-ID: <20220820125717.588722-32-tudor.ambarus@microchip.com>
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

From: Tudor Ambarus <tudor.ambarus@gmail.com>

Use pm_ptr() macro to fill at_xdmac_driver.driver.pm. In case CONFIG_PM is
not enabled, the macro will return NULL.

Signed-off-by: Tudor Ambarus <tudor.ambarus@gmail.com>
---
 drivers/dma/at_hdmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 0b473e6d161d..e35b4b325452 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2524,7 +2524,7 @@ static int at_dma_resume_noirq(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops at_dma_dev_pm_ops = {
+static const struct dev_pm_ops __maybe_unused at_dma_dev_pm_ops = {
 	.prepare = at_dma_prepare,
 	.suspend_noirq = at_dma_suspend_noirq,
 	.resume_noirq = at_dma_resume_noirq,
@@ -2536,7 +2536,7 @@ static struct platform_driver at_dma_driver = {
 	.id_table	= atdma_devtypes,
 	.driver = {
 		.name	= "at_hdmac",
-		.pm	= &at_dma_dev_pm_ops,
+		.pm	= pm_ptr(&at_dma_dev_pm_ops),
 		.of_match_table	= of_match_ptr(atmel_dma_dt_ids),
 	},
 };
-- 
2.25.1

