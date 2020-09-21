Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9082B271DDF
	for <lists+dmaengine@lfdr.de>; Mon, 21 Sep 2020 10:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIUIZX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Sep 2020 04:25:23 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:53379
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726416AbgIUIZX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Sep 2020 04:25:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM3UPGchfu04kEpzndK7Hhpey12xTdk+lUco+nld24EP3ucrUJvh3Cd9qhzPx6At56Y4PsXU/gFL5T3U5Rv8RLH8MGaCDu4Rh0Y39gxXW8i/dDV4kbSvNQkiL2GMs1uEBn85TPBU5Una5j8fg78yKukOYcivhuS5LSTaJ1IlzsJ1dBA9MXIor6aDCtjLODMo4ERDyR5wY/bHv8LJsHzc+gkqroqpKeUscN2+f2qATyrs/hogWPxVCivc7XjO74D4jFWtI4DMN9Na1URLnfFITRk51xb8Y/iGoCg2VW/BZWdT6nqco/3FoVY5Cr2+8pBXSDfk6jt095E1/EfaMjOs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YLCSH+fx+UuIDsHytbS1FIG25qFesTYvscAgzZOHNI=;
 b=By7YyXdu9Ei4wPxEcBUt6A9NUNYeEp99Ouxs+M/4Pkl1BIjmmQ90/ZofiV5L6XWTOA3WGPjKn0Ie7DBIdxLkcRVKsqkFzWP8ClpvtybI2rIDU44Q7om+6QAb7oSM1moXnjJWejYuuZb3d/BTbgLE1YqSiI3KQdNoGZH0uTeZV3Y7cTitH3i8Ws+E8FHZlE03pFttK3sc+mjMooiiG+ofEQD3yv8Bo/VeSnuhdapwpoZInad0BnR2hHDdGmz8Dp8GqiAbGj2RMKCw3zlwxmUFXuZVbDBPm7Kgrh7AlzQVKM1zTX7hgQXbfoXiaE4hOJmioDCGqEt6Xj3gozKunhjnWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YLCSH+fx+UuIDsHytbS1FIG25qFesTYvscAgzZOHNI=;
 b=aDVfxA4qMDigFqX9HwjGu5sOs9mAKplyTES8LhgpDYPY9Vb0dsffelCNkItFxDOS5ZfrjqrIL+9Aua8bGG2jxo7Fwbuglpvoq5wO3isPfKbKBMxlNSPJwHyiFJY7LKDCWfRRClpZfnlC6CfWxePm5BkIWnd2+XKKxUw7f6HQfgM=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Mon, 21 Sep
 2020 08:25:18 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3391.017; Mon, 21 Sep 2020
 08:25:18 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "r.schwebel@pengutronix.de" <r.schwebel@pengutronix.de>,
        "Benjamin.Bara@skidata.com" <Benjamin.Bara@skidata.com>,
        "Richard.Leitner@skidata.com" <Richard.Leitner@skidata.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v13 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Topic: [PATCH v13 00/12] add ecspi ERR009165 for i.mx6/7 soc family
Thread-Index: AQHWf2tkimfqSdG8kEGKEyob2MpDZaljtaAAgA8dHUA=
Date:   Mon, 21 Sep 2020 08:25:16 +0000
Message-ID: <VE1PR04MB66387B8FEBBC937CE0A1AC24893A0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
 <20200911164018.6treqdmywzjhqe3a@pengutronix.de>
