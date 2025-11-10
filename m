Return-Path: <dmaengine+bounces-7114-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E14FAC45FC7
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 11:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4CB14E8E5C
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 10:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32BA30C36D;
	Mon, 10 Nov 2025 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaqJU7wx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5E30BBAB;
	Mon, 10 Nov 2025 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771100; cv=none; b=COtw7gKYiGVYJgKgReZ52HZbko3qypQHHbWgdQo3YJGAavaOgmwgklpTfCmSq3hXjCvDq+D9BwA/S5RJu6sT+FsKFDUyHp6VK44V6Yi9krRnoP782Fa0iYuC2ms+V66upH4uQCxdrtdUVVmLfgCssX1P64eNLonfokL0cUeD4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771100; c=relaxed/simple;
	bh=XsqlCtPiLy+XmIRbck4ylskBkeyrZIVThqfjAn1sq0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPgrsZwtztxJMo+e0ApYS9UBNhQotmi1Zk5CrRrNjqLNHGzHRUqYd2z1fHg8CG/icwWtX44KqniPwr6sqzkMilfeJ9784WMANNzGYjP5Tl610P/yGjNXQ5CfOeNOLG8aLfmJ4TjhBZbLDGkqQStKe5ODR0j6ak53ifQPEWoZEIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaqJU7wx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762771099; x=1794307099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XsqlCtPiLy+XmIRbck4ylskBkeyrZIVThqfjAn1sq0o=;
  b=BaqJU7wxPYmjJfDG6zN4f1Fmg5B7QZxmv8GY8EEwKRhx5T4CKOb83X2M
   m0rCNWgla+Hguworxj2EXjyysq1ekuRfUaclIIW1gTaF3mlAIzqzkhVgn
   i7Xl8zoL2i/QYeuF4JDNFUtJMGdino1aOwt3ITrzgEYZHzzaD4OGiyuWc
   8+OnrACPqrHMXcw/eiVovJaYdZEiclgnR83SdpmAo2OqqF6G9TGw+YxFF
   zDVO/xbmN5zZ2Huahx8/duVFwZLXp3sAUDEi/H5wB8gVtjevbE0TGgrhp
   75Xn2En9Bg1jxeHzr5veqoaBIih6ee0JGaZOuyHilR/VPApzPNG8iCp3S
   A==;
X-CSE-ConnectionGUID: yJmnB4CnR5OC9SGNgxUjIQ==
X-CSE-MsgGUID: RHhzn2ZXSCOUwGZk5AnB3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75428656"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75428656"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:38:18 -0800
X-CSE-ConnectionGUID: YB99gmtmQfaV/LSvfgaycg==
X-CSE-MsgGUID: TRm5i9mLQvehQQMNp9VGpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192750714"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 10 Nov 2025 02:38:14 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 835C19B; Mon, 10 Nov 2025 11:38:07 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: [PATCH v2 06/13] dmaengine: k3dma: use sg_nents_for_dma() helper
Date: Mon, 10 Nov 2025 11:23:33 +0100
Message-ID: <20251110103805.3562136-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
References: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of open coded variant let's use recently introduced helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/k3dma.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index acc2983e28e0..88f9a2952edc 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -536,19 +536,14 @@ static struct dma_async_tx_descriptor *k3_dma_prep_slave_sg(
 	size_t len, avail, total = 0;
 	struct scatterlist *sg;
 	dma_addr_t addr, src = 0, dst = 0;
-	int num = sglen, i;
+	int num, i;
 
 	if (sgl == NULL)
 		return NULL;
 
 	c->cyclic = 0;
 
-	for_each_sg(sgl, sg, sglen, i) {
-		avail = sg_dma_len(sg);
-		if (avail > DMA_MAX_SIZE)
-			num += DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
-	}
-
+	num = sg_nents_for_dma(sgl, sglen, DMA_MAX_SIZE);
 	ds = k3_dma_alloc_desc_resource(num, chan);
 	if (!ds)
 		return NULL;
-- 
2.50.1


