Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE4B6F8046
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 11:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjEEJpB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 May 2023 05:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjEEJpA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 May 2023 05:45:00 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC14E7A
        for <dmaengine@vger.kernel.org>; Fri,  5 May 2023 02:44:59 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so12938902276.1
        for <dmaengine@vger.kernel.org>; Fri, 05 May 2023 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683279898; x=1685871898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCZ5gOZGay01QN1wHjQAh8Ri+WPvgr7jsxXO0RRuS7o=;
        b=FD/WmZYVUi3EMNZPPg/hdLHt9s+vJ0y0SFqPowwwpMxpVpug2hrEEUQFsWQjONS9kr
         0F6oayVS2FiN9rO8qOeW4zKxcjfV8ijlNCKyyLfQCCErFAR87zdNYcL7q28xNDEJDSCD
         WrLx0PorpjnEsaEJUWxevDCk4FAKb/kjpWaJOK3PzZ9L3hIYS4ZIH+bPzNwvb22IOuxN
         RT6Ss4h3HeL6Q1q1pc69bBAeIVuxewV2w/zXUXeP94Cy7oCBCqyLbe5heXjDSYXBxMa/
         VPGcBIsuZKQRi5ET18ViQWvc3nI/AZr3tOuDt6h6vgB6uXHB8xWzydu8sVTcD/2q+/4j
         9Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683279898; x=1685871898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCZ5gOZGay01QN1wHjQAh8Ri+WPvgr7jsxXO0RRuS7o=;
        b=cMq/6WHP2blFpG5CRvdCpfXiJqXzfMuQ1XdWpR/zlLG5d+MEt2u0Wpb9MpeYdyRhcv
         cOGwKeZoRlk5oUjcdb4KXez9/gJRClsYcYZE6ihRIS+QdLEGRm/WtKVKeg7EGMe7OUut
         tzhVVV8mYRw6K38CAJYwxy2Ve1TmWlcpJktM0yKS8uUdHPH1eiIcnj7L545EFqTE73n1
         a0olFqUV65JAWlUwjx6afKLT5tr5NI5wEL8rSoQ8Yc+6yH8djhH5rf5kvCnxtz43pDSv
         bAHjLRmQ0qkoPv0CJu/9GlpuLyeDzOkhgbLcls4M4k84BGfVI35D7cmb6BgxkI/bd5Xp
         xfsA==
X-Gm-Message-State: AC+VfDxqvS2WdZj2ecPB5hudVi6sS1wF2lesZ+va3txE9SXgp9a/VP8d
        FI/JiqnFWyV8O8r+o+DI1xPOVYCu503pl92BL/emPQ==
X-Google-Smtp-Source: ACHHUZ6HCkrAgHh/ojQsRbyFiV7ucIGBz6KdQOj7giDRR00rnT6kQZUC/O3u9ilY/OK6jDBf2o92eX7j01JxLdN8ZHQ=
X-Received: by 2002:a25:3287:0:b0:b98:c6bb:137b with SMTP id
 y129-20020a253287000000b00b98c6bb137bmr2814731yby.9.1683279898093; Fri, 05
 May 2023 02:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230504145737.286444-1-joychakr@google.com> <20230504145737.286444-8-joychakr@google.com>
 <78616bc1-8d9e-4a1c-70d6-ad62c2cfa8a8@linaro.org>
In-Reply-To: <78616bc1-8d9e-4a1c-70d6-ad62c2cfa8a8@linaro.org>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Fri, 5 May 2023 15:14:45 +0530
Message-ID: <CAOSNQF15UN2Rckes55UHxbUvN1PJcbj9aWirVGSLDOs5Y5EPnQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] dt-bindings: dmaengine: pl330: Add new quirks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, manugautam@google.com,
        danielmentz@google.com, sjadavani@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 4, 2023 at 8:38=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/05/2023 16:57, Joy Chakraborty wrote:
> > Add 2 new quirks added to the driver "arm,pl330-optimize-dev2mem-axsize=
"
> > and "arm,pl330-periph-single-dregs"
>
> This we can see from the diff. You need to answer why?
>

Sure will change it to:
"
Addition of following quirks :
- "arm,pl330-periph-use-diff-axsize"
   AxSize of transactions to peripherals are limited by the peripheral
address width which inturn limits the AxSize used for transactions
towards memory.
   This quirk will make transactions to memory use the maximum
possible bus width(AxSize), store data in MFIFO and use narrow
multi-beat transactions to move data to peripherals.
   This only applies to transfers between memory and peripherals where
bus widths available are different for memory and the peripheral.
- "arm,pl330-periph-complete-with-singles" :
   When transfer sizes are not a multiple of a block of burst
transfers (AxLen * AxSize configured at the peripheral), certain
peripherals might choose not to set the burst request at the
peripheral request interface of the DMA.
   This quirk moves the remaining bytes to the peripheral using single
transactions.
"

> >
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > ---
> >  Documentation/devicetree/bindings/dma/arm,pl330.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/Doc=
umentation/devicetree/bindings/dma/arm,pl330.yaml
> > index 4a3dd6f5309b..0499a7fba88d 100644
> > --- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> > +++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> > @@ -53,6 +53,14 @@ properties:
> >      type: boolean
> >      description: quirk for performing burst transfer only
> >
> > +  arm,pl330-optimize-dev2mem-axsize:
> > +    type: boolean
> > +    description: quirk for optimizing AxSize used between dev<->mem
>
> This tells me nothing... Neither what it is about nor why this is
> property of a board or PL330 hardware implementation. Please describe
> hardware, not drivers.
>

Will change the name to "arm,pl330-periph-use-diff-axsize" and add descript=
ion:
"
Quirk to use different AxSize for bursts while accessing source and
destination when moving data between memory and peripheral.
Maximum possible bus width is used as AxSize for transactions towards
memory and transactions towards peripherals use AxSize as per
peripheral address width.
"

> > +
> > +  arm,pl330-periph-single-dregs:
> > +    type: boolean
> > +    description: quirk for using dma-singles for peripherals in _dregs=
()
>
> Same concerns.
>

Will change the name to  "arm,pl330-periph-complete-with-singles" and
add description:
"
Quirk to use dma singles n times instead of an n beat burst to
complete a transfer when the transfer size is not a multiple of the
burst size and burst length configured at the peripheral.
n being bytes left after the major chunk is transferred with
peripheral configured burst transactions.
"

>
> Best regards,
> Krzysztof
>

Will update the patch series if this is satisfactory.

Thanks
Joy
