Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B273E753D98
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jul 2023 16:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbjGNOgr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jul 2023 10:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbjGNOgo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Jul 2023 10:36:44 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14C930C6;
        Fri, 14 Jul 2023 07:36:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk034iMAoqR6mntz7Y5U0rpPRhPoJlrp3irHbgN3VYTmmJZ9d5zr8pjqGB4mQjH4wDxN6RO3irPVIWZ3tDWhQAa6o+7slYlyaz7KkBlQyhvEVUfstY+42+PAhPOCgbfDN3mBHYhZZKUMAON9DJemfcQsB3e0EynvsgjRVQbTbPubJEFoIHXJhREEKaZ0YRPY1ofdg7Uac9c/2eK+PIeJDkHRKRfc0+I9RSu9g6epybGF689mrH0KT70vbBgtKPcLn1lEaeQmz+CPa++zz0Fxg65HiFC5YLsgPmX/gtYDJ7ue6YlYbtXDZc7RtqPiAF0mB3Vb/Xh5VFrGcs91UHXDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ek88tsqH5nCPVZVbREh2dKeUT2Ow79TVmR9RO2e8fqo=;
 b=ealNdVE8AjRf4NPDANZv7QwPTUpmxiQTB+MtlZTNrABqgj/7Uowq8eLhlIwYUHdHGdGOoCHtvKVinZmCCNweTQEhrIagALXfJw37HduLw++4oEbRIcEWqPm8foGsUW7DcRNRet3cpzP0nozDGxxALdAV8qD1UsktvoAL0zFzzrEIWB4vUeXTQBQbpBp/04k2NXCn+66JtAbCA2ubDHkm9npQh39a+GdZKiN+lkDnkov6Kq6wPp7iJ6dGq0lDkkAAlVj8nTPKzbhvkvDh9m0o3drQELiNW8qMYdoXzEKy4H4D9qNnS0THUDxLYOwyqGO08V/73I4kKbyg5BFfXFoEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zigngroup.com; dmarc=pass action=none
 header.from=zigngroup.com; dkim=pass header.d=zigngroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zigngroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek88tsqH5nCPVZVbREh2dKeUT2Ow79TVmR9RO2e8fqo=;
 b=fruKURFljPRC3E0K2Ty7btBe3bOIWnJG7eQWtBvcQmE0EeY80BjxHOQvmsZtWmz7K883mRbVbwGfgtLbP8ykfQMs6K/tU+3N4cAW82/1jmgHxJt8QKEKicoPmPp9zj2J/Ds+EfTTfBAuNb61hy7UmprcetpLCf9+XrlunUkapZFpWuwhRtn6IMS9xsKSvFcWyzLJ7r1K6NUj8o0UapNmIn0pxtfDYA4Q2waJB59XouYxzoGBS2AHelP886pdjEAV+2DWB3X+hNPGpSA8Imr3y96/dldg/mZyHT4mXnyPQjVP0FoBGDkJrfC68pCvnQqcKDm5AkBrZfG+79LkUwlW6Q==
