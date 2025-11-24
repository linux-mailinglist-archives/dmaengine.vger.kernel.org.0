Return-Path: <dmaengine+bounces-7308-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086D5C806A7
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36943A2503
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4122FFDF8;
	Mon, 24 Nov 2025 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIpA9SWH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119D2FF656;
	Mon, 24 Nov 2025 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986334; cv=none; b=EAMTMSxHXelaf0/fN9TYhLvPcJPIxw+lbDaNvaePJVsaq4ZxK0iMq9fdd4wsDsMdJ2jrt6mWrVm8R7gPHpAqFOHf9kWRirnhom/UjMFunXD41nNF25h+LudvAQmjHjJWcb8VYD+RK5BUfap4mo9hco6IW6S9Z+/sg4khbXDo8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986334; c=relaxed/simple;
	bh=/cxJU6vGAsQflUr/+ZE9vbpP5RWmAFwZncC3phpHqKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZiqj2gjoF6vQiJaduil7pMCC1rCU8qH34f6FklE4AQ6CyqcfJz46EU3urUoIL/RSuVzyEVOwZugjk7X1xUWyImebyNIMLhIzxiNztOmm54FpyoG35LeTunzD3m64rDVme9vg8cYji94yafcIG9LPQGw1cbKJ2f2z7c00tSP1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIpA9SWH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986332; x=1795522332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/cxJU6vGAsQflUr/+ZE9vbpP5RWmAFwZncC3phpHqKM=;
  b=GIpA9SWHHV48B2VylH5MZ4RiQbAydwuhNLs+RSDDBSqN1BUqwPZgTVEZ
   FedBw+S2C4ShnDBf9AQBZp2Ixi0cH7YjljsmySc4bDakQXbP6uBXrmZl9
   SrMted+9vQH5s15l73dPkttX9PoWPm3qJ0tVE+AkhF7rMt9DlQ5UGjjqQ
   tLJv5IJO1KKjCuo9O6tVaJfAxzSJF4Ug8BAS84eA/+69+7bpnWxgI758b
   6/I1xyI7DlQVyNSlLlE8bkFScoaTBaGINU97HFzV8iHYOG8csdk3bEp6A
   cFloLkYdwmEn5vMuXXT8lmD744LKClNZWT4uRirZ6AydzS2hABESu7FNa
   Q==;
X-CSE-ConnectionGUID: O982OkL6TSSfbo37HpCuVg==
X-CSE-MsgGUID: J5aRCAAyTkGlSP+V3N/TZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="91467912"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="91467912"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:12:09 -0800
X-CSE-ConnectionGUID: fh/9F8B6QSyvv2FZin4FtQ==
X-CSE-MsgGUID: v9ZK9M8yQI6oey+Xgb50lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192559536"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 24 Nov 2025 04:12:04 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4975DA1; Mon, 24 Nov 2025 13:12:03 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Vinod Koul <vkoul@kernel.org>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Cc: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 01/13] scatterlist: introduce sg_nents_for_dma() helper
Date: Mon, 24 Nov 2025 13:09:19 +0100
Message-ID: <20251124121202.424072-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>
References: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes the user needs to split each entry on the mapped scatter list
due to DMA length constrains. This helper returns a number of entities
assuming that each of them is not bigger than supplied maximum length.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/scatterlist.h |  2 ++
 lib/scatterlist.c           | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 29f6ceb98d74..6de1a2434299 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -441,6 +441,8 @@ static inline void sg_init_marker(struct scatterlist *sgl,
 
 int sg_nents(struct scatterlist *sg);
 int sg_nents_for_len(struct scatterlist *sg, u64 len);
+int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len);
+
 struct scatterlist *sg_last(struct scatterlist *s, unsigned int);
 void sg_init_table(struct scatterlist *, unsigned int);
 void sg_init_one(struct scatterlist *, const void *, unsigned int);
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 4af1c8b0775a..21bc9c1f7c06 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -64,6 +64,32 @@ int sg_nents_for_len(struct scatterlist *sg, u64 len)
 }
 EXPORT_SYMBOL(sg_nents_for_len);
 
+/**
+ * sg_nents_for_dma - return the count of DMA-capable entries in scatterlist
+ * @sgl:	The scatterlist
+ * @sglen:	The current number of entries
+ * @len:	The maximum length of DMA-capable block
+ *
+ * Description:
+ * Determines the number of entries in @sgl which would be permitted in
+ * DMA-capable transfer if list had been split accordingly, taking into
+ * account chaining as well.
+ *
+ * Returns:
+ *   the number of sgl entries needed
+ *
+ **/
+int sg_nents_for_dma(struct scatterlist *sgl, unsigned int sglen, size_t len)
+{
+	struct scatterlist *sg;
+	int i, nents = 0;
+
+	for_each_sg(sgl, sg, sglen, i)
+		nents += DIV_ROUND_UP(sg_dma_len(sg), len);
+	return nents;
+}
+EXPORT_SYMBOL(sg_nents_for_dma);
+
 /**
  * sg_last - return the last scatterlist entry in a list
  * @sgl:	First entry in the scatterlist
-- 
2.50.1


