Return-Path: <dmaengine+bounces-7702-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF799CC4835
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCDED3027A31
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E953246F1;
	Tue, 16 Dec 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SawhsF5Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40E315D2E;
	Tue, 16 Dec 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904378; cv=none; b=qZoM9yKYkvcUDAtkgUX0/a3UFJgwL7RwQ5+igazFfsb4uSNMqlQFZBUkaHKFUpzTmME1mDmDGKeFb3vk8YmDKSwU9+1ISMZsORWUU9f4rShZEo5nd/zp2hgr15VYz8KGzkVs1FPn276s04CYcm3KxAACie9pDd/8z5/6NxO2eFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904378; c=relaxed/simple;
	bh=gd+LVa87L/5nacGvsTeXMVlyPGvTYEgI4GD5mnHFym4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UP3qQsgHNLogPvW1ZBsLsoLtP8CG94qjbFczNQ8VzCcY1d99XTfcat9Jy/SvVGrcVhmRjF3QZGyyzkaqJq5R7iSQab4WCSSHupAh9jGRksMnjty9kMbJFThNUMUKqRM0f5s5Y5Pzg/+YNSecsS7LdRUCldLpj2cZZzcGjohoV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SawhsF5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271B2C113D0;
	Tue, 16 Dec 2025 16:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904378;
	bh=gd+LVa87L/5nacGvsTeXMVlyPGvTYEgI4GD5mnHFym4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SawhsF5Z8Opq5ci/eYR4Rhimoaj2sOV6bMBRWp2yZc1kDiZ9XZ6x2Dg55b5hHWmKp
	 J8aRJW9t1r7z9v5KmsFRmWeK9ptRwCY/QWR3TmJUxP9QWBnUJMyLa/16b4uiEj6Kkv
	 TWir+yna+KjIfypWOZZ3N+3v1qZHYz9oEX8ZtZjMCqjdUu6mO+zRjWUhckx7zE5bqx
	 gzRH2HXt/coLotsD6wCyqX7Dupzu7CNSgPccI6PW2Rtm8/7kNekoXxlr2wEq+DGrDz
	 YEwCFlgINAufvzeFR23L4DrHp9v4/i89z/MfhXx/L9AQEU4fn5KHXkgSdWL8/Kp0uC
	 /JMnV472mBsEQ==
From: Vinod Koul <vkoul@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251121-dma3_improv-v2-0-76a207b13ea6@foss.st.com>
References: <20251121-dma3_improv-v2-0-76a207b13ea6@foss.st.com>
Subject: Re: [PATCH v2 0/4] dmaengine: stm32-dma3: improvements and helper
 functions
Message-Id: <176590437579.430148.12860558109000484739.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:29:35 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 21 Nov 2025 14:36:55 +0100, Amelie Delaunay wrote:
> This series introduces improvements and helper functions for channel
> and driver management.
> 
> It enables proper unloading of the stm32_dma3 module, replacing the
> previous subsys_initcall() mechanism with module_plaform_driver().
> 
> It introduces helper functions to take and release the channel semaphore,
> and restores the semaphore state on resume, considering the possible
> reset of CxSEMCR register during suspend.
> 
> [...]

Applied, thanks!

[1/4] dmaengine: stm32-dma3: use module_platform_driver
      commit: 0d41ed4ea496fabbb4dc21171e32d9a924c2a661
[2/4] dmaengine: stm32-dma3: introduce channel semaphore helpers
      commit: d26eb4a75a4a2bbf27305e62ad82cedf5f8c577c
[3/4] dmaengine: stm32-dma3: restore channel semaphore status after suspend
      commit: dea737e31c2c62df5a45871bfb4ceb90a112dbd8
[4/4] dmaengine: stm32-dma3: introduce ddata2dev helper
      commit: 8be4f3cbe263d22053d7afea4efee2e7178eee21

Best regards,
-- 
~Vinod



