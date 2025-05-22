Return-Path: <dmaengine+bounces-5245-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4A8AC04A1
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 08:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77D68C12EC
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 06:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4C221D9A;
	Thu, 22 May 2025 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X8L7SJ5Q"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F2221545;
	Thu, 22 May 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895627; cv=none; b=sP59IDEaMBq1XHkvPNvXufgvMD9qfKN11C5s+MMe/QtPNt7OYTTeKDnUopGnIIF/c+WnvBLpf6NecAL+L+fRIIAbcPMQfJ+zIgC6hAQusb0MfOVYCGOZPJZ0lHo3ZQeQem6ZzIhXvjvkZUAmb9SDhOycMpZJ6G8MT+o4kTernT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895627; c=relaxed/simple;
	bh=wNk2+OKsEq/DR//t2NAj31ZXY1zmFeyeq++ojvIakwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1lZdpLW+UWzniCKTdv9QjCgDIwbfDVHYy1WmFenRWusvRwwKolJMvmjRJHKtdJ/4FN1s7cRDeNpoN/jYdtSn74efa6WC6cBMVEXFqeykaxxMV2Bqj87e/1Mj1UUmUs3NueunrZNjRSMu+BxrapNaNAyHPDUJS4HOPrP3iuX4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X8L7SJ5Q; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747895613; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=G5T5vQBP7VDmXiTjxitsUt9CyrtXdYxS6Dzmv1QSkyc=;
	b=X8L7SJ5QIPBKYrdKNvCFmfdEAv972WOEy+rde+wgEJ5A9UBPWwGPYL2Sn4eT3oKPp54TBpD0e4orLDsuSlZpX9TjRkf7qzbvvMW4G8vbTcgHbdFmkYnM6kn7XXWeD9Q170ODayglcaProO/G3UKesglAw5FhZRlVkKqdElZUdYQ=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WbUiQNO_1747895613 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 May 2025 14:33:33 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	vkoul@kernel.org
Cc: xueshuai@linux.alibaba.com,
	dmaengine@vger.kernel.org,
	colin.i.king@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dmaengine: idxd: Fix race condition between WQ enable and reset paths
Date: Thu, 22 May 2025 14:33:28 +0800
Message-ID: <20250522063329.51156-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
References: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A device reset command disables all WQs in hardware. If issued while a WQ
is being enabled, it can cause a mismatch between the software and hardware
states.

When a hardware error occurs, the IDXD driver calls idxd_device_reset() to
send a reset command and clear the state (wq->state) of all WQs. It then
uses wq_enable_map (a bitmask tracking enabled WQs) to re-enable them and
ensure consistency between the software and hardware states.

However, a race condition exists between the WQ enable path and the
reset/recovery path. For example:

A: WQ enable path                   B: Reset and recovery path
------------------                 ------------------------
a1. issue IDXD_CMD_ENABLE_WQ
                                   b1. issue IDXD_CMD_RESET_DEVICE
                                   b2. clear wq->state
                                   b3. check wq_enable_map bit, not set
a2. set wq->state = IDXD_WQ_ENABLED
a3. set wq_enable_map

In this case, b1 issues a reset command that disables all WQs in hardware.
Since b3 checks wq_enable_map before a2, it doesn't re-enable the WQ,
leading to an inconsistency between wq->state (software) and the actual
hardware state (IDXD_WQ_DISABLED).

To fix this, the WQ state should be set to IDXD_WQ_ENABLED before issuing
the IDXD_CMD_ENABLE_WQ command. This ensures the software state aligns with
the expected hardware behavior during resets:

A: WQ enable path                   B: Reset and recovery path
------------------                 ------------------------
                                   b1. issue IDXD_CMD_RESET_DEVICE
                                   b2. clear wq->state
a1. set wq->state = IDXD_WQ_ENABLED
a2. set wq_enable_map
                                   b3. check wq_enable_map bit, true
                                   b4. check wq state, return
a3. issue IDXD_CMD_ENABLE_WQ

By updating the state early, the reset path can safely re-enable the WQ
based on wq_enable_map.

A corner case arises when both paths attempt to enable the same WQ:

A: WQ enable path                   B: Reset and recovery path
------------------                 ------------------------
                                   b1. issue IDXD_CMD_RESET_DEVICE
                                   b2. clear wq->state
a1. set wq->state = IDXD_WQ_ENABLED
a2. set wq_enable_map
                                   b3. check wq_enable_map bit
                                   b4. check wq state, not reset
                                   b5. issue IDXD_CMD_ENABLE_WQ
a3. issue IDXD_CMD_ENABLE_WQ

Here, the command status (CMDSTS) returns IDXD_CMDSTS_ERR_WQ_ENABLED,
but the driver treats it as success (IDXD_CMDSTS_SUCCESS), ensuring the WQ
remains enabled.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/dma/idxd/device.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5cf419fe6b46..b424c3c8f359 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -188,16 +188,32 @@ int idxd_wq_enable(struct idxd_wq *wq)
 		return 0;
 	}
 
+	/*
+	 * A device reset command disables all WQs in hardware. If issued
+	 * while a WQ is being enabled, it can cause a mismatch between the
+	 * software and hardware states.
+	 *
+	 * When a hardware error occurs, the IDXD driver calls
+	 * idxd_device_reset() to send a reset command and clear the state
+	 * (wq->state) of all WQs. It then uses wq_enable_map to re-enable
+	 * them and ensure consistency between the software and hardware states.
+	 *
+	 * To avoid inconsistency between software and hardware states,
+	 * issue the IDXD_CMD_ENABLE_WQ command as the final step.
+	 */
+	wq->state = IDXD_WQ_ENABLED;
+	set_bit(wq->id, idxd->wq_enable_map);
+
 	idxd_cmd_exec(idxd, IDXD_CMD_ENABLE_WQ, wq->id, &status);
 
 	if (status != IDXD_CMDSTS_SUCCESS &&
 	    status != IDXD_CMDSTS_ERR_WQ_ENABLED) {
+		clear_bit(wq->id, idxd->wq_enable_map);
+		wq->state = IDXD_WQ_DISABLED;
 		dev_dbg(dev, "WQ enable failed: %#x\n", status);
 		return -ENXIO;
 	}
 
-	wq->state = IDXD_WQ_ENABLED;
-	set_bit(wq->id, idxd->wq_enable_map);
 	dev_dbg(dev, "WQ %d enabled\n", wq->id);
 	return 0;
 }
-- 
2.43.5


