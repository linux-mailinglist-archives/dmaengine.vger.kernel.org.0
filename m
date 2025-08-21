Return-Path: <dmaengine+bounces-6106-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96919B309B7
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BC81CE6EC1
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458562E7F14;
	Thu, 21 Aug 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kebygcm6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99E225D7;
	Thu, 21 Aug 2025 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817213; cv=none; b=UaNslVcpzMuG48x5SxIPlBSL7P72eCTpQxrFxBsz/NeZf3zhLLXFEJBmI5H/accn30KpeGi5ahpSs85ohyn+Qt1AvjmX4H28vdvAJnbOCYkMdF1NA8qI3tq7b0fW3r3G+c3vkpKlS1y3ARpwsQkJSNX2sgCL/eharLJoxvPxJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817213; c=relaxed/simple;
	bh=9hFoTAyqA9GW3b1BG5uuf9nkTjArO+R+7ljWgK9e/84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhjN81PYS0fMT4yQJDRROl8gpM8N5bnl1S27PMOV3iatgS/VFxR6LdYEGzury3ujdfWXL/pd4+Y5VGeP93EGvT7A9YFoBITYnehxHxqKWMcoIr6mk0dx8wBSoDEWwFqWI2Aa2FJE/TXuQ7zzvUGULpSiBijeOzRxTRc91uNENKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kebygcm6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817211; x=1787353211;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9hFoTAyqA9GW3b1BG5uuf9nkTjArO+R+7ljWgK9e/84=;
  b=Kebygcm6CRQdslHsH692CUv7f9XUxMmzN58I1SbLrrG44bPzATwZJP3c
   1qc+3MppZeGXaX4WXTkEue/r3q7u82Ptj5l20Rsj8MVkR9OetQBoCAWY6
   xhSHGp+to616JhYEEBy6LrFZOI+e7qK6Q5ql8RMN5n3SRHuG3AcuJWRjK
   i4BLkA2trFsezPuyiOt72YCVMS4Q4dQZEAg+LoavbhbdAfFFZrU65FfE7
   SPfMTdIKppJ9juTwLW8/xcmRZI1BJd+3Spm+p972W+lLe+JM6SZkiY65a
   eChUfLYrrSKmf35Cn66TcYwnA+5e+m15s8l4KxLcaExLWxQa97QY68n18
   w==;
X-CSE-ConnectionGUID: hUbhZoUFTDuY+gecuRxXyA==
X-CSE-MsgGUID: ywpgd0C4RsCJUzPdlkI+PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60748483"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60748483"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
X-CSE-ConnectionGUID: AmWp8JPAQ1uXY2LBhEfVag==
X-CSE-MsgGUID: gDJ1g01nQmKD+cCmyfLNVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168444339"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.24.157]) ([10.98.24.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:09 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Aug 2025 15:59:35 -0700
Subject: [PATCH v2 01/10] dmaengine: idxd: Fix lockdep warnings when
 calling idxd_device_config()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-1-595d48fa065c@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-2e5ae
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755817209; l=2407;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=9hFoTAyqA9GW3b1BG5uuf9nkTjArO+R+7ljWgK9e/84=;
 b=4zM0hVrYq7L3++Rpj2z4r4t+eTmpcE5jVYeK1zyg31KPVADppYHxEB5/EQwWE9fObMA4Di3cW
 riPabTypymfBZYZQHE7BRnnMYA414KTxCeDbnGnZWfnGOKzP0fNshqG
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

Move the check for IDXD_FLAG_CONFIGURABLE and the locking to "inside"
idxd_device_config(), as this is common to all callers, and the one
that wasn't holding the lock was an error (that was causing the
lockdep warning).

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 17 +++++++----------
 drivers/dma/idxd/init.c   | 10 ++++------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5cf419fe6b46..ac41889e4fe1 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1107,7 +1107,11 @@ int idxd_device_config(struct idxd_device *idxd)
 {
 	int rc;
 
-	lockdep_assert_held(&idxd->dev_lock);
+	guard(spinlock)(&idxd->dev_lock);
+
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return 0;
+
 	rc = idxd_wqs_setup(idxd);
 	if (rc < 0)
 		return rc;
@@ -1434,11 +1438,7 @@ int idxd_drv_enable_wq(struct idxd_wq *wq)
 		}
 	}
 
-	rc = 0;
-	spin_lock(&idxd->dev_lock);
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		rc = idxd_device_config(idxd);
-	spin_unlock(&idxd->dev_lock);
+	rc = idxd_device_config(idxd);
 	if (rc < 0) {
 		dev_dbg(dev, "Writing wq %d config failed: %d\n", wq->id, rc);
 		goto err;
@@ -1534,10 +1534,7 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 	}
 
 	/* Device configuration */
-	spin_lock(&idxd->dev_lock);
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		rc = idxd_device_config(idxd);
-	spin_unlock(&idxd->dev_lock);
+	rc = idxd_device_config(idxd);
 	if (rc < 0)
 		return -ENXIO;
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f98aa41fa42e..c25bd0595561 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1092,12 +1092,10 @@ static void idxd_reset_done(struct pci_dev *pdev)
 	idxd_device_config_restore(idxd, idxd->idxd_saved);
 
 	/* Re-configure IDXD device if allowed. */
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
-		rc = idxd_device_config(idxd);
-		if (rc < 0) {
-			dev_err(dev, "HALT: %s config fails\n", idxd_name);
-			goto out;
-		}
+	rc = idxd_device_config(idxd);
+	if (rc < 0) {
+		dev_err(dev, "HALT: %s config fails\n", idxd_name);
+		goto out;
 	}
 
 	/* Bind IDXD device to driver. */

-- 
2.50.1


