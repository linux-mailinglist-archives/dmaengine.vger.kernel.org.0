Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201BF36C0F
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 08:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbfFFGLO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 02:11:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59232 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFGLO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 02:11:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x565xpkC056377;
        Thu, 6 Jun 2019 00:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559800791;
        bh=9heKrnOXHvL95qTzCc29Ui6sssSZQTwyI7UPhTtnmz8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nGwMH4vi2KH+EkExCBhtEZXxcR1u7izGwf+DXV2ql0k+SZkaRc+d6OEQ38jV43deK
         WusNDzHBInEHR2ru6z34YfZYyzyVYpNPD59M/5KhSXWfeE+Rzqg+Yl/oHHliMiEKNp
         BUCT+vFFahFtWzIUn4lKAOt0WgHpCDaFiq84AaRk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x565xpcr083934
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Jun 2019 00:59:51 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 6 Jun
 2019 00:59:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 6 Jun 2019 00:59:49 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x565xlWC073686;
        Thu, 6 Jun 2019 00:59:47 -0500
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>, <mkumard@nvidia.com>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ed95f03a-bbe7-ad62-f2e1-9bfe22ec733a@ti.com>
Date:   Thu, 6 Jun 2019 09:00:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sameer,

On 06/06/2019 6.49, Sameer Pujar wrote:
> Sorry for late reply.
> [Resending the reply since delivery failed for few recipients]
> I discussed this internally with HW folks and below is the reason why
> DMA needs
> to know FIFO size.
> 
> - FIFOs reside in peripheral device(ADMAIF), which is the ADMA interface
> to the audio sub-system.
> - ADMAIF has multiple channels and share FIFO buffer for individual
> operations. There is a provision
>   to allocate specific fifo size for each individual ADMAIF channel from
> the shared buffer.
> - Tegra Audio DMA(ADMA) architecture is different from the usual DMA
> engines, which you described earlier.

It is not really different than what other DMAs are doing.

> - The flow control logic is placed inside ADMA. Slave peripheral
> device(ADMAIF) signals ADMA whenever a
>   read or write happens on the FIFO(per WORD basis). Please note that
> the signaling is per channel. There is
>   no other signaling present from ADMAIF to ADMA.
> - ADMA keeps a counter related to above signaling. Whenever a sufficient
> space is available, it initiates a transfer.
>   But the question is, how does it know when to transfer. This is the
> reason, why ADMA has to be aware of FIFO
>   depth of ADMAIF channel. Depending on the counters and FIFO depth, it
> knows exactly when a free space is available
>   in the context of a specific channel. On ADMA, FIFO_SIZE is just a
> value which should match to actual FIFO_DEPTH/SIZE
>   of ADMAIF channel.
> - Now consider two cases based on above logic,
>   * Case 1: when DMA_FIFO_SIZE > SLAVE_FIFO_SIZE
>     In this case, ADMA thinks that there is enough space available for
> transfer, when actually the FIFO data
>     on slave is not consumed yet. It would result in OVERRUN.
>   * Case 2: when DMA_FIFO_SIZE < SLAVE_FIFO_SIZE
>     This is case where ADMA won’t transfer, even though sufficient space
> is available, resulting in UNDERRUN.
> - The guideline is to program, DMA_FIFO_SIZE(on ADMA side) =
> SLAVE_FIFO_SIZE(on ADMAIF side) and hence we need a
>   way to communicate fifo size info to ADMA.

The src_maxburst / dst_maxburst is exactly for this reason. To
communicate how much data should be transferred per DMA request to/from
peripheral.

In TI land we have now 3 DMA engines servicing McASP. McASP has FIFO
which is dynamically configured (you can see the AFIFO of McASP as a
small DMA: on McASP side it services the peripheral, on the other side
it interacts with the given system DMA used by the SoC - EDMA, sDMA or
UDMAP). All DMAs needs a bit different configuration, but the AFIFO
depth on the McASP side is coming in via the src/dst_maxburst and the
drivers just need to interpret it correctly.

It does sounds like that FIFO_SIZE == src/dst_maxburst in your case as well.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
