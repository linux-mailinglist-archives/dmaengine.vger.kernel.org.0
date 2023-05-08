Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9420F6FAF93
	for <lists+dmaengine@lfdr.de>; Mon,  8 May 2023 14:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjEHMB6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 May 2023 08:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjEHMB0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 May 2023 08:01:26 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D717B4C9AA
        for <dmaengine@vger.kernel.org>; Mon,  8 May 2023 04:59:06 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55a64f0053fso65966317b3.3
        for <dmaengine@vger.kernel.org>; Mon, 08 May 2023 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683547143; x=1686139143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIowkfIi/w2/lZ9wY1KVia8iKFoETo3oMoKgAYwhoeg=;
        b=CUXUoK5y3HKeeFBmYl0RX9X0y83y8VWqHwJiui8cI4DkfLD1RiJUf/RSH2G80oDA28
         /1foKFJRT2NsXFxLDP0E63bplVXdaFRFYas+EABmp3j9ck3kuP8NsKeaCY6USAeu57G5
         dQqStiBALTt5xf+aiA/UxCCkSxntt+2yJoyq4CtS/p0AHMbK5pANnniFF3vYIj0hz5B9
         Aya9gvzS6N9ooDUX+hfozUwDxoOKaL7qHu3GxCChRyDSvazQENY0VgvZ9kP0Dh050Ljz
         CdTu8KB4gpmMw7DuVtRr4XEPyyTwRR5Ck05T3qSP5O3q/MbTrmzP64bF4OAhZJRMHKM8
         RnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683547143; x=1686139143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIowkfIi/w2/lZ9wY1KVia8iKFoETo3oMoKgAYwhoeg=;
        b=fgfDcHGpsMKrXcje+IWFykHkCuXXcqDejZpxdBQEiehG0Dw53Fmxa3SEMOG0v8O2P8
         RmLUT9PScp3CcpWAs1j5pPGe82uoT0h6V470M5nWSRDAbYfbH44emmOlD4BEz7vVwHjb
         JfQWvndZb1mCRRkcttpO0K8Ud/5ID/ln2bI8ZUYcF8rBp2Bduk8bAe9wxbBRLjL8Elye
         7KOSwXAc5KKdO9VBNxkO6TPGU1mwx+tc/do6SYxZK5wPZVnOBm/Exths9dligTmbgY6X
         OvoKc2FsRPX7vB+PdBJGuSWhWB9zEHucjPWV2l46neVNe0yFRaAWJQmpr2wuMul4ASk1
         +aiA==
X-Gm-Message-State: AC+VfDyYZD+njrK3z8rEcBlKty0HZb3AIJ58Ajs5Gmp/z2dBf7mNLGe7
        qZPEnWK96QLium1CCoUPu7guoOWNrvXwp6W19CHYeg==
X-Google-Smtp-Source: ACHHUZ6HUZVug7ZDRRKUd20kN2DYD1F/ilVsXiwLgoLzYKoGNVYq9ZU6JXNMvLJltqVpFR6OojeV1Uz99EAQLmyEqUY=
X-Received: by 2002:a81:a1c9:0:b0:559:f85e:44e8 with SMTP id
 y192-20020a81a1c9000000b00559f85e44e8mr11335498ywg.29.1683547143242; Mon, 08
 May 2023 04:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230504145737.286444-1-joychakr@google.com> <20230504145737.286444-8-joychakr@google.com>
 <78616bc1-8d9e-4a1c-70d6-ad62c2cfa8a8@linaro.org> <CAOSNQF15UN2Rckes55UHxbUvN1PJcbj9aWirVGSLDOs5Y5EPnQ@mail.gmail.com>
 <3d9d545d-a620-85f6-b7bd-d57a8729f818@linaro.org>
In-Reply-To: <3d9d545d-a620-85f6-b7bd-d57a8729f818@linaro.org>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Mon, 8 May 2023 17:28:50 +0530
Message-ID: <CAOSNQF0jJLc78_1aGYY3=csJc7WqqvydwxmQ22rvXpLruQ-XRg@mail.gmail.com>
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

