Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278C26FED4A
	for <lists+dmaengine@lfdr.de>; Thu, 11 May 2023 09:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbjEKH6o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 May 2023 03:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbjEKH6l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 11 May 2023 03:58:41 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658A68A54
        for <dmaengine@vger.kernel.org>; Thu, 11 May 2023 00:58:34 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55a5a830238so76659377b3.3
        for <dmaengine@vger.kernel.org>; Thu, 11 May 2023 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683791913; x=1686383913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkscnF/KTXJ0FECfCsyp1oedck4XNhpkqlVKEGQkMDU=;
        b=ZigNMeK/lP5H1Z47r2LaTyi0KdLf8+YU/dY5F3l51D8o5Fzrk2imdMYmwQAesGKTwu
         rEF9pmkHjLhIPV0ZE8b2AGzqpXRVd4M2VcjEz4AZTA2Bihx8n1f1Cbw5GNExtqWHD7eA
         3jqySoToHxFPANVf5ocDHqtFTjPi9OR7udiEzzYF47ubqq3WFfhyPqpisDrBzhevgAYT
         BkSXIcEYAb5GUdxWgWyJI0UDXslyE3JtMm2tso66dARf7sGN9BjrTYylI3AiJIyXGzx+
         nv6wLyN1yu0sBisqjkCXOh4r+yQ0qPEApldhpcqsGYkfxBvmp6b48Fi4IJCkeCe1X2eu
         +oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683791913; x=1686383913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkscnF/KTXJ0FECfCsyp1oedck4XNhpkqlVKEGQkMDU=;
        b=fNobpsyMPxu2t+g2rjz/C2SO9mFzcG2UoeYWqKMVCQAPfw1UKPRkkfPKamjMfxUHol
         2mbi22d43dGJx83Ru0jQpcIWQEzjO3UCS9u1/MNl3NXzZJq8SSFCoZj94Rz8W9g5B6E9
         sdw5l3+bdQBFJiWijI3wc/Qiz7HHfuRTPVUgPyoOSDIfaWhjTtD9J9wRbrxrBb802ud2
         yLQE53Sj9MJxNcl5+1ZFMHVLRbL2qELdTXvIMjmrGkWXPAzEgw3X3VgJr+OCDft+le6+
         fT0DrkfvkfyaxpYUEd3Uiu1uDSmCRKbs/NRv2czXjiqXy1rZYvSkAVp2w43yhc2KWUrR
         fD3A==
X-Gm-Message-State: AC+VfDz1ExaUSGt0GT63Cx0+p19Mm7YM+68bM9btBPMnYWId5XzmBPzQ
        eR3tq1w1TNffco/Kpi6wu8m4ruhEhMYVK2SpSQYedw==
X-Google-Smtp-Source: ACHHUZ4/zj52rhxmIebfw5gIIU+TlEzSnxJDO6Mk7HaJD2y76ykj/GxLSP1pR7mI1xvpSroW7WN55rqJzibeWkyNkek=
X-Received: by 2002:a0d:f042:0:b0:559:f026:46d1 with SMTP id
 z63-20020a0df042000000b00559f02646d1mr20497691ywe.40.1683791913445; Thu, 11
 May 2023 00:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230504145737.286444-1-joychakr@google.com> <20230504145737.286444-8-joychakr@google.com>
 <78616bc1-8d9e-4a1c-70d6-ad62c2cfa8a8@linaro.org> <CAOSNQF15UN2Rckes55UHxbUvN1PJcbj9aWirVGSLDOs5Y5EPnQ@mail.gmail.com>
 <3d9d545d-a620-85f6-b7bd-d57a8729f818@linaro.org> <CAOSNQF0jJLc78_1aGYY3=csJc7WqqvydwxmQ22rvXpLruQ-XRg@mail.gmail.com>
 <83b8d419-9d43-3c81-2014-a4380de45b88@linaro.org>
In-Reply-To: <83b8d419-9d43-3c81-2014-a4380de45b88@linaro.org>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Thu, 11 May 2023 13:28:19 +0530
Message-ID: <CAOSNQF1NVrOAvzQym1NpSDfUE01Rb7jp79Tu9QLMKB-7m1JCMw@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 8, 2023 at 10:13=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/05/2023 13:58, Joy Chakraborty wrote:
> > On Fri, May 5, 2023 at 5:53=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 05/05/2023 11:44, Joy Chakraborty wrote:
> >>> On Thu, May 4, 2023 at 8:38=E2=80=AFPM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 04/05/2023 16:57, Joy Chakraborty wrote:
> >>>>> Add 2 new quirks added to the driver "arm,pl330-optimize-dev2mem-ax=
size"
> >>>>> and "arm,pl330-periph-single-dregs"
> >>>>
> >>>> This we can see from the diff. You need to answer why?
> >>>>
> >>>
> >>> Sure will change it to:
> >>> "
> >>> Addition of following quirks :
> >>> - "arm,pl330-periph-use-diff-axsize"
> >>>    AxSize of transactions to peripherals are limited by the periphera=
l
> >>> address width which inturn limits the AxSize used for transactions
> >>> towards memory.
> >>>    This quirk will make transactions to memory use the maximum
> >>> possible bus width(AxSize), store data in MFIFO and use narrow
> >>> multi-beat transactions to move data to peripherals.
> >>>    This only applies to transfers between memory and peripherals wher=
e
> >>> bus widths available are different for memory and the peripheral.
> >>> - "arm,pl330-periph-complete-with-singles" :
> >>>    When transfer sizes are not a multiple of a block of burst
> >>> transfers (AxLen * AxSize configured at the peripheral), certain
> >>> peripherals might choose not to set the burst request at the
> >>> peripheral request interface of the DMA.
> >>>    This quirk moves the remaining bytes to the peripheral using singl=
e
> >>> transactions.
> >>> "
> >>
> >> This does not answer why. You just copied again the patch contents.
> >>
> > Hi Krzysztof,
> > Both the changes could be useful for SOC's which have PL330 integrated
> > with a peripheral
>
> What do you mean here by "PL330 integrated with a peripheral"?

