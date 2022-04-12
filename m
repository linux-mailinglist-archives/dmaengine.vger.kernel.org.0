Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784BC4FDB6F
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 12:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbiDLKDk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 06:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385668AbiDLIw2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 04:52:28 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7176764710;
        Tue, 12 Apr 2022 01:12:55 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id d71so4989105qkg.12;
        Tue, 12 Apr 2022 01:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnqEEZ1zFWnMJmtyNXblrY5MQvtZ5RBg/IUnGVTe7nE=;
        b=FaAqLTPeR8zQW28ZYZCMsxHJuewq63COHX12yxCzeSPASMWiVkxApRM3Q3N9L+L4gq
         SwzrLNp28g8Fza8b7iA+Bn806a+TLVhbGXjg3G3nFx1qgsUVaLdyMT962s8VxEpvMgpV
         SuX5jB4EGecuEgxRLSVOjIgbzaO85PELkhf9gx8d9We0r15ZopzQxn6RpcipRcYZggek
         sFr+ZYnsgu9W2jkkBhPYaasyV4a/6H7uRSt1oza4W4q+LHlDE0JDLuT67NtRSeiRT6KT
         AN1qgmi9qBQfCayw1HNgK08q+k+nq+lJ72v8TAvVFM4DghVj8v3GOssu3pxP4uijJwjz
         ZuSA==
X-Gm-Message-State: AOAM5311HGp/B+P25j7ipmDN3k7bSZL578NQ/EmMqkJpotTwPBbMD+YF
        e/jtqM4spaOz2upd1PUWuLR4vffv/g8R4hXt
X-Google-Smtp-Source: ABdhPJyRBsmcscwkqiImLbeE05pXeu7rnAt4FYsRfXBmLtITfkTGWrMy+PSIdz+V0vv2MKO7WXgsJQ==
X-Received: by 2002:a37:a897:0:b0:69c:329:2310 with SMTP id r145-20020a37a897000000b0069c03292310mr2241446qke.349.1649751174055;
        Tue, 12 Apr 2022 01:12:54 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm23923536qtp.30.2022.04.12.01.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:12:53 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id p65so13523245ybp.9;
        Tue, 12 Apr 2022 01:12:53 -0700 (PDT)
X-Received: by 2002:a25:2c89:0:b0:641:2884:b52e with SMTP id
 s131-20020a252c89000000b006412884b52emr9459376ybs.506.1649751173092; Tue, 12
 Apr 2022 01:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
 <20220407004511.3A6D1C385A3@smtp.kernel.org> <20220407101605.7d2a17cc@xps13>
 <CAMuHMdUZFTm+0NFLUFoXT7ujtxDot_Y+gya9ETK1FOai2MXfvA@mail.gmail.com>
 <20220412093155.090de9d6@xps13> <CAMuHMdVpfHuJi1+bm2jvsz8ZpMn8u=5bNYqHBRv7DYykyrC-XQ@mail.gmail.com>
 <20220412094338.382e8754@xps13> <CAMuHMdVaWskmiqUEyGyz7HKUjgzFhx+5hAJxd5od7Hp4hFD1KA@mail.gmail.com>
 <20220412100301.03ccece8@xps13>
In-Reply-To: <20220412100301.03ccece8@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 10:12:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPRb0SiCtYcqAy5YJEGp3U30FaXcmjMpgc=szXUnShpA@mail.gmail.com>
Message-ID: <CAMuHMdXPRb0SiCtYcqAy5YJEGp3U30FaXcmjMpgc=szXUnShpA@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] RZN1 DMA support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Apr 12, 2022 at 10:03 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> geert@linux-m68k.org wrote on Tue, 12 Apr 2022 09:52:25 +0200:
> > On Tue, Apr 12, 2022 at 9:43 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > geert@linux-m68k.org wrote on Tue, 12 Apr 2022 09:37:22 +0200:
> > > > So far I've been rather terse in giving feedback on these series,
> > > > as I'm in wait-and-see mode w.r.t. what else you've planned for the
> > > > sysctrl DT node[1] and clock/sys controller code...
> > > >
> > > > [1] Did I say I'm not that fond of child nodes? But for the dmamux,
> > > >     it looks like a good solution to handle this.
> > >
> > > O:-)
> > >
> > > I plan in the coming days to write a proper reset controller driver
> > > that will be queried by the rtc driver (as proposed by Alexandre).
> >
> > OK.
> >
> > > Which means I'll have to declare this reset controller as a child of
> > > the systrl node. If you disagree with it, you may jump-in, see this
> > > thread :
> > >
> > >         Subject: Re: [PATCH 2/7] soc: renesas: rzn1-sysc: Export a
> > >                  function to  enable/disable the RTC
> > >         Date: Wed, 6 Apr 2022 10:32:31 +0200
> >
> > But do you need a child node for that? All(most all) other Renesas
> > clock drivers provide reset functionality, and none of them use a
> > child node for that.
>
> How do you "request" the reset handle from the consumer driver if it's
> not described in the DT? Do you have examples to share?

I didn't say it does not need to be described in DT ;-)

Just add "#reset-cells = <1>" to the sysctrl node, and nodes can
start referring to it using "resets = <&sysctrl N>".
Currently, the sysctrl node is already a clock and power-domain provider.

Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml
shows an R-Car CPG/MSSR node providing clock, power-domain, and
reset functionalities.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
