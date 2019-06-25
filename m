Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB5FB52408
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 09:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfFYHI2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 03:08:28 -0400
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:65414
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfFYHI1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 03:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RmcsshLhS5lUF4ks5ANSNG7Jic53DLLk836Qnq3u/s=;
 b=kPpOaLAHaNYoxEiWkLIGLHBSWYcAoP9OY0xAfYgqD12jv+EH0gVqHNJ0SCfsdyHdoWYaWCm6aTXROVGwnpo9o01o1GBZixxNYg1okzBnZYXfRsWv9lezTlQhI2+OszqcsmAAYbugIi+cBMqqsIAL1yP2JGkc55EoMz+wjb8qnuc=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6656.eurprd04.prod.outlook.com (20.179.235.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.15; Tue, 25 Jun 2019 07:08:23 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8%2]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 07:08:23 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "angelo@sysam.it" <angelo@sysam.it>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v4 1/6] dmaengine: fsl-edma: add drvdata for fsl-edma
Thread-Topic: [PATCH v4 1/6] dmaengine: fsl-edma: add drvdata for fsl-edma
Thread-Index: AQHVIoleKbz2iEWQIkiDkkbU+hW4GKar00UAgAAvcZA=
Date:   Tue, 25 Jun 2019 07:08:23 +0000
Message-ID: <VE1PR04MB66387F57FA3B625CBA5D23B189E30@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190614081724.13366-1-yibin.gong@nxp.com>
 <20190614081724.13366-2-yibin.gong@nxp.com>
 <20190625041216.GE2962@vkoul-mobl>
In-Reply-To: <20190625041216.GE2962@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ddb5d2b-ed12-4a0c-8778-08d6f93be9b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6656;
x-ms-traffictypediagnostic: VE1PR04MB6656:
x-microsoft-antispam-prvs: <VE1PR04MB665603B6CC80439D1A10B5FF89E30@VE1PR04MB6656.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(136003)(396003)(189003)(199004)(76176011)(316002)(3846002)(7736002)(99286004)(256004)(74316002)(6116002)(53546011)(229853002)(66446008)(478600001)(4326008)(76116006)(66476007)(64756008)(71190400001)(66556008)(73956011)(68736007)(25786009)(71200400001)(5660300002)(52536014)(66066001)(8676002)(8936002)(6506007)(33656002)(55016002)(7696005)(53936002)(102836004)(6436002)(305945005)(66946007)(6916009)(4744005)(2906002)(7416002)(81156014)(54906003)(11346002)(486006)(446003)(476003)(6246003)(26005)(9686003)(186003)(81166006)(14454004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6656;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VpvYuqU/mwiWHzPj/DDNNjTOqAiSXPq8Wg/rmeQyimW4GGZNDbKiRg6XZPaqrXzO8EH0ZEYEd2FsVZCpuJW6SN9DDMQuCJb36zDApn7gGZc6j7X0s7t24+DNHE7mfCazrJLqduRjRgaj8j/4fssHPSXdI8RWrNi0G1LnPzuBGeC75Mh3atB0tGGctS+YewAUruqeoAP0o0bGbP7BLqLteHV5UDMZ2Wb1tk7PbSzIyU6Hhdh3Lf10TkxNuYAkHh4BwkxCIHPCbUwAGLpXOHh833mjj9Ht8AGWaWKEby4n7m6ZLrV9WUaXsN9DcRiKdvy4K9tQv8C0G+t3ykUdKTsNAxNXevC8/TwEyIZupkdqlj+7I0Hrtx5mAlvctlbipjICOx4vThu9fApIZJZCzK6zZ/gzQ7X/8NkQpQr7XN+i2zU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddb5d2b-ed12-4a0c-8778-08d6f93be9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 07:08:23.7577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6656
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Okay, will correct it and send v5 after rebase.
>On 25-06-19, 16:17, Vinod Koul wrote:
> On 14-06-19, 16:17, yibin.gong@nxp.com wrote:
> > From: Robin Gong <yibin.gong@nxp.com>
> >
> > There are some differences between vf610 and next i.mx7ulp. Put such
> > differences into static driver data for distiguish easily at driver
>=20
> Typo distiguish
>=20
> Though I tried to apply 1-5 it doesnt apply for me, can you rebase and re=
send
>=20
> Thanks
>=20
> --
> ~Vinod
