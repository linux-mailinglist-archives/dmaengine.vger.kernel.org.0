Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6C75CFD9
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 14:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfGBM44 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 08:56:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16228 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBM44 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 08:56:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1b54940000>; Tue, 02 Jul 2019 05:56:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Jul 2019 05:56:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Jul 2019 05:56:53 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Jul
 2019 12:56:51 +0000
Subject: Re: [PATCH v3] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190627194728.8948-1-digetx@gmail.com>
 <dab25158-272c-a18f-a858-433f7f9000e0@nvidia.com>
 <3a5403fe-b81f-993c-e7c0-407387e001d9@gmail.com>
 <39df67ea-d707-7181-3050-3d215f4487f6@gmail.com>
 <108982bc-1741-8fee-d2dd-4f4d45178ba0@gmail.com>
 <7b02adbd-2b12-a3ea-e74a-d41c4f924fd9@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <41561b5f-5ca5-3311-d87e-4f9582d123ed@nvidia.com>
Date:   Tue, 2 Jul 2019 13:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7b02adbd-2b12-a3ea-e74a-d41c4f924fd9@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562072212; bh=uPQ2Qq8w+aVXoI6ZlvPH1EwQ0zcq0SbGXe2qkD0NUxo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gIbpEjaxnH8EOwx88v7tWRnj7WbpUTjLfSY1S/b7jLsMi/Pz5Z7iCATnO2RkwuQ3f
         AVpoQy5mUVJf/UwK3yEymfIuVFGHDgWRY1AAmW5xXv9UJ8bJoxd7N+Jyp3RxB94Y0S
         KDKjKb3iDeTAuf3o0he+VY8V5evBqUM22Nw3DpFyIYwZZ25Mg/QTGzBlk2z4ecwPMg
         IIJW0cKtBD7+FuPPS1fcF9Xg53z+FzcrX99eXl77Ig4wnCnjq4aOG35w/yuh5EamqD
         rZYVblGXaN1rBoPmhgWdhr5wiNb1Usz5wzgPPRVSb/mtIexPa039u0XKTQXRSSK7ic
         KlLt6CB8/jRHg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 02/07/2019 13:27, Dmitry Osipenko wrote:
