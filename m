Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6E118421
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 10:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLJJwE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 04:52:04 -0500
Received: from mx1.emlix.com ([188.40.240.192]:52806 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbfLJJwD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Dec 2019 04:52:03 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 04:52:02 EST
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 988E75FE45;
        Tue, 10 Dec 2019 10:44:30 +0100 (CET)
Subject: Re: [PATCH v5 1/3] dmaengine: imx-sdma: fix buffer ownership
To:     Robin Gong <yibin.gong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "jlu@pengutronix.de" <jlu@pengutronix.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190923135808.815-1-philipp.puschmann@emlix.com>
 <20190923135808.815-2-philipp.puschmann@emlix.com>
 <VE1PR04MB6638A9E882D40FB7F8CB7F14895D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
Message-ID: <eb584cf0-2be4-138f-e339-aaf9f6f203b0@emlix.com>
Date:   Tue, 10 Dec 2019 10:44:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB6638A9E882D40FB7F8CB7F14895D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



Am 04.12.19 um 10:19 schrieb Robin Gong:
> On 2019-9-23 Philipp Puschmann <philipp.puschmann@emlix.com> wrote:
>> BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the buffer,
>> when 0 ARM owns it. When processing the buffers in
>> sdma_update_channel_loop the ownership of the currently processed buffer
>> was set to SDMA again before running the callback function of the buffer and
>> while the sdma script may be running in parallel. So there was the possibility to
>> get the buffer overwritten by SDMA before it has been processed by kernel
> Does this patch need indeed? I don't think any difference here move done flag
> before callback or after callback, because callback never care this flag and actually
> done flag is setup for next time rather than this time.
The callback doesn't care, but the DMA controller cares about this flag. I see a possible race
condition here. If i set the DONE flag for a specific buffer descriptor before handling the
data belonging to this buffer descriptor (aka running the callback function) the DMA script running
at the same time could corrupt that data while being processed.
Or is there are mechanism that prevents this case, that i havn't considered here.

> Basically, this flag should be
> set to 1 quickly asap so that sdma could use this bd asap. If delay the flag may cause
> sdma channel stop since all BDs consumed.

> Could you try again your case without this patch?
I don't have the hw to reproduce this available at the moment but as i remember i did run it without
this patch successfully already. The problem i have described above was more a logical or theoretical
one than a problem that really occured with my setup.

>> leading to kind of random errors in the upper layers, e.g. bluetooth.
>>
>> Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
>> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
>> ---
>>
>> Changelog v5:
>>  - no changes
>>
>> Changelog v4:
>>  - fixed the fixes tag
>>
>> Changelog v3:
>>  - use correct dma_wmb() instead of dma_wb()
>>  - add fixes tag
>>
>> Changelog v2:
>>  - add dma_wb()
>>
>>  drivers/dma/imx-sdma.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
>> 9ba74ab7e912..b42281604e54 100644
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
>>  		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd; @@ -817,6
>> +816,9 @@ static void sdma_update_channel_loop(struct sdma_channel
>> *sdmac)
>>  		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
>>  		spin_lock(&sdmac->vc.lock);
>>
>> +		dma_wmb();
>> +		bd->mode.status |= BD_DONE;
>> +
>>  		if (error)
>>  			sdmac->status = old_status;
>>  	}
>> --
>> 2.23.0
> 
