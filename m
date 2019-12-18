Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEBA1243F5
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfLRKK3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Dec 2019 05:10:29 -0500
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:34428
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbfLRKK3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Dec 2019 05:10:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMJ11d3k2YatOaS8xX0wHCc/nPI1s8tP3U+pqJ6LvvZcj9A+W91n8TpCpOO3dRIYNlcd7RsD8uuSvcFfba//wNF21m/9MTxDVo+IMnRywIE/bG5ZgGwcxOymDmiyIBm3PPISNFZD/wZuxiGXrbzVGgCVOP337nrzA9EilHX17c5i2nNDnYMm0F2PhW0wWq9+LqrYquWLbxXeojGw5crm+U4XorPCYj+XordfKdwayYM6K8XrfLDCrtg7FfySeQIqSuUb98q599L2UUmS+gj4ZnX+H8C6zEZmCbEoAnAfoXsJ4exXBC6o7f7YPzWHfwZIhuVyTu+p89UIdIByhU4cuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlO6tPzGHutgEHq9ANCLqgjW6/BCZWu01/d1TTsqeRg=;
 b=CfIIBrtSORAkTLs2W94Dgj2oHzW7qpzUqCCcnqQZaUTQ3Ypx+U1HAE129fbjdA2NvyobmkHh5juZUvMkasIkI1KoQnw1ILIRLhLQzAyUuCEon3gAk7OYMba3hQzUG8+/7NlFVO1q16m3mYvSdL7/2o+jFVy9heT8NOOnNQ6O6xBbThW6YzAphdoGcPX9IgdsYzasaR2S0F17UheZ3ukCyFgnt8jhVqOIJZp2kRzqyCWIwNb3svKuQo+UrkQraFfuxnsKQevKTyR2cXEDvZv65QXVLWg5eu1q067pqgmn5Rc+838vz3by2bEeptyUjgr/QavGXo3U++fm5Wqra+f0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlO6tPzGHutgEHq9ANCLqgjW6/BCZWu01/d1TTsqeRg=;
 b=CvEJRo2OwN31lCr2XGz7UpySbA2Qcv3ydFTvgNfGU44Q+geZfq9dHkQUB0S5n6Zb3RhGEhqiWZiGG68CDMMDB9M/pmo4j1mnoGk5rA7UlVQXOWV1V7QFUOv6r4gAxKQvwXLJz3KvjRcwKuA+6gPxzTLaHCzkHAZmPtzHpGDUKyA=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6413.eurprd04.prod.outlook.com (20.179.232.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 10:09:43 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::100:f42b:82a1:68c2]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::100:f42b:82a1:68c2%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 10:09:43 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Green Wan <green.wan@sifive.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: RE: [PATCH 9/9] dmaengine: imx-sdma: Fix memory leak
Thread-Topic: [PATCH 9/9] dmaengine: imx-sdma: Fix memory leak
Thread-Index: AQHVs/8XyZFo/yD2Hk685C41UbL1Kae/m+3Q
Date:   Wed, 18 Dec 2019 10:09:43 +0000
Message-ID: <VE1PR04MB66380F203072F8B4765769D789530@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20191216105328.15198-1-s.hauer@pengutronix.de>
 <20191216105328.15198-10-s.hauer@pengutronix.de>
