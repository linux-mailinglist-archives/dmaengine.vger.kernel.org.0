Return-Path: <dmaengine+bounces-1086-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3671A861109
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 13:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67DAD1C21783
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241807BB11;
	Fri, 23 Feb 2024 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W//bwjjj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10637C0A0;
	Fri, 23 Feb 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690105; cv=none; b=Fml9qDZHzUFHSArmDnQh4I58+9a/Y4ii3mkCYyV/Qax1LJ12KY0FitJ/u2LCnWvDpHY4ehWmUmGR2x0FCEEgFGYV4dR8tst/2md4/QJeYQIbrAmJ4QCfHMJNIkZcYSeL45HB/qg+MCIuqiFbdGDQxlv5MvWXwgddAjDliyCraI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690105; c=relaxed/simple;
	bh=U6JgLu1gHhoatRBKMbgHyiudk3w6hVrl6B+NK2QWmrs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BUVFHk/7WD1RQiB7/395jHzNNP/juaPAtujp8FR4p/aVsKimmEoJG6OnVN0lY1kCmk58wdtn+672t8JZchPPjWN9FwsZtf6W5EIcLGlTXSTzB2F6FCQiWLTta75UeMFlVODvpqG0/NvaG3866cjWgssg5JKJKYNIbOBmE7rdjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W//bwjjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C82C433C7;
	Fri, 23 Feb 2024 12:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690104;
	bh=U6JgLu1gHhoatRBKMbgHyiudk3w6hVrl6B+NK2QWmrs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W//bwjjjxygLppEx62N32zSXmCxP/81AgYftGxvfi1vlPu+Hm9w1R9hAIREe1EpC+
	 VoP6y0QMolkJqKklsy/stjFvNdKn4KnnuQhI+j7D4i3noaDlsRbBYH344KE/e1jJrY
	 6+lnpE7JD3EJtl7tMWq1D5bHIo18WlgxxfsOLiCphTqxYxyU3Mfa8kfGecjPoHxdO8
	 3nc1s9u6wvLIvlfYMhiN6EOBKD0BHV7m5AQzwxGCuwHIJSBMJ2uG6PckHFqkSXNhvt
	 dEHkjO71WPtGSNrt9Zin90jYstB+WxVBmKj350oEPigmYzUA8giA5BhBEtiZhlJ2C+
	 8y060dA5LYNVg==
From: Vinod Koul <vkoul@kernel.org>
To: Tadeusz Struk <tstruk@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Sanjay R Mehta <sanju.mehta@amd.com>, Eric Pilmore <epilmore@gigaio.com>, 
 dmaengine@vger.kernel.org, Tadeusz Struk <tstruk@gigaio.com>, 
 stable@vger.kernel.org
In-Reply-To: <20240219201039.40379-1-tstruk@gigaio.com>
References: <6a447bd4-f6f1-fc1f-9a0d-2810357fb1b5@amd.com>
 <20240219201039.40379-1-tstruk@gigaio.com>
Subject: Re: [PATCH] dmaengine: ptdma: use consistent DMA masks
Message-Id: <170869010159.529426.17575318371522129090.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:38:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 19 Feb 2024 21:10:39 +0100, Tadeusz Struk wrote:
> The PTDMA driver sets DMA masks in two different places for the same
> device inconsistently. First call is in pt_pci_probe(), where it uses
> 48bit mask. The second call is in pt_dmaengine_register(), where it
> uses a 64bit mask. Using 64bit dma mask causes IO_PAGE_FAULT errors
> on DMA transfers between main memory and other devices.
> Without the extra call it works fine. Additionally the second call
> doesn't check the return value so it can silently fail.
> Remove the superfluous dma_set_mask() call and only use 48bit mask.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ptdma: use consistent DMA masks
      commit: df2515a17914ecfc2a0594509deaf7fcb8d191ac

Best regards,
-- 
~Vinod



