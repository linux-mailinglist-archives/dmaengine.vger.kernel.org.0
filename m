Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17833450072
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 09:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhKOI6m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 03:58:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231600AbhKOI6B (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 03:58:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C1DE63227;
        Mon, 15 Nov 2021 08:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636966506;
        bh=6T6nVYUZYeuHx0KVvy6d2aAfM4hqSW/xkD9UxCrEiew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XE1rkoS26Hg1qVOUe/8JhihPWyqzwdxtSu6KpZSliRxpkj1mrD33TUzc4f3D7Z563
         QLiO1buUzxFjE4Smwu3DKTXQuDLm+gytZAgIqSOnAvyzoAXeDNMVaxRSz5FfYVxdzx
         fxlDZ6etPDPs4+Tui9Els9qLGXd+sLiGd5gsTfkJ6/smITicktBYHNkHB4AAvmw0pc
         NRLtSgumom3wapnQ8lOIVnzIUsTm+82JiaSwVIuKcuOx5tpNurM5w5orGkJkyh4UkT
         ImBiCpR78cdAYk6E0uXXpxENctgamiDTvLJByR5cyn6kcnDn0EUp+6TdkBa4HYzUNn
         uP4cknrvguDtA==
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
Subject: [PATCH 03/11] mmc: bcm2835: stop setting chan_config->slave_id
Date:   Mon, 15 Nov 2021 09:53:55 +0100
Message-Id: <20211115085403.360194-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211115085403.360194-1-arnd@kernel.org>
References: <20211115085403.360194-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The field is not interpreted by the DMA engine driver, as all the data
is passed from devicetree instead. Remove the assignment so the field
can eventually be deleted.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/bcm2835.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 8c2361e66277..463b707d9e99 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1293,14 +1293,12 @@ static int bcm2835_add_host(struct bcm2835_host *host)
 
 		host->dma_cfg_tx.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		host->dma_cfg_tx.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		host->dma_cfg_tx.slave_id = 13;		/* DREQ channel */
 		host->dma_cfg_tx.direction = DMA_MEM_TO_DEV;
 		host->dma_cfg_tx.src_addr = 0;
 		host->dma_cfg_tx.dst_addr = host->phys_addr + SDDATA;
 
 		host->dma_cfg_rx.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		host->dma_cfg_rx.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		host->dma_cfg_rx.slave_id = 13;		/* DREQ channel */
 		host->dma_cfg_rx.direction = DMA_DEV_TO_MEM;
 		host->dma_cfg_rx.src_addr = host->phys_addr + SDDATA;
 		host->dma_cfg_rx.dst_addr = 0;
-- 
2.30.2

