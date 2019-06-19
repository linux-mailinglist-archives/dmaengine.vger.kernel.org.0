Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 384EB4B5FF
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 12:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFSKN4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jun 2019 06:13:56 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1327 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSKN4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jun 2019 06:13:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0a0ae30000>; Wed, 19 Jun 2019 03:13:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Jun 2019 03:13:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Jun 2019 03:13:53 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun
 2019 10:13:52 +0000
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190613210849.10382-1-digetx@gmail.com>
 <f2290604-12f4-019b-47e7-4e4e29a433d4@codethink.co.uk>
 <7354d471-95e1-ffcd-db65-578e9aa425ac@gmail.com>
 <1db9bac2-957d-3c0a-948a-429bc59f1b72@nvidia.com>
 <0f797be6-9b80-7c31-44ef-0df68d36252e@codethink.co.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e443c114-167f-6e93-c3dc-0bd09fda3f6c@nvidia.com>
Date:   Wed, 19 Jun 2019 11:13:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0f797be6-9b80-7c31-44ef-0df68d36252e@codethink.co.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560939235; bh=x86mfEiEYdyxady8mUw6TOwl6elQCeOquY+kusgW+RI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SubKxxwci1urqePqhaeCn5oQmur9WOHar/iZVCng/Ea5e7GuTq6z3Rojk8z2kZ0P+
         wdo93P2oR9dfnLhXRzKt6fwCnTw4Jc2r7cLa77L3lRSCEhIjbik51/HEzI8ERROoKB
         a2nqBM4OAut77Qrj689DoL08qEzXroUev5BKD56MaJy0HLEhnCMVosbFO8MA86Uqj0
         CgIYXlizqAjDloY5mUqJjOEDnTrRvIwtX9X+W6M1Qy1Sl5onQrF4uCTFbUHeIix7CG
         R96Q9siIKRlZ4TeVbrac/Y8JeSnJIOz+1LN0zwr52e3e6tgZzg4c8aaDSXPfFwUD/J
         lR1KGVDWHxK0g==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 19/06/2019 11:08, Ben Dooks wrote:
> On 19/06/2019 11:04, Jon Hunter wrote:
>>
>> On 19/06/2019 00:27, Dmitry Osipenko wrote:
>>> 19.06.2019 1:22, Ben Dooks =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On 13/06/2019 22:08, Dmitry Osipenko wrote:
>>>>> Tegra's APB DMA engine updates words counter after each transferred
>>>>> burst
>>>>> of data, hence it can report transfer's residual with more fidelity
>>>>> which
>>>>> may be required in cases like audio playback. In particular this fixe=
s
>>>>> audio stuttering during playback in a chromiuim web browser. The
>>>>> patch is
>>>>> based on the original work that was made by Ben Dooks [1]. It was
>>>>> tested
>>>>> on Tegra20 and Tegra30 devices.
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethi=
nk.co.uk/
>>>>>
>>>>>
>>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 drivers/dma/tegra20-apb-dma.c | 35
>>>>> ++++++++++++++++++++++++++++-------
>>>>> =C2=A0=C2=A0 1 file changed, 28 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dma/tegra20-apb-dma.c
>>>>> b/drivers/dma/tegra20-apb-dma.c
>>>>> index 79e9593815f1..c5af8f703548 100644
>>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct
>>>>> dma_chan *dc)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0 +static unsigned int tegra_dma_update_residual(struct
>>>>> tegra_dma_channel *tdc,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct tegra_dma_sg_req *sg_req,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct tegra_dma_desc *dma_desc,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 unsigned int residual)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 unsigned long status, wcount =3D 0;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 if (!list_is_first(&sg_req->node, &tdc->pending_s=
g_req))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return residual;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 if (tdc->tdma->chip_data->support_separate_wcount=
_reg)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wcount =3D tdc_read(tdc, =
TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 status =3D tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS=
);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 if (!tdc->tdma->chip_data->support_separate_wcoun=
t_reg)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wcount =3D status;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return residual - sg_req-=
>req_len;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 return residual - get_current_xferred_count(tdc, =
sg_req, wcount);
>>>>> +}
>>>>
>>>> I am unfortunately nowhere near my notes, so can't completely
>>>> review this. I think the complexity of my patch series is due
>>>> to an issue with the count being updated before the EOC IRQ
>>>> is actually flagged (and most definetly before it gets to the
>>>> CPU IRQ handler).
>>>>
>>>> The test system I was using, which i've not really got any
>>>> access to at the moment would show these internal inconsistent
>>>> states every few hours, however it was moving 48kHz 8ch 16bit
>>>> TDM data.
>>>>
>>>> Thanks for looking into this, I am not sure if I am going to
>>>> get any time to look into this within the next couple of
>>>> months.
>>>
>>> I'll try to add some debug checks to try to catch the case where
>>> count is updated before EOC
>>> is set. Thank you very much for the clarification of the problem. So
>>> far I haven't spotted
>>> anything going wrong.
>>>
>>> Jon / Laxman, are you aware about the possibility to get such
>>> inconsistency of words count
>>> vs EOC? Assuming the cyclic transfer mode.
>>
>> I can't say that I am. However, for the case of cyclic transfer, given
>> that the next transfer is always programmed into the registers before
>> the last one completes, I could see that by the time the interrupt is
>> serviced that the DMA has moved on to the next transfer (which I assume
>> would reset the count).
>>
>> Interestingly, our downstream kernel implemented a change to avoid the
>> count appearing to move backwards. I am curious if this also works,
>> which would be a lot simpler that what Ben has implemented and may
>> mitigate that race condition that Ben is describing.
>=20
> That might be the same thing we saw. IIRC it looks like the DMA has
> moved on, but the count gets re-set before the EOC? I can't see that
> git site so can't comment.

That's odd, that should be a public site AFAIK. Does the following not
work ...

https://nv-tegra.nvidia.com/gitweb/

Jon

--=20
nvpublic
