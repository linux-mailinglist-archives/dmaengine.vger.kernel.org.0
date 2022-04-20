Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731A850860D
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 12:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiDTKiy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 06:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377720AbiDTKix (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 06:38:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0083FBD6;
        Wed, 20 Apr 2022 03:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 596BD617CC;
        Wed, 20 Apr 2022 10:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029CDC385A0;
        Wed, 20 Apr 2022 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650450966;
        bh=fTs96CqjvphFVKpX75orr/aEaWullDZzBRJGRDTh33s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asPD7GobM/w/uudIAIu8VzMwwEIoHsYwLLYYgCYAn1FwVfD1UucQdocoyxItb/pbs
         +YSHC+0N2mmebNHxTuq2+OeBi3bLJvdASN8taaeYRrSzjSXemLwJVyYp9jKvgaAU4d
         nSMcxvWwgL551aMxyp4Fgng92MOmrItgoNNC4Gqj+p0wEiFSsmjLKRoZdqDOE3/GJZ
         fo3IYHoyVkiRerR5vg1HDzviQf/oGslXvGQR5SpPmfNwpiDi3ZPbuKICJY6GycTahi
         n0DV5xsB6Oq0oEdDSyk0NmezfE/k0W8eUaDnQ5mtbulXKNLVhAAruhOczpOVlyJBzk
         ySn3oHojwZKaw==
Date:   Wed, 20 Apr 2022 16:06:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: qcom: gpi: Add minItems for
 interrupts
Message-ID: <Yl/iElIfHhmoOYOU@matsya>
References: <20220414064235.1182195-1-vkoul@kernel.org>
 <0598d1bb-cd7c-1414-910c-ae6bedc8295d@linaro.org>
 <Ylf2gsJ+Ks0wz6i3@matsya>
 <9d35e76e-5d98-b2d8-a22c-293adcbaadf0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d35e76e-5d98-b2d8-a22c-293adcbaadf0@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-04-22, 13:44, Krzysztof Kozlowski wrote:
> On 14/04/2022 12:25, Vinod Koul wrote:
> >>>        Interrupt lines for each GPI instance
> >>> +    minItems: 1
> >>
> >> This should be some real case minimum, not just 1. Unless really only
> >> one interrupt is also possible in existing variations?
> > 
> > So that depends on the channels available to use which can be worst case
> > of 1. Maximum is 13.. Most of the controllers are between 12-13, but we
> > dont want to change binding in future if controller has lesser channels
> > right?
> 
> If the choice is per SoC-controller, then the best would be to limit in
> allOf:if:then. However maybe the number of channels depends also on
> other factor (e.g. secure world configuration)?

That is quite right. So we wont know how many channels are made
available..

So is min 1 acceptable or do you have an alternate ?

-- 
~Vinod
