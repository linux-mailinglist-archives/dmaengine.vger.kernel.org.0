Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDCE5FA46F
	for <lists+dmaengine@lfdr.de>; Mon, 10 Oct 2022 22:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJJUAg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Oct 2022 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJJUAf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Oct 2022 16:00:35 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D0065802;
        Mon, 10 Oct 2022 13:00:31 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id q11so6151266ilj.10;
        Mon, 10 Oct 2022 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EEFmiFJ7Dw1gVqlSeptMmfCFB7n+NWN+0z+4deZp3HU=;
        b=NLddd3v+0tKtp6cmtm2QqhHh1h2elNdUINa2PSf7HuXdoxWcN5g9mdAiQ0u8E6eslT
         /dNnyFilX3We6S7g1+yw9XlSqlKKQkSTx4TQHAKHQAaDTfG74ZqvBjY9XRnwwrMSCYUV
         Rj84pKkSB2ph6kUlrYBGpkwFGhB3qzaXqw/+guUMUOvl9po5tAMX0Z5RTBhieOo9/Xx0
         OnoKSV2S+hLhG912NLjqfe95ZvnCOn4OBINluIcQuWmQT31lt5rn8p7vgEkbiXeg8ZVH
         JLwdFEquBeZgd8pvVMMOticXlsgeKc2a38qyXOeisyCKeb0SR7dVZTQotJUpYxmd7yPv
         PM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEFmiFJ7Dw1gVqlSeptMmfCFB7n+NWN+0z+4deZp3HU=;
        b=69XfmiIu/k7SZ8i28R+KlyVAgiWHUj/mVDf1uY52YvcWp83s6IfcKAZIeodXnaiiPp
         yvkWHgd6rJs/elP25TU98tApUVD1n+TFhWH+Q3oI4+6R6gyyuQFVdPmKEdDmt7UBMMm0
         9Fr6tlEwndElYtBestDXahHtc0Alfk/pCOUNRIUdx2O1GuOO7zPxZlLVDIvb+8WEmW2G
         Fp8GOZfanRwN7+PcI3k9gHFvCCRfBp4TtsYG63TLmvyISgE8w11EuseJ6sR06k6AI3/f
         nxtMiynLzBcHocYj7da8eUDSFkzFkXbTCOZDbCh5Q4qQuaxjBAWlMYAiEhFbJfJOP4rX
         immQ==
X-Gm-Message-State: ACrzQf21IwM0+a5WxidY8ZP7CD98jEuoF/9K6ghSw7SIcHehoaXqPVo2
        2SO3iKuiHs9LvBJfwvNXHREfiKSKwlv/yT962oDTJkwm6QLivhnp
X-Google-Smtp-Source: AMsMyM4IOC+JUIyA9Rgli9LM7FUiqfPhAbQIr549hOWE+uF2Y0x1wXn+Hc2yPwnDnz9Ies/eixMujgupBC0XjftOofs=
X-Received: by 2002:a05:6e02:20ea:b0:2fc:318b:a952 with SMTP id
 q10-20020a056e0220ea00b002fc318ba952mr3875846ilv.236.1665432029905; Mon, 10
 Oct 2022 13:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221009181338.2896660-1-lis8215@gmail.com> <20221009181338.2896660-9-lis8215@gmail.com>
 <2e89fc3a-bc54-17e7-d352-25db877172ff@linaro.org>
In-Reply-To: <2e89fc3a-bc54-17e7-d352-25db877172ff@linaro.org>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Mon, 10 Oct 2022 23:00:18 +0300
Message-ID: <CAKNVLfZ4zPdhv=zJOcDk_hnVVoU51L8uAsoXEmzJpecsyc5KmQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] MIPS: DTS: Ingenic: Add support for the JZ4755 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> How do you build it? How do you test it? It's basically non-compillable,
> dead code. You need a board.

I tested it on a Ritmix RZX-50 handheld, although this patchset doesn't
include it as it requires many other changes to be fully functional.
I decided to do this in two steps: add platform first (this patchset) then
specific drivers and quirks, in the next patchset, when this one passes.

Of course I can add machine's dts with working parts. What's the usual way?
