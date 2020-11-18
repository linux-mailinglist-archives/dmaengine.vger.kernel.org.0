Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FAA2B88D9
	for <lists+dmaengine@lfdr.de>; Thu, 19 Nov 2020 00:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgKRX60 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 18:58:26 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42216 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgKRX60 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Nov 2020 18:58:26 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A3619C00BF;
        Wed, 18 Nov 2020 23:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605743904; bh=xMtfUUXrs8OTPhltxhQVTQtJPCNyZrhwHqCAXHSeuiY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cxV02Tu4j7d8topJ8TWwLNDjMo6Uqn//xWK4DnigkEyrcLCXPHjgzHE1ta8vR3LbD
         rBmimWP3rF8Su0e023MP9aCEsLTBzmIxYZ4Bu9SdDISiCpPLH4WWXxRzby15YdM+AP
         NrQQEtESVZ5yTneVcMr6jduJ74r8daxPiE61LbE7YbuX+jdBRsuXQmYJaVshho0PFy
         e3YVxe5f8OjAZFpY5/AjJ2hBIBET0+28I0U4F9Cw6j0eKTTUSpHdBKmwbgijNzT3mm
         CfLbAZt6Dpc2t6mKoFesJPktWT3V4RzUbLRXSvrIC0CUzbrIIBszlB04q/d0ptz6TO
         dP/PUE21u8atQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5B404A006E;
        Wed, 18 Nov 2020 23:58:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A9B1E812F1;
        Wed, 18 Nov 2020 23:58:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=paltsev@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="k+l3eyH8";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDs8SKmkJ5IeVJeGuwndJpGZ41pbFjp2kBA8EmQ8U8NNJhUUBcdYSmjXEkWtZOb43IePcZMO9aLdXWqOvM6nANQPT1Ai08j/5FrbMmnKU6IguoVkOMCJZdKY2vsYn9MRRYlrLrHvADU5iXZEYxf0LbETNpboxNjkX0Jcrg7lGmH/bQ67FodibBTadBFwH3D3vkzRZJOceroIMFb3ndexQ6qG8n0xYNR5ORdodOYmsRu1btXL4bU5awPYvMrH3cB6a63jPjf7OQr1CiS8o4gOxtOdZaJLZ7wLnpl4e/JS9GITg/Gajj15EceCHfBpo6Lfk/FLvaSWaOHVmdBVA/3m6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u4PnsOFzp3JBTzebDZjVnJlNjexoQveheu42tq3Zy8=;
 b=PLOw/MvZSyKE07lwfBLBk+BFYigWvFHdejpVfYrxlthvJE/MHywEgmMYoKpH4eot3LmRXXlkAO6P6TVdAReNPNG2lmltNW6xEYdkVADD/kuWsRPdYnp+hOQh/d04PElZvDiW3wHBfqWSaao3yW5u9n0NnyKOksrChOZyAGQaSUpyy2ihoubMf+hUT9zeaAhLCVwAscY5AohrBXoZaEEhPTKnVycMpT8ZTUqY2vyh9E6iFqL69uskULs1YukqUb0dUI3pEraouVnytc2mHlkAH9LaeXSWrlaxjvGxFlhH2ZHLkHsskou/bHBm8U8SgjcTejPR7cXPKnsyg7ia23uh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u4PnsOFzp3JBTzebDZjVnJlNjexoQveheu42tq3Zy8=;
 b=k+l3eyH8r45Dx3GfTQ9G6eqBKH8xXaNrViMqgV2AOn0uzcqmO1ntSThqUaOJHm93xPP8F6Ebj8Ak0/+Wb6Bn/K87c/oCvynVi7BOCXUoVwQ0D5BssLZUghRrhDsn4NjPILZIXzF+rgg94QdJ88jDYDwapHqyuArVpsf+Enxuu0A=
