Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3B7CA648
	for <lists+dmaengine@lfdr.de>; Mon, 16 Oct 2023 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjJPLJU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Oct 2023 07:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjJPLJT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Oct 2023 07:09:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD3D83;
        Mon, 16 Oct 2023 04:09:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B25DC433CA;
        Mon, 16 Oct 2023 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697454556;
        bh=5zJCucxKJiJFREdw+9vbsSiIgkqJAENia9ICetGpmRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdzZjzvPDHkpl8zWlRdXVe75detixZmuTQ/WKblr04pVx7gO6RXZd910mFx9yhbVy
         8z6DegMckHefAnMVz/Oku2GBpfOXHjDTGV8WukTbi5US6hDivMFL1Aw55aaVqDTVil
         l1ZweBBT7IPT7xGqzWsAYehrjBiTQdKqEjtKeQrEtTO8jDvWCFNJamw0x/ocGuxjUc
         ecOXtS8S6tq8m8TXsOykXzc+oGl8PWKjUeNJjODIS9gXZfiAvxwbpjpPCnHCsSoPCx
         4d6F9hm/DcXbhbIk0SztDzlz6P5I6LE57eZ5qwjk2tCSgl8LHlMfGQXeKm/ZqVpxoI
         x+fQ6exGQmivA==
Date:   Mon, 16 Oct 2023 16:39:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mohan Kumar <mkumard@nvidia.com>
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        ldewangan@nvidia.com, krzysztof.kozlowski+dt@linaro.org,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V1 0/2] Support dma channel mask
Message-ID: <ZS0Z2G64rjrQTobg@matsya>
References: <20231009063509.2269-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009063509.2269-1-mkumard@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-10-23, 12:05, Mohan Kumar wrote:
> To reserve the dma channel using dma-channel-mask property
> for Tegra platforms.
> 
> Mohan Kumar (2):
>   dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
>   dmaengine: tegra210-adma: Support dma-channel-mask property

This fails to apply for me, pls rebase

-- 
~Vinod
