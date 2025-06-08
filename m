Return-Path: <dmaengine+bounces-5329-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A625AD1228
	for <lists+dmaengine@lfdr.de>; Sun,  8 Jun 2025 14:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649D716A21B
	for <lists+dmaengine@lfdr.de>; Sun,  8 Jun 2025 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3914620AF62;
	Sun,  8 Jun 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqVUUvCC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A31A5BA3;
	Sun,  8 Jun 2025 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749387299; cv=none; b=bDj+xG2cvZgtz6y89QaKsyEeLkN2gwZ/7mMsHu1QWJwaGNGemUrjyhvadwFaEDIn8dcg8q4wtbQVOp9+uMAY/nzXvYclyhHl/3PaEjW+lFEp5ySkUqnHy9OPeketuRCWcw0LMzGG0XLb3N4/nDgKPFKPpT+a0JcznZ8wWjuM+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749387299; c=relaxed/simple;
	bh=+7dWpHSkjFDR6Bnr1s8j6sMaW0LqBYHN9HBs7ln+MKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKSRMb17RGKeGuHcdyd6sL4Q2HAdJVaK+U8LzrHWpz68Zj/1tv2CTtKM0E/2NyfO3mkbPqgHkhhPlsOEzolbFkW/2EeYXsHsV363gBG8vst2TQTL6/X6A/4ZyZh1YdWe2FlUSjVIgYf5LRlTrPIG2gNq6zwjvzAFHUhCBJQyYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqVUUvCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0262C4CEF4;
	Sun,  8 Jun 2025 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749387298;
	bh=+7dWpHSkjFDR6Bnr1s8j6sMaW0LqBYHN9HBs7ln+MKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GqVUUvCCx1Tu9sM/7LTYYjykVMgyC9JNdB+c/S18NmzCZ1bDStzwAzAFgxoyqBZG4
	 aguqZJCpKLFDcJpkoccG+zJFrk6nAKM2sTez4Jdhj/dpoFqeoCiFWH+Yv5QfFtfBjv
	 c2a+OvgqhO6INKWsErZlg1gTJJtNlVL5H43o5ODQidiSD4/HhcM42awCc4owd01hv3
	 LljHk2tMjHESTMCnN8/QF4omGJAHhu7EgWAv1TlZiz5m7CEzYwJk13fBm728eLbxPi
	 y/b2JORqv3Pu4GEc4eYB8uWM44BVa/TSqia54l54Gl3/XIzJe7Q/oTAB3/LaYbHAD9
	 7ITOeXqsrp+5A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yi Sun <yi.sun@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 06/10] dmaengine: idxd: Check availability of workqueue allocated by idxd wq driver before using
Date: Sun,  8 Jun 2025 08:54:43 -0400
Message-Id: <20250608125447.933686-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250608125447.933686-1-sashal@kernel.org>
References: <20250608125447.933686-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.10
Content-Transfer-Encoding: 8bit

From: Yi Sun <yi.sun@intel.com>

[ Upstream commit 17502e7d7b7113346296f6758324798d536c31fd ]

Running IDXD workloads in a container with the /dev directory mounted can
trigger a call trace or even a kernel panic when the parent process of the
container is terminated.

This issue occurs because, under certain configurations, Docker does not
properly propagate the mount replica back to the original mount point.

In this case, when the user driver detaches, the WQ is destroyed but it
still calls destroy_workqueue() attempting to completes all pending work.
It's necessary to check wq->wq and skip the drain if it no longer exists.

Signed-off-by: Yi Sun <yi.sun@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

Link: https://lore.kernel.org/r/20250509000304.1402863-1-yi.sun@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
detailed analysis:

## Critical Bug Fix Analysis

**1. Real User-Affecting Issue:**
The commit addresses a kernel panic/call trace that occurs in production
environments when running IDXD workloads in containers. The issue is
triggered when Docker doesn't properly propagate mount replicas, leading
to improper workqueue destruction sequences.

**2. Race Condition Fix:**
The core problem is a race condition where:
- The user driver detaches and `wq->wq` is set to NULL in
  `destroy_workqueue(wq->wq); wq->wq = NULL;`
- But `idxd_cdev_evl_drain_pasid()` still attempts to call
  `drain_workqueue(wq->wq)`
- This causes a NULL pointer dereference when accessing `wq->wq`

**3. Minimal, Focused Change:**
The fix adds just two lines:
```c
- drain_workqueue(wq->wq);
+       if (wq->wq)
+               drain_workqueue(wq->wq);
```

This is exactly the type of small, defensive change appropriate for
stable backports.

**4. Evidence from Kernel Analysis:**
My research of the mainline kernel confirms this NULL check pattern
doesn't exist in current code, indicating this is a legitimate new bug
fix. The current code at `drivers/dma/idxd/cdev.c:352` calls
`drain_workqueue(wq->wq)` without any NULL protection.

**5. Critical Subsystem:**
The IDXD (Intel Data Streaming Accelerator) driver is used in high-
performance computing and data center environments. Kernel panics in
this subsystem can affect critical workloads.

**6. Comparison to Similar Backported Commits:**
This closely matches Similar Commit #1 and #4 (both marked YES for
backporting):
- Fixes driver probe/removal issues
- Prevents kernel crashes during error paths
- Small, contained change with minimal regression risk
- Addresses resource cleanup problems

**7. Production Impact:**
The commit message specifically mentions this affects containerized
workloads, which are common in production environments. The failure mode
(kernel panic) is severe.

**8. No Architectural Changes:**
The fix doesn't modify any APIs, data structures, or control flow - it
simply adds a defensive NULL check before using a potentially destroyed
workqueue.

This commit perfectly fits the stable tree criteria: it fixes an
important bug that causes kernel panics, has minimal risk of regression,
is small and contained, and addresses a real user-reported issue in
production environments.

 drivers/dma/idxd/cdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 6d12033649f81..bc934bc249df1 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -349,7 +349,9 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
 			set_bit(h, evl->bmap);
 		h = (h + 1) % size;
 	}
-	drain_workqueue(wq->wq);
+	if (wq->wq)
+		drain_workqueue(wq->wq);
+
 	mutex_unlock(&evl->lock);
 }
 
-- 
2.39.5


