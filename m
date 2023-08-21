Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA21E782AF6
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjHUNwf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjHUNwf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 09:52:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B353D11F;
        Mon, 21 Aug 2023 06:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F5761FD6;
        Mon, 21 Aug 2023 13:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF3CC433C7;
        Mon, 21 Aug 2023 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625931;
        bh=7mKKDVgdF/2Lo4ZD2YTNmgRHjnTYf27kHrdSorA5ROQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r9EvY2UWj59CzzUSJ81GU5AT3FoAi8QcJGa4BoUIuMFZMLgh0b4Fx10hYphRpiX93
         YP6eC9VzzWRAjnFtEYi6FMrim8nOFqSHLR3L8/8AZHsFYGqmJWVHQ3j2gwmE9Zrrpl
         MktFl9aT18tX37sQ3WZGYd8w+Ay5qULO7BMaIjHMgFgT+AE/sWA6/2Gaebm5VUOAKQ
         WQtMteLaEnmj4PeZGktK0jIULNavJj3LBQe9v6UCZwL3tOclOEgfxPnQc+3g1vqDvY
         d2xflXeqLwZAT1V+uGe/KjO3qcbB6AcyzQImo7re2W6A8+i/v/dB/dqv4Fq3Awda75
         6lhyEoR0GQRlg==
From:   Vinod Koul <vkoul@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux@armlinux.org.uk,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, git@amd.com
In-Reply-To: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
Subject: Re: (subset) [PATCH net-next v5 00/10] net: axienet: Introduce
 dmaengine
Message-Id: <169262592741.224153.9100272726584790594.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 19:22:07 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Mon, 07 Aug 2023 11:21:39 +0530, Radhey Shyam Pandey wrote:
> The axiethernet driver can use the dmaengine framework to communicate
> with the xilinx DMAengine driver(AXIDMA, MCDMA). The inspiration behind
> this dmaengine adoption is to reuse the in-kernel xilinx dma engine
> driver[1] and remove redundant dma programming sequence[2] from the
> ethernet driver. This simplifies the ethernet driver and also makes
> it generic to be hooked to any complaint dma IP i.e AXIDMA, MCDMA
> without any modification.
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: dmaengine: xilinx_dma:Add xlnx,axistream-connected property
        commit: 94afcfb819b3a07e55d463c29e2d594316f40b4a
[02/10] dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
        commit: e8cfa385054c6aa7ae8dd743d8ea980039a0fc0b
[03/10] dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
        commit: d8a3f65f6c1de1028b9af6ca31d9dd3738fda97e
[04/10] dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
        commit: 491e9d409629964457d094ac2b99e319d428dd1d
[05/10] dmaengine: xilinx_dma: Freeup active list based on descriptor completion bit
        commit: 7bcdaa65810212c999d21e5c3019d03da37b3be3
[06/10] dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical usecase
        commit: c77d4c5081aa6508623be876afebff003a2e5875
[07/10] dmaengine: xilinx_dma: Program interrupt delay timeout
        commit: 84b798fedf3fa8f0ab0c096593ba817abc454fe5

Best regards,
-- 
~Vinod


