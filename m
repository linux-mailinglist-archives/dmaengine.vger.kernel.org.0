Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C3174DDCC
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jul 2023 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjGJTH2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jul 2023 15:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjGJTHW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jul 2023 15:07:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9476A13D;
        Mon, 10 Jul 2023 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689016027; x=1720552027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHOF6DrEvuRACHmnKROaRDudHiYk2POqQye99IoY3vM=;
  b=JT3r5IpEDL4Ylm4QAKqKLPX6iz3ZQSzu/Pt46pZENWVDh8zxevSVPLne
   GZkPcp8A56ZtXsv6cQijQcIjfrmMmAdRb5JHMM6gehxuch+1XqLlfhe93
   EUFhjXBuqcmHGF4k1FRrcdcUiE+pLgy99sh+sC2EnzxufAhvgWZ0bmpA2
   WkuFDurGxYqNU5xTiKDbC39tZmlb3DuttFsxNY/UaI/4SbIx7YhTApCuB
   ys6rzGI45J42nD+yy2FCDSUirpL5ZolnW5uJZXULlkKetqvgZKE99fVnl
   eAK9bG8gN2T11T3JYKGDFjFyyFA4+em9KSRcZ87MmHajkOHuQAcIeZgA1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="354290758"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354290758"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 12:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="844991050"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="844991050"
Received: from jdmillsx-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.107.12])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 12:07:05 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v7 04/14] dmaengine: idxd: Export descriptor management functions
Date:   Mon, 10 Jul 2023 14:06:44 -0500
Message-Id: <20230710190654.299639-5-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
References: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To allow idxd sub-drivers to access the descriptor management
functions, export them.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/submit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index c01db23e3333..5e651e216094 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -61,6 +61,7 @@ struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype)
 
 	return __get_desc(wq, idx, cpu);
 }
+EXPORT_SYMBOL_NS_GPL(idxd_alloc_desc, IDXD);
 
 void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 {
@@ -69,6 +70,7 @@ void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	desc->cpu = -1;
 	sbitmap_queue_clear(&wq->sbq, desc->id, cpu);
 }
+EXPORT_SYMBOL_NS_GPL(idxd_free_desc, IDXD);
 
 static struct idxd_desc *list_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 					 struct idxd_desc *desc)
@@ -215,3 +217,4 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	percpu_ref_put(&wq->wq_active);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(idxd_submit_desc, IDXD);
-- 
2.34.1

