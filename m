Return-Path: <dmaengine+bounces-714-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1B182A40A
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jan 2024 23:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EAC1C22AC2
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jan 2024 22:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BAF4E1BF;
	Wed, 10 Jan 2024 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UlNCwhmr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D74CDE7
	for <dmaengine@vger.kernel.org>; Wed, 10 Jan 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3e8a51e6bso37798665ad.3
        for <dmaengine@vger.kernel.org>; Wed, 10 Jan 2024 14:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704926479; x=1705531279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdU8XQ8hAn2X9CvWueVcEm806lEJ5ho/XsvrIs44ZKs=;
        b=UlNCwhmrwZb1gcpWKFkUQexXpz9lwM27XJMS3GUMYQ8erbXkktwQIvmHAm1MWkWcBa
         5+pa8vuu/SHk77aE98Fw7yJj1UJ8MjsUXunWfRUw7XlBdjU+lrBvmMOnFgAcNMy5CK6C
         qDuM5TeK3jgDXBL8r9dKVM4z76e/yAoXsUSCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704926479; x=1705531279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdU8XQ8hAn2X9CvWueVcEm806lEJ5ho/XsvrIs44ZKs=;
        b=qM0aWZVHPjjzvaYny/rUhMWBziCvV8+2EUkdH/fpyKHcR64UjTbsBqDJl2KceN0VGz
         6IDMMY21kFkjFTUksVC1vlSmhoixBHWbhe8Ee0MNwGzTQTyXJOaboopwWHRtPpuadTw4
         DVjL6W2Lo4NGOFA8s9E3l4/Kcgg1fZwAZOB3Qu3236B2Vs8q6uPW2f4g1EkLTvztS/6T
         jle6+Ckm5sF1vDQydFZ9rAQ2IFQ/wgB/WA0gQLjq3k1sIkJ+SR9pFPuerGj3tk3sQ2B7
         MWr66Ppq5Ti8MgX76bNuTW1PBdKy8ofVytPq3zcwT/f56UJWBtMEZoL34EPhiWG31hZX
         6SIg==
X-Gm-Message-State: AOJu0YyIGf6syLWCMiBXRMMGwdAsatpC9xYt4wEpoNBrOLAADp7ZHk0A
	OXn+wXheYrgHqVGXQdouBNQxS0wcS+Vg
X-Google-Smtp-Source: AGHT+IHp847lM7oeKuciJE8ldA5qlj6UWszN7QW4GPZK7rdK1qWeVVXe7fVH+4XSitoofTTZv6Ep0g==
X-Received: by 2002:a05:6a20:429b:b0:199:40a9:6716 with SMTP id o27-20020a056a20429b00b0019940a96716mr152336pzj.27.1704926479657;
        Wed, 10 Jan 2024 14:41:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ff26-20020a056a002f5a00b006da73b90fe4sm4123314pfb.14.2024.01.10.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:41:19 -0800 (PST)
Date: Wed, 10 Jan 2024 14:41:18 -0800
From: Kees Cook <keescook@chromium.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dmaengine: usb-dmac: Avoid format-overflow warning
Message-ID: <202401101437.48C52CF6@keescook>
References: <20240110222210.193479-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110222210.193479-1-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Wed, Jan 10, 2024 at 10:22:10PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> gcc points out that the fix-byte buffer might be too small:
> drivers/dma/sh/usb-dmac.c: In function 'usb_dmac_probe':
> drivers/dma/sh/usb-dmac.c:720:34: warning: '%u' directive writing between 1 and 10 bytes into a region of size 3 [-Wformat-overflow=]
>   720 |         sprintf(pdev_irqname, "ch%u", index);
>       |                                  ^~
> In function 'usb_dmac_chan_probe',
>     inlined from 'usb_dmac_probe' at drivers/dma/sh/usb-dmac.c:814:9:
> drivers/dma/sh/usb-dmac.c:720:31: note: directive argument in the range [0, 4294967294]
>   720 |         sprintf(pdev_irqname, "ch%u", index);
>       |                               ^~~~~~
> drivers/dma/sh/usb-dmac.c:720:9: note: 'sprintf' output between 4 and 13 bytes into a destination of size 5
>   720 |         sprintf(pdev_irqname, "ch%u", index);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Maximum number of channels for USB-DMAC as per the driver is 1-99 so use
> u8 instead of unsigned int/int for DMAC channel indexing and make the
> pdev_irqname string long enough to avoid the warning.
> 
> While at it use scnprintf() instead of sprintf() to make the code more
> robust.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This looks like good fixes; thanks! I see n_channels is sanity checked
during the probe in usb_dmac_chan_probe(), so this looks good.

(Is there a reason not to also change n_channels to a u8?)

-Kees

> ---
>  drivers/dma/sh/usb-dmac.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> index a9b4302f6050..f7cd0cad056c 100644
> --- a/drivers/dma/sh/usb-dmac.c
> +++ b/drivers/dma/sh/usb-dmac.c
> @@ -706,10 +706,10 @@ static const struct dev_pm_ops usb_dmac_pm = {
>  
>  static int usb_dmac_chan_probe(struct usb_dmac *dmac,
>  			       struct usb_dmac_chan *uchan,
> -			       unsigned int index)
> +			       u8 index)
>  {
>  	struct platform_device *pdev = to_platform_device(dmac->dev);
> -	char pdev_irqname[5];
> +	char pdev_irqname[6];
>  	char *irqname;
>  	int ret;
>  
> @@ -717,7 +717,7 @@ static int usb_dmac_chan_probe(struct usb_dmac *dmac,
>  	uchan->iomem = dmac->iomem + USB_DMAC_CHAN_OFFSET(index);
>  
>  	/* Request the channel interrupt. */
> -	sprintf(pdev_irqname, "ch%u", index);
> +	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
>  	uchan->irq = platform_get_irq_byname(pdev, pdev_irqname);
>  	if (uchan->irq < 0)
>  		return -ENODEV;
> @@ -768,8 +768,8 @@ static int usb_dmac_probe(struct platform_device *pdev)
>  	const enum dma_slave_buswidth widths = USB_DMAC_SLAVE_BUSWIDTH;
>  	struct dma_device *engine;
>  	struct usb_dmac *dmac;
> -	unsigned int i;
>  	int ret;
> +	u8 i;
>  
>  	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
>  	if (!dmac)
> @@ -869,7 +869,7 @@ static void usb_dmac_chan_remove(struct usb_dmac *dmac,
>  static void usb_dmac_remove(struct platform_device *pdev)
>  {
>  	struct usb_dmac *dmac = platform_get_drvdata(pdev);
> -	int i;
> +	u8 i;
>  	for (i = 0; i < dmac->n_channels; ++i)
>  		usb_dmac_chan_remove(dmac, &dmac->channels[i]);
> -- 
> 2.34.1
> 

-- 
Kees Cook

