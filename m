Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89315450073
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 09:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhKOI6o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 03:58:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhKOI6H (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 03:58:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A02B96322E;
        Mon, 15 Nov 2021 08:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636966512;
        bh=0aNffjFyOwM4u0Oo7aAQAYOuioDBDQQgvS3dt9nDAoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAj0mIyHUENlkP6yrlZxkqYSD5hocgglcT83E2dvJW5vsfypS+bCmhcsFYUNOkxLb
         VGm36iEtIrx5MsVBXb22F/vG+l2XPNfSwWhLmNnpXY2YEg1WtV9h7uDQ4GwxtuNv9L
         drDvkpdeYSJiDY3sEkXjDYk0eXhjJUhkOOej7yEfUcc6kxARiOwLRZ91ApCbkZq51a
         1DlM4aygC8K+7tMPsuyHuPXgtlhUMsrKFmzWe5QnTopYr5GRXxpXJp9kRg4sUJG2px
         7btIXMzPZaupxro9KeNOsc8eN7Q4CrodjLRdG9uMjUnyKFs+UCAV79ctDov27Vvgoc
         1WIStRJ1SW5ww==
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
Subject: [PATCH 04/11] dmaengine: shdma: remove legacy slave_id parsing
Date:   Mon, 15 Nov 2021 09:53:56 +0100
Message-Id: <20211115085403.360194-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211115085403.360194-1-arnd@kernel.org>
References: <20211115085403.360194-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The slave device is picked through either devicetree or a filter
function, and any remaining out-of-tree drivers would have warned
about this usage since 2015.

Stop interpreting the field finally so it can be removed from
the interface.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/sh/shdma-base.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 7f72b3f4cd1a..41c6bc650fa3 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -786,14 +786,6 @@ static int shdma_config(struct dma_chan *chan,
 	if (!config)
 		return -EINVAL;
 
-	/*
-	 * overriding the slave_id through dma_slave_config is deprecated,
-	 * but possibly some out-of-tree drivers still do it.
-	 */
-	if (WARN_ON_ONCE(config->slave_id &&
-			 config->slave_id != schan->real_slave_id))
-		schan->real_slave_id = config->slave_id;
-
 	/*
 	 * We could lock this, but you shouldn't be configuring the
 	 * channel, while using it...
-- 
2.30.2