Received: from AM0PR08MB3089.eurprd08.prod.outlook.com (2603:10a6:208:57::16)
 by PAXPR08MB6352.eurprd08.prod.outlook.com (2603:10a6:102:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 14:36:28 +0000
Received: from AM0PR08MB3089.eurprd08.prod.outlook.com
 ([fe80::b8db:c667:26f2:c7a2]) by AM0PR08MB3089.eurprd08.prod.outlook.com
 ([fe80::b8db:c667:26f2:c7a2%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 14:36:27 +0000
From:   Tim van der Staaij | Zign <Tim.vanderstaaij@zigngroup.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: deadlock when imx-sdma logs "restart cyclic channel"
Thread-Topic: PROBLEM: deadlock when imx-sdma logs "restart cyclic channel"
Thread-Index: AQHZr+fVlI/NmSx7t0uXzxV1fonxNA==
Date:   Fri, 14 Jul 2023 14:36:27 +0000
Message-ID: <AM0PR08MB308979EC3A8A53AE6E2D3408802CA@AM0PR08MB3089.eurprd08.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zigngroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR08MB3089:EE_|PAXPR08MB6352:EE_
x-ms-office365-filtering-correlation-id: 58b577cf-5846-4a35-e2fa-08db8477b511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j5KK0G1ebBGsTVtyNi1j4sF6CGWxnRbrCu4JC+YbhNWf8BYcMs04L3BrLF/tS38bTnzowZs7iS9faKUfwBQnZrmgS1aD0mx9RxcWjOseOW8gppfQUpS5ZTZm80z18irLYBqge33oqr1OoYQRyROloDPUfRJ6ImwkwnCaAFdQNTWqCgh77C/slxUJ9kZL8ab68WTTAVHr7RhHBowxdme7UBGuw//F/Sk4LCdql7CHHmdqbyPftMw4aGGwR19GrLo/1rEvuQlDgm0g5CJtFBTCeC2VR4mZfiGO9016qNhWLj+4T2Ei3qhwp2eTEzQuaNKOQ0qJhOfJIcpFG+88s4TOJX7KUybYcVTti38CNrXiURZsTrI7VduaTUu5C28DZoPAbTmGhD/5ZRnYPiI8xQMety0IwpVHM5v4YLHCXYhCYJtjLKmeM+wYFJidcwR2ndZO65bXK/0b6Uvr4rhQdSGMPFCoWTS5RZZT3KsWsRaSZBp4n88GKdH003WoHWXLt3qb1tndUTD4LbjulDHztVvWY7bhJuY44039fexaQKyq2wuZMZLG3UOQEfWFk0CIqypIWQE/T7Tbddy2G80rCto8ah6ozxGgQDddEUj7o9sCj4W5Vw28Ajx2OaGQfJY8VSwW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3089.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39830400003)(451199021)(110136005)(54906003)(41300700001)(55016003)(64756008)(66476007)(66446008)(76116006)(4326008)(66946007)(66556008)(478600001)(5660300002)(52536014)(8936002)(2906002)(8676002)(316002)(71200400001)(7696005)(86362001)(26005)(9686003)(6506007)(186003)(83380400001)(33656002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VZl17hPz5lOJa8UsAY+5f/cWNKhMVuKWI4W2KXslJShI8AWvkk8a3hHgvG?=
 =?iso-8859-1?Q?F1yfTAhO1NOwEssa+Em0MtSQEGO1tIjfxz5xkGsWTSpY/McVHuXZzbDkOe?=
 =?iso-8859-1?Q?s5c89gsGmDbb8HLigUvr3EmcFuurAozvzLgPqui3ODRoVZAwBPLhrexsUI?=
 =?iso-8859-1?Q?PFAM5vhsdX4XJwkEC0qhW904Ir7ZJLGjxaSqcLFV+qaZvb/y/fsoz7j7Vp?=
 =?iso-8859-1?Q?FE75XriBTaRYTAeVqx253HDFtpb5w1RrG7AGf7CP3LsJi/9vgvWoArJFtr?=
 =?iso-8859-1?Q?/X4+DblXb3qaAWKKIzmxQfRfI7cdIN6GFM/HS1uAShr+Vkj46l6Svcuv1w?=
 =?iso-8859-1?Q?NF5LzzGoeXzEMDcyDhEjrtQrWoxY1zPRTdqsdDTfjc0vEHZkq7j8akJHGA?=
 =?iso-8859-1?Q?gOLcEgmDAJaN1Lc8Eo7iqhnEJRaqCScVZY0CJREgTAY8ub8lkw6HOqsjku?=
 =?iso-8859-1?Q?LjJxenPa2LS4dwhq6Ia+rhwqdYYhoHXAbS/dgC1SQheYbHt5d+QpLZKevH?=
 =?iso-8859-1?Q?b1GsaqKl3QCBksckwp7C762HvY0mgfHjhI1ILV+LFXMjLNF2uR8PkBq6U0?=
 =?iso-8859-1?Q?IhSN6YUhAl7xuv4mA55d8TpKSQCAMvU6+PbmQWZ4RZDbBYQaBUfK6Bokah?=
 =?iso-8859-1?Q?4wAVKTkhxIEa8l5/iGQ6Qr1J1/O9znGrDEwkoKXmS2AJVIH2SCAIx9cloR?=
 =?iso-8859-1?Q?zEQE1ppwFOSgvhpRQ5RyQchmdPJRMeXBcOulUXDCEpEu0Wc/HQ6Ly+hAVU?=
 =?iso-8859-1?Q?QbbTPLrvDbAoyMjbIIdnf3ED11RnaHv910HAgjtSUGzlxpWJ1flCJGr/gs?=
 =?iso-8859-1?Q?iBzGoOej6cDD4FyyopKz6mpQyfzFiBR2nInHamfMrrWHTmOfM6GLl2IVuT?=
 =?iso-8859-1?Q?ghcnCnKCitXyBkumudBDIO5a5Uy/44rhj6pEpiQwu3hYqm3J0sGigrgW3a?=
 =?iso-8859-1?Q?iiUUW49ySmk1aBjP6Y1O/Qon0zyb1c7Dt6J++fs5EUYam92TiV+8H1QQaw?=
 =?iso-8859-1?Q?xi9KUE9VOzgu9zS2eSreYtMhV9U8VzkANxLafhcKghpPbmc4AiHIOGUrKd?=
 =?iso-8859-1?Q?u8AD2SXcXdRGLpT67BrYMmYNKNw58Ct8SIKVD6Oa5hgawyWF2LNuSyYCF+?=
 =?iso-8859-1?Q?4+r1BphFZLCfNFq1QHQs5bHEGHAQiQ04A7uQv2MUWpeQsJ+26Q3z5y3JyR?=
 =?iso-8859-1?Q?Gl+lizIfn5gG1T433LqEMMXbmbYWHXB+vNuz6fs+TR/WBzniGbhhjan0yc?=
 =?iso-8859-1?Q?+sz0f5KZmE0/v9IGaNNnKzPBEBK+SkByqTfeCr+LGgRA63XhA6I0COmxq+?=
 =?iso-8859-1?Q?08t/EWIZUNlrfS8kNN9TOdDXkvsZ9pJury/hkrOaEd1+0Xkp4gRAuny9ur?=
 =?iso-8859-1?Q?ECz4XuyIbCUBk/E9wp8osyB2TgDTohPsT5VsmzDlax4dpPlvywWS98Xj1b?=
 =?iso-8859-1?Q?FzQ6vslkoWfPknsZJV0MFgsITu1WRl7t9h9wZEClAnLHn+qafM3AXVRO/r?=
 =?iso-8859-1?Q?qhmcvQSVyu/Hd9hWLtuBaqvOsJSGe6R5eDHK8RimqV472QUsbHHueWyOnd?=
 =?iso-8859-1?Q?MC8ENi9kXfSJxoMXxKyKLqybPDdK5P3TrFfb7dDOpVrXFANbDNHfI7h6Qj?=
 =?iso-8859-1?Q?1yq7cBkq4zYfDPkhR6l44dQJ6Sp2znV3Uh1sOEBeAwv0gQDCekPtB3dg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: zigngroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3089.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b577cf-5846-4a35-e2fa-08db8477b511
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 14:36:27.6863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ec7f600c-e944-4b82-8191-695b8f02591d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tof52/4pHUvj1hTb8I/3TyJS5jPZCv41OuTmxBSn+kL5F4EiavrCm6Y5gdanVI3Pb3nEzsNZjxVMYDE+xEZif+uwT8CQGSLOaMuf8JjlvDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6352
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,=0A=
=0A=
I use an i.MX6ULL UART with DMA enabled. Sometimes when a *lot* of data is =
received on this UART, the kernel hangs, printing this to the serial consol=
e:=0A=
=0A=
[   83.339872] imx-sdma 20ec000.sdma: restart cyclic channel 5=0A=
[   83.340296] =0A=
[   83.340307] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
[   83.340312] WARNING: possible circular locking dependency detected=0A=
[   83.340317] 5.19.14-yocto-standard #1 Not tainted=0A=
[   83.340326] ------------------------------------------------------=0A=
[   83.340329] ssh-keygen/236 is trying to acquire lock:=0A=
[   83.340336] c1718ad8 (console_owner){-...}-{0:0}, at: console_emit_next_=
record.constprop.0+0x120/0x344=0A=
[   83.340388] =0A=
[   83.340388] but task is already holding lock:=0A=
[   83.340392] c391481c (&vc->lock){-.-.}-{2:2}, at: sdma_int_handler+0xb4/=
0x34c [imx_sdma]=0A=
[   83.340442] =0A=
[   83.340442] which lock already depends on the new lock.=0A=
[   83.340442] =0A=
[   83.340447] =0A=
[   83.340447] the existing dependency chain (in reverse order) is:=0A=
[   83.340450] =0A=
[   83.340450] -> #2 (&vc->lock){-.-.}-{2:2}:=0A=
[   83.340469]        sdma_prep_dma_cyclic+0x194/0x1f4 [imx_sdma]=0A=
[   83.340495]        imx_uart_startup+0x494/0x624=0A=
[   83.340508]        uart_port_startup+0x128/0x290=0A=
[   83.340519]        uart_port_activate+0x58/0xc0=0A=
[   83.340530]        tty_port_open+0x80/0xd0=0A=
[   83.340543]        uart_open+0x18/0x20=0A=
[   83.340557]        tty_open+0x128/0x678=0A=
[   83.340570]        chrdev_open+0xc0/0x214=0A=
[   83.340582]        do_dentry_open+0x1a8/0x3fc=0A=
[   83.340596]        path_openat+0xb48/0xe68=0A=
[   83.340606]        do_filp_open+0x5c/0xd4=0A=
[   83.340618]        do_sys_openat2+0xb8/0x188=0A=
[   83.340631]        sys_openat+0x8c/0xd8=0A=
[   83.340642]        ret_fast_syscall+0x0/0x1c=0A=
[   83.340655]        0xbedf9078=0A=
[   83.340662] =0A=
[   83.340662] -> #1 (&port_lock_key){-.-.}-{2:2}:=0A=
[   83.340681]        imx_uart_console_write+0x16c/0x1a8=0A=
[   83.340692]        console_emit_next_record.constprop.0+0x18c/0x344=0A=
[   83.340707]        console_unlock+0x10c/0x270=0A=
[   83.340719]        register_console+0x154/0x2e8=0A=
[   83.340732]        uart_add_one_port+0x4fc/0x564=0A=
[   83.340745]        imx_uart_probe+0x4c0/0x71c=0A=
[   83.340755]        platform_probe+0x58/0xb0=0A=
[   83.340770]        really_probe.part.0+0x9c/0x2b0=0A=
[   83.340783]        __driver_probe_device+0xa0/0x138=0A=
[   83.340793]        driver_probe_device+0x30/0x10c=0A=
[   83.340805]        __driver_attach+0x8c/0x178=0A=
[   83.340815]        bus_for_each_dev+0x80/0xcc=0A=
[   83.340832]        bus_add_driver+0x154/0x1e8=0A=
[   83.340843]        driver_register+0x88/0x11c=0A=
[   83.340854]        imx_uart_init+0x20/0x40=0A=
[   83.340866]        do_one_initcall+0x7c/0x43c=0A=
[   83.340880]        kernel_init_freeable+0x17c/0x228=0A=
[   83.340892]        kernel_init+0x14/0x140=0A=
[   83.340908]        ret_from_fork+0x14/0x28=0A=
[   83.340918]        0x0=0A=
[   83.340925] =0A=
[   83.340925] -> #0 (console_owner){-...}-{0:0}:=0A=
[   83.340946]        lock_acquire.part.0+0xb0/0x250=0A=
[   83.340959]        console_emit_next_record.constprop.0+0x168/0x344=0A=
[   83.340975]        console_unlock+0x10c/0x270=0A=
[   83.340987]        vprintk_emit+0x114/0x358=0A=
[   83.340999]        dev_vprintk_emit+0x114/0x150=0A=
[   83.341016]        dev_printk_emit+0x2c/0x5c=0A=
[   83.341030]        __dev_printk+0x4c/0x6c=0A=
[   83.341042]        _dev_warn+0x3c/0x70=0A=
[   83.341057]        sdma_int_handler+0x308/0x34c [imx_sdma]=0A=
[   83.341085]        __handle_irq_event_percpu+0x9c/0x338=0A=
[   83.341096]        handle_irq_event+0x38/0xd0=0A=
[   83.341107]        handle_fasteoi_irq+0x98/0x204=0A=
[   83.341120]        handle_irq_desc+0x1c/0x2c=0A=
[   83.341130]        gic_handle_irq+0x6c/0x90=0A=
[   83.341146]        generic_handle_arch_irq+0x2c/0x64=0A=
[   83.341159]        call_with_stack+0x18/0x20=0A=
[   83.341173]        __irq_usr+0x84/0xa0=0A=
[   83.341184]        0xb6d35e48=0A=
[   83.341191] =0A=
[   83.341191] other info that might help us debug this:=0A=
[   83.341191] =0A=
[   83.341196] Chain exists of:=0A=
[   83.341196]   console_owner --> &port_lock_key --> &vc->lock=0A=
[   83.341196] =0A=
[   83.341221]  Possible unsafe locking scenario:=0A=
[   83.341221] =0A=
[   83.341225]        CPU0                    CPU1=0A=
[   83.341228]        ----                    ----=0A=
[   83.341231]   lock(&vc->lock);=0A=
[   83.341239]                                lock(&port_lock_key);=0A=
[   83.341248]                                lock(&vc->lock);=0A=
[   83.341257]   lock(console_owner);=0A=
[   83.341266] =0A=
[   83.341266]  *** DEADLOCK ***=0A=
[   83.341266] =0A=
[   83.341270] 2 locks held by ssh-keygen/236:=0A=
[   83.341277]  #0: c391481c (&vc->lock){-.-.}-{2:2}, at: sdma_int_handler+=
0xb4/0x34c [imx_sdma]=0A=
[   83.341323]  #1: c17189d8 (console_lock){+.+.}-{0:0}, at: dev_vprintk_em=
it+0x114/0x150=0A=
[   83.341359] =0A=
[   83.341359] stack backtrace:=0A=
[   83.341365] CPU: 0 PID: 236 Comm: ssh-keygen Not tainted 5.19.14-yocto-s=
tandard #1=0A=
[   83.341376] Hardware name: Freescale i.MX6 Ultralite (Device Tree)=0A=
[   83.341387]  unwind_backtrace from show_stack+0x10/0x14=0A=
[   83.341407]  show_stack from dump_stack_lvl+0x60/0x90=0A=
[   83.341427]  dump_stack_lvl from check_noncircular+0x118/0x188=0A=
[   83.341446]  check_noncircular from __lock_acquire+0x1484/0x2b8c=0A=
[   83.341463]  __lock_acquire from lock_acquire.part.0+0xb0/0x250=0A=
[   83.341481]  lock_acquire.part.0 from console_emit_next_record.constprop=
.0+0x168/0x344=0A=
[   83.341503]  console_emit_next_record.constprop.0 from console_unlock+0x=
10c/0x270=0A=
[   83.341524]  console_unlock from vprintk_emit+0x114/0x358=0A=
[   83.341544]  vprintk_emit from dev_vprintk_emit+0x114/0x150=0A=
[   83.341567]  dev_vprintk_emit from dev_printk_emit+0x2c/0x5c=0A=
[   83.341590]  dev_printk_emit from __dev_printk+0x4c/0x6c=0A=
[   83.341610]  __dev_printk from _dev_warn+0x3c/0x70=0A=
[   83.341633]  _dev_warn from sdma_int_handler+0x308/0x34c [imx_sdma]=0A=
[   83.341672]  sdma_int_handler [imx_sdma] from __handle_irq_event_percpu+=
0x9c/0x338=0A=
[   83.341705]  __handle_irq_event_percpu from handle_irq_event+0x38/0xd0=
=0A=
[   83.341720]  handle_irq_event from handle_fasteoi_irq+0x98/0x204=0A=
[   83.341740]  handle_fasteoi_irq from handle_irq_desc+0x1c/0x2c=0A=
[   83.341755]  handle_irq_desc from gic_handle_irq+0x6c/0x90=0A=
[   83.341775]  gic_handle_irq from generic_handle_arch_irq+0x2c/0x64=0A=
[   83.341798]  generic_handle_arch_irq from call_with_stack+0x18/0x20=0A=
[   83.341821]  call_with_stack from __irq_usr+0x84/0xa0=0A=
[   83.341838] Exception stack(0xe0dd5fb0 to 0xe0dd5ff8)=0A=
[   83.341850] 5fa0:                                     00000000 00000007 =
015ee9dc 00000000=0A=
[   83.341864] 5fc0: 00000080 00000000 00000000 00000010 00000040 00000002 =
000000c0 37ea2aa2=0A=
[   83.341874] 5fe0: ffffffff bed21458 00000000 b6d35e48 60030030 ffffffff=
=0A=
=0A=
I noticed that sdma_int_handler calls sdma_update_channel_loop while &sdmac=
->vc is locked. However, sdma_update_channel_loop can log "restart cyclic c=
hannel" in some situations, which will eventually attempt to acquire the lo=
ck of the console owner, which I suppose is the same lock.=0A=
=0A=
Steps to reproduce:=0A=
=0A=
Unfortunately I didn't find a way to consistently reproduce this issue. I c=
an only say that I observed it multiple times in different boots, but only =
when large amounts of data are received.=0A=
=0A=
# cat /proc/version=0A=
Linux version 5.19.14-yocto-standard (oe-user@oe-host) (arm-poky-linux-gnue=
abi-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39.0.20220819) #1 SMP Thu Oct=
 6 18:16:52 UTC 2022=0A=
=0A=
Note: I didn't test on a newer kernel because the diff with this version sh=
ows no relevant changes.=0A=
=0A=
# cat /proc/cpuinfo=0A=
processor	: 0=0A=
model name	: ARMv7 Processor rev 5 (v7l)=0A=
BogoMIPS	: 64.00=0A=
Features	: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt fp=
d32 lpae =0A=
CPU implementer	: 0x41=0A=
CPU architecture: 7=0A=
CPU variant	: 0x0=0A=
CPU part	: 0xc07=0A=
CPU revision	: 5=0A=
Hardware	: Freescale i.MX6 Ultralite (Device Tree)=0A=
=0A=
Relevant device tree additions:=0A=
=0A=
/* Serial console UART */=0A=
&uart1 {=0A=
	pinctrl-names =3D "default";=0A=
	pinctrl-0 =3D <&pinctrl_uart1>;=0A=
	status =3D "okay";=0A=
};=0A=
=0A=
/* RS485 UART with DMA */=0A=
&uart5 {=0A=
	pinctrl-names =3D "default";=0A=
	pinctrl-0 =3D <&pinctrl_uart5>;=0A=
	dmas =3D <&sdma 33 4 1>, <&sdma 34 4 2>;=0A=
	dma-names =3D "rx", "tx";=0A=
	fsl,uart-has-rtscts;=0A=
	linux,rs485-enabled-at-boot-time;=0A=
	status =3D "okay";=0A=
};=0A=
=0A=
Kind regards,=0A=
=0A=
Tim=0A=
