Return-Path: <dmaengine+bounces-3862-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F8D9E09FC
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 18:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E838282B9F
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5F61DE3B3;
	Mon,  2 Dec 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZEEAJHH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC99D1DE3B1
	for <dmaengine@vger.kernel.org>; Mon,  2 Dec 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160681; cv=none; b=VaUKWL9505Tdtj2NyA8OHGJyy+k3slIaDEKO/tXKt1ibde37PWgYnt9DUII3kmMFKikeD7aXfBXmwzBTATZ0siba+sI+y2lpmubP3Z3gjeaHZUilyz3wA4ARzOCAUic2e18VKnTb4l/6KShXb3qGQ4DqB9Q/sSqgODC4Hql6rUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160681; c=relaxed/simple;
	bh=WMt7Cfzx5clJe+hR86E0PnFc9JGU/GXcD2Ch07F0c50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ERyokFS9pTR2OjuG83HfDEgGuvkHLWRERgU6WH+mANC0hMNDkzWjR6fDVqj7bBNGeDQOulTFvtw4Ivc8NdzmTEqoiFIcipy3G2voSSE/S01ZDzyJsFTpwuRQ+hVlaT9vLlauXouh0I5+sPNVZrwElwOO3NSDFVKsX0uydeWQLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZEEAJHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E972C4CED9;
	Mon,  2 Dec 2024 17:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160681;
	bh=WMt7Cfzx5clJe+hR86E0PnFc9JGU/GXcD2Ch07F0c50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jZEEAJHHTV85F8upg5TJ2HjEOIJGfjThYSmzx1Fbq45FDLkFpuHylKQupbavUjwzp
	 5iPgKlMEQHPfi8g0tip4477HiAYnli/foCPAs6vl0/1U1XW78Twi763P9Y1/oW7Zfd
	 QqMONgmLT0Nl1/OLMei9IAzK8egHS0dHbV/CHEYV3EkyjEIYKty/VzQN6hkZ2yZSAT
	 UrVhG+NNiVy4nkp0RV8yMVkMo/pBhCsr8sSgJfSZS/VNvI4T1b4uEjCeAo6xypzRD6
	 sWBoSOB9Dd3K/C8/Ih8GE23oS0Xh47EbwlhuYRlJv/GrqUAJMurebXc3NepVeD+Y3y
	 rO+ljxGMFOB4Q==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Marek Vasut <marex@denx.de>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Peter Korsgaard <peter@korsgaard.com>, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20241031171132.56861-1-marex@denx.de>
References: <20241031171132.56861-1-marex@denx.de>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Configure parking registers
 only if parking enabled
Message-Id: <173316067900.538095.9728729453604607068.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 23:01:19 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 31 Oct 2024 18:11:04 +0100, Marek Vasut wrote:
> The VDMA can work in two modes, parking or circular. Do not program the
> parking mode registers in case circular mode is used, it is useless.
> 
> 

Applied, thanks!

[1/1] dmaengine: xilinx_dma: Configure parking registers only if parking enabled
      commit: 8a20040f9de3a4ea90ab900cdd7745d57bc2da82

Best regards,
-- 
~Vinod



