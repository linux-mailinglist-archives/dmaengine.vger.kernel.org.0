Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0D9716CC5
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 20:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjE3Sqh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 May 2023 14:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjE3Sqg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 May 2023 14:46:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C0C9
        for <dmaengine@vger.kernel.org>; Tue, 30 May 2023 11:46:31 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 44MPqYngtbOsk44MPqezJs; Tue, 30 May 2023 20:46:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685472384;
        bh=wAisxzg8dfWOsHsZpM0v+nS0EU1aAoqe1cA6dlcGUok=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cxt0b70ongh8rsgRilK/5wy7YAeEmoJ6BLvRFuDAttIFdCTyIEADSZEsZ9Pt/f9gp
         /8DhWc68KV2UcjVYvivWz3kq7O1O5X9Fvi+CTn0I+rEO+d1jf933J2/xdcymkleJIs
         RGan+1ir9Dzt6Z2N2nRYOgW+dALxxgKqJyoZ08xKxpyGFNSYD55OYnqZuVmjkitpp3
         OkzZbMEnIRnMELQqRlpZvf5Rq/ylVz+Wt/if9U9hWAXQpfz3S6DnWFAg16Y0fgONQI
         riQDrtvrRSoEXkaj3RRjcnrJI0HLg8cxj48aDPbFtEAeUBTYdtjAf4VinNLHypXG1o
         KGXxJF0XHpo/Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 30 May 2023 20:46:24 +0200
X-ME-IP: 86.243.2.178
Message-ID: <1335982c-70ea-6af2-19cf-73a4332ae510@wanadoo.fr>
Date:   Tue, 30 May 2023 20:46:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dmaengine: idxd: No need to clear memory after a
 dma_alloc_coherent() call
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <f44be04317387f8936d31d5470963541615f30ef.1685283065.git.christophe.jaillet@wanadoo.fr>
 <1e87f3fa-58c5-d47f-3335-cd0a554b3144@petrovitsch.priv.at>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1e87f3fa-58c5-d47f-3335-cd0a554b3144@petrovitsch.priv.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 30/05/2023 à 17:54, Bernd Petrovitsch a écrit :
> On 28/05/2023 16:11, Christophe JAILLET wrote:
>> dma_alloc_coherent() already clear the allocated memory, there is no need
>> to explicitly call memset().
> 
> Hmm, so wouldn't be dma_zalloc_coherent() a better name for the function?
> 
> Kind regards,
>      Bernd

Hi,

No strong opinion about it.
It is not malloc either !)

When dma_zalloc_coherent() has been deprecated (see [1]), for some 
reason, it was decided to keep the "alloc" version.

CJ


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/dma-mapping.h?id=06d4dd2f2ce1cdb625f77c0676d5af6ba310c01d
