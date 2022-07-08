Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FF156BF5B
	for <lists+dmaengine@lfdr.de>; Fri,  8 Jul 2022 20:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbiGHQKv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Jul 2022 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbiGHQKu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Jul 2022 12:10:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9734A7437F;
        Fri,  8 Jul 2022 09:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlRFSHNPwW4fPyOrVGc/DM5ittKufIPVnSdlhew/DhrFMXY82Qm0yZbqgbiC8hCYMrifCvkq4pExVq7MI7oHehBvcXLHreYS0wVYcC/4EBt9u9j2fNHlMseHx/H4w4Db+IInGq+lZIGuQrsuCb//lmNNEmfstT9ERbbJdS294zU2O/FVrvmu8Os13NCU5SlKVVS7qeyu1T5+HnZRG/q1S/Cil+KI0cWGsO7NYQR6rypYFTpnIZTQp74q2Je7Khis9y5qco7NM0jPBNZAC0DQzNzE/EDOlz7hytkxOW2ps0+PHF3aR7TKYKAnw+6SzKCw8+McICosb3TFNaLRQO6ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJPHvn9SgY6AsTxG8IEtGGmajSxXRwAm/m62VRAecVM=;
 b=SecYhmJFCCNNx2KoaBiOW0R3MK/KYrkeBPjDsamZP+eUNRuGokWhV00PuaGtPDzI63KK3tkJouQE3Kugzw9D1uzslfhAvmyv5HFxPf9cxAf+phNJScNYud8RmcEDEg6oaJNVJcmzD24d+c4iTpyHwMH+SM0iWtEw3CbHcsGiWeFDzpN0G/ZlPcYKhtBPwmBJQ5RpJ0z/JAEJii663UgcFTxYUVIy7EpfmTCFukBG8acXRj/Ji/1PSDb3RrUjmZwzjlfvr9bxTXt+Ai4Or3NY3F0Yd+SlVIQM/Pcsg7SmC37/Pg/M1kWYuSFWcXdXjlyj3w+hbq8tVplX0sehXTs3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJPHvn9SgY6AsTxG8IEtGGmajSxXRwAm/m62VRAecVM=;
 b=B+U1d2qjQgC/KiuQVT6yQUgaPTFojwDvieLPzBcTGaHdoG4p/ZTYpOlHqlDM+LDgEIoPTAmJnGgoDp9WHuFFnWm6g5Xf0jNKUBrGaBmctm7ByOWD/S1n+dcQ/94ZmSQWbEwJFED8lDhnyYd2DTxoZYbZgvLUvitpHfRZYykWdgXJ0pL4ulZDIcnEgjGBqgQ+giV6nL8Ooan+rccEmnDVty9QpuCcLCTtwXGdPPJ11AkPSqRjqjaoeQNjY+bPkgQpJ7dLvb1HCXIzURRFaIMeozkZbhKwVGcI4d85DxroZmOMuTW3ANV3CS5SYm0pe6a62cNlpYAHOjbi/fQpEvvGwg==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 16:10:48 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::28e6:129d:a1f:84d3]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::28e6:129d:a1f:84d3%5]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 16:10:47 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: dmaengine: Add compatible for
 Tegra234
Thread-Topic: [PATCH v2 1/3] dt-bindings: dmaengine: Add compatible for
 Tegra234
Thread-Index: AQHYkhH2RKRmdrlQR063eqSYWXAxeq10i9OAgAAamLA=
Date:   Fri, 8 Jul 2022 16:10:47 +0000
Message-ID: <SJ1PR12MB6339A080E09C0CCCCB9F2E6BC0829@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20220707145729.41876-1-akhilrajeev@nvidia.com>
 <20220707145729.41876-2-akhilrajeev@nvidia.com> <YshAt5WAG9zUkrpy@orome>
