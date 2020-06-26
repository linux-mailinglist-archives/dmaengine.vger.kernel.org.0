Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B926020AFAB
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2020 12:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgFZK2l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Jun 2020 06:28:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56474 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgFZK2l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Jun 2020 06:28:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05QASVew022878;
        Fri, 26 Jun 2020 05:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593167311;
        bh=2sgKdorcdIQb8LjqWsTteHIxdXbBN5knpabZ6nwoafs=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=D3PCkC1/VCfGCD7k/3eOdi9XGaQscK+5RKsXGCQwKgc18gfb/qtqLxLEhVuo87ntD
         8Q/f2KiCp8r5Fkd/fUBgJYArIraq+uQ66acSlePF8scpaxkK7Iujpx+YnOIlj2xFP2
         drC+ABBiCI3WUm0LOWrC1OrGP065xYDhI7WX5c9I=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05QASVRs104244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Jun 2020 05:28:31 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 26
 Jun 2020 05:28:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 26 Jun 2020 05:28:31 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05QASSYD018142;
        Fri, 26 Jun 2020 05:28:29 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: DMA Engine: Transfer From Userspace
To:     Thomas Ruf <freelancer@rufusul.de>, Vinod Koul <vkoul@kernel.org>
CC:     Federico Vaga <federico.vaga@cern.ch>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
 <419762761.402939.1592827272368@mailbusiness.ionos.de>
 <20200622155440.GM2324254@vkoul-mobl>
 <1835214773.354594.1592843644540@mailbusiness.ionos.de>
 <2077253476.601371.1592991035969@mailbusiness.ionos.de>
 <20200624093800.GV2324254@vkoul-mobl>
 <3a4b1b55-7bce-2c48-b897-51e23e850127@ti.com>
 <1666251320.1024432.1593007095381@mailbusiness.ionos.de>
X-Pep-Version: 2.0
Message-ID: <1a610c67-73a4-f66d-877a-5c4d35cbf76a@ti.com>
Date:   Fri, 26 Jun 2020 13:29:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1666251320.1024432.1593007095381@mailbusiness.ionos.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 24/06/2020 16.58, Thomas Ruf wrote:
>=20
>> On 24 June 2020 at 14:07 Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:=

>> On 24/06/2020 12.38, Vinod Koul wrote:
>>> On 24-06-20, 11:30, Thomas Ruf wrote:
>>>
>>>> To make it short - i have two questions:
>>>> - what are the chances to revive DMA_SG?
>>>
>>> 100%, if we have a in-kernel user
>>
>> Most DMAs can not handle differently provisioned sg_list for src and d=
st.
>> Even if they could handle non symmetric SG setup it requires entirely
>> different setup (two independent channels sending the data to each
>> other, one reads, the other writes?).
>=20
> Ok, i implemented that using zynqmp_dma on a Xilinx Zynq platform (obvi=
ously ;-) and it works nicely for us.

I see, if the HW does not support it then something along the lines of
what the atc_prep_dma_sg did can be implemented for most engines.

In essence: create a new set of sg_list which is symmetric.

> Don't think that it uses two channels from what a saw in their implemen=
tation.

I believe it was breaking it up like atc_prep_dma_sg did.

> Of course that was on kernel 4.19.x where DMA_SG was still available.
>=20
>>>> - what are the chances to get my driver for memcpy like transfers fr=
om
>>>> user space using DMA_SG upstream? ("dma-sg-proxy")
>>>
>>> pretty bleak IMHO.
>>
>> fwiw, I also get requests time-to-time to DMA memcpy support from user=

>> space from companies trying to move from bare-metal code to Linux.
>>
>> What could be plausible is a generic dmabuf-to-dmabuf copy driver (V4L=
2
>> can provide dma-buf, DRM can also).
>> If there is a DMA memcpy channel available, use that, otherwise use so=
me
>> method to do the copy, user space should not care how it is done.
>=20
> Yes, i'm using it together with a v4l2 capture driver and also saw the =
dma-buf thing but did not find a way how to bring this together with "ord=
inary user memory".

One of the aim of dma-buf is to share buffers between drivers and user
space (among drivers and/or drivers and userspace), but I might be
missing something.

> For me the root of my problem seems to be that dma_alloc_coherent leads=
 to uncached memory on ARM platforms.

It depends, but in most cases that is true.

> But maybe i am doing it all wrong ;-)
>=20
>> Where things are going to get a bit more trickier is when the copy nee=
ds
>> to be triggered by other DMA channel (completion of a frame reception
>> triggering an interleaved sub-frame extraction copy).
>> You don't want to extract from a buffer which can be modified while th=
e
>> other channel is writing to it.
>=20
> I think that would be no problem in case of our v4l2 capture driver doi=
ng both DMAs:
> Framebuffer DMA for streaming and Zynqmp DMA (using DMA_SG) to get it t=
o "ordinary user memory".
> But as i wrote before i prefer to do the "logic and management" in user=
space so the capture driver is just using the first DMA and the "dma-sg-p=
roxy" driver is only used as a memcpy replacement.
> As said this is all working fine with kernel 4.19.x but now we are stuc=
k :-(
>=20
>> In Linux the DMA is used for kernel and user space can only use it
>> implicitly via standard subsystems.
>> Misused DMA can be very dangerous and giving full access to program a
>> transfer can open a can of worms.
>=20
> Fully understand that!
> But i also hope you understand that we are developing a "closed system"=
 and do not have a problem with that at all.
> We are also willing to bring that driver upstream for anyone doing the =
same but of course this should not affect security of any desktop or serv=
er systems.
> Maybe we just need the right place for that driver?!

What might be plausible is to introduce hw offloading support for memcpy
type of operations in a similar fashion how for example crypto does it?

The issue with a user space implemented logic is that it is not portable
between systems with different DMAs. It might be that on one DMA the
setup takes longer than do a CPU copy of X bytes, on the other DMA it
might be significantly less or higher.

Using CPU vs DMA for a copy in certain lengths and setups should not be
a concern of the user space.
Yes, you have a closed system with controlled parameters, but a generic
mem2mem_offload framework should be usable on other setups and the same
binary should be working on different DMAs where one is not efficient
for <512 bytes, the other shows benefits under 128bytes.

> Not sure if staging would change your concerns.
>=20
> Thanks and best regards,
> Thomas
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

