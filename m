Return-Path: <dmaengine+bounces-3698-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A573C9C2ED7
	for <lists+dmaengine@lfdr.de>; Sat,  9 Nov 2024 18:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB653B2126B
	for <lists+dmaengine@lfdr.de>; Sat,  9 Nov 2024 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F317B19CC11;
	Sat,  9 Nov 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="koVjcZPA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A502556E;
	Sat,  9 Nov 2024 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731173854; cv=none; b=slrW481dqrRGtDMjgbCOf3I4FpHnT20OIq8VXZG0FYAx8P0lJOPrQn1BCXikteftMZoemo3MPypZHFLzbacNudLKugpODi5j+dly8fV2qcNfSGQBd3jqL+pT6wf5neP/spd43S7TI2fEgvc3GgOqsDkWTj3x6BUpZ2wQ9BR/dxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731173854; c=relaxed/simple;
	bh=i6yvpd4PiYqHCrO03Ai94gLpVeDRtmo8KRvnB3M/Fpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AP3UL6OGCYBeLH0nX5N45PZxryKcvZnAJmTY2J2MkbFCHJJg86597//ln59fNfzwevYs6M+9DohE564X7NzlpOlkceGLMJVUPbY9bFHWoR7eN4BKl89dFhrSvOl8HKApBcm9/UsddoF4X4Dv+Vcts6gwRZzzK0iQLHwyAv3mhaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=koVjcZPA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731173829; x=1731778629; i=wahrenst@gmx.net;
	bh=ID0U4v8IJwDheWM1GMjMt6YDBO95xzj8yHE+CefJD7M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=koVjcZPAN3TgN0vh/aNhAnQeeko+NkgKFJ4h1F4VtB8yBykyhdHKYHV+tU/tMiZ9
	 tlB9xVpOcO1GutBKUxVA1sY96xww15lbA18nMLnD5QUYIzSUJ9CNd+xnaz3SMXTg7
	 z5DAAWZhHlt4fh+L/OjI98iWmSSOD/cCesYnRhJOwHsA5KdAsMbQ4DKsQ4PBn+oZx
	 Hzfxfwrvve8xeDUAhY4MzVNml7KLvDmkrnnHDuD8kMmGmHiapmWdkLoXD8SrtydZC
	 J4ZktRIFIgZhaWTGsGc754NV+yv+yxHXDY+2KcHYK2a2yptXaXi2agTTJLHfGFuzM
	 JOTecv9qMEEvoqwcbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfUe-1syr2z1s5Y-0097Bl; Sat, 09
 Nov 2024 18:37:09 +0100
Message-ID: <83a0282c-0263-46ba-8eba-78f6a81e7c98@gmx.net>
Date: Sat, 9 Nov 2024 18:37:05 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/9] dmaengine: bcm2835-dma: add suspend/resume pm
 support
To: Russell King <linux@armlinux.org.uk>, Lukas Wunner <lukas@wunner.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, "Ivan T . Ivanov"
 <iivanov@suse.de>, linux-arm-kernel@lists.infradead.org,
 Ulf Hansson <ulf.hansson@linaro.org>, kernel-list@raspberrypi.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Minas Harutyunyan <hminas@synopsys.com>,
 bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org
