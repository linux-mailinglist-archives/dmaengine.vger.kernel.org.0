Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B783DA4BC
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 15:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhG2Nuk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 09:50:40 -0400
Received: from mail-eopbgr1400127.outbound.protection.outlook.com ([40.107.140.127]:23980
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237764AbhG2Nuj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Jul 2021 09:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoU/g6yH2+p90j4e9ZqY6LyzvPQmLJ4IhTvQ+aVk+oF+3ADaHNgAl2qbMrc29An22yisX2xYLjteKRnjyfDnC98H/no53h9esFRvVgZtoa+OcHQN6jNLX8zRPhOs3hOaZf7x4cANu7MWfA3oEPRmjUoDMdREOQfdjG9FjejfpaPP41ApOPwklzrV5Xsw0O/ccaEbXn2PUpe6jsqt5tJspFo9jVjxGG7o7WfqiRzqhowu2vQYxJd3JE5ab95/KTTsxKGSUYXlMWwfsu6R0wHGLSrSJqLNqBfkYBeZ5swq/mn3FAqQsOIlbD5mi7sf2RAkisKNstvu9f7D+diE79nEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xrHbTJxS+tQuceAx7FWzPA8UOmSoZf+Fdi4Dgq/D1g=;
 b=h4sa6796gIm+jDuQCef7W1KslPnL3ucELpdn4+iJmXm/UpDGtReyOSbkwxkHhjpzzY5X7LXTkJnpkE+zKWr52pAk0v7Wh7XsHXeKZjjWQhftF/eYcvcQxjgZZFcgGIsJIbqHMYGBxvRrsQycIWzK0Yn9h3YaNYTgwIiDMe1ZmD8CWipVAdLX6YxcB7jb0KETyDuZ+FJumiL4IaT//hEo/Ty3Ernamoj1gSXg4ETumF7VYlB4s8LtbtDCmlTCRbalgz+S3UalWfYCSl9pohoOS2OMxSAXQjkgn5T7QE9OyzZdmTQ9vlB8xUG6xtu2MrqJrZcN6m2pmTBHPRnefyXDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xrHbTJxS+tQuceAx7FWzPA8UOmSoZf+Fdi4Dgq/D1g=;
 b=FTTIsgVsuSKrimv10137rkHrTkG7LV0TcEySh08buqKfGzFJkc3rQT9Ywd4LNCu6mRFz7MnLUMBXuBNFvFfKRsBb+/1kzgNaY66vgLawI3/CJ0iFDVNJh4sSedr6dAa1BBuWmbj+lgGlxhxBKPeU8tLeET1q+ga45CMsRYTW6DI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB6481.jpnprd01.prod.outlook.com (2603:1096:604:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Thu, 29 Jul
 2021 13:50:32 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%8]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 13:50:32 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     kernel test robot <lkp@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Topic: [PATCH v5 3/3] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Index: AQHXhFNN5k7xdihHE0W8RkO2hDq6HqtZ0oyAgAAeZOCAAAZ8IA==
Date:   Thu, 29 Jul 2021 13:50:32 +0000
Message-ID: <OS0PR01MB592295ADFE40F0BBC260C0E086EB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210729082520.26186-4-biju.das.jz@bp.renesas.com>
 <202107291957.CdAuuHpk-lkp@intel.com>
 <OS0PR01MB592243832A383E3AEA9E213C86EB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592243832A383E3AEA9E213C86EB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a9ffc63-4e3b-4ea3-e185-08d95297d594
x-ms-traffictypediagnostic: OS0PR01MB6481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS0PR01MB6481C020EDD255060F86422186EB9@OS0PR01MB6481.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lvJe2NjGGlIT/Oa1Hk+/ut5pgopgBmA+YUS16hHIQLn6H3htTHC2DAA2e/C7k83JroR8j6JcUayikSroQtR7Wcyrm2heD0nVOIM9n07KiH/g8ViYYfmyCFnP2dhl1EK5mzsmc7xjrMpEkxEFlT3mj/OD7sUqwySoUsIfGZg1VCrUnF9DGt4IMrvYbK3MqUxw+ftSf9qNNgOO0MYxe7JB2MsL+jI3gxqvH8+XQo1Hvb4j9EFWbWVgtreo8xpRkKqZP5FNFt9ZxOoBxvtb8Wef07mN+E9sFT2uoS+bNUR9FdM/sK46UbAnAEIEYi5FveFmejryKxMNINOU3h8x08uK6PgBjbOT/SzwfUh9KDkWvXMDjbl/OZph7IydEdSAkioHNq0gqD99oJlVzr0kXMdhiMnpe5ifEyNOKnt7MW3BdrMp4ONjB7NVis6s6eiz/dL4Zro6HzusTpzVcNZe/0yfg8GFu9wlzov/z+AUeb/dqRSh5nhG/GkcG0e+JeGEc+CBRo1ahpN8TnGQcgVBWUiXLiLp6zUY+jaJ+7qbJsmZHAV5xZijoKW93vwwXM2q1RxIu0zLBCN52S8pKZw15BRZAPPTzYmERoP0hkXUO0JeVzcesYpKz/HhEwNHg+4PbjU4Gqnv+MGFJgs0QJJu5hRSu26LpgsC4UIb3orZtSiEtAO/qGketV3fOqUDPtOr/0NTZ69Jb+nc21EcSuzlKCgccwBt4a0OfYJi63UWJKnRY4X2la1swHHUNRkccW3afseG8gGanMoxnvxShVCGd8c/VXYRMcdAfehs8SpmKuk4mfxV3/e1qIc2+gRda4WEgP6faJsOq5HUqAYCPF3B794tww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(71200400001)(38100700002)(86362001)(5660300002)(122000001)(83380400001)(316002)(478600001)(186003)(4326008)(30864003)(7696005)(38070700005)(8676002)(53546011)(6506007)(33656002)(19627235002)(45080400002)(110136005)(66946007)(2906002)(8936002)(54906003)(966005)(52536014)(2940100002)(9686003)(76116006)(66556008)(64756008)(66446008)(55016002)(66476007)(26005)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kvWmi3SuBdBtE7mRO9syCOZoVzyqHzcjm7n0mYYLWujnQirO2MWAh3+bx+b5?=
 =?us-ascii?Q?RLXQWOiwD4hryOzqvgB2eP2AgJnPa2fG5yBU+5/APzFyQJq7SE6tUKQj1vc9?=
 =?us-ascii?Q?HCfxeCSTX7nIlRubU4tQmB7oWHMOh4i0XeHL90QFhdN7zMqdfesEmfyXnNE+?=
 =?us-ascii?Q?0UfkUy+J/ykXHVa55XML+GoHgoN+gsRqa26VC4CLmMzBeW7sh7NT6Sxn/1x+?=
 =?us-ascii?Q?W2Oa2QTY285cKT9VuDSf+8azYT+hkL0D5lefKUwMu+WhmuLftyOm6pEyTm2m?=
 =?us-ascii?Q?MoGfKil0AOYs/48sWD12vqSKUb/e+YGeJpdzgc+mv/0RhF9VNS4KgHwPK2WP?=
 =?us-ascii?Q?XIJbGr61yS3Emr8V/+YPXkood1CpNC6nzpzoaZSP4c0vRbk+gpV0q2FVI/c/?=
 =?us-ascii?Q?AcsIIw9mE1G5pCsSk6x8mVrTQhxhVnyFqwv3F4EiTf2PpyuUfXFTI8YcBRJ8?=
 =?us-ascii?Q?mXDLirysIxwoL/Xtt577wTch4Q5/3vMTGqH1iwhuN3x0L5E+5Eowx3uY5Kv3?=
 =?us-ascii?Q?939s4Vj2Q4rVCKP3WqyZFBOdfguOhl5t0y0+A9skJ1DBk2Tpoq1c1MHpXB28?=
 =?us-ascii?Q?a7T7Upw4kBsFP+Xpe1nuAriqyQb6Zw+SMkNqJxKREAMHLxYivRqYPgFexiyo?=
 =?us-ascii?Q?PI2XRo/zyiCL8XHUzGz5ihlskJSCRCD/e5K1XzVRNePXrGEyST7NUz0Cg1mw?=
 =?us-ascii?Q?jClVDpELrTJQL5VZZYyiXO0UbQ6c/3uvDC9jMaJ/v8rBO7iE22Sl8JFCSikn?=
 =?us-ascii?Q?UFQPJWki1AExxa3myP1snPASfyDT3B07BYv5FPR2DLZ2l1M/eYs/C82RXIBO?=
 =?us-ascii?Q?wFlReNtCCZVbGB1jYNmvnorsO781txYsawF6znYpUMWhXkjIr1w97RMLwE6j?=
 =?us-ascii?Q?oKrFfe8C+W6DUDHP3qa6vI7e2lF+RAKime0z29cPOpDSPBJy6C0j2VD+YlJM?=
 =?us-ascii?Q?v63qxo9XjWnFr+n/DAX/4c4LPhVKcQIAC5z9Eb3UN8kuXMtYju0Gy67J9XHc?=
 =?us-ascii?Q?W7VuBGElzcN8WHEhNlRoYaUvs6RpjCH9gPXLNrhc2goz17sWLoTM5F6dqHqb?=
 =?us-ascii?Q?XCNzeb4E44oc6vXmhBl8p+iruwZ+Ct3sdjzdbv+pXUj3ABoM8HyUvoPocaTr?=
 =?us-ascii?Q?QYMFI1iZGaDr8CQnfY3qsakOhoOGIE0MNsXCO/E/QQO1dM8//QAexbry4A3h?=
 =?us-ascii?Q?jZkgQDHi4FlgNjvUpPcChqI5Fq9g+9FsDEifJQZS9JWG5VfWi/mJhAdadQay?=
 =?us-ascii?Q?HGjfPL05vNjBK4K/TNOWERskPbcSbOJ9rr6MU2DEM0anmL+NdMMiG8jbfRvC?=
 =?us-ascii?Q?ruv0Y64kChndBTsOCCuVeVyZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9ffc63-4e3b-4ea3-e185-08d95297d594
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 13:50:32.4497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: myHTIxzN2j9MpfaLFIAxj1cdv6JB3QaiFd49cf+wleMY91cpjHEOlgoznl14X65moGa+s/UkLv9eKdMkG63e5brIPGJwiFzT/awUPbZ0WPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6481
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If I make format specifier %lld for dma_addr_t then ARM64 compiler is happy=
, but nios compiler complains

If I make format specifier %d for dma_addr_t then ARM compiler complains, b=
ut nios2 is happy

So what is the best way to handle format specifier for dma_addr_t for all a=
rchitectures?

Regards,
Biju

> Subject: RE: [PATCH v5 3/3] drivers: dma: sh: Add DMAC driver for RZ/G2L
> SoC
>=20
> Hi All,
>=20
> Looks like there is compiler issue with nios2 cross compilation toolchain=
.
>=20
> As per the kernel documentation %pad is the format specifier for
> dma_addr_t.
>=20
> This toolchain does not like it. Please let me know if I am missing any
> thing here.
>=20
> The changes I made to fix the issue reported by bot:-
> -------------------
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -475,7 +475,7 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan,
> dma_addr_t dest, dma_addr_t src,
>         struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>         struct rz_dmac_desc *desc;
>=20
> -       dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> len=3D%ld\n",
> +       dev_dbg(dmac->dev, "%s channel: %d src=3D%lld dst=3D%lld len=3D%z=
x\n",
>                 __func__, channel->index, src, dest, len);
>=20
>         if (list_empty(&channel->ld_free))
>=20
> compilation logs:-
> ------------------
> dasb@ree-du1sdd5:~/dmaengine$ COMPILER_INSTALL_PATH=3D$HOME/0day
> COMPILER=3Dgcc-10.3.0 ~/bin/make.cross ARCH=3Dnios2 Compiler will be inst=
alled
> in /data/dasb/0day make --keep-going CONFIG_OF_ALL_DTBS=3Dy CONFIG_DTC=3D=
y
> CROSS_COMPILE=3D/data/dasb/0day/gcc-10.3.0-nolibc/nios2-linux/bin/nios2-
> linux- --jobs=3D48 ARCH=3Dnios2
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
> <stdin>:1515:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>   CHK     include/generated/compile.h
> make[1]: *** No rule to make target 'arch/nios2/boot/dts/""', needed by
> 'arch/nios2/boot/dts/built-in.a'.
> make[1]: Target '__build' not remade because of errors.
> make: *** [Makefile:1842: arch/nios2/boot/dts] Error 2
>   CC      drivers/dma/sh/rz-dmac.o
> In file included from ./include/linux/printk.h:456,
>                  from ./include/asm-generic/bug.h:22,
>                  from ./arch/nios2/include/generated/asm/bug.h:1,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/thread_info.h:13,
>                  from ./include/asm-generic/current.h:5,
>                  from ./arch/nios2/include/generated/asm/current.h:1,
>                  from ./include/linux/sched.h:12,
>                  from ./include/linux/ratelimit.h:6,
>                  from ./include/linux/dev_printk.h:16,
>                  from ./include/linux/device.h:15,
>                  from ./include/linux/dma-mapping.h:7,
>                  from drivers/dma/sh/rz-dmac.c:12:
> drivers/dma/sh/rz-dmac.c: In function 'rz_dmac_prep_dma_memcpy':
> drivers/dma/sh/rz-dmac.c:478:21: warning: format '%p' expects argument of
> type 'void *', but argument 6 has type 'dma_addr_t' {aka 'unsigned int'}
> [-Wformat=3D]
>   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%=
zx\n",
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:134:15: note: in definition of macro
> '__dynamic_func_call'
>   134 |   func(&id, ##__VA_ARGS__);  \
>       |               ^~~~~~~~~~~
> ./include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> '_dynamic_func_call'
>   166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
>       |  ^~~~~~~~~~~~~~~~~~
> ./include/linux/dev_printk.h:123:2: note: in expansion of macro
> 'dynamic_dev_dbg'
>   123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~
> ./include/linux/dev_printk.h:123:23: note: in expansion of macro 'dev_fmt=
'
>   123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |                       ^~~~~~~
> drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg'
>   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%=
zx\n",
>       |  ^~~~~~~
> drivers/dma/sh/rz-dmac.c:478:42: note: format string is defined here
>   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%=
zx\n",
>       |                                         ~^
>       |                                          |
>       |                                          void *
>       |                                         %d
> In file included from ./include/linux/printk.h:456,
>                  from ./include/asm-generic/bug.h:22,
>                  from ./arch/nios2/include/generated/asm/bug.h:1,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/thread_info.h:13,
>                  from ./include/asm-generic/current.h:5,
>                  from ./arch/nios2/include/generated/asm/current.h:1,
>                  from ./include/linux/sched.h:12,
>                  from ./include/linux/ratelimit.h:6,
>                  from ./include/linux/dev_printk.h:16,
>                  from ./include/linux/device.h:15,
>                  from ./include/linux/dma-mapping.h:7,
>                  from drivers/dma/sh/rz-dmac.c:12:
> drivers/dma/sh/rz-dmac.c:478:21: warning: format '%p' expects argument of
> type 'void *', but argument 7 has type 'dma_addr_t' {aka 'unsigned int'}
> [-Wformat=3D]
>   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%=
zx\n",
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:134:15: note: in definition of macro
> '__dynamic_func_call'
>   134 |   func(&id, ##__VA_ARGS__);  \
>       |               ^~~~~~~~~~~
> ./include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> '_dynamic_func_call'
>   166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
>       |  ^~~~~~~~~~~~~~~~~~
> ./include/linux/dev_printk.h:123:2: note: in expansion of macro
> 'dynamic_dev_dbg'
>   123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~
> ./include/linux/dev_printk.h:123:23: note: in expansion of macro 'dev_fmt=
'
>   123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>       |                       ^~~~~~~
> drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg'
>   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%=
zx\n",
>       |  ^~~~~~~
> drivers/dma/sh/rz-dmac.c:478:51: note: format string is defined here
>   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%=
zx\n",
>       |                                                  ~^
>       |                                                   |
>       |                                                   void *
>       |                                                  %d
>   CHK     kernel/kheaders_data.tar.xz
>   AR      drivers/dma/sh/built-in.a
>   AR      drivers/dma/built-in.a
>   AR      drivers/built-in.a
> make: Target '__all' not remade because of errors.
>=20
> Regards,
> Biju
>=20
> > -----Original Message-----
> > From: kernel test robot <lkp@intel.com>
> > Sent: 29 July 2021 12:34
> > To: Biju Das <biju.das.jz@bp.renesas.com>; Vinod Koul
> > <vkoul@kernel.org>
> > Cc: kbuild-all@lists.01.org; Biju Das <biju.das.jz@bp.renesas.com>;
> > Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Chris
> > Paterson <Chris.Paterson2@renesas.com>; Geert Uytterhoeven
> > <geert+renesas@glider.be>; dmaengine@vger.kernel.org; Chris Brandt
> > <Chris.Brandt@renesas.com>; linux-renesas-soc@vger.kernel.org
> > Subject: Re: [PATCH v5 3/3] drivers: dma: sh: Add DMAC driver for
> > RZ/G2L SoC
> >
> > Hi Biju,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on vkoul-dmaengine/next] [also build test
> > WARNING on robh/for-next v5.14-rc3 next-20210728] [If your patch is
> > applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
-
> > scm.com%2Fdocs%2Fgit-format-
> > patch&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2887f4=
8
> > 8c2f
> > ef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6376315551
> > 6672
> > 5253%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> > iI6I
> > k1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTJFcD19oJIJ3tWbNwldGo4xy2aaAou=
J
> > nopP
> > yZQ2tixo%3D&amp;reserved=3D0]
> >
> > url:
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.c
> > om%2F0day-ci%2Flinux%2Fcommits%2FBiju-Das%2FAdd-RZ-G2L-DMAC-
> > support%2F20210729-
> > 162632&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2887f=
4
> > 88c2
> > fef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637631555
> > 1667
> > 25253%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> > TiI6
> > Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D%2Bg8o5Ec95AfQ5n39E6cJ6lnsziA=
R
> > XpVw
> > g%2BRoQgBYQks%3D&amp;reserved=3D0
> > base:
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
.
> > kern
> > el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fvkoul%2Fdmaengine.git&amp;
> > data
> > =3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2887f488c2fef08d9528=
4
> > c66f
> > %7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637631555166725253%7CUnk
> > nown
> > %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
> > XVCI
> > 6Mn0%3D%7C1000&amp;sdata=3DPLRxI4C7cMH0H4QS6Dv045x8zx%2BIlFeb0mV0QLwfNb=
Q
> > %3D&
> > amp;reserved=3D0 next
> > config: nios2-allyesconfig (attached as .config)
> > compiler: nios2-linux-gcc (GCC) 10.3.0 reproduce (this is a W=3D1
> > build):
> >         wget
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fraw=
.
> > gith
> > ubusercontent.com%2Fintel%2Flkp-
> > tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=3D04%7C01%7Cbiju.das.jz%40b=
p
> > .ren
> > esas.com%7C542bfff2887f488c2fef08d95284c66f%7C53d82571da1947e49cb4625a
> > 166a
> > 4a2a%7C0%7C0%7C637631555166725253%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> > LjAw
> > MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dm=
R
> > WtzY
> > YmV9%2B8br%2BnBcClZz1roSj4GAxaesZbrtMNjYw%3D&amp;reserved=3D0 -O
> > ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         #
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.c
> > om%2F0day-
> > ci%2Flinux%2Fcommit%2Fcfd03e1dedb6793c62ca9acb9642dd314d44ac8e&amp;dat
> > a=3D04
> > %7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2887f488c2fef08d95284c66
> > f%7C
> > 53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637631555166725253%7CUnknow
> > n%7C
> > TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> > I6Mn
> > 0%3D%7C1000&amp;sdata=3DrVtsa8DjyZ4TY2hpwlKz%2F6e3kBSubO6VM58rh8ioiNA%3=
D
> > &amp
> > ;reserved=3D0
> >         git remote add linux-review
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.c
> > om%2F0day-
> > ci%2Flinux&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2=
8
> > 87f4
> > 88c2fef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63763
> > 1555
> > 166735210%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> > LCJB
> > TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DJb9197GDbxvSzKoZHxgDzTAXn=
L
> > AqPL
> > 8KrH%2Bp7xJHu1A%3D&amp;reserved=3D0
> >         git fetch --no-tags linux-review Biju-Das/Add-RZ-G2L-DMAC-
> > support/20210729-162632
> >         git checkout cfd03e1dedb6793c62ca9acb9642dd314d44ac8e
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-10.3.0
> > make.cross
> > ARCH=3Dnios2
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from include/linux/printk.h:456,
> >                     from include/asm-generic/bug.h:22,
> >                     from ./arch/nios2/include/generated/asm/bug.h:1,
> >                     from include/linux/bug.h:5,
> >                     from include/linux/thread_info.h:13,
> >                     from include/asm-generic/current.h:5,
> >                     from ./arch/nios2/include/generated/asm/current.h:1=
,
> >                     from include/linux/sched.h:12,
> >                     from include/linux/ratelimit.h:6,
> >                     from include/linux/dev_printk.h:16,
> >                     from include/linux/device.h:15,
> >                     from include/linux/dma-mapping.h:7,
> >                     from drivers/dma/sh/rz-dmac.c:12:
> >    drivers/dma/sh/rz-dmac.c: In function 'rz_dmac_prep_dma_memcpy':
> > >> drivers/dma/sh/rz-dmac.c:478:21: warning: format '%llx' expects
> > >> argument of type 'long long unsigned int', but argument 6 has type
> > >> 'dma_addr_t' {aka 'unsigned int'} [-Wformat=3D]
> >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%ll=
x
> > len=3D%ld\n",
> >          |
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/dynamic_debug.h:134:15: note: in definition of macro
> > '__dynamic_func_call'
> >      134 |   func(&id, ##__VA_ARGS__);  \
> >          |               ^~~~~~~~~~~
> >    include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> > '_dynamic_func_call'
> >      166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
> >          |  ^~~~~~~~~~~~~~~~~~
> >    include/linux/dev_printk.h:123:2: note: in expansion of macro
> > 'dynamic_dev_dbg'
> >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >          |  ^~~~~~~~~~~~~~~
> >    include/linux/dev_printk.h:123:23: note: in expansion of macro
> > 'dev_fmt'
> >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >          |                       ^~~~~~~
> >    drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg=
'
> >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%ll=
x
> > len=3D%ld\n",
> >          |  ^~~~~~~
> >    drivers/dma/sh/rz-dmac.c:478:46: note: format string is defined here
> >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%ll=
x
> > len=3D%ld\n",
> >          |                                           ~~~^
> >          |                                              |
> >          |                                              long long
> unsigned
> > int
> >          |                                           %x
> >    In file included from include/linux/printk.h:456,
> >                     from include/asm-generic/bug.h:22,
> >                     from ./arch/nios2/include/generated/asm/bug.h:1,
> >                     from include/linux/bug.h:5,
> >                     from include/linux/thread_info.h:13,
> >                     from include/asm-generic/current.h:5,
> >                     from ./arch/nios2/include/generated/asm/current.h:1=
,
> >                     from include/linux/sched.h:12,
> >                     from include/linux/ratelimit.h:6,
> >                     from include/linux/dev_printk.h:16,
> >                     from include/linux/device.h:15,
> >                     from include/linux/dma-mapping.h:7,
> >                     from drivers/dma/sh/rz-dmac.c:12:
> >    drivers/dma/sh/rz-dmac.c:478:21: warning: format '%llx' expects
> > argument of type 'long long unsigned int', but argument 7 has type
> > 'dma_addr_t' {aka 'unsigned int'} [-Wformat=3D]
> >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%ll=
x
> > len=3D%ld\n",
> >          |
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/dynamic_debug.h:134:15: note: in definition of macro
> > '__dynamic_func_call'
> >      134 |   func(&id, ##__VA_ARGS__);  \
> >          |               ^~~~~~~~~~~
> >    include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> > '_dynamic_func_call'
> >      166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
> >          |  ^~~~~~~~~~~~~~~~~~
> >    include/linux/dev_printk.h:123:2: note: in expansion of macro
> > 'dynamic_dev_dbg'
> >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >          |  ^~~~~~~~~~~~~~~
> >    include/linux/dev_printk.h:123:23: note: in expansion of macro
> > 'dev_fmt'
> >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >          |                       ^~~~~~~
> >    drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg=
'
> >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%ll=
x
> > len=3D%ld\n",
> >          |  ^~~~~~~
> >    drivers/dma/sh/rz-dmac.c:478:57: note: format string is defined here
> >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%ll=
x
> > len=3D%ld\n",
> >          |                                                      ~~~^
> >          |                                                         |
> >          |                                                         long
> > long unsigned int
> >          |                                                      %x
> >    In file included from include/linux/printk.h:456,
> >                     from include/asm-generic/bug.h:22,
> >                     from ./arch/nios2/include/generated/asm/bug.h:1,
> >                     from include/linux/bug.h:5,
> >                     from include/linux/thread_info.h:13,
> >                     from include/asm-generic/current.h:5,
> >                     from ./arch/nios2/include/generated/asm/current.h:1=
,
> >                     from include/linux/sched.h:12,
> >                     from include/linux/ratelimit.h:6,
> >                     from include/linux/dev_printk.h:16,
> >                     from include/linux/device.h:15,
> >                     from include/linux/dma-mapping.h:7,
> >                     from drivers/dma/sh/rz-dmac.c:12:
> > >> drivers/dma/sh/rz-dmac.c:478:21: warning: format '%ld' expects
> > >> argument of type 'long int', but argument 8 has type 'size_t' {aka
> > >> 'unsigned int'} [-Wformat=3D]
> >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%ll=
x
> > len=3D%ld\n",
> >          |
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/dynamic_debug.h:134:15: note: in definition of macro
> > '__dynamic_func_call'
> >      134 |   func(&id, ##__VA_ARGS__);  \
> >          |               ^~~~~~~~~~~
> >    include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> > '_dynamic_func_call'
> >      166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
> >          |  ^~~~~~~~~~~~~~~~~~
> >    include/linux/dev_printk.h:123:2: note: in expansion of macro
> > 'dynamic_dev_dbg'
> >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >          |  ^~~~~~~~~~~~~~~
> >    include/linux/dev_printk.h:123:23: note: in expansion of macro
> > 'dev_fmt'
> >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >          |                       ^~~~~~~
> >    drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg=
'
> >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%ll=
x
> > len=3D%ld\n",
> >          |  ^~~~~~~
> >    drivers/dma/sh/rz-dmac.c:478:65: note: format string is defined here
> >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%ll=
x
> > len=3D%ld\n",
> >          |
> > ~~^
> >          |
> > |
> >          |
> > long int
> >          |
> > %d
> >
> >
> > vim +478 drivers/dma/sh/rz-dmac.c
> >
> >    469
> >    470	static struct dma_async_tx_descriptor *
> >    471	rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t
> > dest, dma_addr_t src,
> >    472				size_t len, unsigned long flags)
> >    473	{
> >    474		struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> >    475		struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> >    476		struct rz_dmac_desc *desc;
> >    477
> >  > 478		dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> > len=3D%ld\n",
> >    479			__func__, channel->index, src, dest, len);
> >    480
> >    481		if (list_empty(&channel->ld_free))
> >    482			return NULL;
> >    483
> >    484		desc =3D list_first_entry(&channel->ld_free, struct
> > rz_dmac_desc, node);
> >    485
> >    486		desc->type =3D RZ_DMAC_DESC_MEMCPY;
> >    487		desc->src =3D src;
> >    488		desc->dest =3D dest;
> >    489		desc->len =3D len;
> >    490		desc->direction =3D DMA_MEM_TO_MEM;
> >    491
> >    492		list_move_tail(channel->ld_free.next, &channel-
> > >ld_queue);
> >    493		return vchan_tx_prep(&channel->vc, &desc->vd, flags);
> >    494	}
> >    495
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
t
> > s.01
> > .org%2Fhyperkitty%2Flist%2Fkbuild-
> > all%40lists.01.org&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C=
5
> > 42bf
> > ff2887f488c2fef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0
> > %7C6
> > 37631555166735210%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > V2lu
> > MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DIaa%2FyiTehgWr7yg=
H
> > m6xV
> > 0xspg7HWa79nPlkqUH0HVj0%3D&amp;reserved=3D0
