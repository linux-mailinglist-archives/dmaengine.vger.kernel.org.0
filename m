Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A24A003F
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jan 2022 19:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343557AbiA1SlD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jan 2022 13:41:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:22378 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235580AbiA1SlD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Jan 2022 13:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643395263; x=1674931263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pAOQRZyMiTjxfKjDX5AUUy5de+fQawB2WbVaitH/eOA=;
  b=e3scWVd1hD0njrOmX6llM6gpdBPh6M1yfgGxYSyGLc75rKW+iI9V64BH
   Xad6uj877MNGCnUiOXzcdID2P8q68uN5gife9FJKFr1Y4jZcyRAeoKJzb
   HtY4KFEl/xLRAxcYuzUDLJW6fwYoZR1m1TyxS+FJd/bzsWJPyPJC0BgXr
   nqA5QNDfZyECMMDPVpStTAei8IEymJH3Vm50YeEWiPXoaVS6yj+DLGgsn
   kJW5TToRjyy5GBds35P830wIld2iHBvcRKSvKEv7Vw2NMz/JG4n9hTCzS
   rbOSkoL1Ueqql+cjSL8nKYzzgStkNWNtDCId7RPryDOtT8kTJxy/+ScL9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="333528317"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="333528317"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:41:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="618802115"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 10:41:00 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [RFC PATCH 2/4] dmaengine: at_hdmac: In atc_prep_dma_memset, treat value as a single byte
Date:   Fri, 28 Jan 2022 11:39:46 -0700
Message-Id: <20220128183948.3924558-3-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128183948.3924558-1-benjamin.walker@intel.com>
References: <20220128183948.3924558-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The value passed in to .prep_dma_memset is to be treated as a single
byte repeating pattern.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 30ae36124b1db..6defca514a614 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -942,6 +942,7 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 	struct at_desc		*desc;
 	void __iomem		*vaddr;
 	dma_addr_t		paddr;
+	unsigned char		fill_pattern;
 
 	dev_vdbg(chan2dev(chan), "%s: d%pad v0x%x l0x%zx f0x%lx\n", __func__,
 		&dest, value, len, flags);
@@ -963,7 +964,14 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 			__func__);
 		return NULL;
 	}
-	*(u32*)vaddr = value;
+
+	/* Only the first byte of value is to be used according to dmaengine */
+	fill_pattern = (unsigned char)value;
+
+	*(u32*)vaddr = (fill_pattern << 24) |
+		       (fill_pattern << 16) |
+		       (fill_pattern << 8) |
+		       fill_pattern;
 
 	desc = atc_create_memset_desc(chan, paddr, dest, len);
 	if (!desc) {
-- 
2.33.1

