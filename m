Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2325563805
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 18:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiGAQfI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 12:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiGAQfH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 12:35:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3515944740
        for <dmaengine@vger.kernel.org>; Fri,  1 Jul 2022 09:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8C9E62571
        for <dmaengine@vger.kernel.org>; Fri,  1 Jul 2022 16:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FEAC3411E;
        Fri,  1 Jul 2022 16:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656693303;
        bh=mO+mindoKUsL46KCUFp28ERV1gyZf/Vvuhqlxz02zgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pgelOjRU3lfx1fPCUPXPm01iw+fUINLsaOUrgFvlzkXXV+0yQR3JPLJE7pc8TNyQu
         q5GtqtYYwS1VZR4+8NvZ1bXlKQjhiYYgaX9mav5j1KiFP15eJUrQBzF4su7RJkXjS1
         lyXr6zLjYd9DJsd7H19lGepmy4CqXI6qGXc0BT4a+N65FjInY4ocujj/aE6+JhmWBN
         v6x/GUeUNjemNdJ265fYw1PPdXTMLiA55leutJ67q2D9lVLrsc1HykQ9RxW4MsQ5Wr
         w9Tpr7e7iW5sLWDRZ2TBsTVbW9lCX/vE+rDVAV74Gf8gGTcJnKQp1HdtQkMRq/IEt0
         3piZcrkLDc7xg==
Date:   Fri, 1 Jul 2022 22:04:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Hui Wang <hui.wang@canonical.com>, dmaengine@vger.kernel.org,
        shawnguo@kernel.org, yibin.gong@nxp.com
Subject: Re: [PATCH] dmaengine: imx-sdma: Setting DMA_PRIVATE capability
 during the probe
Message-ID: <Yr8iMkBNMowEG+uF@matsya>
References: <20220524074933.38413-1-hui.wang@canonical.com>
 <20220620083310.GV2387@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620083310.GV2387@pengutronix.de>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-06-22, 10:33, Sascha Hauer wrote:
> On Tue, May 24, 2022 at 03:49:33PM +0800, Hui Wang wrote:

> > +	dma_cap_set(DMA_PRIVATE, sdma->dma_device.cap_mask);
> 
> I am not sure about the impacts on the memcpy capability of the SDMA
> driver when setting this flag. It looks like this flag influences the
> way suitable channels are picked for memcpy, but I don't understand
> the code just by looking at it. I see that several other drivers
> providing memcpy set this flag as well, so I guess it's ok to set it,
> but it would be good to hear a word from Vinod about it.

So DMA_PRIVATE is used to make channel not available for general dma
allocation. So yes it would impact dma memcpy which is about allocating
generically.

-- 
~Vinod