In-Reply-To: <20200911164018.6treqdmywzjhqe3a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cba8acb2-8acd-45f3-82fb-08d85e07df91
x-ms-traffictypediagnostic: VI1PR04MB6944:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6944D249F8827639BD2E9DAB893A0@VI1PR04MB6944.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pRYfi+3WPpK1DK0C+AJgtvPvVOuISMvNZnBLGZYDL+TEqTcWIZl28d6+RD9yV4t+L3MficmjoevTrdEbx8wA91YZXIdAN2goukjawQyepnwRzc25ESl1ZVlkI18Fuum/WCWRiPCNGxqYgQK72JYUKkAaiufYdz7nyGX4S341wzDKCbZhKcx+BJDFwEyxFq46Qb2Loo9+AH/JLtv/scVF9wt1lQyord2X2FLhwn4YIEk0pCTzDbTwIEf3WyRZkBQTB9vCI3qEv9d9CJCzcp4gxt+PhhBRWNmch40Kexq1aWVovAEmNpem3loWOjyyFEMK0V84X3I9F3vU3wKpAcIEG5Z0p0Wc1CBuoE4/vkIOYH4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(7416002)(8676002)(54906003)(478600001)(7696005)(966005)(316002)(66476007)(66556008)(64756008)(86362001)(2906002)(76116006)(6916009)(53546011)(66446008)(6506007)(45080400002)(66946007)(55016002)(71200400001)(52536014)(9686003)(33656002)(26005)(5660300002)(8936002)(186003)(4326008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pxVLiZiyHfouNUcYj7+a1Q4iulOnyCTIKGgxGtpw8/x5DmzDD5ojZ9xxwv0/07TXmHQ8M8Q5XYUC8wkNlIRdV7yvij5nw/YYJt9aYIGnidM3JY/3s0rg8bIHDcJzlnVC1Dh33CQLXpJbiJCewQ4R2mAm2Ra4RGCEnzoGnA+5P3wKodBaU8Ab2jAMCBSOnzv/LceHsdhXmbn//kijBz+JxhmCeC77SIX7yy5HXdM/Qb7yiyH+G4sipuxUf4qBbVGPaxc9jeJcy1F10gu3N1ew0hAqkJx6Jq3YALL00WdJ5x7qp/fV2hTFwccOSxuq4K6Pt7x5tzfzxlKDujl4wk3TbOeg/Yr5/qytkHj46ZBsSRZADBzrml6aVKrstuYqL9TK+Rq6qlxImyD2dBiv3spC87yyXs7glq0oR5uJx3de0WgbtUU2z5gC0DLiarRwvnbsYBecK15jgp/02H9Eq2QEvVL9pv+esV1Xb+tMYYf1dntT8Kj9UWssmBRMpAINOdK+khZNB4bhKTtJGXsRa53TtmZQNhBlpQJcgmrU+WOnLdhWPr3xxstabPEFuyyqNvmou5Yc4kCIFooq0Pg+ueKoaRaOZ3EYd2HEEqzsl+HjaTBY+D4IyHtX+ZFSxI2EavtpAwuH+OgjTwVHr5aefUKO9g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba8acb2-8acd-45f3-82fb-08d85e07df91
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 08:25:16.5621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yrooecPYo5u8wfdUnZ9g/kH4VAByXTj1mqqwA/yyWEEjmO2xxTweKcnQxfTeG25goXhUz+HEvKDQiwF6GZ4vWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/09/12 0:40 Marco Felsch <m.felsch@pengutronix.de> wrote:
> Hi Robin,
>=20
> I took your patches and did a few test on the mainline available
> fsl,imx6q-sabrelite. I used a vanilla linux version v5.9-rc1 for all my t=
ests except
> the needed SPI-NOR patches [1]. Following are my results:
Marco, thanks for your test :)

>=20
> Testcase 1: "Using ROM-FW"
> =3D=3D=3D
> [OK] Playing Audio (SSI)
> [OK] TX/RX bytes on a different UART (not the serial used for
>      interaction)
> [OK] Writing to the SPI-NOR
> [OK] Doing all at the same time (once for TX and once for RX on UART)
>=20
> Notes:
> - Your Patches adding a maybe noise message "sdma firmware not ready".
>   Maybe we should consider about that if it should be a warning or a info=
.
That means the script you're using is ram script which may not be loaded as=
 your
case. That should be a warning I think, to avoid too much noise I have refi=
ne it
to dev_warn_once.

