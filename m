Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA13675B92
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jul 2019 01:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfGYXrp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 19:47:45 -0400
Received: from mail-eopbgr700128.outbound.protection.outlook.com ([40.107.70.128]:7937
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbfGYXrp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Jul 2019 19:47:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiGRQXd8nlgpIvGf554PjweZhrBlt8K+l1TcfkHQjBEmAEZK2T7FFXXd2zfhEdWu/TEkn16vB7iueaPotCEelI793bQS8dGZkSdHivKFHT4DerVOVnm3HYZCaoT9NXp0wMttnek5xEXb/TQ/S9vWhJcqTNcSfFYc5jiARHgRWyV4HFkpIvCo62VyNWSWXkrDWb2BotSLkGRkuVGgkRc2tn2Qd2B6wkD6QqH1wuCHPV6agpzk/pq3V6Me/qjQAnlgIzfUlf0mztHxe+ep8+Jfi6zbSzLC6Y592VnSfGZPg6SJEnan+xHXPXZtrRTzWG8sNB4IYwIT2RV/Xb/bnHActg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI2KyNQLE7IhRLZwhZv0udYhgOmLXOWv5ZIVnLBdQh8=;
 b=UGM8OBXVtThHbckw/Ttm0qcKpzBpuD6NOh1wnKoQRyCABNeJgPVGQlfepruYIJ1/Sg8SzHKpmjhAMZaVXuaBmpvd12hbsz6wJKun2J/0ZjUeM27G39wQR4mEhveCpiYEEdShoFAI9IqgBLM16pE0hIgXHkli/1NcKoJzhv7t7OKC7WQswHzM4wLDMYGmFx9296g5/Sqk+Om8Q3blm9HgvWtALnevVPSPTrs6efW8bf93Y1R/1NwVYU+Cs2SVVTzPV0CuGDGRu2q4rGlSjMmR5ZkXejtaQzKOeH5Q5HxOmsuG5ugqFkpS8C4qyFOFS/FCWhcpr9Sxc2Hawq2tt0rXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI2KyNQLE7IhRLZwhZv0udYhgOmLXOWv5ZIVnLBdQh8=;
 b=QCa1aGtGfGRnOv5+EsHd7hnho1khRhdXjNTZC5r/6YYn88HUZSFtCnfxUoB54ai7jfUfM9BT6ks87ljlx1/95UxkHl2xitUWJq6Wn92cVRMTyIfPHfofX7oHbqIP1OWT9UTjZOdGBienZugfa2xCGR/5fID8U7LjukDxPS4ctfM=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1503.namprd22.prod.outlook.com (10.174.170.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 25 Jul 2019 23:47:39 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::49d3:37f8:217:c83]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::49d3:37f8:217:c83%6]) with mapi id 15.20.2094.017; Thu, 25 Jul 2019
 23:47:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
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
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 02/11] MIPS: qi_lb60: Migrate to devicetree
Thread-Topic: [PATCH 02/11] MIPS: qi_lb60: Migrate to devicetree
Thread-Index: AQHVQ0NWCLVfx8mbpE6E+nYkLom38g==
Date:   Thu, 25 Jul 2019 23:47:37 +0000
Message-ID: <20190725234735.h7qmtt26qpkjw3n6@pburton-laptop>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-3-paul@crapouillou.net>
In-Reply-To: <20190725220215.460-3-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:a03:114::36) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a3ef576-5f6d-4b9b-063f-08d7115a7909
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR2201MB1503;
x-ms-traffictypediagnostic: MWHPR2201MB1503:
x-microsoft-antispam-prvs: <MWHPR2201MB15030536C74C6D8B37D85931C1C10@MWHPR2201MB1503.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(396003)(136003)(366004)(39850400004)(376002)(199004)(189003)(7736002)(53936002)(99286004)(66946007)(6246003)(6506007)(81166006)(81156014)(102836004)(68736007)(76176011)(6916009)(26005)(186003)(9686003)(58126008)(8676002)(6512007)(52116002)(66066001)(66476007)(54906003)(256004)(6436002)(6486002)(6116002)(8936002)(386003)(7416002)(66446008)(64756008)(316002)(229853002)(71200400001)(71190400001)(25786009)(486006)(44832011)(1076003)(478600001)(4326008)(5660300002)(3846002)(14454004)(33716001)(66556008)(446003)(2906002)(42882007)(11346002)(305945005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1503;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iSGvlzuhrUfH7o2YaKIXla9eXn/K/4/8jf/mNeKIxX4RDEG4gzC54Ibj4Jgnp7R+oq+1+xP0cwKpROSvpK0+xI9nNhPEDq26CCycbSfM7iHpAK4GpTa014MsRRhRSkCjU1yKE0KME5rxtOm/lLXWiNE5AuiYXcBy/zee1z/OTtVE4awlsuuNhQ3cSvEFej1pCOaaYblLJ79mnEdYg41Oi2HFLDnkkZ7Ut244N6FVv9zxZsJ6RqKe0//qsFom3rxEb8diKUgqgbESGaFFjvDTjJ9N5GRzgiXoRmX+rs1F2B/m7Rlj9pQETJh2u6wCDJg4q/necjY+sqf/6TdlbxId05iFN+4KVIlmh+OH+CpjlR+srV3EUp5JDwOVkTBkqovmE4GX32GzLyzAvC6e61ymiAlktpPvMHEdUIhiDFFvylk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8ACA55FCC1F804CB7F8CE8CFDE41571@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3ef576-5f6d-4b9b-063f-08d7115a7909
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 23:47:37.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1503
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Paul,

On Thu, Jul 25, 2019 at 06:02:06PM -0400, Paul Cercueil wrote:
> Move all the platform data to devicetree.

Nice! :)

> The only bit dropped is the PWM beeper, which requires the PWM driver
> to be updated. I figured it's okay to remove it here since it's really
> a non-critical device, and it'll be re-introduced soon enough.

OK, I can see that being a price worth paying. Though it's possible to
include the binding at least for that in this series I'd be even
happier. Actually I see we already have

  Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt

in mainline - what needs to change with it?

> +	spi {
> +		compatible =3D "spi-gpio";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		sck-gpios =3D <&gpc 23 GPIO_ACTIVE_HIGH>;
> +		mosi-gpios =3D <&gpc 22 GPIO_ACTIVE_HIGH>;
> +		cs-gpios =3D <&gpc 21 GPIO_ACTIVE_LOW>;
> +		num-chipselects =3D <1>;
> +
> +		spi@0 {
> +			compatible =3D "ili8960";

Should this be "ilitek,ili8960"?

Is there a binding & driver for this submitted somewhere? If not then do
we need this at all? It doesn't look like the existing platform data
would actually lead to a driver being loaded so I'm wondering if we can
just drop this until such a driver (or at least a documented DT binding)
exists.

Thanks,
    Paul
