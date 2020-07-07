Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB02169E5
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 12:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgGGKSP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 06:18:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48504 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbgGGKSO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 06:18:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 067AIBDS099817;
        Tue, 7 Jul 2020 05:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594117091;
        bh=XUUacjJm4odlYItbgNfE1AM3TGNp6/7FOA/sRnMr1C0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KjxapZ9LfafUkBtHc1GtZCZ/zlBOAmMF8RjdpjsjLpIRhKCeyqrvSn2XSiygmIGmC
         Gwzts3J66mYlEmktJSxmSIC9D8hgPBrRTGTymLXRNqPQXNmXF5+ba1MoalITsKQ9O9
         e3P5dXl4/qi7651DVoyx4Gm0kWUZPp2/6qbxjdLI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 067AIBNr124895
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 05:18:11 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 05:18:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 05:18:11 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 067AI9og037045;
        Tue, 7 Jul 2020 05:18:10 -0500
Subject: Re: [PATCH 5/5] dmaengine: ti: k3-udma: Use udma_chan instead of
 tchan/rchan for IO functions
To:     Grygorii Strashko <grygorii.strashko@ti.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
References: <20200707091031.10411-1-peter.ujfalusi@ti.com>
 <20200707091031.10411-6-peter.ujfalusi@ti.com>
 <3539fa39-b61f-ea38-4bb4-60f85102efc3@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <0d3c2200-dacb-750f-6418-30edf40cd67d@ti.com>
Date:   Tue, 7 Jul 2020 13:19:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3539fa39-b61f-ea38-4bb4-60f85102efc3@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 07/07/2020 12.27, Grygorii Strashko wrote:
>=20
>=20
> On 07/07/2020 12:10, Peter Ujfalusi wrote:
>> Move the uc->tchan/rchan checks to the IO wrappers itself instead of
>> calling the functions with tchan/rchan directly.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> =C2=A0 drivers/dma/ti/k3-udma.c | 163 +++++++++++++++++++-------------=
-------
>> =C2=A0 1 file changed, 78 insertions(+), 85 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 7eae3a3d0703..8b9a3829abc2 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -282,51 +282,49 @@ static inline void udma_update_bits(void __iomem=

>> *base, int reg,
>> =C2=A0 }
>> =C2=A0 =C2=A0 /* TCHANRT */
>> -static inline u32 udma_tchanrt_read(struct udma_tchan *tchan, int reg=
)
>> +static inline u32 udma_tchanrt_read(struct udma_chan *uc, int reg)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 if (!tchan)
>> +=C2=A0=C2=A0=C2=A0 if (!uc || !uc->tchan)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>=20
> In general I have no objections, but
> do you need those checks at all? can it ever happen?

right, it is highly unlikely that uc is NULL. iow it is never NULL.
I'll drop the !uc checks.

Thanks,
- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

