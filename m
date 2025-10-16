Return-Path: <dmaengine+bounces-6862-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9EBBE386F
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 14:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560BE585744
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4571334399;
	Thu, 16 Oct 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm5DNpWK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C92334389;
	Thu, 16 Oct 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619358; cv=none; b=UnylPzybLH3SJJQ2Kek7es1813xi8l+EjoZc6WC4drA90l0w4kJGGAOjODHWY0ObGfkSMd10gp6XR38kpti7fZ6UJ9PO2BD1EIMksihZHNm5sr9HYB1E4tfpdY0O+VHR0CGLJDhfu3gs+MVmsUgCD5Gov9gBEo+wvHU8AxXtiqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619358; c=relaxed/simple;
	bh=7Dmfv3gTVej609EwgF8zmpF2F/JwFF1MDizpIwAwxW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hHJ2o+1OBZhLA/wMItLUJ4EBoY+Vwe6s9gfwefqeFyLeSErMOHFwjzcIxoDvI59UcHuVNv6UgpWjcnK3mz6kVnOrD1Lyo/f00T2FmBhDQTcJ0bgSY5Eib5D+FSz40wbDghNTGzwhyCzYPPYYB0CtralT8JP9p+tkfjj5cVwtwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm5DNpWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EA3C4CEF1;
	Thu, 16 Oct 2025 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760619358;
	bh=7Dmfv3gTVej609EwgF8zmpF2F/JwFF1MDizpIwAwxW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Wm5DNpWKiyXCmb8pBnZf09ttGff7hmyRFqlylVnDywj8b2nARKejbvCd5ylHUsxKR
	 nAvMhrBFytg9mTttj0x7whpEupq1fonhaorr5bhTHdN7EQIWfcRmTQoAa2cMKXxZSd
	 i+X2iKjm+KOXSQUZONEepsMxwfHn6xJpAVd9nxc80LgMHX3r3GUfkL2vR7sDvvmUIS
	 xHuUxDyAOYsSj8Rf2i5+qEsBf/+Z7w79wzZGPE9DZQNee9lZyk3A1riGVms95OCExN
	 r9AKyHaBctfEulf1Fn4XQnWvZ8qQ7E5n8tHeDSe3BfujNn5Dx+PqQhnhk1haZkEDHd
	 y4mTn+p4ybWqw==
From: Vinod Koul <vkoul@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Yixun Lan <dlan@gentoo.org>, Guodong Xu <guodong@riscstar.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, elder@riscstar.com, 
 Naresh Kamboju <naresh.kamboju@linaro.org>, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com>
References: <20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com>
Subject: Re: [PATCH] dmaengine: mmp_pdma: fix DMA mask handling
Message-Id: <176061935426.510550.684278188506408313.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 18:25:54 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 18 Sep 2025 22:27:27 +0800, Guodong Xu wrote:
> The driver's existing logic for setting the DMA mask for "marvell,pdma-1.0"
> was flawed. It incorrectly relied on pdev->dev->coherent_dma_mask instead
> of declaring the hardware's fixed addressing capability. A cleaner and
> more correct approach is to define the mask directly based on the hardware
> limitations.
> 
> The MMP/PXA PDMA controller is a 32-bit DMA engine. This is supported by
> datasheets and various dtsi files for PXA25x, PXA27x, PXA3xx, and MMP2,
> all of which are 32-bit systems.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: mmp_pdma: fix DMA mask handling
      commit: 88ebb29d3244e515a92c2331434bb73fef7efdc6

Best regards,
-- 
~Vinod



