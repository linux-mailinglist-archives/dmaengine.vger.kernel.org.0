Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725581E0912
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2020 10:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389169AbgEYIj7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 May 2020 04:39:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47302 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389150AbgEYIj6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 May 2020 04:39:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04P8dc1I094599;
        Mon, 25 May 2020 03:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590395978;
        bh=OSCkiAD2IFkkJP3tRwqM8iW2l1NIjDCioO7eEpIzpvY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vFKa0VHJvOvgu0dLyavgKOovxQPhaIA7v5km3lRvnkZj4cjsncfrZ/Bcrl+hLXVCb
         4MFrzh6edErc4BBnU2WuURj9hYbfAjTvmiZ/6RJ9ki229jnXuJ4Fs9VYbcPtDYqQSx
         yGzkMusvsCnEMTs77knDlmkDGCANawyiU/hYn1zk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04P8dc92093629;
        Mon, 25 May 2020 03:39:38 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 25
 May 2020 03:39:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 25 May 2020 03:39:38 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04P8dZQD037639;
        Mon, 25 May 2020 03:39:36 -0500
Subject: Re: [PATCH] dmaengine: ti: edma: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>
CC:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200521084634.31966-1-dinghao.liu@zju.edu.cn>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <cec177bf-3465-01a5-febb-00d78e8e27b0@ti.com>
Date:   Mon, 25 May 2020 11:40:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521084634.31966-1-dinghao.liu@zju.edu.cn>
Content-Type: multipart/mixed;
        boundary="------------C46E6AC2967E360ECC53D2DA"
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--------------C46E6AC2967E360ECC53D2DA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 21/05/2020 11.46, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

Thank you for the patch!

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/dma/ti/edma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index c4a5c170c1f9..609ce2607eb7 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2402,8 +2402,7 @@ static int edma_probe(struct platform_device *pde=
v)
>  	ret =3D pm_runtime_get_sync(dev);
>  	if (ret < 0) {
>  		dev_err(dev, "pm_runtime_get_sync() failed\n");
> -		pm_runtime_disable(dev);
> -		return ret;
> +		goto err_disable_pm;
>  	}
> =20
>  	/* Get eDMA3 configuration from IP */
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

--------------C46E6AC2967E360ECC53D2DA
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

--------------C46E6AC2967E360ECC53D2DA--
