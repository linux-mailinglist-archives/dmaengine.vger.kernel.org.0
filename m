Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A016FB801
	for <lists+dmaengine@lfdr.de>; Mon,  8 May 2023 22:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjEHUIB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 May 2023 16:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjEHUH4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 May 2023 16:07:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C357459F8;
        Mon,  8 May 2023 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683576470; x=1715112470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XQ1zGv9JKYUAvlq2H9+30zI4fnNsJOWmds2DkhxoNrs=;
  b=noOwMRwav3sikwndBeDcikFQW/Scbyzyh0kxrLo4K/wR8N0qPiph7m28
   ao1fhTdjah/HEq7/P7So18Ncq/y/7IABo16aO79zZx01ie8qS1HcSC5QY
   RfNrSqUV4LyYch/z+9G65ok3OdTopRv5P2B4EldhaeNiqjtIpDuYVoqgu
   ANhGkT61fNO/115l1yS3dZUTLjlS1lLXGfNrYEBclo91d2tGuJtZGM7P0
   Vvp+GhOcwaPAko1zpwl4C4QPPxu3Ds2ooCmBjib6iUjGF0GIYihxrAYLA
   ZHLV12satlOvm3/NX+vjkdGYm5OuUknudWxUGiu4fGcbfwxq6wKB8zDsS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="348573639"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="348573639"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="788241634"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="788241634"
Received: from sajmal-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.74.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:07:49 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v4 05/15] dmaengine: idxd: Export wq resource management functions
Date:   Mon,  8 May 2023 15:07:27 -0500
Message-Id: <4037f6839b847cd65b48381e491f0f14e05fa9ff.1683573703.git.zanussi@kernel.org>
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

To allow idxd sub-drivers to access the wq resource management
functions, export them.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index af1aa88a66c1..7837d0a56314 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -161,6 +161,7 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 	free_hw_descs(wq);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(idxd_wq_alloc_resources, IDXD);
 
 void idxd_wq_free_resources(struct idxd_wq *wq)
 {
@@ -174,6 +175,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq)
 	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
 	sbitmap_queue_free(&wq->sbq);
 }
+EXPORT_SYMBOL_NS_GPL(idxd_wq_free_resources, IDXD);
 
 int idxd_wq_enable(struct idxd_wq *wq)
 {
@@ -422,6 +424,7 @@ int idxd_wq_init_percpu_ref(struct idxd_wq *wq)
 	reinit_completion(&wq->wq_resurrect);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(idxd_wq_init_percpu_ref, IDXD);
 
 void __idxd_wq_quiesce(struct idxd_wq *wq)
 {
@@ -431,6 +434,7 @@ void __idxd_wq_quiesce(struct idxd_wq *wq)
 	complete_all(&wq->wq_resurrect);
 	wait_for_completion(&wq->wq_dead);
 }
+EXPORT_SYMBOL_NS_GPL(__idxd_wq_quiesce, IDXD);
 
 void idxd_wq_quiesce(struct idxd_wq *wq)
 {
@@ -438,6 +442,7 @@ void idxd_wq_quiesce(struct idxd_wq *wq)
 	__idxd_wq_quiesce(wq);
 	mutex_unlock(&wq->wq_lock);
 }
+EXPORT_SYMBOL_NS_GPL(idxd_wq_quiesce, IDXD);
 
 /* Device control bits */
 static inline bool idxd_is_enabled(struct idxd_device *idxd)
-- 
2.34.1

