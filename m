Return-Path: <dmaengine+bounces-8116-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AABCD02906
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 13:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 523E73027CDE
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A413806C6;
	Thu,  8 Jan 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmehJVc+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7543350A26;
	Thu,  8 Jan 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869807; cv=none; b=hE9rPfxFNSaKC6OU8ZGgZ8aaI9MmAAO5gxIJGIaXmHteyedeH7zTagWK92RUTOYKSXsWf66BUF3+5h3Up+VlAS77CUTqvW5P78pinBh+h+ZShC8avu17n5Y0IAxRqG7odgVz9v0dWIx9uLasOySNZTDFvmc591MBxMYAngtLFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869807; c=relaxed/simple;
	bh=/cxJU6vGAsQflUr/+ZE9vbpP5RWmAFwZncC3phpHqKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDFmXpkP+QPVJ4GQYZuavW6o6bsvuDuoLZRuuw8vqwbmDBJcvm+/l8LqHp0N/yAdOpgoPO2g25agIuZW9aepcFF5THu9lOYMvLGEsvxk06KXWP6+moE8+mKL3OTtS0SQdxvxA3BQlJ+rblrR4t36iZKskzcvsTj+y3RmeVObG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmehJVc+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767869799; x=1799405799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/cxJU6vGAsQflUr/+ZE9vbpP5RWmAFwZncC3phpHqKM=;
  b=jmehJVc+L7xtjDVCRabq/wqHHUkjgXX36nUgCikKuKg7FPqIFYvpdZNK
   wH3OIU6SIBCRAi8H/S8rHQZ7ElhuRpJbpiMZe6XmXVpDAsNsNER0WrGR/
   QdoyJowHsXXpVRtLqRdSzME1L4xs/Naj1cirB/c5Om8XvxTBTPmlokuC5
   K49fed19bZJayVIZiCQyoZff2hgyCgU4KSQ7EUrMJoeCtTW7MVfAgt/As
   pDvh+PLhWXIoXTsrt/O/YYb3IzxTlUFBcDWzDY93UxQnmxkHmGTJiTC7D
   X7tdeOq6y5ModNQIoyDGnWeQnlEPh4QW+xkcsOMNa4+t84OHSVcrkgIQZ
   w==;
X-CSE-ConnectionGUID: 5n5yLmH0TvK63o+k6gJXMw==
X-CSE-MsgGUID: QwM/4aDNS+KPcKjKufkRRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80354547"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="80354547"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:56:27 -0800
X-CSE-ConnectionGUID: J4Qr4JKcTiKmKvrG3ivuJg==
X-CSE-MsgGUID: wvoTnZnrRaiKzhZI7CYxBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203615536"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 08 Jan 2026 02:56:21 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4179499; Thu, 08 Jan 2026 11:56:20 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
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
Subject: [PATCH v5 01/13] scatterlist: introduce sg_nents_for_dma() helper
Date: Thu,  8 Jan 2026 11:50:12 +0100
Message-ID: <20260108105619.3513561-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260108105619.3513561-1-andriy.shevchenko@linux.intel.com>
References: <20260108105619.3513561-1-andriy.shevchenko@linux.intel.com>
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


