Return-Path: <dmaengine+bounces-7882-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA20CD91D6
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 12:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 006973074D1D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 11:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D0B32ED4A;
	Tue, 23 Dec 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH5oTrTB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB8331A68;
	Tue, 23 Dec 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489309; cv=none; b=lgKAk69Osa6vy7L6v6h6WzJiW5jLIl06f5ufH3vFOJABTDnn6BlVyY3TJW1ol4VwmB60/0pQyTEnlrNYJrtXOazDgZWyBmcEi9OOUk2TpEI0DBORfgrMfMF0LVl8wX91zmzKkEm2utTb2y6Y6FL5embyrVbuM7xl+PsLQQGIv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489309; c=relaxed/simple;
	bh=KCJf4ICKUg4d+4CCrW1uq1qUVJx+y45H9G4fHNmF96Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JXYTeI9Xl98V7yk44DBMwd7jGfj5mC96tp7F3iEu1EFefiendcakr7DBFULuAHfIjZ1Spc/Rk4A6dl+SRzNeZcyZIFQnGipxR3aYnqUAKdQfcg1CKYw+9Cl5jjex6jlHyrY2jtl6cTWthYt19wwBRTcpNzjSbM1hN2ferBFlGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH5oTrTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E5BC116C6;
	Tue, 23 Dec 2025 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766489308;
	bh=KCJf4ICKUg4d+4CCrW1uq1qUVJx+y45H9G4fHNmF96Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sH5oTrTB5k619Stb59NdBv4Swig7HXVjHNn9QI5WMWz/Trcq2M9GbuTaoVu6skcf4
	 reZe+wV2HXuxEUMT9Sj9aWXelCHJ4SF+7Xh0yIh69XV3I9OreJh8JLXjrHfFlU6A3S
	 2aKjO7ow6tJykFtKOumFrhc4smLI5c3mWlvmPW4dgp6q9Mci+PTgErMLDQCpnknXL0
	 CRVISSBsGI+TYdhgMgVl+vufkZDWJglyG2TUS5k5RkjK/Fsd97NKx6wdA3yKldThGF
	 JerthVbXS+1eibIZPxcCK7/zjt57amdmlTz5aVGlT8DBW9B4ZuEdleQo25PTKfgDAI
	 qnbPQpsfa0YCQ==
From: Vinod Koul <vkoul@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
In-Reply-To: <20251217-mdma_warnings_fix-v2-1-340200e0bb55@foss.st.com>
References: <20251217-mdma_warnings_fix-v2-1-340200e0bb55@foss.st.com>
Subject: Re: [PATCH v2] dmaengine: stm32-mdma: initialize m2m_hw_period and
 ccr to fix warnings
Message-Id: <176648930565.697163.2533356435881488772.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 16:58:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Wed, 17 Dec 2025 09:15:03 +0100, Amelie Delaunay wrote:
> m2m_hw_period is initialized only when chan_config->m2m_hw is true. This
> triggers a warning:
> ‘m2m_hw_period’ may be used uninitialized [-Wmaybe-uninitialized]
> Although m2m_hw_period is only used when chan_config->m2m_hw is true and
> ignored otherwise, initialize it unconditionally to 0.
> 
> ccr is initialized by stm32_mdma_set_xfer_param() when the sg list is not
> empty. This triggers a warning:
> ‘ccr’ may be used uninitialized [-Wmaybe-uninitialized]
> Indeed, it could be used uninitialized if the sg list is empty. Initialize
> it to 0.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: stm32-mdma: initialize m2m_hw_period and ccr to fix warnings
      commit: aaf3bc0265744adbc2d364964ef409cf118d193d

Best regards,
-- 
~Vinod



