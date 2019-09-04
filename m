Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0906A7B5E
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 08:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfIDGPB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 02:15:01 -0400
Received: from mail-eopbgr1410114.outbound.protection.outlook.com ([40.107.141.114]:43328
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbfIDGPB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 02:15:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwwCdDKaHBSpDx2/F2MCszs6ozYNZYEhS9vxvU4soxypLk0jLTfhP+5snQqdKxcvcpUI+3tJrUVTFliLsQ5hIt57Gz1J9EL1I2NZAWdGkmr4QvVzKETVKSdYhdu7d1n6bQf65wKR8iLdztgksY/TuR8wsrIAskmNYa22IJGANuAb8IGOwPRoU86zxWl27uTYLn06rQ2F8k3iqo3L1DkM1V1huu9ZCH2kWCRsw0s1BmSvsEwVSl11/40QIwu0NGFd65iOYsyhGY5BZFNRgofj9RA/xhH/IAKLvtVBKHAWu/6QwyVddJdN07bBzc4G5vh1dfUj/Tj1Kqtprw09qtQCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbYvSpkV4yGodz19q9O3Xsynhg20Ck3IiPgThZWa9dA=;
 b=ng6utsVjY16Lzu3sd0g248pSu8tx/fQWZhNRQNOu5R4I1eMxJF1o1NhQ86fzv3RDFWWxmjaV7tqXR/8GTQizazMc8oCKL02aZZEWcFl/7YKD2IMuYKYMHqWGxLYzW5LNwMddbJmswKW0o/lTNxc+ta4gpWyMpIfOiMvGfvFhch9IziHhN09bPNO0ZP30dseRFvS7yXUOoGWwX2FvkVNI43w4nHe8lpvDG3tpMDCPlM5luLDCmoecPuzSEiVt0XmIVva4TJGU83P/0S1okxDak51ssduyPIrcuh5Z9uhNYwnqu5Df4qFDUJvg3P2JWi3QxO0HFh2nXcgCBl9wRFZVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbYvSpkV4yGodz19q9O3Xsynhg20Ck3IiPgThZWa9dA=;
 b=iGxZhiDp2iIy+BcWkjeyoqTj0SLLeLC99UHgXKSV+sEZT4DdPdW4bN27zl0uxTQwtp/BmGgSPylv2DL/TcvxANtVUL/KwqX/gjUQZU02SMAqyb4OZ/3i+Vm1vWFOdM9/G9sDxnwybWKTDR2oFCSBy4Xl20ArXatXwA8StJPZIdk=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2048.jpnprd01.prod.outlook.com (52.133.179.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Wed, 4 Sep 2019 06:14:56 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 06:14:56 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 0/2] dmaengine: rcar-dmac: minor modifications
Thread-Topic: [PATCH 0/2] dmaengine: rcar-dmac: minor modifications
Thread-Index: AQHVXMhHUZJIStNXp0ixtQGHtUkZ3qcbFS2AgAAAkKA=
Date:   Wed, 4 Sep 2019 06:14:56 +0000
Message-ID: <TYAPR01MB454461A61EE21E891FF171B5D8B80@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1566904231-25486-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190904060955.GG2672@vkoul-mobl>
In-Reply-To: <20190904060955.GG2672@vkoul-mobl>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce65a3e9-33ac-41e0-7758-08d730ff3566
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB2048;
x-ms-traffictypediagnostic: TYAPR01MB2048:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <TYAPR01MB20485967C9EF157BFB58D051D8B80@TYAPR01MB2048.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(76116006)(14454004)(256004)(74316002)(66476007)(71200400001)(6506007)(6306002)(966005)(86362001)(66066001)(478600001)(11346002)(5660300002)(316002)(305945005)(486006)(186003)(53546011)(6436002)(446003)(76176011)(6916009)(99286004)(2906002)(66446008)(33656002)(53936002)(7736002)(4744005)(102836004)(64756008)(7696005)(9686003)(25786009)(6246003)(66946007)(3846002)(54906003)(6116002)(26005)(4326008)(8676002)(81166006)(81156014)(229853002)(66556008)(55016002)(8936002)(71190400001)(476003)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2048;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AJSebpckDxGMocW3uBoCQu5awX7rfVZFUKfasmzmjCvGw7hDrGpgbCOyJlb5vTrgMOpJd3n3IR/flxU+xR+OYtaSS96Bo98KVe2bLl1Ug9LeoXHxufhp3juDQk+ltdRlzZClne+spJPuhV5JtbDTAMWvitoJ4OkIzbprlhFWswyorRe8B28nPRE+DVv1O102s2vQlHVAuBs09wiZ5g2qe1eegZBK+UWZtZkZJWvpgmYPWfUQp8TzcpJsfPr5eIB6KRZOzobYoQGCm74+wBTmA+/9mFu21mTEGFTHfazWOJEOxCIwd/fLWFyEFhsjV/XuGfKqGM6byf9HVRN88ysjmHd6auWBTXy7J3V8XRAy75yLxawDw4INyv+uy3F/9UcEfDPSr6bUpUxanuOU3YNsulIwuSe147JUzwloXf3Rio4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce65a3e9-33ac-41e0-7758-08d730ff3566
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 06:14:56.5706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgQbw5kltKKkdhhOg8QpjU+bbeq4GbMVBEeUhg/e8TQUFqtyqKWrhKicZYLXzoWqC9SWon5F1mkwRc4d6vxxyJXcRKvZeN8XbPyGF1lMVz3O0rkPxGx+viFxjF9vTT9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2048
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

> From: Vinod Koul, Sent: Wednesday, September 4, 2019 3:10 PM
>=20
> On 27-08-19, 20:10, Yoshihiro Shimoda wrote:
> > This patch series is based on renesas-drivers.git /
> > renesas-drivers-2019-08-13-v5.3-rc4 tag. This is minor modifications
> > to add support for changed registers memory mapping hardware support
> > easily in the future.
>=20
> This fails to apply for me, please rebase and resend.

I'm sorry for this. I'll rebase this patch series.
Also, I'll rebase the following patch as one series.
https://patchwork.kernel.org/patch/11118639/

And, note that the following patch [1] is already superseded.
https://patchwork.kernel.org/patch/11118637/

Best regards,
Yoshihiro Shimoda


> Thanks
>=20
> --
> ~Vinod
