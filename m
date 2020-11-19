Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778E32B88E9
	for <lists+dmaengine@lfdr.de>; Thu, 19 Nov 2020 01:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgKSAKJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 19:10:09 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42578 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbgKSAKJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Nov 2020 19:10:09 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0BFBCC00BF;
        Thu, 19 Nov 2020 00:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605744608; bh=7SwnremCyeS02Tf+2pnPC/iklJ8V8hmb2WDqiC/lEhE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MJ+7cF6KiD7tO+Rp5ztw69ybaSJTindU1Qb7VsYtwdy3evicYBtzkYFBWN/VtSCZt
         cE/52z5It1g/3hdPVLBqziX3Urv0kPaznXoN85OXsmJHGMWBzjjRNYBDmyRRQqAUcn
         Dk4Y6taOw+TNkKY0pGrx2l9WgQaVJlkDIoqwvw6es7cNLbucI/gFn21Jqft/+SDXpb
         IP1Ze9tXueCnQOhCfl4gROEMArSMYoPl5Qh6m76w6tUKeSeH6MtRQhAFutEXKK2kn2
         Uj+ggToSca5O3rDMw27jz0q7OCM4xepjhvp7yXZONU5saHY5EI6xv+MnX4uNN3X6fI
         A7Hz9ULdXJl8g==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6188DA0096;
        Thu, 19 Nov 2020 00:10:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 00346400DA;
        Thu, 19 Nov 2020 00:10:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=paltsev@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="SSydU24D";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lh0AA7tu0sybSprYZEmTELOHEStV+5IxvfG9lZf8TGDNLV9aPzvSE3DoxXYdFunLBiyptr/BdFmqQcd2Rm40cBVeWWe7G4hxmvRgMQI+j0/Izi1ukF0CtYKv17Yp5Q58FKMJxbJ9miqVgmrtxqN9l9NVYRpZ7nm0/cVU0+RIdtoGkuSH7ovoGnYDkgU6L3RFPRrFzeSETOo22okUX3CGeWJ+DXbOx81iaGhl//s61gJqdyoCWRjqGVPBZ0wyIx9Ih6vvOCtFEXIjIjmZgT4QXNlgHp4TRx53tOy1mqmgtzm6jjAC8mgyqHDqxXm3C0NgAVkme/zDIISM977SW5by+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFsFBCRna1kdbKuDIVhVie2cZhAPQU7cPbUFANnUftk=;
 b=NAu/wgU0wOdSG99orBBG2BPzG0GfaESrrSw9QGaz3AxxUSo155cs+eTVmRYizKxo6Za5VhZkqVPe0kXwyw6FnXXzScIs/UriaJkTTv655Dx10RBxI0Tr7s2KXaMtXG1sO7VFYegDnho1q/Y+z4/oJQeprMYm9rmYzX3CLk9g20blkojfBxMMEugSQDpJzPhyAdCSnVh+98sGXLXy7fOzx9YBCyS9lUN5vr+3jI9KDt/5NUO7gyVQ0mpGWiImnqfcLG7e/7s6vsmhVBt8JwSM8OQseeVr74ZUu+/NaZgnEDgwcYn+DJG6jmSHym28XLN7iECdU4lPNc98F4k9/z0JbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFsFBCRna1kdbKuDIVhVie2cZhAPQU7cPbUFANnUftk=;
 b=SSydU24DdoHNYALOU8OgPSxH7TFLDvqtJrwPV2niEDWxr9eRbHpnsjjbKWuob3m/Pl+wLewgbqjLZv5m9LNCQAC+C70wvZSIHGZVwHqS8O+34Zfj9qZ0JQksxSNR4f/jfVzBvKMKXa5p+4OUfrT6wy1Ge4R67vbio7Bv3OPlgwA=
Received: from MWHPR1201MB0029.namprd12.prod.outlook.com
 (2603:10b6:301:4d::15) by MWHPR1201MB0096.namprd12.prod.outlook.com
 (2603:10b6:301:55::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 19 Nov
 2020 00:10:05 +0000
Received: from MWHPR1201MB0029.namprd12.prod.outlook.com
 ([fe80::49ab:983f:4056:5dff]) by MWHPR1201MB0029.namprd12.prod.outlook.com
 ([fe80::49ab:983f:4056:5dff%4]) with mapi id 15.20.3564.028; Thu, 19 Nov 2020
 00:10:05 +0000
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Sia Jee Heng <jee.heng.sia@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 08/15] dmaengine: dw-axi-dmac: Support
 of_dma_controller_register()
Thread-Topic: [PATCH v4 08/15] dmaengine: dw-axi-dmac: Support
 of_dma_controller_register()
