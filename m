Return-Path: <dmaengine+bounces-7158-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 308C7C58758
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F13CB4FB183
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F913559CF;
	Thu, 13 Nov 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NX6Ij+p/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F893557ED;
	Thu, 13 Nov 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046979; cv=none; b=oS1M9+9bHBbN060+GwTsHTl9Xj9Y6cGjhYy4m6v5gINz6KPwdrM7kKMaAnKqsfr/4JvqtMtI81nxDACSvM6tpznVxe0oywqAMNAOOme38TiehNpg85+b/8LofrRE0+SzXWwXT1dIehKqHgJugeJ+PS0HiBqcpmQDaCFphy0+7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046979; c=relaxed/simple;
	bh=aIZKpp2i1U4bYPp+lJpBExBX9TU2DJpWjDWAz41Iejk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwvhUqxByzceCPbBXGT44Hp5MtSJwFDEeA9qbi8slcRG0OzhWpgh5iofDMofntThFak/6JXWwODX2iOakF4rh+SQuLrjQJ/COQZyIXhIOnyUf/AUttGSyVGCjIbYB4z2JpGT7QXTumExFCVzBG9PwV47oIrPjES3SNgibpRRmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NX6Ij+p/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046978; x=1794582978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aIZKpp2i1U4bYPp+lJpBExBX9TU2DJpWjDWAz41Iejk=;
  b=NX6Ij+p/2GT8E90D8SxdspqbV+VM26hbiRQccyb/C5sKrXVWiyxHM4QY
   H1XNiXau4UauVYekc3kSsYcBl8GuZTSY4j5BYlFr0T1qX143qRJtO4gkn
   uGwMelGVCzBoQzC50l3S80YzGj4WpRXmyLd6KFFJWoDfvkfAeJU3+7IyZ
   QKak4xhwq2ZPtPhB03obwiVQrCvRQ0onzbTzaoeSTQg1Divz0sS20SOj8
   jgG+qQURrHQZzhYibHgzLxemQDn4RoCmNv6Z8bfOBCpT11aeCDT8G22Yj
   muE+BFsa8PFBabROFGxS5dPxLzymCQnlNtF0xQl6MND2sohvmP/Sggu2D
   Q==;
X-CSE-ConnectionGUID: 3C9rWzKHR9eR9OVrPM4LEA==
X-CSE-MsgGUID: BMTXTz/6TpSzXVQo1RsEww==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75740533"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75740533"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:16:17 -0800
X-CSE-ConnectionGUID: wjhhABpbSUGlxlItUqzAHw==
X-CSE-MsgGUID: RSO0QpruQw+tQAMQ6Xjwqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189792122"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 13 Nov 2025 07:16:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D4E309E; Thu, 13 Nov 2025 16:16:04 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
Subject: [PATCH v3 08/13] dmaengine: pxa-dma: use sg_nents_for_dma() helper
Date: Thu, 13 Nov 2025 16:13:04 +0100
Message-ID: <20251113151603.3031717-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
References: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of open coded variant let's use recently introduced helper.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/pxa_dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 249296389771..b639c8b51e87 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -970,7 +970,7 @@ pxad_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	dma_addr_t dma;
 	u32 dcmd, dsadr = 0, dtadr = 0;
-	unsigned int nb_desc = 0, i, j = 0;
+	unsigned int nb_desc, i, j = 0;
 
 	if ((sgl == NULL) || (sg_len == 0))
 		return NULL;
@@ -979,8 +979,7 @@ pxad_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	dev_dbg(&chan->vc.chan.dev->device,
 		"%s(): dir=%d flags=%lx\n", __func__, dir, flags);
 
-	for_each_sg(sgl, sg, sg_len, i)
-		nb_desc += DIV_ROUND_UP(sg_dma_len(sg), PDMA_MAX_DESC_BYTES);
+	nb_desc = sg_nents_for_dma(sgl, sg_len, PDMA_MAX_DESC_BYTES);
 	sw_desc = pxad_alloc_desc(chan, nb_desc + 1);
 	if (!sw_desc)
 		return NULL;
-- 
2.50.1


