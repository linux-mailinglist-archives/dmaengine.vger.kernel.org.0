Return-Path: <dmaengine+bounces-969-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C2884C69B
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 09:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027121C21CBB
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F388320B0C;
	Wed,  7 Feb 2024 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5oQ77FK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51C220B00;
	Wed,  7 Feb 2024 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295759; cv=none; b=Vys8ereyyjjWPMdS0IcFG2wYSF5CYcVy2th+6oKivENdq1b2YzCTVkfdykn9/nOooQElxNVrpDIS8n71yp3nTRLSCVThhk2WFbfKlDMiItxpuA54daMlPxTn0fy2LEOPqCOJ8V/aF+qohXIj7tJ9Otk4y3Yo1sntuqygiP0wO6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295759; c=relaxed/simple;
	bh=rJCacFpE6fWbHdD+fJin1OdZD+PIrljzRtYE71Eon4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BGJkTspFt+g0FPSW6jFopyAlUJLvMjEOgfA3TsF8uPf0Hg/zAr13vOkf3bDom5+u4XO9POcK9WFNX1Q0xgJm8m12JLD0MoKz9Z1irH87OrLfxZov/ticZdst7fLuo4fbSFbV6D7dD6s7E0DNwWEH/C8clg6CFOOlNHQyLSROPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5oQ77FK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B33C43390;
	Wed,  7 Feb 2024 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707295759;
	bh=rJCacFpE6fWbHdD+fJin1OdZD+PIrljzRtYE71Eon4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N5oQ77FKSk17Qei/JNuTCJmwBi6gROvYIIp7/2b6LLXR+ajZecqfxdqWy1lm0miTS
	 8Xpni2fa6F/z8k8QUlDhQ3bMUGkH6+tIEM6GNip6kej1ONdMV8ZxkPoEm405J79yMz
	 B4KsYuJVj5Q4eecCez6hXyEeNrw/7wVIfJuaZe52LYBDn7yeixAAteksIbfA+wo2hj
	 tmueJvg+v4IL+rTe3tKbou0VERUj+YQAdSid8fu8XsV2AE4ssZhyakL5+Vhmn1+FeT
	 H2U/57Qi5KlG/pXMYJ40b9hF2Wza+hiZ9ziicxOyyLZVzjxOgqexXKy7EyKElOJEyt
	 4prG8+esx+6rQ==
From: Vinod Koul <vkoul@kernel.org>
To: Wen He <wen.he_1@nxp.com>, Peng Ma <peng.ma@nxp.com>, 
 Jiaheng Fan <jiaheng.fan@nxp.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240201215007.439503-1-Frank.Li@nxp.com>
References: <20240201215007.439503-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: fsl-qdma: fix SoC may hang on 16 byte
 unaligned read
Message-Id: <170729575753.88665.8686858564580619272.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 09:49:17 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 01 Feb 2024 16:50:07 -0500, Frank Li wrote:
> There is chip (ls1028a) errata:
> 
> The SoC may hang on 16 byte unaligned read transactions by QDMA.
> 
> Unaligned read transactions initiated by QDMA may stall in the NOC
> (Network On-Chip), causing a deadlock condition. Stalled transactions will
> trigger completion timeouts in PCIe controller.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read
      commit: 9d739bccf261dd93ec1babf82f5c5d71dd4caa3e

Best regards,
-- 
~Vinod