Thread-Index: AQHWvIrRlLHF5Erm206fp1n916gn4qnOlqqn
Date:   Thu, 19 Nov 2020 00:10:05 +0000
Message-ID: <MWHPR1201MB0029DC5ED96606C7C3FDDF03DEE00@MWHPR1201MB0029.namprd12.prod.outlook.com>
References: <20201117022215.2461-1-jee.heng.sia@intel.com>,<20201117022215.2461-9-jee.heng.sia@intel.com>
In-Reply-To: <20201117022215.2461-9-jee.heng.sia@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [5.18.244.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8f31ffa-cb75-47f7-ecfb-08d88c1f77e4
x-ms-traffictypediagnostic: MWHPR1201MB0096:
x-microsoft-antispam-prvs: <MWHPR1201MB0096AB56B726CF821B142185DEE00@MWHPR1201MB0096.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 96gKwnQYRAjEK/Lq42yZ0F6MgTUK3x2Ossh0vztv+CPnfggeOX0urmD4MoWhKYCpuXJSUmosSzvKttCgT14QQH8XIpGfc3Z30uov98dK3w325iqspKHzN4n2ZgrJEQA6ofCaRxX6NzdHI4UsNmMUX+1y7lA9A11Fen7sh8b5O+/i5oFWPdqjVJ6iqAi5+2WKvjK9PYnu3jzdaazfJQb7qsSk9Dwp+XZ67KPz/9n6fAySKNoqZxHvnMgUm8+aK2urBgqcymdlMhRDxWbRAwj+l6KcLQOaw52tm948Nkhnu2jSs3wgrU5Ew3ayruEiyu6bvSr7txv7kju9Bqr5Hzw4SA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0029.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(26005)(8676002)(66556008)(91956017)(110136005)(76116006)(66946007)(33656002)(8936002)(186003)(2906002)(64756008)(4326008)(66446008)(54906003)(6506007)(5660300002)(478600001)(86362001)(9686003)(66476007)(7696005)(71200400001)(55016002)(316002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZrEH6QsHmwZ4GYE7FgWLRIXXxZGETnYBkJf8fiHQum4oRIXoBoH4FtQc9eNMkwd7+JK8OkB8l3lcwvoN+txcyNjxBaNGyKsEonjYxDFYS1SwQgZbCgIUIN08z/gkwZ61BQqUFn7bPYafsxM/hwLLjjJEk3rx3sVZTzpHM4D3EHWazEWgZVAa75PYMKxHqoLlYVwI3Kwz2bV/ULKknQPMVUYdZmeUy05DrJcKqwNXycxAOGRuQpi0n/8y3aC70cBYhxUDPxLMUrRDNCMeETwsp6hq7THfZX0XTXEMLZxM0ZVDMdumFdIuhOjbSAxHac+DvpuHzbOhRMoJ3yxMuHANz5CiNNsNyZw83jDwYVgLk2OmPFAT5/HcKgQnjJ9/BftUVo3/SiwiAJQ6ILEVLHE4S3iCJeeczWhfxUNgjCnSzE+F8cnv3qfK6/EnQQa925QJW0p+grpuyJTw6dgTfZaH5tkVOsl1eSG73D9E0lgPI83+blSQTVIWVtHqTfgMtQOPC4DOTn/Newy0hI0RXKeJq4oMIuWQo9zdjwi6mUTBV6WhIrlrISZHDp+B9HCfTXUPkRPqkPTscrbVeCVsIOcUBqf7sIygKXU3IxyF6vX7tIkO3pj+wy7iJAbP/E1HQUUh1CjrzxQbbShBTNQGr+UQflr8Ewzuvzo1/ji3wN59vUYXBaZzJZGioS4ThOpFGmw3aTDF+GK/Ozp753SGsf3X3TFziLL7Ms70fnpPXgKw+8d5EwG2RaG6PJf/ZQxyWMXzdOsOB77isTeKkcm3+HYb98Ph/kEaEM4ln2Il3E97ZTP/UqpdY/WrDiZ0Ws/jLKffkFyonU3M8X60eryF9BlrkigtdaeLsss/yGnlyDv85Tx3t2Gv5YRTudNGIvaU5I4pPjfpkludRMkA6IpBi2ZAoA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0029.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f31ffa-cb75-47f7-ecfb-08d88c1f77e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 00:10:05.4452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cm1T4OqsD1Vf63ghT0bOHtQa9PLM3YkWvF04AMGv4zrI83Xf/EMzQf7E01IVRbrCsBGV379qzQh1MScXbyBSng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0096
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sia,=0A=
=0A=
> Subject: [PATCH v4 08/15] dmaengine: dw-axi-dmac: Support of_dma_controll=
er_register()=0A=
> =0A=
> Add support for of_dma_controller_register() so that DMA clients=0A=
> can pass in device handshake number to the AxiDMA driver.=0A=
> =0A=
> DMA clients shall code the device handshake number in the Device tree.=0A=
> When DMA activities are needed, DMA clients shall invoke OF helper=0A=
> function to pass in the device handshake number to the AxiDMA.=0A=
> =0A=
> Without register to the of_dma_controller_register(), data transfer=0A=
> between memory to device and device to memory operations would failed.=0A=
> =0A=
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0A=
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>=0A=
> ---=0A=
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 26 +++++++++++++++++++=
=0A=
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +=0A=
>  2 files changed, 27 insertions(+)=0A=
> =0A=
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma=
/dw-axi-dmac/dw-axi-dmac-platform.c=0A=
> index b5f92f9cb2bc..72871b8738be 100644=0A=
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c=0A=
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c=0A=
> @@ -20,6 +20,7 @@=0A=
>  #include <linux/kernel.h>=0A=
>  #include <linux/module.h>=0A=
>  #include <linux/of.h>=0A=
> +#include <linux/of_dma.h>=0A=
>  #include <linux/platform_device.h>=0A=
>  #include <linux/pm_runtime.h>=0A=
>  #include <linux/property.h>=0A=
> @@ -1044,6 +1045,22 @@ static int __maybe_unused axi_dma_runtime_resume(s=
truct device *dev)=0A=
>         return axi_dma_resume(chip);=0A=
>  }=0A=
> =0A=
> +static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_=
spec,=0A=
> +                                           struct of_dma *ofdma)=0A=
> +{=0A=
> +       struct dw_axi_dma *dw =3D ofdma->of_dma_data;=0A=
> +       struct axi_dma_chan *chan;=0A=
> +       struct dma_chan *dchan;=0A=
> +=0A=
> +       dchan =3D dma_get_any_slave_channel(&dw->dma);=0A=
> +       if (!dchan)=0A=
> +               return NULL;=0A=
> +=0A=
> +       chan =3D dchan_to_axi_dma_chan(dchan);=0A=
> +       chan->hw_hs_num =3D dma_spec->args[0];=0A=
> +       return dchan;=0A=
> +}=0A=
> +=0A=
>  static int parse_device_properties(struct axi_dma_chip *chip)=0A=
>  {=0A=
>         struct device *dev =3D chip->dev;=0A=
> @@ -1233,6 +1250,13 @@ static int dw_probe(struct platform_device *pdev)=
=0A=
>         if (ret)=0A=
>                 goto err_pm_disable;=0A=
> =0A=
> +       /* Register with OF helpers for DMA lookups */=0A=
> +       ret =3D of_dma_controller_register(pdev->dev.of_node,=0A=
> +                                        dw_axi_dma_of_xlate, dw);=0A=
> +       if (ret < 0)=0A=
> +               dev_warn(&pdev->dev,=0A=
> +                        "Failed to register OF DMA controller, fallback =
to MEM_TO_MEM mode\n");=0A=
> +=0A=
>         dev_info(chip->dev, "DesignWare AXI DMA Controller, %d channels\n=
",=0A=
>                  dw->hdata->nr_channels);=0A=
> =0A=
> @@ -1266,6 +1290,8 @@ static int dw_remove(struct platform_device *pdev)=
=0A=
> =0A=
>         devm_free_irq(chip->dev, chip->irq, chip);=0A=
> =0A=
> +       of_dma_controller_free(chip->dev->of_node);=0A=
> +=0A=
>         list_for_each_entry_safe(chan, _chan, &dw->dma.channels,=0A=
>                         vc.chan.device_node) {=0A=
>                 list_del(&chan->vc.chan.device_node);=0A=
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-d=
mac/dw-axi-dmac.h=0A=
> index a26b0a242a93..651874e5c88f 100644=0A=
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h=0A=
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h=0A=
> @@ -37,6 +37,7 @@ struct axi_dma_chan {=0A=
>         struct axi_dma_chip             *chip;=0A=
>         void __iomem                    *chan_regs;=0A=
>         u8                              id;=0A=
> +       u8                              hw_hs_num;=0A=
Just a nitpick: 'hw_hs_num' sounds quite obfuscated. Could it be 'hw_handsh=
ake_num' for example? =0A=
=0A=
>         atomic_t                        descs_allocated;=0A=
> =0A=
>         struct dma_pool                 *desc_pool;=0A=
> --=0A=
> 2.18.0=0A=
> =0A=
