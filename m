Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D051F334F
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2020 07:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgFIFVK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jun 2020 01:21:10 -0400
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:39953
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbgFIFVK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Jun 2020 01:21:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP7rUtXQfxCyot87oW+5qXkXhyWY16+Jke3B0MJbe3Rfpc3BBPUPiuvYaqWMoNjnHH4HtbFtQLqFx1d3gitQdTI3axZLWDHQMoiPF8DQ9oUP1n9hHnYbTjD1tK2WdbaAJkgOX4qbxcdt3NtajLpm/u4sOse1nnXRBhdqred8tNoh8zqu60tyB6gfCGrk4x6z/WWGn1LjDZWLEJka+K+NZHbpQ3odqP8j67OllUsK9zCD2715I8BYINqkZA8S5ocW1+ILGRFIqOI+dCbUw0ufCTyDMZ3n3VBPCb+MDW37s+0ZvkEU4lSpdOS8HY7VD4E8FC0V1urX5yMrvnFKYbCwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHkBw0HPxc+prr1W8elbO/t6RVzRCdRlO9wi82ahmio=;
 b=bUICbCJ4k6Kk30gR5QEKPgBWNAkGUs5mg+rhw73MBzLGsZgKmoanHje7WQIS161lxt6bxILhlvvdeBOc8kOfIYBz4fAUk7cPEvC1bOLYT0XCHG9bOW/FCK0HXKjIHFhypo8d0BVzx/6qBRIyWSjIyq9Jesbf3lBosL5M1mtTOHMuGcZ/wT4iptMTxcjeCGcsx16ONwRI0D3CwpiVr+7Yt7njKarBjo6rGi/oA7V9T/zCvHeAhI0gxLl59irPmFgoUA2JYYzFsoNIcP2HDvqwnU05PVtwswdx2jSMfhpX3rjbhxJ6rs5LhV/EcsX/Ejr4aDexjkOrGyP89EOOTBig7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHkBw0HPxc+prr1W8elbO/t6RVzRCdRlO9wi82ahmio=;
 b=ou2M7RFyYpOHdh+p6qHmmHysqyiQZIdpNpUt+4O5AxIKisLflGHuOvVnXMCxIUdGP+43wgblMSi/O5Pab62C9OerXekcBw7ZoG6RE8GxO58E3Bh+6FkYxcLYddYg2UqDYu8bo6W3fkJTVKfHFVP0gOPDHfobMAgKbf3nvDbP7J0=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6685.eurprd04.prod.outlook.com (2603:10a6:803:120::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 05:21:04 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 05:21:04 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v9 RESEND 01/13] spi: imx: add dma_sync_sg_for_device
 after fallback from dma
Thread-Topic: [PATCH v9 RESEND 01/13] spi: imx: add dma_sync_sg_for_device
 after fallback from dma
Thread-Index: AQHWPBYcMy4ZpJEEjkym0JBjSJknZajOy8sAgAABToCAAA6IgIAAFFCAgACn/7A=
Date:   Tue, 9 Jun 2020 05:21:04 +0000
Message-ID: <VE1PR04MB6638B1EC49D295C64292B7BD89820@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
 <1591485677-20533-2-git-send-email-yibin.gong@nxp.com>
 <20200608143458.GH4593@sirena.org.uk>
 <VE1PR04MB66388F89015F774EE3FFF69D89850@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200608153139.GI4593@sirena.org.uk>
 <59ce3620-00b9-bac1-30e1-011a29583642@arm.com>
