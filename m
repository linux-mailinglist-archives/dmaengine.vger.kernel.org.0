Return-Path: <dmaengine+bounces-4586-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6934A47CEC
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 13:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2282E16CDDE
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2025 12:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0E722D4DB;
	Thu, 27 Feb 2025 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVQCIbvi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7166622D4D3;
	Thu, 27 Feb 2025 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658068; cv=none; b=jQUit7+y3Wri6Gxl2n2A+xg58wzQQBRT2ybfA1wrcNop8mIl0y14MJsRhzkW3EsEAQbnDyqJwwy5ksU4k/F71EbV2TMbuRnVTYscIhDqGJpsniwhgkl8DFiu/6GT6dG7nAU/h/IAsDrA3adbYgJDbtpTiFdqT8INeMbJ04By0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658068; c=relaxed/simple;
	bh=/hCAJApp+uqq28d/drSoxYk4Huw19uqsMNVDOUZrtQY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mYmmpk3ocNQCg8UsdvtG/8XMSDOG+Bwg+jhT6HI2BRohNUMv5Dz2q37+jZ3/9+d085TToPnUjSUUEBlmdGiC91OnDgISEpZ+7RYox5hOZGhoAUoRd3WbocyF+Y3WrGOItX4oRKYYzxEp4Iwqj7F84vbzIEtiwh4vLHhWmMcGY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVQCIbvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6FEC4CEE8;
	Thu, 27 Feb 2025 12:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658067;
	bh=/hCAJApp+uqq28d/drSoxYk4Huw19uqsMNVDOUZrtQY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qVQCIbviXRvK1e1bG20aawo8NQ71u4lype/QzXhZgVzDZKUPlj4IXA2xFo7RYqEII
	 /bC0RTzbmayXT90In0LrkOmso7ObZek6exi9BO/GD8raswKRxiUcQhCwfb6lYVOjMq
	 JHAN9Ky5Eq1ZXA2j85Zf3KfjhtFv40OXLXBEQ445vUmME0X9AHII4bvTKMWVDELKZj
	 i26AwEqTMIpalT5YkDInCe3d6xfdS6YUiEWLNCHP0ClZ8g+C3Mzz6YCEBEMCLLtD72
	 W/wPt8wEO3aJmViZWXGMb4b8f2/+aFFPPGcdm/GJgc+r5oXULWxV/MN9aGOcQFpyHy
	 ajA89JGk10I1A==
From: Vinod Koul <vkoul@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250225163315.4168033-1-arnd@kernel.org>
References: <20250225163315.4168033-1-arnd@kernel.org>
Subject: Re: [PATCH] dmaengine: img-mdc: remove incorrect of_match_ptr
 annotation
Message-Id: <174065806591.367410.16888539892440851329.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 17:37:45 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 25 Feb 2025 17:33:12 +0100, Arnd Bergmann wrote:
> Building with W=1 shows a warning about of_ftpm_tee_ids being unused when
> CONFIG_OF is disabled:
> 
>     drivers/dma/img-mdc-dma.c:863:34: error: unused variable 'mdc_dma_of_match' [-Werror,-Wunused-const-variable]
> 
> 

Applied, thanks!

[1/1] dmaengine: img-mdc: remove incorrect of_match_ptr annotation
      commit: 186fdd3d87e7b77f7537ff65f686d029cb6560d2

Best regards,
-- 
~Vinod



