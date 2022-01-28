Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FCF4A0041
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jan 2022 19:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbiA1SlS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jan 2022 13:41:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:22587 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343585AbiA1SlS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Jan 2022 13:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643395278; x=1674931278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ye5S5Fhti5NDHBTOu0VS5+fU2jdSdbDIiMwIOSV02UY=;
  b=Bp2ypCD1V95iuGJDXeL9Z/clRDsvzIgBx8fs2ewEIVKZQadStz4COzIb
   qbBgyuv5SgfYkWMW0K+ZyrcdJ16hpOAfXiMrkgnWaYa0mvy+YZtKXlABY
   fwHmxlQ//t1lTkOc5js6mS76l2O0gmKJ5Kz5r/85l7Os4MyZe9pQpEwcZ
   QgMvKjYfKdMtzKs4qd3e7ppsGs8neW0eZcitC95sm1i3A/cxSLKmaKHYR
   fcs7MjvTRx8HGjSBnNUQWOj/6V0PbsOeyEBXZj1hsHWO0HlfL53o+l5vR
   Cj8tHxzbgHctg96tgfeIRG/KtuI8+YpaQE/bW39fbCcrwVcAYQIlexIzC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="307905172"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="307905172"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="618802156"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 10:41:17 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [RFC PATCH 4/4] dmaengine: hidma: In hidma_prep_dma_memset treat value as a single byte
Date:   Fri, 28 Jan 2022 11:39:48 -0700
Message-Id: <20220128183948.3924558-5-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128183948.3924558-1-benjamin.walker@intel.com>
References: <20220128183948.3924558-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The value parameter is a single byte, so duplicate it to the 8 byte
range that is used as the pattern.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
Cc: Sinan Kaya <okaya@kernel.org>
---
 drivers/dma/qcom/hidma.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 65d054bb11aaa..d8aa6c0abe126 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -431,6 +431,7 @@ hidma_prep_dma_memset(struct dma_chan *dmach, dma_addr_t dest, int value,
 	struct hidma_desc *mdesc = NULL;
 	struct hidma_dev *mdma = mchan->dmadev;
 	unsigned long irqflags;
+	u64 pattern;
 
 	/* Get free descriptor */
 	spin_lock_irqsave(&mchan->lock, irqflags);
@@ -443,9 +444,19 @@ hidma_prep_dma_memset(struct dma_chan *dmach, dma_addr_t dest, int value,
 	if (!mdesc)
 		return NULL;
 
+	pattern = (unsigned char)value;
+	pattern = (pattern << 56) |
+		  (pattern << 48) |
+		  (pattern << 40) |
+		  (pattern << 32) |
+		  (pattern << 24) |
+		  (pattern << 16) |
+		  (pattern << 8) |
+		  pattern;
+
 	mdesc->desc.flags = flags;
 	hidma_ll_set_transfer_params(mdma->lldev, mdesc->tre_ch,
-				     value, dest, len, flags,
+				     pattern, dest, len, flags,
 				     HIDMA_TRE_MEMSET);
 
 	/* Place descriptor in prepared list */
-- 
2.33.1

