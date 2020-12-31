Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89822E7FFB
	for <lists+dmaengine@lfdr.de>; Thu, 31 Dec 2020 13:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLaMp0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Dec 2020 07:45:26 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52080 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbgLaMpZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Dec 2020 07:45:25 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EC3AFC0AB9;
        Thu, 31 Dec 2020 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1609418664; bh=kHrqmVSdMKQDPsZVY07rZXcEi4RKDaByR4o80MrgyGo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=UHzRzRpl/2KCN/G7k64eSestQeVkJEqbhF8cJ4ojCa/xXRilTaIfQbCevTtDV4rhy
         jqpUwRetgg2gKEvgEHKcUO+9ozx6wVVX+MWzPUrDu3kp16NvtPm0eCFIgaFxTurNdd
         YtR95kcmzSb1+Rok5CNa3ulq36J8Gve2G6Ul4MQ+Ey7zJ37sm6av0K8Yh6Dr3IDefP
         P9gMkNUOdAMYV+Jg8TiGUmKbHMBuHaAnK4Z/m61rwRozU72koeALFi54MWT/0L789v
         /Yu775AnaCdA+uCbIWgs0lYoiBscz9LJdId0DjUrTLoHLxAcXNHySyyCvw+hUlDLzs
         NJb3nxS2q+P1A==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3427CA005E;
        Thu, 31 Dec 2020 12:44:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 493C640143;
        Thu, 31 Dec 2020 12:44:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=paltsev@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Htcg2HRH";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbnZmAVR1d/mWjD8xYcU0ddIg/9OoJ8wyJv/zArD5Awtlc8EEPPnhShToH4sS18bri6KrsoO2A0OS7pJScagRJNEDGrIZaQsgYXREnmAnE2m6PCls44JSCE1rlzU3i9R/GOAzQo6IqjbDKxa3kk5pGICHIUpiS1+YuGmQnFB3NdfLyTbuVTonPZCFsIf3IRq1kqVlT+kZlqzIiWJibgDIe0qhijadmyj224Ksmt5ly+rBDCtAGNyly0vFKYc6lvu6cfCvL91s7cKgVICko9tiiOA7Oy+EEqITGTDS9Mmm3w5CvHoYRRh0ICHjP7hBjA1V2PJzc4f7oPPPw7tj7MEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8a1GmdB32FMbTq3mW2peaboL/vFgG/59NVr8bVm4z0=;
 b=COIz9vkVg6DXAPId8tbV0OFcdGhI86XtbEPi9GbKeFGV8T9Ml/v6bR3yrjzK9Tiy5ZWZHYLOeupybkrVSceQH/him4EpoAyNYTuOU1QjJN3PfMU2uRM0y4mI7w3KKdSMs1vRA0LZTWrzulW1w2ADdw38TlcOPjAANdAG1ALZDXltFZRaK/pYTP/CslLo7GSD3+Pw9Ba0OhQVIqcREOnKwrzrHpG/mpVBhxV+l64Jt/2CuuTNpSKNF3bSIjoJgY9TMRE/nfxceYHnC7JRp4rUEClxSJE4KIdzBFcp42/jSoD//yZs0a5KPanJI1mAc9Axj2b4pTX0aFeHm5pva5MB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8a1GmdB32FMbTq3mW2peaboL/vFgG/59NVr8bVm4z0=;
 b=Htcg2HRH4TeFUig3fzrBTEMzzMuiHeUUWNqhC9JG25DLNY8dhjxmX+/s73G5SANyIN8kd3LgQ8dunba1XkYUigT7fk6TIqFVN97ihyHawGlFFb0z16BFRPGMCsrZooZSBeKOVx8kbTUGGpkP8rH548IZO7UkKXauU1R/FVNO+hQ=
Received: from MWHPR1201MB0029.namprd12.prod.outlook.com
 (2603:10b6:301:4d::15) by MWHPR12MB1790.namprd12.prod.outlook.com
 (2603:10b6:300:109::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Thu, 31 Dec
 2020 12:44:19 +0000
Received: from MWHPR1201MB0029.namprd12.prod.outlook.com
 ([fe80::49ab:983f:4056:5dff]) by MWHPR1201MB0029.namprd12.prod.outlook.com
 ([fe80::49ab:983f:4056:5dff%4]) with mapi id 15.20.3700.031; Thu, 31 Dec 2020
 12:44:19 +0000
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Sia Jee Heng <jee.heng.sia@intel.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v8 13/16] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA
 handshake
Thread-Topic: [PATCH v8 13/16] dmaengine: dw-axi-dmac: Add Intel KeemBay
 AxiDMA handshake
