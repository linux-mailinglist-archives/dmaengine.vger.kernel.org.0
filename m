Return-Path: <dmaengine+bounces-5515-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B83ADC831
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 12:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A9F1891E5E
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E389291C13;
	Tue, 17 Jun 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVnLnf/j"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76600288CA5;
	Tue, 17 Jun 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156074; cv=none; b=Up/llgG5os7rfxnlKPuh57w05CIPsiEmdgd1mJ0BpdWha9mVBScELHpLbLppRFbLSiQ0fkICI43/2e9T2BeLBxSOzYdeX0TLGrhjb6Hn8l498GGsJffGjNlL1Al8K59pny4EO90MD6ZFQlJHVF6vxL3AaXwayRUvZFNJs/RypkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156074; c=relaxed/simple;
	bh=gqV21TcK9Cc3ulZOth7BRdJuQAZrSi3YuwCV5P2/3fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqmgVOWgKUr3zceXM5FwYyRLDatsv1K5qg8hRDbyz0BW1AxyAul7UoBzQA1Upsd+kDjmmDijGcudH4fOm2OV3ZZzGczOOj2fyqYkvR/sksdfN5hgv4HmKPn4r3VoQ0EBj6H36oPzQ/xQtGTQm+AbHWrTBD6g5yDaOqK9ctWPH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVnLnf/j; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750156073; x=1781692073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqV21TcK9Cc3ulZOth7BRdJuQAZrSi3YuwCV5P2/3fY=;
  b=MVnLnf/j4EmQI2rTMgah4O4yMqXX5u/9oaKlU9B3FMsNKNxfiwb+KM9Y
   MIDc1o/iMPPUH449AY7w+sRG1BEJ61parNnZwaGa5wYVqzSU9YcMtKivG
   Z796oXkdgg371B6oDRy5U3wp9Eze6fktBE7wB+9N3pWpPbwpbolZUlw/z
   3Mfm9Zt0tOE0THLbT3XkPiaRldumA1Ye1wWXgXViwdCUHXx8sBMs6C0Xz
   T3kfQjQTYZwlcPC+NtKuffcWmnqrDynC5mduqBdIqVZ61q1D8aNjdsk/n
   Q50pUSPkyIKQK2JGgEwZshYbNPTz8wyH95Cu38KS8J1Dgb4MnP+GGD7JF
   Q==;
X-CSE-ConnectionGUID: IBUGp3h8StSt+jwt0GWJWw==
X-CSE-MsgGUID: ochE/QEaTFe2R6xyVIOhIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52462100"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52462100"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 03:27:53 -0700
X-CSE-ConnectionGUID: lwt4GzZNQpG3EDFu5X4pPQ==
X-CSE-MsgGUID: UzK3sOE6T+WPbk/BM/Nabg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="154033970"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by orviesa005.jf.intel.com with ESMTP; 17 Jun 2025 03:27:50 -0700
From: Yi Sun <yi.sun@intel.com>
To: vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com,
	yi.sun@intel.com,
	gordon.jin@intel.com,
	fenghuay@nvidia.com
Subject: [PATCH v3 2/2] dmaengine: idxd: Fix refcount underflow on module unload
Date: Tue, 17 Jun 2025 18:27:12 +0800
Message-ID: <20250617102712.727333-3-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617102712.727333-1-yi.sun@intel.com>
References: <20250617102712.727333-1-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent refactor introduced a misplaced put_device() call, leading to a
reference count underflow during module unload.

There is no need to add additional put_device() calls for idxd groups,
engines, or workqueues. Although commit a409e919ca3 claims:"Note, this
also fixes the missing put_device() for idxd groups, engines, and wqs."
It appears no such omission existed. The required cleanup is already
handled by the call chain:
idxd_unregister_devices() -> device_unregister() -> put_device()

Extend idxd_cleanup() to perform the necessary cleanup, and remove
idxd_cleanup_internals() which was not originally part of the driver
unload path and introduced unintended reference count underflow.

Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 40cc9c070081..40f4bf446763 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1292,7 +1292,10 @@ static void idxd_remove(struct pci_dev *pdev)
 	device_unregister(idxd_confdev(idxd));
 	idxd_shutdown(pdev);
 	idxd_device_remove_debugfs(idxd);
-	idxd_cleanup(idxd);
+	perfmon_pmu_remove(idxd);
+	idxd_cleanup_interrupts(idxd);
+	if (device_pasid_enabled(idxd))
+		idxd_disable_system_pasid(idxd);
 	pci_iounmap(pdev, idxd->reg_base);
 	put_device(idxd_confdev(idxd));
 	pci_disable_device(pdev);
-- 
2.43.0


