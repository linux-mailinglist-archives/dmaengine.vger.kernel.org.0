Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD6C7C9370
	for <lists+dmaengine@lfdr.de>; Sat, 14 Oct 2023 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjJNI06 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 14 Oct 2023 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNI05 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 14 Oct 2023 04:26:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E0FBF;
        Sat, 14 Oct 2023 01:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aU3K6nq3uFJnJqkGsudQGpCfUtOE986VEvnizw5c+lRbMD5EeH2YcW3EBEFN0u52rgvKKFVo/GGR9Pn8UlUj1oW7XWub6aDTEj2dyhZOB3dvMblQodioJWCknC4xogGp9tIl1Ey6i5BJk4SKgxlhpU8DwML1BDVKERMNXW6+N0hGckm//6VIbRB9+m/WfKgawLm0HNazbNtawaDElGqtBBLpZBEFuEYtqohtsM0JZcbOP6s9JzLWTRXUoDvzM1WxOETP5jVujlRvlcOulujdt/HVRUKXmnFrTBYKMAMEpQ8AxwmV6KnQm+Pp46p1H1l5azm7tmUt5/eWzQXl3R1p5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwzW6ALN+Eq26+SyPzMuKRHHIyhgdwdNc6NN4ODTuAc=;
 b=Xl2Ck5f2oIzdT4Ugr/8l+SQJjwT4bklxbJsYThxucXLokMWjNAdAA1rAcbSLFk0NJcnnBZZleT6lu66TM+T4gkcpiFdf+WApeJe89eNeP5Ot2jW9myWBIh8KL4eSBLvB2lV5QxmSARt3jMNeKWZtrmnu2VirL6+SdSTeZjb2yxPjfkkvrj9ei3RWZMVHubmzZdXKjodr0p/R23aSXlGIvQ1JDxS1vAyCHcBXZoEDZXq2QDMEIwA3mkwZuXmY1OEu2BtG85bxMUWnFXf0uM6dua7XUmFM4fxWLXZWb+Ortc17P3mneDTm86xVf8BYySbA2f2N9gywDHF0VGxyHB5Gmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwzW6ALN+Eq26+SyPzMuKRHHIyhgdwdNc6NN4ODTuAc=;
 b=n4QPckLupWuglDbP+/4uT2intVB+spMZxayat+n1NsAIyiV6seD1qzaMT7LTsVCqE7vXQw21U25Q56SnAbJMDwc/GbxWzxpGNdojUl0Y2IzkejJNbBM8PI3/7S6guT/4RW3RSCOwofbhlSnCi1vOQchelBCUAxv2oYZYzZaILrA=
Received: from DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) by
 SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Sat, 14 Oct 2023 08:26:50 +0000
Received: from DM4PR12MB6326.namprd12.prod.outlook.com
 ([fe80::cfda:e75d:4c7a:ae52]) by DM4PR12MB6326.namprd12.prod.outlook.com
 ([fe80::cfda:e75d:4c7a:ae52%7]) with mapi id 15.20.6863.046; Sat, 14 Oct 2023
 08:26:50 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH 1/3] dmaengine: ae4dma: Initial ae4dma controller driver
 with multi channel
Thread-Topic: [PATCH 1/3] dmaengine: ae4dma: Initial ae4dma controller driver
 with multi channel
Thread-Index: AQHZ5OXFUN7BzI35s02+So3lunxHgLA5h6CAgAw6yrA=
Date:   Sat, 14 Oct 2023 08:26:50 +0000
Message-ID: <DM4PR12MB6326A31446E45335D2FB457BE5D1A@DM4PR12MB6326.namprd12.prod.outlook.com>
References: <1694460324-60346-1-git-send-email-Sanju.Mehta@amd.com>
 <1694460324-60346-2-git-send-email-Sanju.Mehta@amd.com>
 <ZR02PT/k0op8T71U@matsya>
