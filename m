Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D186F1FC0
	for <lists+dmaengine@lfdr.de>; Fri, 28 Apr 2023 22:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346793AbjD1U4J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Apr 2023 16:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346776AbjD1Uz6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Apr 2023 16:55:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF31719;
        Fri, 28 Apr 2023 13:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682715357; x=1714251357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zvaDHuKYl25sgdRWq/GAXkq6tZiIBi7g4rJF93+3/do=;
  b=FG9nSSwfMuE8WyE9T5XlRy0MkG6Bp2FUOaYQ1SSZThxEjxq+yGnU5sTb
   IY/ZVaOgikdXVinhgREn9TNXH7odobTqRf0VEmlRBzM1DJ/RCveGgLB6+
   QwuX9Qu4uwFc1fVqjxEiGWR0z9SHXGtxQPpfpF8czGhiln1ZfTPEsxenl
   Nwc5hTuxPdUqlNZS1WUAd4Esp0N9tkRYYLGCy2+LLLI2zmGdFnYSjGH2v
   5o0WipEB2/o43dhxjVfY0TzMnbuFwGKC7LXTE7kIk8IyZf2To1SlEn1v4
   5kTOLEzHmI9tb1CFbsCi67K7teuqJmcwah/kXwoEcWmk5yDsFmy4mw0zg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="336937666"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="336937666"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 13:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="838980391"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="838980391"
Received: from ykaur1-mobl2.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.209.181.29])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 13:55:56 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v3 06/15] dmaengine: idxd: Add private_data to struct idxd_wq
Date:   Fri, 28 Apr 2023 15:55:30 -0500
Message-Id: <20230428205539.113902-7-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
References: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a void * to idxd_wqs for user-defined context data, along with
accessors set_idxd_wq_private() and idxd_wq_private().

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/dma/idxd/idxd.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 719f9f1662ad..0402f97d6ff8 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -216,6 +216,8 @@ struct idxd_wq {
 	u32 max_batch_size;
 
 	char driver_name[WQ_NAME_SIZE + 1];
+
+	void *private_data;
 };
 
 struct idxd_engine {
@@ -550,6 +552,16 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
 	return wq->client_count;
 };
 
+static inline void set_idxd_wq_private(struct idxd_wq *wq, void *private)
+{
+	wq->private_data = private;
+}
+
+static inline void *idxd_wq_private(struct idxd_wq *wq)
+{
+	return wq->private_data;
+}
+
 /*
  * Intel IAA does not support batch processing.
  * The max batch size of device, max batch size of wq and
-- 
2.34.1

