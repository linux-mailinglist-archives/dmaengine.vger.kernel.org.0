Return-Path: <dmaengine+bounces-4010-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B562B9F5100
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7775C188A014
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AFF1F470F;
	Tue, 17 Dec 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Sduztu2d"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB064142E77
	for <dmaengine@vger.kernel.org>; Tue, 17 Dec 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452988; cv=none; b=AB6AB3kNQMJuvPMALaw5IgFKyL3DhWJdIe42jcnkBGtumZkWUwsWATh2+30jl2EGdcLz6Oijf3Uj7lXTvLRvgPx+62+W2a4f4XozYjH8FkawSYoEiR19OD6cBJSvxZoTOpth0DOOPqtYM757lsqyyljILrdqQWRwHyoxQDBA5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452988; c=relaxed/simple;
	bh=DD3FAl2qtwgNuyy16y7MJ5DW9ahwRaPByNpYh242nJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5MWk+V04fX7tSxFqDhmymZ2ABoOC13RJROmagwzUqUbIGbTwF1FMp87P/GKjEKlroHqJX9X7fVtqIwhUb47/cAlm037ne2OpZOuHVLrIdVeqPugtU2bJ9rk9EretNyys4IqFD9Q5VKdkT9dYFXlVbM/4vOrsn7uFeO0uciJRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Sduztu2d; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1734452970; x=1735057770; i=wahrenst@gmx.net;
	bh=n9zwjCj6EBJRZwuako70jsyhbW+Mce+32hY+E/9TnlI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sduztu2dzkh+F63ImWLjVCtaxFvnk8myIrUqxHjsmeNJEC6qi6VTC89A8PFby0JV
	 D8szjnTPkyePT2HUTKfLNR0aFTZ+5gYg9BbGF8ZXvibPraZAZG6W+RLBOscZffo2z
	 eFlRzk6L/IWGYL4fFsz/owBuCxVA9jbRckvvuIBzBs3elN5nz7eIeGwF+xmTjwZ3D
	 T+tAueB2+eFEqbB+3lkQSKZkaEyP33nrbr91p8tFFfklt0fg3dDW5DGYLWuUi84/A
	 qLNHXUrZrHnePF56IdA9CB1zHO09251XvC5/QE168qaag4cwXag+1xGrC1hSbxtCb
	 G02RG6GerC75G2mGFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.106] ([37.4.251.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1t2Sf136pR-00UshK; Tue, 17
 Dec 2024 17:29:30 +0100
Message-ID: <da2113a5-301b-4421-a651-9922d4ffb0de@gmx.net>
Date: Tue, 17 Dec 2024 17:29:29 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7] dmaengine: bcm2835-dma: Prevent suspend if DMA channel
 is busy
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 "Ivan T . Ivanov" <iivanov@suse.de>, linux-arm-kernel@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org
References: <20241204165546.77941-1-wahrenst@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20241204165546.77941-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Da3P5oCeg9aKX6VLje1ZWdJ4c+FGgHfiqv1Puf3Sy97Cv4z2cB5
 Fl0ro4tXVQuFhUqUuaL60prR20rnCXE/nTI+XOaYHUai38ZWOL8kqK8WphB/YfacqgRemqy
 ECxzarKJW38gTyNX4pdg0euqPrXmkwvA5cfFtY/LicFUmTHo6F3I7A9Lgy4/rWas6GpASv4
 HMquwGzCoNKfCH+gBay9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x3XvP3T0YLE=;yI4GKni3/dyqiiUPmfbmS+zpBZJ
 Feag4HlOU+ySnEZ8ZD+E1IcFix5V0zYqmi6lGgp/Pa9YUSdCZptOyPWGF+xgiOj3f//Zpy8CE
 NN581qddagMEZpgK5Hn4bF0/BmPPxCApzobrQk8KPOlfiqkj8nVB6VElF36JK2nOidKCce/Vz
 hmBeUYRRAwcy0ZQ+9Eb6UEPlTpXOTYXBZWus1d83IDfhdQjRoRrsCW4l90s+AkoC6GWDpc1ST
 Lj9hm87pdqxZ/iqvmDMLXPYmRbH60+APp05kjF9AnD9GjT+P9NoFl9/FWpJruy2/fwSOo7m/I
 MtBkhRh6FfdRboRiwHzYx1KFDjh0Z9PRiacDDaBijHQEW3sgvazJKIf8Xf2PSFD9p+5ea7AcU
 3sS+pGbA8qwAe5l7MeSuGjU48JkUHP48oync8nKTb0NJVy/mw7M5rQrA4g7TtckHpXtGbxBI/
 A1dZKvw9J4qEp1g3TjDus4TtN9RlbSm10W0a7g+6NZpryFZlx4B5C+oNeZ/RuebyoDn/buVZ4
 Gc69nq+FkKZ+6SUvicGqNwksFHZpf6OujN3rcRufZvT23C5NGqekusC9TggKOjAZM+juLQTxk
 z3nLJDljC0RastSguHrVs7G88Kgu+4xTZib0J8+oJRR1KK6WLoJ6PU1trBR2JMA8zGjIlKGq8
 5tsG9rRk0eeFf/MvubsIERbzbIcm6tLdXyNlJ/t/s0wodwb8lQTHRAxA23YZEKBpfQEwMAoiG
 sski7S9nKqcjsLUrO1eHG4ZFYmalRQH/rWKfOavh3k9XVx6lbbV5z9IbdlECItSuzEG3aPFfV
 jqe8i1hhGpmqEQw/kB0dNz5fzsGphd1H6NEEO5wAfwoTdJLw8OzUqIHU9jf+laP45r7dh0Wdq
 h8f7/g3kU6EOnKi9jR46bi9r99ewoGJEAQYEVZZ9lU3fyWy4XoAZQyODRRcxavyJRZHzIzo/z
 KAc8wziUh/ADBH5IuT5NCbv8xmIvTjrRKobgrr023zi0csEoBt2DFxCGj2iA5ImXBalL5irfU
 bzUVRAt2kH1IayBSvOKTAJsOjSUqHYCEJ5+FQ9zmTcdrnxwOSbUe07GPDkzo2r8obiDyoiqSK
 ZqGlJIDFTVJCBJ3ftH3I/vWl1Mluk0

Am 04.12.24 um 17:55 schrieb Stefan Wahren:
> bcm2835-dma provides the service to others, so it should suspend
> late and resume early. Suspend should be prevented in case a DMA
> channel is still busy.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
gentle ping ...
> ---
>   drivers/dma/bcm2835-dma.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> Changes in V7:
> - improve patch title and changelog
> - add explaining comment and drop warning in suspend
> - drop empty resume callback
>
> Changes in V6:
> - split out of series because there is no dependency
>
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 7ba52dee40a9..20b10c15c696 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -875,6 +875,27 @@ static struct dma_chan *bcm2835_dma_xlate(struct of_phandle_args *spec,
>   	return chan;
>   }
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
> +		/* Check if DMA channel is busy */
> +		if (readl(chan_base + BCM2835_DMA_ADDR))
> +			return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops bcm2835_dma_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(bcm2835_dma_suspend_late, NULL)
> +};
> +
>   static int bcm2835_dma_probe(struct platform_device *pdev)
>   {
>   	struct bcm2835_dmadev *od;
> @@ -1033,6 +1054,7 @@ static struct platform_driver bcm2835_dma_driver = {
>   	.driver = {
>   		.name = "bcm2835-dma",
>   		.of_match_table = of_match_ptr(bcm2835_dma_of_match),
> +		.pm = pm_ptr(&bcm2835_dma_pm_ops),
>   	},
>   };
>
> --
> 2.34.1
>


