Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6885700457
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 11:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbjELJ4L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240571AbjELJ4E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 05:56:04 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2105.outbound.protection.outlook.com [40.107.113.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE32DC69;
        Fri, 12 May 2023 02:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XePP/d8lLBpKOkwkX7ndEtgvnuR7N54isFiRNCrbr9Zq+07RgHVyU1CQE3VyDT5nxLVstsddegI+2jc1s6O9kmtHQvCMQJA6rE917ljPFB6MErQChecHta7qoP7YtId7FQhK44I2JzDfytB5b8xE4/63Xk7xriIJ9KjFBSVm/IxITSiRCsEo3C5WZB53lUuPlJCC1XurtM4kibTyTm23am7FvyVurq1agVN1MVyYR6VAaXG/SQ/a733fN5hf333JLocoPf+lWL1+4XouXkKzw3poVFyk8T3aOBJAOJ2q1v6DzEY5HHx4pj6CDSPL9bflILCaCoEd7vuRE6snJZN2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvHuP01Ylp2CT5jOz3r4HQr5nf+/0Z3xmjUU4llJeVg=;
 b=jHs1CMS5tPdzV0wDb00ykREzqYTq7vUjwJM+U6Tt9gw+eSY48UkZxE7rPRlr+s1F1OylP6kvlgIGevz73Riz1R8waX1BFftrM6pXRMuQ81Zu9rWv9xFXx/HTCbl+93rbBdVE4sFKyvzxeG8tIBCNr+wzRNk9+XXiA0taojJtZQDSQCH88pod3sGkyIrfPW0yg+HGcSir7X6WSNtswimUe7SEuYvcgC5F5hoM58y4KIrY4HD1535chSxOgqB6cgXzrVz+YGDHZikpwF6icEjTa3RDa0jjK6u4IyJp7EI+DWmH/Z/35w5fPe5EZfF4m/M84J1UvJuysp7HKghy4Clxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvHuP01Ylp2CT5jOz3r4HQr5nf+/0Z3xmjUU4llJeVg=;
 b=b6Kq8F59rw2deJ0tFP9P14aDINWxvgAGd4UadNG1AZwYsmrPpgixtBq2FSYvHKKl+LrWFI+AXYVQMXT8verON/D6TMBZkwVyx0azQlW8YuWHFVJh/lSgZLc7xdrdJD/TorOldel2+r3o1T1Pkf1y1EepMEzv+xopSUqlh+FWxb4=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB9669.jpnprd01.prod.outlook.com
 (2603:1096:400:221::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 09:55:57 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 09:55:57 +0000
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
Subject: RE: [PATCH RESEND v5 05/14] PCI: dwc: Drop duplicated fast-link-mode
 flag unsetting
Thread-Topic: [PATCH RESEND v5 05/14] PCI: dwc: Drop duplicated fast-link-mode
 flag unsetting
Thread-Index: AQHZhDwZvGSMdLqDnUS1Z2y/X9+Jo69WZwYw
Date:   Fri, 12 May 2023 09:55:57 +0000
Message-ID: <TYBPR01MB534152367C653DDC7760E0DFD8759@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20230511190902.28896-6-Sergey.Semin@baikalelectronics.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB9669:EE_
x-ms-office365-filtering-correlation-id: 1b94dd63-061a-475e-0b61-08db52cf15a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f7BO/V0u41HKP9/Y7GSPC4ZDvPnkt4EnvzaDt34gLHVNCRKQoKIHppmrVhrPyWZaNqpk7F23Ff95r1bGCX8VL98xx7w/96bHTtC26prx3kBHfcfB6Kr8cKVxWdpFrv4UDEp9m/g5AlHQP9PZxjYhWrbx8rsyov7DLccSSQfiMH32xiQsENN/pCWMj4LrG37BPaCfZUCf2fssLspToKAi/fHfEriyBUbOdfWREqeDfwQKi52G2cHMd1oSTamMPehsBg4XL1HQdrYRSx5KzIjJoPJOiAjhZj8HlQ/OJvH6MTEEgcVUl6noXxFsCwV5S726v/s1sQmQ18WHAAK44HVFK0xl2fB/HEO5vKfCMCsr4mQNoxNRIGe2XiXKrOs6nqKJUP900Gph1nuT7cINKy5RRF1edPSF8Wsdz+cxFQncbzIDcXQdLkAdFYO/seT0MMdAD3JcgQS/Bez0a8f3hX92ZR3NMwy2N7ZLFqZbrdQ4hcXQgAoXoKR3TbiP6Xj3stNOPjhx6fqVqwqpLhfE+sqQ7h09FsN/irYoPHEzz68Nl8fhNVEubq4rIeYOHKiorYO67n40VOTBlC8hu/JzUM7w79F4SbDyUq6P65zNqvNLGDi7nmJALXjAeM931NfO0IFEoUWrHrQvt7v+QPGLPTCmAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(64756008)(66476007)(66556008)(76116006)(66946007)(66446008)(110136005)(54906003)(71200400001)(26005)(9686003)(6506007)(316002)(4326008)(41300700001)(478600001)(7696005)(8676002)(8936002)(5660300002)(52536014)(7416002)(86362001)(38100700002)(55016003)(33656002)(186003)(83380400001)(122000001)(921005)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?UGI793xwxY394qOxe0e9ZcIPt82LPlJsjR7FHOVDELbJrRpYGo8A52vgC3?=
 =?iso-8859-2?Q?ZLRiKHKxMGLIZmjxv4nPITAkYwGQ/K19+SrWBdm/m4IKauY6GsgK3gvpZk?=
 =?iso-8859-2?Q?LQbinx66ib/WOZTiix8Kx2zzkIJaMXfebAlQeXyS0AZSKApESkz5Of6v9L?=
 =?iso-8859-2?Q?EZSfpchKJlUeH0l0e2MiDCqhvZSxbDhRbP1IH/AaqVLZcugWTdWW6s4C8E?=
 =?iso-8859-2?Q?ZcY2MImS8ePgp/uG1KajJx6PVwiDofmmvIe9vQF79ziKJ/ZDRHwZMqiyAz?=
 =?iso-8859-2?Q?8O+8MnuNd3YYETRnHg6aEMpNQ7swZCQU6omW9cCvrnDh2vZxBtmoj6o4we?=
 =?iso-8859-2?Q?iE3+lyVD/KWe6wRNmYKyryg9EtXFyoly4To7F+i+cekN+0G4YyVOgYueqp?=
 =?iso-8859-2?Q?wPO9b7bDXzWYGFdnTdo4mDt7LyUPg4K7VR9TNu1L7A5rQ7/IpVAXVMnzcF?=
 =?iso-8859-2?Q?8p0OTlOVmWMrJW1tAAB+lOVZNZFU++H6qk0jdsYX4qpdkydeE6/kc6l2Vv?=
 =?iso-8859-2?Q?c+k2gexZM0HGbJga/K0buesa94jBCF1o8WTi4GLQ+HZ0A2g/809cq15msc?=
 =?iso-8859-2?Q?00N+ixEgNaz/rzOafTG5N4pJpm7fekIXKY6g3Tn+0+A4PIE0UXQEgi20BD?=
 =?iso-8859-2?Q?+d2VanRiwH7oBfqGPVo95qia6uBmlXlTZ9KGh4QJZGfMcv7sdHtEpoPbTS?=
 =?iso-8859-2?Q?MqDmFpvksUA45LhEUMczrdAnMiQ6vFwAGODWnInBV+x0a5v/3o01AYNnHB?=
 =?iso-8859-2?Q?4QTGuOA+6a1zq66A4sPVPwpsLcAo1B/EiyvtDaR1vrMzn10B5O0WPObwLX?=
 =?iso-8859-2?Q?4H1J1ZWY1do4haIX2s4Myzwk1lXwvgThWD9zW6EBtCKnODa1+2UewIDrfn?=
 =?iso-8859-2?Q?hN6EzuUgybd1fmDfvwbKwX61XgR9k83tMwBbXE0gbU6GqtfJbSamL8OSH5?=
 =?iso-8859-2?Q?myGMJImreMm2hbFu26tzsfiwU2qdOVGoO2y3Jn++bJg2SSvlyUIIRzxnKa?=
 =?iso-8859-2?Q?WVPB/b0M4Ag63MGJt6SBSjtHDqJ3fH59uW+V/tKbGKErwV+gDqQizUNgLj?=
 =?iso-8859-2?Q?wwAGs+YNYPT2OMx+csCEvaJt2Ecl+6uOS/vZ2q2PnA7UP2RiWv4F6GPoZs?=
 =?iso-8859-2?Q?7blouv3f9fR9y4OG1n0RoIsF7pgXgyKUNN7cMTzFAmNQ13eyNnLc9Abm+1?=
 =?iso-8859-2?Q?eyNkL75mSD1inTmNBzArOTbJAfSEpTUdxcri0YQxA8hAzeyRsGMuZy5qj0?=
 =?iso-8859-2?Q?INTK6yQb7oDWauZCTJKra2HP8Z8YmJDTvueNjE33XP1l00rwngNHRPQT1O?=
 =?iso-8859-2?Q?zRmtFBkeqKNauKp0rYaUkA2jWk5KzNkRTdJ4twXNpZ5hJiKjkz/E7qmBEU?=
 =?iso-8859-2?Q?hswbtaevACOODTdKJ3LfEOlXlLmWyC2mIOJizHCQGFJLraOGMUkFnRVw23?=
 =?iso-8859-2?Q?tvFKR29Lgswk/jYwwglHj3kokZhFlwmymK3C13c6R+n4tW31h6XX5+LhVf?=
 =?iso-8859-2?Q?y/6yf57f/f1ECSbaTYl8F98z9CvatiAky/HkLW7H2hRIfc16OfHwM01JqK?=
 =?iso-8859-2?Q?obW8Qy9VCq9QmNot4dEwW4clGLo8fQ3o9v5cfNI/00VhZBL8yoVshznRBv?=
 =?iso-8859-2?Q?W4VLsS8dsUN0IOZYuvH9e+v/7jjQ4w8dSeVopZPlv/4La2KGaR7zWOXw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b94dd63-061a-475e-0b61-08db52cf15a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 09:55:57.7239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4jdGgTMMR8XjXRikVFcSW6pQvugtsr28HoE0AeWxgR//QJ0iKjcVBYvHU73d4vQEkhJNwMZZT6y6bbHGpXYujX2gsjef8gI42cfD+dhwcnh9feEpPbM3X8GGMylVyaC
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
> Most likely by mistake the PORT_LINK_FAST_LINK_MODE flag unsetting was
> added twice in the commit cff9244432e8 ("PCI: dwc: Ensure FAST_LINK_MODE
> is cleared"): first it is cleared right after the content of the
> PCIE_PORT_LINK_CONTROL register is read, second it's cleared in the
> framework of the link-mode initialization procedure. The later action is
> redundant. Let's drop it.
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
> index 8e33e6e59e68..e55b7b387eb6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1019,7 +1019,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	}
>=20
>  	/* Set the number of lanes */
> -	val &=3D ~PORT_LINK_FAST_LINK_MODE;
>  	val &=3D ~PORT_LINK_MODE_MASK;
>  	switch (pci->num_lanes) {
>  	case 1:
> --
> 2.40.0
>=20

