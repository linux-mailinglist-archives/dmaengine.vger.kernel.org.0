Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B0F26BF6C
	for <lists+dmaengine@lfdr.de>; Wed, 16 Sep 2020 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgIPIfw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Sep 2020 04:35:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44344 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgIPIfv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Sep 2020 04:35:51 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08G8Znpf093841;
        Wed, 16 Sep 2020 03:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600245349;
        bh=IJyXH9+BhG9uPYs6VuSOzVhQhTpmZ2S2LrLmpLkb5gk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=a+baDbpDfPWApiH56aPqKIe5xF3V/GoMzPyDYgRIyVLysDYxSYn05qIOtaLtmqCbW
         aKbFqseIxbo0QkEcoypQOXuqyX/Kqu0NWKYVD1jIg0o0+/tSF6U91m7GlNu4bi8yOn
         HhMx7cztT7sTRtMz/92b0rb8/F4oghvm+b27iCxY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08G8ZmQI093308
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 03:35:48 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 03:35:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 03:35:48 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08G8ZksU080979;
        Wed, 16 Sep 2020 03:35:47 -0500
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: fix channel enable functions
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20200915164149.22123-1-grygorii.strashko@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <46ea0401-e4f7-5b08-c780-b6cd7d1af5e9@ti.com>
Date:   Wed, 16 Sep 2020 11:35:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915164149.22123-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 15/09/2020 19.41, Grygorii Strashko wrote:
> Now the K3 UDMA glue layer enable functions perform RMW operation on UD=
MA
> RX/TX RT_CTL registers to set EN bit and enable channel, which is
> incorrect, because only EN bit has to be set in those registers to enab=
le
> channel (all other bits should be cleared 0).
> More over, this causes issues when bootloader leaves UDMA channel RX/TX=

> RT_CTL registers in incorrect state - TDOWN bit set, for example. As
> result, UDMA channel will just perform teardown right after it's enable=
d.
>=20
> Hence, fix it by writing correct values (EN=3D1) directly in UDMA chann=
el
> RX/TX RT_CTL registers in k3_udma_glue_enable_tx/rx_chn() functions.

This is how the DMAengine driver deals with the enable.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DM=
Aengine users")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/dma/ti/k3-udma-glue.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glu=
e.c
> index dc03880f021a..37d706cf3ba9 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -370,7 +370,6 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_pop_tx_chn);
> =20
>  int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)=

>  {
> -	u32 txrt_ctl;
>  	int ret;
> =20
>  	ret =3D xudma_navss_psil_pair(tx_chn->common.udmax,
> @@ -383,15 +382,11 @@ int k3_udma_glue_enable_tx_chn(struct k3_udma_glu=
e_tx_channel *tx_chn)
> =20
>  	tx_chn->psil_paired =3D true;
> =20
> -	txrt_ctl =3D UDMA_PEER_RT_EN_ENABLE;
>  	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,=

> -			    txrt_ctl);
> +			    UDMA_PEER_RT_EN_ENABLE);
> =20
> -	txrt_ctl =3D xudma_tchanrt_read(tx_chn->udma_tchanx,
> -				      UDMA_CHAN_RT_CTL_REG);
> -	txrt_ctl |=3D UDMA_CHAN_RT_CTL_EN;
>  	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
> -			    txrt_ctl);
> +			    UDMA_CHAN_RT_CTL_EN);
> =20
>  	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn en");
>  	return 0;
> @@ -1059,7 +1054,6 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_rx_flow_disable);
> =20
>  int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)=

>  {
> -	u32 rxrt_ctl;
>  	int ret;
> =20
>  	if (rx_chn->remote)
> @@ -1078,11 +1072,8 @@ int k3_udma_glue_enable_rx_chn(struct k3_udma_gl=
ue_rx_channel *rx_chn)
> =20
>  	rx_chn->psil_paired =3D true;
> =20
> -	rxrt_ctl =3D xudma_rchanrt_read(rx_chn->udma_rchanx,
> -				      UDMA_CHAN_RT_CTL_REG);
> -	rxrt_ctl |=3D UDMA_CHAN_RT_CTL_EN;
>  	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
> -			    rxrt_ctl);
> +			    UDMA_CHAN_RT_CTL_EN);
> =20
>  	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,=

>  			    UDMA_PEER_RT_EN_ENABLE);
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

