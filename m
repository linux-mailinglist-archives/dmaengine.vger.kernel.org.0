Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDAC567DF1
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 07:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiGFFmg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 01:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiGFFmf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 01:42:35 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2100.outbound.protection.outlook.com [40.107.114.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09BA21E37;
        Tue,  5 Jul 2022 22:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKyUIFDZZbRuGEj5oDeUUsdFvoyL710sQhKqR3rEGukjuprZSQ5Impx968sJRNC/lG+kWVqS1piZv+aUfcOpk6ZxgSuzPL3+LlCFEhdAunIKRqFLd32zvTfpyzTuroaKv0QCewWD3qKfGqGr9raxBEs19/TaqMsFDt8zLQ3qQyeoxxV+SVhdbP/0ro4aaDPccpg11FYQ/J+aRJmrr6wiakxrAjxndAVZBxQJoYheDXcv4pc/BP1msAJP6GxacGn3DcwAD5yed2yBi5W0drDlaYWhjUV1fasTKL3ggzrKRvhgxkrIGhbHVE9Vrog5r18sF+L3Pwtl8k3bm/T7En+NIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru3XzZ0FhpEYK5FfzbGqERGsCIF8o9A8G3QDxEmwV34=;
 b=UpcO+s2xBfedq7gZqi8J9qU8lxBE2eHXUZS3mowhP1IbHJi2K3Y7w6/iaQFn7j1msiR1Ov4lrg63dj8HsL932SrGmesYeCwR+k3IIpxMbFt0BE97Afl3J9BEChf+XQxutCJOiR2/YlmdbXc7gFx7ySuJUt5dQsE/hErcOnFPMjuTqUfhX63DAJQU3fH8WGmv2ivkOjVvMTR0LSLA+7d/bbvajoz2nnzb45YbszcVzHbS1ChM1jFUOGvN3dVln1FdfmvxDRxoyB6CyLoslOoTjCJ61hORVG2x4kuyNiqP8BhSleAUjLYdfZjtUxh2CtoIm3rEPnYMO+1RPiYNW/BeDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru3XzZ0FhpEYK5FfzbGqERGsCIF8o9A8G3QDxEmwV34=;
 b=iQWv1rBYv7iUezLtO41eSDkbubg9uCmH9AIHddKzO+lBF+2z4HS6ePxU0AT0DUyEcjzuRuIjC2X2vhTotOeO6UWcz20zgxLU931/NTNQ66X0fsWpgBV0GDrHigwZ7wJ3dCTqCXyAoWwFK2AMAljswRP/e5Ksvv/H0T+Xdx5LDTU=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS0PR01MB5554.jpnprd01.prod.outlook.com
 (2603:1096:604:a7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 05:42:31 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%5]) with mapi id 15.20.5395.022; Wed, 6 Jul 2022
 05:42:31 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: RE: [PATCH v3 19/24] dmaengine: dw-edma: Use non-atomic io-64 methods
Thread-Topic: [PATCH v3 19/24] dmaengine: dw-edma: Use non-atomic io-64
 methods
Thread-Index: AQHYfKtQgpemW274PkqGO4tIUqvOIa1w+Alw
Date:   Wed, 6 Jul 2022 05:42:31 +0000
Message-ID: <TYBPR01MB53418C1BC8791CB6D068A177D8809@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
 <20220610091459.17612-20-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610091459.17612-20-Sergey.Semin@baikalelectronics.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8b1d506-4442-4f56-41d6-08da5f1251c5
