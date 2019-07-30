Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBBC17B08F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 19:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfG3RoE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 13:44:04 -0400
Received: from mail-eopbgr680101.outbound.protection.outlook.com ([40.107.68.101]:24614
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726432AbfG3RoC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jul 2019 13:44:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOfQxlovo1hBnVbQAluJHM/Ho8mIKjzsBvE3H2vHSzXOLBivuEpzq93nkXCjBBEr8lwcKbyRIWOJ8H9KqsCdUYKU6trN4kB4wqGBx17UJ8HSMw1rg/qZ31fHgIdeavhnlOtuwELERPjztaiejdbAS/VKwOV4qtcf3ODGImUhZ48Lw7RLz1S50J1zo7OqxEij6I2L4dWT3Acrm79GKD80TNg0jyiYCP+CQxvbFS4GUeVKh5UexTRJIbn3bEg0i3t02TGBQx/cxS3LMabFaqoUHon7m2jyB7oUYZhzL3fiKbOpWtatgrPpg4j90pQjLExDHW56Pa7fcG89C38+WdqhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/9kVOmtYsGf1tTebWAncnxaLOdzGNqeJFHrw8PAIig=;
 b=g20+BqRmKn5m+ydnJTid0pTU805ioMp6O9BU2a9/SIkz5mgivPZ7XZSAb3stkgQYpJRTOH/lQnYetMJFtN1xP9CrT/IC0ZU+7LFUVrBm/cAwBIRX1m89dDBFMb+qwKSTGMe0OPv0tImLjGbqmwsWY/wh0OjM4w0A8C683SNUcL55RW14F0cxE/H8p/xKx5sX46ej7iKsP9hmusu5Cbjt0qzJPp89DHxLpjJkQ0V3dYN+mAqimp1TeluvyEN1hc0HPyt2GbPKpI6HVC8/aHdqRpsOCl2kkqwWVZ4RS+v42kBmPLUiwOn/rdLqG5PQknWCop9ohtubK+ylKSpaKXzwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/9kVOmtYsGf1tTebWAncnxaLOdzGNqeJFHrw8PAIig=;
 b=OCTR7Kd84+HbbSIii4NGmnU/DuaNDCtFnBgpagDHOEFFs+2QmAsQ9RXCsazWdSm0ynANV23aBd5rZXYzzDAAu2EEL5xFCWnqcvnR6VSUFuK2yVcZAGE/JfcJ3aAv9iA/DnvZ77rRrMBD2iqHbFTnN0+lLWOplPS17gH2eg831lo=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1088.namprd22.prod.outlook.com (10.174.169.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 17:44:00 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 17:44:00 +0000
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
Subject: Re: [PATCH 06/11] dma: Drop JZ4740 driver
Thread-Topic: [PATCH 06/11] dma: Drop JZ4740 driver
Thread-Index: AQHVRv5ekaH2UYAaWEud9Ij5KlCMtA==
Date:   Tue, 30 Jul 2019 17:44:00 +0000
Message-ID: <MWHPR2201MB127716344973CCF7640D0B16C1DC0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190725220215.460-7-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-7-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f996696b-f650-4660-463e-08d7151580da
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1088;
x-ms-traffictypediagnostic: MWHPR2201MB1088:
x-microsoft-antispam-prvs: <MWHPR2201MB1088AD4203E51034AED8E8C1C1DC0@MWHPR2201MB1088.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39850400004)(346002)(376002)(396003)(189003)(199004)(7736002)(6436002)(52536014)(386003)(486006)(74316002)(6116002)(446003)(9686003)(11346002)(305945005)(5660300002)(55016002)(99286004)(66446008)(66946007)(53936002)(64756008)(66556008)(66476007)(4326008)(6246003)(25786009)(3846002)(71200400001)(66066001)(71190400001)(7416002)(8676002)(6916009)(76176011)(81156014)(52116002)(54906003)(186003)(44832011)(229853002)(476003)(4744005)(8936002)(81166006)(68736007)(102836004)(7696005)(2906002)(6506007)(256004)(33656002)(316002)(478600001)(42882007)(26005)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1088;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tf5EMwgYP0T534u0xmhTITDu93gIRV/ChAJaMZx4jg2khl5SV+KJsHt2FW+ixU8t3B4rGzzzvAT/Vj7jGh/R6P0ACIazIZXz476u45whx89Avs0FnPHt5ODkDJ6tyTLI/Z/HdXXV5NFBiOKEBQZTacGAcNSJ5N2hYEQCCZ/9mSQlr8HeYEOLFYhqsAaZ2y1dj+Jl3KRNj6VMMEEH+UPVq/Dyo3eON7Z+30XPAYbrsDik+lVd1jQKPMzKh/XXJc1YaSpQAzCEFSuiKCMixRRYA8+YZHe6aP1Rwkh33O+JJz+kjdSsbN7AyiEMH4r5K9Jq5l3WCaVZ8LOZ1/fZV5iJa66qFZ9RM4uiLIxhHQrS4G2RuE6Sx7b9M9hR2uwXcu7MNZqQPJGj9gNZoWJpdrcH/NDwIK+5XosA6obzAnmKM2Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f996696b-f650-4660-463e-08d7151580da
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 17:44:00.0382
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
> The newer and better JZ4780 driver is now used to provide DMA
> functionality on the JZ4740.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> Acked-by: Vinod Koul <vkoul@kernel.org>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
