Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C752DB51
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242429AbiESRar (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbiESRac (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90D2BA565;
        Thu, 19 May 2022 10:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 498F3612B7;
        Thu, 19 May 2022 17:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2245AC385AA;
        Thu, 19 May 2022 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652981350;
        bh=P1Zqc1KogFjCAZ5CvE8ZXLD/+8kI8DleGHyGq0Ks1hQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYeThdeFCXY3TiqOtuL2uvXh00bdSAwmm1atW+KVVxeO5AsxUAkX11gDyJ6AQSUhj
         axQ7z/5Bum+L8aJvFMUP60IkPVUOxgJmfo6uydcPe0xjKJY5/tpqeAkxIUmhRtSJOR
         NJtwqEBM/i5g9MOeVs6gADaRzFn1djWdoyuT9nXz9aB0l85oS1WxrSfgCVXUnUiTEC
         hPHRTt7AO1NeCKGkfGK75gpA3tZeWB3mTfqXD3d8Z/xj8F58RElCi7Hj4/LJ5Dxr+d
         /tO2gHyfqAcl6iwZcvuHhHM3/B/spUO6rUKV4zdOAEpuTpQ+90UbdAzCdYI4Mio28S
         7uI0kE6pvACuw==
Date:   Thu, 19 May 2022 22:59:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: pl330: Add power-domains
Message-ID: <YoZ+Ylfu8l51cJl5@matsya>
References: <20220427064048.86635-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427064048.86635-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-04-22, 08:40, Krzysztof Kozlowski wrote:
> The pl330 DMA controller on Exynos SoC (e.g. dma-controller@3880000 in
> Exynos5420) belongs to power domain, so allow such property.

Applied, thanks

-- 
~Vinod