References: <20241025103621.4780-1-wahrenst@gmx.net>
 <20241025103621.4780-3-wahrenst@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241025103621.4780-3-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hN71PDERMZiyLGnEBo4kzNeGRlc5kNE3RE8MVnKiOzxG8c1bGzU
 +go8AsrMPQugllh1JPxfyvkavCbZpNtALQi2JaZW1jrV1lYo03gLh0t/tS2SoAI/bDQKmW3
 DdKWANT5sJm8Gyt2TuMUt0QEHrnmeqU1KGb145iQVlIVG9pddn+PPicibpIXDhYA/O8yDiK
 cBnHsrnKR37Xz1+5GPWRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LUbR2To7WhQ=;ZEsSZRvxT7/lz0VEiqxCjoC1+0h
 4KFN2gZhUGHQpVKGN1Ks1Xos/+D2k6uhiF9v01JDs3Ov9unVOR632WPrldf3A9pauhU+nr9eh
 t1OexOzAH+JCIotdNQMlIgiV+FDmuX0e/9yfkUDfGdgIRnuy8WPZoz8bzKdNn6y802PS54gTt
 zcBmmTAmQq9OlkUe9TvwaNNeMighOIhiyHLy8SjkHopw9Vf8r1Hof1kLQDhiwMmqs7MLlpswa
 h1YrV1nSPYepF3MGZ15disZWtKE8PGqN5CyMDBdqJ2yQArP7LzmGRAnGt0Xl3r8mwA2gtlxLl
 E32MnPLxNhkz9tcJJ1lQx07TvdKdDj79ynm6i3UTT0S3xq0bMIlttlaeTupwFSCeeLLr45QcZ
 /LBriAnID8R3VJAQT8Ht7AUvVRpregZLNbsEm548eoYsFdU3x+U9gU/WTduEc1/lH8fU9yTBe
 r+qd1sXRlSfyv7Z4WDeQU/stPDdrb3aP3vJGZQhBvyP/9kaxbhMerh7+IuyeeymwzlyvXQL/A
 fesWLW4tVgsQPRT1/hmUWKKQ37BJUxuQEUGK/RjHMLTRKNpZlj7/3pHYtvU4fNQ+DnvJbhilT
 X8C8HxTA8k4ycQ7Mjfr2luOKquBPkSb51qOMSPjsSV0qMylqklOuV1EELzklXBmvvv084jMG9
 AyBk8NFSm21Ufuf8Tpo6UnkXPGn1Z7blB0/7NlCKUtoODr0QSGQVbejSyCYHtZWO0SyzutvS+
 KEyMeLACCXnnjZi0bbEcD1jiY0EzuDwkjchooLE2Pf9FkRKb4EpHKNN2u2u5ZpTQiyp9lia/1
 TpE8gtz3MKLj90BbMY8wUeX88aFWG1/c3XndRfKf5MtTCB70gQgpcZzolQXygHmDOQNRI4YSN
 KwmuxcrdGUltKdMouqKebAH44mwJsXnokO/1BB2xkJYgre0YAPudawPQl

Am 25.10.24 um 12:36 schrieb Stefan Wahren:
> bcm2835-dma provides the service to others, so it should
> suspend late and resume early.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Since there wasn't any feedback for this patch, i want to send a gentle
ping ...

Regards

> ---
>   drivers/dma/bcm2835-dma.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index e1b92b4d7b05..647dda9f3376 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -875,6 +875,35 @@ static struct dma_chan *bcm2835_dma_xlate(struct of=
_phandle_args *spec,
>   	return chan;
>   }
>
> +static int bcm2835_dma_suspend_late(struct device *dev)
> +{
> +	struct bcm2835_dmadev *od =3D dev_get_drvdata(dev);
> +	struct bcm2835_chan *c, *next;
> +
> +	list_for_each_entry_safe(c, next, &od->ddev.channels,
> +				 vc.chan.device_node) {
> +		void __iomem *chan_base =3D c->chan_base;
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
> +static const struct dev_pm_ops bcm2835_dma_pm_ops =3D {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(bcm2835_dma_suspend_late,
> +				     bcm2835_dma_resume_early)
> +};
> +
>   static int bcm2835_dma_probe(struct platform_device *pdev)
>   {
>   	struct bcm2835_dmadev *od;
> @@ -1033,6 +1062,7 @@ static struct platform_driver bcm2835_dma_driver =
=3D {
>   	.driver =3D {
>   		.name =3D "bcm2835-dma",
>   		.of_match_table =3D of_match_ptr(bcm2835_dma_of_match),
> +		.pm =3D pm_ptr(&bcm2835_dma_pm_ops),
>   	},
>   };
>
> --
> 2.34.1
>

