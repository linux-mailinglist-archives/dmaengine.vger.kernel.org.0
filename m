Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40156F0B13
	for <lists+dmaengine@lfdr.de>; Thu, 27 Apr 2023 19:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244102AbjD0Rko (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Apr 2023 13:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244281AbjD0Rkm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Apr 2023 13:40:42 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04187468F;
        Thu, 27 Apr 2023 10:40:13 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1879e28ab04so7061787fac.2;
        Thu, 27 Apr 2023 10:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682617190; x=1685209190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp/j3I3sONtLooZJ2ZhetrqGxDwLVuI0JCZmItKp+34=;
        b=AILdVA+fnsujpIS56mIdazPXLoqXXO4nsk/9ubzXZdzID/55SZIplz4rbOcTD77/Oc
         jsiMn1fsDgVJ5TeXJ4USij7gfF8nt7di2D9xofX2rGkK1lL0LXSMR8iM5nfRVLgjAKjb
         kv73nKhZJ8XJFP+kJqd+TmbPDEpZ770BmpI+SXIoNf+es1T9LDTrrCmjGe61XEU8jw8b
         +oNLVCyKrs3M29wCx2MFpWTKnrcz5QH+WBjGlovNWt6GzoZh865gF67Cti4QTaj3nkZ/
         aqYR7W7mcN5zHGZOasxgMq5IHaXWNY81I0U/mHqvvsuCOk9SeGXfeiD5gXmAsQcC8W9b
         N9dQ==
X-Gm-Message-State: AC+VfDx2S0cCn+Uc1jySTWbYFQtdcSa7CIor01zri+mZy801cMReQsFE
        FqB6JJHlF4SxL9pyqQddbB6RwGynUQ==
X-Google-Smtp-Source: ACHHUZ5ZOl3xNe6CmiHnwhpZsA4e/G9yG2SqbFP7NvA7SwlRkqLC5OQxjafdjg1OZn3oT+MR2nkmPA==
X-Received: by 2002:a05:6870:44c3:b0:18e:f8e9:a6a8 with SMTP id t3-20020a05687044c300b0018ef8e9a6a8mr1081422oai.38.1682617190082;
        Thu, 27 Apr 2023 10:39:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b6-20020a056830104600b0068bd922a244sm8317143otp.20.2023.04.27.10.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:39:49 -0700 (PDT)
Received: (nullmailer pid 3210298 invoked by uid 1000);
        Thu, 27 Apr 2023 17:39:49 -0000
Date:   Thu, 27 Apr 2023 12:39:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/8] dt-bindings: dma: dma40: Prefer to pass sram
 through phandle
Message-ID: <168261718864.3210243.12337547291845541745.robh@kernel.org>
References: <20230417-ux500-dma40-cleanup-v2-0-cdaa68a4b863@linaro.org>
 <20230417-ux500-dma40-cleanup-v2-1-cdaa68a4b863@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417-ux500-dma40-cleanup-v2-1-cdaa68a4b863@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 27 Apr 2023 14:09:56 +0200, Linus Walleij wrote:
> Extend the DMA40 bindings so that we can pass two SRAM
> segments as phandles instead of directly referring to the
> memory address in the second reg cell. This enables more
> granular control over the SRAM, and adds the optiona LCLA
> SRAM segment as well.
> 
> Deprecate the old way of passing LCPA as a second reg cell,
> make sram compulsory.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Enumerate phandles using inner and outer maxItems as specified
>   by Rob.
> - Drop quotes around reference.
> ---
>  .../devicetree/bindings/dma/stericsson,dma40.yaml  | 36 +++++++++++++++++-----
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

