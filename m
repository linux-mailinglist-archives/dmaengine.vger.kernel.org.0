Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2FF3F0804
	for <lists+dmaengine@lfdr.de>; Wed, 18 Aug 2021 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbhHRP3H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Aug 2021 11:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbhHRP3H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Aug 2021 11:29:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876B7C061764;
        Wed, 18 Aug 2021 08:28:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l11so2022989plk.6;
        Wed, 18 Aug 2021 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dT+pL+9YhtUImpcGN/cKN8jzBfuzVCiFl8hmF6VGry0=;
        b=hD3mxBhnDdODBl5zrCmekRuyAN49XWYkOcgChl79sRL1WCPUAuS5sDnhh8IeB80ab9
         RhOqTw8wduv5KWLenIcV0a0/dMAHR+ewwJYm6xaZpKNA0rHrO7I9GxxJgBl9VgpeTqqT
         pw0eQQ+s2z4wz11RAu+nyA4UCDz4ooPceIeLdoVYki8A56TaRrjcsNVYt1EVoLLesx/9
         u6erXipMKMQkZa1UF3Ik568mL57hskgp8b4OMc/fkl5pT+C9wcE4kohy5Dtp/+hxFNr7
         EIHPWWjl8EUmlN3dUD5RLsV6BCSwrmy9vRhhEx7+SgLTfkwFHqwd1OujaiSGaK91V8Hb
         rn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dT+pL+9YhtUImpcGN/cKN8jzBfuzVCiFl8hmF6VGry0=;
        b=AtySR+V5gvPlj3XyXIXFgAUOyk51VvBWDymQdrvF8gAaVq2SuqzmU7fIKa8BXzOfCd
         B5X1+cs1nEM6/icKPG2zLGFKSuNSyajaixkfy5B1gBk2dvJukccVbX2cfenzM6+2HO9c
         n31dVhLewIwW4QM3vlXJn7fojEtToz07hPXN8h0bFfGMZbmtp+navo6EO7aV4oOGFZX+
         1I2zCUhsPd9C7dFI32+oRVLtAk+auD4eM+IPzafackJXtfjAlsN5lfsDL7K4LA2r83MC
         mp6ZTZXlq8BdYKCq7KiBV4yxMToxsRQCFJp5TAknU2DHPd8boAY29NjNov7Kvp1KMvS0
         KEPQ==
X-Gm-Message-State: AOAM532CYwBuiw1xLtI4D/Ff5wC9CtD+iZdIrJmFqoNG4Da5BSA+E4Mq
        HwH8u/56Nr14TTFGxfXIlLCDrl27MxqPNQidfY8=
X-Google-Smtp-Source: ABdhPJz37Yoh/AQvwctMhVs2WQyFUTaJPKB6tkwCcsPDUiRztdii+LOHXMP3q4VbsAXM9iNGkqkeUajI37fr6Cquw2E=
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id
 m1-20020a170902bb8100b0012da7ec3d85mr7739762pls.17.1629300511960; Wed, 18 Aug
 2021 08:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210818151315.9505-1-daniel.thompson@linaro.org> <20210818151315.9505-2-daniel.thompson@linaro.org>
In-Reply-To: <20210818151315.9505-2-daniel.thompson@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Aug 2021 18:27:52 +0300
Message-ID: <CAHp75VdDZJ+aUtx-A3y62WQ5+OtrS47Ts6PDe1bGQ0OcRRV+7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: dmaengine: Add a description of what
 dmatest does
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@linaro.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 18, 2021 at 6:15 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently it can difficult to determine what dmatest does without
> reading the source code. Let's add a description.
>
> The description is taken mostly from the patch header of
> commit 4a776f0aa922 ("dmatest: Simple DMA memcpy test client")
> although it has been edited and updated slightly.

> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

Not sure if you can use it like this (I mean the above SoB)
Otherwise it's a good idea, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  Documentation/driver-api/dmaengine/dmatest.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation/driver-api/dmaengine/dmatest.rst
> index ee268d445d38..529cc2cbbb1b 100644
> --- a/Documentation/driver-api/dmaengine/dmatest.rst
> +++ b/Documentation/driver-api/dmaengine/dmatest.rst
> @@ -6,6 +6,16 @@ Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>  This small document introduces how to test DMA drivers using dmatest module.
>
> +The dmatest module tests DMA memcpy, memset, XOR and RAID6 P+Q operations using
> +various lengths and various offsets into the source and destination buffers. It
> +will initialize both buffers with a repeatable pattern and verify that the DMA
> +engine copies the requested region and nothing more. It will also verify that
> +the bytes aren't swapped around, and that the source buffer isn't modified.
> +
> +The dmatest module can be configured to test a specific channel. It can also
> +test multiple channels at the same time, and it can start multiple threads
> +competing for the same channel.
> +
>  .. note::
>    The test suite works only on the channels that have at least one
>    capability of the following: DMA_MEMCPY (memory-to-memory), DMA_MEMSET
> --
> 2.30.2
>


-- 
With Best Regards,
Andy Shevchenko
