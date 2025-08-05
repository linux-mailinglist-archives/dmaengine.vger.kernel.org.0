Return-Path: <dmaengine+bounces-5943-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73462B1AC02
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 03:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054A27AE575
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 01:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB31A2541;
	Tue,  5 Aug 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpX8XAcK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3B0199924;
	Tue,  5 Aug 2025 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357295; cv=none; b=UZ9qWQPcY+L18Bi1PJSZUd9lQi5d9abhBwtMqyWZ+8TCw6APGy8FopKE+n7C2kgqQseVh3djiChLjjIfPeSAky0Vszfi+6gcj5daV0R5JYtoh8wupQkuGySJ0cHOYSFNrlY3YBF2kqTMXUaz8ORl5sqLjweH9Hf5w6jpjr9JVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357295; c=relaxed/simple;
	bh=IPYPIh8ls036r5dFdmKaGbGjopokvguBWp4n7+ERrDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DNE6wvdnUgh+jAzRG3Q8Cx72Q7oFtm/fTEZBdN9P76UPCO0Xy7+FwMPOQ7I/nBP9QsOLur8lF2d1nxbT3IHqz7+TS3XBXdKS1WKEFrsBeEmR4MtyRzxEfjNYVAKEtiWF55PGiAuOCVTl5M8H30USW+VEl9sqPTkHVNTZhu+atpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpX8XAcK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754357294; x=1785893294;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IPYPIh8ls036r5dFdmKaGbGjopokvguBWp4n7+ERrDo=;
  b=YpX8XAcK7v+VOT28m8ECjZqSKnFprQaI8qqBP5Wof0GB5K5pRwuFhzrl
   yzM61bxovDhG4CEd5IJL09FgQwV/IntkJpQ17iY6HtgmpACZimCR9/bYd
   IUniEIfhnieLYJcZrAoXxHulAoHw60Hb604eETw3vNjce6u7Jfnx5QfZA
   BHIVD7SCKbOZD3lmdIUPMUNuyLtAhFfVY2FjSgPCs17ZuBasxgek8Mxpq
   a+S4m+2L6o+bOSaPuAIId0RK515TblNOyWGkr4qoxINuJnVoeRaKQDUGB
   cEw6OBWrDfaex8kGQHcUlDdVmK3M++M2xUYpIIODnW6eIh5cYIcsPjuje
   g==;
X-CSE-ConnectionGUID: 85PFfl3nQPmNChD9KOiPvQ==
X-CSE-MsgGUID: z1lB5UzZSB+mMr4sC/6E2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68085351"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68085351"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
X-CSE-ConnectionGUID: ElpJFVpAQzeTC+5O7FTFHw==
X-CSE-MsgGUID: upiuQnaaQYSJMFJXjMJDag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169699537"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.32.147]) ([10.98.32.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 04 Aug 2025 18:27:52 -0700
Subject: [PATCH 1/9] dmaengine: idxd: Fix lockdep warnings when calling
 idxd_device_config()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-1-4e020fbf52c1@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754357291; l=1369;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=IPYPIh8ls036r5dFdmKaGbGjopokvguBWp4n7+ERrDo=;
 b=h+9RiBZLGSMkxRSSd0PfqobFOXuB2wNiYH8wtMHju3FWWUkMqVwy7cvQe87YnTH7RhFeJrTib
 FnOvkuUuK0TAjcT1u6FMqFd6ndv9xpeJwo1vX5Y++v2+5hjBJb4wh4V
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

idxd_device_config() should only be called with idxd->dev_lock held.
Hold the lock to the calls that were missing.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/init.c | 2 ++
 drivers/dma/idxd/irq.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 35bdefd3728bb851beb0f235fae7c6d71bd59239..d828d352ab008127e5e442e7072c9d5df0f2c6cf 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1091,7 +1091,9 @@ static void idxd_reset_done(struct pci_dev *pdev)
 
 	/* Re-configure IDXD device if allowed. */
 	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
+		spin_lock(&idxd->dev_lock);
 		rc = idxd_device_config(idxd);
+		spin_unlock(&idxd->dev_lock);
 		if (rc < 0) {
 			dev_err(dev, "HALT: %s config fails\n", idxd_name);
 			goto out;
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 1107db3ce0a3a65246bd0d9b1f96e99c9fa3def6..74059fe43fafeb930f58db21d3824f62b095b968 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -36,7 +36,9 @@ static void idxd_device_reinit(struct work_struct *work)
 	int rc, i;
 
 	idxd_device_reset(idxd);
+	spin_lock(&idxd->dev_lock);
 	rc = idxd_device_config(idxd);
+	spin_unlock(&idxd->dev_lock);
 	if (rc < 0)
 		goto out;
 

-- 
2.50.1


