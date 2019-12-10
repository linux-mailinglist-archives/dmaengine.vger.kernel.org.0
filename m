Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE20118C68
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 16:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLJPXx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 10:23:53 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42230 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfLJPXw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Dec 2019 10:23:52 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBAFNY6x005934;
        Tue, 10 Dec 2019 09:23:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575991414;
        bh=ZtoSxlcObKzPTWASgyBEsgR0ikWXgeBhuAR6gc29//0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ULAq52gHGz7HQGOwwhVJFvcowfN4B0EEe1RR8qpirNfhgNIrBQrGDFmCU9ZlWPRHr
         fl2QdR8kRlCkWCLl9bWdDbdvM1nKgs3o9uT6yLNB89VUf0yuBDQwETg7WRUo8cCZkP
         c/ML9hX6Q6O+8fOfhMFbIYZgVsv8BYgdRbD2l4lg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBAFNY6g066548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 09:23:34 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 09:23:34 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 09:23:34 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBAFNWlX036924;
        Tue, 10 Dec 2019 09:23:33 -0600
Subject: Re: [PATCH 1/6] dmaengine: virt-dma: Do not call desc_free() under a
 spin_lock
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     <dmaengine@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
References: <20191210123352.7555-1-s.hauer@pengutronix.de>
 <20191210123352.7555-2-s.hauer@pengutronix.de>
 <7f8c4ae6-88f9-7818-a9d6-cc55bcf62bd5@ti.com>
 <20191210141956.ymbivsl5tshv6rl2@pengutronix.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f605043e-4170-4105-c43a-79ced7b9728c@ti.com>
Date:   Tue, 10 Dec 2019 17:23:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210141956.ymbivsl5tshv6rl2@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/12/2019 16.19, Sascha Hauer wrote:
> On Tue, Dec 10, 2019 at 03:12:47PM +0200, Peter Ujfalusi wrote:
>>>  static inline void vchan_synchronize(struct virt_dma_chan *vc)
>>>  {
>>> +	LIST_HEAD(head);
>>>  	unsigned long flags;
>>>  
>>>  	tasklet_kill(&vc->task);
>>>  
>>>  	spin_lock_irqsave(&vc->lock, flags);
>>> -	if (vc->vd_terminated) {
>>> -		vchan_vdesc_fini(vc->vd_terminated);
>>> -		vc->vd_terminated = NULL;
>>> -	}
>>> +
>>> +	list_splice_tail_init(&vc->desc_terminated, &head);
>>> +
>>>  	spin_unlock_irqrestore(&vc->lock, flags);
>>> +
>>> +	vchan_dma_desc_free_list(vc, &head);
>>
>> My only issue with the vchan_dma_desc_free_list() is that it prints with
>> dev_dbg() for each descriptor it is freeing up.
>> The 'stuck' descriptor happens quite frequently if you start/stop audio
>> for example.
> 
> if we consider the message useful then I would say it's equally useful
> both for the 'stuck' descriptor and for the regular case.

The case with the 'stuck' descriptor is not really a stuck descriptor.
It is the cyclic descriptor which is by principle never completes so the
vchan_complete() would be never called for it -> we leaked descriptors
in audio start/stop/start/...

Printing about it up is like printing before each vc->desc_free() call
at each completion.

> IMO the debug message only makes sense if we make sure it is printed
> each time a descriptor is freed. Currently it's printed when the
> descriptor is freed from vchan_dma_desc_free_list(), but not when it's
> freed from vchan_vdesc_fini(). This is confusing as looking at the dmesg
> suggests that we lose descriptors.

The only case I can think when it is usable is when client prepared
several transfers, but decides to terminate the channel, or if several
descriptors are in the issued list waiting and the client terminates the
channel.

Enabling the debug for all free operation would easily make the device
overwhelmed with prints during boot (MMC rootfs w/ system DMA?).

I'm questioning the sole usefulness of the print. I don't think it adds
any value or information.

>> This is why I proposed a local
>>
>> list_for_each_entry_safe(vd, _vd, &head, node) {
>> 	list_del(&vd->node);
>> 	vchan_vdesc_fini(vd);
>> }
>>
>> On the other hand what vchan_dma_desc_free_list() is doing is exactly
>> the same thing as this loop is doing with the addition of the debug print.
>>
>> I'm not sure how useful that debug print is, not sure if anyone would
>> miss if it is gone?
>>
>> If not, than see my comment on patch 2.
> 
> We could add the dev_dbg into vchan_vdesc_fini() as well and still
> implement your suggestion on patch 2...

That would be a bad idea. imho.

> Anyway, I don't care much if the dev_dbg is there or not. I'll happily
> add a patch removing it for the next round if that's what we agree upon.

I would just drop the debug print ;)

Vinod?

> 
> Sascha
> 
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
