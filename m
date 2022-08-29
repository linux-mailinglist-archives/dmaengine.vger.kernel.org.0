Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E484B5A5651
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 23:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiH2Vmh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 17:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiH2Vmg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 17:42:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777677C509;
        Mon, 29 Aug 2022 14:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5ED4B81210;
        Mon, 29 Aug 2022 21:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FC1C433C1;
        Mon, 29 Aug 2022 21:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661809352;
        bh=MsyOWASI1g4z1h2BMPcGA+iFSFPUPWSag4GkwTQTTr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfUPeOL0oxsol1pgs+1ZKtB1/6OBBiKCodFruY4XdnN/DAWYdBMIuLDcOs4kDTd4M
         BmAjVtAlN/S6RjR31cvtb+Xp8vT2zZSZlX+R7wkXB1xwSrMCf/R0c2YCIGdMmBlYL/
         ST0XtrZUyJd1LFOb/+7P180jbCcC3BSdf7chgDttsYspezm/5sYHQYnGIVjB7h1wfV
         s5UEVk20vwHGh8aKAtqr3EuNje77DcqQlRHj9FW16ekj7D2rBCpBMjecyDL1FGkhNt
         FI7TB+zavJ+Y2U4SLjoWX6mpSWMHdoXgHhHu5I8yDEyRIP0vsZdj3VCYp8KIwzVmdV
         nYs0egWRFmMyg==
Date:   Mon, 29 Aug 2022 16:42:29 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: qcom: gpi: add compatible
 for SM6350
Message-ID: <20220829214229.zs264vapq4hxmdpz@builder.lan>
References: <20220812082721.1125759-1-luca.weiss@fairphone.com>
 <20220812082721.1125759-2-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812082721.1125759-2-luca.weiss@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Aug 12, 2022 at 10:27:19AM +0200, Luca Weiss wrote:
> Document the compatible for GPI DMA controller on SM6350 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> index 7d2fc4eb5530..eabf8a76d3a0 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -21,6 +21,7 @@ properties:
>      enum:
>        - qcom,sc7280-gpi-dma
>        - qcom,sdm845-gpi-dma
> +      - qcom,sm6350-gpi-dma
>        - qcom,sm8150-gpi-dma
>        - qcom,sm8250-gpi-dma
>        - qcom,sm8350-gpi-dma
> -- 
> 2.37.1
> 
