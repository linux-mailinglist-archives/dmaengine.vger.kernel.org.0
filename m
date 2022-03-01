Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC304C9300
	for <lists+dmaengine@lfdr.de>; Tue,  1 Mar 2022 19:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiCAS0s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Mar 2022 13:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiCAS0s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Mar 2022 13:26:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A5652E0
        for <dmaengine@vger.kernel.org>; Tue,  1 Mar 2022 10:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646159166; x=1677695166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yIAwBfFnTh1qEK6FTIf2dCgCkxr1qrPLCMSRONpUbo8=;
  b=NEFhfmZ4A9MoevxEiPPOO4VnPI8DQ1gW4j4EfU3QXvxcmmAd+ftYGOO+
   nOlg1Db34iDMwVBzGVPcdgAwcz2xY6459LyMzbtnr6kLRS9L0GMtqEbtv
   xy/2zzVQIBuR0cGmaOt4djV8i4n29RC2m+FOnD2MY7/vwtA/0+UCH9NP1
   i3anKTyyGLo/yo6aYVjXe8TI28KMxSwzTtaf+IddKJ+JvRRxISNHIFcam
   ndNvEmWRArLs73PArfii5sNQWhrs8Pn4ZYNALYdc2HKAUIbGHWsJAhdHE
   D8YfxEPX5K7pzmoq28NoOeJAWED1aJ2S9/Jh/xbJemmt6CBXlV3DxibMh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252940736"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252940736"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:26:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630110237"
Received: from bwalker-desk.ch.intel.com ([143.182.137.126])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Mar 2022 10:26:06 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 3/4] dmaengine: at_xdmac: In at_xdmac_prep_dma_memset, treat value as a single byte
Date:   Tue,  1 Mar 2022 11:25:50 -0700
Message-Id: <20220301182551.883474-4-benjamin.walker@intel.com>
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

The value passed in to .prep_dma_memset is to be treated as a single
byte repeating pattern.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index a1da2b4b6d732..fb9df3a69babd 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1202,6 +1202,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 	unsigned long		flags;
 	size_t			ublen;
 	u32			dwidth;
+	char			pattern;
 	/*
 	 * WARNING: The channel configuration is set here since there is no
 	 * dmaengine_slave_config call in this case. Moreover we don't know the
@@ -1244,10 +1245,16 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 
 	chan_cc |= AT_XDMAC_CC_DWIDTH(dwidth);
 
+	/* Only the first byte of value is to be used according to dmaengine */
+	pattern = (char)value;
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
2.35.1

