Return-Path: <dmaengine+bounces-5951-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B533B1AC12
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 03:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3F017E677
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 01:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CD3204583;
	Tue,  5 Aug 2025 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjp1eqz4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7421EA7D2;
	Tue,  5 Aug 2025 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357300; cv=none; b=q9+OJEKgcub9kRpwXxi0Z0kCWi7TrF+ZBrRmLZMG3DOpKTxUX6/jaqj9HGO1EBy8NRAOEiMicVSUdawn9LFRPsM4llMdseGuJb3SJBT5c2axq5Gy2BxMeZsHGoez024QTImxCOFfmjv+Ut3v+g76OrH/LqLRiTQJ0C+Sf/nw18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357300; c=relaxed/simple;
	bh=EztGGHn6kT28gd4q118MU0nBKXitkO/GDUTSrKqzUGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQcPu1zaEFP50NP07FjzPyKHJ6f63GQ3BWnUBASK0Q7dd7yRiul3Yk0mKu4tdXsrmzlRfQp9YagdgjH1gLrF3c8+8EdNL1MeK+8Pu9c4vzvYDZzMhFt2y3UbEWdJOM3ZuU/gNXhoOPMSzifcQrH3Tb/Ly1cJ9M3c3w4nt3XdRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjp1eqz4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754357299; x=1785893299;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EztGGHn6kT28gd4q118MU0nBKXitkO/GDUTSrKqzUGM=;
  b=hjp1eqz4D6jZhrd7LLYP0q6rJ0u1TK9WOJoTP1BG+Q2CS6Dy6AP6A/Eq
   J8qe7Vx/+B2qIRt7TjrCkOrjGD0cHNGhg5gVu54vINnLr/4AFPNNBE7xT
   BRTQP8eNdqI6aOUQb9OybShek2yZzd9wO8HWVgN18LE+AHcioLnlUOcVe
   203SnsQSUGzkTi4tf1G3phPcwDYseAXFyOltl2c648QJjGhaZs/0Am+XJ
   1IUmXIJmWvVwYv30Svrv8SRqSUIJAxDvkzfeeQoELuoLPgh/ha9nGdVpu
   RWRCqEGLI01jtG2U6Tc7Nt6b48Ev4oIYE6YkNJCULv4I+wTF+KZSWU/xC
   Q==;
X-CSE-ConnectionGUID: tZyopQqbSqG4P7W1xZs+FA==
X-CSE-MsgGUID: qRABYXi/RKOmOLL6XiQKIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68085368"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68085368"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:12 -0700
X-CSE-ConnectionGUID: OtOLKMmMSEGFC4BpEGY/xQ==
X-CSE-MsgGUID: lE47SnROS1uibV8Alf60ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169699571"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.32.147]) ([10.98.32.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:12 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 04 Aug 2025 18:28:00 -0700
Subject: [PATCH 9/9] dmaengine: idxd: Fix leaking event log memory
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-9-4e020fbf52c1@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754357291; l=1201;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=EztGGHn6kT28gd4q118MU0nBKXitkO/GDUTSrKqzUGM=;
 b=iG7GJUBKmwdXiEUkx0jslAdStb1MvaTNGNuMpwnG7XGNmqZ6TFCqYFWq6hHdcXvUKgKXZnyeK
 KaqHZ7GAT6fBZ1qiGBxu9EZ4OxLnieo2KWeyqYlH6ejlY+pxhiXwBrm
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
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 8f6afcba840ed7128259ad6b58b2fd967b0c151c..288cfd85f3a91f40ce2f8d8150830ad0628eacbe 100644
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


