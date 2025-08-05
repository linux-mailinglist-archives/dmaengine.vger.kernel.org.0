Return-Path: <dmaengine+bounces-5945-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF27DB1AC06
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 03:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CBC17D017
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 01:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37651CEAC2;
	Tue,  5 Aug 2025 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxOVxVTh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696E01A3166;
	Tue,  5 Aug 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357296; cv=none; b=lZcTFL/jbO4qOWIhI7p/6Q5s26lO1w0of61vGAOpfmSmfpR9c1TeDIImDL8JZhH1xFjHd9KOPGZvPGZ+V5d31LLy/JkpF6PLs0+w/aafzDPreyLcR0pr/c/U7dNa7hzgjLfm5O5dQeeo+AGxwmJe4NU46zpRM/fjIveGQS8tb/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357296; c=relaxed/simple;
	bh=4cLCVz8K+Y02Y5GTc8PnvAxHDjxzkvsx4m/X+SySBxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWix1QvPEkGh9eyxVqb8rWKEr2/76/ZRnMyO7YUC0X9Ba0NVET7gj2YyMpop825pHxP4ws4mOzASaKPU5kyQzHBYML742pHQgkbrTQPkOyDMSyhsmBSF655nocxOfHz0VLykNYJ/98veRuucfZ7es3rl89zMLzN4J134w8bVpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxOVxVTh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754357295; x=1785893295;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4cLCVz8K+Y02Y5GTc8PnvAxHDjxzkvsx4m/X+SySBxc=;
  b=DxOVxVThp4t5TK4G+IdNc8XfG2P3DZuYf3XRgbCnIcoIXpmJbjQp4OPP
   Mg+saBBuQREtmvzoWSPr4FUXdyvVkVFVe52VVvk1OxbSkB2seSaSYCXbR
   2r8Zhgt0wlgdTMEmzEDUXRV+nATmYRZhbHoEiMtjy4uFlinkZJ90dva5O
   Y6jndrT3B0MAr6ewOV+3hCIo408ytpu4x7iPxhm6xaDUvYlxf3S5wuVb9
   9//hTPpW9Lq8KfMcGrs+nroPDZ2ao6HyL4lQZJC/wSaYhPz5W/P3nSQQO
   6wVCxgAj2Rzeyah6iLoUJG14K1OHiOzHIp2rYEOjmcsbtxuSBWk3QpFPp
   A==;
X-CSE-ConnectionGUID: Dh0TTjFATey0UptuZLxwzw==
X-CSE-MsgGUID: M+GoRFJaT9evo4juAk1BEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68085355"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68085355"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
X-CSE-ConnectionGUID: IvRz556WQ1+fuIBSDRvZ+g==
X-CSE-MsgGUID: 4sLGXkQySsqvoYKvB9gbTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169699545"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.32.147]) ([10.98.32.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 04 Aug 2025 18:27:54 -0700
Subject: [PATCH 3/9] dmaengine: idxd: Fix possible invalid memory access
 after FLR
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-3-4e020fbf52c1@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754357291; l=962;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=4cLCVz8K+Y02Y5GTc8PnvAxHDjxzkvsx4m/X+SySBxc=;
 b=KZPoJJ9EM2QFEaUnt2h/HHubG7oJKnk/UD6efNVKskN38S35gz3j79TS29Tgm+8nZFLEOtk/j
 TjnAWoPCBtUBb8yoVg9YMbiuMBtwJfq58Tx7ARv20hqvdPw6R3kJI4N
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

In the case that the first Field Level Reset (FLR) concludes
correctly, but in the second FLR the scratch area for the saved
configuration cannot be allocated, it's possible for a invalid memory
access to happen.

Always set the deallocated scratch area to NULL after FLR completes.

Fixes: 98d187a98903 ("dmaengine: idxd: Enable Function Level Reset (FLR) for halt")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a58b8cdbfa60ba9f00b91a737df01517885bc41a..31e00af136a7e13887d3ffd00efbb05864712a80 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1136,6 +1136,7 @@ static void idxd_reset_done(struct pci_dev *pdev)
 	}
 out:
 	kfree(idxd->idxd_saved);
+	idxd->idxd_saved = NULL;
 }
 
 static const struct pci_error_handlers idxd_error_handler = {

-- 
2.50.1


