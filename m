Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929211D2A38
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2020 10:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgENIdD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 May 2020 04:33:03 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38234 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENIdC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 May 2020 04:33:02 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04E8WnZ3068680;
        Thu, 14 May 2020 03:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589445169;
        bh=wrWLvX+xcYZYuneU7uYoZ1aOivxAyjgi4GYVUlhf1Q4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KhKOrURfWnQVdsjIlbR/3PfgYp5We+af2YG6S+gPmL4vi9BJ4PowkNJyZQvRMF2Fc
         i2rYPeIJIwzt6bOqcaMyUSZhP+maipvFv4KAXMQqwILJzAbbxTsr2W1CANRRIZ/yJe
         u8DX2sD4Mwr4+x9M5MtTwbEcmIMKnlazx51cY1mk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04E8Wn0A077981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 03:32:49 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 03:32:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 03:32:48 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04E8Wlsi004421;
        Thu, 14 May 2020 03:32:47 -0500
Subject: Re: [PATCH -next] dmaengine: ti: k3-udma: Use PTR_ERR_OR_ZERO() to
 simplify code
To:     Samuel Zou <zou_wei@huawei.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1588757146-38858-1-git-send-email-zou_wei@huawei.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <f9ae33c9-5a8a-d10a-5bb3-ecf9ee5d81f5@ti.com>
Date:   Thu, 14 May 2020 11:33:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1588757146-38858-1-git-send-email-zou_wei@huawei.com>
Content-Type: multipart/mixed;
        boundary="------------E105EE2BC1BE5753D91002F5"
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--------------E105EE2BC1BE5753D91002F5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On 06/05/2020 12.25, Samuel Zou wrote:
> Fixes coccicheck warnings:
>=20
> drivers/dma/ti/k3-udma.c:1294:1-3: WARNING: PTR_ERR_OR_ZERO can be used=

> drivers/dma/ti/k3-udma.c:1311:1-3: WARNING: PTR_ERR_OR_ZERO can be used=

> drivers/dma/ti/k3-udma.c:1376:1-3: WARNING: PTR_ERR_OR_ZERO can be used=


Thanks for the patch, I have missed it as I was not in CC for it.
scripts/get_maintainer.pl would have tipped for a wider recipient list..

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>
> ---
>  drivers/dma/ti/k3-udma.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 0a04174..f5775ca 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -1291,10 +1291,8 @@ static int udma_get_tchan(struct udma_chan *uc)
>  	}
> =20
>  	uc->tchan =3D __udma_reserve_tchan(ud, uc->config.channel_tpl, -1);
> -	if (IS_ERR(uc->tchan))
> -		return PTR_ERR(uc->tchan);
> =20
> -	return 0;
> +	return PTR_ERR_OR_ZERO(uc->tchan);
>  }
> =20
>  static int udma_get_rchan(struct udma_chan *uc)
> @@ -1308,10 +1306,8 @@ static int udma_get_rchan(struct udma_chan *uc)
>  	}
> =20
>  	uc->rchan =3D __udma_reserve_rchan(ud, uc->config.channel_tpl, -1);
> -	if (IS_ERR(uc->rchan))
> -		return PTR_ERR(uc->rchan);
> =20
> -	return 0;
> +	return PTR_ERR_OR_ZERO(uc->rchan);
>  }
> =20
>  static int udma_get_chan_pair(struct udma_chan *uc)
> @@ -1373,10 +1369,8 @@ static int udma_get_rflow(struct udma_chan *uc, =
int flow_id)
>  	}
> =20
>  	uc->rflow =3D __udma_get_rflow(ud, flow_id);
> -	if (IS_ERR(uc->rflow))
> -		return PTR_ERR(uc->rflow);
> =20
> -	return 0;
> +	return PTR_ERR_OR_ZERO(uc->rflow);
>  }
> =20
>  static void udma_put_rchan(struct udma_chan *uc)
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

