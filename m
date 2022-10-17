Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CCF601655
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 20:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJQSdG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 14:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJQSdF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 14:33:05 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8419774E06;
        Mon, 17 Oct 2022 11:33:04 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id w196so13066755oiw.8;
        Mon, 17 Oct 2022 11:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49WpkNDVrip5fI/9/zV16EJNvnec5IuQPlP82K1xqzM=;
        b=pgBYPpCVh2KfWlqI/x+Yjp/ljtbf8TGi5uRZ40ho1nT6CjCFZXE68hPtXKjqnt3PFT
         kkoCJ+rkmELGhGyCGHTBWF4JN6fI0VKe2AM40QIQmub7z0u2sGKYWij5+0CmuzS1Yi17
         A+kEaShjpjVfd5ieS9KkTcmReWI9+E2ERE9ilBzp3NyZiOehZBWDR5APb6bJI+HYy4Kx
         hYWmwU0jFAuKQRwICUfA2FWp0QIGJS6nRlyl29k9Z4o2xXzzzj5W1MjdmYvibkpCpUBi
         GnQ2KarTKL/8TGGkLLk4lJk7BfxQwzmPkuc8MroqF5bJw/CAS0G+teWo05LXOGAWVGEM
         3BGQ==
X-Gm-Message-State: ACrzQf2tZ8jazulz5wcem8PJ9+N4GCBkPJIuSGIq0upWdUAcjgcGfNyM
        Fn5Qz0sSc7XFZJ4UP17BTw==
X-Google-Smtp-Source: AMsMyM6wpiGBJ7Nr9Jr0ug/bqmYluBy4dI7rW6n3Mn9v3PbpUw14yNsxn+X7CkEsHTMFgFuOPfRd1Q==
X-Received: by 2002:a05:6808:1301:b0:355:2687:a035 with SMTP id y1-20020a056808130100b003552687a035mr5339009oiv.162.1666031583729;
        Mon, 17 Oct 2022 11:33:03 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x8-20020a056830408800b0065c2c46077dsm4972675ott.67.2022.10.17.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:33:03 -0700 (PDT)
Received: (nullmailer pid 2253317 invoked by uid 1000);
        Mon, 17 Oct 2022 18:33:03 -0000
Date:   Mon, 17 Oct 2022 13:33:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: dma: qcom: gpi: use sm6350 fallback
Message-ID: <166603158304.2253260.12930815520486063893.robh@kernel.org>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org>
 <20221015140447.55221-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221015140447.55221-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, 15 Oct 2022 10:04:43 -0400, Krzysztof Kozlowski wrote:
> Several devices like SM6350, SM8150 and SC7280 are actually compatible,
> so use one compatible fallback for all of them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
