Return-Path: <dmaengine+bounces-3261-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A198FD42
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 08:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03201C21CF0
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 06:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322AA6F305;
	Fri,  4 Oct 2024 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0HVwt4g2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC24DA00
	for <dmaengine@vger.kernel.org>; Fri,  4 Oct 2024 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728022971; cv=none; b=DN4KcFeYOnq/duCOuiORMA8zRPTGeofnRM35ZXE4UHexi933v5KCW5OMxJEwLB+smW9dYN5nSUbWQyUB8i3BOhiwlJ3aTs3wkLBJlHm/6b1H2RmTeHPMQMrf+GIgcFf9DlQynOgup2KyZ9FAWyZo7U3JHmwoktX/udjGgIAkgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728022971; c=relaxed/simple;
	bh=8WtI3looRgG00XYYKEwCB/ALK7iIjxpxJcPdxlJXeA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kTX+7xaoS3JjnFORBcafvC1Vhwx70fCwNkOhRXEVdtA2tAmzmsYHMBVxWuxJJ/d798IITFu6hQf0CSovAp0W/HkjnhLIMzbNwuNbrs98pLng/2aCuBPodHOILhrCoPjwXKNiVehqTlMC5LChbcKGLerIwPZ4DX71s4fNqAOceH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0HVwt4g2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37ccfada422so1094018f8f.2
        for <dmaengine@vger.kernel.org>; Thu, 03 Oct 2024 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728022965; x=1728627765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBwjw1zrSL56rtKHitU4pUzmWNMAGC6t+dKgq5syOhk=;
        b=0HVwt4g2V79hkay81fLDyPbqPhImtbOMgifgKGjRbzoeU6S2Qepzmu0Etu0OLVs+qK
         isOGq7p2VyFhZxRbTTqVOs89kN62LwhPM4hb3r3Y7hE4IDaxFBxNkwhXwM6rwY4Fen3e
         IGp5Kj2GdQt+1jC0Dhoqmxg+/uRq0HCX9PQcapUsLR25YuLqNMpobP+GN8pWEfg1vvHP
         dn8U2ZAIeQqDOfXjBoLVVPpncOdAlp6CezfjAsz8SkseaOF4eHcXmvpfw4y5J6LHNNHz
         Wsd0fWy3ytjDOmly+QOXn8+WJJ+E/9mwdFr+N213uK3hMgl1DtEKP/a4bJ6bH54XeoH3
         0+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728022965; x=1728627765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBwjw1zrSL56rtKHitU4pUzmWNMAGC6t+dKgq5syOhk=;
        b=odwIRSaA17lNvJxUaK+NbiaxVs5bGOQJvW9fJaL1+8vjdsFSyx9USERaeiGM8YHvkU
         PGLm6x/UBwSdrJsgf0qJYOU5U9ArDwj+tuRdVqnVu+4tSEArzU9sXiZfUfuGMk9veI2W
         3TVhB1gqtX9hxSOE8jDjrRZZfIqIddpxsXhH+YXnsorXTWGLpaivTClU9q93oPCHAosv
         WI1w+GOy0BlJPzUw5eoBiErJaKlRuvHFlU1+qALVtG0ry9yjZPULra8Lsf1pyDqbQQ5C
         DMMLxhfNhUMneLNE9uZ557gcMGIx0Q4ZvkalpcIU1cIAPFzlKLyK2K6AmC705ux6YjQe
         tPoA==
X-Gm-Message-State: AOJu0YyBz5Zy1oOGRInwC8rhrUrExjaQKPFb1CLj5wpnC8eRbF0IDeel
	YwHoOh2Dvt8OWas6GKai/fc9F/3FWk399y32k+OEhCsqImMB0rhzA84XKLJ/I5U=
X-Google-Smtp-Source: AGHT+IHdbxR4h/zg8oQhRZbOnuel8xUxJ4IX8LDf48qzIDG4UGYT91EllpIoS2y3na5kdzq1ZiqACA==
X-Received: by 2002:a5d:6e90:0:b0:374:b6f3:728d with SMTP id ffacd0b85a97d-37d0e8ee08emr945128f8f.46.1728022963887;
        Thu, 03 Oct 2024 23:22:43 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082161b7sm2589574f8f.34.2024.10.03.23.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 23:22:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Subject: [PATCH] dma: Switch back to struct platform_driver::remove()
Date: Fri,  4 Oct 2024 08:22:27 +0200
Message-ID: <20241004062227.187726-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=35056; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=8WtI3looRgG00XYYKEwCB/ALK7iIjxpxJcPdxlJXeA8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm/4mj5iga1P2yEBov5oPag2I3sAgMqelsiP/OJ /sOOwpxl9yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZv+JowAKCRCPgPtYfRL+ TmvyB/47D9s9Y2h2/eDvZTPOtSW8/dLyTimjseF6oKG8+sDO4PeeTnKSRAhjLerDTZckLsmQo+F 9ul7HjeNHQQomeij65sqTH7iaQ2D3pA9gM3+ehFB1h03zGw84P2rFoS9xbijEik/mklVYLb8R3e wJGz+HH8E8dA9jBKRDdaRl45LjE+FQgtBaLDOgPqsYDpT1q3mwOXkwhwscON9dI3XccRAyV0srC qks+eT6P7Iu3F1NgW+jpgadLXjPSzTi4kzIp2oJ26apM3nbZqf3iMjMflQjm2x+qO/xuJbS4oXo 5oc6BSpl/jlG1cie2xDiq6APpKKwMMEWJep/1Fbn8+H+T/gG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/dma after the previous
conversion commits apart from the wireless drivers to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

