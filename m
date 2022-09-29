Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965315EFA85
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiI2Qbf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 12:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiI2Qb2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 12:31:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F37514C9D0;
        Thu, 29 Sep 2022 09:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F5A8B82547;
        Thu, 29 Sep 2022 16:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFCDC433C1;
        Thu, 29 Sep 2022 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664469081;
        bh=m/ihyg+6/QviLbrF/OUEZsfQ9lsN0rCuzODFHQsvoso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujm6lUIYEoDBW5zdIPQLQ6/6zCRoIRlVRW071g3XlmPUe3cxEhIOn5+pGEdT4MF1N
         kRD4I5LbTzmuQPeNpuTHGuwZ2TGYI2TOonA8Osl3XeVSvqWtjRzH31wGHRqboqR6qS
         taH0SZ8VPH1T9DDBDRC5tG+GBb08B/ChjNIovDT/GN0A02Hqu6SGAHs8TDKBfVujKD
         4yWlSoOmssyx2+gJ2XI6mWbQrUeweBYKrpRh+WsSpF5jkkwSq2ULXBhR7mCRAmoTzf
         77yVJPgOyAcVPRJxQSnvehA5pciqES0EXf8Tnni5JhN1vK0P8LAG5duyVZEKau6Miw
         /nZz67UK9SO8w==
Date:   Thu, 29 Sep 2022 22:01:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
        Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/10] dt-bindings: dma: apple,admac: Add iommus and
 power-domains properties
Message-ID: <YzXIVM6zGszDa2JQ@matsya>
References: <20220916142550.269905-1-j@jannau.net>
 <20220916142550.269905-2-j@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916142550.269905-2-j@jannau.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-09-22, 16:25, Janne Grunau wrote:
> Apple's ADMAC is on all supported Apple silicon SoCs behind an IOMMU
> and has its own power-domain.

Applied, thanks

-- 
~Vinod
