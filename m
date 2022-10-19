Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEE46047B0
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 15:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiJSNod (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 09:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiJSNoA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 09:44:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334291552F4;
        Wed, 19 Oct 2022 06:31:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CD26B823B2;
        Wed, 19 Oct 2022 13:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81588C433C1;
        Wed, 19 Oct 2022 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666186216;
        bh=2L2jeDsVN9w9kUdnBfgnFxJ5WxkNRtvWQ38M5+XfO/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIUPHmMcZWYt3OvMmRU/6acc8WNrgwHI/j40NvGwvaPYH4m8M7uDA/nf1NNshtW6o
         X6AyS/wMjWZ3X8M8vySGdL1wIoygXc5pzd+Ajjj0AQGU/C9PJ7p3qjs1CR1v8AlIYi
         4nLuu238p59ZORrMzteTWOg5rk6oWVymepGYuSyjw4H0ZFaqe1wQM9GH7S13Nn/WiL
         3QyuUYbVd+28HujNkqsBPEmkldVNCGPIc3gIsIrIBY/noy8118Ss0BaBKEO+emmRpq
         WlQjwsrnw8wBQ90AntiNw6zz/h1/dBQcqlszpet03zZHaXuX5iLemoXhB76pswnE4l
         ujVKLR0Fpba9A==
Date:   Wed, 19 Oct 2022 19:00:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: qcom: gpi: Add compatible for QDU1000
 and QRU1000
Message-ID: <Y0/75E7MqCpQml+I@matsya>
References: <20221014221102.7445-1-quic_molvera@quicinc.com>
 <20221014221102.7445-3-quic_molvera@quicinc.com>
 <15b50b09-ba8c-c93c-a5f8-7b0d4d12f223@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15b50b09-ba8c-c93c-a5f8-7b0d4d12f223@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-10-22, 09:42, Krzysztof Kozlowski wrote:
> On 14/10/2022 18:11, Melody Olvera wrote:
> > Add compatible fields for the Qualcomm QDU1000 and QRU1000 SoCs.
> > 
> > Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> > ---
> >  drivers/dma/qcom/gpi.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> > index cc938a31dc2d..02438735e92b 100644
> > --- a/drivers/dma/qcom/gpi.c
> > +++ b/drivers/dma/qcom/gpi.c
> > @@ -2286,6 +2286,8 @@ static int gpi_probe(struct platform_device *pdev)
> >  }
> >  
> >  static const struct of_device_id gpi_of_match[] = {
> > +	{ .compatible = "qcom,qdu1000-gpi-dma", .data = (void *)0x10000 },
> > +	{ .compatible = "qcom,qru1000-gpi-dma", .data = (void *)0x10000 },
> 
> The feedback was: drop entire patch.
> 
> There is really no need for this pattern to keep growing.

Right, I have picked the patches so you dont need to add yours to driver
file, please check dmaengine/next

-- 
~Vinod
