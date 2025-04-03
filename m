Return-Path: <dmaengine+bounces-4813-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FD0A7A7E8
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181F8173ADA
	for <lists+dmaengine@lfdr.de>; Thu,  3 Apr 2025 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E532512CB;
	Thu,  3 Apr 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHlhThqP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFFA2500C5;
	Thu,  3 Apr 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697474; cv=none; b=CmHDWxhjqbgBO+Mp0lyQyEFQHZmDFlk1lfwCKugyrN05x4G9vo/hqQqGjrOjPjYUA9mCgDzVaobGlqXI/B47aeESaE9fx1gijdrJW/l8aR9BTLaavyal6v0xlAtpOUN3Dh4n9hHR+VrhgTIqzRZ8I7pWJAfO6cX+zXV+OABX9Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697474; c=relaxed/simple;
	bh=jyJRTRAHy1cZSnHmfgR4+oj4/9L6975s3vJ2+NNfUxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nGFTNSCwq57NRLflN5Gqy0DYt9CWYAuor6ISH/xcNvtatYra5hnDaSBoKTq7lYplSnP08/rRMZMmJ62yJHVzt0uGm+saZ7Rm0PP1GMqvdgTRZuQJJjg1nwERg0BznvKobXi4/9OnCN12aeU3k/BcEi4D0gy5ku72fsKMaEmidO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHlhThqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FA07C4CEE3;
	Thu,  3 Apr 2025 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743697474;
	bh=jyJRTRAHy1cZSnHmfgR4+oj4/9L6975s3vJ2+NNfUxs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=aHlhThqPIuhOxn7peeNumUzA4fGvZ5zt55qfiQkKjJ1zcFCpezkRI17g+C4DFtb3m
	 eH/bfP0LJtu+clSbkcyLNYEA0bIwxsGj/dCv448xFP43qgKVpL08pDImG2c/FXLCAa
	 OA6KBoiz+EyMXa4Rm8qjZKs7iQiq9GhxabdKQ5cmtrXxRH2MYnQa08m+YRTukI8yEF
	 DCxnv2HYLbXQdh++Ja0kMpS8Mnbn52qoJ55P3y8op9CpDObgSz/HcpT9clsfJhmpWt
	 uR5VmU6GKY70jvVchXTxBLMd9QZKsfEgCl54fINUAs9657HBnu791SmWGeVeiKmwYm
	 JVpGHCh9nX1kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E704C3600C;
	Thu,  3 Apr 2025 16:24:34 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Thu, 03 Apr 2025 11:24:19 -0500
Subject: [PATCH] Revert "dmaengine: dmatest: Fix dmatest waiting less when
 interrupted"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-dmaengine-dmatest-revert-waiting-less-v1-1-8227c5a3d7c8@amd.com>
X-B4-Tracking: v=1; b=H4sIADK27mcC/x2NQQrCMBBFr1Jm7cC0qQW9irgIzTcO6CiZUIXSu
 xu7e2/x/l/JURRO526lgkVdX9akP3Q036NlsKbmNMhwlFECp2eEZTX8qcIrtwyl8idqVcv8gDt
 HmaZwSpL6OVDbehfc9Lv/XK7b9gNUZ22YdwAAAA==
X-Change-ID: 20250403-dmaengine-dmatest-revert-waiting-less-a06639d0d1c3
To: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743697473; l=1742;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=Rc7Qs86ICgVAk71Y+cZz9vWqynj5i2cRse2Xp/Ofc2A=;
 b=P/YaHgve0A48XRJovDouoH5dpci4+Zxe86GQH8kuKzUDVnHgw8+8THPwPx/NkTI33Vhkw7ULV
 lsd9JmmHN/vBthrO0kvGH/pTK65GUuNyfIVxqAyLmDTyZxddgO/ydDA
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Several issues with this change:

* The analysis is flawed and it's unclear what problem is being
  fixed. There is no difference between wait_event_freezable_timeout()
  and wait_event_timeout() with respect to device interrupts. And of
  course "the interrupt notifying the finish of an operation happens
  during wait_event_freezable_timeout()" -- that's how it's supposed
  to work.

* The link at the "Closes:" tag appears to be an unrelated
  use-after-free in idxd.

* It introduces a regression: dmatest threads are meant to be
  freezable and this change breaks that.

See discussion here:
https://lore.kernel.org/dmaengine/878qpa13fe.fsf@AUSNATLYNCH.amd.com/

Fixes: e87ca16e9911 ("dmaengine: dmatest: Fix dmatest waiting less when interrupted")
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/dmatest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index d891dfca358e209c9a5c2d8b49e3e539130e53e8..91b2fbc0b8647127c7753669fa21c84d300764b9 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -841,9 +841,9 @@ static int dmatest_func(void *data)
 		} else {
 			dma_async_issue_pending(chan);
 
-			wait_event_timeout(thread->done_wait,
-					   done->done,
-					   msecs_to_jiffies(params->timeout));
+			wait_event_freezable_timeout(thread->done_wait,
+					done->done,
+					msecs_to_jiffies(params->timeout));
 
 			status = dma_async_is_tx_complete(chan, cookie, NULL,
 							  NULL);

---
base-commit: 6565439894570a07b00dba0b739729fe6b56fba4
change-id: 20250403-dmaengine-dmatest-revert-waiting-less-a06639d0d1c3

Best regards,
-- 
Nathan Lynch <nathan.lynch@amd.com>



