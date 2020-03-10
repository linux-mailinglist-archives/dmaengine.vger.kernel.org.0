Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFC017F1F1
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 09:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCJI1r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Mar 2020 04:27:47 -0400
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:4885
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbgCJI1r (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Mar 2020 04:27:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvrcMZEDbMS9adcN2QOBl5u6fJLjg93+e5XTrNGqQxVeOs3Xb4OFepX/NYlBn6SY5ui9BqzdLMTHfUTSuOwcVOdwPXWjEDZAifiVZRah/4HVTyl0MTrNL8qJyg89+GF3Li5DxrNYLrAXWh7yHdJnWq5SClKmSnqVPJoGkDrIR/RM7ra7t9/U5fAjr4InO8Mqm4DbKNYn9uA+NeSHMmN0pX/O3/Z4JnIJjOkGoOMzz6voPXe9zQFTbTvZOlGfdnTXbhBcqRRO8y5SFVW/1xZPyJmjKU24VT+ELQqsE2hqm+wB0cH75FpWzXIow7gcakUCa9SapH572/QH7e/nks/eVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m97V0eSykN1CXULL3ZV8lBCFT2zzdvfN7XyYpRQp04=;
 b=k012AudWV27lNLo/47LP3NHYnVl/IMXg7KeKmIVZCPDyXNVAmmqXKllG/r6wEFt0GqfNepmaJMmkL5A1Z6SWojCOdDFUoAoAb08r5Y9BeEowR50QLEX8/x0/Y+6kg8qpsnwSfPUjByyoobzOV4ZPqLz4eGrXr9IsCbmv6r3hlosqOXcUB/pVtP2rqLI6FumXbdNiebzOddWFXgaivelLrZ45d3ESpbebv86MBpsXhUP9lKnPb7Re+NetKGp8YYT8NP+KUJezkHigWLiov32v4WH58ECHSxJ63a9LnV3M/jXAMHpPQkx9nAdxs2Nc6Ui1biRP4xrwKqY5U70TXmbbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m97V0eSykN1CXULL3ZV8lBCFT2zzdvfN7XyYpRQp04=;
 b=oVTS5hWC5dlu4Y0QUYLb6+LcL228z2CN155WNiT+twNBwWBrkGepid1VBsk2hiy2hOQ4LixQ/Z4jTSVOhExt0Enccl+7yJBm97avDrSKAkq2vE/+vJ6Gvvooi8PIS5VLUMoszQwkQBHuky45JTTdhP1NgickfBNj++lftvuYu5Q=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6767.eurprd04.prod.outlook.com (20.179.234.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Tue, 10 Mar 2020 08:27:41 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 08:27:41 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RESEND v6  06/13] spi: imx: fix ERR009165
Thread-Topic: [RESEND v6  06/13] spi: imx: fix ERR009165
Thread-Index: AQHV9oxXftoGpg9l0ka8yr0vqbewZqhBcOwAgAAKFSA=
Date:   Tue, 10 Mar 2020 08:27:41 +0000
Message-ID: <VE1PR04MB66384DA6732A840FE1D80C1989FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-7-git-send-email-yibin.gong@nxp.com>
 <20200310073920.GR3335@pengutronix.de>
In-Reply-To: <20200310073920.GR3335@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88acc0a7-28e6-4a7a-fd5a-08d7c4cce668
x-ms-traffictypediagnostic: VE1PR04MB6767:|VE1PR04MB6767:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB67677423BDC29176E04EA8E689FF0@VE1PR04MB6767.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(66476007)(66446008)(64756008)(66556008)(76116006)(52536014)(71200400001)(966005)(4326008)(478600001)(45080400002)(55016002)(33656002)(66946007)(81156014)(81166006)(8676002)(6916009)(26005)(186003)(5660300002)(8936002)(7696005)(9686003)(2906002)(6506007)(86362001)(316002)(54906003)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6767;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BIXgle4FfsSGj4XmFnr/EL1BRy7H8WXPnYoBZSrgEUlfbL8aGq+rNS1BvDuBCkFy4CpAaI9QWw1ti7RwqGZnBEtI/Jk/i1cHMBKiV3PsWeFFsjX/0d9THKin8/c7VMQXrro99LUTtENt1xSHfpfqkXAla4q/ve+ahRB9ePudPKbqAJP68DiP5kUi8c0ujg6zP1wZ9VPm1aUiJJ7kPMKCqh2xqKdpQOh+dyaHtoaGu7fu+wK1w766Nlb7fmL6ckPZVtpKd5fLoLbcvPRnBkQIibMwfKVBvv+kMEyByNapBdsXWtVx5zCm+juWqVY8OrPdkSYm70j/0tHY8i8hriB1jPS4xWs93fzAB7FtbkpdD1nAk8XZcRAf0omIgIabPR52LMjXBroR4b1CwLBnIyOqMrDOzLo4WeGKHlb1veJEkxADjbHCnopplcFktdfrD09Z9xdTP+vGfbcTA7J3N6EsvPQULHRnOaK1+WVtj6yPs10zgbsztxi2+I4orrdBIc4uQ+nBFVfJHPIzwYEhBV0huacHQBVMXVF56Va5sBqV6oyEaem6TgJbO0F/TEws3OKA7VNYOB9JDQLVJSkFQ2LFrpKtS+vg0cz79Oh0Rm0I4i239VyCdbzpTTEr8e7QjFQ3
x-ms-exchange-antispam-messagedata: +3Lyxiq7DGvUgQigA/olGD9OXQFPw3M+46IN6L21TZmxhJGUnQi8OBRYCowDGOWWJ4INgjt9odf8169q/z0Yx76V/HNFXCHPgcIKxxlqz1ZCDvwoJnCbQxgf9QziTfI87HqrMz/RxEsWe9aE4eYXsQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88acc0a7-28e6-4a7a-fd5a-08d7c4cce668
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 08:27:41.2338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKyloGauQ5OExnAF9hc/fYjt1bmj9E46FCUmErO2do+O84eEyhz9F3KnM1SzVYdWOhNXYfT8tP7w8StBXCjZ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6767
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/03/10 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Mar 10, 2020 at 07:31:55PM +0800, Robin Gong wrote:
> > Change to XCH  mode even in dma mode, please refer to the below
> > errata:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.
> >
> nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01%7C
> yibin.g
> >
> ong%40nxp.com%7Ccbabce268dfd4b0a0e2a08d7c4c62ff6%7C686ea1d3bc2b4c
> 6fa92
> >
> cd99c5c301635%7C0%7C1%7C637194227793913712&amp;sdata=3DQ5N49T4jgX
> TcdTzsB
> > 3D0saK2%2Fzj0R4gnJcGR%2Bd70Fm4%3D&amp;reserved=3D0
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > Acked-by: Mark Brown <broonie@kernel.org>
> > ---
> >  drivers/spi/spi-imx.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > f4f28a4..842a86e 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -585,8 +585,9 @@ static int mx51_ecspi_prepare_transfer(struct
> spi_imx_data *spi_imx,
> >  	ctrl |=3D mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
> >  	spi_imx->spi_bus_clk =3D clk;
> >
> > +	/* ERR009165: work in XHC mode as PIO */
> >  	if (spi_imx->usedma)
> > -		ctrl |=3D MX51_ECSPI_CTRL_SMC;
> > +		ctrl &=3D ~MX51_ECSPI_CTRL_SMC;
>=20
> 'ctrl' was read from the hardware. In the dma case it was set explicitly,=
 but it
> was never cleared for a PIO transfer. This looked wrong before this patch=
. Now
> with this patch it looks even more wrong:
> We clear a bit that has never been set and we only do this for DMA, when =
for
> the PIO case it definitly must be cleared. Drop the if clause.
Good point, ACK.
>=20
> >
> >  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> >
> > @@ -612,12 +613,14 @@ static int mx51_ecspi_prepare_transfer(struct
> > spi_imx_data *spi_imx,
> >
> >  static void mx51_setup_wml(struct spi_imx_data *spi_imx)  {
> > +	u32 tx_wml =3D 0;
> > +
> >  	/*
> >  	 * Configure the DMA register: setup the watermark
> >  	 * and enable DMA request.
> >  	 */
> >  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> > -		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
> > +		MX51_ECSPI_DMA_TX_WML(tx_wml) |
>=20
> tx_wml is never assigned any other value than 0. Drop the variable.
That's prepared for 07/13 patch which may assign spi_imx->wml to tx_wml.
>=20
> >  		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
> >  		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
> >  		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
> @@ -1171,7
> > +1174,11 @@ static int spi_imx_dma_configure(struct spi_master *master)
> >  	tx.direction =3D DMA_MEM_TO_DEV;
> >  	tx.dst_addr =3D spi_imx->base_phys + MXC_CSPITXDATA;
> >  	tx.dst_addr_width =3D buswidth;
> > -	tx.dst_maxburst =3D spi_imx->wml;
> > +	/*
> > +	 * For ERR009165 with tx_wml =3D 0 could enlarge burst size to fifo s=
ize
> > +	 * to speed up fifo filling as possible.
> > +	 */
> > +	tx.dst_maxburst =3D spi_imx->devtype_data->fifo_size;
> >  	ret =3D dmaengine_slave_config(master->dma_tx, &tx);
> >  	if (ret) {
> >  		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n",
> > ret); @@ -1265,10 +1272,6 @@ static int spi_imx_sdma_init(struct
> > device *dev, struct spi_imx_data *spi_imx,  {
> >  	int ret;
> >
> > -	/* use pio mode for i.mx6dl chip TKT238285 */
> > -	if (of_machine_is_compatible("fsl,imx6dl"))
> > -		return 0;
>=20
> So with this patch it becomes possible to do DMA on i.MX6dl, but it is
> mentioned nowhere.
That's a common IP issue but caught on i.mx6dl at that time, so this time I=
 didn't mention
i.mx6dl.
>=20
> Sascha
>=20
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7Ccbabce2
> 68dfd4b0a0e2a08d7c4c62ff6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C1%7C637194227793913712&amp;sdata=3DTL%2BheiNsYVPld3qyzWjF6yQZgH2
> HLdVFxzFeK3MupTc%3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
