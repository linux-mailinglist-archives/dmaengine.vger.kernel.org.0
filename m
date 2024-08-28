Return-Path: <dmaengine+bounces-2988-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EEB962F5C
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 20:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86654B22886
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 18:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844BE1AAE24;
	Wed, 28 Aug 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF37y7K1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB581AAE1F;
	Wed, 28 Aug 2024 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868522; cv=none; b=Ly1+j+p9ogPFXke6TXthZXUmCIOdhczgzfdSRWtYuptTKb0HJp48ahJoJEjFu2ISqW3v/pkM5dTCr4hhBQv+ElA4sL3oQWZ7FVdCbcTxLuPRwrw+U8XijIk/6CtObaiU++d/NADP/q8/odrXYuQNn7HnOc9xiITMNHa5HX8U4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868522; c=relaxed/simple;
	bh=lfo7GYbwsNRF/MECpvVIQqdekF5OgBCjIKu+++o37eE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gBoEhAhInREqsydBIt6hszLxFqFiqqBP40JGut3PWxEUEY2c3k31SS16fsh7vrN6L/+tR4H3VWUba63ne+lHCXqY3rrP1qibAbIbY+IBJaijpb/bnqfF3uG35xeyY/8u0kAp+NnMRHdmZmCzFaktmv/xNGfbggZmD7y5gEHcag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF37y7K1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5F9C4CEC1;
	Wed, 28 Aug 2024 18:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724868521;
	bh=lfo7GYbwsNRF/MECpvVIQqdekF5OgBCjIKu+++o37eE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SF37y7K1p4C5ezTk/emUYCI2QliF60yqJV1XU2xnFykSvBoXv3i3fiENmM5qTwTH8
	 Q/k0WdDJki4R3O9VYlAMu4Ybf/Ba5cEHKCIJhmyDd4136Ltkpq7Kz3OZ0nfN683q7C
	 S5hNMq/mHZJIh+SuKpWBC6nrckLgLNxxpg/nRdU2ACmZv3HfHRtQGmLhuTEaDUHlhy
	 lmrkhuBwMjcgYOWS8o6XEzD0K0mjaptYgMOj3V7U0p/94CVvVMkc+k+FTEfi4tkm8F
	 s2DU/PaabNRiz2fJShMsBzlOBEniH7tF5d4XWsiaYbXb67w6nFZQ278AJG+yWAt5Dv
	 wR7c9NM+iTcKw==
From: Vinod Koul <vkoul@kernel.org>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, 
 quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com, 
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
 Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1724674261-3144-1-git-send-email-quic_msarkar@quicinc.com>
References: <1724674261-3144-1-git-send-email-quic_msarkar@quicinc.com>
Subject: Re: [PATCH v4 0/2] Fix unmasking interrupt bit and remove
 watermark interrupt enablement
Message-Id: <172486851833.309756.677991791964410222.b4-ty@kernel.org>
Date: Wed, 28 Aug 2024 23:38:38 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 26 Aug 2024 17:40:59 +0530, Mrinmay Sarkar wrote:
> This patch series reset STOP_INT_MASK and ABORT_INT_MASK bit and unmask
> these interrupt for HDMA.
> 
> and also remove enablement of local watermark interrupt enable(LWIE)
> and remote watermarek interrupt enable(RWIE) bit to avoid unnecessary
> watermark interrupt event.
> 
> [...]

Applied, thanks!

[1/2] dmaengine: dw-edma: Fix unmasking STOP and ABORT interrupts for HDMA
      commit: 383baf5c8f062091af34c63f28d37642a8f188ae
[2/2] dmaengine: dw-edma: Do not enable watermark interrupts for HDMA
      commit: 9f646ff25c09c52cebe726601db27a60f876f15e

Best regards,
-- 
~Vinod



