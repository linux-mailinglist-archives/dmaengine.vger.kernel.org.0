Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963394A662B
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 21:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbiBAUli (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 15:41:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:16574 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240465AbiBAUki (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 15:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643748038; x=1675284038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXMJopER3QlTz0wS29AUubfW1f8Vsa6VOJ61nWihPXc=;
  b=CNTMkk3fi4dZXSXpuj2kZ4yvBpi3BmXGBn8vjDbDJiFBhAVKJYy/ttS9
   Ffp9TI8rV3ABQYyhGd7sVoqk554ehOsHEEOYOUaeGkFfNDcMyidHJwWLl
   3M30M/1UXNhkhQn8HlKJNysXkPbB0Y6JYCx0PFktdAs5o/Rxw+UbzbWKD
   GMzvVMaEuCvEbw4rH97K63rXIXLW13w2CEzpG+QY3K4Y8lA3zXSxMRa4a
   2nJ+c1ChkutxlIje1Ugv21qqdKO2IuobAb0TNGSedlA1lNDcEw+c5XHqw
   Vky5EAd5MPzACy6HlE2SgOCeVUoZOVAINpbBX0JEAyaD5LdCOfR7pe5nt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="334143893"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="334143893"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 12:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="479820795"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 12:39:12 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [RESEND 06/10] dmaengine: Remove dma_set_tx_state
Date:   Tue,  1 Feb 2022 13:38:09 -0700
Message-Id: <20220201203813.3951461-7-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220201203813.3951461-1-benjamin.walker@intel.com>
References: <20220201203813.3951461-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Nothing calls this anymore.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/dmaengine.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 08c7bd7cfc229..7a5203175e6a8 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -88,15 +88,6 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
 	return DMA_IN_PROGRESS;
 }
 
-static inline void dma_set_tx_state(struct dma_tx_state *st,
-	dma_cookie_t last, dma_cookie_t used, u32 residue)
-{
-	if (!st)
-		return;
-
-	st->residue = residue;
-}
-
 static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
 {
 	if (state)
-- 
2.33.1

