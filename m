Return-Path: <dmaengine+bounces-3853-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED439E0948
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 18:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DE2161C82
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF9C1D9350;
	Mon,  2 Dec 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7eCKFg1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929521D79BE;
	Mon,  2 Dec 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158371; cv=none; b=fHcRYolvlz/CwZ6ZlxxpEFiRWUiG39/vCcVMa1oSx4ysA2uMJ/7zF5/iBfrEvGEbhSFj/SgzFBycE4V+RuszMTfJ5zKmDdoPbN5EUcv4xUI51XifixgA574X7mA8WUXA8kfbqCzao3hHR3npJg5ED8FbEBDfg0vqU8fnf29L7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158371; c=relaxed/simple;
	bh=Q4lgsKkUPNBCVPx2h6Wla6/xJs8K53Ur7RI1wCNcloo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/coeqsC6xCKPOq/rbg2rhAvQeAOf7nDC5/BgE3v/EirvbXP+HFciGEqxmVqsoQkJ2YQp16TS16Fbd3y320zlTaitfRqTMXLcwDoVT3l0UIJvfpdR8F6hW+wyQ8G5cL99yDrvlrWY85xjglOMzRurBl42XqX7ai9OuzNqO9EwKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7eCKFg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0C7C4CED1;
	Mon,  2 Dec 2024 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158371;
	bh=Q4lgsKkUPNBCVPx2h6Wla6/xJs8K53Ur7RI1wCNcloo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7eCKFg1KXaaddaBtfqvXEQXCx2za65xSHDAg3p8iOSCWY6ytSNVv12kFL7z7CWvq
	 0DMDJHotcWDgEDTMj4PylU1/giO6ZMrur/AUevxXMWfJF2QSKA3PdTnFBuglYs9v1l
	 zCVze3VgoxR4wEK0qEngPtu4l8FdTi7N57nYrhTLhhuUiGnk52yUwNHMtO6TRkLpKD
	 UO1NIPx7IyPzKssU3ntLNZQ0wOGJoLJEbIu5NOn9z91bBvHGpBiuRqU9SfQfDX5wWr
	 2rARLFekFQxrlVxy3Fzeu/aF4tQcZku6YYQMY6hDpWKslOmAWnZO0V9FbFOSRigjCM
	 3xbcYpmeBH+9Q==
Date: Mon, 2 Dec 2024 22:22:47 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com,
	bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH V5 2/9] dmaengine: bcm2835-dma: add suspend/resume pm
 support
Message-ID: <Z03l308ur7xuE1SB@vaman>
References: <20241025103621.4780-1-wahrenst@gmx.net>
 <20241025103621.4780-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025103621.4780-3-wahrenst@gmx.net>

On 25-10-24, 12:36, Stefan Wahren wrote:
> bcm2835-dma provides the service to others, so it should
> suspend late and resume early.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/dma/bcm2835-dma.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index e1b92b4d7b05..647dda9f3376 100644
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

Can you help understand how this helps by logging... we are not adding
anything except checking this and resume is NOP as well!

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

