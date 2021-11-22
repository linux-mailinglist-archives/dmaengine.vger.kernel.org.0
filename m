Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B2D459774
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 23:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbhKVW0S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 17:26:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239236AbhKVW0M (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 17:26:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20BEB61028;
        Mon, 22 Nov 2021 22:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637619785;
        bh=d7m5O4/1nyBGt5Kh33p+oJ8bVHRAS2FfC8Aq7HlukD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9vM5QRuk8fadP59ElpA3ffYUxfRVicrLxNOTf6e03SjGI2V3nsfn8cy3no76jRy2
         RDW8l+sIUSCY6gvdbzO4wQ2AAfKEwEssXaTOKLN8mBgW2oC6rbb8Grgm3zn26NcITl
         4hcTr9aLhkFY3SCxz7WQc70Ko9Jp/B6+EVRTt4cSjOhtxz6FOGr83EAYftKEZg7yZT
         GnYh/33xI6Gx+eRxpaESCR5LoWgmya5WHI/acve3Woxr1X/fjCQRjNzrWaWmJ3p2s3
         Ok01FBgGD/IQQP5RVu8NbnuhF5Z+l0bB0OYW66oZ0UUqp0zstTqsn5/tPu0/YQMz8f
         LRNC3XKm0SL3w==
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
Subject: [PATCH v2 05/11] dmaengine: shdma: remove legacy slave_id parsing
Date:   Mon, 22 Nov 2021 23:21:57 +0100
Message-Id: <20211122222203.4103644-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122222203.4103644-1-arnd@kernel.org>
References: <20211122222203.4103644-1-arnd@kernel.org>
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

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
2.29.2

