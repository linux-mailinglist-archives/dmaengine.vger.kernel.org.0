Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D5451B774
	for <lists+dmaengine@lfdr.de>; Thu,  5 May 2022 07:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbiEEFcy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 May 2022 01:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiEEFcy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 May 2022 01:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199701EAE0;
        Wed,  4 May 2022 22:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A232461ACF;
        Thu,  5 May 2022 05:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB9EC385A4;
        Thu,  5 May 2022 05:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651728555;
        bh=UmiWNST85xlrXdo4LctqgdbyGWV/UwCAEFb8UlVuBd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMKs+g2Mxqjadb/yY8CjrRQeFLzc72G56i5yYg7RZa1SwzMeeT4PKYb1j6m0/9jxx
         0Bfef26O7JHvOZvF84GOMzv8ssTJr6k9UQEel1meeZqzzq1qgZn/uHD08yZHFqB+vs
         C9XS8kt3XmsGl3QWR+uOy4OL9IoI49Yb+oNI+uMjXCDrRKZcQZjQY1U+Lc9JNqgAMf
         0pBBo5E9jd0BQIyUwQ1ktb2x8VATFpKM4F5lKkAOO0CyoAN9Qa2+Y1smUaGbzmywoS
         Aov1zCF10bHTcRnu36iVGQUZqmIJHwkQxkVy9fdn1d65/o9uYQZjT6goOEDuOjPV8N
         ykHxZWS/2fJkw==
Date:   Thu, 5 May 2022 13:29:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: fsl-imx: deprecate
 '#dma-channels' and '#dma-requests'
Message-ID: <20220505052907.GX14615@dragon>
References: <20220427161533.647837-1-krzysztof.kozlowski@linaro.org>
 <20220427161533.647837-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427161533.647837-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 27, 2022 at 06:15:32PM +0200, Krzysztof Kozlowski wrote:
> The generic properties, used in most of the drivers and defined in
> generic dma-common DT bindings, are 'dma-channels' and 'dma-requests'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