Thread-Index: AQHW3aAioccw/TUNekO0DxIVg+IMXqoRJs68
Date:   Thu, 31 Dec 2020 12:44:19 +0000
Message-ID: <MWHPR1201MB00297BC4BB351FA85FE66A12DED60@MWHPR1201MB0029.namprd12.prod.outlook.com>
References: <20201229044713.28464-1-jee.heng.sia@intel.com>,<20201229044713.28464-14-jee.heng.sia@intel.com>
In-Reply-To: <20201229044713.28464-14-jee.heng.sia@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [5.18.204.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07f6b1dd-6bed-43ac-0ef4-08d8ad89ca70
x-ms-traffictypediagnostic: MWHPR12MB1790:
x-microsoft-antispam-prvs: <MWHPR12MB17905ABCC67E5E212E27A7FADED60@MWHPR12MB1790.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UaW05Gi/BvHqnp66ke2sFUtU1rOP3/+AABy6pQqk6wFfgu2LxAFhadhjRUa2EcEPMvvqindZ9N2Ht4xv+9q0kgRINUrlAg7B+ap+HOORqdcGAg5nq7xB8/SM/oYrup+cJLrkH2CbGZnXON+qlmgKkNP89RPkVon1IoqjdcbB+PnKrhHrMtd18T/AQ3go4OJVu9Auj/L00GfU2ZOUnTbJeOhtzOeiSkPbsF7lVKZ9h7H2s3+qI7qw12YNrczrEjk1UtuVH3t9nGxXdEyXFP4coRkOTGMCbhu5UP1sb9qeypeYe8r+y5WZXP9YXpTOZjWgbty0JNF0nzXKy4VGFsVBaOnI6iFf4wzVy5GiwFdS4BaHXqBNiyFOvuHdlQa3kwDy7hUkbIzwmqPhTMUH805xLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0029.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(136003)(39850400004)(478600001)(2906002)(91956017)(66556008)(33656002)(5660300002)(9686003)(6506007)(53546011)(55016002)(66946007)(8676002)(7696005)(66446008)(54906003)(83380400001)(52536014)(86362001)(4326008)(64756008)(186003)(26005)(66476007)(110136005)(316002)(76116006)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?NIkUZcGz1H1VekKwQ8LtyFoBUufvWgVKkoXihxno9bwMYx/fnLhcc4wHxE?=
 =?iso-8859-1?Q?KtpCC/TVKsdXVDmzYa8pyA7GLYQ8kApP3zkK3EcZJWBPfn/0j4svzRE+Nb?=
 =?iso-8859-1?Q?VBEU3EHspHNqAbe2yK3CCrf9XLXMYZZf8pvjdQAZ/8v2i5+b3ddAyYtLX1?=
 =?iso-8859-1?Q?lfpFPwTfwLh3G3o5VHWAQKV3UZPCVkE+4n9JnT1j6ASnOCRclK5qZdYGyc?=
 =?iso-8859-1?Q?5xKMT104DTy9FFwev6+/qZV7Jmbj6ztypfLmx9TRd0KAZ3GhoG6hTxDHcm?=
 =?iso-8859-1?Q?ofjHnaLYwHlMCcCQXPZ/9Oxia1F2CzrjFrOF0f0GGnmQNlOTTnUcujaTBA?=
 =?iso-8859-1?Q?9Tj45GTXO//u4glKxUCqBc2mJy0k7QL5NFtoq6pSAx4WyxNxNL08bWJL5c?=
 =?iso-8859-1?Q?C3yTq2skTyD1FDIk/x/vVp8wgAqQG0oVNOchICL6u4xiETWxmxbrixUQYu?=
 =?iso-8859-1?Q?3LAkw0BkpUrVGdb3c6WTH6pboJaWzZREw1+CtWO9kz8map3cS7JksPpqMu?=
 =?iso-8859-1?Q?N2lwuM80l23vKgqtkNw2HkFL7KVVSo0VGDALB2UUkn6SHQLrwVjLzVSG9a?=
 =?iso-8859-1?Q?xsWWmHAoYjJxW58AmIOTR0d+t1ZE2OE0IJcAudGYD1h2UMyQ6eLXoVDAV7?=
 =?iso-8859-1?Q?4NYdxjHw3QZY8RhKgWG9Q8/XUObEeCQJzAu32s3jdunD86Eni3p7vLY+5w?=
 =?iso-8859-1?Q?FoEK/LShtrlL1iAKi9LXW+kvO+hf5LJonZxcqECPdZbjLP+7oTvOtNxOlh?=
 =?iso-8859-1?Q?Gf+sjc12D1uf5Wio7B4WZ8/IbEaIB4KeLdiB3Tsw4RzGapo8fAsugW8Sbd?=
 =?iso-8859-1?Q?pztI6iPRM/JPeAIMTtKAFsVVvG8vEYnAM/6GYWWvBp0sX6Kemf8YVJTJgO?=
 =?iso-8859-1?Q?GEbUIM9Hk6zTcgcAZuQw47FEnoVi6T3HPe3wNXall2eVbVArfyMMitBOwU?=
 =?iso-8859-1?Q?FtpikJElwI1xZ6XICAb4NSqMSDXayu89gwY+31vc3WQQbiPMQEP40dE7U2?=
 =?iso-8859-1?Q?9EnipDPXDV7974pIw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0029.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f6b1dd-6bed-43ac-0ef4-08d8ad89ca70
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2020 12:44:19.0671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OeghajUwydaEKc2sITttxK+NcWiJGKUyiUPYyiwMCgJ2dpMrbIcbxrUtYswx+CB/L+jyJOMuz7FFLAtK2e7tZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1790
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sia Jee Heng,=0A=
=0A=
see my comments inlined:=0A=
=0A=
> From: Sia Jee Heng <jee.heng.sia@intel.com>=0A=
> Sent: Tuesday, December 29, 2020 07:47=0A=
> To: vkoul@kernel.org; Eugeniy Paltsev; robh+dt@kernel.org=0A=
> Cc: andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org; linux-k=
ernel@vger.kernel.org; devicetree@vger.kernel.org=0A=
> Subject: [PATCH v8 13/16] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDM=
A handshake=0A=
> =0A=
> Add support for Intel KeemBay AxiDMA device handshake programming.=0A=
> Device handshake number passed in to the AxiDMA shall be written to=0A=
> the Intel KeemBay AxiDMA hardware handshake registers before DMA=0A=
> operations are started.=0A=
> =0A=
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0A=
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>=0A=
> ---=0A=
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 52 +++++++++++++++++++=
=0A=
>  1 file changed, 52 insertions(+)=0A=
> =0A=
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma=
/dw-axi-dmac/dw-axi-dmac-platform.c=0A=
> index 062d27c61983..5e77eb3d040f 100644=0A=
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c=0A=
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c=0A=
 [snip]=0A=
> +=0A=
> +       return 0;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * If DW_axi_dmac sees CHx_CTL.ShadowReg_Or_LLI_Last bit of the fetched =
LLI=0A=
>   * as 1, it understands that the current block is the final block in the=
=0A=
> @@ -626,6 +668,9 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, d=
ma_addr_t dma_addr,=0A=
>                 llp =3D hw_desc->llp;=0A=
>         } while (num_periods);=0A=
> =0A=
> +       if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num,=
 true))=0A=
