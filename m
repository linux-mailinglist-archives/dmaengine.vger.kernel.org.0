Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F1E751AD2
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jul 2023 10:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjGMIIv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Thu, 13 Jul 2023 04:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjGMIIS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Jul 2023 04:08:18 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76723AB3;
        Thu, 13 Jul 2023 01:05:56 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bff27026cb0so381092276.1;
        Thu, 13 Jul 2023 01:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689235252; x=1691827252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4q6Dp1a5ZPR38LPAzFTuFEyWMCfsyFFquI2ZhIpkvY=;
        b=B/lj+2o42JAv3JsGI692a1ka/zv9clB1OjCkm6/8l8jGcU6zfCSd18SavbufYi58U5
         XWB7fMcyiBiPb8+GxiOZf3BA57S10rbqdY+rxSi1Os91B0MWu2Bdzde1NmybMB3Fab3b
         Sxeoo8YZfQEaqzbz2X1A1nKqQnIsSEFMgxED79AfgtE1i88oysH3qdv8ZG5qJTzJTqGs
         Hi4mHccqIQxCGqY6xWk9RDWUqAmq1mNc/iErPeD68AV+ru9B/r7o7rirp45KVct66gIy
         qeJ0hkiLvF0v+gVlPLdFWNO9SS+UPWOoPWa7abR23vs7bN0TAzbCm7P38gAdVYYasL8w
         c1dA==
X-Gm-Message-State: ABy/qLbiLkOCoTgphdc49laBklhVLoNHyuAK/KlyuVVTGjUyfF83vrjU
        k8ljMBoEgnXFONYZ6XrCTeI7fDP+HRcYT6Ql
X-Google-Smtp-Source: APBJJlFPvPGB407G/vKiABXt8xkOSY6tb2cMiLPtL0GI6hj6OTBl+w2Hlr8Ng6k2HnOgFRjTdHfrEA==
X-Received: by 2002:a0d:db4e:0:b0:577:18a9:fde9 with SMTP id d75-20020a0ddb4e000000b0057718a9fde9mr1072357ywe.43.1689235251802;
        Thu, 13 Jul 2023 01:00:51 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id c11-20020a81df0b000000b0054fba955474sm1637948ywn.17.2023.07.13.01.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 01:00:51 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so374156276.3;
        Thu, 13 Jul 2023 01:00:51 -0700 (PDT)
X-Received: by 2002:a25:2fd5:0:b0:c70:d138:51b2 with SMTP id
 v204-20020a252fd5000000b00c70d13851b2mr778725ybv.25.1689235251043; Thu, 13
 Jul 2023 01:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230705081856.13734-1-frank.li@vivo.com> <168909383153.208679.15343948792914219046.b4-ty@kernel.org>
 <c3373ebe-2f52-bed7-7f59-98e1268c9af2@linux-m68k.org> <ZK6O2b88Nz6J2JeN@matsya>
In-Reply-To: <ZK6O2b88Nz6J2JeN@matsya>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Jul 2023 10:00:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXiyk6NSGJWwby9VoP98=g0xu-SRAkDtxYqA-DcnOLmrQ@mail.gmail.com>
Message-ID: <CAMuHMdXiyk6NSGJWwby9VoP98=g0xu-SRAkDtxYqA-DcnOLmrQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dmaengine: qcom: gpi: Use devm_platform_get_and_ioremap_resource()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Wed, Jul 12, 2023 at 1:30 PM Vinod Koul <vkoul@kernel.org> wrote:
> On 12-07-23, 11:33, Geert Uytterhoeven wrote:
> > On Tue, 11 Jul 2023, Vinod Koul wrote:
> > > On Wed, 05 Jul 2023 16:18:52 +0800, Yangtao Li wrote:
> > > > Convert platform_get_resource(), devm_ioremap_resource() to a single
> > > > call to devm_platform_get_and_ioremap_resource(), as this is exactly
> > > > what this function does.
> > >
> > > Applied, thanks!
> > >
> > > [1/5] dmaengine: qcom: gpi: Use devm_platform_get_and_ioremap_resource()
> > >      commit: d9313d9f1fbc14cae5147c5130bea54aa76ad65f
> > > [2/5] dmaengine: qcom_hidma: Use devm_platform_get_and_ioremap_resource()
> > >      commit: a189107deb574fd08018bbf2fe5cd86450a54b13
> > > [3/5] dmaengine: qcom: hidma_mgmt: Use devm_platform_get_and_ioremap_resource()
> > >      commit: fe6c2622473f3756a09bd6c42cffca6fbdce391c
> > > [4/5] dmaengine: shdmac: Convert to devm_platform_ioremap_resource()
> > >      commit: 0976421c5a339b1b1a89cfba4471a6de761130ed
> > > [5/5] dmaengine: stm32-dma: Use devm_platform_get_and_ioremap_resource()
> > >      commit: b402a7eeaa35aaa3300a4ba6bd5b381112ae183c
> >
> > I noticed all your new dmaengine[1] and phy[2] commits contain a
> > "Message-ID:" tag.  Presumable you added a git hook for that?
>
> Thanks for pointing that out, yes something is messed up for me.
>
> > However, the standard way is to add a Link: tag pointing to lore
> > instead, cfr. [3].
>
> Yep and if you look at the dmaengine and phy commits for 6.4 they have
> "Link" in them, so something is not working, let me fix that up.

Sorry, hadn't noticed that, so I assumed you were a new user ;-)

I saw you have already updated your branches, but FTR, the issue
was caused by a new version of git, which broke the hook, cfr. commit
2bb19e740e9b3eb4 ("Documentation: update git configuration for Link:
tag") in v6.5-rc1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
