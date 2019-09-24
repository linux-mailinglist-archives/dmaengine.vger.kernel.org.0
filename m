Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5E5BC545
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 11:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404579AbfIXJxe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 05:53:34 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:65018
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2395316AbfIXJxe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 05:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY2KJRFi/SoIVjsVeedf3fgXJdVEJRBrp3BNnwt/YDwAsZP1MeL/sKSjgF76IxQa6SgMjGbv9AaL9suKViAQQc8JxDXgHOwDEiuhxgkLk9bUBYK23rWDTyQdyZUzDcTXaLc2pH326127U4nfNxqgn4+l8R8h2xcrHd0ZPPC8YAme2Qorj4f9hf5q03JasXfGcwQeVW4zfNPv741K1A9ZXIUcHuaMU7qEjg6eFiz2Bki3nxCJS8x1kgACMjF4oVyiJhu8eKszAhEAAFrgNmAZJYYtHVr0dWp/WihUyuai1ykuS8LXkGb/ngE9BdkgRUTzidNVf/y6McGUXpF2FFpjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVCHAGZrxEdv1p5MpseYNNfc5jitmdV6Q00UQHfqS8E=;
 b=QBbS1B386w68wDDalKcYS4Ij94Tz0D2fGIeEbaZq8aRo/bNhUjFQbvW5fuYstPBHMM0gcsO6bCBmlDPPoGIGu+h4Pw4ZfgOsK1btoUGUP6JkYKp3TkO9a7rZ4y0/ycOBa6+reCvqY0DjdcfY1iPOzn4wAdoj0mHJEriqMy6LRLOu6hMCGiqwTuNnBe6tr7TMmYmGso/1miOCiHfwEikRrd/P4SvILrEzxTKZjFbGi+6y4a20Cngr7vxiaBhLm3G0sHbXAgXVc+Uuk5EtqHfooefHz5MLy8oPj0vsJC7w0jzwKp87D4yT3w7bwQbAdX59k0gooCzWl/PeKXKC03nxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVCHAGZrxEdv1p5MpseYNNfc5jitmdV6Q00UQHfqS8E=;
 b=K56gn9McDbLgzrFPB7fzHrHNsB+pUUsAhFp62Giug+eh3Lu804Za1Qh5V+yvM+/n2k6jxQ64uciVvEb3v/B8Chf7/PqavY2k+lKZOSn5YviqsZPiLcgB2N45HdPerzrW2m/LujeJgePkIllpd6/UqcYxqE/n/jcBriQDAeVaHq4=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6560.eurprd04.prod.outlook.com (20.179.234.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 09:53:29 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 09:53:29 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 12/15] ARM: dts: imx6ul: add dma support on ecspi
Thread-Topic: [PATCH v5 12/15] ARM: dts: imx6ul: add dma support on ecspi
Thread-Index: AQHVH2TVoxrocaPAG0GbhXUgE95pRabOlrSAgAmbW7CAAQJGgIAAEIzwgGH3e8A=
Date:   Tue, 24 Sep 2019 09:53:28 +0000
Message-ID: <VE1PR04MB663843266A2839FE5CF5142489840@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-13-yibin.gong@nxp.com> <20190717064204.GA3738@dragon>
 <VE1PR04MB663894FA5BC88B130C70AC0789C70@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20190724004848.GV15632@dragon>
 <VE1PR04MB6638F60965CD3D5CE47F26C489C60@VE1PR04MB6638.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB6638F60965CD3D5CE47F26C489C60@VE1PR04MB6638.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 456d19d0-a8be-49a8-b6e6-08d740d50d38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6560;
x-ms-traffictypediagnostic: VE1PR04MB6560:|VE1PR04MB6560:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6560FBEABB6D8F771BEEC9A189840@VE1PR04MB6560.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(199004)(189003)(5660300002)(66476007)(110136005)(76176011)(52536014)(6306002)(86362001)(8676002)(486006)(66446008)(7416002)(26005)(81156014)(8936002)(966005)(4326008)(99286004)(2501003)(102836004)(6436002)(256004)(55016002)(6246003)(14454004)(3846002)(229853002)(186003)(33656002)(53546011)(25786009)(478600001)(6116002)(66066001)(305945005)(71190400001)(81166006)(71200400001)(2906002)(54906003)(6506007)(316002)(4001150100001)(7736002)(476003)(11346002)(66556008)(7696005)(9686003)(66946007)(4744005)(74316002)(64756008)(76116006)(446003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6560;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S+BiUzEYkzH4n2nTJGZHbdDGiALhL0QlhdsXDLPwLkeqAJt8/0MPOwjqAWV+sgs0LMxgY7WWKYDObZrQFoUWlJLOHql3ntSgjZhvg/bkow/l0kDqfnFs9QvXEFgGWVIfFTvCA5xc7UXNj63slC4a0kIT/jDBTK3BmWCnKNRyjkA2pWoIhGqmvPuzkbB7ceSSA6edWsSnaYBQlUp2Oqzijyy6KOAPbXGGab1rkW8SCbDXOdKlo5iMYs5kgDlFfs8T2loSBhfXdQOW5Rz9Rbm4zM9WHah6nh1Q1vK/CG5pb+yCfdWGXk6h2Awy4C4OTrihf4HOVDSAMg3pH1U/UYj5qBHrPg9aMAdwuf0xBdXCB6bfXqWE31bzw0q+ESRuLgGVCyyyyQTuGDM49JRu2L1Hwso9MQiCPTqys75mHl5XPMTTYLGPKGUn51j6GpxQCxymbSAs8VjTTEvCPEp4JaQkkw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456d19d0-a8be-49a8-b6e6-08d740d50d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 09:53:28.8308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9Ns9MpvEIPhrqpFQ/tOijeQ1v2kSOFD6bV5Ngvgmsdv9vrPd3k7rCsr+woK6r46sRNjf8dtsKJula1dJOycjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6560
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Ping Sacha...
On 2019-7-24 9:53 Robin Gong wrote:
> On 2019-7-24 at 08:49 Shawn Guo <shawnguo@kernel.org> wrote:
> > On Tue, Jul 23, 2019 at 09:39:38AM +0000, Robin Gong wrote:
> > > On 2019-7-17 at 14:42 Shawn Guo <shawnguo@kernel.org> wrote:
> > > > On Mon, Jun 10, 2019 at 04:17:50PM +0800, yibin.gong@nxp.com
> wrote:
> > > > > From: Robin Gong <yibin.gong@nxp.com>
> > > > >
> > > > > Add dma support on ecspi.
> > > > >
> > > > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > >
> > > > Applied, thanks.
> > > Thanks Shawn, but how about other dts patches such as 01/15,02/15?
> >
> > I need the authors of the commits being reverted agree on the reverting=
.
> >
> >   Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> >   Sascha Hauer <s.hauer@pengutronix.de>
> Seems Sean's mail can't be reached.
> Hello Sacha, Could you please help test if my patch set could fix your is=
sue
> even I revert your patch?
> https://patchwork.kernel.org/cover/10984301/
> >
> > Shawn