In-Reply-To: <ZR02PT/k0op8T71U@matsya>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b366377e-8ae4-4290-8d6a-08f76b9ecc6b;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T04:39:37Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6326:EE_|SA0PR12MB4592:EE_
x-ms-office365-filtering-correlation-id: 983753e9-956d-4d23-6628-08dbcc8f5068
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sGB0SQ3Wj8BnPkSUU3VqALCFNq/shZeNh/96DTbx7kQV46LNp37/ebsp1Etc0juDATR+KNGs83Cop5UQKM/W7XcIX8oJGeSt+vhOkFq1uzV9szDJbsh2IC8P2rNmhkHiB8eQhkExrYEAbWxMdOlg9hsuC1a7aqBPDx9Qa1XnMtc9UrGP4cbXUdVH/KgHsMuQV7fTvKtWFUPelr8s1azpN9yTSHgLaAEpendTndxR8/cDO+8UygUXZbCFmLZ8mJw1OgA1vUC3+SVkMkFPmAOtlpEWkPL4ndfH0D8WqyEbfpGOZjMwBLkW7qjGxx1equSbLGmDQSdhIQlogmcocO0iD4/LYblyFR3GY/SZz9tthxho0ix1YWQf9gQjcAPkA+GEbAeu6unXun5KwEnd+HLZd02MVGvFb254APkCZIk4Dh/ktgNNq1KixNdejtiNk4FRXsuNxYUUBXoIhYloVJGTUJkg8lLEIVULruWaC9jZPwFPiSsjPD2HBJpsK9+pyZKETBCP5B42q8sabmYgsNRfpNlSmBX5vDo4BIs+nMHNztYRCweGOUlM9Ef9BIDETpiogbWyBBOY15ZvHL5FmkEu/1Gx2gw3vV+LR9EoPlH7BuJxe26tEh3tKkG6HIcSwN5y1zVu5EptvvxfBsZ0MJcohUSEbMPw+LFC6ND6s6ox/B4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6326.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(966005)(55016003)(71200400001)(2906002)(478600001)(30864003)(41300700001)(52536014)(4326008)(8676002)(8936002)(5660300002)(66899024)(7696005)(66446008)(6916009)(66476007)(66946007)(54906003)(64756008)(66556008)(76116006)(316002)(83380400001)(26005)(6506007)(33656002)(9686003)(122000001)(53546011)(86362001)(38070700005)(38100700002)(42413004)(32563001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2wWkJ1CwFmGa/phpJStYfZTcnqr3fKQtSJklM3TScZww/cghYqTPlVFoZYAc?=
 =?us-ascii?Q?i8idosxA/SFjzJ+l6fiNxcQ5rTCMnkRCuNhwSpSiKNiu2QBNmq2H0V6GtpOv?=
 =?us-ascii?Q?507U0kjHMkKH4x3qKDmUzq6j00BbzgvUKm2azkX+fbjYbglhhkdFycIWPEul?=
 =?us-ascii?Q?Xfa5xNjIgBi/Gd4ftucg594SKhdjxlhpandmY9qbFDhsiwadgOTnaxeVYHSK?=
 =?us-ascii?Q?ZG8tDrTZmgpwPccVtfDl6BM/i9+FX3ms0QGAJO+17bevim7P/ofelFbh+3Kd?=
 =?us-ascii?Q?3oz0k7DjwwOvGjZ0boDlg7GBtFsSE/DEkUIUQIM8I121kbR48j3XbOTOB+jH?=
 =?us-ascii?Q?l6eLTjxKeDdcxxQ0BTnIo8fe3+RGbzT8R5XHWC1QecwAQPSTMbl4YO9cVuuj?=
 =?us-ascii?Q?WOj7zZhVCBGxiU37ZGjqRA13iRrxvXnXuEeZWYT/DUTHgNXYiKgSRGHNoCXX?=
 =?us-ascii?Q?w6phRN/Xw69HHf+29ab2+4sQ6WWdnF59tLq0xKnMvGOP8gd+MwcYXd2D6+9O?=
 =?us-ascii?Q?XMMNgK0azuxLyNW0NbyM6ihbh+Tck7y1eVwJ1xQ77y0ZxQ2cb2ybbJg4OurY?=
 =?us-ascii?Q?XjYtp1TDaLbVMnjeSwP1ddokg4fjxqB3NXCXChSpwCvSpeeLvTMGqW1v9zMH?=
 =?us-ascii?Q?ZUg/8YTyeMvn2Uxk3qVUbBM/GKEPiQejkadoTfWIBjENXVI5h5YSWvEodqPh?=
 =?us-ascii?Q?FZn31X0HML0coRZG9vfGkgvgagAnFS62XnnatAK20KyX7aEFWt1N2vAmNzKA?=
 =?us-ascii?Q?ypHdNpQM1PINR4ehLjRxyEM+SX4GwSKxqAdubHUpywB6/0Tz1OH1BMY7Z40e?=
 =?us-ascii?Q?yc5IURU/0/UrxMQ1gO5SGsp1Hsap9MPbMOuCExD1Q6spY7OO5TmRCF4Ekr/6?=
 =?us-ascii?Q?2/a1xbjrVCrDIAAaexvRpZmshqIB6Kz6aLho5Mkvyg95opiKtAxzs6pJC/YH?=
 =?us-ascii?Q?q9C0UN/wOjMEMHuE5aFUFwnm3cipm++ljOwvwYGO64J4RIh+YecHlErF6WzT?=
 =?us-ascii?Q?G0PPE6SQZWbyyeKWnrBxiMNG+WGd1YFbxcaRpJPWXs+JN8gpFjq20oUIAazK?=
 =?us-ascii?Q?EGXQCpYsCLnhvAtgtdzlLyBL0PT5pccTeUMBxchg1Viv32dhbz5Ozy1ObUn2?=
 =?us-ascii?Q?qtZLVA3Mpz1yoOCWFzZzLdj5TIA8a3SGdJ0e7r72XKB5ma4xy3dkG8rRyp39?=
 =?us-ascii?Q?YFPsakInzNEC45Un+sBKrAvpfVBfOim4Q+jAvw2uvJuEkyb0JDDoB85lmzhk?=
 =?us-ascii?Q?jeC3MbyBsX8/rgcNenL9Er9yQ7K8MXnq9OUohVgSY4EAMa01Z/Bclo1aQJAW?=
 =?us-ascii?Q?SEtspKAgkzMWWW6BsjW37/ppR4q1MSEkABYjn7V5eC0Ss1cozSGj00s4o4xa?=
 =?us-ascii?Q?Jk2sqxGL3Dsgs8mTTCk5WhSfiQHpijzGcyuxIpbLIq6OuK8HBp6QJ788ewEK?=
 =?us-ascii?Q?/kzCYJrqsTtFT/4B10Rnjl/UsYGo5FNOiFCzpjG1w954+PIut5onrjHp4F/c?=
 =?us-ascii?Q?4SrIXFV4efKS8MQzWF4l5BVgMSCZ97hOgdMPA2/JiQFPkZWUaUJDHYAezMux?=
 =?us-ascii?Q?NDJl/DGyroBAYgx0OtE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983753e9-956d-4d23-6628-08dbcc8f5068
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2023 08:26:50.4017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JL7FJXO7DxR9sYMeoFCepbdgRO2mktL/HsQ+tspxBSdoWzIdnsdboy6xe/3rFxtm4DH6lTk/dSX6H0cR6UNVpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

[AMD Official Use Only - General]

> From: Vinod Koul <vkoul@kernel.org>
> Sent: Wednesday, October 4, 2023 3:24 PM
> To: Mehta, Sanju <Sanju.Mehta@amd.com>
> Cc: gregkh@linuxfoundation.org; dan.j.williams@intel.com; robh@kernel.org=
;
> mchehab+samsung@kernel.org; davem@davemloft.net; linux-
> kernel@vger.kernel.org; dmaengine@vger.kernel.org
> Subject: Re: [PATCH 1/3] dmaengine: ae4dma: Initial ae4dma controller dri=
ver
> with multi channel
>
> On 11-09-23, 14:25, Sanjay R Mehta wrote:
> > From: Sanjay R Mehta <sanju.mehta@amd.com>
> >
> > Add support for AMD AE4DMA controller. It performs high-bandwidth
> > memory to memory and IO copy operation. Device commands are
> managed
> > via a circular queue of 'descriptors', each of which specifies source
> > and destination addresses for copying a single buffer of data.
> >
> > Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> > ---
> >  MAINTAINERS                     |   6 +
> >  drivers/dma/Kconfig             |   2 +
> >  drivers/dma/Makefile            |   1 +
> >  drivers/dma/ae4dma/Kconfig      |  11 ++
> >  drivers/dma/ae4dma/Makefile     |  10 ++
> >  drivers/dma/ae4dma/ae4dma-dev.c | 320
> > +++++++++++++++++++++++++++++++++++++
> >  drivers/dma/ae4dma/ae4dma-pci.c | 247
> +++++++++++++++++++++++++++++
> >  drivers/dma/ae4dma/ae4dma.h     | 338
> ++++++++++++++++++++++++++++++++++++++++
> >  8 files changed, 935 insertions(+)
> >  create mode 100644 drivers/dma/ae4dma/Kconfig  create mode 100644
> > drivers/dma/ae4dma/Makefile  create mode 100644
> > drivers/dma/ae4dma/ae4dma-dev.c  create mode 100644
> > drivers/dma/ae4dma/ae4dma-pci.c  create mode 100644
> > drivers/dma/ae4dma/ae4dma.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index d590ce3..fdcc6d9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -891,6 +891,12 @@ Q:     https://patchwork.kernel.org/project/linux-
> rdma/list/
> >  F: drivers/infiniband/hw/efa/
> >  F: include/uapi/rdma/efa-abi.h
> >
> > +AMD AE4DMA DRIVER
> > +M: Sanjay R Mehta <sanju.mehta@amd.com>
> > +L: dmaengine@vger.kernel.org
> > +S: Maintained
> > +F: drivers/dma/ae4dma/
> > +
> >  AMD CDX BUS DRIVER
> >  M: Nipun Gupta <nipun.gupta@amd.com>
> >  M: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig index
> > 08fdd0e..b26dbfb 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -777,6 +777,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
> >
> >  source "drivers/dma/lgm/Kconfig"
> >
> > +source "drivers/dma/ae4dma/Kconfig"
>
> There is another amd driver on the list, I suggest move all of these to a=
md/
> and have one kconfig inside amd/
>
Sure Vinod. As you suggested will do this.

> > +
> >  # clients
> >  comment "DMA Clients"
> >     depends on DMA_ENGINE
> > diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile index
> > a4fd1ce..513d87f 100644
> > --- a/drivers/dma/Makefile
> > +++ b/drivers/dma/Makefile
> > @@ -81,6 +81,7 @@ obj-$(CONFIG_XGENE_DMA) +=3D xgene-dma.o
> >  obj-$(CONFIG_ST_FDMA) +=3D st_fdma.o
> >  obj-$(CONFIG_FSL_DPAA2_QDMA) +=3D fsl-dpaa2-qdma/
> >  obj-$(CONFIG_INTEL_LDMA) +=3D lgm/
> > +obj-$(CONFIG_AMD_AE4DMA) +=3D ae4dma/
> >
> >  obj-y +=3D mediatek/
> >  obj-y +=3D qcom/
> > diff --git a/drivers/dma/ae4dma/Kconfig b/drivers/dma/ae4dma/Kconfig
> > new file mode 100644 index 0000000..1cda9de
> > --- /dev/null
> > +++ b/drivers/dma/ae4dma/Kconfig
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: GPL-2.0-only config AMD_AE4DMA
> > +   tristate  "AMD AE4DMA Engine"
> > +   depends on X86_64 && PCI
> > +   help
> > +     Enabling this option provides support for the AMD AE4DMA
> controller,
> > +     which offers DMA capabilities for high-bandwidth memory-to-
> memory and
> > +     I/O copy operations. The controller utilizes a queue-based descri=
ptor
> > +     management system for efficient DMA transfers. It is specifically
> > +     designed to be used in conjunction with AMD Non-Transparent
> Bridge devices
> > +     and is not intended for general-purpose peripheral DMA
> functionality.
> > diff --git a/drivers/dma/ae4dma/Makefile b/drivers/dma/ae4dma/Makefile
> > new file mode 100644 index 0000000..db9cab1
> > --- /dev/null
> > +++ b/drivers/dma/ae4dma/Makefile
> > @@ -0,0 +1,10 @@
> > +# SPDX-License-Identifier: GPL-2.0-only # # AMD AE4DMA driver #
> > +
> > +obj-$(CONFIG_AMD_AE4DMA) +=3D ae4dma.o
> > +
> > +ae4dma-objs :=3D ae4dma-dev.o
> > +
> > +ae4dma-$(CONFIG_PCI) +=3D ae4dma-pci.o
> > diff --git a/drivers/dma/ae4dma/ae4dma-dev.c
> > b/drivers/dma/ae4dma/ae4dma-dev.c new file mode 100644 index
> > 0000000..a3c50a2
> > --- /dev/null
> > +++ b/drivers/dma/ae4dma/ae4dma-dev.c
> > @@ -0,0 +1,320 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * AMD AE4DMA device driver
> > + * -- Based on the PTDMA driver
> > + *
> > + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> > + *
> > + * Author: Sanjay R Mehta <sanju.mehta@amd.com>  */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/delay.h>
> > +
> > +#include "ae4dma.h"
> > +#include "../dmaengine.h"
> > +#include "../virt-dma.h"
> > +
> > +static unsigned int max_hw_q =3D 1;
> > +module_param(max_hw_q, uint, 0444);
> > +MODULE_PARM_DESC(max_hw_q, "Max queues per engine (any non-zero
> value
> > +less than or equal to 16, default: 1)");
> > +
> > +/* Human-readable error strings */
> > +static char *ae4_error_codes[] =3D {
> > +   "",
> > +   "ERR 01: INVALID HEADER DW0",
> > +   "ERR 02: INVALID STATUS",
> > +   "ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
> > +   "ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
> > +   "ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
> > +   "ERR 06: INVALID ALIGNMENT",
> > +   "ERR 07: INVALID DESCRIPTOR",
> > +};
> > +
> > +static void ae4_log_error(struct ae4_device *d, int e) {
> > +   if (e <=3D 7)
> > +           dev_info(d->dev, "AE4DMA error: %s (0x%x)\n",
> ae4_error_codes[e], e);
> > +   else if (e > 7 && e <=3D 15)
> > +           dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID
> DESCRIPTOR", e);
> > +   else if (e > 15 && e <=3D 31)
> > +           dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID
> DESCRIPTOR", e);
> > +   else if (e > 31 && e <=3D 63)
> > +           dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID
> DESCRIPTOR", e);
> > +   else if (e > 63 && e <=3D 127)
> > +           dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR",
> e);
> > +   else if (e > 127 && e <=3D 255)
> > +           dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR",
> e);
>
> why info level? It should err going by fn description
>
Right, I'll remove that in v2.

