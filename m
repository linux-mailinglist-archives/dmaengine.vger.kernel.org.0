Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B211760464B
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 15:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiJSNGR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 09:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiJSNGC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 09:06:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EEA18B766;
        Wed, 19 Oct 2022 05:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A970CB823CD;
        Wed, 19 Oct 2022 12:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DC3C433B5;
        Wed, 19 Oct 2022 12:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666183769;
        bh=YE9JgLLLQcGSzyeupSVS0hxeagJWUUGzlvzc9Jis9Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRsWHDZJ/RB9cFDgaAseVj4gLmNkQZ5gYS6DeY2NtGmY+a8ZYhKlOTnUv8WaW3ZZW
         g6W/2FIn7gk2S2OLuuSI6wyOqUVNfVsJsz+SD2/A5lMJktNlRiBAzOQ80JWY+SLkUv
         4/gBOVThe1C1Ff+dllDOcM5ATYc0F5U/BOQMylB1vLhRPHT3ngh1ClHeaolEb2ezGU
         cQWyg2DsVds2htjMN52E7o8LF6pYP00YjfjNu06fyDrDWydTXyb0GtrsUJhNG1/f8K
         4uW1iWMiIWPA0Cs6PRrf9lYqmk2kUf4PjuCRoSGPggGWrtsTptW7lzmIbDtZxocZVv
         QM+R/3sBTYO9A==
Date:   Wed, 19 Oct 2022 18:19:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] dma/arm64: qcom: use one compatible also for
 0x10000 offset
Message-ID: <Y0/yVdVaZ0PNSRPN@matsya>
References: <20221018230352.1238479-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018230352.1238479-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-10-22, 19:03, Krzysztof Kozlowski wrote:
> Hi,
> 
> Dependencies
> ============
> 1. DT bindings and DMA driver change depends contextually on:
>    https://lore.kernel.org/all/20221018005740.23952-1-mailingradian@gmail.com/
> 
> 2. DTS patches are independent, although they will spark some dtbs_check
>    warnings (due to change in bindings).

Applied 1-2, thanks

-- 
~Vinod
