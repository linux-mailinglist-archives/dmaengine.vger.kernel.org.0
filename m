Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCED03A81EF
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhFOOM3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Jun 2021 10:12:29 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:41860
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230352AbhFOOMR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Jun 2021 10:12:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKTQGy4/69DLK4aoHIfHV5NC/UEP1cNZtNuj3gRL0WCqns1Q/d7YtCBv/QsrDMaJsaj2xJQpMecBdHqK9cn3hUpeosrJfoPF74KUMcLHPRgTzZLGFFzL+ro7aLwHkFPq1fFRlLvq271+h3ejWbHrZ5ECipc50U84gd7oGFK+V1CRajDeFUMksTDmplZxtrfsxqQ4unKZdrDfjPPAdEW8oL9fh/4uD9yVqZDFLEZ2DGGpNZlsXqGvqfuHmUPlQOMsTZlsSDIp/oCsSM/HSiHli1EAWeeIAJsPa/+uDqvZSVMD/lsJwqflnlTu897t7UxGpCsGEga4khIZWvZ+kIQxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgOeTPu7h+YnjzqKyH4W6QUaRe/+rVbfzqkaP+N24lo=;
 b=VEEi7CpJIL8I05x81e5a73b82IB78jqPZp7L87yG1H8BE0vuKIi12xHfSXcnYpfZV1K2yHI2JprPVp27MD2KpzQb2ttAEwKziw2mdgYegmVZJTF2XpgArWUkS80sR0SsLWSqunzKSHVzaEScOz0RLYdYYSKJo261GwE6IeI5P0/6V3ibPNDgVHTyVVPyXOtpxPjVLoYu+rOIfsGDnq0krRl8XMUhBIx9sct9+QYjWUtSWvlroZPwx4VtoyKEcf8QPE0lxym3m0iIkDmj+LiypmtY6BBCa7Y3LJqFBZS+VtI3heqLxUQEy4VYP0+1R6F5jXfA3Mh+1fKEaoXr3IuedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgOeTPu7h+YnjzqKyH4W6QUaRe/+rVbfzqkaP+N24lo=;
 b=iKKU9xUDSnUWkC0HmBOnsDkr/ez3lpfZ0LZFyXAOwNueTJ6cUj63SLpDza80fTXea1JP5xXMhXLtOjMh6lEwWO+oNZvpLHIL5xS42CRVjQdw/sfelZjwnsG0zlcW3EeHSsTHUQXgpX4Xmj2hI35QBYofWk5P7Q3/CecCRmO4X5E=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB3056.eurprd04.prod.outlook.com (2603:10a6:802:8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 15 Jun
 2021 14:10:09 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::ed27:a6b2:74fc:8ef2%6]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 14:10:09 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Clark Wang <xiaoning.wang@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v14 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v14 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHXK33LUkqD6t3KUUabL8+87acFPqsPOqgAgAV+imCAAElmAIAABENQgABgQoCAAB74UA==
Date:   Tue, 15 Jun 2021 14:10:08 +0000
Message-ID: <VE1PR04MB6688F98FE0B76AF20392DD6E89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
 <CAOMZO5CNjpek0vkDrMyTmfbnr2cLcquck6QQBqXLBiyTDKPXvA@mail.gmail.com>
 <VE1PR04MB6688017E125D42C5DCB3C17D89309@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <YMhDvlPrFvSZP//I@vkoul-mobl>
 <VE1PR04MB6688E8EECC03C5290DE10BC089309@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <YMiYEZDgutW+KRsO@vkoul-mobl>
