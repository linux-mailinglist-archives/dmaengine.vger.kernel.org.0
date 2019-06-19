Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9994B689
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfFSKzS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jun 2019 06:55:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19501 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfFSKzS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jun 2019 06:55:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0a14930000>; Wed, 19 Jun 2019 03:55:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Jun 2019 03:55:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Jun 2019 03:55:15 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun
 2019 10:55:14 +0000
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Dmitry Osipenko <digetx@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190613210849.10382-1-digetx@gmail.com>
 <f2290604-12f4-019b-47e7-4e4e29a433d4@codethink.co.uk>
 <7354d471-95e1-ffcd-db65-578e9aa425ac@gmail.com>
 <1db9bac2-957d-3c0a-948a-429bc59f1b72@nvidia.com>
 <c8bccb6e-27f8-d6c8-cfdb-10ab5ae98b26@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <49d087fe-a634-4a53-1caa-58a0e52ef1ba@nvidia.com>
Date:   Wed, 19 Jun 2019 11:55:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c8bccb6e-27f8-d6c8-cfdb-10ab5ae98b26@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560941715; bh=sOPaMSe0g2vKI6XG44WhBmWvohqjDYr1wPxKJ6JP7CY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=enMD3zyncDWnLYsJAX4fE5h+p5WUmnQ3W7WpqJJC7Oa5lOL0vi9lxDekRVX2slmu5
         oVEwffHNF5+ny660L9auHmx8LbABzdozbXeEdt2tBKKygCw2HsqIN4M5U6LweF8gwJ
         aUG4DxVTVVdz+727cpscxf5EBizgET7PYpkAvmPkP/K+KwSGNBtBjJNt9jMtDphUlG
         m2kFnmE9ZKKp0ZG4/qTLDCNeKp2mxKBKdwtYcasOuPSDiPoG0V11CUW/9TfMX7D6e5
         sgZv+yiWHuH7RoFdOb0osauEtom3L8BQp070mH8SblCIZbnT2Kvx+9GHxPFrVagMZ/
         zgV2FsCefNgxQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 19/06/2019 11:27, Dmitry Osipenko wrote:
> 19.06.2019 13:04, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 19/06/2019 00:27, Dmitry Osipenko wrote:
>>> 19.06.2019 1:22, Ben Dooks =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On 13/06/2019 22:08, Dmitry Osipenko wrote:
>>>>> Tegra's APB DMA engine updates words counter after each transferred b=
urst
>>>>> of data, hence it can report transfer's residual with more fidelity w=
hich
>>>>> may be required in cases like audio playback. In particular this fixe=
s
>>>>> audio stuttering during playback in a chromiuim web browser. The patc=
h is
>>>>> based on the original work that was made by Ben Dooks [1]. It was tes=
ted
>>>>> on Tegra20 and Tegra30 devices.
>>>>>
>>>>> [1] https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@cod=
ethink.co.uk/
>>>>>
>>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>> =C2=A0 drivers/dma/tegra20-apb-dma.c | 35 +++++++++++++++++++++++++++=
+-------
>>>>> =C2=A0 1 file changed, 28 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-=
dma.c
>>>>> index 79e9593815f1..c5af8f703548 100644
>>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_c=
han *dc)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0 }
>>>>> =C2=A0 +static unsigned int tegra_dma_update_residual(struct tegra_dm=
a_channel *tdc,
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
>>> I'll try to add some debug checks to try to catch the case where count =
is updated before EOC
>>> is set. Thank you very much for the clarification of the problem. So fa=
r I haven't spotted
>>> anything going wrong.
>>>
>>> Jon / Laxman, are you aware about the possibility to get such inconsist=
ency of words count
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
>>
>> Cheers
>> Jon
>>
>> [0]
>> https://nv-tegra.nvidia.com/gitweb/?p=3Dlinux-4.4.git;a=3Dcommit;h=3Dc7b=
ba40c6846fbf3eaad35c4472dcc7d8bbc02e5
>>
>=20
> The downstream patch doesn't check for EOC and has no comments about it, =
so it's hard to
> tell if it's intentional. Secondly, looks like the downstream patch is mu=
cked up because it
> doesn't check whether the dma_desc is *the active* transfer and not a pen=
ding!

I agree that it should check to see if it is active. I assume that what
this patch is doing is not updating the dma position if it appears to
have gone backwards, implying we have moved on to the next buffer. Yes
this is still probably not as accurate as Ben's implementation because
most likely we have finished that transfer and this patch would report
that it is not quite finished.

If Ben's patch works for you then why not go with this?

Cheers
Jon

--=20
nvpublic
