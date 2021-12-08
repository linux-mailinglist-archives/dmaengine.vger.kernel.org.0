Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3087046D346
	for <lists+dmaengine@lfdr.de>; Wed,  8 Dec 2021 13:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhLHMcj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Dec 2021 07:32:39 -0500
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:9127
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233308AbhLHMch (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Dec 2021 07:32:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnfsnwBEtM4BC/UjC4+DkE3hOhAytw9Ea4mPiPNHofIHB+zNi8H6EKHr3pf8p/515Rt2lxlP8/SnJSccj6gNwl2U7IIKp/69dWOu/p3WIhDSvosEfaqI1fJuDWAI87Y1pGXFTOP0yn7KWSiUS0j1FoDiCQ14XjRAzKfbnpkhOvos5ltreFrTtgm860MfFjY4cqIuIfi2pd4S5v1VPKIDnZACv7Ie5B+pSYDPd7lQmcNFmO5pik1W0NTEC3qSUJw2StYwh2NkB6ceMzNoGKJULbsicpmUeIY7yBfEmNWxoSY9YHspIAYdWEFfWMdfhTjAhqB+kLxRnNWPQCrl9jC0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NbPUvZaYHCXy1dBKHTpXT0ZtSqPsrkI07K6kT5xgMw=;
 b=DPJ0uECg99ekDbwgHexvt4wJdpseZZTZ6R8Gsl+0SkDlF2xoIQbKz9rPw2GQmV9BFadM1zyyomJHJDukf49z8Z038l9M7g6UagQxXLIbpzpuaveo1xmTuRm3TfRUSp+PJAzGK0u3xR98+/JQSR76DxrXFhUw4Ab6rfOLmJyxZpPvLbp58id9QkB4bjc74Yd6lwr2r4v9FRBsT92wfJ6R80jZLZXNRYxgk+K16E6Jkq3ulnME8TJz+NhOyWBv8VzBB5TfFzEkH/4LieqyvzFWXpqfYHz6MBXJetgZ7P2WJNie5P0wWWFrB+uH1/RSI6GaaRdEcNv/a8/WlE+yuTRfKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NbPUvZaYHCXy1dBKHTpXT0ZtSqPsrkI07K6kT5xgMw=;
 b=Sc3G0MBbAhJZL3OQbeNBzz9ayIboqlf1ofpgJB6upmB6n/bwWn+rwkt4w/fJ3sqQ4n2QANvA480q7TY4ToMBFDfzHFGNy/XosfzVOzjZAt0umdN+XzuGuy2BYFckD/Gh/5OWLn7SXDbNThIApOL85p8ILJdJcBvqHGkE8CUH/iw=
Received: from SA1PR02MB8560.namprd02.prod.outlook.com (2603:10b6:806:1fb::24)
 by SN4PR0201MB3424.namprd02.prod.outlook.com (2603:10b6:803:51::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 12:29:03 +0000
Received: from SA1PR02MB8560.namprd02.prod.outlook.com
 ([fe80::b9c2:c09a:cf61:2389]) by SA1PR02MB8560.namprd02.prod.outlook.com
 ([fe80::b9c2:c09a:cf61:2389%6]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 12:29:02 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
CC:     Michal Simek <michals@xilinx.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: xilinx: Handle IRQ mapping errors
Thread-Topic: [PATCH] dmaengine: xilinx: Handle IRQ mapping errors
Thread-Index: AQHX7CioyqFXcQ4vC0uyXU8RCP1+9qwoe8+g
Date:   Wed, 8 Dec 2021 12:29:02 +0000
Message-ID: <SA1PR02MB85604F1C613CC2312C52D627C76F9@SA1PR02MB8560.namprd02.prod.outlook.com>
References: <20211208114212.234130-1-lars@metafoo.de>
In-Reply-To: <20211208114212.234130-1-lars@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9ecc7e8-4744-4612-4549-08d9ba46519a
x-ms-traffictypediagnostic: SN4PR0201MB3424:EE_
x-microsoft-antispam-prvs: <SN4PR0201MB342487CD23CED6114D960AEDC76F9@SN4PR0201MB3424.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nkpJrCU8KZidEcDOQkpKWZAOtq0UfmQ9YPDljv6zyz0KtJe2o3EXIqRqvMaqABJqWMv/eA9SZQ9nEbYwg2RjW5SYIwubTFI3hT2FowjXQuGPmOvPdgakp4rxDftZrBwbnQiwMblSbmE9YD/mNsmT013GWurnvESXrCmefVoHlYb032ZK0ToV0ZJ5+RlgBU20bOIeVL8vIu7Anxk/tOke6mmoI6Rgsb9MEdXWdelMsmWXZypoLDGGpAyogLdXFTe8W7kTfz447gqaHgfSDRrx0kKpfk4m9Duw93QyxIeAtRlgnycl0a2igK0EBkOrq3glj7yGG/TKXW1V0U921rUkuzBAVBDV5wqWZ2DGAkP5ocI9xXF0mzncwRvC6AUX6VAboWsMKNDuu+kE9CyxF+dwekVWxEhM5qMYA1GWextsFhpmU2PrnaVYTHtSIRTa8C27glBUpxxjk4LhVn3cWfav9BNTp773IOTgBZ2DdHIRVsZYeTKEcwCpoNWo0jW8Ip7t1yd0/Sl9ZmeEq8iFLUUc/2bZXb2NYsZNZI3ydG3tAUDoyPLlVZTeniWoC7FwS7xB2vptOHS2dI1OUMR01T4jghFUYQAfe53eqYIOKVt+PXBHjjPtKi8K1/FX0AahBb89Nk1qCNKs7q4Lre/p9DV+J0eRtvVEhE6UDLp04Px6YTQhzSEk4GBvArog+k9epjHrKYnqJeynB+Kdn0FvM5JMmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR02MB8560.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(316002)(86362001)(6506007)(53546011)(71200400001)(122000001)(8936002)(26005)(8676002)(66556008)(64756008)(186003)(76116006)(66446008)(66476007)(66946007)(5660300002)(2906002)(52536014)(83380400001)(33656002)(7696005)(38070700005)(110136005)(54906003)(508600001)(9686003)(55016003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pxETw2UW5BwQsQ8YkVaQwtXH4Kxsx7QapL//TCzbfHgWt47ROfZhSpnkpiuM?=
 =?us-ascii?Q?DpWpsbnexgr9k2jyqw87GP9d0AmyOg81t7ppjEIKU8DhIdf9eIGns/6eikiK?=
 =?us-ascii?Q?Hx5CdlWuq4ivx/tilz3SM8aaImrs1EWtfHhE4DI02FZQivBzNJP0gmjd1kEP?=
 =?us-ascii?Q?SC5WsyMEnKKgr+pvk0wW95yxRwFe+f3641s/gMLy4NmX+yW44zepjBF6Hbz3?=
 =?us-ascii?Q?85XHw1y0qP+Yl4GJX1uzTjHmvcjio5DUzitBxBjt8TO4VekCnJ7A7bZTw6U6?=
 =?us-ascii?Q?VxTJ6uKziuu1Wa8kDPZMtK3MXVjBcmkEXyODvPxPvpgbxO/JuUXu1aHt+Kud?=
 =?us-ascii?Q?3nKovopJ7tJ7HWsLKNaieyLPzM1ioHwvZYYwVmMOCZvS4KUrrR00eAktrHmU?=
 =?us-ascii?Q?9xZKYOyV6cbTNP5c/KRrAgXL1xsvzoh8J+sn3rSoU4M0jAyX97oddWUfiPEB?=
 =?us-ascii?Q?E4UC7EIVLqjbI2O9+QIFs56McFdZfjlNIFqigGCfntYccJU1Xi1hCv+99odk?=
 =?us-ascii?Q?TBcvGQp6tXLKoDyH6C69OxXjNIg2jhoM6XXVriUL027N7ESl6Y5TD33zJrVb?=
 =?us-ascii?Q?rtBEo9sy7yo+uXHbRYlFpvEIxa8cNTd8SlN/8ALVM2PS/EW4547h0+Omb8rm?=
 =?us-ascii?Q?rBP9oKohyGFdOlFlbwCljPMpiq5Wo1aLB8UGE76ybPHAmqcLSYthKpZbZGot?=
 =?us-ascii?Q?BEm/L+sk1LNJA0tL7foCJtiPO3BDa7gd90qErI8Z1ixOzijWMdmXBto5euHx?=
 =?us-ascii?Q?197/44zdfxZjT1mYrlOm//p1NqeN/IpAbPbG5z+kZ1yOaMbYGsmCYzlOa3Jp?=
 =?us-ascii?Q?DDrBvjfhdsKehf8UcbEo9HXtBTRdLA8eXSluj6xNODLXFu3z1FusghT2Im/M?=
 =?us-ascii?Q?fjxP1b6rA+3Nv9PXvVHOJt2lWUVYpC5hawir1nEPZQ7x784pLWjOvYAb/vxY?=
 =?us-ascii?Q?buc9GhFJvQCoVoTB6VtcqjauE6foeRnWLeOsySW5/ucXFKpfoAt0jOUuPwJ0?=
 =?us-ascii?Q?paWqAEvsNpy4DrHtJK8lBUBMHdtDZl/N3KGKmmnrUTwBnf+NS5yv84zQAwq9?=
 =?us-ascii?Q?hfQyZ/Xgvqp+idoHLeAH7qz/VATapOi0EkLx/Q7auENXZOc9BZ/y81nRUNS5?=
 =?us-ascii?Q?th9o6TAzbLNIwREge6+sgBbGxhFcW9bQfS2q+zngqyVsKkiBXu1myZVCG0TL?=
 =?us-ascii?Q?Try1uc03WdUCcOXydxZ1DtP1IjM5KlM6wtCr3Qmp1kp09HFuopD4ZCZMd5Ds?=
 =?us-ascii?Q?/Bf9d8vIgpQzNqxscx/qCBD//cuPmACLVr9ehvc70hKNgxB4cGJQMu/HqG3y?=
 =?us-ascii?Q?g0MRgtfWs1iv/XdZIRj4520t61N9hjaDEdeA24XBTy8ncTof4BTvNMs1fMBB?=
 =?us-ascii?Q?o/6K8wo3hXCioE6Ums2s+NDQuXgeGh+fDSXUskpIPTtPEf2G6qcIk3Heteeo?=
 =?us-ascii?Q?NzKtFu0fUzdC8B9TiXpVL5COIckQp3ZEOfAwAOfxckv6UaWfuwmno7K1tiEN?=
 =?us-ascii?Q?I8sXdzmqsKCyKEw5qdoXcZZZe8f5dxd9HtZaSTn1zTuYot/GsI69zHCvYySL?=
 =?us-ascii?Q?JAPIa/zJs5iPgtejEKzWlWvAgvJoJBnn2vPwt1rsBbIpzbxCGItdUR1iEJ9Z?=
 =?us-ascii?Q?wxMJZQBkHs99NeiCRWVuvtU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8560.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ecc7e8-4744-4612-4549-08d9ba46519a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 12:29:02.7783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deEyqr3SXjSEhYiFHAAYZASAHtR5QBzbGkOn3IEdU1xsIqgk3esmWHAdq4BYRuZAT5jpqHS9lqlT6KZCJlpP4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3424
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Lars-Peter Clausen <lars@metafoo.de>
> Sent: Wednesday, December 8, 2021 5:12 PM
> To: Vinod Koul <vkoul@kernel.org>
> Cc: Michal Simek <michals@xilinx.com>; Radhey Shyam Pandey
> <radheys@xilinx.com>; dmaengine@vger.kernel.org; Lars-Peter Clausen
> <lars@metafoo.de>
> Subject: [PATCH] dmaengine: xilinx: Handle IRQ mapping errors
>=20
> Handle errors when trying to map the IRQ for the DMA channels.
>=20
> The main motivation here is to be able to handle probe deferral. E.g. whe=
n
> using DT overlays it is possible that the DMA controller is probed before
> interrupt controller, depending on the order in the DT.
>=20
> In order to support this switch from irq_of_parse_and_map() to of_irq_get=
(),
> which internally does the same, but it will return EPROBE_DEFER when the
> interrupt controller is not yet available.
>=20
> As a result other errors, such as an invalid IRQ specification, or missin=
g IRQ are
> also properly handled.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Thanks!
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 61618148f9d4..cd62bbb50e8b 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -2980,7 +2980,9 @@ static int xilinx_dma_chan_probe(struct
> xilinx_dma_device *xdev,
>  	}
>=20
>  	/* Request the interrupt */
> -	chan->irq =3D irq_of_parse_and_map(node, chan->tdest);
> +	chan->irq =3D of_irq_get(node, chan->tdest);
> +	if (chan->irq < 0)
> +		return dev_err_probe(xdev->dev, chan->irq, "failed to get
> irq\n");
>  	err =3D request_irq(chan->irq, xdev->dma_config->irq_handler,
>  			  IRQF_SHARED, "xilinx-dma-controller", chan);
>  	if (err) {
> @@ -3054,8 +3056,11 @@ static int xilinx_dma_child_probe(struct
> xilinx_dma_device *xdev,
>  	if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIMCDMA && ret <
> 0)
>  		dev_warn(xdev->dev, "missing dma-channels property\n");
>=20
> -	for (i =3D 0; i < nr_channels; i++)
> -		xilinx_dma_chan_probe(xdev, node);
> +	for (i =3D 0; i < nr_channels; i++) {
> +		ret =3D xilinx_dma_chan_probe(xdev, node);
> +		if (ret)
> +			return ret;
> +	}
>=20
>  	return 0;
>  }
> --
> 2.30.2

