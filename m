Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169634FBA49
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 12:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbiDKLAc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 07:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345792AbiDKLAa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 07:00:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE70443C0;
        Mon, 11 Apr 2022 03:58:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id be5so7542106plb.13;
        Mon, 11 Apr 2022 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=neoL93v1FQD5PO80zVIlusq7TF65khnb+nEiJ+ZIYps=;
        b=R9dZYFdq5yVATZ3XJWwUNTdExd0FgQO0ZWtoF3o/RTLOgbXtd/p28qzp8AF1rWiU3Z
         3+NERWN2Unkhyp29TALZSF5cSg9c29zKrhyL7hNGKn7vLPrtRCQyjKKLka4RMtJMNpZ4
         ahnLWm9t48XUL17kzCe/oj2MGlnQYHzSD1ua7Nc9kDdlYe/juPFYNbudF13yPa6sOyYe
         piBAUqD5vZJQxTRC0twsLW+bJnFtJy3aqcLbPyZ7cEQtitfeD6OVpqwRMrYRM0cDxoh7
         Vk1qg0PX5inW0esw3QT16R7w/FHp3O59LXqUAWeoni56LY2A8uun9WVELgqKfp6CbZ0o
         bgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=neoL93v1FQD5PO80zVIlusq7TF65khnb+nEiJ+ZIYps=;
        b=qP3Quj+Dm7fNDcQKloYf1QWcT+EQlwhDIDiADDI6wgjfAVLkRqrDSlGe2anjRGu86o
         bXduBCV1NJERPJ3acNtFNaAlWOjCIuxqRI/SeEfFUwGhFexzv+AyogoFj6LsO4D8LdIC
         zSjjd/kpXTtkY0jY2ickJdQS+yU805tE4SHc/RT825OdbYUVhX+3Adgmaagr7sGDN6R8
         IwA8QvUxk1lkOo3Je8P/l5iPGa+NPj6eCQQ8llnkbd3uhtPsPWgxklbVPsofvA21E5I0
         m8MCuIZmGbtt22HWjUkkHTg2xjFtQ7UA8iH9ix6rTsyNImxWBCVG621VTjsGLdGry6Au
         EcOw==
X-Gm-Message-State: AOAM532FBAnI2eJ9uqTdTaEUX8W8NFMkbJzTYPnv+ntwKbvLUmxszyxy
        2zCgQhqq8qW0Av/E0EwqwtA=
X-Google-Smtp-Source: ABdhPJwElaEn7PLRh27DOpDoDhP3DZRKy/HNPr6mpB/9WKganP7ARt5gUovKBlaaB7+VXEnReHIgwQ==
X-Received: by 2002:a17:90b:4c44:b0:1c7:109c:b419 with SMTP id np4-20020a17090b4c4400b001c7109cb419mr36082262pjb.113.1649674696515;
        Mon, 11 Apr 2022 03:58:16 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a74c900b001cb8d6b5c47sm4233182pjl.46.2022.04.11.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:58:16 -0700 (PDT)
Date:   Mon, 11 Apr 2022 16:28:10 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA
 binding to json format
Message-ID: <20220411105810.GB33220@9a2d8922b8f1>
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
 <14ecb746-56f0-2d3b-2f93-1af9407de4b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ecb746-56f0-2d3b-2f93-1af9407de4b7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> This is something new and it seems only one SoC defines it (not even one
> BAM version). I wonder whether this is actually correct or this
> particular version of BAM is slightly different. Maybe someone could
> clarify it, but if no - looks ok.

Yes, sdm845.dtsi uses 4 entries and rest 1.

> 
> > +
> > +  num-channels:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Indicates supported number of DMA channels in a remotely controlled bam.
> > +
> > +  qcom,controlled-remotely:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> 
> type: boolean

Boolean comes under flag in types.yaml

definitions:
  flag:
    oneOf:
      - type: boolean
        const: true
      - type: 'null'

I have seen other boolean properties(spi-cpol, spi-cpha and bunch of
others) using type flag. I think we should keep flag here.

> 
> > +    description:
> > +      Indicates that the bam is controlled by remote proccessor i.e. execution
> > +      environment.
> > +
> > +  qcom,ee:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Indicates the active Execution Environment identifier (0-7) used in the
> > +      secure world.
> 
> maximum: 7

ok.

> > +required:
> > +  - compatible
> > +  - "#dma-cells"
> > +  - interrupts
> > +  - reg
> 
> clocks, clock-names, qcom-ee - these are required according to old bindings.

I missed qcom,ee. Will add in v3.

For clocks and clock-names , there are two platforms(msm8996.dtsi,
sdm845.dtsi) where these properties are missing. And I don't want to add
some random values. Shall I skip them here? and let board owners add
them later.
