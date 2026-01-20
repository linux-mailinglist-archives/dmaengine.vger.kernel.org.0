Return-Path: <dmaengine+bounces-8409-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKm2OA/gb2n8RwAAu9opvQ
	(envelope-from <dmaengine+bounces-8409-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 21:05:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 797FE4AFB4
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 21:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36C398846BF
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE5D47B42F;
	Tue, 20 Jan 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEVy/UHo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7847B42D;
	Tue, 20 Jan 2026 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937708; cv=none; b=k3gdI+Uo93deioI+zO7pNrG1uCpL2KfGtBtwn35IkwxjimwtwWjIZT8Pkrl9iXuHxs65Lw2RdhbEt/ob2QqVou7jAia339I+gDdlRmqwhOni1AccFJsxjZKcsEz27Vdynn/OQujbkcbNRZpuwBw+/TAgNuwqq5jwse7PCDMgH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937708; c=relaxed/simple;
	bh=LhUtgzXOVPV8SD3R2VJ6zeG5rQgZrdms4OAVI/3ji5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhJ9meRNt0cCha9lH21urnk6yaGT3z9GNrDR/ieUbVUukJ4D2RfLXK6BKFHxNe8SPTykfNvPGXVikML6qkOcx1oEV8FxnoO8d7wno10UkpRz+hr9oJKwNTUqv+6pDfM6j06IuZmT/fvby4OZcY+NZCiUvvSESvuu/BoCMhEqG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEVy/UHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2E1C19421;
	Tue, 20 Jan 2026 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768937705;
	bh=LhUtgzXOVPV8SD3R2VJ6zeG5rQgZrdms4OAVI/3ji5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEVy/UHoYyT1NPcSaM7OZOWOmpSp4fz9Om0Cj6qr09uIAdFFQCGFWFoJwEBZjZelF
	 0s5s3uDl6t/EemYHuhJQYi02UXEaIoi+Evq+YYb29zaLur/hnFOBVC+nD9Yt2iJm9i
	 lk1eIjzyP0wY3B+x8ZZgjXNp6oyxHmqijIoj3gzwx2ATIP5dfPPpTPHB4gMi1iT5aX
	 6lPTff7/GyXtZswom8WOVMkaJPTGwPTEBLbiSDdprgJetN3HboA+fs0PqAhDoN7XMU
	 9mLUGTqe3iNigiDAl894Y1WZoUaLiXdGmQUjfl7/XOISnI5+8BQvJSTg4GmXksmwXY
	 GFUjZem7TrGQg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Guodong Xu <guodong@riscstar.com>,
	Juan Li <lijuan@linux.spacemit.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH AUTOSEL 6.18] dmaengine: mmp_pdma: Fix race condition in mmp_pdma_residue()
Date: Tue, 20 Jan 2026 14:34:48 -0500
Message-ID: <20260120193456.865383-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120193456.865383-1-sashal@kernel.org>
References: <20260120193456.865383-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8409-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,msgid.link:url,riscstar.com:email]
X-Rspamd-Queue-Id: 797FE4AFB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guodong Xu <guodong@riscstar.com>

[ Upstream commit a143545855bc2c6e1330f6f57ae375ac44af00a7 ]

Add proper locking in mmp_pdma_residue() to prevent use-after-free when
accessing descriptor list and descriptor contents.

The race occurs when multiple threads call tx_status() while the tasklet
on another CPU is freeing completed descriptors:

CPU 0                              CPU 1
-----                              -----
mmp_pdma_tx_status()
mmp_pdma_residue()
  -> NO LOCK held
     list_for_each_entry(sw, ..)
                                   DMA interrupt
                                   dma_do_tasklet()
                                     -> spin_lock(&desc_lock)
                                        list_move(sw->node, ...)
                                        spin_unlock(&desc_lock)
  |                                     dma_pool_free(sw) <- FREED!
  -> access sw->desc <- UAF!

This issue can be reproduced when running dmatest on the same channel with
multiple threads (threads_per_chan > 1).

Fix by protecting the chain_running list iteration and descriptor access
with the chan->desc_lock spinlock.

Signed-off-by: Juan Li <lijuan@linux.spacemit.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Link: https://patch.msgid.link/20251216-mmp-pdma-race-v1-1-976a224bb622@riscstar.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

This confirms the `mmp_pdma_residue()` function was added in 2014. The
race condition has existed since then.

## Analysis Summary

### 1. COMMIT MESSAGE ANALYSIS

The commit message clearly describes:
- A **use-after-free (UAF) race condition** in `mmp_pdma_residue()`
- The race occurs between `tx_status()` (calling `mmp_pdma_residue()`)
  and the DMA tasklet (`dma_do_tasklet()`)
- **Clear reproduction steps**: running dmatest with `threads_per_chan >
  1`
