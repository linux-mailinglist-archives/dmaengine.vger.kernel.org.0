Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C90324468E
	for <lists+dmaengine@lfdr.de>; Fri, 14 Aug 2020 10:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHNIpX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Aug 2020 04:45:23 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:51145
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbgHNIpX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Aug 2020 04:45:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKHKFqHc3/g5pAeee1raTaoWB+4ady3OQIWnL26c2dVm5r/RzZuFJgripcbb/+dOjasYhAkDw7wJ5vyztn0UvpKU0AMToNH3HBdQBb8ZR0gqItL7RIxuFu7QCwYEJL0EXZjUTIkKWDIFeQ8wEMdMON9WU8+sSTKzIDL1WR90UtlFXdElch45IexzS5MLdtcYwyztkxzcYC+dVYoYh+hOVeMbPBtcNWcHP9RfwaMB+p6yzdQod/8IFk6M9W0bluzAjke/uZPMy6/NHVkBUPBXGbtUUvDLfYPxCtwzsmDMj9oAkI3VO12//w0VoUX0SZ5zjMj/8vB8y606WElqf6DQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT7gVHa83ywzYJSFGQ/gYZyrQfv4p5BGZSmbyQCrhS4=;
 b=WjMZnAzs7B8dsFeXa8OnlAMkexVG4fJ2EfUsGtIOPoU6Im42S2+Lf96diA5bo/6i3Mckpp+7TMdixkdl3EsHqEyPOSs8J52DiELkqKX/XD8zOkiGCuFoqE29k0ulzCKMa/Ojr827h4VrcTMNl2qvc/PgAVTRhEtrB9MYLM/NRGqbExFLZ7JNvf7yOeYPCb4s+xub3NSmarBZIE0/F5LLTMesF0KSjkqd+PKY/G2YwjaApl+n2MAC1lmO/MqySx594lEWnOJqqFZzXDjywEiRmlRgHHPOTrTMvxTYj3JEdJyolLnRSY2ACKP0nG8aIq/qHULvHT6TI1/+26/UhWSEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT7gVHa83ywzYJSFGQ/gYZyrQfv4p5BGZSmbyQCrhS4=;
 b=X06XmTAxiAj9NxDHaIFd0qsIxymmjHLk9QtCyN+bNC/6ea8UUUNu+oMgUstBZD+RJ07ORuue7r41um+1nrtxsvpZ5MSokR8vvtptTSDxAKrPoqmuM/u+9xXRbJqxUIq18wAm1aNiURToFLJJH4Z9aOO32J2RH8BQZQ1rpSG6uBc=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5502.eurprd04.prod.outlook.com (2603:10a6:803:c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 08:45:18 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3283.020; Fri, 14 Aug 2020
 08:45:17 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Richard Leitner <richard.leitner@skidata.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: RE: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Topic: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Index: AQHWcWQbD9eqMlwY2U27XyctTVPmVak3Rd/w
Date:   Fri, 14 Aug 2020 08:45:17 +0000
Message-ID: <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20200813112258.GA327172@pcleri>
In-Reply-To: <20200813112258.GA327172@pcleri>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: skidata.com; dkim=none (message not signed)
 header.d=none;skidata.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7990903c-ebe7-49c1-0208-08d8402e5f06
x-ms-traffictypediagnostic: VI1PR04MB5502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB55022CAB67DD43B8A5BE81F989400@VI1PR04MB5502.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rJLHQuDk+RXddueGGDO64rqAdXRSzEoMPnAcpi69T9uM4MRaTM65JDWLdU9O9fc69CI6My6VlFpqLpMd7wwRjwCHWMpU4GcPDUU6vDrKr+INDIZcQRpOGHzRZg7F9rOd9ctRScasCM1RVMTF1JgyDa98Bt3ScYYXCP14zvL+ba2o08tH0fHJ/9VdfbsDQrZtlYIRUPXMO8dWV5Nex1O38j07aOLL2g7LLmZStFskEcHe0gjabFp5cEuZqvZV7iuTZZUk10jB6g4pRJiTFoxznC256unSYD1PpBkB6UbDZZIrwuCiBXwJ7UktRfSVFsybSWhFlW+G5MSAZenJ6bnekDJFUaK6ZuTwp5/PyyrwLhct3tO7plnIVhXCfBGiTSyIpLXuD3NWaLxaWKeTLCeHnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(2906002)(8676002)(7416002)(316002)(110136005)(8936002)(71200400001)(33656002)(54906003)(6506007)(55016002)(26005)(7696005)(186003)(9686003)(66476007)(4326008)(86362001)(966005)(478600001)(76116006)(66946007)(66556008)(45080400002)(52536014)(5660300002)(83380400001)(83080400001)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: k2OhU4goLA1npSdTfmq/W8qnlwelM1WGwVX+XeN1W/P1US1o6Y4Jl0w1W8kAUoI+O8hLbz0sLdkk9kE51M4TB/q24oJZnGKVdJyRRQe4yTXCYuULNhNdc6/M2hgTdXDQ6TDjbusQHuXnFM95D71BPfYdiQMPKGTpJ/+E/0WTgfGYbbafR2gEM8SWLSztkwlCGhEhpzEZcItm4XRev3CQ8xI4HyTWEDXDfM29O9SKr2DDPN0rbvC6+lWy8hon9aJ9l6FmQGRuofAELLCsrNuTHHtGfrToEC81W56GfBSGndRr4aVf73R5rDIO63wNaZogNNwpb8s8GhT2IBfOzbP5SM8N6xnc/jBkjvwGTsCbZiBNSfKiic+p0lh591GohnVCUbvc/s/CNE+A2e4S4cmOfVLE0ohkbR2B4sOVv79GDwX8aZbCYrkgfKHbfT5z88g/+SLHFFmd2PbBQvSDW0HSz00DLmXHkhEmskfeLrhz8bFfBeVGGRuXfifie8Vi33drWRaaucQDYEeaIE6Q2qVUO6eJQP2O85rUV2aeeQXc8Yny0gwEFI/k0rerKBTX4GTZ5gV8J9izyIMzYfwwFkagOI3LPZUomX+A+5BF4vTIs55oZe2g1uFVkCN3Q7gA3s9QAAiK2jOQW1VRjX/ySSrnHg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7990903c-ebe7-49c1-0208-08d8402e5f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 08:45:17.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQzQH/uOEsV0ohV4aLU07OGYFTxWp/SopCQE+PSZfJVN1DUguIAnzhoYIoa4UIROIdepE2XdwL21rQz2LbjOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5502
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/08/13 19:23: Richard Leitner <richard.leitner@skidata.com> wrote:
> Hi,
> we've found a race condition with the PCM on the i.MX6 which results in a=
n
> -EIO for the SNDRV_PCM_IOCTL_READI_FRAMES ioctl after an -EPIPE (XRUN).
>=20
> A possible reproduction may look like the following reduced call graph du=
ring a
> PCM capture:
>=20
> us -> ioctl(SNDRV_PCM_IOCTL_READI_FRAMES)
>       - wait_for_avail()
>         - schedule_timeout()
>    -> snd_pcm_update_hw_ptr0()
>       - snd_pcm_update_state: EPIPE (XRUN)
>       - sdma_disable_channel_async() # get's scheduled away due to sleep =
us
> <- ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) returns -EPIPE us ->
> ioctl(SNDRV_PCM_IOCTL_PREPARE) # as reaction to the EPIPE (XRUN) us ->
> ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) # next try to capture frames
>       - sdma_prep_dma_cyclic()
>         - sdma_load_context() # not loaded as context_loaded is 1
>       - wait_for_avail()
>         - schedule_timeout()
> # now the sdma_channel_terminate_work() comes back and sets #
> context_loaded =3D false and frees in vchan_dma_desc_free_list().
> us <- ioctl returns -EIO (capture write error (DMA or IRQ trouble?))
Seems the write error caused by context_loaded not set to false before
next transfer start? If yes, please have a try with the 03/04 of the below
patch set, anyway, could you post your failure log?
https://lkml.org/lkml/2020/8/11/111