--------------E105EE2BC1BE5753D91002F5
Content-Type: application/pgp-keys; name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFki4nsBCAD3BM+Ogt951JlaDloruEjoZk/Z+/37CjP0fY2mqLhBOzkpx95u
X1Fquf0KfVk+ZzCd25XGOZEtpZNlXfbxRr2iRWPS5RW2FeLYGvg2TTJCpSr+ugKu
OOec6KECCUotGbGhpYwBrbarJNEwDcAzPK7UJYa1rhWOmkpZJ1hXF1hUghB84q35
8DmN4sGLcsIbVdRFZ1tWFh4vGBFV9LsoDZIrnnANb6/XMX78s+tr3RG3GZBaFPl8
jO5IIv0UIGNUKaYlNVFYthjGCzOqtstHchWuK9eQkR7m1+Vc+ezh1qK0VJydIcjn
OtoMZZL7RAz13LB9vmcJjbQPnI7dJojz/M7zABEBAAG0JlBldGVyIFVqZmFsdXNp
IDxwZXRlci51amZhbHVzaUB0aS5jb20+iQFOBBMBCAA4FiEE+dBcpRFvJjZw+uta
LCayis85LN4FAlki4nsCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQLCay
is85LN4QjggAzxxxXqiWpA3vuj9yrlGLft3BeGKWqF8+RzdeRvshtNdpGeIFf+r5
AJVR71R1w89Qeb4DGXus7qsKiafdFGG7yxbuhw8a5wUm+ZncBXA+ETn3OyVtl8g8
r/ZcPX420jClBNTVuL0sSnyqDFDrt5f+uAFOIwsnHdpns174Zu9QhgYxdvdZ+jMh
Psb745O9EVeNvdfUIRdrVjb4IhJKNIzkb0Tulsz5xeCJReUYpxZU1jzEq3YZqIou
+fi+oS4wlJuSoxKKTmIXtSeEy/weStF1XHMo6vLYqzaK4FyIuclqeuYUYSVy2425
7TMXugaI+O85AEI6KW8MCcu1NucSfAWUabkBDQRZIuJ7AQgAypKq8iIugpHxWA2c
Ck6MQdPBT6cOEVK0tjeHaHAVOUPiw9Pq+ssMifdIkDdqXNZ3RLH/X2svYvd8c81C
egqshfB8nkJ5EKmQc9d7s0EwnYT8OwsoVb3c2WXnsdcKEyu2nHgyeJEUpPpMPyLc
+PWhoREifttab4sOPktepdnUbvrDK/gkjHmiG6+L2owSn637N+Apo3/eQuDajfEu
kybxK19ReRcp6dbqWSBGSeNB32c/zv1ka37bTMNVUY39Rl+/8lA/utLfrMeACHRO
FGO1BexMASKUdmlB0v9n4BaJFGrAJYAFJBNHLCDemqkU7gjaiimuHSjwuP0Wk7Ct
KQJfVQARAQABiQE2BBgBCAAgFiEE+dBcpRFvJjZw+utaLCayis85LN4FAlki4nsC
GwwACgkQLCayis85LN7kCwgAoy9r3ZQfJNOXO1q/YQfpEELHn0p8LpwliSDUS1xL
sswyxtZS8LlW8PjlTXuBLu38Vfr0vGav7oyV7TkhnKT3oBOLXanyZqwgyZSKNEGB
PB4v3Fo7YTzpfSofiwuz03uyfjTxiMGjonxSb+YxM7HBHfzjrOKKlg02fK+lWNZo
m5lXugeWD7U6JJguNdYfr+U4zYIblelUImcIE+wnR0oLzUEVDIWSpVrl/OqS3Rzo
mw8wBsHksTHrbgUnKL0SCzYc90BTeKbyjEBnVDr+dlfbxRxkB8h9RMPMdjodvXzS
Gfsa9V/k4XAsh7iX9EUVBbnmjA61ySxU/w98h96jMuteTg=3D=3D
=3DeQmw
-----END PGP PUBLIC KEY BLOCK-----

--------------E105EE2BC1BE5753D91002F5--
