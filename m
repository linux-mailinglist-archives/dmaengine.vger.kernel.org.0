Return-Path: <dmaengine+bounces-6113-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1B6B309CA
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2AAB655B9
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F502ED845;
	Thu, 21 Aug 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgwxWpqE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2BD2EBBAC;
	Thu, 21 Aug 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817217; cv=none; b=lAnsgmXYYz/axaAJbhRaTnGl6FbVeGDV76NmorTHFakVnq0fbt0mnknB6pJWw4f8rKAdBbJG2CTwl1Ljpl258kQosDbu3uWJrjjE/8AwxAvQzN3k2jhBAQLhq0g/dqcq3FKQ6jTdP58Nuflyk4vD7AqEKGh0OVYuf389YLJ2gkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817217; c=relaxed/simple;
	bh=AcUvlloJcRxP1Gh65pW1h/uhxTIyQhMoNri7bxjpC2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0ptD8QqBplZ6WrW5bgNVZTFKEBLcgNUDNnUYo8SwCHZ6lqES3AtCWC5XsWFIqjTCckyEB55xh9HlmscnXBy0reSGE634Uq/8VE5yohCFxpKf7mdYqN56REQTmUNAgb1upwajHN195tttN+g2kBibf5n0XDXzP1SXvpsAjk5fyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgwxWpqE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817216; x=1787353216;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AcUvlloJcRxP1Gh65pW1h/uhxTIyQhMoNri7bxjpC2A=;
  b=hgwxWpqEZh3nC5fUA40ezYNpCfu1SjD2QUfVoeWnlQYY5wp4REPW+4AG
   09r0tKRb+yz/AYtwCl/46Syb4ISvPPAoDQRET+groKMKTJB/2pBAF5YoB
   JneYt8hgYtDXI7LhuINE8n4m0oFZT0nU3oqro/pL/Fc1j81U8w6l1s9Aq
   e10p4ptjeyCLTg2CgkUJoKZ4HQ+l4Qy9sqJqca96XdmFQya4mTE0sTHn+
   RV06M7BUqLf0gnxWGR3uqN9dRr7IYf/BSsGhFH4OHRy/wiBm0F1tAqZPw
   GUFxTZTnMKyYBpShwVnGVNjfzFNSpJgLXzJrQ1QsBjStUXdNApXG7+RG3
   w==;
X-CSE-ConnectionGUID: maMIXh/2RJumEsODqk/biQ==
X-CSE-MsgGUID: 7AC5vyBPTyOBaf+CjQTZlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60748499"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60748499"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:11 -0700
X-CSE-ConnectionGUID: jPiQ1p2uRS+/n1yUmeSfhA==
X-CSE-MsgGUID: lm4fO7kiRZOAJapV+nAPbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168444366"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.24.157]) ([10.98.24.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Aug 2025 15:59:42 -0700
Subject: [PATCH v2 08/10] dmaengine: idxd: Fix memory leak when a wq is
 reset
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-8-595d48fa065c@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-2e5ae
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755817209; l=1614;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=AcUvlloJcRxP1Gh65pW1h/uhxTIyQhMoNri7bxjpC2A=;
 b=ozkczljI3PazGA+LNVQ8gxk62dVaTdJJnD/NUEFSheruantMHmxcQxUseyN1OAG+Fom+1NxnC
 pdAodInGN//CZyLg03qX0gL28tCMYAb/7WrVUtQ293BdaUR36tYu406
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

idxd_wq_disable_cleanup() which is called from the reset path for a
workqueue, sets the wq type to NONE, which for other parts of the
driver mean that the wq is empty (all its resources were released).

Only set the wq type to NONE after its resources are released.

Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index c62808e30417..ddce262853b0 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -174,6 +174,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq)
 	free_descs(wq);
 	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
 	sbitmap_queue_free(&wq->sbq);
+	wq->type = IDXD_WQT_NONE;
 }
 EXPORT_SYMBOL_NS_GPL(idxd_wq_free_resources, "IDXD");
 
@@ -367,7 +368,6 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	lockdep_assert_held(&wq->wq_lock);
 	wq->state = IDXD_WQ_DISABLED;
 	memset(wq->wqcfg, 0, idxd->wqcfg_size);
-	wq->type = IDXD_WQT_NONE;
 	wq->threshold = 0;
 	wq->priority = 0;
 	wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
@@ -1536,7 +1536,6 @@ void idxd_drv_disable_wq(struct idxd_wq *wq)
 	idxd_wq_reset(wq);
 	idxd_wq_free_resources(wq);
 	percpu_ref_exit(&wq->wq_active);
-	wq->type = IDXD_WQT_NONE;
 	wq->client_count = 0;
 }
 EXPORT_SYMBOL_NS_GPL(idxd_drv_disable_wq, "IDXD");

-- 
2.50.1


