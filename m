Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936007B06C
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 19:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfG3Rnq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 13:43:46 -0400
Received: from mail-eopbgr680132.outbound.protection.outlook.com ([40.107.68.132]:37763
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726432AbfG3Rnp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jul 2019 13:43:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHKJ6MBBxAKF2whOmS5Bk+w3OAIwjjgysjlr6J1nJOVUseyb4tG85iGdf/0/Xq1fderjhEdjjcRgEgfKWY48KVrA593Y2nr3Ib0OQkkgwEloRIl3ukjGFRGgFxFNlAdfRLrLgES94xso8iDtqmJMCpeabckHya7EblYqjWwcGefS1oH/01ODc2Hh97AJDsMTeHGKOJ0A2zREuIVjc5t5AO4n/qxV9loso+thEoDcqoYQnL8KVmP8ihT+F49H4gQiqGnW7ipQtR/v9r9Gqbg4TczjBwEi+VopmlvhvO0JmkNol3ik4t7d4zToNGgAkVGArLjEaaoz8DqcqohU9vvnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeuDWkU/r6uI1NbxsCKBz6y/i7szA6zYECYktHMV9VE=;
 b=LGSDOMsaddMIttFo5j3EHF8MTIyydjwGuFL7Cv3fCBXZEd4pxlYK+MgVtVJZGnn4radjSC7ZjSiW3uQTDXkPi92TebjCuBBz/Ohs+Lpw5+WZSXBulLhUpWvDm7WE75zXXlwUFL3Xfr/kZZmFJBZQuWa5XOQXDnSn4fV7pn2/ZOoliy/9C5VqCI5TVMVn8+ObIJEWP1X2ITijYN64152DTAhAG2JYDheIhVUOp4ln98vYnAci9+jWXZ02TT9XLl07u/TDY95atyRJv/w6Kuujsbxi/+K3Ua1qu8tCcDpyKggYZEx+pdK71kzeT7J6Srg26uM5ZqIbocDrS0oaHlqjzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeuDWkU/r6uI1NbxsCKBz6y/i7szA6zYECYktHMV9VE=;
 b=i7SNH2BmvkwNKet+lwUtURmZlSwqXCIdAZHVCKHrdDhRPt+/xdKsdYyPW7r1VTcH1DPJCc0V2O6BlkUaULPeyE1OnsieiS8jzeKE6eFBC2r2HbQVMDrAb7S0HyuZJTuD5t1gVQze/a92AUjC+qyt7XpERloQWlvSnusZCNgSgjI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1088.namprd22.prod.outlook.com (10.174.169.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 17:43:39 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 17:43:39 +0000
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
Subject: Re: [PATCH 01/11] MIPS: DTS: jz4740: Add missing nodes
Thread-Topic: [PATCH 01/11] MIPS: DTS: jz4740: Add missing nodes
Thread-Index: AQHVRv5SC/UNRQ0j0kSBIM7bj9GbPQ==
Date:   Tue, 30 Jul 2019 17:43:39 +0000
Message-ID: <MWHPR2201MB127769D32FAA4944F9A791CDC1DC0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190725220215.460-2-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-2-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0037.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::14) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ced0446-cc98-4527-5f3b-08d71515748d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1088;
x-ms-traffictypediagnostic: MWHPR2201MB1088:
x-microsoft-antispam-prvs: <MWHPR2201MB1088E78D70BEA742AA3314F8C1DC0@MWHPR2201MB1088.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39850400004)(346002)(376002)(396003)(189003)(199004)(7736002)(6436002)(52536014)(386003)(486006)(74316002)(6116002)(446003)(9686003)(11346002)(305945005)(5660300002)(55016002)(99286004)(66446008)(66946007)(53936002)(64756008)(66556008)(66476007)(4326008)(6246003)(25786009)(3846002)(71200400001)(66066001)(71190400001)(7416002)(8676002)(6916009)(76176011)(81156014)(52116002)(54906003)(186003)(44832011)(229853002)(476003)(4744005)(8936002)(81166006)(68736007)(102836004)(7696005)(2906002)(6506007)(256004)(33656002)(316002)(478600001)(42882007)(26005)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1088;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M1ii7ytiPwEAhGxpkKFJMpHe2XzBeS7zQo8zdz0nU6lzNoPhTDPxi99uwN3zo6hj9Pf9bP6HmkFKqesN5qbGRkV62/cGIFXHZ4SMNRoknnIqBQpe/pVjzrWctk6h9ekEnNE52Ds9pOpaWUdLKtBEIxJcfHC/oednXE1SCLWfWbz9JEx20vINHkZxV6hZv4VEO1MtUWO3ZaVMpBydPQ5xY/118hYTVWBZNpZKiLitJ/Vqnoo/9aTIeLwkbT6Zf/h6qhINuXuVCBCLW9F2S5sZ8F+ZjwH4x49PPJ2FCQCRrwTg1v6WcWVx6jo4FwMVqksuvb2vWFBTKFvlVqiCkPpi8P8i/psIIiSVSUhaA8/yojZJhULM7BCQTS2saQsvSi3tPPo6GY9lGiVe4NPTjpQYrKaYJceIgyb4ahQghUs3/Z4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ced0446-cc98-4527-5f3b-08d71515748d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 17:43:39.3095
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
> Add nodes for the MMC, AIC, ADC, CODEC, MUSB, LCD, memory,
> and BCH controllers.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
