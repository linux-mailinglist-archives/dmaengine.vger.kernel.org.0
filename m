Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A06A489565
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 10:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243073AbiAJJif (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 04:38:35 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:46617 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243013AbiAJJhr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jan 2022 04:37:47 -0500
Received: by mail-ua1-f44.google.com with SMTP id c36so22168734uae.13;
        Mon, 10 Jan 2022 01:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/pM3c1SFKFjtAgn2YoWQjOqoUrdt4rA6OqWZn+r53Q=;
        b=zVAFFS8k0G0LcoLOI2nBgQsmKaWfrJFtXAchUPOK8b307smxV0RdRcYwfvOacW+aB5
         VoLOdfcq1lUxm0+cU1EMf2ts6Y061yEJfP3XrYwkDXCLf81mq1TnKUa8JnFeZybmaZi+
         qL4tdUsMQ7lJU5ZynsUxl+OcgZOUdzyS665E4Q+1vpmLo9PmZPHuvxSE4j3LlUUIpnef
         oP3eHENb+IUinp7OBfrl5kj40mgqBdnIqg8/uJXjf8Wa1zKP0aGcOfCWsc5f71ev5QAH
         wA52GlRDSjmTgBqZlI5Y+LgffDfJNZme8M6dIJoui636oqpYMsYpAI9wzerDbNuXBLPA
         ulfA==
X-Gm-Message-State: AOAM532MaE1S5qgQqbP+CrMW+nQYviBPXjU4oBUOMiZmbh3ZWA0/Cnhg
        HOR0mbJxb/zTkxroeOECEGHcznaBokBmgA==
X-Google-Smtp-Source: ABdhPJyNsiv0ZUAZtHM+U4zL8TQqL/8r+V1FcxVYVGkTLf0qQ2SypDYTs+PSWY/ew+heiouu8hWdnA==
X-Received: by 2002:a05:6102:3e94:: with SMTP id m20mr4352562vsv.13.1641807466257;
        Mon, 10 Jan 2022 01:37:46 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id k28sm1548350vkn.46.2022.01.10.01.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 01:37:45 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id m90so7021754uam.2;
        Mon, 10 Jan 2022 01:37:45 -0800 (PST)
X-Received: by 2002:ab0:4d5a:: with SMTP id k26mr17506505uag.122.1641807465227;
 Mon, 10 Jan 2022 01:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20220106030939.2644320-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220106030939.2644320-1-jiasheng@iscas.ac.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 10:37:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWt0dWaP7Yz7CPD-ytfrCSOb4gOqp58tT+9SzNMWBqWHA@mail.gmail.com>
Message-ID: <CAMuHMdWt0dWaP7Yz7CPD-ytfrCSOb4gOqp58tT+9SzNMWBqWHA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: rcar-dmac: Check for error num after
 setting mask
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Vinod <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zou Wei <zou_wei@huawei.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jiasheng,

On Thu, Jan 6, 2022 at 4:09 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
> Because of the possible failure of the dma_supported(), the
> dma_set_mask_and_coherent() may return error num.
> Therefore, it should be better to check it and return the error if
> fails.
>
> Fixes: dc312349e875 ("dmaengine: rcar-dmac: Widen DMA mask to 40 bits")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1869,7 +1869,9 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>         dmac->dev = &pdev->dev;
>         platform_set_drvdata(pdev, dmac);
>         dma_set_max_seg_size(dmac->dev, RCAR_DMATCR_MASK);

dma_set_max_seg_size() can fail, too.

> -       dma_set_mask_and_coherent(dmac->dev, DMA_BIT_MASK(40));
> +       ret = dma_set_mask_and_coherent(dmac->dev, DMA_BIT_MASK(40));
> +       if (ret)
> +               return ret;
>
>         ret = rcar_dmac_parse_of(&pdev->dev, dmac);
>         if (ret < 0)
> --
> 2.25.1
>


--
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