>=20
>=20
> What we have found out, based on our understanding:
> The dmaengine docu states that a dmaengine_terminate_async() must be
> followed by a dmaengine_synchronize().
> However, in the pcm_dmaengine.c, only dmaengine_terminate_async() is
> called (for performance reasons and because it might be called from an
> interrupt handler).
>=20
> In our tests, we saw that the user-space immediately calls
> ioctl(SNDRV_PCM_IOCTL_PREPARE) as a handler for the happened xrun
> (previous ioctl(SNDRV_PCM_IOCTL_READI_FRAMES) returns with -EPIPE). In
> our case (imx-sdma.c), the terminate really happens asynchronously with a
> worker thread which is not awaited/synchronized by the
> ioctl(SNDRV_PCM_IOCTL_PREPARE) call.
>=20
> Since the syscall immediately enters an atomic context
> (snd_pcm_stream_lock_irq()), we are not able to flush the work of the
> termination worker from within the DMA context. This leads to an
> unterminated DMA getting re-initialized and then terminated.
>=20
> On the i.MX6 platform the problem is (if I got it correctly) that the
> sdma_channel_terminate_work() called after the -EPIPE gets scheduled away
> (for the 1-2ms sleep [1]). During that time the userspace already sends i=
n the
> ioctl(SNDRV_PCM_IOCTL_PREPARE) and
> ioctl(SNDRV_PCM_IOCTL_READI_FRAMES).
> As none of them are anyhow synchronized to the terminate_worker the
> vchan_dma_desc_free_list() [2] and "sdmac->context_loaded =3D false;" [3]=
 are
