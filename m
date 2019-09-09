Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12450AD2E3
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2019 07:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfIIF4Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 01:56:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39754 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfIIF4Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 01:56:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x895uLCs008703;
        Mon, 9 Sep 2019 00:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568008581;
        bh=2Bbb3tDAMJ9BxWKHx1geE957uzg9mJ+ZC0U5GDiSY3k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=m1EZ5Vq1ZPJz9OE7eQAEVOmlORQmpY7fLibYXbHR5dvyr74H3agnzO+EOBbnq0dmz
         wwAoadDzqYCLZSPWyyjATROcIXbA6BP5NMAljdzB3RXNIhn0z1ro/Ze/xkAXoLi/Wj
         L081ZbJKatb/KQoySjJSKdO6ctxLQKYAfSQeAm2Q=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x895uLq4123510;
        Mon, 9 Sep 2019 00:56:21 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 9 Sep
 2019 00:56:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 9 Sep 2019 00:56:20 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x895uIMK055091;
        Mon, 9 Sep 2019 00:56:19 -0500
Subject: Re: [RFC 3/3] dmaengine: Support for requesting channels preferring
 DMA domain controller
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-4-peter.ujfalusi@ti.com>
 <20190908121507.GN2672@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <0bd4d678-31be-bead-7591-0452b6fed5f2@ti.com>
Date:   Mon, 9 Sep 2019 08:56:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190908121507.GN2672@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/09/2019 15.15, Vinod Koul wrote:
> On 06-09-19, 17:18, Peter Ujfalusi wrote:
>> In case the channel is not requested via the slave API, use the
>> of_find_dma_domain() to see if a system default DMA controller is
>> specified.
>>
>> Add new function which can be used by clients to request channels by mask
>> from their DMA domain controller if specified.
>>
>> Client drivers can take advantage of the domain support by moving from
>> dma_request_chan_by_mask() to dma_domain_request_chan_by_mask()
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/dmaengine.c   | 17 ++++++++++++-----
>>  include/linux/dmaengine.h |  9 ++++++---
>>  2 files changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index 6baddf7dcbfd..087450eed68c 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -640,6 +640,10 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>>  	struct dma_device *device, *_d;
>>  	struct dma_chan *chan = NULL;
>>  
>> +	/* If np is not specified, get the default DMA domain controller */
>> +	if (!np)
>> +		np = of_find_dma_domain(NULL);
>> +
>>  	/* Find a channel */
>>  	mutex_lock(&dma_list_mutex);
>>  	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>> @@ -751,19 +755,22 @@ struct dma_chan *dma_request_slave_channel(struct device *dev,
>>  EXPORT_SYMBOL_GPL(dma_request_slave_channel);
>>  
>>  /**
>> - * dma_request_chan_by_mask - allocate a channel satisfying certain capabilities
>> - * @mask: capabilities that the channel must satisfy
>> + * dma_domain_request_chan_by_mask - allocate a channel by mask from DMA domain
>> + * @dev:	pointer to client device structure
>> + * @mask:	capabilities that the channel must satisfy
>>   *
>>   * Returns pointer to appropriate DMA channel on success or an error pointer.
>>   */
>> -struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
>> +struct dma_chan *dma_domain_request_chan_by_mask(struct device *dev,
>> +						 const dma_cap_mask_t *mask)
> 
> should we really use dma_request_chan_by_mask() why not create a new api
> dma_request_chan_by_domain() and use that, it falls back to
> dma_request_chan_by_mask() if it doesnt find a valid domain!

So:
struct dma_chan *dma_request_chan_by_domain(struct device *dev,
					    const dma_cap_mask_t *mask);

?

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
