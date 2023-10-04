Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C4F7B8152
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 15:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbjJDNtJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 09:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbjJDNtI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 09:49:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC57C0;
        Wed,  4 Oct 2023 06:49:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D601C433C8;
        Wed,  4 Oct 2023 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696427342;
        bh=MBEtnPFBJlhd3FWBV+ARjaXUoaZ9Dl2ozbByMBfu4s4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIpoJFKMJA0DHSQVOYpxra+hNidIMbiyraE4lEjzw+cwTkFxUsn16H14ra13KIEBF
         Pog5SjZCOnPNpPWaBdX93VhQne6ExToo7sfS9IKM+FeA0O/u6d8Zh9v7vLssh1SEgf
         3HHqvCygS2ws+nrlGwGAsS84eyYXkScdnJf00k9X9gCD8/HN7XzZOF43BYMoFzXUy6
         xMB+26tduI4+vKcg52EvWPk8SRUetcly/+5SDakRDhpwF0ruOvlxc+p/ESDXEKowuE
         bv2vINVbPlEI9IrohLUDKAzwdUNjfeLtfHI/Gac4t0WPlW7mH9kn3MC2fP2zp8nuID
         IjYgdNpfm6uqA==
Date:   Wed, 4 Oct 2023 19:18:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     coolrrsh@gmail.com
Cc:     fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] dmaengine: idxd: Remove redundant memset() for
 eventlog allocation
Message-ID: <ZR1tSu0IQHFNuqMo@matsya>
References: <20230829180027.6357-1-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829180027.6357-1-coolrrsh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-08-23, 23:30, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> dma_alloc_coherent function already zeroes the array 'addr'.
> So, memset function call is not needed.
> 
> This fixes warning such as:
> drivers/dma/idxd/device.c:783:8-26:
> WARNING: dma_alloc_coherent used in addr already zeroes out memory,
> so memset is not needed.

Already fixes by 4ca95a5b220c901f9c2402532ef78bf5aaf7d35d

> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
> ---
> v1->v2
> Renamed the subject line
> ---
>  drivers/dma/idxd/device.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5abbcc61c528..7c74bc60f582 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -786,8 +786,6 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
>  		goto err_alloc;
>  	}
>  
> -	memset(addr, 0, size);
> -
>  	spin_lock(&evl->lock);
>  	evl->log = addr;
>  	evl->dma = dma_addr;
> -- 
> 2.25.1

-- 
~Vinod
