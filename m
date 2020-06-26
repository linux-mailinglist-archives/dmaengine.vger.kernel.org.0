Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5847520AD24
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2020 09:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgFZHaA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 Jun 2020 03:30:00 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35844 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFZHaA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 Jun 2020 03:30:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05Q7TiKO110026;
        Fri, 26 Jun 2020 02:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593156584;
        bh=H7Sye2F6KYJGyt86hcv78Gg9uUrflv9GgwpNcNmMWqA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qmi8KBoS3LJBml2lCLL+R4h2DzChe0sIGuMZoPXycfI9jeo8yaJtuxe5BVmJYgjh1
         PZbDJ06D6FPBdVDAXOWcdrx7wGJdEzrQNZIv6mRUkyzyhxSvVxawabrhynKB4K8yya
         9kmXrg5m5Jp1qmBMC9DbdyU2WsdK0LxNWSUUBbjU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05Q7TimS099997
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Jun 2020 02:29:44 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 26
 Jun 2020 02:29:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 26 Jun 2020 02:29:43 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05Q7Tgwm111765;
        Fri, 26 Jun 2020 02:29:42 -0500
Subject: Re: [PATCH][next] dmaengine: ti: k3-udma: Use struct_size() in
 kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200619224334.GA7857@embeddedor>
 <20200624055535.GX2324254@vkoul-mobl>
 <3a5514c9-d966-c332-84ba-f418c26fa74c@embeddedor.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <98426221-8bff-25df-a062-9ec1ca4e8f26@ti.com>
Date:   Fri, 26 Jun 2020 10:30:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3a5514c9-d966-c332-84ba-f418c26fa74c@embeddedor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 24/06/2020 20.12, Gustavo A. R. Silva wrote:
> Hi Vinod,
>=20
> On 6/24/20 00:55, Vinod Koul wrote:
>> On 19-06-20, 17:43, Gustavo A. R. Silva wrote:
>>> Make use of the struct_size() helper instead of an open-coded version=

>>> in order to avoid any potential type mistakes.
>>>
>>> This code was detected with the help of Coccinelle and, audited and
>>> fixed manually.
>>>
>>> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>  drivers/dma/ti/k3-udma.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>>> index 0d5fb154b8e2..411c54b86ba8 100644
>>> --- a/drivers/dma/ti/k3-udma.c
>>> +++ b/drivers/dma/ti/k3-udma.c
>>> @@ -2209,7 +2209,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, st=
ruct scatterlist *sgl,
>>>  	u32 ring_id;
>>>  	unsigned int i;
>>> =20
>>> -	d =3D kzalloc(sizeof(*d) + sglen * sizeof(d->hwdesc[0]), GFP_NOWAIT=
);
>>> +	d =3D kzalloc(struct_size(d, hwdesc, sglen), GFP_NOWAIT);
>>
>> struct_size() is a * b + c but here we need, a + b * c.. the trailing
>> struct is N times here..
>>
>=20
> struct_size() works exactly as expected in this case. :)
> Please, see:
>=20
> include/linux/overflow.h:314:
> 314 #define struct_size(p, member, count)                              =
     \
> 315         __ab_c_size(count,                                         =
     \
> 316                     sizeof(*(p)->member) + __must_be_array((p)->mem=
ber),\
> 317                     sizeof(*(p)))

True, struct_size is for this sort of things.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

While looking it up in include/linux/overflow.h I have noticed your
commit in linux-next, which adds flex_array_size()

The example in the commit message contradicts with what the helper
does imho. To be correct it should have been:

struct something {
	size_t count;
	struct foo items[];
};

- struct something *instance;
+ struct something instance;

- instance =3D kmalloc(struct_size(instance, items, count), GFP_KERNEL);
+ instance.items =3D kmalloc(struct_size(instance, items, count), GFP_KER=
NEL);
instance->count =3D count;
memcpy(instance->items, src, flex_array_size(instance, items, instance->c=
ount));

If I'm not mistaken..


>=20
> Thanks
> --
> Gustavo
>=20
>>>  	if (!d)
>>>  		return NULL;
>>> =20
>>> @@ -2525,7 +2525,7 @@ udma_prep_dma_cyclic_pkt(struct udma_chan *uc, =
dma_addr_t buf_addr,
>>>  	if (period_len >=3D SZ_4M)
>>>  		return NULL;
>>> =20
>>> -	d =3D kzalloc(sizeof(*d) + periods * sizeof(d->hwdesc[0]), GFP_NOWA=
IT);
>>> +	d =3D kzalloc(struct_size(d, hwdesc, periods), GFP_NOWAIT);
>>>  	if (!d)
>>>  		return NULL;
>>> =20
>>> --=20
>>> 2.27.0
>>

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/=
Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

