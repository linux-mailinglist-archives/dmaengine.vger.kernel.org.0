Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B321925D16B
	for <lists+dmaengine@lfdr.de>; Fri,  4 Sep 2020 08:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgIDG37 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Sep 2020 02:29:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42278 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgIDG36 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Sep 2020 02:29:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0846TrQ6125651;
        Fri, 4 Sep 2020 01:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599200993;
        bh=uUM2Oj4qkFE3oYXIgBVnfIb36eIz3gZ7/uHRmD/RPxo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cOcSzMdYt/WiWfLI5cIvdXi9Oswm8+h4tMhNJFNtpiRqLhO8Gt0MIwuP4YMx52Bi2
         qyzSPZJfBaQIxp8S+UavpSpSMzaH1KFemRoEmds9s3nCsQeJF4XLcRxEglL3Pur/lm
         AmmYVTDYJOt+jEFD3VyWyC2mjLUCeAtAtgk19fsU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0846TrXA008913
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Sep 2020 01:29:53 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 4 Sep
 2020 01:29:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 4 Sep 2020 01:29:53 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0846ToFE045013;
        Fri, 4 Sep 2020 01:29:51 -0500
Subject: Re: [PATCH v5 2/2] Add Intel LGM soc DMA support.
To:     "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>,
        <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <andriy.shevchenko@intel.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>,
        <chuanhua.lei@linux.intel.com>, <malliamireddy009@gmail.com>
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <cdd26d104000c060d85a0c5f8abe8492e4103de5.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <fbc98cdb-3b50-cbcc-0e90-c9d6116566d1@ti.com>
 <bf3e4422-b023-4148-9aa6-60c4d74fe5a9@linux.intel.com>
 <3aea19e6-de96-12ba-495c-94b3b313074d@ti.com>
 <51ed096a-d211-9bab-bf1e-44f912b2a20e@linux.intel.com>
 <831fadff-8127-7634-32be-0000e69e0d94@ti.com>
 <6a2e572e-c169-21d5-d36f-23972a24cc54@linux.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <331db01b-ceea-64bd-0eff-5c75134a603b@ti.com>
Date:   Fri, 4 Sep 2020 09:31:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6a2e572e-c169-21d5-d36f-23972a24cc54@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 31/08/2020 11.07, Reddy, MallikarjunaX wrote:
>=20
> On 8/28/2020 7:17 PM, Peter Ujfalusi wrote:
>> Hi,
>>
>> On 27/08/2020 17.41, Reddy, MallikarjunaX wrote:
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_alloc_chan_resources =3D
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d->inst->ops->device_=
alloc_chan_resources;
>>>>>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_free_chan_resources =3D
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d->inst->ops->device_=
free_chan_resources;
>>>>>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_terminate_all =3D
>>>>>>> d->inst->ops->device_terminate_all;
>>>>>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_issue_pending =3D
>>>>>>> d->inst->ops->device_issue_pending;
>>>>>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_tx_status =3D d->inst->ops->d=
evice_tx_status;
>>>>>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_resume =3D d->inst->ops->devi=
ce_resume;
>>>>>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_pause =3D d->inst->ops->devic=
e_pause;
>>>>>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_config =3D d->inst->ops->devi=
ce_config;
>>>>>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_prep_slave_sg =3D
>>>>>>> d->inst->ops->device_prep_slave_sg;
>>>>>>> +=C2=A0=C2=A0=C2=A0 dma_dev->device_synchronize =3D d->inst->ops-=
>device_synchronize;
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0 if (d->ver =3D=3D DMA_VER22) {
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_dev->src_addr_wid=
ths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_dev->dst_addr_wid=
ths =3D BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_dev->directions =3D=
 BIT(DMA_MEM_TO_DEV) |
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(DMA_DEV_=
TO_MEM);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_dev->residue_gran=
ularity =3D
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMA_RESIDUE_GRANULARITY_=
DESCRIPTOR;
>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>> So, if version is !=3D DMA_VER22, then you don't support any direc=
tion?
>>>>>> Why register the DMA device if it can not do any transfer?
>>>>> Only dma0 instance (intel,lgm-cdma) is used as a general purpose sl=
ave
>>>>> DMA. we set both control and datapath here.
>>>>> Other instances we set only control path. data path is taken care
>>>>> by dma
>>>>> client(GSWIP).
>>>> How the client (GSWIP) can request a channel from intel,lgm-* ? Don'=
t
>>>> you need some capabilities for the DMA device so core can sort out t=
he
>>>> request?
>>> client request channel by name, dma_request_slave_channel(dev, name);=

>> clients should use dma_request_chan(dev, name);
>>
>> If the channel can be requested via DT or ACPI then we don't check the=

>> capabilities at all, so yes, that could work.
>>
>>>>> Only thing needs to do is get the channel, set the descriptor and j=
ust
>>>>> on the channel.
>>>> How do you 'on' the channel?
>>> we on the channel in issue_pending.
>> Right.
>> Basically you only prep_slave_sg/single for the DMA_VER22? Or do you
>> that for the others w/o direction support?
>
> Yes. prep_slave_sg/single only for the DMA_VER22.

So, you place the transfers to DMA_VER22's channel

>>
>> For the intel,lgm-* DMAs you only call issue_pending() and probably
>> terminate_all?
> Yes, correct.

and issue_pending on a channel which does not have anything pending?
How client knows which of the 'only need to be ON' channel to enable
when it placed a transfer to another channel?

How would the client driver (and the IP) would be integrated with
different system DMA which have standard channel management?

If DMA_VER22 knows which intel,lgm-* it should place the transfer then
with virt-dma you can handle that just fine?

Do you have public documentation for the DMA? It sounds a bit like TI's
EDMA which is in essence is a two part  setup:
CC: Channel Controller - to submit transfers (like your DMA_VER22)
TC: Transfer Controller - it executes the transfers submitted by the CC

One CC can be backed by multiple TCs. I don't have direct control over
the TC (can not start/stop), it is controlled by the CC.

Documentation/devicetree/bindings/dma/ti-edma.txt

Or is it a different setup?

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