Received: from MWHPR1201MB0029.namprd12.prod.outlook.com
 (2603:10b6:301:4d::15) by MWHPR12MB1310.namprd12.prod.outlook.com
 (2603:10b6:300:a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Wed, 18 Nov
 2020 23:58:19 +0000
Received: from MWHPR1201MB0029.namprd12.prod.outlook.com
 ([fe80::49ab:983f:4056:5dff]) by MWHPR1201MB0029.namprd12.prod.outlook.com
 ([fe80::49ab:983f:4056:5dff%4]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 23:58:19 +0000
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v4 11/15] dmaengine: dw-axi-dmac: Add Intel KeemBay DMA
 register fields
Thread-Topic: [PATCH v4 11/15] dmaengine: dw-axi-dmac: Add Intel KeemBay DMA
 register fields
Thread-Index: AQHWvIrXLAM1xxfy7U+r4CcYlOAdA6nOkDDR
Date:   Wed, 18 Nov 2020 23:58:19 +0000
Message-ID: <MWHPR1201MB0029278F2808FB55CEB8B3D5DEE10@MWHPR1201MB0029.namprd12.prod.outlook.com>
References: <20201117022215.2461-1-jee.heng.sia@intel.com>,<20201117022215.2461-12-jee.heng.sia@intel.com>
In-Reply-To: <20201117022215.2461-12-jee.heng.sia@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [5.18.244.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25b57cc9-2a03-49a3-e9b3-08d88c1dd31e
x-ms-traffictypediagnostic: MWHPR12MB1310:
x-microsoft-antispam-prvs: <MWHPR12MB131067C77F7EE204A45EA0A6DEE10@MWHPR12MB1310.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6qW2D2RUAPlVpBRflsH2afEVhxON1CaWaleijMo0HBEiBHBz9DwuwaXrcTeEqMIwzEZfPbnp7YXg0/rG8dJK/G7bn93RSX2CKL10CMAIDVETuKqmgmATGRcBSxJO5cHzjjqq8zywYdrDydTxMn7IVXq72Z0R5gph9DwXAq2XAqWF0EQNvlv/VWBJDF4m0h5RFAgeEQpQm7T8J80zRhMKRzoh3sGQVvlws1uwS5atxZSQreF04CTRO/QGQczgbF6OgEIIEbhRucoXtmlaLhtgVkHIrzjJ8Q2dc1aSTavTwcdRyZ6JDl+Sl6sh6KRjy4PPU9DHWuogXQkJYM8sh4D/9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0029.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(8676002)(54906003)(66556008)(66476007)(64756008)(66446008)(66946007)(316002)(33656002)(478600001)(7696005)(9686003)(71200400001)(5660300002)(55016002)(83380400001)(91956017)(4326008)(76116006)(6506007)(2906002)(8936002)(6916009)(52536014)(186003)(26005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bNQSeGQZ0xYuUxMqJjz5FMQNQOR6HN8WNVbo0KtuW6MnnZH0rqXIMLLUAHRM9ZR8ZU8ZE1hygsAcufDwX2SRhrQyad7UGPBBkP0c2QF84va64RM+Ezi8OtzUpykHspa3B50Iw5WQXVixBYhdy1vvECLvm6wSLcmXf8UytM6jEB/it9znQ/20lAWU+aNgYnnAS29+0RmgXSfsnVuu1ePBWPuZXs/oUzS6BzuXql2Y1SkesMDkCtkCUy22lPPp8VL95EkTPrI1Cq4soK1Km8XInbEUS5+u6susF0kMztqZxsgqHqEQ8yiel2YfaXOSR02HeLlZSEPdjUqUtjnM+laZH5eX7nZQi4Y83wyLQ1jnomBOiladPU1KZHoUCEM8YvaTZ8tZhUoasmewV2pPtA6JktYFkEM9+3mT+0Mc5Xy/NUbcZFrP5+YXYLDepYIb7ZoLzekLDy97BPsfHagSapDqD8sJPe7MJgqBq9I+ekDYjKAsg4M3/2dXt/00Zpbmp6NDRhPtBFnRNDPsqXs2prq575RnLpsalLz8/N56D2Su+dZG6946eDhGZhKLiTCRMXxW0a+cItoLCDvtWnLscTC9pf1fOz1K9sNy1ium732E2KuJj2wiQo0ODnI3GiL9FDr8/w3J7VaULG3yiWr5uREG/rip0/4hjLSK5xe5V1QWN3OfejnZWaOXqZVGteryNudYmoRtD7SWJKfR+QKBiaDLDsG/gV2qPOfBnuZOI5/zL9B3Be8ZDZ7/Hw/dOu4jdTWu/+md66MeZB8S5CG2aVKuJcG0BBvPpYvHCKqwSwuM6WgGE8pFZETp2FIORsDry62WCaAElmXw+0WzvAWD6Do+csgaN08cDyomVE3jPKdSKe39YTgw24EJuxwO3b9syQaHl3mHv/1lvnx7FnK7k1aysw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0029.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b57cc9-2a03-49a3-e9b3-08d88c1dd31e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 23:58:19.4395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qX3dI7V2vfkVjXwjzhRtYKz2BOOjCbsnRwbXiBQWGzBdToNGgMF8xza1S+LgMXt4sAzpwY8Cra1yI/y0vhTbmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1310
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sia,=0A=
=0A=
> Subject: [PATCH v4 11/15] dmaengine: dw-axi-dmac: Add Intel KeemBay DMA r=
egister fields=0A=
> =0A=
> Add support for Intel KeemBay DMA registers. These registers are required=
=0A=
> to run data transfer between device to memory and memory to device on Int=
el=0A=
> KeemBay SoC.=0A=
> =0A=
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0A=
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>=0A=
> ---=0A=
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  4 ++++=0A=
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 14 ++++++++++++++=0A=
>  2 files changed, 18 insertions(+)=0A=
> =0A=
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma=
/dw-axi-dmac/dw-axi-dmac-platform.c=0A=
> index 7c97b58206bf..9f7f908b89d8 100644=0A=
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c=0A=
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c=0A=
> @@ -1192,6 +1192,10 @@ static int dw_probe(struct platform_device *pdev)=
=0A=
>         if (IS_ERR(chip->regs))=0A=
>                 return PTR_ERR(chip->regs);=0A=
> =0A=
> +       chip->apb_regs =3D devm_platform_ioremap_resource(pdev, 1);=0A=
> +       if (IS_ERR(chip->apb_regs))=0A=
> +               dev_warn(&pdev->dev, "apb_regs not supported\n");=0A=
=0A=
There shouldn't be warning in case of compatible =3D "snps,axi-dma-1.01a" a=
nd=0A=
apb_regs missing. Could you please try to do ioremap for this region only i=
n=0A=
case of intel,kmb-axi-dma?=0A=
=0A=
> +=0A=
>         chip->core_clk =3D devm_clk_get(chip->dev, "core-clk");=0A=
>         if (IS_ERR(chip->core_clk))=0A=
>                 return PTR_ERR(chip->core_clk);=0A=
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-d=
mac/dw-axi-dmac.h=0A=
> index bdb66d775125..f64e8d33b127 100644=0A=
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h=0A=
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h=0A=
> @@ -63,6 +63,7 @@ struct axi_dma_chip {=0A=
>         struct device           *dev;=0A=
>         int                     irq;=0A=
>         void __iomem            *regs;=0A=
> +       void __iomem            *apb_regs;=0A=
>         struct clk              *core_clk;=0A=
>         struct clk              *cfgr_clk;=0A=
>         struct dw_axi_dma       *dw;=0A=
> @@ -169,6 +170,19 @@ static inline struct axi_dma_chan *dchan_to_axi_dma_=
chan(struct dma_chan *dchan)=0A=
>  #define CH_INTSIGNAL_ENA       0x090 /* R/W Chan Interrupt Signal Enable=
 */=0A=
>  #define CH_INTCLEAR            0x098 /* W Chan Interrupt Clear */=0A=
> =0A=
> +/* Apb slave registers */=0A=
Could you please add the comment that all this registers exist only in case=
 of=0A=
intel,kmb-axi-dma extension?=0A=
=0A=
> +#define DMAC_APB_CFG           0x000 /* DMAC Apb Configuration Register =
*/=0A=
> +#define DMAC_APB_STAT          0x004 /* DMAC Apb Status Register */=0A=
> +#define DMAC_APB_DEBUG_STAT_0  0x008 /* DMAC Apb Debug Status Register 0=
 */=0A=
> +#define DMAC_APB_DEBUG_STAT_1  0x00C /* DMAC Apb Debug Status Register 1=
 */=0A=
> +#define DMAC_APB_HW_HS_SEL_0   0x010 /* DMAC Apb HW HS register 0 */=0A=
> +#define DMAC_APB_HW_HS_SEL_1   0x014 /* DMAC Apb HW HS register 1 */=0A=
> +#define DMAC_APB_LPI           0x018 /* DMAC Apb Low Power Interface Reg=
 */=0A=
> +#define DMAC_APB_BYTE_WR_CH_EN 0x01C /* DMAC Apb Byte Write Enable */=0A=
> +#define DMAC_APB_HALFWORD_WR_CH_EN     0x020 /* DMAC Halfword write enab=
les */=0A=
> +=0A=
> +#define UNUSED_CHANNEL         0x3F /* Set unused DMA channel to 0x3F */=
=0A=
> +#define MAX_BLOCK_SIZE         0x1000 /* 1024 blocks * 4 bytes data widt=
h */=0A=
> =0A=
>  /* DMAC_CFG */=0A=
>  #define DMAC_EN_POS                    0=0A=
> --=0A=
> 2.18.0=0A=
> =
