Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D832EA8001
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 12:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfIDKIG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 06:08:06 -0400
Received: from mail-eopbgr1400133.outbound.protection.outlook.com ([40.107.140.133]:6208
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbfIDKIF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 06:08:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvnQAfZUsepXvi2M/nvPJYL/jj93MSzBw3SkGFBV82Q4WWOBMqJBrOGSDq5iR33x6ANuDxu45IRWkNLvESbR4O5x4J/fWVkOYLr6W2fbdk70p19wbjCyIyft1Z8lg4VcssO3e6dEQ4Li30daON4w2njUhgKtCC3Gx+es82+Pk6o2YG4gPEut+CSVuWhfDvJy1t7Gegt09BUACha1git47MbDuPhnTnHpV8wagDBRYR4egxgsG/g4arclZpYNC5ET1q7bBVCQEMClB6HOry25VwCN6XYeK9kedEwLmKpVWdjpJb4mZIhWnbLM5BQYJNbmCG2sTmv4xRk96bDvbGmecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7MHTJfSUYkduo8eheebe3RVjGzdAYMfNGCPCAAng3g=;
 b=DtOsW75M4Q+v6QDju+0cB9/l/dycOmbodLYbSk+ZSohiYxq6HNAVi1rFcR1e5Uhoh9qFf2zfqKGw7OiVaC122XLgV7fi5aQaBvmxOyJLkHfRr7yYL6hrTMZe0u5fZzI+ddRA1W65goy/qy9IEQj0qA2urzQwYC+/QZOVBUGf/Cwq+UIfQ19mVBz36c7UriyXfNDSxSstrDQ5ZnYLGJzvvKA33b0W5IFkITSyaBZGtfXGxCnWrgqQisfgNAxPcDrNOj2FRtzjhNLs3Kxq7UFmxHbIiU9HYUN/qQjsw9ES3BylT5LS928h6FCeh0pbMxktu9ExOMmsX5hLceKK0Yoq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7MHTJfSUYkduo8eheebe3RVjGzdAYMfNGCPCAAng3g=;
 b=YqT4TbPgKj7QnFVxri7cM9FZo1fBwKoHozbtwBBG7Xn6qU4nl2IQV9hVCRvb41pLzEXANrcF2U2Mrl7VRKx4603CP59cyLp5b58l7G3zJn1WCPYUPvBVwPoycP9lQxBFb9kXXuC26JKXGsRAUYz7y6MLCYn5njTh2cbPStz5scM=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2256.jpnprd01.prod.outlook.com (52.133.178.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Wed, 4 Sep 2019 10:08:02 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 10:08:02 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] dmaengine: rcar-dmac: use of_data and add
 dma-channel-mask support
Thread-Topic: [PATCH v2 0/3] dmaengine: rcar-dmac: use of_data and add
 dma-channel-mask support
Thread-Index: AQHVYvoyWfCfeUsgYE69NjZs5BVH9qcbQoCAgAAEbOA=
Date:   Wed, 4 Sep 2019 10:08:02 +0000
Message-ID: <TYAPR01MB4544C3A8C8F3E5559E903A2ED8B80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1567585478-23902-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190904093629.GS2672@vkoul-mobl>
In-Reply-To: <20190904093629.GS2672@vkoul-mobl>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2b00f5a-84a8-476b-2a04-08d7311fc5b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB2256;
x-ms-traffictypediagnostic: TYAPR01MB2256:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <TYAPR01MB22560DF414704A9E74862C16D8B80@TYAPR01MB2256.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(199004)(189003)(6436002)(33656002)(25786009)(7736002)(2906002)(71190400001)(66446008)(71200400001)(5660300002)(4326008)(99286004)(66476007)(66946007)(64756008)(102836004)(478600001)(66066001)(55016002)(11346002)(6916009)(66556008)(7696005)(53936002)(86362001)(966005)(53546011)(6506007)(26005)(76176011)(186003)(52536014)(14454004)(9686003)(446003)(229853002)(6246003)(486006)(476003)(305945005)(54906003)(316002)(8936002)(3846002)(81156014)(81166006)(256004)(6116002)(74316002)(8676002)(76116006)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2256;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wz7Pj5vauSb9xbdl/U3JKI7W00zNxsb9spCnCdy1bYeMShxre+/PNqpiycQFWseicKmvnUTenz2G2sKzCtKMJOb7D8J4JAvJL5dqGEJMA7NaIug1q3sfCUZ614u6B51E/8QFuOaJZo1j3p9+4NDP2Ftz5GmAlPOb+wn4HIdnBDXE6ALk1rADtiK/kZTrgb5cljLWv8DyryEMiTg7xVLx1g9xcxOfHheL3FDtAXG1rfRfpCowbfF+7A6JpzalmPJ5+K3TPIly0rYXNFnDNAj4VTQ5w93/iywK3VYg0P7A/h+hybqh1DnR4TqpKINfIaMFwuQm/3ZdZ4m5Nq/D683aG8PB13Btvk/OvGBYD9zednc9EAWuKwzwz39A6pybCi9tzwJL2UGNm0UKj/ChMfgmkVR0pR9b2JPdBIflffbe534=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b00f5a-84a8-476b-2a04-08d7311fc5b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 10:08:02.4809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1oxF91DGJSZGajwpX098U+PXefPmBL8F5GSR604uyiSEKp6rcuJi1KtT6yy+VFNuJBdbaTzsfr2xn0a4Pe6p7d7NdijgWYftRMmgoDtShGHoCXN5n/8753qvGO4yUqk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2256
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

> From: Vinod Koul, Sent: Wednesday, September 4, 2019 6:36 PM
>=20
> On 04-09-19, 17:24, Yoshihiro Shimoda wrote:
> > This patch series is based on the latest slave-dma.git / next branch an=
d
> > merge the latest slave-dma.git / fixes branch. This is because this pat=
ch
> > series depends on the following commit:
>=20
> Well it should not depend on fix which is going for 5.3 and the rest for
> 5.4
>=20
> Can you please rebase on next and send. This doesnt apply for me

I'm sorry for bothering you. I have a question. The patch 1/3 [1] and 3/3 [=
2]
completely depends on the fix patch [3] because the fix patch added
a new member and the patch 3/3 used it. How do I handle such a case?
Should I wait for submitting this patch series until v5.3 is released?
# If so, I think this means this patch series will be merged into v5.5.

