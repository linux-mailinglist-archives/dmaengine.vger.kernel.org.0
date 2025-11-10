Return-Path: <dmaengine+bounces-7109-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB95C45FB1
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 11:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D096134720B
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 10:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640F8305960;
	Mon, 10 Nov 2025 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkTqx1k1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D0301707;
	Mon, 10 Nov 2025 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771095; cv=none; b=JULqXqDpu6CGKnx4E1EIhXiqYn+hcmyjxvANre7x5j2C0wgNHldg+9inSZgb5chtPaY4LuvLF0OUa0Ns3WO6OMScFtgc/rDAAlIx/+XqVRYBvRzhxzhrOztFu4qbWIt2MoUy0kG3eapzbRox1QdSAS1ypQ1cTdQBk1VthH7+hm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771095; c=relaxed/simple;
	bh=4Zh3TL69b+gdWcKPQcymDHz8XDu0tfbcYP+gfBoy5co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KI8kQfPcydKhKFm/MwMT7/GZaargpOHpMin45ZlftE9qf5cr/oKh7T5VteHxbaLKv36TJEm6b9K+EDhoS9N5fPJa/6iYwrAZQWNAq6RPDpvfckVTvbMHFW0/7apS82SKBEVJqyXZvue2TVBPD34HWt/aAlbvu1cYMjgOqiy1IJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkTqx1k1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762771093; x=1794307093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Zh3TL69b+gdWcKPQcymDHz8XDu0tfbcYP+gfBoy5co=;
  b=NkTqx1k1XqeHxCl0tlW+6hs1SskXoJfEbu4MLnY+UNofERDnAHUPiYSC
   bTENzDF4ODffLtM99+JjrdafVYXCGb0SQiMO0YcgRpHQexpG3DzwU2jMv
   3GxiUWvUtI0AnDUliEqFUcaOsg6KhbHY3JUkQdFwvGK9LuTDjyAhzslUD
   Y6eS8hq2ChJIIW1AKijMDsM/3MCYEJGm+txc30jz8F9R0i7n7evN3XtMx
   1uW+gP/CuJilA8C7vtX4xiE4g3XXW3CGpb+LQNmWCBaURBdPgUtGjwM5L
   s0+CAK+VwuGjRvPOPb6Wwrsj6BeMQUIuifQSjWvX5qY9EFezGmPdor8C+
   w==;
X-CSE-ConnectionGUID: /2ZTt2uXRNC47+i7t4mFRg==
X-CSE-MsgGUID: TlT6hiEUTzuhKiAucTs9Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="68677982"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="68677982"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:38:13 -0800
X-CSE-ConnectionGUID: ihaVOzPVSqKkglaDulk+Iw==
X-CSE-MsgGUID: PRC7eIlSQ/mEwofKKs5zLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="189081440"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 10 Nov 2025 02:38:08 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 73E7A98; Mon, 10 Nov 2025 11:38:07 +0100 (CET)
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
Subject: [PATCH v2 03/13] dmaengine: axi-dmac: use sg_nents_for_dma() helper
Date: Mon, 10 Nov 2025 11:23:30 +0100
Message-ID: <20251110103805.3562136-4-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/dma-axi-dmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 5b06b0dc67ee..5d4436e7d2ee 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -674,10 +674,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
 	if (direction != chan->direction)
 		return NULL;
 
-	num_sgs = 0;
-	for_each_sg(sgl, sg, sg_len, i)
-		num_sgs += DIV_ROUND_UP(sg_dma_len(sg), chan->max_length);
-
+	num_sgs = sg_nents_for_dma(sgl, sg_len, chan->max_length);
 	desc = axi_dmac_alloc_desc(chan, num_sgs);
 	if (!desc)
 		return NULL;
-- 
2.50.1


