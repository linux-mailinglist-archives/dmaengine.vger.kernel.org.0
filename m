Return-Path: <dmaengine+bounces-7316-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 150CAC8066B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 852E03436AB
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E453016E2;
	Mon, 24 Nov 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8CuPq7n"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E682FFDD6;
	Mon, 24 Nov 2025 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986344; cv=none; b=eQr0H0hnUIPA6WLwbbaU73ia8EWRUpB9c0hF50Hg1YzSMnWLmDjOIVl+Ts5j6YLkmWQeRJOKaejH0zKaC9fLMpQu7SpC4Xf00wM6bk9YEhMNkDjqK+eDZ+m7ySMOmyLzijJ7pL5QYhR5WAKPp10jLKUhMsiCd2VGBEs05oKxrVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986344; c=relaxed/simple;
	bh=noDJxCmlGW2l/RNKrw+Y3WhNwmbPyJ6mAjM7+Omfh0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHF6u1HL/NphVMCSvpgD0Zmf9OCTQ5DRJaL6OEhPF5QxKqldh+hVthANtdhlIZb6YPHKBrIaFpZ8e1XleA9wt2eR4kEW3rgL3Mq5Dx2pRqQqJcL3bqzj5P+syPe8oBmoZmBQX+rH++L1HLUcuWXTiuUpnpLOPl+5Uj6vLzV0EyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8CuPq7n; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986341; x=1795522341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=noDJxCmlGW2l/RNKrw+Y3WhNwmbPyJ6mAjM7+Omfh0g=;
  b=a8CuPq7nwnmL/ykXOaeg8J0CdV7saios3JLVlXRKfTtsqA/h8zRobH8N
   rDGoljOdw6hVQl1wZGhHSCdoG6kwImGinOrvQr7uVRHzOIaPANd63VyZt
   vzejbSlSGgH3WNDafgRw2nkYig8u4dK40mqCg/g+nVWEib0Tcd+7d5ymN
   116yQxJft0/1cIeFsNGa/ZcPrHbFlm5BeHyeLQ/zQgkgpKkF95mE94EyY
   HwDpoABgX4k1h4QgRjweDkr9VDWSIJvX0sOmJl2Z3Ybzi4MTphIvuL+p3
   XuoAvHCUMlcOQsQ/ZnWmFPoiKbd7W44HCTwLk6DbFpKpeGrQ4ScWVwUtF
   Q==;
X-CSE-ConnectionGUID: o90D4kf/Qf2H8ZLCD0yTDg==
X-CSE-MsgGUID: UTLaULJESh2ULfKJ6PN66w==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="69847604"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="69847604"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:12:16 -0800
X-CSE-ConnectionGUID: ul+nTSsMTxuky5teU59mmA==
X-CSE-MsgGUID: Lw/TYoX5SQSD+IXZODL5KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="222970345"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 24 Nov 2025 04:12:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6F30AA9; Mon, 24 Nov 2025 13:12:03 +0100 (CET)
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
Subject: [PATCH v4 09/13] dmaengine: qcom: adm: use sg_nents_for_dma() helper
Date: Mon, 24 Nov 2025 13:09:27 +0100
Message-ID: <20251124121202.424072-10-andriy.shevchenko@linux.intel.com>
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

Instead of open coded variant let's use recently introduced helper.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/qcom/qcom_adm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
index e0f0c6f42c1f..aeb01b7087e2 100644
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


