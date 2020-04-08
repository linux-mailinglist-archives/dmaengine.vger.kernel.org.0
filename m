Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA051A23C3
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2020 16:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgDHOGv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Apr 2020 10:06:51 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:39596
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbgDHOGu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Apr 2020 10:06:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU/nXxklCGYZf6cu+u8iCe0b1X4C5Q5lS2c39ddOMF1RYpNNWcTNDicLkmrXy87r3ktlnkuMNgKEoayrqbc/8KB7vTdv8dOYKmXksB4TwPXbutDk8A1XSPU5sABqJBEds4Xtl7kKohuwzbtDiu8GZOCwwKOdBKC9uO/RPH3hqQqZ8E3/oqQvbOhNdF5SZVrGsb7lvGBL97ueZH9ctf8s/ZxD/ok6jWdmw6WlS7aQIoRIF6IPCN6REvwOQ3RsQnRNnlo/znLCCJM2zLxWfbDjWklbqF0/KXZDAYX0TqAdWjUzusmliR18Q4dGKaDBrO9UZPQjVjmhMpJ+f+Wkf+xs6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrVS9b90n2ehaIDFEV3sRInKkInvB0h3YgEYDaMppBM=;
 b=Q+87uveZtlsZHjmLG6aQVLyiFhI/DpwntKA1NJ7dsXZKPRYowbGP52F+G/fiYe5Rsjrge/8MwuFl30UyyLKk31jhw7tsDfbN4usXEqP+HDNaHZcwfZ73lG9U2rR5XfGf7q9uznlGC9lUpXRP31ePr/gfERmcGE3KkNw6I+JXb3nxlyvxbUZCXneATAizFfG2Un6lT5en+3uA7iP+wcZRCHYH55aGUbUwM80peuQWHFAkcOSBwaS5p5yMJBtkbstGhsUssCedZWVb9tls6Wf4teV/rmoFJkhtNrPNJ2DCr95XIZBmqTWxieoo70Pt4JQBNjfpdIX5GPUsouZczr8ikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrVS9b90n2ehaIDFEV3sRInKkInvB0h3YgEYDaMppBM=;
 b=URr5uE3sjQnOdIDiKT6u5tsJR4HdOM86fKuu5RCrhnWk9SeTKatPEuiL6uLk6lcFrzb9LDVIZhvIH1zaki+jD3W0T71G9DP3xasGINy6sCyA8i26zf4DKILnRYOiSkrHsBflbxK6XoHMQbgDLdAmVNWuhsymJkTxgiK0cj1UEFQ=
Received: from BYAPR02MB5638.namprd02.prod.outlook.com (2603:10b6:a03:9f::18)
 by BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 14:06:44 +0000
Received: from BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::71f7:ef60:ce:9249]) by BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::71f7:ef60:ce:9249%6]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 14:06:44 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Sebastian von Ohr <vonohr@smaract.com>,
        Vinod Koul <vkoul@kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Michal Simek <michals@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Index: AQHV87v41lTd1EQv20WfWLzX9IzVjqg7kQjQgDHqXwCAACmBUIABXaGAgABwzYA=
Date:   Wed, 8 Apr 2020 14:06:44 +0000
Message-ID: <BYAPR02MB5638DED4EF67EB842164DB0AC7C00@BYAPR02MB5638.namprd02.prod.outlook.com>
References: <20200303130518.333-1-vonohr@smaract.com>
 <20200306133427.GG4148@vkoul-mobl>
 <CH2PR02MB7000C592992EEFBFB01D5735C7E30@CH2PR02MB7000.namprd02.prod.outlook.com>
 <c12c2321f9d5407698b9992b9a375966@smaract.com>
 <BYAPR02MB5638F1A9A1B68C0FA534E07DC7C30@BYAPR02MB5638.namprd02.prod.outlook.com>
 <c0883a291b5940b6b1ecb14b072ffc15@smaract.com>
