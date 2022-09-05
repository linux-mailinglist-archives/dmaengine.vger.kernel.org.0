Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E35ACA7E
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 08:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiIEGVB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 02:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbiIEGVB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 02:21:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381BF2B261
        for <dmaengine@vger.kernel.org>; Sun,  4 Sep 2022 23:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 426A1CE106E
        for <dmaengine@vger.kernel.org>; Mon,  5 Sep 2022 06:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572A4C433D6;
        Mon,  5 Sep 2022 06:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662358855;
        bh=NUWhonAk7FLq7pBR3eroBH9z7hUc4UKLmOah536Q0m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfgtgYUE0SV6hUlxgwEORXuIDE2ggX3Y4J0o3+vRWvMwuUMQDPzDu3UMwcmZ74gWU
         f7qqbValtT8fZ6vK6+aLZlG8LQTIhbVF56ivPZiktvB1FfY/lKc185PPQZlLLdjNs/
         t/u6FwzScK3sl0apYjOYY5UK04X+wt/lm5z04yMRICtwYBma1sYPeSFuFuEi/BRxXa
         6ZmeM4y32eaenrAwg94/tAZFr5NmS8ufGL3hyupF2Y7ER+9Lqg+CnqeWmZsYVUslJC
         VFEGExLXXQErr6ttihJJY/9L/TFAWcipgE55hUNTvMgdmjJWCkCRTII8815KUsUKEK
         nwrfy9wMd9FFA==
Date:   Mon, 5 Sep 2022 11:50:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     green.wan@sifive.com, dmaengine@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] dmaengine: sf-pdma:Remove the print function
 dev_err()
Message-ID: <YxWVQzQj7uRgwxyO@matsya>
References: <20220810062532.13425-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810062532.13425-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-08-22, 06:25, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> >From the coccinelle check:
> 
> ./drivers/dma/sf-pdma/sf-pdma.c
> Error:line 409 is redundant because platform_get_irq() already prints an
> error
> 
> ./drivers/dma/sf-pdma/sf-pdma.c
> Error:line 424 is redundant because platform_get_irq() already prints an
> error
> 
> So,remove the unnecessary print function dev_err()

Applied, thanks

-- 
~Vinod
