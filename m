Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68E4C92FE
	for <lists+dmaengine@lfdr.de>; Tue,  1 Mar 2022 19:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiCAS0p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Mar 2022 13:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbiCAS0n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Mar 2022 13:26:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A757652E0
        for <dmaengine@vger.kernel.org>; Tue,  1 Mar 2022 10:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646159162; x=1677695162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6N/CwwGxAc5yLrcNzbc33NCQB9rqAk6Rz/wTvQGExIU=;
  b=LPPikPVmG1G9g9oZRLTZr/jQevC2eGQWaen2hu/T2UOHwWjTcIrPuzQ6
   IzWMynDTFY0Q+n1POr5GzHYePOUAR8l5oAlit7V+NLeD+DMccWlA45V3+
   r4DA29QkR3j9mdEUTJ+4nvYKPiOsdSBT6Jq91JIWeh5SvKSivjx7QVa97
   5BTg+kjQNN5BfjQ5xqaHmMhm2m4uiZAu+S7hT833qkaYTLUU/v60iXKFf
   J2RvdQJYFtYD1laFQG/JF31fekygo4qzBp38NJuW2/1sVGf2VCtp5+zBX
   QZIPh9LLvQyuX5LpdK5G8HhVQTx+879TQAYa6AdI/7awWor9aoXP5iPIF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252940721"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252940721"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630110184"
Received: from bwalker-desk.ch.intel.com ([143.182.137.126])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Mar 2022 10:26:01 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v3 1/4] dmaengine: Document dmaengine_prep_dma_memset
Date:   Tue,  1 Mar 2022 11:25:48 -0700
Message-Id: <20220301182551.883474-2-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301182551.883474-1-benjamin.walker@intel.com>
References: <20220301182551.883474-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

