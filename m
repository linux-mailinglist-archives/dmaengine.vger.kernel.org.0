Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB386DC096
	for <lists+dmaengine@lfdr.de>; Sun,  9 Apr 2023 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjDIPrX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Apr 2023 11:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIPrW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Apr 2023 11:47:22 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2076.outbound.protection.outlook.com [40.107.215.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CFE30F8;
        Sun,  9 Apr 2023 08:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqZr2UEG9W98SED5gZB6zhQi43odscdqUUC0gyDVgR+Ve+Qp6Ewm7h1WiNQgCHI6ehS2itKuUt/DzILZl8hA0PxUuziY3lra7PC9IXOzJt8B2oEqo1E2PjYc6lB9Vy1nNQ9TJZIJI6RkLnLHe4EGuxt/AmwVsGFGDS77xCz75+04FgVKTshq/HhKA+5aMj/Jv9lMrqUmVoXD8mCtzJVeRsmtJrU3huMZOuEFq/NFvqSoQ5UdqjlHdo7JO3laDMimjLFOXEEryp4BME7zVJ2KqC3PiR4wEgGht/MLldvjDe7A9Z/gzXW+FJWcFmPZWRHd1jcuYZjaR3ycDlq4XwdDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QVgyoTwhW/xjsYjWtreqNMCFlquweZP0Rkb/VO//xU=;
 b=lguvb3bA/qWyQMa00GrQbdOYKdEMZJj9/RfUxZk3MUdNC+TDKUksum3426+cxRUX2HcgEm2v4MftUlYautqdsiNOQf0IxJfIywytaecSY5YpeG+0sS/+TFpo5oImdH/3o8jwGLgk7M37wvPWXfMKo79Wa7zmMrQLsxj2rDL0j2NZuXAlyrfaJnawWWY/SjFjq+9I/jcpvkt+VnC3wXkJ9vR1uyEJZOc8Av8lPi/TPPSEJUC9GXGOKVHGNXRBkR4nNAkdIihnEGhB3F+YE7Hx3TX5QR5qcbif92FW28YiGLO7k4r+hf5v9twX5o9125C6CP/3dPDKf/Quu9ARgGrS0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QVgyoTwhW/xjsYjWtreqNMCFlquweZP0Rkb/VO//xU=;
 b=ByL9MAKayqVsZM78tdPztYHN/UUZXSoe6aBrFjBPeGTzkvDUZE6DsDtwEk7MGg33R3zv+tgUzqlarGB50m2hHF3znIYbQtdtXVDvX1cMfDeaErsVi3Aq7ktT/YfH8stredEzSmQKV3PISy1K6HidCvElOibMXU8Mev9xdsU21A4iIIfRAbF+bp7RloD/d2GHBCRAWkeT6q3jWbDZ6aeTzjTH1VvJsniv80REfDAU8L4nw3adEb/J4U5qBFTCeNItiQOL7ep5Bfop2N/YhSmZ/52i6GW1ZYFUiEjAbwfhf8pYnnMhdlE/hYvOjLklD79JJbKf0vxySm7H1UE3YDJ7+g==
Received: from TYAPR06MB2239.apcprd06.prod.outlook.com (2603:1096:404:21::20)
 by TYZPR06MB5099.apcprd06.prod.outlook.com (2603:1096:400:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Sun, 9 Apr
 2023 15:47:16 +0000
Received: from TYAPR06MB2239.apcprd06.prod.outlook.com
 ([fe80::b96b:86d9:ffa6:8bf7]) by TYAPR06MB2239.apcprd06.prod.outlook.com
 ([fe80::b96b:86d9:ffa6:8bf7%5]) with mapi id 15.20.6277.038; Sun, 9 Apr 2023
 15:47:15 +0000
From:   Libing Lei <libing.lei@jaguarmicro.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3] dmaengine: dw-axi-dmac: add spinlock for multi-channel
 DMA
Thread-Topic: [PATCH V3] dmaengine: dw-axi-dmac: add spinlock for
 multi-channel DMA
Thread-Index: AQHZZwu29j1XDN66h02IJGS9gD27yq8fa/QAgAOusDA=
Date:   Sun, 9 Apr 2023 15:47:15 +0000
Message-ID: <TYAPR06MB2239EF3AECFB14AA7AB3888E8C949@TYAPR06MB2239.apcprd06.prod.outlook.com>
References: <20230404153945.916-1-libing.lei@jaguarmicro.com>
 <ZC+82NwoumBLYnml@chenyu5-mobl1>
In-Reply-To: <ZC+82NwoumBLYnml@chenyu5-mobl1>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR06MB2239:EE_|TYZPR06MB5099:EE_
x-ms-office365-filtering-correlation-id: 1a90a107-7d3c-472c-ed47-08db3911b14e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +n73awloNX5uxTDGnmDWsZFw6MshCkhC3ANmupVzNow1XWse0QKG06mKQzsV0hfeOR8JQGCGqAyQqPjzSxxB8KGADK8OMByEgOCwG/jVdowJ0dOlZMRGQM4P8iUXGPpS6mqfMc2fapF4giRcmJbJq1KFI0vamj5r8jp0EBDkLC6ndVhUIWuCREvR78v3HuaovYwoYN10POWRDPAwZOklqa0P4vPB9MN+R8ELiuVGigS3RR6mBVgIm+jblIuojWegheJIeXQ3ve7iIGr/W2XYVtNBFllNe0mYKs+zl4B+64vmr3W8W63KZy4ILZQxUE85Uk1LVZtdZwWUVKiGbgMSGzGClvjr0lC75Siz5KiEgMzjn3J9TW6VfkmbmXRHk08fODNeCRJy1gR2kRJZBqVYhQlSZVbF81MTKfAtJE3Cio9ll9BwRdrPf6HK7c6D22NOWPF/4om+8iephwgV22RScJCqADsV9aB1PlNHmtjuP1KssMEwT/QmowFqojhyvlhGJeWPe3bcZSWRx/ic/D5SpufmKzfjT1lfIerRdDAl4N8/vSBf4fO4RPJci06Nv+e9QSFi5fhPSvWYWN/PN/vSfqa7N9yEbdXmp4/bAbM9io9QNF2/ZXFp1qj429jyV4Rk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR06MB2239.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39830400003)(366004)(376002)(346002)(451199021)(478600001)(71200400001)(38100700002)(8676002)(8936002)(316002)(41300700001)(76116006)(66946007)(66556008)(6916009)(4326008)(55016003)(66476007)(66446008)(64756008)(54906003)(122000001)(186003)(2906002)(53546011)(38070700005)(9686003)(6506007)(26005)(86362001)(83380400001)(33656002)(52536014)(5660300002)(7696005)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Qz2nfNpuFYPTd6Ig7WwEiVMSasAuKEwYZCxtHRj/Le9O20wbCgYahheGiZY?=
 =?us-ascii?Q?Q8u+6+JfAMg/vUS2kiZlS6hf54uIiIPDSRgVi+qrOH8DTpUSHYF8mSHPG/uC?=
 =?us-ascii?Q?TC3T7gctf3lELxKVTw/q8AprrwCf07I3YXJG+QWM3t0StgBYu4k3SQvI35cc?=
 =?us-ascii?Q?a02scQgZ9TBl5gm/KZsExXU5vw/YvC4ywfoV30fseetTBr1O3wkelHTD9yti?=
 =?us-ascii?Q?aiHOxf0WX+42QHiYdWduKbMT5U4e7YOhe9motv8nTLfQU90+v1XALlFgD2oh?=
 =?us-ascii?Q?9hxKpRMyh2TDn5dkTAGVthOUwck2HrAZzLeAA6m7s/nWMdzmWsEMuxPNEgUW?=
 =?us-ascii?Q?ZOnBALl8RAdBK39Fm/8hX7Hg9Sziu0sDRkw3hcD6mhKZt/np6ng7xnJuZ3qE?=
 =?us-ascii?Q?sBabWhaeJvAUeiwkSyYaca3pwvNbZGmKJ2wmDbPGG4AnXH/a/G4GEsHUS0pU?=
 =?us-ascii?Q?Xn7XVGPqFcLaaQ7AabN9Lbl+r7GZ1lPch2ttT7HJGpNnPYFKBjNd3ICG5UZl?=
 =?us-ascii?Q?U5jYIVHATpF6+8Kn3u+rl0kceqhiTHKEUlt1Nns3YaBpy9f/gA393GGtqCC0?=
 =?us-ascii?Q?v6KhnGiT1KmlQcI0KTS2So69EjqAx1wF4Vh56sobI6QzQPWSr/aDnaLL1b3o?=
 =?us-ascii?Q?Usv5nU2OwiiRMvp5FRj/Cf39XLLJRp5w/Fp9cMlOWOvsbRU3SQ8vxr8re4ix?=
 =?us-ascii?Q?vrG2uzIQK7KGzQR1+SQ3/XNvQiD4Kd2YAXeunZESIWz/zpCdKftFzxQT1x+g?=
 =?us-ascii?Q?vBiOiNy1bq3hY22fEJozVk2pdItSxtveh2mwmvV0qTDpc/W9tazNaEC5bhro?=
 =?us-ascii?Q?QXhVOcWRzNdQUlh16G5ppT0iF3TBGmF0X2lDywkkaWidLol2OKZgUXlyJ9fo?=
 =?us-ascii?Q?kQuyWwLesiHrs96vUfqMbdTUitiI3g3IO8Cj6PAQFnv0/AYeUWuUd8L9WfN5?=
 =?us-ascii?Q?Mt5nrTLZ4yVzxtMD6n5ZYP+29PfmdbIh9Mb2l2IvpNVcKuyhfTrCJ+R0v5pg?=
 =?us-ascii?Q?p5Tch4J9XfQ8GNA2OnLlwvsckV1GPXT+yr7MGWCUoM8yXqZKYelL87LRYBC+?=
 =?us-ascii?Q?p5K4K3uDqNF9T5V3Vy0P1o/xDItZ27EWbbCFN1P6a/QMj60rd6FBxCqtQNea?=
 =?us-ascii?Q?J1CVRFaSfmZOcd/EvG0hxPlvfTF0M5F0PzdtLnFYpwJW9HOzTVgvavd4Wxdd?=
 =?us-ascii?Q?MSAtaCP4jt7KylZRxBppSlKj1lFL514n0PveT/0oAkJZ/iYEuJ8ftNwj2Ec/?=
 =?us-ascii?Q?1A94WJGDOdSEMe8qs+a6+qhnhPvJ8oFkIzgoAAakdIymHPplUR0YKdrIZGSa?=
 =?us-ascii?Q?X4DyE2dhvRwvMqiZxTP0pmgfa9jZ2VscT3/bfYaySDaMqTi1qRhO+FHCI2xG?=
 =?us-ascii?Q?aaTlMGx8CGda8uzkVx5nl5vIn3dJHdiZ4uUZ7KnxkSz4wET/MNX7pE5S6mlU?=
 =?us-ascii?Q?r02ezTuTPjN0cxRqnQXfV5/sSg5GvlkQ9OxxLzc+6gGBZGv9v9WnYAtjTs00?=
 =?us-ascii?Q?jnioEUChvTYhOpJK7dmKbvw0JfglFhKrr4lYtdGRVWjSvDAIOrHECOgWpVjc?=
 =?us-ascii?Q?3UayoYhIZ0NlH5h9+XdodVgFrwCWdBJWQwusPDYz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR06MB2239.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a90a107-7d3c-472c-ed47-08db3911b14e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2023 15:47:15.4517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2cklDHzLzVLmX6u9pbOyttae8kY52BTzbwR0lvTs2JmeHy9JN7+0JWENPGyrkyqidyH5i/TAIusk50M29mn9LU/4wKJMzMUx4dizTGEWc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5099
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023-04-07 at 14:48:56 +0800, Chen Yu <yu.c.chen@intel.com> wrote:
> On 2023-04-04 at 23:39:45 +0800, Libing Lei wrote:
> > When multiple channels operate simultaneously, the common register shar=
ed
> > by all channels could be set to an unexpected value due to race conditi=
ons
> Does the channel mean the "chip" in the following patch? I mean, each cha=
nnel
> has 1 chip plugged in? I asked this question because I'm trying to figure=
 out the
