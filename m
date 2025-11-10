Return-Path: <dmaengine+bounces-7116-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD3FC45FF9
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 11:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E508F3B63C5
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 10:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BCE30C61B;
	Mon, 10 Nov 2025 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/+TtB6P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B530BBBB;
	Mon, 10 Nov 2025 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771101; cv=none; b=GyYypZQnWW6aFKECSy4HH70XTJ/JFZiTzdNlGProcUEV1MUbxp0z0UuHE+aZYA9Va4uZfIQXpfHeCUL/stgwlNEqco+aKKqdHUQ/tatl/z2u3X5Q33byMpNCUFFZa3aGh9bgpRHY1mSJ+/RW4FQ7Gu58huQBv3GB4FZVHmS/z4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771101; c=relaxed/simple;
	bh=FVYq9jhKnLoWvvNaF2UoF2l9OnxxHFIvRoR7/5QiK/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pb1ms1pbAX368NMx4w3ry5udPLhop+aiP7OOtnkTd06gSgOEH2zpON05Oxuf7WdaC4WZBs4GO/kKeQ2ND6jrEUKpilXFF+U46SShHo163k1tW+1Ai4jc1JMyNJGnsdiPo9PVk9o2QZUtxKrcV5L0m7N63eXYbowT7UA/2bgBF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/+TtB6P; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762771099; x=1794307099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FVYq9jhKnLoWvvNaF2UoF2l9OnxxHFIvRoR7/5QiK/I=;
  b=j/+TtB6PpxMKVBGApCiQzd/KSdM1DXOVPCyLIcRHrpTVjQ4mHbM+zo6R
   ePlbY415JCwZt072k5WHUTEfyJjxS/HplZBdQ6HvL6IP3pwzmwrZ6ooZ0
   Y3UTV9FtbVj90YhE1KNSJn2wrHupseJb8lv/GXI7ZUBLTSrIoAVZuc6QP
   LDrufNzjz0dg/UexL6ncNDfT0t1bi7Xz3aY+/5MxJ6xdm1V7F5IcHBq7Z
   +5NxNhnakTOrftK9oJ0eysReWL2fAoY+Wq8M58yLHzWqzMm0mh9sOmL/o
   1oUywfS8MBWOymeRSdggbmb/tXlD+UmpwWB5swZbSDONlak2UcWO9KYmO
   g==;
X-CSE-ConnectionGUID: elJfZAKmStWd9dx/ACAO9Q==
X-CSE-MsgGUID: XRb9m5QbQNGyI68hoBhqDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="67425228"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="67425228"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:38:19 -0800
X-CSE-ConnectionGUID: 1OAI2T3eTcmOyt/qIdGftA==
X-CSE-MsgGUID: 3KHBWfu/Qo65fequlUDp1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193026324"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 10 Nov 2025 02:38:14 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 918539E; Mon, 10 Nov 2025 11:38:07 +0100 (CET)
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
Subject: [PATCH v2 09/13] dmaengine: qcom: adm: use sg_nents_for_dma() helper
Date: Mon, 10 Nov 2025 11:23:36 +0100
Message-ID: <20251110103805.3562136-10-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/qcom/qcom_adm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
index 6be54fddcee1..490edad20ae6 100644
--- a/drivers/dma/qcom/qcom_adm.c
+++ b/drivers/dma/qcom/qcom_adm.c
@@ -390,16 +390,15 @@ static struct dma_async_tx_descriptor *adm_prep_slave_sg(struct dma_chan *chan,
 	}
 
 	/* iterate through sgs and compute allocation size of structures */
-	for_each_sg(sgl, sg, sg_len, i) {
-		if (achan->slave.device_fc) {
+	if (achan->slave.device_fc) {
+		for_each_sg(sgl, sg, sg_len, i) {
 			box_count += DIV_ROUND_UP(sg_dma_len(sg) / burst,
 						  ADM_MAX_ROWS);
 			if (sg_dma_len(sg) % burst)
 				single_count++;
-		} else {
-			single_count += DIV_ROUND_UP(sg_dma_len(sg),
-						     ADM_MAX_XFER);
 		}
+	} else {
+		single_count = sg_nents_for_dma(sgl, sg_len, ADM_MAX_XFER);
 	}
 
 	async_desc = kzalloc(sizeof(*async_desc), GFP_NOWAIT);
-- 
2.50.1


