Return-Path: <dmaengine+bounces-3948-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2779EDA03
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2024 23:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AAA188269A
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2024 22:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2582203D7F;
	Wed, 11 Dec 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5CBumuG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882920102A;
	Wed, 11 Dec 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956361; cv=none; b=FcDIdI8UxNtUns9I+6nSLrrkJF6mPdfnv0t71VgwMb/ZXtPWOi1fkfFdvA8Ul3xPA8dvhL+k6qGz/qDyTnbNwPFFxC5pO7b79slnAqPI6RmtIJ6jwJxHiTRN7aFFkuA64SY4tQ9i5M6iY2HxtIvgZcudmYuxupS3xIjre9q2svY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956361; c=relaxed/simple;
	bh=il/LP0fiktwHyC77+kl7PbXayxiUWzB2aK3hHeyKOp0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fhJ835NdZxhfDv0RCF7BUxkcBc3FNRQVXOf9jD0HyjAMZ4Ek2xNH72OvxI0ma+HKyz+edShy5Qz6s3ZNQdXauN70D3Y8vzbNtPAlUsKEOtiq7CxvLLDqOHGsAl7xGeX0ZSkc/XzK+ZPqm01WaQNq8oySLvbR5h4Uh5bGiERMjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5CBumuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BF5C4CED2;
	Wed, 11 Dec 2024 22:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956361;
	bh=il/LP0fiktwHyC77+kl7PbXayxiUWzB2aK3hHeyKOp0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y5CBumuGwdaTIUle2/mYmKPRDobxNEAa6rBA9JYi6bEbIedw9zcOvMM5DJA5ZB/mM
	 eBJPdavTIV5zeA0YCCQINKu9mGMdUWA0ufAK3v1xo3N8M1wPmqXw3uu8Ui8gCIzOR4
	 T7Q/G21LeE2qTojctC1ulmTVtfyUzQCyEBcjTzR0TykkdXTYP/rxRQkttrsLqn7Fmw
	 5S8OI7FlbZSdax0So7Bpu+k/453ZrHLon6OIs5btOoqZ8uzprsc9uF1Ug431XOrRt1
	 tWauQ4VvZ8v7rE1lmeXPQmFo11ZCU4/ohbbs+x9p3z5lkALa65fkEbJOCLs129/ijO
	 QHq4KQSfWq8ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEA9380A965;
	Wed, 11 Dec 2024 22:32:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] dma: fix typo in the comment
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395637749.1729195.15051372994717315610.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:57 +0000
References: <20240918034114.860132-1-yanzhen@vivo.com>
In-Reply-To: <20240918034114.860132-1-yanzhen@vivo.com>
To: Yan Zhen <yanzhen@vivo.com>
Cc: linux-riscv@lists.infradead.org, vkoul@kernel.org,
 paul.walmsley@sifive.com, samuel.holland@sifive.com, michal.simek@amd.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Vinod Koul <vkoul@kernel.org>:

On Wed, 18 Sep 2024 11:41:14 +0800 you wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
> 
> Replace 'enngine' with 'engine' in the comment &
> replace 'trascatioin' with 'transaction' in the comment &
> replace 'descripter' with 'descriptor' in the comment &
> replace 'descritpor' with 'descriptor' in the comment &
> replace 'rgisters' with 'registers' in the comment.
> 
> [...]

Here is the summary with links:
  - [v1] dma: fix typo in the comment
    https://git.kernel.org/riscv/c/39d283d14692

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