given the simplicity of the individual changes I do this all in a single
patch. I you don't agree, please tell and I will happily split it.

It's based on today's next, feel free to drop changes that result in a
conflict when you come around to apply this. I'll care for the fallout
at a later time then. (Having said that, if you use b4 am -3 and git am
-3, there should be hardly any conflict.)

Note I didn't Cc: all the individual driver maintainers to not trigger
sending limits and spam filters.

Best regards
Uwe

 drivers/dma/altera-msgdma.c                    | 2 +-
 drivers/dma/amd/qdma/qdma.c                    | 2 +-
 drivers/dma/apple-admac.c                      | 2 +-
 drivers/dma/at_hdmac.c                         | 2 +-
 drivers/dma/at_xdmac.c                         | 2 +-
 drivers/dma/bcm-sba-raid.c                     | 2 +-
 drivers/dma/bcm2835-dma.c                      | 2 +-
 drivers/dma/bestcomm/bestcomm.c                | 2 +-
 drivers/dma/dma-jz4780.c                       | 2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 +-
 drivers/dma/dw/platform.c                      | 2 +-
 drivers/dma/fsl-edma-main.c                    | 2 +-
 drivers/dma/fsl-qdma.c                         | 2 +-
 drivers/dma/fsl_raid.c                         | 2 +-
 drivers/dma/fsldma.c                           | 2 +-
 drivers/dma/idma64.c                           | 2 +-
 drivers/dma/img-mdc-dma.c                      | 2 +-
 drivers/dma/imx-dma.c                          | 2 +-
 drivers/dma/imx-sdma.c                         | 2 +-
 drivers/dma/k3dma.c                            | 2 +-
 drivers/dma/ls2x-apb-dma.c                     | 2 +-
 drivers/dma/mcf-edma-main.c                    | 2 +-
 drivers/dma/mediatek/mtk-cqdma.c               | 2 +-
 drivers/dma/mediatek/mtk-hsdma.c               | 2 +-
 drivers/dma/mediatek/mtk-uart-apdma.c          | 2 +-
 drivers/dma/milbeaut-hdmac.c                   | 2 +-
 drivers/dma/milbeaut-xdmac.c                   | 2 +-
 drivers/dma/mmp_pdma.c                         | 2 +-
 drivers/dma/mmp_tdma.c                         | 2 +-
 drivers/dma/moxart-dma.c                       | 2 +-
 drivers/dma/mpc512x_dma.c                      | 2 +-
 drivers/dma/mv_xor_v2.c                        | 2 +-
 drivers/dma/nbpfaxi.c                          | 2 +-
 drivers/dma/owl-dma.c                          | 2 +-
 drivers/dma/ppc4xx/adma.c                      | 2 +-
 drivers/dma/pxa_dma.c                          | 2 +-
 drivers/dma/qcom/bam_dma.c                     | 2 +-
 drivers/dma/qcom/hidma.c                       | 2 +-
 drivers/dma/qcom/qcom_adm.c                    | 2 +-
 drivers/dma/sa11x0-dma.c                       | 2 +-
 drivers/dma/sf-pdma/sf-pdma.c                  | 2 +-
 drivers/dma/sh/rcar-dmac.c                     | 2 +-
 drivers/dma/sh/rz-dmac.c                       | 2 +-
 drivers/dma/sh/shdmac.c                        | 2 +-
 drivers/dma/sh/usb-dmac.c                      | 2 +-
 drivers/dma/sprd-dma.c                         | 2 +-
 drivers/dma/st_fdma.c                          | 2 +-
 drivers/dma/stm32/stm32-dma3.c                 | 2 +-
 drivers/dma/sun4i-dma.c                        | 2 +-
 drivers/dma/sun6i-dma.c                        | 2 +-
 drivers/dma/tegra186-gpc-dma.c                 | 2 +-
 drivers/dma/tegra20-apb-dma.c                  | 2 +-
 drivers/dma/tegra210-adma.c                    | 2 +-
 drivers/dma/ti/cppi41.c                        | 2 +-
 drivers/dma/ti/edma.c                          | 2 +-
 drivers/dma/ti/omap-dma.c                      | 2 +-
 drivers/dma/timb_dma.c                         | 2 +-
 drivers/dma/txx9dmac.c                         | 4 ++--
 drivers/dma/uniphier-mdmac.c                   | 2 +-
 drivers/dma/uniphier-xdmac.c                   | 2 +-
 drivers/dma/xgene-dma.c                        | 2 +-
 drivers/dma/xilinx/xdma.c                      | 2 +-
 drivers/dma/xilinx/xilinx_dma.c                | 2 +-
 drivers/dma/xilinx/xilinx_dpdma.c              | 2 +-
 drivers/dma/xilinx/zynqmp_dma.c                | 2 +-
 65 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index e6a6566b309e..a203fdd84950 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -954,7 +954,7 @@ static struct platform_driver msgdma_driver = {
 		.of_match_table = of_match_ptr(msgdma_match),
 	},
 	.probe = msgdma_probe,
