Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C1F5BE51C
	for <lists+dmaengine@lfdr.de>; Tue, 20 Sep 2022 14:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiITMAq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Sep 2022 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiITMAN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Sep 2022 08:00:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF81E0E6;
        Tue, 20 Sep 2022 05:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTwSxCfZRJ+Z5UyUCB9r1JpVae0nGa+xSKS90rxuW8jOk3ntxkS/Lr6Mi4ixvmuhZvnbMnH9+snVF3dU1ygFj2TT7Aw8XtP4h/OGTUkBcba7Z2Axga+KtnxGThKkvmRXbCe+kAJVw1n3Dssic+AlPmXqjIY96lvYsJyHM3e7rAdHdvtg0BvjxzOavY39FsNlszDiZlwc3f/IiW5CjDYbmZWynR26FUrXZk4BUTDwsHUX2tXNYE/hS2eWllrV1zc4PMu82sVxNCGRQ445rF56yHTTCmSdqnChJiyVRa+9vMk2K5CiroxjraYphjhNsYNdaHsKFlPYkWcbiHTHTZiNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqkVDCKy7SMesYjtJByJF2DG/ir/HMKyBwwurKQ8kec=;
 b=RjdILrpWw8prfuF4cq0j8HhjBYJtWdekiR2l5GOweEhta+EwPaOlGTh1fuGJVm9jec5RqSZ50HjsHeQJXvrvfwDp5vX9lzkYgu/30f6/DcImVYC6je16yO7dY9UXihZ5xAt9NIil/wxT1Yx21CMFgIFEliODYysOknNPm0ZKXKx0znHo/FyvV9EbJMlerbT7tY1CesWOe9McmIQVI8Jc9SS5A9QPdxbS5YZbW46n3NMYBIajRsCJUsCPHnyGsCfFKvg+PgmaNNc8laR89b+ZUSDJJ2FKhk/YLtu3R1hxrcKtx+mycL0gFaBjPBoY2MD7e357LVF8orHBnYHwdot0Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqkVDCKy7SMesYjtJByJF2DG/ir/HMKyBwwurKQ8kec=;
 b=xvoTCyQInRiLzqIc4XczBheRCMbtyOXxwCafC7ZddUb+9wYFYUufsN0HB13Mc5Jr/SaNdTyBc7fZJ59/g7J2h0BMhWXunFdb+Nf/d/9uTJuI6PtD+2X6vYN9kjKnhLs/F71tXPDL+m76IiqfizW1ZnZLcNPQsZEKvf2P/HLyrUc=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 12:00:04 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::8193:5c0c:4da8:7aad]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::8193:5c0c:4da8:7aad%7]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 12:00:03 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Vinod Koul <vkoul@kernel.org>,
        "Gaddam, Sarath Babu Naidu" <sarath.babu.naidu.gaddam@amd.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "adrianml@alumnos.upm.es" <adrianml@alumnos.upm.es>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>,
        "Katakam, Harini" <harini.katakam@amd.com>,
        "git@xilinx.com" <git@xilinx.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC V3 PATCH 0/8] Xilinx DMA enhancements and optimization
Thread-Topic: [RFC V3 PATCH 0/8] Xilinx DMA enhancements and optimization
Thread-Index: AQHYzLUokPyXdBQ+zkGuk0IkXRyZp63oLoSAgAABReA=
Date:   Tue, 20 Sep 2022 12:00:02 +0000
Message-ID: <MN0PR12MB5953774B25AB9CA40A8BB43EB74C9@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20220920055119.12634-1-sarath.babu.naidu.gaddam@amd.com>
 <YymjofmCECa3iF20@matsya>
