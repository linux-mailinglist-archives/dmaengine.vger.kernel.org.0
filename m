Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B804C5EEF5B
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 09:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiI2Hl3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 03:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiI2Hk6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 03:40:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7C121116;
        Thu, 29 Sep 2022 00:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8F20B8220A;
        Thu, 29 Sep 2022 07:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CFCC433C1;
        Thu, 29 Sep 2022 07:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664437242;
        bh=C2emNc0NAZeHrems5nNVYRQ4SMC2epBUFyJLM2zmGmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9BEhHgjvuv4D6muqvt5Pkw9paqZhAL7cFaBdyPd/SR4timbLw5eh25nw+lEa5O2e
         vwz+GstAWGi5dtaKYnk+URjtXIpyKwwuRHxWIzq9rAKDjxMIiRR8E8Pk8QB/EK7IHS
         FbKPLVW1Fbm34B3HbNLApoa2A9cWy1QrIiIHL9PfdXEmVqwOFbG1dWXHjzJS30PXeL
         qaGHKpxoCkKXgCe8CD0XCRcZ10hknMDckSpsK6aX3zuraRPk37cvI74s1wUGGG87vG
         kwSJ6KWxej+R0Iu/6f91rhuP/qB4xWW/DHJolj/XMBulcSC4IWr5UBkXbUvNyJ0QQO
         5N7i3Ghm9ER6w==
Date:   Thu, 29 Sep 2022 13:10:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] dmaengine: qcom: gpi: drop redundant of_device_id
 entries
Message-ID: <YzVL9ngfwqfwhF8Q@matsya>
References: <20220927014846.32892-1-mailingradian@gmail.com>
 <20220927014846.32892-5-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927014846.32892-5-mailingradian@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-09-22, 21:48, Richard Acayan wrote:
> The drivers are transitioning from matching against lists of specific
> compatible strings to matching against smaller lists of more generic
> compatible strings. Continue the transition in the GPI DMA driver.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/dma/qcom/gpi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 89839864b4ec..e5f37d61f30a 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -2289,8 +2289,6 @@ static const struct of_device_id gpi_of_match[] = {
>  	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
>  	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
> -	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
> -	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },

We cant do this without breaking stuff...

There are DTs which have this id!

>  	{ .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
>  	{ .compatible = "qcom,sm8450-gpi-dma", .data = (void *)0x10000 },
>  	{ },
> -- 
> 2.37.3

-- 
~Vinod
