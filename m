Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E824438D2EB
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 04:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhEVCOp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 22:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhEVCOn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 May 2021 22:14:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90609C06138B;
        Fri, 21 May 2021 19:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=otxB9XgkPaq33SprB3S94UgubLgv8m0t9c6KhElQH1Q=; b=1ZwVArsUR4vtRRxGxtDwtiQRrP
        upYDwwkeFi47c8OOh0d63VK2OwPczmAn2ReeyrBkz1WUQxH3ENuhUzgErvfHGIva9BpxKh+bZnEKn
        y1mezx4m74rVh7eudaRNmF5+Af1v7ZXpXeNNbDT0mQ/3eiy+a+YOLXMrFvaLcih5rGS4xLrngPSvQ
        P4m1Urs7tGwaSxnDuD2IvHnHv9QRTAxLHMY9Jl08F3TppuGLqD26xgeQK8eK00NBtSS8yUr/fP356
        Yb0X1qs5w9N/UK1Noi7voU3ENfl4SL4gConObfdNHCz7hS0d4dAA1Kl8lDIvjgptTIq9VQGNcaz3n
        OvYQaIDw==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkH8e-00HX9I-3N; Sat, 22 May 2021 02:13:16 +0000
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
Subject: [PATCH 1/4] DMA: ALTERA_MSGDMA depends on HAS_IOMEM
Date:   Fri, 21 May 2021 19:13:10 -0700
Message-Id: <20210522021313.16405-2-rdunlap@infradead.org>
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

Repairs this build error:
s390-linux-ld: drivers/dma/altera-msgdma.o: in function `request_and_map':
altera-msgdma.c:(.text+0x14b0): undefined reference to `devm_ioremap'

Fixes: a85c6f1b2921 ("dmaengine: Add driver for Altera / Intel mSGDMA IP core")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Stefan Roese <sr@denx.de>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210521.orig/drivers/dma/Kconfig
+++ linux-next-20210521/drivers/dma/Kconfig
@@ -59,6 +59,7 @@ config DMA_OF
 #devices
 config ALTERA_MSGDMA
 	tristate "Altera / Intel mSGDMA Engine"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	help
 	  Enable support for Altera / Intel mSGDMA controller.
