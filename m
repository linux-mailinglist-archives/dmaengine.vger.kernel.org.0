Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAB244B480
	for <lists+dmaengine@lfdr.de>; Tue,  9 Nov 2021 22:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbhKIVOk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Nov 2021 16:14:40 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:54542 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhKIVOk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Nov 2021 16:14:40 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id kYPImHEHgIEdlkYPImbK7K; Tue, 09 Nov 2021 22:11:53 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 09 Nov 2021 22:11:53 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH V2] dma: dw-edma-pcie: switch from 'pci_' to 'dma_' API
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Qing Wang <wangqing@vivo.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
References: <1632800660-108761-1-git-send-email-wangqing@vivo.com>
 <e30467d0-55e0-156c-4eba-2838c22fe030@wanadoo.fr>
 <20211109132137.GK2001@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <e5f6585a-399f-5b08-700c-aa8a16969605@wanadoo.fr>
Date:   Tue, 9 Nov 2021 22:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211109132137.GK2001@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 09/11/2021 à 14:21, Dan Carpenter a écrit :
> On Tue, Nov 02, 2021 at 08:05:53PM +0100, Christophe JAILLET wrote:
>> Hi,
>>
>>
>> Le 28/09/2021 à 05:44, Qing Wang a écrit :
>>> From: Wang Qing <wangqing@vivo.com>
>>>
>>> The wrappers in include/linux/pci-dma-compat.h should go away.
>>>
>>> The patch has been generated with the coccinelle script below.
>>> expression e1, e2;
>>> @@
>>> -    pci_set_dma_mask(e1, e2)
>>> +    dma_set_mask(&e1->dev, e2)
>>>
>>> @@
>>> expression e1, e2;
>>> @@
>>> -    pci_set_consistent_dma_mask(e1, e2)
>>> +    dma_set_coherent_mask(&e1->dev, e2)
>>>
>>> While at it, some 'dma_set_mask()/dma_set_coherent_mask()' have been
>>> updated to a much less verbose 'dma_set_mask_and_coherent()'.
>>>
>>> Signed-off-by: Wang Qing <wangqing@vivo.com>
>>> ---
>>>    drivers/dma/dw-edma/dw-edma-pcie.c | 17 ++++-------------
>>>    1 file changed, 4 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>>> index 44f6e09..198f6cd
>>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>>> @@ -186,27 +186,18 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>>    	pci_set_master(pdev);
>>>    	/* DMA configuration */
>>> -	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
>>> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>>>    	if (!err) {
>> if err = 0, so if no error...
>>
>>> -		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
>>> -		if (err) {
>>> -			pci_err(pdev, "consistent DMA mask 64 set failed\n");
>>> -			return err;
>>> -		}
>>> +		pci_err(pdev, "DMA mask 64 set failed\n");
>>> +		return err;
>> ... we log an error, return success but don't perform the last steps of the
>> probe.
> 
> I have an unpublished Smatch check for these:
> 
> drivers/dma/dw-edma/dw-edma-pcie.c:192 dw_edma_pcie_probe() info: return a literal instead of 'err'
> 
> The idea of the Smatch check is that it's pretty easy to get "if (!ret)"
> and "if (ret)" transposed.  It would show up in testing, of course, but
> the truth is that maintainers don't always have all the hardware they
> maintain.
> 
> And the other idea is that "return 0;" is always more readable and
> intentional than "return ret;" where ret is zero.
> 
> Anyway, is someone going to fix these?

Patch sent.
Feed-back welcomed.

CJ

> 
> regards,
> dan carpenter
> 
> 

