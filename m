Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B217C93AF
	for <lists+dmaengine@lfdr.de>; Sat, 14 Oct 2023 11:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjJNJOM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 14 Oct 2023 05:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNJOM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 14 Oct 2023 05:14:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7C6BF;
        Sat, 14 Oct 2023 02:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdlnS/ez+fhElXFVzL2DZOBGxwdD6hbhKVjGgU6cmLmMOZG/5OPvbig1JS0Et4HPM1WbSCfUTj0DUOgkhlvQ7Yy2Qn06yQn751mJCZ5typsNQsySMlDTPSN+7VVJeB93wZFB73Sun3wx+VJ3qkl3hNAM32cNxCsOcgNhNE1yMIMcwU4EyYqjV3NPnGtKtARGVEIDwrJwG2+Q0z8g/TDEL4Iqc5+mFP41xTfNUg/Zr7ck5JhV/M4cFXkKO34Fq2TOn1mVzmmSY0cOa2xPtE5uzYFc6VOiyyb7bCMVhBVTsptec7ef4QOSukm2Gyf9Qb+IPMfLziwFA5J/yPBXFQOIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPhYbp4NxS1igeOOr9IPPF/j3lVtDOgi1sFmrP+u5a4=;
 b=oQrCyEE9zZJnyuhuwhbz+QmiH+KOafixpzCEzlwDGLpk5N2AwlLrYq6U85l8yjjKh4ittT2s71ewiSSwIyzQw5k9VWd9vv0QOQk8CFWTcUYc8QR0ddHnbToWC8eK/age488dYXgkEIU5Avkg80vQ6rqDrxanupvI6Rt5tVmNK0+kN0NW7zxyiwK0t3Nlaw+WB4faF/5Q3dvnjQDnnS3w0Hc39KJu40dVulKcnXjYhyYIK0JkzOxe0tIB57NnXkZOUAd1Q0LSWC69nejXii2cds7Dj5fTDoWydheiekhG0cZyVNPNxmfujK+q61qJp0/tvUcgSJiWAhmmBMSgQ5k5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPhYbp4NxS1igeOOr9IPPF/j3lVtDOgi1sFmrP+u5a4=;
 b=OEbHiiZJNsn/7aLeEvz+0szUneBV4yKqWMoa2fuMz9HVgo7XkJvGXWem6ZMC6fd3pvV6J0g6JdSsNUQNGqa3DMjNb53mHkMQorBO+PTmqq/Vrd0UOFrImyAzg971myTbKukl+S9OnfJtmTzGQbT7m6yqjSNbuIO1seoEqhAMB/I=
Received: from DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) by
 IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Sat, 14 Oct 2023 09:14:05 +0000
Received: from DM4PR12MB6326.namprd12.prod.outlook.com
 ([fe80::cfda:e75d:4c7a:ae52]) by DM4PR12MB6326.namprd12.prod.outlook.com
 ([fe80::cfda:e75d:4c7a:ae52%7]) with mapi id 15.20.6863.046; Sat, 14 Oct 2023
 09:14:05 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH 2/3] dmaengine: ae4dma: register AE4DMA controller as a
 DMA resource
Thread-Topic: [PATCH 2/3] dmaengine: ae4dma: register AE4DMA controller as a
 DMA resource
Thread-Index: AQHZ5OXEDBKMkLk4+kKoqMLA1+RR5bA5uBeAgA9xHfA=
Date:   Sat, 14 Oct 2023 09:14:04 +0000
Message-ID: <DM4PR12MB632699FBC8CE82D43EBB569CE5D1A@DM4PR12MB6326.namprd12.prod.outlook.com>
References: <1694460324-60346-1-git-send-email-Sanju.Mehta@amd.com>
 <1694460324-60346-3-git-send-email-Sanju.Mehta@amd.com>
 <ZR1e5SrtVePDdL/K@matsya>
