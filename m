Return-Path: <dmaengine+bounces-2327-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FC2901704
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 18:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5DBB20F24
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C080247A40;
	Sun,  9 Jun 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXi8GwA5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA1D1EA73;
	Sun,  9 Jun 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717951227; cv=none; b=pFJauVqoWksFw71G3pcnlty3qDAmwpSKpipIEGHCGhOh6/cc7+TSgEOPc7iyX4jPSHhX0IpCKetCR6fD01ZWcjh5mkiIO58jblBEqSpb79xUGsd4efE7J/z5Vl3z7T7wCPue1fDaCT6U1Prt5jGygCtc96NPKigOQAM+THkenss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717951227; c=relaxed/simple;
	bh=GvpgVeH8caYoRfUd4ZWG2IefcCP4XeyACLZHX1/PZ7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OCXCn7u+6EPF8s9rz3k1WyIpFT4WTQoJnS6hUnIMOOJwwEQiN0B/R0QUEp3k0fgR0SOrA5p8sKy2ZWS/FzHM4UmWOouinyxrIarqUcsWcuhEosyuI8NdHw0tumpbfD78KpmvnQK2mlwewhUM7vm91rdY4T4OemzyXnEowaeVgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXi8GwA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 073D0C3277B;
	Sun,  9 Jun 2024 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717951227;
	bh=GvpgVeH8caYoRfUd4ZWG2IefcCP4XeyACLZHX1/PZ7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oXi8GwA5ckE4W47hzv0W37SEfcVCiCBzvuJZaUGn/EN3PIAdR6LtmAENaAGteT0PQ
	 g5BvuR7+1U5RMFWAggXrmDfA3JfpwzUr/YKT5Rulcv0rpdB1qn2D+Dq12TiBCAKMg+
	 FqsDpw9pIg6jpgIBzvGBFqnkcJ/qWME21G5QusJ/Yvz0eJZa9+ewmb9i3jQc2ClcpW
	 4S5d6lxm+d6qeDy8xW0SqUOMUVggsRffHn/CBMW3KNJ2j2oAB9JMuSb6CZAA6lVEEl
	 Ym2n5HM7jZXekhnMb4ZAknLzsVw+7HIzdQOw7BSRLLXvOD6IZHrVW2dpYOhLmyeuRn
	 9zNXFA8/ZD6BQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E89EFCF3BAB;
	Sun,  9 Jun 2024 16:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dmaengine: ti: k3-udma-glue: clean up return in
 k3_udma_glue_rx_get_irq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171795122694.8829.8746227477977795348.git-patchwork-notify@kernel.org>
Date: Sun, 09 Jun 2024 16:40:26 +0000
References: <2f28f769-6929-4fc2-b875-00bf1d8bf3c4@kili.mountain>
In-Reply-To: <2f28f769-6929-4fc2-b875-00bf1d8bf3c4@kili.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
 rogerq@kernel.org, grygorii.strashko@ti.com, jpanis@baylibre.com,
 c-vankar@ti.com, diogo.ivo@siemens.com, horms@kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 6 Jun 2024 17:23:44 +0300 you wrote:
> Currently the k3_udma_glue_rx_get_irq() function returns either negative
> error codes or zero on error.  Generally, in the kernel, zero means
> success so this be confusing and has caused bugs in the past.  Also the
> "tx" version of this function only returns negative error codes.  Let's
> clean this "rx" function so both functions match.
> 
> This patch has no effect on runtime.
> 
> [...]

Here is the summary with links:
  - [net-next] dmaengine: ti: k3-udma-glue: clean up return in k3_udma_glue_rx_get_irq()
    https://git.kernel.org/netdev/net-next/c/28f961f9d5b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



