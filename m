Return-Path: <dmaengine+bounces-7692-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1BACC4786
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79E9C300BA15
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CADD2BE7AB;
	Tue, 16 Dec 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQJcmnep"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1E2882C5;
	Tue, 16 Dec 2025 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904183; cv=none; b=obEFzbqSWtTskpQc/EO6vH2KBBWX30ih14xUEvpV9CaENvY2vdks74n5rSCbROyK20Jst0H7NhQItOZe5pGcWGihS18jVds22zsY5QthOhGM53dJ+ShacQELcZ7ftazPvfLgWqfr8TG4WgcJD6B8vYMVbQaS+JrWhl7o2lROj50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904183; c=relaxed/simple;
	bh=tG1SeQOIXU1i/h7qdkQqs75ay6wmpkRhFCtiG6Q9UtE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UDUbuoSrtmNOof/5CMZuCYI3JrSAFJPU+s9qk24fy2va2p1o7GeRha+bEPHJJ2fitBDIyqH6xvaUsU2ETJdUthlK+24JpWIzTodHRG+D+z0JfEpFhCjxB9zhHxxSEiLMUbrICygvGL7ba22/wkq19xfKTBZNDZPJnbntzl3HkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQJcmnep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BD0C4CEF1;
	Tue, 16 Dec 2025 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765904183;
	bh=tG1SeQOIXU1i/h7qdkQqs75ay6wmpkRhFCtiG6Q9UtE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tQJcmnep3X5OaTr7M8sl6sAneglR3sSnvztHM/lNU2JFpXSUR+VnRAysvJvxidnbW
	 hGKH807FiJvuUhcRjyNeIIsZMjrnw+x+agK/YzR8ndjQ5kEFjqQePQ3sW4PaBc9pJd
	 RAV6s/I9rgpSAd0/K1/tdTX6jdPH4Cj4bSQRSqmxpKZ8AJLnd3pQ26tiVuW/d/tP9S
	 6tO7ZHHwJda28Lo4ItYxU5ryznvIlh1DB0RyK1nLE7c8vITsg1xqawZ6mbriuva3xL
	 9/U/Eu+W6lTUg4ky064k5q4nvMSLo0tmshUkjxBsDYTGFBq20mWL5zqk1VNwPAf+zW
	 GEhJ9zLFVWiLA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@nxp.com, Zhen Ni <zhen.ni@easystack.cn>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20251014090522.827726-1-zhen.ni@easystack.cn>
References: <20251014090522.827726-1-zhen.ni@easystack.cn>
Subject: Re: [PATCH v4] dmaengine: fsl-edma: Fix clk leak on
 alloc_chan_resources failure
Message-Id: <176590418161.422798.10654079302568628725.b4-ty@kernel.org>
Date: Tue, 16 Dec 2025 22:26:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 14 Oct 2025 17:05:22 +0800, Zhen Ni wrote:
> When fsl_edma_alloc_chan_resources() fails after clk_prepare_enable(),
> the error paths only free IRQs and destroy the TCD pool, but forget to
> call clk_disable_unprepare(). This causes the channel clock to remain
> enabled, leaking power and resources.
> 
> Fix it by disabling the channel clock in the error unwind path.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: Fix clk leak on alloc_chan_resources failure
      commit: b18cd8b210417f90537d914ffb96e390c85a7379

Best regards,
-- 
~Vinod



