Return-Path: <dmaengine+bounces-5738-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8025AF8A51
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 09:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A856E4AE1
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 07:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEB12980CA;
	Fri,  4 Jul 2025 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoLTr3rf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18A28D8D0;
	Fri,  4 Jul 2025 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615653; cv=none; b=fq9JSo4cmneU5L7239V0MC/wrwFW8CKefuHk+pXJR2/VKMQN0IF/EYw9djh6ufLkOe7q7eZ36fPWMxR//rwnd0qg2GoGKE+8y/NTzzxb9gX25Ayebwv4YYtRud40hd2N4ni3fk1wrUsdqZ7ea+2ZjcEfDs8e69jOxh80iUrebww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615653; c=relaxed/simple;
	bh=/CIbIR/zbhCjZ/cFIFqC/MmyrDN/rrFu56hCjz4GzXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gXwOe3IwHwGPRj0EuDHWnQdzvo8sivNxWZMVG5A34etbRvv/OAWUNTJaQZoqVVB1q/p9plBSq4P/TUnGtfGXuX1Ls5z6WVCUgo90t9RVJ2hO9845o2qpimWJXlBrnimacolBNW8IFfgI19UbFITZI/eCU1dyFEB/LpQVJHc13zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoLTr3rf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615651; x=1783151651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CIbIR/zbhCjZ/cFIFqC/MmyrDN/rrFu56hCjz4GzXk=;
  b=RoLTr3rfII7UDfrek4XJWeQWLLCxbGkEtdBZc9qH4n32fAOkTxY0o656
   gid/3SJBjBPpM8sX6z80+YaQBTExE8jtJanvKCb28N4Lz0GHbntWEhh+N
   ft84SZFEnuNvprRS1eAGwloHxgEMPOvpM9Xfbwybk3eVIAqS+xWVjQbNd
   YbA5UdHdVWmDDFn+8q7nmRwSnhhKRpgBqPRtXzsgwUi2ZMoCrzk2SpMW0
   HyJWp5dTC5DfaLDp4B5xr6hhbpQW0BfNuHdr1vWuo29keHDFDKubFuXBk
   Z4vuZ7Kr1+ghhWnlUrCyWIJ+mjlWkc/YvW485glZvCzSbFye8uPyVRAjP
   Q==;
X-CSE-ConnectionGUID: CPENT+9DRTWci19H2l50Ww==
X-CSE-MsgGUID: s5lMWusrQti1NEHkAk75mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494501"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494501"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:10 -0700
X-CSE-ConnectionGUID: gj+SqCv9QA+K8twjZgRmSQ==
X-CSE-MsgGUID: bEdlVY7kR+icdEMGIvk3Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924193"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:09 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id D917444910;
	Fri,  4 Jul 2025 10:54:06 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/80] dmaengine: ti: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:06 +0300
Message-Id: <20250704075406.3217578-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/dma/ti/cppi41.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
index 8d8c3d6038fc..88756dccd62c 100644
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -390,7 +390,6 @@ static int cppi41_dma_alloc_chan_resources(struct dma_chan *chan)
 	if (!c->is_tx)
 		cppi_writel(c->q_num, c->gcr_reg + RXHPCRA0);
 
-	pm_runtime_mark_last_busy(cdd->ddev.dev);
 	pm_runtime_put_autosuspend(cdd->ddev.dev);
 
 	return 0;
@@ -411,7 +410,6 @@ static void cppi41_dma_free_chan_resources(struct dma_chan *chan)
 
 	WARN_ON(!list_empty(&cdd->pending));
 
-	pm_runtime_mark_last_busy(cdd->ddev.dev);
 	pm_runtime_put_autosuspend(cdd->ddev.dev);
 }
 
@@ -509,7 +507,6 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
 		cppi41_run_queue(cdd);
 	spin_unlock_irqrestore(&cdd->lock, flags);
 
-	pm_runtime_mark_last_busy(cdd->ddev.dev);
 	pm_runtime_put_autosuspend(cdd->ddev.dev);
 }
 
@@ -627,7 +624,6 @@ static struct dma_async_tx_descriptor *cppi41_dma_prep_slave_sg(
 	txd = &c->txd;
 
 err_out_not_ready:
-	pm_runtime_mark_last_busy(cdd->ddev.dev);
 	pm_runtime_put_autosuspend(cdd->ddev.dev);
 
 	return txd;
@@ -1139,7 +1135,6 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_of;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
-- 
2.39.5


