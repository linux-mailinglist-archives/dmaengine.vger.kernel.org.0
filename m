Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36FF35D6C1
	for <lists+dmaengine@lfdr.de>; Tue, 13 Apr 2021 07:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhDMFFo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Apr 2021 01:05:44 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:14997
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229515AbhDMFFo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Apr 2021 01:05:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwSCcK/v2StVipCgmiwTujwgruZIt5//mMujkaDndYlcI/8LMYV7xne0RKZ07oLM/MLOVXWyL/XAAH73qKsWkbZXryt7MYjRrwNT95FCPJay3Fs51d3i+kLihNxZhwZxbD7InGcfWbVqTsBFkNjhtdrvh2K8cfXP+gPGSCFKVx6iwN+Ezt8vCpuBjvRx7biZ/tOhr4dG7LaqooOoIBRKFq+UPzBCy32tjfZ3tsyiLLHP+dJf/6Aq8Fe/yEMVKtiOTPZ/FnjEpSvLz5j1QcGOGXzUs3KhT7VRrwl/3TKzYX+mpOIsdpoLL65YwcJf8rnT69ZKfcRnMkhVJH7No28m9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DhGUal6g6HG8MJrji8fMyYRSSuJmyR60Ul2ATMjDdo=;
 b=Nref5o9wYwfEfZYxgxEZjEMhj0YWohG/NyCOJSd7XAzPV45ZdgtVE3vGEvoXxUufLwhjCwrhHfrk1owjwzdbs4QKczies3pxIP/ZJ+jwamV+g/Wy/KdZSz1qBFiQy8NbHsRAUh6TFsBPOE2MEae9NhLZklgt9gT3qsId9VqaQsZYq3gBcL5UgmSeewBoY8WEMjNWDqtr6mdY/O79LnSN8U0UjyHoRdKZFcPNIzB2q27+Q/oROc9bRgWO3ifE1pP3YviWIC1rDCv2wUvOwV66R/CPBTlc864LqPmEzj+4VTaRBhnbZrWU3ZL4+DuwgaJ177Q4fdbCFcr9jfwxeDxO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DhGUal6g6HG8MJrji8fMyYRSSuJmyR60Ul2ATMjDdo=;
 b=AJ7EIEnjRMiJ/4MP6EHHodz7WuqrpIOoAvw31I3ZpQbTb4SSkjmk64ll7gZx1Lo5qP3yfn/GkZGSItoM1zT26FSN9J+P805uGr5N9j6UyGR0j7qOUuoBwqUSkX7pcxw1CpE4ynDfhkkw3YxdcEKlyfjDweS4halCC5Hu71JH3rE=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0401MB2512.eurprd04.prod.outlook.com (2603:10a6:800:4e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 05:05:20 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.037; Tue, 13 Apr 2021
 05:05:20 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v14 12/12] dmaengine: imx-sdma: add terminated list for
 freed descriptor in worker
Thread-Topic: [PATCH v14 12/12] dmaengine: imx-sdma: add terminated list for
 freed descriptor in worker
Thread-Index: AQHXK335jrwJzEXFA0CdBZeUtRWghqqwqGUAgAFCLDA=
Date:   Tue, 13 Apr 2021 05:05:20 +0000
Message-ID: <VE1PR04MB663877142BA90AADDF9B3AB3894F9@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
 <1617809456-17693-13-git-send-email-yibin.gong@nxp.com>
 <YHQVPoQAYVuHL3/S@vkoul-mobl.Dlink>