-	.remove_new = msgdma_remove,
+	.remove = msgdma_remove,
 };
 
 module_platform_driver(msgdma_driver);
diff --git a/drivers/dma/amd/qdma/qdma.c b/drivers/dma/amd/qdma/qdma.c
index b0a1f3ad851b..6d9079458fe9 100644
--- a/drivers/dma/amd/qdma/qdma.c
+++ b/drivers/dma/amd/qdma/qdma.c
@@ -1133,7 +1133,7 @@ static struct platform_driver amd_qdma_driver = {
 		.name = "amd-qdma",
 	},
 	.probe		= amd_qdma_probe,
-	.remove_new	= amd_qdma_remove,
+	.remove		= amd_qdma_remove,
 };
 
 module_platform_driver(amd_qdma_driver);
diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index 9588773dd2eb..c499173d80b2 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -950,7 +950,7 @@ static struct platform_driver apple_admac_driver = {
 		.of_match_table = admac_of_match,
 	},
 	.probe = admac_probe,
-	.remove_new = admac_remove,
+	.remove = admac_remove,
 };
 module_platform_driver(apple_admac_driver);
 
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index baebddc740b0..2d147712cbc6 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2250,7 +2250,7 @@ static const struct dev_pm_ops __maybe_unused at_dma_dev_pm_ops = {
 };
 
 static struct platform_driver at_dma_driver = {
-	.remove_new	= at_dma_remove,
+	.remove		= at_dma_remove,
 	.shutdown	= at_dma_shutdown,
 	.id_table	= atdma_devtypes,
 	.driver = {
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 299396121e6d..9c7b40220004 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2476,7 +2476,7 @@ MODULE_DEVICE_TABLE(of, atmel_xdmac_dt_ids);
 
 static struct platform_driver at_xdmac_driver = {
 	.probe		= at_xdmac_probe,
-	.remove_new	= at_xdmac_remove,
+	.remove		= at_xdmac_remove,
 	.driver = {
 		.name		= "at_xdmac",
 		.of_match_table	= of_match_ptr(atmel_xdmac_dt_ids),
diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index cfa6e1167a1f..7f0e76439ce5 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -1756,7 +1756,7 @@ MODULE_DEVICE_TABLE(of, sba_of_match);
 
 static struct platform_driver sba_driver = {
 	.probe = sba_probe,
-	.remove_new = sba_remove,
+	.remove = sba_remove,
 	.driver = {
 		.name = "bcm-sba-raid",
 		.of_match_table = sba_of_match,
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index e1b92b4d7b05..7ba52dee40a9 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -1029,7 +1029,7 @@ static void bcm2835_dma_remove(struct platform_device *pdev)
 
 static struct platform_driver bcm2835_dma_driver = {
 	.probe	= bcm2835_dma_probe,
-	.remove_new = bcm2835_dma_remove,
+	.remove = bcm2835_dma_remove,
 	.driver = {
 		.name = "bcm2835-dma",
 		.of_match_table = of_match_ptr(bcm2835_dma_of_match),
diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
index 0bbaa7620bdd..6c4d655ffe77 100644
--- a/drivers/dma/bestcomm/bestcomm.c
+++ b/drivers/dma/bestcomm/bestcomm.c
@@ -486,7 +486,7 @@ MODULE_DEVICE_TABLE(of, mpc52xx_bcom_of_match);
 
 static struct platform_driver mpc52xx_bcom_of_platform_driver = {
 	.probe		= mpc52xx_bcom_probe,
-	.remove_new	= mpc52xx_bcom_remove,
+	.remove		= mpc52xx_bcom_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = mpc52xx_bcom_of_match,
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index c9cfa341db51..100057603fd4 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1122,7 +1122,7 @@ MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
 
 static struct platform_driver jz4780_dma_driver = {
 	.probe		= jz4780_dma_probe,
-	.remove_new	= jz4780_dma_remove,
+	.remove		= jz4780_dma_remove,
 	.driver	= {
 		.name	= "jz4780-dma",
 		.of_match_table = jz4780_dma_dt_match,
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index fffafa86d964..b23536645ff7 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1676,7 +1676,7 @@ MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
 
 static struct platform_driver dw_driver = {
 	.probe		= dw_probe,
-	.remove_new	= dw_remove,
+	.remove		= dw_remove,
 	.driver = {
 		.name	= KBUILD_MODNAME,
 		.of_match_table = dw_dma_of_id_table,
diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 47c58ad468cb..2606cf9cd429 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -191,7 +191,7 @@ static const struct dev_pm_ops dw_dev_pm_ops = {
 
 static struct platform_driver dw_driver = {
 	.probe		= dw_probe,
-	.remove_new	= dw_remove,
+	.remove		= dw_remove,
 	.shutdown       = dw_shutdown,
 	.driver = {
 		.name	= DRV_NAME,
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index f9f1eda79254..60de1003193a 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -740,7 +740,7 @@ static struct platform_driver fsl_edma_driver = {
 		.pm     = &fsl_edma_pm_ops,
 	},
 	.probe          = fsl_edma_probe,
-	.remove_new	= fsl_edma_remove,
+	.remove		= fsl_edma_remove,
 };
 
 static int __init fsl_edma_init(void)
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 5005e138fc23..823f5c6bc2e1 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1288,7 +1288,7 @@ static struct platform_driver fsl_qdma_driver = {
 		.of_match_table = fsl_qdma_dt_ids,
 	},
 	.probe          = fsl_qdma_probe,
-	.remove_new	= fsl_qdma_remove,
+	.remove		= fsl_qdma_remove,
 };
 
 module_platform_driver(fsl_qdma_driver);
diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 014ff523d5ec..6aa97e258a55 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -886,7 +886,7 @@ static struct platform_driver fsl_re_driver = {
 		.of_match_table = fsl_re_ids,
 	},
 	.probe = fsl_re_probe,
-	.remove_new = fsl_re_remove,
+	.remove = fsl_re_remove,
 };
 
 module_platform_driver(fsl_re_driver);
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 18a6c4bf6275..b5e7d18b9766 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1404,7 +1404,7 @@ static struct platform_driver fsldma_of_driver = {
 #endif
 	},
 	.probe = fsldma_of_probe,
-	.remove_new = fsldma_of_remove,
+	.remove = fsldma_of_remove,
 };
 
 /*----------------------------------------------------------------------------*/
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 3c648308a54a..d147353d47ab 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -693,7 +693,7 @@ static const struct dev_pm_ops idma64_dev_pm_ops = {
 
 static struct platform_driver idma64_platform_driver = {
 	.probe		= idma64_platform_probe,
-	.remove_new	= idma64_platform_remove,
+	.remove		= idma64_platform_remove,
 	.driver = {
 		.name	= LPSS_IDMA64_DRIVER_NAME,
 		.pm	= &idma64_dev_pm_ops,
diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
index 0532dd2640dc..4127c1bdcca7 100644
--- a/drivers/dma/img-mdc-dma.c
+++ b/drivers/dma/img-mdc-dma.c
@@ -1076,7 +1076,7 @@ static struct platform_driver mdc_dma_driver = {
 		.of_match_table = of_match_ptr(mdc_dma_of_match),
 	},
 	.probe = mdc_dma_probe,
-	.remove_new = mdc_dma_remove,
+	.remove = mdc_dma_remove,
 };
 module_platform_driver(mdc_dma_driver);
 
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index e913f0db99da..a651e0995ce8 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -1233,7 +1233,7 @@ static struct platform_driver imxdma_driver = {
 		.name	= "imx-dma",
 		.of_match_table = imx_dma_of_dev_id,
 	},
-	.remove_new	= imxdma_remove,
+	.remove		= imxdma_remove,
 };
 
 static int __init imxdma_module_init(void)
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 72299a08af44..3449006cd14b 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2440,7 +2440,7 @@ static struct platform_driver sdma_driver = {
 		.name	= "imx-sdma",
 		.of_match_table = sdma_dt_ids,
 	},
-	.remove_new	= sdma_remove,
+	.remove		= sdma_remove,
 	.probe		= sdma_probe,
 };
 
diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 5de8c21d41e7..acc2983e28e0 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -1028,7 +1028,7 @@ static struct platform_driver k3_pdma_driver = {
 		.of_match_table = k3_pdma_dt_ids,
 	},
 	.probe		= k3_dma_probe,
-	.remove_new	= k3_dma_remove,
+	.remove		= k3_dma_remove,
 };
 
 module_platform_driver(k3_pdma_driver);
diff --git a/drivers/dma/ls2x-apb-dma.c b/drivers/dma/ls2x-apb-dma.c
index 9652e8666722..2460cf9a44f5 100644
--- a/drivers/dma/ls2x-apb-dma.c
+++ b/drivers/dma/ls2x-apb-dma.c
@@ -692,7 +692,7 @@ MODULE_DEVICE_TABLE(of, ls2x_dma_of_match_table);
 
 static struct platform_driver ls2x_dmac_driver = {
 	.probe		= ls2x_dma_probe,
-	.remove_new	= ls2x_dma_remove,
+	.remove		= ls2x_dma_remove,
 	.driver = {
 		.name	= "ls2x-apbdma",
 		.of_match_table	= ls2x_dma_of_match_table,
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 0c5862bf26f8..9e1c6400c77b 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -267,7 +267,7 @@ static struct platform_driver mcf_edma_driver = {
 		.name	= "mcf-edma",
 	},
 	.probe		= mcf_edma_probe,
-	.remove_new	= mcf_edma_remove,
+	.remove		= mcf_edma_remove,
 };
 
 bool mcf_edma_filter_fn(struct dma_chan *chan, void *param)
diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index b69eabf12a24..d5ddb4e30e71 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -922,7 +922,7 @@ static void mtk_cqdma_remove(struct platform_device *pdev)
 
 static struct platform_driver mtk_cqdma_driver = {
 	.probe = mtk_cqdma_probe,
-	.remove_new = mtk_cqdma_remove,
+	.remove = mtk_cqdma_remove,
 	.driver = {
 		.name           = KBUILD_MODNAME,
 		.of_match_table = mtk_cqdma_match,
diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index 58c7961ab9ad..fa77bb24a430 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -1038,7 +1038,7 @@ static void mtk_hsdma_remove(struct platform_device *pdev)
 
 static struct platform_driver mtk_hsdma_driver = {
 	.probe		= mtk_hsdma_probe,
-	.remove_new	= mtk_hsdma_remove,
+	.remove		= mtk_hsdma_remove,
 	.driver = {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= mtk_hsdma_match,
diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 1bdc1500be40..08e15177427b 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -637,7 +637,7 @@ static const struct dev_pm_ops mtk_uart_apdma_pm_ops = {
 
 static struct platform_driver mtk_uart_apdma_driver = {
 	.probe	= mtk_uart_apdma_probe,
-	.remove_new = mtk_uart_apdma_remove,
+	.remove = mtk_uart_apdma_remove,
 	.driver = {
 		.name		= KBUILD_MODNAME,
 		.pm		= &mtk_uart_apdma_pm_ops,
diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
index 7b41c670970a..9a5ec247ed6d 100644
--- a/drivers/dma/milbeaut-hdmac.c
+++ b/drivers/dma/milbeaut-hdmac.c
@@ -571,7 +571,7 @@ MODULE_DEVICE_TABLE(of, milbeaut_hdmac_match);
 
 static struct platform_driver milbeaut_hdmac_driver = {
 	.probe = milbeaut_hdmac_probe,
-	.remove_new = milbeaut_hdmac_remove,
+	.remove = milbeaut_hdmac_remove,
 	.driver = {
 		.name = "milbeaut-m10v-hdmac",
 		.of_match_table = milbeaut_hdmac_match,
diff --git a/drivers/dma/milbeaut-xdmac.c b/drivers/dma/milbeaut-xdmac.c
index 2cce529b448e..58d4fd6df0bf 100644
--- a/drivers/dma/milbeaut-xdmac.c
+++ b/drivers/dma/milbeaut-xdmac.c
@@ -409,7 +409,7 @@ MODULE_DEVICE_TABLE(of, milbeaut_xdmac_match);
 
 static struct platform_driver milbeaut_xdmac_driver = {
 	.probe = milbeaut_xdmac_probe,
-	.remove_new = milbeaut_xdmac_remove,
+	.remove = milbeaut_xdmac_remove,
 	.driver = {
 		.name = "milbeaut-m10v-xdmac",
 		.of_match_table = milbeaut_xdmac_match,
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 136fcaeff8dd..a95d31103d30 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1137,7 +1137,7 @@ static struct platform_driver mmp_pdma_driver = {
 	},
 	.id_table	= mmp_pdma_id_table,
 	.probe		= mmp_pdma_probe,
-	.remove_new	= mmp_pdma_remove,
+	.remove		= mmp_pdma_remove,
 };
 
 module_platform_driver(mmp_pdma_driver);
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index b76fe99e1151..c8dc504510f1 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -736,7 +736,7 @@ static struct platform_driver mmp_tdma_driver = {
 		.of_match_table = mmp_tdma_dt_ids,
 	},
 	.probe		= mmp_tdma_probe,
-	.remove_new	= mmp_tdma_remove,
+	.remove		= mmp_tdma_remove,
 };
 
 module_platform_driver(mmp_tdma_driver);
diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 66dc6d31b603..de09e1ab7767 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -644,7 +644,7 @@ MODULE_DEVICE_TABLE(of, moxart_dma_match);
 
 static struct platform_driver moxart_driver = {
 	.probe	= moxart_probe,
-	.remove_new = moxart_remove,
+	.remove = moxart_remove,
 	.driver = {
 		.name		= "moxart-dma-engine",
 		.of_match_table	= moxart_dma_match,
diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index 68c247a46321..bf131cb5db66 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -1110,7 +1110,7 @@ MODULE_DEVICE_TABLE(of, mpc_dma_match);
 
 static struct platform_driver mpc_dma_driver = {
 	.probe		= mpc_dma_probe,
-	.remove_new	= mpc_dma_remove,
+	.remove		= mpc_dma_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table	= mpc_dma_match,
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index c8c67f4d982c..d908143c7731 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -884,7 +884,7 @@ static struct platform_driver mv_xor_v2_driver = {
 	.probe		= mv_xor_v2_probe,
 	.suspend	= mv_xor_v2_suspend,
 	.resume		= mv_xor_v2_resume,
-	.remove_new	= mv_xor_v2_remove,
+	.remove		= mv_xor_v2_remove,
 	.driver		= {
 		.name	= "mv_xor_v2",
 		.of_match_table = of_match_ptr(mv_xor_v2_dt_ids),
diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 3b011a91d48e..0d6324c4e2be 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1515,7 +1515,7 @@ static struct platform_driver nbpf_driver = {
 	},
 	.id_table = nbpf_ids,
 	.probe = nbpf_probe,
-	.remove_new = nbpf_remove,
+	.remove = nbpf_remove,
 };
 
 module_platform_driver(nbpf_driver);
diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index aa436f9e3571..57cec757d8f5 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1252,7 +1252,7 @@ static void owl_dma_remove(struct platform_device *pdev)
 
 static struct platform_driver owl_dma_driver = {
 	.probe	= owl_dma_probe,
-	.remove_new = owl_dma_remove,
+	.remove = owl_dma_remove,
 	.driver = {
 		.name = "dma-owl",
 		.of_match_table = of_match_ptr(owl_dma_match),
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 7b78759ac734..9d2a5a967a99 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4549,7 +4549,7 @@ MODULE_DEVICE_TABLE(of, ppc440spe_adma_of_match);
 
 static struct platform_driver ppc440spe_adma_driver = {
 	.probe = ppc440spe_adma_probe,
-	.remove_new = ppc440spe_adma_remove,
+	.remove = ppc440spe_adma_remove,
 	.driver = {
 		.name = "PPC440SP(E)-ADMA",
 		.of_match_table = ppc440spe_adma_of_match,
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 31f8da810c05..e50cf3357e5e 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -1442,7 +1442,7 @@ static struct platform_driver pxad_driver = {
 	},
 	.id_table	= pxad_id_table,
 	.probe		= pxad_probe,
-	.remove_new	= pxad_remove,
+	.remove		= pxad_remove,
 };
 
 static bool pxad_filter_fn(struct dma_chan *chan, void *param)
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d43a881e43b9..bbc3276992bb 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1469,7 +1469,7 @@ static const struct dev_pm_ops bam_dma_pm_ops = {
 
 static struct platform_driver bam_dma_driver = {
 	.probe = bam_dma_probe,
-	.remove_new = bam_dma_remove,
+	.remove = bam_dma_remove,
 	.driver = {
 		.name = "bam-dma-engine",
 		.pm = &bam_dma_pm_ops,
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 4d2cd8d9ec74..c2b3e4452e71 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -948,7 +948,7 @@ MODULE_DEVICE_TABLE(acpi, hidma_acpi_ids);
 
 static struct platform_driver hidma_driver = {
 	.probe = hidma_probe,
-	.remove_new = hidma_remove,
+	.remove = hidma_remove,
 	.shutdown = hidma_shutdown,
 	.driver = {
 		   .name = "hidma",
diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
index c1db398adc84..6be54fddcee1 100644
--- a/drivers/dma/qcom/qcom_adm.c
+++ b/drivers/dma/qcom/qcom_adm.c
@@ -937,7 +937,7 @@ MODULE_DEVICE_TABLE(of, adm_of_match);
 
 static struct platform_driver adm_dma_driver = {
 	.probe = adm_dma_probe,
-	.remove_new = adm_dma_remove,
+	.remove = adm_dma_remove,
 	.driver = {
 		.name = "adm-dma-engine",
 		.of_match_table = adm_of_match,
diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index 01e656c69e6c..dc1a9a05252e 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -1079,7 +1079,7 @@ static struct platform_driver sa11x0_dma_driver = {
 		.pm	= &sa11x0_dma_pm_ops,
 	},
 	.probe		= sa11x0_dma_probe,
-	.remove_new	= sa11x0_dma_remove,
+	.remove		= sa11x0_dma_remove,
 };
 
 static int __init sa11x0_dma_init(void)
diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 428473611115..15b1f4baf357 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -633,7 +633,7 @@ MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
 
 static struct platform_driver sf_pdma_driver = {
 	.probe		= sf_pdma_probe,
-	.remove_new	= sf_pdma_remove,
+	.remove		= sf_pdma_remove,
 	.driver		= {
 		.name	= "sf-pdma",
 		.of_match_table = sf_pdma_dt_ids,
diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 1094a2f82164..2679c1f09faf 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -2037,7 +2037,7 @@ static struct platform_driver rcar_dmac_driver = {
 		.of_match_table = rcar_dmac_of_ids,
 	},
 	.probe		= rcar_dmac_probe,
-	.remove_new	= rcar_dmac_remove,
+	.remove		= rcar_dmac_remove,
 	.shutdown	= rcar_dmac_shutdown,
 };
 
diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 65a27c5a7bce..8303765e3b6e 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -1001,7 +1001,7 @@ static struct platform_driver rz_dmac_driver = {
 		.of_match_table = of_rz_dmac_match,
 	},
 	.probe		= rz_dmac_probe,
-	.remove_new	= rz_dmac_remove,
+	.remove		= rz_dmac_remove,
 };
 
 module_platform_driver(rz_dmac_driver);
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 8ead0a1fd237..093e449e19ee 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -906,7 +906,7 @@ static struct platform_driver sh_dmae_driver = {
 		.pm	= &sh_dmae_pm,
 		.name	= SH_DMAE_DRV_NAME,
 	},
-	.remove_new	= sh_dmae_remove,
+	.remove		= sh_dmae_remove,
 };
 
 static int __init sh_dmae_init(void)
diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index f7cd0cad056c..b2081a6126e6 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -899,7 +899,7 @@ static struct platform_driver usb_dmac_driver = {
 		.of_match_table = usb_dmac_of_ids,
 	},
 	.probe		= usb_dmac_probe,
-	.remove_new	= usb_dmac_remove,
+	.remove		= usb_dmac_remove,
 	.shutdown	= usb_dmac_shutdown,
 };
 
diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 3f54ff37c5e0..187a090463ce 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1298,7 +1298,7 @@ static const struct dev_pm_ops sprd_dma_pm_ops = {
 
 static struct platform_driver sprd_dma_driver = {
 	.probe = sprd_dma_probe,
-	.remove_new = sprd_dma_remove,
+	.remove = sprd_dma_remove,
 	.driver = {
 		.name = "sprd-dma",
 		.of_match_table = sprd_dma_match,
diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index 8880b5e336f8..c65ee0c7bfbd 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -858,7 +858,7 @@ static struct platform_driver st_fdma_platform_driver = {
 		.of_match_table = st_fdma_match,
 	},
 	.probe = st_fdma_probe,
-	.remove_new = st_fdma_remove,
+	.remove = st_fdma_remove,
 };
 module_platform_driver(st_fdma_platform_driver);
 
diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 0be6e944df6f..b9470f783f98 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1827,7 +1827,7 @@ static const struct dev_pm_ops stm32_dma3_pm_ops = {
 
 static struct platform_driver stm32_dma3_driver = {
 	.probe = stm32_dma3_probe,
-	.remove_new = stm32_dma3_remove,
+	.remove = stm32_dma3_remove,
 	.driver = {
 		.name = "stm32-dma3",
 		.of_match_table = stm32_dma3_of_match,
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 2e7f9b07fdd2..f37cdf6f2179 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1292,7 +1292,7 @@ MODULE_DEVICE_TABLE(of, sun4i_dma_match);
 
 static struct platform_driver sun4i_dma_driver = {
 	.probe	= sun4i_dma_probe,
-	.remove_new = sun4i_dma_remove,
+	.remove = sun4i_dma_remove,
 	.driver	= {
 		.name		= "sun4i-dma",
 		.of_match_table	= sun4i_dma_match,
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 583bf49031cf..95ecb12caaa5 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1488,7 +1488,7 @@ static void sun6i_dma_remove(struct platform_device *pdev)
 
 static struct platform_driver sun6i_dma_driver = {
 	.probe		= sun6i_dma_probe,
-	.remove_new	= sun6i_dma_remove,
+	.remove		= sun6i_dma_remove,
 	.driver = {
 		.name		= "sun6i-dma",
 		.of_match_table	= sun6i_dma_match,
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 3642508e88bb..cacf3757adc2 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1532,7 +1532,7 @@ static struct platform_driver tegra_dma_driver = {
 		.of_match_table = tegra_dma_of_match,
 	},
 	.probe		= tegra_dma_probe,
-	.remove_new	= tegra_dma_remove,
+	.remove		= tegra_dma_remove,
 };
 
 module_platform_driver(tegra_dma_driver);
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 7d1acda2d72b..14a61e53a41b 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1675,7 +1675,7 @@ static struct platform_driver tegra_dmac_driver = {
 		.of_match_table = tegra_dma_of_match,
 	},
 	.probe		= tegra_dma_probe,
-	.remove_new	= tegra_dma_remove,
+	.remove		= tegra_dma_remove,
 };
 
 module_platform_driver(tegra_dmac_driver);
diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 24ad7077c53b..2953008d42ef 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -1008,7 +1008,7 @@ static struct platform_driver tegra_admac_driver = {
 		.of_match_table = tegra_adma_of_match,
 	},
 	.probe		= tegra_adma_probe,
-	.remove_new	= tegra_adma_remove,
+	.remove		= tegra_adma_remove,
 };
 
 module_platform_driver(tegra_admac_driver);
diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
index a8bb70c2d109..8d8c3d6038fc 100644
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -1243,7 +1243,7 @@ static const struct dev_pm_ops cppi41_pm_ops = {
 
 static struct platform_driver cpp41_dma_driver = {
 	.probe  = cppi41_dma_probe,
-	.remove_new = cppi41_dma_remove,
+	.remove = cppi41_dma_remove,
 	.driver = {
 		.name = "cppi41-dma-engine",
 		.pm = &cppi41_pm_ops,
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 5f8d2e93ff3f..343e986e66e7 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2636,7 +2636,7 @@ static const struct dev_pm_ops edma_pm_ops = {
 
 static struct platform_driver edma_driver = {
 	.probe		= edma_probe,
-	.remove_new	= edma_remove,
+	.remove		= edma_remove,
 	.driver = {
 		.name	= "edma",
 		.pm	= &edma_pm_ops,
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 6ab9bfbdc480..8c023c6e623a 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1915,7 +1915,7 @@ MODULE_DEVICE_TABLE(of, omap_dma_match);
 
 static struct platform_driver omap_dma_driver = {
 	.probe	= omap_dma_probe,
-	.remove_new = omap_dma_remove,
+	.remove = omap_dma_remove,
 	.driver = {
 		.name = "omap-dma-engine",
 		.of_match_table = omap_dma_match,
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 7410025605e0..ecaf002558af 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -761,7 +761,7 @@ static struct platform_driver td_driver = {
 		.name	= DRIVER_NAME,
 	},
 	.probe	= td_probe,
-	.remove_new = td_remove,
+	.remove = td_remove,
 };
 
 module_platform_driver(td_driver);
diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 44ba377b4b5a..35d5221683b2 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -1260,14 +1260,14 @@ static const struct dev_pm_ops txx9dmac_dev_pm_ops = {
 };
 
 static struct platform_driver txx9dmac_chan_driver = {
-	.remove_new	= txx9dmac_chan_remove,
+	.remove		= txx9dmac_chan_remove,
 	.driver = {
 		.name	= "txx9dmac-chan",
 	},
 };
 
 static struct platform_driver txx9dmac_driver = {
-	.remove_new	= txx9dmac_remove,
+	.remove		= txx9dmac_remove,
 	.shutdown	= txx9dmac_shutdown,
 	.driver = {
 		.name	= "txx9dmac",
diff --git a/drivers/dma/uniphier-mdmac.c b/drivers/dma/uniphier-mdmac.c
index ad7125f6e2ca..7a99f86ecb5a 100644
--- a/drivers/dma/uniphier-mdmac.c
+++ b/drivers/dma/uniphier-mdmac.c
@@ -493,7 +493,7 @@ MODULE_DEVICE_TABLE(of, uniphier_mdmac_match);
 
 static struct platform_driver uniphier_mdmac_driver = {
 	.probe = uniphier_mdmac_probe,
-	.remove_new = uniphier_mdmac_remove,
+	.remove = uniphier_mdmac_remove,
 	.driver = {
 		.name = "uniphier-mio-dmac",
 		.of_match_table = uniphier_mdmac_match,
diff --git a/drivers/dma/uniphier-xdmac.c b/drivers/dma/uniphier-xdmac.c
index 3ce2dc2ad9de..ceeb6171c9d1 100644
--- a/drivers/dma/uniphier-xdmac.c
+++ b/drivers/dma/uniphier-xdmac.c
@@ -603,7 +603,7 @@ MODULE_DEVICE_TABLE(of, uniphier_xdmac_match);
 
 static struct platform_driver uniphier_xdmac_driver = {
 	.probe = uniphier_xdmac_probe,
-	.remove_new = uniphier_xdmac_remove,
+	.remove = uniphier_xdmac_remove,
 	.driver = {
 		.name = "uniphier-xdmac",
 		.of_match_table = uniphier_xdmac_match,
diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 275848a9c450..f64624ea44ad 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -1815,7 +1815,7 @@ MODULE_DEVICE_TABLE(of, xgene_dma_of_match_ptr);
 
 static struct platform_driver xgene_dma_driver = {
 	.probe = xgene_dma_probe,
-	.remove_new = xgene_dma_remove,
+	.remove = xgene_dma_remove,
 	.driver = {
 		.name = "X-Gene-DMA",
 		.of_match_table = xgene_dma_of_match_ptr,
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 718842fdaf98..93772abc3b49 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -1315,7 +1315,7 @@ static struct platform_driver xdma_driver = {
 	},
 	.id_table	= xdma_id_table,
 	.probe		= xdma_probe,
-	.remove_new	= xdma_remove,
+	.remove		= xdma_remove,
 };
 
 module_platform_driver(xdma_driver);
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 5eb51ae93e89..1bdd57de87a6 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3271,7 +3271,7 @@ static struct platform_driver xilinx_vdma_driver = {
 		.of_match_table = xilinx_dma_of_ids,
 	},
 	.probe = xilinx_dma_probe,
-	.remove_new = xilinx_dma_remove,
+	.remove = xilinx_dma_remove,
 };
 
 module_platform_driver(xilinx_vdma_driver);
diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index be87764af9e8..ee5d9fdbfd7f 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1863,7 +1863,7 @@ MODULE_DEVICE_TABLE(of, xilinx_dpdma_of_match);
 
 static struct platform_driver xilinx_dpdma_driver = {
 	.probe			= xilinx_dpdma_probe,
-	.remove_new		= xilinx_dpdma_remove,
+	.remove			= xilinx_dpdma_remove,
 	.driver			= {
 		.name		= "xilinx-zynqmp-dpdma",
 		.of_match_table	= xilinx_dpdma_of_match,
diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 9ae46f1198fe..3156eff5deb0 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1192,7 +1192,7 @@ static struct platform_driver zynqmp_dma_driver = {
 		.pm = &zynqmp_dma_dev_pm_ops,
 	},
 	.probe = zynqmp_dma_probe,
-	.remove_new = zynqmp_dma_remove,
+	.remove = zynqmp_dma_remove,
 };
 
 module_platform_driver(zynqmp_dma_driver);

base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
-- 
2.45.2


