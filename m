Return-Path: <dmaengine+bounces-7693-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEF1CC484A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE8C3059589
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB5221FB8;
	Tue, 16 Dec 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7Ky9UFY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1AA14B08A;
	Tue, 16 Dec 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904186; cv=none; b=tx6W/2JRtBvQLxNXS+kU7xfd+TFCrTXKlxn11o0UuRGD7hX0LpFi6vZ9BWBlOk9+6/xxYG+fXAhgR8eKFrE4zUpb+w7sZVUwGMtSAUZKlY4m3W0+uwtToeUyHvHRnIUJRKoDupqi+EXDFz5aP+D0EMmt2LoquwEIy3PlVL4fxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904186; c=relaxed/simple;
	bh=cNKpevnXsX9XUwqoMEgdxh29HOpfZ/BhQ6L8gahlKIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B6Ow3zE4SiX+sSQLzSDzGOyi6sTBX/yAxq8qY/+rwp2wC70OJW2zI0873izGeF3gJw8wOmHnr1iMnHWZy5vkzBSCTSHO3suEEh90lqgOzbW0GtUTUWR2MIRDfLBUFi8hD+VREobILs3BowlqUy1f3B/w+VQ4YKBEb2aK10D3QH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7Ky9UFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05012C19422;
	Tue, 16 Dec 2025 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904185;
	bh=cNKpevnXsX9XUwqoMEgdxh29HOpfZ/BhQ6L8gahlKIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E7Ky9UFYTW+yabm3WfxuMFV/Q6arAWY/+OL+Yluax/1geJILcoXogcw8NspzCyiue
	 p0QWmyzWMQwPb+QUaTP9OkJ6buwprWsclo96DgEH+/yFdPMdpVnH2gBtw3vGKHADXO
	 OhWd74qZOdEiII+p4Bf7gFoHXgKiIydfm2fX1lqXVFUIodPHgrSHkFbCJucVvfmrHt
	 1FHiMNgJu1K5M0srCz7tBjVIfbxPFC+bWLUvqDJfR9GLXPJiwvjQfpovO2G21v6EWe
	 vyY04O6S9e5fmrOnv8BymVbZpD8jYLZUnG9sEaKSf4Je/KxNeqftpCMICeSVIaGjMZ
	 2XQja81TLLnJQ==
From: Vinod Koul <vkoul@kernel.org>
To: "Sheetal ." <sheetal@nvidia.com>
Cc: ldewangan@nvidia.com, jonathanh@nvidia.com, thierry.reding@gmail.com, 
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251110142445.3842036-1-sheetal@nvidia.com>
References: <20251110142445.3842036-1-sheetal@nvidia.com>
Subject: Re: [PATCH] dmaengine: tegra-adma: Fix use-after-free
Message-Id: <176590418364.422798.14000642771067955308.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:26:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 10 Nov 2025 19:54:45 +0530, Sheetal . wrote:
> A use-after-free bug exists in the Tegra ADMA driver when audio streams
> are terminated, particularly during XRUN conditions. The issue occurs
> when the DMA buffer is freed by tegra_adma_terminate_all() before the
> vchan completion tasklet finishes accessing it.
> 
> The race condition follows this sequence:
> 
> [...]

Applied, thanks!

[1/1] dmaengine: tegra-adma: Fix use-after-free
      commit: 2efd07a7c36949e6fa36a69183df24d368bf9e96

Best regards,
-- 
~Vinod



