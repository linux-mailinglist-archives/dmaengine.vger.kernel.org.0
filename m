Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010615BB281
	for <lists+dmaengine@lfdr.de>; Fri, 16 Sep 2022 20:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIPSxm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Sep 2022 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiIPSxh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Sep 2022 14:53:37 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43E8B8A56;
        Fri, 16 Sep 2022 11:53:34 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id f20-20020a9d7b54000000b006574e21f1b6so6949073oto.5;
        Fri, 16 Sep 2022 11:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=E8mRtmh0ZzsQjaKh+D488C6qOln9Ah4mPyoUoY2TE9w=;
        b=rbcgMPoQJAowZ9iy0rhTDntlR5nkyomdj1DyQpDFpIe30A+uCRfT4BFdurAVFbHG0o
         C8JPRMNpovSSEhJiYouhNx0ePPSTyA+eWhHi13M0xyyn5nFkC+l5sBemTnvOrHpfsi5J
         W0Fnum/XL7Oe8J2r1XdKPrbh1eotPrijkC7jwCk2cUrBU2vjcbi/1CXOpgO3Dazpu3PM
         g5KQwe3QObKUpG8L/vT72GDMT9+FaKejGA58wusR8NLMzN5TNcs75XVTHD5SwqIP5AEH
         3GrDD2dNkXxCW++ZO3jEI8RejoYEStqs1ksGw527co9OZnCjMuPHi3GEhX+Dwg3n3bCi
         lHKQ==
X-Gm-Message-State: ACrzQf1vAFtj8fn0MEWds9WaA+FcNoM6ghiLdAc57taW1GQyhRHIJzse
        t3XYhbh7bq/uWyZD8sKlThvgV4UigQ==
X-Google-Smtp-Source: AMsMyM5AFwILdv3IQqqd4qSlmN9/82WPDnf1q9FSGkNo/D1wyypQpLsVmYmVm8E//U4QOJCvgAbTZA==
X-Received: by 2002:a9d:5c83:0:b0:656:9d4f:1447 with SMTP id a3-20020a9d5c83000000b006569d4f1447mr2889928oti.178.1663354413291;
        Fri, 16 Sep 2022 11:53:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm3648723oab.3.2022.09.16.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:53:33 -0700 (PDT)
Received: (nullmailer pid 1070364 invoked by uid 1000);
        Fri, 16 Sep 2022 18:53:32 -0000
Date:   Fri, 16 Sep 2022 13:53:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: dma: add additional pbus reset to
 qcom,adm
Message-ID: <20220916185332.GA1070331-robh@kernel.org>
References: <20220914140426.7609-1-ansuelsmth@gmail.com>
 <20220914140426.7609-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914140426.7609-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 14 Sep 2022 16:04:26 +0200, Christian Marangi wrote:
> qcom,adm require an additional reset for the pbus line. Add this missing
> reset to match the current implementation on ipq806x.dtsi.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,adm.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
