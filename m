Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AE6696DB8
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 20:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBNTUD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 14:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjBNTUC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 14:20:02 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ACE30DD;
        Tue, 14 Feb 2023 11:20:01 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id bj22so13839448oib.11;
        Tue, 14 Feb 2023 11:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TijPrW01SusPeqgU93zj+PaZJEliWbkmIJHGZ7Gw5cU=;
        b=lV0/EQYKJKaSFtlfCnc8DxzhypYFolmCVsfXkxlrwSbsbo7vWciGRBI24ExOpYdbV0
         CZltz2uF/oZphFH37Ztv46Abz16S6oA6vI9JJHhg+H5XzKDkqNV8tpP5WlPys0/4TRKJ
         AhLH5jNH0T7ImgmQ8BuYaKRU0mXSL8qVLk5FWtQvVz+X5TZViFL7+P8B42ePyyppDfbx
         mP7ZXrSz7OeD6G/7dvAL4pRw5M71ZYvPa1Xj6Xhs+g3OASjl2uq+9bJVHfyxD+KHSEds
         ENsQjlq8TsNnugyz1Vqzz6LehPhqzS54eWt1lm3dSSgBCLGbSH0cwvGp2SllpX+Otv2i
         tSFA==
X-Gm-Message-State: AO0yUKULm1bsDwGkl21KiKc6LaWxhGSe0oPTFmq2vuv5L/da3tYzJ6gi
        NbBD7HmMvmJQ20T1ppxjCA==
X-Google-Smtp-Source: AK7set8fynAn+e3iL12R+/VtBADDsvcxd4FgY3dUEG466kszj/Jl1DLq6tDpbjBnNxuG9Os1CQSfPQ==
X-Received: by 2002:a05:6808:4285:b0:378:7234:bc46 with SMTP id dq5-20020a056808428500b003787234bc46mr1690381oib.44.1676402400689;
        Tue, 14 Feb 2023 11:20:00 -0800 (PST)
Received: from robh_at_kernel.org (c-67-162-147-231.hsd1.co.comcast.net. [67.162.147.231])
        by smtp.gmail.com with ESMTPSA id b13-20020aca220d000000b0037d743b5cb7sm4318528oic.17.2023.02.14.11.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:20:00 -0800 (PST)
Received: (nullmailer pid 29522 invoked by uid 1000);
        Tue, 14 Feb 2023 19:19:59 -0000
Date:   Tue, 14 Feb 2023 13:19:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Janne Grunau <j@jannau.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [RFC PATCH] dt-bindings: dma: apple,sio: Add schema
Message-ID: <20230214191959.GA27025-robh@kernel.org>
References: <20230214141053.92731-1-povik+lin@cutebit.org>
 <167638945429.3790.16067227881981242831.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167638945429.3790.16067227881981242831.robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 14, 2023 at 10:12:34AM -0600, Rob Herring wrote:
> 
> On Tue, 14 Feb 2023 15:10:53 +0100, Martin Povišer wrote:
> > Describe the SIO coprocessor which serves as pretend DMA controller on
> > recent Apple platforms.
> > 
> > Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> > ---
> > 
> > Since the schema mentions a loader preparing the binding appropriately,
> > here's a PR with the relevant (WIP) loader code, if anyone wants to look:
> > https://github.com/AsahiLinux/m1n1/pull/286
> > 
> >  .../devicetree/bindings/dma/apple,sio.yaml    | 129 ++++++++++++++++++
> >  1 file changed, 129 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/apple,sio.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/dma/apple,sio.example.dts:24.35-27.11: Warning (node_name_vs_property_name): /example-0/interrupt-controller: node name and property name conflict

This is a quirk with how the examples are constructed. In any case, just 
drop the 'interrupt-controller' node. No need to show providers in an 
example.

Rob
