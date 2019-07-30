Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5647B0B2
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 19:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfG3Rnz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 13:43:55 -0400
Received: from mail-eopbgr680110.outbound.protection.outlook.com ([40.107.68.110]:43542
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726432AbfG3Rnz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jul 2019 13:43:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbuxwj7j4adzdv0fmBNfnqhx24c+eYYEuUVqbkE6hJvCDq7LoV0Zl+W7KkbSFqux8s2YY5k3hPZ8az0RxquzZGeLSLGDQJxuwrqd7vqlDlG1pITkCt8ZA9Ge40XEh7mufk3eOYHjYkbL/9iz8I3bYOgN/L0N8q1EWfZ+hINbk73sD5KzjRkGEA/4AUhJ1dYQCgmHst+KYTWNE58UuG9zd0oYsOZ5NkCIxmcBOiCUwucg32N97xnJDGWUteBOHb1hTBCM8HZFuw7xdRJBXyfIKIIezjguUo80dd2uItxrOSodtvseWr5V1al5F+u0Gs6VqW9x9zZV915wT+jKzotBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BX4SU6PwwnhbvyGfv3M6c92ze2YzMLnLwmrICGdzqg=;
 b=ZKsPTX/Fryl9JUC/Tdq/8FJ6jQRq1/JtwW89+fcrOtJOzaqQ4N/MtX6SfEkvC/TYOfWmvnbra+DB7IQICGr+MqeKaienfS+wPA27REAu8UZ6KKPbYvxAQkkxGFZEl6vrQ8lKOkk5rtb8AGYF1bMekFHXiuy/Fj4wQCm7/Km45RL9FbNpl88aMeQ56YoVu5nMkGSX5Pml/09hBQrTZhZyUII3m3iNv2DPAiogUPBLeHr2p6VqnoffvF5BXzAwYzU5dTVf7Vs9ce/ADifT/BWNlmW8bjd3jNrvnt/QwnyvTLO/iLFISvVsJ8yfvhvsHqHia8csSGM+2ZSg/XQUGBQN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BX4SU6PwwnhbvyGfv3M6c92ze2YzMLnLwmrICGdzqg=;
 b=ITnpH7wKokCT6qpAxKCxOTrURLPinYmauj6s0majVYCRV1xr4u/A3dahC9UMgosTrPipIG67IgeVu7lsEn1ZlJdBFctnTK5YaTYu57td3R/OxKQDmwWmTzBOLRxuLvSaMlowDf3NroMRD3XZUTgn4jQ17Bmn+BoqMWsx04RATZA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1088.namprd22.prod.outlook.com (10.174.169.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 17:43:51 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 17:43:51 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, "od@zcrc.me" <od@zcrc.me>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 04/11] ASoC: jz4740: Drop lb60 board code
Thread-Topic: [PATCH 04/11] ASoC: jz4740: Drop lb60 board code
Thread-Index: AQHVRv5Z3HRPuXglA0CFShYL1aERyQ==
Date:   Tue, 30 Jul 2019 17:43:51 +0000
Message-ID: <MWHPR2201MB12774249834C09DBDE719902C1DC0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190725220215.460-5-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-5-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0073.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::14) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6250fd5d-84dd-4f26-1f29-08d715157bc2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1088;
x-ms-traffictypediagnostic: MWHPR2201MB1088:
x-microsoft-antispam-prvs: <MWHPR2201MB1088EF45D9223799A65AAB40C1DC0@MWHPR2201MB1088.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39850400004)(346002)(376002)(396003)(189003)(199004)(7736002)(6436002)(52536014)(386003)(486006)(74316002)(6116002)(446003)(9686003)(11346002)(305945005)(5660300002)(55016002)(99286004)(66446008)(66946007)(53936002)(64756008)(66556008)(66476007)(4326008)(6246003)(25786009)(3846002)(71200400001)(66066001)(71190400001)(7416002)(8676002)(6916009)(76176011)(81156014)(52116002)(54906003)(186003)(44832011)(229853002)(476003)(4744005)(8936002)(81166006)(68736007)(102836004)(7696005)(2906002)(6506007)(256004)(33656002)(316002)(478600001)(42882007)(26005)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1088;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lhq3rr5NngLy/qSzzewAQ7EPGtEV8okVD8OhyyTbH+SjEe+8hGmbbKBx9ItUYQadHktlIVbR10tYRV8nCAQNsecG+lLBr7HGXXNTBemSXc8UC6LOS5Nzsa8uIfhV/IK7kbg+gXy+j1wai8B1gCmriXrYVJqI4hXPdsAYfz/A8FvvuaoTrLX/EQo3zZAkY84UnGbxRJHhKaW9jCKQ0zgwCqJcgOZTiFhRoytI07CSnozo86y8q/gOSLfzmW0M+qsPJ8QbVR5XqVOUxWJ5LoGXoohxTwIjfPzqZbK5ONE/IVf+7buufQ3FHpgfMQTcU2tG2RjErn9QBYz6uX2uBcOa+R9BMo3e4fWnGr6AFdnRrclZ/BGjxuLsBtoG/I24n92NPNjtbi3I+6WcBZUyf2DRbCyINsen1vVdfr1ubN02ADY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6250fd5d-84dd-4f26-1f29-08d715157bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 17:43:51.4012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1088
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

Paul Cercueil wrote:
> The board now uses the simple-audio-card driver.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> Acked-by: Mark Brown <broonie@kernel.org>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