>=20
> - For spi-nor I did run this test:
>   dd if=3D/dev/urandom of=3D/var/tmp/test1M bs=3D1M count=3D1 && \
>   flashcp -v /var/tmp/test1M /dev/mtd2
>=20
>   and checked /proc/interrupts:
>   25:    2107169          0          0          0       GPC  31
> Level	2008000.spi
>=20
> Testcase 2: "Using new FW from linux-firmware"
> =3D=3D=3D
> [OK] Playing Audio (SSI)
> [OK] TX/RX bytes on a different UART (not the serial used for
>      interaction)
> [OK] Writing to the SPI-NOR
> [OK] Doing all at the same time (once for TX and once for RX on UART)
>=20
> Notes:
> - For spi-nor I did run this test:
>   dd if=3D/dev/urandom of=3D/var/tmp/test1M bs=3D1M count=3D1 && \
>   flashcp -v /var/tmp/test1M /dev/mtd2
>=20
>   and checked /proc/interrupts:
>   25:    2107993          0          0          0       GPC  31
> Level	2008000.spi
>=20
>   I saw no SDMA interrupts during this testcase instead I saw only spi
>   controller interrupts.
That's not expected. But I have tried just now and show that SDMA interrupt
caught by spi as belows. Are you sure sdma firmware loaded indeed?

./spidev_test -D /dev/spidev0.0 -s 1200000 -b 8 -S 512 -I 1 -l 8 -S 512 -I
spi mode: 0x24
bits per word: 8
max speed: 1200000 Hz (1200 kHz)
total: tx 0.5KB, rx 0.5KB
root@imx6qpdlsolox:~# cat /proc/interrupts | grep dma
 58:          2          0       GPC   2 Level     sdma=20


>=20
> - According linux-firmware you did a version bump from 3.5 to 4.5 but my
>   dmesg shows:
>   imx-sdma 20ec000.sdma: loaded firmware 3.5
3.x is used for i.mx6 family while 4.x is used for i.mx7/8 since there are =
some
change on ROM which depended by RAM script. Not means version bump
between 3.5/4.5. 3.5 is correct on i.mx6q.=20

>=20
> SPI Benchmark:
> =3D=3D=3D
> flash_erase /dev/mtd2 0 0 && \
> 	dd if=3D/dev/urandom of=3D/dev/mtd2 bs=3D1M count=3D1
>=20
> - without firmware (ROM-FW)
>   1048576 bytes (1.0 MB, 1.0 MiB) copied, 51.9713 s, 20.2 kB/s
>=20
> - with firmware
>   1048576 bytes (1.0 MB, 1.0 MiB) copied, 59.4174 s, 17.6 kB/s
>=20
> Conclusion:
> =3D=3D=3D
> It seems that we don't have any performance boost with your patchset inst=
ead
> we are increasing the complexity and the interrupts...
Yes, that's expected. What ERR009165 fix is data correct on spi bus though
that bring performance drop in dma mode, because the workaround just let
sdma do similar thing as cpu (PIO), while cpu running faster than sdma. If =
you
care much spi performance, PIO is better way. If care cpu loading, dma way
is better.=20

>=20
> Pls let me know if I did something wrong during testing or if my test set=
up was
> wrong. Note: the /dev/mtd2 isn't mainlined yet but if you use barebox you=
 only
> have to add:
> 8<---------------------------------------------------------------------
> diff --git a/arch/arm/dts/imx6qdl-sabrelite.dtsi
> b/arch/arm/dts/imx6qdl-sabrelite.dtsi
> index ec3d364bde..256dd90a0f 100644
> --- a/arch/arm/dts/imx6qdl-sabrelite.dtsi
> +++ b/arch/arm/dts/imx6qdl-sabrelite.dtsi
> @@ -38,6 +38,11 @@
>  		label =3D "barebox-environment";
>  		reg =3D <0xe0000 0x20000>;
>  	};
> +
> +	parition@100000 {
> +		label =3D "user-partition";
> +		reg =3D <0x100000 0x100000>;
> +	};
>  };
>=20
>  &ocotp {
> 8<---------------------------------------------------------------------
> to the barebox device tree.
>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.=
infra
> dead.org%2Fpipermail%2Flinux-mtd%2F2020-September%2F082099.html&am
> p;data=3D02%7C01%7Cyibin.gong%40nxp.com%7C324d4b5c2f2344883a3108d85
> 67166f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C63735439234
> 6471210&amp;sdata=3Dru8fKz6wpDhzYeaHIT28T0OybHlCFHJ41N1lJYuqKgE%3D&
> amp;reserved=3D0
>=20
> Regards,
>   Marco
