Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3203A608034
	for <lists+dmaengine@lfdr.de>; Fri, 21 Oct 2022 22:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJUUt3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Oct 2022 16:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiJUUt1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Oct 2022 16:49:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB15AE69;
        Fri, 21 Oct 2022 13:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 416F5B80C82;
        Fri, 21 Oct 2022 20:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5585C433D6;
        Fri, 21 Oct 2022 20:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385358;
        bh=2Okf1FijBUJK3YZp+HRPTMDG+UXMWUkWoGbJGvqhrQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lt6ZttgTUiRYMZKsWwgpq0g2S8vUuZqVE1LWJJRyjBsgzjIgcREi4n8/UhprwIgNM
         FdfU91vTOHqBmqLLIV27y5WRggFBx8pQpgoYiE5y1WPsHAm/iOloFj6aLccOwPXn/m
         RsIQcLS0fp1JL06nm0FpoX4PKk5iRDYWCnXWyAhcLuJq1YqpHdmvcLQlylsqX/Mu5m
         QDBOolSSO1idWzPDfeCplYPddUYR6wTVru9513k8eEBOWTiSVqf3MDMPaZUKA6UVfH
         KdLdUVy/v/oXTSepWMYL7oQOtRFnck1kv/yS0orJ69bqRvszMuZpkzHKuUn2UI4zSR
         uixOig0hJZwbA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        dmaengine@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 14/21] dmaengine: remove s3c24xx driver
Date:   Fri, 21 Oct 2022 22:27:47 +0200
Message-Id: <20221021203329.4143397-14-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The s3c24xx platform was removed and this driver is no longer
needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/Kconfig                       |   12 -
 drivers/dma/Makefile                      |    1 -
 drivers/dma/s3c24xx-dma.c                 | 1428 ---------------------
 include/linux/platform_data/dma-s3c24xx.h |   48 -
 4 files changed, 1489 deletions(-)
 delete mode 100644 drivers/dma/s3c24xx-dma.c
 delete mode 100644 include/linux/platform_data/dma-s3c24xx.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index b73fc89ba877..ea81d825575f 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -609,18 +609,6 @@ config SPRD_DMA
 	help
 	  Enable support for the on-chip DMA controller on Spreadtrum platform.
 
-config S3C24XX_DMAC
-	bool "Samsung S3C24XX DMA support"
-	depends on ARCH_S3C24XX || COMPILE_TEST
-	select DMA_ENGINE
-	select DMA_VIRTUAL_CHANNELS
-	help
-	  Support for the Samsung S3C24XX DMA controller driver. The
-	  DMA controller is having multiple DMA channels which can be
-	  configured for different peripherals like audio, UART, SPI.
-	  The DMA controller can transfer data from memory to peripheral,
-	  periphal to memory, periphal to periphal and memory to memory.
-
 config TXX9_DMAC
 	tristate "Toshiba TXx9 SoC DMA support"
 	depends on MACH_TX49XX
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 5b55ada052a7..a4fd1ce29510 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -70,7 +70,6 @@ obj-$(CONFIG_STM32_DMA) += stm32-dma.o
 obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
 obj-$(CONFIG_STM32_MDMA) += stm32-mdma.o
 obj-$(CONFIG_SPRD_DMA) += sprd-dma.o
-obj-$(CONFIG_S3C24XX_DMAC) += s3c24xx-dma.o
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
 obj-$(CONFIG_TEGRA186_GPC_DMA) += tegra186-gpc-dma.o
 obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
deleted file mode 100644
index a09eeb545f7d..000000000000
diff --git a/include/linux/platform_data/dma-s3c24xx.h b/include/linux/platform_data/dma-s3c24xx.h
deleted file mode 100644
index 96d02dbeea67..000000000000
-- 
2.29.2

