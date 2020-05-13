Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD971D09ED
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgEMHaG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 03:30:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42394 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgEMHaF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 May 2020 03:30:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04D7U0MC092238;
        Wed, 13 May 2020 02:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589355000;
        bh=ejyQC7jmRz5Hq8qewaEoZtN0A8UfA/qp8YQnBZASiU8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=l6en0JlmqGfzT0Rlba3+hlekZvZ675b+VOJaBNFG9maS8ttX6faNkBbHStY5ll/3y
         6GlYMynCaxV1Gi+8T9QHwLqn8nj2HCc3RWFPCF7+a1DE6k+JHNA957A/vNpCA0zzh8
         kGg1lAHDvmwXOdFSeDOh3ZwS7G3bbGHV4WfQ2Upc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04D7U08E126589;
        Wed, 13 May 2020 02:30:00 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 02:29:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 02:29:59 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04D7TwAZ102150;
        Wed, 13 May 2020 02:29:59 -0500
Subject: Re: [PATCH v4] dmaengine: cookie bypass for out of order completion
To:     Dave Jiang <dave.jiang@intel.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <swathi.kovvuri@intel.com>
References: <158924063387.26270.4363255780049839915.stgit@djiang5-desk3.ch.intel.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <4d279eb4-baf8-f504-da30-6a6a963bc521@ti.com>
Date:   Wed, 13 May 2020 10:30:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <158924063387.26270.4363255780049839915.stgit@djiang5-desk3.ch.intel.com>
Content-Type: multipart/mixed;
        boundary="------------7E48ADA229F68EF8F76D6F5B"
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--------------7E48ADA229F68EF8F76D6F5B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 12/05/2020 2.47, Dave Jiang wrote:
> The cookie tracking in dmaengine expects all submissions completed in
> order. Some DMA devices like Intel DSA can complete submissions out of
> order, especially if configured with a work queue sharing multiple DMA
> engines. Add a status DMA_OUT_OF_ORDER that tx_status can be returned f=
or
> those DMA devices. The user should use callbacks to track the completio=
n
> rather than the DMA cookie. This would address the issue of dmatest
> complaining that descriptors are "busy" when the cookie count goes
> backwards due to out of order completion. Add DMA_COMPLETION_NO_ORDER
> DMA capability to allow the driver to flag the device's ability to comp=
lete
> operations out of order.

I'm still a bit hesitant around this.
If the DMA only support out of order completion then it is mandatory
that each descriptor must have unique callback parameter in order the
client could know which transfer has been completed.
Kind of obvious, not sure if it worth documenting.

It was/is on my to do list to support out of order completion as well,
but the use case and setup is different and would need additional
features for DMAengine (like 'classification' of a descriptor).
I have planned to add optional DMA device level of cookie handling so I
could track non ordered cookie statuses.
In my case I mostly know which way the descriptor is going to go, but if
I understand right in your case you have a pool of DMAs and it is mostly
random which one is going to pick up (and complete) the descriptors,
thus leading to cases when smaller transfers overtaking longer ones in
completion.

I also believe this would not block optional DMA device level of cookie
handling.

> Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
> ---
> v4:
> - Add block for polled in dmatest. Need better enabling in future to so=
lve
>   per channel capability for out of order vs poll. (peter)