> protection scope of the introduced spinlock.
No,chip doesn't means "channel" but the dmac chip,which points to some
common registers for all channels.
> > on SMP machines, resulting in a disaster that DMAC cannot work from the=
n
> > on:
> >
> > cpu0                            cpu1
> >  dw_axi_dma_interrupt()
> >   axi_dma_irq_disable(chip)
> >   ...
> >                                 axi_chan_block_xfer_start()
> >                                  axi_dma_enable()
> >                                   val =3D axi_dma_ioread32(chip, DMAC_C=
FG)
> >   axi_dma_irq_enable(chip)
> >                                   axi_dma_iowrite32(chip, DMAC_CFG, val=
)
> >
> > As a result, the global interrupt enable bit INT_EN in the DMAC_CFG
> > register is eventually cleared and the DMAC will no longer generates
> > interrupts.
> >
> > The error scenario is as follows:
> >
> > [ 63.483688] dmatest: dma0chan1-copy: result #18: 'test timed out' with
> > src_off=3D0xc2 dst_off=3D0x27b len=3D0x3a54 (0)
> > [ 63.483693] dmatest: dma0chan2-copy: result #18: 'test timed out' with
> > src_off=3D0x239 dst_off=3D0xfc9 len=3D0x213a (0)
> > [ 63.483696] dmatest: dma0chan0-copy: result #19: 'test timed out' with
> > src_off=3D0x5d1 dst_off=3D0x231 len=3D0x395e (0)
> >
> > a spinlock is added to fix it up.
> >
> Although it is unlikely to introduce ABBA lock, maybe enabling the
> CONFIG_LOCKDEP to have a double check on this.
Thanks for your good suggestion!I have enabled the CONFIG_LOCKDEP in my
testcase:
/ # ls /proc/lockdep*
/proc/lockdep         /proc/lockdep_chains  /proc/lockdep_stats
> > Signed-off-by: Libing Lei <libing.lei@jaguarmicro.com>
> The patch looks good to me.
>=20
> thanks,
> Chenyu
>=20
It's my pleasure.

Best Regards,
Libing.Lei
