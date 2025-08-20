Return-Path: <dmaengine+bounces-6085-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07950B2E448
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 19:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87047720C64
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D452522B4;
	Wed, 20 Aug 2025 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZShsMle"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7725DD1E;
	Wed, 20 Aug 2025 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711746; cv=none; b=PuE1+kbI0TNCclYLfNkVz0su01vWOf1RiakuskTXulQoLNFn/vJyD/olGwGj0AQTpwUxrIx5zN9KGPLj4faPz2mqlIy+sSzqhkg4gTdj2x5N1wbaL+Ph0QIpIqtEfED8J5PY1/k8v3Z9wNZbhk2hhydhBKr8/7pke3b+mDvIVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711746; c=relaxed/simple;
	bh=taFllpfPeK/OWKFrcmr/fx+iqbU6n6aNamWk8kSs85c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=urpZv+MzBVZScy6VjNGPyMdSbRrxVLfacQqcxtpsvKCJHnOawPTF8+656bSesmprbJHxNmr1X+vD34hT5nWPG/jn/HDvY0IFvRa8uf5+vw8+YTKw3GsOka006TCQjxZ6feNu6mMAeXUJ2use5aNiVkp5e27+8CtN0tKUiZRdHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZShsMle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C180C4CEE7;
	Wed, 20 Aug 2025 17:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755711745;
	bh=taFllpfPeK/OWKFrcmr/fx+iqbU6n6aNamWk8kSs85c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JZShsMle4YSqU5Cg5hrdNlXcr7QOuELENAwgYGh7PvYEF0Pfnn3bFkIdJvHeR8yYY
	 zWxxVpbzARHC9IDfAFtF+R59D5CPixT+D8AlnchCwqiqav6Wtly8wxmGbUYzsHs1va
	 kEFpG1iivL5WxhlC1T3WyFPOC+dlkXJgfILLuEx37kvwibrLEHBSqsM2De5ieZ/DO7
	 p6B4Y30M1Zp7LpWnNP4lj9a4sw5vp1oUOXbEBY0NpmWmaJDELVg5KV82Ck1d5HMkl2
	 EhuFtJr6jxyrPNk6nCyCwmLCVPxC6tVSEa8LxMpMHgYoOHrNAN9Nb7w/4Uq+V0v7rB
	 7rIkSjg00NMZw==
From: Vinod Koul <vkoul@kernel.org>
To: michal.simek@amd.com, yanzhen@vivo.com, radhey.shyam.pandey@amd.com, 
 palmer@rivosinc.com, u.kleine-koenig@baylibre.com, 
 Abin Joseph <abin.joseph@amd.com>
Cc: git@amd.com, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250722070255.28944-1-abin.joseph@amd.com>
References: <20250722070255.28944-1-abin.joseph@amd.com>
Subject: Re: [PATCH v3] dmaengine: zynqmp_dma: Add shutdown operation
 support
Message-Id: <175571174185.87738.5416812365218476037.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 23:12:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 22 Jul 2025 12:32:55 +0530, Abin Joseph wrote:
> Add shutdown callback to ensure that DMA operations are properly stopped
> and resources are released during system shutdown or kexec operations.
> Fix incorrect PM state handling in the remove function that was causing
> clock disable warnings during the shutdown operations, which was not
> implemented earlier. The original logic used pm_runtime_enabled() check
> after calling the pm_runtime_disable(), would always evaluate to true
> after the disable call, which leads to unconditionally calling the
> runtime_suspend regardless of the device's actual power state.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: zynqmp_dma: Add shutdown operation support
      commit: 72dd8b2914b5db1dccf902971c2ea6b541711b28

Best regards,
-- 
~Vinod



