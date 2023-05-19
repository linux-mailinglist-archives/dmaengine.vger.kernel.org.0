Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BDB7092C0
	for <lists+dmaengine@lfdr.de>; Fri, 19 May 2023 11:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjESJLK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 May 2023 05:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjESJK5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 May 2023 05:10:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA52B1BDB
        for <dmaengine@vger.kernel.org>; Fri, 19 May 2023 02:10:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3078c092056so1983074f8f.1
        for <dmaengine@vger.kernel.org>; Fri, 19 May 2023 02:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684487433; x=1687079433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4PUn3laZkjlv9r91VlagRE7SeQ4y7zfvRtcaATbBto=;
        b=tPPNaiTO8lJ5jKQV6OBH0hubdfYT6e0g5een+CNh5ZVnoqtMivb80X9jt62BmL7Ntc
         JmDTguBRtWeMmeWge9aFO2HntpQSdodBZm/+Bk5lRIzSoCNh6vAi8eupqFAh9LXyq/av
         mqb/xGE2oU0pXdzRbXi6jBqk9jQj2FCBBKMSVhMYeAHY7KTU9fNZZweDD4jivvMWtQrj
         OENV18nIItD13qed13rPXMEVGHvBz7PVZ5m4CA4oa5LRABnMxGoPL0J7t8A0zq94JhVp
         hXc9a81Ra8u+zRHvw9la+GPmwDtH70uD0C2A8Dgcu+vmuDYVDVWK0L5Gt0RgSYf0hcyL
         pd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684487433; x=1687079433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4PUn3laZkjlv9r91VlagRE7SeQ4y7zfvRtcaATbBto=;
        b=MqVglmPsVzFrH+w6RXYVx2qapqIIpY/IZ8i//mqOIM1MMbGkMUJtFKVx15r8nBG/bD
         CoC3KlhbpFTgqhpG0kOszPHcQL8B1Kt04FtDfhaMvF+jE55LZQXTtjlgGu04PZ+0mDPi
         x9Ne333oyvgswXUD0nA2I5xY5Ly2s00aXkiH/o7mmT/AWcffshKceclDEd/NjTQaIvTe
         ZZg7j1/eFbYt53CPCGYiYxfgR3KUVRWwnWyscPQJ6dXx/rkyITI2UwJf4zCvQmrhZgJl
         gA9YY+XhFLQRLeOxX3/AbODzaUePttL+2o2aLEsoPX7aq7xDWVRBWSFw+xkGAFLk/VHK
         5LUA==
X-Gm-Message-State: AC+VfDy0rAI4O2RvE/na5rCcGkjyRKNRYiGqo0uPNF7DRqyIYlJAmarL
        gsJGa7QmTG1z1L1n0Iqw8m3FnLQW2uHpQ3xS4sztMw==
X-Google-Smtp-Source: ACHHUZ6Ls/fxuZgcyZ694cYOnC1gqFmjt2rYX4qoLImFgpcP92r4Yt0cObiHBFfjDzWMPfy6SRBwmNGjFRTCq9koXeo=
X-Received: by 2002:a5d:6388:0:b0:309:492a:bb07 with SMTP id
 p8-20020a5d6388000000b00309492abb07mr1162243wru.26.1684487432711; Fri, 19 May
 2023 02:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230518-bamclk-dt-v1-1-82f738c897d9@gerhold.net>
 <CAH=2Ntya7bqHVri_F8BOUJ6kJxtG2_usV08do+=OgkaoVJvxBQ@mail.gmail.com> <ZGYKQkgRrBqO2rsx@gerhold.net>
In-Reply-To: <ZGYKQkgRrBqO2rsx@gerhold.net>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 19 May 2023 14:40:21 +0530
Message-ID: <CAH=2Ntw0BZH=RGp14mYLhX7D6jV5O5eDKRQbby=uCy85xMDU_g@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: make channels/EEs optional in
 DT with clock
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 18 May 2023 at 16:51, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Thu, May 18, 2023 at 04:43:57PM +0530, Bhupesh Sharma wrote:
> > On Thu, 18 May 2023 at 14:56, Stephan Gerhold <stephan@gerhold.net> wrote:
> > >
> > > If we have a BAM clock in the DT we are able to turn on the BAM
> > > controller while probing, so there is no need to read "num-channels"
> > > and "qcom,num-ees" from the DT. It can be read more accurately directly
> > > from the identification registers of the BAM.
> > >
> > > This simplifies setting up typical controlled-remotely BAM DMAs in the
> > > DT that can be turned on via a clock (e.g. the BLSP DMA).
> >
> > Can you please list which qcom board(s) you tested this patch on?
> >
>
> It works fine at least on MSM8916/DB410c (for blsp_dma) and MDM9607
> (blsp_dma and qpic_dma (for NAND)). More testing would be much
> appreciated of course!

I tested this yesterday on RB1/RB2, RB5 and saw no improvement, so was wondering
why exactly is this needed and which platforms are impacted.

> Personally I don't see much of a risk: If enabling the clock doesn't
> actually enable the BAM controller, then the clock probably does not
> belong to the BAM in the first place... :)

Right, but I think the commit message needs a bit more clarity to
reflect that it is now proposed to check for the bam_clk presence
earlier in the _probe flow (as compared to earlier).

Thanks.
