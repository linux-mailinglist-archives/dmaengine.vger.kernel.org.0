Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC00750873F
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378213AbiDTLqX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378104AbiDTLqW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:46:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555CD41601;
        Wed, 20 Apr 2022 04:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7AA661935;
        Wed, 20 Apr 2022 11:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD892C385A4;
        Wed, 20 Apr 2022 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455016;
        bh=7JNN+lLGpQd2vOnQsY9fUp5J7u+gxy2utrkR2mPkKNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fg15V7pkLZEYA7XL7RgFYyLq3JceRQss/63jRVpGH7h/9ZeuXBC7R4auxD/Y2Cgh6
         ISUVZO3E5n5ep7pSD5siEAiSVNj64+Qk6IyUMl0iIXurKZ9QpgJF0ZRFaaof/p3p2S
         AfpB1vW9nT0NKTi8j3bS/YzhTI17TIlFPW6CzaA4lkTcuNjUdTz32PxY4uSkBsAMGw
         0ASTOG8YV/S1svg9zbSo6IeLzUQxd4MzSgUs4RZIOQagOaFuhI6k64cbUL7LqjDILT
         RxUiEQNWnkuWq2WrK9PZSZSXpiw9G0Dq3KQnITP8rt8DVljMhBPIBCWiDtQxvk2BKY
         Paqfx2Hb2sMjQ==
Date:   Wed, 20 Apr 2022 17:13:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     paul@crapouillou.net, linux-mips@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: jz4780: set DMA maximum segment size
Message-ID: <Yl/x5BNqlKjxYgif@matsya>
References: <20220411153618.49876-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411153618.49876-1-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-04-22, 16:36, Aidan MacDonald wrote:
> Set the maximum segment size, since the hardware can do transfers larger
> than the default 64 KiB returned by dma_get_max_seg_size().
> 
> The maximum segment size is limited by the 24-bit transfer count field
> in DMA descriptors. The number of bytes is equal to the transfer count
> times the transfer size unit, which is selected by the driver based on
> the DMA buffer address and length of the transfer. The size unit can be
> as small as 1 byte, so set the maximum segment size to 2^24-1 bytes to
> ensure the transfer count will not overflow regardless of the size unit
> selected by the driver.

Applied, thanks

-- 
~Vinod
