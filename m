Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82CB1A2A0C
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2020 22:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgDHUFW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Apr 2020 16:05:22 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgDHUFW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Apr 2020 16:05:22 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MsZeX-1j2Oa03Ce3-00u5hu; Wed, 08 Apr 2020 22:05:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH] dmaengine: tegra: fix broken 'select' statement
Date:   Wed,  8 Apr 2020 22:04:34 +0200
Message-Id: <20200408200504.4067970-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rb4meZQ9gh+WxIAIB/PYG2cBGipxSGWIGaVMSUR6w7zivwbZ+Te
 cPcPvkTLWMR9o18FI4oftrbK36zyApCrskApgcdy3m3GN3Gt8PjPLlbvxPJlfFtqbraKuTD
 jdPQWzFP50iRl/39rh91mQXABCCtfYUzrpwsRgw5n+gUZbf5iVC+5v9gnNyGLZC5KtGEFBM
 QKdVV8awfWDPb7TFUk4HA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6eCKGBr90C0=:maw1nI0oiVkP1WEH6mxblu
 YXG0XHKMLd51TAzeHW2568hvsL9ZvXhOGmVw2YjU1jVDjWuPlzHsvTdOaGlxUzK1DUZcRdKVp
 v4pI+sFLpU+8g0LnnI7afZbiejGneXpVLPMBpoJs9w3kIzdki4tLOLeOgZ4v9EgHOxY9foYxO
 9FKLwKLYGpQbIfv8i6seSJRNfTOojDy0/QdPaqLG30EuXE0l56y68o+Sv0lnyBFbD4j5212sz
 UxhNzE8CsYrpTwXK2XUu0ZGrpEUj7liio0esy+xpKgzsjOg0J3qsE/sNKfRWRFoEAGovIXzgo
 PHbt47QTb8oN9RxfFHw48qKgUmNUnbuWU1oAvekmM/TLbiAnsPXNGVrnGO38VPYIJX+IfNjOu
 RKi1U5QbKWjx0KkyU5W8wMQV20R6XJqffDH+siVPNiqvvK0c7roufNic3eJpZK8JmAwToRhpS
 K4VeuHMxAJ7qTOkY880l1+9di94xjc+TkTjSTDF/jQrX1A1I2+NAiiyIpWo8c+aY9tynhz5Yc
 0bR/nPNzJC2/XDvTa+LiErLP0ybLHUr1jCDOufmBqtJvgCwplaUD20kLG3MMH3P+wrYWZiZIx
 ZhVCc0AT7v8SooAXNxI0iDsM5paf1E59TRcFIOgvJs6MTaixnFr1gXKiA4BAsZ3rTmp/xwSqs
 1NjDIuiQcxctkcVxObse7zHGaihJwnqBqvWOu02w0LfUVA3jAOgMIbnyQYXFc+kHATmVp+5FX
 aeYHUUYDFKdxmfn8Hsod9xUR71uZi2rbHbLPRO3Zxa6fU6Cv56x06/wjPl24PktxPaMbO9YPv
 H90OEjKchI9ZBCW2OdDz6Ewa0HdgrcYasyh4nwD8fqO05hEq3k=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

A SoC driver selects the dmaengine driver for the platform it
is made for, leading to Kconfig warnings in some configurations:

WARNING: unmet direct dependencies detected for TEGRA20_APB_DMA
  Depends on [n]: DMADEVICES [=n] && (ARCH_TEGRA [=y] || COMPILE_TEST [=y])
  Selected by [y]:
  - SOC_TEGRA_FUSE [=y] && ARCH_TEGRA [=y] && ARCH_TEGRA_2x_SOC [=y]

WARNING: unmet direct dependencies detected for TEGRA20_APB_DMA
  Depends on [n]: DMADEVICES [=n] && (ARCH_TEGRA [=y] || COMPILE_TEST [=y])
  Selected by [y]:
  - SOC_TEGRA_FUSE [=y] && ARCH_TEGRA [=y] && ARCH_TEGRA_2x_SOC [=y]

Generally, no driver should 'select' a driver from a different subsystem,
especially when there is no build-time dependency between the two.

Remove the bogus 'select' and instead change the dmaengine driver to
be default-enabled in this configuration, to let existing defconfig
files continue working.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/Kconfig       | 1 +
 drivers/soc/tegra/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 023db6883d05..c19e25b140c5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -619,6 +619,7 @@ config TXX9_DMAC
 config TEGRA20_APB_DMA
 	tristate "NVIDIA Tegra20 APB DMA support"
 	depends on ARCH_TEGRA || COMPILE_TEST
+	default SOC_TEGRA_FUSE && ARCH_TEGRA_2x_SOC
 	select DMA_ENGINE
 	help
 	  Support for the NVIDIA Tegra20 APB DMA controller driver. The
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 3693532949b8..84bd615c4a92 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -126,7 +126,6 @@ config SOC_TEGRA_FUSE
 	def_bool y
 	depends on ARCH_TEGRA
 	select SOC_BUS
-	select TEGRA20_APB_DMA if ARCH_TEGRA_2x_SOC
 
 config SOC_TEGRA_FLOWCTRL
 	bool
-- 
2.26.0

