Return-Path: <dmaengine+bounces-2637-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D4B928D5E
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 20:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5A6B2225A
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 18:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08915262A8;
	Fri,  5 Jul 2024 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7VjPvaN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542BE224F2;
	Fri,  5 Jul 2024 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203321; cv=none; b=a9PqHSfMVFCiQLVCHAQbZFSpMGaznAxTqpSJbdT0fD+OWW2cnPFQ+kHeNE8M2MurxeOJdogEHWseNTov6wSBcmqbGqjeuxbvvQKPEmH67f2067fAoW2lLFj/91hOHafEgy4FT4SLcoArLAGiPFvyU+4dE3GhRztz7yNMVAwkX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203321; c=relaxed/simple;
	bh=kS7EfrqmMLPCfTSA0oSje2k+PTqM8YIGfH6XLHRZNTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oATixe1RXtoddIGJ0/rxDSNsFcwy7DBUL56DBdY0ot9L+R1Ypl1yHXz5yd8t2qAOXQfqtare5JVFMWezHuUFQXze4nChV7GvZcqwPN1iHupcQeMspRpswkDF6/tOnrFxjG+wAYzcUu0lIepTTwazhQgsaEnAwk890gFhOrP9RL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7VjPvaN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720203320; x=1751739320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kS7EfrqmMLPCfTSA0oSje2k+PTqM8YIGfH6XLHRZNTE=;
  b=k7VjPvaNk7sXWsBCHM4SBV2VFZT2W8VFgh4Kjjl8ToiGhjmtlW4r1bbh
   EXrnvXNThMurNoe5blrwPUhyrwxe6guPmzuOeFTDqjcXcUcsKtdbhgHNk
   9yDAwHRMuy89roplc64oqRask9luL3+d7SNQ8vkzfIwK2W5X5V2XWHm7B
   H7Wu8WwND+5ymaOlENHpOCs3QCh1nhRl814DWGhnlU5wXkF50xNilShRp
   EvRLkIxPnQAZCiqqJyDr/55tHTPxwNSH5NgKIcqJyiWB5DV1CX2rNSRYf
   vnch0qrfyA5/aMFLt5mny99/iMUnJEzf+ywVgeZuWxnRICEQW5piVC4Kc
   g==;
X-CSE-ConnectionGUID: bb7/KZNeRNOW5inUrM9vBA==
X-CSE-MsgGUID: DclUgzYrQRWXw0YFCEDU6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="12410717"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="12410717"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 11:15:19 -0700
X-CSE-ConnectionGUID: 19uZAlpaSQG9i/tZrWkXIQ==
X-CSE-MsgGUID: Jq1TIjZuSsWlpPghVmxh2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="47672691"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa008.jf.intel.com with ESMTP; 05 Jul 2024 11:15:19 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 0/5] Enable FLR for IDXD halt
Date: Fri,  5 Jul 2024 11:15:13 -0700
Message-Id: <20240705181519.4067507-1-fenghua.yu@intel.com>
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

Fenghua Yu (5):
  dmaengine: idxd: Add idxd_pci_probe_alloc() helper
  dmaengine: idxd: Binding and unbinding IDXD device and driver
  dmaengine: idxd: Add idxd_device_config_save() and
    idxd_device_config_restore() helpers
  dmaengine: idxd: Refactor halt handler
  dmaengine: idxd: Enable Function Level Reset (FLR) for halt

 drivers/dma/idxd/idxd.h |  13 ++
 drivers/dma/idxd/init.c | 478 ++++++++++++++++++++++++++++++++++++----
 drivers/dma/idxd/irq.c  |  85 ++++---
 3 files changed, 506 insertions(+), 70 deletions(-)

-- 
2.37.1


