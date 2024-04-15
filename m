Return-Path: <dmaengine+bounces-1840-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F178A59A9
	for <lists+dmaengine@lfdr.de>; Mon, 15 Apr 2024 20:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5432D1C20F0C
	for <lists+dmaengine@lfdr.de>; Mon, 15 Apr 2024 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705B13A864;
	Mon, 15 Apr 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfMr/xT1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C2384D24;
	Mon, 15 Apr 2024 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205257; cv=none; b=fxKti/lgnGbjw/zpF+N662qDkhy50jg/TZMl4sIu1N9WUPRM9YLYHTT4gzuzlIzhhMzw/3VIzv27UkZHbKB2PoE4axzdknh1TQLAX3CwKvoJ50c9WAttSZUB6qoNNhHV4T1toavvG75I/UpCf6TRKAgfnFaeYpK5MD72v2GUnCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205257; c=relaxed/simple;
	bh=yOL9RQkQZOwUCAqbLSj1a2WoEW56l25BTbDLITbtZjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ml1csk33sEE3UYPYfnTEgV3iW6f2e/UbqTCd27CGcxWQ86pldd8bxZ3d9rAHsLsAfZAiTFvjtC35VGGkvr3EsLbi10feZIyTkg15vYawLm8anu+mLjL/blV2j2gbQs6CwMuQwEkCf5Eutinz8DIuoo9tjkKxDczQ5LQRsJm0NCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfMr/xT1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713205256; x=1744741256;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yOL9RQkQZOwUCAqbLSj1a2WoEW56l25BTbDLITbtZjA=;
  b=BfMr/xT123XQiAzQpx06etatQs48Hq6F/pscwpHdes/z3gDtW6Hi0zpG
   5tKfoQGwW5LCf3FGKvwlUDdHZmmQomVowZEIOzvtkuez8eu8E5XiE0IhH
   Ug1Q9RxkrHlexaGvoWVRG97D60JlbbwVzdIndJ+TdnrSDQ/UQ7lOVJ9yA
   Zmy+M7ao/zUJ//Pvykw59wa4KHxKeroeLualROvLUC7ZgZKptlBLUgzrD
   XrZkQW/0OhoyNwr/T+Z5HymxnmRRaOQh+i6Q+JSnBee1DwVr3/p8inOAK
   Z6D4r/TZsiuBBDxvoD80D7xTV5IWypa504T/FWG68weoCCnI9nQbkgh34
   g==;
X-CSE-ConnectionGUID: Re8O+gcaTvaonFzHEoE/Fg==
X-CSE-MsgGUID: YGUhPVYbQ/m/E+Mq5XP+8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="11557184"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="11557184"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 11:20:54 -0700
X-CSE-ConnectionGUID: UWJpL6J8Q2O6boHH81CKhA==
X-CSE-MsgGUID: z85dXddtQFCPEvH9eh15TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26784016"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa004.jf.intel.com with ESMTP; 15 Apr 2024 11:20:54 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] MAINTAINERS: Update role for IDXD driver
Date: Mon, 15 Apr 2024 11:20:55 -0700
Message-Id: <20240415182055.3465170-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

Move Dave Jiang to reviewer role since he has not been working on the
driver.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c23fda1aa1f0..6839b635d35a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10940,7 +10940,7 @@ F:	drivers/idle/intel_idle.c
 
 INTEL IDXD DRIVER
 M:	Fenghua Yu <fenghua.yu@intel.com>
-M:	Dave Jiang <dave.jiang@intel.com>
+R:	Dave Jiang <dave.jiang@intel.com>
 L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	drivers/dma/idxd/*
-- 
2.37.1


