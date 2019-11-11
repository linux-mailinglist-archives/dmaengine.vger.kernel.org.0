Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C80F703B
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2019 10:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfKKJPF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Nov 2019 04:15:05 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44204 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJPF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Nov 2019 04:15:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAB9Etav002180;
        Mon, 11 Nov 2019 03:14:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573463695;
        bh=A9b+LfFAU9abDyZML7frujnSPbQT16TGgA6T2WhOOz4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fQXw6SsF4mnZggBOhlgS28uuqZ4Tzagnl1FPaRYECHFiWK6vN9ubexYdHjs1HIhZ4
         8Fy986pCalwDYiZXODoSgiQJIoj+1iYER22prIGrZPa3Qcwdu5LLK1nqegB9+BFZr/
         Rf8UcyjnoItwQGskYC/OHAIMqer6vRO859N09DhI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAB9Et3o062305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Nov 2019 03:14:55 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 03:14:37 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 03:14:37 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAB9Epbh106565;
        Mon, 11 Nov 2019 03:14:51 -0600
Subject: Re: [PATCH v4 10/15] dmaengine: ti: New driver for K3 UDMA - split#2:
 probe/remove, xlate and filter_fn
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-11-peter.ujfalusi@ti.com>
 <20191111053301.GO952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <9b0f8bec-4964-8136-4173-7b45e479c0c5@ti.com>
Date:   Mon, 11 Nov 2019 11:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111053301.GO952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 11/11/2019 7.33, Vinod Koul wrote:
> On 01-11-19, 10:41, Peter Ujfalusi wrote:
> 
>> +static bool udma_dma_filter_fn(struct dma_chan *chan, void *param)
>> +{
>> +	struct psil_endpoint_config *ep_config;
>> +	struct udma_chan *uc;
>> +	struct udma_dev *ud;
>> +	u32 *args;
>> +
>> +	if (chan->device->dev->driver != &udma_driver.driver)
>> +		return false;
>> +
>> +	uc = to_udma_chan(chan);
>> +	ud = uc->ud;
>> +	args = param;
>> +	uc->remote_thread_id = args[0];
>> +
>> +	if (uc->remote_thread_id & K3_PSIL_DST_THREAD_ID_OFFSET)
>> +		uc->dir = DMA_MEM_TO_DEV;
>> +	else
>> +		uc->dir = DMA_DEV_TO_MEM;
> 
> Can you explain this a bit?

The UDMAP in K3 works between two PSI-L endpoint. The source and
destination needs to be paired to allow data flow.
Source thread IDs are in range of 0x0000 - 0x7fff, while destination
thread IDs are 0x8000 - 0xffff.

If the remote thread ID have the bit 31 set (0x8000) then the transfer
is MEM_TO_DEV and I need to pick one unused tchan for it. If the remote
is the source then it can be handled by rchan.

dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
dma-names = "tx", "rx";

0xc400 is a destination thread ID, so it is MEM_TO_DEV
0x4400 is a source thread ID, so it is DEV_TO_MEM

Even in MEM_TO_MEM case I need to pair two UDMAP channels:
UDMAP source threads are starting at offset 0x1000, UDMAP destination
threads are 0x9000+

Changing direction runtime is hardly possible as it would involve
tearing down the channel, removing interrupts, destroying rings,
removing the PSI-L pairing and redoing everything.

>> +static int udma_remove(struct platform_device *pdev)
>> +{
>> +	struct udma_dev *ud = platform_get_drvdata(pdev);
>> +
>> +	of_dma_controller_free(pdev->dev.of_node);
>> +	dma_async_device_unregister(&ud->ddev);
>> +
>> +	/* Make sure that we did proper cleanup */
>> +	cancel_work_sync(&ud->purge_work);
>> +	udma_purge_desc_work(&ud->purge_work);
> 
> kill the vchan tasklets at it too please

Oh, I have missed that, I'll add it.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
