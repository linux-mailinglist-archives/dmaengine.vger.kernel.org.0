Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E5F4A0040
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jan 2022 19:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiA1SlJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jan 2022 13:41:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:53454 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343585AbiA1SlJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Jan 2022 13:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643395269; x=1674931269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tFz5exw/Q8BYBVPJtqsAJmTppihvI1zL1DDjfonh8LQ=;
  b=OdT3/+sDmjdrizRTAisTJJSirPbcV2ZxnB1c5XLY81HlXEaUM1tBeQn6
   sqLliYClcE1BFlT15ltLzjzD3won5gEgnhv5igE4KJRaEKKnNfpf3kbQ/
   mBmG/JS/CtJJ/wjVENwsbg5WHO1QerpK0gQZhNk45H47ikqqn7oOzsNwp
   DigGMAZA7yJ1Zrzt8o6lGcKnlBsdS8lEGBEcqWS/f4ESeSYTyET00hUb5
   juC7y/BpO6kv4v/HOALfXLc10FKplGi2STdt86rsSu6t1huRQ1vncPsgf
   Y9e/0VIr8gPZJ+MAhCg+6UIwXqt6No3WoxnxK749tC0IH66g0pylbXZc9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="234559899"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="234559899"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:41:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="618802153"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2022 10:41:08 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [RFC PATCH 3/4] dmaengine: at_xdmac: In at_xdmac_prep_dma_memset, treat value as a single byte
Date:   Fri, 28 Jan 2022 11:39:47 -0700
Message-Id: <20220128183948.3924558-4-benjamin.walker@intel.com>
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
 drivers/dma/at_xdmac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index a1da2b4b6d732..547778fc6445b 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1202,6 +1202,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 	unsigned long		flags;
 	size_t			ublen;
 	u32			dwidth;
+	unsigned char		pattern;
 	/*
 	 * WARNING: The channel configuration is set here since there is no
 	 * dmaengine_slave_config call in this case. Moreover we don't know the
@@ -1244,10 +1245,16 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 
 	chan_cc |= AT_XDMAC_CC_DWIDTH(dwidth);
 
+	/* Only the first byte of value is to be used according to dmaengine */
+	pattern = (unsigned char)value;
+
 	ublen = len >> dwidth;
 
 	desc->lld.mbr_da = dst_addr;
-	desc->lld.mbr_ds = value;
+	desc->lld.mbr_ds = (pattern << 24) |
+			   (pattern << 16) |
+			   (pattern << 8) |
+			   pattern;
 	desc->lld.mbr_ubc = AT_XDMAC_MBR_UBC_NDV3
 		| AT_XDMAC_MBR_UBC_NDEN
 		| AT_XDMAC_MBR_UBC_NSEN
-- 
2.33.1

