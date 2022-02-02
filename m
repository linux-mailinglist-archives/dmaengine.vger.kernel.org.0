Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBAC4A782E
	for <lists+dmaengine@lfdr.de>; Wed,  2 Feb 2022 19:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346743AbiBBSqE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Feb 2022 13:46:04 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:55722 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346729AbiBBSqD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Feb 2022 13:46:03 -0500
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id FKdinz4vkzBp5FKdinKnVu; Wed, 02 Feb 2022 19:46:00 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 02 Feb 2022 19:46:00 +0100
X-ME-IP: 90.126.236.122
Message-ID: <d31d8348-c7ee-587a-d376-85e86092436f@wanadoo.fr>
Date:   Wed, 2 Feb 2022 19:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dmaengine: ptdma: Fix the error handling path in
 pt_core_init()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org
References: <1b2573cf3cd077494531993239f80c08e7feb39e.1643551909.git.christophe.jaillet@wanadoo.fr>
 <20220202071530.GV1951@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220202071530.GV1951@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 02/02/2022 à 08:15, Dan Carpenter a écrit :
> On Sun, Jan 30, 2022 at 03:12:09PM +0100, Christophe JAILLET wrote:
>> @@ -230,7 +230,7 @@ int pt_core_init(struct pt_device *pt)
>>   	/* Request an irq */
>>   	ret = request_irq(pt->pt_irq, pt_core_irq_handler, 0, dev_name(pt->dev), pt);
>>   	if (ret)
>> -		goto e_pool;
>> +		goto e_dma_alloc;
> 
> These are ComeFrom label names.  It's an unfortunate style of naming
> labels based on the goto location instead of saying what the goto does.
> 
> This is one of those cases where the code has moved on, and now the name
> no longer points to where it came from or to where it's going.  It just
> stands as a Hyperart Thomasson pointing to the past.  It reminds us of
> change and decay.  Take time to smell the air in autumn.  Beauty is all
> around.
> 
> regards,
> dan carpenter
> 

Autumn is over. Winter is coming (tm). And Spring will soon be there.

I'll try to send a refreshing update as a V2 to go one step further and 
do some spring cleaning in the labels used here.

CJ
