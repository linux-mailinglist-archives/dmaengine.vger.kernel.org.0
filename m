Return-Path: <dmaengine+bounces-7876-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E2CCD917C
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 806033016EE8
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D3432E737;
	Tue, 23 Dec 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPF9iBUs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23F32BF55;
	Tue, 23 Dec 2025 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489030; cv=none; b=Z5Eef/zD3Is48wm5cT917qqsgT+E9Yk7ptHt0jeU1xWVV3IP6KQIYDQl671abUsCbpu9cha7H19S7uw1Vdu5DGEhiPVrQ/qa0X1316la34LB6kHt7cOl9FAt8iAlvcaf71fDwRUOWxJ61m+9pD4YS77S1k7Lj2fXTBmr93w9fMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489030; c=relaxed/simple;
	bh=qjiXXTtdhA3Ia7ceKURDkyMy4cCCXb54Afeg+N/0e6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IwuAJtrRRNFTew3h9cYpsAD10cwbrcF0tZXz2dLW6n8xZKS9rllxvG9w2VupGvIjAFpJR5ngnNj1iPDARtYUs2Wf4v1MkGHV6OBKgE27/0O0CMyeQaO6UF2v86yWCUMMWxnABBB5CnLusTH9lijDNFqVs6X7NSbANYkbW02boPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPF9iBUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08741C116D0;
	Tue, 23 Dec 2025 11:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489030;
	bh=qjiXXTtdhA3Ia7ceKURDkyMy4cCCXb54Afeg+N/0e6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TPF9iBUs1x6W/kZmzoR3iIK2C1YLMNyArWbTlMauZSGsQoMcVFkJjC701h+eU6dEZ
	 5o+uXCzv2MuMa1Kv7l612UHLCEKpRt+skJDv0TUU3K3vjebYg7PltQlHexSTmDZxMW
	 uBKUMg5DDKRdCRgq9iFeTN0z1OP78a4wBM+z5Pu+tc3RYC93T5lNLfVaIJF0S0ZwwI
	 6H4VFbH+oxIkHBPrzAaO7/yJD7GhbfL5H+2LoQejVa0TsRSxIH/U1Q/f1maZHdPvFX
	 fbL+zWnh4YSLxhbrFcp0lDo5n8TUO/OXOgZSGxOjJnMzcwjFO+IUKIhSX3KUp33dcz
	 hGGFCBhNwzhQQ==
From: Vinod Koul <vkoul@kernel.org>
To: peter.ujfalusi@gmail.com, Haotian Zhang <vulab@iscas.ac.cn>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251103073018.643-1-vulab@iscas.ac.cn>
References: <20251103073018.643-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] omap-dma: fix dma_pool resource leak in error paths
Message-Id: <176648902866.689692.8514963839721463874.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:53:48 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 03 Nov 2025 15:30:18 +0800, Haotian Zhang wrote:
> The dma_pool created by dma_pool_create() is not destroyed when
> dma_async_device_register() or of_dma_controller_register() fails,
> causing a resource leak in the probe error paths.
> 
> Add dma_pool_destroy() in both error paths to properly release the
> allocated dma_pool resource.
> 
> [...]

Applied, thanks!

[1/1] omap-dma: fix dma_pool resource leak in error paths
      commit: 7b28c670df4508a7cb1ee31cb159b4366fcc6d4b

Best regards,
-- 
~Vinod



