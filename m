Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F078D525770
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 23:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358911AbiELVyw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 17:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359000AbiELVyh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 17:54:37 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDEC5839A
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 14:54:36 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2f83983782fso72140277b3.6
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1VU58MHQqP+/7H+d1w/E+L2ZvFeIXOvlm41/oypmL0=;
        b=sOYt/Gx0hkqvhlgblLEO/HYJxZTdK226ravqNQqKOZQ4UJ5y4ThWbN3ehEwwngDlYf
         11tzgbu0WDOYcy1r8mukQ0ovGT+JvnNid4hvM/mwJSBL9p6kxhhMPl1VxGiE1H/Brvx6
         sapouRkIaz3YQWLwT6VqH4XBSxiLo/uPAiRrSo/Sc0ntI2pRCWlzprmHwvostLXD2a1k
         qhLlOWMG5cY3OqsqNkLjwCh4XSsVHyjdQAiYDfTxJxahxf6nPPoJvTrjufeZHC9GpGfR
         af8bi9WIHNWL/KF5rHUcdbfZUiKC9vjY0PXp3N2S78bHVYiW6GXw6Cvfpo82kcxnTVm/
         Ec4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1VU58MHQqP+/7H+d1w/E+L2ZvFeIXOvlm41/oypmL0=;
        b=SnFnilFMTqqVQedwGUUCrhtVu/AJoHkHONJsV8Hnlj+tH7v3lb1DS6zySF1iIy4tYb
         elpPt+Lf21eKQ2KPT5lNcvGKjVd4adAVgMD0Y2GFyp6/fPmekJbJfUXKVBIt9CfSkMhr
         Wq0V/pwlkos6VDQ4ZwK53Gzp/e3NAcnepYW9HGXgvhjx+ekpuOkND7pUZtm69pyqYQ8y
         xraLCxqUj6U6q1ILjUzhKekA2siGhMEq2fA+N1FRE8l2DPCWtOtgiXGp2BcxQzbwpIcC
         p/UHZJzIW9d5lJUXT6twBQhnbPyL/oxxtne2Drv17eHqmrIbDqp2zm6EXCr4/VuWkq70
         NE2A==
X-Gm-Message-State: AOAM530uREoG7Or7di9FNPn2pEci8rKfCi4Oc5MrMc9i9ORprQLHIyLF
        TvHHvOgSrpgVj/xPjfDJTXLC8AmA0s5WV/GRj7F7pg==
X-Google-Smtp-Source: ABdhPJzvEO0jiVxrIG+1xE2X6cZ/BJG2CWgwTmUY1c9wQnpnOTd/I357N8dayLCf00VtX03B0P1jTijf3GPai6A5/ak=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr2377894ywd.118.1652392475988; Thu, 12
 May 2022 14:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com> <353023ba-d506-5d45-be68-df2025074ed6@kernel.org>
 <3ee366a7-e61f-e513-aa2f-12e8d5316f3c@embeddedor.com> <YmpedDjzZXz2t6NS@smile.fi.intel.com>
 <DA101ED8-F99F-4DCB-9CB7-370A62C44B65@linux.microsoft.com>
In-Reply-To: <DA101ED8-F99F-4DCB-9CB7-370A62C44B65@linux.microsoft.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 May 2022 23:54:23 +0200
Message-ID: <CACRpkdadjPn82G4TMKyyQtkju=oA4EX=GNxs8KRtrQ7CcqVOog@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        olivier.dautricourt@orolia.com, sr@denx.de,
        Vinod Koul <vkoul@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, ludovic.desroches@microchip.com,
        tudor.ambarus@microchip.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, wangzhou1@hisilicon.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com, afaerber@suse.de,
        mani@kernel.org, logang@deltatee.com, sanju.mehta@amd.com,
        daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, agross@kernel.org,
        bjorn.andersson@linaro.org, krzysztof.kozlowski@linaro.org,
        green.wan@sifive.com, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, patrice.chotard@foss.st.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 6, 2022 at 7:43 PM Allen Pais <apais@linux.microsoft.com> wrote:

>  - Concerns regarding throughput, would workqueues be as efficient as tasklets (Vinod)

You need to ask the scheduler people about this.

The workqueues goes deep into the scheduler and I can't make
out how they are prioritized, but they are certainly not treated
like any other task.

Yours,
Linus Walleij