In-Reply-To: <YHQVPoQAYVuHL3/S@vkoul-mobl.Dlink>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e63d70c8-6b76-4382-049b-08d8fe39bcc1
x-ms-traffictypediagnostic: VI1PR0401MB2512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2512C0ED0E0E8FF911D67661894F9@VI1PR0401MB2512.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FxiBFpSwWH3mmuD/qqhdXSfpnqnt/YIEm3KzWSe/U8JpV1pTsJ7rsMncRh/Se9B39miq8m46yh96Vbs+8A0rvhDIWfRSPC8IF2RgCPnGm1fzLqQk9vbKSLQ2aICIjYLYYGtdJJ8v9RMyr5uZI0AtyuQ/b/lik5GRP7aLRTQscToNzC6wOZwAUEngDeISivLEmZWWMvL/8GMcA0+CeJ5v1a5qCd+oUpiLVYcGlC3oF1v010r7f2AciD8wq0xR/XsP2GM6BpFkgdMI+3tFrU4tysqWAtQE/scib6Y/xt90U2Rct+Mu19t8CHxf5TzLKaq3o5ecCIMznlewL+518TT8DCVrCVyS21LMCqTIzhjnJF3VrrxWDG4FqIR4iR3YjCuTZJfhTSvFzkvzr1RPbG4UGQ/JCTKM97jRMfAL7lsOc4sFDORDck9dF2q6aGT4xygI1k/2n47AFc6aoUXJrhzekv4kONIi7GgvAyfAErabZ4XbhA6gi3XM0OZEJ3bj2CrdwFhVgjBo7ImVd09XDO5HB411WDrm9keQIMGrnje1TB1NqndXmeI190Jm+YYX5uqJxJpRUTodUUJEwVlzpwJU1OWEkv6iFr7QTL5cy191Uw4ab4g9u+XkvtE5KMMY20Rrr4MkOxOglRz3yF7gm2r67VPHBWahTlg35sYlpF+vfPueekcttT7vuaoVcQ8bA3td
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(53546011)(8936002)(2906002)(9686003)(26005)(38100700002)(55016002)(66476007)(64756008)(6506007)(66556008)(66946007)(5660300002)(7416002)(54906003)(76116006)(316002)(4326008)(52536014)(33656002)(186003)(966005)(478600001)(45080400002)(8676002)(86362001)(7696005)(122000001)(6916009)(66446008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5675fMzAMU10JWz6X2pg/q9I+kejCu5xZoM06lTIae9bpckexX5qbGlLXK0x?=
 =?us-ascii?Q?rJWA0c0xQrOEF3IWtRZZpVn8ZusqtB4AM0gD9I9vETbAz6h7Ed29hT2YvjoP?=
 =?us-ascii?Q?l4Tog9W9QsoIGEmFfyuq+fn5LIwtqaAt/ny0blZwb2pjaL8QB7pSVZkXzFiE?=
 =?us-ascii?Q?nqKxOfWCdRRoA6NOVSSkv6enYY5tHf740QzGsLOdP8CtmDIY/OgPLpLJzl7X?=
 =?us-ascii?Q?T6qFo6lHkd+3gCHqVCqKwKCbU/Mmb5Oc12+eLWcd/y4L2oayUE5A63vUp1uI?=
 =?us-ascii?Q?V2L/EahAgyfL1dSJf1kwHlPovV/425U09KTqbEhRAo5GhXwPrxtr6GSjeoFv?=
 =?us-ascii?Q?RiTKnYSi/xDwf5PBpMUOQhFitiXxNTJVZl/gEoOHPFEwIAMvhvWZrNJm2KsK?=
 =?us-ascii?Q?zablFdxCvzXdjUkoaSrAYOarCtu3m0OuY3gMNlNiD8Ksf2VP6Y+YSbN8WN1T?=
 =?us-ascii?Q?mM0e1ilI/oPIMeZ7DKQWb6u8T+uXiyfN0zi4vx/H8HlPspGGWytOCdCc65Ck?=
 =?us-ascii?Q?EgZNj623wfMtXHO3KkKH6ipR426EaZAIzyR9fgm2goqdpmTr+P9XRz1T7JMk?=
 =?us-ascii?Q?vbRZGRmw6cye1eT/RbZcGnlD3yLfZYWgYLC7i36c8mtCeQHLgiiwJo2wBQma?=
 =?us-ascii?Q?G7CHoAQ6F5UEZDAxufqcU6cntWmjT1mvPC52Y1W9HpoktWHGasR7rsqaEAXc?=
 =?us-ascii?Q?5Oz9InUXLA7EaTSB4Yhs2nuMsnqtdLyd0hiz4pH+KLyHCcYfqXu1ogKoYNEw?=
 =?us-ascii?Q?w78yiyBS7mS6GiSDK2IrR7oPQ0oGGw7GgxtrBadkHLwE59WeYcUWqzidPXVq?=
 =?us-ascii?Q?cpCjLwQWOXucc/pY/wfRIuVj3LPOFnVE6UhYBC6w1iymIQpu+RBn7t9a7SUK?=
 =?us-ascii?Q?LXV9ZvWQuXqCy+ShgKxfrtvhIRI6Lh+IM+SRvwl2dkxOPuNmUzp47dBWAWyi?=
 =?us-ascii?Q?z6C5Gei4x6ZWQsJckqTXlF/FMTUgsCiVTQjUsQPdLR26utkckIJAzaoaqwxf?=
 =?us-ascii?Q?I3Xl4M99XGQ79WBnONElcmInhr9A9logsVtwCEKsExQ1dxA+CXMaOgxGIRAs?=
 =?us-ascii?Q?jE10O9nMPpVs1kOK6sY2ULr9HS1rpYxjDldZjpWnhVtRORFawtgF5ZgarPH7?=
 =?us-ascii?Q?hReVrvMwAsj02KCfhn/s/AB2XE4L0O/x/HpTFib91Mdn8ZZneN6NgNpsHsCu?=
 =?us-ascii?Q?7Pe/7zINqvc/rFmUQrH5TaJe444klw773X/YQr1n0MMCyMCEZ8l/fnOL+M2K?=
 =?us-ascii?Q?KIuUZzgr76um6zC+QGpSnF2NoBvPZrm1w/3HKlDQxmp9bjFQYo0E+FcGteMV?=
 =?us-ascii?Q?mITxfFfavE3opyX/kDS+LFfO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63d70c8-6b76-4382-049b-08d8fe39bcc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 05:05:20.3264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7VUrhK/LftswOGgBhEpZ3ObPeIpbcBaxLZsS7977vtrUCea2jentvvtYh31S5ZIsxxPnRgO9e13TEtCwSvp/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2512
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021/04/12 17:39,  Vinod Koul <vkoul@kernel.org>  wrote:=20
> On 07-04-21, 23:30, Robin Gong wrote:
> > Add terminated list for keeping descriptor so that it could be freed
> > in worker without any potential involving next descriptor raised up
> > before this descriptor freed, because vchan_get_all_descriptors get
> > all descriptors including the last terminated descriptor and the next
> > descriptor, hence, the next descriptor maybe freed unexpectly when
> > it's done in worker without this patch.
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.
> >
> spinics.net%2Flists%2Fdmaengine%2Fmsg23367.html&amp;data=3D04%7C01%
> 7Cyib
> >
> in.gong%40nxp.com%7Cf255f329c8de459ffbaf08d8fd96d6c5%7C686ea1d3bc
> 2b4c6
> >
> fa92cd99c5c301635%7C0%7C0%7C637538171591949442%7CUnknown%7CT
> WFpbGZsb3d
> >
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C
> >
> 1000&amp;sdata=3D3YFgzHFDNwRnogvxZpNcwVKOKpk4GHrgScdrbuMKjwE%3D
> &amp;rese
> > rved=3D0
>=20
> Sound like you should implement .device_synchronize() and do the actual
> work there..?
Yes,  I believe no issue here if call dmaengine_terminate_sync() always sin=
ce
flush_work(&sdmac->terminate_worker) has already been in  .device_synchroni=
ze() of
sdma driver. But unfortunately, have to use dmaengine_terminate_all() inste=
ad in some
non-atomic case like ALSA.