In-Reply-To: <YymjofmCECa3iF20@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SA1PR12MB7294:EE_
x-ms-office365-filtering-correlation-id: d9031210-8a81-489f-8ca9-08da9affa6af
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cbdYMNGLYsXOxSeD4U4U5mmoVtAkvGc3JB6JuD7XGu/7ozqTJhCm4worMo+wDncWLKo2Z0TUH25VXU2ATsE92BnFjHDdzpGjuM1haFxD2wKUUIU5d8gcydNsVKMUEIgOcGP5Z5FdxVQpLg2nU8hqRZWQWgBS6GYYtzquP53exOvzTipTxzDRgaGMnFOwBqsvzXscyhBNCVkbMIRIElln9nr/D467k+6klAZcqanGV61XZoP0nO4/j9nH/nocCuD47dalMiV0a3IBMxplG0a7yEgwqp2eKlSzCPfbe5VdlctOXakUCulOqRftlqNOV+lELoLY2I75dj5+1evLr5B4cFwOEJ2xe0ahzwzpacGT2Xg30ccCRA9hHGtzSCmalpLdXmRGhYdr8GP+7wTojwYdtvj49nKAQ9oANSwUMqO7kZaSJflTUX14TXqSyqQYCL3z/xPdSHx60yu1sAdlv8JeKTz8Q9rk1RQI/opBHK+dbmgXf7Jfaqi7ygc5WPeZ82cI8VRZMao0a6bAarotJ4VHl+uBl1AWxImNhvob3soPDjGJi0FxraMhzlebVIlLv2FG5XOIS0xrFf+vT7UZeessVC1p4i/JNjOGPrrBujvVsc6EIENBv9TQ8/AW0pJ8DKayuxHtB2N5/5ZjYKSWIsGOTauXe4ubBA0qWkCw4q1dRXLe+yECk3BU59oQG1OdimPLJfY7B7PmrrwOCq/5UxhktQucctWVI44ovhQkuA3mA9vdDWkcRiwy/7be/PyUT21DtjRTeU5aoHHuk7NQ9T9Fmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(9686003)(6506007)(7696005)(53546011)(38070700005)(7416002)(38100700002)(2906002)(478600001)(5660300002)(66446008)(64756008)(66476007)(122000001)(86362001)(33656002)(186003)(55016003)(71200400001)(41300700001)(83380400001)(66556008)(4326008)(110136005)(6636002)(8936002)(54906003)(66946007)(8676002)(316002)(52536014)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tCwztYtqFXdhozUC5uTguGe4BNhv8pGA+diiIzlK+gxLwQOyGMwgTiYOB/0M?=
 =?us-ascii?Q?TKxakstrj1gH25Fe14nerm2/OVx/s4ekdseBidDEQcnns3lSUwQQh606BYsh?=
 =?us-ascii?Q?iwyuAridNzRX0LpyHIJa98VQe8a1p+8Wa4/X6TsNKmhOjT/f3dkv0C2Xypd7?=
 =?us-ascii?Q?pxda0WQ7RsTwZh3uVhbgkgJeYR1KW9yGevXbPwyFjbTZvvY7K/hA6DQmQt+m?=
 =?us-ascii?Q?sE3qdSBHqNmoB1uskMG+wawv+8NF5KRHPeJLpfBJSyjnxwARW/BRQGRF2GYg?=
 =?us-ascii?Q?t68Dd11b0hq4DD9yK77xH8KCm8JUz0AJtG/hHX2MqQ2yT0xLABezZqV2OCro?=
 =?us-ascii?Q?DiJSz5WbkCZn5/uBeSTLFeONe8ZFwYtIF3fdgdCpkEBt3FSWT55Kbm732GRi?=
 =?us-ascii?Q?NhUtAFdhpdFqSywJHlg8IyUVBxd48pLWm6R8n6xS7yqpdWrQy+IqnOd4Texh?=
 =?us-ascii?Q?0AytMBK0Vzt7VaybEnI1Uwl+TAFiwv3CIU8Qqvy7StvVR111IqauX1CiA3M5?=
 =?us-ascii?Q?djzscmCy/mv3+8AUGt/rlVzTcCmxFrsDOkPiK/+9EqIjjQ3VNPG0zxveiTqn?=
 =?us-ascii?Q?NN8IxDPgpti7tLoHVBiiWuxRehd/3RBXSGlLLRVtDC+nvxiy0AqYQNW9fItX?=
 =?us-ascii?Q?MF9Rx/rs/m8tMpwSJ2zYvrK5zk+aSo2EoF8MPdQalaxqJhjr56Smme0u03dX?=
 =?us-ascii?Q?8DznO39o0rkdWM8qXP/eJT56rjDW4qS5Zmny5SvPzsefHAEclLQY66tklUeU?=
 =?us-ascii?Q?NBSsAa8ybywiAc4KvbXrt3oK4nIL/PfCJKag7H546eCCOByILQ23hb5r5w/K?=
 =?us-ascii?Q?U9Cd8vi8I145xR2op/w6JAskb5Q1MHUlTJGIEivBHDwTzwOxY0FtKWteXOCI?=
 =?us-ascii?Q?+LBV8T+QztCRjCq6wcQbzfU2JzitzqpVs0T1/F/tSzjiq268QfNZNfvCAwYG?=
 =?us-ascii?Q?l44NvCdu37/wQb3xX2dbS/q6MYCR3D87JJ+1tRg01dj/uUI1DbfbcQe+N2Z5?=
 =?us-ascii?Q?FG1Z6lAM0VoRndh/v/XCbW+11xut3dbNQn1WRIj5dmu6MvSa5BKJF0QqP9BT?=
 =?us-ascii?Q?/yUZ9L/MYZI/EZt+6qx4EigxIhCUdJlR3DQX7RZJUFPehlu/laGBDzHIggmT?=
 =?us-ascii?Q?HI6Tq4JDYZvoxSS6aRBE6HmD+lEb0C1s5HhSiDT9FThn3BCH+DOl7p5NmRqj?=
 =?us-ascii?Q?zDpMPr5/bQZhPh0TuhmmvTUac5LDGSArXo3t3Re9yOfGInklralr02eGbx17?=
 =?us-ascii?Q?mLVjmMNYrmsiaf7eFDIsJUtx9Q6s5xM8Y3bizbbrDzhvJUgnV9HAycNKGbG/?=
 =?us-ascii?Q?a1rVrBoMTsvtB9HCW9iW43Afj4+CYczLoyOvVCrjCFkj7qLLmiyfr4ZWHVbu?=
 =?us-ascii?Q?pM9PiJ1lpn8jLhvPkr5ou4c/wTFD/EMHQULyp7dKs5ywXl2k8nIzafgsgTBO?=
 =?us-ascii?Q?xwOxqlmWZwWG0Zo8diACk0iHN8gW9rMCmBGgmlCLv92f7tCjJs1CPpFHOLLM?=
 =?us-ascii?Q?q/7JOJnpuQAHVhst57+Z7AScnfksYPyBWLr2sMgccQM/Dxq5ruBNYaF3+A0A?=
 =?us-ascii?Q?+fTyHhnLIpGROdXJscZFDqtv454XaijTIvd3dL6z30uNIByJoeDywnO3AUy2?=
 =?us-ascii?Q?QSfaaACTGIZJhWCN+agsvjM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9031210-8a81-489f-8ca9-08da9affa6af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 12:00:03.0050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGMpkiVTmIgPxx7vzlKl++YUub2Nz35xZX+XVsG8JiRUasveHh/w7nAAhwUgEPF1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Tuesday, September 20, 2022 4:57 PM
