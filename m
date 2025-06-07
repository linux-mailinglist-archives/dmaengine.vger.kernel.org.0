Return-Path: <dmaengine+bounces-5326-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE76DAD0D88
	for <lists+dmaengine@lfdr.de>; Sat,  7 Jun 2025 15:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE8D18969FC
	for <lists+dmaengine@lfdr.de>; Sat,  7 Jun 2025 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9189A1C1F05;
	Sat,  7 Jun 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpZ7oLAP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E7A22541D;
	Sat,  7 Jun 2025 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301590; cv=none; b=LVTWjBl34dG/PUGNejW9kRiRDfNC4/FmL1m4M9+Ef/1QBP0+cwbm0CM1aKFok7m3YEDP322xbQJ3fmfBb7qxFUiLhgTNBaLPdvu1A7hZxjr35XXhx3xdTNR7ByBlrEdsMIKaSyyO0heZATa4DW/34bD967VXOq8FkION61ZE9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301590; c=relaxed/simple;
	bh=TRCBx/dlu/Usj7MGTdFl2eC87AR0McHpxfl7Hi/VT5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGWq4ep30/cClAaCEcJ1rVnpc42YP2pyyZylS5ZhLR5pvxY4LoY9bngNg+Lm485298fronO25+RbG5qjgn0MLr1dUnEBCXm3FZe+OTtOfWHkrd9DUk48r4760gJ/QMn9NiDQAJPoDhtv6pssnxkTpsxQQOss7s9NGDTW93aHPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpZ7oLAP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749301589; x=1780837589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TRCBx/dlu/Usj7MGTdFl2eC87AR0McHpxfl7Hi/VT5c=;
  b=CpZ7oLAPsisKNDyWeP637/4FPG1J1bs+02RDinLsTniJmwZC95ZLj8H2
   idFGbn1L+zocDACRi4crUMiDvuGb7To2Pf3QTvzsviaNIMJ6Br5CFnf/N
   yR0H9yqN31yp/zKkXbOZB7dRjb9rnkbzoa7oLK/kA+ufLi6d9nbnxBGdu
   4Fuq4a38m45YbdrDhN3GVHFmh42zhAeHkO/plC9sYfwERe19P3gx64IZc
   m+PI/iDG+Y6lSS9GtOsvd560xibh2j2B+1GNBwapj5HdLRs2BNDOolkui
   2L2ODXERTagOFyjhMLRFBPXIJz2BmNG4XA1h3s6wydx+HQ94okukoZljH
   A==;
X-CSE-ConnectionGUID: znDqTlLpS/qQUSiGPn2v1g==
X-CSE-MsgGUID: t1jDaxBuSMCLdy/argRefg==
X-IronPort-AV: E=McAfee;i="6800,10657,11457"; a="55242777"
X-IronPort-AV: E=Sophos;i="6.16,218,1744095600"; 
   d="scan'208";a="55242777"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 06:06:29 -0700
X-CSE-ConnectionGUID: q5jblasBSD67E45YIRGEQw==
X-CSE-MsgGUID: 39mMbY5OS26UA1KPo26CpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,218,1744095600"; 
   d="scan'208";a="151074663"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by orviesa004.jf.intel.com with ESMTP; 07 Jun 2025 06:06:27 -0700
From: Yi Sun <yi.sun@intel.com>
To: vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com,
	gordon.jin@intel.com
Subject: [PATCH v2 1/2] dmaengine: idxd: Remove improper idxd_free
Date: Sat,  7 Jun 2025 21:06:15 +0800
Message-ID: <20250607130616.514984-2-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607130616.514984-1-yi.sun@intel.com>
References: <20250607130616.514984-1-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The call to idxd_free() introduces a duplicate put_device() leading to a
reference count underflow:
refcount_t: underflow; use-after-free.
WARNING: CPU: 15 PID: 4428 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
...
Call Trace:
 <TASK>
  idxd_remove+0xe4/0x120 [idxd]
  pci_device_remove+0x3f/0xb0
  device_release_driver_internal+0x197/0x200
  driver_detach+0x48/0x90
  bus_remove_driver+0x74/0xf0
  pci_unregister_driver+0x2e/0xb0
  idxd_exit_module+0x34/0x7a0 [idxd]
  __do_sys_delete_module.constprop.0+0x183/0x280
  do_syscall_64+0x54/0xd70
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

The idxd_unregister_devices() which is invoked at the very beginning of
idxd_remove(), already takes care of the necessary put_device() through the
following call path:
idxd_unregister_devices() -> device_unregister() -> put_device()

In addition, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled, put_device() may
trigger asynchronous cleanup via schedule_delayed_work(). If idxd_free() is
called immediately after, it can result in a use-after-free.

Remove the improper idxd_free() to avoid both the refcount underflow and
potential memory corruption during module unload.

Fixes: d5449ff1b04d ("dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call")
Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 760b7d81fcd8..504aca0fd597 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1324,7 +1324,6 @@ static void idxd_remove(struct pci_dev *pdev)
 	idxd_cleanup(idxd);
 	pci_iounmap(pdev, idxd->reg_base);
 	put_device(idxd_confdev(idxd));
-	idxd_free(idxd);
 	pci_disable_device(pdev);
 }
 
-- 
2.43.0


