Return-Path: <dmaengine+bounces-4395-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD612A2EFE1
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC26C1888FA1
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706E237188;
	Mon, 10 Feb 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2ByZBVI"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC680221DBF;
	Mon, 10 Feb 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198107; cv=none; b=c+vzUj70rOSHajtTtto+RxTFL/8+mZG6mEI8MCi8ZFn6fni2hJmg5dLmj1YxmlykiuplUdcDy0nB3o56UI3uG3dD9bZTKzZjhx1cDeYN/r07Z81JAOV9S7aD7vJRcz8jI+3DmB9jkqRlGcgTk4qiYEHhTy5aYGwQgy/MgOCi4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198107; c=relaxed/simple;
	bh=Co8afiWugpJkabF78b8GJNpLEF4rbBHfjLyesRenPLw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b10+NdwgEFtHSxVs2NWylpxwww2serLX8k/dKE+FgSm//c2kO1LV7Rofjd5TxBvGnoVzkyr8xx8jEmYDU/Dx+atFY36D5QqxJyHs6WwxRCPClnNI1oINAOX6dsM1RZQA+T7UvziKwiayE3BDc+lDai5Fzl09lYzuI3cr1l1EW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2ByZBVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BA3C4CED1;
	Mon, 10 Feb 2025 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739198107;
	bh=Co8afiWugpJkabF78b8GJNpLEF4rbBHfjLyesRenPLw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Q2ByZBVI5UElkc96ZQaupz7Ackk97ET2SNOfhgtjjW7KILMyaMP/shtmN7600tLKA
	 mXYiC5YTOStx0adGhRsqeHVouxAql6NZJwLkx+jF03TcQNHiFRIqOgsuAzTxMRXSDy
	 vyaRQ4CzQUoAgQgbJvsWbS+Gq9/UbrtOJHq3tuht3e/pq+H538VDlqFqIleLA/2LqV
	 VklIpdIYYZDV+ETmBOcL7qo5hgYl8y1S0MA0WcoD5q6Ze1SUXw51iaqLe48IerwxV+
	 FjGakSc3xITmst8XsUV6aMp+mfY3FgNzHYmuRG4b19TcPN1TIx0el022T399usnuAO
	 ScNx3ym0OXt7A==
From: Vinod Koul <vkoul@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20241008173351.2246796-1-andriy.shevchenko@linux.intel.com>
References: <20241008173351.2246796-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/4] dmaengine: dma_request_chan*() amendments
Message-Id: <173919810428.71959.10040102676409346998.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 20:05:04 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 08 Oct 2024 20:27:43 +0300, Andy Shevchenko wrote:
> Reduce the scope of the use of some rarely used DMA request channel APIs
> in order to make the step of their removal or making static in the
> future. No functional changes intended.
> 
> In v2:
> - updated the commit messages (Frank)
> 
> [...]

Applied, thanks!

[1/4] dmaengine: Replace dma_request_slave_channel() by dma_request_chan()
      commit: 31d43141d13aa63587f140884b1f667800ce4e1d
[2/4] dmaengine: Use dma_request_channel() instead of __dma_request_channel()
      commit: 1c83d3dfa0905590408595560629627cba4f9261
[3/4] dmaengine: Add a comment on why it's okay when kasprintf() fails
      commit: 1722fb4a1307748f983c1345c4c24178d8e0be47
[4/4] dmaengine: Unify checks in dma_request_chan()
      commit: 91d8560c15918c7d44e4f665fac829ba8057a2f3

Best regards,
-- 
~Vinod



