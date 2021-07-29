Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49C73DA40E
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 15:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbhG2N06 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 09:26:58 -0400
Received: from mail-eopbgr1410107.outbound.protection.outlook.com ([40.107.141.107]:10336
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237509AbhG2N05 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 29 Jul 2021 09:26:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjTYSPkWt5PQEFM1hmfUSy/1VkUfXq3SPNYfrLPUdE85EWzqMmAVCq4KQ3f3hOVH1myqHHSwLqDoNLyLrzPXncyi0ZxEcxsEK3B7TCkVYKllIi5DtkQ/gsdbWI8D8i/6IKjWj0TAYeKL3EZ5hXRkJwpFCZchGdj4YjWdOXTtxfpV50akxdcjjlGCKWTDeLPmMqRGqH6D+cqb7UKA2wh3o7UFZCeB+hJxI3aB+3601yTjLenI7EPXD2wdAxB2O/dMxQ3DhC3WSDD4HhN5EcTM1hnj+ppaOjbt+DH1QyiE6dz7k8bXkJs5bf1Piyai5F+Pbfd8NsU4lzyZqU5WZM1R+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2hedDtNV2VrglGL/3lYI9Gup38ndp3500SO+cw203w=;
 b=R41IiEDiwJy4HGKKPnZ0ZY0oFnWtlZhdX/73zhiDMs5pVmkLQcsEe5hseQKjOKUdKg/wSRHb57tFnqrTGTqr89G5/lPudBY8z8L2A1nwdxJ18yQ3OeMvPsM1AYA28qT32QUf2u9KTp8WCAXKSdyoa2UVJ0XVPsCWUfa/j8yoA7p5bJNALq+KachDeN7LKiZig0FjSibhH85o8sXYa+kM+gSUAmBmCIxXZsLW6yTE/1ENBgZPj8kVIhs1TW9uPeZlIdN7Sgf4WYx1a0F6LGyrM7+0nHx9SZPOIfhPuFd9u13s/7S/76PtORUyeOAJXQZu2aXLHNbJbt8z72QTJxo9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2hedDtNV2VrglGL/3lYI9Gup38ndp3500SO+cw203w=;
 b=cgJx+WL6dngcTFnQtHLUMc+jHgZLzF3GRi/MDg9lBCWLM4Fzlterjc1DWgsM4XyDNsfd6CtMqS0do0/85uSES+jfDZaogIvzsUe1VReqWau05n+f34onOhAI0l8csPiNV3C4Srg7oBaBOAtUob7sMVUevKDHd3NYPLA0WfD5RoY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB2673.jpnprd01.prod.outlook.com (2603:1096:603:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 13:26:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%8]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 13:26:50 +0000
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
Thread-Index: AQHXhFNN5k7xdihHE0W8RkO2hDq6HqtZ0oyAgAAeZOA=
Date:   Thu, 29 Jul 2021 13:26:49 +0000
Message-ID: <OS0PR01MB592243832A383E3AEA9E213C86EB9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210729082520.26186-4-biju.das.jz@bp.renesas.com>
 <202107291957.CdAuuHpk-lkp@intel.com>
In-Reply-To: <202107291957.CdAuuHpk-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a448c83-6773-4b37-b80d-08d9529485b0
x-ms-traffictypediagnostic: OSAPR01MB2673:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB26732D6AC48DA32D644FE9DA86EB9@OSAPR01MB2673.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYxKsXpx12qdf5Lu6XZwBcf7doqRkyyqkXQjjzyEfUQaksxOVXm9d2c045CMINcHQlLkJm/j7CcS3v16ypxolscvBXyzfQFbNOIosQGdwi0VOYRALa+WbJZsuHOo2BhFLRX666RN6flzC8LnsW5Dbz3ATZE+UaH5+zivJxb24+vmJNSEwPsG7HKRpIPIcwwKU7J6lDXhhT8FQc7Jztz25JvJdSo6oEFEhw5MMljrdF9AZk1kZJz7nVoPnmyMpqOpr8Wu7oC14KW67krT59k7qUhS4G6dfPZMnYHUdUWZRgGdlCfA89PathPS5Y3ENTSsHvYApYDzeV4BOREoJMAnsGxXyDpQO7ZXGIJe5ALeupxz1zqitt2kaADA6dS8GGcKFChjr2L6smJL0JCdd+/yGEdQJlLp7Qco59wXhsEbR8M5orIdEp/UP0DFeEiuZu9PFRS/J6DpLeBzzc3d+kV+YuRV07a4ji+yCWbGaMGnoVrLVeh8GzjKlvMIg8M5x0OhSrFaDHuMuPDb9PlL0jLCo3re5WWX+FPeyIIrDetMAvlIoWVZGYbkPiKhFJCHcqE9l4MPowTWSJ3+OvmUiQ8divPDNzqgKtf0X202zUS4Alxvqn5TVfnfJ8hb7RLZhqmplIe8boENkso8mpMYIuxVDhj5id7+Qk8RVd3bF/4ExpyKWz313lyGWjzu9biIaI3RGKCs9BDeHijflttnj8QikKnL8JBxU2i129C4Ea7A+lGwkzP8OdKezsD1U40RPypt9EcRVasQIf6PvCWf8NJB4cM3Wl9RRFuezTPVi1C/1Qs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(71200400001)(38070700005)(30864003)(316002)(7696005)(110136005)(54906003)(53546011)(52536014)(66946007)(6506007)(9686003)(19627235002)(66476007)(26005)(5660300002)(4326008)(8676002)(186003)(55016002)(64756008)(66556008)(76116006)(966005)(66446008)(33656002)(83380400001)(38100700002)(86362001)(478600001)(2906002)(122000001)(45080400002)(8936002)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LwnOGGNF2XjSWj8Zwp2yc8xdgH2T9aNI678Howf/cPoEPkvffThubqTzWpDv?=
 =?us-ascii?Q?tNq6Bb6cisSgcjb+wrO8wG1WfnCE+9+aUujvx6HncCQLmNv0E5p2nxRS9Utr?=
 =?us-ascii?Q?CDrymlwE1cWxAeXR2c7uWSAbqDr5nFkW5p1PU852iNgs3oOFGHC4ai52F4dP?=
 =?us-ascii?Q?S/SkDoeVyVauzI90D6DSQ7IF2b4tBJGJvL/IxhrgnJQEDVpBrsRdMaVkG05H?=
 =?us-ascii?Q?jgrtQ4FnC33C+eoihZIcibuGK+9s9U3EOv2DEc5a33bBOS1c6K46h7NXo/la?=
 =?us-ascii?Q?8a9E7HyhnB0Mqq9nEoTf/8qHAzKNMED7yCaUDf9p6/2qt+o5hZw1NozTPkMu?=
 =?us-ascii?Q?HJ1J2L0qmXgMW3zED1ZK0f/SK3OutCa0YTMhRZFJ1d1KoxXMvx4bVhJ+fx9Y?=
 =?us-ascii?Q?U6N36RlO8zWMUOhXtk5pQuJk/Z23z20uOuGKkbEgCQDWFqi0lahX8R70rv3J?=
 =?us-ascii?Q?bo+mAiry0zX/NLZ0w+jt0UT/FwaE4sn4HquA9yxcWRaKP+EP5RdK+9yIGnso?=
 =?us-ascii?Q?UvV9JYjICR5grGNmF9f3N70E3KRBrPxDZtfJtkQnOl1aFb7ihWEVCEy1//my?=
 =?us-ascii?Q?pJHy0dyIod2ttHlcuKN2ICLNOqHBa5IHygBkRbwfdqxk2IWo2WUdifPEHT+e?=
 =?us-ascii?Q?nJT+DH9uRRsIJ1tunq4LM6F6DYgp2j+E4m6jJy+1drwWJGPd+BoLXXtsSbDG?=
 =?us-ascii?Q?BEjgvkP4LOsCbdkUAHHp5vJUywQZra2SlB+05OeiaG6ch0jABm5pbbTyJ7Q1?=
 =?us-ascii?Q?51r+oAV+tQprluuUEZgpuKurhXlADmRZAVf329wSj9yeNYtK994AiqFeSteC?=
 =?us-ascii?Q?bIZNC2rbZJp7tIl/5yjrDBukqhaWXv2qPJ6rtMaKu3WvWbvXZ0sQXByff/Q6?=
 =?us-ascii?Q?aNB3OTaqguJiOSTBeRDOQhDASb/OOPB/3gW9uPRVGUXlGZCAf0Cf9TKVDmSP?=
 =?us-ascii?Q?WQ0yobNTJGBKkyXmlg7zrl245hKbu14ISNEbYo3QTUnlujUQhrv2FZFPAb7m?=
 =?us-ascii?Q?ZvVOh0gFjZQq+xj2nxOlZXP/e+fUsEA3X9Msm1B3RWuaSubmM2yg4N13OKQm?=
 =?us-ascii?Q?gcIHHQVkvq+fMAUL+j7TMMZSOH07k8fmVlWLu1Ij8a73CbkfYRoPuKUSxa0+?=
 =?us-ascii?Q?ut9z3vC3sbB5C35mm51WIOlCHtDu9mQPcD1lvNq0RI57Yui8mUc4jif9KfDr?=
 =?us-ascii?Q?zEAuFsHvpQ5H+AWfwfMUfV+2xhI0v05fu6kKkz68F3oZdaHfMuLRgct3Jz8u?=
 =?us-ascii?Q?9ZY9CGbs/V3AEv/l5IrO8HQNltG3NJWGQYjzr7UgjZTsDHraqcRvb/Kypvp3?=
 =?us-ascii?Q?lo9l2wchBavc0qR4Pegx35QE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a448c83-6773-4b37-b80d-08d9529485b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 13:26:49.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C36SEO6FlynoRUPsyYQl8ND8X0DWWjZrpCskgaUUHo0D3h5x8Gew70bTjLUcUgCha0t0V6UuP8skqbsjhxMf5q9H5tMXT2O7xjGQYqPDO70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2673
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

Looks like there is compiler issue with nios2 cross compilation toolchain.

As per the kernel documentation %pad is the format specifier for dma_addr_t=
.

This toolchain does not like it. Please let me know if I am missing any thi=
ng here.

The changes I made to fix the issue reported by bot:-
-------------------
+++ b/drivers/dma/sh/rz-dmac.c
@@ -475,7 +475,7 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr=
_t dest, dma_addr_t src,
        struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
        struct rz_dmac_desc *desc;
=20
-       dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx len=3D=
%ld\n",
+       dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%zx\=
n",
                __func__, channel->index, src, dest, len);
