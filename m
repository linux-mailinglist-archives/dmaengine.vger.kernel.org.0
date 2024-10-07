Return-Path: <dmaengine+bounces-3281-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE61993082
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 17:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234161C231EF
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F571D88C4;
	Mon,  7 Oct 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUFQFDMK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A11D86D2;
	Mon,  7 Oct 2024 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313486; cv=none; b=C1SX4Jd0liaNvTq7cG4RkgBeY70MkHrDpP1mfu4NRRRGKAU8duW1jb25sJKqb6c/1NJ/ilBi+qCHjtBDnpdS+Ae5M4KgzkKThPKQFlO/PwNemZEncmHdiWlXwYUAEyGAAlKoQOdJ4f2n1iV0LuPSMw1kdGwZsduKFZTFWug15C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313486; c=relaxed/simple;
	bh=hMVFo2QqijVdQmD9I29p4WSfR8DVMo2z3LQfrBgDbMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJeSgPftDZy9nYEV3nLv5h2mi4TZTJPpKFbTrSmAyEX7J5IdZisgwJ4wpH0nOcI8Jhbk90dolZvCEnvufF0IQucW4TQVDy+Sr7syN6m92W5EIx9rSnXI4RhvkYGC64PFBWuVNGm33D7B46hHKe08i2roG2EC2AJ4DL1a4qA/IHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUFQFDMK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728313486; x=1759849486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hMVFo2QqijVdQmD9I29p4WSfR8DVMo2z3LQfrBgDbMc=;
  b=JUFQFDMKh/hkLKHBIU4wkLSeb2MCVMP573AxeH11YCvGp8ENhdSNo/FP
   g/XzMD9BCnELO9s8pjcqjd35rlm6kxc4zohVXI0tQzk9jtmVC2m8bgime
   qh/c+9jvV5Dc+PW6m7nEZPcO1SpD1rEnbP585CDoBJaqdWoJnmm8njOx3
   8ynTxXKzOsoOOyGaiQRvbjqILKu+Vv0eIpcqvWseIcb50e7/C5+EtoPHK
   xoDA0vwQpnT787kBDt+teG/PXJQM2JF8gEgKYgQI7KGgOd0WXkULpW5dV
   8gaBzh6PpGg9+3kgxFUCpHYqmwCn2nzLZGjWZaAwBuJzlDfzEp8MnfRSm
   Q==;
X-CSE-ConnectionGUID: 22Tqf2tmQlaKLibe/1EIig==
X-CSE-MsgGUID: 2QPXgvDfRFO6DUJH8tt64w==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27593250"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27593250"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:04:45 -0700
X-CSE-ConnectionGUID: typ133cYQ4iAayN5Erz0ZQ==
X-CSE-MsgGUID: kb2LZHkwQiOb/BINbrbGJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75463528"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 07 Oct 2024 08:04:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CAB12301; Mon, 07 Oct 2024 18:04:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 0/3] dmaengine: acpi: devm APIs and other cleanups
Date: Mon,  7 Oct 2024 18:03:22 +0300
Message-ID: <20241007150436.2183575-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a set of a few cleanups mostly related to ACPI DMA devm APIs.
No functional changes intended.

Andy Shevchenko (3):
  dmaengine: acpi: Drop unused devm_acpi_dma_controller_free()
  dmaengine: acpi: Simplify devm_acpi_dma_controller_register()
  dmaengine: acpi: Clean up headers

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/dma/acpi-dma.c                        | 43 ++++++-------------
 include/linux/acpi_dma.h                      |  9 ++--
 3 files changed, 15 insertions(+), 38 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


