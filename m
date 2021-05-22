Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6358438D2EC
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 04:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhEVCOo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 22:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhEVCOn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 May 2021 22:14:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8B8C061574;
        Fri, 21 May 2021 19:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iQYwOPXrWz3J+UUz/yowI5gRKi/vR/JVWXsbNEdQuW8=; b=hx2Yc6Q/tZidlhuMHmgSw06m6w
        /lrRT/fVJOKPLuSK3R+TmMupe//Fki0c/FFntdprVBpDgjnzL2qGZnqIx+vdni7SjttU6U+JiP7Ux
        7+S9pKQzsu9AV/aQBiLhSwnG14tXW5vKLmLmyiMyQfetjQXD8pqDY8Hv/yyze0bpNoxcG+YqOx7kn
        1BC4POQlz4WnpsQ2TnHEnA+8lVIHih+FkqBEnSio/7qRqX/KGFzqkI6Ct696j80jDniM5ZexET+yq
        hwFwby5pRGmKnh6wdyezIyHkp8I7t8FCBChS8jQId9STh2ekYo6u6u+fl3B4NB3dc1EFjyQrNJkYb
        J3tUoCVw==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkH8f-00HX9I-KT; Sat, 22 May 2021 02:13:17 +0000
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
Subject: [PATCH 4/4] DMA: XILINX_ZYNQMP_DPDMA depends on HAS_IOMEM
Date:   Fri, 21 May 2021 19:13:13 -0700
Message-Id: <20210522021313.16405-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210522021313.16405-1-rdunlap@infradead.org>
References: <20210522021313.16405-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When CONFIG_HAS_IOMEM is not set/enabled, most iomap() family
functions [including ioremap(), devm_ioremap(), etc.] are not
available.
Drivers that use these functions should depend on HAS_IOMEM so that
they do not cause build errors.

Cures this build error:
s390-linux-ld: drivers/dma/xilinx/xilinx_dpdma.o: in function `xilinx_dpdma_probe':
xilinx_dpdma.c:(.text+0x336a): undefined reference to `devm_platform_ioremap_resource'

Fixes: 7cbb0c63de3fc ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
CC: dmaengine@vger.kernel.org
Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Tejas Upadhyay <tejasu@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/dma/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210521.orig/drivers/dma/Kconfig
+++ linux-next-20210521/drivers/dma/Kconfig
@@ -702,6 +702,7 @@ config XILINX_ZYNQMP_DMA
 
 config XILINX_ZYNQMP_DPDMA
 	tristate "Xilinx DPDMA Engine"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
