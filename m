Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A343DD5D25
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 10:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfJNIKY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 04:10:24 -0400
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:27719
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfJNIKY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 04:10:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdztRfgapVG2kEx3PHGVQ5zQp+7EuCKnge9rulJHcRft5DHEybjgFXXOGM2uM21yNQ3yznqMc5FTB+USvBXT5yyX155BztioUpnOm1Dh+IDizhtcbDRWbKW3etroRKPgp5hmNk1cfbcJWmacQh09Nw63TWlscsMYIoc8bkOHDDqV36/bhukE5fHHcczOAGfm0gGX0JVjNZreBunbqf5fDnAyuYa4XmkaQoracOCTqGzpr4ZiJSkNnkJde/Cc8kr/ERhW2/D4d7w6pbCXMtMd5U6LgBax6P4ambLWmYNFDBH2Zd/I2l0HayWOC+t9+11t3iXN1UFuK+BUFkhJiSnueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsdcaDiZgjM6BdeYqsK3P0pA8rLqX+f0TZWoch4vjD8=;
 b=UVQ19uJNODtiHyGMM2A3nrb2yttmn5rv0MIu+JphIjthuCGa3uBBmc7kOvOwLsfMP6FtXbZ/GT2ZOOyMuVAFwMp8i/Xd1ck4eLMhlSFgNNpkY1miAPxgfZFrEy+9k+YMtL+MVgLOJurZ4j8RXXTx1IUA2u2enP9s7frwiy9Tde2RASp3zsWHkvQiCQBcTFdCtmgdNDusbsDTf7DE1HP6Ne3o87y+WX1HRiMd2qOg13RZo14hHPqp0s8HZ4aTo7IMoOtPoDS1kgHRCuZBcQsbhoKmNVIPNc3IVmN0k69T1hdojFDVQhkXDfLMB21qfFq4sPn5ZEaRPjIsI8VQX4t3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsdcaDiZgjM6BdeYqsK3P0pA8rLqX+f0TZWoch4vjD8=;
 b=d6h8bAndJ/Hxf5vIZhBoGVIVO2Hul2l/G5ZWDE8LVWVuQ3r+knUbVj3tNKGY62NZ4WJG8JB39MvAk24gzLLM81QQd7dYrUsL8+ROis1C1DEaocAqekNipUiUH7zAEq6D+iBaH3UNFxHx7HWzuw8NICoAYdJ50SsW0DYmYVwoY5o=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6495.eurprd04.prod.outlook.com (20.179.233.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Mon, 14 Oct 2019 08:10:20 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561%5]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 08:10:20 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "J.Lambrecht@TELEVIC.com" <J.Lambrecht@televic.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] dmaengine: imx-sdma: fix kernel hangs with SLUB slab
 allocator
Thread-Topic: [PATCH v1] dmaengine: imx-sdma: fix kernel hangs with SLUB slab
 allocator
Thread-Index: AQHVcr1VGWNo2EzDlEmVbBRWEyoOA6dZ5eeAgAAA+QCAAADW8A==
Date:   Mon, 14 Oct 2019 08:10:20 +0000
Message-ID: <VE1PR04MB66386213FCB0ADA44EB195E589900@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1569347584-3478-1-git-send-email-yibin.gong@nxp.com>
 <20191014080215.GL2654@vkoul-mobl> <20191014080544.GM2654@vkoul-mobl>
In-Reply-To: <20191014080544.GM2654@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a226c7a-1c48-406b-8d08-08d7507df4d7
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VE1PR04MB6495:|VE1PR04MB6495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB64957A98BC831A805572549889900@VE1PR04MB6495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(229853002)(486006)(6246003)(53546011)(476003)(478600001)(7416002)(6506007)(25786009)(6436002)(5660300002)(55016002)(316002)(54906003)(86362001)(2906002)(6116002)(446003)(11346002)(3846002)(9686003)(6916009)(14454004)(81156014)(66946007)(76116006)(66476007)(256004)(64756008)(33656002)(8936002)(81166006)(66556008)(14444005)(8676002)(7736002)(74316002)(305945005)(99286004)(76176011)(102836004)(7696005)(52536014)(26005)(186003)(4326008)(66066001)(71200400001)(71190400001)(4001150100001)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6495;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9xBVZnQXUVUzESBrTV84z11xI5lurhaU3DOIKaNIx2h0+3Gn5SycRVyUJ9A41p9WI45DHF0H3YIEY79pq2B0Sp6JgxXFCvDgsD57z8lqBitnYeKTAZg9y9pgaeUBSq8Nq9Yl+U51oQBFAX2ZTh8k3S53UqeCjE51pxwSdcPgEgRek8iAuDiVmcUeKkgNHXIFhO0CmkVOWrR8P6NokBVB4banAgsR0PgS6Mgxpe82RtH3cT+n+2NAwhqzkCqPcRh8spGCahxIrSdjx1H9mUIJlJS+tnztZ+S3WPlbq1rKXRQBkkA1cUZXXukbfk5wgC2hIv258KMS9f8r4nJ5XWB3+HnCw81UHaWgGf7t9LL6rLmzGjqch+ko02F2Ll+dG/bMGAO0Gicx8U0ofGJsYYntPxbzb6kAQKaKz0NPOB9uD1c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a226c7a-1c48-406b-8d08-08d7507df4d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 08:10:20.3686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQJrwwCzbKgOk/4HAE7m5/JS6/Q5rUo4f9TlAijAqAgCsbAI6tSsOWRUY7c7oOkBLypiW+KsrrXL5A0tUCs8gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6495
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2019-10-14 Vinod Koul <vkoul@kernel.org> wrote:
> On 14-10-19, 13:32, Vinod Koul wrote:
> > On 24-09-19, 09:49, Robin Gong wrote:
> > > Illegal memory will be touch if SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3
> > > (41) exceed the size of structure sdma_script_start_addrs(40), thus
> > > cause memory corrupt such as slob block header so that kernel trap
> > > into while() loop forever in slob_free(). Please refer to below code
> > > piece in imx-sdma.c:
> > > for (i =3D 0; i < sdma->script_number; i++)
> > > 	if (addr_arr[i] > 0)
> > > 		saddr_arr[i] =3D addr_arr[i]; /* memory corrupt here */ That issue
> > > was brought by commit a572460be9cf ("dmaengine: imx-sdma: Add
> > > support for version 3 firmware") because
> > > SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3
> > > (38->41 3 scripts added) not align with script number added in
> > > sdma_script_start_addrs(2 scripts).
> >
> > Applied, thanks
>=20
> And after applying I noticed the patch title is not apt. The patch title =
should
> reflect the change and not the cause or result.
>=20
> So I have modified the title to: "dmaengine: imx-sdma: fix size check for=
 sdma
> script_number"
Yes, You are right, thanks Vinod.
>=20
> Thanks
> --
> ~Vinod
