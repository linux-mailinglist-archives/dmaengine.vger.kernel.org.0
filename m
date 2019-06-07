Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD6838BBA
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2019 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfFGNfl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jun 2019 09:35:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45212 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfFGNfk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jun 2019 09:35:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x57DZSMw126286;
        Fri, 7 Jun 2019 08:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559914528;
        bh=bmgnxqXqETSqwCHC4eaX3bDsAPKHDrU/WVJdeJVaAXk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mB982WeDh1CcAdFl8czdDnb7rakbJ1z9aHhUpjafQd3rBxyRG6CpvCVbK9zRy5hvX
         DDlHJrkdx+goQqLuJ8zprbOunyYhDl1T0xUxLp5dqV/i7/w7cvkuDuxJGjjHktyIvu
         IggtTHLxTLBFBAiUyIHmYtFA7Vwnw/1aMlKOqgf0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x57DZSHB121601
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Jun 2019 08:35:28 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 7 Jun
 2019 08:35:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 7 Jun 2019 08:35:27 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x57DZPKF073408;
        Fri, 7 Jun 2019 08:35:25 -0500
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Jon Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <mkumard@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <ed95f03a-bbe7-ad62-f2e1-9bfe22ec733a@ti.com>
 <4cab47d0-41c3-5a87-48e1-d7f085c2e091@nvidia.com>
 <8a5b84db-c00b-fff4-543f-69d90c245660@nvidia.com>
 <3f836a10-eaf3-f59b-7170-6fe937cf2e43@ti.com>
 <a36302fc-3173-070b-5c97-7d2c55d5e2cc@nvidia.com>
 <a08bec36-b375-6520-eff4-3d847ddfe07d@ti.com>
 <4593f37c-5e89-8559-4e80-99dbfe4235de@nvidia.com>
 <d0db90e3-3d05-dfba-8768-28511d9ee3ac@ti.com>
 <5208a50a-9ca0-8f24-9ad0-d7503ec53f1c@nvidia.com>
 <ba845a19-5dfb-a891-719f-43821b2dd412@nvidia.com>
 <e67a2d7c-5bd1-93ad-fe75-afcab38bc17c@ti.com>
 <a65f2b07-4a3a-7f83-e21f-8b374844a4b9@nvidia.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <56aa6f45-cfd8-7f1e-9392-628ceb58093f@ti.com>
Date:   Fri, 7 Jun 2019 16:35:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a65f2b07-4a3a-7f83-e21f-8b374844a4b9@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 07/06/2019 15.58, Jon Hunter wrote:
>> Imho if you can explain it without using 'HACK' in the sentences it
>> might be OK, but it does not feel right.
> 
> I don't perceive this as a hack. Although from looking at the
> description of the src/dst_maxburst these are burst size with regard to
> the device, so maybe it is a stretch.
> 
>> However since your ADMA and ADMIF is highly coupled and it does needs
>> special maxburst information (burst and allocated FIFO depth) I would
>> rather use src_maxburst/dst_maxburst alone for DEV_TO_MEM/MEM_TO_DEV:
>>
>> ADMA_BURST_SIZE(maxburst)	((maxburst) & 0xff)
>> ADMA_FIFO_SIZE(maxburst)	(((maxburst) >> 8) & 0xffffff)
>>
>> So lower 1 byte is the burst value you want from ADMA
>> the other 3 bytes are the allocated FIFO size for the given ADMAIF channel.
>>
>> Sure, you need a header for this to make sure there is no
>> misunderstanding between the two sides.
> 
> I don't like this because as I mentioned to Dmitry, the ADMA can perform
> memory-to-memory transfers where such encoding would not be applicable.

mem2mem does not really use dma_slave_config, it is for used by
is_slave_direction() == true type of transfers.

But true, if you use ADMA against anything other than ADMAIF then this
might be not right for non cyclic transfers.

> That does not align with the description in the
> include/linux/dmaengine.h either.

True.

>> Or pass the allocated FIFO size via maxburst and then the ADMA driver
>> will pick a 'good/safe' burst value for it.
>>
>> Or new member, but do you need two of them for src/dst? Probably
>> fifo_depth is better word for it, or allocated_fifo_depth.
> 
> Right, so looking at the struct dma_slave_config we have ...
> 
> u32 src_maxburst;
> u32 dst_maxburst;
> u32 src_port_window_size;
> u32 dst_port_window_size;
> 
> Now if we could make these window sizes a union like the following this
> could work ...
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 8fcdee1c0cf9..851251263527 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -360,8 +360,14 @@ struct dma_slave_config {
>         enum dma_slave_buswidth dst_addr_width;
>         u32 src_maxburst;
>         u32 dst_maxburst;
> -       u32 src_port_window_size;
> -       u32 dst_port_window_size;
> +       union {
> +               u32 port_window_size;
> +               u32 port_fifo_size;
> +       } src;
> +       union {
> +               u32 port_window_size;
> +               u32 port_fifo_size;
> +       } dst;

What if in the future someone will have a setup where they would need both?

So not sure. Your problems are coming from a split DMA setup where the
two are highly coupled, but sits in a different place and need to be
configured as one device.

I think xilinx_dma is facing with similar issues and they have a custom
API to set parameters which does not fit or is peripheral specific:
include/linux/dma/xilinx_dma.h

Not sure if that is an acceptable solution.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