> 02.07.2019 15:04, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> 02.07.2019 14:56, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> 02.07.2019 14:37, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> 02.07.2019 14:20, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>
>>>>> On 27/06/2019 20:47, Dmitry Osipenko wrote:
>>>>>> Tegra's APB DMA engine updates words counter after each transferred =
burst
>>>>>> of data, hence it can report transfer's residual with more fidelity =
which
>>>>>> may be required in cases like audio playback. In particular this fix=
es
>>>>>> audio stuttering during playback in a chromium web browser. The patc=
h is
>>>>>> based on the original work that was made by Ben Dooks and a patch fr=
om
>>>>>> downstream kernel. It was tested on Tegra20 and Tegra30 devices.
>>>>>>
>>>>>> Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@=
codethink.co.uk/
>>>>>> Link: https://nv-tegra.nvidia.com/gitweb/?p=3Dlinux-4.4.git;a=3Dcomm=
it;h=3Dc7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
>>>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>
>>>>>> Changelog:
>>>>>>
>>>>>> v3:  Added workaround for a hardware design shortcoming that results
>>>>>>      in a words counter wraparound before end-of-transfer bit is set
>>>>>>      in a cyclic mode.
>>>>>>
>>>>>> v2:  Addressed review comments made by Jon Hunter to v1. We won't tr=
y
>>>>>>      to get words count if dma_desc is on free list as it will resul=
t
>>>>>>      in a NULL dereference because this case wasn't handled properly=
.
>>>>>>
>>>>>>      The residual value is now updated properly, avoiding potential
>>>>>>      integer overflow by adding the "bytes" to the "bytes_transferre=
d"
>>>>>>      instead of the subtraction.
>>>>>>
>>>>>>  drivers/dma/tegra20-apb-dma.c | 69 +++++++++++++++++++++++++++++++-=
---
>>>>>>  1 file changed, 62 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb=
-dma.c
>>>>>> index 79e9593815f1..71473eda28ee 100644
>>>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>>>> @@ -152,6 +152,7 @@ struct tegra_dma_sg_req {
>>>>>>  	bool				last_sg;
>>>>>>  	struct list_head		node;
>>>>>>  	struct tegra_dma_desc		*dma_desc;
>>>>>> +	unsigned int			words_xferred;
>>>>>>  };
>>>>>> =20
>>>>>>  /*
>>>>>> @@ -496,6 +497,7 @@ static void tegra_dma_configure_for_next(struct =
tegra_dma_channel *tdc,
>>>>>>  	tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
>>>>>>  				nsg_req->ch_regs.csr | TEGRA_APBDMA_CSR_ENB);
>>>>>>  	nsg_req->configured =3D true;
>>>>>> +	nsg_req->words_xferred =3D 0;
>>>>>> =20
>>>>>>  	tegra_dma_resume(tdc);
>>>>>>  }
>>>>>> @@ -511,6 +513,7 @@ static void tdc_start_head_req(struct tegra_dma_=
channel *tdc)
>>>>>>  					typeof(*sg_req), node);
>>>>>>  	tegra_dma_start(tdc, sg_req);
>>>>>>  	sg_req->configured =3D true;
>>>>>> +	sg_req->words_xferred =3D 0;
>>>>>>  	tdc->busy =3D true;
>>>>>>  }
>>>>>> =20
>>>>>> @@ -797,6 +800,61 @@ static int tegra_dma_terminate_all(struct dma_c=
han *dc)
>>>>>>  	return 0;
>>>>>>  }
>>>>>> =20
>>>>>> +static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_cha=
nnel *tdc,
>>>>>> +					       struct tegra_dma_sg_req *sg_req)
>>>>>> +{
>>>>>> +	unsigned long status, wcount =3D 0;
>>>>>> +
>>>>>> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>>> +		wcount =3D tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>>>>> +
>>>>>> +	status =3D tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>>>>> +
>>>>>> +	if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>>> +		wcount =3D status;
>>>>>> +
>>>>>> +	if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>>>>> +		return sg_req->req_len;
>>>>>> +
>>>>>> +	wcount =3D get_current_xferred_count(tdc, sg_req, wcount);
>>>>>> +
>>>>>> +	if (!wcount) {
>>>>>> +		/*
>>>>>> +		 * If wcount wasn't ever polled for this SG before, then
>>>>>> +		 * simply assume that transfer hasn't started yet.
>>>>>> +		 *
>>>>>> +		 * Otherwise it's the end of the transfer.
>>>>>> +		 *
>>>>>> +		 * The alternative would be to poll the status register
>>>>>> +		 * until EOC bit is set or wcount goes UP. That's so
>>>>>> +		 * because EOC bit is getting set only after the last
>>>>>> +		 * burst's completion and counter is less than the actual
>>>>>> +		 * transfer size by 4 bytes. The counter value wraps around
>>>>>> +		 * in a cyclic mode before EOC is set(!), so we can't easily
>>>>>> +		 * distinguish start of transfer from its end.
>>>>>> +		 */
>>>>>> +		if (sg_req->words_xferred)
>>>>>> +			wcount =3D sg_req->req_len - 4;
>>>>>> +
>>>>>> +	} else if (wcount < sg_req->words_xferred) {
>>>>>> +		/*
>>>>>> +		 * This case shall not ever happen because EOC bit
>>>>>> +		 * must be set once next cyclic transfer is started.
>>>>>
>>>>> I am not sure I follow this and why this condition cannot happen for
>>>>> cyclic transfers. What about non-cyclic transfers?
>>>>
>>>> It cannot happen because the EOC bit will be set in that case. The cou=
nter wraps
>>>> around when the transfer of a last burst happens, EOC bit is guarantee=
d to be set
>>>> after completion of the last burst. That's my observation after a thor=
ough testing,
>>>> it will be very odd if EOC setting happened completely asynchronously.
>>>>
>>>> For a non-cyclic transfers it doesn't matter.. because they are not cy=
clic and thus
>>>> counter will be stopped by itself. It will be a disaster if all of sud=
den a
>>>> non-cyclic transfer becomes cyclic, don't you think so? :)
>>>>
>>>
>>> Ah, probably I was too focused on audio playback use-case. If it's a fr=
ee-running
>>> transfer, then that case of a wraparound seems should be legit.. hmm.
>>>
>>
>> Looks like that will work:
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma=
.c
>> index 71473eda28ee..201c693b11f5 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -648,6 +648,8 @@ static void handle_cont_sngl_cycle_dma_done(struct t=
egra_dma_channel *tdc,
>>  		st =3D handle_continuous_head_request(tdc, sgreq, to_terminate);
>>  		if (!st)
>>  			dma_desc->dma_status =3D DMA_ERROR;
>> +	} else {
>> +		sg_req->words_xferred =3D 0;
>>  	}
>>  }
>>
>=20
> BTW, I don't understand the logic of having multiple SGs for a cyclic tra=
nsfer. It looks
> like driver is doing insane thing by trying to substitute an in-fly SG wi=
th another one..

I may have mentioned before that I don't like how this driver was
implemented. Ideally it should use the virt-dma helpers and avoid all
this nonsense. However, best to leave sleeping dogs lie.

Jon

--=20
nvpublic
