Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27A35F7AE
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2019 14:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfGDMI2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Jul 2019 08:08:28 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14294 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfGDMI2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Jul 2019 08:08:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1dec360000>; Thu, 04 Jul 2019 05:08:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Jul 2019 05:08:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Jul 2019 05:08:25 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jul
 2019 12:08:23 +0000
Subject: Re: [PATCH v4] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190703012836.16568-1-digetx@gmail.com>
 <b0a0b110-61c8-ae8b-22a0-3311f70b428a@nvidia.com>
 <b1f4d7c3-636e-947f-ac76-fc639ac7fee4@gmail.com>
 <55d402ad-6cb9-9e91-a8a4-b89d37674f4d@nvidia.com>
 <a0168814-09e2-6dfe-5c5c-e053911cede6@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <940563c4-e2e9-c1d8-ac74-e6871e086746@nvidia.com>
Date:   Thu, 4 Jul 2019 13:08:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a0168814-09e2-6dfe-5c5c-e053911cede6@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562242102; bh=QCd2pNifawP69293diLI9LAzdM46YJ/iIviUDZ24ve0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fgS7i8nFqqgWpjFHlNYbVtvmOqi6LGVTwSjnDFuL0afhItK8dAM8xmouzrDR0dptS
         235X9yhXZuZH627whES/QLKb5yTzjnU8r4yYOZmdNXiuXsQXfbbRbkd7wjADphtlOk
         Gp/jduzkEVBhyd9h4w/4dDxe7ak5wV73bm9TaoGTB2//kLfzYv6cxZpK2nMQbw+pdi
         KnH+EhadN7BXjH1DLpBTc8vCzff7dpTX7xKbzeIG23GaDWdnbSuTYDjlJC5TdjkuAb
         SEUn/PK0CG2Erun1E+i+LxKIqBjXdpwbX5M3Y+8Z6PGPLEV1ewzhVdT0RfHTsk51Ss
         7dauCQm3FeGdQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 04/07/2019 11:49, Dmitry Osipenko wrote:
> 04.07.2019 10:10, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 03/07/2019 18:00, Dmitry Osipenko wrote:
>>> 03.07.2019 19:37, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>
>>>> On 03/07/2019 02:28, Dmitry Osipenko wrote:
>>>>> Tegra's APB DMA engine updates words counter after each transferred b=
urst
>>>>> of data, hence it can report transfer's residual with more fidelity w=
hich
>>>>> may be required in cases like audio playback. In particular this fixe=
s
>>>>> audio stuttering during playback in a chromium web browser. The patch=
 is
