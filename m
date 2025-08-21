Return-Path: <dmaengine+bounces-6105-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2A2B309B5
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F34AE07C3
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80952D24A4;
	Thu, 21 Aug 2025 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+72Keho"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A226AA83;
	Thu, 21 Aug 2025 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817211; cv=none; b=MW7fpDKG3oZIQTa0uLRBaYMq+k5QLS1febwU9GmenmXFlPNiJ8rqoTnFnr3IzjGR0Le43gzqMBOiYkhi6NzgAN/lD0OmmbVtzs00FzRCaH4SYL/cAB3KOX6x2lJ5caD0keSOCdfAgIPzzSvBQkP2ERXWOlJn/C59jGgrx5eZOtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817211; c=relaxed/simple;
	bh=ytFpAwEOCPsAjk6tJkIJ+onW7AKsz09Oxgs5MtaFIGs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=swXl8Dr0F849Ec7GT1b7aSEYt5r49D6WJrt7ZR4eEI0ePY54ladRuOeHApStJvm5+h/yW5uULJasX4r7MYBvKRHgjmqbd+HlW6AcGoutZiPQvm/UhCc+4MZadYHxJ/kbFYmMz38vrjC8c0BAhqrA5YMgt4iYzdoiGZhJmdrgDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+72Keho; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817210; x=1787353210;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ytFpAwEOCPsAjk6tJkIJ+onW7AKsz09Oxgs5MtaFIGs=;
  b=Q+72KehoVojckZEXO7yaWVt9mAB9+/D0eTY0v6IMOGmD3e4N+qNtcs4U
   oGBPbG5F2SzPQfmFA6Bx6rCUs1R90rCDrhwEIjCZTkxZLIwLBF4qf+emy
   GSuD3hqi96XuybXdn/zUJHSLPwxxBBBKmILh4h8XT/y1yDwlhkhLGyMJO
   Bujgpgjma0aojnc4QPs+bsQ4YxxwFvLFgeZgmNnkS8N6GFgr3cGAw2q1H
   G2xYwZa692HfZzsUN/YkQlRHGW+rvIHjPU3o3vgRiPSFaZ32BxsQ4GKX3
   tMt1gYUbv8wyOWnjg8R6tgUoFwNZ38VFQpCnlhZr2XBs+gyx7dZ75D0+2
   A==;
X-CSE-ConnectionGUID: rKf2XS9TSwehE4HusQOPYw==
X-CSE-MsgGUID: SRNLhNQKSOu5bqp/026gFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60748480"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60748480"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:09 -0700
X-CSE-ConnectionGUID: QQnSmKADQ3KUKxMP6wAVdA==
X-CSE-MsgGUID: Ah0/TwLSQFWDTIuYvWV1fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168444337"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.24.157]) ([10.98.24.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:09 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v2 00/10] dmaengine: idxd: Memory leak and FLR fixes
Date: Thu, 21 Aug 2025 15:59:34 -0700
Message-Id: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANakp2gC/5WNQQ6CMBBFr0Jm7Zi2QEpceQ/DAuhUJmKrLTQYw
 t2t3MDl+/l5b4NIgSnCpdggUOLI3mVQpwKGsXN3QjaZQQlVi0ZUGVeDlle0U0Dv8EHB0YTvhRa
 KmEqUpS111xstdQNZ8wqU70fi1mYeOc4+fI5ikr/1D3mSKLAioYTtba0GeWU303Qe/BPafd+/G
 +qwMtAAAAA=
X-Change-ID: 20250804-idxd-fix-flr-on-kernel-queues-v3-13f37abd7178
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-2e5ae
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755817209; l=2091;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=ytFpAwEOCPsAjk6tJkIJ+onW7AKsz09Oxgs5MtaFIGs=;
 b=k1GtBK4WqqgXjv37I5ZXI2pKlxb47VgVKs3u9xGeNrbUbD2XaU3h1raO9HCcAkVc5PhpkECHx
 lbg65uQ+IDHChkfgMZ/2e+yLqVPYHOZegCoyYfd6KR0HaKb5YfbQeDP
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

Hi,

During testing some not so happy code paths in a debugging (lockdep,
kmemleak, etc) kernel, found a few issues.

There's still a crash that happens when doing a PCI unbind, but I
don't have a patch at this time.

Cheers,

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
Changes in v2:
- Fixed messing up the definition of FLR (Function Level
  Reset) (Nathan Lynch)
- Simplified callers of idxd_device_config(), moved a common check,
  and locking to inside the function (Dave Jiang);
- For idxd DMA backend, ->terminate_all() now flushes all pending
  descriptors (Dave Jiang);
- For idxd DMA backend, ->device_synchronize() now waits for submitted
  operations to finish (Dave Jiang);
- Link to v1: https://lore.kernel.org/r/20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com

---
Vinicius Costa Gomes (10):
      dmaengine: idxd: Fix lockdep warnings when calling idxd_device_config()
      dmaengine: idxd: Fix crash when the event log is disabled
      dmaengine: idxd: Fix possible invalid memory access after FLR
      dmaengine: idxd: Flush kernel workqueues on Function Level Reset
      dmaengine: idxd: Flush all pending descriptors
      dmaengine: idxd: Wait for submitted operations on .device_synchronize()
      dmaengine: idxd: Fix not releasing workqueue on .release()
      dmaengine: idxd: Fix memory leak when a wq is reset
      dmaengine: idxd: Fix freeing the allocated ida too late
      dmaengine: idxd: Fix leaking event log memory

 drivers/dma/idxd/cdev.c   |  8 ++++----
 drivers/dma/idxd/device.c | 43 +++++++++++++++++++++++++++++--------------
 drivers/dma/idxd/dma.c    | 18 ++++++++++++++++++
 drivers/dma/idxd/idxd.h   |  1 +
 drivers/dma/idxd/init.c   | 14 +++++++-------
 drivers/dma/idxd/irq.c    | 16 ++++++++++++++++
 drivers/dma/idxd/sysfs.c  |  1 +
 7 files changed, 76 insertions(+), 25 deletions(-)
---
base-commit: 1daede86fef9e9890c5781541ad4934c776858c5
change-id: 20250804-idxd-fix-flr-on-kernel-queues-v3-13f37abd7178

Best regards,
--  
Vinicius