In-Reply-To: <YMiYEZDgutW+KRsO@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.236.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9082377-f3ac-4d9a-2d83-08d9300748a4
x-ms-traffictypediagnostic: VI1PR04MB3056:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3056446CD813752456739D5489309@VI1PR04MB3056.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hqJESuh3lPjla11xf9N+yzlGLO3VMj48uYV7pQ5I7doHfrNjEBT4R4iZkAEW9U04zg9voxNewC9YwYDCqyBclOmmEwRLGDBX3HYLHBTNtfkBH/IhS/3k4Vo7W8fMdsB7zI0ydyx3gN5MCFnbVsxCuxJ3AiEF8VbrJPBmTIB8RIKOcugfNl9q34SayUzn8kYcvTPfb7V+w0hf5xTJHWm2cVlGD/SW8msluNZY7JNj3ZmJqMuG8ZNgXTvJtUsszodgGH5D111XGrgYU9IleN+RozrJJpopUt+Yr6jYWNVxWLmAyU+bbz0JQ8aqUZXIqIxC3+exlm5oHjWOQLwOTjFqgwdgEJ3VOOX2PgfDgMbbaFA1HxfmohHpDkcLcoM0YR9wHUxx+fPP55XcKzZF/pZvO//fD3siRKRawqjSVBio5S6RUKzuCnwLqtNdjVAxaKqA0Lrj+DF1tfrQiNI0X0CpoAikKP5CwTfEliwaKeiwTEd/zkXhp0Y/9Nj590eRiLHdQxbzv+xKrDv73tRlk2hlI0Jz0QFnqEkfLEzqKUHMz+BJM3gw85KTmD9bdyjEQTyO/NSl2H1FVwvD1oWAXOjm4+lDj2STvjIXIWlxij/I6xs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(376002)(366004)(136003)(9686003)(83380400001)(52536014)(55016002)(66556008)(66476007)(64756008)(66946007)(478600001)(5660300002)(6506007)(26005)(122000001)(33656002)(7696005)(38100700002)(53546011)(186003)(4326008)(2906002)(6916009)(71200400001)(54906003)(66446008)(7416002)(86362001)(76116006)(8676002)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3CGfyNJz7DPyTk5ZLS/lUqWSglqeCVh9bZkIfq72JalaAZCatUGs43EZo3?=
 =?iso-8859-1?Q?+uG7AT73FQFAZyPbE+vIC9Jfrg63vDjRcvu8BRXdPuHRDybR8EHL4HeqjW?=
 =?iso-8859-1?Q?Fs+zBgus0881kWWm5jETzTNWtEdvf70b2y3DIKEGfM5B+galQyBcB3mNDc?=
 =?iso-8859-1?Q?8tvthN1ykDoeYPg/EieHF9wu4E+C/D4bCH9GTlNVxsnM+xptieqSZ34VzA?=
 =?iso-8859-1?Q?Kjv8lkWZMatCOsIUc2BUKltxc0tjd4Itlv3UqBIJIQXlQWp5CdgIy1tu+a?=
 =?iso-8859-1?Q?8fl5oTaEJ9HHVrdemlLQpv2Ztke4vehAXijvUAbmx4k4X1uSL4y4vMGuOn?=
 =?iso-8859-1?Q?bcUZ23r+PqUpDDi6lra9V8m2F03GLJ7KP+n/2CxnvI++xM93qAFCi3lBDT?=
 =?iso-8859-1?Q?0IKWjndAYESSBuK22tR+YUY/pLRem1qjEsyXncInvFrh5Yy3EI43ZRSI7x?=
 =?iso-8859-1?Q?gF8S3vObol1jcn7o61+j9KqwSyFd+mkJotKWasHhQvUf4wOlifXD386o2r?=
 =?iso-8859-1?Q?0HfAILo9ba/AbCJWzV+fejZ9NIBVzcqmhp21ENQfI1ZvjVWbyCSqBh+V/M?=
 =?iso-8859-1?Q?hIFHhXCoeOXiLhB+O9tdBcXnff4nAcE2smJzqLZ62ZIEjzdnvw+x212HhL?=
 =?iso-8859-1?Q?/WcqyhXXWoFFrE6SLX+mOBMpDVBORrnR2sATv9eltZBXaMUjtkkUx/LsmZ?=
 =?iso-8859-1?Q?rWTQ5XU+MCWYxFZhbGAed2iiPhQ1H6lVi7Jw/GfkrdoXc7dr1RM02yuY6u?=
 =?iso-8859-1?Q?ApzBrzTjSagXf2sbuZIwSQcf2KNDEVGiCpMTi0Wfof7t0TK4wmTYLiosKH?=
 =?iso-8859-1?Q?+yMcU2UKu4vg0PvYxnaH8tipdoo9Mlwkk5GyKv1/Ase3aAp4Yea+PJZTE7?=
 =?iso-8859-1?Q?H3OXWbcMq5r4c8zI/gpYmtCgwItJg7+nKHKNjGkbAIKzlApxKMG3+32r+4?=
 =?iso-8859-1?Q?elERcqltIUYJ6xLKv3SjQwRIbXmqdN15mYiPsjlJHjDvHrF3mxwtZ27dL0?=
 =?iso-8859-1?Q?sxNXVXdgDpZ0QBXNQK72Fh+DyfQhcI9eE8jfhcx5XcbBZ0BMjlrToUbjc+?=
 =?iso-8859-1?Q?QwRbBmXZEPJIacDzdDabYScJhEN83YrVtAXeemwI9gVSw4YJMl7VgIIEyj?=
 =?iso-8859-1?Q?Q0On9Ax9koz8IVzLXtrR2hDhb4CRMNTVjN/KkoZX+aNiwBUK6uroxEZit7?=
 =?iso-8859-1?Q?BE0d51N/xSg7asV5qWIce7Rzlh/qztuiYxIloAysUHeVHPV2b92iXJLv1V?=
 =?iso-8859-1?Q?91kUSreYN0kjy8UAy8ewTz8WybE0SvsNXOSGlVIety5za036nWSFbkwP3p?=
 =?iso-8859-1?Q?4k/i/LZnRCAMZzceKdNOj52MpsuvUGvI8sj69BKK3JeUBKOTvmvQjL66ib?=
 =?iso-8859-1?Q?SupcwdJbmp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9082377-f3ac-4d9a-2d83-08d9300748a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 14:10:08.8810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9C+ugyOHR212yxdY7/Q8iLf+9FLjl0oJ+kWSbi8pL+YfpdM8SYtrtFHmR57kQ1OCatOLdNGYbtdN9U9FdSEXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3056
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15/06/21 20:08 Vinod Koul <vkoul@kernel.org> wrote:
> On 15-06-21, 06:36, Robin Gong wrote:
> > On 15/06/21 14:08 Vinod Koul <vkoul@kernel.org> wrote:
> > > On 15-06-21, 01:55, Robin Gong wrote:
> > > > On 06/11/21 21:51 Fabio Estevam <festevam@gmail.com> wrote:
> > >
> > > > > Without this series, SPI DMA does not work on i.MX8MM:
> > > > >
> > > > >  [   41.315984] spi_master spi1: I/O Error in DMA RX
> > > > >
> > > > > I applied your series and SPI DMA works now:
> > > > >
> > > > > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > > > Thanks Fabio.
> > > > Hello Vinod, Mark,
> > > > Is my patch set good enough to merge? I remember someone else are
> > > > requesting it from last year like Fabio.
> > >
> > > I have acked the last dmaengine patch, is there any else required fro=
m me?
> > > Which tree will be this merged thru?
> > Thanks Vinod, mainline is enough I think.
>=20
> I meant which subsystem tree will this go thru :)
I thought the patches with 'spi' tag could be merged into spi tree while
'dmaengine' merged into dmaengine tree, the rest of dts patch merged
into i.mx branch. But from HW errata view, maybe merging all into i.mx
branch is a better way?

