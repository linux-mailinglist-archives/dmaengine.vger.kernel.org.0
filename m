Return-Path: <dmaengine+bounces-8129-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCFBD048B0
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 17:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91D36319A486
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25DF27F017;
	Thu,  8 Jan 2026 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdi6bUqv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3F2877FC;
	Thu,  8 Jan 2026 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886097; cv=none; b=IjcM1s2uoLFC1ONtRLchrBl8KMKJ8HKAF1D/AXM0VPSYxsD7DH7S7BegMPjW8rV1UfqFYWHM9w1xjHFaYFpytGc9xB9HzBnzgv5yzGMLoEl4xxv18CqEyN1k1CYWoIFDA+vVLQK1v/+2S4Kxe1TPXb4qNDGHi3u0UVuRBymfEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886097; c=relaxed/simple;
	bh=E5e1s7u7BuNOAe9+8E8ZA0upewfom6zXYwsboyfIQLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aeabJhIbcNRbigbssP3vA7EyDoB15mdXMj9MsAm9fDZ29G4yVjX/vNr1YKvcvmA+7yQMqBjySZaBK1bZS1PEfiLWMd62o9oDUzc7Mtujh1K5giqq8FJHNFU30mxmXAAc0e2zL2YfJIvoJkeq5Vf09OgXsNs/q4ghj+PFdYuOaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdi6bUqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5F6C116D0;
	Thu,  8 Jan 2026 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767886097;
	bh=E5e1s7u7BuNOAe9+8E8ZA0upewfom6zXYwsboyfIQLk=;
	h=From:To:Cc:Subject:Date:From;
	b=hdi6bUqvv1l+nTotmlwg1Z2shnVZIvhIAcJp+Ge7bb0sf5wuirkEbLfwbJbhKnfoa
	 1PnKEKcRlx/GGTmlw/h0hDA8R12mL/sEjcGnLss2aKlNX8CMnVncQUj+0EP0hZRFjm
	 G2kOjU08FpBUkMA37r+LWUGqIyXuGWHUHtjv2ZA29La0o+qr8Cy5AgS/uyO+oqF47w
	 ryKvi9lfBceo1oJ2OStJSXSq61i6zwIM00FLyHuRrs3ph/as0Mh2r0hl+MqZcrr1nr
	 /W2p4b4S/MBDJWqmZy0x/9GyZQk0efqxqUsBaCFdcgNr1F9D2usl60snSPMTns5ijo
	 EsX++gdeY/RYg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>, Vinod Koul <vkoul@kernel.org>
Subject:
 [RESEND][PATCH v1] dmaengine: sh: Discard pm_runtime_put() return value
Date: Thu, 08 Jan 2026 16:28:13 +0100
Message-ID: <8633556.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Clobbering an error value to be returned from shdma_tx_submit() with
a pm_runtime_put() return value is not particularly useful, especially
if the latter is 0, so stop doing that.

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is requisite for converting pm_runtime_put() into a void function.

If you decide to pick it up, please let me know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

Originally posted here:

https://lore.kernel.org/linux-pm/9626129.rMLUfLXkoz@rafael.j.wysocki/

---
 drivers/dma/sh/shdma-base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -143,7 +143,7 @@ static dma_cookie_t shdma_tx_submit(stru
 				}
 
 				schan->pm_state = SHDMA_PM_ESTABLISHED;
-				ret = pm_runtime_put(schan->dev);
+				pm_runtime_put(schan->dev);
 
 				spin_unlock_irq(&schan->chan_lock);
 				return ret;




