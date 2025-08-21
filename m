Return-Path: <dmaengine+bounces-6112-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027ACB309C5
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C0360537E
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC352ECD3F;
	Thu, 21 Aug 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjUiMaWU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17C2EBB85;
	Thu, 21 Aug 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817216; cv=none; b=Q6Hj0p2x0VFjYzoo2eB22c0PzkjZicEa0KBXVj7HS+Q7ealOq0M3rugishxCQF6NDcjqg3u/WBcnhChkhTWvpEbtmTZ49NZ+qLaLMebzo/QjXd5+9eyWWvx4IbWkNRWwl4DFUiAdLrTGt84MbT5P3HjtdhEeuN2oUXs/s35XWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817216; c=relaxed/simple;
	bh=eLTK3oZaMnnq8VX6zD4DLG+0DDkxzaiClUQRvhGDtUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qh1L/JEdFFT5NsM523cTAfFOVkDk6a/UHln7h/F2EusR7f0urSTVEHqr/V7t+3BUu0qzfaJlBu5QeKcXzFqspriHCKKjaxW9IO0KMiiFO8X17WYIGg+IXVcd6Hd9hvX92Ufa3fxOYBhDeIyDNpntC1PMHxRGHqaeZn4ZR+qBE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjUiMaWU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817215; x=1787353215;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eLTK3oZaMnnq8VX6zD4DLG+0DDkxzaiClUQRvhGDtUs=;
  b=hjUiMaWUSAijGxyszu8auGCuPMrzmxR7oeJu8asUmYIlqXykEF031FYk
   bofNK0pPSWVhlujRnTG1aNG1yGkWr8c0diz/dZjsdCUyesdahhVX1HhId
   9NDoEjYoWIRiWrClzQBbnTPBfixG2/S2JfSdrgEOXuFYudvZEqpeGdfzd
   SKGJQn8fzZ5BPWkgr7/nPpRWbU6kBQFBrqA/ev0DxUP5Ebu5uHPFfa/uy
   oVWmjakB/RUJc5wVxrNLiNmT86gm2OFp5mEZjuh2xgdOk1JyrvvFLqFfT
   Vf8bKRGzKYRrwMIaB8DO8Xd4bAcyKtrTKzTC1+C6jSzw/1nUdSnKK3K7A
   A==;
X-CSE-ConnectionGUID: eIn/13ggSlur9uwHXvhUWQ==
X-CSE-MsgGUID: kNYwM4nATAug6qt3IoH9DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60748498"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60748498"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
X-CSE-ConnectionGUID: +pLTWXtpQgWlLMhyakB/fQ==
X-CSE-MsgGUID: 9P87EGdrRwyWDeHUr1PE2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168444364"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.24.157]) ([10.98.24.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Aug 2025 15:59:41 -0700
Subject: [PATCH v2 07/10] dmaengine: idxd: Fix not releasing workqueue on
 .release()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-7-595d48fa065c@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-2e5ae
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755817209; l=803;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=eLTK3oZaMnnq8VX6zD4DLG+0DDkxzaiClUQRvhGDtUs=;
 b=eQhOm3PO1EcgY+A3utUceYn9jDbif8cTs+wGIVPOaZdsfGluBggMT/w7LBpYEAQnDaWHX8Czf
 EfJbWi6lgcJBpqe1v/9+TAiZTAban8bkcOueEOA9RH+jVOcA+QYDUxn
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

The workqueue associated with an DSA/IAA device is not released when
the object is freed.

Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 9f0701021af0..cdd7a59140d9 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1812,6 +1812,7 @@ static void idxd_conf_device_release(struct device *dev)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
+	destroy_workqueue(idxd->wq);
 	kfree(idxd->groups);
 	bitmap_free(idxd->wq_enable_map);
 	kfree(idxd->wqs);

-- 
2.50.1


