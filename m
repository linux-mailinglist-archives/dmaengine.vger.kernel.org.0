Return-Path: <dmaengine+bounces-5637-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BDCAEA97D
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 00:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADE33BAD11
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jun 2025 22:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397D021B91F;
	Thu, 26 Jun 2025 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4p020pp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CC213E74;
	Thu, 26 Jun 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976417; cv=none; b=cdh1qRU2bD7+mt1/Y/gLrV5uFlIKCtj5UalAkOdU2tAyynT/ZGYtuFZQiKk/p2FBbuuJkf2ONf7j5VLqtviX4TA9d4ItIoT6Q8nxSOP9LDuJLOX3sbjONopCwsWBn8J1nTg3t4+3c1p5C125IkQkJHktUsHVmJ43lZePvvN6pzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976417; c=relaxed/simple;
	bh=ucsBH0oET7oAgyvEDa/a3datI+skfPNQCt62RZ9yLVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6qgVpLRWz8hZsKEYfnPjw/cajpGOXun1yH343/63hdE/Zby17cMAqidWj8guzX6YewlmtH/hSgHmSDB9CCtk43yRi3U36QrliLDaHXbuf30VjVzgZIrMrwZrkzSKJ/6InpGreZc7mS7334613khMCv6LK4d3j30IcVn9E+SATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4p020pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E10AC4CEEB;
	Thu, 26 Jun 2025 22:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750976416;
	bh=ucsBH0oET7oAgyvEDa/a3datI+skfPNQCt62RZ9yLVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4p020ppAY3ZUq9GxVphQHtmW7Nv2xB3Wlg/q5yrQXm3EkE4bNikZUjWa5OIG8tnY
	 qtMYEw3dh73r/bTvkyn9L9gXBaKwOB4wvwcG7etPZo7YfoQzeQrJnM2fJmTcw7SUp9
	 KmWoOf20XipOsGc1GkCMmgMDT6jjEM70DyFcnzkBLgas24Ko1EjFvkEpghCb0YZfVB
	 bn4kGt9o7Ov8zt2bA+jqmXecRQJDiKeFJCiebQvy8IMVUKoksvX4xWLOwHccsA/+45
	 Jtlbp/Fs/ev4/nB1b/m1NOqovgi6S4APtgI0cIT6LKyITOXVq+b1qCAn0TcVGABlqO
	 tpqQ/llYEUv0Q==
Date: Thu, 26 Jun 2025 15:20:15 -0700
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v7 0/2] Add `devm_dma_request_chan()` to simplify probe
 path in atmel-quadspi.c
Message-ID: <aF3Hn_yWPMOXOb9f@vaman>
References: <20250610082256.400492-1-csokas.bence@prolan.hu>
 <f21f9aa5-974a-4326-88e0-cd29fd24555f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f21f9aa5-974a-4326-88e0-cd29fd24555f@sirena.org.uk>

On 10-06-25, 12:49, Mark Brown wrote:
> On Tue, Jun 10, 2025 at 10:22:52AM +0200, Bence Csókás wrote:
> 
> > to their devm_ managed counterparts. Patch 1/2 adds the new
> > `devm_dma_request_chan()` function. Patch 2/2 then uses this APIs to
> > simplify the probe() function.
> 
> I'm not copied on patch 1, please let me know if/when there's some
> progress there.

You can pull in this tag for the dependency

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine_devm_api

for you to fetch changes up to 08bf1663c21a3e815eda28fa242d84c945ca3b94:

  dmaengine: Add devm_dma_request_chan() (2025-06-26 15:18:04 -0700)

----------------------------------------------------------------
dmaengine: tag for devm api

----------------------------------------------------------------
Bence Csókás (1):
      dmaengine: Add devm_dma_request_chan()

 drivers/dma/dmaengine.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |  7 +++++++
 2 files changed, 37 insertions(+)

Thanks
-- 
~Vinod

