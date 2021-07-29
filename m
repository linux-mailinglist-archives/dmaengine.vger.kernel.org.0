Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF703DA5EC
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 16:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbhG2OKG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 10:10:06 -0400
Received: from mail-eopbgr1410139.outbound.protection.outlook.com ([40.107.141.139]:26432
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238908AbhG2OIQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Jul 2021 10:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gs11/nwS99qLpKV4ky30AWrn2ljzib37waZdIT73Y4HYvb0HQWqQFuiBrJSQkUOPMWO4MO/uxWhMsF6aF+XTLr7FUC2KiYpDOAhKAQ4IQdFWcWqijcYhCidR78mZdQn07xnrjryPXEn3FIyTb1objJZ1XoE197BduABaKTvaSRYvWgfMsHgBpJC79lFeMWitFSOeTAALb38aIdCtKDsjw8QOfN43nIOai0kB7e8Uag0EBLMYZWLM0UO3G53B9EzxKlH7nc4I6kErd4dGVk1bPUZ7gAAq8mIy3d1Cvnwhzok8wPRCd4X6QzOZJ7UCkff6W20T5Ptc3z5HbVAJy6rEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2S5z6oszZ4bMu97gxlIwhAzXCFV9b56ztl5vUxBDEk=;
 b=AcFjyLo//fpEHorA/O6iT3194b2GThQxPXUfY9rYn4KzKcnEy8xAI2BR3CUH1k1SIXuSvPh+S10AVIJHJ3rnkaT/oIsVO2DIkmVdDPxAGlunGXJb3dId8Oqdff0x6uY1TLTOUSdsS4phNbgtOXbRsWTU4y5vT6rwK4TSwqJTYTixQ5t6vgxvnDH6kA9BmvpzB7/Xmmg1L/BTdE/bYWkTWBOab0Q70hO5AYtaVZxNJ7ZzNd8W+vGRSn2+U2qQoQ2HykVK58CGFNkaN2ajSquAD3tu0XhxtiSHta4aJUYeHDogsKtJX25Ncq9D5dGmUqdaUD+N5ei9o4NkvsQOb2Vngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2S5z6oszZ4bMu97gxlIwhAzXCFV9b56ztl5vUxBDEk=;
 b=prgPRh6im53192mLYWa2DAOLWFk/OoCtNqTjDUtlu3OdW/zd0OLST0s1WMzO5qeS7p1qC+fVYL0iRZULAlKntC+yVcwoUWqcC4hUuRwEmMJQTvOulihZt4Dh3mTFCWlyZLBDGHXW0nOBisQ1WV5YPc3Gup3RVVezFJYrWpz7WCw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5715.jpnprd01.prod.outlook.com (2603:1096:604:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 14:08:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%8]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 14:08:09 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        kernel test robot <lkp@intel.com>,
        Vinod Koul <vkoul@kernel.org>
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
Thread-Index: AQHXhFNN5k7xdihHE0W8RkO2hDq6HqtZ0oyAgAAeZOCAAAZ8IIAABR5Q
Date:   Thu, 29 Jul 2021 14:08:09 +0000
Message-ID: <OS0PR01MB5922C288A894BF28E5E03A2186EB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210729082520.26186-4-biju.das.jz@bp.renesas.com>
 <202107291957.CdAuuHpk-lkp@intel.com>
 <OS0PR01MB592243832A383E3AEA9E213C86EB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB592295ADFE40F0BBC260C0E086EB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592295ADFE40F0BBC260C0E086EB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bp.renesas.com; dkim=none (message not signed)
 header.d=none;bp.renesas.com; dmarc=none action=none
 header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c525ed8-4d21-4b15-d990-08d9529a4bc5
x-ms-traffictypediagnostic: OS0PR01MB5715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS0PR01MB5715EF4CBB3426FC73072E8B86EB9@OS0PR01MB5715.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:148;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ttn9OlfhFJwQ2jxddvNLl6SFzM8zR4ivtz2Ls8xn5bZcDvo81UtOzMWSeNgSTWv0m+VMWnY35zqh34fMjjkMy9azNkNv4LGCZqS/h8M1Gq2aNMRBtnkopqxM90C6IvJ5g0L0a2pkMUoX5hxyjM9zDw0gj6qGeHThDpAZsK1XbkDwESlI0LZp2lny+zWAgUzdE4Sx9avzSsQFFWQLSfyqkRDsEL2qJwmNmiW2WAl/1v9s6YzbGHyLDCOTlR/ekpAUC4aZALvJAiao5vA15ilBSdUFJbhOK5DE4CON0YXpjkig4fmxv23m7QcjGkS0uvSyXx/7P7yhvIaZC+hKPsGeR+DjSvNGYT3H35bJFOt6v/bLcg/Fo90cyUEkWl0vQUDqt5Gnszr1AocMfSoA5SoQOv3sVqKBKcF7ukTr7yV2gcK6m3gWBWb8bT+jZfP3c6/cht0UZ0rIvktYfZJk35l8DKF39z2wfpxPfgwUxiGu0bqV3tnEDt9QyDrl/w54D71s9CnusxUvyjlRudt0JyzOR1Gq8/16uinwSLW7Yh30HpZLt3m3Hb/SZG6ams/MQKTsSQGnOiC9WA2B4im/axlwB7H57lhge/JKEitNy5lSeMIfKdDJGFA9WQmF9IhL+fRBmvUWREO1gMqFSf8/jr7wceWYYwLHpCvgyc6noSGNMx6/IKc1zpCDjrxKm1t+lMIotkl+nkgfMYiPhfiFTAVBPoIIf+iSMg7GN5ITzzg2tixrFbYjaHBBaIsm6hVWXzcDEihcxVTCdcHgFtJ8behC7rInQg04+fvZK5bI1iMwHzIhgGh8K9j++MhqUN/YlmDcNlAKeiYQdYsCn0RWOAbnfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(508600001)(83380400001)(30864003)(8676002)(19627235002)(5660300002)(9686003)(45080400002)(186003)(26005)(54906003)(71200400001)(110136005)(52536014)(6506007)(8936002)(966005)(53546011)(66446008)(33656002)(2906002)(38070700005)(4326008)(66946007)(66476007)(7696005)(66556008)(64756008)(122000001)(38100700002)(2940100002)(86362001)(316002)(76116006)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x/wpxzk226Mp3wuych9Ki3IgvSU6wrnE465F2dXeD/jWpVYZszKmws/jDUz9?=
 =?us-ascii?Q?jiL1jOomeR01Tf681UwKbPECox6Pe1bdRPeIkVNfx4dxTgdUwpOgPRDnzc7i?=
 =?us-ascii?Q?dHvVqelKgPew3aimzhTDF2LGxOadTEeZbDfARPWcHmuPP6tQ++moIu6WiBgZ?=
 =?us-ascii?Q?rwKnqjDir5tKKA5VOEQxoBngEu++56m51TFFpkLCkYzC3OWPavDarwMHKQVj?=
 =?us-ascii?Q?NvrE2YX52bmpG6b3YxaElA8vzT4GetaJeds++Rk9qrDF/hk9jr2lXpe4JGg4?=
 =?us-ascii?Q?WchSoCgfP9RovRUDG7bB4J0Hzq1v5uUqoGsrejZSIi0mmyq2mQrR4ct5Or87?=
 =?us-ascii?Q?b6Odb8+r9K72pViBVjkOKNsg7d3xs/dOzGXHNDQDs28yLIloeCdar6rpJRnr?=
 =?us-ascii?Q?OenEkXU0bub3ueq8mL58+tSnvJFD9ui5oSJ2/gnVRfMLZWGd3H/Cff+mMCv3?=
 =?us-ascii?Q?X2nN1VkCEeUzafuaZB6km2u3Ux/BvHYv4Wwu1JF0N1qLSwTXvIRGj99BzYNl?=
 =?us-ascii?Q?wt4azo9esVCErSAURmcRioBUqp4xj5sfwNlBx/FuUs9MQQZDOxkWm9m01Gyh?=
 =?us-ascii?Q?ilwcbob423ugFFSUXnesiNdXgsCtI7A8uL4Y5k8+IHsyPyPBfpX7/zPGS9rI?=
 =?us-ascii?Q?AKCmUiZa39PkEwvEIP3qrbpmp8ZFWhlxOxzFMujUlp4V1zeQka4Jvtump8sg?=
 =?us-ascii?Q?grx5zlGJG78nI/44i2HH7Fwl/3EvKnS9z1UfRamkeraUctjMjQaL0W/196B+?=
 =?us-ascii?Q?TB8qbOZ7HQ07qkNZ1WudpiBZEy52lRBsJrATyMbBrKBseqhSTb5MkmYbmBZc?=
 =?us-ascii?Q?QLKZJvpxu/Ij/SdzXaXhwBaCPTJdrhbkccRWPypjRNlQC6g+yktAYjFthxxl?=
 =?us-ascii?Q?zF3e+ZzMUJuiWvhNqvleDod6ozrp4AgkZYY1cXIkms5HupQvHhdlMXNXsVEb?=
 =?us-ascii?Q?48yy1SpnsEF80XXu8yuCGE393zp3yJ0Xu7EVOT5RhNg8YXa8PNcJLTDNaHNP?=
 =?us-ascii?Q?3V5hCufoAcDnunoUc9fbEyMi1jd3ZKUDu14zBa1d9YdhdT0GKO5s6JATfLkb?=
 =?us-ascii?Q?RDrsJcH8rt1X6EHuyFHfKrj2IOrPKVlaw3h6w4w3xYZn4GTo7hL1jTSe2uql?=
 =?us-ascii?Q?TCylMRCmeuGPf8r3WKh/depsypgVVlPKhVsfht5Ws/9ubM7ZBycsLlel5bAP?=
 =?us-ascii?Q?/4wiSitZa0IhzQMEyrFQpFmxwqKfqFpHOnK5czMQhe0ByaooRy6qqIeX9aFb?=
 =?us-ascii?Q?l7SGI+rmbz9uFuS6Tn42l40fB1P0Dytkt8VJ0G+HYEsrXu39RQ0irtr8KXe0?=
 =?us-ascii?Q?+XJenWYTfYOOMMHA1tVh0A9e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c525ed8-4d21-4b15-d990-08d9529a4bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 14:08:09.8099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6cUBaX2GoQPvJyOJ99SSiAdPlPdVQW/Q7LJhoW8Ncqs3+yroLOKEwU3uxRLsfpNof+/v0onSaP4KxVg/+R1lH6i9kI6fiB9VLIChIf3XRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5715
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

Sorry for the noise. Please ignore my previous mails. %pad with reference t=
o dma_addr_t type fixed the issue.

Tested with aarch64 and nios2 tool chain.

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index db4e0a539906..ef82af06a3f3 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -475,8 +475,8 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr=
_t dest, dma_addr_t src,
        struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
        struct rz_dmac_desc *desc;
=20
-       dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx len=3D=
%ld\n",
-               __func__, channel->index, src, dest, len);
+       dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%zx\=
n",
+               __func__, channel->index, &src, &dest, len);
=20
        if (list_empty(&channel->ld_free))
                return NULL;