Thanks, it is just too bad that dma_has_cap() is so widely used to be
easily repurposed :(

> v3:
> - v2 mailed wrong patch
> v2:
> - Add DMA capability (vinod)
> - Add documentation (vinod)
>=20
>  Documentation/driver-api/dmaengine/provider.rst |   11 +++++++++++
>  drivers/dma/dmatest.c                           |   11 ++++++++++-
>  drivers/dma/idxd/dma.c                          |    3 ++-
>  include/linux/dmaengine.h                       |    2 ++
>  4 files changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Document=
ation/driver-api/dmaengine/provider.rst
> index 56e5833e8a07..783ca141e147 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -239,6 +239,14 @@ Currently, the types available are:
>      want to transfer a portion of uncompressed data directly to the
>      display to print it
> =20
> +- DMA_COMPLETION_NO_ORDER
> +
> +  - The device supports out of order completion of the operations.
> +
> +  - The driver should return DMA_OUT_OF_ORDER for device_tx_status if
> +    the device supports out of order completion and the completion is
> +    is expected to be completed out of order.

It is not just supports out of order, but does not support in order
completion. Iow it can not guarantee in order completion.
As a not: all cookie tracking and checking API should be treated as
invalid. For example dma_sync_wait() is unusable.

and one extra 'is'

> +
>  These various types will also affect how the source and destination
>  addresses change over time.
> =20
> @@ -399,6 +407,9 @@ supported.
>    - In the case of a cyclic transfer, it should only take into
>      account the current period.
> =20
> +  - Should return DMA_OUT_OF_ORDER if the device supports out of order=

> +    completion and is completing the operation out of order.

Same here.

> +
>    - This function can be called in an interrupt context.
> =20
>  - device_config
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index a2cadfa2e6d7..93c7c56af5f2 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -821,7 +821,10 @@ static int dmatest_func(void *data)
>  			result("test timed out", total_tests, src->off, dst->off,
>  			       len, 0);
>  			goto error_unmap_continue;
> -		} else if (status !=3D DMA_COMPLETE) {
> +		} else if (status !=3D DMA_COMPLETE &&
> +			   !(dma_has_cap(DMA_COMPLETION_NO_ORDER,
> +					 dev->cap_mask) &&
> +			     status =3D=3D DMA_OUT_OF_ORDER)) {
>  			result(status =3D=3D DMA_ERROR ?
>  			       "completion error status" :
>  			       "completion busy status", total_tests, src->off,
> @@ -999,6 +1002,12 @@ static int dmatest_add_channel(struct dmatest_inf=
o *info,
>  	dtc->chan =3D chan;
>  	INIT_LIST_HEAD(&dtc->threads);
> =20
> +	if (dma_has_cap(DMA_COMPLETION_NO_ORDER, dma_dev->cap_mask) &&
> +	    info->params.polled) {
> +		info->params.polled =3D false;
> +		pr_warn("DMA_COMPLETION_NO_ORDER, polled disabled\n");
> +	}
> +
>  	if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask)) {
>  		if (dmatest =3D=3D 0) {
>  			cnt =3D dmatest_add_threads(info, dtc, DMA_MEMCPY);
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index c64c1429d160..0c892cbd72e0 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -133,7 +133,7 @@ static enum dma_status idxd_dma_tx_status(struct dm=
a_chan *dma_chan,
>  					  dma_cookie_t cookie,
>  					  struct dma_tx_state *txstate)
>  {
> -	return dma_cookie_status(dma_chan, cookie, txstate);
> +	return DMA_OUT_OF_ORDER;
>  }
> =20
>  /*
> @@ -174,6 +174,7 @@ int idxd_register_dma_device(struct idxd_device *id=
xd)
>  	INIT_LIST_HEAD(&dma->channels);
>  	dma->dev =3D &idxd->pdev->dev;
> =20
> +	dma_cap_set(DMA_COMPLETION_NO_ORDER, dma->cap_mask);
>  	dma->device_release =3D idxd_dma_release;
> =20
>  	if (idxd->hw.opcap.bits[0] & IDXD_OPCAP_MEMMOVE) {
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 21065c04c4ac..1123f4d15bae 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -39,6 +39,7 @@ enum dma_status {
>  	DMA_IN_PROGRESS,
>  	DMA_PAUSED,
>  	DMA_ERROR,
> +	DMA_OUT_OF_ORDER,
>  };
> =20
>  /**
> @@ -61,6 +62,7 @@ enum dma_transaction_type {
>  	DMA_SLAVE,
>  	DMA_CYCLIC,
>  	DMA_INTERLEAVE,
> +	DMA_COMPLETION_NO_ORDER,
>  /* last transaction type for creation of the capabilities mask */
>  	DMA_TX_TYPE_END,
>  };
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

--------------7E48ADA229F68EF8F76D6F5B
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

--------------7E48ADA229F68EF8F76D6F5B--
