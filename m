Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0024BC174
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 21:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiBRU4W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 15:56:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbiBRU4V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 15:56:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE37189AB8
        for <dmaengine@vger.kernel.org>; Fri, 18 Feb 2022 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645217764; x=1676753764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tFz5exw/Q8BYBVPJtqsAJmTppihvI1zL1DDjfonh8LQ=;
  b=YIbzpzdAcK6CYLCcqmr/zgvhWYxg9T4G541SLmzABCJrmJ0waFPCrpUB
   wsa8o1qxdgvbMOsZcCABaIRUN2dOPTo2/44ZsUqDVTX69LB6uTvb6VQMr
   2jzdiSxqT59dcU0ssRKq0P1ALfRvm6Joi4iLrpzSOQPXtP1qLyqbdA3wv
   tbB/A5PRZqQqZ57g0MpE72Kx9G8Kn+Hiz7UPFDgzi9vdPP1+6+IRqwroe
   jtlcS1VikQ58nGPI4ACBdm0eecFXs3d7LnT1LnklnLhAy39d+Jv9yZN1k
   MEPg8NiOu5glxCiUzOwo2ZHft5pSPfs5cedtuzfchFPpqgoYlkI0NlUb7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231840024"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231840024"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 12:56:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="626735637"
Received: from bwalker-desk.ch.intel.com ([143.182.137.126])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2022 12:56:02 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 3/4] dmaengine: at_xdmac: In at_xdmac_prep_dma_memset, treat value as a single byte
Date:   Fri, 18 Feb 2022 13:55:56 -0700
Message-Id: <20220218205557.486208-4-benjamin.walker@intel.com>
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

