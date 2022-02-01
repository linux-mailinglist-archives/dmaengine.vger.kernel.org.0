Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B404A662F
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 21:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbiBAUlo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 15:41:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:16619 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242503AbiBAUlC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 15:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643748062; x=1675284062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sMbutdcygkqI/J2ttnrg17fEP9LStKxNuQgas5Lz9pw=;
  b=dHjc7CQbF2ArM167r9ULrXkIOyWpj3FaMV/4JTi+aLv6wZNIlECFm4AJ
   ck1BkjcTiSaMe2z1fdFWAlPUguESjMz7mrLLzjXUJ5nTD0Bu6RTrYVsw1
   ofFCbcDNlCgC4sCcNRka2kEyuJz+gXU/5HP9KmJFY6Lzk1S5Dnd64PRoN
   UKenJiJVePk8BtCjJ9t9+qL3jn1mLQcpflahmHk5sxJQrpl46sbuW1oYa
   huehAjJGXhAwqzQNBlp6CDuo6/QIXW8hcojIcN9anqAUx6DP6XVCo/VET
   7pGd223O9zP8VYhJfKjK9hQOdfz5qY4B3Th8Qn/9CN2BplQt6Y+UuYG0I
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="334143895"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="334143895"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 12:39:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="479820813"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 12:39:12 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [RESEND 08/10] dmaengine: idxd: idxd_desc.id is now a u16
Date:   Tue,  1 Feb 2022 13:38:11 -0700
Message-Id: <20220201203813.3951461-9-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220201203813.3951461-1-benjamin.walker@intel.com>
References: <20220201203813.3951461-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is going to be packed into the cookie. It does not need to be
negative or larger than u16.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/idxd/idxd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index c53835584406a..b95299b723518 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -328,7 +328,7 @@ struct idxd_desc {
 	struct dma_async_tx_descriptor txd;
 	struct llist_node llnode;
 	struct list_head list;
-	int id;
+	u16 id;
 	int cpu;
 	struct idxd_wq *wq;
 };
-- 
2.33.1

