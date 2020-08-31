Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B339225786F
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 13:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgHaL3l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 07:29:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54938 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgHaL3K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 07:29:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07VBSiWU015203;
        Mon, 31 Aug 2020 06:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598873324;
        bh=3yIBUmZEpUsrzIVAOjTjKYK0DrTiK7qpTQHTkneU90w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=p9qE0IhH1F5gHv0Bta7HtCPiLjdgtOZ2YFvSCt9UdCPqQN1gQfIXRs73tNqzp+zrr
         2vsdeLF3QiRB4ZLK4IxBsnJueaS2aI6HcmV6oWBvIddZ+Ysd0IPUreMOQ5fnQmxnq0
         CwoT74B20nzXZZXba4Cm33h/sHpmcgGQJF0DL/Hw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07VBSdN9078134
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 06:28:39 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 31
 Aug 2020 06:28:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 31 Aug 2020 06:28:38 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07VBSYbZ002855;
        Mon, 31 Aug 2020 06:28:35 -0500
Subject: Re: [PATCH v3 35/35] dmaengine: k3-udma: convert tasklets to use new
 tasklet_setup() API
To:     Allen Pais <allen.lkml@gmail.com>, <vkoul@kernel.org>
CC:     <linus.walleij@linaro.org>, <vireshk@kernel.org>,
        <leoyang.li@nxp.com>, <zw@zh-kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <sean.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <logang@deltatee.com>,
        <agross@kernel.org>, <jorn.andersson@linaro.org>,
        <green.wan@sifive.com>, <baohua@kernel.org>, <mripard@kernel.org>,
        <wens@csie.org>, <dmaengine@vger.kernel.org>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
 <20200831103542.305571-36-allen.lkml@gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <9fa4a529-3a70-6a74-0fcd-57a2fc61b028@ti.com>
Date:   Mon, 31 Aug 2020 14:30:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831103542.305571-36-allen.lkml@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 31/08/2020 13.35, Allen Pais wrote:
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

