Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF0E1F1BB2
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2020 17:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgFHPIx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Jun 2020 11:08:53 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:50144
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730033AbgFHPIw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 8 Jun 2020 11:08:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PABPK+dd5AbMZ4HdQsz+Bew3KBpotYhnIZFWupDFUP4fzwd6jrmVXrVt8tRI3POsBGvyQlnTm2/MNeZk+CLw7BaQHplCnN6BaN9BWnRBV9pFoyauxhyxEib+ilcM4EOzmjn64japtypShzlkd4F0THrRWbSUIpPqCehwg+RnzT4INx+u0+m0hYHt92JR9njImWq3Jk55c4BotI9oNKpmw1GJ9n+W4WwCpnmN+uUy2L8fYp6GfmaqiNK7amRrcdaESul+WCVDzjXzLc3dEnJnXB25XBG3zovJWsnWjHI5b4Rwmhr5B/yZ5bpedJV9A2/1FHjNVcOvBolCi9wx+LFZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FKlWPTAeyaJ8sOWNBlus9Z2N57C0qPEf58EnFV4lps=;
 b=hcMXCBd8rGQ0uh0Xat6gKtbEmpqGSuOpWi8lXBRA96R/POmMCzoqb9YC+f7Tm8gLpab2qcsqCSHYqTKNER9rVmgOcHtID1HlLczQCG6b3ot0zMmpzcKRtWF+MfBjqx+2vjp0KS5foO4UWHfmmNq07YRExKG0CYLIsxPbLBtQB4QbfHNHfzUSPoKstfsHItPPMfXPlw1KJqUmIz8wUclP8XFTzi9v7U2lBpUEy9sM2pX+24kDVo7dKx+AEHbgeC+TQBGrKndlPghhI7remOvxmRG8jw5V95Bzty1AllEze5dBHubsVZWeuDynL1SaLbc2n5C9SXLfDodQUOvl+uTEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FKlWPTAeyaJ8sOWNBlus9Z2N57C0qPEf58EnFV4lps=;
 b=s4wqM6weKf6fte54xPswchSLLs5ct8Ve14HmRCY6jyfx6Aqhb9mFwP8YO2TkAqAM2rA0U/rjHgJH5NzGX/i/kUa+MPiozAtBw4qMuHVOS1SQ2Pu2tJQdXh9p9E7FDyg21HPQ3w5BcRtVqGnxiThDpvBH9G2sxj396dpffxs2u8s=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 15:08:45 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 15:08:45 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH v9 RESEND 01/13] spi: imx: add dma_sync_sg_for_device
 after fallback from dma
Thread-Topic: [PATCH v9 RESEND 01/13] spi: imx: add dma_sync_sg_for_device
 after fallback from dma
Thread-Index: AQHWPBYcMy4ZpJEEjkym0JBjSJknZajOy8sAgAABToA=
Date:   Mon, 8 Jun 2020 15:08:45 +0000
Message-ID: <VE1PR04MB66388F89015F774EE3FFF69D89850@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
 <1591485677-20533-2-git-send-email-yibin.gong@nxp.com>
 <20200608143458.GH4593@sirena.org.uk>
