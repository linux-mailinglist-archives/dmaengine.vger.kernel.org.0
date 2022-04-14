Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605A6500B08
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiDNK2Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbiDNK1j (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 06:27:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BFC6C94D;
        Thu, 14 Apr 2022 03:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12164B82893;
        Thu, 14 Apr 2022 10:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1574BC385A5;
        Thu, 14 Apr 2022 10:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649931911;
        bh=ng1Q70SgjCwX1SpN3Nel10OKN/RIdygk7E6v7+91XKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XoDrMFCmgB05vL1RkeyygBoyUreaPJaBwTlXdODyGe2QGsgJDWxXGhBRZIZbZM9Qx
         +WwGjIluBjWWNsqUwiS+nf7cyYL9DkF5MZUuACtOR5BcsILqBbjyfXdQj4zjXuNZfX
         l3aUGNs+xU7Ep94iluERMqtRD24mP24FtPbaozFO70n5TSQwU0y6B+DlTS8NeRMwaa
         spgUHMF0xDRhcRE34JLtogtxV98EMsJFWMPogYWWfvQO01nmyIX8ivQX0afxjv2e0F
         plj2S9BpDf9Xxtwndv6HnkTQaVZ4RNq1Pz8Uz+FetcHU3G8UNoO8zmWwz7N7NCU60B
         d/Zc5bI06YIAw==
Date:   Thu, 14 Apr 2022 15:55:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: qcom: gpi: Add minItems for
 interrupts
Message-ID: <Ylf2gsJ+Ks0wz6i3@matsya>
References: <20220414064235.1182195-1-vkoul@kernel.org>
 <0598d1bb-cd7c-1414-910c-ae6bedc8295d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0598d1bb-cd7c-1414-910c-ae6bedc8295d@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-04-22, 09:36, Krzysztof Kozlowski wrote:
> On 14/04/2022 08:42, Vinod Koul wrote:
> > Add the minItems for interrupts property as well. In the absence of
> > this, we get warning if interrupts are less than 13
> > 
> > arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb:
> > dma-controller@800000: interrupts: [[0, 588, 4], [0, 589, 4], [0, 590,
> > 4], [0, 591, 4], [0, 592, 4], [0, 593, 4], [0, 594, 4], [0, 595, 4], [0,
> >   596, 4], [0, 597, 4]] is too short
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> > index 8a790ffbdaac..7d2fc4eb5530 100644
> > --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> > +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> > @@ -32,6 +32,7 @@ properties:
> >    interrupts:
> >      description:
> >        Interrupt lines for each GPI instance
> > +    minItems: 1
> 
> This should be some real case minimum, not just 1. Unless really only
> one interrupt is also possible in existing variations?

So that depends on the channels available to use which can be worst case
of 1. Maximum is 13.. Most of the controllers are between 12-13, but we
dont want to change binding in future if controller has lesser channels
right?

-- 
~Vinod
