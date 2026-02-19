Return-Path: <dmaengine+bounces-8966-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOYvO6hxlmlqfQIAu9opvQ
	(envelope-from <dmaengine+bounces-8966-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 03:12:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F4D15B9A2
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 03:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 785DE3077BF0
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 02:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2667F3112B2;
	Thu, 19 Feb 2026 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wil0D8ZP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7B310779;
	Thu, 19 Feb 2026 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771466709; cv=none; b=IBKnbvQX/FRW76HbDlXP3QFgPm3FkTQbWL08cd3q6pJXSZoqnX7k0asgg/IlyHeB9fqe2UQsa3MPwiL5f3fq+nBKWuAoYUr8rc/Tu93RnWUCutPbcYIoijSWsmUYyhBrDx4qVQkCZ7vSXrWq2+fhu9M25MV6LhSSpyNwkw1kAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771466709; c=relaxed/simple;
	bh=frX33pev+XR4l6oz6+xiDXC5X50uJZtofsvGkHEY7RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnWxErthvXPJAR0g1DPhwuat99lik3HJ7IEfoCe20fd1cKYn2TghmUYtFNccjapZZsPemvyneLdQ5k8g/1gTc6oRjdQSGUERftFsgq/6pPxrafSrylNUB5Q1dog9SNeUCRW5w35mGtf/GbsYGlgdDAbX+ubkoXGonwPspF/0x2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wil0D8ZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E80C19425;
	Thu, 19 Feb 2026 02:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771466708;
	bh=frX33pev+XR4l6oz6+xiDXC5X50uJZtofsvGkHEY7RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wil0D8ZPPDa/S/GwFA0Vt8A7F+18QXRUJX7g1qSxJ8KtCPtQnuacBrPrFwKlrGyHu
	 JgVpr2O1y77ZO47EzS29aj4W38oN2jH+LqivTGB+V1QW6LnJbMcg4cpYPpCLK8b0Qe
	 QUuGrLtVyW8ddNVjP4YWaCEz4jI+6kdKiDb6q6oHqWbEMSQywfwantQ4JP0fVJWEZH
	 +tAlhiet9F/1S5iA0V5yO3wyQFOz3PutsJ8hoBLcNF0s0pM32Juu7vBJYZzh4tx1Ni
	 x+JXQeLhdbCbdjVheDdGiYc87WyL20aa84aIxKCDefJhnpS2Cp58vQRTHIjbTg3Pgl
	 sxH+9dvSEM9hw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	dmaengine@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] dmaengine: stm32-dma3: use module_platform_driver
Date: Wed, 18 Feb 2026 21:04:11 -0500
Message-ID: <20260219020422.1539798-35-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219020422.1539798-1-sashal@kernel.org>
References: <20260219020422.1539798-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8966-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foss.st.com,linaro.org,kernel.org,gmail.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 94F4D15B9A2
X-Rspamd-Action: no action

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

[ Upstream commit 0d41ed4ea496fabbb4dc21171e32d9a924c2a661 ]

Without module_platform_driver(), stm32-dma3 doesn't have a
module_exit procedure. Once stm32-dma3 module is inserted, it
can't be removed, marked busy.
Use module_platform_driver() instead of subsys_initcall() to register
(insmod) and unregister (rmmod) stm32-dma3 driver.

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Link: https://patch.msgid.link/20251121-dma3_improv-v2-1-76a207b13ea6@foss.st.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Interesting - all three STM32 DMA drivers use `subsys_initcall()`. The
other two (stm32-dma and stm32-mdma) also lack module_exit. This commit
only changes stm32-dma3.

## Analysis Summary

### What the commit fixes
The stm32-dma3 driver registers using `subsys_initcall()` but has no
`module_exit()` function. This means the module can be loaded (`insmod`)
but never unloaded (`rmmod`), as the kernel marks it as busy due to
having no exit/cleanup path.

### Change implications
The fix replaces `subsys_initcall()` (priority level 4) with
`module_platform_driver()` which uses `module_init()` /
`device_initcall()` (priority level 6). This is a **behavioral change**
- the driver will now:
1. Initialize later in the boot sequence (device_initcall instead of
   subsys_initcall)
2. Be unloadable via rmmod

### Risk Assessment
- **Positive**: Fixes inability to unload the module - this is a genuine
  bug fix
- **Risk**: The init level change from `subsys_initcall` (level 4) to
  `device_initcall` (level 6) could cause probe ordering issues. DMA
  controllers are often needed early by other subsystems. However, with
  device tree and deferred probing in modern kernels, this should be
  handled. The fact that 54 other DMA drivers use
  `module_platform_driver()` successfully supports this.
- **Scope**: Very small change - removes 6 lines, adds 1 line. Single
  file, single driver.
- **Affected stable trees**: Only 6.11+ (driver introduced in
  v6.11-rc1), so this would apply to v6.12.y and v6.13.y stable trees.

### Stable criteria assessment
- **Fixes a real bug**: Yes - module cannot be unloaded
- **Obviously correct**: Mostly. The `module_platform_driver()` macro is
  the standard pattern used by the majority of DMA drivers. However, the
  init level change adds a small risk.
- **Small and contained**: Yes - 7 lines changed in one file
- **No new features**: The ability to unload a module is restoring
  expected behavior, not a new feature
- **Tested**: Has a Reviewed-by tag from Eugen Hristev

### Concerns
1. The initialization order change (`subsys_initcall` →
   `device_initcall`) is the main concern. DMA engines are
   infrastructure that other drivers depend on. If anything probes
   before the DMA controller is ready and doesn't handle deferred
   probing correctly, this could cause regressions.
2. However, this is mitigated by the fact that modern device tree
   platforms and probe deferral should handle this gracefully.
3. The bug (inability to rmmod) primarily affects development/debugging
   workflows and modular kernel configurations, not production embedded
   systems that typically build DMA drivers in.

## Verification

- **git log** confirmed stm32-dma3.c was introduced by commit
  f561ec8b2b33d, which is in v6.11-rc1
- **Read of current source** (line 1917-1922) confirmed the
  `subsys_initcall` without `module_exit` pattern matches the pre-patch
  state
- **Grep of drivers/dma/stm32/** confirmed all three STM32 DMA drivers
  use subsys_initcall - this commit only changes stm32-dma3
- **Grep of drivers/dma/** found 21 DMA drivers using subsys_initcall
  and 54 using module_platform_driver, confirming module_platform_driver
  is the dominant pattern
- **git tag** confirmed the driver exists only in 6.11+ stable trees
- The `.remove` callback (`stm32_dma3_remove`) is already defined in the
  platform_driver struct (line 1909), confirming the removal path was
  intended to work

## Conclusion

This fixes a real bug (module cannot be unloaded) with a minimal, well-
understood change using a standard kernel macro. The risk is the init
level change, but this follows the pattern of the majority of DMA
drivers. The fix is small, reviewed, and appropriate for stable. The
driver only exists in 6.11+, limiting the scope of backport. For
embedded/STM32 developers who load the DMA3 driver as a module, this is
a meaningful fix.

**YES**

 drivers/dma/stm32/stm32-dma3.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 50e7106c5cb73..9500164c8f688 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1914,12 +1914,7 @@ static struct platform_driver stm32_dma3_driver = {
 	},
 };
 
-static int __init stm32_dma3_init(void)
-{
-	return platform_driver_register(&stm32_dma3_driver);
-}
-
-subsys_initcall(stm32_dma3_init);
+module_platform_driver(stm32_dma3_driver);
 
 MODULE_DESCRIPTION("STM32 DMA3 controller driver");
 MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@foss.st.com>");
-- 
2.51.0