In-Reply-To: <YshAt5WAG9zUkrpy@orome>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd6adb31-7173-4b8e-8505-08da60fc6b92
x-ms-traffictypediagnostic: IA1PR12MB6578:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0iJjEUwQHMVhEa2p/obVnpC7hD6RCt7wxrr3jYXqOJ74DuCr6NmPaUD2D4YSw8GygyvvwVa+S3KnHUem8sjN79eLdorHnOmWQTRbtTR/C3B9Bz89M+7SyyQ9cCEJq7zyJMsVgsWtpxJT2jXGD9yin8N1qmaaISQ+zcW8WX/a0+SU36CtBJbIa1NnHB+cdIYHk4SkOduIc2l/qE6/o5BS+sBWL0b1hX1QA/+hlCJVMcBAG2EqW8WaSeQQbVEM19qJdf4hG6sRjDAGnaVZf1CrhBwqeHd+BDSqVilLxZ6jwHbwzW8XO/56aHi32x0UBOgdzZ6fOiUDFkxDm6HYGFWIzGD7/8yw0HvBn/p81hlJshfyha+zI8+ZnqKAniIsKYM8Y+PomzkiXYQOZNKt7CQaEDDs8XFKqt4Qr/Jd/4+fLbp2Bo+Td790TfSOTpSN++H+NLZm2rwj8vEFZJ+d5tPgyOfmRYSYSR6mA4PJ3D/4BO3WrWG2Je4J+FriH4rqYXl0/sW26Y/2VwIKJrQH+17P5k5wANxuX2qe7BYWZY+dSQqSttsLXiWoAmdkblyww8Qu22gszjuM8vGrF8usacvXWpqt3E7owNRLIfSR8FV+0hR/o2hE4+cNhgCjF5Dbfznc7SHBoaYakqrXxt4gzhCyD3md2UcL9l7VO+5V2qPL0athcIHvcnpBfhjdtw/vMcwhPfhGFEZAny06tRfyDzx3Rg17icuMGANIcsViolEwwYmwjNvkETuAoRbM8l3zUZsp+6zkT6zaUF3u343StMJ9Mv0rQqX4hO4Xm1giuKUZEtH2piZRrao9YgaZG9OFwC1x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(7696005)(6506007)(55016003)(55236004)(186003)(66476007)(66446008)(8676002)(4326008)(66556008)(54906003)(64756008)(76116006)(66946007)(6916009)(71200400001)(26005)(83380400001)(9686003)(86362001)(38070700005)(38100700002)(41300700001)(2906002)(52536014)(8936002)(5660300002)(122000001)(316002)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GGRg0CqLFRkFRVJiSYIDyicjxJWjhc6zB9EvHugPwMdXf6DpvCzmFFjo24Rg?=
 =?us-ascii?Q?LcbeoF73K0Zjc/TyyzCa/4Ct9CJBgQAeu8j2+EaCq4XuD2jFV0xvxynVwlSJ?=
 =?us-ascii?Q?+g+xxuceOHg4b2w2OV+f5hAiJ1XUcRoYlLWNsEkjFaXEmZ0Z0Hdod9nAOZpT?=
 =?us-ascii?Q?vzpT4caVZMtcexgw2fuy2DZhag8ZArrijvESWFN2ovQx+xP7VQafT/mB/e4X?=
 =?us-ascii?Q?+x9l2DWfin8QC6pH5NNb7Ndd4W8+nY//pXu8xEIfl6IDwdAJbcSYCFCceIGo?=
 =?us-ascii?Q?HJqCUzHHjl9eiyQ5hl3pc7YjxWR8y/0NnkDE2/WplYnpRdmG/Sf6jcI0SfM+?=
 =?us-ascii?Q?QSnRa6f7pVhdytjgLkxiOXisqz2BWle8hFiSWzf8G44xCxycqh7tuUdds8L5?=
 =?us-ascii?Q?EO6nUBMtEx/HaIJOegMcGuLF+hrDg0b4kyksCDzh5vbZpbckSUPdnxVqSgeU?=
 =?us-ascii?Q?bErnYfJ794Jpb3moBNYOv1wdYO1Xy9wS4ylwinDfm+lI7Fw7+xPCrrq/ye9h?=
 =?us-ascii?Q?JkHmmb+dDFWva5sXWZDWnH4H4+GBYuEAhfT69Z59z/+R/SQ7EMkHN2ckeCdx?=
 =?us-ascii?Q?yF83ybJNEhY3JVz1+AFVIVJMELnLjhjp0kIhzO1zLSJaT1LQhQ/uN8sLqPvI?=
 =?us-ascii?Q?/wVge8YUVV1eP+W7vzI/v5pjMnWhk0VmxcPWBAH1OSsetE7wqWuGEo0y2C0d?=
 =?us-ascii?Q?QdV7d5yefdPkseWeJnkheG8c3MiKq55cO52NXVSBPdWIiXhrCJLK/Li71xES?=
 =?us-ascii?Q?5sXx3E0SGNkxI+KWewooUnqdJg+rCgf2+ShEPcC206bniXTJ6/41WUWFpzUW?=
 =?us-ascii?Q?zx4U2rY9kONaPmoYl7xs7qwJ5g8KRy4cBsYjuCl5ALWVny16nkTO7TGJ7HW0?=
 =?us-ascii?Q?hBjrQxdB9u5bBOThWsZHbTYq9Wwc4I0lF02UTiba3tifs6ArHgYOQwRPGdQC?=
 =?us-ascii?Q?uG0XBR+ENlSMhUnlJk/qhzitRLE7j9j0Ao5meqfe+wDdykwsgSpJrPc8FPqI?=
 =?us-ascii?Q?7OpMGwGzpUz/Zyg3u0P/BcDw9nsfvmxvQy+YnkfzI8up6144wJowmK7YBTEF?=
 =?us-ascii?Q?1dHsEYjMPptqj1eI4ZdSdW3+AK9NxE7x2n7WMv6cB0Mzy8nPQTAv4g9ciE7D?=
 =?us-ascii?Q?r83KAqzqA3ApQRdMBLpSXSswshLtxMJhJmBw0WoVG3l1nAtr+qVCM6YFwDJg?=
 =?us-ascii?Q?cq0CDLb3I0m9z+926Hekmv+yes9QLMC75fryxUWsQBLy123Arx5dk4E0HB8x?=
 =?us-ascii?Q?b15DcF7pjn/uvWkxZtIuU3wDtfaG6wt2smzxlEa1kqKiC6+4ZIS5GNEAkkHD?=
 =?us-ascii?Q?rE54dg/N+qSur7u80hoqtqoDpM6Hsq19hz3Dby4/fRrrDuP9ckpdhLG1vnQn?=
 =?us-ascii?Q?ZMomTFUZ6SKnuiPCgdvqHB+e04Pm6/vm2MZNtVrKg/KDD8olL5i2t5AXArOR?=
 =?us-ascii?Q?oI+HUPmhS8Wb9/n6wtjGNDsexDsqubWolRiNkUAvtZX8ml5SAzCqvMgNJQCM?=
 =?us-ascii?Q?C+OcpRnZ3fZ/kc+yHhLq9eO1t9U7seV4lrgn+yxQ6vPaohrVtGay6oVbTakk?=
 =?us-ascii?Q?QbZmRLFr8meZO3QiITQXXfZIOFl2sz15sxPzt1fg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6adb31-7173-4b8e-8505-08da60fc6b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 16:10:47.8979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rIBPFpxnLaPN14FHr9u612qVnzzL2UKhf6UdRRq7qnSs4b/WhQrsOQ54tDST14zXUOgyKUKu+sK3MLe/kfXpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On Thu, Jul 07, 2022 at 08:27:27PM +0530, Akhil R wrote:
> > Document the compatible string used by GPCDMA controller for Tegra234.
> >
> > Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > ---
> >  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml         | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> > b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> > index 9dd1476d1849..81f3badbc8ec 100644
> > ---
> > a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.ya
> > +++ ml
> > @@ -23,6 +23,7 @@ properties:
> >      oneOf:
> >        - const: nvidia,tegra186-gpcdma
> >        - items:
> > +          - const: nvidia,tegra234-gpcdma
> >            - const: nvidia,tegra194-gpcdma
> >            - const: nvidia,tegra186-gpcdma
>=20
> I don't think this works because it will now fail to validate Tegra194 de=
vice trees.
> You'll need to create a separate set of items for Tegra234.

If I update it as below, would it work?

- items:
	- const: nvidia,tegra234-gpcdma
	- const: nvidia,tegra186-gpcdma

- items:
	- const: nvidia,tegra194-gpcdma
	- const: nvidia,tegra186-gpcdma

Regards,
Akhil

--
nvpublic
