Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0394776BC89
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjHASbO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjHASbN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:31:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704EF1FFC;
        Tue,  1 Aug 2023 11:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE05E61680;
        Tue,  1 Aug 2023 18:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB89AC433C7;
        Tue,  1 Aug 2023 18:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690914671;
        bh=Z6iZx1MnTkv+z0S9RMruiULP5AWXR+HZFjpUnj/UERQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5LVZ7LDQp9HZ+iARzkaUjXd/VCMsWt8Jbz0Vel41HptW9Wd0B92SfnMtueHunSq3
         vSfaca7LlT3VFnnwIpht+3GkkspvAfpgWoJ7Mye7No4vB4QdzaLLnDE1ZigLN63Nh5
         XkOPEGTSXZtsLTW+cP7OZplKGglZdgjiR68Uolpc2zYbBpEsnMmE18UG97elC12Zao
         Ne+YBLfJWQnZw3s2OHKugQgdWiY+KR1zQt+VW9HWLDssASnbmj8gBNcaRpsIU8SbwE
         F8wSyL0yKoUIirWrbZnFQGkfPbq/REDNlPMq0nO6eUhSRZVyI2c2X9GjuqydS2UDnf
         U4jJ9pRhCeJUw==
Date:   Wed, 2 Aug 2023 00:01:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     sunran001@208suo.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: No need to clear memory after a
 dma_alloc_coherent() call
Message-ID: <ZMlPazK9/kXjRftJ@matsya>
References: <20230721073440.5402-1-xujianghui@cdjrlc.com>
 <0bd20a5f09b3419e1d4d8c2b6786e886@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd20a5f09b3419e1d4d8c2b6786e886@208suo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-07-23, 07:35, sunran001@208suo.com wrote:
> dma_alloc_coherent() already clear the allocated memory, there is no need
> to explicitly call memset().

Please fix the sender name and resend. it should match s-o-b name

> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/dma/idxd/device.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 7c74bc60f582..72330876d40a 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -792,7 +792,6 @@ static int idxd_device_evl_setup(struct idxd_device
> *idxd)
>  	evl->log_size = size;
>  	evl->bmap = bmap;
> 
> -	memset(&evlcfg, 0, sizeof(evlcfg));
>  	evlcfg.bits[0] = dma_addr & GENMASK(63, 12);
>  	evlcfg.size = evl->size;

-- 
~Vinod
