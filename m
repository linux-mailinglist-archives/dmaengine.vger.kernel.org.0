Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE06C78642
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 09:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfG2HWx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jul 2019 03:22:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50364 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfG2HWx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Jul 2019 03:22:53 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6T7Mid4063082;
        Mon, 29 Jul 2019 02:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564384964;
        bh=VnQ9Nv//8xBx58kK6E2oPeg3dqXVx2pbyRIDI1AqKV0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GHyl86mBC2VOEWrDJKZkxDR2RrIawERskz2V5queRcjgloAIm1wWHczwzPRL1reDC
         7aPpWUn69EWnCv7lWs4LXwHzL2v6REaFcaCoRCO5a9iuiap8ziSIAfCixAMKwgcVpo
         GDZuFQkX/12xFADUXD/65ZCZouz7KEUbIfiEuWuU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6T7Min0120738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jul 2019 02:22:44 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 29
 Jul 2019 02:22:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 29 Jul 2019 02:22:43 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6T7Mdo1056158;
        Mon, 29 Jul 2019 02:22:40 -0500
Subject: Re: [PATCH v5 0/3] dmaengine: ti: edma: Polled completion support
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
References: <20190716082655.1620-1-peter.ujfalusi@ti.com>
 <20190729064209.GF12733@vkoul-mobl.Dlink>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f051dd12-911b-2b13-1908-7f0e1bd4b695@ti.com>
Date:   Mon, 29 Jul 2019 10:22:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729064209.GF12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,

On 29/07/2019 9.42, Vinod Koul wrote:
> On 16-07-19, 11:26, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v4:
>> - Split the DMA_COMPLETE and !txstate check as Vinod suggested
>>
>> Change since v3:
>> - fix DMA pointer tracking for memcpy
>> - completion polling is only done when it is asked by not providing
>>   DMA_PREP_INTERRUPT for memcpy
>>
>> Changes since v2:
>> - Fix typo in the comment for patch 0
>>
>> Changes since v1:
>> - Cleanup patch for the array register handling
>> - typo fixed in patch2 commit message
>>
>> The code around the array register access was pretty confusing for the first
>> look, so clean them up first then use the cleaner way in the polled handling.
>>
>> When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
>> does not want to use interrupts for DMA completion or because it can not
>> rely on DMA interrupts due to executing the memcpy when interrupts are
>> disabled it will poll the status of the transfer.
>>
>> Since we can not tell from any EDMA register that the transfer is
>> completed, we can only know that the paRAM set has been sent to TPTC for
>> processing we need to check the residue of the transfer, if it is 0 then
>> the transfer is completed.
>>
>> The polled completion can bve tested by applying:
>> https://patchwork.kernel.org/patch/10966499/
>>
>> Enabling the memcpy for EDMA and run the dmatest with polled = 1.
>>
>> Or, enable the EDMA memcpy support and boot up any dra7 family device with
>> display enabled. The workaround for DMM errata i878 uses polled DMA memcpy.
> 
> Applied, thanks. Fixed typo in 2nd patch while at it

Thank you! I was about to send v6 with the fixed typo.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
