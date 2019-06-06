Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3252F37A1B
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jun 2019 18:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfFFQxY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Jun 2019 12:53:24 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12824 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfFFQxY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Jun 2019 12:53:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf945010001>; Thu, 06 Jun 2019 09:53:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 09:53:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Jun 2019 09:53:23 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 16:53:20 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
To:     Dmitry Osipenko <digetx@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <mkumard@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a652b103-979d-7910-5e3f-ec4bca3a3a3b@nvidia.com>
Date:   Thu, 6 Jun 2019 17:53:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e6741e07-be0c-d16b-36d7-77a3288f0500@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559840001; bh=I/fuzuK3Yiq+HteMq2fY8VIc2IY2bt5ed0CgfdjuV54=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ma4J8RKDt2lu89e0z0l+xoOop5ExSdljrZj9Fj9i+Op6lYX9er+LJb8yLlx5KeTtE
         p7B49HuIaunwz1kZX45K3rUwqYnC5VTWDoUInHMruK3a6r5qvS4SfjzW114miL4Lh1
         EswOf/X8CHcCdbGpgBkmNwCUGUlM6U59cmlwguXVKmepaBsomRPD/B41rVlKeW2+GH
         BFMBMQDxVX4MNro5LW8ALA2dolOX3cL0i3719k8y/XIOCL7Hj61Ioekomge9nUOo1k
         ktjLmrDAp1xNQgy2b/+E9t38STr2G3qPExgTq1uW/d/FUNUz5YbzU8iMlVhHNgRQmh
         OKD4N6SNk0TgA==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 06/06/2019 17:44, Dmitry Osipenko wrote:
> 06.06.2019 19:32, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 06/06/2019 16:18, Dmitry Osipenko wrote:
>>
>> ...
>>
>>>>> If I understood everything correctly, the FIFO buffer is shared among
>>>>> all of the ADMA clients and hence it should be up to the ADMA driver =
to
>>>>> manage the quotas of the clients. So if there is only one client that
>>>>> uses ADMA at a time, then this client will get a whole FIFO buffer, b=
ut
>>>>> once another client starts to use ADMA, then the ADMA driver will hav=
e
>>>>> to reconfigure hardware to split the quotas.
>>>>
>>>> The FIFO quotas are managed by the ADMAIF driver (does not exist in
>>>> mainline currently but we are working to upstream this) because it is
>>>> this device that owns and needs to configure the FIFOs. So it is reall=
y
>>>> a means to pass the information from the ADMAIF to the ADMA.
>>>
>>> So you'd want to reserve a larger FIFO for an audio channel that has a
>>> higher audio rate since it will perform reads more often. You could als=
o
>>> prioritize one channel over the others, like in a case of audio call fo=
r
>>> example.
>>>
>>> Is the shared buffer smaller than may be needed by clients in a worst
>>> case scenario? If you could split the quotas statically such that each
>>> client won't ever starve, then seems there is no much need in the
>>> dynamic configuration.
>>
>> Actually, this is still very much relevant for the static case. Even if
>> we defined a static configuration of the FIFO mapping in the ADMAIF
>> driver we still need to pass this information to the ADMA. I don't
>> really like the idea of having it statically defined in two different
>> drivers.
>=20
> Ah, so you need to apply the same configuration in two places. Correct?
>=20
> Are ADMAIF and ADMA really two different hardware blocks? Or you
> artificially decoupled the ADMA driver?

These are two different hardware modules with their own register sets.
Yes otherwise, it would be a lot simpler!

Jon

--=20
nvpublic
