Return-Path: <dmaengine+bounces-8181-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A03D0BB5B
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 18:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A59FA30437AC
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03522368261;
	Fri,  9 Jan 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAYrP13z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150233AD89;
	Fri,  9 Jan 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980245; cv=none; b=mwZ3BN7+cURNgPTBDM/JUlIZ8PgjtfaGAn70hUQnVEtZHJ762S80vktXegWDjjuGSfecRwSQjbx52wZV4Lm7kTq/qwn1/JZX/BuVJo8CSQ7tDoR6cZlQ4K4NNPzO6GfMBfqnZCyGlvT622k8KJZPoib9sqvB7j8DAjGqScSkjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980245; c=relaxed/simple;
	bh=6D20sLJm4brDMSdvd7JdzurQBl2Gfob5k4qwI5PXFPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0u1IVkU4L4OkA8ci93vmOO6n8g+SLSduEAjVdSaU874pxNzJo4ciDg1C2EBYui9Ulj0ahI3OgNfKX0nQaV+bOrx49b7gvUBSTOcuwZ4/tTbqvfbCeLkumYCgMebMkMPC5NqMx0sLl4mbY8Z2O4fBiKr32YHXGOussrEjDPX+VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAYrP13z; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767980243; x=1799516243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6D20sLJm4brDMSdvd7JdzurQBl2Gfob5k4qwI5PXFPA=;
  b=TAYrP13zsXz9MolpcUOgUNcGkebVIX2+HQbVD6zhEVNHQmcOegY5l5ij
   5bw4WN8NjbsqlwOgTQHXXiOwGq1OzpoqfE5qUISxvnQBKe1XUwF5zgLsA
   +6s56QDOgSyN2GZ7A3EFLLp7oWI9Bsfdf/bOBEFgKAMRWFmHliYVtYN9E
   t0oksqytVOhFehKLYavF6iPRLlTBHBrgQxxO4xbQRGEpj8Z2OSCr/e0Sk
   rlihpvk/rFk3IVCmIPQensoiSI+rZc9X0lUnpefHT3LAGjNyFR0o9Iev+
   WVcnfjsB/Xo2ztLmD617jHOqLp30I+Djetj0aOO8KuLr8n+qq45Ll+1bS
   w==;
X-CSE-ConnectionGUID: r3lylOeYS0OwnEHh8dZCHQ==
X-CSE-MsgGUID: mX4e8+f4Tb2ESCLKnJt8ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69411042"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="69411042"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 09:37:21 -0800
X-CSE-ConnectionGUID: APH8J4l1RDmGveIJM8KPzw==
X-CSE-MsgGUID: JwHtO6DlTH2uEmTyyaU89w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203948107"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 09 Jan 2026 09:37:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 334A294; Fri, 09 Jan 2026 18:37:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 0/3] dmaengine: A little cleanup and refactoring
Date: Fri,  9 Jan 2026 18:35:40 +0100
Message-ID: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just a set of small almost ad-hoc cleanups and refactoring.
Nothing special and nothing that changes behaviour.

Changelog v3:
- fixed checkpatch warning (mixed tabs and spaces) (Vinod)

v2: 20251110085349.3414507-1-andriy.shevchenko@linux.intel.com

Changelog v2:
- dropped not very good (and not compilable) change (LKP)

Andy Shevchenko (3):
  dmaengine: Refactor devm_dma_request_chan() for readability
  dmaengine: Use device_match_of_node() helper
  dmaengine: Sort headers alphabetically

 drivers/dma/dmaengine.c | 50 +++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

-- 
2.50.1


