Return-Path: <dmaengine+bounces-5852-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A5B0F242
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B921C21D24
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF052E6108;
	Wed, 23 Jul 2025 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO2WKAdQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471A2E5B19;
	Wed, 23 Jul 2025 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273777; cv=none; b=dwYhjK7VPb/sbsQLb6jJuoX3avzVyKNfVzgC6vdV12RzAVs270966pDwHc08RMobCgbx/2exLnomcl5owWsQfLSDogFjocbtqPHCu4KPC07lJVnUEjS7BWcCFYIstGhkyhRqx1atgKd+ikmBnaLyaImwG/D3PUbiXEwrG9Xd2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273777; c=relaxed/simple;
	bh=5Cq4SJZryPa8AUw5lgtWZCLX220ScM2NYEXqBoyD0xs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n0wy7Nd+e7A53jNVk1Kz6O+tnKzO1JGL2UIO5CMWKRK0gS1f35NSUyR5xHwa5qMXuragHR3CjwlYPwZlC0BOE6RNEpg9W4/2EX5rMTRKLPBe6e4gtfOxOZPndVGVoa6S7MLtGcvT59vUFOMoxkqL3s3yDH/1CS04aQ4hGzfWuo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO2WKAdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E09C4CEF5;
	Wed, 23 Jul 2025 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753273776;
	bh=5Cq4SJZryPa8AUw5lgtWZCLX220ScM2NYEXqBoyD0xs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uO2WKAdQ2dGB+b09oW4a4WtG69Yv41jQAj3IMQJcWwh9xl8dp1iHMrlYZVaxQJ/B4
	 HZphNBJdvQdBOPFV8ah4Wppprw6JtZUPtFEUysbhwx0TsQiyd3ph3U+ySSYXGK5AVZ
	 24sIKsXBP98gtjxtHVkVeIQ9b/aYIbBlEQRS4M5kWiWftNst6iHRzhGXD1pfu1CSg8
	 87Bk3dIAUdkGn5g9x3OgSKFia/zgZZ7+WVXcERe5Yx4N2mwYeeF2sTAhtbqC3x/nAn
	 lJx3QKkAnQ0+52Xkm/zx1FdDREW0gsdCI6Zv+01jFwakh/cf9cp+uGKpjJvr1MRyVd
	 2sSfiBuHxsb2g==
From: Vinod Koul <vkoul@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Lior Amsalem <alior@marvell.com>, 
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701123753.46935-2-fourier.thomas@gmail.com>
References: <20250701123753.46935-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH] dma: mv_xor: Fix missing check after DMA map and
 missing unmap
Message-Id: <175327377490.189941.16790792675971894041.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 17:59:34 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 01 Jul 2025 14:37:52 +0200, Thomas Fourier wrote:
> The DMA map functions can fail and should be tested for errors.
> 
> In case of error, unmap the already mapped regions.
> 
> 

Applied, thanks!

[1/1] dma: mv_xor: Fix missing check after DMA map and missing unmap
      commit: 60095aca6b471b7b7a79c80b7395f7e4e414b479

Best regards,
-- 
~Vinod



