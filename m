Return-Path: <dmaengine+bounces-5119-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6BEAB06E9
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 02:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9821C4C40FE
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 00:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BBC36D;
	Fri,  9 May 2025 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyePLuzm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ECF366;
	Fri,  9 May 2025 00:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746749025; cv=none; b=UqDcHVwAurK9Q8f/Nk/D3EM2G3LgyQONhywUZL35m3aM68QVJ0EUFH815L1OBszoEcbrHRYFWXJK5It92KuoSZlhlnAm3mkhS1x6inqNIFTTHXHO5O13+nZEX83ViDoYnAjPrwUKA4GaBH6KLzzSiAoGneNCYiSd4iJ7I+vHcGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746749025; c=relaxed/simple;
	bh=PQt8e1xAFZ8eIKrfvNojjNPt2OTrvDfKuaMser2n6k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjec0756fMjIcD+H0Hh2SUagzL3U0wPsseewE77nu+gvX4uozPQl8N6/xEOmB2GqcRUUfMtThM2QfKG5aoNYCLkQbMzI84VWIvCR7JRQY5KR7YT20tLsEIZtYcMJh4CaHe5nCs1RgWxoSg5KX+s/ny7mW/UXl2G7cvNy5jCFXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyePLuzm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746749025; x=1778285025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PQt8e1xAFZ8eIKrfvNojjNPt2OTrvDfKuaMser2n6k4=;
  b=IyePLuzmV/XUM0M/q30dbyXrotndfSoMVl0SoXJzsTkUjmG8bklREgLM
   UDacE1xFhWstlSof5MrPYCU57aiI0J0FCwBh/l/K++fI5v3lJPrhnOpbk
   ws1xwf24qZCE04nK2UGsQ/63aLL7KIkfn/v/SoJnxiJVCldJaVJMvYtCV
   1fzs2xWz7pV7u1jEdsg6wRbgUoMKHz+DphsifTA1iBfA5cLNZRt5zR4Fo
   g5mXTICwvdQxL1oAW82tLUDsqZk+u2vucBmpz9e812pauZR9Wrq1N/wo4
   4MZHnuIVYAdD4rraiSvSzy/ec2K+aXUHJFyGU1OZ7uxQMUYwNtA8+P0fJ
   w==;
X-CSE-ConnectionGUID: tnjfghglRaCRVxMj1ANeiQ==
X-CSE-MsgGUID: bP5KMTTrRcSxFcy7seF0bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48718299"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="48718299"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 17:03:44 -0700
X-CSE-ConnectionGUID: j4ukEc3GQXiSFLuNX15uVg==
X-CSE-MsgGUID: Qfbdvj+GQPecG3llgt2W5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="140494561"
Received: from sunyi-station (HELO sunyi-station..) ([10.239.96.51])
  by fmviesa003.fm.intel.com with ESMTP; 08 May 2025 17:03:41 -0700
From: Yi Sun <yi.sun@intel.com>
To: dave.jiang@intel.com,
	vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com,
	anil.s.keshavamurthy@intel.com,
	gordon.jin@intel.com
Subject: [PATCH] dmaengine: idxd: Check availability of workqueue allocated by idxd wq driver before using
Date: Fri,  9 May 2025 08:03:04 +0800
Message-ID: <20250509000304.1402863-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running IDXD workloads in a container with the /dev directory mounted can
trigger a call trace or even a kernel panic when the parent process of the
container is terminated.

This issue occurs because, under certain configurations, Docker does not
properly propagate the mount replica back to the original mount point.

In this case, when the user driver detaches, the WQ is destroyed but it
still calls destroy_workqueue() attempting to completes all pending work.
It's necessary to check wq->wq and skip the drain if it no longer exists.

Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ff94ee892339..a202fe4937a7 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -349,7 +349,9 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
 			set_bit(h, evl->bmap);
 		h = (h + 1) % size;
 	}
-	drain_workqueue(wq->wq);
+	if (wq->wq)
+		drain_workqueue(wq->wq);
+
 	mutex_unlock(&evl->lock);
 }
 
-- 
2.43.0


