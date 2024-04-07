Return-Path: <dmaengine+bounces-1775-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D589B311
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A2E283C35
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368D03D0D1;
	Sun,  7 Apr 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF3bIexF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC03D0C2
	for <dmaengine@vger.kernel.org>; Sun,  7 Apr 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507952; cv=none; b=B1WPyL2LhtfDdWkS+S8twARFawRHOH/vy8oDP4Y6o/pkQQI7IPOhMIK9iAzy7xgKVSffTl3Fi6vQ//QL3R9DKCvJ6Yz+UD4DfkZ/EjW/LkWb8U413pqA+R4SH8EX3kRb4ztWcur6MWfeGTxfOCugU0QmGZvX85q5tSfMtwZh5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507952; c=relaxed/simple;
	bh=fk5yUJNrg5rFeaGPe00ldc+7tV95bDp2PAES/8L9XZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VcVfTk7/EsXiJWxcR8CelPOIuXG8haLZRNNwJuI1VVqWzakKpQu3+b0355FGL+NTYew/Ef4lUMRrID/RkJff8PkDp7oniyG1637EgqDyAiycsw7q6AfAj8fPEaueCVaiGzCFkWsvrYg7Ki9Yjk1fE1xj83rwrSEhR9BWs9seCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF3bIexF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AFAC43399;
	Sun,  7 Apr 2024 16:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507951;
	bh=fk5yUJNrg5rFeaGPe00ldc+7tV95bDp2PAES/8L9XZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DF3bIexF+bMqL4gvN/Mc5c58OzZIzvHq58fTGfP/O8Z9lfR2aiwgHRz80O36nXpNc
	 VnAVXZT0+CjgVNuP3hhP9ZnP3hgDSZnrYIglQPM47m40mS74yqEodwYKM/PWe8O7Uh
	 0RHniL5UA8sWyWb8u8gzK4Rs94XSK7YFPt+fFppLyaBiMeW9Wje+w7tPqp+rhtO9Kh
	 yJkcKeqZHnOwa7nak68+sZkaoo3IC1esjWCn4Z7oBSl2dArPKdKnQmNJ2NgQ2RBr9J
	 L6ubRaDP4Uut6EVShTR7evXk1CvfOjO+Z0qo24qEPSFvrdoERVfMOxNIqANBYEmdl2
	 Tvt7an/6gXAYA==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, stable@kernel.org
In-Reply-To: <20240328-axi-dmac-devm-probe-v3-0-523c0176df70@analog.com>
References: <20240328-axi-dmac-devm-probe-v3-0-523c0176df70@analog.com>
Subject: Re: [PATCH RESEND v3 0/2] dmaengine: axi-dmac: move to device
 managed probe
Message-Id: <171250794973.435322.9851608106548699025.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:09:09 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 28 Mar 2024 14:58:49 +0100, Nuno Sa wrote:
> Added a new patch so we can easily backport a possible race in the
> unbind path.
> 
> Vinod, I'm just resending these patches again (as merge window is now
> over. I applied and compiled them on top of the next branch. Tip in:
> 
> 8b7149803af17 ("MAINTAINERS: Drop Gustavo Pimentel as EDMA Reviewer")
> 
> [...]

Applied, thanks!

[1/2] dmaengine: axi-dmac: fix possible race in remove()
      commit: 1bc31444209c8efae98cb78818131950d9a6f4d6
[2/2] dmaengine: axi-dmac: move to device managed probe
      commit: 779a44831a4f64616a2fb18256fc9c299e1c033a

Best regards,
-- 
~Vinod



