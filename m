Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEE42482DC
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 12:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgHRKX3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 06:23:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57504 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRKX3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 06:23:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07IANF5g118045;
        Tue, 18 Aug 2020 05:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597746195;
        bh=FUWhHboZZuWmjWhQJksLmLFzMVPHa+vMd0FTYbNVw+w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oH9b+EKQBgt8lV+tmLGer/vk5OUAKHoTOxex9bMp6MOiOQ5hb8RQLDtiUy+ompyYT
         lT/sp7QMMW0pOtt/Usb0lYckzGhQXZ9D+8RxjpO5hjTqKn/WL3RAvjG7Xj4SVuWAiz
         UXI18wQpvX97oZkaPavYlzu32tu0DsMlOcMWBQhQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07IANFuj073622
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 05:23:15 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 18
 Aug 2020 05:23:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 18 Aug 2020 05:23:15 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07IANCBm051072;
        Tue, 18 Aug 2020 05:23:12 -0500
Subject: Re: [PATCH 35/35] dma: k3-udma: convert tasklets to use new
 tasklet_setup() API
To:     Allen Pais <allen.lkml@gmail.com>, <vkoul@kernel.org>,
        <linus.walleij@linaro.org>, <vireshk@kernel.org>,
        <leoyang.li@nxp.com>, <zw@zh-kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <matthias.bgg@gmail.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <baohua@kernel.org>, <wens@csie.org>
CC:     <dmaengine@vger.kernel.org>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
 <20200818090638.26362-36-allen.lkml@gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <2dedd6a2-7a75-4001-57c5-17cde4d998d3@ti.com>
Date:   Tue, 18 Aug 2020 13:24:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818090638.26362-36-allen.lkml@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Allen,

On 18/08/2020 12.06, Allen Pais wrote:
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/dma/ti/k3-udma.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index c14e6cb105cd..59cd8770334c 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -2914,9 +2914,9 @@ static void udma_desc_pre_callback(struct virt_dm=
a_chan *vc,
>   * This tasklet handles the completion of a DMA descriptor by
>   * calling its callback and freeing it.
>   */
> -static void udma_vchan_complete(unsigned long arg)
> +static void udma_vchan_complete(struct tasklet_struct *t)
>  {
> -	struct virt_dma_chan *vc =3D (struct virt_dma_chan *)arg;
> +	struct virt_dma_chan *vc =3D from_tasklet(vc, t, task);
>  	struct virt_dma_desc *vd, *_vd;
>  	struct dmaengine_desc_callback cb;
>  	LIST_HEAD(head);
> @@ -3649,8 +3649,7 @@ static int udma_probe(struct platform_device *pde=
v)
> =20
>  		vchan_init(&uc->vc, &ud->ddev);
>  		/* Use custom vchan completion handling */
> -		tasklet_init(&uc->vc.task, udma_vchan_complete,
> -			     (unsigned long)&uc->vc);
> +		tasklet_setup(&uc->vc.task, udma_vchan_complete);
>  		init_completion(&uc->teardown_completed);
>  		INIT_DELAYED_WORK(&uc->tx_drain.work, udma_check_tx_completion);
>  	}
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

