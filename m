Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB1125787C
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgHaLac (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 07:30:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55038 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgHaL3l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 07:29:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07VBTJcD015316;
        Mon, 31 Aug 2020 06:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598873359;
        bh=pBxOxoVcwH4Btp/suFr+N7QvOsXbt61+DBoaWxdHKRU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jXL6FMkZkpwLoFjiRG9GpQB/BMWCQbmqTUi5dFHyCCOhGDMPD6RW1TQKYWe4269OK
         q8BFMxCkbPMDXm/91dWg10P/SWrsmsPNhGUaSqGkaFvGShSXBB4AA/qwzOlDpr5+1I
         YwM8jqLe9Ky5lMcnWLgbqcyVQVfgsOkNowD9XtxQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07VBTJ3V116399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 06:29:19 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 31
 Aug 2020 06:29:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 31 Aug 2020 06:29:19 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07VBTEox056410;
        Mon, 31 Aug 2020 06:29:15 -0500
Subject: Re: [PATCH v3 30/35] dmaengine: virt-dma: convert tasklets to use new
 tasklet_setup() API
To:     Allen Pais <allen.lkml@gmail.com>, <vkoul@kernel.org>
CC:     <linus.walleij@linaro.org>, <vireshk@kernel.org>,
        <leoyang.li@nxp.com>, <zw@zh-kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <sean.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <logang@deltatee.com>,
        <agross@kernel.org>, <jorn.andersson@linaro.org>,
        <green.wan@sifive.com>, <baohua@kernel.org>, <mripard@kernel.org>,
        <wens@csie.org>, <dmaengine@vger.kernel.org>,
        Romain Perier <romain.perier@gmail.com>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
 <20200831103542.305571-31-allen.lkml@gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <84ceeee1-bd19-b2a7-f969-fb96c10a1297@ti.com>
Date:   Mon, 31 Aug 2020 14:30:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831103542.305571-31-allen.lkml@gmail.com>
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

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/dma/virt-dma.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
> index 23e33a85f033..a6f4265be0c9 100644
> --- a/drivers/dma/virt-dma.c
> +++ b/drivers/dma/virt-dma.c
> @@ -80,9 +80,9 @@ EXPORT_SYMBOL_GPL(vchan_find_desc);
>   * This tasklet handles the completion of a DMA descriptor by
>   * calling its callback and freeing it.
>   */
> -static void vchan_complete(unsigned long arg)
> +static void vchan_complete(struct tasklet_struct *t)
>  {
> -	struct virt_dma_chan *vc =3D (struct virt_dma_chan *)arg;
> +	struct virt_dma_chan *vc =3D from_tasklet(vc, t, task);
>  	struct virt_dma_desc *vd, *_vd;
>  	struct dmaengine_desc_callback cb;
>  	LIST_HEAD(head);
> @@ -131,7 +131,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dm=
a_device *dmadev)
>  	INIT_LIST_HEAD(&vc->desc_completed);
>  	INIT_LIST_HEAD(&vc->desc_terminated);
> =20
> -	tasklet_init(&vc->task, vchan_complete, (unsigned long)vc);
> +	tasklet_setup(&vc->task, vchan_complete);
> =20
>  	vc->chan.device =3D dmadev;
>  	list_add_tail(&vc->chan.device_node, &dmadev->channels);
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

