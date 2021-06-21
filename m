Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1B3AEF5E
	for <lists+dmaengine@lfdr.de>; Mon, 21 Jun 2021 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhFUQiB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Jun 2021 12:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232414AbhFUQf5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Jun 2021 12:35:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E05B061289;
        Mon, 21 Jun 2021 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624292896;
        bh=EVp8eR+0gFf3zeSAS4slZqlAbcbPp7AwdLvUmfBdaSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4NqjPIXuYTljYve3HV5qZqedOgs2mWAHN9XZzC8Z//66TVWSnExIdzrCcdSBkGAQ
         9u1gVpBMAAxuFVW/vhX2bktQ7XKUNbaOnn6dv8XFqzfFJIzR/74iBvp5DSZ+JlkS5f
         +TEMBqM9N21nuwiijoIxVkY9L6RU+Xw+JOy4l96g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Green Wan <green.wan@sifive.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.12 007/178] dmaengine: SF_PDMA depends on HAS_IOMEM
Date:   Mon, 21 Jun 2021 18:13:41 +0200
Message-Id: <20210621154921.712666505@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621154921.212599475@linuxfoundation.org>
References: <20210621154921.212599475@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 8e2e4f3c58528c6040b5762b666734f8cceba568 ]

When CONFIG_HAS_IOMEM is not set/enabled, certain iomap() family
functions [including ioremap(), devm_ioremap(), etc.] are not
available.
Drivers that use these functions should depend on HAS_IOMEM so that
they do not cause build errors.

Mends this build error:
s390-linux-ld: drivers/dma/sf-pdma/sf-pdma.o: in function `sf_pdma_probe':
sf-pdma.c:(.text+0x1668): undefined reference to `devm_ioremap_resource'

Fixes: 6973886ad58e ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Green Wan <green.wan@sifive.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Link: https://lore.kernel.org/r/20210522021313.16405-4-rdunlap@infradead.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/sf-pdma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sf-pdma/Kconfig b/drivers/dma/sf-pdma/Kconfig
index f8ffa02e279f..ba46a0a15a93 100644
--- a/drivers/dma/sf-pdma/Kconfig
+++ b/drivers/dma/sf-pdma/Kconfig
@@ -1,5 +1,6 @@
 config SF_PDMA
 	tristate "Sifive PDMA controller driver"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.30.2