> executed during the wait_for_avail() [4] of the
> ioctl(SNDRV_PCM_IOCTL_READI_FRAMES).
>=20
> To make sure we identified the problem correctly we've tested to add a
> "dmaengine_synchronize()" before the snd_pcm_prepare() in [5]. This fixed=
 the
> race condition in all our tests. (Before we were able to reproduce it in =
100% of
> the test runs).
>=20
> Based on our understanding, there are two different points to ensure the
> termination:
> Either ensure that the termination is finished within the previous
> SNDRV_PCM_IOCTL_READI_FRAMES call (inside the DMA context) or finishing
> it in the SNDRV_PCM_IOCTL_PREPARE call (and all other applicable ioclts)
> before entering the atomic context (from the PCM context).
>=20
> We initially thought about implementing the first approach, basically spl=
itting
> up the dma_device terminate_all operation into a sync
> (busy-wait) and a async one. This would align the operations with the
> DMAengine interface and would enable a sync termination variant from atom=
ic
> contexts.
> However, we saw that the dma_free_attrs() function has a WARN_ON on irqs
> disabled, which would be the case for the sync variant.=20
> Side note: We found this issue on the current v5.4.y LTS branch, but it a=
lso
> affects v5.8.y.
>=20
> Any feedback or pointers how we may fix the problem are warmly welcome!
> If anything is unclear please just ask :-)
>=20
> regards;
> Richard Leitner
> Benjamin Bara
>=20
> [1]https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fel=
ixir.
> bootlin.com%2Flinux%2Fv5.8%2Fsource%2Fdrivers%2Fdma%2Fimx-sdma.c%23
> L1066&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7C79ad115b01ef453f7
> e7408d83f7b3c4d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637
> 329145824068928&amp;sdata=3DD9F%2FRUG27xv9nv8J1KtrLtld2eaI6gsXiWIAIgk
> Avjw%3D&amp;reserved=3D0
> [2]https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fel=
ixir.
> bootlin.com%2Flinux%2Fv5.8%2Fsource%2Fdrivers%2Fdma%2Fimx-sdma.c%23
> L1071&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7C79ad115b01ef453f7
> e7408d83f7b3c4d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637
> 329145824068928&amp;sdata=3D0EKDVgzOZzL7TpX4ykhqjvpz5ryUHUpWw7frRe
> cksBU%3D&amp;reserved=3D0
> [3]https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fel=
ixir.
> bootlin.com%2Flinux%2Fv5.8%2Fsource%2Fdrivers%2Fdma%2Fimx-sdma.c%23
> L1072&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7C79ad115b01ef453f7
> e7408d83f7b3c4d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637
> 329145824068928&amp;sdata=3DaIhatvb1ocQqyYCVFEg71LgJlRBoVusbDFPIxnte
> PuY%3D&amp;reserved=3D0
> [4]https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fel=
ixir.
> bootlin.com%2Flinux%2Fv5.8%2Fsource%2Fsound%2Fcore%2Fpcm_lib.c%23L1
> 825&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7C79ad115b01ef453f7e
> 7408d83f7b3c4d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6373
> 29145824073919&amp;sdata=3Dy0Udbd%2FKGaVgqLrcp6fNOlMlFCGHCMfojkpp
> B4HzUuE%3D&amp;reserved=3D0
> [5]https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fel=
ixir.
> bootlin.com%2Flinux%2Fv5.8%2Fsource%2Fsound%2Fcore%2Fpcm_native.c%2
> 3L3226&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7C79ad115b01ef453f
> 7e7408d83f7b3c4d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 7329145824073919&amp;sdata=3Dch3BQ5DDGU5HWXqIZSvUeFnBoRoP%2BMM
> HEpnk8mIfWj8%3D&amp;reserved=3D0
