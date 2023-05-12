Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3517670045B
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 11:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbjELJ4W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 05:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbjELJ4L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 05:56:11 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2128.outbound.protection.outlook.com [40.107.113.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAB710E64;
        Fri, 12 May 2023 02:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgOANAp8Sq7gdfoiHKXeEw6uFvkrjc3ibi5Opxh2G3NyuPBthiwboDymPS+AeMieIsrCUhnKkmI34sXXvUWFcnU0Qh5vQEMC5w2SFarYHgXu73Lbok89YOpHLctZVCZf6EEqTJmKzbmhcybJW52vurdQ2aiyZuHSDCJ3MWYJV3pNFc6BsHChc5JLK9j3pk7w3CgX0ackT6LEJYTn3oTfjIvlYMQt+zP3BCdDjwGNPsmxk8XmwOYaJASwq7HRZmy9ge5NDSBWLAeHLH+9oeKva+cK7d/l74dhp9kYLTbtGcWkXmaRaw3t5Ri7NZsoyyoJ212539tSIAIiFUyVutmHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4mVJS9d4M/5KCx7ytbaja4BIKvhva+uekkwteV2a30=;
 b=BP9peHP5UW81d2g7R2szpdpjlVWGXab0e4U801TJaivsuOChBxURrlJUHAqAjF4PEczDTpc2Gz5IOUTiDmiUOFaAwdM0nrf18oY9KkdxqwpBQvE5M/BJ1iqIEzprMdgbOo34rdGPTOBpeSW8n8yfYDY4DmHtQm106PtKJCe+qF1OEiRAY7zgjdMmv5zQTf1qISPnRpZqQV3jSwK7yaURXge7uSuDuZwP5oj228BLEBmz1ajj7/43lu51YFDM5jpuw6kl1WZrkuRmpg9sDGaWTF8hFXuj44Woe3EIMBMd3IfOyMiZzXIYYXbz/dj4yZBhhnNgWmiI+N96Rz1V6Uz0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4mVJS9d4M/5KCx7ytbaja4BIKvhva+uekkwteV2a30=;
 b=c5hRSAZ72NQ468NuFw5SJ0WNMF/r1hyDJRtv6Z68/Kve/ScsPlO53KiGSEmk5Spd17ajojqFp4mLYoy5AvIZP8tYN1Vf1v+Jl4I2rOo6Wn2x5Rpgncq1gSZECqY3Aa/I0l6vf/5PfkUxiLazYkQhLTw3vBWdIeLwx+8f2v8FbFs=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB9669.jpnprd01.prod.outlook.com
 (2603:1096:400:221::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 09:56:03 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 09:56:03 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND v5 06/14] PCI: dwc: Drop empty line from
 dw_pcie_link_set_max_speed()
Thread-Topic: [PATCH RESEND v5 06/14] PCI: dwc: Drop empty line from
 dw_pcie_link_set_max_speed()
Thread-Index: AQHZhDwZNwir8jYpdEOY4xKqJzYPPK9WZyZA
Date:   Fri, 12 May 2023 09:56:03 +0000
Message-ID: <TYBPR01MB53417A0E46D89EF3FF65351BD8759@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20230511190902.28896-7-Sergey.Semin@baikalelectronics.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB9669:EE_
x-ms-office365-filtering-correlation-id: 00350392-2ec2-48b5-6f2b-08db52cf18d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4iXq8761XT+ImJHppPlIHJ9xHV1olAuCVvrgfL7uIm2Wt4PnOLZ6UKtO87eU6BNEUWzyhUanmmlrIdXrSJqCYt1J3Y/9E9aaVRSLwnZ155SMW+cIo6CStXqBGnELNH2DeSotU2s6qURxzdKoobWwOjNzr16pOUt0cCmKgyanccZ838VhW1+VcDIqyIEoijWtZGjTE5P/482VKlo5rbFUQ9BCSan0p6Efx9QZ/3Egus2IydeQShtKOg6B7GU5/5aOEYIp1gJWqyA0vvKLVS5vP7V7MCUg73FvoAUBrfAac53UqSLcrrLc9JNlQO/fQTL1uZ6ln3nPejVgzQBnUI9j0z7WlwV8UEbGK1s7KAb/Yv0RwSpjHW53FXKirNiVLvzBLyz6lNRnTWYwfgzH70Ibab1zrRZ6Ik5xyvo3k/rxDci2L3mNS1rkERHKNgDuPyLD898OT0/vFAvsI2q23M8qUMO05X5+Kla5Nt9SUH4SRhyDeIZyTN5/DS5WTjz+aVcgTSLTjMce/LccMOlFvZPsLKd18QyM+qLMuWWgV/SG+GIHy8Df5jEYxru4SKSjlvL2EVyU3w0ZsKfhsF8HDlIoaFtGaUCD1pxtDIj66/PZ251zOI6FgoqwcxQnY0p4WUbTvJm9oWanuEQYcjHE5YwlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(64756008)(66476007)(66556008)(76116006)(66946007)(66446008)(110136005)(54906003)(71200400001)(26005)(9686003)(6506007)(316002)(4326008)(41300700001)(478600001)(7696005)(8676002)(8936002)(5660300002)(52536014)(7416002)(86362001)(38100700002)(55016003)(33656002)(186003)(83380400001)(122000001)(921005)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?aqRXu7er2S3SnEHNVSTzMPsiQb0c4WjQ19GDa2zJWk+D3PKa6OGmCqsf2u?=
 =?iso-8859-2?Q?VuDT2YHGKv7YY3c+446TMbr2YDjRV++l6OAWnbo/lVkh/WYtZl9gMrw5th?=
 =?iso-8859-2?Q?VAmefrMbwDcP8J01NEdSCqoPnv7QOiBnXBCBt4z/MTM+N2c4ieOTivkkMJ?=
 =?iso-8859-2?Q?3paTqaBD96J13hwxnCID7yJZ7x0C2RQRPbVE/0tARIg6tPz969SdJC0697?=
 =?iso-8859-2?Q?vI5SJk7tVGQui65u6nEHlstvaLIkOy7dVBPLkHPGdVJZSE/z29QGr/pKtj?=
 =?iso-8859-2?Q?lL2zH7Us5Tg1q8ozNFfi7KRlS+giZ6I48aVHQ1k2VChqZnbPbHm4KbWwBk?=
 =?iso-8859-2?Q?BzMKzPj0XXGWkPdRfByjNh+JGthb1/tCDD9BGkfKzi+DzZ3oFy74C/OmFm?=
 =?iso-8859-2?Q?l8z3xD2xyNC++4u9FatG91kovA3LAD+UpwBh6nIlJjgRBGbMNlFwbqijBp?=
 =?iso-8859-2?Q?M+hLK1Zuo9toLDG5idfIH5BPSKShIk49EwJc/AsYr6TMCQ746WesmOw6qv?=
 =?iso-8859-2?Q?UW8yShJpDne3P9Lhv4wju0WU/XDxFYVoxdKrnlOd0ZEW0Si34v6u6n5Gj8?=
 =?iso-8859-2?Q?wmDlQ9rY9ZZzJxcuLMczXmv8HArExVlWxVDP/zzP+zHH9SXApZI7Cp6MZM?=
 =?iso-8859-2?Q?dC34ofpiz0oFSDfc60rpjFHMol4dZ20yRbp/Q5ZYb+TqQfvzJn/B0v9gQm?=
 =?iso-8859-2?Q?2FJY2cSqgcuj7up3Nd3/97eiZMfXLKriPQF5HgtIcMbFPWrdxjEB8k+cP3?=
 =?iso-8859-2?Q?b7KQDGlGF6XPUGqPSn5fYGwIAjepgY9x4Hog6+s4dLcl5ZTKqr9NNVNOLx?=
 =?iso-8859-2?Q?09dhiyxHE1WJ5d/7C6O/9wSf+kj7AoecJ+0co0IxytlJqPVCvAS0NIC3LW?=
 =?iso-8859-2?Q?6UF8FeI/my7Vg+xPoKhc+tRBuzAogAl7eLr5uVkAZ4kK9mTH1g9w1p9p6w?=
 =?iso-8859-2?Q?C1eFQVdSY+DG2JTC01aaWvy1bO1c6mPWbDBqWgtGvnWjqNcKuR3qhsmNiB?=
 =?iso-8859-2?Q?o0O+pU+j8kQg5iR4xzWDmpq0jioA4cUV7jgZu3FlGa5RtwTO87vCaAnII9?=
 =?iso-8859-2?Q?oCfjViyMT9gTiJCRl9Mebt+g3A0Pg2+uQz45DhQttAQD/Ip7qwGvKrPHkb?=
 =?iso-8859-2?Q?LXpFPNetzEI5ThhSukXqYhk9UL+X8//utWUBEDmSOZyizFVy9lQy3XS4zT?=
 =?iso-8859-2?Q?3zrrV0CQS8QZxjF62rgNPaMKctgiXPfjXGGb2/1AYECZSMsCS+MddduJTX?=
 =?iso-8859-2?Q?b6VlkUy7Bn95EFTc3AwTTUtssi2NZeQHPm0EO/i1ApOaX278FyCx20IUmf?=
 =?iso-8859-2?Q?tGNI+eWugzMqgSN+DhHQRk/49I/RtNJAKy+Rlpxo7MqvdEvqEoumaYdhJX?=
 =?iso-8859-2?Q?8M7u38LkVF1k03y/8nUkYmpXnTXI6Zb+CsRUEBoha054L3Q+frlV4cP6eG?=
 =?iso-8859-2?Q?OiAat6Cs9Ud4TkM/THtWRZMEr5YmLKipnF8vgRAL6c8Z60dXeJNALeKjXI?=
 =?iso-8859-2?Q?FnlFF98UcYC8TJIjEm32bgCzJ1iM8J3bKN9JsVCWBJQDmOZmkDzEs1wh2u?=
 =?iso-8859-2?Q?injOMsewpveLg0IAeq25XiNFmzR50QUahxvJujwhHF6vpOdCTf42Ozj836?=
 =?iso-8859-2?Q?56AKSCugwdoXFKi8ReVoCli9YnGKDKjQ9MqhRoUoc5oHlUT4kNN6KzvA?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00350392-2ec2-48b5-6f2b-08db52cf18d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 09:56:03.1305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIwZgPSU2safWmDFlASls+6uxAhwPfRtv7w6WpNGvXfUkEfu/bTt9Pjh3mDfQJ91F5K22fnRhLkLgn+y3oEWU5tFr8QpsXrWheptEzcfNqlkPXRUag/LjzklwblI+CYM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Friday, May 12, 2023 4:09 AM
>=20
> Well, just drop a redundant empty line from the tail of the denoted
> function which by mistake was added in commit 39bc5006501c ("PCI: dwc:
> Centralize link gen setting").
>=20
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I'm not sure whether my review is useful or not, but anyway,

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index e55b7b387eb6..ede166645289 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -729,7 +729,6 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie=
 *pci, u32 link_gen)
>=20
>  	cap &=3D ~((u32)PCI_EXP_LNKCAP_SLS);
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
> -
>  }
>=20
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> --
> 2.40.0
>=20