In-Reply-To: <ZR1e5SrtVePDdL/K@matsya>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=496e6a84-2a78-4dc8-ab3f-199ad96b2bc6;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-14T09:13:52Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6326:EE_|IA1PR12MB8079:EE_
x-ms-office365-filtering-correlation-id: 317da287-93b1-488f-2a18-08dbcc95e9f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5pY/MGqsh4FQD1NbUAxdGfzH+FM8Q9Tb6QFkjLzQddUlaQzhVQOrxNNWNiI7RFs0cPxxHtEdwTdZjytXIjeyEgZ61GQTfSxuM9lxqc1DRPqaGDcTeD2PkEtm0+7SWBmSxjlwsy+IyCbetpckH/aAUUfg++c5BMGAsT+0Vv8ksvZGjh+m2JihG5OwqKa+nNP6TrDKDy81J0ue6TdM5v73rywEaIx25Myit/e5WAWoFWPa1eJTnszpwAjb4h0v/d3A7IQUbc6RXzxyyPgH63pIpOA9VYwMJGpWPoTMMEvqK871+Upbl0ASt4ISWTYwiuFmqOQpZEGj3loK6lvR2yPdcTqD6BUKWE5oBYVIEMe+Z6QtlA8pdQhwwzf9vKZSsFwbOYcpubboECFHfuF9X3er83b/PddNw+88kHBwPdq8Gayczv2GQVyrlr+pfMn1HKEcHDXZtgPgB0/rExOLz+QMAYiIby6AR2BgnqzP21mu4P7a82xidXV/iIUcmRMycIETVLewQtOe913Yz/dTaE1SjYdJ8sOZT/OrFsc4mDaYDjup4gy2/kkf+fbV/F9KY/GWZz4Lb0tqmjpWyyxgfRr2kvcKrCzoa88hBE9G21HABkdan4T6JUCxhHekyhS1B7w7frZZYDlN/g/yGucg4LWpOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6326.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(55016003)(8676002)(52536014)(8936002)(33656002)(4326008)(41300700001)(66899024)(71200400001)(5660300002)(83380400001)(38100700002)(2906002)(30864003)(86362001)(122000001)(38070700005)(26005)(6916009)(478600001)(316002)(66946007)(66446008)(66476007)(76116006)(54906003)(64756008)(66556008)(9686003)(7696005)(53546011)(6506007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eFrpY67BmM9CGi27AXBrXJ/kdR4GGtbCdpIriI09VSqDlMJeCGs6jPoTE50b?=
 =?us-ascii?Q?6xX3JCMnjyu0uI0sfb8NColEmv8uLsuINOmYp24D/sWg3wzUEcRhT7IRTMwZ?=
 =?us-ascii?Q?ljYI+wxb0ju+VI61tadNMNKFzRb1b1Aq81Caz7CnOBmyiW9648NsEQV2U3ac?=
 =?us-ascii?Q?ToUzXC78IBBsjP74HN90FapA7SkUVddWvgGL+7AOz9bJJoXyyitIJAE7HGN6?=
 =?us-ascii?Q?hj4a3oaq+2adq3iD2IRuT+SOp26aB63mgEICz55lZwrIN1L/klxRy3NpquCR?=
 =?us-ascii?Q?+m8HdYVyMT4AGF+hAF0mWRQtlbx2WAT6AdIV14FWFe9jk6kW2yJRDh2XsvjY?=
 =?us-ascii?Q?0dLpti1C0K53ZBKCJwHy7QQ/o9EsOcuKNIdpxtSRRNJr9L5zcyMpfuyleA8M?=
 =?us-ascii?Q?DNjURsJYHOmmHM3KgxqUfX1F3UES6hq9G/QtMXh70P9tQNsS5YrgXI+XPVrG?=
 =?us-ascii?Q?gcDyzJLdN98d4EZDNqiwHKOXVzog6xHsIj1hXiDA4f/1FDd9mObSr/jfPoeL?=
 =?us-ascii?Q?xaAFSm2QWS2Y5H0VJ+Smn5Jnbv8+mSQp0VMzwyvnbLq/g0A3WIATXZfk7WLj?=
 =?us-ascii?Q?VmCOjDmMt8gq3KUubcgl8+ibYui9iMa1tWYpaqkR5xjwkX9qcOs1QxXKjDYM?=
 =?us-ascii?Q?a7FoK2wVSOzEvwLdJ6HW0FtxFoyNk8pgZoVasfYjmYzYW3uz7WGSwsvnbFlL?=
 =?us-ascii?Q?4taqqIC4lYbJ4aVJTDIXSmIKqSKr+6Dq1JX/RQnoMhf9CTc3rojSH6OSLprW?=
 =?us-ascii?Q?Q+4yBRYpHmRHfy7fel7/jKqr0Icc6vwBi64DigDqvezXU+41RVhRjeot4LJd?=
 =?us-ascii?Q?XL4ccZlbxKrDMSp484vOHQkyJBnprXQAbvDVY6M6uAcvcd/Zb7eoyjuHXP0Y?=
 =?us-ascii?Q?YXlZMfYMkIP5VZPirHiipHRnvV1wO5U6IMd48oXEwYfUQtklT4d0Nw5CStx4?=
 =?us-ascii?Q?h1nMJEkMe0tmL0u0dAlJVsW05laTt8WygSQgd2T9qBb+lF5e+KjcIW3UsbSn?=
 =?us-ascii?Q?mLfTkQWjuyXndX8LNjNwTK1rQnQXJKV7tEWiq2Y6rB5GY11thac3gmmk6Xqe?=
 =?us-ascii?Q?sLCbLwmSPQCq5wGwHBMuQti8l9hEb+N3w0RtLdYeKXpn+hpFh+QVhCE8swxZ?=
 =?us-ascii?Q?TRLAQshz5T4fswpE3voZj4QKbF0CMs8P41CdR2hFzPOjQGjxngX/ZCC+iiFH?=
 =?us-ascii?Q?4WwN+JvXy8xZge4HNaoQdax53Z7dYX0ONMBL53x8gWI1gEVeMt1WRXSuZSWe?=
 =?us-ascii?Q?IXif84wmIlWNAUb+RnvtZNOdvhOgAaoNRy0WgFpEMykk30lpLEqagxVSzxNu?=
 =?us-ascii?Q?21dtYBdtJR028hL8UMr8AUrHM0h1O2mOIocEjrkli6CicJtuUqx8uw27alZE?=
 =?us-ascii?Q?2v2mpg4YREcmYrEvgo36SOIqtcJl5S4fENh7VoS940wzAJKtqysYpWkNXb3k?=
 =?us-ascii?Q?Y6e7UMUbizIGJeQoa4fAwtDpap30ysgXA3c85/xrvaHXS3Jv3fdRBMKhfOdK?=
 =?us-ascii?Q?fmJ6N+l01WwOFWfHBJgS2H4PT10f9sodD97+92ctBd60EZUVCo7GNXSRJ0MP?=
 =?us-ascii?Q?RHRvQC/ZeU6Sbcl3y0Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317da287-93b1-488f-2a18-08dbcc95e9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2023 09:14:05.0155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70xroBXx1muM7Ba/L7PUC4NLO+O3FL3jQsHdl0Wpw7KUGilYiKlIUCYsgCBx7JTXAXNDBddfBHDfKgbFVC1uqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

[Public]

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Wednesday, October 4, 2023 6:18 PM
> To: Mehta, Sanju <Sanju.Mehta@amd.com>
> Cc: gregkh@linuxfoundation.org; dan.j.williams@intel.com; robh@kernel.org=
;
> mchehab+samsung@kernel.org; davem@davemloft.net; linux-
> kernel@vger.kernel.org; dmaengine@vger.kernel.org
> Subject: Re: [PATCH 2/3] dmaengine: ae4dma: register AE4DMA controller as
> a DMA resource
>
> On 11-09-23, 14:25, Sanjay R Mehta wrote:
> > From: Sanjay R Mehta <sanju.mehta@amd.com>
> >
> > Register ae4dma queue's to Linux dmaengine framework as general-
> purpose
> > DMA channels.
> >
> > Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> > ---
> >  drivers/dma/ae4dma/Kconfig            |   2 +
> >  drivers/dma/ae4dma/Makefile           |   2 +-
> >  drivers/dma/ae4dma/ae4dma-dev.c       |  17 ++
> >  drivers/dma/ae4dma/ae4dma-dmaengine.c | 425
> ++++++++++++++++++++++++++++++++++
> >  drivers/dma/ae4dma/ae4dma.h           |  28 +++
> >  5 files changed, 473 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/dma/ae4dma/ae4dma-dmaengine.c
> >
> > diff --git a/drivers/dma/ae4dma/Kconfig b/drivers/dma/ae4dma/Kconfig
> > index 1cda9de..3d1dbb7 100644
> > --- a/drivers/dma/ae4dma/Kconfig
> > +++ b/drivers/dma/ae4dma/Kconfig
> > @@ -2,6 +2,8 @@
> >  config AMD_AE4DMA
> >     tristate  "AMD AE4DMA Engine"
> >     depends on X86_64 && PCI
> > +   select DMA_ENGINE
> > +   select DMA_VIRTUAL_CHANNELS
> >     help
> >       Enabling this option provides support for the AMD AE4DMA
> controller,
> >       which offers DMA capabilities for high-bandwidth memory-to-
> memory and
> > diff --git a/drivers/dma/ae4dma/Makefile b/drivers/dma/ae4dma/Makefile
> > index db9cab1..b1e4318 100644
> > --- a/drivers/dma/ae4dma/Makefile
> > +++ b/drivers/dma/ae4dma/Makefile
> > @@ -5,6 +5,6 @@
> >
> >  obj-$(CONFIG_AMD_AE4DMA) +=3D ae4dma.o
> >
> > -ae4dma-objs :=3D ae4dma-dev.o
> > +ae4dma-objs :=3D ae4dma-dev.o ae4dma-dmaengine.o
> >
> >  ae4dma-$(CONFIG_PCI) +=3D ae4dma-pci.o
> > diff --git a/drivers/dma/ae4dma/ae4dma-dev.c
> b/drivers/dma/ae4dma/ae4dma-dev.c
> > index a3c50a2..af7e510 100644
> > --- a/drivers/dma/ae4dma/ae4dma-dev.c
> > +++ b/drivers/dma/ae4dma/ae4dma-dev.c
> > @@ -25,6 +25,11 @@ static unsigned int max_hw_q =3D 1;
> >  module_param(max_hw_q, uint, 0444);
> >  MODULE_PARM_DESC(max_hw_q, "Max queues per engine (any non-zero
> value less than or equal to 16, default: 1)");
> >
> > +static inline struct ae4_dma_chan *to_ae4_chan(struct dma_chan
> *dma_chan)
> > +{
> > +   return container_of(dma_chan, struct ae4_dma_chan, vc.chan);
> > +}
> > +
> >  /* Human-readable error strings */
> >  static char *ae4_error_codes[] =3D {
> >     "",
> > @@ -273,8 +278,17 @@ int ae4_core_init(struct ae4_device *ae4)
> >             tasklet_setup(&cmd_q->irq_tasklet, ae4_do_cmd_complete);
> >     }
> >
> > +   /* register to the DMA engine */
> > +   ret =3D ae4_dmaengine_register(ae4);
> > +   if (ret)
> > +           goto e_free_irq;
> > +
> >     return 0;
> >
> > +e_free_irq:
> > +   for (i =3D 0; i < ae4->cmd_q_count; i++)
> > +           free_irq(ae4->ae4_irq[i], ae4);
> > +
> >  e_free_dma:
> >     dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase, cmd_q-
> >qbase_dma);
> >
> > @@ -292,6 +306,9 @@ void ae4_core_destroy(struct ae4_device *ae4)
> >     struct ae4_cmd *cmd;
> >     unsigned int i;
> >
> > +   /* Unregister the DMA engine */
> > +   ae4_dmaengine_unregister(ae4);
> > +
> >     for (i =3D 0; i < ae4->cmd_q_count; i++) {
> >             cmd_q =3D &ae4->cmd_q[i];
> >
> > diff --git a/drivers/dma/ae4dma/ae4dma-dmaengine.c
> b/drivers/dma/ae4dma/ae4dma-dmaengine.c
> > new file mode 100644
> > index 0000000..a50e4f5
> > --- /dev/null
> > +++ b/drivers/dma/ae4dma/ae4dma-dmaengine.c
> > @@ -0,0 +1,425 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * AMD AE4DMA device driver
> > + * -- Based on the PTDMA driver
>
> How different is it from PTDMA, why cant this be incorporated in ptdma
> driver
>
> > + *
> > + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> > + *
> > + * Author: Sanjay R Mehta <sanju.mehta@amd.com>
> > + */
> > +#include <linux/delay.h>
> > +#include "ae4dma.h"
> > +#include "../dmaengine.h"
> > +#include "../virt-dma.h"
> > +
> > +static inline struct ae4_dma_chan *to_ae4_chan(struct dma_chan
> *dma_chan)
> > +{
> > +   return container_of(dma_chan, struct ae4_dma_chan, vc.chan);
> > +}
> > +
> > +static inline struct ae4_dma_desc *to_ae4_desc(struct virt_dma_desc *v=
d)
> > +{
> > +   return container_of(vd, struct ae4_dma_desc, vd);
> > +}
> > +
> > +static void ae4_free_chan_resources(struct dma_chan *dma_chan)
> > +{
> > +   struct ae4_dma_chan *chan =3D to_ae4_chan(dma_chan);
> > +
> > +   vchan_free_chan_resources(&chan->vc);
> > +}
> > +
> > +static void ae4_synchronize(struct dma_chan *dma_chan)
> > +{
> > +   struct ae4_dma_chan *chan =3D to_ae4_chan(dma_chan);
> > +
> > +   vchan_synchronize(&chan->vc);
> > +}
> > +
> > +static void ae4_do_cleanup(struct virt_dma_desc *vd)
> > +{
> > +   struct ae4_dma_desc *desc =3D to_ae4_desc(vd);
> > +   struct ae4_device *ae4 =3D desc->ae4;
> > +
> > +   kmem_cache_free(ae4->dma_desc_cache, desc);
> > +}
> > +
> > +static int ae4_dma_start_desc(struct ae4_dma_desc *desc, struct
> ae4_dma_chan *chan)
> > +{
> > +   struct ae4_passthru_engine *ae4_engine;
> > +   struct ae4_device *ae4;
> > +   struct ae4_cmd *ae4_cmd;
> > +   struct ae4_cmd_queue *cmd_q;
> > +
> > +   desc->issued_to_hw =3D 1;
> > +   list_del(&desc->vd.node);
> > +
> > +   ae4_cmd =3D &desc->ae4_cmd;
> > +   ae4 =3D ae4_cmd->ae4;
> > +   cmd_q =3D chan->cmd_q;
> > +   ae4_engine =3D &ae4_cmd->passthru;
> > +
> > +   ae4_cmd->qid =3D cmd_q->qidx;
> > +   cmd_q->tdata.cmd =3D ae4_cmd;
> > +
> > +   /* Execute the command */
> > +   ae4_cmd->ret =3D ae4_core_perform_passthru(cmd_q, ae4_engine);
> > +
> > +   return 0;
> > +}
> > +
> > +static struct ae4_dma_desc *ae4_next_dma_desc(struct ae4_dma_chan
> *chan)
> > +{
> > +   /* Get the next DMA descriptor on the active list */
> > +   struct virt_dma_desc *vd =3D vchan_next_desc(&chan->vc);
> > +
> > +   return vd ? to_ae4_desc(vd) : NULL;
> > +}
> > +
> > +static void ae4_cmd_callback_tasklet(void *data, int err)
> > +{
> > +   struct ae4_dma_desc *desc =3D data;
> > +   struct dma_chan *dma_chan;
> > +   struct ae4_dma_chan *chan;
> > +   struct dma_async_tx_descriptor *tx_desc;
> > +   struct virt_dma_desc *vd;
> > +   unsigned long flags;
> > +
> > +   dma_chan =3D desc->vd.tx.chan;
> > +   chan =3D to_ae4_chan(dma_chan);
> > +
> > +   if (err =3D=3D -EINPROGRESS)
> > +           return;
> > +
> > +   tx_desc =3D &desc->vd.tx;
> > +   vd =3D &desc->vd;
> > +
> > +   if (err)
> > +           desc->status =3D DMA_ERROR;
> > +
> > +   spin_lock_irqsave(&chan->vc.lock, flags);
> > +   if (desc) {
> > +           if (desc->status !=3D DMA_COMPLETE) {
> > +                   if (desc->status !=3D DMA_ERROR)
> > +                           desc->status =3D DMA_COMPLETE;
>
> So a DMA_IN_PROGRESS descriptor would be marked complete?
>
Upon successful completion of the DMA, the interrupt handler will schedule =
the execution of this tasklet function, therefore indicating the status as =
complete.
> > +
> > +                   dma_cookie_complete(tx_desc);
> > +                   dma_descriptor_unmap(tx_desc);
> > +           } else {
> > +                   /* Don't handle it twice */
> > +                   tx_desc =3D NULL;
> > +           }
> > +   }
> > +   spin_unlock_irqrestore(&chan->vc.lock, flags);
> > +
> > +   if (tx_desc) {
> > +           dmaengine_desc_get_callback_invoke(tx_desc, NULL);
> > +           dma_run_dependencies(tx_desc);
> > +   }
> > +}
> > +
> > +static struct ae4_dma_desc *ae4_handle_active_desc(struct
> ae4_dma_chan *chan,
> > +                                              struct ae4_dma_desc *des=
c)
> > +{
> > +   struct dma_async_tx_descriptor *tx_desc;
> > +   struct virt_dma_desc *vd;
> > +   unsigned long flags;
> > +
> > +   /* Loop over descriptors until one is found with commands */
> > +   do {
> > +           if (desc) {
> > +                   if (!desc->issued_to_hw) {
> > +                           /* No errors, keep going */
> > +                           if (desc->status !=3D DMA_ERROR)
> > +                                   return desc;
> > +                   }
> > +                   tx_desc =3D &desc->vd.tx;
> > +                   vd =3D &desc->vd;
> > +           } else {
> > +                   tx_desc =3D NULL;
> > +           }
> > +           spin_lock_irqsave(&chan->vc.lock, flags);
> > +           desc =3D ae4_next_dma_desc(chan);
> > +           spin_unlock_irqrestore(&chan->vc.lock, flags);
> > +   } while (desc);
> > +
> > +   return NULL;
> > +}
> > +
> > +static void ae4_cmd_callback(void *data, int err)
> > +{
> > +   struct ae4_dma_desc *desc =3D data;
> > +   struct dma_chan *dma_chan;
> > +   struct ae4_dma_chan *chan;
> > +   struct ae4_device *ae4;
> > +   int ret;
> > +
> > +   if (err =3D=3D -EINPROGRESS)
> > +           return;
> > +
> > +   dma_chan =3D desc->vd.tx.chan;
> > +   chan =3D to_ae4_chan(dma_chan);
> > +   ae4 =3D chan->ae4;
> > +
> > +   if (err)
> > +           desc->status =3D DMA_ERROR;
> > +
> > +   while (true) {
> > +           /* Check for DMA descriptor completion */
> > +           desc =3D ae4_handle_active_desc(chan, desc);
> > +
> > +           /* Don't submit cmd if no descriptor or DMA is paused */
> > +           if (!desc)
> > +                   break;
> > +
> > +           /* if queue is full dont submit to queue */
> > +           if (ae4_core_queue_full(ae4, chan->cmd_q)) {
> > +                   usleep_range(100, 200);
> > +                   continue;
> > +           }
> > +
> > +           ret =3D ae4_dma_start_desc(desc, chan);
> > +           if (!ret)
> > +                   break;
> > +
> > +           desc->status =3D DMA_ERROR;
> > +   }
> > +}
> > +
> > +static struct ae4_dma_desc *ae4_alloc_dma_desc(struct ae4_dma_chan
> *chan, unsigned long flags)
> > +{
> > +   struct ae4_dma_desc *desc;
> > +   struct ae4_cmd_queue *cmd_q =3D chan->cmd_q;
> > +
> > +   desc =3D kmem_cache_zalloc(chan->ae4->dma_desc_cache,
> GFP_NOWAIT);
> > +   if (!desc)
> > +           return NULL;
> > +
> > +   vchan_tx_prep(&chan->vc, &desc->vd, flags);
> > +
> > +   desc->ae4 =3D chan->ae4;
> > +   cmd_q->int_en =3D !!(flags & DMA_PREP_INTERRUPT);
> > +   desc->issued_to_hw =3D 0;
> > +   desc->status =3D DMA_IN_PROGRESS;
> > +
> > +   return desc;
> > +}
> > +
> > +static struct ae4_dma_desc *ae4_create_desc(struct dma_chan
> *dma_chan,
> > +                                       dma_addr_t dst,
> > +                                       dma_addr_t src,
> > +                                       unsigned int len,
> > +                                       unsigned long flags)
> > +{
> > +   struct ae4_dma_chan *chan =3D to_ae4_chan(dma_chan);
> > +   struct ae4_cmd_queue *cmd_q =3D chan->cmd_q;
> > +   struct ae4_passthru_engine *ae4_engine;
> > +   struct ae4_dma_desc *desc;
> > +   struct ae4_cmd *ae4_cmd;
> > +
> > +   desc =3D ae4_alloc_dma_desc(chan, flags);
> > +   if (!desc)
> > +           return NULL;
> > +
> > +   ae4_cmd =3D &desc->ae4_cmd;
> > +   ae4_cmd->ae4 =3D chan->ae4;
> > +   ae4_engine =3D &ae4_cmd->passthru;
> > +   ae4_cmd->engine =3D AE4_ENGINE_PASSTHRU;
> > +   ae4_engine->src_dma =3D src;
> > +   ae4_engine->dst_dma =3D dst;
> > +   ae4_engine->src_len =3D len;
> > +   ae4_cmd->ae4_cmd_callback =3D ae4_cmd_callback_tasklet;
> > +   ae4_cmd->data =3D desc;
> > +
> > +   desc->len =3D len;
> > +
> > +   spin_lock_irqsave(&cmd_q->cmd_lock, flags);
> > +   list_add_tail(&ae4_cmd->entry, &cmd_q->cmd);
> > +   spin_unlock_irqrestore(&cmd_q->cmd_lock, flags);
> > +
> > +   return desc;
> > +}
> > +
> > +static struct dma_async_tx_descriptor *
> > +ae4_prep_dma_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
> > +               dma_addr_t src, size_t len, unsigned long flags)
> > +{
> > +   struct ae4_dma_desc *desc;
> > +
> > +   desc =3D ae4_create_desc(dma_chan, dst, src, len, flags);
> > +   if (!desc)
> > +           return NULL;
>
> I dont see any logic in splitting these into two!
>
Right, I will remove in V2.

> > +
> > +   return &desc->vd.tx;
> > +}
> > +
> > +static struct dma_async_tx_descriptor *
> > +ae4_prep_dma_interrupt(struct dma_chan *dma_chan, unsigned long
> flags)
> > +{
> > +   struct ae4_dma_chan *chan =3D to_ae4_chan(dma_chan);
> > +   struct ae4_dma_desc *desc;
> > +
> > +   desc =3D ae4_alloc_dma_desc(chan, flags);
> > +   if (!desc)
> > +           return NULL;
> > +
> > +   return &desc->vd.tx;
> > +}
> > +
> > +static void ae4_issue_pending(struct dma_chan *dma_chan)
> > +{
> > +   struct ae4_dma_chan *chan =3D to_ae4_chan(dma_chan);
> > +   struct ae4_dma_desc *desc;
> > +   unsigned long flags;
> > +
> > +   spin_lock_irqsave(&chan->vc.lock, flags);
> > +   vchan_issue_pending(&chan->vc);
> > +   desc =3D ae4_next_dma_desc(chan);
> > +   spin_unlock_irqrestore(&chan->vc.lock, flags);
> > +
> > +   ae4_cmd_callback(desc, 0);
> > +}
> > +
> > +static int ae4_pause(struct dma_chan *dma_chan)
> > +{
> > +   struct ae4_dma_chan *chan =3D to_ae4_chan(dma_chan);
> > +   unsigned long flags;
> > +
> > +   spin_lock_irqsave(&chan->vc.lock, flags);
> > +   //TODO : implemnt pause
>
> typo implemnt and drop this and add when you add support!
> No dummy code please
>
Sure, I will fix this in V2.

>
> > +   spin_unlock_irqrestore(&chan->vc.lock, flags);
> > +
> > +   return 0;
> > +}
> > +
> > +static int ae4_resume(struct dma_chan *dma_chan)
> > +{
> > +   struct ae4_dma_chan *chan =3D to_ae4_chan(dma_chan);
> > +   struct ae4_dma_desc *desc =3D NULL;
> > +   unsigned long flags;
> > +
> > +   spin_lock_irqsave(&chan->vc.lock, flags);
> > +   ae4_start_queue(chan->cmd_q);
> > +   desc =3D ae4_next_dma_desc(chan);
> > +   spin_unlock_irqrestore(&chan->vc.lock, flags);
> > +
> > +   /* If there was something active, re-start */
> > +   if (desc)
> > +           ae4_cmd_callback(desc, 0);
>
> resume when no pause is supported..??
Sure.

> --
> ~Vinod
