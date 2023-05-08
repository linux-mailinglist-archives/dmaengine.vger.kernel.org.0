Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE9D6FB7FE
	for <lists+dmaengine@lfdr.de>; Mon,  8 May 2023 22:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjEHUIA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 May 2023 16:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjEHUH4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 May 2023 16:07:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076805BAA;
        Mon,  8 May 2023 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683576469; x=1715112469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHOF6DrEvuRACHmnKROaRDudHiYk2POqQye99IoY3vM=;
  b=FnID8r0foLVAZy0mytCfB1LROjdNnJfy4fEznnMKedn5k0mETbzdvNQ0
   +E6HbGtJPKPou/giiu1b3MsXNjAKjNJfzlfkLrzfgC7Yb6sma3B4kSDfw
   hXi4bG7A3yQYKMKwV4GC/1V64ve13ll3zZWOu+Ja0+adBWY3TfPmXiVGm
   7hC0XMn9YJqiOKm/rmCuq382DtyBnynqTVLAtZ9VwDadtNQjgQCzLOHWx
   +oIr+xvzILMqAj9z/DLmvkw9gwcxFRERfr4vENIoNYyXADrXKLGw53XAi
   dmvzc5rtPk9U3nfb53+FDiU7BoyonPWCtxGhL6owHltOxEmeIm0Txnf2K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="348573631"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="348573631"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="788241629"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="788241629"
Received: from sajmal-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.74.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:07:47 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v4 04/15] dmaengine: idxd: Export descriptor management functions
Date:   Mon,  8 May 2023 15:07:26 -0500
Message-Id: <aaa07cc4203310ced305af34728c857a2caa1e7a.1683573703.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1683573703.git.zanussi@kernel.org>
References: <cover.1683573703.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

