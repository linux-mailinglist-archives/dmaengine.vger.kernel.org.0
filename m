Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944454BC170
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 21:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiBRU4U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 15:56:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiBRU4U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 15:56:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4CE184631
        for <dmaengine@vger.kernel.org>; Fri, 18 Feb 2022 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645217763; x=1676753763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=unKxfshh86dInrkw1kXhK8vdm0pS1G/6t7SAOu77Low=;
  b=nb4zpCHEDTICgJ9oq9MYhz+eewxzNAOQeUbh7B4a1jB6zwx1ykLbgsp9
   sNbN87ngsHMbrqpJQs4xFJe/VZkQXn3gjOgaarGRTUKOrX+rX6X4JciVr
   CfsXacBx+FsumYH+6060vSUuGfABnb097xb3BFTQ+JuUI3mzAeEKWCKGg
   AP7xQhMg0L/wCi7YveFVYnWV0kB++j9ws3U1QBxDzI9M0qEU8IWUxm9ep
   kzVke+ypcRj0lVtHm8xFDzglncsjix7TJPXs3yR4NZR9BGMPcaAuF9upI
   bRLXYfD7Z88oIHzcyI8+vtFqKRQ70oxq2AzU+kd3sziwdCUPeBHl0P1Q3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231840023"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231840023"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 12:56:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="626735630"
Received: from bwalker-desk.ch.intel.com ([143.182.137.126])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2022 12:56:02 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 2/4] dmaengine: at_hdmac: In atc_prep_dma_memset, treat value as a single byte
Date:   Fri, 18 Feb 2022 13:55:55 -0700
Message-Id: <20220218205557.486208-3-benjamin.walker@intel.com>
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

The value passed in to .prep_dma_memset is to be treated as a single
byte repeating pattern.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 30ae36124b1db..bb84693f82e8d 100644
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
+	fill_pattern = (char)value;
+
+	*(u32*)vaddr = (fill_pattern << 24) |
+		       (fill_pattern << 16) |
+		       (fill_pattern << 8) |
+		       fill_pattern;
 
 	desc = atc_create_memset_desc(chan, paddr, dest, len);
 	if (!desc) {
-- 
2.35.1

