Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C894500AA
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 09:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbhKOJBL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 04:01:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236344AbhKOI6x (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 03:58:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D85961BF5;
        Mon, 15 Nov 2021 08:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636966558;
        bh=KymEuSb1ZBu9d4ip60ZapuAOc2fPUmm65BckI1F9t+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdZ6xF0xp+O72e2bWrz1JbVB8H175gzm3ebqcgB4b1TFRnEbOtg/Co/2UVmy2RSYO
         K4PGopsAL2+EPUBQXn3pIZuRLnOiV7Z4ZHRzhRaGpOOilkyT8qB7djWEyRGQxY+o07
         0pURtU5ha6Bqhqi3VRo20hpuTebBqhRUMgKKcND/ItqTEUbbBG6gtFAFRdgoUlbWQv
         nllnKfHGybN+48IS6aBEK9XM+8ihm/vdNwSp8OLBPdHs4lV1MKpoIy38LN4jK4yIhT
         e7DvDqpq2WV2gb8/H5hLIdnkM9Qc2HOyUeSrulI8xZE0lHPXJ5SUm3GD7JPkNCpR/k
         kEJCWgx/yAgzA==
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
Subject: [PATCH 11/11] dmaengine: remove slave_id config field
Date:   Mon, 15 Nov 2021 09:54:03 +0100
Message-Id: <20211115085403.360194-12-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211115085403.360194-1-arnd@kernel.org>
References: <20211115085403.360194-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

All references to the slave_id field have been removed, so
remove the field as well to prevent new references from
creeping in again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/dmaengine.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 9000f3ffce8b..0349b35235e6 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -418,9 +418,6 @@ enum dma_slave_buswidth {
  * @device_fc: Flow Controller Settings. Only valid for slave channels. Fill
  * with 'true' if peripheral should be flow controller. Direction will be
  * selected at Runtime.
- * @slave_id: Slave requester id. Only valid for slave channels. The dma
- * slave peripheral will have unique id as dma requester which need to be
- * pass as slave config.
  * @peripheral_config: peripheral configuration for programming peripheral
  * for dmaengine transfer
  * @peripheral_size: peripheral configuration buffer size
@@ -448,7 +445,6 @@ struct dma_slave_config {
 	u32 src_port_window_size;
 	u32 dst_port_window_size;
 	bool device_fc;
-	unsigned int slave_id;
 	void *peripheral_config;
 	size_t peripheral_size;
 };
-- 
2.30.2