Hi Krzysztof,

By integration with peripheral I mean when the PL330 DMA is used to
copy data to/from memory to a peripheral hardware (e.g. FIFO of a SPI
master) where flow control of data is managed by the peripheral
request interface exposed by PL330 :
https://developer.arm.com/documentation/ddi0424/a/functional-overview/perip=
heral-request-interface

>
> > but I am not sure if all SOC's need/want this change
> > hence wanted to keep it as a DT knob to avoid any regressions.
> > But like you say it might not be the right thing to do.
>
> Devicetree is for describing hardware, not the contents of registers of
> a device. Your changes might fit or might not, I don't know this good
> enough, so I wait for your justification. Without justification this
> looks like controlling driver from DT...
>

Yes this does control the driver behaviour on how the PL330 DMA
hardware is programmed but it also is a function of
   - The bus width available in the soc towards memory and peripheral
to be different.
   - The requirement of peripherals interfaced with PL330 on how odd
transfer sizes are to be copied from memory to peripheral.

But, both changes IMO can be enabled by default as well in the driver
without devicetree knobs but it carries the risk of regression on
SOC's which do not have such a requirement.

Hence I was looking for some insight from Vinod Koul to see if it is
okay to go ahead with the changes without device tree knobs.

> >
> >>>
> >>>>>
> >>>>> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/dma/arm,pl330.yaml | 8 ++++++++
> >>>>>  1 file changed, 8 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/dma/arm,pl330.yaml b=
/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> >>>>> index 4a3dd6f5309b..0499a7fba88d 100644
> >>>>> --- a/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/dma/arm,pl330.yaml
> >>>>> @@ -53,6 +53,14 @@ properties:
> >>>>>      type: boolean
> >>>>>      description: quirk for performing burst transfer only
> >>>>>
> >>>>> +  arm,pl330-optimize-dev2mem-axsize:
> >>>>> +    type: boolean
> >>>>> +    description: quirk for optimizing AxSize used between dev<->me=
m
> >>>>
> >>>> This tells me nothing... Neither what it is about nor why this is
> >>>> property of a board or PL330 hardware implementation. Please describ=
e
> >>>> hardware, not drivers.
> >>>>
> >>>
> >>> Will change the name to "arm,pl330-periph-use-diff-axsize" and add de=
scription:
> >>> "
> >>> Quirk to use different AxSize for bursts while accessing source and
> >>> destination when moving data between memory and peripheral.
> >>> Maximum possible bus width is used as AxSize for transactions towards
> >>> memory and transactions towards peripherals use AxSize as per
> >>> peripheral address width.
> >>> "
> >>
> >> Still no answer. Why this is property of a board or PL330 hardware
> >> implementation?
> >> I also asked to describe hardware but I still see "quirk to ...". We u=
se
> >> "quirk" as concept in Linux driver. Describe the hardware, not Linux d=
river.
> >>
> >
> > This comes to use when the bus width requirement between peripheral
> > and memory is different, but buswidth is something we read from HW
> > registers so this can be enabled by default.
>
> Don't add discoverable stuff to DT.

Sure, will not add this to DT.

>
> >
> >>
> >>>
> >>>>> +
> >>>>> +  arm,pl330-periph-single-dregs:
> >>>>> +    type: boolean
> >>>>> +    description: quirk for using dma-singles for peripherals in _d=
regs()
> >>>>
> >>>> Same concerns.
> >>>>
> >
> > An example of such a case is given in the ARM TRM for PL330, so maybe
> > we can have this by default as well.
> > Link : https://developer.arm.com/documentation/ddi0424/d/functional-ove=
rview/peripheral-request-interface/dmac-length-management#:~:text=3DDMAC%20=
length%20management-,Example%202.3,-shows%20a%20DMAC
>
> I could not find here a case describing hardware. You pointed out some
> code. What does the code have anything to do with DT?
>

The instructions mentioned here are consumed by the PL330 Hardware to
generate AXI transactions on the system bus. The example mentioned in
the link is similar to how the driver would behave when this is
enabled.

I shall remove this as well and create a new patch without any DT
depency for the changes.

Thanks
Joy
>
> Best regards,
> Krzysztof
>
