Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B687B60DA61
	for <lists+dmaengine@lfdr.de>; Wed, 26 Oct 2022 06:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJZEoJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Oct 2022 00:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJZEoI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Oct 2022 00:44:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA4167C8D;
        Tue, 25 Oct 2022 21:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvTO1lvyHDqdtxMRVpzD3Svi5TofD4QZwW4tU7eUrEPUGl/x3aYLn2FZAGtVly5whUYB6R7xSOe+KXOqjZbbWXm/MLiKVo8p5WPFyuiObQMICjqWg37XUAL4I4qmHBKpb7kCfevDrX81g++p5d35j6VMd3C8n1kil3UZCW3J/0QpjNjpxfvgFRDGh8FA9sXNyMBI7I2NHhvn49rXI2Ul9DZEVFJ5CmaoAi+Mc8nLI2+x0hRL8FjU7W9wIINSxslVNKSRy/YS1MpipCF2ExhODnhvc8EPaAIIxbYThIkax3iEduApDnvypUseKscubPTPsoL0lPDet6a0J3isUXGTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/GtIMj8+2pQ4Jmvmx1Eg7GlyatnKg47Ktdunhf25eg=;
 b=DKSrHy78+bTOolkZJFNmUtbT78Dog0NvHy+TFrvS37SCaTGuEyP/EpA5UV/A2bUkdQhsgGgQcbqZsjnF1noS1PH8RgjMPcBy1JgvXORyOEztlaLIDIrOyzAMzBNId/f96DPHzHQdB2YAPi42ZKzIqtT5vKiGFwIJK94nH0cbRiHTMZQk70dzXlSIJgmzkA4P9xGOn4dLdKfgXncobUSYxBWJmJgFAWDN2RT7pZ3APJcutmuKIJ2TfOHxQbsbHYhd1kaDs8G9lkpJxMl1WBsFb12ZG9a2juVzulLkbWxYfAa/rmSPjRJo+nMiVS7Dxb7qdvZ3bY+6f9V35zeGP1/hMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/GtIMj8+2pQ4Jmvmx1Eg7GlyatnKg47Ktdunhf25eg=;
 b=KFkqdKerS26rfVs251QtWyIVdWusXhp20a9pqZdMm0TgY9W1oQkNhscQ1uLPLGSa6jJpoLWa11EJ97DekPML24gbypeLp66E0V8WMPttro7BJbdx93p92/IPElTFnoCvXZ4b2ak44OzEAfmTOPQewOge5YYMdz8zZ0ZX0o8rEhJGmqAkp4n5FGvpROrY11Db6y/nUWXBcF5gnT8qMoiiw76SKmY5YPFeyrg2VikQJLtXErbMaEMA0f1nGhnZJYa7DfJ+GWAFlUxBSj3c4URPDb+QCEe6rDTwDXpUIeZbSTw/BS9Km5A8qK0Tgt+s03D3wXe+p1/OmK+NoNX8S0BbHw==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 04:44:05 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::a79a:f9ad:49ba:bf32]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::a79a:f9ad:49ba:bf32%6]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 04:44:03 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: RE: [PATCH RESEND v2 3/3] dmaengine: tegra: Add support for
 dma-channel-mask
Thread-Topic: [PATCH RESEND v2 3/3] dmaengine: tegra: Add support for
 dma-channel-mask
Thread-Index: AQHY5F69UPkfFaxUi0yvDnZJOZcJza4YHWYAgAf/RmA=
Date:   Wed, 26 Oct 2022 04:44:03 +0000
Message-ID: <SJ1PR12MB63399B01D750CD4725A13A03C0309@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20221020083322.36431-1-akhilrajeev@nvidia.com>
 <20221020083322.36431-4-akhilrajeev@nvidia.com>
 <20221021021604.GA2181729-robh@kernel.org>