=20
        if (list_empty(&channel->ld_free))

compilation logs:-
------------------
dasb@ree-du1sdd5:~/dmaengine$ COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=
=3Dgcc-10.3.0 ~/bin/make.cross ARCH=3Dnios2=20
Compiler will be installed in /data/dasb/0day
make --keep-going CONFIG_OF_ALL_DTBS=3Dy CONFIG_DTC=3Dy CROSS_COMPILE=3D/da=
ta/dasb/0day/gcc-10.3.0-nolibc/nios2-linux/bin/nios2-linux- --jobs=3D48 ARC=
H=3Dnios2
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
<stdin>:1515:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  CHK     include/generated/compile.h
make[1]: *** No rule to make target 'arch/nios2/boot/dts/""', needed by 'ar=
ch/nios2/boot/dts/built-in.a'.
make[1]: Target '__build' not remade because of errors.
make: *** [Makefile:1842: arch/nios2/boot/dts] Error 2
  CC      drivers/dma/sh/rz-dmac.o
In file included from ./include/linux/printk.h:456,
                 from ./include/asm-generic/bug.h:22,
                 from ./arch/nios2/include/generated/asm/bug.h:1,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:13,
                 from ./include/asm-generic/current.h:5,
                 from ./arch/nios2/include/generated/asm/current.h:1,
                 from ./include/linux/sched.h:12,
                 from ./include/linux/ratelimit.h:6,
                 from ./include/linux/dev_printk.h:16,
                 from ./include/linux/device.h:15,
                 from ./include/linux/dma-mapping.h:7,
                 from drivers/dma/sh/rz-dmac.c:12:
