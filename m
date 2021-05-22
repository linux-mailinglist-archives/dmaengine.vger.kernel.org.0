Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0338D2EF
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 04:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhEVCOq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 22:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhEVCOn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 May 2021 22:14:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96182C06138C;
        Fri, 21 May 2021 19:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3BKp/4Sg45DErjN5esItAoQV5jwcip26xTH+cOjGs9w=; b=Laj9nE+laZmoOIlb3BC2T5pbpq
        KWWzPzNeAj7f5/GHXpJXNxohYxI+EC6dtPe77IxYF+MAh2ktwE/nLVkuXE83nrI8dIyVDmc5K2l4E
        xTJQ+Djmys1kRfYltRfOaeoM5PVtZS0////ekMXzhUZQQk8BgGMhHA/m2GRMkewDTDW3ZjIQ/gEQk
        0AdSX5yEvnpHOzFI+yn12SZWe42idsUttjt4n9A0fOv8bP0eJh8WuwK0eS3HN0rFQfckwoNMmMbjI
        nd+oSM+PlCjSV1lKy/wULgey07UvK6fW99nQ6z0LZJDrcFcf5fDwXST0JwaLbdnfX69ntR4nY1pD4
        h4vLTAmg==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkH8f-00HX9I-3Y; Sat, 22 May 2021 02:13:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Stefan Roese <sr@denx.de>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Green Wan <green.wan@sifive.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/4] DMA: SF_PDMA depends on HAS_IOMEM
Date:   Fri, 21 May 2021 19:13:12 -0700
Message-Id: <20210522021313.16405-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210522021313.16405-1-rdunlap@infradead.org>
References: <20210522021313.16405-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

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
---
 drivers/dma/sf-pdma/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210521.orig/drivers/dma/sf-pdma/Kconfig
+++ linux-next-20210521/drivers/dma/sf-pdma/Kconfig
@@ -1,5 +1,6 @@
 config SF_PDMA
 	tristate "Sifive PDMA controller driver"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
