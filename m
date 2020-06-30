Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159F720F49D
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733311AbgF3Mag (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 08:30:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58610 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbgF3Maf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Jun 2020 08:30:35 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05UCUP88019337;
        Tue, 30 Jun 2020 07:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593520225;
        bh=EQaiKYjbNB8HuWa8sKmWUugU4qHf1DWCOZOkP4WeozE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=f1+k9zM/36lJdPIRS8gFxcSqGMIxVd0UCp5ElLP8pLL7qaaXTe3SIKaj7wBs4Pcx5
         3g2eX0O4IatLF2thOPiDorUTsNZkGGeuSBQ2wFcVhX27+RFP5OduqGzrhHIMs3uJPk
         8buDOcxXgfTeDbJFZnvJ9AWoSWqD8xAl3aGKwHDg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05UCUPL8124644;
        Tue, 30 Jun 2020 07:30:25 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 30
 Jun 2020 07:30:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 30 Jun 2020 07:30:14 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05UCUC24033373;
        Tue, 30 Jun 2020 07:30:12 -0500
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
 <1a610c67-73a4-f66d-877a-5c4d35cbf76a@ti.com>
 <1819433567.1017000.1593443883087@mailbusiness.ionos.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <391e0aee-e35b-fa39-ab86-18fe33a776ee@ti.com>
Date:   Tue, 30 Jun 2020 15:31:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1819433567.1017000.1593443883087@mailbusiness.ionos.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 29/06/2020 18.18, Thomas Ruf wrote:
>=20
>> On 26 June 2020 at 12:29 Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:=

>>
>> On 24/06/2020 16.58, Thomas Ruf wrote:
>>>
>>>> On 24 June 2020 at 14:07 Peter Ujfalusi <peter.ujfalusi@ti.com> wrot=
e:
>>>> On 24/06/2020 12.38, Vinod Koul wrote:
>>>>> On 24-06-20, 11:30, Thomas Ruf wrote:
>>>>>
>>>>>> To make it short - i have two questions:
>>>>>> - what are the chances to revive DMA_SG?
>>>>>
>>>>> 100%, if we have a in-kernel user
>>>>
>>>> Most DMAs can not handle differently provisioned sg_list for src and=
 dst.
>>>> Even if they could handle non symmetric SG setup it requires entirel=
y
>>>> different setup (two independent channels sending the data to each
>>>> other, one reads, the other writes?).
>>>
>>> Ok, i implemented that using zynqmp_dma on a Xilinx Zynq platform (ob=
viously ;-) and it works nicely for us.
>>
>> I see, if the HW does not support it then something along the lines of=

>> what the atc_prep_dma_sg did can be implemented for most engines.
>>
>> In essence: create a new set of sg_list which is symmetric.
>=20
> Sorry, not sure if i understand you right?
> You suggest that in case DMA_SG gets revived we should restrict the sup=
port to symmetric sg_lists?

No, not at all. That would not make much sense.

> Just had a glance at the deleted code and the *_prep_dma_sg of these dr=
ivers had code to support asymmetric lists and by that "unaligend" memory=
 (relative to page start):
> at_hdmac.c        =20
> dmaengine.c       =20
> dmatest.c         =20
> fsldma.c          =20
> mv_xor.c          =20
> nbpfaxi.c         =20
> ste_dma40.c       =20
> xgene-dma.c       =20
> xilinx/zynqmp_dma.c
>=20
> Why not just revive that and keep this nice functionality? ;-)

What I'm saying is that the drivers (at least at_hdmac) in essence
creates aligned sg_list out from the received non aligned ones.
It does this w/o actually creating the sg_list itself, but that's just a
small detail.

In a longer run what might make sense is to have a helper function to
convert two non symmetric sg_list into two symmetric ones so drivers
will not have to re-implement the same code and they will only need to
care about symmetric sg lists.

Note, some DMAs can actually handle non symmetric src and dst lists, but
I believe it is rare.

>> What might be plausible is to introduce hw offloading support for memc=
py
>> type of operations in a similar fashion how for example crypto does it=
?
>=20
> Sounds good to me, my proxy driver implementation could be a good start=
 for that, too!

It needs to find it's place as well... I'm not sure where that would be.
Simple block-copy offload, sg copy offload, interleaved offload (frame
extraction) offload, dmabuf copy offload comes to mind as candidates.

>> The issue with a user space implemented logic is that it is not portab=
le
>> between systems with different DMAs. It might be that on one DMA the
>> setup takes longer than do a CPU copy of X bytes, on the other DMA it
>> might be significantly less or higher.
>=20
> Fully agree with that!
> I was also unsure how my approach will perform but in our case the late=
ncy was increased by ~20%, cpu load roughly stayed the same, of course th=
is was the benchmark from user memory to user memory.
> From uncached to user memory the DMA was around 15 times faster.

It depends on the size of the transfer. Lots of small individual
transfers might be worst via DMA do the the setup time, completion
handling, etc.

>> Using CPU vs DMA for a copy in certain lengths and setups should not b=
e
>> a concern of the user space.
>=20
> Also fully agree with that!

There is one and big issue with the fallback to CPU copy... If you used
DMA then you might need to do cache operation to get things in their
right place.
If you have done it with CPU then you most like do not need to care
about it.
Handling this should be done in level where we are aware which path is
taken.

>> Yes, you have a closed system with controlled parameters, but a generi=
c
>> mem2mem_offload framework should be usable on other setups and the sam=
e
>> binary should be working on different DMAs where one is not efficient
>> for <512 bytes, the other shows benefits under 128bytes.
>=20
> Usable: of course
> "Faster": not necessarily as long as it is an option
>=20
> Thanks for your valuable input and suggestions!
>=20
> best regards,
> Thomas
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

