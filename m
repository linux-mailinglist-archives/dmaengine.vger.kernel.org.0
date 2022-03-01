Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43D44C92FF
	for <lists+dmaengine@lfdr.de>; Tue,  1 Mar 2022 19:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiCAS0q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Mar 2022 13:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbiCAS0q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Mar 2022 13:26:46 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7866515F
        for <dmaengine@vger.kernel.org>; Tue,  1 Mar 2022 10:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646159164; x=1677695164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ccnKoRuJWlUDOWyVQ/tOZp6vbPYhdPVS2+VwfFUCj3s=;
  b=fiNun+s2wKpHWN0gyeVvBKhjUiT+y9pwlokBVjXWMPeFyJ2bAJmFXvof
   Lz1hwY1YOkBDF8yoBqQaeKbVDC9ooBzwyYHRD/a795Kac24GLxtjMRsVW
   MyR26VtbyAL2EOExLYz3eFLFPg60g+Efewyq73sQKfSk8cHYi5xvV3rNh
   tQWHGWzLrnL5XfwIGSK0BqbZqjUYiq6DYPBMiyedOvmBA17IC5LGU60Ef
   g5IRESHozoxtCrJLsS8PR3XB99kwYZRo9fxMYWy+XobASvreO6jDhnpcP
   oGg1qSOOpMZJMCD5BsEKP4SPvQ34Gqs0ngDAJj16pYeN2ftSzZFnL9VDY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252940733"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252940733"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 10:26:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630110229"
Received: from bwalker-desk.ch.intel.com ([143.182.137.126])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Mar 2022 10:26:04 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, ludovic.desroches@microchip.com,
        okaya@kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 2/4] dmaengine: at_hdmac: In atc_prep_dma_memset, treat value as a single byte
Date:   Tue,  1 Mar 2022 11:25:49 -0700
Message-Id: <20220301182551.883474-3-benjamin.walker@intel.com>
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
 drivers/dma/at_hdmac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 30ae36124b1db..5a50423b7378e 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -942,6 +942,7 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 	struct at_desc		*desc;
 	void __iomem		*vaddr;
 	dma_addr_t		paddr;
+	char			fill_pattern;
 
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

