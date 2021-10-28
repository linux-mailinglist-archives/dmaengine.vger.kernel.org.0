Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD743DBD2
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 09:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhJ1HVY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 03:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhJ1HVY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Oct 2021 03:21:24 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95163C061767
        for <dmaengine@vger.kernel.org>; Thu, 28 Oct 2021 00:18:57 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so7391866ott.2
        for <dmaengine@vger.kernel.org>; Thu, 28 Oct 2021 00:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyqCq2t4o73sS9auTSwS2zR2Aay8fzrOFsH/pDZ5BrU=;
        b=jIqV7VBIVxnQMFYiJMAQqmcStUoqGgwunhx8d24sTqGnbDI0prYhYpCAS0xdfFMk1N
         VDyUL17EmtS46h9z/gG4+ce3a/bqioOcYt94Y/Y2jVUN5twCvUGOh6uqkMK0DJcxSQm8
         eh2dYCDn4LiLxvFliJNFF4poqvroTPjsIGe1ch5SSuwpwmbjVQs50egNNYjRMc5wV3MB
         UgJ4dZ54et6qY8NTRENm3aTOhQEwV73w2jNFlWZ8jUzZ2ZKIWd/ZFoq+PRHt7py9vdHm
         MrVHwfk0pIXdVIX3LbnZC9IqDcb+Wwb5dyycqh22RXa5ZZJn8tbm/FL6gpLjQ2BejEiX
         ACnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyqCq2t4o73sS9auTSwS2zR2Aay8fzrOFsH/pDZ5BrU=;
        b=oQC5nHxcXM1Fu9fwEZ5ffyu3oJYLH5LqEsiGSh/2dSkjxwSkGd6dYaiazmdSqTU9EE
         6t925hsdQsmPChGXzN3NGrut/PmbI6pqbv1J12yFiD7WIJlryv6MpmLdkrxXBvOD39y7
         wNcV3zYGsANbCxL4DFVk/S7fW6KOBhlmImTr1L6gTkzEgiFenf/rC/vdix7cmgzuuU41
         Yf44YQLldG8FOfjwJSCAW1oeHCboZmyXXTwsJgD+mpYWo0tXuwHEPnPqv7C6z9TGC6qa
         q+sa3z6lzmTrNYHoESFDa7weITomSKxfzptvOwT70G+fXojifGkUflHFpJNYPE5/iX3e
         2xQA==
X-Gm-Message-State: AOAM531AO1Un+olJN3SuWBlqb1fou2m7bsukgR9CDvmeTUpW31vf4Quf
        oEmdrfhlIAFq423d5S+xlba2xU69MPSzB7LqeQOXJs2y0l/plQ==
X-Google-Smtp-Source: ABdhPJymRvGxOIXywDlySd2vz0CHfCignaGtttk5vy37gKIaRcUYrGNUFcgD20qi0daQkphAcbbLG+h6jiPMs7/aCso=
X-Received: by 2002:a05:6830:2b28:: with SMTP id l40mr2109071otv.162.1635405536820;
 Thu, 28 Oct 2021 00:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211018102421.19848-1-stephan@gerhold.net> <YXZFGFH5lxDKeenw@matsya>
 <YXZL655lHukjar/x@gerhold.net> <CAH=2NtzfTqkwZum3owipC0kHvX2BMRssqRFmFAXPFkXK_SmN1w@mail.gmail.com>
 <YXpOAlTO80A4tZcT@gerhold.net>
In-Reply-To: <YXpOAlTO80A4tZcT@gerhold.net>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 28 Oct 2021 12:48:45 +0530
Message-ID: <CAH=2Ntxx9QKeV-uezT+TM_Vw_jEMbv0uGAE_Y0xKXhkLJh4z9w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] dmaengine: qcom: bam_dma: Add "powered remotely"
 mode for BAM-DMUX
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>, dmaengine@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 28 Oct 2021 at 12:45, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Hi Bhupesh,
>
> On Thu, Oct 28, 2021 at 12:20:35PM +0530, Bhupesh Sharma wrote:
> > On Mon, 25 Oct 2021 at 11:47, Stephan Gerhold <stephan@gerhold.net> wrote:
> > >
> > > On Mon, Oct 25, 2021 at 11:18:08AM +0530, Vinod Koul wrote:
> > > > On 18-10-21, 12:24, Stephan Gerhold wrote:
> > > > > The BAM Data Multiplexer (BAM-DMUX) provides access to the network data
> > > > > channels of modems integrated into many older Qualcomm SoCs, e.g.
> > > > > Qualcomm MSM8916 or MSM8974.
> > > > >
> > > > > Shortly said, BAM-DMUX is built using a simple protocol layer on top of
> > > > > a DMA engine (Qualcomm BAM DMA). For BAM-DMUX, the BAM DMA engine runs in
> > > > > a special mode where the modem/remote side is responsible for powering
> > > > > on the BAM when needed but we are responsible to initialize it.
> > > > > The BAM is powered off when unneeded by coordinating power control
> > > > > via bidirectional interrupts from the BAM-DMUX driver.
> > > > >
> > > > > This series adds one possible solution for handling the "powered remotely"
> > > > > mode in the bam_dma driver.
> > > >
> > > > This looks good me me. Bhupesh/Stephan what was the conclusion on the
> > > > the discussion you folks had?
> > > >
> > >
> > > Basically I said I would wait if you still want to take this for 5.16. :)
> > > There is a conflict with the DT schema conversion in Bhupesh's series,
> > > but it's trivial to solve no matter which of the patches is applied first.
> > >
> > > Since Bhupesh still needs to send v5 as far as I can tell (and has a
> > > much larger series overall), I think it's fine to apply this one first.
> > >
> > > Bhupesh, you can just copy-paste this below qcom,controlled-remotely
> > > in your DT schema if Vinod applies this patch first:
> > >
> > >   qcom,powered-remotely:
> > >     $ref: /schemas/types.yaml#/definitions/flag
> > >     description:
> > >       Indicates that the bam is powered up by a remote processor
> > >       but must be initialized by the local processor.
> >
> > Sure, I can respin my v5 with 'qcom,powered-remotely' property added,
> > if this series gets applied first.
>
> Thanks!
>
> > Can I add you S-o-B to the same?
>
> I literally just copy-pasted this from "qcom,controlled-remotely" in
> your patch with the description from my dt-bindings change that already
> has my S-o-B. I don't think it is necessary to add my S-o-B to your
> patch as well just for this. :)

Great, thanks. I will handle the "qcom,controlled-remotely" in my v5 patchset.

Otherwise, the series looks good to me, so:
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Regards.
