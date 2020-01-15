Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48E213BC3A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 10:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgAOJSU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 04:18:20 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3608 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgAOJSU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 04:18:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1ed8a40000>; Wed, 15 Jan 2020 01:17:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Jan 2020 01:18:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Jan 2020 01:18:19 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 09:18:17 +0000
Subject: Re: [PATCH v4 02/14] dmaengine: tegra-apb: Implement synchronization
 callback
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-3-digetx@gmail.com>
 <c225399c-f032-8001-e67b-b807dcda748c@nvidia.com>
 <627f996c-1487-1b9a-e953-f5737f3ad32a@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <34ec4c18-f082-def6-8544-0d15a109d7f8@nvidia.com>
Date:   Wed, 15 Jan 2020 09:18:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <627f996c-1487-1b9a-e953-f5737f3ad32a@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579079844; bh=t/zrGXb4O5AHRi3mZ6jAJ53qgOH1X6OhtsFPL/UmGIQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=U0qQecO8Hm2RO1idOMvqVv0Mk9my2JG+BXlQGDoVfi5K5Tqe+YTqdFosvmzMT0CQA
         WdOMYe/NLEmew7NlZ73D/X6AX3oK5IrhzwnyIuc6qLjzYvmgQY0A2ReQP75dXZ+AJT
         AO9D0jHwTMhCuO6oleBtu7S5KGvmZ0CkwBh/rdVYX2MknwUlUfh44hPfjjoxrjhgjQ
         KkeHuQFyQAlrVhzxwacekP3aTqSXKGIW2ZZNSt7Aag+MhA1Kn4qv47Mc/KuvVH1wZC
         lZMZCIMbJeTeXVSYZQi1HX/JS1pXJFMLrO9NNYHqLq6lXOGlIQpOUS9glNw1XwuTAZ
         qnJfBZzJQe+pA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 14/01/2020 21:02, Dmitry Osipenko wrote:
> 14.01.2020 18:15, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 12/01/2020 17:29, Dmitry Osipenko wrote:
>>> The ISR tasklet could be kept scheduled after DMA transfer termination,
>>> let's add synchronization callback which blocks until tasklet is finish=
ed.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/dma/tegra20-apb-dma.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dm=
a.c
>>> index 319f31d27014..664e9c5df3ba 100644
>>> --- a/drivers/dma/tegra20-apb-dma.c
>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>> @@ -798,6 +798,13 @@ static int tegra_dma_terminate_all(struct dma_chan=
 *dc)
>>>  	return 0;
>>>  }
>>> =20
>>> +static void tegra_dma_synchronize(struct dma_chan *dc)
>>> +{
>>> +	struct tegra_dma_channel *tdc =3D to_tegra_dma_chan(dc);
>>> +
>>> +	tasklet_kill(&tdc->tasklet);
>>> +}
>>> +
>>
>> Wouldn't there need to be some clean-up here? If the tasklet is
>> scheduled, seems that there would be some other house-keeping that needs
>> to be done after killing it.
>=20
> I'm not seeing anything to clean-up, could you please clarify?

Clean-up with regard to the descriptors. I was concerned if you will the
tasklet the necessary clean-up of the descriptors is not handled.

Jon

--=20
nvpublic