Regards,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 29 July 2021 14:51
> To: kernel test robot <lkp@intel.com>; Vinod Koul <vkoul@kernel.org>
> Cc: kbuild-all@lists.01.org; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; Chris Paterson <Chris.Paterson2@renesas.com>;
> Geert Uytterhoeven <geert+renesas@glider.be>; dmaengine@vger.kernel.org;
> Chris Brandt <Chris.Brandt@renesas.com>; linux-renesas-soc@vger.kernel.or=
g
> Subject: RE: [PATCH v5 3/3] drivers: dma: sh: Add DMAC driver for RZ/G2L
> SoC
>=20
> If I make format specifier %lld for dma_addr_t then ARM64 compiler is
> happy, but nios compiler complains
>=20
> If I make format specifier %d for dma_addr_t then ARM compiler complains,
> but nios2 is happy
>=20
> So what is the best way to handle format specifier for dma_addr_t for all
> architectures?
>=20
> Regards,
> Biju
>=20
> > Subject: RE: [PATCH v5 3/3] drivers: dma: sh: Add DMAC driver for
> > RZ/G2L SoC
> >
> > Hi All,
> >
> > Looks like there is compiler issue with nios2 cross compilation
> toolchain.
> >
> > As per the kernel documentation %pad is the format specifier for
> > dma_addr_t.
> >
> > This toolchain does not like it. Please let me know if I am missing
> > any thing here.
> >
> > The changes I made to fix the issue reported by bot:-
> > -------------------
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -475,7 +475,7 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan,
> > dma_addr_t dest, dma_addr_t src,
> >         struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> >         struct rz_dmac_desc *desc;
> >
> > -       dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> > len=3D%ld\n",
> > +       dev_dbg(dmac->dev, "%s channel: %d src=3D%lld dst=3D%lld
> > + len=3D%zx\n",
> >                 __func__, channel->index, src, dest, len);
> >
> >         if (list_empty(&channel->ld_free))
> >
> > compilation logs:-
> > ------------------
> > dasb@ree-du1sdd5:~/dmaengine$ COMPILER_INSTALL_PATH=3D$HOME/0day
> > COMPILER=3Dgcc-10.3.0 ~/bin/make.cross ARCH=3Dnios2 Compiler will be
> > installed in /data/dasb/0day make --keep-going CONFIG_OF_ALL_DTBS=3Dy
> > CONFIG_DTC=3Dy
> > CROSS_COMPILE=3D/data/dasb/0day/gcc-10.3.0-nolibc/nios2-linux/bin/nios2=
-
> > linux- --jobs=3D48 ARCH=3Dnios2
> >   CALL    scripts/atomic/check-atomics.sh
> >   CALL    scripts/checksyscalls.sh
> > <stdin>:1515:2: warning: #warning syscall clone3 not implemented [-Wcpp=
]
> >   CHK     include/generated/compile.h
> > make[1]: *** No rule to make target 'arch/nios2/boot/dts/""', needed
> > by 'arch/nios2/boot/dts/built-in.a'.
> > make[1]: Target '__build' not remade because of errors.
> > make: *** [Makefile:1842: arch/nios2/boot/dts] Error 2
> >   CC      drivers/dma/sh/rz-dmac.o
> > In file included from ./include/linux/printk.h:456,
> >                  from ./include/asm-generic/bug.h:22,
> >                  from ./arch/nios2/include/generated/asm/bug.h:1,
> >                  from ./include/linux/bug.h:5,
> >                  from ./include/linux/thread_info.h:13,
> >                  from ./include/asm-generic/current.h:5,
> >                  from ./arch/nios2/include/generated/asm/current.h:1,
> >                  from ./include/linux/sched.h:12,
> >                  from ./include/linux/ratelimit.h:6,
> >                  from ./include/linux/dev_printk.h:16,
> >                  from ./include/linux/device.h:15,
> >                  from ./include/linux/dma-mapping.h:7,
> >                  from drivers/dma/sh/rz-dmac.c:12:
> > drivers/dma/sh/rz-dmac.c: In function 'rz_dmac_prep_dma_memcpy':
> > drivers/dma/sh/rz-dmac.c:478:21: warning: format '%p' expects argument
> > of type 'void *', but argument 6 has type 'dma_addr_t' {aka 'unsigned
> > int'} [-Wformat=3D]
> >   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad
> len=3D%zx\n",
> >       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > ./include/linux/dynamic_debug.h:134:15: note: in definition of macro
> > '__dynamic_func_call'
> >   134 |   func(&id, ##__VA_ARGS__);  \
> >       |               ^~~~~~~~~~~
> > ./include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> > '_dynamic_func_call'
> >   166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
> >       |  ^~~~~~~~~~~~~~~~~~
> > ./include/linux/dev_printk.h:123:2: note: in expansion of macro
> > 'dynamic_dev_dbg'
> >   123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >       |  ^~~~~~~~~~~~~~~
> > ./include/linux/dev_printk.h:123:23: note: in expansion of macro
> 'dev_fmt'
> >   123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >       |                       ^~~~~~~
> > drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg'
> >   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad
> len=3D%zx\n",
> >       |  ^~~~~~~
> > drivers/dma/sh/rz-dmac.c:478:42: note: format string is defined here
> >   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad
> len=3D%zx\n",
> >       |                                         ~^
> >       |                                          |
> >       |                                          void *
> >       |                                         %d
> > In file included from ./include/linux/printk.h:456,
> >                  from ./include/asm-generic/bug.h:22,
> >                  from ./arch/nios2/include/generated/asm/bug.h:1,
> >                  from ./include/linux/bug.h:5,
> >                  from ./include/linux/thread_info.h:13,
> >                  from ./include/asm-generic/current.h:5,
> >                  from ./arch/nios2/include/generated/asm/current.h:1,
> >                  from ./include/linux/sched.h:12,
> >                  from ./include/linux/ratelimit.h:6,
> >                  from ./include/linux/dev_printk.h:16,
> >                  from ./include/linux/device.h:15,
> >                  from ./include/linux/dma-mapping.h:7,
> >                  from drivers/dma/sh/rz-dmac.c:12:
> > drivers/dma/sh/rz-dmac.c:478:21: warning: format '%p' expects argument
> > of type 'void *', but argument 7 has type 'dma_addr_t' {aka 'unsigned
> > int'} [-Wformat=3D]
> >   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad
> len=3D%zx\n",
> >       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
> > ./include/linux/dynamic_debug.h:134:15: note: in definition of macro
> > '__dynamic_func_call'
> >   134 |   func(&id, ##__VA_ARGS__);  \
> >       |               ^~~~~~~~~~~
> > ./include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> > '_dynamic_func_call'
> >   166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
> >       |  ^~~~~~~~~~~~~~~~~~
> > ./include/linux/dev_printk.h:123:2: note: in expansion of macro
> > 'dynamic_dev_dbg'
> >   123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >       |  ^~~~~~~~~~~~~~~
> > ./include/linux/dev_printk.h:123:23: note: in expansion of macro
> 'dev_fmt'
> >   123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >       |                       ^~~~~~~
> > drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg'
> >   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad
> len=3D%zx\n",
> >       |  ^~~~~~~
> > drivers/dma/sh/rz-dmac.c:478:51: note: format string is defined here
> >   478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad
> len=3D%zx\n",
> >       |                                                  ~^
> >       |                                                   |
> >       |                                                   void *
> >       |                                                  %d
> >   CHK     kernel/kheaders_data.tar.xz
> >   AR      drivers/dma/sh/built-in.a
> >   AR      drivers/dma/built-in.a
> >   AR      drivers/built-in.a
> > make: Target '__all' not remade because of errors.
> >
> > Regards,
> > Biju
> >
> > > -----Original Message-----
> > > From: kernel test robot <lkp@intel.com>
> > > Sent: 29 July 2021 12:34
> > > To: Biju Das <biju.das.jz@bp.renesas.com>; Vinod Koul
> > > <vkoul@kernel.org>
> > > Cc: kbuild-all@lists.01.org; Biju Das <biju.das.jz@bp.renesas.com>;
> > > Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> > > Chris Paterson <Chris.Paterson2@renesas.com>; Geert Uytterhoeven
> > > <geert+renesas@glider.be>; dmaengine@vger.kernel.org; Chris Brandt
> > > <Chris.Brandt@renesas.com>; linux-renesas-soc@vger.kernel.org
> > > Subject: Re: [PATCH v5 3/3] drivers: dma: sh: Add DMAC driver for
> > > RZ/G2L SoC
> > >
> > > Hi Biju,
> > >
> > > Thank you for the patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on vkoul-dmaengine/next] [also build test
> > > WARNING on robh/for-next v5.14-rc3 next-20210728] [If your patch is
> > > applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented
> > > in
> > > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > t-
> > > scm.com%2Fdocs%2Fgit-format-
> > > patch&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2887=
f
> > > 48
> > > 8c2f
> > > ef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63763155
> > > 51
> > > 6672
> > > 5253%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> > > BT
> > > iI6I
> > > k1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTJFcD19oJIJ3tWbNwldGo4xy2aaA=
o
> > > uJ
> > > nopP
> > > yZQ2tixo%3D&amp;reserved=3D0]
> > >
> > > url:
> > > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > th
> > > ub.c
> > > om%2F0day-ci%2Flinux%2Fcommits%2FBiju-Das%2FAdd-RZ-G2L-DMAC-
> > > support%2F20210729-
> > > 162632&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff288=
7
> > > f4
> > > 88c2
> > > fef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6376315
> > > 55
> > > 1667
> > > 25253%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> > > JB
> > > TiI6
> > > Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D%2Bg8o5Ec95AfQ5n39E6cJ6lnsz=
i
> > > AR
> > > XpVw
> > > g%2BRoQgBYQks%3D&amp;reserved=3D0
> > > base:
> > > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
it.
> > > kern
> > > el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fvkoul%2Fdmaengine.git&am
> > > p;
> > > data
> > > =3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2887f488c2fef08d95=
2
> > > 84
> > > c66f
> > > %7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637631555166725253%7CU
> > > nk
> > > nown
> > > %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> > > CJ
> > > XVCI
> > > 6Mn0%3D%7C1000&amp;sdata=3DPLRxI4C7cMH0H4QS6Dv045x8zx%2BIlFeb0mV0QLwf=
N
> > > bQ
> > > %3D&
> > > amp;reserved=3D0 next
> > > config: nios2-allyesconfig (attached as .config)
> > > compiler: nios2-linux-gcc (GCC) 10.3.0 reproduce (this is a W=3D1
> > > build):
> > >         wget
> > > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fr=
aw.
> > > gith
> > > ubusercontent.com%2Fintel%2Flkp-
> > > tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=3D04%7C01%7Cbiju.das.jz%4=
0
> > > bp
> > > .ren
> > > esas.com%7C542bfff2887f488c2fef08d95284c66f%7C53d82571da1947e49cb462
> > > 5a
> > > 166a
> > > 4a2a%7C0%7C0%7C637631555166725253%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> > > 4w
> > > LjAw
> > > MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D
> > > mR
> > > WtzY
> > > YmV9%2B8br%2BnBcClZz1roSj4GAxaesZbrtMNjYw%3D&amp;reserved=3D0 -O
> > > ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         #
> > > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > th
> > > ub.c
> > > om%2F0day-
> > > ci%2Flinux%2Fcommit%2Fcfd03e1dedb6793c62ca9acb9642dd314d44ac8e&amp;d
> > > at
> > > a=3D04
> > > %7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2887f488c2fef08d95284c
> > > 66
> > > f%7C
> > > 53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637631555166725253%7CUnkn
> > > ow
> > > n%7C
> > > TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> > > VC
> > > I6Mn
> > > 0%3D%7C1000&amp;sdata=3DrVtsa8DjyZ4TY2hpwlKz%2F6e3kBSubO6VM58rh8ioiNA=
%
> > > 3D
> > > &amp
> > > ;reserved=3D0
> > >         git remote add linux-review
> > > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > th
> > > ub.c
> > > om%2F0day-
> > > ci%2Flinux&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bff=
f
> > > 28
> > > 87f4
> > > 88c2fef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637
> > > 63
> > > 1555
> > > 166735210%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
> > > Ii
> > > LCJB
> > > TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DJb9197GDbxvSzKoZHxgDzTA=
X
> > > nL
> > > AqPL
> > > 8KrH%2Bp7xJHu1A%3D&amp;reserved=3D0
> > >         git fetch --no-tags linux-review Biju-Das/Add-RZ-G2L-DMAC-
> > > support/20210729-162632
> > >         git checkout cfd03e1dedb6793c62ca9acb9642dd314d44ac8e
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-10.3.0
> > > make.cross
> > > ARCH=3Dnios2
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > >    In file included from include/linux/printk.h:456,
> > >                     from include/asm-generic/bug.h:22,
> > >                     from ./arch/nios2/include/generated/asm/bug.h:1,
> > >                     from include/linux/bug.h:5,
> > >                     from include/linux/thread_info.h:13,
> > >                     from include/asm-generic/current.h:5,
> > >                     from
> ./arch/nios2/include/generated/asm/current.h:1,
> > >                     from include/linux/sched.h:12,
> > >                     from include/linux/ratelimit.h:6,
> > >                     from include/linux/dev_printk.h:16,
> > >                     from include/linux/device.h:15,
> > >                     from include/linux/dma-mapping.h:7,
> > >                     from drivers/dma/sh/rz-dmac.c:12:
> > >    drivers/dma/sh/rz-dmac.c: In function 'rz_dmac_prep_dma_memcpy':
> > > >> drivers/dma/sh/rz-dmac.c:478:21: warning: format '%llx' expects
> > > >> argument of type 'long long unsigned int', but argument 6 has
> > > >> type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=3D]
> > >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%=
llx
> > > len=3D%ld\n",
> > >          |
> > > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    include/linux/dynamic_debug.h:134:15: note: in definition of
> > > macro '__dynamic_func_call'
> > >      134 |   func(&id, ##__VA_ARGS__);  \
> > >          |               ^~~~~~~~~~~
> > >    include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> > > '_dynamic_func_call'
> > >      166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
> > >          |  ^~~~~~~~~~~~~~~~~~
> > >    include/linux/dev_printk.h:123:2: note: in expansion of macro
> > > 'dynamic_dev_dbg'
> > >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >          |  ^~~~~~~~~~~~~~~
> > >    include/linux/dev_printk.h:123:23: note: in expansion of macro
> > > 'dev_fmt'
> > >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >          |                       ^~~~~~~
> > >    drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro
> 'dev_dbg'
> > >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%=
llx
> > > len=3D%ld\n",
> > >          |  ^~~~~~~
> > >    drivers/dma/sh/rz-dmac.c:478:46: note: format string is defined
> here
> > >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%=
llx
> > > len=3D%ld\n",
> > >          |                                           ~~~^
> > >          |                                              |
> > >          |                                              long long
> > unsigned
> > > int
> > >          |                                           %x
> > >    In file included from include/linux/printk.h:456,
> > >                     from include/asm-generic/bug.h:22,
> > >                     from ./arch/nios2/include/generated/asm/bug.h:1,
> > >                     from include/linux/bug.h:5,
> > >                     from include/linux/thread_info.h:13,
> > >                     from include/asm-generic/current.h:5,
> > >                     from
> ./arch/nios2/include/generated/asm/current.h:1,
> > >                     from include/linux/sched.h:12,
> > >                     from include/linux/ratelimit.h:6,
> > >                     from include/linux/dev_printk.h:16,
> > >                     from include/linux/device.h:15,
> > >                     from include/linux/dma-mapping.h:7,
> > >                     from drivers/dma/sh/rz-dmac.c:12:
> > >    drivers/dma/sh/rz-dmac.c:478:21: warning: format '%llx' expects
> > > argument of type 'long long unsigned int', but argument 7 has type
> > > 'dma_addr_t' {aka 'unsigned int'} [-Wformat=3D]
> > >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%=
llx
> > > len=3D%ld\n",
> > >          |
> > > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    include/linux/dynamic_debug.h:134:15: note: in definition of
> > > macro '__dynamic_func_call'
> > >      134 |   func(&id, ##__VA_ARGS__);  \
> > >          |               ^~~~~~~~~~~
> > >    include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> > > '_dynamic_func_call'
> > >      166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
> > >          |  ^~~~~~~~~~~~~~~~~~
> > >    include/linux/dev_printk.h:123:2: note: in expansion of macro
> > > 'dynamic_dev_dbg'
> > >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >          |  ^~~~~~~~~~~~~~~
> > >    include/linux/dev_printk.h:123:23: note: in expansion of macro
> > > 'dev_fmt'
> > >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >          |                       ^~~~~~~
> > >    drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro
> 'dev_dbg'
> > >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%=
llx
> > > len=3D%ld\n",
> > >          |  ^~~~~~~
> > >    drivers/dma/sh/rz-dmac.c:478:57: note: format string is defined
> here
> > >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%=
llx
> > > len=3D%ld\n",
> > >          |                                                      ~~~^
> > >          |                                                         |
> > >          |
> long
> > > long unsigned int
> > >          |                                                      %x
> > >    In file included from include/linux/printk.h:456,
> > >                     from include/asm-generic/bug.h:22,
> > >                     from ./arch/nios2/include/generated/asm/bug.h:1,
> > >                     from include/linux/bug.h:5,
> > >                     from include/linux/thread_info.h:13,
> > >                     from include/asm-generic/current.h:5,
> > >                     from
> ./arch/nios2/include/generated/asm/current.h:1,
> > >                     from include/linux/sched.h:12,
> > >                     from include/linux/ratelimit.h:6,
> > >                     from include/linux/dev_printk.h:16,
> > >                     from include/linux/device.h:15,
> > >                     from include/linux/dma-mapping.h:7,
> > >                     from drivers/dma/sh/rz-dmac.c:12:
> > > >> drivers/dma/sh/rz-dmac.c:478:21: warning: format '%ld' expects
> > > >> argument of type 'long int', but argument 8 has type 'size_t'
> > > >> {aka 'unsigned int'} [-Wformat=3D]
> > >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%=
llx
> > > len=3D%ld\n",
> > >          |
> > > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    include/linux/dynamic_debug.h:134:15: note: in definition of
> > > macro '__dynamic_func_call'
> > >      134 |   func(&id, ##__VA_ARGS__);  \
> > >          |               ^~~~~~~~~~~
> > >    include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> > > '_dynamic_func_call'
> > >      166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
> > >          |  ^~~~~~~~~~~~~~~~~~
> > >    include/linux/dev_printk.h:123:2: note: in expansion of macro
> > > 'dynamic_dev_dbg'
> > >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >          |  ^~~~~~~~~~~~~~~
> > >    include/linux/dev_printk.h:123:23: note: in expansion of macro
> > > 'dev_fmt'
> > >      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >          |                       ^~~~~~~
> > >    drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro
> 'dev_dbg'
> > >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%=
llx
> > > len=3D%ld\n",
> > >          |  ^~~~~~~
> > >    drivers/dma/sh/rz-dmac.c:478:65: note: format string is defined
> here
> > >      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%=
llx
> > > len=3D%ld\n",
> > >          |
> > > ~~^
> > >          |
> > > |
> > >          |
> > > long int
> > >          |
> > > %d
> > >
> > >
> > > vim +478 drivers/dma/sh/rz-dmac.c
> > >
> > >    469
> > >    470	static struct dma_async_tx_descriptor *
> > >    471	rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t
> > > dest, dma_addr_t src,
> > >    472				size_t len, unsigned long flags)
> > >    473	{
> > >    474		struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> > >    475		struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> > >    476		struct rz_dmac_desc *desc;
> > >    477
> > >  > 478		dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> > > len=3D%ld\n",
> > >    479			__func__, channel->index, src, dest, len);
> > >    480
> > >    481		if (list_empty(&channel->ld_free))
> > >    482			return NULL;
> > >    483
> > >    484		desc =3D list_first_entry(&channel->ld_free, struct
> > > rz_dmac_desc, node);
> > >    485
> > >    486		desc->type =3D RZ_DMAC_DESC_MEMCPY;
> > >    487		desc->src =3D src;
> > >    488		desc->dest =3D dest;
> > >    489		desc->len =3D len;
> > >    490		desc->direction =3D DMA_MEM_TO_MEM;
> > >    491
> > >    492		list_move_tail(channel->ld_free.next, &channel-
> > > >ld_queue);
> > >    493		return vchan_tx_prep(&channel->vc, &desc->vd, flags);
> > >    494	}
> > >    495
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
i
> > > st
> > > s.01
> > > .org%2Fhyperkitty%2Flist%2Fkbuild-
> > > all%40lists.01.org&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%=
7
> > > C5
> > > 42bf
> > > ff2887f488c2fef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7
> > > C0
> > > %7C6
> > > 37631555166735210%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
> > > oi
> > > V2lu
> > > MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DIaa%2FyiTehgWr7=
y
> > > gH
> > > m6xV
> > > 0xspg7HWa79nPlkqUH0HVj0%3D&amp;reserved=3D0