> > +}
> > +
> > +void ae4_start_queue(struct ae4_cmd_queue *cmd_q) {
> > +   /* Turn on the run bit */
> > +   iowrite32(cmd_q->qcontrol | CMD_Q_RUN, cmd_q->reg_control); }
> > +
> > +void ae4_stop_queue(struct ae4_cmd_queue *cmd_q) {
> > +   /* Turn off the run bit */
> > +   iowrite32(cmd_q->qcontrol & ~CMD_Q_RUN, cmd_q->reg_control); }
> > +
> > +static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct
> > +ae4_cmd_queue *cmd_q) {
> > +   bool soc =3D FIELD_GET(DWORD0_SOC, desc->dw0);
> > +   u8 *q_desc =3D (u8 *)&cmd_q->qbase[0];
> > +   u32 tail_wi;
> > +
> > +   cmd_q->int_rcvd =3D 0;
> > +
> > +   if (soc) {
> > +           desc->dw0 |=3D FIELD_PREP(DWORD0_IOC, desc->dw0);
> > +           desc->dw0 &=3D ~DWORD0_SOC;
> > +   }
> > +   mutex_lock(&cmd_q->q_mutex);
> > +
> > +   /* Write Index of circular queue */
> > +   tail_wi =3D  ioread32(cmd_q->reg_control + 0x10);
> > +   q_desc +=3D (tail_wi * 32);
> > +
> > +   /* Copy 32-byte command descriptor to hw queue. */
> > +   memcpy(q_desc, desc, 32);
> > +   cmd_q->qidx =3D (cmd_q->qidx + 1) % CMD_Q_LEN; // Increment
> q_desc id.
> > +
> > +   /* The data used by this command must be flushed to memory */
> > +   wmb();
> > +
> > +   /* Write the new tail_wi address back to the queue register */
> > +   tail_wi =3D (tail_wi + 1) % CMD_Q_LEN;
> > +   iowrite32(tail_wi, cmd_q->reg_control + 0x10);
> > +
> > +   mutex_unlock(&cmd_q->q_mutex);
> > +
> > +   return 0;
> > +}
> > +
> > +int ae4_core_perform_passthru(struct ae4_cmd_queue *cmd_q, struct
> > +ae4_passthru_engine *ae4_engine)
>
> Who calls this, pls document the arguments for apis
>
Sure will document this in v2.

