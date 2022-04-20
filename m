Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69423508711
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbiDTLfU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiDTLfT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:35:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193234199E;
        Wed, 20 Apr 2022 04:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6DD8B81EAC;
        Wed, 20 Apr 2022 11:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACB0C385A1;
        Wed, 20 Apr 2022 11:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650454351;
        bh=ebFJKJg13z90XuDCP50Bg9XslvGPTWVfiEJ3o0iVhZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwY5GF3aL2QHqUnOr+CAhkh0EfUhYtfglg9goQAcGlsfMqTfB9kLun4SN1f+sznUc
         WQ7EZqYXJGJ3sZyspxgeHwbWdjDlsaEyAuCHVvvHwxlkC0hRAhsTSBFvXg8Zh5tUpI
         RSFpylwjg/X2y8txPj0EyJ1RT3yGk46cU1MUlfZM0Vl6uUblRfwHTmRvbzYtgjebjI
         kTmmA0u3QvErnJvIF6kBuL7c8n78Hm+vwSps+3nuH6H5tfxMuRIufPn5mJM756q97L
         uISzojOvIHt3tiae8CjQMPR2V2DkQSV5KcI5NgGyqXK0upEYCUIo7QtdV5JVjzK41w
         AxZBlUR95hfXA==
Date:   Wed, 20 Apr 2022 17:02:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: qcom: gpi: Add minItems for
 interrupts
Message-ID: <Yl/vSjdRe99if4Rd@matsya>
References: <20220414064235.1182195-1-vkoul@kernel.org>
 <0598d1bb-cd7c-1414-910c-ae6bedc8295d@linaro.org>
 <Ylf2gsJ+Ks0wz6i3@matsya>
 <9d35e76e-5d98-b2d8-a22c-293adcbaadf0@linaro.org>
 <Yl/iElIfHhmoOYOU@matsya>
 <e08a8f96-54a7-60be-0bd4-7a74fdcd627e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08a8f96-54a7-60be-0bd4-7a74fdcd627e@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-04-22, 13:11, Krzysztof Kozlowski wrote:
> On 20/04/2022 12:36, Vinod Koul wrote:
> >> If the choice is per SoC-controller, then the best would be to limit in
> >> allOf:if:then. However maybe the number of channels depends also on
> >> other factor (e.g. secure world configuration)?
> > 
> > That is quite right. So we wont know how many channels are made
> > available..
> > 
> > So is min 1 acceptable or do you have an alternate ?
> 
> minItems:1 is ok.

Thanks, can I get an ack?

-- 
~Vinod
