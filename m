Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324744F179B
	for <lists+dmaengine@lfdr.de>; Mon,  4 Apr 2022 16:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351106AbiDDOvk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 4 Apr 2022 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378353AbiDDOvY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Apr 2022 10:51:24 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDAB22285;
        Mon,  4 Apr 2022 07:49:12 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id d142so7805796qkc.4;
        Mon, 04 Apr 2022 07:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HPLACUw9G8R/RifzEuAaAYaQrT5woDu89AJlFDXCoc0=;
        b=LLTe/xMSSMz7emSpjugN1HlzdCr76lqcdQZ6DI7sroXvuoSVfAQgwcMkkor8Q8VQHJ
         yW3KuG7TCUAYO7hjLHRjF7sMOw0oqJRY2ie2NbBmEgoNeS7nOeyiHrDW4oIMoT3dUV2i
         MJMzYjK3OxybSYbudutv5mIFIEQEfZabW0xu4Wc0eNFP1zR7EkXKwVDPWo5mFwnKSS+L
         LjLIj1PsavjDEhmMbcxma25uaj7WXod4IxCrLR0WTDHxCpl4/fi1lLAH/S+fHxGAiAUJ
         J1E+ic0R+WgRqnUGNNdztjvwjUozGN/aBljAoiDJK4HWVQ/WMgyUpNSl8elmeJ4fYyDJ
         B9Xw==
X-Gm-Message-State: AOAM530ZPHklV7elzWJrmrwCkmCqyrjx1S0ISAwl2H/TkQsvzUEH9FCW
        a36df7c4O4MA33/8KOjndGSx3ee6xHgDsw==
X-Google-Smtp-Source: ABdhPJzXnwykIXQAw20gg3lBmiOcThREHssWS6JwnY/E8o3etOHBrbAeMkY+xAOF5yh3NTKLtm0COA==
X-Received: by 2002:a05:620a:2904:b0:67d:db5a:b27f with SMTP id m4-20020a05620a290400b0067ddb5ab27fmr59738qkp.529.1649083751668;
        Mon, 04 Apr 2022 07:49:11 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a29cf00b00680ca4b3755sm7122030qkp.119.2022.04.04.07.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 07:49:10 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2e64a6b20eeso102344287b3.3;
        Mon, 04 Apr 2022 07:49:10 -0700 (PDT)
X-Received: by 2002:a81:5c2:0:b0:2e5:e4eb:c3e7 with SMTP id
 185-20020a8105c2000000b002e5e4ebc3e7mr305576ywf.62.1649083750254; Mon, 04 Apr
 2022 07:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220404133904.1296258-1-miquel.raynal@bootlin.com>
In-Reply-To: <20220404133904.1296258-1-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Apr 2022 16:48:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWS0ABggEuyqjzuX1Jp306p6FOj_uvPuHW1Z63Ov551+Q@mail.gmail.com>
Message-ID: <CAMuHMdWS0ABggEuyqjzuX1Jp306p6FOj_uvPuHW1Z63Ov551+Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] RZN1 DMA support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

On Mon, Apr 4, 2022 at 3:39 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> Here is a first series bringing DMA support to RZN1 platforms. Soon a
> second series will come with changes made to the UART controller
> driver, in order to interact with the RZN1 DMA controller.
>
> Stephen acked the sysctrl patch (in the clk driver) but somehow I feel
> like it would be good to have this patch applied on both sides
> (dmaengine and clk) because more changes will depend on the addition of
> this helper, that are not related to DMA at all. I'll let you folks
> figure out what is best.
>
> Cheers,
> Miquèl
>
> Changes in v6:
> * Added Stephen's acks.

Looks like you forgot to add the ack?

> * Fixed an extra newline added in the middle of nowhere.
> * Rebased on top of v5.18-rc1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
