Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE93D5CFE0
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGBM5s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 08:57:48 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17870 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBM5r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 08:57:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1b54ce0000>; Tue, 02 Jul 2019 05:57:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Jul 2019 05:57:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Jul 2019 05:57:46 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Jul
 2019 12:57:43 +0000
Subject: Re: [PATCH v3] dmaengine: tegra-apb: Support per-burst residue
 granularity
From:   Jon Hunter <jonathanh@nvidia.com>
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
 <b50045f9-7d8f-d91a-8629-625bcd7057bc@nvidia.com>
Message-ID: <892f4ec3-c063-7e75-a891-3f814db2b9ff@nvidia.com>
Date:   Tue, 2 Jul 2019 13:57:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b50045f9-7d8f-d91a-8629-625bcd7057bc@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562072270; bh=szdbuE0I1A8f7TOGaXEzzSv8Ju2S8Pi0WcleCTr1KOM=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GEpq5goX3WxBq4Nj0SQ+o4WMpZFRqKgoHnrwt2MI/Z80/c+6nS6dIuAxO6DkooVcN
         jrVsZuYRLvTvIoDRjLev2GWJo+vj+BPitLsQuqjG/nfqtYQHQ0t/9llljnZ6XA38vj
         /Yc1HH1Kag4Q4s1Ii6MmP5u8llCmd6j8M2FlKi41slz6zzKS6fbhQO5VRCgdrNZ91C
         wnO+wB2wxykWmrcYi60IVqkP/jgXcCfurRXJ906oMFGcYpJQw6Ifp9WuxQ68/ns03E
         kdXzeS43XEmquPpfDZfLzznN5FkPbK71lHLhBjwipZRUch7zSjhYUToLzR0pz51q6U
         sufMdQt3zIpLg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 02/07/2019 13:54, Jon Hunter wrote:
>=20
> On 02/07/2019 12:37, Dmitry Osipenko wrote:
>> 02.07.2019 14:20, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>
>>> On 27/06/2019 20:47, Dmitry Osipenko wrote:
>>>> Tegra's APB DMA engine updates words counter after each transferred bu=
rst
>>>> of data, hence it can report transfer's residual with more fidelity wh=
ich
>>>> may be required in cases like audio playback. In particular this fixes
>>>> audio stuttering during playback in a chromium web browser. The patch =
is
>>>> based on the original work that was made by Ben Dooks and a patch from
>>>> downstream kernel. It was tested on Tegra20 and Tegra30 devices.
>>>>
>>>> Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@co=
dethink.co.uk/
>>>> Link: https://nv-tegra.nvidia.com/gitweb/?p=3Dlinux-4.4.git;a=3Dcommit=
;h=3Dc7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>
>>>> Changelog:
>>>>
>>>> v3:  Added workaround for a hardware design shortcoming that results
>>>>      in a words counter wraparound before end-of-transfer bit is set
>>>>      in a cyclic mode.
>>>>
>>>> v2:  Addressed review comments made by Jon Hunter to v1. We won't try
>>>>      to get words count if dma_desc is on free list as it will result
>>>>      in a NULL dereference because this case wasn't handled properly.
>>>>
>>>>      The residual value is now updated properly, avoiding potential
>>>>      integer overflow by adding the "bytes" to the "bytes_transferred"
>>>>      instead of the subtraction.
>>>>
>>>>  drivers/dma/tegra20-apb-dma.c | 69 +++++++++++++++++++++++++++++++---=
-
>>>>  1 file changed, 62 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-d=
ma.c
>>>> index 79e9593815f1..71473eda28ee 100644
>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>> @@ -152,6 +152,7 @@ struct tegra_dma_sg_req {
>>>>  	bool				last_sg;
>>>>  	struct list_head		node;
>>>>  	struct tegra_dma_desc		*dma_desc;
>>>> +	unsigned int			words_xferred;
>>>>  };
>>>> =20
>>>>  /*
>>>> @@ -496,6 +497,7 @@ static void tegra_dma_configure_for_next(struct te=
gra_dma_channel *tdc,
>>>>  	tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
>>>>  				nsg_req->ch_regs.csr | TEGRA_APBDMA_CSR_ENB);
>>>>  	nsg_req->configured =3D true;
>>>> +	nsg_req->words_xferred =3D 0;
>>>> =20
>>>>  	tegra_dma_resume(tdc);
>>>>  }
>>>> @@ -511,6 +513,7 @@ static void tdc_start_head_req(struct tegra_dma_ch=
annel *tdc)
>>>>  					typeof(*sg_req), node);
>>>>  	tegra_dma_start(tdc, sg_req);
>>>>  	sg_req->configured =3D true;
>>>> +	sg_req->words_xferred =3D 0;
>>>>  	tdc->busy =3D true;
>>>>  }
>>>> =20
>>>> @@ -797,6 +800,61 @@ static int tegra_dma_terminate_all(struct dma_cha=
n *dc)
>>>>  	return 0;
>>>>  }
>>>> =20
>>>> +static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_chann=
el *tdc,
>>>> +					       struct tegra_dma_sg_req *sg_req)
>>>> +{
>>>> +	unsigned long status, wcount =3D 0;
>>>> +
>>>> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>>> +		return 0;
>>>> +
>>>> +	if (tdc->tdma->chip_data->support_separate_wcount_reg)
>>>> +		wcount =3D tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
>>>> +
>>>> +	status =3D tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
>>>> +
>>>> +	if (!tdc->tdma->chip_data->support_separate_wcount_reg)
>>>> +		wcount =3D status;
>>>> +
>>>> +	if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
>>>> +		return sg_req->req_len;
>>>> +
>>>> +	wcount =3D get_current_xferred_count(tdc, sg_req, wcount);
>>>> +
>>>> +	if (!wcount) {
>>>> +		/*
>>>> +		 * If wcount wasn't ever polled for this SG before, then
>>>> +		 * simply assume that transfer hasn't started yet.
>>>> +		 *
>>>> +		 * Otherwise it's the end of the transfer.
>>>> +		 *
>>>> +		 * The alternative would be to poll the status register
>>>> +		 * until EOC bit is set or wcount goes UP. That's so
>>>> +		 * because EOC bit is getting set only after the last
>>>> +		 * burst's completion and counter is less than the actual
>>>> +		 * transfer size by 4 bytes. The counter value wraps around
>>>> +		 * in a cyclic mode before EOC is set(!), so we can't easily
>>>> +		 * distinguish start of transfer from its end.
>>>> +		 */
>>>> +		if (sg_req->words_xferred)
>>>> +			wcount =3D sg_req->req_len - 4;
>>>> +
>>>> +	} else if (wcount < sg_req->words_xferred) {
>>>> +		/*
>>>> +		 * This case shall not ever happen because EOC bit
>>>> +		 * must be set once next cyclic transfer is started.
>>>
>>> I am not sure I follow this and why this condition cannot happen for
>>> cyclic transfers. What about non-cyclic transfers?
>>
>> It cannot happen because the EOC bit will be set in that case. The count=
er wraps
>> around when the transfer of a last burst happens, EOC bit is guaranteed =
to be set
>> after completion of the last burst. That's my observation after a thorou=
gh testing,
>> it will be very odd if EOC setting happened completely asynchronously.
>=20
> I see how you know that the EOC is set. Anyway, you check if the EOC is
> set before and if so return sg_req->req_len prior to this test.

s/I see/I don't see/

Jon

--=20
nvpublic
