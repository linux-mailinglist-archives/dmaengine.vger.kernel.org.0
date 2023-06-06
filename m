Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD49723B17
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jun 2023 10:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbjFFIOk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Jun 2023 04:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjFFIOj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Jun 2023 04:14:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6F9123
        for <dmaengine@vger.kernel.org>; Tue,  6 Jun 2023 01:14:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30aef0499b6so4553061f8f.1
        for <dmaengine@vger.kernel.org>; Tue, 06 Jun 2023 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686039275; x=1688631275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wqPSXg+U3/mqumv4DLK+ARpYMO1ucj61S84Jur+Gv2g=;
        b=TTPlictXVmZ5tqtY4akUrDhkVQeIud6WSXHw/bU1EDNwRXbrMsN957b54Cvne9yOV1
         IrC91M+HfOjLR2JGN/V6f2mvuzH4DjY/ibzm3OYtmMTUb2JEhScV3v/cgcQTbGLSpSad
         V1DG9sRo1nYrTDyxOUJAFFkWhfhVd3k36NujJmHCQB2RyO518CJf9CHewxp90CaUmt1f
         3pDG44OiBBV2zOH+ucE6Cw5AZi8u106tvRIoEFKskFwlfYC3RUPEZqzzuWf4BSbb3CvI
         lHzCE7eG315aIanRfUMuRqvcpvtpJxbkUAXfIQTp6pF1MjEHZDvpc9aC/bMM6jcswFNM
         NORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686039275; x=1688631275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqPSXg+U3/mqumv4DLK+ARpYMO1ucj61S84Jur+Gv2g=;
        b=MVkgP+n47G7Dh3GhQvvTjTNO8G0QeoybSYMxQn8NLWVyJ+0G+yWfDtE83Uvw/U9/7W
         2ipgZ9e9TF4elHjoJVzz4OEKocUVRJOtMdXCY61qMWb9xQH90dGQqyPAwWItAUis+NYL
         Xy4pVgVwzwEAs67jp6lPiHllqsUL6lsx/jscGD4bW1UW5mw8ZXhUR/59ONnGcYJkxyBU
         v+t6ogvf2bwLKGe5D3iPxqReNbxy1i2S9qMVuE89vB9ndKtPMrnNGZRKY2EQyrj1zPy9
         NUDvkMt0z6+VGCKN/TWroWbt1mAUAdiykwe/Z2e3j4vXYZ/MyDYZiZVun6nHc6kdA8X2
         /W0g==
X-Gm-Message-State: AC+VfDwDzxXukaGWrvztw3WEjCZihJBaGecBJ6GOE8VONMYEiQGC8O2p
        54AyGtyk5F1Po49M/B53GJsMRohEIJCwiNHADEoccg==
X-Google-Smtp-Source: ACHHUZ6VImNGGQl2NaxY9/WnzShy/0LQDDx4D6J0k26DamuInCHztTXzBb18rk47JEmCH5DzticzJurf3qgSJn3LYSY=
X-Received: by 2002:adf:e38d:0:b0:2cd:bc79:5432 with SMTP id
 e13-20020adfe38d000000b002cdbc795432mr1296543wrm.25.1686039275555; Tue, 06
 Jun 2023 01:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
 <20230526192210.3146896-2-bhupesh.sharma@linaro.org> <CAH=2Ntx+4F+ZP_Y+=e4p9rdTRQV8FHaepJCyqVFtWUPjDehoNg@mail.gmail.com>
In-Reply-To: <CAH=2Ntx+4F+ZP_Y+=e4p9rdTRQV8FHaepJCyqVFtWUPjDehoNg@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 6 Jun 2023 13:44:23 +0530
Message-ID: <CAH=2NtzAmza2f89dPx_7yiaUU9g5hNervg1pjQvRakadDph2Ew@mail.gmail.com>
Subject: Re: [PATCH v8 01/11] dt-bindings: dma: Add support for SM6115 and
 QCM2290 SoCs
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org, djakov@kernel.org, stephan@gerhold.net,
        Rob Herring <robh@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 29 May 2023 at 11:43, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Hi Vinod,
>
> > On Sat, 27 May 2023 at 00:52, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> >
> > Add new compatible for BAM DMA engine version v1.7.4 which is
> > found on Qualcomm SM6115 and QCM2290 SoCs. Since its very similar
> > to v1.7.0 used on SM8150 like SoCs, mark the comptible scheme
> > accordingly.
> >
> > While at it, also update qcom,bam-dma bindings to add comments
> > which describe the BAM DMA versions used in SM8150 and SM8250 SoCs.
> > This provides an easy reference for identifying the actual BAM DMA
> > version available on Qualcomm SoCs.
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> > Tested-by: Anders Roxell <anders.roxell@linaro.org>
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  .../devicetree/bindings/dma/qcom,bam-dma.yaml | 20 ++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > index f1ddcf672261..c663b6102f50 100644
> > --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > @@ -15,13 +15,19 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    enum:
> > -        # APQ8064, IPQ8064 and MSM8960
> > -      - qcom,bam-v1.3.0
> > -        # MSM8974, APQ8074 and APQ8084
> > -      - qcom,bam-v1.4.0
> > -        # MSM8916 and SDM845
> > -      - qcom,bam-v1.7.0
> > +    oneOf:
> > +      - enum:
> > +          # APQ8064, IPQ8064 and MSM8960
> > +          - qcom,bam-v1.3.0
> > +          # MSM8974, APQ8074 and APQ8084
> > +          - qcom,bam-v1.4.0
> > +          # MSM8916, SDM630
> > +          - qcom,bam-v1.7.0
> > +      - items:
> > +          - enum:
> > +              # SDM845, SM6115, SM8150, SM8250 and QCM2290
> > +              - qcom,bam-v1.7.4
> > +          - const: qcom,bam-v1.7.0
> >
> >    clocks:
> >      maxItems: 1
> > --
> > 2.38.1
>
> Bjorn has applied the dts patches from this series to his tree.
> As suggested by him, can you please pick patches [PATCH 1/11] and
> [PATCH 2/11] from this series via the 'dmaengine' tree.
>
> Seems some Cc fields got messed up while sending the patchset, so
> Cc'ing the dmaengine list again.

Ping. Any updates on these two patches?

Thanks.
