Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8769F4EDB74
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 16:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiCaOLz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiCaOLz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 10:11:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A16190EAA;
        Thu, 31 Mar 2022 07:10:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 76CDBCE21DC;
        Thu, 31 Mar 2022 14:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E601BC340ED;
        Thu, 31 Mar 2022 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648735804;
        bh=/oDSuFCb4Ah81sJx/T9N4CSUj6w3B5456zC1kELXHUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UG25bqPpgpokUu4QvKKYHWUMBmKCw8Ww11I2VbcQdbth/Tyq64wQLPOEK2vBAm6vR
         K5qWbVGidELXybyUDj8XBvO00TtkQjiLXKtv3T/NOCujdSI4aKSNNorP7MptZBvioD
         beGXTc3Bh0uDoo5t++JxHwfJiBFnXjakUuTPLacIQghA+tiuqeVDQs3UFElcXEvKRC
         4BKd6f6oiUK3r0m8fFCURtJ8zr/SQEa4t7gwJooaZy0URbKeKo/nPH9HqVGBDpd3Ob
         T0XLWZ0nf0xF1bk+CHDkLOGIGXjtrjPoRf0fJBtsl73+r/Ka/yBxnwyIjE4AcTRV6T
         o0Br9+GVdyekw==
Date:   Thu, 31 Mar 2022 19:40:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@cutebit.org>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH 1/2] dt-bindings: dma: Add Apple ADMAC
Message-ID: <YkW2OG3dU4YFYJEZ@matsya>
References: <20220330164458.93055-1-povik+lin@cutebit.org>
 <20220330164458.93055-2-povik+lin@cutebit.org>
 <YkU6yvUQ6v4VdXiJ@matsya>
 <C2D8BDAF-0ACF-4756-B10F-B5097BC93670@cutebit.org>
 <265B2992-06E5-4E45-A971-B170A385EFD4@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <265B2992-06E5-4E45-A971-B170A385EFD4@cutebit.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-03-22, 09:06, Martin Povišer wrote:
> 
> > On 31. 3. 2022, at 8:50, Martin Povišer <povik@cutebit.org> wrote:
> > 
> >> 
> >> On 31. 3. 2022, at 7:23, Vinod Koul <vkoul@kernel.org> wrote:
> >> 
> >> On 30-03-22, 18:44, Martin Povišer wrote:
> >>> Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio
> >>> samples on Apple SoCs from the "Apple Silicon" family.
> >>> 
> >>> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> >>> ---
> >>> .../devicetree/bindings/dma/apple,admac.yaml  | 73 +++++++++++++++++++
> >>> 1 file changed, 73 insertions(+)
> >>> create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml
> >>> 
> >>> diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
> >>> new file mode 100644
> >>> index 000000000000..34f76a9a2983
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
> > 
> >>> +  apple,internal-irq-destination:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    description: Index influencing internal routing of the IRQs
> >>> +      within the peripheral.
> >> 
> >> do you have more details for this, is this for peripheral and if so
> >> suited to be in dam-cells?
> > 
> > By peripheral I meant the DMA controller itself here. 

Dmaengine convention is that peripheral is device which we are doing dma
to/from, like audio controller/fifo here

> > Effectively the controller has four independent IRQ outputs and the driver
> > needs to know which one we are using. (It need to be the same output even
> > for different ADMAC instances on one die.)

That smells like a mux to me.. why not use dma-requests for this?

-- 
~Vinod