- The CPU timeline diagram explicitly shows the race window between
  unlocked list iteration and descriptor free

Keywords: "Fix race condition", "use-after-free", "UAF"

### 2. CODE CHANGE ANALYSIS

**The bug:** `mmp_pdma_residue()` iterates over `chan->chain_running`
list and accesses descriptor contents (`sw->desc`) without holding the
`desc_lock` spinlock. Meanwhile, `dma_do_tasklet()` can:
1. Hold `desc_lock`
2. Move descriptors from `chain_running` to `chain_cleanup` via
   `list_move()`
3. Release `desc_lock`
4. Free the descriptor via `dma_pool_free()`

If `mmp_pdma_residue()` is iterating over the list when this happens, it
can access freed memory (UAF).

**The fix:** Adds `spin_lock_irqsave(&chan->desc_lock, flags)` before
the `list_for_each_entry()` loop and `spin_unlock_irqrestore()` at all
exit points from the function. This is:
- Small (+6 lines, -0 lines of actual logic)
- Surgical - uses the existing `desc_lock` that already protects this
  list elsewhere
- Follows existing driver patterns (other list operations use this lock)

### 3. CLASSIFICATION

This is a **bug fix** for a **use-after-free vulnerability**. This is a
serious memory safety issue:
- Can cause kernel crashes/panics
- Can lead to data corruption
- Potential security implications (UAF bugs are commonly exploitable)

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed**: ~10 lines (just adding lock/unlock around existing
  code)
- **Files touched**: 1 file
- **Complexity**: Very low - straightforward spinlock acquisition
- **Risk of regression**: Minimal - uses existing lock that is designed
  for this purpose
- **Potential issues**: Slightly increased lock contention when calling
  `tx_status()`, but this is necessary for correctness

### 5. USER IMPACT

- **Who is affected**: Users of MMP PDMA DMA controller (Marvell PXA/MMP
  platforms, SpacemiT K1)
- **Trigger conditions**: Multi-threaded DMA operations on same channel
  (common in dmatest, may occur in real workloads)
- **Severity**: High - UAF can cause kernel crashes or undefined
  behavior
- **Reproducibility**: Can be reproduced with dmatest (`threads_per_chan
  > 1`)

### 6. STABILITY INDICATORS

- Has proper sign-offs: `Signed-off-by` from author, forwarder, and DMA
  maintainer (Vinod Koul)
- Link to mailing list discussion included
- The existing lock (`desc_lock`) has been in the driver since the
  beginning
- The locking pattern matches other functions in the driver

### 7. DEPENDENCY CHECK

- No dependencies on other commits
- The affected code (`mmp_pdma_residue()`) has existed since 2014
- The `desc_lock` spinlock exists in all stable trees
- Should apply cleanly to any kernel from 3.15+ (when residue reporting
  was added)

**Note**: Recent mainline commits added SpacemiT K1 support with 64-bit
operations (`pdev->ops->get_desc_dst_addr`, etc.), but the core logic
and the race condition existed with the original 32-bit implementation
too. For older stable trees (pre-6.x), minor context adjustments might
be needed due to the `pdev->ops->` refactoring, but the fix concept
remains the same.

### Conclusion

This commit fixes a clear **use-after-free race condition** in the MMP
PDMA driver. The bug:
- Can cause kernel crashes/panics
- Has existed since 2014 (when residue reporting was added)
- Is reproducible with standard kernel testing tools (dmatest)

The fix:
- Is small and surgical (~10 lines of spinlock additions)
- Uses existing infrastructure (the `desc_lock` already exists for this
  purpose)
- Follows existing driver patterns
- Has minimal regression risk

This is exactly the type of fix stable trees need: a clearly correct fix
for a real bug that users can hit, with minimal risk of introducing new
problems.

**YES**

 drivers/dma/mmp_pdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index d07229a748868..481b58c414e47 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -928,6 +928,7 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 {
 	struct mmp_pdma_desc_sw *sw;
 	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(chan->chan.device);
+	unsigned long flags;
 	u64 curr;
 	u32 residue = 0;
 	bool passed = false;
@@ -945,6 +946,8 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 	else
 		curr = pdev->ops->read_src_addr(chan->phy);
 
+	spin_lock_irqsave(&chan->desc_lock, flags);
+
 	list_for_each_entry(sw, &chan->chain_running, node) {
 		u64 start, end;
 		u32 len;
@@ -989,6 +992,7 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 			continue;
 
 		if (sw->async_tx.cookie == cookie) {
+			spin_unlock_irqrestore(&chan->desc_lock, flags);
 			return residue;
 		} else {
 			residue = 0;
@@ -996,6 +1000,8 @@ static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
 		}
 	}
 
+	spin_unlock_irqrestore(&chan->desc_lock, flags);
+
 	/* We should only get here in case of cyclic transactions */
 	return residue;
 }
-- 
2.51.0


