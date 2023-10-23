Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C827D3A59
	for <lists+dmaengine@lfdr.de>; Mon, 23 Oct 2023 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjJWPE7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Oct 2023 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjJWPE6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Oct 2023 11:04:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105E10E;
        Mon, 23 Oct 2023 08:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vkt5NvWrbZUAjuq9LcAd6i8u9wM11jjQhphXO1l4HXj6pAZawiQigz7vN/l8MPzqTTkmKzf0uumFFvPUGTsnOmASmQbsgwA+HZg2j/lsYe8BdDHxzXy10GaEgHkFoxvAhom40g2QSUrDtyFwBR6NpDP9Bo/w7HERsEDEBJpp+rrj5RqqjVQ8I51GVXVQEZOwdEX9zgAVyYVmVklzRUwcSZheXi69x7KgKALo1D9NoXpr8CHZow2eBOsW5fipZ8bcKK1MWTMK0yFnczUmELYMLl3P+pPDrCb/PRDljN0dUtvYaysoCs4Eyou13qGgd0CS/WKj15ohXfuswojcQycomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqLfORJ4+vnu/+joUUCdLgNBjUALrZI+u6m32GZLDn4=;
 b=JwCqcFIz7qIW20L8fM+ZxUoIK3CaBrNR18qt4ktAEgeqDS1FaNYiLMhe/ppnOvQP0imPUFcjqfhIe5kgzZs+OM7EyjqKvMSCWzkH/KDc6EfjWwpya+dlp7MhuEr10JDr1m7iFc9qUjoc4lWRIcd0D/oj5ieUvOEjMvjfI79eMPca3eeFjHJlj19vvTCwOSmwgAaGEx2z57NjLHgdpl7fpYQaLjekPYr4NsEnvl00NG+bkqvjTr7KdE0Zw2QCIvRDzXH0oC6ktWeoxB2V3+lh6TD+NmQn15ES+adwjQ6WhZbo2R57GKgioQ+2rHzIASNcd41N0wk+fsWIKsAX/3E8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqLfORJ4+vnu/+joUUCdLgNBjUALrZI+u6m32GZLDn4=;
 b=HGAKbh8tuN68CmU4WntwjeJLnPlaxTGyYQBtXGc0JZ7uI0oyJPbykV0Ga/vBXvvVYWlMm717YvL0gkqIl43ZSr84E4VlyWrnXqdTzMQS4hLiSesk6aMrEPT9jETrcc8i2cg+cTfG0F/BgLpy3fWM7avQJbalmmKX/KPH+bJGhiU=
Received: from DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) by
 SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Mon, 23 Oct 2023 15:04:51 +0000
