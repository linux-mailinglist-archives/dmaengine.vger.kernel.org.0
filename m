Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574265339DE
	for <lists+dmaengine@lfdr.de>; Wed, 25 May 2022 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiEYJZG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 May 2022 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbiEYJZB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 May 2022 05:25:01 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3888A302
        for <dmaengine@vger.kernel.org>; Wed, 25 May 2022 02:24:59 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id q184so6374163ybg.11
        for <dmaengine@vger.kernel.org>; Wed, 25 May 2022 02:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8v8NJ0a8V56vtqLR+SMp9QvjOrvgB+9HAIgTvz0fNJo=;
        b=dYJhLfBDjkkwdtL7D9ZCvH/HwdunUkHDymiQT/6fOkGfUlgVU79wfDNeKi1FmvO01+
         sYziFA2LOGAfhRqoHeA2iY+WYLDKijMRBXtk7C9/myzGSV/1yBTPtk6tY5yr6aZknMvq
         iLgkfAtv9jdC0BFti5DSakNtV6dFv7VSLlkUS50I4bWqisejUClMiEswT8RJnSp4VZ+c
         2e9Ew7kGjVu2lxGwPu5u5kCugna04xaGgXoBapEPsQM2HR7+zNeTZgGbmlfgei/SwXVk
         N9y954AfWXnR9J/RQcoJWVcEZsWkqX5qXN+67MuuLLVyBMM5P2KSSCGz8fI/ZDbWqiAr
         CxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8v8NJ0a8V56vtqLR+SMp9QvjOrvgB+9HAIgTvz0fNJo=;
        b=QoL4idP214wfgVZvVCadIHJxQj1k68yXVIJARDtqnDfXIDgeWM96yIIGlBcl28wJ1h
         IeUzbNTcGydFeBdMMOKqF6yJ2NbLjiZxhlK+KKpsi3tyn41+naw0/xjC7t7fggfAFkye
         WN39o/ooT4w00kZmuZwLAhfsWIYW80dRVgC5YwRtfGl1KwHsnJhV88K9fS/1YKWj4p3U
         YR+1k/seFX+D6I8yZ8ShmnWQH1Lz4lkK4z6Gzb1We29dBCs6PlMGzdXMtLEUR7wakj38
         SKIvOeV/bPYLvcKBVRQ40otBYaU0LrQVrjXtR3kKbvrTgk2k5vCxqVRN2sYiG7RC7fyi
         JGIA==
X-Gm-Message-State: AOAM533SmZT7+RbfxSHvVAX2iSeQkgsOdFO2wkumFOe/VSR6U5NanlK7
        RS3k7tvDsp/xFPCNh2+ZAJT4rHix5UmvimlimbTIpw==
X-Google-Smtp-Source: ABdhPJyTI8yw+M0YzU0THJ1vYh5OzrMdzgHpVAzvdG4RReWcEDTXHjPdRmztzhwlqmxghfm1UKDV/wUEiUYjP8kA62g=
X-Received: by 2002:a25:420e:0:b0:655:8817:e6ba with SMTP id
 p14-20020a25420e000000b006558817e6bamr3360166yba.369.1653470698888; Wed, 25
 May 2022 02:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com> <20220419211658.11403-2-apais@linux.microsoft.com>
In-Reply-To: <20220419211658.11403-2-apais@linux.microsoft.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 May 2022 11:24:46 +0200
Message-ID: <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Allen Pais <apais@linux.microsoft.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Paging Vincent Guittot and Arnd Bergmann on the following question
on this patch set:

- Will replacing tasklets with workque like this negatively impact the
  performance on DMA engine bottom halves?

For reference:
https://lore.kernel.org/dmaengine/YoI4J8taHehMpjFj@matsya/

Yours,
Linus Walleij
