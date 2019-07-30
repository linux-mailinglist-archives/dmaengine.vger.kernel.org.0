Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C78C7B0A3
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfG3RoR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 13:44:17 -0400
Received: from mail-eopbgr740098.outbound.protection.outlook.com ([40.107.74.98]:3166
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731662AbfG3RoR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jul 2019 13:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRNsShTB3W2YN18KscRiezzbVRVOaHwU++9fONhjG4JaGD6ywGy4SZdIqMOgc0hiKhKZYDFqKG4o7q5lcpa9ynRSR5AqqxtwoPETYY13CTnKqsmJQAKPdn2gkDZ1R1zJPEodWHinxSrfcgI2kiEqjydujKpQDa58UHrE0N2ONJytvJ9f/uaIrCDQ6zNmbDmHzh19RC4ggSkyaLNBakgdtfsBUlCBL+1FsdhQ58nq73cRnXGA+vHa58kgTyWnnS8dfNlJpGl0fu7v7cu7a0uHTeY27vsVWOfBoSRQ1RmYoI3NQvuGNFr9LcwCPWIZwtwywWaZmtbALc/2mKhbiG7Xcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTtK0xexa6OefAxCOUkdSxG1tXcEDaHWIg1jxrq+2Qw=;
 b=m/VT+Hui31gkZ1+NXQQjKrlW4D+yqt967qZuFbu6J1xHc6DNqs2A10LjcMdfgRFbx9VbcueNnqNkbYZFZR4bCJEzPUU0BTus5vwBMms7bvVzK8+PkCc+bCe/DCCFsOhflAP41YmMWdtSasLygsZmA8r+wkd0yWXO5elnQr4H3lPavwxMfsrWboJYUzNkGL6WL541m2aihYYPIFzvZP2pLdG2lx+co7P0LNf4Cu0JyOuzlFKYCYoxVD3J/ggReVJON0WAmBNNM++RFspXYmd12Wo5cgjWkZzpF3l6OoVxNzILnM0y5SuH9vDTCQOfQ/qILAuANVxYQ1KpQyJX9gsgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTtK0xexa6OefAxCOUkdSxG1tXcEDaHWIg1jxrq+2Qw=;
 b=S4rDSpaCNgUAliugZ9qODEgD8cyc6CU5+nYX3+Z4Avkd2kiAcpfn/hkgAUSg30BamFdeteBYlpg2WDVFuGzC6Nx0Y1LCtjjJmuUjwj8sRVpWVHJdRN9y2B4tstrH0C4yARiFKpJQoMGnwcckMmrI3LKwNe6MhqCG8gsg2VN3a0s=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1023.namprd22.prod.outlook.com (10.174.167.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Tue, 30 Jul 2019 17:44:13 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::105a:1595:b6ef:cbdf%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 17:44:13 +0000
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
Subject: Re: [PATCH 09/11] hwmon: Drop obsolete JZ4740 driver
Thread-Topic: [PATCH 09/11] hwmon: Drop obsolete JZ4740 driver
Thread-Index: AQHVRv5msVS8eXHddUW+EWQ0JmG3sg==
Date:   Tue, 30 Jul 2019 17:44:13 +0000
Message-ID: <MWHPR2201MB127717A25A015893A7BCB916C1DC0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190725220215.460-10-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-10-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cefa3c0-4884-4b40-3d1c-08d7151588ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1023;
x-ms-traffictypediagnostic: MWHPR2201MB1023:
x-microsoft-antispam-prvs: <MWHPR2201MB1023FD94F018FD52EB5182C1C1DC0@MWHPR2201MB1023.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(376002)(39850400004)(396003)(189003)(199004)(6116002)(53936002)(66556008)(52536014)(8936002)(74316002)(71190400001)(6246003)(76176011)(71200400001)(446003)(81156014)(81166006)(476003)(64756008)(6436002)(14454004)(66946007)(66446008)(26005)(33656002)(256004)(7736002)(305945005)(52116002)(186003)(386003)(7696005)(55016002)(6506007)(486006)(66476007)(99286004)(102836004)(2906002)(229853002)(44832011)(11346002)(66066001)(7416002)(316002)(5660300002)(9686003)(4744005)(6916009)(8676002)(478600001)(42882007)(68736007)(25786009)(54906003)(4326008)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1023;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wrjsRhYO4vUkdcevYoOPMGH4LmQ+yXjxc1W7WKNRtxI3t/S8HAeLqp1X47s+5RbKb8a91cbBReJCcWJtJHL/f3RoHku19srxbHMUDXhnV4BmObf4APQMHzdfrES+XLzFrBAhTP+m0Mpn5Qsk6NLIkkWVa/OKiaOURKfdtcfxuYl3l025KxqRfLIUQBd4BC2nPzRGKETSYRDmH5nABDVSdPlqQQuF8VwM9C9NxVYDc1FLOopIfKrkBlZOC4WxeFlfxSk14OUP0LBOj+PPD1L4Hh5WOJyuRW5kGhPnlthonzKIiKnyMjcurMu5Do3LLP/zTlK7RlQwV9aOz4NGwzREnZCi8FXhqT+SHMz+74UG1dUVnbox2c3Ex1w5FjzeG9zR2g9vUtdku7AnDjth04YAX6VHysQ8pG4wANLLj9u8mho=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cefa3c0-4884-4b40-3d1c-08d7151588ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 17:44:13.6162
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
> The JZ4740 boards now use the iio-hwmon driver.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
