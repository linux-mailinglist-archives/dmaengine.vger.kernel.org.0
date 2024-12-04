Return-Path: <dmaengine+bounces-3877-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D459E39F2
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F810164DF8
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 12:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2897D1B4F3A;
	Wed,  4 Dec 2024 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk+pX1ey"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27AF5103F
	for <dmaengine@vger.kernel.org>; Wed,  4 Dec 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315302; cv=none; b=FZogaz/W5tD5BXQirAuj6XCiHDbCzmHTbgVfieCIluFoWpEnrpdqdIY3pYcMekNOB6LTx0V9J9lYWIYNYWS/+DgEx/XEE+elj6rguIllF+JZL+1Js3jihlQM+/srWCn81kL+u7kAh2SbpYuut1+xbZXrKFsDX9JzwjgRgEWZUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315302; c=relaxed/simple;
	bh=0esWkB65X/oo0wpPGn1s8FVihkOj05L6lVwMoKq7XrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INSsI3lY4XoGUTZlaZgNS14iFrxgPd58VONxVcMoV+AdrrJoZStia6zd+pzk94PkZoxk1IGjrOxQk7mkxtq/FAny25QjgRebI7eaVCboKWoLbQ53O+iiuLo7o95Lpy7PNAezCMEdngilRI+ujJ7a0wNDXyT/msh3DzDmJJsccn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk+pX1ey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AFAC4CED1;
	Wed,  4 Dec 2024 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733315301;
	bh=0esWkB65X/oo0wpPGn1s8FVihkOj05L6lVwMoKq7XrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yk+pX1eynZsmc8x6Om6FhATvU+rnJ3HzRRDV8nLnRNp3YCikYOz61K8XJJt+j38je
	 izYAQPK6L88Rm4VDrJsbVCrFczn4lu50bTVSEXJmKwcMn/8thHdnGdyP09uUJIJC66
	 9/eBrGJXLqDYUbo5a4Ik/fN/JuDJHOWxmFCxrjaZjoWoRVtNJDQTJAB9LJsPg58BTc
	 ctP1ANau81fwy28kpPuAgFJL0JB41Rnn3SOYPLgQR1xlcDZUH5wl6c4V0jgXFVqfrp
	 b44PTGu9uUFc8NHglcM7xgQIFN5sbD0qJou7kg7lo7kgk5LOop9E3Niq31ujjyhuQs
	 MCJGdrOKE9eag==
Date: Wed, 4 Dec 2024 17:58:18 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org
Subject: Re: [PATCH V6] dmaengine: bcm2835-dma: add suspend/resume pm support
Message-ID: <Z1BK4rcOvCoA+xdH@vaman>
References: <20241202114627.33401-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202114627.33401-1-wahrenst@gmx.net>

On 02-12-24, 12:46, Stefan Wahren wrote:
> bcm2835-dma provides the service to others, so it should
> suspend late and resume early.

Expecting v7 with updated title and changelog and dropping resume

> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/dma/bcm2835-dma.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
>  Changes in V6:
>  - split out of series because there is no dependency
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 7ba52dee40a9..cf8a01a5b884 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -875,6 +875,35 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
>  	return chan;
>  }
> 
> +static int bcm2835_dma_suspend_late(struct device *dev)
> +{
> +	struct bcm2835_dmadev *od = dev_get_drvdata(dev);
> +	struct bcm2835_chan *c, *next;
> +
> +	list_for_each_entry_safe(c, next, &od->ddev.channels,
> +				 vc.chan.device_node) {
> +		void __iomem *chan_base = c->chan_base;
> +
> +		if (readl(chan_base + BCM2835_DMA_ADDR)) {
> +			dev_warn(dev, "Suspend is prevented by chan %d\n",
> +				 c->ch);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int bcm2835_dma_resume_early(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops bcm2835_dma_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(bcm2835_dma_suspend_late,
> +				     bcm2835_dma_resume_early)
> +};
> +
>  static int bcm2835_dma_probe(struct platform_device *pdev)
>  {
>  	struct bcm2835_dmadev *od;
> @@ -1033,6 +1062,7 @@ static struct platform_driver bcm2835_dma_driver = {
>  	.driver = {
>  		.name = "bcm2835-dma",
>  		.of_match_table = of_match_ptr(bcm2835_dma_of_match),
> +		.pm = pm_ptr(&bcm2835_dma_pm_ops),
>  	},
>  };
> 
> --
> 2.34.1

-- 
~Vinod

