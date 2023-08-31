Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981A878F26F
	for <lists+dmaengine@lfdr.de>; Thu, 31 Aug 2023 20:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbjHaSUZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Aug 2023 14:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346889AbjHaSUY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Aug 2023 14:20:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B836EE64;
        Thu, 31 Aug 2023 11:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 249E1B82347;
        Thu, 31 Aug 2023 18:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA0BC433C7;
        Thu, 31 Aug 2023 18:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693506018;
        bh=VMnBjyrMJOvmmAgU2WXJPR+bylx7hdXAwRuW/89n7us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuDRQpPJLpUetJX+eu1xAKM5tG6Nw3ZT2OB//CZahw4n25KWDRhYSpQW8Ko2pmTsM
         f0H+bZKp8Ibnbs+cLX2bMC7p8tuNw8hXUkqeDhOxJexaMIbvWGpQ9+TdE09B4clgc/
         9MNzk2bdlT6hBgPEbSSRsdQZOYDaluoErXaBRpQB7lldEiUasU629p4ufwq+QPM/ov
         wcfJDuUdbF7YymifoaQchIBwu1ZGH9MLLxEOyjiQ7AWbpUvh6ZUslE7b5U2ZpOgmCw
         crOol2oqxAkzCxIJ0d3hPqMDDj7GTjkkop1Vss5/jqqxus4GI3AEbJY7OjCxmvOcxr
         Oxl2L0rOjoxEQ==
Received: (nullmailer pid 2541286 invoked by uid 1000);
        Thu, 31 Aug 2023 18:20:16 -0000
Date:   Thu, 31 Aug 2023 13:20:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dmaengine@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: qcom: geni-se: Allow dma-coherent
Message-ID: <169350601590.2541228.13173749815664428921.robh@kernel.org>
References: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
 <20230830-topic-8550_dmac2-v1-2-49bb25239fb1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-topic-8550_dmac2-v1-2-49bb25239fb1@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 30 Aug 2023 14:48:41 +0200, Konrad Dybcio wrote:
> On SM8550, the QUP controller is coherent with the CPU.
> Allow specifying that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

