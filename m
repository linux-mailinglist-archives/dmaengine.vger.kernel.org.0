Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0033D72A92C
	for <lists+dmaengine@lfdr.de>; Sat, 10 Jun 2023 07:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjFJFfO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 10 Jun 2023 01:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFJFfN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 10 Jun 2023 01:35:13 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EDA3A9E;
        Fri,  9 Jun 2023 22:35:12 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so5145636276.0;
        Fri, 09 Jun 2023 22:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686375311; x=1688967311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66j/h+9cZEjKb4UdwLgMXHl/kBywtFkqb8wIoqWmDMo=;
        b=Fgz9LE+WgSayy0gqznU4nHufTkzzOdkWA77tPaKYuOOBIE9nSZwtWlWTcLvi3I83Nm
         yCIfnuvzBhkEvNL0TO3VEtAZZ8fhuE+QVZkNV13GWT8P7/Q1lOA+c2S9TbrH05K9BLbI
         aJNSicKHM0yT4TIW2AMc4rUuuEp82Gxhf0pYn3KJMsnBRl52zleKRI5AFi9n1w1ntddC
         qtpHb7ZgfWhXx0Kg5s8hU2ZU5sbR6lgSUbYyXqMocfve5ZNbM3OxXfSG8ENvGfy9YzF+
         t4rZndmqRZNdYPwZlPGCiN63QGEx3E7n8/XVuMKO2N8A7vT/bLDCQny0///xi9fV/HD0
         4WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686375311; x=1688967311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66j/h+9cZEjKb4UdwLgMXHl/kBywtFkqb8wIoqWmDMo=;
        b=OV2g8x7KCE8W3wI4tEwsvrPuh6P6CqFVgmpfq6DH/DFVsbvlT87cOI60C42Md+gJRJ
         MtPpLKpG2VIIHBRq2oMQ/07RBNSB9TWOZqsV6lBAX92piSy2nzigUQu4j25eQYUuhsjp
         8obCFjVGBfJTv3shFmHTmHd8pm+w0Vycg+XTWL3pMXzMK5hgHf4/G6jjWR4739ndh+da
         wN4cnxxVOo/ew3oUItMnTeXC8pRH9xqNSGdVrp2jgUiUgCpAlKzu9EoWrivqQsJM3/Ee
         klrqiajxTN2YGQbETnSUD1AXR6KUk97kouVx23ZlUxOl3DtGRYFHKTmnjsGnl42AqCYb
         vWTA==
X-Gm-Message-State: AC+VfDwrPd1XVa4TBoHCmgYWFFOQV8v+ZP0e5KOOGYAGS1u3QJ3oElKs
        FVtgqY99lBNra0wat7pfj6GKWLmPDJvDu+JlhLM=
X-Google-Smtp-Source: ACHHUZ44wzkF29g4xzNfFH994CgHcQled1GvWddTD2bcNqr/f4iQNWBbImwZgeL8vGFigKA1//NILymWMxvSlQDXSiY=
X-Received: by 2002:a25:54f:0:b0:bac:46f2:8d0f with SMTP id
 76-20020a25054f000000b00bac46f28d0fmr6290839ybf.3.1686375311574; Fri, 09 Jun
 2023 22:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686192243.git.zhoubinbin@loongson.cn> <bb2d5985a3d9fd8e7ccbe2794842d93a8978d8a6.1686192243.git.zhoubinbin@loongson.cn>
 <68bb3816-d707-3a21-59a2-8785dce7210a@linaro.org>
In-Reply-To: <68bb3816-d707-3a21-59a2-8785dce7210a@linaro.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Sat, 10 Jun 2023 13:35:00 +0800
Message-ID: <CAMpQs4JF-HtHpb_3YJBUNo2x6_E=S-gf1p9kJ7vp01S62PYSxw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: dmaengine: Add Loongson LS2X
 APB DMA controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, Yingkun Meng <mengyingkun@loongson.cn>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jun 10, 2023 at 12:49=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/06/2023 04:55, Binbin Zhou wrote:
> > Add Loongson LS2X APB DMA controller binding with DT schema
> > format using json-schema.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
>
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: loongson,ls2k1000-apbdma
> > +      - items:
> > +          - const: loongson,ls2k0500-apbdma
> > +          - const: loongson,ls2k1000-apbdma
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#dma-cells":
> > +    const: 1
> > +
> > +  dma-channels:
> > +    const: 1
>
> If it is const, why do you need it?
>
Hi Krzysztof:

IMO, although it is a single-channel DMAC, the "dma-channels" are
still needed for a more comprehensive description of the hardware.

Thanks.
Binbin

> Best regards,
> Krzysztof
>
