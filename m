Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C487C49C54
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 10:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfFRIrG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 04:47:06 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3755 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfFRIrG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 04:47:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d08a5080004>; Tue, 18 Jun 2019 01:47:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 01:47:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Jun 2019 01:47:03 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 08:47:01 +0000
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
 <d34c100d-e82a-bb00-22c6-c5f2f6cdb03a@nvidia.com>
 <b47b7b89-e830-0b3e-026d-c6c7d67d3324@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <255f92e8-df61-5e9c-ba4f-e52a0bd11451@nvidia.com>
Date:   Tue, 18 Jun 2019 09:47:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b47b7b89-e830-0b3e-026d-c6c7d67d3324@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560847624; bh=BNRft4nxFu1I3+WbPSbDRRtVP9WPLPJr58b0fEhrxuM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DXGD8S6MGzRl3AaY07KR6OLdT5RgypGeKvkXN/xSZhARGP50485xUNB5QvZSkjaqr
         uXpMa6O9YkrKR/axQq26pCUlJ/OAWSEH+PVG/OM3iLKISZVVvouSzXggCQ2+EazWHz
         KVZEPRv6VruXBKkwzKDXbA9PmYcy0Kkq/BxTR+NoHLD+r4Wm+n0ZB8GluhkY1Rwq4X
         XHbdu0zqvLP4QIIW0othuw2I6U41H4YPCFGUOhSC/QjBnetGPftqLRmUmvaVUBnFvL
         boWfieIxYJul9serVduN5XbSd/S3T4/dKmdsIGA2G0ozAUxhyXIQ82xz1Yp5qzzYkR
         nKOc9kNqBbuMA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 17/06/2019 13:41, Dmitry Osipenko wrote:
> 17.06.2019 13:57, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 14/06/2019 17:44, Dmitry Osipenko wrote:
>>> 14.06.2019 18:24, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>
>>>> On 14/06/2019 16:21, Jon Hunter wrote:
>>>>>
>>>>> On 13/06/2019 22:08, Dmitry Osipenko wrote:
>>>>>> Tegra's APB DMA engine updates words counter after each transferred =
burst
>>>>>> of data, hence it can report transfer's residual with more fidelity =
which
>>>>>> may be required in cases like audio playback. In particular this fix=
es
>>>>>> audio stuttering during playback in a chromiuim web browser. The pat=
ch is
>>>>>> based on the original work that was made by Ben Dooks [1]. It was te=
sted
>>>>>> on Tegra20 and Tegra30 devices.
>>>>>>
>>>>>> [1] https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@co=
dethink.co.uk/
>>>>>>
>>>>>> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>  drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++----=
---
>>>>>>  1 file changed, 28 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb=
-dma.c
>>>>>> index 79e9593815f1..c5af8f703548 100644
>>>>>> --- a/drivers/dma/tegra20-apb-dma.c
>>>>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>>>>> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_=
chan *dc)
>>>>>>  	return 0;
>>>>>>  }
>>>>>> =20
>>>>>> +static unsigned int tegra_dma_update_residual(struct tegra_dma_chan=
nel *tdc,
>>>>>> +					      struct tegra_dma_sg_req *sg_req,
>>>>>> +					      struct tegra_dma_desc *dma_desc,
>>>>>> +					      unsigned int residual)
>>>>>> +{
>>>>>> +	unsigned long status, wcount =3D 0;
>>>>>> +
>>>>>> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>>>>>> +		return residual;
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
>>>>>> +		return residual - sg_req->req_len;
>>>>>> +
>>>>>> +	return residual - get_current_xferred_count(tdc, sg_req, wcount);
>>>>>> +}
>>>>>> +
>>>>>>  static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>>>>>>  	dma_cookie_t cookie, struct dma_tx_state *txstate)
>>>>>>  {
>>>>>>  	struct tegra_dma_channel *tdc =3D to_tegra_dma_chan(dc);
>>>>>> +	struct tegra_dma_sg_req *sg_req =3D NULL;
>>>>>>  	struct tegra_dma_desc *dma_desc;
>>>>>> -	struct tegra_dma_sg_req *sg_req;
>>>>>>  	enum dma_status ret;
>>>>>>  	unsigned long flags;
>>>>>>  	unsigned int residual;
>>>>>> @@ -838,6 +862,8 @@ static enum dma_status tegra_dma_tx_status(struc=
t dma_chan *dc,
>>>>>>  		residual =3D dma_desc->bytes_requested -
>>>>>>  			   (dma_desc->bytes_transferred %
>>>>>>  			    dma_desc->bytes_requested);
>>>>>> +		residual =3D tegra_dma_update_residual(tdc, sg_req, dma_desc,
>>>>>> +						     residual);
>>>>>
>>>>> I had a quick look at this, I am not sure that we want to call
>>>>> tegra_dma_update_residual() here for cases where the dma_desc is on t=
he
>>>>> free_dma_desc list. In fact, couldn't this be simplified a bit for ca=
se
>>>>> where the dma_desc is on the free list? In that case I believe that t=
he
>>>>> residual should always be 0.
>>>>
>>>> Actually, no, it could be non-zero in the case the transfer is aborted=
.
>>>
>>> Looks like everything should be fine as-is.
>>
>> I am still not sure we want to call this for the case where dma_desc is
>> on the free list.
>=20
> You're right! It's a bug there! The sg_req=3DNULL if dma_desc is on the f=
ree list, hence
> it will result in a NULL dereference. I'll fix it in v2 and will avoid th=
e offending
> call, like you're suggesting.
>=20
>>> BTW, it's a bit hard to believe that there is any real benefit from the
>>> free_dma_desc list at all, maybe worth to just remove it?
>>
>> I think you need to elaborate a bit more here. I am not a massive fan of
>> this driver, but I am also not in the mood for changing unless there is
>> a good reason.
>=20
> It looks like the whole point of the free list is to have a cache of prea=
llocated
> dma_desc's, but dma_desc allocation and initialization doesn't cost anyth=
ing in
> comparison to the free list because memory is allocated from a SLAB cache=
 and then the
> initialization will happen on CPU's cache.
>=20
> So the free list is quite pointless in terms of optimization. Moreover wh=
at if driver
> allocates a lot of dma_desc's and uses them just once? Looks like it will=
 be quite a
> lot of wasted memory on the free list.

Yes indeed and for the ADMA we allocate and free on-demand as you are
suggesting. I don't know why it was done like this, but to make the
change it would be good to get some data about how much memory it is
consuming to see if it is actually worth it.

Cheers
Jon

--=20
nvpublic
