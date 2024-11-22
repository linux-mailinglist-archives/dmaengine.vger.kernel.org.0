Return-Path: <dmaengine+bounces-3773-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29E89D6655
	for <lists+dmaengine@lfdr.de>; Sat, 23 Nov 2024 00:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9DAB21A7B
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 23:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15D01A4F22;
	Fri, 22 Nov 2024 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eyz2BUuL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981017D341;
	Fri, 22 Nov 2024 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732318236; cv=none; b=OuX3AMV1zp6ALvkAVwQQVZ5iwd772m8uwP1Kqw9BCxrnka8TIWFAPPur76+slVJxrqCNztceEmN5cfK4OCtovzwDiyVL68mA6ETLI8xyOZgF5PzYAxJedXPKAXtRgkePZ9ftXyM9yt6fjbDGU+86qLclXaJUWz9Xn4j6kj0bzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732318236; c=relaxed/simple;
	bh=JjVNjErFpwfEM4XLRC33DIZITSXkrWQ7voUX19gT+pc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F6kzHuH97WrtlPuXyTbLWodbH+TGRDVJXETJIxEfvUq/7hi4WRsD8CLYyGb5AMyVatmoZ0gz0AZpvet4ZQmjubWeO795WBFpsOxzDw9dl66WE6QlMFs+SqxLCQn5ZSKGHa+CzL4/kf0AEhmI+nFSuC5nLn2TJV118dX+NaCeMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eyz2BUuL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732318235; x=1763854235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JjVNjErFpwfEM4XLRC33DIZITSXkrWQ7voUX19gT+pc=;
  b=Eyz2BUuLDABSo5LhyumzYUq76tBvGx+965oyOYBB9Vg9IydyM6xbY5tm
   WA7w8VawRcOkGGnE4Gs1EsTsdo6csnONlodonZtj1Cd9qAJTLX8mPw9iC
   s6TLU2T2qP29IQMcjYwCvH7xs9Q818duE9XDmBi3DPk+8n2vQJGcaHt6U
   N7fYscYo6wGrAp5wozSTwLkKBaSXHuiG1//ff07LNmedDih4QIwXecxhO
   mBp6TkdBn7LJIivlwvX/pVYP8RMouGoDnGYcGjhwGSaqdHKTpbjvitTuZ
   00fTEkViGL8T1foQvTXd3Lw0QqfmKZDNoogL+Kk4+nTO777KrDfS7O2Ke
   g==;
X-CSE-ConnectionGUID: 2GAJ+3b+QUW3wb74gGakkA==
X-CSE-MsgGUID: foySGTvESk6NNWOtMXdcVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43134417"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="43134417"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:30:34 -0800
X-CSE-ConnectionGUID: 0zi4EtxZTaCAFYeYcXl6vQ==
X-CSE-MsgGUID: 16iACC0PSF6gStte2cs7xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="95127787"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa005.fm.intel.com with ESMTP; 22 Nov 2024 15:30:34 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 0/5] Enable FLR for IDXD halt
Date: Fri, 22 Nov 2024 15:30:23 -0800
Message-Id: <20241122233028.2762809-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When IDXD device hits hardware errors, it enters halt state and triggers
an interrupt to IDXD driver. Currently IDXD driver just prints an error
message in the interrupt handler.

A better way to handle the interrupt is to do Function Level Reset (FLR)
and recover the device's hardware and software configurations to its
previous working state. The device and software can continue to run after
the interrupt.

This series enables this FLR handling for IDXD device whose WQs are all
user type. FLR handling for IDXD device whose WQs are kernel type
will be implemented in a future series.

Change log:
v2:
- Patch 3: Call a free helper to free all saved configs (Dave Jiang).
- Patch 3: Replace defined bitmap free function with existing
  bitmpa_free().

v1:
https://lore.kernel.org/lkml/20240705181519.4067507-1-fenghua.yu@intel.com/

Fenghua Yu (5):
  dmaengine: idxd: Add idxd_pci_probe_alloc() helper
  dmaengine: idxd: Binding and unbinding IDXD device and driver
  dmaengine: idxd: Add idxd_device_config_save() and
    idxd_device_config_restore() helpers
  dmaengine: idxd: Refactor halt handler
  dmaengine: idxd: Enable Function Level Reset (FLR) for halt

 drivers/dma/idxd/idxd.h |  13 ++
 drivers/dma/idxd/init.c | 479 ++++++++++++++++++++++++++++++++++++----
 drivers/dma/idxd/irq.c  |  85 ++++---
 3 files changed, 507 insertions(+), 70 deletions(-)

-- 
2.37.1


