Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB01D4B5DD
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbfFSKE4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jun 2019 06:04:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15623 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfFSKE4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jun 2019 06:04:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0a08c50000>; Wed, 19 Jun 2019 03:04:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Jun 2019 03:04:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Jun 2019 03:04:54 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Jun
 2019 10:04:52 +0000
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1db9bac2-957d-3c0a-948a-429bc59f1b72@nvidia.com>
Date:   Wed, 19 Jun 2019 11:04:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7354d471-95e1-ffcd-db65-578e9aa425ac@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560938693; bh=9VZGTRZrxWWEY18NcGQuJmHyHgcvtS3tJvZN6EFsSDo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rw8ATL0hmoQbL6+zVMENoVLWDE+CTSMHrblhbUkeOn5st1w2Jg8xBENB+wNL58kpX
         WTDcZnAsBLbQniPuPMUnGuUfYDQ6Rgz9Xpbsj4EW0svo1UaYk5e9KMIMrQStHhCdmC
         HEXWtxYCFvmxCn8qOfDRWSa6FWl4PHPz6V8AdJF48hhhu0h0JzKhOlXbyHEJvkz68T
         xf4z92+H/1XF3LoYF+omDGkb+dz/YEa9SH4qgy0RaGBdRLfQeNg7JVvficEM73XR+J
         8Rl4ZG7Vgu5TfSsjg8YhOAe4t2AvV2077ueqZ1DtJl4+kkZHm4lgp99ZUuQIkZQtRa
         k3OkMoPi+piag==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 19/06/2019 00:27, Dmitry Osipenko wrote:
> 19.06.2019 1:22, Ben Dooks =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 13/06/2019 22:08, Dmitry Osipenko wrote:
>>> Tegra's APB DMA engine updates words counter after each transferred bur=
st
>>> of data, hence it can report transfer's residual with more fidelity whi=
ch
>>> may be required in cases like audio playback. In particular this fixes
>>> audio stuttering during playback in a chromiuim web browser. The patch =
is
>>> based on the original work that was made by Ben Dooks [1]. It was teste=
d
>>> on Tegra20 and Tegra30 devices.
>>>
>>> [1] https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codet=
hink.co.uk/
>>>
>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>> =C2=A0 drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++-=
------
>>> =C2=A0 1 file changed, 28 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dm=
a.c
>>> index 79e9593815f1..c5af8f703548 100644
>>> --- a/drivers/dma/tegra20-apb-dma.c
>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_cha=
n *dc)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> =C2=A0 +static unsigned int tegra_dma_update_residual(struct tegra_dma_=
channel *tdc,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct tegra_dma_sg_req *sg_req,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct tegra_dma_desc *dma_desc,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned int residual)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 unsigned long status, wcount =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!list_is_first(&sg_req->node, &tdc->pending_sg_=
req))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return residual;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (tdc->tdma->chip_data->support_separate_wcount_r=
eg)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wcount =3D tdc_read(tdc, TE=
GRA_APBDMA_CHAN_WORD_TRANSFER);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 status =3D tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!tdc->tdma->chip_data->support_separate_wcount_=
reg)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wcount =3D status;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return residual - sg_req->r=
eq_len;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return residual - get_current_xferred_count(tdc, sg=
_req, wcount);
>>> +}
>>
>> I am unfortunately nowhere near my notes, so can't completely
>> review this. I think the complexity of my patch series is due
>> to an issue with the count being updated before the EOC IRQ
>> is actually flagged (and most definetly before it gets to the
>> CPU IRQ handler).
>>
>> The test system I was using, which i've not really got any
>> access to at the moment would show these internal inconsistent
>> states every few hours, however it was moving 48kHz 8ch 16bit
>> TDM data.
>>
>> Thanks for looking into this, I am not sure if I am going to
>> get any time to look into this within the next couple of
>> months.
>=20
> I'll try to add some debug checks to try to catch the case where count is=
 updated before EOC
> is set. Thank you very much for the clarification of the problem. So far =
I haven't spotted
> anything going wrong.
>=20
> Jon / Laxman, are you aware about the possibility to get such inconsisten=
cy of words count
> vs EOC? Assuming the cyclic transfer mode.

I can't say that I am. However, for the case of cyclic transfer, given
that the next transfer is always programmed into the registers before
the last one completes, I could see that by the time the interrupt is
serviced that the DMA has moved on to the next transfer (which I assume
would reset the count).

Interestingly, our downstream kernel implemented a change to avoid the
count appearing to move backwards. I am curious if this also works,
which would be a lot simpler that what Ben has implemented and may
mitigate that race condition that Ben is describing.

Cheers
Jon

[0]
https://nv-tegra.nvidia.com/gitweb/?p=3Dlinux-4.4.git;a=3Dcommit;h=3Dc7bba4=
0c6846fbf3eaad35c4472dcc7d8bbc02e5

--=20
nvpublic