In-Reply-To: <20221021021604.GA2181729-robh@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|DS7PR12MB6309:EE_
x-ms-office365-filtering-correlation-id: c7489124-0b5c-4ff2-1aae-08dab70cb586
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: okbbM0br/uLNtQlPKtG7ryLETxBK+ShjwJ6l5Q5RbSflEDTFLk9hQlLDODaODu03tGssez+fbCyTCB/2aaXXpjdfoTEhxRWqTdINVPL4K809NYR6U+vwrj4NMMnnHG2I2XEAgVkPLqTsF0X6j5QL26Jp8NObPme5BYSyCrBCvZS8OBqoF1+aWWSDAmAe01hqTsOR0ElzPmf40U1/VKEPTA26rPp8PfqQJMQNarhJzsuCpPmUdiATaUNGj423kozbYWLSf4oaHUAAPUAnCeM3p6sjTY7Gj96P1+9ZUAF6ZS4Fr7+jKmAytRXUYhXWmsZISY6yo9pgdJzDmSMxwyCQ0/imdE6WxsXoIRwBxRBM9061EBG+CVajuzGTd9uaY1UeQVaBwWjqJQdzG4Y/wroiVtAtp/646b620bVTmmE9lMTpzI8yPaOVi/kve5g9BQDDPHvjQaSpBNnHOzx14N1WVE9AcBQQDDpFY3uJwwPXI4ehr+LPNDYfi3WP1hLjuZicYpNVxJJHtYpbWTT6AoHqXBEagRhskXIe5kACf/vEBtHwiQ8GMkY+np3+lv/Eb7YWnsKnhurR3nyN21VjxBNfuGC/WrDR1IvaDS8nWv/gjMYaIu5QyEvW87xGAhlKuAxxyyfOpSvUrQ66iSvpmcz+h1vdRt0V8dGmo4yqK23oFDWvlEOXT/fCO5AdFitiwZC2jdIPysvOsHQEHhGvSKV7F1DsB1KMtIpNPLRsxIXHQPY41aVAePsmgTWXggePg8Ebq9/yVADrPBzOA2Vv2dldXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(55016003)(33656002)(8936002)(5660300002)(478600001)(7416002)(38070700005)(71200400001)(8676002)(316002)(2906002)(122000001)(4326008)(86362001)(38100700002)(7696005)(6506007)(186003)(26005)(9686003)(6916009)(54906003)(41300700001)(66476007)(66446008)(64756008)(76116006)(66556008)(66946007)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+dsooCF4DEcb+YnK/0AMu2dk4Sr1+7E9pb1+DCiu52dm1HUnb6F6ijoNl6UE?=
 =?us-ascii?Q?ayHcgEmVFKNfB2ZRJJjdjHRata9nikx0BPYkS5DsBNPS8gRKSkIHhhqjWsYb?=
 =?us-ascii?Q?EDbz20y6dEdTreZmyx46ghecYlo0xcyDfpAFG6UiKmtU1E59sBQQvISaHpuH?=
 =?us-ascii?Q?T+mDen3BZi8YUw7jF3AeyruCT/OOi9FDEj9cJT3QSvQL4wWtibwv3VzcGm8A?=
 =?us-ascii?Q?4oQ4pPmEWxaTPMuodt4HjQG7K/nAHEWO8lz6PfYJrjX/BYTcLu8stjMchfiM?=
 =?us-ascii?Q?Jd++3cQjev2aUoaxeDHkFQaOEmGIVBmuM9UO4m0ak3XM3oxYFvRqt7bdXnK5?=
 =?us-ascii?Q?dyAPKunzSnmb7VkJcEbUycgGT8bPOaIBwvsBor4benqGqQO0GHgoqC0QntNe?=
 =?us-ascii?Q?27DtHlHKQzNaP1DEdiIrAFbdXmd7b72vRY79ojfhe7AQFqnAn6/y48X2sFL6?=
 =?us-ascii?Q?RQtk1xFxJxourDoxOo/VMqD3ggYNnH9YU8KYre/Wvok+lupvPyFdcQCQnGnd?=
 =?us-ascii?Q?omBqvkJtrJTzuWJcNsVjcP/4bTG+9DsPc+eFIdZ2+9gMvThi8Nn9TA7rqOFi?=
 =?us-ascii?Q?S68a1SRCObrPU6zTR7ujiLkaFCGbRixZy4A8bZhaEqcX0E1OK/ZBCSsnuQE2?=
 =?us-ascii?Q?PFNznSReK/p7idWFafE3exqiyE/9OVRGnGU8rYX7vLmtKUsf1zYOrpBljTnh?=
 =?us-ascii?Q?YbPAvEHcUDLGop7h5XgoGVOOsX/0TdnW4fV8V1e3FxOIdS62QFdBy0cVleB/?=
 =?us-ascii?Q?V4GPhJUuFEHxPjRqf4pxKCvwV89DNCOBpOWfNp48OofJFNReH3t5M9bK0cwk?=
 =?us-ascii?Q?AyZBeUZhrJxkntIzBG6vnmHv6IUqKKnMkXuyeDK5Kcl5ITqo/VSMBzKswpbT?=
 =?us-ascii?Q?LgsQA7+gOfy2ySs+n1DVwT5FxsUflA8OpOR/mT+Ai2X+ni3z0jzTrtxCDqX4?=
 =?us-ascii?Q?xVQcdAvGmH4AeqhbhE4jDPx5VVYURYiKznQxb+mL08j1Ou6QPED9bt8u1neA?=
 =?us-ascii?Q?M3Qe9XGRwaxHuBmQJ2dN60KzH/XfS83RJqH2tFFHStywfoFsYG5UGA31+vrh?=
 =?us-ascii?Q?vtjuofqhLTtDZ/COrjEY9pmHv5I1sbyIcYlOZXDTA1kJD2kO+gUTCenAN7tt?=
 =?us-ascii?Q?hb5sKLa97hFAA7gIAck00DiZ5QvwvDIvAySudkDB6IsC5KniJgaLo90Vk3sE?=
 =?us-ascii?Q?49sd990BWfX4s13KDFOsEyIgeIeEuGsbPCdIfCuFYyCdLhCx8qa1/4QwoCE8?=
 =?us-ascii?Q?ffFC0nTFWrFhtuXmkC8mdKR0MLjsDjqCUYUAeNUAmoUGffWR0rChMa+/VmDp?=
 =?us-ascii?Q?tGuRG2vYUtT+15r8BWzN43YiWu5cGSc8UPNK2LViM95KUqXppOQEStgDr/hE?=
 =?us-ascii?Q?OXPa1bVdU4ZqXFTpDTSt5nGeEqom/pJNdU3EYX9R8NPRSM0y40GLH4NDm3sA?=
 =?us-ascii?Q?7PMWcN8x85NWhPg/0hxlqwcP5yJzG0KzNsus0Yl923CKYw0jx+d2qBFFgh63?=
 =?us-ascii?Q?nPxEGh0eMSF5XxwH8jSXAF99WYl8u7gvGDtYH3J7Tc3JCdnYdzs++11DzFJv?=
 =?us-ascii?Q?6JgC4Pz0+/8a54cgIECpZkhsKWj0gDrDWmEq1hQU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7489124-0b5c-4ff2-1aae-08dab70cb586
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 04:44:03.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBIll7bXV/l+Aq6kKABTiT7JeO5ucoDg9kth1DNmCadCJ5mD1P9l1B2K2oBxPQuNuHygkRbYYnPTSaL4rcJ0HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On Thu, Oct 20, 2022 at 02:03:22PM +0530, Akhil R wrote:
> > Add support for dma-channel-mask so that only the specified channels
> > are used. This helps to reserve some channels for the firmware.
> >
> > This was initially achieved by limiting the channel number to 31 in
> > the driver and adjusting the register address to skip channel0 which
> > was reserved for a firmware. Now, with this change, the driver can
> > align more to the actual hardware which has 32 channels.
> >
> > Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> >  drivers/dma/tegra186-gpc-dma.c | 37 +++++++++++++++++++++++++++-------
> >  1 file changed, 30 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-
> dma.c
> > index fa9bda4a2bc6..1d1180db6d4e 100644
> > --- a/drivers/dma/tegra186-gpc-dma.c
> > +++ b/drivers/dma/tegra186-gpc-dma.c
> > @@ -161,7 +161,10 @@
> >  #define TEGRA_GPCDMA_BURST_COMPLETION_TIMEOUT        5000 /* 5
> msec */
> >
> >  /* Channel base address offset from GPCDMA base address */
> > -#define TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET 0x20000
> > +#define TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET        0x10000
> > +
> > +/* Default channel mask reserving channel0 */
> > +#define TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK    0xfffffffe
> >
> >  struct tegra_dma;
> >  struct tegra_dma_channel;
> > @@ -246,6 +249,7 @@ struct tegra_dma {
> >       const struct tegra_dma_chip_data *chip_data;
> >       unsigned long sid_m2d_reserved;
> >       unsigned long sid_d2m_reserved;
> > +     u32 chan_mask;
> >       void __iomem *base_addr;
> >       struct device *dev;
> >       struct dma_device dma_dev;
> > @@ -1288,7 +1292,7 @@ static struct dma_chan *tegra_dma_of_xlate(struct
> of_phandle_args *dma_spec,
> >  }
> >
> >  static const struct tegra_dma_chip_data tegra186_dma_chip_data =3D {
> > -     .nr_channels =3D 31,
> > +     .nr_channels =3D 32,
>=20
> This is an ABI break. A new kernel with an old DTB will use 32 channels
> instead of 31. You should leave this and use the dma-channel-mask to
> enable all 32 channels.
>=20
Hi Rob,

If using an old DTB, tdma->chan_mask will be default to 0xfffffffe since it
would not have the dma-channel-mask property. The driver would still=20
use 31 channels even if it uses an old DTB. Shouldn't it prevent the
ABI break?=20

Regards,
Akhil

