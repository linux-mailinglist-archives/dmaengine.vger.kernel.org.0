Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1121A6ACD24
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCFSxT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjCFSwt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:52:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD766BDFA;
        Mon,  6 Mar 2023 10:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128765; x=1709664765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T24PujgQYZHqfnkCbqb1TyiF+r+EUpp8fid20iaYFLk=;
  b=IGzNEBzsssHXOGdryWx89dYwbWQhS0wK2r6eNvLUF7FpVt6WM1Z4Kebb
   BYUNkNexLu9e3LpO/jEIweFzVurXpIAxdZ3W35aOWZNkkxWqQBcF2al+C
   b8gTmRpyGjfXqo4SNcHop6BbHrIaPH3q7mPVjnpvvsdc4E2rPwnbi15IP
   wGTGuz5H5rBetyir/dSgKGfVyXnzZJYXkWo1xlzlDJHBOSjqgXXnS3udL
   hI4gzqgfZ0ahmmu17Oz2FWGYAM8LE5VQ6AuN2WE25ULgGjqN2WA+anW+W
   qwgLC4sfOHWXyVq9mTqmOB2K12/A/6kSkaCzvwBY/gU5uyPn5vwkgYhnN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227727"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227727"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255798"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255798"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:44 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 06/16] dmaengine: idxd: Add private_data to struct idxd_wq
Date:   Mon,  6 Mar 2023 12:52:16 -0600
Message-Id: <20230306185226.26483-7-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a void * to idxd_wqs for user-defined context data.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/dma/idxd/idxd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 719f9f1662ad..e55213b5153e 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -216,6 +216,8 @@ struct idxd_wq {
 	u32 max_batch_size;
 
 	char driver_name[WQ_NAME_SIZE + 1];
+
+	void *private_data;
 };
 
 struct idxd_engine {
-- 
2.34.1

