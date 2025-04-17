Return-Path: <dmaengine+bounces-4911-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D9BA9212B
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 17:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717C23B9C29
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86D2253954;
	Thu, 17 Apr 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQ6O5jZL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC7253947;
	Thu, 17 Apr 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903111; cv=none; b=RpLSKQF2VOv7UWaZydtEOsAd3sz7JJBrG5Igb1qZnmumRsbWBZp4y7a6jCHCvOJsPIsgalWyJcRHXf77EIdEpB+Pa7inC+AijQvWYJjuKclhg+XDkHg9ITKn6oAgWeFftGJXbTTyq19BtRQhTyKe6629BgWILZI4jdpz3Zsbnas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903111; c=relaxed/simple;
	bh=YLXT0DIAdwqaiit0FNlWXwry/Zzrp931AZnBeH9NLI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AA/safqC8sFbM2D3DTDJp0LDlbJqVilx0QQ3PuygEIyoZ3YajtehvjikHLVdLFvpevAwEQZeIRA0FPZTHDuh9mWVHunWwiahIWBJTJ9tmWwjoEJPIUN1o+XjjpUO8ahan2pf3OV2eUON8HPPJE8k5pocgIDIAsJurGHfTPimIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQ6O5jZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DE9C4CEEA;
	Thu, 17 Apr 2025 15:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903111;
	bh=YLXT0DIAdwqaiit0FNlWXwry/Zzrp931AZnBeH9NLI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bQ6O5jZLJ326V3lJ2p3M3tMkfZxb3cyFK3OrGqDBkYJoGmwNCwxukhFruRIiZQoEV
	 z8WJAP7FxSwqLd35ix02Xm7+pQRfjC/m512BHaSYPO4/inv2DUjM0ym3FJ7grKT0IC
	 WsyM3ByZrK8lvYiYxOr9S3VBG3U2RgcKQF9naUD5n4SVj9oxMidS0YLU5A8llnnh8J
	 ZS8v37Tu1jOWblU//xoet/QlagYuU6DhPe7rrc/ZkWdh+v5RiO0/oeNhn1u9m2IAz3
	 891Nctfq8gKFRqsdn3kFveQXC3o4imjPCeMUiNISQjKdhDXpTuX+dLQvKBwD0pHyXR
	 d6HbvANswdzCg==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Nathan Lynch <nathan.lynch@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250403-dmaengine-dmatest-revert-waiting-less-v1-1-8227c5a3d7c8@amd.com>
References: <20250403-dmaengine-dmatest-revert-waiting-less-v1-1-8227c5a3d7c8@amd.com>
Subject: Re: [PATCH] Revert "dmaengine: dmatest: Fix dmatest waiting less
 when interrupted"
Message-Id: <174490310945.238609.8546371498324092542.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 20:48:29 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 03 Apr 2025 11:24:19 -0500, Nathan Lynch wrote:
> Several issues with this change:
> 
> * The analysis is flawed and it's unclear what problem is being
>   fixed. There is no difference between wait_event_freezable_timeout()
>   and wait_event_timeout() with respect to device interrupts. And of
>   course "the interrupt notifying the finish of an operation happens
>   during wait_event_freezable_timeout()" -- that's how it's supposed
>   to work.
> 
> [...]

Applied, thanks!

[1/1] Revert "dmaengine: dmatest: Fix dmatest waiting less when interrupted"
      commit: df180e65305f8c1e020d54bfc2132349fd693de1

Best regards,
-- 
~Vinod



