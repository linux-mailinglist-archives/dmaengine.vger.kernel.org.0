Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5964251CB
	for <lists+dmaengine@lfdr.de>; Thu,  7 Oct 2021 13:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240838AbhJGLPU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 07:15:20 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52782 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbhJGLPT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Oct 2021 07:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633605206; x=1665141206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xVnn9WxWYI8p2PQEPWKAc0zs+S1iqFL65zaIk7wggGM=;
  b=fHMKpUw2uzCgU5UQpPIES+NuXlIJreiTzwApf8fKIFtmlQphj+Dmq8oE
   XTHLvCnt6nDyqVJhrH05W9uA0AkOTa4zDcJ5rFu47uBZ7yxUaiH4eJRM1
   nNxBibHBduyn3xe4lUOtgk7ZfzNn71OgCvqQCM7CgnMDth7s9mZR+78fl
   hnBAp7/15qtHJ/jgiixA9EgiHm3hmRGNiL06IjTsySbp6rWzPYyL65Cwu
   vrOEXsn8CANzZMX9NqRw8puGDlBjVeD1D0/QoUYHcsZEbAyw1ZRhunPkh
   Zbw5vIuyGj2KlqDuexe8oPiaMz2E1gBJGViAEriseKLxHZx0ClBk0s2VS
   g==;
IronPort-SDR: 2fyYNGt3pyRZKFY+Z96VHM6+zArKgqdXFYRmzip1tgrcu2oEIVdZHBYZj4XRNqfJQOali31ZYp
 YWcWvxaGd5EWdQaOOdt17+3P2/eN+tPypgDkmPYMt8yKcdk03RJS143Y9G1SclU2k23hDQ8FEK
 FjCzJhGE9V8QNGgQnCo7TO2z1x3ol5G8CGZNVpodNhGTcYQcRO2D9yC27BYXjwwnhTjPoRAIpS
 xUxWuUVc2GJX2BWckpJ+vu7NYW9reRiqVXQ7dBjWSGVHTmgb4mZZma9+5MBl04TCyA09ALlOPo
 ifJD24zQ1ldz/kfzKQYmNfy9
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="139381853"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2021 04:13:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 7 Oct 2021 04:13:24 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 7 Oct 2021 04:13:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/4] dmaengine: at_xdmac: use __maybe_unused for pm functions
Date:   Thu, 7 Oct 2021 14:12:29 +0300
Message-ID: <20211007111230.2331837-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
References: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use __maybe_unused for pm functions.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index e18abbd56fb5..12371396fcc0 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1950,8 +1950,7 @@ static void at_xdmac_axi_config(struct platform_device *pdev)
 	}
 }
 
-#ifdef CONFIG_PM
-static int atmel_xdmac_prepare(struct device *dev)
+static int __maybe_unused atmel_xdmac_prepare(struct device *dev)
 {
 	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct dma_chan		*chan, *_chan;
@@ -1965,12 +1964,8 @@ static int atmel_xdmac_prepare(struct device *dev)
 	}
 	return 0;
 }
-#else
-#	define atmel_xdmac_prepare NULL
-#endif
 
-#ifdef CONFIG_PM_SLEEP
-static int atmel_xdmac_suspend(struct device *dev)
+static int __maybe_unused atmel_xdmac_suspend(struct device *dev)
 {
 	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct dma_chan		*chan, *_chan;
@@ -1994,7 +1989,7 @@ static int atmel_xdmac_suspend(struct device *dev)
 	return 0;
 }
 
-static int atmel_xdmac_resume(struct device *dev)
+static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 {
 	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct at_xdmac_chan	*atchan;
@@ -2032,7 +2027,6 @@ static int atmel_xdmac_resume(struct device *dev)
 	}
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static int at_xdmac_probe(struct platform_device *pdev)
 {
-- 
2.25.1

