Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C699154643
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2020 15:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBFOdj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Feb 2020 09:33:39 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4636 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFOdj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Feb 2020 09:33:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3c23a90000>; Thu, 06 Feb 2020 06:33:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 06:33:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Feb 2020 06:33:38 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Feb
 2020 14:33:36 +0000
Subject: Re: [PATCH v7 14/19] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200202222854.18409-1-digetx@gmail.com>
 <20200202222854.18409-15-digetx@gmail.com>
 <ca0f71ef-ba16-73bc-d904-1f5351c69931@nvidia.com>
 <3133d4e3-7623-9342-f26c-5de8b4e6b8c6@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <422a3043-9674-9860-eb98-e7a8eac73c58@nvidia.com>
Date:   Thu, 6 Feb 2020 14:33:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3133d4e3-7623-9342-f26c-5de8b4e6b8c6@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580999593; bh=JIt4CiWKyQvqHZzMOvI6LbtPuH6fvx16CRXo3Yd9Sx4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jb+xeGHOr3HnJFRCnV4GvJ3hnwtFp1JvGj5CG/jGy9uMZLggQcGe5kG/R8kJn6poe
         7aOAtJ0iT0e5gaCQIOjHYzeq96BfAx8xF8cR3OjnLmdFr2kx2aCOs75l3MHfrTpQ7o
         5q49onAQxun6OOyYVT3Hs5TrgG20C1ABTs5n/+qDa1q47KGoeeUvw4Ajf0XWFgxEp3
         1+wHuqeYTdQVNy9XeEKtBZ3Rli6OoeoMotWy/80wQBk4vYpjYifGwu4yMtMtzQnJyH
         FPTeiR+11gg8FzRLjVYZVDsMMBOs3I49jDp0VDpZZoJHdEaaf9/RizAPmTysMhvqGZ
         +p6FSgfi7PauA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 06/02/2020 14:31, Dmitry Osipenko wrote:
> 06.02.2020 16:50, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 02/02/2020 22:28, Dmitry Osipenko wrote:
>>> It's a bit impractical to enable hardware's clock at the time of DMA
>>> channel's allocation because most of DMA client drivers allocate DMA
>>> channel at the time of the driver's probing, and thus, DMA clock is kep=
t
>>> always-enabled in practice, defeating the whole purpose of runtime PM.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++-----------
>>>  1 file changed, 24 insertions(+), 11 deletions(-)
>> What about something like ......
>> @@ -581,6 +582,7 @@ static bool handle_continuous_head_request(struct te=
gra_dma_channel *tdc,
>>  	hsgreq =3D list_first_entry(&tdc->pending_sg_req, typeof(*hsgreq), nod=
e);
>>  	if (!hsgreq->configured) {
>>  		tegra_dma_stop(tdc);
>> +		pm_runtime_put(tdc->tdma->dev);
>>  		dev_err(tdc2dev(tdc), "Error in DMA transfer, aborting DMA\n");
>>  		tegra_dma_abort_all(tdc);
>>  		return false;
>=20
> Yes, that it's what you suggested to do in the reply to v6.
>=20
> Alright, I'll drop v7 patch #13 and add the put to this patch #14.

Yes I was not sure if it was clear. However, this seems a bit of an
easier change and should keep the 'busy' status somewhat consistent with
the rpm state.

Jon

--=20
nvpublic