On Fri, May 5, 2023 at 5:53=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/05/2023 11:44, Joy Chakraborty wrote:
> > On Thu, May 4, 2023 at 8:38=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 04/05/2023 16:57, Joy Chakraborty wrote:
> >>> Add 2 new quirks added to the driver "arm,pl330-optimize-dev2mem-axsi=
ze"
> >>> and "arm,pl330-periph-single-dregs"
> >>
> >> This we can see from the diff. You need to answer why?
> >>
> >
> > Sure will change it to:
> > "
> > Addition of following quirks :
> > - "arm,pl330-periph-use-diff-axsize"
> >    AxSize of transactions to peripherals are limited by the peripheral
> > address width which inturn limits the AxSize used for transactions
> > towards memory.
> >    This quirk will make transactions to memory use the maximum
> > possible bus width(AxSize), store data in MFIFO and use narrow
> > multi-beat transactions to move data to peripherals.
> >    This only applies to transfers between memory and peripherals where
> > bus widths available are different for memory and the peripheral.
> > - "arm,pl330-periph-complete-with-singles" :
> >    When transfer sizes are not a multiple of a block of burst
> > transfers (AxLen * AxSize configured at the peripheral), certain
> > peripherals might choose not to set the burst request at the
> > peripheral request interface of the DMA.
> >    This quirk moves the remaining bytes to the peripheral using single
> > transactions.
> > "
>
> This does not answer why. You just copied again the patch contents.
>
Hi Krzysztof,
Both the changes could be useful for SOC's which have PL330 integrated
with a peripheral but I am not sure if all SOC's need/want this change
hence wanted to keep it as a DT knob to avoid any regressions.
But like you say it might not be the right thing to do.

> >
> >>>
> >>> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/dma/arm,pl330.yaml | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b/D=
ocumentation/devicetree/bindings/dma/arm,pl330.yaml
> >>> index 4a3dd6f5309b..0499a7fba88d 100644
> >>> --- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> >>> +++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> >>> @@ -53,6 +53,14 @@ properties:
> >>>      type: boolean
> >>>      description: quirk for performing burst transfer only
> >>>
> >>> +  arm,pl330-optimize-dev2mem-axsize:
> >>> +    type: boolean
> >>> +    description: quirk for optimizing AxSize used between dev<->mem
> >>
> >> This tells me nothing... Neither what it is about nor why this is
> >> property of a board or PL330 hardware implementation. Please describe
> >> hardware, not drivers.
> >>
> >
> > Will change the name to "arm,pl330-periph-use-diff-axsize" and add desc=
ription:
> > "
> > Quirk to use different AxSize for bursts while accessing source and
> > destination when moving data between memory and peripheral.
> > Maximum possible bus width is used as AxSize for transactions towards
> > memory and transactions towards peripherals use AxSize as per
> > peripheral address width.
> > "
>
> Still no answer. Why this is property of a board or PL330 hardware
> implementation?
> I also asked to describe hardware but I still see "quirk to ...". We use
> "quirk" as concept in Linux driver. Describe the hardware, not Linux driv=
er.
>

This comes to use when the bus width requirement between peripheral
and memory is different, but buswidth is something we read from HW
registers so this can be enabled by default.

>
> >
> >>> +
> >>> +  arm,pl330-periph-single-dregs:
> >>> +    type: boolean
> >>> +    description: quirk for using dma-singles for peripherals in _dre=
gs()
> >>
> >> Same concerns.
> >>

An example of such a case is given in the ARM TRM for PL330, so maybe
we can have this by default as well.
Link : https://developer.arm.com/documentation/ddi0424/d/functional-overvie=
w/peripheral-request-interface/dmac-length-management#:~:text=3DDMAC%20leng=
th%20management-,Example%202.3,-shows%20a%20DMAC

> >
> > Will change the name to  "arm,pl330-periph-complete-with-singles" and
> > add description:
> > "
> > Quirk to use dma singles n times instead of an n beat burst to
> > complete a transfer when the transfer size is not a multiple of the
>
> No, how you wrote it sounds like driver. Don't add driver quirks to DT.
>
> Best regards,
> Krzysztof
>

Hi Vinod Kaul,

Do you think it is feasible to enable these changes by default instead
of a DT property ?

Thanks
Joy
