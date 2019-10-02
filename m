Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D06BC8AA0
	for <lists+dmaengine@lfdr.de>; Wed,  2 Oct 2019 16:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfJBOMN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Oct 2019 10:12:13 -0400
Received: from mail-eopbgr760054.outbound.protection.outlook.com ([40.107.76.54]:31099
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfJBOMN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 2 Oct 2019 10:12:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjqB7cJxeQQtK84pfrgAVAyhnVrP+w7ReMshVBkOv60Y3vXxbq2UMVmBbQsNMULTjxdLOPqnvcdFvld7XtF+wSLjTJqDHEni49ncdrEpbucnpsMkXTUn0v7f5KR9qX3asoEUPpjy5IzE7/IeCKeq+lwz3LKMkgeygUCNF5QutnRijypXbMZ5RsIA5rBm1YEZaq+BosywywRTwMrevIIrnd1rHsy5DY90ketN4ISGWQqMEB+QkmKAIFWjgqxKlZGIpKClQRLl4Q00LZoD+8692pU92eGV9STJM1hifDOecdWYlavD1OtHmLML2/A5rGBV/8shM6bEnInd04yp6s9uDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xObepoDVfyH4Ze4N4vbZ38xPys14l70MGGhww5kd60=;
 b=IVsVWVGs1FHfyfzwOMRUBnzA/FChbEZLkNADMA7XXt/q2TklZIKPgPpUxgkL5SIxW1TE3AyaLqePbnfX67vmqa70pqfYhm/ZmHKPUb3beOUMHt6On3dGa7mY+YVIyMb/Prp4kVkmdwUfZXeV1FNY/WRv1EHym8bfPaQrzpY4uTHrAosgDAs90X3JH0GMv4KmOGwZLiKtfp7+/oHEAhk2eI3I2XrWJGqOyZBaaYLc7GymFH18z0J+6PyzSzg2c9bIEQbgf9Xd+zam7+Nx6v5RvGznpwvXL16los8b2Kwz2Zx1D1QoMjsaf9qhwmeZJDp9LJR5zJ3Bc3K5TA1y7ennLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xObepoDVfyH4Ze4N4vbZ38xPys14l70MGGhww5kd60=;
 b=n/w3Yvl5Iz9u1idvBFzJmsezXT0nOnQP4xQUzDnEGWou6ahbLfzqMAMgFexpFYF00sM6t4IdNu5HIVUD/DMVRj72hjhzyBrGK7nUnooC0cJsOMDEqAeTzmX2PhFDrcI7ss62kHeXyyLuVkrBcUWajBYlViNR3VdKlZyE2dHgCrI=
Received: from BN7PR08MB5684.namprd08.prod.outlook.com (20.176.179.87) by
 BN7PR08MB5217.namprd08.prod.outlook.com (20.176.176.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 14:12:10 +0000
Received: from BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::f0ca:4368:4e6e:6f18]) by BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::f0ca:4368:4e6e:6f18%7]) with mapi id 15.20.2305.022; Wed, 2 Oct 2019
 14:12:10 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: dma_map_sg_attrs() time consumption not consistent
Thread-Topic: dma_map_sg_attrs() time consumption not consistent
Thread-Index: AdV5KRr2pDl8tJdoR4KQGu3cJ+BqMA==
Date:   Wed, 2 Oct 2019 14:12:10 +0000
Message-ID: <BN7PR08MB5684D50621234D24E29FFED6DB9C0@BN7PR08MB5684.namprd08.prod.outlook.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYmVhbmh1b1xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTliNmUwMjcwLWU1MWUtMTFlOS05ZTJkLWI4OGE2MDU1NTMwMVxhbWUtdGVzdFw5YjZlMDI3MS1lNTFlLTExZTktOWUyZC1iODhhNjA1NTUzMDFib2R5LnR4dCIgc3o9IjU3MyIgdD0iMTMyMTQ0OTkxMjQxNDU5Nzc3IiBoPSJaYVRqYXp1OTlBUkpvZENYejFJbFU4RXBJUDA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.80.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3d32a37-bf5e-421a-7fb9-08d74742843a
x-ms-traffictypediagnostic: BN7PR08MB5217:|BN7PR08MB5217:|BN7PR08MB5217:|BN7PR08MB5217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR08MB521756A0A5458FA826C1AA87DB9C0@BN7PR08MB5217.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(199004)(189003)(66946007)(71200400001)(71190400001)(81166006)(2351001)(81156014)(1730700003)(305945005)(14444005)(8936002)(256004)(6506007)(55236004)(102836004)(2906002)(6916009)(25786009)(3846002)(6116002)(8676002)(74316002)(9686003)(33656002)(2501003)(55016002)(76116006)(5640700003)(4744005)(316002)(186003)(14454004)(478600001)(26005)(86362001)(7696005)(4326008)(107886003)(66066001)(99286004)(7736002)(64756008)(66446008)(476003)(486006)(66476007)(66556008)(6436002)(52536014)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB5217;H:BN7PR08MB5684.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0z5Zu/AsJfc7cBUbUois/QAsfyMx7rnvotmcZ3gUmWzuVBrkRUTQ0BPPyCUCtT/sTl0xhYsmtdIT4xY1jgwWdTO2nKT9+uSavMs0lO4xngvXmqQDJC5WaTWhxA1I0gDWrZJq/SrQVL/USE1raZ1t0mWNLf/h3zHbsihuLoMGT2LfWoicLUU5RJyb9qJYBsrLhhf6C4aOr7IeYc4KV176nHvTUbkYU6LH2RwLkf2rym4SEaaluyUmZYzFN5QbjVx2SyRM7vYhN8prBGqotfZkjKAiDPmZORcrNp1Zbzc4ydpEXCcV3dt0GzmjT7KpcJp9bbpeTtvvlpohNXuDmvSc0Y11S/FCihl4ph082SEuGJ6IX3znavCKiFknYFGU3SiiZAO4POmeyoen0JU+X2voNSwrLBBro8OQgwIosJQ2zE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d32a37-bf5e-421a-7fb9-08d74742843a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 14:12:10.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYeeepKxPTTMWtbmyZvf+XgeI4ZAfy22erTBJLubfzIt3WKM0q1ugsXYOsuy+85WQONrWbBm7ap3PayrWxSTWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB5217
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,=20
Recently, I experienced a problem on scaterlist DMA mappping. It is said th=
at if mapping 128KB data length for DMA tranfer,
when I enable jbd2, dma_map_sg_attrs() will take more thant two times of ti=
me, comparing to the condition which jbd2 disabled.
Somebody suggested me to print out  DMA entry to look at what happening.  I=
 studied dma_map_sg_attrs() funciton a little bit,
But don't much clear how to print this kind of info. Is there anyone who kn=
ows this?
Thanks.

//Bean

