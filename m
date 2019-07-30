Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5107B0AD
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 19:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbfG3RoV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 13:44:21 -0400
Received: from mail-eopbgr740113.outbound.protection.outlook.com ([40.107.74.113]:37649
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731699AbfG3RoV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jul 2019 13:44:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1+kkZjZL3XExNekGJglFZU2SfWUrzVVZCIaFGHHIrpHz/vuzqQQyn90xyU4JaDkW7tct7xbwELvnq1637t0tzuEQH48i6WAGCTsngjaDyKBA9jMDrYET8+ducgn26/bseo6BC//bDmg8ELhrCe7zfpR4AaTY1W8jX5wLuCn6uAeiELMEAryF5NAHpIAxJn8RBTaI5duRVxg9NwljdHGDFJCbWMgbfr5pIf69JixoBRuq8pjfEZeBQ3FJc4WdHVCpZvD1eE3HN1cBg4Dd3HyblZwVyr0tbB+c2TWY68AO/m5mx/irTDkySFvQtEM+DrrhLYlBv7cPDir2NUA2FQ4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG+mgJGml+VLKAIGTjphO5Z0KAYO/Qs0X5QNpvriwvI=;
 b=PW+c7GD9/648W5Epk7EfzgmpjTr53M6gSImrXKV7O2YsnLruO2occ0ZI5/LnnnEZjcAFDDtnZae5RTip5aaGUJNgPdew/z5Dwa5endNdeDpJjJGcQtC2ShFjGA58Jp37M8hTWH73/7z4COamUiTbe6U1hvbo4RZtcCuPburUPzuSixmKo51G2O1L7PqZn0RPiwdnEk8CB9lZMSWvu0ZgmPYtkhz88CHiVQN1yajNu7OayUE7FDPv/oLTKORkcVrcpcVh9ntII9Pc0N8nrjpbMwiYwfqL+djYFzLMR/ftKBMvett0pMxwXLQL2GbB8cCdaVftRWlUbzqy2yxY+XeU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG+mgJGml+VLKAIGTjphO5Z0KAYO/Qs0X5QNpvriwvI=;
 b=qhEQJY1lSlez3T7mcAVDK3p27GBrL4fLfsXRKY4/AcuqUFA4kzctiL99ETC9E1KfwTvpo95CE2qLvRHly+ZKKvViD7uEikkiohmoY5oxfnG4qmEJIP60kxraaUGsBwbax8qxQ0hsyWfnfheljYsOEhzmtEsUzqOYOEGj6pehrZU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1023.namprd22.prod.outlook.com (10.174.167.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Tue, 30 Jul 2019 17:44:17 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 17:44:17 +0000
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
Subject: Re: [PATCH 11/11] MIPS: jz4740: Drop dead code
Thread-Topic: [PATCH 11/11] MIPS: jz4740: Drop dead code
Thread-Index: AQHVRv5prUMgGonT8UmT7v+ptlQ2uA==
Date:   Tue, 30 Jul 2019 17:44:17 +0000
Message-ID: <MWHPR2201MB1277B22F5752232A50F9DF8DC1DC0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190725220215.460-12-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-12-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:180::49) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d19d8d58-31f1-49bf-c0b8-08d715158b5a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1023;
x-ms-traffictypediagnostic: MWHPR2201MB1023:
x-microsoft-antispam-prvs: <MWHPR2201MB10237A12B4BC9DD36D749F00C1DC0@MWHPR2201MB1023.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(376002)(39850400004)(396003)(189003)(199004)(6116002)(53936002)(66556008)(52536014)(8936002)(74316002)(71190400001)(6246003)(76176011)(71200400001)(446003)(81156014)(81166006)(476003)(64756008)(6436002)(14454004)(66946007)(66446008)(26005)(33656002)(256004)(7736002)(305945005)(52116002)(186003)(386003)(7696005)(55016002)(6506007)(486006)(66476007)(99286004)(102836004)(2906002)(229853002)(44832011)(11346002)(66066001)(7416002)(316002)(5660300002)(9686003)(4744005)(6916009)(8676002)(478600001)(42882007)(68736007)(25786009)(54906003)(4326008)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1023;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CfE/YTEaiPc2vw5PCYZ7HIZ6xGjGjl8CCpXtF95Q975bD9E1o4gATxtLXzKx3a13ylRszvkGrcKwXqXVJo2cGWgA6hs3oP+CSHCouISXmx4FcqKzWq9MeD2QbiJgWUca+XVhs83dWl+hZYXyXyoUzH2sJQf3AvJpM3rPn04aaBJpTAWxvU2ZFLwX9fQKN19kdpJdnSBi9aKBQLE6+6emPsA2kKfJNm9Jv3gaNx5c7zWOQtW4G6C8PG6mMy43oM2K8o3VfTC6NCekkzJd1kXJmOxoFK1l2MCoXDbFDG9s2t8Q0prGSeiiOep4tYAgE23vcCU4aXbynqO/sIln5RSb6t7743rWNseNVrXkUCRTNk3ZkQ9R0wmsQb0PfrdkUcTL2QGkb1AAtzDwAMSEvXta/TKbm+7i0iya5AtNrbZVMJ0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19d8d58-31f1-49bf-c0b8-08d715158b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 17:44:17.5553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1023
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

Paul Cercueil wrote:
> Remove all the source files that are not used anywhere anymore.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
