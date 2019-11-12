Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53568F89A1
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2019 08:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbfKLHXE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Nov 2019 02:23:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60290 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLHXD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Nov 2019 02:23:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAC7MtS3036617;
        Tue, 12 Nov 2019 01:22:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573543375;
        bh=eT3P/dHyd3eivjdDocbI/JCxXP7Qo8LHZ/vo4INoYeY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=E6s/TsZNByQ2yxi9Ii2JwvdKPeRSY8yV8KwfXREYr9qpUp1ibBJpulBMz8muEEPz7
         z97WtvfZJl5YmffY1D5iurJnLYX1EPlRXbvUGDu4CG/frGXKCesStVcrNKAQ7agrfA
         OBQdcEDNZBT6ScztaHfJrrMLPv5vjG6oX52+ae+w=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAC7MtZo047895;
        Tue, 12 Nov 2019 01:22:55 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 01:22:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 01:22:37 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAC7Mpn1104285;
        Tue, 12 Nov 2019 01:22:51 -0600
Subject: Re: [PATCH v4 12/15] dmaengine: ti: New driver for K3 UDMA - split#4:
 dma_device callbacks 1
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-13-peter.ujfalusi@ti.com>
 <20191111060943.GQ952516@vkoul-mobl>
 <6d73f6e1-6d85-d468-2e69-47d36ed75807@ti.com>
 <20191112053621.GW952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <28866241-dafe-5446-0cf2-b58368682603@ti.com>
Date:   Tue, 12 Nov 2019 09:24:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112053621.GW952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/11/2019 7.36, Vinod Koul wrote:
> On 11-11-19, 12:29, Peter Ujfalusi wrote:
>> On 11/11/2019 8.09, Vinod Koul wrote:
>>> On 01-11-19, 10:41, Peter Ujfalusi wrote:
> 
>>>> +static enum dma_status udma_tx_status(struct dma_chan *chan,
>>>> +				      dma_cookie_t cookie,
>>>> +				      struct dma_tx_state *txstate)
>>>> +{
>>>> +	struct udma_chan *uc = to_udma_chan(chan);
>>>> +	enum dma_status ret;
>>>> +	unsigned long flags;
>>>> +
>>>> +	spin_lock_irqsave(&uc->vc.lock, flags);
>>>> +
>>>> +	ret = dma_cookie_status(chan, cookie, txstate);
>>>> +
>>>> +	if (!udma_is_chan_running(uc))
>>>> +		ret = DMA_COMPLETE;
>>>
>>> so a paused channel will result in dma complete status?
>>
>> The channel is still enabled (running), the pause only sets a bit in the
>> channel's real time control register.
> 
> Okay and which cases will channel not be running i.e., you return
> DMA_COMPLETE above?

After terminate_all or before the first issue_pending call. When the
channel is disabled.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
