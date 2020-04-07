Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF751A10ED
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2020 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgDGQD4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Apr 2020 12:03:56 -0400
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:45249
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726930AbgDGQD4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 Apr 2020 12:03:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngbi+IJ1UDwyTEHeRR6zXJoPe8ZazGcskskhtzlr9qKNNSQD5ABQxtRSFJAQMrrt7xNA2sBbY8WVNhbf8CA6e4sJV1a4y1H1DuFavWwJpwfcjBc9osudh+BpP6cZwxPn18nT+LpipMm8AaFatD/m3QpOpwxdObDcXCoKSYFAlCD8n1zEZ3O1wAcGGzD6Ja1ufofAo1RFWnRRZgFGFNdbLxPSdsfs2MuP0pR+gbHLR8MZ7MOeVRUe5lJGwAsaH145AAXsXpZn42Gfml8jDFn/ljuUmkF5sRt3rvji3Jh+spZpb/TgcejgBTovxSijD9hjNfi54e7xJZ0Zi+TA7C7DhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogY6//qITR4DXLbcSznmHsM/WIqQjonda4U9/6hXjrs=;
 b=oBm6UENtTr1tZLlHsPpG/4eW+7WQXPKQEnOH6BImTKjauFtfyAK5KxSledEthDyt/++sq5a9wErT1PAUixIBkDRCgA+BV6S0A5VDNOyZ+oYEMyhWholDBdll1c/9vL+IgUOpKDAc3l4vt5Y1+kAoIfh9bXXYpu9Xu/qtOJscGyiXBEERUij9P19Sa6zQ4hr5eXxPYHW1XHXoHw+CZH72XZltdeSXHLzw4+i7FrKDY70KCMrj/zJP70X1bBt2ULd0SnHDczBewWsIXFiorxjjVRl/KwYZTjeWuoWu67JjrU122Yu1yCMGJR5X3z/WUrNhu0npZ34wjaMsPSMzf442aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogY6//qITR4DXLbcSznmHsM/WIqQjonda4U9/6hXjrs=;
 b=J/Y2eLRFsS6A2TlGyLA6n7PB0gF++UL9BdCGXQkiYPB5G+YQ8Fdr83kUAt7Bwizk45gIxj3U1XqaB8h6E5bstld/s8nwesJpZwK5f5WDnszDV4DTfxTPWyqAoLyn6SZiNMS1BiETlR1k04uh9jK4wCCU9EW+DBsqY3M5gEMNJCs=
Received: from BYAPR02MB5638.namprd02.prod.outlook.com (2603:10b6:a03:9f::18)
 by BYAPR02MB5752.namprd02.prod.outlook.com (2603:10b6:a03:122::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Tue, 7 Apr
 2020 16:03:53 +0000
Received: from BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::71f7:ef60:ce:9249]) by BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::71f7:ef60:ce:9249%6]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 16:03:53 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Sebastian von Ohr <vonohr@smaract.com>,
        Vinod Koul <vkoul@kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Michal Simek <michals@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Index: AQHV87v41lTd1EQv20WfWLzX9IzVjqg7kQjQgDHqXwCAACmBUA==
Date:   Tue, 7 Apr 2020 16:03:53 +0000
Message-ID: <BYAPR02MB5638F1A9A1B68C0FA534E07DC7C30@BYAPR02MB5638.namprd02.prod.outlook.com>
References: <20200303130518.333-1-vonohr@smaract.com>
 <20200306133427.GG4148@vkoul-mobl>
 <CH2PR02MB7000C592992EEFBFB01D5735C7E30@CH2PR02MB7000.namprd02.prod.outlook.com>
 <c12c2321f9d5407698b9992b9a375966@smaract.com>
In-Reply-To: <c12c2321f9d5407698b9992b9a375966@smaract.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [117.217.117.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0295f481-0d9c-444f-2855-08d7db0d44e4
x-ms-traffictypediagnostic: BYAPR02MB5752:|BYAPR02MB5752:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB575222AAB016DE7361F012EAC7C30@BYAPR02MB5752.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5638.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(6506007)(66446008)(8676002)(53546011)(76116006)(81156014)(64756008)(66946007)(8936002)(55016002)(66476007)(66556008)(81166006)(9686003)(7696005)(86362001)(33656002)(110136005)(6636002)(2906002)(4326008)(316002)(478600001)(5660300002)(71200400001)(26005)(186003)(52536014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Flaq0mLmeIl4QY+oewa6GRdJc/qcogT7Y7qrBjNYJWXtFZJb6It26nOyvm4ZxMek2T60Jr8aiBaGCLNAW1BukqKPXT3vcPLtb8XAZlcu0UMPfHpamQ0dDP0P23JmiU4hvjsU7FqD+3lN4UB1lL5J3+4upLWonwvMeVU2Via1ZaY5Rx4EWRag3qjjouNPNEAcMdJH4Rf8QgXW5A6NfG7W03GOrF/aZh/NTMxHSn1oU0T0kLGgm2Tt3ecleUPXrElUQQb3X7MP9ap2CRmuSSIekpycGHuHPQncKcQQ0ytJigj/7Lt6PMDNYGtTtw3KQc00UslqLrbyoLsSoNlAW7fjoThmXcAwYJHFlGQp66jMjAj1jINp76Im2BE3LUblMfFqyr2YG0OVWggoxscbnVTneDPC9qB/jW3Pr5356BC+HGnOL7uVfK4DDy/2RHT+JNVh
x-ms-exchange-antispam-messagedata: BQh9s4yqftPPDLdrWxPr3PCsFV+iRKDaV+hTNJeoMM3R47Ed8accbwq6RN+V9UpD5872YKhSCubb063yj8ODfFzRLUjSVhA6ekgEp0jz1TQIaOTa5Xp3/CUbt4Pk6tIuLk3MTXKbe1er5cnaWAk+5A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0295f481-0d9c-444f-2855-08d7db0d44e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 16:03:53.1786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPkRfVYvVqZeRgLg3QQHNrMJHzGqkE9MJlJ6ZSILCfbvp1pfszQal3WhQjnQ4AcQLetTksbXe96M2Bdkm4LOqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5752
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Sebastian von Ohr <vonohr@smaract.com>
> Sent: Tuesday, April 7, 2020 1:22 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>; Vinod Koul
> <vkoul@kernel.org>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; Michal Simek <michals@xilinx.com>
> Cc: dmaengine@vger.kernel.org
> Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty
> list
>=20
> > -----Original Message-----
> > From: Radhey Shyam Pandey [mailto:radheys@xilinx.com]
> > Sent: Friday, March 6, 2020 2:57 PM
> > To: Vinod Koul <vkoul@kernel.org>; Sebastian von Ohr
> > <vonohr@smaract.com>; Appana Durga Kedareswara Rao
> > <appanad@xilinx.com>; Michal Simek <michals@xilinx.com>
> > Cc: dmaengine@vger.kernel.org
> > Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for
> > empty list
> >
> > Sure, we will test it. Changes look fine.  Though had a question in
> > mind, for a generic fix to this problem, should we make locking
> > mandatory for all cookie helper functions? Or is there any limitation?
>=20
> Any progress on the testing? If you need help reproducing the issue pleas=
e
> let me know.
Thanks for reminding me. Somehow I missed it. You mentioned in one
of earlier thread that this bug is introduced it using dma_sync_wait to
wait for DMA completion. So to reproduce the issue in xilinx axidma
test client I have to replace issue_pending with sync_wait API?
