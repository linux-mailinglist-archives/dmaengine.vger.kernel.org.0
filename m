Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928B576894D
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 01:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjG3Xum (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jul 2023 19:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG3Xul (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jul 2023 19:50:41 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8634210C0;
        Sun, 30 Jul 2023 16:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=FVsm7XR5gyD3MmGf40bx/+LP6XG63Sd/Pb98sroNX+0=; b=Pwizs9VhPURkngamp5j03F2HZb
        wDmxLfwou6NxEh4deJei7d1+l+mIoNhPDLeCGbdd/asUvPAoVTeF1ESYx+3WhOxFY0yAzaVbtJ3Pp
        P1kVY/PCF7uSpLEfBuCWXXywYnqfxWweu+xO7z69+/fa5sPD2/xLyL2Pnuw3ZMMSn3u4TuSSXhuJ9
        5iUNlJpx/kuUw6UcTGpZTtKDnx3ZYDo5kFGwEbPGu3Ixu1E5gH4AfAJx2S0b4sdZAX+czi4mQWyL4
        KP99IfaRg6xrO9RT/d2Qz+ssfo+9CP/JlzPkmrCBKCZifNILYE97hgoaA5hAw1d4zN02kfKg4U3jO
        YNm0HAjw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1qQGBF-00F0SV-Ve; Sun, 30 Jul 2023 17:50:34 -0600
Message-ID: <ff871e8d-c5b0-99ed-0a44-385d70c503c2@deltatee.com>
Date:   Sun, 30 Jul 2023 17:50:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
To:     Chengfeng Ye <dg573847474@gmail.com>, vkoul@kernel.org
Cc:     yuyunbo519@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
References: <20230729175952.4068-1-dg573847474@gmail.com>
Content-Language: en-CA
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230729175952.4068-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: dg573847474@gmail.com, vkoul@kernel.org, yuyunbo519@gmail.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v2] dmaengine: plx_dma: Fix potential deadlock on
 &plxdev->ring_lock
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/29/23 11:59, Chengfeng Ye wrote:
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
> The lock was changed from spin_lock_bh() to spin_lock() by a previous patch
> for performance concern but unintentionally brought this potential deadlock
> problem.
> 
> This patch reverts back to spin_lock_bh() to fix the deadlock problem.
> 
> Fixes: 1d05a0bdb420 ("dmaengine: plx_dma: Move spin_lock_bh() to spin_lock()")
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> 

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan
