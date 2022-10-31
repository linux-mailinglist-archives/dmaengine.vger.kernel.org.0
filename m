Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC70614014
	for <lists+dmaengine@lfdr.de>; Mon, 31 Oct 2022 22:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJaVpK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Oct 2022 17:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJaVpG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Oct 2022 17:45:06 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196B1140D9;
        Mon, 31 Oct 2022 14:44:53 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id m204so2417605oib.6;
        Mon, 31 Oct 2022 14:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjxwkLQZ4tD75LnXvg548BEqZdFlUP3QqZ10JPMVReU=;
        b=BZqOSSwAgfdKxY/O1DDOAEYo30HU8t9mgb5pk9cs3SDJ2l/MqU0ziTCBMSnqQy7fth
         f2CUrs6Rtv6Gli2gCsuDLL5MLrACF5okpOBxcorQRm1RTPTJ/Epbia5B0+uCjF8IACKh
         oiqN2TUf03BrHn8B+1EFUyuiV2W+M1uj9ZvWfGmJIRwRqnVsZDGm6QqnntEkhrMj/BvM
         lbU30gUCb7+0qlaIFlaNxgyRowKdB5KcELBwkE0+VZDDYuTii1aMwYpvQcMSrqPcu4VP
         RZNHbBTSf6XT/VohFs41F0DvRZyTtrZFtMJnQ6R+OgojeFYZcrocexlA7FgVhgaGHtoI
         K3vg==
X-Gm-Message-State: ACrzQf2OgMm2i6qMMH7+PTmzGvEjHW0q31uhz3dvIjiV/sEFgXTmeykr
        V3rCOwXLvGjLCnto+0jeNizaQxcr3g==
X-Google-Smtp-Source: AMsMyM4FkjjF3koz07xQw5qHaDhFn1B7/s9//njaVGmLQtfJGo/aRGkm59Po/5eVIkIDKiMtBKRB6Q==
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id e3-20020a056808148300b00354a36e005bmr15884883oiw.35.1667252692254;
        Mon, 31 Oct 2022 14:44:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i3-20020a4addc3000000b0049201e2b8f4sm2806653oov.4.2022.10.31.14.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:44:51 -0700 (PDT)
Received: (nullmailer pid 3622272 invoked by uid 1000);
        Mon, 31 Oct 2022 21:44:53 -0000
Date:   Mon, 31 Oct 2022 16:44:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Adam Skladowski <a39.skl@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 3/8] dt-bindings: dmaengine: qcom: gpi: add compatible
 for SM6115
Message-ID: <166725269282.3622215.12274868256756111136.robh@kernel.org>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-4-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030094258.486428-4-iskren.chernev@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sun, 30 Oct 2022 11:42:53 +0200, Iskren Chernev wrote:
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Document the compatible for GPI DMA controller on SM6115 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
