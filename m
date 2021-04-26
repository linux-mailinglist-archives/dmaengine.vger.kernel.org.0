Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B836AA0D
	for <lists+dmaengine@lfdr.de>; Mon, 26 Apr 2021 02:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhDZAgs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 25 Apr 2021 20:36:48 -0400
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:10625
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231247AbhDZAgr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 25 Apr 2021 20:36:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/5fYQEg5ci9itH/m/aPjsWLP4c+0fD9gqUheqcyk3M9JNDqqzhwDgRgs2HG5cWjKkAqyII0m9O2PIVePunlgGCHGeQpK61DnDxk4ccqctDyNlZ4IZhe5xPXBTTwEeiY7aghB7AmswzY4n+i2hLjlwaCI0BUcIGSddak6eczDU5Rgx9XWF3C68lzo7Duy1GCd1MSoyfPAvdjtVacfWbKnAdiswZ/x8iUwpZDW82nJ5RyBmFIcKfkVR7ul1R/1CQRQ7OcRarGIx9+D3RTB5xK9lmNMY2WK5PzHoATB7ugNxBubIOrH4YCoqHWFy9um06yK28dmLGwuQszphFS7jicMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTrCjZvY8LUctN9eZxKsE8A+U3DLXZbj22crYpDT//E=;
 b=OfhbbTUglWx3kmUXAceJXagubFHSd2a/9o3/A5d2P72Xbx8YDzW6s6ScH5XauXqNkpF0D55iLSHYP1nyj7qQbTASGSB2Bh+8RlnftgPoynrPCDBflIP8wnuoJupu8VQLY7g7f8WJeB0oq9DMFRvwj+q58IsKIajj9I6vRXF6fFHD/ggII5PIBSKJ7kOPoBwe1/j8RG6jP9DCRwkp1wiDMhzxkPiMxLTbZLkjqicBFVAXHRo2hpxfak5F26Cyo61omqk5o1bNY0b0rfNfhFWyf/gpWkysLAV0QZoYNjOyw0PGXt4NNd+q8mLgbJHy1s9t1WROGLKaq5NIT2gesd47Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTrCjZvY8LUctN9eZxKsE8A+U3DLXZbj22crYpDT//E=;
 b=GhnYiHzG0tq6uimRUg5RZ0J3wGFqCAOWgK7YMNg3lwk52Daggo1O71YRTdaBUJYpdz4uxyDnRR3zQsEBZfLKewRCTEriVvMcCoX4GOhAKkY6KWceE7yfca2Xh/OTtmBuGNTRs6bhoA6CD0OXwTFprjrkkd0TISs4U/4fJrKcod0=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 00:36:03 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::de2:8b2:852b:6eca]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::de2:8b2:852b:6eca%7]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 00:36:02 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] dmaengine: fsl-qdma: check dma_set_mask return value
Thread-Topic: [PATCH v2] dmaengine: fsl-qdma: check dma_set_mask return value
Thread-Index: AQHXN93OPWIlm8wqkUag6MExaFEFSqrFbbyAgACKiIA=
Date:   Mon, 26 Apr 2021 00:36:02 +0000
Message-ID: <VE1PR04MB6688E678794C807DD9B18C3289429@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1619170187-5552-1-git-send-email-yibin.gong@nxp.com>
 <YIWWg6fJFjMgb65m@vkoul-mobl.Dlink>
