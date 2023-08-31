Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0454978F26B
	for <lists+dmaengine@lfdr.de>; Thu, 31 Aug 2023 20:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346872AbjHaSUU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Aug 2023 14:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343507AbjHaSUU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Aug 2023 14:20:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EC8E6B;
        Thu, 31 Aug 2023 11:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EFACCCE201B;
        Thu, 31 Aug 2023 18:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DC9C433C8;
        Thu, 31 Aug 2023 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693506012;
        bh=7WZI1mZEAh514Sx8f5fF5/Wrmape0Upa19isw5zY/KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKvJ4sKl6IpJTyTUlBUin9PMewbFd3/btKqOkBv7/kNsKJqy93lhMvBKt2YxKD6gl
         QUYdrgZGqcIITI8Eg6E5a7LgzhimMq1DG6nd9YtsmxQCRD78QaXnBXxFGHEsaMkaMa
         xVxLg9TouCBR0XBS3CiGIB9oYTtPZPlb3y/4Xoc6P+AMENWJJO4c8plKwxQTyriRwL
         8jU7mgpbCAkRe5IZCkICompyodmRuH/aWOeOzxZkgdNn7dpr+qLXzRjGB0p9GmNLcG
         XnVCYH0uyMXFXO7SLVdjv/mxULzcb5GZeb77v19QuF1Ey6OSdj7RfItFRdhBgJn4A9
         FUEI3iVPSdGQw==
Received: (nullmailer pid 2540904 invoked by uid 1000);
        Thu, 31 Aug 2023 18:20:04 -0000
Date:   Thu, 31 Aug 2023 13:20:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: dmaengine: qcom: gpi: Allow dma-coherent
Message-ID: <169350600377.2540849.5971761743710979201.robh@kernel.org>
References: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
 <20230830-topic-8550_dmac2-v1-1-49bb25239fb1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-topic-8550_dmac2-v1-1-49bb25239fb1@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 30 Aug 2023 14:48:40 +0200, Konrad Dybcio wrote:
> On SM8550, the GPI DMA controller is coherent with the CPU.
> Allow specifying that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

