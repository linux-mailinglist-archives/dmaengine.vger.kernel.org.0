Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD040C450
	for <lists+dmaengine@lfdr.de>; Wed, 15 Sep 2021 13:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbhIOLWV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Sep 2021 07:22:21 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44204
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232586AbhIOLWS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Sep 2021 07:22:18 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A73E740199;
        Wed, 15 Sep 2021 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631704858;
        bh=aCsSIJxK9pE/n3HAREFG4OSSYjY0R4uc/FvjPXJXeu8=;
        h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=g5N7OfVGcdkrylcmEifW3I5oqpQjF0m5tHlTEikztQvjAHNj6sryg0rvWvj/ZZo7o
         oFSFIOJ50lko9QDSFBk0Uxxv+Ux900l7L2UeFeBYjcBNa0jpM8Mhd2brPxCXUzVeKf
         tJ5yIkxrt/RTy8eZRCWdLaKgzNi7mmiVFP40GYjM9ign/zCqoZhJWsiu4LCS9OoQN5
         9/N1rKtCnm2TL8pvrIuoiKxpP5FTyNd4hDZ2X7ao4kebPKakk+ZRQXN5I/lrf1WKb2
         pzIBM9CEibzi6OVfXeQzudsLqJ5k+RD+ZiRyU/cbbgn9FLQZQBG1SBHfVwKiC4Dlnm
         lsZIxs2hiqVDw==
Subject: Re: [PATCH] dmaengine: sh: make array descs static
From:   Colin Ian King <colin.king@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210915111951.12326-1-colin.king@canonical.com>
Message-ID: <e1981bb9-8965-dd85-b900-42904cf7fbf7@canonical.com>
Date:   Wed, 15 Sep 2021 12:20:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915111951.12326-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Incorrect $SUBJECT, V2 sent

On 15/09/2021 12:19, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the read-only array ds_lut on the stack but instead it
> static. Also makes the object code smaller by 163 bytes:
> 
> Before:
>    text    data     bss     dec     hex filename
>   23508    4796       0   28304    6e90 ./drivers/dma/sh/rz-dmac.o
> 
> After:
>    text    data     bss     dec     hex filename
>   23281    4860       0   28141    6ded ./drivers/dma/sh/rz-dmac.o
> 
> (gcc version 11.2.0)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index f9f30cbeccbe..005f1a3ff634 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -573,7 +573,7 @@ static void rz_dmac_issue_pending(struct dma_chan *chan)
>  static u8 rz_dmac_ds_to_val_mapping(enum dma_slave_buswidth ds)
>  {
>  	u8 i;
> -	const enum dma_slave_buswidth ds_lut[] = {
> +	static const enum dma_slave_buswidth ds_lut[] = {
>  		DMA_SLAVE_BUSWIDTH_1_BYTE,
>  		DMA_SLAVE_BUSWIDTH_2_BYTES,
>  		DMA_SLAVE_BUSWIDTH_4_BYTES,
> 

