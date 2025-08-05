Return-Path: <dmaengine+bounces-5950-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33331B1AC0F
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 03:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A0E3BE75A
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 01:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A531F3B85;
	Tue,  5 Aug 2025 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3+1HbqX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484B1DE2C2;
	Tue,  5 Aug 2025 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357299; cv=none; b=CqMAUx+6iHYbgy8o5sVqEXArphawPs6vIrbQi1jlwbMt2SwJQQ9jYc8+I3ybrkO+4Hqeso3jfWE8LkiTPVkHOVAnZ0Fd6WuFj01zjMdMGkdKTs7oKB/+bdAj6LOkATbziZpex89zcXaWnOdv4ywx8gVrIwbE8axObjwclnURjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357299; c=relaxed/simple;
	bh=hqRLY7svLkCk+t/5lKLr/BM+MsElzoLaOGbyxhXHyI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFnSC5tfv4BPaYAmtZmf8f8kxyVDL0hv5ILvaUY3the/zeJpRFHA5J/991XMxjy4OozyfTdSp/Kd/bOYeWXtYrntJkbHlz74GaJgQhWk1LPpCnmU7HbI+36eZogRSUuuFRZdedFprkCewyvMNIn8x+GT1wZM0xIq0P+rr4Vgz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3+1HbqX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754357297; x=1785893297;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hqRLY7svLkCk+t/5lKLr/BM+MsElzoLaOGbyxhXHyI8=;
  b=P3+1HbqXc7Yb/2A4gbT0a2chKkLXd/nDebwe302N8eHAG1ou2n34aWHs
   ohdmTyHTjlhoYbRH2YJhQ2pn7p++S4IV4tkwzy2oM/XDiraGx9Z0ZZjOz
   BJ4oehTYZ51BYU1MvGsphQcM7JrnoL+kA5KfprXFk1cn47H0IgRpBGeps
   76lZlO2v1yeeKUxYv+NZlkEGffmc8TUjXcTpBGI/I983RuxxpZld6hkEj
   d/XdgQCnDTCX6jZW+vmpRVXs+tM7jvCva/4fBku9FOLNqMqgKTsUnL4FJ
   rL7qYFoMa3QA+LlUSiB5oDVvDNszS1HRUpKPoiD5z9wnIpuRb70vJ+H/c
   g==;
X-CSE-ConnectionGUID: g7wrqD6DTKaILSu78NPbVA==
X-CSE-MsgGUID: 60qPTHIGSn6w3S/Sc+5FLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68085365"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68085365"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:12 -0700
X-CSE-ConnectionGUID: tSMMTXTnQSKvrXERGnUvug==
X-CSE-MsgGUID: JFmZXbguTxC0ynjgs0LC2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169699567"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.32.147]) ([10.98.32.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 04 Aug 2025 18:27:59 -0700
Subject: [PATCH 8/9] dmaengine: idxd: Fix freeing the allocated ida too
 late
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-8-4e020fbf52c1@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754357291; l=1541;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=hqRLY7svLkCk+t/5lKLr/BM+MsElzoLaOGbyxhXHyI8=;
 b=UXgQtGshrX2xzl8Uiyt5T57ugdRzPf9ZoOTrh7lx8lOADrrHPh5JX8qkquHLk2p9mdiubXKNM
 tR0JC4QvtueD0D4CMADPy6xwoBBiMnB4ui5HWXXSNxcNzApn/kh3rpc
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

It can happen that when the cdev .release() is called, the driver
already called ida_destroy(). Move ida_free() to the _del() path.

We see with DEBUG_KOBJECT_RELEASE enabled and forcing an early PCI
unbind.

Fixes: 04922b7445a1 ("dmaengine: idxd: fix cdev setup and free device lifetime issues")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/cdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 7e4715f927732702416d917f34ab0a83f575d533..4105688cf3f060704b851ee17467c135c170326e 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -158,11 +158,7 @@ static const struct device_type idxd_cdev_file_type = {
 static void idxd_cdev_dev_release(struct device *dev)
 {
 	struct idxd_cdev *idxd_cdev = dev_to_cdev(dev);
-	struct idxd_cdev_context *cdev_ctx;
-	struct idxd_wq *wq = idxd_cdev->wq;
 
-	cdev_ctx = &ictx[wq->idxd->data->type];
-	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	kfree(idxd_cdev);
 }
 
@@ -582,11 +578,15 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 
 void idxd_wq_del_cdev(struct idxd_wq *wq)
 {
+	struct idxd_cdev_context *cdev_ctx;
 	struct idxd_cdev *idxd_cdev;
 
 	idxd_cdev = wq->idxd_cdev;
 	wq->idxd_cdev = NULL;
 	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
+
+	cdev_ctx = &ictx[wq->idxd->data->type];
+	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	put_device(cdev_dev(idxd_cdev));
 }
 

-- 
2.50.1


