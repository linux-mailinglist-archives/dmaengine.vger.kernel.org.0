Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C90826D8C9
	for <lists+dmaengine@lfdr.de>; Thu, 17 Sep 2020 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgIQKVp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 06:21:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59552 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgIQKVo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Sep 2020 06:21:44 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08H9fYjT025052;
        Thu, 17 Sep 2020 04:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600335694;
        bh=jYAVlNFS6fBIzA+9Vb7FqqMNVRHOWIGHygBGFcpdO7w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TOf+Rw5IAZ1iQG0ZkVL3feMKSOch4iURM++hRAfsbpf75iJLAQiYJBwLFVVB0Ubpi
         Dvlnq48HNpcOHcXOs3D7NI7kzebnAsBCtu7oz8vjNKFGBG8SmRuYoWu6BonEJfl38W
         0QrePR0o+6EvfE/9F7GZRpSUQDTxf51mZ7gzcnEA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08H9fXpS045091
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 04:41:33 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 04:41:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 04:41:33 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08H9fVHh055896;
        Thu, 17 Sep 2020 04:41:32 -0500
Subject: Re: [PATCH -next] dmaengine: ti: k3-udma: use
 devm_platform_ioremap_resource_byname
To:     Qilong Zhang <zhangqilong3@huawei.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>
References: <20200917074457.52748-1-zhangqilong3@huawei.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <b43833ec-0d2b-8bed-cde4-432a03232432@ti.com>
Date:   Thu, 17 Sep 2020 12:41:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917074457.52748-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 17/09/2020 10.44, Qilong Zhang wrote:
> From: Zhang Qilong <zhangqilong3@huawei.com>
>=20
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/dma/ti/k3-udma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index de7bfc02a2de..eb29fdc9ffc1 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -3157,13 +3157,11 @@ static const struct soc_device_attribute k3_soc=
_devices[] =3D {
> =20
>  static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev=
 *ud)
>  {
> -	struct resource *res;
>  	int i;
> =20
>  	for (i =3D 0; i < MMR_LAST; i++) {
> -		res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -						   mmr_names[i]);
> -		ud->mmrs[i] =3D devm_ioremap_resource(&pdev->dev, res);
> +		ud->mmrs[i] =3D devm_platform_ioremap_resource_byname(pdev,
> +								    mmr_names[i]);
>  		if (IS_ERR(ud->mmrs[i]))
>  			return PTR_ERR(ud->mmrs[i]);
>  	}
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

