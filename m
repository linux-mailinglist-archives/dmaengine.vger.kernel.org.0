Return-Path: <dmaengine+bounces-253-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C97FAB5B
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 21:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F1EB21317
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6123EA7E;
	Mon, 27 Nov 2023 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIvdYK6l"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F340D60;
	Mon, 27 Nov 2023 12:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701116841; x=1732652841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KIwEAq00pSueG4DSxFjX/X+olr9EGFvm2qeS8vaAfoM=;
  b=jIvdYK6leX7mnfwty3N1lJb8lUji7UUyMxIg57gnAHQCbyc8A5aBuz7M
   anOKtdBtfyy9pJynRpZvrODkIMDl4RswsHmYdPbqEPXPjCvgK32c+/qeD
   0qOIqw6FnM5N+dDQWkLwVmRzbWaaOylFVqohr3aotEunsbtxvSLxL4soT
   3/C00p/0Z5aH3tf1lhOl6keAwmKDfhPi9PNYZtFnV19NLmKd2dDeZmu85
   uYOtpieB/d/niBGIoKeTFuYvp+DcDacZwA9jZZT17hkFXswuK/eBK2cXT
   ZiqqsoTWdhSXJGsgsg1rB5bgkx0llWRnhDBG1j41nX2b9vwhpg20qomQB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="457115517"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="457115517"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="16394536"
Received: from rpkulapa-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.213.183.92])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:27:20 -0800
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
Subject: [PATCH v10 05/14] dmaengine: idxd: Add wq private data accessors
Date: Mon, 27 Nov 2023 14:26:55 -0600
Message-Id: <20231127202704.1263376-6-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
References: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the accessors idxd_wq_set_private() and idxd_wq_get_private()
allowing users to set and retrieve a private void * associated with an
idxd_wq.

The private data is stored in the idxd_dev.conf_dev associated with
each idxd_wq.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/idxd/idxd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index ae3be5cb2ee3..4b67181f4396 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -618,6 +618,16 @@ static inline int idxd_wq_refcount(struct idxd_wq *wq)
 	return wq->client_count;
 };
 
+static inline void idxd_wq_set_private(struct idxd_wq *wq, void *private)
+{
+	dev_set_drvdata(wq_confdev(wq), private);
+}
+
+static inline void *idxd_wq_get_private(struct idxd_wq *wq)
+{
+	return dev_get_drvdata(wq_confdev(wq));
+}
+
 /*
  * Intel IAA does not support batch processing.
  * The max batch size of device, max batch size of wq and
-- 
2.34.1


