Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80365763C4F
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjGZQWM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGZQWL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 12:22:11 -0400
X-Greylist: delayed 1489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 09:22:09 PDT
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FFF1BDA
        for <dmaengine@vger.kernel.org>; Wed, 26 Jul 2023 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=4QVwg/3buKSKa87Kcb2VqaMkmqvy97Dgt5k/CEvT8aQ=; b=heBCf9Bwkfy9wEwW2XMdjOiYW5
        zLEwoiA+XKTBS9uzuU2MaAA/esjk7A5WciR4XIjg20XBNfvqswFXaY8N+KiFjo1TW6XdQDwSEWvGl
        1ZC70U/NnmlNfFql1lJ92MS1Fjae6kjsIG8V01ayjngNsvoljymDw39ZBXuPTDLg/OYD3J7INrQ5p
        lGoI48P+v7yQbUCa2jKAwbWBedwKXXly6pslTWyCAZayqtBthXYaKxlOjJ/GtJ4cmNf6C6il3mRVD
        B+2TRn0lysrZP8Em/dpRF08Ik7INqpgJ7FCvsuSfbuJG+BuKj/FczJq7AD/LLq8Y2WohlEFJ3/kbc
        Sx9i2jTw==;
Received: from d75-158-34-12.abhsia.telus.net ([75.158.34.12] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1qOgt3-00B3w0-6K; Wed, 26 Jul 2023 09:57:18 -0600
Message-ID: <9378e69f-2bd4-9d8d-c736-b8799f6ebecc@deltatee.com>
Date:   Wed, 26 Jul 2023 09:57:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726104827.60382-1-dg573847474@gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230726104827.60382-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 75.158.34.12
X-SA-Exim-Rcpt-To: dg573847474@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential deadlock on
 &plxdev->ring_lock
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2023-07-26 04:48, Chengfeng Ye wrote:
> As plx_dma_process_desc() is invoked by both tasklet plx_dma_desc_task()
> under softirq context and plx_dma_tx_status() callback that executed under
> process context, the lock aquicision of &plxdev->ring_lock inside
> plx_dma_process_desc() should disable irq otherwise deadlock could happen
> if the irq preempts the execution of process context code while the lock
> is held in process context on the same CPU.
> 
> Possible deadlock scenario:
> plx_dma_tx_status()
>     -> plx_dma_process_desc()
>     -> spin_lock(&plxdev->ring_lock)
>         <tasklet softirq>
>         -> plx_dma_desc_task()
>         -> plx_dma_process_desc()
>         -> spin_lock(&plxdev->ring_lock) (deadlock here)
> 
> This flaw was found by an experimental static analysis tool I am developing
> for irq-related deadlock.
> 
> The tentative patch fixes the potential deadlock by spin_lock_irqsave() in
> plx_dma_process_desc() to disable irq while lock is held.
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Makes sense. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