In-Reply-To: <YIWWg6fJFjMgb65m@vkoul-mobl.Dlink>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 317b0016-1ea8-410e-9536-08d9084b4533
x-ms-traffictypediagnostic: VE1PR04MB7423:
x-microsoft-antispam-prvs: <VE1PR04MB7423A99899A1E1848EFF600789429@VE1PR04MB7423.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBLiBo8sk9BS1axfKGR1WCQESXh8+zcHhrP8rCYSNSETARA0bhaGydN0ryknpcVTlf6nH+AvUfM68Gl3HUZheHq99RS2rr+dHWqxDBMRQUMPLoAFTEp72LifzaAcUgkiqVPtWnxRxeshXJhEDjpwcieFVoT4WNHOImim4Lh4f2iXuoUvw1S+tTqK2xLCh8qFgKTEngq3Bpc4YafL8qpjza3C1I1RpAQigQRZFaTBiHB9OR6rrnriV8MfhWLHDHZQmDwkgjneMvtTCDeq0PpL9uuchex+hWGCu3JbaQdTLjGXQ+rNCeLC5coQ07rhWPte5LA4i/6uo85SVDCPX9OvWMymHW187ri9tMFNy6XnaHjp/+NhbiLodAtFO3GbbRkPpkNtw5L83Q2yLJ7T9ktwh0VkSAdKJE2RlK7NIEAfURHTRvVV0yguSW7hOk/xNGPFKIyqRA/EpM2BKRQhgkGEUDMOgb/j+fCvlsVWFckX75NHAGbkYh2TTLEhIqX8PGA6m4dAcX3Z0iOQvvjXkvpxhG5d8NOf8pF3MXfdsBbpVlDfY9LoCPRcP4NyOkCwU6j52k3Q3IvLqGXYy4S6lkO6eoGE71u2GYJBKOnesrla5/A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(186003)(2906002)(478600001)(38100700002)(6916009)(9686003)(6506007)(26005)(86362001)(53546011)(66946007)(122000001)(33656002)(55016002)(66446008)(5660300002)(8676002)(316002)(66556008)(64756008)(7696005)(76116006)(66476007)(52536014)(83380400001)(4326008)(54906003)(8936002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ulTN1T8ygEtha28JnVgK0x1zs2OHZCIdRJkwaQ+TC/Fu2qLBcLpkR5M7KMfI?=
 =?us-ascii?Q?8crR9Lv2AWwc5RSv+rNq3Atg2w6qrbdK9VOMp8EAxSsbABnmjU6WdTsfAg+f?=
 =?us-ascii?Q?OWlhPru3QKeCT9K0lU3DhpsHYFmQ8yD0N7C5BBBIiF6Mg0BIbtXvh40K3KY4?=
 =?us-ascii?Q?1nNpskMVvydcJr5zNqBI6eLou6cl9fOQWrVpo4np8vfeWdQjyjF4uUmtfkPM?=
 =?us-ascii?Q?x7WWYbCosW4ZWNRWqOog7WhKqFt3Z66ICTYxTNXVn86W1F4lr7GA2dC8yvac?=
 =?us-ascii?Q?HaO+4SN1qpaP3fPAyPdjgd9EkGAqtM2hhhjeCnM1eoXgu4yDCaWQdlS54w8P?=
 =?us-ascii?Q?vf4e1P8ZnCSE3qm32r9QTHUkpWp2Wgg1WJ6HQHGfdQpWA4fG3IqEMu6hQL3X?=
 =?us-ascii?Q?gP7VB1eYCJvk8Zc1d6TSHgF3PXKQoJQxW1U+6WXxrTsK4VZtTAQ97T6l7/Ne?=
 =?us-ascii?Q?fM5taTbVkNVvRrPRb/a8xAnCyFL6IWJhheIeFeIvdSfcJdLAZnZInk9Zv7LN?=
 =?us-ascii?Q?vTHoueKgsrOumRfzUzwGBPNEdBvc8SNjqWpD9scm7N4N5mYTacvE0NdhGezK?=
 =?us-ascii?Q?/xHV1xnsrGcXubY/d++ypZlMLL/HyoPWSRQNQnL3ZTqxIB9xrTxmMn4aPkA+?=
 =?us-ascii?Q?0DmmpvwC6RG63XAM1X35XEizKocWZkupXPT4rKYdaKsnV+PFeKdUfxKtGhvW?=
 =?us-ascii?Q?GuT4qbtq5ltMCdTBoLyvEMtW9x/B2hfPiQJOS+Cb8j7SUkvyOUnZq+Z/Z8wv?=
 =?us-ascii?Q?wvcyANZJoLy+ZzGifwYWFNyiuL4JrS24GcBXY6INB0b+8a1mMEXDuf07zt4W?=
 =?us-ascii?Q?DZ9XwzG15xRTsoB4EQEra9xBOYJITgJaAqv4StTLjar1xVUhmCr36XS1E4Vu?=
 =?us-ascii?Q?7RTSyh7RxRQMQ/8P+maCE43cN5RVkHWT1yd6C/En2tPm1SdwOz28HOL+mcR4?=
 =?us-ascii?Q?YCfDQHX5tOAA8Q7sounjpr8bwUBIHekGMFRsV6lqmgihJ325XoMmEz5kMMAv?=
 =?us-ascii?Q?ekCvzQ2jHeZhaWloPqoCr+4eHmjGZE2/3FOkDCz198m1fZxAr+HBs7pQU4eO?=
 =?us-ascii?Q?LCWXN07UVGOrz0NZ3pWEPBGYmRsUu98oxrDMtdV92mldcikLfTXUeen12Or4?=
 =?us-ascii?Q?1NjxnHbJ9Rva9Tpr88JRz2NjAAsVflIe6QKCSCp2r50TrGGEe8rKqMA99ITL?=
 =?us-ascii?Q?WIwMa34O2HXhAEY+9rvLG0W27W8TL9Ugt8l/+rUVDFLho/xbcsNFbLP6xOLf?=
 =?us-ascii?Q?0CjATBTOeiM5pXt4Se31twqADMXl4ycLkhgfcAQLzDnmXCyIatzw3lEEdtkD?=
 =?us-ascii?Q?5rVJ9pb//CxYuTOLustVwoZT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317b0016-1ea8-410e-9536-08d9084b4533
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 00:36:02.4994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQcXn1laq3SqSjh4dnAyS0YgCfhyejYKT8yvlXM4cuzV02HlEfG4HBG0iVrS8sLyH4RTrM2+w4nP8L9cmX5Dnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021/04/26 Vinod Koul <vkoul@kernel.org> wrote:=20
> On 23-04-21, 17:29, Robin Gong wrote:
> > For fix warning reported by static code analysis tool like Coverity
> > from Synopsys.
>=20
> Please mention which warning, also Coverity id Do see other patches which
> add coverity ids
>=20
Okay, would add it in v3, thanks.

> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  drivers/dma/fsl-qdma.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c index
> > ed2ab46..86c02b6 100644
> > --- a/drivers/dma/fsl-qdma.c
> > +++ b/drivers/dma/fsl-qdma.c
> > @@ -1235,7 +1235,11 @@ static int fsl_qdma_probe(struct
> platform_device *pdev)
> >  	fsl_qdma->dma_dev.device_synchronize =3D fsl_qdma_synchronize;
> >  	fsl_qdma->dma_dev.device_terminate_all =3D fsl_qdma_terminate_all;
> >
> > -	dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
> > +	ret =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "dma_set_mask failure.\n");
> > +		return ret;
> > +	}
> >
> >  	platform_set_drvdata(pdev, fsl_qdma);
> >
> > --
> > 2.7.4
>=20
> --
> ~Vinod
