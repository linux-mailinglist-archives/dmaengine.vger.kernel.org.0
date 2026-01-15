Return-Path: <dmaengine+bounces-8298-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B54F3D291A3
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 23:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0DF53015DFC
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 22:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753CC333755;
	Thu, 15 Jan 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4YTuZgi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422EA33121B;
	Thu, 15 Jan 2026 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517273; cv=none; b=ErkefhLZU8j6E90M4q1dLLhrVsQIpz250Jw/QXAEjicz6Gz9t8ZDneNzJmDOR84Hgmjtud15vVa2vsOTRKhzylKWnHXS5W1K7XonWgP72/+zyynFrzhq1xX0FvXvRzhTsnXX4ZHvai5dmzWOFxP9Dyt5FjfDHG9jneZQCXpFmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517273; c=relaxed/simple;
	bh=Fl4iu5qlLERicKEA6AODOo4UaiFTsq4rUJHJ2dZySbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CVhmfR77maLFqrHHLahXTbxAoi62BQW4omvkVPVnB31wFQNiUWHeGkQd6qy0Zkq0E0/t56JOVL24G8tsHuEd7WQ5E4zUREXlgs+VmOKPi+vV6ZDW3/61o5n0Z1DBJE7bq7BxJknxS7gv+Ja1MqlYCCNDDYU+eG72eKEnz5wZXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4YTuZgi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517271; x=1800053271;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Fl4iu5qlLERicKEA6AODOo4UaiFTsq4rUJHJ2dZySbk=;
  b=c4YTuZgiGbGrHbYbGyO5pthvX0mn96dKq+FL2a1LEsmgiKcxFZHGs3Nb
   IbcHKeCmmRC0xAPGfL/ABgupY9oThkJHxKzmOe9tC3DMqu4mBnGYAiOZq
   ZE6SsXDTK3I0UuhtgUuH+ojISMR8rVsWCy/uvXnK8iFNiT6HtyaKY41yN
   EofmiiNDTnvP43THIdzh0pd93IZs9poyB3uUxWH2tQzdgFzszCDl+G23M
   Z6/ZjO3g8cofNJAV1iCtWMaBAuHGglXSoTSLF+R0NB5MzhcWwFkxkx09f
   2x1BzyJVpNN8DDmPI12xQssPQMncm+lLe9CTrDXgZsTLG663oRSWkvjmj
   Q==;
X-CSE-ConnectionGUID: uRHaXK7NSUOlQQW9/hj/fA==
X-CSE-MsgGUID: ZVYy8V9CQoyFV/iBD00cpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69744637"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69744637"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:48 -0800
X-CSE-ConnectionGUID: 7A2laGH+RYCGsx6uDKcBgw==
X-CSE-MsgGUID: IJ0VCn3hSP2oLe8QBYdl7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204965456"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:48 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 15 Jan 2026 14:47:25 -0800
Subject: [PATCH RESEND v2 07/10] dmaengine: idxd: Fix not releasing
 workqueue on .release()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-7-59e106115a3e@intel.com>
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768517265; l=803;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=Fl4iu5qlLERicKEA6AODOo4UaiFTsq4rUJHJ2dZySbk=;
 b=YoXR5sQCrcuxCSpZnFfVw7f6uE2prEIiGo03ZgWk6gf5pIr6uvxmwyHOP7GI6A/igRhavGv4P
 CPOYLIT1S0XB/PYLCtNdTcDB8RV06rXQt1w12gOW2VX6ne4AuJyub/9
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

The workqueue associated with an DSA/IAA device is not released when
the object is freed.

Fixes: 47c16ac27d4c ("dmaengine: idxd: fix idxd conf_dev 'struct device' lifetime")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index cc2c83d7f710..6d251095c350 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1836,6 +1836,7 @@ static void idxd_conf_device_release(struct device *dev)
 {
 	struct idxd_device *idxd = confdev_to_idxd(dev);
 
+	destroy_workqueue(idxd->wq);
 	kfree(idxd->groups);
 	bitmap_free(idxd->wq_enable_map);
 	kfree(idxd->wqs);

-- 
2.52.0


