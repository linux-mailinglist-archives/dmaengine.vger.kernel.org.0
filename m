Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95164E5FC4
	for <lists+dmaengine@lfdr.de>; Thu, 24 Mar 2022 08:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiCXH52 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Mar 2022 03:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiCXH52 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Mar 2022 03:57:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AFC8FE56
        for <dmaengine@vger.kernel.org>; Thu, 24 Mar 2022 00:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P56xciO/U4LUlvm1+dOF2/mZb3lniMHq0RfYiyJE6INrExBbFR4q4ALCsl+nwQMzSGUwilA5QM9gwV0cmleVTqswZ0BshSroiBlju1v4ke/crqhKCW33RK6Pte9sjXl3vB8dZlk9NbKy65UjYlDcNa4qDj0UAmIO8sRHDq8y8nCkITuKasaTYbvg96uaxL8uNmiKsEvyAtlj78+mZE3T1PiBrg2O2SsMU4LIrHsX8LwjNZeYiK7UzMDDc8eF3hdOQotED8q65KTRgdphV0qmpY+RlEa2ivybD5qRAjB69IzhR5uFj4wFOxSwjaLYEsKnGyvF3c48EC1f4coaBm3aRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DszY1q/GlUTNODn9GC9z0PVdGZpaqymS+ljaccjmFEY=;
 b=ET2jyLz9vYusofjh+C0wDlVl1kkTYLhIcVSZr9gNAnTr7W8IdP4RrIvz93YJVohYPa1oxqIgHC2q9IS/MLD8Uo0DqtzJZsA1Kq1CbJhOLqF8NojzPSdM+AWAfdJT5/zu2DJeBbgZF+tgd1t1FEOyNR6YsStns2O6JA/MmY/epJ/OlTMjWjv88b8yw4OkAXBuPg0gFealq3l8mxokGmS0sHFNvgAf3td+faKqJMzNxFq3gwZvjbDJRkJQboGwcJsZKR9c/aFWnWp96jYzMYLCpsfigPJ0ZebqFTNi5pc8LtB8YkTt2A6QXDW07IZDCAiJNsxqAz9ZPk3Yt+8JTXcvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DszY1q/GlUTNODn9GC9z0PVdGZpaqymS+ljaccjmFEY=;
 b=QrH3augALdqawMNumIhiWntjZHZCIyTAJj3bLIE/VghRPVH3r4YtYNimVja4CseKJR3l7j+7sHpBRwVegos+mUAIYXJswC+BjN9eyAET8UqXrq2G1MlQ2b79mgzNPh5sC0VGZHKb5ZXzmJPC5C22culZHoEcnyJvz+pQu2+8qHE=
