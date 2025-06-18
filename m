Return-Path: <dmaengine+bounces-5535-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A32ADF530
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 19:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089CF1BC4925
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD8D2EE99E;
	Wed, 18 Jun 2025 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uV7628HY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1803085C4;
	Wed, 18 Jun 2025 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269403; cv=none; b=HcUf272pZ/xB4iWpU5ROCQVItcmNo8bekANYQbEkPHj30khJVLG8HDSTkxK9L+SmswK1tYdeGLSUNtLIgP6OfIg5W7wTseNFKYkxnhGexgJWEVxgCsj00cRJaf21k2OPP9m5tFAk+6P0A57x3TNyLxx92yNnwDWlycFV0uqnIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269403; c=relaxed/simple;
	bh=V0jYqFFKbzT7bXfhR/W46mT6WW4TnOaHWP8Drco8eiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzqvH0HT6ar91VFPIbToGLNLt2xB0vYNj5N4KaFznedG8VaTWG/mKq+sh+eECar7fhrhfD1JdClRrJl4faepQNupKIWkaJEfPxv1+jU4atiLhaBPviNooLd+SJGMJIX6DwEFwJqmvlPVnBUZZYBcqYKYSZL/JD6pOnUDBN5cp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uV7628HY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33887C4CEE7;
	Wed, 18 Jun 2025 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750269401;
	bh=V0jYqFFKbzT7bXfhR/W46mT6WW4TnOaHWP8Drco8eiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uV7628HYaOedZ3pV9W7Ru7d0YDnUQZ+TXa7cQWrutbXYSYKAfl7ue8cv+fgaBuWUY
	 Oq1SxMn3u4ueJxX2enqWnA7QtAqBzkko+p8iD9Xfvsi1ClKHASGGOs5EM4J+vKPSUA
	 saiJ32qW4OVwUn4twpjLmMGm9NwNLEfH34ihfXETKQekxfjF//UiI5lv64PxgkMLjK
	 YiVn93P4n+NPJm0L7ECpei0VPaclRin5EnH6ELEnV1SMXIsUKhDLu8F7ka2INP9F94
	 O6Yn49GNo1amfPXd59VFhvYyiPsppYkzM+n2Wvp7c1zThiK+ccP744aWttvBTCszvH
	 0yrVqWTYtfPVw==
Date: Wed, 18 Jun 2025 23:26:37 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Abin Joseph <abin.joseph@amd.com>, michal.simek@amd.com,
	yanzhen@vivo.com, radhey.shyam.pandey@amd.com, palmer@rivosinc.com,
	git@amd.com, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: zynqmp_dma: Add shutdown operation support
Message-ID: <aFL91fq7SPAiXOak@vaman>
References: <20250612162144.3294953-1-abin.joseph@amd.com>
 <aFENfW0v0gmtY2Gu@vaman>
 <rgjc7ujikyznrri27u6v3zst2m44423g46rlfnkfncr24jwx6z@mfwwvhe3upby>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rgjc7ujikyznrri27u6v3zst2m44423g46rlfnkfncr24jwx6z@mfwwvhe3upby>

On 17-06-25, 09:43, Uwe Kleine-König wrote:
> Hello Vinod,
> 
> On Tue, Jun 17, 2025 at 12:08:53PM +0530, Vinod Koul wrote:
> > On 12-06-25, 21:51, Abin Joseph wrote:
> > > Implement shutdown hook to ensure dmaengine could be stopped inorder for
> > > kexec to restart the new kernel.
> > > 
> > > Signed-off-by: Abin Joseph <abin.joseph@amd.com>
> > > ---
> > >  drivers/dma/xilinx/zynqmp_dma.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> > > index d05fc5fcc77d..8f9f1ef4f0bf 100644
> > > --- a/drivers/dma/xilinx/zynqmp_dma.c
> > > +++ b/drivers/dma/xilinx/zynqmp_dma.c
> > > @@ -1178,6 +1178,18 @@ static void zynqmp_dma_remove(struct platform_device *pdev)
> > >  		zynqmp_dma_runtime_suspend(zdev->dev);
> > >  }
> > >  
> > > +/**
> > > + * zynqmp_dma_shutdown - Driver shutdown function
> > > + * @pdev: Pointer to the platform_device structure
> > > + */
> > > +static void zynqmp_dma_shutdown(struct platform_device *pdev)
> > > +{
> > > +	struct zynqmp_dma_device *zdev = platform_get_drvdata(pdev);
> > > +
> > > +	zynqmp_dma_chan_remove(zdev->chan);
> > > +	pm_runtime_disable(zdev->dev);
> > > +}
> > > +
> > >  static const struct of_device_id zynqmp_dma_of_match[] = {
> > >  	{ .compatible = "amd,versal2-dma-1.0", .data = &versal2_dma_config },
> > >  	{ .compatible = "xlnx,zynqmp-dma-1.0", },
> > > @@ -1193,6 +1205,7 @@ static struct platform_driver zynqmp_dma_driver = {
> > >  	},
> > >  	.probe = zynqmp_dma_probe,
> > >  	.remove = zynqmp_dma_remove,
> > > +	.shutdown = zynqmp_dma_shutdown,
> > 
> > Why not do all operations performed in remove..?
> 
> .remove() isn't called on shutdown.

Yes that is correct

> Having said that, most other drivers also don't handle .shutdown(). IMHO
> this is special enough that this warrants a comment. Or is kexec a
> reason to silence *all* DMA and most drivers should have a .shutdown
> callback?

My point was remove does a lot of work to quiesce the dma transactions,
terminate the pending work etc, all those steps should be ideally done
on shutdown too, hence question of why not do all the steps done in
remove as well

But yes, you are bringing another good point for drivers, they should
have a shutdown callback implemented

-- 
~Vinod

