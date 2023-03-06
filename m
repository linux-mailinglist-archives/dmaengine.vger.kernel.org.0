Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6176ACD1D
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 19:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCFSwx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 13:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCFSws (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 13:52:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066E7040B;
        Mon,  6 Mar 2023 10:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678128764; x=1709664764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UWiyeSaMJRXIRpsgST4Bs27UAB5ID/L9rOXwzjeNkgk=;
  b=YXX0ri3Rc5tESxrxW0gkf9MjZAgkfAdNtOOfjzsqf35F96W4ZX+8T3Yb
   TtTVQWGxqDhQ8f2GEmowEJ2k2cWKkgG5hD3BPzRtT6qEQmGSZiTrOtm+M
   P+cnB21088GoCEE3zMDHY/nV3t8qWC7veYRPxApv7rXYxOCeq27uWORyV
   dPPIO/75i1BiLX1ilBOhtDiR+V1Zkqi8drTozgi9TrIo4V4+kKVPgE+ta
   /UQ7FkMRYJY5HpBv/gblyxgpeAT+LniuWusPKg34X8riDBZwtgsaUvf+H
   XLKUbNf70Jk7PsQnIavfKWOvkONkd9a9Qvpw+381RIAkfHVs23+WpbTBz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398227719"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398227719"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626255788"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626255788"
Received: from jeblanco-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.118.26])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:52:41 -0800
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 05/16] dmaengine: idxd: Export wq resource management functions
Date:   Mon,  6 Mar 2023 12:52:15 -0600
Message-Id: <20230306185226.26483-6-tom.zanussi@linux.intel.com>
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

To allow idxd sub-drivers to access the wq resource management
functions, export them.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
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

