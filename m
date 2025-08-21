Return-Path: <dmaengine+bounces-6115-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D88B309CC
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20D21CC9081
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7165F2F3606;
	Thu, 21 Aug 2025 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKxGesIc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A822ECE97;
	Thu, 21 Aug 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817218; cv=none; b=fvdVFrWFOmB2GLSDI9YnertPr58pnLhIh20vbNcE3jslkHaCLLFqzS2JWawzHIzJEyz5X/WAOC141/tG+6OvQXVB+g5rqsLmW8FcWO+2jUBcpRhfja7I3gB/sYD+DlKfafRajGw3imWGqJ76qm6G4V9eTb3bRsuwry9cFOdFyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817218; c=relaxed/simple;
	bh=W51MrwzFJgFBMfOJDZMbvPNlljcaK8etAkXOFsk3k8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a/54myZ/ZnOZPuQBTgvO58wZ+9+WfLDs+krh28Dc2Naf37cwpoGTD5OP0fmWCFWEgLer+ZFtixBHoy8ycPvoXaVqF6sw9gUZjjwmd1gD8HRAw9DpkdHfpoB/Y3kRreBXhlUyh9N5jZIhB7MDyn8aLU6HLBavoY/f2wTWLFTn8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKxGesIc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817217; x=1787353217;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=W51MrwzFJgFBMfOJDZMbvPNlljcaK8etAkXOFsk3k8Y=;
  b=VKxGesIcjPn1Y4pDJ/wDOBmVUfffcsV8zRomdEOI/iBMx61Mmr+eZVNj
   /c4WWTYJImvCefKC3KCY94abcfRYE/bL3gFPfU3YnsOzeP29vpqydc50u
   CFcO5mBGb3leFzvzI+PGAB4qB1dgOAVrgqDiOC1+emrjbw8hzXi2xW93B
   ixxkWyxQeOBPRukOheyOmCbIedgD8gw2RM35r+fAZ8GGMEJ8eqMeZuQi7
   nqUSK33Y45FsjQsVkvpNbQZSSHZAgoht//pCwCuquSCzVH532a+9hNiL0
   yANdi9ilPozCNM8yL71Wv46xU8N9ij0qMLHsy6u6l34blOHbD8wHmcwrV
   A==;
X-CSE-ConnectionGUID: /KPtAZjZTYung36OqaSkvg==
X-CSE-MsgGUID: Us48xTraT6WMuouceGtUFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60748502"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60748502"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:11 -0700
X-CSE-ConnectionGUID: FcDF4eyHTUyb0NEttUic+g==
X-CSE-MsgGUID: 7KL3XuYuReODwSG1u551gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168444373"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.24.157]) ([10.98.24.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Aug 2025 15:59:44 -0700
Subject: [PATCH v2 10/10] dmaengine: idxd: Fix leaking event log memory
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-10-595d48fa065c@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-2e5ae
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755817209; l=1193;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=W51MrwzFJgFBMfOJDZMbvPNlljcaK8etAkXOFsk3k8Y=;
 b=2qpLaxZA8bnR44i+b4t1ZElqRHmM5Kz8SuUkmPfpqw4VqYpC6J+LpeDhPD9SRx+WDCEzhEFhU
 AIVi+5ekkQ5B2QFW4ndKKLJgLCQLcT48Q3gncNVj7xnixJ+9mmG6R07
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

During the device remove process, the device is reset, causing the
configuration registers to go back to their default state, which is
zero. As the driver is checking if the event log support was enabled
before deallocating, it will fail if a reset happened before.

Do not check if the support was enabled, the check for 'idxd->evl'
being valid (only allocated if the HW capability is available) is
enough.

Fixes: 244da66cda35 ("dmaengine: idxd: setup event log configuration")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index ddce262853b0..0cf1425e9a7c 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -818,10 +818,6 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	if (!evl)
 		return;
 
-	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
-	if (!gencfg.evl_en)
-		return;
-
 	mutex_lock(&evl->lock);
 	gencfg.evl_en = 0;
 	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);

-- 
2.50.1


