Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E0B18848A
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2020 13:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgCQMxk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Mar 2020 08:53:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53780 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQMxk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Mar 2020 08:53:40 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02HCrZ9a057868;
        Tue, 17 Mar 2020 07:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584449615;
        bh=QEmuQB7fhuGxUGv+P99VY96J8QmR9TntuVE/+3VFqKQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AGl3AuZqMfeYVvYpVzg8Geui0qgQbFATbPbYe6vNWt8OiSMvuqH/5LCItQqeAYxwi
         xYsA8sTrwyhN3O3rDMck2J6Cyx5kuj3DZP7GCp3MeyM8iG7saLFcsaXRuMLJGjTFpX
         Utwv6kCJ+Io2/sc1NaMM19awtVWiRVl0uKPkMNqY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02HCrYnc023500
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Mar 2020 07:53:35 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Mar 2020 07:53:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Mar 2020 07:53:34 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02HCrVuP101312;
        Tue, 17 Mar 2020 07:53:32 -0500
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix an error handling path in
 'k3_udma_glue_cfg_rx_flow()'
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20200315155015.27303-1-christophe.jaillet@wanadoo.fr>
 <49a35126-3cc6-0cbb-e632-42a237ef353e@ti.com>
 <e1d2d6af-7dc3-6e90-28d3-05d9b293cba9@ti.com> <20200317124217.GB4650@kadam>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <117d70b8-5e58-b708-9df4-cd7a9f68a49d@ti.com>
Date:   Tue, 17 Mar 2020 14:53:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200317124217.GB4650@kadam>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 17/03/2020 14:42, Dan Carpenter wrote:
> On Tue, Mar 17, 2020 at 09:50:52AM +0200, Grygorii Strashko wrote:
>> Hi Christophe,
>>
>> On 16/03/2020 09:20, Peter Ujfalusi wrote:
>>> Hi Christophe,
>>>
>>> On 15/03/2020 17.50, Christophe JAILLET wrote:
>>>> All but one error handling paths in the 'k3_udma_glue_cfg_rx_flow()'
>>>> function 'goto err' and call 'k3_udma_glue_release_rx_flow()'.
>>>>
>>>> This not correct because this function has a 'channel->flows_ready--;' at
>>>> the end, but 'flows_ready' has not been incremented here, when we branch to
>>>> the error handling path.
>>>>
>>>> In order to keep a correct value in 'flows_ready', un-roll
>>>> 'k3_udma_glue_release_rx_flow()', simplify it, add some labels and branch
>>>> at the correct places when an error is detected.
>>>
>>> Good catch!
>>>
>>>> Doing so, we also NULLify 'flow->udma_rflow' in a path that was lacking it.
>>>
>>> Even better catch ;)
>>>
>>>> Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine user")
>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>> ---
>>>> Not sure that the last point of the description is correct. Maybe, the
>>>> 'xudma_rflow_put / return -ENODEV;' should be kept in order not to
>>>> override 'flow->udma_rflow'.
>>>> ---
>>>>    drivers/dma/ti/k3-udma-glue.c | 30 ++++++++++++++++++++----------
>>>>    1 file changed, 20 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
>>>> index dbccdc7c0ed5..890573eb1625 100644
>>>> --- a/drivers/dma/ti/k3-udma-glue.c
>>>> +++ b/drivers/dma/ti/k3-udma-glue.c
>>>> @@ -578,12 +578,12 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>>>>    	if (IS_ERR(flow->udma_rflow)) {
>>>>    		ret = PTR_ERR(flow->udma_rflow);
>>>>    		dev_err(dev, "UDMAX rflow get err %d\n", ret);
>>>> -		goto err;
>>>> +		goto err_return;
>>>
>>> return err; ?
>>>
>>>>    	}
>>>
>>> Optionally you could have moved the
>>> 	rx_chn->flows_ready++;
>>> here and
>>
>> Thank you for your patch.
>>
>> I tend to agree with Peter here - just may be with comment that it will be dec in
>> k3_udma_glue_release_rx_flow().
>> All clean ups were moved in standalone function intentionally to avoid
>> code duplication in err and normal channel release path, and avoid common errors
>> when normal path is fixed, but err path missed.
> 
> A standalone function to free everything is *always* going to be buggy.
> This patch is the classic bug where when you "free everything", you end
> up undoing things that haven't been done.
> 
> The best way to do error handling is to 1) Free the most recently
> allocated resource and 2)  Use label names which say what the goto does.
> 
> With multiple labels like "goto err_rflow_put;" the review only needs to
> ask, what was the most recent allocation?   In the case, it was
> "udma_rflow" and the "goto err_rflow_put" puts it.  That's very simple
> and correct.  There is no need to scroll to the bottom of the function.
> 
> When it comes to line count, if we only free successfully allocated
> resources then it means we can remove all the if statements from the
> k3_udma_glue_release_rx_flow() so the line count ends up being similar
> either way.
> 
> The other problem with "common cleanup functions" is that when people
> want to audit it, instead of looking at the gotos, reviewers have to
> open up two terminal windows and go through it line by line.  Currently
> static analysis tools are not able to parse common clean functions.
> 
> Christophe's patch doesn't just fix the bug he observed, it also fixed
> at least one other double free bug.  It's quite hard to spot the second
> bug, but Christophe fixed it automatically by following the rules.
> 

fair enough. Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
