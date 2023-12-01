Return-Path: <dmaengine+bounces-340-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B25068013F6
	for <lists+dmaengine@lfdr.de>; Fri,  1 Dec 2023 21:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 428EAB21129
	for <lists+dmaengine@lfdr.de>; Fri,  1 Dec 2023 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA68B56B80;
	Fri,  1 Dec 2023 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lqg+XV4I"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C291510EA;
	Fri,  1 Dec 2023 12:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701461467; x=1732997467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oTslo5dfBjUzN5B7+kuIpfd8d61O/Ub8JrrlE4TLUdc=;
  b=Lqg+XV4IR15MNbreHJwLc6VnI0DPLCV5uYX2wtsqwHWvVNX1EM/yM9CR
   +YmC45UHjcEPUGlLfwOgk1VQy5iUS0bW9FGlEMWCekzb33HaBDRFmlhDe
   inD2NPpcKxdz/cnpH10i7v0+QFHQFIKUDoYDZ6vOA47p+R2dlttAEIAuH
   fKV7bH6D1IIBRTr7lP0BdZ8K4LMFu067uH+8DBvtNOkTXnYETZhgp042/
   NLAcxuoqqWxlG6YXhs1qKoQJwZSGKNd2riFSRRgGX2uWlNXLgQTzF5DgH
   uD7SX3/UD75Wr+Q+xz3Xt0vKvbnI+tBbNVXMhfwzdl5N3qu2mUr5aT/V1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="427781"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="427781"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 12:10:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="860671153"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="860671153"
Received: from temersox-mobl2.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.213.166.197])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 12:10:45 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	fenghua.yu@intel.com,
	vkoul@kernel.org
Cc: dave.jiang@intel.com,
	tony.luck@intel.com,
	wajdi.k.feghali@intel.com,
	james.guilford@intel.com,
	kanchana.p.sridhar@intel.com,
	vinodh.gopal@intel.com,
	giovanni.cabiddu@intel.com,
	pavel@ucw.cz,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v11 03/14] dmaengine: idxd: Export descriptor management functions
Date: Fri,  1 Dec 2023 14:10:24 -0600
Message-Id: <20231201201035.172465-4-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201201035.172465-1-tom.zanussi@linux.intel.com>
References: <20231201201035.172465-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow idxd sub-drivers to access the descriptor management
functions, export them.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
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


