Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997E61B192
	for <lists+dmaengine@lfdr.de>; Mon, 13 May 2019 09:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfEMH5K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 May 2019 03:57:10 -0400
Received: from mail-eopbgr1410139.outbound.protection.outlook.com ([40.107.141.139]:40573
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727914AbfEMH5K (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 13 May 2019 03:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCubA7wcxUXNDADIJ7ouIewx9sQQyGE+5bjOBZHeyOA=;
 b=R5HI3sIFxxvqcJqLn83WMVq5kUH7nwxZvdAr66eUaGIHdZrXb0kAyM/ols1eILpXDMSvgI5gTi9MxQJJKA1hhoulZXYi+pZQo0NfHpcopY3kCARhIaBMfKTvMxMXwZ5warzNVMC+vGMn/GaCVD0tPsXyDi/B4UiX9xmcMimjeYc=
Received: from OSBPR01MB3174.jpnprd01.prod.outlook.com (20.176.240.146) by
 OSBPR01MB3333.jpnprd01.prod.outlook.com (20.178.5.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 07:57:07 +0000
Received: from OSBPR01MB3174.jpnprd01.prod.outlook.com
 ([fe80::f873:6332:738d:7213]) by OSBPR01MB3174.jpnprd01.prod.outlook.com
 ([fe80::f873:6332:738d:7213%3]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 07:57:07 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Simon Horman <horms+renesas@verge.net.au>,
        Vinod Koul <vinod.koul@intel.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: RE: [PATCH] dmaengine: sudmac: remove unused driver
Thread-Topic: [PATCH] dmaengine: sudmac: remove unused driver
Thread-Index: AQHVBmYUs4O0Dq2sV0yGUFPTpg0f96ZoterA
Date:   Mon, 13 May 2019 07:57:07 +0000
Message-ID: <OSBPR01MB3174C44D415A0748033AD2A1D80F0@OSBPR01MB3174.jpnprd01.prod.outlook.com>
References: <20190509125211.324-1-horms+renesas@verge.net.au>
In-Reply-To: <20190509125211.324-1-horms+renesas@verge.net.au>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffe73c73-bd87-456e-2f19-08d6d7789898
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB3333;
x-ms-traffictypediagnostic: OSBPR01MB3333:
x-microsoft-antispam-prvs: <OSBPR01MB33330839A649E03D03A7E6E6D80F0@OSBPR01MB3333.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(136003)(396003)(346002)(199004)(189003)(86362001)(478600001)(186003)(74316002)(6436002)(5660300002)(476003)(26005)(486006)(81166006)(6116002)(99286004)(14454004)(81156014)(76116006)(256004)(3846002)(4744005)(33656002)(53936002)(6246003)(4326008)(25786009)(8676002)(71190400001)(71200400001)(8936002)(66946007)(7736002)(316002)(73956011)(102836004)(305945005)(2906002)(7696005)(66066001)(110136005)(54906003)(11346002)(6506007)(55016002)(68736007)(9686003)(76176011)(64756008)(66446008)(229853002)(66556008)(66476007)(446003)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3333;H:OSBPR01MB3174.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tpKX9O9u7VkzdQ/cTrL/GC9TgeL1AzaTa41fRzewN5l0MrkgPPVPUOFldSAQvsyKSMX/hpAb0OzMaV2AC8GrdmcFT1QaokBGnqt/worOmOz1AzcB/ZgbzYqL4wuOb6UUXOiF69/XQbEXpGRxKUJdYrfvbJL6BfyhnuVdN/+47WqJg9J+puxikXlEgUHq/nMoyTLzMYjYSCGbJGJXr6gd4awpqHNFcbL3KbCm9Dr6ekVZzhw0toffy6WuAU7jrKMXvbYZZqy4nl4rDhGDx1yHGLC7RZ053zn9TajX33qZrrJavM34i4/umfd+71w2cPylwYhmaUqXXZ0A3/b6Vdl5s9t7SbzOy+XPvcXmYQPxA6o+GwVg7+pCegLCn0Mo9ye1VNTeSeY8Jn/rK/jU3lMlEmnlKRcjuB7+GRUhGujeZWo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe73c73-bd87-456e-2f19-08d6d7789898
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 07:57:07.3912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3333
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Simon-san,

> From: Simon Horman, Sent: Thursday, May 9, 2019 9:52 PM
>=20
> SUDMAC driver was introduced in v3.10 but was never integrated for use
> by any platform. As it unused remove it.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thank you for the patch!

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

