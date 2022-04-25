Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FCF50E403
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbiDYPKA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 11:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242734AbiDYPJ7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 11:09:59 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422D606FF
        for <dmaengine@vger.kernel.org>; Mon, 25 Apr 2022 08:06:56 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2f7ca2ce255so52124747b3.7
        for <dmaengine@vger.kernel.org>; Mon, 25 Apr 2022 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqiODolKDwfyRALQlYWQcszGWRFH6z+IxhiKOhDhTFo=;
        b=HG1YlSO8m3GLToDGvpIw/Zvu2U9nZ5SndeRDDJRZzwhTyGyEpMsAxW5XPxX3IOWTRs
         mGvIVPSDaRHy3QTsHxyXTARve8aN2WtIy6ova2yzzY8yBXooOL/eJBy9rlWHhiXosZjo
         aMGBCzSNe6GgdoMJQ+aAeYOwvM6Xz2h5Xr2NDt6h4EsVuLdOcc9IAGHXNWJ6LE2+8cjT
         ieq+gd2dQVwDMzWSbvHmF1Rq1dPImaQVS9oV3TeJoDvXhzEDK0IGEYuai6dJBHbdsHa7
         6ifG5Hd1qIJvMevVQy9ygMtTboxW3zHpSvK+ldc5jOgaMmF+oBehT404iwlLts1OYMkU
         F/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqiODolKDwfyRALQlYWQcszGWRFH6z+IxhiKOhDhTFo=;
        b=dtSfCGITUR0XqvuiysBb5UHy+sZvEIAaXzFlY7rjFMIx874phwJeDn9SAahwbeCd/N
         QoXfqrTFtOQd5lh1v3V62uDR1QNMCP+TX4sxkixAXf8ntDw4+n4eqBK5d6ORxsz9DwcU
         UCTOtt79oqBMPGvlfOUdpeP6t30kc6lnx2red5dyzVWCa6cFdwSpPaii5EwRYWy/gnyk
         JEwXma0bXMu3NTJMvv5Gv7PhPbAU5OYYnLV7yM64NmS6nGnuc0CP8CZG8wQz46fMalC3
         3HTgWvMaYN1MBVefQTDKRUR8gnP7NCDFq5ANStjP5pijhtgBqt6JLbw+9bjAEqyV/Q0u
         DGVw==
X-Gm-Message-State: AOAM5337pEFFA4rf+jllc5zguwAexNHhqHS6q1AlgAxaHwbTRHTk3W8U
        SzaD//VQ2F6uGm7aHq7dZyPYAVxvzLYL79mjCr6VKA==
X-Google-Smtp-Source: ABdhPJwTVuRcAfvc1fO1xeG98w40wfDx7OdmNy1nAU7g1tneXxN06QNrYfNTjYzGAMDWsyK50c82G3B9eEZZeRy29HU=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr16690680ywd.118.1650899212383; Mon, 25
 Apr 2022 08:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com> <20220419211658.11403-2-apais@linux.microsoft.com>
In-Reply-To: <20220419211658.11403-2-apais@linux.microsoft.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Apr 2022 17:06:40 +0200
Message-ID: <CACRpkdZz_JGGCv74gQYKMq5fdHLo_6jFuJ2uh8N9Q1VG5+kCFw@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     olivier.dautricourt@orolia.com, sr@denx.de, vkoul@kernel.org,
        keescook@chromium.org, linux-hardening@vger.kernel.org,
        ludovic.desroches@microchip.com, tudor.ambarus@microchip.com,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        andriy.shevchenko@linux.intel.com, leoyang.li@nxp.com,
        zw@zh-kernel.org, wangzhou1@hisilicon.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, afaerber@suse.de, mani@kernel.org,
        logang@deltatee.com, sanju.mehta@amd.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        agross@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, green.wan@sifive.com,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        patrice.chotard@foss.st.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 19, 2022 at 11:17 PM Allen Pais <apais@linux.microsoft.com> wrote:

> The tasklet is an old API which will be deprecated, workqueue API
> cab be used instead of them.
>
> This patch replaces the tasklet usage in drivers/dma/* with a
> simple work.
>
> Github: https://github.com/KSPP/linux/issues/94
>
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>

Booted on:

>  drivers/dma/ste_dma40.c                       | 17 ++++-----

This DMA-controller with no regressions:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Also looks good so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
