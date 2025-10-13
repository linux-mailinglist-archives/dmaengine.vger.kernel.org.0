Return-Path: <dmaengine+bounces-6823-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D934FBD57BF
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 19:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34073E5B12
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E1C2BE63A;
	Mon, 13 Oct 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gohuTDct"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB602296BBA;
	Mon, 13 Oct 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374862; cv=none; b=EH+PIS4250gzRGXDoeMBR43b/Di6bqkJ9RwZ7hNUfV291fShfbZOYoZdPNaajKpSehzCCnb4lMOfwT8oyTLficPBh9q2WLW4n7GbMz3ExgRZRpLeA2F4wkTjyP75V/96BIVyXQfbsdcHd6uwAtCaNKXWH8clqvPP2Dhp7HBpdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374862; c=relaxed/simple;
	bh=4MFSAeuVpBQvqmqSjyK0yJwFQ/ROFaatrCdCEs5ayzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxeJPjUZQUY+EgXE0/b2269LsROnsCxtnkKQc1j7zFB86Bc53muwV3I+tm3unhC3jBvN+xqK/NBJWdSQsQihEQ1OqgNlYG+O1JWuHVX9dLyp7i/TkdMYEaATeKehHJMdro6RJ+30Wss1eNh2JN/0wWW3kPp3yJa/25Rqfw+QP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gohuTDct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE13CC4CEE7;
	Mon, 13 Oct 2025 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760374861;
	bh=4MFSAeuVpBQvqmqSjyK0yJwFQ/ROFaatrCdCEs5ayzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gohuTDctP/tRfmO3/xVb5WLeKnExyL5x1G4z8tKesogZC8d4hdxZOxFdM3cisefKt
	 vuFy4URynmScK2I3YKULu+SyXWuni0UiHUVIb4AYDxdiTeh77KfNrJLztNYuozvdic
	 XorxEJxxuoWF5RH3CI6IQrlUjn1Dp1HGPiCrJZlMUbSZ5e0aPDwTVpPIbb4FYW/oLy
	 e+m4MrLz/8oMtb5f+zCEjKavwylklTtKXg/cz0NMIGXSdenHO+OIsAfNK6IGgTu/WA
	 yC8jNan0AlVc551WRYrLXhrfL75zzx5R8z0zMVHrNVjV+zBq7C8gHQWbm22idgQSb0
	 SI0Ys/E8n6F5A==
Date: Mon, 13 Oct 2025 10:00:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Yixun Lan <dlan@gentoo.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, elder@riscstar.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Guodong Xu <guodong@riscstar.com>
Subject: Re: [PATCH] dmaengine: mmp_pdma: fix DMA mask handling
Message-ID: <20251013170055.GA3968340@ax162>
References: <20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com>
 <20250930221001.GA66006@ax162>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930221001.GA66006@ax162>

Hi Vinod,

On Tue, Sep 30, 2025 at 03:10:01PM -0700, Nathan Chancellor wrote:
> On Thu, Sep 18, 2025 at 10:27:27PM +0800, Guodong Xu wrote:
> > The driver's existing logic for setting the DMA mask for "marvell,pdma-1.0"
> > was flawed. It incorrectly relied on pdev->dev->coherent_dma_mask instead
> > of declaring the hardware's fixed addressing capability. A cleaner and
> > more correct approach is to define the mask directly based on the hardware
> > limitations.
> > 
> > The MMP/PXA PDMA controller is a 32-bit DMA engine. This is supported by
> > datasheets and various dtsi files for PXA25x, PXA27x, PXA3xx, and MMP2,
> > all of which are 32-bit systems.
> > 
> > This patch simplifies the driver's logic by replacing the 'u64 dma_mask'
> > field with a simpler 'u32 dma_width' to store the addressing capability
> > in bits. The complex if/else block in probe() is then replaced with a
> > single, clear call to dma_set_mask_and_coherent(). This sets a fixed
> > 32-bit DMA mask for "marvell,pdma-1.0" and a 64-bit mask for
> > "spacemit,k1-pdma," matching each device's hardware capabilities.
> > 
> > Finally, this change also works around a specific build error encountered
> > with clang-20 on x86_64 allyesconfig. The shift-count-overflow error is
> > caused by a known clang compiler issue where the DMA_BIT_MASK(n) macro's
> > ternary operator is not correctly evaluated in static initializers. By
> > moving the macro's evaluation into the probe() function, the driver avoids
> > this compiler bug.
> > 
> > Fixes: 5cfe585d8624 ("dmaengine: mmp_pdma: Add SpacemiT K1 PDMA support with 64-bit addressing")
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Closes: https://lore.kernel.org/lkml/CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org> # build
> 
> It would be great if this could be picked up before the 6.18 DMA pull
> request so that I do not have to patch our CI to avoid this issue.

This patch resolves a (bogus) clang warning that breaks the build with
-Werror. Can you please queue this for a future DMA fixes pull request?
This has been available for almost a month and really should have made
the original 6.18 pull request but I dropped the ball on pinging again
before it went out since I was dealing with Kbuild this cycle.

Cheers,
Nathan