In-Reply-To: <c0883a291b5940b6b1ecb14b072ffc15@smaract.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [117.214.116.44]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acea2743-0079-44af-f3a5-08d7dbc611fc
x-ms-traffictypediagnostic: BYAPR02MB4886:|BYAPR02MB4886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB488686A190B05B24425E75FFC7C00@BYAPR02MB4886.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5638.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(66946007)(71200400001)(76116006)(66446008)(64756008)(66556008)(66476007)(5660300002)(6636002)(7696005)(55016002)(186003)(26005)(6506007)(9686003)(53546011)(478600001)(4326008)(2906002)(110136005)(8676002)(81156014)(86362001)(8936002)(316002)(81166007)(33656002)(52536014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MpZcAdQD06tnVIvkkY+QhJIMKt9/Mf4Vl9mM4pslgF17HD4356Qdtt0QpyMcJry9T34+1pju0zK639NzZWjwmvOW7Ta0ErECfXgS31sIrX7uZBYQQ4cCipBvlIcLE4WZ0eM6xEy1ZueND2aj0f5YJ6Tdz9M1zwFLkcj+9UHrY73w01BPki/q73v7IqyZTCOgU6uZWXBZ9iTT/wBpQ9vbTR+L7pIqi7ZQ4rkcuBKqVupNTeVsEDOLX6Hh6Yl++SPoqIC1mh2kjwj5KdKeO5MgMBugsBWpQWag4awvWWj2BhH/wEq446QAN3g/1aqGzDFumK2L7xYUemX7nNzrel32cAsv/GwY+54KaTjUtGiygmEmBuS4cbUSywBxJX2z6+79+TpZbVDVAIlfqsyTIbuhuNuckbb6oev1eLROv3Rc/3Lgw+FnYxdT9W/GlleujOmD
x-ms-exchange-antispam-messagedata: K4m55nMLxn1malVmVMhDqFGo6RWyqHs79y/gl1mLnc0Up2wBs5/gKKXhBStm2oSe48Ow1E1l6gmyvSAknT+dhp18BrW8srP1XhkQDLKJjuEhZZC2Fop71gmjk5eBpPfqhJJTqFvVODeRfGwV2Ik+5A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acea2743-0079-44af-f3a5-08d7dbc611fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 14:06:44.6573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJ3Bu0IvSFVzlME2DMp0YSWoQFX0CbOfWWXBdfobKHFM/ebZQz4TAVWCdgSro9wa9W+GOn/Yf5BOGoKG0zPfWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4886
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Sebastian von Ohr <vonohr@smaract.com>
> Sent: Wednesday, April 8, 2020 12:42 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>; Vinod Koul
> <vkoul@kernel.org>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; Michal Simek <michals@xilinx.com>
> Cc: dmaengine@vger.kernel.org
> Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty
> list
>=20
> > -----Original Message-----
> > From: Radhey Shyam Pandey [mailto:radheys@xilinx.com]
> > Sent: Tuesday, April 7, 2020 6:04 PM
> > To: Sebastian von Ohr <vonohr@smaract.com>; Vinod Koul
> > <vkoul@kernel.org>; Appana Durga Kedareswara Rao
> > <appanad@xilinx.com>; Michal Simek <michals@xilinx.com>
> > Cc: dmaengine@vger.kernel.org
> > Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for
> empty
> > list
> >
> > Thanks for reminding me. Somehow I missed it. You mentioned in one
> > of earlier thread that this bug is introduced it using dma_sync_wait to
> > wait for DMA completion. So to reproduce the issue in xilinx axidma
> > test client I have to replace issue_pending with sync_wait API?
>=20
> Yes, dma_sync_wait triggered the bug for me almost every transfer. In the
> xilinx axidmatest this is probably best achieved by adding dma_sync_wait
> before the wait_for_completion_timeout. I encountered the bug with your
> xilinx-v2019.2.01 tag. On this tag it actually crashes the kernel with an
> invalid memory access (because the residue is written to desc). With the
> current driver version it probably seems to work fine. You might have to
> add some debug print to verify that the active_list can indeed be empty i=
n
> xilinx_dma_tx_status.

I tried with xilinx-v2019.2.01 tag and added  dma_sync_wait before wait_for
_completion_timeout still the bug is not reproduced. I guess it's difficult
to reproduce as it is dependent on actual timing on the events i.e tx_statu=
s
checks for cookie status and it is not complete. Then soon interrupt handle=
r
is triggered for transfer complete and it updates the empty list and when
it is again accessed in tx_status it results in data corruption.

But just to ensure that I am using the same sequence is it possible to shar=
e
the patch for axidmatest client?