> To: Gaddam, Sarath Babu Naidu <sarath.babu.naidu.gaddam@amd.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> lars@metafoo.de; adrianml@alumnos.upm.es; dmaengine@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Pandey,
> Radhey Shyam <radhey.shyam.pandey@amd.com>; Sarangi, Anirudha
> <anirudha.sarangi@amd.com>; Katakam, Harini
> <harini.katakam@amd.com>; git@xilinx.com; git (AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [RFC V3 PATCH 0/8] Xilinx DMA enhancements and optimization
>=20
> On 20-09-22, 11:21, Sarath Babu Naidu Gaddam wrote:
> > Some background about the patch series: Xilinx Axi Ethernet device
> > driver
> > (xilinx_axienet_main.c) currently has axi-dma code inside it. The goal
> > is to refactor axiethernet driver and use existing AXI DMA driver
> > using DMAEngine API.
> >
> > This patchset does feature addition and optimization to support axidma
> > integration with axiethernet network driver. Once axidma version is
> > accepted mcdma specific changes will be added in followup version.
>=20
> why is this tagged RFC? Is it not ready for merge?

To recap - In v3, the new addition is "[PATCH 8/8] dmaengine:=20
xilinx_dma: Add device_config support" along with addressing=20
RFC v2 comment.=20

8/8 is initial proposal on how to implement coalesce feature in
dmaengine driver to support ethernet usecases. Thought was
that it's better to have this idea reviewed as RFC before=20
extending the logic for other IP variants and spin sanity test
all usecases.=20

Fallback option is to split this series and send patches which are
already reviewed in RFC v2 as PATCH and only 8/8 (which need=20
more discussion/framework extension) as RFC?
Let me know your thoughts.=20

Thanks,
Radhey
>=20
> >
> > Changes for V2:
> > - Use metadata API[1] for passing metadata from dma to netdev client.
> > - Read irq-delay from DT.
> > - Remove desc_callback_valid check.
> > - Addressed RFC v1 comments[2].
> > - Minor code refactoring.
> >
> > Changes for V3:
> > - Add device_config support for passing any dma client data.
> > - Address RFC v2 comments.
> >     - remove hardcoding for axidma_tx_segment.
> >     - Below review comment is in pipeline. We are facing a race issue w=
hen
> >       addressing it. we will fix it in the next version.
> >       "chan->idle =3D true; in xilinx_dma_irq_handler() needs to be gat=
ed on
> >        the active_list being empty".
> >
> > Comments, suggestions are very welcome
> >
> > Radhey Shyam Pandey (7):
> >   dt-bindings: dmaengine: xilinx_dma: Add xlnx,axistream-connected
> >     property
> >   dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
> >   dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
> >   dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
> >   dmaengine: xilinx_dma: Freeup active list based on descriptor
> >     completion bit
> >   dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical
> >     usecase
> >   dmaengine: xilinx_dma: Program interrupt delay timeout
> >
> > Sarath Babu Naidu Gaddam (1):
> >   dmaengine: xilinx_dma: Add device_config support
> >
> >  .../bindings/dma/xilinx/xilinx_dma.txt        |   4 +
> >  drivers/dma/xilinx/xilinx_dma.c               | 107 ++++++++++++++++--
> >  include/linux/dma/xilinx_dma.h                |  16 +++
> >  3 files changed, 115 insertions(+), 12 deletions(-)
> >
> > --
> > 2.25.1
>=20
> --
> ~Vinod