> +               goto err_desc_get;=0A=
> +=0A=
=0A=
In this implementation 'dw_axi_dma_chan_prep_cyclic' callback will fail if=
=0A=
we don't have APB registers which are only specific for KeemBay.=0A=
Looking for the code of 'dw_axi_dma_chan_prep_cyclic' I don't see the reaso=
n=0A=
why it shouldn't work for vanila DW AXI DMAC without this extension. So, co=
uld=0A=
you please change this so we wouldn't reject dw_axi_dma_chan_prep_cyclic in=
 case=0A=
of APB registers are missed.=0A=
=0A=
>         return vchan_tx_prep(&chan->vc, &desc->vd, flags);=0A=
> =0A=
>  err_desc_get:=0A=
> @@ -684,6 +729,9 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan,=
 struct scatterlist *sgl,=0A=
>                 llp =3D hw_desc->llp;=0A=
>         } while (sg_len);=0A=
> =0A=
> +       if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num,=
 true))=0A=
> +               goto err_desc_get;=0A=
> +=0A=
=0A=
Same here.=0A=
=0A=
=0A=
>         return vchan_tx_prep(&chan->vc, &desc->vd, flags);=0A=
> =0A=
>  err_desc_get:=0A=
> @@ -959,6 +1007,10 @@ static int dma_chan_terminate_all(struct dma_chan *=
dchan)=0A=
>                 dev_warn(dchan2dev(dchan),=0A=
>                          "%s failed to stop\n", axi_chan_name(chan));=0A=
> =0A=
> +       if (chan->direction !=3D DMA_MEM_TO_MEM)=0A=
> +               dw_axi_dma_set_hw_channel(chan->chip,=0A=
> +                                         chan->hw_handshake_num, false);=
=0A=
> +=0A=
>         spin_lock_irqsave(&chan->vc.lock, flags);=0A=
> =0A=
>         vchan_get_all_descriptors(&chan->vc, &head);=0A=
> --=0A=
> 2.18.0=0A=
> =
