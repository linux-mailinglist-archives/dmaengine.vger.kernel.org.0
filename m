Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF347B086
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfG3RoB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 13:44:01 -0400
Received: from mail-eopbgr680107.outbound.protection.outlook.com ([40.107.68.107]:55537
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731527AbfG3Rn6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jul 2019 13:43:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMP/QzEf0VuM8IWrafKDINk2T2z8GcNmrl/jLx+tqT1e4twES5/j6xU9gbDovhzPkJEzE3dHhWz8hXJh8j/YCGquJ2AxXJj0rwaEo+UgL3TPTgDUBxThTNfZIj165O+7Oh+hO7UXT08XH7lPhbCmWpyRB9howdqRvBB9bxyNy6KFq2FfS2WRUw4g8ye/RyWpV+407aQMIqM0x0I1k6/jwqzBwgvHqFVHq6tXWJKLDOOo4FDhptn2DecMENKNSe+K3GrnMUhECGgYcCPcTVHFSt+g2B0vcNFpTG0KPcbJ79x8RMYdE7OftnP1n9sMm419FPRHd+u9KMXEmG15n8LHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1azvV6eumHiivRNRXM+PnIWYwe38H2lX6HYhZSS1cZE=;
 b=I8avp2QAZ1jZRi6bFsduVEuFD1m2wpzcCvxIdj5GoeXzioBOD0E5316XDY1VL4vA6RunmKt1xmEB9IuTSdPVCv4LKiv1ACFqqnPOpmDzGiBADFtCIuhSsJgZmH6+PgMTDNNkNXj4D8NJykPj46u2L65eRI1PyhF9U4AHyswcBHxnQ7G6r2SY6Fx2Ns1+sfC307BT2oJWG4bRQMFQgnapB+Y2Ooa+3WFzpbDRSJeM33meDbBVSH6pYA7JZxo50aGHvagGrkw8U8R4u1XixoKuW5Ze2otPuPWk5Vat7fH+1CvsdmBgrQ2ubDupqxQT8mAEf3qpDkv8F+auH58Kkb8pHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1azvV6eumHiivRNRXM+PnIWYwe38H2lX6HYhZSS1cZE=;
 b=OcnPDdsjNKjfyy7uQE0AHgEgMRQ/VUHeMomHztiPQfldzNSfxNQOqUj7BMZVYiKonBrRT8vxZZhlRjhFANMRll5gzLox/CSL9KuPpjKdcrcVtoh/8rSyedtJA/RBlIWtUiTQfclgh/VgoO6EERNnxtpEhSubXPjSQ/ITOiKM0vs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1088.namprd22.prod.outlook.com (10.174.169.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 17:43:55 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 17:43:55 +0000
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
Subject: Re: [PATCH 05/11] video/fbdev: Drop JZ4740 driver
Thread-Topic: [PATCH 05/11] video/fbdev: Drop JZ4740 driver
Thread-Index: AQHVRv5cl8/uMpmuRkq+nlYbqst7Og==
Date:   Tue, 30 Jul 2019 17:43:55 +0000
Message-ID: <MWHPR2201MB1277CBFBCC5B2A7DCE8CF2E6C1DC0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190725220215.460-6-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-6-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85b3a80e-1ec6-4c08-6a37-08d715157e5a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1088;
x-ms-traffictypediagnostic: MWHPR2201MB1088:
x-microsoft-antispam-prvs: <MWHPR2201MB1088F07BB788CFC3D02B6689C1DC0@MWHPR2201MB1088.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39850400004)(346002)(376002)(396003)(189003)(199004)(7736002)(6436002)(52536014)(386003)(486006)(74316002)(6116002)(446003)(9686003)(11346002)(305945005)(5660300002)(55016002)(99286004)(66446008)(66946007)(53936002)(64756008)(66556008)(66476007)(4326008)(6246003)(25786009)(3846002)(71200400001)(66066001)(71190400001)(7416002)(8676002)(6916009)(76176011)(81156014)(52116002)(54906003)(186003)(44832011)(229853002)(476003)(4744005)(8936002)(81166006)(68736007)(102836004)(7696005)(2906002)(6506007)(256004)(33656002)(316002)(478600001)(42882007)(26005)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1088;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b+5ViTJwLuKjsrC+C+h7lXppVG7wuPQ5cK+V6fKypF6ety+vnnNDd2CY+xAQiEXH99LqgBI3RfBRg6KRhbF0kfM/7qJwv41JsMzPUXEAkGRRnfcok6zY47KIAnpQAykI5I7Un6/UebpkuWO0VYLe3OjI9JOH+aHzExc2ulKohUIAKRkL5fYFZw+fQ50dr0X26lCje2oVYdniz4caCI8ighNS5yNLVfuMrP5XoE2/f2+OmRR+Nl9NP6uNCl8gJGPzpPaKdzOssbvK/BtfJFEdTXMA4g45jIOYjgmp+lqyuqLu8bl95M7PPj/NsHFR8qvD7npLoe7T1UKjn9Apy8lXzev3mj2L+mUNw4xa8/oAFJKKOaoXq0xdkgJvsg+KWccaq8jhgYVug1P59lFPpgQRY62mvtDe6sB7RYdTBVajs3s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b3a80e-1ec6-4c08-6a37-08d715157e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 17:43:55.7367
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
> The JZ4740 fbdev driver has been replaced with the ingenic-drm driver.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
