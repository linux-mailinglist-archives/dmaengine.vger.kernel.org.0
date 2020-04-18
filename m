Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FB61AF188
	for <lists+dmaengine@lfdr.de>; Sat, 18 Apr 2020 17:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgDRPRR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Apr 2020 11:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDRPRR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 18 Apr 2020 11:17:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 489D22072B;
        Sat, 18 Apr 2020 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587223036;
        bh=qugxNfPkvqYi5+IUgteDQlgxWnSNpZvobR+yGLVDicc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BkhkS6zEdLKRGqWQpRLzde6OxUxvIwlsvwGWQPRdCua2pBb8tHU3aRvh2C5SCmGxF
         hJJb3A/+a666MlSl69WLezjGQ6lb9GPV3C8sSkDhE+D/DkCU8wBeqbBydQz5q1+cfp
         Px4H65dHyixYKeb6TjYi7fnmo/ai+VhYvqh6vU6A=
Date:   Sat, 18 Apr 2020 16:17:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial 4/6] iio: Fix misspellings of "Analog Devices"
Message-ID: <20200418161710.55ccf37c@archlinux>
In-Reply-To: <20200416103058.15269-5-geert+renesas@glider.be>
References: <20200416103058.15269-1-geert+renesas@glider.be>
        <20200416103058.15269-5-geert+renesas@glider.be>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 16 Apr 2020 12:30:56 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> According to https://www.analog.com/, the company name is spelled
> "Analog Devices".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to the togreg branch of iio.git and pushed out as testing as there
are other things in that tree that need a build test.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7791.c                       | 2 +-
>  drivers/iio/trigger/iio-trig-hrtimer.c         | 2 +-
>  drivers/staging/iio/Documentation/overview.txt | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index abb2393926317087..70bfc41052db2740 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -444,5 +444,5 @@ static struct spi_driver ad7791_driver = {
>  module_spi_driver(ad7791_driver);
>  
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> -MODULE_DESCRIPTION("Analog Device AD7787/AD7788/AD7789/AD7790/AD7791 ADC driver");
> +MODULE_DESCRIPTION("Analog Devices AD7787/AD7788/AD7789/AD7790/AD7791 ADC driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> index a5e670726717f0d8..f59bf8d585866ea2 100644
> --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> @@ -4,7 +4,7 @@
>   *
>   * Copyright (C) Intuitive Aerial AB
>   * Written by Marten Svanfeldt, marten@intuitiveaerial.com
> - * Copyright (C) 2012, Analog Device Inc.
> + * Copyright (C) 2012, Analog Devices Inc.
>   *	Author: Lars-Peter Clausen <lars@metafoo.de>
>   * Copyright (C) 2015, Intel Corporation
>   */
> diff --git a/drivers/staging/iio/Documentation/overview.txt b/drivers/staging/iio/Documentation/overview.txt
> index 43f92b06bc3e5574..ebdc64f451d7c798 100644
> --- a/drivers/staging/iio/Documentation/overview.txt
> +++ b/drivers/staging/iio/Documentation/overview.txt
> @@ -34,7 +34,7 @@ turned on or off (if possible) via sysfs interfaces.
>  fifo / ring buffers on the sensor chip.  These greatly reduce the load
>  on the host CPU by buffering relatively large numbers of data samples
>  based on an internal sampling clock. Examples include VTI SCA3000
> -series and Analog Device ADXL345 accelerometers.  Each buffer supports
> +series and Analog Devices ADXL345 accelerometers.  Each buffer supports
>  polling to establish when data is available.
>  
>  * Trigger and software buffer support. In many data analysis

