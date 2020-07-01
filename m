Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C85A210B15
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 14:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbgGAMcn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 08:32:43 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50332 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729959AbgGAMcm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 08:32:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061CWdmm119172;
        Wed, 1 Jul 2020 07:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593606759;
        bh=1OuTMMgKHW9X0GDjYYou2VPWRj2DQVp8c0i04AnCvoY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Vv65hgBIY4pRKWHYmfM40h1olZDz+1/AOvMBD5/ldI3VvIQnFiAT1TxV4JyW5fQ7s
         X1jWX0ic2aaAG/1Kq91+hoAtj1Uh93qCR25AwHYpmRzx8NleeJDEK3hx+MbZ2vyhW9
         zhrYLSAnWjv5NYhenWFtZgYCOjZ6vpFP9TBsiIiA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061CWdho086059;
        Wed, 1 Jul 2020 07:32:39 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 07:32:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 07:32:38 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061CWZu9024434;
        Wed, 1 Jul 2020 07:32:36 -0500
Subject: Re: [PATCH next 4/6] soc: ti: k3-ringacc: add request pair of rings
 api.
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>
References: <20200701103030.29684-1-grygorii.strashko@ti.com>
 <20200701103030.29684-5-grygorii.strashko@ti.com>
 <7e334685-7d98-9896-ef5b-3a2dfeb100a9@ti.com>
 <e3936c3c-eb60-35a5-6413-ceba273cdf1c@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <45e136da-12c4-044e-dab5-4e9f9d406be9@ti.com>
Date:   Wed, 1 Jul 2020 15:33:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e3936c3c-eb60-35a5-6413-ceba273cdf1c@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 01/07/2020 15.12, Grygorii Strashko wrote:
>=20
>=20
> On 01/07/2020 14:54, Peter Ujfalusi wrote:
>> Hi Grygorii,
>>
>> On 01/07/2020 13.30, Grygorii Strashko wrote:
>>> Add new API k3_ringacc_request_rings_pair() to request pair of rings =
at
>>> once, as in the most cases Rings are used with DMA channels, which
>>> need to
>>> request pair of rings - one to feed DMA with descriptors (TX/RX FDQ) =
and
>>> one to receive completions (RX/TX CQ). This will allow to simplify
>>> Ringacc
>>> API users.
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> ---
>>> =C2=A0 drivers/soc/ti/k3-ringacc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 24 ++++++++++++++++++++++++
>>> =C2=A0 include/linux/soc/ti/k3-ringacc.h |=C2=A0 4 ++++
>>> =C2=A0 2 files changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.=
c
>>> index 8a8f31d59e24..4cf1150de88e 100644
>>> --- a/drivers/soc/ti/k3-ringacc.c
>>> +++ b/drivers/soc/ti/k3-ringacc.c
>>> @@ -322,6 +322,30 @@ struct k3_ring *k3_ringacc_request_ring(struct
>>> k3_ringacc *ringacc,
>>> =C2=A0 }
>>> =C2=A0 EXPORT_SYMBOL_GPL(k3_ringacc_request_ring);
>>> =C2=A0 +int k3_ringacc_request_rings_pair(struct k3_ringacc *ringacc,=

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int fwd_id, int compl_id,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct k3_ring **fwd_ring,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct k3_ring **compl_ring)
>>
>> Would you consider re-arranging the parameter list to:
>> int k3_ringacc_request_rings_pair(struct k3_ringacc *ringacc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct k3_ring **fwd_ring, int fwd_id,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct k3_ring **compl_ring, int compl_id)=

>>
>=20
> i think it's more common to have input parameters first.

That's true. I just like parameters grouped.
(ringacc, fwd_id, fwd_ring, compl_id, compl_ring)

having said that, I don't have objection to leave things as they are.

>=20
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!fwd_ring || !compl_ring)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 *fwd_ring =3D k3_ringacc_request_ring(ringacc, fw=
d_id, 0);
>>> +=C2=A0=C2=A0=C2=A0 if (!(*fwd_ring))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 *compl_ring =3D k3_ringacc_request_ring(ringacc, =
compl_id, 0);
>>> +=C2=A0=C2=A0=C2=A0 if (!(*compl_ring)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k3_ringacc_ring_free(*fwd=
_ring);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENODEV;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(k3_ringacc_request_rings_pair);
>>> +
>=20
>=20
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