Received: from DM4PR12MB6326.namprd12.prod.outlook.com
 ([fe80::7a0e:4279:ec71:b5dc]) by DM4PR12MB6326.namprd12.prod.outlook.com
 ([fe80::7a0e:4279:ec71:b5dc%4]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 15:04:51 +0000
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
Thread-Index: AQHZ5OXFUN7BzI35s02+So3lunxHgLA5h6CAgAw6yrCABmxlAIALimPQ
Date:   Mon, 23 Oct 2023 15:04:50 +0000
Message-ID: <DM4PR12MB6326104B02B1D2D75022D1BAE5D8A@DM4PR12MB6326.namprd12.prod.outlook.com>
References: <1694460324-60346-1-git-send-email-Sanju.Mehta@amd.com>
 <1694460324-60346-2-git-send-email-Sanju.Mehta@amd.com>
 <ZR02PT/k0op8T71U@matsya>
 <DM4PR12MB6326A31446E45335D2FB457BE5D1A@DM4PR12MB6326.namprd12.prod.outlook.com>
 <ZSzb9OEo6cIbln3A@matsya>
In-Reply-To: <ZSzb9OEo6cIbln3A@matsya>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=72450ebe-4c54-4820-8d1e-a67b7f124d76;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-23T14:59:18Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6326:EE_|SA1PR12MB6970:EE_
x-ms-office365-filtering-correlation-id: e6ecbcb4-5837-45d1-dd1c-08dbd3d96801
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 125C2tvZH39a04jYhmwtWbpUDA0shQw2HpLbLaAeNZIWFcTAMAOhs8kVbWvuUov9SXRKF0DfcsCLjyVXSx/ja2U9WsezidtUT3aUQdrXPLlC38sHRMNiWAePOT71EJcucT7sNZbrS9zb3pUTTPnRprC7JlXh70TFmWg6b8lAgpraUKAkUdcn1c5amvg96E74UMi6kYdfK69ikyWGtyXo/6OZVsMD5fsWA8Azdr8cM4ea6aiwmH/291MCvaWcnaRsDfRLqBzRri88Ik/t0af8bsu76nFEQvtk1X30lw5K75pMR/E6JueRnYRMhdqYdOZvrwZ0QoBIo0QiCRn93QdXh2wVSITyNdFocVNpmaROEoepB0FLXAWZx1G8hOBQ34Lys4z8dAs7WMf6yekpCaPLfIjL+0bq0F0vFukK906+e1uRAggr5YELoD0lpQXfgUmGrei7SHmmt4tEtE3CaCAsYs1FtJMxSZlG55rtQfY6cEBm1DwmYjFKrr8CiBOeKCegc8o1kETUFV6YB55hOQinTbmCLLn5ordEQ8a5X/yK1Zde0T1/fmIz0U9FFZXOit/40IHEZq3O4tqsdhdrn5oFCcxrQlPSXtp0FmKPKznFXrd3DlP/pcqViTjvR1BRb5zrsg54IXYeKraM03TdNJIetohwtuH4aVnKT8+++fKTczA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6326.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(122000001)(7696005)(478600001)(55016003)(38100700002)(71200400001)(6506007)(9686003)(38070700009)(53546011)(54906003)(66446008)(66946007)(76116006)(66556008)(66476007)(64756008)(8676002)(4326008)(8936002)(5660300002)(41300700001)(86362001)(2906002)(6916009)(316002)(52536014)(26005)(33656002)(83380400001)(42413004)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oyQbnofnF4oSZ2/VbUUIHdXU+93aESWTAzNR0DGAOhselSQquCuUUmElVY93?=
 =?us-ascii?Q?NfjLq/qKsU1mQamMa8Z7isItPxo9zLh61cO6qIxYZNxY4ABdHebu2pN1NGJC?=
 =?us-ascii?Q?svJrO7OIzKEiwg98XVjtrn+OEC+MZssGjrBLWJA0/1XrhW2gssb9sU/jIwdf?=
 =?us-ascii?Q?P56zNj1Yj6Iyvr7+g3FTfA+ChCKkS+k4xTHGzuppdsgLPgkgJ6DrI1uyO1g6?=
 =?us-ascii?Q?3J54zxlkNV2e+yPUllOTiLp27EypanSPozSqjfzrJDYTrEKwMm8n2G/jYy0H?=
 =?us-ascii?Q?kaHw7IjY8cTi+xPWAJC8QDVJZ1vhXldB+7YqD+gTcgtt0beS9m1hgQ8IV86Q?=
 =?us-ascii?Q?XBh0N8l74aEhbmC9ftftqQpG86KcQqNvlzKviIejstG5zPaTWmcZuVrtTcBO?=
 =?us-ascii?Q?T/UeBJoIymyx21fBFIQHHNY4B+TeRoAXTBnvvM8CIZZeUMZ8RcsQUYpCJd8y?=
 =?us-ascii?Q?kk+j8vOpo5nPWsnsm89yziYY8GTPtokJab5QTe4r44z5Gh9rFg14ZXhkWmsV?=
 =?us-ascii?Q?mLc5cEl7Hz1LiKQ8PQ65+pxOqN47J8yg7JOrPcQuundkOJL+HugQZV+wsjuH?=
 =?us-ascii?Q?QT87Au54pyUzaep9TDIE6TEMoZgeNOKufHHI1bgM9T8JuiETCUQqUUXxiXuB?=
 =?us-ascii?Q?oRZMSgyGj/Q1728Hyz1n2oWgdINhJ2YZ6GXdlCbc41Jw7dIAEaz1poQotKOT?=
 =?us-ascii?Q?rSoC/pvorVzrUIu633B+9YNe05GdeyXMdsbfZypcjYSIkLysvHnJ1HAm3b2v?=
 =?us-ascii?Q?awMp4VWSWii/OPLv9EtvZP2DcFjTEywZd6ztfMlmdRXwn09WxjNN2gq+y52f?=
 =?us-ascii?Q?XF68lDcnUWZ2H6vNaKRs6sb7VQ0aM5Lfut1ptbNE6nJ0J+pAVW4FqoTZlyMR?=
 =?us-ascii?Q?sC7FRyXQ0a6V3BQNy+LpBfDfQDW3Oa6lLrtOZynV7HjM60MEv3fjSG23vqR3?=
 =?us-ascii?Q?YumTibNr5NCGBn8+Xv9+BaKlw5aRGJSAmy9M4Z9h9feLZ7CZm8OICWyTp34B?=
 =?us-ascii?Q?CGldxfW1AX6ZmFYlpmZ+9kxJDoFoPO6McK0cOdz+3ap5BD1B3rE4dwcoHGrd?=
 =?us-ascii?Q?hOq9ZH2la/D5vMDh8EsZlBQf5MxzdS6yPpxEwIOpizRC7sOBYnTwbdKGEErU?=
 =?us-ascii?Q?kE02jvZDYoLR2ebkEpC+yS6ZIIbzAQxp7O0TjI0P2JoK1DOiOSnMl+yE++2R?=
 =?us-ascii?Q?j8GetfiC9Rk6Y2L9ouDZvXCQbiXmr6zEU2xjA38hbc62hRxuiFD8pUQmOKtQ?=
 =?us-ascii?Q?mMem0z4/XXIY8Z7iKTxfh/vmXFusmeAY3nizYVIJiPQMAEVEkX0thBL0nHAC?=
 =?us-ascii?Q?TaIR14QGtrkEZlMCNXT2WZIWoZz7Au8oBsZ+joSa2VfUXS5s6mZpQcyt7cbd?=
 =?us-ascii?Q?LDHh9n83qYTpZv19zRpsm5HVTTVFICht2ZAMjLq9pN4puNh0p6D1kTytLwYR?=
 =?us-ascii?Q?ItxqLQJBs2+MHb/X0+yWefa3K8emhyE56iUSU+WUbCDBbxSTaj8zMpDqp3Io?=
 =?us-ascii?Q?vxIVMNJ2XsizdwoI/pGulqoE4d8c/GAxG832UXuwbtuMw6bpaLYBk2nQV5IE?=
 =?us-ascii?Q?q0Ol/SZbyBdeHVjbg/4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ecbcb4-5837-45d1-dd1c-08dbd3d96801
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 15:04:50.9285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqsHHjLZhwVHmP2I3B8sILiXEDETrGoXI9LFV7ucjqTqxQ+Q3E8PueLZTQYSvV0Ac9OHjVnrccTQndUtyvYb+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Monday, October 16, 2023 12:15 PM
> To: Mehta, Sanju <Sanju.Mehta@amd.com>
> Cc: gregkh@linuxfoundation.org; dan.j.williams@intel.com; robh@kernel.org=
;
> mchehab+samsung@kernel.org; davem@davemloft.net; linux-
> kernel@vger.kernel.org; dmaengine@vger.kernel.org
> Subject: Re: [PATCH 1/3] dmaengine: ae4dma: Initial ae4dma controller dri=
ver
> with multi channel
>
> On 14-10-23, 08:26, Mehta, Sanju wrote:
> > [AMD Official Use Only - General]
>
> ??
>
> > > > diff --git a/drivers/dma/ae4dma/ae4dma-pci.c
> > > > b/drivers/dma/ae4dma/ae4dma-pci.c new file mode 100644 index
> > > > 0000000..a77fbb5
> > > > --- /dev/null
> > > > +++ b/drivers/dma/ae4dma/ae4dma-pci.c
> > > > @@ -0,0 +1,247 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * AMD AE4DMA device driver
> > > > + * -- Based on the PTDMA driver
> > >
> > > cant we use ptdma driver to support both cores?
> > >
> > AE4DMA has multiple channels per engine, whereas PTDMA is limited to a
> single channel per engine. Furthermore, there are significant disparities=
 in both
> the DMA engines and their respective handling methods. Hence wanted to ke=
ep
> separate codes for PTDMA and AE4DMA.
>
> Pls wrap your replies to 80chars!
>
> The channel count should be configurable and for the handling methods,
> you can have low level handler functions for each controller which can
> be selected based on device probe
>
> I feel reuse of code is better idea than having two different drivers

Yes, I agree. I will combine both so that code can be reused.

- Sanjay
> --
> ~Vinod