[1] https://patchwork.kernel.org/patch/11129607/
[2] https://patchwork.kernel.org/patch/11129601/
[3]
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git/commit/=
?h=3Dfixes&id=3Dcf24aac38698bfa1d021afd3883df3c4c65143a4

Best regards,
Yoshihiro Shimoda

> Thanks
>=20
> > ---
> > commit cf24aac38698bfa1d021afd3883df3c4c65143a4
> > Author: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Date:   Mon Sep 2 20:44:03 2019 +0900
> >
> >     dmaengine: rcar-dmac: Fix DMACHCLR handling if iommu is mapped
> > ---
> >
> > Changes from v1:
> >  - Combine two patch series into this patch series.
> > https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D1=
66457&state=3D*
> > https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D1=
66457&state=3D*
> >  - Remove a patch because updated patch is already merged into
> >    the latest slave-dma.git / fixes branch as described above.
> >  - Add Reviewed-by tags into all patches.
> >  - Rename a member of rcar_dmac_of_data.
> >  - Just ignore the return value of of_property_read_u32() for dma-chann=
el-mask.
> >
> > Yoshihiro Shimoda (3):
> >   dmaengine: rcar-dmac: Use of_data values instead of a macro
> >   dmaengine: rcar-dmac: Use devm_platform_ioremap_resource()
> >   dmaengine: rcar-dmac: Add dma-channel-mask property support
> >
> >  drivers/dma/sh/rcar-dmac.c | 47 +++++++++++++++++++++++++++++++++++++-=
--------
> >  1 file changed, 38 insertions(+), 9 deletions(-)
> >
> > --
> > 2.7.4
>=20
> --
> ~Vinod
