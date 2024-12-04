Return-Path: <dmaengine+bounces-3886-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A763E9E3B1C
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D878283420
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7051C4A10;
	Wed,  4 Dec 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6pq0FlJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542B1CBEB9;
	Wed,  4 Dec 2024 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318339; cv=none; b=CmGdiEBJTd2VnedVe2hkrsfEPunVt/FU1JM82+EHtO752Sv8ZZUa2bG4l/7VaPelnhvzvNxjEBmZ8eAeQLUOGZA20AsLDnxZHg//iLwS/EGiONcCqXe8JBMOh3Z+jl/YYPiG5AmVxSqHjHMW25uga+yQTA8vA4aXrd5ga5aaHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318339; c=relaxed/simple;
	bh=O4S/wPTbM0rnpcsNVajI8R2iVuPPDn9yksiA4y4+cvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JS5GB+XWHYN3MJY9UMvXOGt5Cl18RuHuNtwF9AYIJnxm8b1TjToGK0APppj7CsMJGKIDZOXPrqyWsbiMTPmpRGjhzIunCzRRvzYpdfOZ7nAN4hnu/3DEDFLokErIgyBIvugF0Ow0cEFyjra/p+a4KfQ9vq6HxLBPk1ndVEef7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6pq0FlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA089C4CED1;
	Wed,  4 Dec 2024 13:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733318338;
	bh=O4S/wPTbM0rnpcsNVajI8R2iVuPPDn9yksiA4y4+cvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A6pq0FlJQL2VKj1ovTC00ieWA4P9Aw6FKinHGAT1rQS3eG69HCF3NboQDB3cW2lnO
	 F2C7AxwjZoXCoiUaawx3pIP8ZL54ygIQSU8jYRaaYq8q1l48vfT1AUM/LnutW3ffNS
	 K1bQK5tAnHzqMbEHphJRQsaLxFUjEzj0XgL5dmeHALhyVh75xbmpSd7bqdAO1mjtz+
	 NtmktZp/4KjsUQMpepMxm7vzVVJ43aE7TJCt6ZCTSsua4LmJJ0Lb6guljYyXMIixo5
	 xv9uHnEhOW5RkXyjcAfKILjB+0ilnJWbca9IFMVgWMjBpow8au/Ova9RXVbmrNs0KR
	 cJh2KUMlUEP0w==
From: Vinod Koul <vkoul@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
 Robin Murphy <robin.murphy@arm.com>, dmaengine@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <87a5dlwlr0.wl-kuninori.morimoto.gx@renesas.com>
References: <87a5dlwlr0.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] dmaengine: sh: rcar-dmac: add comment for r8a779a0
 compatible
Message-Id: <173331833657.673424.7732753056751334122.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 18:48:56 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 27 Nov 2024 00:42:12 +0000, Kuninori Morimoto wrote:
> Add the reason why we need r8a779a0 compatible.
> 
> 

Applied, thanks!

[1/1] dmaengine: sh: rcar-dmac: add comment for r8a779a0 compatible
      commit: 23417899110410f2fc1bf7dd8df381312d60c933

Best regards,
-- 
~Vinod



