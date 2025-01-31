Return-Path: <dmaengine+bounces-4243-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56848A241EF
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2025 18:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491003A306E
	for <lists+dmaengine@lfdr.de>; Fri, 31 Jan 2025 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C86D1E7668;
	Fri, 31 Jan 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lITZKn+W"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9811CD215;
	Fri, 31 Jan 2025 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738344950; cv=none; b=klcrrabvm3Hx92SZ7AxvXV6s2TtotXvM8I0XXr+dN4NEmSiRgKwfIJTavwNm/KuczgJFP9p03w9AnYvk+ggztc8vHpwrp7DRG5jfN+al8iMzPmzZMu/3yBP3S5y4dr8GBTjKFtwcQ0xbCcnxmyVv3TFZ7YyQeYpHexHHM8yS6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738344950; c=relaxed/simple;
	bh=2Fsuwa5QOlgJIafMqhYpIuJVbNq69kCZGsHiteVNHmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d9BxcS7plKTzRuBHYPDXaKcGtMtU5wFagi3hE2+VlGx1IrdlRFlAdcQCCX7L+xY5UVvR68wTcfjXWkXuqrJ8XhFbVcs8Jww5rS9FGtisl5dpcrOg+bNBwBjLC0XZIrKwAlg0zYcIdGFja7eptTtuFWvd4NPIHz9acjd96zlQ+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lITZKn+W; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738344949; x=1769880949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2Fsuwa5QOlgJIafMqhYpIuJVbNq69kCZGsHiteVNHmc=;
  b=lITZKn+WQS4t336CbmNscNH7K2C6/2UjTnNCQpoOnSFodMI37jKcCVMu
   X377QxkJqsJJm6kK+FQRLu/ABK3j4Z4i0tSygBbeO7SH37aPD30ZFFOjE
   UZekjZMyKxn14pi2CU9Alie2VXomvgp2aruTxdZ1aokkJTujOp3SLvz1s
   N8z3tUCif6rr2U7qdobAaAb1YkQGTlXGxLDNoEskxwbGgXtKyVkT6s4Bj
   I4CzTMRMflnM5XeZTt3nFGnmE3qbJ3E+8SqgeJTGd2iKehenAuIboIRs0
   WI8v2fwNVMbFrizfbsY8xhG9FQ1smPA+q27XJSDMWfiMNpAm5dgtibU5b
   A==;
X-CSE-ConnectionGUID: u/x9QEHrTM2uwExKed+tFA==
X-CSE-MsgGUID: NG0OySZDQLasFD6IP35jkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="49912300"
X-IronPort-AV: E=Sophos;i="6.13,249,1732608000"; 
   d="scan'208";a="49912300"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 09:35:48 -0800
X-CSE-ConnectionGUID: B0eAb5NoQ9myTitEHpdwIQ==
X-CSE-MsgGUID: ENh2DwcHTjS1U0um05ZMEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="114675187"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa003.jf.intel.com with ESMTP; 31 Jan 2025 09:35:47 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] MAINTAINERS: Change maintainer for IDXD
Date: Fri, 31 Jan 2025 09:35:51 -0800
Message-Id: <20250131173551.3979408-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to job transition, I am stepping down as IDXD maintainer.
Vinicius will take over maintainership responsibilities moving forward.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1086e53a317..08ce00b6c1f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11677,7 +11677,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
 F:	drivers/idle/intel_idle.c
 
 INTEL IDXD DRIVER
-M:	Fenghua Yu <fenghua.yu@intel.com>
+M:	Vinicius Costa Gomes <vinicius.gomes@intel.com>
 R:	Dave Jiang <dave.jiang@intel.com>
 L:	dmaengine@vger.kernel.org
 S:	Supported
-- 
2.37.1


