Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB545009D
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 09:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhKOI66 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 03:58:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhKOI6k (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 03:58:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2223663223;
        Mon, 15 Nov 2021 08:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636966545;
        bh=dcMQMZncG8IjNijKZNej/gmwTiTYDPeCFK23hEXOfto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYuJvxO5lVR/GiGcXXlpTenpQL8tS/RiB2q/z0CMEjbvV3OtExgDGliJ9mPslll9Z
         gJF9jW4NvrAMcYVtan/DOPn491D5evV0DjVoLO4PKbj3djKSiupC9gs/o/JDRousmF
         VfKHtJYY+yuBV0OABHqDiHSUkpE6qGp8SFfe7NSJEmA0l/mxODuVE3wHHx7vsA5sov
         Wa36nu6IAmzkpbTK/7+6RaXeDPwWYCIT8QDeBGczguXuJlI760X3i1oAk8E/g82B3L
         MDBneNRRk20n1rSG1Z9mUgJiWRhrqnptEhFZTTbLf+wXfy+4WmVGvjS1fVUD20TPas
         ktKoOqahs6Lsg==
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
Subject: [PATCH 09/11] dmaengine: tegra20-apb: stop checking config->slave_id
Date:   Mon, 15 Nov 2021 09:54:01 +0100
Message-Id: <20211115085403.360194-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211115085403.360194-1-arnd@kernel.org>
References: <20211115085403.360194-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Nothing sets the slave_id field any more, so stop accessing
it to allow the removal of this field.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/tegra20-apb-dma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index b7260749e8ee..eaafcbe4ca94 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -343,12 +343,6 @@ static int tegra_dma_slave_config(struct dma_chan *dc,
 	}
 
 	memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig));
-	if (tdc->slave_id == TEGRA_APBDMA_SLAVE_ID_INVALID &&
-	    sconfig->device_fc) {
-		if (sconfig->slave_id > TEGRA_APBDMA_CSR_REQ_SEL_MASK)
-			return -EINVAL;
-		tdc->slave_id = sconfig->slave_id;
-	}
 	tdc->config_init = true;
 
 	return 0;
-- 
2.30.2

