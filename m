Return-Path: <dmaengine+bounces-6114-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7759CB309CB
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534071CC76ED
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D422EE281;
	Thu, 21 Aug 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMgq7p/X"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A72EBDE0;
	Thu, 21 Aug 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817217; cv=none; b=VI5qHZx/UftVXZdcix3Cw1jT5ak85baO/b7Ml61q2ext6Ufn7C6A2TMYJa4J2OtHHpfGi6PgcvEvW042mDudUxemdFaGlAQ+cKxXlczVzb42xX8UjCCmvs4bdBECQISGAOl2iTCVAVMZ5q54eoBzpFfz/MsN/mY4rap5C3SGOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817217; c=relaxed/simple;
	bh=gX6w7tFGb3222D0jzgCq6DGMv3NUgvN/JDxvautEv6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cUbPPEalVLCmLokaA+3rjjrEOhXbgzSFb/135HK1J9Ue6HJPx4un9bUMq4d20/Qcpm0B+HNhgvOrGlt3ftqYwmLzQ9mYn1DOkbaKICHuWlh4ZiR16bx/ezJB8xOIxYBuO/9kEc2MqiF+G/ZM1ChIKvYMORgpMyuCyC5LQ3p9GkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMgq7p/X; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817216; x=1787353216;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gX6w7tFGb3222D0jzgCq6DGMv3NUgvN/JDxvautEv6k=;
  b=dMgq7p/XnKC4utYsf0CRfe5HWpOCLb232CkLOPCEZFxAgJ3T3LkPWL+H
   YFbJpAKM67xQhjfTXm9EPMxk6jEJKHW3/8BJfc2TxG5MF+5lws7L4Wlvo
   R7OEOynluisnBKIIyp3iZQeid/A0gjICqVo+tBUoRpHVKGBl1qtoa5+QG
   2fE04YcHGPbTj1O2n54mkX0FIURvDlDaLh8RUz4+4ZvC2+tgpmCdooZE1
   ryEGYCYlmSrn5E0SkFgYWt9JfBybmBnQZsQbctw3H9q/syuLlClJuXZqk
   TD6vwv7/IK9KHQLZXMA970v6M8xsAgJO74jXsz8sMTksJgJYGndojmwSw
   w==;
X-CSE-ConnectionGUID: 6n5HRAtrTgqs3r+7NHNUsA==
X-CSE-MsgGUID: XF0dxCb+SGye8byPSshJ+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60748501"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60748501"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:11 -0700
X-CSE-ConnectionGUID: cd/kKEtBSKe/CBuxdmfmHw==
X-CSE-MsgGUID: IFOGlWiEQUStY1guaeqqeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168444371"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.24.157]) ([10.98.24.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Aug 2025 15:59:43 -0700
Subject: [PATCH v2 09/10] dmaengine: idxd: Fix freeing the allocated ida
 too late
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-9-595d48fa065c@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-2e5ae
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755817209; l=1533;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=gX6w7tFGb3222D0jzgCq6DGMv3NUgvN/JDxvautEv6k=;
 b=+YKPLeKRz/ET+RMAsPwJEUtJ7IjHwZZ/XkHIcubbPnvyNmbE+v/+KmDvtsaY4YnZdDSyXPAM6
 AV8DpUfr12GCiLYzDD4moyTNcOIUOeCdBiQmF9LgEZUueX2yKpi0Tos
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

It can happen that when the cdev .release() is called, the driver
already called ida_destroy(). Move ida_free() to the _del() path.

We see with DEBUG_KOBJECT_RELEASE enabled and forcing an early PCI
unbind.

Fixes: 04922b7445a1 ("dmaengine: idxd: fix cdev setup and free device lifetime issues")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/cdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 7e4715f92773..4105688cf3f0 100644
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


