Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87133773072
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 22:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjHGUiT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 16:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjHGUiJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 16:38:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B22EE5F;
        Mon,  7 Aug 2023 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691440688; x=1722976688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vObohvQfDDNqka9m/gIuvJ0AUJRK4wpxi4IWTNHjdm0=;
  b=XF+1dSTv1eJLfOQiGRZpqnjzW3JSiN3qLUfnZgKVc3kf1/AopV0XhmSj
   BqrXu44LKByT0l31vR4dg94MedRQV+yIxrWirq/HdbeQpUakAiSROYdMf
   7NnovLSX8eQarI5NxGW+oCRJYj4X2x4FExQXe7nLkX/61eIWBdHIi5E9/
   9N08J2hkX+K4rsApBHtQon2WKOVu6QVsEDVXk2uQEdvXVeQ4wKEH2fgV/
   X0333ozcIGRxk2XopNBmi+aQxoVR/fzOde/XNoKwt9YlsoEpnQ6/EQmfr
   +3/lMOH1LLwr6P0skNpVCs06/+g70CQ9rIc+RI+eOXTjWFV6zJKcGs3yz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374319677"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="374319677"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766123345"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="766123345"
Received: from eeroesle-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.81.193])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:37:43 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v9 05/14] dmaengine: idxd: Export wq resource management functions
Date:   Mon,  7 Aug 2023 15:37:17 -0500
Message-Id: <20230807203726.1682123-6-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807203726.1682123-1-tom.zanussi@linux.intel.com>
References: <20230807203726.1682123-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/idxd/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 9b2a6a1ee2af..4f6972cf656e 100644
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

