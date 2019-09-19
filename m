Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96049B7623
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 11:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfISJUU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 05:20:20 -0400
Received: from mx1.emlix.com ([188.40.240.192]:57352 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730839AbfISJUU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 19 Sep 2019 05:20:20 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 3D96C603BE;
        Thu, 19 Sep 2019 11:20:17 +0200 (CEST)
Subject: Re: [PATCH 1/4] dmaengine: imx-sdma: fix buffer ownership
To:     Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, jslaby@suse.com, vkoul@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        gregkh@linuxfoundation.org, dmaengine@vger.kernel.org,
        dan.j.williams@intel.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
 <20190911144943.21554-2-philipp.puschmann@emlix.com>
 <9bcf315369449a025828410396935b679aae14bf.camel@pengutronix.de>
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
Openpgp: preference=signencrypt
Message-ID: <bd6ff4fb-0cbd-675e-a4f2-d311cfe2c62d@emlix.com>
Date:   Thu, 19 Sep 2019 11:20:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9bcf315369449a025828410396935b679aae14bf.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am 16.09.19 um 16:17 schrieb Lucas Stach:
> On Mi, 2019-09-11 at 16:49 +0200, Philipp Puschmann wrote:
>> BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the buffer,
>> when 0 ARM owns it. When processing the buffers in
>> sdma_update_channel_loop the ownership of the currently processed buffer
>> was set to SDMA again before running the callback function of the the
>> buffer and while the sdma script may be running in parallel. So there was
>> the possibility to get the buffer overwritten by SDMA before it has been
>> processed by kernel leading to kind of random errors in the upper layers,
>> e.g. bluetooth.
>>
>> It may be further a good idea to make the status struct member volatile or
>> access it using writel or similar to rule out that the compiler sets the
>> BD_DONE flag before the callback routine has finished.
>>
>> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
>> ---
>>  drivers/dma/imx-sdma.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
>> index a01f4b5d793c..1abb14ff394d 100644
>> --- a/drivers/dma/imx-sdma.c
>> +++ b/drivers/dma/imx-sdma.c
>> @@ -802,7 +802,6 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
>>  		*/
>>  
>>  		desc->chn_real_count = bd->mode.count;
>> -		bd->mode.status |= BD_DONE;
>>  		bd->mode.count = desc->period_len;
>>  		desc->buf_ptail = desc->buf_tail;
>>  		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
>> @@ -817,6 +816,8 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
>>  		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
>>  		spin_lock(&sdmac->vc.lock);
> 
> To address your comment from the second paragraph of the commit message
> there should be a dma_wmb() here before changing the status flag.
> 
> Regards,
> Lucas

Hi Lucas,

thanks for your feedback. I will apply the hints to v2 of the patches.

Regards,
Philipp
> 
>> +		bd->mode.status |= BD_DONE;
>> +
>>  		if (error)
>>  			sdmac->status = old_status;
>>  	}
> 
