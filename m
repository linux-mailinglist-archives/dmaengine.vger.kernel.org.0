Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3015055F
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2020 12:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgBCLhv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Feb 2020 06:37:51 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19133 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgBCLhu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Feb 2020 06:37:50 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3805ff0003>; Mon, 03 Feb 2020 03:37:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 03 Feb 2020 03:37:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 03 Feb 2020 03:37:50 -0800
Received: from [10.26.11.224] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Feb
 2020 11:37:47 +0000
Subject: Re: [PATCH v6 11/16] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-12-digetx@gmail.com>
 <2442aee7-2c2a-bacc-7be9-8eed17498928@nvidia.com>
 <0c766352-700a-68bf-cf7b-9b1686ba9ca9@gmail.com>
 <e72d00ee-abee-9ae2-4654-da77420b440e@nvidia.com>
 <cedbf558-b15b-81ca-7833-c94aedce5c5c@gmail.com>
 <315241b5-f5a2-aaa0-7327-24055ff306c7@nvidia.com>
 <1b64a3c6-a8b9-34d7-96cc-95b93ca1a392@gmail.com>
 <bf459b54-fa4c-b0ff-0af8-b7cb66b0a43c@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <423eb28f-b5fc-c917-a7b2-72562183683f@nvidia.com>
Date:   Mon, 3 Feb 2020 11:37:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bf459b54-fa4c-b0ff-0af8-b7cb66b0a43c@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580729856; bh=ceXnFZ7jddmETXXwdfs4mGpj+O00W2KY/YQ322nXt4U=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qXuwCM2rJ8br+WfWyobe/MOBDj1SnQ+sqtC2P5uvgpRUccqPpupsIKKpULWJuCtQy
         6+QbNlZX687vt/qhOmx92gy1Pw3v7rccOBTqUiXn8aSGPyXtGngyhgs/b4F70poRYT
         HflYyjxCPZzn3obut9ctKGikXHbRtlIn2F/Gl9YHEdaZnc/fVJUbCCEc4t5ywtcCHT
         tjAk/8johzjzyOG9rnIKLdMoqAyLTOAN1mgi0zhYljIfFsCZRsZVUwTW++WsiNqgAH
         JiRUMU80FPLJEYHqhP2uynEgr2Gi/RKZazoeeDHl/eWOEztujVleq0XhrIEdFle+7g
         v+rjTZC4ZZUpQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 01/02/2020 15:13, Dmitry Osipenko wrote:
> 31.01.2020 17:22, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> 31.01.2020 12:02, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>
>>> On 30/01/2020 20:04, Dmitry Osipenko wrote:
>>>
>>> ...
>>>
>>>>>> The tegra_dma_stop() should put RPM anyways, which is missed in your=
s
>>>>>> sample. Please see handle_continuous_head_request().
>>>>>
>>>>> Yes and that is deliberate. The cyclic transfers the transfers *shoul=
d*
>>>>> not stop until terminate_all is called. The tegra_dma_stop in
>>>>> handle_continuous_head_request() is an error condition and so I am no=
t
>>>>> sure it is actually necessary to call pm_runtime_put() here.
>>>>
>>>> But then tegra_dma_stop() shouldn't unset the "busy" mark.
>>>
>>> True.
>>>
>>>>>> I'm also finding the explicit get/put a bit easier to follow in the
>>>>>> code, don't you think so?
>>>>>
>>>>> I can see that, but I was thinking that in the case of cyclic transfe=
rs,
>>>>> it should only really be necessary to call the get/put at the beginni=
ng
>>>>> and end. So in my mind there should only be two exit points which are
>>>>> the ISR handler for SG and terminate_all for SG and cyclic.
>>>>
>>>> Alright, I'll update this patch.
>>>
>>> Hmmm ... I am wondering if we should not mess with that and leave how
>>> you have it.
>>
>> I took another look and seems my current v6 should be more correct becau=
se:
>>
>> 1. If "busy" is unset in tegra_dma_stop(), then the RPM should be put
>> there since tegra_dma_terminate_all() won't put RPM in this case:
>>
>> 	if (!tdc->busy)
>> 		goto skip_dma_stop;
>>
>> 2. We can't move the "busy" unsetting into the terminate because then
>> tegra_dma_stop() will be invoked twice. Although, one option could be to
>> remove the tegra_dma_stop() from the error paths of
>> handle_continuous_head_request(), but I'm not sure that this is correct
>> to do.
>=20
> Jon, I realized that my v6 variant is wrong too because
> tegra_dma_terminate_all() -> tdc->isr_handler() will put RPM, and thus,
> the RPM enable-count will be wrecked in this case.

Did you see my other suggestion to move the pm_runtime_put() outside of
tegra_dma_stop? There are only a few call sites for tegra_dma_stop and
so if we call pm_runtime_put() after calling tegra_dma_stop this should
simplify matters.

Jon

--=20
nvpublic
