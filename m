Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B6E77A0C4
	for <lists+dmaengine@lfdr.de>; Sat, 12 Aug 2023 17:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHLP1W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 12 Aug 2023 11:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLP1W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 12 Aug 2023 11:27:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F71708;
        Sat, 12 Aug 2023 08:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyfHHCIekq4dQ+vuizl6SfYYBRD9qt0IuEb6bu3BRbB4F82kUVNndDRV+Ux6l+vzH/b1J9qOQFT6R4WNNVJKbzzi6sg+Tbgqd0U2xMvf4UK5xY6RhZHKJjWGtBwPa8zD+YuRN1ZTK4Xru0n8l6mVgdhlzKOiWUBGVaTLGXHN0qt/FR1cSwPWb0jlTl7EcW5kbvV+9jOhuOO+G48+MU1MuD4uY/CbKqj4NqaFx9NkSHPl6kLd9iSwWlVOzdfEa1RxPc5LthrzxN+jeJytVbAfm0u/rWPZ64aERxKXr2+FcgXV9f1EPEWOZ6OvTEb+Jfw7XZ6xGF5laVLw9w7XVMK+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sc5wGnicBcejzCRxmakCir7uF1xHbdfMm2Jkg2V26xM=;
 b=XN9qYp+3yc01/DKnmPwyLyn5wTfSRsZEPEdOy4O0ZM2hNwcHE9naOQtavNDeO5TKZwwDjcYBV3MFtXqcwhChaPO2VFhbowjWw7UxozKfivUTsbWKwEfCkS4ED4M3l+iug9QNA85wQ7Gu7Fjy9YAtDMJEnmfIQphvBQFQMAlzfZnoXfRWlTiH4Bd0JBYCrqZyt9NZYawYdVzXiDKQIzyTS8ddwoeS79T4wvxXjDe9O8dCmNxvxYqAA393cJTukN/jZC8MfOBkHaYyt+XYE+vL2twgakqCfgFdMQDCD6k+HZjdzmpN+D6kJAukYujxaqGirzOyR67q7t62Kz2SUB8z1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc5wGnicBcejzCRxmakCir7uF1xHbdfMm2Jkg2V26xM=;
 b=xfi1y5B1R0a+9H4T4IsqxSOSjSrNehO2E0nE7sb/1t+nVSdSETi3WW7513Le9wJy5EtVzTZEW5UaFOmf84vS6crzgXB0SZ8wPg1c6uQjK6XXvJCujzAHbSrCZBAX5SQH6aU5Zp9GxB/hqYKFMGnIBzHtZfl16DlRn/OGyPgZFeA=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SJ0PR12MB5470.namprd12.prod.outlook.com (2603:10b6:a03:3bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Sat, 12 Aug
 2023 15:27:20 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c%7]) with mapi id 15.20.6678.022; Sat, 12 Aug 2023
 15:27:19 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH net-next v5 10/10] net: axienet: Introduce dmaengine
 support
Thread-Topic: [PATCH net-next v5 10/10] net: axienet: Introduce dmaengine
 support
Thread-Index: AQHZyPOqeZCnkJC6tUWnKK5vO3ejB6/hAxuAgAXJTuA=
Date:   Sat, 12 Aug 2023 15:27:19 +0000
Message-ID: <MN0PR12MB5953A9FEC556D07494DB8E37B711A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
        <1691387509-2113129-11-git-send-email-radhey.shyam.pandey@amd.com>
 <20230808154853.0fafa7fc@kernel.org>