>
> > +{
> > +   struct ae4dma_desc desc;
> > +   struct ae4_device *ae4 =3D cmd_q->ae4;
> > +
> > +   cmd_q->cmd_error =3D 0;
> > +   memset(&desc, 0, sizeof(desc));
> > +   desc.dw0 =3D CMD_DESC_DW0_VAL;
> > +   desc.dw1.status =3D 0;
> > +   desc.dw1.err_code =3D 0;
> > +   desc.dw1.desc_id =3D 0;
>
> these are redundant, u already did memset
>
Right, I'll remove that in v2.

> > +   desc.length =3D ae4_engine->src_len;
> > +   desc.src_lo =3D upper_32_bits(ae4_engine->src_dma);
> > +   desc.src_hi =3D lower_32_bits(ae4_engine->src_dma);
> > +   desc.dst_lo =3D upper_32_bits(ae4_engine->dst_dma);
> > +   desc.dst_hi =3D lower_32_bits(ae4_engine->dst_dma);
> > +
> > +   if (cmd_q->int_en)
> > +           ae4_core_enable_queue_interrupts(ae4, cmd_q);
> > +   else
> > +           ae4_core_disable_queue_interrupts(ae4, cmd_q);
> > +
> > +   return ae4_core_execute_cmd(&desc, cmd_q); }
> > +
> > +static void ae4_do_cmd_complete(struct tasklet_struct *t) {
> > +   struct ae4_cmd_queue *cmd_q =3D from_tasklet(cmd_q, t, irq_tasklet)=
;
> > +   unsigned long flags;
> > +   struct ae4_cmd *cmd;
> > +
> > +   spin_lock_irqsave(&cmd_q->cmd_lock, flags);
> > +   cmd =3D list_first_entry(&cmd_q->cmd, struct ae4_cmd, entry);
> > +   list_del(&cmd->entry);
> > +   spin_unlock_irqrestore(&cmd_q->cmd_lock, flags);
> > +
> > +   cmd->ae4_cmd_callback(cmd->data, cmd->ret); }
> > +
> > +void ae4_check_status_trans(struct ae4_device *ae4, struct
> > +ae4_cmd_queue *cmd_q) {
> > +   u8 status;
> > +   int head =3D ioread32(cmd_q->reg_control + 0x0C);
> > +   struct ae4dma_desc *desc;
> > +
> > +   head =3D (head - 1) & (CMD_Q_LEN - 1);
> > +   desc =3D &cmd_q->qbase[head];
> > +
> > +   status =3D desc->dw1.status;
> > +   if (status) {
> > +           cmd_q->int_status =3D status;
> > +           if (status !=3D 0x3) {
>
> magic number
>
Sure. Will fix in V2.

> > +                   /* On error, only save the first error value */
> > +                   cmd_q->cmd_error =3D desc->dw1.err_code;
> > +                   if (cmd_q->cmd_error) {
> > +                           /*
> > +                            * Log the error and flush the queue by
> > +                            * moving the head pointer
> > +                            */
> > +                           ae4_log_error(cmd_q->ae4, cmd_q-
> >cmd_error);
> > +                   }
> > +           }
> > +   }
> > +}
> > +
> > +static irqreturn_t ae4_core_irq_handler(int irq, void *data) {
> > +   struct ae4_cmd_queue *cmd_q =3D data;
> > +   struct ae4_device *ae4 =3D cmd_q->ae4;
> > +   u32 status =3D ioread32(cmd_q->reg_control + 0x4);
> > +   u8 q_intr_type =3D (status >> 24) & 0xf;
> > +
> > +   if (q_intr_type =3D=3D  0x4)
> > +           dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "queue
> desc error", q_intr_type);
> > +   else if (q_intr_type =3D=3D  0x2)
> > +           dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "queue
> stopped", q_intr_type);
> > +   else if (q_intr_type =3D=3D  0x1)
> > +           dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "queue
> empty", q_intr_type);
> > +   else
> > +           dev_info(ae4->dev, "AE4DMA INTR: %s (0x%x)\n", "unknown
> error",
> > +q_intr_type);
>
> better use a switch
>
Right, Will use switch here in v2.
> > +
> > +   ae4_check_status_trans(ae4, cmd_q);
> > +
> > +   tasklet_schedule(&cmd_q->irq_tasklet);
> > +
> > +   return IRQ_HANDLED;
> > +}
> > +
> > +int ae4_core_init(struct ae4_device *ae4) {
> > +   char dma_pool_name[MAX_DMAPOOL_NAME_LEN];
> > +   struct ae4_cmd_queue *cmd_q;
> > +   u32 dma_addr_lo, dma_addr_hi;
> > +   struct device *dev =3D ae4->dev;
> > +   struct dma_pool *dma_pool;
> > +   unsigned int i;
> > +   int ret;
> > +   u32 q_per_eng =3D max_hw_q;
> > +
> > +   /* Update the device registers with queue information. */
> > +   iowrite32(q_per_eng, ae4->io_regs);
> > +
> > +   q_per_eng =3D ioread32(ae4->io_regs);
> > +
> > +   for (i =3D 0; i < q_per_eng; i++) {
> > +           /* Allocate a dma pool for the queue */
> > +           snprintf(dma_pool_name, sizeof(dma_pool_name),
> "%s_q%d", dev_name(ae4->dev), i);
> > +           dma_pool =3D dma_pool_create(dma_pool_name, dev,
> > +                                      AE4_DMAPOOL_MAX_SIZE,
> > +                                      AE4_DMAPOOL_ALIGN, 0);
> > +           if (!dma_pool)
> > +                   return -ENOMEM;
> > +
> > +           /* ae4dma core initialisation */
> > +           cmd_q =3D &ae4->cmd_q[i];
> > +           cmd_q->id =3D ae4->cmd_q_count;
> > +           ae4->cmd_q_count++;
> > +           cmd_q->ae4 =3D ae4;
> > +           cmd_q->dma_pool =3D dma_pool;
> > +           mutex_init(&cmd_q->q_mutex);
> > +           spin_lock_init(&cmd_q->q_lock);
> > +
> > +           /* Preset some register values (Q size is 32byte (0x20)) */
> > +           cmd_q->reg_control =3D ae4->io_regs + ((i + 1) * 0x20);
> > +
> > +           /* Page alignment satisfies our needs for N <=3D 128 */
> > +           cmd_q->qsize =3D Q_SIZE(Q_DESC_SIZE);
> > +           cmd_q->qbase =3D dma_alloc_coherent(dev, cmd_q->qsize,
> > +&cmd_q->qbase_dma, GFP_KERNEL);
> > +
> > +           if (!cmd_q->qbase) {
> > +                   ret =3D -ENOMEM;
> > +                   goto e_destroy_pool;
> > +           }
> > +
> > +           cmd_q->qidx =3D 0;
> > +           cmd_q->q_space_available =3D 0;
> > +
> > +           init_waitqueue_head(&cmd_q->int_queue);
> > +           init_waitqueue_head(&cmd_q->q_space);
>
> why do you need two waitqueues here?
>
These are not used anymore. Will cleanup them in V2.
> > +
> > +           dev_dbg(dev, "queue #%u available\n", i);
> > +   }
> > +
> > +   if (ae4->cmd_q_count =3D=3D 0) {
> > +           dev_notice(dev, "no command queues available\n");
> > +           ret =3D -EIO;
> > +           goto e_destroy_pool;
> > +   }
> > +   for (i =3D 0; i < ae4->cmd_q_count; i++) {
> > +           cmd_q =3D &ae4->cmd_q[i];
> > +           cmd_q->qcontrol =3D 0;
> > +           ret =3D request_irq(ae4->ae4_irq[i], ae4_core_irq_handler, =
0,
> > +                             dev_name(ae4->dev), cmd_q);
> > +           if (ret) {
> > +                   dev_err(dev, "unable to allocate an IRQ\n");
> > +                   goto e_free_dma;
> > +           }
> > +
> > +           /* Update the device registers with cnd queue length (Max
> Index reg). */
> > +           iowrite32(CMD_Q_LEN, cmd_q->reg_control + 0x08);
> > +           cmd_q->qdma_tail =3D cmd_q->qbase_dma;
> > +           dma_addr_lo =3D lower_32_bits(cmd_q->qdma_tail);
> > +           iowrite32((u32)dma_addr_lo, cmd_q->reg_control + 0x18);
> > +           dma_addr_lo =3D ioread32(cmd_q->reg_control + 0x18);
> > +           dma_addr_hi =3D upper_32_bits(cmd_q->qdma_tail);
> > +           iowrite32((u32)dma_addr_hi, cmd_q->reg_control + 0x1C);
> > +           dma_addr_hi =3D ioread32(cmd_q->reg_control + 0x1C);
> > +           ae4_core_enable_queue_interrupts(ae4, cmd_q);
> > +           INIT_LIST_HEAD(&cmd_q->cmd);
> > +
> > +           /* Initialize the ISR tasklet */
> > +           tasklet_setup(&cmd_q->irq_tasklet, ae4_do_cmd_complete);
> > +   }
> > +
> > +   return 0;
> > +
> > +e_free_dma:
> > +   dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase,
> > +cmd_q->qbase_dma);
> > +
> > +e_destroy_pool:
> > +   for (i =3D 0; i < ae4->cmd_q_count; i++)
> > +           dma_pool_destroy(ae4->cmd_q[i].dma_pool);
> > +
> > +   return ret;
> > +}
> > +
> > +void ae4_core_destroy(struct ae4_device *ae4) {
> > +   struct device *dev =3D ae4->dev;
> > +   struct ae4_cmd_queue *cmd_q;
> > +   struct ae4_cmd *cmd;
> > +   unsigned int i;
> > +
> > +   for (i =3D 0; i < ae4->cmd_q_count; i++) {
> > +           cmd_q =3D &ae4->cmd_q[i];
> > +
> > +           wake_up_all(&cmd_q->q_space);
> > +           wake_up_all(&cmd_q->int_queue);
> > +
> > +           /* Disable and clear interrupts */
> > +           ae4_core_disable_queue_interrupts(ae4, cmd_q);
> > +
> > +           /* Turn off the run bit */
> > +           ae4_stop_queue(cmd_q);
> > +
> > +           free_irq(ae4->ae4_irq[i], cmd_q);
> > +
> > +           dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase,
> > +                             cmd_q->qbase_dma);
> > +   }
> > +
> > +   /* Flush the cmd queue */
> > +   while (!list_empty(&ae4->cmd)) {
> > +           /* Invoke the callback directly with an error code */
> > +           cmd =3D list_first_entry(&ae4->cmd, struct ae4_cmd, entry);
> > +           list_del(&cmd->entry);
> > +           cmd->ae4_cmd_callback(cmd->data, -ENODEV);
> > +   }
> > +}
> > diff --git a/drivers/dma/ae4dma/ae4dma-pci.c
> > b/drivers/dma/ae4dma/ae4dma-pci.c new file mode 100644 index
> > 0000000..a77fbb5
> > --- /dev/null
> > +++ b/drivers/dma/ae4dma/ae4dma-pci.c
> > @@ -0,0 +1,247 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * AMD AE4DMA device driver
> > + * -- Based on the PTDMA driver
>
> cant we use ptdma driver to support both cores?
>
AE4DMA has multiple channels per engine, whereas PTDMA is limited to a sing=
le channel per engine. Furthermore, there are significant disparities in bo=
th the DMA engines and their respective handling methods. Hence wanted to k=
eep separate codes for PTDMA and AE4DMA.

