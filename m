Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E839148010
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2019 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfFQK52 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jun 2019 06:57:28 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7206 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfFQK52 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jun 2019 06:57:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0772150000>; Mon, 17 Jun 2019 03:57:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 03:57:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 17 Jun 2019 03:57:25 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 10:57:23 +0000
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190613210849.10382-1-digetx@gmail.com>
 <5fbe4374-cc9a-8212-017e-05f4dee64443@nvidia.com>
 <7ab96aa5-0be2-dc01-d187-eb718093eb99@nvidia.com>
 <840fcf60-8e24-ff44-a816-ef63a5f18652@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d34c100d-e82a-bb00-22c6-c5f2f6cdb03a@nvidia.com>
Date:   Mon, 17 Jun 2019 11:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <840fcf60-8e24-ff44-a816-ef63a5f18652@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560769045; bh=ezUnyuKGHlbPhYjLZf5Spom5VDavEjqfyB+JBE4bVJU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gWIH3E3+v+rzCFyiimf1UtBRbcTKw21IjQoX8qYax0Wf6gBrBTLcmUWsqLkh6/UFy
         XnEHI+bHpHAWxiEQNNpyC3s8qwK0gRHLZUsw+p43zIRlE5esrVIhmBEHrK6ha5IEO5
         SwoCWHmt1WDwQGta6Gn11HgPQMDQbwSlDy2VKK0qBuoQU7JZVGPR3iOa1BbQc2Emml
         RagrWT3XGNyE3x6cgN4POnafe8qguNKYs1BkRdtZ44LxUr5t2jWlFmsegBnDB3SiVF
         rqyarHsvzvafNb0sOCafZNxoGJVRvFVbaC9NGqQxAlQVVcID3JLhI4YES9cU6AJn8v
         orsF7W/+m6vuw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 14/06/2019 17:44, Dmitry Osipenko wrote:
> 14.06.2019 18:24, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 14/06/2019 16:21, Jon Hunter wrote:
>>>
>>> On 13/06/2019 22:08, Dmitry Osipenko wrote:
>>>> Tegra's APB DMA engine updates words counter after each transferred bu=
rst
>>>> of data, hence it can report transfer's residual with more fidelity wh=
ich
>>>> may be required in cases like audio playback. In particular this fixes
>>>> audio stuttering during playback in a chromiuim web browser. The patch=
 is
>>>> based on the original work that was made by Ben Dooks [1]. It was test=
ed
>>>> on Tegra20 and Tegra30 devices.
>>>>
>>>> [1] https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@code=
think.co.uk/
>>>>
>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++------=
-
>>>>  1 file changed, 28 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-d=
ma.c
>>>> index 79e9593815f1..c5af8f703548 100644
>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_ch=
an *dc)
>>>>  	return 0;
>>>>  }
>>>> =20
>>>> +static unsigned int tegra_dma_update_residual(struct tegra_dma_channe=
l *tdc,
>>>> +					      struct tegra_dma_sg_req *sg_req,
>>>> +					      struct tegra_dma_desc *dma_desc,
>>>> +					      unsigned int residual)
>>>> +{
>>>> +	unsigned long status, wcount =3D 0;
>>>> +
>>>> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>>> +		return residual;
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
>>>> +		return residual - sg_req->req_len;
>>>> +
>>>> +	return residual - get_current_xferred_count(tdc, sg_req, wcount);
>>>> +}
>>>> +
>>>>  static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>>>>  	dma_cookie_t cookie, struct dma_tx_state *txstate)
>>>>  {
>>>>  	struct tegra_dma_channel *tdc =3D to_tegra_dma_chan(dc);
>>>> +	struct tegra_dma_sg_req *sg_req =3D NULL;
>>>>  	struct tegra_dma_desc *dma_desc;
>>>> -	struct tegra_dma_sg_req *sg_req;
>>>>  	enum dma_status ret;
>>>>  	unsigned long flags;
>>>>  	unsigned int residual;
>>>> @@ -838,6 +862,8 @@ static enum dma_status tegra_dma_tx_status(struct =
dma_chan *dc,
>>>>  		residual =3D dma_desc->bytes_requested -
>>>>  			   (dma_desc->bytes_transferred %
>>>>  			    dma_desc->bytes_requested);
>>>> +		residual =3D tegra_dma_update_residual(tdc, sg_req, dma_desc,
>>>> +						     residual);
>>>
>>> I had a quick look at this, I am not sure that we want to call
>>> tegra_dma_update_residual() here for cases where the dma_desc is on the
>>> free_dma_desc list. In fact, couldn't this be simplified a bit for case
>>> where the dma_desc is on the free list? In that case I believe that the
>>> residual should always be 0.
>>
>> Actually, no, it could be non-zero in the case the transfer is aborted.
>=20
> Looks like everything should be fine as-is.

I am still not sure we want to call this for the case where dma_desc is
on the free list.

> BTW, it's a bit hard to believe that there is any real benefit from the
> free_dma_desc list at all, maybe worth to just remove it?

I think you need to elaborate a bit more here. I am not a massive fan of
this driver, but I am also not in the mood for changing unless there is
a good reason.

Cheers
Jon

--=20
nvpublic