drivers/dma/sh/rz-dmac.c: In function 'rz_dmac_prep_dma_memcpy':
drivers/dma/sh/rz-dmac.c:478:21: warning: format '%p' expects argument of t=
ype 'void *', but argument 6 has type 'dma_addr_t' {aka 'unsigned int'} [-W=
format=3D]
  478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%zx=
\n",
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:134:15: note: in definition of macro '__dyn=
amic_func_call'
  134 |   func(&id, ##__VA_ARGS__);  \
      |               ^~~~~~~~~~~
./include/linux/dynamic_debug.h:166:2: note: in expansion of macro '_dynami=
c_func_call'
  166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/dev_printk.h:123:2: note: in expansion of macro 'dynamic_de=
v_dbg'
  123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~
./include/linux/dev_printk.h:123:23: note: in expansion of macro 'dev_fmt'
  123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                       ^~~~~~~
drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg'
  478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%zx=
\n",
      |  ^~~~~~~
drivers/dma/sh/rz-dmac.c:478:42: note: format string is defined here
  478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%zx=
\n",
      |                                         ~^
      |                                          |
      |                                          void *
      |                                         %d
In file included from ./include/linux/printk.h:456,
                 from ./include/asm-generic/bug.h:22,
                 from ./arch/nios2/include/generated/asm/bug.h:1,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:13,
                 from ./include/asm-generic/current.h:5,
                 from ./arch/nios2/include/generated/asm/current.h:1,
                 from ./include/linux/sched.h:12,
                 from ./include/linux/ratelimit.h:6,
                 from ./include/linux/dev_printk.h:16,
                 from ./include/linux/device.h:15,
                 from ./include/linux/dma-mapping.h:7,
                 from drivers/dma/sh/rz-dmac.c:12:
drivers/dma/sh/rz-dmac.c:478:21: warning: format '%p' expects argument of t=
ype 'void *', but argument 7 has type 'dma_addr_t' {aka 'unsigned int'} [-W=
format=3D]
  478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%zx=
\n",
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/dynamic_debug.h:134:15: note: in definition of macro '__dyn=
amic_func_call'
  134 |   func(&id, ##__VA_ARGS__);  \
      |               ^~~~~~~~~~~
./include/linux/dynamic_debug.h:166:2: note: in expansion of macro '_dynami=
c_func_call'
  166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/dev_printk.h:123:2: note: in expansion of macro 'dynamic_de=
v_dbg'
  123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~
./include/linux/dev_printk.h:123:23: note: in expansion of macro 'dev_fmt'
  123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                       ^~~~~~~
drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg'
  478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%zx=
\n",
      |  ^~~~~~~
drivers/dma/sh/rz-dmac.c:478:51: note: format string is defined here
  478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D%pad dst=3D%pad len=3D%zx=
\n",
      |                                                  ~^
      |                                                   |
      |                                                   void *
      |                                                  %d
  CHK     kernel/kheaders_data.tar.xz
  AR      drivers/dma/sh/built-in.a
  AR      drivers/dma/built-in.a
  AR      drivers/built-in.a
make: Target '__all' not remade because of errors.

Regards,
Biju

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: 29 July 2021 12:34
> To: Biju Das <biju.das.jz@bp.renesas.com>; Vinod Koul <vkoul@kernel.org>
> Cc: kbuild-all@lists.01.org; Biju Das <biju.das.jz@bp.renesas.com>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Chris
> Paterson <Chris.Paterson2@renesas.com>; Geert Uytterhoeven
> <geert+renesas@glider.be>; dmaengine@vger.kernel.org; Chris Brandt
> <Chris.Brandt@renesas.com>; linux-renesas-soc@vger.kernel.org
> Subject: Re: [PATCH v5 3/3] drivers: dma: sh: Add DMAC driver for RZ/G2L
> SoC
>=20
> Hi Biju,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on vkoul-dmaengine/next] [also build test WARNIN=
G
> on robh/for-next v5.14-rc3 next-20210728] [If your patch is applied to th=
e
> wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit-
> scm.com%2Fdocs%2Fgit-format-
> patch&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2887f488=
c2f
> ef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6376315551667=
2
> 5253%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6=
I
> k1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTJFcD19oJIJ3tWbNwldGo4xy2aaAouJn=
opP
> yZQ2tixo%3D&amp;reserved=3D0]
>=20
> url:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.c
> om%2F0day-ci%2Flinux%2Fcommits%2FBiju-Das%2FAdd-RZ-G2L-DMAC-
> support%2F20210729-
> 162632&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2887f48=
8c2
> fef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637631555166=
7
> 25253%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI=
6
> Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D%2Bg8o5Ec95AfQ5n39E6cJ6lnsziARX=
pVw
> g%2BRoQgBYQks%3D&amp;reserved=3D0
> base:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ern
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fvkoul%2Fdmaengine.git&amp;dat=
a
> =3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2887f488c2fef08d95284c=
66f
> %7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637631555166725253%7CUnknow=
n
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I
> 6Mn0%3D%7C1000&amp;sdata=3DPLRxI4C7cMH0H4QS6Dv045x8zx%2BIlFeb0mV0QLwfNbQ%=
3D&
> amp;reserved=3D0 next
> config: nios2-allyesconfig (attached as .config)
> compiler: nios2-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=3D1 build):
>         wget
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fraw.g=
ith
> ubusercontent.com%2Fintel%2Flkp-
> tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.=
ren
> esas.com%7C542bfff2887f488c2fef08d95284c66f%7C53d82571da1947e49cb4625a166=
a
> 4a2a%7C0%7C0%7C637631555166725253%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
w
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DmRW=
tzY
> YmV9%2B8br%2BnBcClZz1roSj4GAxaesZbrtMNjYw%3D&amp;reserved=3D0 -O
> ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.c
> om%2F0day-
> ci%2Flinux%2Fcommit%2Fcfd03e1dedb6793c62ca9acb9642dd314d44ac8e&amp;data=
=3D04
> %7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff2887f488c2fef08d95284c66f%7=
C
> 53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637631555166725253%7CUnknown%7=
C
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n
> 0%3D%7C1000&amp;sdata=3DrVtsa8DjyZ4TY2hpwlKz%2F6e3kBSubO6VM58rh8ioiNA%3D&=
amp
> ;reserved=3D0
>         git remote add linux-review
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.c
> om%2F0day-
> ci%2Flinux&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C542bfff288=
7f4
> 88c2fef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63763155=
5
> 166735210%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ=
B
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DJb9197GDbxvSzKoZHxgDzTAXnLA=
qPL
> 8KrH%2Bp7xJHu1A%3D&amp;reserved=3D0
>         git fetch --no-tags linux-review Biju-Das/Add-RZ-G2L-DMAC-
> support/20210729-162632
>         git checkout cfd03e1dedb6793c62ca9acb9642dd314d44ac8e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-10.3.0 make.cro=
ss
> ARCH=3Dnios2
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>    In file included from include/linux/printk.h:456,
>                     from include/asm-generic/bug.h:22,
>                     from ./arch/nios2/include/generated/asm/bug.h:1,
>                     from include/linux/bug.h:5,
>                     from include/linux/thread_info.h:13,
>                     from include/asm-generic/current.h:5,
>                     from ./arch/nios2/include/generated/asm/current.h:1,
>                     from include/linux/sched.h:12,
>                     from include/linux/ratelimit.h:6,
>                     from include/linux/dev_printk.h:16,
>                     from include/linux/device.h:15,
>                     from include/linux/dma-mapping.h:7,
>                     from drivers/dma/sh/rz-dmac.c:12:
>    drivers/dma/sh/rz-dmac.c: In function 'rz_dmac_prep_dma_memcpy':
> >> drivers/dma/sh/rz-dmac.c:478:21: warning: format '%llx' expects
> >> argument of type 'long long unsigned int', but argument 6 has type
> >> 'dma_addr_t' {aka 'unsigned int'} [-Wformat=3D]
>      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> len=3D%ld\n",
>          |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/dynamic_debug.h:134:15: note: in definition of macro
> '__dynamic_func_call'
>      134 |   func(&id, ##__VA_ARGS__);  \
>          |               ^~~~~~~~~~~
>    include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> '_dynamic_func_call'
>      166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
>          |  ^~~~~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:123:2: note: in expansion of macro
> 'dynamic_dev_dbg'
>      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>          |  ^~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:123:23: note: in expansion of macro
> 'dev_fmt'
>      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>          |                       ^~~~~~~
>    drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg'
>      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> len=3D%ld\n",
>          |  ^~~~~~~
>    drivers/dma/sh/rz-dmac.c:478:46: note: format string is defined here
>      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> len=3D%ld\n",
>          |                                           ~~~^
>          |                                              |
>          |                                              long long unsigne=
d
> int
>          |                                           %x
>    In file included from include/linux/printk.h:456,
>                     from include/asm-generic/bug.h:22,
>                     from ./arch/nios2/include/generated/asm/bug.h:1,
>                     from include/linux/bug.h:5,
>                     from include/linux/thread_info.h:13,
>                     from include/asm-generic/current.h:5,
>                     from ./arch/nios2/include/generated/asm/current.h:1,
>                     from include/linux/sched.h:12,
>                     from include/linux/ratelimit.h:6,
>                     from include/linux/dev_printk.h:16,
>                     from include/linux/device.h:15,
>                     from include/linux/dma-mapping.h:7,
>                     from drivers/dma/sh/rz-dmac.c:12:
>    drivers/dma/sh/rz-dmac.c:478:21: warning: format '%llx' expects
> argument of type 'long long unsigned int', but argument 7 has type
> 'dma_addr_t' {aka 'unsigned int'} [-Wformat=3D]
>      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> len=3D%ld\n",
>          |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/dynamic_debug.h:134:15: note: in definition of macro
> '__dynamic_func_call'
>      134 |   func(&id, ##__VA_ARGS__);  \
>          |               ^~~~~~~~~~~
>    include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> '_dynamic_func_call'
>      166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
>          |  ^~~~~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:123:2: note: in expansion of macro
> 'dynamic_dev_dbg'
>      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>          |  ^~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:123:23: note: in expansion of macro
> 'dev_fmt'
>      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>          |                       ^~~~~~~
>    drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg'
>      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> len=3D%ld\n",
>          |  ^~~~~~~
>    drivers/dma/sh/rz-dmac.c:478:57: note: format string is defined here
>      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> len=3D%ld\n",
>          |                                                      ~~~^
>          |                                                         |
>          |                                                         long
> long unsigned int
>          |                                                      %x
>    In file included from include/linux/printk.h:456,
>                     from include/asm-generic/bug.h:22,
>                     from ./arch/nios2/include/generated/asm/bug.h:1,
>                     from include/linux/bug.h:5,
>                     from include/linux/thread_info.h:13,
>                     from include/asm-generic/current.h:5,
>                     from ./arch/nios2/include/generated/asm/current.h:1,
>                     from include/linux/sched.h:12,
>                     from include/linux/ratelimit.h:6,
>                     from include/linux/dev_printk.h:16,
>                     from include/linux/device.h:15,
>                     from include/linux/dma-mapping.h:7,
>                     from drivers/dma/sh/rz-dmac.c:12:
> >> drivers/dma/sh/rz-dmac.c:478:21: warning: format '%ld' expects
> >> argument of type 'long int', but argument 8 has type 'size_t' {aka
> >> 'unsigned int'} [-Wformat=3D]
>      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> len=3D%ld\n",
>          |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/dynamic_debug.h:134:15: note: in definition of macro
> '__dynamic_func_call'
>      134 |   func(&id, ##__VA_ARGS__);  \
>          |               ^~~~~~~~~~~
>    include/linux/dynamic_debug.h:166:2: note: in expansion of macro
> '_dynamic_func_call'
>      166 |  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
>          |  ^~~~~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:123:2: note: in expansion of macro
> 'dynamic_dev_dbg'
>      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>          |  ^~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:123:23: note: in expansion of macro
> 'dev_fmt'
>      123 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>          |                       ^~~~~~~
>    drivers/dma/sh/rz-dmac.c:478:2: note: in expansion of macro 'dev_dbg'
>      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> len=3D%ld\n",
>          |  ^~~~~~~
>    drivers/dma/sh/rz-dmac.c:478:65: note: format string is defined here
>      478 |  dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> len=3D%ld\n",
>          |
> ~~^
>          |
> |
>          |
> long int
>          |
> %d
>=20
>=20
> vim +478 drivers/dma/sh/rz-dmac.c
>=20
>    469
>    470	static struct dma_async_tx_descriptor *
>    471	rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t
> dest, dma_addr_t src,
>    472				size_t len, unsigned long flags)
>    473	{
>    474		struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
>    475		struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>    476		struct rz_dmac_desc *desc;
>    477
>  > 478		dev_dbg(dmac->dev, "%s channel: %d src=3D0x%llx dst=3D0x%llx
> len=3D%ld\n",
>    479			__func__, channel->index, src, dest, len);
>    480
>    481		if (list_empty(&channel->ld_free))
>    482			return NULL;
>    483
>    484		desc =3D list_first_entry(&channel->ld_free, struct
> rz_dmac_desc, node);
>    485
>    486		desc->type =3D RZ_DMAC_DESC_MEMCPY;
>    487		desc->src =3D src;
>    488		desc->dest =3D dest;
>    489		desc->len =3D len;
>    490		desc->direction =3D DMA_MEM_TO_MEM;
>    491
>    492		list_move_tail(channel->ld_free.next, &channel-
> >ld_queue);
>    493		return vchan_tx_prep(&channel->vc, &desc->vd, flags);
>    494	}
>    495
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.01
> .org%2Fhyperkitty%2Flist%2Fkbuild-
> all%40lists.01.org&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7C54=
2bf
> ff2887f488c2fef08d95284c66f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C=
6
> 37631555166735210%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l=
u
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DIaa%2FyiTehgWr7ygHm=
6xV
> 0xspg7HWa79nPlkqUH0HVj0%3D&amp;reserved=3D0
