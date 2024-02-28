Return-Path: <dmaengine+bounces-1154-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B7B86B951
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A4EB23E00
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 20:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFD215F33A;
	Wed, 28 Feb 2024 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHLGXjRQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63215DBAF;
	Wed, 28 Feb 2024 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153385; cv=none; b=dQOHCN3grEA0N5xNwweRgigcDgzx16f25iry8fkULB4I1ACmh7LhsB8kN3f2r0jC1GqePzpqeKV9YLo1HCGBbxgNOFulFTY82yz8fDiUbyD1c5Kh+CrZvvSEAKkYOA9fmF7T8HqXtPPA3rDA2iSkRAnktOx74Q0t4cDTdCr0Flk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153385; c=relaxed/simple;
	bh=/llCeBOq/akHF/gxzRufHNlRAWfKFNHHOOSUCKXMrCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/9mrnXi3bBhnM620hlobSzMJP7X1CVaHHxTh5XzHi80EFxJ0eaSG5qpI10R8TFhdudYvltiOYbADvW2S8gt6vzRpkwMlJy/6UWD7/DH66LmxDtERXZeyepLmXz9yJCCe98VMWs+A9hpyLCvMk835SbKmiWTZzZcLwqqhW/kjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHLGXjRQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153384; x=1740689384;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/llCeBOq/akHF/gxzRufHNlRAWfKFNHHOOSUCKXMrCA=;
  b=cHLGXjRQlnHK/NHK2RUQAb8ubhD4SkqTdAqpUXBNBfEHRlUU3QSV8p/W
   faVQOxSAP2gA4TEMt9CTyG8ZguKjKtmDqbPP58UqMipsIj4A7FLxzx5+Q
   DKqkfz8e55YGCKTZbO08J/tDpNl+0z6pAMZt0DHcaksxU2vKTyUf9+sLp
   KO9luGtCTZQAZRLQbn+43fq9O7mJqX7f+k1kW7n9L38XpIE3yegMm0jLk
   lvqccnpwvCODnGfMSi/Gbl6VxvSWpLCCLorCBN4nZexleVl96R81gV6Eo
   /563T3qQdNuKy9CPoz45SiPBeJlYwSp7vktcwR20GJO29Tg/7OZomYWBI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3428709"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3428709"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034657"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034657"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:49:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 01E211C5; Wed, 28 Feb 2024 22:49:33 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v4 0/8] iio: core: New macros and making use of them
Date: Wed, 28 Feb 2024 22:41:30 +0200
Message-ID: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added new macros to overflow.h and reuse it in IIO. For the sake of examples
a few more places were updated (requested by Kees). In case maintainers are okay,
tags will be appreciated.

v4:
- dropped applied patches
- refactored macros and code to make them simpler (Jonathan)
- moved (renamed) macros to overflow.h

v3: https://lore.kernel.org/r/20230724110204.46285-1-andriy.shevchenko@linux.intel.com
- dropped applied patches
- use switch-case for the supported clocks (Jonathan)                                                            - redone opaque_struct_size() to be simpler (Uwe)
- dropped wrong hunk for krealloc_array() conversion (Jonathan)                                                  - dropped initcall move (Jonathan)

v2:
- sprintf() --> sysfs_emit() (Nuno)
- added tag (Nuno)

Andy Shevchenko (8):
  overflow: Use POD in check_shl_overflow()
  overflow: Add struct_size_with_data() and struct_data_pointer()
    helpers
  iio: core: NULLify private pointer when there is no private data
  iio: core: Calculate alloc_size only once in iio_device_alloc()
  iio: core: Use new helpers from overflow.h in iio_device_alloc()
  spi: Use new helpers from overflow.h in __spi_alloc_controller()
  net-device: Use new helpers from overflow.h in netdevice APIs
  dmaengine: ste_dma40: Use new helpers from overflow.h

 drivers/dma/ste_dma40.c         | 12 ++++++------
 drivers/iio/industrialio-core.c | 16 +++++++++-------
 drivers/spi/spi.c               |  6 +++---
 include/linux/netdevice.h       |  3 ++-
 include/linux/overflow.h        | 29 +++++++++++++++++++++++++++--
 net/core/dev.c                  | 10 +++++-----
 6 files changed, 52 insertions(+), 24 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