In-Reply-To: <20191216105328.15198-10-s.hauer@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b87c0c4-461f-4c77-3c4c-08d783a2671b
x-ms-traffictypediagnostic: VE1PR04MB6413:|VE1PR04MB6413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB641394D42C79F43D139794A289530@VE1PR04MB6413.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(199004)(189003)(186003)(66946007)(64756008)(66556008)(81166006)(66446008)(5660300002)(7696005)(81156014)(8676002)(8936002)(26005)(76116006)(6506007)(53546011)(66476007)(7416002)(4326008)(9686003)(55016002)(2906002)(478600001)(71200400001)(316002)(86362001)(54906003)(33656002)(52536014)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6413;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ebsvG/neSj50VlouS874t/vtPx2hw9dPC3t++vaNfG4b92oWjxlTpOSazNrYHue1MLi3cbOWSz3scRuPRo2XMAvBPb0EljH4yDPKIaBua6oDITZj32PuEenMlFRryp3BRXziZ665iJ+o7FU6ziQB33QXimEY27Og9W6C774TSKdjnEPxH8NcrsptchE7tiOqIAzHjR6OojryJjsbjyF21PeUTv24Homy7ggiYbKGwhpI34+I48TsQVhoHKkC6mPtO5kPCDxENsnXBA3iuxT7KwYXk9VhgiQpJ5hao2x/oucg8OrmKKAYjuMI0ac2zYHD7sCH6hDx8lGxK+ClXCGddtRuzWSPFSRJaZ6kmNeSZIwn+vqXXRPZN08f99hd3hMBZbSbvhV0LXdN3u8c7X6IdrmBVmg4a5MmJxS7y98aHLWLhjXVGcfiZCoAxXxF/3ZC
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b87c0c4-461f-4c77-3c4c-08d783a2671b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 10:09:43.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRbDfxIp6QqBjPKhl9E49MnNvwEvOEDHIr9yPAw9CB0ybyYUeuBXq+lrR/KRzRvWRMMWmclxUGGps+wsUBz5Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6413
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2019/16/12 18:53 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The current descriptor is not on any list of the virtual DMA channel.
> Once sdma_terminate_all() is called when a descriptor is currently in fli=
ght then
> this one is forgotten to be freed. We have to call
> vchan_terminate_vdesc() on this descriptor to re-add it to the lists.
> Now that we also free the currently running descriptor we can (and actual=
ly
> have to) remove the current descriptor from its list also for the cyclic =
case.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Thanks Sacha. Now it's better to document or comment somewhere to notice
vchan_terminate_vdesc() should be called in channel(cyclic) terminated unle=
ss
dma controller driver free all desc by itself after this patch set applied.
Reviewed-by: Robin Gong <yibin.gong@nxp.com>
Tested-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> 99dbfd9039cf..066b21a32232 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -760,12 +760,8 @@ static void sdma_start_desc(struct sdma_channel
> *sdmac)
>  		return;
>  	}
>  	sdmac->desc =3D desc =3D to_sdma_desc(&vd->tx);
> -	/*
> -	 * Do not delete the node in desc_issued list in cyclic mode, otherwise
> -	 * the desc allocated will never be freed in vchan_dma_desc_free_list
> -	 */
> -	if (!(sdmac->flags & IMX_DMA_SG_LOOP))
> -		list_del(&vd->node);
> +
> +	list_del(&vd->node);
>=20
>  	sdma->channel_control[channel].base_bd_ptr =3D desc->bd_phys;
>  	sdma->channel_control[channel].current_bd_ptr =3D desc->bd_phys; @@
> -1071,7 +1067,6 @@ static void sdma_channel_terminate_work(struct
> work_struct *work)
>=20
>  	spin_lock_irqsave(&sdmac->vc.lock, flags);
>  	vchan_get_all_descriptors(&sdmac->vc, &head);
> -	sdmac->desc =3D NULL;
>  	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
>  	vchan_dma_desc_free_list(&sdmac->vc, &head);
>  	sdmac->context_loaded =3D false;
> @@ -1080,11 +1075,19 @@ static void sdma_channel_terminate_work(struct
> work_struct *work)  static int sdma_terminate_all(struct dma_chan *chan) =
 {
>  	struct sdma_channel *sdmac =3D to_sdma_chan(chan);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sdmac->vc.lock, flags);
>=20
>  	sdma_disable_channel(chan);
>=20
> -	if (sdmac->desc)
> +	if (sdmac->desc) {
> +		vchan_terminate_vdesc(&sdmac->desc->vd);
> +		sdmac->desc =3D NULL;
>  		schedule_work(&sdmac->terminate_worker);
> +	}
> +
> +	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
>=20
>  	return 0;
>  }
> --
> 2.24.0

