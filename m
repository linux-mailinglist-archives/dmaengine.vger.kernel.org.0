Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80D614B25C
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 11:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgA1KPF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 05:15:05 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35468 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgA1KPE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 05:15:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00SAEwN4095092;
        Tue, 28 Jan 2020 04:14:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580206498;
        bh=mWUZieK6VsDsxDGqbbUR433/WEuy/vg/QgAzz5vfMug=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=sKgYgrRteNIehHg8xpRo+9MSHKvrA0wgASmKce80BcF9/djWJwwn3NEfwnKYLNG6J
         Zo8YS+McVIhcFCwiKQtkYSNdWe3Ew+5pGHYLn/1mNe1V5U0PMtgHQgk3xQcW5Dwn1J
         wfziPuLo9cuAg4rB6Me9C4Qp6Ok68yHK7sr7avrA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00SAEwEo130116
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jan 2020 04:14:58 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 28
 Jan 2020 04:14:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 28 Jan 2020 04:14:56 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00SAEtsp084177;
        Tue, 28 Jan 2020 04:14:55 -0600
Subject: Re: [PATCH for-next 0/4] dmaengine: ti: k3-udma: Updates for next
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>
References: <20200127132111.20464-1-peter.ujfalusi@ti.com>
Message-ID: <41c53cc4-fa3e-1ab1-32b8-1d516cda7341@ti.com>
Date:   Tue, 28 Jan 2020 12:15:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200127132111.20464-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,

On 27/01/2020 15.21, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> Based on customer reports we have identified two issues with the UDMA driver:
> 
> TX completion (1st patch):
> The scheduled work based workaround for checking for completion worked well for
> UART, but it had significant impact on SPI performance.
> The underlying issue is coming from the fact that we have split data movement
> architecture.
> In order to know that the transfer is really done we need to check the remote
> end's (PDMA) byte counter.
> 
> RX channel teardown with stale data in PDMA (2nd patch):
> If we try to stop the RX DMA channel (teardown) then PDMA is trying to flush the
> data is might received from a peripheral, but if UDMA does not have a packet to
> use for this draining than it is going to push back on the PDMA and the flush
> will never completes.
> The workaround is to use a dummy descriptor for flush purposes when the channel
> is terminated and we did not have active transfer (no descriptor for UDMA).
> This allows UDMA to drain the data and the teardown can complete.
> 
> The last two patch is to use common code to set up the TR parameters for
> slave_sg, cyclic and memcpy. The setup code is the same as we used for memcpy
> with the change we can handle 4.2GB sg elements and periods in case of cyclic.
> It is also nice that we have single function to do the configuration.

I have marked these patches as for-next as 5.5 was not released yet.
Would it be possible to have these as fixes for 5.6?

Thanks,
- Péter

> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   dmaengine: ti: k3-udma: Workaround for RX teardown with stale data in
>     peer
>   dmaengine: ti: k3-udma: Move the TR counter calculation to helper
>     function
>   dmaengine: ti: k3-udma: Use the TR counter helper for slave_sg and
>     cyclic
> 
> Vignesh Raghavendra (1):
>   dmaengine: ti: k3-udma: Use ktime/usleep_range based TX completion
>     check
> 
>  drivers/dma/ti/k3-udma.c | 452 +++++++++++++++++++++++++++++----------
>  1 file changed, 343 insertions(+), 109 deletions(-)
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
