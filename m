Return-Path: <dmaengine+bounces-4589-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBD3A47CF2
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 13:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA3A16F54B
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 12:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D875622E3F4;
	Thu, 27 Feb 2025 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgJmAANJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460122E3EC
	for <dmaengine@vger.kernel.org>; Thu, 27 Feb 2025 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658080; cv=none; b=dwRSiPKsRMGMYHxRcQ5w2LuK+EbTQ+lZ81+Hc8pptozxoBHZCGs/YNs/LPzW2AttXX6AF2LHg+gM5C3w0x3kLEybO8/PsP2yCWTYBSNcTqluicJ5jS0kTzeTbjwyHnT0RNcC4giIBo1lJ3prV9LoA7h3SNiDPfiO0MYbaYFeqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658080; c=relaxed/simple;
	bh=ME/jFBB/8LAlnipMqfXDhYq3yllHUs3jw+ftJDiUXPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bIftONlc3+M/dFn/47sKDs45S3/NExvYCEzs/p4LqnfwggK5PNKk3CHr1wIs115GBDeI13fI8kDYq4UlwQ2gxetF2zyKbcVnxsW4kOsu0Z1cmtgbbpIzTtngmc5drQAgfsXV6a5VMz6Y1/lEWtvnOU2Jv7pGkaaPdJ7Htxip+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgJmAANJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB90C4CEE5;
	Thu, 27 Feb 2025 12:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658080;
	bh=ME/jFBB/8LAlnipMqfXDhYq3yllHUs3jw+ftJDiUXPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MgJmAANJa63nT4JPr6QeRtdr5TyxDyYclFJ9fiUy4OTHpRQ8oJEbJbTVWk1GPU2bY
	 gGJ79fOBrhDNEzBVCxlFvdFqyGCjrvGYjdmrbG5z2CcCMUryz46BM+qKj0zmnkHejP
	 NeDgH+fNQaxwaWFYSqY3h4CUR0Yg0bOX6ujqVmXsxyL43oRaVaZRuq/USty4KDv6EB
	 mFJQ5vUyCkQ3fm2wptEeAiB1SN1SxD0djCc8nJPg+qx+eQcppjadjncB/ZMYZHowZT
	 1aoDoMY/uBJGrQNHu0vbsa//ZonsHRfxZqTjjHFLByy2yHPXdDBydhRzfb03WNGEJN
	 sXrYROekYL6Bw==
From: Vinod Koul <vkoul@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>, 
 "Ivan T . Ivanov" <iivanov@suse.de>, linux-arm-kernel@lists.infradead.org, 
 bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20250222095028.48818-1-wahrenst@gmx.net>
References: <20250222095028.48818-1-wahrenst@gmx.net>
Subject: Re: [PATCH RESEND] dmaengine: bcm2835-dma: fix warning when
 CONFIG_PM=n
Message-Id: <174065807656.367410.3130811879285785040.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 17:37:56 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 22 Feb 2025 10:50:28 +0100, Stefan Wahren wrote:
> The old SET_LATE_SYSTEM_SLEEP_PM_OPS macro cause a build warning
> when CONFIG_PM is disabled:
> 
> warning: 'bcm2835_dma_suspend_late' defined but not used [-Wunused-function]
> 
> Change this to the modern replacement.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: bcm2835-dma: fix warning when CONFIG_PM=n
      commit: 95032938c7c9b2e5ebb69f0ee10ebe340fa3af53

Best regards,
-- 
~Vinod



