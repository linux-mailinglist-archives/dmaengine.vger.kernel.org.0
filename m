Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3A60C78D
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJYJIQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiJYJHK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:07:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D271CF853;
        Tue, 25 Oct 2022 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688672; x=1698224672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=evIATU0YdE3ohEp9vpmOjUBzxo8LdZOKKD7VgaBjLdE=;
  b=T9SedWLGIuGtNbstN7yvYo1e/dl8Arimh/9CMlAs9QdjtfjwNCcMf4bs
   QOkOo04JHVHUpda9zrlj7IDuadiw4CrZNLqFwqB0+Va8zRwAPUA5mRCpQ
   jxE6bE0fQgbzc9eoZCP+BkDw+vr4fxq9RXiFk286NoSbDNIbIj1dq1/aV
   NQekRsKYwcH6rNd4Shg1KP6DgAZ0zgRtyr9ilnOaLh45KwwC+c6pVen8X
   jBWvuKwh/a4Y9Pq6xVw3TltPPwIjZ6bmBMfdpmpBAfEIq//VYripbSsL2
   QLTKMCiOYugMjLiQLx7v5UWDt9oNaJt2jzoG+YwaDlfehL/skeCkO0e5c
   A==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="196910227"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:26 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:24 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 25/32] dmaengine: at_hdmac: Use pm_ptr()
Date:   Tue, 25 Oct 2022 12:02:59 +0300
Message-ID: <20221025090306.297886-26-tudor.ambarus@microchip.com>
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

Use pm_ptr() macro to fill at_dma_driver.driver.pm. In case CONFIG_PM is
not enabled, the macro will return NULL. When NULL, at_dma_dev_pm_ops will
end up being unused, so prepend it with the __maybe_unused attribute.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 444aa7d75ff5..4e3c519e6079 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2084,7 +2084,7 @@ static int at_dma_resume_noirq(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops at_dma_dev_pm_ops = {
+static const struct dev_pm_ops __maybe_unused at_dma_dev_pm_ops = {
 	.prepare = at_dma_prepare,
 	.suspend_noirq = at_dma_suspend_noirq,
 	.resume_noirq = at_dma_resume_noirq,
@@ -2096,7 +2096,7 @@ static struct platform_driver at_dma_driver = {
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

