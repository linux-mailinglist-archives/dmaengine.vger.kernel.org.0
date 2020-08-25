Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8AF25118E
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 07:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgHYFci (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 01:32:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37562 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgHYFci (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 01:32:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07P5WYqn010614;
        Tue, 25 Aug 2020 00:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598333554;
        bh=wjNR+SGzPQDbd1az9JmlVfglQXIeO/X7AiTR9LTlmxw=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=x+cwGzittNorhUUc9V5nQ/WBu5SM55LR1ur4brng8UzqAls33iUkReWGZ4rVFNYYt
         2DOwtwsZoZDJLRYsm+gmxnEJynKVkp6UMdtp8BX2Zo74E/Qy78j4pHc6Fd3PtlxSgK
         OyFBPhngHuPqjej1tm9zw9rFqCiTFMqxP2VJnsX0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07P5WYH3100275;
        Tue, 25 Aug 2020 00:32:34 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 25
 Aug 2020 00:32:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 25 Aug 2020 00:32:34 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07P5WX1M119590;
        Tue, 25 Aug 2020 00:32:33 -0500
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix the TR initialization for
 prep_slave_sg
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
References: <20200824120108.9178-1-peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <acdbc662-c912-480d-02c6-47a7b6d1b671@ti.com>
Date:   Tue, 25 Aug 2020 08:34:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824120108.9178-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,

On 24/08/2020 15.01, Peter Ujfalusi wrote:
> The TR which needs to be initialized for the next sg entry is indexed b=
y
> tr_idx and not by the running i counter.
>=20
> In case any sub element in the SG needs more than one TR, the code woul=
d
> corrupt an already configured TR.

I forgot to add the Fixes tag:
Fixes: 6cf668a4ef829 ("dmaengine: ti: k3-udma: Use the TR counter helper =
for slave_sg and cyclic")

Can you add it or I can resend with the tag.
=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index c14e6cb105cd..30cb514cee54 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -2059,9 +2059,9 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struc=
t scatterlist *sgl,
>  			return NULL;
>  		}
> =20
> -		cppi5_tr_init(&tr_req[i].flags, CPPI5_TR_TYPE1, false, false,
> -			      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -		cppi5_tr_csf_set(&tr_req[i].flags, CPPI5_TR_CSF_SUPR_EVT);
> +		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
> +			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> +		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
> =20
>  		tr_req[tr_idx].addr =3D sg_addr;
>  		tr_req[tr_idx].icnt0 =3D tr0_cnt0;
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/=
Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

