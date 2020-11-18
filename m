Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3572B88DB
	for <lists+dmaengine@lfdr.de>; Thu, 19 Nov 2020 00:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgKRX7T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 18:59:19 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:57438 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726944AbgKRX7T (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Nov 2020 18:59:19 -0500
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5CA104017E;
        Wed, 18 Nov 2020 23:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605743958; bh=FIfMftxCfbYM63d/qgCWOWG1s0gYhsZEalQ3FD51Nwc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VVbk5q0Rt3DVcpsQUNinVgEp2X8y9nb/F6unLK16L6vdAEnOKjo6xIj1UPupH5kpb
         BKy8xW6Q7tEuGUqpGLIp5l2Nlx2kIGpl3yg/2D0pIPhVeyuEp87RCt1Cvs958wVBAl
         GTY2DYd/USENaKFnIno2aGOmH09Yd89HffeVn/8VGSWSekzsZgM2digh7KUegdB9P7
         Mxaf+CGgguB1+2EW+blxXwVqp2ngm1VUPno693v4+pXwuEbMkOxLkW7RfoQveCr9zU
         SZ43aRa2YoQzAtl3IIjHng93F7BCkSKKUYNBSttk6HuZ0xIiKz/Ph8G1RE4lK2szFX
         If99ajgVDrDZQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4089EA0090;
        Wed, 18 Nov 2020 23:59:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B7422801DE;
        Wed, 18 Nov 2020 23:59:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=paltsev@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="DshrkhYN";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIUn2FRLMpVTGpfcHC3/ai4ApbTp/0kaaRadQAYugxD/bFSD0owyKRyWz1VrGn+NNhPi8DtMEwPIi1SKx21LHtVgAXqoTSKyfRi/xaN118NLIiFb0yxcSum+cy9h9oSDSGouXbM/+Gw7Dbl+WVGkNJwhHTV1a44f8NN534h88VROu2TlLIXU6RYcixRJfimwWLz4iVx6b52gn3xDRa/U+WU3SSl2OMs0qD/nZLMflEzMZ5fc9Ob6g5dWt2TCaz8Hfxhe/Rx8VzqbTUBAWb5ZMpEl5rO3DZG313Xeli2UPwtv7sYk7hqc2AVm8CdADHbB64ziuDtcGWbJLYmxJV1aIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHHT9TfbDE2Eka8j15k/gD5+vjAEdb41MUHgTcPePqs=;
 b=OVopKUinLtpqrRCwtQHWo4EkGcum/08Wi9aq1mJ0LFVOw+R5X8a+vBqecpCItT3QLkOVHnH90v+XzfTsn81MrW5FiPeJKuMsMfpj6bVU5gek2D7xjbE+OpBhppr8bvQfpIPB5RQjagYajjMqTebemg9hwWj5hDlHB4HnzVLNqSJK7QssNpOE9LBA3AJnidPvqDOmArkCDg9DUulUrvmqJn1gK1q5xdeoXlVM+H0so+dZvs9Stk8MHapNWv7v7dOFVJlKQh5VX6O0xdiwfWlvEFJBeQ0lJdOGLgzzbslaX9ydBCy7THxM3/hrq4ejUvH5Yn3tHeORP70dENEGwwNgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHHT9TfbDE2Eka8j15k/gD5+vjAEdb41MUHgTcPePqs=;
 b=DshrkhYN3nfaTZVB+AWMWbYtj0a0Oin2eGK9cyudjnILFhsf7aqBXeTKY1kwp0GMf6U4WhrmJ4/MQmb/c52inNjP+vGYG1TIrqDF5EyxACt3HGRNye8gwyAmtnKp30nNhh9DoK6UVqdxGINY7MQk9s9HAcHwn1xpk19/1X2ORr8=
Received: from MWHPR1201MB0029.namprd12.prod.outlook.com
 (2603:10b6:301:4d::15) by MWHPR12MB1520.namprd12.prod.outlook.com
 (2603:10b6:301:f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 23:59:11 +0000
Received: from MWHPR1201MB0029.namprd12.prod.outlook.com
 ([fe80::49ab:983f:4056:5dff]) by MWHPR1201MB0029.namprd12.prod.outlook.com
 ([fe80::49ab:983f:4056:5dff%4]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 23:59:11 +0000
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 13/15] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA
 handshake
Thread-Topic: [PATCH v4 13/15] dmaengine: dw-axi-dmac: Add Intel KeemBay
 AxiDMA handshake
Thread-Index: AQHWvIranRliWUyoiUC041c/U0Xoy6nOkjKO
Date:   Wed, 18 Nov 2020 23:59:11 +0000
Message-ID: <MWHPR1201MB0029177B655D2B57D636CAB0DEE10@MWHPR1201MB0029.namprd12.prod.outlook.com>
References: <20201117022215.2461-1-jee.heng.sia@intel.com>,<20201117022215.2461-14-jee.heng.sia@intel.com>
In-Reply-To: <20201117022215.2461-14-jee.heng.sia@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [5.18.244.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c542f45c-f407-4cd5-3104-08d88c1df22c
x-ms-traffictypediagnostic: MWHPR12MB1520:
x-microsoft-antispam-prvs: <MWHPR12MB1520F51F1B14E1955F56071FDEE10@MWHPR12MB1520.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OlU7IdE65pH0y4seg3jmE6WzS/VFtTgrbuPCEauag12ZLXo6Da3G2h8f6Pfc+0oFW+wu6HvE79DNrcUVY1tlvx7gBybenlXJl1dg6/EC6q+nnCY6ZGjz2sU/fFcyVTfLkaUGEDBKC1Nwg8yAgnl3PvXAyHYWWc4XmJAO/TVy6qBa3JdGGZa07eJ2mRRhGwbeIP0+LLlq9SFBlPrJT0xN1Mk9rx1t19hZMf/SmU6zu1ziE3Wwi/Ci7IGc2eBqY8d7hF7N8Lemr1UGz1cBCz9+t8KCWrgPwr/QLgIC44OucKhtMnrd2z/pYbVDtkz4+P873xXxwD/LULfItlPs/dqWYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0029.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(64756008)(66556008)(71200400001)(91956017)(8936002)(66946007)(33656002)(76116006)(52536014)(66476007)(8676002)(26005)(86362001)(4326008)(2906002)(66446008)(478600001)(186003)(6916009)(83380400001)(6506007)(54906003)(55016002)(9686003)(316002)(5660300002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0IRH+6WwMDZiwrAzjzsRrSfXkMNAurvhD0DhBXMiteO01pnuVKk7SVcXsFjda91qNcJ4lRFjDxHMG8cABey72WUWVy2bvnDre5p8OtM8PEkBTqaZLrXKX0vH9ALpuUJvolVAeV7V/j+r9m2zBcwnCwzIOHw7zA5wh4HnPyovsEIEHHSY3cPPKkL83kiW6piWv8yraRWEKYC6BW2TL1r0S6Varwg9TkHvQIvFtVu89Uxm+/7hiwkUjemDVSp+36eSyfSqk1WXmH3+sx8lQJTSpe1mQOpz8/N3NAGdLFNUfAVyrNh24QxOQ9FuC3OdXEzGOpAWaW+hcrYCuyiMMdHrhOy61hjIFO23sG4FgDSydklfcZm+7DEMnfCvz5Bb5Q9nD4qkAuLZireGJRWqCvmHV1BoOpzjFoOhUCsbwCnG9QhpjEKM9W9DdSahxCtXIP3Fhqj1wdqVtJFSlaHcOO9CF10fyDMaD6XHoPm1NI86Z+6C34CcNo+m0fV0zXYL60RdVv7qI8Twnst1nU0k4Kdn7rrGrH8U2yqn/1NdHU1jGbbumR0Bu8otYXRKy7XdKNp+fwidc6D/Af68YaixUPJ9jqI/7xjolohqMUA72VDbtBJ/paV2PmKna+k1VGqltGaYkI3mdlK54h24QDvDqXPlggJ/HxiiOcxzH99SSzyBl8JvqgExbT4wtEvtU9rQUAXhVuxo1z47NRk3khTiV0DwKM/RIhgTEaaDj+ceNEQpZ3np5nkVtqr7FQWjPZ74NQkRPPXpN+kvJG1Qqyis82y7o2iEU5krdNpxqcAojYcw3oczB4fXRLwZTxEyg5b0tRNA4WIm5nNvEPIGMXZnaSw/ZrJYOsKaplkEo8S4EabzhW/yQiuRUB272Uxo1qjTMydOD0Gx0AWUNRrnbgIkXPXpgw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0029.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c542f45c-f407-4cd5-3104-08d88c1df22c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 23:59:11.5638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2H5UtVZVqmIK/As8hgjBPaGbqmbelNrhsVoSDw3gYZ2fP4UV7J+v8DufqSmhMG/mzfzdr6+Gfxn4qOB167Fi3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1520
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sia,=0A=
=0A=
> Subject: [PATCH v4 13/15] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDM=
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
> index c2ffc5d44b6e..d44a5c9eb9c1 100644=0A=
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c=0A=
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c=0A=
> @@ -445,6 +445,48 @@ static void dma_chan_free_chan_resources(struct dma_=
chan *dchan)=0A=
>         pm_runtime_put(chan->chip->dev);=0A=
>  }=0A=
> =0A=
> +static int dw_axi_dma_set_hw_channel(struct axi_dma_chip *chip, u32 hs_n=
umber,=0A=
> +                                    bool set)=0A=
> +{=0A=
> +       unsigned long start =3D 0;=0A=
> +       unsigned long reg_value;=0A=
> +       unsigned long reg_mask;=0A=
> +       unsigned long reg_set;=0A=
> +       unsigned long mask;=0A=
> +       unsigned long val;=0A=
> +=0A=
> +       if (!chip->apb_regs)=0A=
> +               return -ENODEV;=0A=
=0A=
In some places you check for this region existence using =0A=
if (IS_ERR(chip->regs))=0A=
and in other places you use=0A=
if (!chip->apb_regs)=0A=
=0A=
I guess it isn't correct. NOTE that this comment valid for other patches as=
 well.=0A=
=0A=
> +=0A=
> +       /*=0A=
> +        * An unused DMA channel has a default value of 0x3F.=0A=
> +        * Lock the DMA channel by assign a handshake number to the chann=
el.=0A=
> +        * Unlock the DMA channel by assign 0x3F to the channel.=0A=
> +        */=0A=
> +       if (set) {=0A=
> +               reg_set =3D UNUSED_CHANNEL;=0A=
> +               val =3D hs_number;=0A=
> +       } else {=0A=
> +               reg_set =3D hs_number;=0A=
> +               val =3D UNUSED_CHANNEL;=0A=
> +       }=0A=
> +=0A=
> +       reg_value =3D lo_hi_readq(chip->apb_regs + DMAC_APB_HW_HS_SEL_0);=
=0A=
> +=0A=
> +       for_each_set_clump8(start, reg_mask, &reg_value, 64) {=0A=
> +               if (reg_mask =3D=3D reg_set) {=0A=
> +                       mask =3D GENMASK_ULL(start + 7, start);=0A=
> +                       reg_value &=3D ~mask;=0A=
> +                       reg_value |=3D rol64(val, start);=0A=
> +                       lo_hi_writeq(reg_value,=0A=
> +                                    chip->apb_regs + DMAC_APB_HW_HS_SEL_=
0);=0A=
> +                       break;=0A=
> +               }=0A=
> +       }=0A=
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
> +       if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_hs_num, true))=
=0A=
> +               goto err_desc_get;=0A=
> +=0A=
>         return vchan_tx_prep(&chan->vc, &desc->vd, flags);=0A=
> =0A=
>  err_desc_get:=0A=
> @@ -684,6 +729,9 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan,=
 struct scatterlist *sgl,=0A=
>                 llp =3D hw_desc->llp;=0A=
>         } while (sg_len);=0A=
> =0A=
> +       if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_hs_num, true))=
=0A=
> +               goto err_desc_get;=0A=
> +=0A=
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
> +                                         chan->hw_hs_num, false);=0A=
> +=0A=
>         spin_lock_irqsave(&chan->vc.lock, flags);=0A=
> =0A=
>         vchan_get_all_descriptors(&chan->vc, &head);=0A=
> --=0A=
> 2.18.0=0A=
> =
