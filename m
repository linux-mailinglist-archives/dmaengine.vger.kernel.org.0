Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB91E1DE557
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2020 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgEVL1o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 May 2020 07:27:44 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6393 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgEVL1o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 May 2020 07:27:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec7b69e0001>; Fri, 22 May 2020 04:25:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 May 2020 04:27:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 May 2020 04:27:43 -0700
Received: from [10.26.74.233] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 11:27:41 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: Fix runtime PM imbalance on
 error
To:     <dinghao.liu@zju.edu.cn>
CC:     <kjlu@umn.edu>, Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200522075846.30706-1-dinghao.liu@zju.edu.cn>
 <967c17d2-6b57-27f0-7762-cd0835caaec9@nvidia.com>
 <45d18e3c.bfdab.1723c07b7d3.Coremail.dinghao.liu@zju.edu.cn>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e2274ef7-2c33-cd3a-319f-45c5c27cff3e@nvidia.com>
Date:   Fri, 22 May 2020 12:27:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <45d18e3c.bfdab.1723c07b7d3.Coremail.dinghao.liu@zju.edu.cn>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590146718; bh=awjFKuADBFKeWBQk5Eejr9+XYg2Ooxb8LM1Zce3S+ZA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dp9guy335vU9wcknVNoLnC5VrJQrA3qXeTavb5gJxDBje+Q+TWZlsLmwT0pASROWd
         LnG/cI978LsHwYeNJSHNyWZbHW8pBTTy2okF9b+Ue5IV/p/QhRv2dLCRbswOTXaklF
         KtZ6M8ZY3ejt4VcvUf2DQ3PciuEZa1njXvVwVvwBTxTfbxNwCFKJqEZ/51HlgfDsUM
         SHxp94VewqyfX8BPLpdhbyg9wKQ5FTHtOXYaSbPjK5SMMZ27l1gsVrCA0acgndjvtK
         6J8M0iOuNhd45xlVjMaI7JZH+gLRDdaXf9qZ5QdUEwLDUGdsfk8YKhnx/SnBn7JQSa
         00cUooeda3bwg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 22/05/2020 11:57, dinghao.liu@zju.edu.cn wrote:
>>
>> On 22/05/2020 08:58, Dinghao Liu wrote:
>>> pm_runtime_get_sync() increments the runtime PM usage counter even
>>> when it returns an error code. Thus a pairing decrement is needed on
>>> the error handling path to keep the counter balanced.
>>>
>>> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>>> ---
>>>  drivers/dma/tegra210-adma.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>>> index c4ce5dfb149b..803e1f4d5dac 100644
>>> --- a/drivers/dma/tegra210-adma.c
>>> +++ b/drivers/dma/tegra210-adma.c
>>> @@ -658,6 +658,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
>>>  
>>>  	ret = pm_runtime_get_sync(tdc2dev(tdc));
>>>  	if (ret < 0) {
>>> +		pm_runtime_put_sync(tdc2dev(tdc));
>>>  		free_irq(tdc->irq, tdc);
>>>  		return ret;
>>>  	}
>>>
>>
>>
>> There is another place in probe that needs to be fixed as well. Can you
>> correct this while you are at it?
>>
>> Thanks
>> Jon
>>
>> -- 
>> nvpublic
> 
> Sure. I have sent a patch to fix PM imbalance in tegra_adma_probe().


You should only send one patch to fix both instances as it is the same
driver. It is impossible to figure out that two patches with the same
$subject are different.

Jon

-- 
nvpublic
