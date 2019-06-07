Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7A386F3
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2019 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfFGJYG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jun 2019 05:24:06 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14264 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFGJYG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jun 2019 05:24:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfa2d320000>; Fri, 07 Jun 2019 02:24:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 02:24:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 02:24:04 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 09:24:01 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Dmitry Osipenko <digetx@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <mkumard@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <ed95f03a-bbe7-ad62-f2e1-9bfe22ec733a@ti.com>
 <4cab47d0-41c3-5a87-48e1-d7f085c2e091@nvidia.com>
 <8a5b84db-c00b-fff4-543f-69d90c245660@nvidia.com>
 <3f836a10-eaf3-f59b-7170-6fe937cf2e43@ti.com>
 <a36302fc-3173-070b-5c97-7d2c55d5e2cc@nvidia.com>
 <a08bec36-b375-6520-eff4-3d847ddfe07d@ti.com>
 <4593f37c-5e89-8559-4e80-99dbfe4235de@nvidia.com>
 <deae510a-f6ae-6a51-2875-a7463cac9169@gmail.com>
 <ac9a965d-0166-3d80-5ac4-ae841d7ae726@nvidia.com>
 <50e1f9ed-1ea0-38f6-1a77-febd6a3a0848@gmail.com>
 <4b098fb6-1a5b-1100-ae16-978a887c9535@nvidia.com>
 <e6741e07-be0c-d16b-36d7-77a3288f0500@gmail.com>
 <a652b103-979d-7910-5e3f-ec4bca3a3a3b@nvidia.com>
 <457eb5e1-40cc-8c0f-e21c-3881c3c04de2@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a931c88c-0741-4332-832a-77458b55bfef@nvidia.com>
Date:   Fri, 7 Jun 2019 10:24:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <457eb5e1-40cc-8c0f-e21c-3881c3c04de2@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559899442; bh=MxZqrJAfR23g+PE4CTEHYSJQaLJosZJv5V3qOu+iOQA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=EPNmCJ8ckokrtSECVyzLoUKmjW5c8x5MO2dqqTBQFmVrT9YY92svfPIL2vOuwR9Hq
         DBRv5gw0oh2lP8DsQHMu7Msr8i730fQNYuqSTUgGqGSaeIBDTETj21FbRvLDFftIoy
         ocQqKQ5vppXmGMK+fRbyydftaGXCuXzA6d2xkO6nq0Zxko+tHOg63gDXyymHOhOSFm
         Guk26tRHeQwIAfjboC0UOtdrqBJeAN1E2X/bMcdMy928HnEYqQx9qQK/uBI8PSsLM7
         SZLP6Bzk/aUZOUqdgfPBprG8vWCO5vpqaj+/onvYaQ8vmQS0uVay0feNG+9SGP65V0
         zeY8kmNw/VnfQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 06/06/2019 18:25, Dmitry Osipenko wrote:
> 06.06.2019 19:53, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 06/06/2019 17:44, Dmitry Osipenko wrote:
>>> 06.06.2019 19:32, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>
>>>> On 06/06/2019 16:18, Dmitry Osipenko wrote:
>>>>
>>>> ...
>>>>
>>>>>>> If I understood everything correctly, the FIFO buffer is shared amo=
ng
>>>>>>> all of the ADMA clients and hence it should be up to the ADMA drive=
r to
>>>>>>> manage the quotas of the clients. So if there is only one client th=
at
>>>>>>> uses ADMA at a time, then this client will get a whole FIFO buffer,=
 but
>>>>>>> once another client starts to use ADMA, then the ADMA driver will h=
ave
>>>>>>> to reconfigure hardware to split the quotas.
>>>>>>
>>>>>> The FIFO quotas are managed by the ADMAIF driver (does not exist in
>>>>>> mainline currently but we are working to upstream this) because it i=
s
>>>>>> this device that owns and needs to configure the FIFOs. So it is rea=
lly
>>>>>> a means to pass the information from the ADMAIF to the ADMA.
>>>>>
>>>>> So you'd want to reserve a larger FIFO for an audio channel that has =
a
>>>>> higher audio rate since it will perform reads more often. You could a=
lso
>>>>> prioritize one channel over the others, like in a case of audio call =
for
>>>>> example.
>>>>>
>>>>> Is the shared buffer smaller than may be needed by clients in a worst
>>>>> case scenario? If you could split the quotas statically such that eac=
h
>>>>> client won't ever starve, then seems there is no much need in the
>>>>> dynamic configuration.
>>>>
>>>> Actually, this is still very much relevant for the static case. Even i=
f
>>>> we defined a static configuration of the FIFO mapping in the ADMAIF
>>>> driver we still need to pass this information to the ADMA. I don't
>>>> really like the idea of having it statically defined in two different
>>>> drivers.
>>>
>>> Ah, so you need to apply the same configuration in two places. Correct?
>>>
>>> Are ADMAIF and ADMA really two different hardware blocks? Or you
>>> artificially decoupled the ADMA driver?
>>
>> These are two different hardware modules with their own register sets.
>> Yes otherwise, it would be a lot simpler!
>=20
> The register sets are indeed separated, but it looks like that ADMAIF is
> really a part of ADMA that is facing to Audio Crossbar. No? What is the
> purpose of ADMAIF? Maybe you could amend the ADMA hardware description
> with the ADMAIF addition until it's too late.

The ADMA can perform the following transfers (per the CH_CONFIG
register) ...

MEMORY_TO_MEMORY
AHUB_TO_MEMORY
MEMORY_TO_AHUB
AHUB_TO_AHUB

Hence it is possible to use the ADMA to do memory-to-memory transfers
that do not involve the ADMAIF.

So no the ADMAIF is not part of the ADMA. It is purely the interface to
the crossbar (AHUB/APE), but from a hardware standpoint they are
separate. And so no we will not amend the hardware description.

Jon

--=20
nvpublic