In-Reply-To: <59ce3620-00b9-bac1-30e1-011a29583642@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b0ad395-6309-44de-8f10-08d80c34e846
x-ms-traffictypediagnostic: VE1PR04MB6685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB66853D9616D6B448BF527D5589820@VE1PR04MB6685.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/lNHVr7dIMiPtQ8ub7DLLkN2z2SHr0IbK8WqUsUwy+s+hVtBgkLOZ4rn+Pp5wheI8RlVLx2THWpvLFRjINOtwpS7ibJNG0umcTyCK/ekV1eVwqpNfK/WysrusfKdilptJyHmOfSua8aWaUspqUiZdGBsGGsErhjPmqo6OtRcSSFb+Jd+qktUsAH79lKVj0Gwr+t5qsPmp2uIILQzYruhJM12udeAWzsnH7Uf7F+sljMFUlNXnJyL4TcftWeYC0FMBw2GElck543W6WOnxO9PQVAwwQ7SKc+NLCe+VW3dwLkKWDBm05sxt3Mx2/VMbyCOifrQ+mKesYl4/xPw3C2gA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(53546011)(76116006)(8676002)(2906002)(83380400001)(8936002)(71200400001)(55016002)(478600001)(33656002)(9686003)(5660300002)(66556008)(86362001)(186003)(26005)(54906003)(6506007)(7696005)(316002)(7416002)(110136005)(66476007)(4326008)(66946007)(66446008)(64756008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Q4lfBzB9Q21BwKqHejUWnW1aU2D8WxZuJwTpbEaGSsgUFZjD3VS1nEGPsn3DraJalKpyqHyMqU+jAvGIwjdmz2GXVGbp2Yc31hiJPzr9vVAvRogDQISFFiyTsvoXdDsX04NenInSynyFFmbNdSHRwpSHBa/3cTETHGP8BeLPklewFbLSfrLA9Mz2WFEWwxakfZhC0PUJg9Fklry7DlKcThmRdukzove/JJIUkFjC/N6MJXRYWwrKrshaGk7TW2hXxZgD3mGWV11BS5f1EvN7NEwrTC6SVksdCbI2Dm/tvp5cdLf7m/kDjquCPFs4eGhhZhevYxO2dZlZp0a9F4SZjqpvHsUCnYRTrYAa/Kq3/kQNe3y2lqeEhlGWw6AEP95C4+j22TzEZCTkDEdGph3OMLK9zLmQrWqxyAG+DMuyOPzRPFpUfAxirbneJvFer9LXoF8Q705PoQRez7kQWzZg5tYhkFJZ4PbVIo98Ssyz31Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0ad395-6309-44de-8f10-08d80c34e846
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 05:21:04.6746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0zgAiXkt4M9D8HiTrgFRM5+reDiPPdbu3QQvzHuVPZMC9iY7HndPduCbGYMPRO/LtqJlyfibDCQf8q3zM6WXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6685
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/06/09 0:44 Robin Murphy <robin.murphy@arm.com> wrote:
> On 2020-06-08 16:31, Mark Brown wrote:
> > On Mon, Jun 08, 2020 at 03:08:45PM +0000, Robin Gong wrote:
> >
> >>>> +	if (transfer->rx_sg.sgl) {
> >>>> +		struct device *rx_dev =3D spi->controller->dma_rx->device->dev;
> >>>> +
> >>>> +		dma_sync_sg_for_device(rx_dev, transfer->rx_sg.sgl,
> >>>> +				       transfer->rx_sg.nents, DMA_TO_DEVICE);
> >>>> +	}
> >>>> +
> >
> >>> This is confusing - why are we DMA mapping to the device after doing
> >>> a PIO transfer?
> >
> >> 'transfer->rx_sg.sgl' condition check that's the case fallback PIO
> >> after DMA transfer failed. But the spi core still think the buffer
> >> should be in 'device' while spi driver touch it by PIO(CPU), so sync i=
t back to
> device to ensure all received data flush to DDR.
> >
> > So we sync it back to the device so that we can then do another sync
> > to CPU?  TBH I'm a bit surprised that there's a requirement that we
> > explicitly undo a sync and that a redundant double sync in the same
> > direction might be an issue but I've not had a need to care so I'm
> > perfectly prepared to believe there is.
> >
> > At the very least this needs a comment.
>=20
> Yeah, something's off here - at the very least, syncing with DMA_TO_DEVIC=
E on
> the Rx buffer that was mapped with DMA_FROM_DEVICE is clearly wrong.
> CONFIG_DMA_API_DEBUG should scream about that.
>=20
> If the device has written to the buffer at all since dma_map_sg() was cal=
led
> then you do need a dma_sync_sg_for_cpu() call before touching it from a C=
PU
> fallback path, but if nobody's going to touch it from that point until it=
's
> unmapped then there's no point syncing it again. The
> my_card_interrupt_handler() example in DMA-API_HOWTO.txt demonstrates
> this.
Thanks for you post, but sorry, that's not spi-imx case now, because the rx=
 data in device memory is not truly updated from 'device'/DMA, but from PIO=
, so that dma_sync_sg_for_cpu with DMA_FROM_DEVICE can't be used, otherwise=
 the fresh data in cache will be invalidated.
But you're right, kernel warning comes out if CONFIG_DMA_API_DEBUG enabled.=
..=20