x-ms-traffictypediagnostic: OS0PR01MB5554:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HvBLjixYfCvsFACTmP60g0UFeePjGoYup6B0OqRB9UxZAIX9b4Q2947xS7rg7i18bkiiozIxR4yMGoV4AMK0SG4PqkZaBd+xBHUcOekoop1uJDrQiDInWp+VQo2JKXMIOGXwkUBH6iUMUhwAaWrjJWjxwj0RPw1f40ibCTQqP8+YwY3lfSGPnXiL3YyU2zbgNQR4d51nyVIEUDGguh/8zL/TGRAhO57VsUCS6FTKZjQRB72uPGFSlS1Ua3BvejdQiydKQu2tDaWr1RodkAWEoRmlCnJJU0n8Tqm50tA3gDxW/m9A1xMQosqs5UsNvlr3qXb/dTsxlOIUmLnIfixFSOxKjf+bB+u0wKmW1iMCrSCEIjCdJKKPGQZPcOZsLE2VfC1ZeJyQI014KLh7K69gmWFkYg8Kg01jVrnQI1K0PzHTCKzf2PTdmuxy7zwllXHwVYSX5TL10D3PtdVpmRsKE7J+yjkX0Or9fPwZyBFQ5LQgBbHmwP4z4savpzTsAulkqzVrf1+FBGvbxljEqms3vuWGy/ocWoXvzDCexm3VKV4TVstGMqRSvkZl96yKNCJ2VYiGIN77Mc8nJfDKp95SKtLaDez0gYeOVVY91iX42E1/toK5VLFFMKSjWTAdyLxVyK0P5n5zGrI7JGgySiIBk8AQl/kzhHWFqh/XWD9cJXPgjxzDHXuRMu0j2YFFkpqdOj3WC7hzvp1IImNerb4WoaEtZWT832j5AeP3EzGcB/bzAIaJl/QiTORj0HOtAtj5695/lfDYQX0s36xZ+8O0Dmfio4PKXD6QIwlyFWr+bHU905kDnspAVumHKYjF5jL0pAxWMDcb7B9vRRJO/Z3MEH+J8IA6vNvWjxpP+1YO7GvNN7iKpdtegM54RX2Ik0KvGGoD2KeGeDQAVZRuYzF25Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(9686003)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(8936002)(52536014)(7416002)(4326008)(8676002)(5660300002)(6916009)(41300700001)(7696005)(33656002)(86362001)(55016003)(6506007)(2906002)(966005)(186003)(478600001)(83380400001)(122000001)(38070700005)(316002)(54906003)(71200400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?ESImABOZSJerkV2IXyhe1tDCs0qYsAXrSQbdMU6FDmCjeNPfAa7X4Fmnvf?=
 =?iso-8859-2?Q?YzPkmfaFJ9d/KjjguZV2k/RH1p3m5QEMB26VP4nWMJnH6PcTAur3/3dcUE?=
 =?iso-8859-2?Q?LdoacREiutXvC6H6VVfHkl6Os+1CVqL5FytyV/I4OF7j+Zt+r4dVO7yFNc?=
 =?iso-8859-2?Q?XXCHOeztYbQy4ql8QmTDaeJwcUjwxlaQFi0vm+6NgOf6NfhVikEvMrNt8U?=
 =?iso-8859-2?Q?1Q1l8ORmotsYtdTXQsyLqosp6QtK3DbB1H/IK4PBcswwAImp9Qt9H9JsNR?=
 =?iso-8859-2?Q?Vmq2FFDAdZgcv8+kLVKaaYPXC76GCZLELdRzxKbCXoCnut5WsL9tItvKdl?=
 =?iso-8859-2?Q?DuPXXk5/QVOguVppcpAfRqcjtkfLeWsnjeqvqbRDRL5uI1NkKu1FTQB5jZ?=
 =?iso-8859-2?Q?T1J+Ncy8iZIoHOS/l5mSAUKlXaTA4wLQRzfazMXBqRrRdxcfSBOl3KOp9f?=
 =?iso-8859-2?Q?wSJkrJO+O2yKPVgMjLGhJ2yMMNVMWQXcauTouSTFThsc12m6BJ92yx+8Sj?=
 =?iso-8859-2?Q?D8/bcrsDgxIdEou7JEvhNNWrt94aFQcJxEjvgJJisTR3jYpPNNCTha6zYx?=
 =?iso-8859-2?Q?tSIHvFiSjc/hGLn9sjo1k4ZtUbqRZdgntdY8WTJXpAl+9FP4wAB5WWFIpC?=
 =?iso-8859-2?Q?lhpitGI89548Nxcm12qwltsrlayW5Tt2gBahMASZ/i2Qpqlturc2RMjZor?=
 =?iso-8859-2?Q?mChoTiS5n4gPC4ph6Ylrne+UnqkIJoi9Mss2WoeMK5RsJBNXM3zWA8gNYX?=
 =?iso-8859-2?Q?WUJbbF0jxIVZfawKrBsQzdxs6XJajmhkysK7gD/BvrWpGAU8nic5e90Zst?=
 =?iso-8859-2?Q?F6/mOCU0icx7arDWbrwBkxaOdkQ7CN18uoAsS92GsvL6I3D7Io0kt3Yj6p?=
 =?iso-8859-2?Q?ZMAa/M+tisJzoHK9y58+iSqq0zk+sVJVToeTQK5GxgTo4PzD5+q2JwS8LI?=
 =?iso-8859-2?Q?Afx4cNmK6/BSEUYpQ334+msiVHu4BOuxJamrSvjENG3rF0syvdE6fgpimq?=
 =?iso-8859-2?Q?d53FqPmRC/3J8u7ulu78GY7aukp539ZtQoA0JxcRwLB+kjrHMtbOjLf1/j?=
 =?iso-8859-2?Q?9n2tFvjkDcYzqvV0zUNygAINvxjrIBlVSgekUPucCq/OeLSH90X5TYluBI?=
 =?iso-8859-2?Q?l64uxt4bxu6XIJT0+yfNjU/BH5IkZ0NNFepORz99HETQUs0eFwjfTEl0/u?=
 =?iso-8859-2?Q?L9PSLwiwRu3Z4IfNOzbiGc1s7yN03/MwSgP3m0CCyE91uQ/q8suISY2VL7?=
 =?iso-8859-2?Q?Wr6owhe3oN49FMx3ZIzxBfsMmFZ9fRoyuGybF/C1TYm6WChfEnpK7kfoVN?=
 =?iso-8859-2?Q?hmFYlR2y1rGi3g2/gqWIvb2gml+DnaHoFkUhnWL8uRsWhuM8MYmLJUs5Li?=
 =?iso-8859-2?Q?QGEuxMQ2FzLDy86DI/wQPifmljAZ/Ol0vtP9sKmejZ5AXwYvKqQAJAD8Ob?=
 =?iso-8859-2?Q?I6F+RjSTdmoz+BYbU+slLy2xzh7SuZm7Sfh8ImDsbc4vOWows8eoS0NWu5?=
 =?iso-8859-2?Q?oHIf48eQV8jUZkDWoZVl086sempvkiKKRlKUb5nPs4EYvzsOiFMRh8sVQc?=
 =?iso-8859-2?Q?DPzsDKL6GYg8qws5qJkCH28rln9K65iVGy6rOB8wV8izJ21U1N36qxKdTQ?=
 =?iso-8859-2?Q?7GwnMfXXrKEBrJmfOLKw8FLdNp+tH6PrRJ2tLvs5sRqvVV4DgPS5mmI4/V?=
 =?iso-8859-2?Q?b/2QDkAIfby6wbbaF+bKm+qbObyXYDXyfMFNnXe52THItqLLOsBfC2jqCp?=
 =?iso-8859-2?Q?FSNg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b1d506-4442-4f56-41d6-08da5f1251c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 05:42:31.2122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3p/v5h0FR28Wy7GwqSUX6fV9kxOiRqooJwmp6eLBD1zmyhJ8zrFWNIpdCNlnojtJ706+ZgsZ1Tu4I4G5zajJSev2LEl2THlIdD6mAd+fKB/DDZV53GPTRcPePxFJ4a11
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5554
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

> From: Serge Semin, Sent: Friday, June 10, 2022 6:15 PM
>=20
> Instead of splitting the 64-bits IOs up into two 32-bits ones it's
> possible to use an available set of the non-atomic readq/writeq methods
> implemented exactly for such cases. They are defined in the dedicated
> header files io-64-nonatomic-lo-hi.h/io-64-nonatomic-hi-lo.h. So in case
> if the 64-bits readq/writeq methods are unavailable on some platforms at
> consideration, the corresponding drivers can have any of these headers
> included and stop locally re-implementing the 64-bits IO accessors taking
> into account the non-atomic nature of the included methods. Let's do that
> in the DW eDMA driver too. Note by doing so we can discard the
> CONFIG_64BIT config ifdefs from the code. Also note that if a platform
> doesn't support 64-bit DBI IOs then the corresponding accessors will just
> directly call the lo_hi_readq()/lo_hi_writeq() methods.
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 71 +++++++++------------------
>  1 file changed, 24 insertions(+), 47 deletions(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index e6d611176891..4348d2323125 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
<snip>
> @@ -417,18 +404,8 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chu=
nk, bool first)
>  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
>  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
>  		/* Linked list */
> -		if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||

I'm trying to use this patch series, but I could not apply this patch.
I investigated why, and then IIUC the DW_EDMA_CHIP_32BIT_DBI flag doesn't
exist on the following based patches:
https://patchwork.kernel.org/project/linux-pci/cover/20220624143947.8991-1-=
Sergey.Semin@baikalelectronics.ru/
https://patchwork.kernel.org/project/linux-dmaengine/cover/20220524152159.2=
370739-1-Frank.Li@nxp.com/

According to the comment from Zhi Li [1], the flag can be skipped by the fi=
xed patch [2].
That's why the flag doesn't exist on the based patches.

[1]
https://patchwork.kernel.org/project/linux-dmaengine/patch/20220503005801.1=
714345-9-Frank.Li@nxp.com/#24844332
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/=
?h=3Dfixes&id=3D8fc5133d6d4da65cad6b73152fc714ad3d7f91c1

Since both codes in #ifdef and #else are the same, we can just remove code =
of the #else part.
But, what do you think?
-----
                #ifdef CONFIG_64BIT
                /* llp is not aligned on 64bit -> keep 32bit accesses */
                SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
                          lower_32_bits(chunk->ll_region.paddr));
                SET_CH_32(dw, chan->dir, chan->id, llp.msb,
                          upper_32_bits(chunk->ll_region.paddr));
                #else /* CONFIG_64BIT */
                SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
                          lower_32_bits(chunk->ll_region.paddr));
                SET_CH_32(dw, chan->dir, chan->id, llp.msb,
                          upper_32_bits(chunk->ll_region.paddr));
                #endif /* CONFIG_64BIT */
-----

Best regards,
Yoshihiro Shimoda

> -		    !IS_ENABLED(CONFIG_64BIT)) {
> -			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> -				  lower_32_bits(chunk->ll_region.paddr));
> -			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> -				  upper_32_bits(chunk->ll_region.paddr));
> -		} else {
> -		#ifdef CONFIG_64BIT
> -			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> -				  chunk->ll_region.paddr);
> -		#endif
> -		}
> +		SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> +			  chunk->ll_region.paddr);
>  	}
>  	/* Doorbell */
>  	SET_RW_32(dw, chan->dir, doorbell,
> --
> 2.35.1