> > + *
> > + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> > + *
> > + * Author: Sanjay R Mehta <sanju.mehta@amd.com> */
> > +
> > +#include <linux/device.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kthread.h>
> > +#include <linux/module.h>
> > +#include <linux/pci_ids.h>
> > +#include <linux/pci.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include "ae4dma.h"
> > +
> > +struct ae4_msix {
> > +   int msix_count;
> > +   struct msix_entry msix_entry[MAX_HW_QUEUES]; };
> > +
> > +/*
> > + * ae4_alloc_struct - allocate and initialize the ae4_device struct
> > + *
> > + * @dev: device struct of the AE4DMA
> > + */
> > +static struct ae4_device *ae4_alloc_struct(struct device *dev) {
> > +   struct ae4_device *ae4;
> > +
> > +   ae4 =3D devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
> > +
>
> This empty line here doesnt make sense

Sure. Will fix this in v2.

> > +   if (!ae4)
> > +           return NULL;
>
> it should be here instead :-)
>
Sure. Will fix this in v2.

> > +   ae4->dev =3D dev;
> > +
> > +   INIT_LIST_HEAD(&ae4->cmd);
> > +
> > +   return ae4;
> > +}
> > +
> > +static int ae4_get_msix_irqs(struct ae4_device *ae4) {
> > +   struct ae4_msix *ae4_msix =3D ae4->ae4_msix;
> > +   struct device *dev =3D ae4->dev;
> > +   struct pci_dev *pdev =3D to_pci_dev(dev);
> > +   int v, i, ret;
> > +
> > +   for (v =3D 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
> > +           ae4_msix->msix_entry[v].entry =3D v;
> > +
> > +   ret =3D pci_enable_msix_range(pdev, ae4_msix->msix_entry, 1, v);
> > +   if (ret < 0)
> > +           return ret;
> > +
> > +   ae4_msix->msix_count =3D ret;
> > +
> > +   for (i =3D 0; i < MAX_HW_QUEUES; i++)
> > +           ae4->ae4_irq[i] =3D ae4_msix->msix_entry[i].vector;
> > +
> > +   return 0;
> > +}
> > +
> > +static int ae4_get_msi_irq(struct ae4_device *ae4) {
> > +   struct device *dev =3D ae4->dev;
> > +   struct pci_dev *pdev =3D to_pci_dev(dev);
> > +   int ret, i;
> > +
> > +   ret =3D pci_enable_msi(pdev);
> > +   if (ret)
> > +           return ret;
> > +
> > +   for (i =3D 0; i < MAX_HW_QUEUES; i++)
> > +           ae4->ae4_irq[i] =3D pdev->irq;
> > +
> > +   return 0;
> > +}
> > +
> > +static int ae4_get_irqs(struct ae4_device *ae4) {
> > +   struct device *dev =3D ae4->dev;
> > +   int ret;
> > +
> > +   ret =3D ae4_get_msix_irqs(ae4);
> > +   if (!ret)
> > +           return 0;
> > +
> > +   /* Couldn't get MSI-X vectors, try MSI */
> > +   dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
> > +   ret =3D ae4_get_msi_irq(ae4);
> > +   if (!ret)
> > +           return 0;
> > +
> > +   /* Couldn't get MSI interrupt */
> > +   dev_err(dev, "could not enable MSI (%d)\n", ret);
> > +
> > +   return ret;
> > +}
> > +
> > +static void ae4_free_irqs(struct ae4_device *ae4) {
> > +   struct ae4_msix *ae4_msix =3D ae4->ae4_msix;
> > +   struct device *dev =3D ae4->dev;
> > +   struct pci_dev *pdev =3D to_pci_dev(dev);
> > +   unsigned int i;
> > +
> > +   if (ae4_msix->msix_count)
> > +           pci_disable_msix(pdev);
> > +   else if (ae4->ae4_irq)
> > +           pci_disable_msi(pdev);
> > +
> > +   for (i =3D 0; i < MAX_HW_QUEUES; i++)
> > +           ae4->ae4_irq[i] =3D 0;
> > +}
> > +
> > +static int ae4_pci_probe(struct pci_dev *pdev, const struct
> > +pci_device_id *id) {
> > +   struct ae4_device *ae4;
> > +   struct ae4_msix *ae4_msix;
> > +   struct device *dev =3D &pdev->dev;
> > +   void __iomem * const *iomap_table;
> > +   int bar_mask;
> > +   int ret =3D -ENOMEM;
> > +
> > +   ae4 =3D ae4_alloc_struct(dev);
> > +   if (!ae4)
> > +           goto e_err;
> > +
> > +   ae4_msix =3D devm_kzalloc(dev, sizeof(*ae4_msix), GFP_KERNEL);
> > +   if (!ae4_msix)
> > +           goto e_err;
> > +
> > +   ae4->ae4_msix =3D ae4_msix;
> > +   ae4->dev_vdata =3D (struct ae4_dev_vdata *)id->driver_data;
> > +   if (!ae4->dev_vdata) {
> > +           ret =3D -ENODEV;
> > +           dev_err(dev, "missing driver data\n");
> > +           goto e_err;
> > +   }
> > +
> > +   ret =3D pcim_enable_device(pdev);
> > +   if (ret) {
> > +           dev_err(dev, "pcim_enable_device failed (%d)\n", ret);
> > +           goto e_err;
> > +   }
> > +
> > +   bar_mask =3D pci_select_bars(pdev, IORESOURCE_MEM);
> > +   ret =3D pcim_iomap_regions(pdev, bar_mask, "ae4dma");
> > +   if (ret) {
> > +           dev_err(dev, "pcim_iomap_regions failed (%d)\n", ret);
> > +           goto e_err;
> > +   }
> > +
> > +   iomap_table =3D pcim_iomap_table(pdev);
> > +   if (!iomap_table) {
> > +           dev_err(dev, "pcim_iomap_table failed\n");
> > +           ret =3D -ENOMEM;
> > +           goto e_err;
> > +   }
> > +
> > +   ae4->io_regs =3D iomap_table[ae4->dev_vdata->bar];
> > +   if (!ae4->io_regs) {
> > +           dev_err(dev, "ioremap failed\n");
> > +           ret =3D -ENOMEM;
> > +           goto e_err;
> > +   }
> > +
> > +   ret =3D ae4_get_irqs(ae4);
> > +   if (ret)
> > +           goto e_err;
> > +
> > +   pci_set_master(pdev);
> > +
> > +   ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> > +   if (ret) {
> > +           ret =3D dma_set_mask_and_coherent(dev,
> DMA_BIT_MASK(32));
> > +           if (ret) {
> > +                   dev_err(dev, "dma_set_mask_and_coherent failed
> (%d)\n",
> > +                           ret);
> > +                   goto e_err;
> > +           }
> > +   }
> > +
> > +   dev_set_drvdata(dev, ae4);
> > +
> > +   if (ae4->dev_vdata)
> > +           ret =3D ae4_core_init(ae4);
> > +
> > +   if (ret)
> > +           goto e_err;
> > +
> > +   return 0;
> > +
> > +e_err:
> > +   dev_err(dev, "initialization failed ret =3D %d\n", ret);
> > +
> > +   return ret;
> > +}
> > +
> > +static void ae4_pci_remove(struct pci_dev *pdev) {
> > +   struct device *dev =3D &pdev->dev;
> > +   struct ae4_device *ae4 =3D dev_get_drvdata(dev);
> > +
> > +   if (!ae4)
> > +           return;
> > +
> > +   if (ae4->dev_vdata)
> > +           ae4_core_destroy(ae4);
> > +
> > +   ae4_free_irqs(ae4);
> > +}
> > +
> > +static const struct ae4_dev_vdata dev_vdata[] =3D {
> > +   {
> > +           .bar =3D 0,
>
> why pass zero data?
>
Initially, during the bringup phase, the base address was included part of =
BAR2. However, it was subsequently resolved to BAR0 in the latest silicon. =
Hence storing BAR info is not needed anymore. Will fix in v2.

> > +   },
> > +};
> > +
> > +static const struct pci_device_id ae4_pci_table[] =3D {
> > +   { PCI_VDEVICE(AMD, 0x14C8), (kernel_ulong_t)&dev_vdata[0] },
> > +   { PCI_VDEVICE(AMD, 0x14DC), (kernel_ulong_t)&dev_vdata[0] },
> > +   /* Last entry must be zero */
> > +   { 0, }
> > +};
> > +MODULE_DEVICE_TABLE(pci, ae4_pci_table);
> > +
> > +static struct pci_driver ae4_pci_driver =3D {
> > +   .name =3D "ae4dma",
> > +   .id_table =3D ae4_pci_table,
> > +   .probe =3D ae4_pci_probe,
> > +   .remove =3D ae4_pci_remove,
> > +};
> > +
> > +module_pci_driver(ae4_pci_driver);
> > +
> > +MODULE_AUTHOR("Sanjay R Mehta <sanju.mehta@amd.com>");
> > +MODULE_LICENSE("GPL"); MODULE_DESCRIPTION("AMD AE4DMA
> driver");
> > diff --git a/drivers/dma/ae4dma/ae4dma.h
> b/drivers/dma/ae4dma/ae4dma.h
> > new file mode 100644 index 0000000..0ae46ee
> > --- /dev/null
> > +++ b/drivers/dma/ae4dma/ae4dma.h
> > @@ -0,0 +1,338 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * AMD AE4DMA device driver
> > + *
> > + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> > + *
> > + * Author: Sanjay R Mehta <sanju.mehta@amd.com>  */
> > +
> > +#ifndef __AE4_DEV_H__
> > +#define __AE4_DEV_H__
> > +
> > +#include <linux/device.h>
> > +#include <linux/pci.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/mutex.h>
> > +#include <linux/list.h>
> > +#include <linux/wait.h>
> > +#include <linux/dmapool.h>
> > +
> > +#define MAX_AE4_NAME_LEN                   16
> > +#define MAX_DMAPOOL_NAME_LEN               32
> > +
> > +#define MAX_HW_QUEUES                      16
> > +#define MAX_CMD_QLEN                       32
> > +
> > +#define AE4_ENGINE_PASSTHRU                5
> > +
> > +/* Register Mappings */
> > +#define IRQ_MASK_REG                       0x040
> > +#define IRQ_STATUS_REG                     0x200
> > +
> > +#define CMD_Q_ERROR(__qs)          ((__qs) & 0x0000003f)
> > +
> > +#define CMD_QUEUE_PRIO_OFFSET              0x00
> > +#define CMD_REQID_CONFIG_OFFSET            0x04
> > +#define CMD_TIMEOUT_OFFSET         0x08
> > +#define CMD_AE4_VERSION                    0x10
> > +
> > +#define CMD_Q_CONTROL_BASE         0x0000
> > +#define CMD_Q_TAIL_LO_BASE         0x0004
> > +#define CMD_Q_HEAD_LO_BASE         0x0008
> > +#define CMD_Q_INT_ENABLE_BASE              0x000C
>
> lower case please (here and elsewhere)
>
Sure. Will fix in V2.
> --
> ~Vinod
