Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2977B09E
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 19:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbfG3RoN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 13:44:13 -0400
Received: from mail-eopbgr740101.outbound.protection.outlook.com ([40.107.74.101]:58528
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726432AbfG3RoM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jul 2019 13:44:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RviucMrb7bRqocz9LC2G3S2nCjFeI5timeG1WbsXgv8JQYIByI23RCIt8Vy9w26MeIFA72dXrQwhpo769lkuTHeCLX85nnVArDG0CyXJ6P/8ST+Dbv+VblcAIjHYPXmDa4NAwzdcASyEQ0H+YsH3WjDlucayzMfkrZytVzSWd0mtLGXJlaM1BoBj8J325rlUMrf+ON/4uQpL+ax0dYXCVXwIghi2Nsxl6JvfwWR2MNpUmJvXt8+eEI5amnhf0PpXzaXJQEmrI8d94RJy6xNLuXI0KKMivQwhhEGUcw8osmcoQGAceDbqVuWWk812Oy6ohXj17JGsKjTnF/Q3/9YwVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHTU9zmPJjPcJnHR862mpbpt9BLI9Xdp2TU5a+bK0pI=;
 b=Bp4z5/kHhEkl4jrydVnCys4H6OD6OiUwh66WDdTX0hMzm+J9MDUQJ4E2DnWAnjLohcdQULIsih1rg8F9S7Vm/jOMboTXVNkZEJvC+2XbnTXiBQ/c+081onBdFdH+gypJTDW4TH7DRZxEqmeJWNKBAXzNBos3v/qEy1rYFbTWyQapLHmwX8oeju1IfGqN7z5Td5yegF8wfGdVMTcEODvo519c0y78J0+vR0Wc4kRfCjXhobV/ZmOdVw2lbel7d7rRePxYrmhyclAwPYum5Vzbrhl7Dbq5L+ze4UBvziixI87yiEfjgFlRqpwQQE52ZPlQtej6qpBVHmauk1JKC92hSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHTU9zmPJjPcJnHR862mpbpt9BLI9Xdp2TU5a+bK0pI=;
 b=BzPoZ/02L8AJrkfU8gHUiE85GslDdMUAmYKV+jPykdzrWnj1DH1pxmTrZvv+0FnlusEegMfWPtLsva19r6PkiIYGTRYS/zkA9awQam9uFcZPhMEqPNI355Xp6WDR7A+J7ymu5O6GyPDCwXG8g47/6204v2mbh294tZeR3JxDxxQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1023.namprd22.prod.outlook.com (10.174.167.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Tue, 30 Jul 2019 17:44:09 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 17:44:09 +0000
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
Subject: Re: [PATCH 08/11] power/supply: Drop obsolete JZ4740 driver
Thread-Topic: [PATCH 08/11] power/supply: Drop obsolete JZ4740 driver
Thread-Index: AQHVRv5k4TjTT1pcZU2LxKlcftx5bg==
Date:   Tue, 30 Jul 2019 17:44:09 +0000
Message-ID: <MWHPR2201MB12771D2BA5082D6000D6C596C1DC0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190725220215.460-9-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-9-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::17) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e951fb2d-2cdf-4873-3c89-08d715158688
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1023;
x-ms-traffictypediagnostic: MWHPR2201MB1023:
x-microsoft-antispam-prvs: <MWHPR2201MB10233100C59115D7E87A6317C1DC0@MWHPR2201MB1023.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(376002)(39850400004)(396003)(189003)(199004)(6116002)(53936002)(66556008)(52536014)(8936002)(74316002)(71190400001)(6246003)(76176011)(71200400001)(446003)(81156014)(81166006)(476003)(64756008)(6436002)(14454004)(66946007)(66446008)(26005)(33656002)(256004)(7736002)(305945005)(52116002)(186003)(386003)(7696005)(55016002)(6506007)(486006)(66476007)(99286004)(102836004)(2906002)(229853002)(44832011)(11346002)(66066001)(7416002)(316002)(5660300002)(9686003)(4744005)(6916009)(8676002)(478600001)(42882007)(68736007)(25786009)(54906003)(4326008)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1023;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZKTtr5jL2TH0M3itAqGi58WW3r+lZ85Szm/ou+rqDdV2Qs9TtFtD361F9feNUZN/DOXkLYSlBQjIDvuYH/E8A/ka5Nhs7wfDjrCxHyXrQ1cMUJfwiN5AgzGCA91TK0rK08igGIOyr3bSeT3119NVJZvwzjBhwtvgRoyFVpzfexUEmW/zAlTLWKz4wYgVSWMWJtBO2ZHiUcI6rtJn5yWANR0BPAg7rXa+7jUemlP9LzdZbmnX/zCAq52q/aDiIdQwldkMBG6dZ/v/nZ/pM+Qyzh91/FWnB91upVKryInbGTmuHZ/rfbvrc4rqerQZE1XWg9t6xvtFmx8gLrtaLvE+LMmu5CBYOPojMiVLtGAAKkZFzw/Wni3elLTBQRd9W4Y158pF76T/tLggbLS9Hzt46NcBcgXT3hvivYrsLWkykMg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e951fb2d-2cdf-4873-3c89-08d715158688
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 17:44:09.4758
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
> It has been replaced with the more mature ingenic-battery driver.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
