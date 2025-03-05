Return-Path: <dmaengine+bounces-4650-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93EA53E31
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 00:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89B67A1A83
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE452066F0;
	Wed,  5 Mar 2025 23:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrBT2fjY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F52209677;
	Wed,  5 Mar 2025 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216076; cv=none; b=fP4povMDAln5Fy7sJ/flR1FixwT3kajXOSixNT4a6UKDks26Hqf+dIykOz0WNjgimzxi/+CwU8wRgwF0OnldmVjv+STDVWT8iKAcKA+Q5GkquGJ2kkmPUDHrNGups8dFnCABmENWdJbaEE3AzjRuKLmc/+N1/UqXzXiBkBS+hN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216076; c=relaxed/simple;
	bh=uS2MSAg+MVM/rGjryVXZZPnq4lTMp2gC3my7S4+jqiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mEEmKLPkCL6mugKLSJ6A6TOzjF8HeggDGhXZ2A50IQg/gMYRP0X01E2GWS71bSPMxbgpUl3lZIKuYALprtSp4ylDZyuTLqAYxqrPz82YN006ns7pX97yY/rol+rUdBa4YGNUkv0m16R49x/qBiHtWpCwdDOUJYZ8yeM0HGcaRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrBT2fjY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741216075; x=1772752075;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uS2MSAg+MVM/rGjryVXZZPnq4lTMp2gC3my7S4+jqiM=;
  b=GrBT2fjYYNcKiA0Jn+9CfAFQcPvgwp2Zke6nfOEt3OULNwfYwmuPqNsr
   qMIsp4ls/dtMVxVMnG/iFjqzIsNUBFyk2D7IECMhXHJ8STzUo3WHcoPJ6
   iuVMc8RK31txp8J464CyzVB21Yn321lTEFhbOLVDuozpeOLD9wuhLEd7h
   7GNBhX1PwSaoRbTsnHDrUh5mNhlh6OXNCM/24b8k4wxfYzW3HRRVWB8jM
   967cbqbryNZ/+24QTxzERmwO3NKeYcxyVFeL7v9Bq6nuaNFzVnGzLn3f7
   BoTV0zHrzNNB1yrwEEq/TPFzv77q3b7PgSdUDWu7dFaItkwrhNjwKUnLM
   w==;
X-CSE-ConnectionGUID: CsqqGrHGQQCjxi4tTAtNbw==
X-CSE-MsgGUID: I3z3z5ywQWi68roMuWBZGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52852292"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="52852292"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:07:54 -0800
X-CSE-ConnectionGUID: OIvMAYXiS06JT7GfJImoUg==
X-CSE-MsgGUID: WW3DypU+SmqhnLYv/vI/fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="118844997"
Received: from unknown (HELO vcostago-mobl3.jf.intel.com) ([10.241.225.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:07:54 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com,
	kristen.c.accardi@intel.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when interrupted
Date: Wed,  5 Mar 2025 15:00:06 -0800
Message-ID: <20250305230007.590178-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the "wait for operation finish" logic to take interrupts into
account.

When using dmatest with idxd DMA engine, it's possible that during
longer tests, the interrupt notifying the finish of an operation
happens during wait_event_freezable_timeout(), which causes dmatest to
cleanup all the resources, some of which might still be in use.

This fix ensures that the wait logic correctly handles interrupts,
preventing premature cleanup of resources.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202502171134.8c403348-lkp@intel.com
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/dmatest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 91b2fbc0b864..d891dfca358e 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -841,9 +841,9 @@ static int dmatest_func(void *data)
 		} else {
 			dma_async_issue_pending(chan);
 
-			wait_event_freezable_timeout(thread->done_wait,
-					done->done,
-					msecs_to_jiffies(params->timeout));
+			wait_event_timeout(thread->done_wait,
+					   done->done,
+					   msecs_to_jiffies(params->timeout));
 
 			status = dma_async_is_tx_complete(chan, cookie, NULL,
 							  NULL);
-- 
2.48.1


