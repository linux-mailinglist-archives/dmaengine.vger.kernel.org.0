Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A9C4BC171
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 21:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiBRU4V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 15:56:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiBRU4U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 15:56:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4026189AB1
        for <dmaengine@vger.kernel.org>; Fri, 18 Feb 2022 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645217763; x=1676753763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6N/CwwGxAc5yLrcNzbc33NCQB9rqAk6Rz/wTvQGExIU=;
  b=Reyu72ccK7B6ChJLCYgFei1CcHHVwI0JPuL+5UA2/SDdq68WbCbvNlCe
   i4E7ZfraFDnjWWW7Td07gIf+FV3yWJPz5AVtez0dbKkH64V8Z5BC+p0Wa
   Ukahe0ZvyOdLAGURy9TSqeUH0Z3q1ZcHmWvOxy3PMV1iH3gaah886MF8Y
   0pJf/LH0jpOmOXqpfu2EDUGLXhcB2OT5Eu487UWcV/u3BAc4qRngDtLx4
   yHzT6AO5Uvqoy+LWh4ZyVGLj3mmE4A1FooU/oPRxBzMxi43zKyP1NjP3I
   zyYHugyEMqsSYgH29H9EethjEu3lP+QRiaT1hNHJbI2zHvCkk+O/VcWeW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231840022"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231840022"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 12:56:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="626735622"
Received: from bwalker-desk.ch.intel.com ([143.182.137.126])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2022 12:56:01 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 1/4] dmaengine: Document dmaengine_prep_dma_memset
Date:   Fri, 18 Feb 2022 13:55:54 -0700
Message-Id: <20220218205557.486208-2-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218205557.486208-1-benjamin.walker@intel.com>
References: <20220218205557.486208-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document this function to make clear the expected behavior of the
'value' parameter. It was intended to match the behavior of POSIX memset
as laid out here:

https://lore.kernel.org/dmaengine/YejrA5ZWZ3lTRO%2F1@matsya/

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 Documentation/driver-api/dmaengine/provider.rst | 6 ++++++
 include/linux/dmaengine.h                       | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 0072c9c7efd34..4f99f0e9bb81d 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -206,6 +206,12 @@ Currently, the types available are:
   - The device is able to perform parity check using RAID6 P+Q
     algorithm against a memory buffer.
 
+- DMA_MEMSET
+
+  - The device is able to fill memory with the provided pattern
+
+  - The pattern is treated as a single byte signed value.
+
 - DMA_INTERRUPT
 
   - The device is able to trigger a dummy transfer that will
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
2.35.1

