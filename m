Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D141B7787
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 12:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfISKfA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 06:35:00 -0400
Received: from mx1.emlix.com ([188.40.240.192]:57656 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387575AbfISKfA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 19 Sep 2019 06:35:00 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 3132A603CA;
        Thu, 19 Sep 2019 12:34:58 +0200 (CEST)
Subject: Re: [PATCH v2 1/3] dmaengine: imx-sdma: fix buffer ownership
To:     Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Cc:     yibin.gong@nxp.com, fugang.duan@nxp.com, dan.j.williams@intel.com,
        vkoul@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
 <20190919102319.23368-1-philipp.puschmann@emlix.com>
 <20190919102319.23368-2-philipp.puschmann@emlix.com>
 <7d694da8ffe098c6c8f6fe9c3a2306fda55eb655.camel@pengutronix.de>
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <1b821b38-2206-07b3-eb0a-47b02bced95c@emlix.com>
Date:   Thu, 19 Sep 2019 12:34:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7d694da8ffe098c6c8f6fe9c3a2306fda55eb655.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lucas,


Am 19.09.19 um 12:27 schrieb Lucas Stach:
> Hi Philipp,
> 
> On Do, 2019-09-19 at 12:23 +0200, Philipp Puschmann wrote:
>> BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the
>> buffer, when 0 ARM owns it. When processing the buffers in
>> sdma_update_channel_loop the ownership of the currently processed
>> buffer was set to SDMA again before running the callback function of
>> the buffer and while the sdma script may be running in parallel. So
>> there was the possibility to get the buffer overwritten by SDMA
>> before
>> it has been processed by kernel leading to kind of random errors in
>> the
>> upper layers, e.g. bluetooth.
>>
>> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
>>
>> ---
>>
>> Changelog v2:
>>  - add dma_wb()
>>
>>  drivers/dma/imx-sdma.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
>> index 9ba74ab7e912..e029a2443cfc 100644
>> --- a/drivers/dma/imx-sdma.c
>> +++ b/drivers/dma/imx-sdma.c
>> @@ -802,7 +802,6 @@ static void sdma_update_channel_loop(struct
>> sdma_channel *sdmac)
>>  		*/
>>  
>>  		desc->chn_real_count = bd->mode.count;
>> -		bd->mode.status |= BD_DONE;
>>  		bd->mode.count = desc->period_len;
>>  		desc->buf_ptail = desc->buf_tail;
>>  		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
>> @@ -817,6 +816,9 @@ static void sdma_update_channel_loop(struct
>> sdma_channel *sdmac)
>>  		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
>>  		spin_lock(&sdmac->vc.lock);
>>  
>> +		dma_wb();
> 
> Has this change been tested? The function you want here is called
> dma_wmb().
embarrassingly you are right. c&p error and even have not tried to build it :/
V3 comes soon..

Regards,
Philipp

> 
> Regards,
> Lucas
> 
>> +		bd->mode.status |= BD_DONE;
>> +
>>  		if (error)
>>  			sdmac->status = old_status;
>>  	}
> 