>>>>> based on the original work that was made by Ben Dooks and a patch fro=
m
>>>>> downstream kernel. It was tested on Tegra20 and Tegra30 devices.
>>>>>
>>>>> Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@c=
odethink.co.uk/
>>>>> Link: https://nv-tegra.nvidia.com/gitweb/?p=3Dlinux-4.4.git;a=3Dcommi=
t;h=3Dc7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
>>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>
>>>>> Changelog:
>>>>>
>>>>> v4: The words_xferred is now also reset on a new iteration of a cycli=
c
>>>>>     transfer by ISR, so that dmaengine_tx_status() won't produce a
>>>>>     misleading warning splat on TX status re-checking after a cycle
>>>>>     completion when cyclic transfer consists of a single SG.
>>>>>
>>>>> v3: Added workaround for a hardware design shortcoming that results
>>>>>     in a words counter wraparound before end-of-transfer bit is set
>>>>>     in a cyclic mode.
>>>>>
>>>>> v2: Addressed review comments made by Jon Hunter to v1. We won't try
>>>>>     to get words count if dma_desc is on free list as it will result
>>>>>     in a NULL dereference because this case wasn't handled properly.
>>>>>
>>>>>     The residual value is now updated properly, avoiding potential
>>>>>     integer overflow by adding the "bytes" to the "bytes_transferred"
>>>>>     instead of the subtraction.
>>>>>
>>>>>  drivers/dma/tegra20-apb-dma.c | 72 +++++++++++++++++++++++++++++++--=
--
>>>>>  1 file changed, 65 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-=
dma.c
>>>>> index 79e9593815f1..148d136191d7 100644
>>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>>> @@ -152,6 +152,7 @@ struct tegra_dma_sg_req {
>>>>>  	bool				last_sg;
>>>>>  	struct list_head		node;
>>>>>  	struct tegra_dma_desc		*dma_desc;
>>>>> +	unsigned int			words_xferred;
>>>>>  };
>>>>> =20
>>>>>  /*
>>>>> @@ -496,6 +497,7 @@ static void tegra_dma_configure_for_next(struct t=
egra_dma_channel *tdc,
>>>>>  	tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
>>>>>  				nsg_req->ch_regs.csr | TEGRA_APBDMA_CSR_ENB);
>>>>>  	nsg_req->configured =3D true;
>>>>> +	nsg_req->words_xferred =3D 0;
>>>>> =20
>>>>>  	tegra_dma_resume(tdc);
>>>>>  }
>>>>> @@ -511,6 +513,7 @@ static void tdc_start_head_req(struct tegra_dma_c=
hannel *tdc)
>>>>>  					typeof(*sg_req), node);
>>>>>  	tegra_dma_start(tdc, sg_req);
>>>>>  	sg_req->configured =3D true;
>>>>> +	sg_req->words_xferred =3D 0;
>>>>>  	tdc->busy =3D true;
>>>>>  }
>>>>> =20
>>>>> @@ -638,6 +641,8 @@ static void handle_cont_sngl_cycle_dma_done(struc=
t tegra_dma_channel *tdc,
>>>>>  		list_add_tail(&dma_desc->cb_node, &tdc->cb_desc);
>>>>>  	dma_desc->cb_count++;
>>>>> =20
>>>>> +	sgreq->words_xferred =3D 0;
>>>>> +
>>>>>  	/* If not last req then put at end of pending list */
>>>>>  	if (!list_is_last(&sgreq->node, &tdc->pending_sg_req)) {
>>>>>  		list_move_tail(&sgreq->node, &tdc->pending_sg_req);
>>>>> @@ -797,6 +802,62 @@ static int tegra_dma_terminate_all(struct dma_ch=
an *dc)
>>>>>  	return 0;
>>>>>  }
>>>>> =20
>>>>> +static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_chan=
nel *tdc,
>>>>> +					       struct tegra_dma_sg_req *sg_req)
>>>>> +{
>>>>> +	unsigned long status, wcount =3D 0;
>>>>> +
>>>>> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>>>> +		return 0;
>>>>> +
>>>>> +	if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>> +		wcount =3D tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>>>> +
>>>>> +	status =3D tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>>>> +
>>>>> +	if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>>>>> +		wcount =3D status;
>>>>> +
>>>>> +	if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>>>> +		return sg_req->req_len;
>>>>> +
>>>>> +	wcount =3D get_current_xferred_count(tdc, sg_req, wcount);
>>>>> +
>>>>> +	if (!wcount) {
>>>>> +		/*
>>>>> +		 * If wcount wasn't ever polled for this SG before, then
>>>>> +		 * simply assume that transfer hasn't started yet.
>>>>> +		 *
>>>>> +		 * Otherwise it's the end of the transfer.
>>>>> +		 *
>>>>> +		 * The alternative would be to poll the status register
>>>>> +		 * until EOC bit is set or wcount goes UP. That's so
>>>>> +		 * because EOC bit is getting set only after the last
>>>>> +		 * burst's completion and counter is less than the actual
>>>>> +		 * transfer size by 4 bytes. The counter value wraps around
>>>>> +		 * in a cyclic mode before EOC is set(!), so we can't easily
>>>>> +		 * distinguish start of transfer from its end.
>>>>> +		 */
>>>>> +		if (sg_req->words_xferred)
>>>>> +			wcount =3D sg_req->req_len - 4;
>>>>> +
>>>>> +	} else if (wcount < sg_req->words_xferred) {
>>>>> +		/*
>>>>> +		 * This case shall not ever happen because EOC bit
>>>>> +		 * must be set once next cyclic transfer is started.
>>>>
>>>> Should this still be cyclic here?
>>>
>>> Do you mean the "comment" by "here"?
>>>
>>> It will be absolutely terrible if this case happens for oneshot transfe=
r, assume
>>> kernel/hardware is on fire.
>>
>> Or more likely a SW bug :-)
>>
>> Yes should never happen for either sg or cyclic, but there is no mention
>> of sg transfers. Maybe the sg case is more obvious but in general this
>> case should never happen for any transfer.
>=20
> Alright, so what the change you are proposing? Or is it fine now?
>=20
> I can certainly change the comment's wording, just please tell me what yo=
u want it to be.
>=20
> /*
>  * This case shall not ever happen because EOC bit
>  * must be set once transfer is actually finished.
>=20
> Does this sound better?

If I think it would be good to say ...

This case will never happen for a non-cyclic transfer. For a cyclic
transfer, although it is possible for the next transfer to have already
started (resetting the word count), this case should still not happen
because we should have detected that the EOC bit is set and hence the
transfer was completed.

At least that should remind me of what we are doing here in the future :-)

Jon

--=20
nvpublic
