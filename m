Return-Path: <dmaengine+bounces-5944-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33315B1AC03
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 03:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6319617C6D3
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 01:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57BC1AAE28;
	Tue,  5 Aug 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuZU02I2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1DC19C553;
	Tue,  5 Aug 2025 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357295; cv=none; b=E+tcPIpvklc/YoUB2VC7ZeFbrJcK9iJr1eedycABUOw2k46M6UvlCec30UBqZWVJNtrPnJVtY6QMdV/9izRhgBUZ8rXQ/4zdlYmYzi18mxl8qoYhg6KK9ojLLldupZRJfYzQyowTmeaGJ3q7IRnKMWWe+h/jFZ4esQXVtKn7qF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357295; c=relaxed/simple;
	bh=GFgYukOaeMbxzvvbb9mGCIu7IxHd36cdjEq9BtBbyCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSIhXOn0DNlGrrUUkj6FudqPalm6H50Kr5eaCceXeX8C9bjWz2hu2sbO+4p7Z/FxHf6Pn2So8djvS4ny626VpJjxZZpw9p2U1BOStoDpcz8s5Ea9AgfSZDucPSPQi5dyd1NO+iVezdyXpKkv6qjgh8GY6eVcplEMjfRBQS/RCr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuZU02I2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754357294; x=1785893294;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GFgYukOaeMbxzvvbb9mGCIu7IxHd36cdjEq9BtBbyCc=;
  b=HuZU02I2N2miqst5daKNtGyzZcIdm/Fe3nD1NsT8S2k9Spj0anlddpn3
   hWipy/3qw5IwEsH0WkA8iAG3/WoqsCn3EdlEKRS/IYEBfubBNTSRYnlXe
   McSx7Dr8L7KgZ+leaNv/cNtTgpvCa4O6x+gx70BVNZM04Tv3RsmWsAuck
   YFT1HicRdd/cLxr4yDw8dx9tsUY62XNL2Yvc0F7AwapqkXevDGxMqRLDf
   IlLhNQMmfHsCGf19G1qEPzu8n0ot3Vd3AZb2CyH//DT+eLgHF/EdYuEuW
   KYZwD4K107ROqYErIstWg/yw/YbrtKy6aUgQPVne+HIWz1f79B4UlzpIL
   g==;
X-CSE-ConnectionGUID: 8wtaNaPySE2bP6ZrlzNS9g==
X-CSE-MsgGUID: MTwBvq0sRoOSyivW2rOLIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68085353"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68085353"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
X-CSE-ConnectionGUID: Yei+M1+1Rg2sktxdhi8rvQ==
X-CSE-MsgGUID: /RNu/xleTjG5d+h+ZC/68A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169699542"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.32.147]) ([10.98.32.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 04 Aug 2025 18:27:53 -0700
Subject: [PATCH 2/9] dmaengine: idxd: Fix crash when the event log is
 disabled
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-2-4e020fbf52c1@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754357291; l=1684;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=GFgYukOaeMbxzvvbb9mGCIu7IxHd36cdjEq9BtBbyCc=;
 b=L53BApcXs9pDGTGNUNUjrNRsqZDELZB2MdBBrBx5v230e2DSSC/bBz2KeIVq1CpFVXlRaiheF
 57d6y/w2/71AAWaQdfHmTgrB9S3q7bLIWTKwBeijq25v31MFe5LKcOq
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

If reporting errors to the event log is not supported by the hardware,
and an error that causes Field Level Reset (FLR) is received, the
driver will try to restore the event log even if it was not allocated.

Also, only try to free the event log if it was properly allocated.

Fixes: 6078a315aec1 ("dmaengine: idxd: Add idxd_device_config_save() and idxd_device_config_restore() helpers")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 3 +++
 drivers/dma/idxd/init.c   | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5cf419fe6b4645337cf361305ca066d34763b3c2..c599a902767ee9904d75a0510a911596e35a259b 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -815,6 +815,9 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 	struct idxd_evl *evl = idxd->evl;
 
+	if (!evl)
+		return;
+
 	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
 	if (!gencfg.evl_en)
 		return;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index d828d352ab008127e5e442e7072c9d5df0f2c6cf..a58b8cdbfa60ba9f00b91a737df01517885bc41a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -959,7 +959,8 @@ static void idxd_device_config_restore(struct idxd_device *idxd,
 
 	idxd->rdbuf_limit = idxd_saved->saved_idxd.rdbuf_limit;
 
-	idxd->evl->size = saved_evl->size;
+	if (idxd->evl)
+		idxd->evl->size = saved_evl->size;
 
 	for (i = 0; i < idxd->max_groups; i++) {
 		struct idxd_group *saved_group, *group;

-- 
2.50.1


