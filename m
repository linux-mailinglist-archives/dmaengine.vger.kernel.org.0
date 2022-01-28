Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019444A003E
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jan 2022 19:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245524AbiA1Skd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jan 2022 13:40:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:31193 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235580AbiA1Skd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Jan 2022 13:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643395233; x=1674931233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGphTqgdpn5bECb5wH31J5bZnYGSDtzPbP50IDkJSpU=;
  b=iHP1u7kGW9bntcgFj2zvEeSTEMwhTlWQA0taar/XRiMFJ2MxZFl4NG0y
   V1pY/1m5BMjpQZUNWadsYWg5lDU/osyOHh9MyYjSCYjexL/z2T5M/6hyD
   CLt6Qw7ZX4bhxOVZkU32keCegv/s1xEdaYbqQT4hh8IP6KhLcKpBx7lNG
   cFLDVPaLJ/EbXFMoRTFMVOIpnLHpIBEREsUAWtgrSRuSujVwQCFhGMylO
   Nd6A71xNA1Q/AU/dApB8Rna8RFqN+yKM6yskGNc607IY+J7oB2+HgRKg6
   3nGW5nPfbgpL42D8mg/xOGfrfVX8EpmWGPbeD4PmCzLVB+/4gRqGwGXcx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227152768"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="227152768"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="618802058"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 10:40:32 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [RFC PATCH 1/4] dmaengine: Document dmaengine_prep_dma_memset
Date:   Fri, 28 Jan 2022 11:39:45 -0700
Message-Id: <20220128183948.3924558-2-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128183948.3924558-1-benjamin.walker@intel.com>
References: <20220128183948.3924558-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document this function to make clear the expected behavior of the
'value' parameter. It was intended to match the behavior of POSIX memset
as laid out here:

https://lore.kernel.org/dmaengine/YejrA5ZWZ3lTRO%2F1@matsya/

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 include/linux/dmaengine.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 842d4f7ca752d..3d3e663e17ac7 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1031,6 +1031,14 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
 	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
 }
 
+/**
+ * dmaengine_prep_dma_memset() - Prepare a DMA memset descriptor.
+ * @chan: The channel to be used for this descriptor
+ * @dest: Address of buffer to be set
+ * @value: Treated as a single byte value that fills the destination buffer
+ * @len: The total size of dest
+ * @flags: DMA engine flags
+ */
 static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memset(
 		struct dma_chan *chan, dma_addr_t dest, int value, size_t len,
 		unsigned long flags)
-- 
2.33.1