Received: from PAXPR04MB9089.eurprd04.prod.outlook.com (2603:10a6:102:225::22)
 by AM9PR04MB8729.eurprd04.prod.outlook.com (2603:10a6:20b:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 07:55:52 +0000
Received: from PAXPR04MB9089.eurprd04.prod.outlook.com
 ([fe80::bc25:a82e:ab71:84fb]) by PAXPR04MB9089.eurprd04.prod.outlook.com
 ([fe80::bc25:a82e:ab71:84fb%8]) with mapi id 15.20.5081.022; Thu, 24 Mar 2022
 07:55:52 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: RE: [PATCH 00/19] ASoC: fsl_micfil: Driver updates
Thread-Topic: [PATCH 00/19] ASoC: fsl_micfil: Driver updates
Thread-Index: Adg/VApVvnoDPiY0TQSjj8d8eixAgw==
Date:   Thu, 24 Mar 2022 07:55:51 +0000
Message-ID: <PAXPR04MB908966C6F585EFC3580B6BB4E3199@PAXPR04MB9089.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c26c79d-fe34-43ec-503d-08da0d6bb7ad
x-ms-traffictypediagnostic: AM9PR04MB8729:EE_
x-microsoft-antispam-prvs: <AM9PR04MB8729EBA67D4FA27C6B8B11CFE3199@AM9PR04MB8729.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CcqQ9uSFvar8UZ/4b5VeqwS55uRdy75252F/GiJ0QHZfYSWkFjj1euOFtg6UfJ1Pz/uhGkxII6nCvmt/lbiABw7fhe50P/Mw+25M3QGfRD2lgmUI5VU8VYdb3Uf7dMClmaLG4327u/cgt/z8ROVioKrlcCTvr3U5fqX+aeNRCe9izuuzO3rTxlrzIWQGnL/nI3ywef6cOLDL5mURVM7iDyuttdduElXYrhAbozj7bUstL9fmFyBsHLj0yBwLX9SaCS+tpP6oi2DqDT55+gbjFT/RoGvPEUdtwfSv5Kn6X8R/U14FpFmqN2ey+yjz+MihBC1QO3KfGaW4+g7hqsIHrSLhyt1GRlcq9PZfQG+RfGFKdp10yPR9tGhD6pjkzjV/dFegGDGeuhXh6Z0/nFpa+jpugkg0leHCKMP1YpGoE4KD4WVsKooUJBWoELj8sTWKb/pR+TtkA0QpfEcqiUHpxb/zvCtHWVJVbVkBqnBRBRnEmpXU3Vfh2KzfURh1bzOoslWPZtD5049t2ds8fxT8fZqRq2xtxchZ6PfAnwTPKD1DM/G1HBxS7xyV8Mcj4snB5DD3f8OJRU68JZ4l69mMlvyADw5aY7pjtci5vSWrPD5IsQv7UbCgbw0pUf/EnIF3glawZmEBbJDtjrdFYn8VLN6XvCY7B61qLrpeTbfzoPzeUyBO5cH/xK9HYW2RHayiupDLcCCns5ob/HQbA56JYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(122000001)(5660300002)(508600001)(83380400001)(71200400001)(55016003)(52536014)(8936002)(186003)(26005)(7696005)(9686003)(316002)(110136005)(33656002)(54906003)(38100700002)(6506007)(64756008)(66556008)(66946007)(8676002)(66476007)(38070700005)(66446008)(2906002)(15650500001)(4326008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8KHhnKneMMSi+GDSz59nQzblCAjIWrrConbKe5vHk6/AedPM1F/340rb+q6j?=
 =?us-ascii?Q?PiwE7s3FQ+dkxX9aJcJuTmBADoP6ziQeG3H8BpMo6oGp+UpnxUQTZtjFHmcH?=
 =?us-ascii?Q?C1JFPK0sR0FZSmcAxBtUzJZztgXmNWduWZjvUbsxrClufg2//dTvUFWkqBrJ?=
 =?us-ascii?Q?DRyPLfJ3w10usfFa1soTwQ5R41UE/na9/AqKL+wAHmHg6GA5CEmELxGuQWGU?=
 =?us-ascii?Q?4+CQvoH7VZYbg+9YGTzw1McjVDyUDkLr+hYhGe2Hs0V0WQGGHv2r0bu3ZoX/?=
 =?us-ascii?Q?O92NgKvtsdJkrhSXxqtn3ZI/MQ4ySVKWmjIfTC/GyQ2lQKTU0s62Askl87EL?=
 =?us-ascii?Q?S6K8Bv5jGElyNudtLPB5Vo2p6J+ThIBUU+R8n0h00L/dCWudzqn4qIK7JJJY?=
 =?us-ascii?Q?V4FQpb6vmxCFDRlYhjhLJfEq1oe3lbrOftiWS3nV7MpWUkUcLiyrNf0w2Xsx?=
 =?us-ascii?Q?5dZ/a4WEqApx0z5oBDKHPptjrZWm8xWmSRrLeIpzGw0+4/EXPQZAQJQmz4Np?=
 =?us-ascii?Q?A2ePyVCXmCKYX960dC9AJtpFA6+3yLv5Dh7N+GN5wgjUh12uPgjE66+1J9kW?=
 =?us-ascii?Q?XJCh+3WnxcE2ULEyA5ya388b76WBBT54m2njnmYhzDcIe4r03/badPjc+sqx?=
 =?us-ascii?Q?FvZQlQLpeJNWKy22u1CIJIRQiloJmaiPOJSEvq+LOrha2qIixnlvxK3k7QXF?=
 =?us-ascii?Q?k6u/I36F0QZBx7G73mzuCN6dtjMxUNFh9wQW/aYoehUsUyOd4BEppI7nLWTF?=
 =?us-ascii?Q?5hewukt4IdaMw2ntow6nhrhtXxkJD4M22676gsqov3TwavkspKMgPQfaQI4E?=
 =?us-ascii?Q?ZjYsswdK4gmTH/vOuETS/2gdqdJM0TQjTrF30PYbDXpZr5pFmfnRGjFU+PQO?=
 =?us-ascii?Q?PjrxbMohgEKqRC9Y4wpq2eW4BUYcBK7EhRanHX7BqVt4S3p8xGWgGnfayK/H?=
 =?us-ascii?Q?tl1/g1j//M+PLDSwEaA7h/V8TVoP45Ze9AHRZuEoLhWXhfoAEg9UyayNImfQ?=
 =?us-ascii?Q?ji6yL12krObU9Q4EV8zCFU2lQBEbj5eq+uKTUzh1Zrb4FWIg21/WkmFT18b3?=
 =?us-ascii?Q?vqjXU4Zq7WavrWzVFb28z9Ae57PRPAH+XR3WKTp7h5QnGbku1/9HHunyfEit?=
 =?us-ascii?Q?B5Wvut4We2a9GtWB2g6K4wZHKgSUVFaFrAEmT9gk2qgwceYIzL4/pXHVbrWi?=
 =?us-ascii?Q?f7xyxR/MpGaiPGgua7RCxoxoBzCfhsHIkCGYYYC88GtxtL3Pwi4Myjt0HIqr?=
 =?us-ascii?Q?JaKlUSE9RnZj/r6UeHicPNewzz7NAkp8J91dvt6yUfiCyVM3IRHOkXOAocmJ?=
 =?us-ascii?Q?t38NlHLFJr5PDWir9/sRFDtAnI5zrE6jL42OVZQn4oGLErvAFgz9KldtubJ4?=
 =?us-ascii?Q?7ugZMUR2dcLQ7w7AZtWtWlR8+Jr1132Mtt+VJ8RBwq3PYZ8LyD4CEwsCF+Fr?=
 =?us-ascii?Q?lMHh2NozMCsh21aIyAtzE/oDShkLFx0h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c26c79d-fe34-43ec-503d-08da0d6bb7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 07:55:51.9659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vf5MtwyJMcWpxX55GFzPoLloVRuX4dgsXrL6cWcRELNHB8HJ4nUy9eVPkAWianzf2iJGihwpm+KBCSkk5heVYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi

>=20
> This series has a bunch of cleanups for the FSL MICFIL driver. There is n=
ot
> much chance for regressions in this series as the driver currently can't =
work
> at all. The MICFIL needs multififo support in the i.MX SDMA engine which =
is
> added with this series, see 10/19.
>=20
> The multififo support is selected in the dma phandle arguments in the dev=
ice
> tree, the transfer type must be '25' aka IMX_DMATYPE_MULTI_SAI.
> This is set already to 25 in the upstream i.MX8M[NM] dtsi files, but the =
SDMA
> driver silently ignores unsupported values instead of throwing an error. =
This
> is fixed in this series and multififo support is added.
>=20
> I think the series should go via the ASoC tree, so I'll need an ack from =
the
> DMA guys for 9/19 and 10/10.

Thanks for this series,  basically I am ok with the fsl_micfil part,
just a comments for sdma change as we have discussed.

Best regards
Wang Shengjiu

>=20
> Sascha
>=20
> Sascha Hauer (19):
>   ASoC: fsl_micfil: Drop unnecessary register read
>   ASoC: fsl_micfil: Drop unused register read
>   ASoC: fsl_micfil: drop fsl_micfil_set_mclk_rate()
>   ASoC: fsl_micfil: do not define SHIFT/MASK for single bits
>   ASoC: fsl_micfil: use GENMASK to define register bit fields
>   ASoC: fsl_micfil: use clear/set bits
>   ASoC: fsl_micfil: drop error messages from failed register accesses
>   ASoC: fsl_micfil: drop unused variables
>   dma: imx-sdma: error out on unsupported transfer types
>   dma: imx-sdma: Add multi fifo support
>   ASoC: fsl_micfil: add multi fifo support
>   ASoC: fsl_micfil: use define for OSR default value
>   ASoC: fsl_micfil: Drop get_pdm_clk()
>   ASoC: fsl_micfil: simplify clock setting
>   ASoC: fsl_micfil: rework quality setting
>   ASoC: fsl_micfil: drop unused include
>   ASoC: fsl_micfil: drop only once used defines
>   ASoC: fsl_micfil: drop support for undocumented property
>   ASoC: fsl_micfil: fold fsl_set_clock_params() into its only user
>=20
>  drivers/dma/imx-sdma.c                |  71 ++++-
>  include/linux/platform_data/dma-imx.h |   7 +
>  sound/soc/fsl/fsl_micfil.c            | 368 +++++++++-----------------
>  sound/soc/fsl/fsl_micfil.h            | 269 +++++--------------
>  4 files changed, 265 insertions(+), 450 deletions(-)
>=20
> --
> 2.30.2

