Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5238013A12D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 07:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgANG6W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 01:58:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34608 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgANG6V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jan 2020 01:58:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00E6w9uc083037;
        Tue, 14 Jan 2020 00:58:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578985089;
        bh=9cisbpiJjEXM+HQ9q627buGSbHVcnQI341z9kbrIfpk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=E2zln4VLdz+OvOKCRs6j5Z7Du0EDOzB9HIjUXdSW05jU87ywExFVwbW3XoLMMBCOG
         vdFFGdRPyLYLuSpIJZuhUKxzt/DieuQRL7BEBvkufGpUUoUxlskTSuvu0Eh9TQPh6v
         mogPdLTRMSX0bxCiRxZygH1dpbHen2EaZUVzcg6E=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00E6w9ZU098404
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jan 2020 00:58:09 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 14
 Jan 2020 00:58:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 14 Jan 2020 00:58:09 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00E6w5OR034860;
        Tue, 14 Jan 2020 00:58:06 -0600
Subject: Re: [PATCH v8 02/18] soc: ti: k3: add navss ringacc driver
To:     <santosh.shilimkar@oracle.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <frowand.list@gmail.com>
References: <20191223110458.30766-1-peter.ujfalusi@ti.com>
 <20191223110458.30766-3-peter.ujfalusi@ti.com>
 <6d70686b-a94e-18d1-7b33-ff9df7176089@ti.com>
 <900c2f21-22bf-47f9-5c3c-0a3d95a5d645@oracle.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ea6a87ae-b978-a786-27eb-db99483a82d9@ti.com>
Date:   Tue, 14 Jan 2020 08:58:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <900c2f21-22bf-47f9-5c3c-0a3d95a5d645@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Santosh,

On 13/01/2020 23.28, santosh.shilimkar@oracle.com wrote:
> 
> 
> On 12/23/19 3:38 AM, Peter Ujfalusi wrote:
>> Hi Santosh,
>>
>> On 23/12/2019 13.04, Peter Ujfalusi wrote:
>>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>>
>>> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
>>> enable straightforward passing of work between a producer and a
>>> consumer.
>>> There is one RINGACC module per NAVSS on TI AM65x SoCs.
>>>
>>> The RINGACC converts constant-address read and write accesses to
>>> equivalent
>>> read or write accesses to a circular data structure in memory. The
>>> RINGACC
>>> eliminates the need for each DMA controller which needs to access ring
>>> elements from having to know the current state of the ring (base
>>> address,
>>> current offset). The DMA controller performs a read or write access to a
>>> specific address range (which maps to the source interface on the
>>> RINGACC)
>>> and the RINGACC replaces the address for the transaction with a new
>>> address
>>> which corresponds to the head or tail element of the ring (head for
>>> reads,
>>> tail for writes). Since the RINGACC maintains the state, multiple DMA
>>> controllers or channels are allowed to coherently share the same
>>> rings as
>>> applicable. The RINGACC is able to place data which is destined towards
>>> software into cached memory directly.
>>>
>>> Supported ring modes:
>>> - Ring Mode
>>> - Messaging Mode
>>> - Credentials Mode
>>> - Queue Manager Mode
>>>
>>> TI-SCI integration:
>>>
>>> Texas Instrument's System Control Interface (TI-SCI) Message Protocol
>>> now
>>> has control over Ringacc module resources management (RM) and Rings
>>> configuration.
>>>
>>> The corresponding support of TI-SCI Ringacc module RM protocol
>>> introduced as option through DT parameters:
>>> - ti,sci: phandle on TI-SCI firmware controller DT node
>>> - ti,sci-dev-id: TI-SCI device identifier as per TI-SCI firmware spec
>>>
>>> if both parameters present - Ringacc driver will configure/free/reset
>>> Rings
>>> using TI-SCI Message Ringacc RM Protocol.
>>>
>>> The Ringacc driver manages Rings allocation by itself now and requests
>>> TI-SCI firmware to allocate and configure specific Rings only. It's done
>>> this way because, Linux driver implements two stage Rings allocation and
>>> configuration (allocate ring and configure ring) while TI-SCI Message
>>> Protocol supports only one combined operation (allocate+configure).
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> Reviewed-by: Tero Kristo <t-kristo@ti.com>
>>> Tested-by: Keerthy <j-keerthy@ti.com>
>>
>> Can you please giver your Acked-by for the ringacc patches if they are
>> still OK from your point of view as you had offered to take them before
>> I got comments from Lokesh.
>>
> Sure. But you really need to split the series so that dma engine and
> soc driver patches can be applied independently.

The ringacc is a build and runtime dependency for the DMA. I have hoped
that all of them can go via DMAengine (hence asking for your ACK on the
drivers/soc/ti/ patches) for 5.6.

> Can you please do that?

This late in the merge window that would really mean that I will miss
another release for the KS3 DMA...
I can live with that if you can pick the ringacc for 5.6 and if Vinod
takes the DMAengine core changes as well.

That would leave only the DMA drivers for 5.7 and we can also queue up
changes for 5.7 which depends on the DMAengine API (ASoC changes, UART,
sa2ul, etc).

If they go independently and nothing makes it to 5.6 then 5.8 is the
realistic target for the DMA support for the KS3 family of devices...

Regards,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
