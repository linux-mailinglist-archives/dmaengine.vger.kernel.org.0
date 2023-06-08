Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045FD728011
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jun 2023 14:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjFHMcc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Jun 2023 08:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjFHMcb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 8 Jun 2023 08:32:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AAAE43;
        Thu,  8 Jun 2023 05:32:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A54E61846;
        Thu,  8 Jun 2023 12:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42B0C433D2;
        Thu,  8 Jun 2023 12:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686227549;
        bh=r/4PkU/68uF7lKPzBCrmdgapCjizIDkg+xcFVkYgySA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bdFjKVnf5dbKmuzzaVnJeFbvAsXl9DObq6ABi1c57cMksyu32dwik3M6M90T2kncE
         tavsbDVCuezHRFk0z4j7xUCi633VEdKXpErlip+5IvoyrYcqsqggbeEsdMrfCGrNZQ
         IDUxuIR3vs6Id91ldSrCfohV/CPHbTyef74JXnDxjAZQeAV8cJBzyzxhI0d1zxylK0
         gH8M6961qZzW5QmfZm/iy5WQGr0yhaOiLlOMlrCkFi/uaxlY/9MNpZQtgMGNNWAlDL
         R3CDp3jghBlBF654pxVl2etHgbuFxYIHq9rt7kNa7QmyxoWnOUKQpoTYKT+Q8o6GeJ
         6vTFRmrwQAKAA==
Date:   Thu, 8 Jun 2023 18:02:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org,
        stephan@gerhold.net, Rob Herring <robh@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH v8 01/11] dt-bindings: dma: Add support for SM6115 and
 QCM2290 SoCs
Message-ID: <ZIHKWYMs1e/rOez0@matsya>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
 <20230526192210.3146896-2-bhupesh.sharma@linaro.org>
 <CAH=2Ntx+4F+ZP_Y+=e4p9rdTRQV8FHaepJCyqVFtWUPjDehoNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2Ntx+4F+ZP_Y+=e4p9rdTRQV8FHaepJCyqVFtWUPjDehoNg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-05-23, 11:43, Bhupesh Sharma wrote:
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

I dont have this series in my inbox or dmaengine pw

> Seems some Cc fields got messed up while sending the patchset, so
> Cc'ing the dmaengine list again.

not just list but mine too..

Please rebase and resend

-- 
~Vinod
