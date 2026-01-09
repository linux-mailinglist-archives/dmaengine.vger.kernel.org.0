Return-Path: <dmaengine+bounces-8138-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA09D06EEE
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 04:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 924EF3010CDD
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 03:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04613033C6;
	Fri,  9 Jan 2026 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng+f41Og"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C72EA482;
	Fri,  9 Jan 2026 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928456; cv=none; b=Ps5F7cSE1HtNzxBQNgJ4XSs1cJ+cTmANlUbwYUT8r8dH44IBxgEFjLTM8wHV6WUYkbTHASnea6lqfUrz3b048XZbB0NlzO33p1aSPUVm09Lc7CUgWYrgGdFx0KNBdGSHY6dPuDWPoABnjXryG3bp+B1DsC81q3BywUy3ScaHoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928456; c=relaxed/simple;
	bh=sCNCgB1AI1K39BcyZ9Wqu8F3lfvuRR8HKkqOrcjiu5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dhkKmftD5bM9V3jM48H++AjHZMOTjnE0ALcnS0dk7J+3lg9HKRMEDjON/aT8gKnhzN+ZQtHeg3ApXYJSure6xFOapOHwnwodmyh4croMXxFGYy92alJW+8UL1v241HQxdv6hLkHafFNyBubb/lBVt77zs2lki/sssN9JVmLIU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng+f41Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD43C116C6;
	Fri,  9 Jan 2026 03:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767928456;
	bh=sCNCgB1AI1K39BcyZ9Wqu8F3lfvuRR8HKkqOrcjiu5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ng+f41OgYI/w25w/Ru9j/iGgSXB0XtyB723kA/Ml9gwN/4GIZt+FZXkumWMCjTOaV
	 Uyp33XPj8gyiia4UuvLrVO5Sx1eK2qCHsLQbdBoe42D+F0CeL7D8MlnZkSvIhDf5Kq
	 53ExC8LVDVDCrVF36ub1TQ3EMDDJo1fa+CVj//6TrKvInrfd5SaOYw8LkW3PtXryZO
	 s+/ka/ricp/F05hV6jbqSor6QzJRMmM89D1T2Rp0CYvK/f2h4YoIE/JjKE9DSBGnIe
	 xEt0V2UstN570C9PMcrqAZ8S5RHHBFQbdHpYBTJnpNy/lwBc/i+QTV/+31ofmkRHFk
	 DjyjtsOby6ITg==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Stefan Wahren <wahrenst@gmx.net>, 
 Thomas Andreatta <thomasandreatta2000@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Olivier Dautricourt <olivierdautricourt@gmail.com>, 
 Stefan Roese <sr@denx.de>, Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Lizhi Hou <lizhi.hou@amd.com>, 
 Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
References: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 00/13] dmaengine: introduce sg_nents_for_dma() and
 convert users
Message-Id: <176792844895.658957.498171043788217178.b4-ty@kernel.org>
Date: Fri, 09 Jan 2026 08:44:08 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 13 Nov 2025 16:12:56 +0100, Andy Shevchenko wrote:
> A handful of the DMAengine drivers use same routine to calculate the number of
> SG entries needed for the given DMA transfer. Provide a common helper for them
> and convert.
> 
> I left the new helper on SG level of API because brief grepping shows potential
> candidates outside of DMA engine, e.g.:
> 
> [...]

Applied, thanks!

[01/13] scatterlist: introduce sg_nents_for_dma() helper
        commit: 80c70bfb95cdbe0c644070f4ca4754a60f0a4830
[02/13] dmaengine: altera-msgdma: use sg_nents_for_dma() helper
        commit: 47f5cb7878cc62ed95981c5d02862b253eddb590
[03/13] dmaengine: axi-dmac: use sg_nents_for_dma() helper
        commit: 024ae9d3092c425f3ea6eae92086a2001ca2e0c7
[04/13] dmaengine: bcm2835-dma: use sg_nents_for_dma() helper
        commit: 39110c68500a149664bafb0c174baef0d42e2129
[05/13] dmaengine: dw-axi-dmac: use sg_nents_for_dma() helper
        commit: 5d6ceb254fa9ac1f50932c42a0a9a8bedaa3190d
[06/13] dmaengine: k3dma: use sg_nents_for_dma() helper
        commit: 3fc49d21f3a46866724ff8ef8a79c6e2cd9d7676
[07/13] dmaengine: lgm: use sg_nents_for_dma() helper
        commit: f9b0274f53a2d464e71f37e8f4d0d0dc41321259
[08/13] dmaengine: pxa-dma: use sg_nents_for_dma() helper
        commit: 068942eaa232ba752b744d98ff8ab22b26c8bff4
[09/13] dmaengine: qcom: adm: use sg_nents_for_dma() helper
        commit: 425f871d7acdb521d67c2578e6ae688a751d1e80
[10/13] dmaengine: qcom: bam_dma: use sg_nents_for_dma() helper
        commit: 107fdf0c4e944030bf544aea98e8ae8537914177
[11/13] dmaengine: sa11x0: use sg_nents_for_dma() helper
        commit: d7785661010e2fe113aec2500f988a8e73ac3e7b
[12/13] dmaengine: sh: use sg_nents_for_dma() helper
        commit: ac326dca6870f0d8e0787e94b1d9c2c91bb358d7
[13/13] dmaengine: xilinx: xdma: use sg_nents_for_dma() helper
        commit: 3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2

Best regards,
-- 
~Vinod



