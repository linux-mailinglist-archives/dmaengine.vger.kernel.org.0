Return-Path: <dmaengine+bounces-450-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4880CF03
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 16:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C081A281D35
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A004A99C;
	Mon, 11 Dec 2023 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F22xU4oE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F634A986;
	Mon, 11 Dec 2023 15:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C608DC433C9;
	Mon, 11 Dec 2023 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702307073;
	bh=e6CXrMobZvPrjdB6OvAR3xnF7KHYIQZ/dEC/uDNZ1bM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F22xU4oEYxG9GvfWb/KYdQEu9zL+aWcYtzSFP6Xv4l0GCVu0RApN2VSCYZwMF/mgX
	 CrnZPkFZgZtjdLiZc3jhvUffq03e282SGutNa8ipxbY64rmhpvT7ZYlnUvNULZWQXU
	 FadEwMg4CiKr7Ksy7EtaEnLdSJWgQf5aWgVhJqfQKaZjPEPaM9BrjdWTr7R+mWPIwB
	 hCWQLDFrr02bwgHD3xGzPDX+49UGrBsjAr1Ok+jAr4bp11b0YqLxlJnPqSMndF7LbR
	 OERgEgGwPrfUX4+bgtOl+V7U2ZY0m/lExGe9lfKMLe0ar+Fs+oduOoWPtYU+JcLKUD
	 Z5qQ1iyJz6gNw==
From: Vinod Koul <vkoul@kernel.org>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, Mohan Kumar <mkumard@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231128071615.31447-1-mkumard@nvidia.com>
References: <20231128071615.31447-1-mkumard@nvidia.com>
Subject: Re: [RESEND PATCH V2 0/2] Support dma channel mask
Message-Id: <170230707042.319997.2049992718193941560.b4-ty@kernel.org>
Date: Mon, 11 Dec 2023 20:34:30 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 28 Nov 2023 12:46:13 +0530, Mohan Kumar wrote:
> To reserve the dma channel using dma-channel-mask property for Tegra
> platforms.
> 
> Mohan Kumar (2):
>   dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
>   dmaengine: tegra210-adma: Support dma-channel-mask property
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
      commit: d95fcb78e7f263f909ce492c3882a704067dc534
[2/2] dmaengine: tegra210-adma: Support dma-channel-mask property
      commit: 25b636225a0816eac20b02fcb37daf6c722d0bed

Best regards,
-- 
~Vinod



