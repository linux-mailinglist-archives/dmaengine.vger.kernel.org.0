Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79FD450064
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 09:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhKOI6A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 03:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230149AbhKOI5y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 03:57:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9224463222;
        Mon, 15 Nov 2021 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636966499;
        bh=SSVFq8V5QgZ8AMrKjuNifJwPRFV2bwVTfXVHbqPj2aU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWPlOAoNVZ+ir7KGxrildoWGM1mQnaf7ewCJRGxAlh7sp55Kq08VXBsh2HJq0UNxl
         eJrtqrhd9f07DrNoIIYQxXcw0Dj7MyBMWvAjpLeDa0bPZnGyAXGf8Nn/iif0W7tUNF
         aASGKwu2D0mv1fB6bh3667PFZmstR+abS6MkboFwlFENPAACABf6i0vQqciiacp6D+
         CIa/shXrYU7IuqNvw2zRLT7DL94AW8AmV/eR1AVEhs5f+SoYebk81ievQQ/PH1ufo+
         sAfTJSFcuSqXozuveEFZbfN7PIQy3f0IbF7les+K9TRndRM/0BhX+9Zl6TK4QdhdOX
         HbQ0zPRM57fFg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: [PATCH 02/11] spi: pic32: stop setting dma_config->slave_id
Date:   Mon, 15 Nov 2021 09:53:54 +0100
Message-Id: <20211115085403.360194-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211115085403.360194-1-arnd@kernel.org>
References: <20211115085403.360194-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Setting slave_id makes no sense with DT based probing, and
should eventually get removed entirely. Address this driver
by no longer setting the field here.

I could not find which DMA driver is used on PIC32, if it's
in the tree at all, but none of the obvious ones even care
about slave_id any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-pic32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 5eb7b61bbb4d..f86433b29260 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -370,7 +370,6 @@ static int pic32_spi_dma_config(struct pic32_spi *pic32s, u32 dma_width)
 	cfg.src_addr_width = dma_width;
 	cfg.dst_addr_width = dma_width;
 	/* tx channel */
-	cfg.slave_id = pic32s->tx_irq;
 	cfg.direction = DMA_MEM_TO_DEV;
 	ret = dmaengine_slave_config(master->dma_tx, &cfg);
 	if (ret) {
@@ -378,7 +377,6 @@ static int pic32_spi_dma_config(struct pic32_spi *pic32s, u32 dma_width)
 		return ret;
 	}
 	/* rx channel */
-	cfg.slave_id = pic32s->rx_irq;
 	cfg.direction = DMA_DEV_TO_MEM;
 	ret = dmaengine_slave_config(master->dma_rx, &cfg);
 	if (ret)
-- 
2.30.2

