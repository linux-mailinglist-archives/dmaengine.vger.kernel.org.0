Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7D65538F
	for <lists+dmaengine@lfdr.de>; Fri, 23 Dec 2022 19:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiLWSRQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Dec 2022 13:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiLWSRP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Dec 2022 13:17:15 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61BE1EC46;
        Fri, 23 Dec 2022 10:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=nBRat498cDUujGXOy3Rn1VDh9qVr3oFVyIebhUBpEH8=; b=C8SjCfzhsTwI4Xgpx7BFX45kkP
        nyKxBSHrZfU+UM6Ufo0ydrWy/WRg845dG9g7ni38zqkqIS3K5TgN5IHIvAat4UwdDD9+L24h+XTiA
        /EToU8fFGhFLzLjomnwxTPWe4QJEFgxWQSEUHJMvZEj7gqorqoZi6jD0BtKsTzGLKPyLu6BjOpPRQ
        9JLCURSQ0HbWhuSd2LEnB8wT58dQKIiIPjwy7JHJ1OohOPu0nQfVvwVj2Rauf3Jd5CmxyGHdmbMai
        OmUquDbcGuOilq18KhjQtScU3xU+Q9ZkIJCz+T2v6AtnkvAGBJyr+E2c+vNBPTCNOc3fGeDewLeTU
        rX2g/p9g==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1p8mbR-00FOq0-RX; Fri, 23 Dec 2022 11:17:07 -0700
Message-ID: <0130c5fe-81ff-537c-bbf4-15bb27876c98@deltatee.com>
Date:   Fri, 23 Dec 2022 11:17:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Dan Carpenter <error27@gmail.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221220061752.1120381-1-linmq006@gmail.com>
 <31659f35-453e-2a5a-2f93-e35ef1395ad7@deltatee.com> <Y6WGMd5hb2LoDyNL@kadam>
Content-Language: en-CA
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Y6WGMd5hb2LoDyNL@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: error27@gmail.com, linmq006@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] dmaengine: plx_dma: Fix potential double free in
 plx_dma_create
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2022-12-23 03:42, Dan Carpenter wrote:
> On Tue, Dec 20, 2022 at 09:35:38AM -0700, Logan Gunthorpe wrote:
>>
>>
>> On 2022-12-19 23:17, Miaoqian Lin wrote:
>>> When all references are dropped, callback function plx_dma_release()
>>> for put_device() will call kfree(plxdev) to release memory.
>>> Fix the error path to fix the possible double free.
>>>
>>> Fixes: 07503e6aefe4 ("dmaengine: plx_dma: add a missing put_device() on error path")
>>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>>> ---
>>> Please correct me if I make mistakes, thanks for your review.
>>> ---
>>>  drivers/dma/plx_dma.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
>>> index 12725fa1655f..bce724ff4e16 100644
>>> --- a/drivers/dma/plx_dma.c
>>> +++ b/drivers/dma/plx_dma.c
>>> @@ -546,8 +546,9 @@ static int plx_dma_create(struct pci_dev *pdev)
>>>  	return 0;
>>>  
>>>  put_device:
>>> -	put_device(&pdev->dev);
>>>  	free_irq(pci_irq_vector(pdev, 0),  plxdev);
>>> +	put_device(&pdev->dev);
>>> +	return rc;
>>>  free_plx:
>>>  	kfree(plxdev);
>>>  
>>
>>
>> Sorry, after reviewing, I don't think this patch is correct.
>>
>> plx_dma_release() is called from dma_async_device_unregister() which
>> won't be called if dma_async_device_register() fails. It does not get
>> freed when the pci device is put. So I don't think this is a possible
>> double free.
> 
> I think instead of "double free" it Miaoqian meant "use after free".  It
> does look like a use after free to me.  Certainly there is no harm from
> applying the patch and it makes the code more obviously correct.

Yeah, moving the put_device() up would certainly look more correct.

But I think it's actually not a bug either because plx_dma_create() is
called from the pci probe function, so the pci device cannot go away.

Logan
