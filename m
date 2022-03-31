Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715054EDF92
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 19:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiCaRXe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 13:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiCaRXe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 13:23:34 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFD61DEAAF;
        Thu, 31 Mar 2022 10:21:46 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id q129so221871oif.4;
        Thu, 31 Mar 2022 10:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nsenYJDFXdH82jpjiqunff4Tj/nrgLEIwwTNVx3c7KA=;
        b=IpNQyL+iL3z4TYEEHvoBFfdo87GdoZ0FD/jpEvHvDhc2QyAsp1+Nrv3DGFkA7J2Uz1
         riylqVozQnr2znIZ9/ks8dtd0X0BZpfAxtYN1E2B/phG9lzc66cCm85FmMl+DgldljCg
         0/csav/Aa5hyWXIIOI0S2+zHzO1h7c4yqbdVHRLHV5WoRhtWLf2GJxWS77pb11z2yBGB
         RMzKPEwZzOrPn/qe1RxZ7PWLh0yAS+Fkf8Zb9SCEsCGMKH8MBRsZuXTJbSXlO+hVo/0E
         ft9qcWON9mkWYApqly6sfWO3aiJFZsnD4ERnIRqy/WAPPSORFY03rYXj0FTztScrSU9F
         WKlA==
X-Gm-Message-State: AOAM533mHYcXzX53THcyWVBrLpHE9nWbh0b5SYFHva1SIlwP9OZfD8a1
        /ci5JfUKZBI1MzjVlD4aDg==
X-Google-Smtp-Source: ABdhPJwnl2uSafHwFjFXClVThGjT6z4BqxQOEpHGBmTRRQm3pFwVVUFoxpHVcYXm7rCBrefSq1tsJA==
X-Received: by 2002:a05:6808:118f:b0:2d4:13f1:8504 with SMTP id j15-20020a056808118f00b002d413f18504mr2962544oil.90.1648747305999;
        Thu, 31 Mar 2022 10:21:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f8-20020a4ace88000000b00321598cd45dsm12006oos.33.2022.03.31.10.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:21:44 -0700 (PDT)
Received: (nullmailer pid 1168272 invoked by uid 1000);
        Thu, 31 Mar 2022 17:21:43 -0000
Date:   Thu, 31 Mar 2022 12:21:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@cutebit.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH 1/2] dt-bindings: dma: Add Apple ADMAC
Message-ID: <YkXjJ2gtX4sL000U@robh.at.kernel.org>
References: <20220330164458.93055-1-povik+lin@cutebit.org>
 <20220330164458.93055-2-povik+lin@cutebit.org>
 <YkU6yvUQ6v4VdXiJ@matsya>
 <C2D8BDAF-0ACF-4756-B10F-B5097BC93670@cutebit.org>
 <265B2992-06E5-4E45-A971-B170A385EFD4@cutebit.org>
 <YkW2OG3dU4YFYJEZ@matsya>
 <B75EEC8B-FE88-47EA-8F56-0DD7EDE0DB77@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B75EEC8B-FE88-47EA-8F56-0DD7EDE0DB77@cutebit.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 31, 2022 at 06:13:53PM +0200, Martin Povišer wrote:
> 
> > On 31. 3. 2022, at 16:10, Vinod Koul <vkoul@kernel.org> wrote:
> > 
> > On 31-03-22, 09:06, Martin Povišer wrote:
> >> 
> >>> On 31. 3. 2022, at 8:50, Martin Povišer <povik@cutebit.org> wrote:
> >>>> 
> >>>> On 31. 3. 2022, at 7:23, Vinod Koul <vkoul@kernel.org> wrote:
> >>>> 
> >>>> On 30-03-22, 18:44, Martin Povišer wrote:
> >>>>> Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio
> >>>>> samples on Apple SoCs from the "Apple Silicon" family.
> >>>>> 
> >>>>> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> >>>>> ---
> >>>>> .../devicetree/bindings/dma/apple,admac.yaml  | 73 +++++++++++++++++++
> >>>>> 1 file changed, 73 insertions(+)
> >>>>> create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml
> >>>>> 
> >>>>> diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..34f76a9a2983
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
> >>> 
> >>>>> +  apple,internal-irq-destination:
> >>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>>> +    description: Index influencing internal routing of the IRQs
> >>>>> +      within the peripheral.
> >>>> 
> >>>> do you have more details for this, is this for peripheral and if so
> >>>> suited to be in dam-cells?
> >>> 
> >>> By peripheral I meant the DMA controller itself here. 
> > 
> > Dmaengine convention is that peripheral is device which we are doing dma
> > to/from, like audio controller/fifo here
> > 
> >>> Effectively the controller has four independent IRQ outputs and the driver
> >>> needs to know which one we are using. (It need not be the same output even
> >>> for different ADMAC instances on one die.)
> > 
> > That smells like a mux to me.. why not use dma-requests for this?
> 
> I am not sure that’s right. Reading the dmaengine docs, DMA requests seem to have
> to do with the DMA-controller-to-peripheral connection, but the proposed property
> tells us which of four independent IRQ outputs of the DMA controller we actually
> have in the interrupts= property. That is, it has to do with the DMA-controller-to-CPU
> connection.

Why do they have to be different? IRQF_SHARED doesn't work?

Why can't you request each IRQ until it succeeds?

What happens when there are 5 DMA controllers?

If using more than 1 interrupt will never work or be needed, then I'm 
inclined to say just describe that 1 interrupt. Yes, that goes against 
'describe all the h/w', but there's always exceptions. I suppose you 
need to know which 'interrupts' index (output) you are using. If so, you 
can do something like this:

interrupts = <-1>, <-1>, <3 0>, <-1>;

Rob
