Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F7B1D0C60
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 11:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgEMJhG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 05:37:06 -0400
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:11585
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbgEMJhG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 05:37:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eqkb+PlBGLHu/1YBHbUze3ZunIxcWZuAnmTT6q5M5olxRecqAOjpNJW3YtZs5vb5b3QXAndig20jStYthVJsiN/oSTk8PJJboHGaBG+izKrPErC5yjKDju9FJdn2X3HJUiwnYEmfipsAjLFZjloepFWnhX6Z2IcQdBM0YX0odBvpOCwyuMOvojH9Wwt5LVorj9V94+EkvIb/vlfuIar1kc+DrVA/HdQUS7gziaM5jyyxt4xfUFKp4wWtWxt1wJ1mpHG1hv0YsQhPYdWsn03bEoTKCbir0wGqRccYsy3bLYRGCToHoBsdnz0xubv+tJS9xj2XPR/bLG7jOyhB9bRDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+2XxqZt1AKKoYhjOq+JBMW+o7JZohzXyXxsUMB9tqA=;
 b=nBhelS4EVGjAqvhvY5Sa7todQpFxSOBxCV1ZBMNZuwP+bBB3gyH6XzzgT3dLipPHJvwtdfoTdQzU/srx6x9glG+FVfTAIItwpYYVbw16nnOt6/A4KTqZLhrF7hLgpNScdZY4Ha22eQ8G/rNg4Ylc0Idu5oLgo8vvL69rex2nhaZGy0i6BsExEYz+5rpcYYwxFSbo5n93JGgZ6RAvbfsNTvIkUW3WFz9znZlL7ZLV4tCjQXernRKZjTsQk3dwF1quqi2BGdnrfYrZWaPKBfr+Cmff1EvZOnoxguEdtgej9kRoTV5ElBRpcNTqKN/YraSmNjayL2WuYNuPaNNgjFALKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+2XxqZt1AKKoYhjOq+JBMW+o7JZohzXyXxsUMB9tqA=;
 b=RIzl5E0Zqf41VKPkvLV7ClNPFpRPrtPulKCmj80fvySNEdjIR6dKU0k5iWdqQnA3AxZdgeQKo0TdvDqaeJHkRU54HMUpKj8KlPl/NLnvTsHx+Pwe927ttMDXmYXWaiLz0GGtZOjUB2skLGSp8fhJe6POXsmkGhexVdTglgc1gp4=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6718.eurprd04.prod.outlook.com (2603:10a6:803:124::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 09:36:59 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.3000.016; Wed, 13 May 2020
 09:36:59 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: RE: [PATCH v7 RESEND 07/13] spi: imx: fix ERR009165
Thread-Topic: [PATCH v7 RESEND 07/13] spi: imx: fix ERR009165
Thread-Index: AQHWJ3cnZ0DWmxBZKkqSbDLRijv4Zqilos2AgAASCaCAAAuqgIAAAiNA
Date:   Wed, 13 May 2020 09:36:59 +0000
Message-ID: <VE1PR04MB66380EFEEAFA1C7DBC98DAF489BF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
 <1589218356-17475-8-git-send-email-yibin.gong@nxp.com>
 <20200513073359.GM5877@pengutronix.de>
 <VE1PR04MB6638DE9AB1E51213DACCCA0F89BF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200513092017.GQ5877@pengutronix.de>
In-Reply-To: <20200513092017.GQ5877@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c489a4d6-c247-4ae0-31a3-08d7f7212f59
x-ms-traffictypediagnostic: VE1PR04MB6718:|VE1PR04MB6718:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB671824625D0B601C6BB2FEC089BF0@VE1PR04MB6718.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Afvz9lPOsqc4m4SqR+XNciZHmDIQeO1MN8gPoaRUoknQhhghwypjuOgQC43YjIskOH10cjZ2cl1joOTBTIiBWxkv7w51wMylLpJ/iqQO2y/LMEmQDD5H156jcaQy3CwidSAJOrSu6y8nMMFJpJvncTPEgU3Gd+mLePsI/edhMJ/0cJVg3Nin5Fx+WG18Z7aKjxmcbpRz0plKLlwyTOa1Iu4c/QnMQV7mqaxY9jCm+qBYxiNb3aFG9U03sE4jU8qHBESmB5HGf+REBlFwDwq9so+oodLd4QBp1F96AnKPCO7rivRjhagVXPJIOf/5pui7L4palZIH7mgMGHJMvmt9qtiVcRMYmS4wCAb3ToIsDz/wUo2dFy7CXU6+wgua9xUhUvc8seBQ8r+a0pZM6pDsOlcQJob6KRUa8AGhl245FIQxk9gSei3SvMUOwy9oQMishzqxEPaM+S4HsHpj0XfVeDkTMC50IhGgTD4WIkmZyIspPW4yRSZqO1+aCNSTZlDbXG0hmVocga9IBqAmdOuMcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(33430700001)(76116006)(86362001)(71200400001)(66946007)(6506007)(316002)(54906003)(8936002)(186003)(8676002)(52536014)(7416002)(4326008)(9686003)(6916009)(7696005)(33440700001)(64756008)(66476007)(66556008)(66446008)(26005)(55016002)(478600001)(5660300002)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zWpJdK6GRBB5T9d6fnEMm0XmyLpzi+O8my+VO+ViJg1CCr3I2Dz8OLynYliBxAo+rs8ZdYjFSqrOUGga3z6iwkgy3mvVU3aOD2ZpUV7IFJIqRuFXrRS2dN1AsGdho4SnYTEh9dkrbpGm7sVknycgqkFkGyhc3C1FTGSFLeMH0t2jXvbUDGr3JCkWcvxxMtwiUQ01dCvVPpLOfax7Nvptk3Gxmud4C99LlsRiKt80TlCQ/8krZD7xqCXAvDtLqrCM4+iym+pht6RH9yvZMWzTW1xgBM8vGLfK4kA8pcYM6ShOMYoriBFNugOepT2sMQayi8ra4NV83xY2m4sV+jEgYxY9cZEhgPG1b/NFITCs+Dpz7al3TfBtewLGqpZPtlELptcn2SD1Zfs7zRVq7Plb6pJDmHcH8r9jcjWzvFqwKvSZxyLzZ8aA/5EmvPep4zf9BZxoV13eg6N2Hx8trN02GmOWb0lfT+QRf0tni9ptMZE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c489a4d6-c247-4ae0-31a3-08d7f7212f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 09:36:59.5151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MNNA5qh6/E3ivKnCXEG0RhzVs+ZWMCRGgVXtF+lrrO5dfE7pM4oZR6INvNA7H8QaZ5fKrI8n52VvgxsTCOTiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6718
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/05/13 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, May 13, 2020 at 09:05:33AM +0000, Robin Gong wrote:
> > On 2020/05/13 Sascha Hauer <s.hauer@pengutronix.de> wrote:d
> > > >  drivers/spi/spi-imx.c | 16 ++++++++--------
> > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > > > f4f28a4..70df8e6 100644
> > > > --- a/drivers/spi/spi-imx.c
> > > > +++ b/drivers/spi/spi-imx.c
> > > > @@ -585,8 +585,8 @@ static int mx51_ecspi_prepare_transfer(struct
> > > spi_imx_data *spi_imx,
> > > >  	ctrl |=3D mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
> > > >  	spi_imx->spi_bus_clk =3D clk;
> > > >
> > > > -	if (spi_imx->usedma)
> > > > -		ctrl |=3D MX51_ECSPI_CTRL_SMC;
> > > > +	/* ERR009165: work in XHC mode as PIO */
> > > > +	ctrl &=3D ~MX51_ECSPI_CTRL_SMC;
> > > >
> > > >  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> > > >
> > > > @@ -617,7 +617,7 @@ static void mx51_setup_wml(struct spi_imx_data
> > > *spi_imx)
> > > >  	 * and enable DMA request.
> > > >  	 */
> > > >  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> > > > -		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
> > > > +		MX51_ECSPI_DMA_TX_WML(0) |
> > > >  		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
> > > >  		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
> > > >  		MX51_ECSPI_DMA_RXTDEN, spi_imx->base +
> MX51_ECSPI_DMA);
> > > @@ -1171,7
> > > > +1171,11 @@ static int spi_imx_dma_configure(struct spi_master
> > > > +*master)
> > > >  	tx.direction =3D DMA_MEM_TO_DEV;
> > > >  	tx.dst_addr =3D spi_imx->base_phys + MXC_CSPITXDATA;
> > > >  	tx.dst_addr_width =3D buswidth;
> > > > -	tx.dst_maxburst =3D spi_imx->wml;
> > > > +	/*
> > > > +	 * For ERR009165 with tx_wml =3D 0 could enlarge burst size to fi=
fo size
> > > > +	 * to speed up fifo filling as possible.
> > > > +	 */
> > > > +	tx.dst_maxburst =3D spi_imx->devtype_data->fifo_size;
> > >
> > > In the next patch this is changed again to:
> > >
> > > +       if (spi_imx->devtype_data->tx_glitch_fixed)
> > > +               tx.dst_maxburst =3D spi_imx->wml;
> > > +       else
> > > +               tx.dst_maxburst =3D spi_imx->devtype_data->fifo_size;
> > >
> > > So with tx_glitch_fixed we end up with tx.dst_maxburst being the
> > > same as two patches before which is rather confusing. Better
> > > introduce tx_glitch_fixed in this patch, or maybe even merge this pat=
ch and
> the next one.
> > Sorry confused you, I should repleace 'tx_wml=3D0' in the above comment=
s
> > with ' TX_THRESHOLD=3D0', which means tx transfer dma have to wait all
> > the tx data in tx fifo transferred with ERR009165 rather than
> > generically 'tx_wml' (for example --half fifo size used as
> > TX_THRESHOLD). Obviously TX_THRESHOLD=3D0 would down performance, so
> > enlarge dst_maxburst to fifo size as PIO with ERR009165. After
> > ERR009165 fixed at HW level. TX_THRESHOLD could be used as common
> > 'spi_imx->wml' so change it back. Will add more detail information in
> > v8.
>=20
> I am not confused, I meant the patches are confusing. What you are doing
> is:
>=20
> No patch:
> 	tx.dst_maxburst =3D a;
>=20
> 1st patch
> 	tx.dst_maxburst =3D b;
>=20
> 2nd patch:
>=20
> 	if (foo)
> 		tx.dst_maxburst =3D a;
> 	else
> 		tx.dst_maxburst =3D b;
>=20
> It would be better readable and understandable if you did that in one pat=
ch,
> because that would directly say "Under certain conditions we have to choo=
se a,
> otherwise b". That's much better than changing "a" to "b" and then to "a =
or b"
>=20
Okay, I'll merge those 2 changes into the next 08/13.