In-Reply-To: <20230808154853.0fafa7fc@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SJ0PR12MB5470:EE_
x-ms-office365-filtering-correlation-id: d2cebc22-59c5-4e95-a450-08db9b489e18
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JYjIf+ImyGunCEsJFRHxl8RaICSqEa3d6LnyrbShSSBgeFzuyDunVzGE1BkMWcpHRaffB4HtwYBg/Zr716QM5MCdU1evWyYEgLG/1GyvIc8t+XnX2lvZRuuO9YCHOHbqBvszr+Raf06/eAruoF2HW0GCkuKSH+H6MBpZcTOeQ7m/4NKObOsRVFdqV9Kkw+uhXGDfwvNnWLoSV8ai3K666eKMBedBQ6MKfJVF5FHfs0cOc9JnwrFZLmIVlHLCxHYazOT+ZpBR9YBDtsDJrPx9Zh86dH3x52beNt1ytBz1AE5uK8XgBb9nOp2RwWJxr8VckvC+ih8NglgXrJYUU8rHiH0pe87u3TCQ2qoxDB5caM3n47G+VQJIWIXS9ZAZDWrKeNudpRUXaHkjOUBXGVRBFqgBWydR/5N/e5PlUaiF5YVlKmZy3st6QC0yS++5lSX/A1vUyl9EgieNmUKO9WmxL25mw91efyGonbmSw+alEWGxSIg8jFhCjNRz2COqpqAKPuQWHGGpWA9iCwy/AsLmsXLz+dHceSJ5oxz4Rrl37MuBfrpNyKJRraxnefYroxUXa4uJNjYTOfKzR3BgqXjTJpUJVg8LmUunjNy4IAMZR6mwmkPuiU22N43a/ASn+HKr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(39860400002)(346002)(376002)(186006)(1800799006)(451199021)(66899021)(9686003)(53546011)(6506007)(7696005)(71200400001)(33656002)(38070700005)(86362001)(38100700002)(122000001)(55016003)(83380400001)(2906002)(478600001)(5660300002)(52536014)(66946007)(76116006)(8936002)(8676002)(4326008)(66476007)(6916009)(7416002)(54906003)(64756008)(41300700001)(66556008)(66446008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9YMFyvzsbrck+ycO2aaUtoRP+zMW+7uK/gw1IfgjHy6hMPqgJb8Vqr+D1HL+?=
 =?us-ascii?Q?/FMjKgxvV65xbo8JLM1+9pHS1K15dRqUcVVQRufiWVogjhGpc8lYGfWG2IEE?=
 =?us-ascii?Q?YE0KyL/SX8gc0C+OsQvTXJaRKsKPZ5IbpEBKhN3AcUJgKkP+7WlikH+JhH//?=
 =?us-ascii?Q?/a0dSGOYhCQhngKtrC6HhPIalm6PBLyvAmt4eFfbjA0MHwRwgn2/NMFfoBhz?=
 =?us-ascii?Q?FCKVlM/QDJyrQtiro8rj5Wi9Y7Oh70pUdM5uuJGtvHrepmIGBGFhOGW+y+df?=
 =?us-ascii?Q?6tGOq2gYPx9Gn8PZv50V0YGjYfFSoiiM2P0m1lWxh8u01Uin0rSYBhh/vTe0?=
 =?us-ascii?Q?TZHDW7CQXUHeceh83SobUNQGVKAVSRT738al5SHTN/shh8ES6ZLhZ+AjO/ar?=
 =?us-ascii?Q?5lM0qBK45qtxFgb5nCPbx9Fela3bZij6SjTeK/+K8Z0+7wegmn7nP1B13OKc?=
 =?us-ascii?Q?G0V2dWOgPuz9EmyBQlVEBe20EPEWB10rDMbMYdRceAg4iWTmYV9XeTbuWpv3?=
 =?us-ascii?Q?Gf0XjwYQrAmnTab0sAMRlRCkfZvuo8Fy5acfjl2XXKmiBz/vRplD8rGetA0w?=
 =?us-ascii?Q?rvOuGcXA3H4hNwDY9n+htDA+B10o4DwMdhTrlHYuWLNikP+04rAqyB8tWEWm?=
 =?us-ascii?Q?Hoj+SpszmLtrLd6SW8NGbFy2vGFa9itG9XwL5ngWw+qTUPi+EmPrM9FdCBjk?=
 =?us-ascii?Q?NenAVKVN5+uQZdnwj6Lw543dSb9eHai4BB+yCxPqS94n1zsRBlTmipvlfECY?=
 =?us-ascii?Q?mUH6J+s4po+EWzVb7z2NdMW6GulRMKmi3A3oV7Av1kn7r5UGk84FJ8E4SxFs?=
 =?us-ascii?Q?SVDg1Vxz8JsL3yc20dRu1Hpzf5o6W1Fi9U2LL6rqBbYdQ9YGRAykM3PdYpas?=
 =?us-ascii?Q?d3q/TWnuGl+8uo5nsBuJZFHLhHsYxKddE+B8ZK33JYjLjwduPbIUjo8zhfRI?=
 =?us-ascii?Q?WKuvVtW5TD7TkMMSEmMPrr84aVvn8nCZYAql8Fah9jHrEsabEZ9Z7WID9bE9?=
 =?us-ascii?Q?wLqGC1zuhgvO+eCB27E2L9OFR94Ybq+qf8Aki6rD6RP+wWM6D4pDaLPkuVLP?=
 =?us-ascii?Q?mqBMLbDwj+bbYoGVtkB/6BuWes/tOUAjBIdzxavqEnYgQUc6Fc4bCpIvc9RZ?=
 =?us-ascii?Q?3mMYU4YOcnUnqDR+XvBeSopwXkg0yv3AQXAbxSQlBRQQNDDC5Z0lgD805r1B?=
 =?us-ascii?Q?7gnuw68nweHU8XvDA6QsLdxJSrI8xAeeFt9fef/F625qgWoeUALFlmDnywKm?=
 =?us-ascii?Q?wLiIACGu7szTsTWhjT9hqGLAjOK6/PUSXGUdd3WoUGeFTBQxgyjPls8B4/Jq?=
 =?us-ascii?Q?kbKA0AAFRIL3Y95Y42LRdArUaRJp9+HPnDh5NR+KiB0/qkBK18azJOxoJO22?=
 =?us-ascii?Q?bl1LG6EE8hcWumsS8VQnIFYP/SNvqPASyYThi80EOSeYXPfU26BczRIIOFj1?=
 =?us-ascii?Q?RIyy+J5twIVJmbqypZsyWTQJL4pMgbFjJb8Rocw3UOjcS+tMiSECQvBsd4vR?=
 =?us-ascii?Q?Z7NiZ4jcbm2JpjcnkR+syh5CxucCkWndAvFroxZJjRxg94vkNvWPzZKCkA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cebc22-59c5-4e95-a450-08db9b489e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 15:27:19.4872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8+EMhuOchqS7NR/A7wYv1ZVqoi0qxBtQZjYIvmxourjBIpSI3J6wzBR0Gp6lZHF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5470
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, August 9, 2023 4:19 AM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: vkoul@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; linux@armlinux.org.uk; dmaengine@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; git (AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [PATCH net-next v5 10/10] net: axienet: Introduce dmaengine
> support
>=20
> On Mon, 7 Aug 2023 11:21:49 +0530 Radhey Shyam Pandey wrote:
> > +struct axi_skbuff {
> > +	struct scatterlist sgl[MAX_SKB_FRAGS + 1];
> > +	struct dma_async_tx_descriptor *desc;
> > +	dma_addr_t dma_address;
> > +	struct sk_buff *skb;
> > +	struct list_head lh;
> > +	int sg_len;
> > +} __packed;
>=20
> Why __packed?

It was added considering size optimization, but I see it may have=20
performance overheads. Will remove it in next version.

>=20
> > +static netdev_tx_t
> > +axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device
> > +*ndev) {
> > +	struct dma_async_tx_descriptor *dma_tx_desc =3D NULL;
> > +	struct axienet_local *lp =3D netdev_priv(ndev);
> > +	u32 app[DMA_NUM_APP_WORDS] =3D {0};
> > +	struct axi_skbuff *axi_skb;
> > +	u32 csum_start_off;
> > +	u32 csum_index_off;
> > +	int sg_len;
> > +	int ret;
> > +
> > +	sg_len =3D skb_shinfo(skb)->nr_frags + 1;
> > +	axi_skb =3D kmem_cache_zalloc(lp->skb_cache, GFP_KERNEL);
> > +	if (!axi_skb)
> > +		return NETDEV_TX_BUSY;
>=20
> Drop on error, you're not stopping the queue correctly, just drop, return=
 OK
> and avoid bugs.

As I understand NETDEV_TX_OK returns means driver took care of packet.
So inline with non-dmaengine xmit (axienet_start_xmit_legacy) should
we stop the queue and return TX_BUSY?

>=20
> > +static inline int axienet_init_dmaengine(struct net_device *ndev)
>=20
> Why inline? Please remove the spurious inline annotations.

Ok will fix it in next version

>=20
> > +{
> > +	struct axienet_local *lp =3D netdev_priv(ndev);
> > +	int i, ret;
> > +
> > +	lp->tx_chan =3D dma_request_chan(lp->dev, "tx_chan0");
> > +	if (IS_ERR(lp->tx_chan)) {
> > +		ret =3D PTR_ERR(lp->tx_chan);
> > +		return dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX)
> channel found\n");
> > +	}
> > +
> > +	lp->rx_chan =3D dma_request_chan(lp->dev, "rx_chan0");
> > +	if (IS_ERR(lp->rx_chan)) {
> > +		ret =3D PTR_ERR(lp->rx_chan);
> > +		dev_err_probe(lp->dev, ret, "No Ethernet DMA (RX) channel
> found\n");
> > +		goto err_dma_request_rx;
>=20
> name labels after the target, not the source. Makes it a ton easier to
> maintain sanity when changing the code later.

Ok will rename it to target i.e goto err_dma_free_tx and fix other as well.

>=20
> > +	}
> > +
> > +	lp->skb_cache =3D kmem_cache_create("ethernet", sizeof(struct
> axi_skbuff),
> > +					  0, 0, NULL);
>=20
> Why create a cache ?
> Isn't it cleaner to create a fake ring buffer of sgl? Most packets will n=
ot have
> MAX_SKB_FRAGS of memory. On a ring buffer you can use only as many sg
> entries as the packet requires. Also no need to alloc/free.


The kmem_cache is used with intent to use slab cache interface and
make use of reusing objects in the kernel. slab cache maintains a=20
cache of objects. When we free an object, instead of
deallocating it, it give it back to the cache. Next time, if we
want to create a new object, slab cache gives us one object from the
slab cache.

If we maintain custom circular buffer (struct circ_buf) ring buffer=20
we have to create two such ring buffers one for TX and other for RX.
For multichannel this will multiply to * no of queues. Also we have to
ensure proper occupancy checks and head/tail pointer updates.

With kmem_cache pool we are offloading queue maintenance ops to
framework with a benefit of optimized alloc/dealloc. Let me know if it=20
looks functionally fine and can retain it for this baseline dmaengine=20
support version?

>=20
> > +	if (!lp->skb_cache) {
> > +		ret =3D  -ENOMEM;
>=20
> double space, please fix everywhere

Will fix it in next version.

>=20
> > +		goto err_kmem;
>=20
> > @@ -2140,6 +2432,31 @@ static int axienet_probe(struct platform_device
> *pdev)
> >  		}
> >  		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
> >  		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
> > +	} else {
> > +		struct xilinx_vdma_config cfg;
> > +		struct dma_chan *tx_chan;
> > +
> > +		lp->eth_irq =3D platform_get_irq_optional(pdev, 0);
>=20
> This can't fail?

I will add check for lp->eth_irq !=3D -ENXIO and add its error handling.
>=20
> > +		tx_chan =3D dma_request_chan(lp->dev, "tx_chan0");
> > +
> > +		if (IS_ERR(tx_chan)) {
>=20
> no empty lines between call and its error check, please fix thru out

Ok will fix and cross-check for all other references.
>=20
> > +			ret =3D PTR_ERR(tx_chan);
> > +			dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX)
> channel found\n");
> > +			goto cleanup_clk;
> > +		}
> --
> pw-bot: cr
