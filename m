Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A5528350
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 13:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiEPLdI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 07:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbiEPLdB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 07:33:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09E938D9B;
        Mon, 16 May 2022 04:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 662E0B810DC;
        Mon, 16 May 2022 11:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5215C385B8;
        Mon, 16 May 2022 11:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652700777;
        bh=J35KBiLWm9yx0BOYLnTJk7rVxmulK79qiZiILuB4w7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMKcB0R+c500+oR6qABXuSCXVrIbnUak6NCFWtM5aHlhxqCAiwXypcX9XDUprR+JO
         hXlvFSmLXs7Bt+iAGGZIhcB7QOArbT2q6lzSc/l+7WEscTBh+WkdjFHQB6RAB12jam
         fRMFsXbWsDD7O2urjxR32bxfAIjRliYPpHo/gfdCb99FsUJPXNhx81XBzZO5Y9taLr
         xDQnBxJMXe1hKiTyEmAoLznn1PsWhp8+/RY8QjbcacKGV9SDD5VB4e4mHoDghD9Ys6
         vkSzJu4b3HgXfmeUwXUkZj3d2cJbuE4ts3W1zbEM1Dkhab25cI5DTD+VOiBEIgFJdz
         hDv/CeINXRrrw==
Date:   Mon, 16 May 2022 17:02:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     dave.jiang@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] dmaengine: idxd: Remove unnecessary synchronize_irq()
 before free_irq()
Message-ID: <YoI2ZRm3irWmqZDg@matsya>
References: <20220513081622.1631073-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513081622.1631073-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-05-22, 08:16, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Calling synchronize_irq() right before free_irq() is quite useless. On one
> hand the IRQ can easily fire again before free_irq() is entered, on the
> other hand free_irq() itself calls synchronize_irq() internally (in a race
> condition free way) before any state associated with the IRQ is freed.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

where is this report...?

> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/dma/idxd/device.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5363fb9218f2..9dd8e6bb21e6 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1179,7 +1179,6 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
>  	struct idxd_device *idxd = wq->idxd;
>  	struct idxd_irq_entry *ie = &wq->ie;
>  
> -	synchronize_irq(ie->vector);
>  	free_irq(ie->vector, ie);
>  	idxd_flush_pending_descs(ie);
>  	if (idxd->request_int_handles)
> --
> 2.25.1
> 

-- 
~Vinod
