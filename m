Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5044F4FCF51
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 08:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbiDLGWS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 02:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiDLGWS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 02:22:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258153465D;
        Mon, 11 Apr 2022 23:20:01 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o5so4910868pjr.0;
        Mon, 11 Apr 2022 23:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZKcGtC5tCIRmh/vNIQCaulDH5znaqMV+2ARM6ku8ic=;
        b=B1TZxoPCuxyVlaC4j3CyGPLLfvj/ucmo3SD/4jFRD98igRMaMKJVk4FzjrUC4oV7ck
         2e/zaRU+z0ZmeOaltjKNVDaW6rqV6NBxLo6uuAbnyCR1h/U0ULbEKVzCyCaDpW4h5EEA
         E4tTnnXaEixFxwM5yvJBluP1di5V1NzqCD/GSysnC3y9WwBvn8kCfUOabdcNxvaQ+w1O
         aIInKld4OneIinbkwrW5suZ6g9sZbef4+plK8zdemMApWfyGy/Od3czgDBJ7hE3qJk8o
         JXrP+57xcbehQTs1gcy7OC5dHIgcqwAganOHQJn4ySQ7Be7LK55olmcWVfiCRrWsAODt
         07eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZKcGtC5tCIRmh/vNIQCaulDH5znaqMV+2ARM6ku8ic=;
        b=8KbY2h2Nke66BMfkM0e+wP870ixBX9yNHFb19g0+ZF9I9QEwUZ4U1mzpD+jaAQ8JR/
         WAznmhyI2ACKhKnMh6EPHTSraePu+yvMN8SUXCPoZqfx9FZHJvF+FdKmdZtEB5NFjot9
         AcUiQ5ZNyg5c5pXlDiD8uTi36XF99wQTxTtmvZKtvjkGih2jHPAs2/Ks0drPdsmEztuz
         QmF6xOED9p0CrSJmPZuA9vJ7RZGIo++4bV9hD2nYsjZZ8Y5iLIXYyMVlravJ8dDzEF/R
         rOHLtvg4O/DsbyO8tHlP2zNyrpL1qzRpW2I1X6AdSZPhd+ezmf1LnvnUpHAvdTfBuAdV
         /lQg==
X-Gm-Message-State: AOAM530oKQk7cXc4sHxs6p+SbyZn3nvcb+40ln7Z9/zZU7Oq/sLR7brB
        lDMLM2sDJPbrDIpOYBggbh0=
X-Google-Smtp-Source: ABdhPJxvM1EiGufY6yffmCMAUDnYn/PcQczG74Cn/K14BzrA2CUVjB2tT/45DJF/kQjCQ8HsRY37Eg==
X-Received: by 2002:a17:90b:1c87:b0:1ca:f4e:4fbe with SMTP id oo7-20020a17090b1c8700b001ca0f4e4fbemr3202324pjb.159.1649744400564;
        Mon, 11 Apr 2022 23:20:00 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id 21-20020a630115000000b00382a0895661sm1568990pgb.11.2022.04.11.23.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 23:20:00 -0700 (PDT)
Date:   Tue, 12 Apr 2022 11:49:53 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA
 binding to json format
Message-ID: <20220412061953.GA95928@9a2d8922b8f1>
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
 <14ecb746-56f0-2d3b-2f93-1af9407de4b7@linaro.org>
 <20220411105810.GB33220@9a2d8922b8f1>
 <50defa36-3d91-80ea-e303-abaade1c1f7e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50defa36-3d91-80ea-e303-abaade1c1f7e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Apr 11, 2022 at 01:38:41PM +0200, Krzysztof Kozlowski wrote:
> On 11/04/2022 12:58, Kuldeep Singh wrote:
> >> This is something new and it seems only one SoC defines it (not even one
> >> BAM version). I wonder whether this is actually correct or this
> >> particular version of BAM is slightly different. Maybe someone could
> >> clarify it, but if no - looks ok.
> > 
> > Yes, sdm845.dtsi uses 4 entries and rest 1.
> 
> Yes, I know. This does not solve my wonder.
> 
> > 
> >>
> >>> +
> >>> +  num-channels:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    description:
> >>> +      Indicates supported number of DMA channels in a remotely controlled bam.
> >>> +
> >>> +  qcom,controlled-remotely:
> >>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>
> >> type: boolean
> > 
> > Boolean comes under flag in types.yaml
> > 
> > definitions:
> >   flag:
> >     oneOf:
> >       - type: boolean
> >         const: true
> >       - type: 'null'
> > 
> > I have seen other boolean properties(spi-cpol, spi-cpha and bunch of
> > others) using type flag. I think we should keep flag here.
> 
> type:boolean is just shorter and example-schema recommends it. If you
> want to base on something (as a template, pattern) then the
> example-schema is the source, the preferred one.

I had seen other spec using flag and that's why kept same here.
Which example schema are you talking about?

> >>
> >> clocks, clock-names, qcom-ee - these are required according to old bindings.
> > 
> > I missed qcom,ee. Will add in v3.
> > 
> > For clocks and clock-names , there are two platforms(msm8996.dtsi,
> > sdm845.dtsi) where these properties are missing. And I don't want to add
> > some random values. Shall I skip them here? and let board owners add
> > them later.
> 
> These are required, so the SoC DTSI should be fixed. Not with random
> clocks but something proper. :)

Yes absolutely :-)
I have kept Srinivas in copy, who sent initial support for both the
dtsi. Probably he can confirm provided his email doesn't bounce.

Anyway Krzysztof, can you confirm the same as you have been actively
contributing to Qcom peripherals. I will add credit in follow-up
submission.