In-Reply-To: <20200608143458.GH4593@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.235.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a383b15f-303f-447b-b947-08d80bbdd6c6
x-ms-traffictypediagnostic: VE1PR04MB6589:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB658929D4432D10EC54230EF489850@VE1PR04MB6589.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yggd+lQBqrcdTQvrdA/yvpMkcRZs67hV0FLXqSdated3FmPRX4pfcPkleNYp/B71QR21XGhXx/DCZLSFJlbEMkzsRurII8a0/ekoVi/0W7bTRU5NCsb9ayYN5ahkblY+tfTbp7jh/H/q4Hnl50S2ES2fFG4bed7W/Qe5XTNCkpuDPsh0/AfarGxaXsGilFKjn/eCxCUQ6zX+HlXzscdv8j8H4mQYOdXGzmVx7Uol7FgQCr1UclnbmJlr1sA9WG/TLVCo39bh5Ob1WRhzq0bq1DdlcJIPHpojz2+E9MqlCtImGEdFL2aE7mFfb1LDH4z4oPVopdkL8JYGe75GY7uINFF6zMiTVKWa13T1fLaVf/LkiKgE90t7a+DKB4K90tn3mwn6ymAocBz/jO0rPhcyzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(2906002)(9686003)(26005)(316002)(186003)(53546011)(7696005)(6506007)(55016002)(33656002)(83380400001)(71200400001)(54906003)(966005)(64756008)(66446008)(66556008)(7416002)(8936002)(4326008)(8676002)(478600001)(66946007)(66476007)(5660300002)(52536014)(86362001)(76116006)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7yWBjfzKb6mhHSQSSgwxJjsysI3YVC5b/rSyOZJiZp8oZZY9WSlUKSWJUnwlnYbTSybzgkmkUs/orVsxtEEBZ1hik45T/LjjVciMsq5oHy/HSsbRCKdbVPCGd7+s8j5JXPMOhcdod4hpX3XcHwo0ESn/PHnoB2rr/RiAG4mPM85f7kJI1fGCxBqIRIaKNm20DXtHT6o5vnZ3c4vahBWkhN7iQOGoSZsBkZotlcuzp1nLwLBpaub5xApFmdvmQA1+xXfWigclRwiu9aj2sljS2eINNy6tZKGxFPVaMM1UAMs+OWooAFkTG11S4NNrItHy3X4tkDZ4ZL5mOw8HQe36p0fk/vFu0X/oqgZgXrEJLPninaHgM0JQ8NMRBq5JpJK/Tp3s5W87a6vt0pYsAoi6n1ZLK0TfwXwj3JcL3VeCMJlxDmSH8CRQFW5TODtAVCtA44u85osrRbrwon4sxCZhbGGSIAzH1V/EvyPJ6aLlKAI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a383b15f-303f-447b-b947-08d80bbdd6c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 15:08:45.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLZGp4zsuFDODko2+vaCejWCnulNEZEnVKQ3CIFcu+wtCs4aTp9b2Co0DYPs3/nodTXU1EmOacL4+oQz+mi2Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6589
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/06/08 22:35 Mark Brown <broonie@kernel.org> wrote:
> On Sun, Jun 07, 2020 at 07:21:05AM +0800, Robin Gong wrote:
> > In case dma transfer failed and fallback to pio, tx_buf/rx_buf need to
> > be taken care cache since they have already been maintained by spi.c
>=20
> Is this needed as part of this series?  This looks like an independent fi=
x and it
> seems better to get this in independently.
But that's used to fix one patch [05/13]of the v8 patch set. To be honest, =
I'm also
not sure how to handle it so that I merged both into first v9....For now, I=
 think you
are right, since 'fallback pio' patch could be independent this series. Wil=
l resend in
v10.
>=20
> > Fixes: bcd8e7761ec9("spi: imx: fallback to PIO if dma setup failure")
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > Link:
> > https://lore.kernel.org/linux-arm-kernel/5d246dd81607bb6e5cb9af86ad4e5
> > 3f7a7a99c50.camel@ew.tq-group.com/
>=20
> The Link is usually to the patch on the list.
Okay, will remove it.
>=20
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -1456,6 +1456,13 @@ static int spi_imx_pio_transfer(struct spi_devic=
e
> *spi,
> >  		return -ETIMEDOUT;
> >  	}
> >
> > +	if (transfer->rx_sg.sgl) {
> > +		struct device *rx_dev =3D spi->controller->dma_rx->device->dev;
> > +
> > +		dma_sync_sg_for_device(rx_dev, transfer->rx_sg.sgl,
> > +				       transfer->rx_sg.nents, DMA_TO_DEVICE);
> > +	}
> > +
> >  	return transfer->len;
> >  }
>=20
> This is confusing - why are we DMA mapping to the device after doing a PI=
O
> transfer?
'transfer->rx_sg.sgl' condition check that's the case fallback PIO after DM=
A transfer
failed. But the spi core still think the buffer should be in 'device' while=
 spi driver
touch it by PIO(CPU), so sync it back to device to ensure all received data=
 flush to DDR.
 =20
