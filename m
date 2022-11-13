Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D816272E3
	for <lists+dmaengine@lfdr.de>; Sun, 13 Nov 2022 23:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiKMWZU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 13 Nov 2022 17:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiKMWZT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 13 Nov 2022 17:25:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458B263CB;
        Sun, 13 Nov 2022 14:25:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3B4E60B7F;
        Sun, 13 Nov 2022 22:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F47EC433C1;
        Sun, 13 Nov 2022 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668378318;
        bh=YghBRJSIPSdrfxV+VciUWwjS4Z4W7JjYjgiJ4lFXMvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXrnFKbUhrTba84/HGb0KHqqtOd8uxorILvYMNCIgUEB7/tcTi8W6ahtMFS6iNcYU
         SYIV3JcZTnkENWj6n/aMq4xKfEOBHDi/vrhVwc/uIaSmWzivZJCRl5LfYYD48XqyrC
         RFL4n83p0JH3pzQuOzTthu4XRtdIsK6N613Pex0Oiw+pYzZAUzcZSrxf3UlX4zCe8u
         GwxZIbw1DrtxKSfHHr6Jbug0oss94xX/b8/Bwh1pCLydTfazyY3R1oOUxEHq36YYGS
         GEW0+gHBPjS+lxcM9aqTkEZm49/UucfEC7N3e7+yN/U9bESczvV3ONfngEVFdxSSQs
         skSK1D2UHkSlQ==
Date:   Mon, 14 Nov 2022 03:55:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: dmaengine: qcom: gpi: add compatible
 for SM6375
Message-ID: <Y3FuyiQzsaWybwWz@matsya>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
 <20221109111236.46003-3-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109111236.46003-3-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-11-22, 12:12, Konrad Dybcio wrote:
> Document the compatible for GPI DMA controller on SM6375 SoC.

Applied, thanks

-- 
~Vinod
