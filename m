Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C42A210A90
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 13:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgGALxV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 07:53:21 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45678 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbgGALxV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 07:53:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061BrCov108915;
        Wed, 1 Jul 2020 06:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593604392;
        bh=uoVs0xKRr+EGHIZ9Yms8yptYm1qeOYBru5wiZ5Cd0Fw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=j0jlJMyUVJibebHe50ClQPIRZ+vAdKZO77rFwdiyF50oaBF1WTzshiOERM5jxmUBJ
         6er6AuJvXau66tgvqD+x85MKvlZ9SlwTfrdQHlYHO+xebqj+esmr7jBE2K83VsHTcx
         eZpq9obda6M+Xc+sBr9STNZUWbXLPgbAEYczKHCM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061BrCpM034174;
        Wed, 1 Jul 2020 06:53:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 06:53:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 06:53:12 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061Br9Dx086455;
        Wed, 1 Jul 2020 06:53:10 -0500
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
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <7e334685-7d98-9896-ef5b-3a2dfeb100a9@ti.com>
Date:   Wed, 1 Jul 2020 14:54:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701103030.29684-5-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Grygorii,

On 01/07/2020 13.30, Grygorii Strashko wrote:
> Add new API k3_ringacc_request_rings_pair() to request pair of rings at=

> once, as in the most cases Rings are used with DMA channels, which need=
 to
> request pair of rings - one to feed DMA with descriptors (TX/RX FDQ) an=
d
> one to receive completions (RX/TX CQ). This will allow to simplify Ring=
acc
> API users.
>=20
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/soc/ti/k3-ringacc.c       | 24 ++++++++++++++++++++++++
>  include/linux/soc/ti/k3-ringacc.h |  4 ++++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index 8a8f31d59e24..4cf1150de88e 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -322,6 +322,30 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_=
ringacc *ringacc,
>  }
>  EXPORT_SYMBOL_GPL(k3_ringacc_request_ring);
> =20
> +int k3_ringacc_request_rings_pair(struct k3_ringacc *ringacc,
> +				  int fwd_id, int compl_id,
> +				  struct k3_ring **fwd_ring,
> +				  struct k3_ring **compl_ring)

Would you consider re-arranging the parameter list to:
int k3_ringacc_request_rings_pair(struct k3_ringacc *ringacc,
				  struct k3_ring **fwd_ring, int fwd_id,
				  struct k3_ring **compl_ring, int compl_id)

> +{
> +	int ret =3D 0;
> +
> +	if (!fwd_ring || !compl_ring)
> +		return -EINVAL;
> +
> +	*fwd_ring =3D k3_ringacc_request_ring(ringacc, fwd_id, 0);
> +	if (!(*fwd_ring))
> +		return -ENODEV;
> +
> +	*compl_ring =3D k3_ringacc_request_ring(ringacc, compl_id, 0);
> +	if (!(*compl_ring)) {
> +		k3_ringacc_ring_free(*fwd_ring);
> +		ret =3D -ENODEV;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(k3_ringacc_request_rings_pair);
> +
>  static void k3_ringacc_ring_reset_sci(struct k3_ring *ring)
>  {
>  	struct k3_ringacc *ringacc =3D ring->parent;
> diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k=
3-ringacc.h
> index 26f73df0a524..7ac115432fa1 100644
> --- a/include/linux/soc/ti/k3-ringacc.h
> +++ b/include/linux/soc/ti/k3-ringacc.h
> @@ -107,6 +107,10 @@ struct k3_ringacc *of_k3_ringacc_get_by_phandle(st=
ruct device_node *np,
>  struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
>  					int id, u32 flags);
> =20
> +int k3_ringacc_request_rings_pair(struct k3_ringacc *ringacc,
> +				  int fwd_id, int compl_id,
> +				  struct k3_ring **fwd_ring,
> +				  struct k3_ring **compl_ring);
>  /**
>   * k3_ringacc_ring_reset - ring reset
>   * @ring: pointer on Ring
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/=
Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

