Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0326C3A48AD
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFKSca (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 14:32:30 -0400
Received: from mail-dm6nam11on2058.outbound.protection.outlook.com ([40.107.223.58]:50271
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229753AbhFKSc3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Jun 2021 14:32:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaPVJFxdAzpdQZ1zTLdozjX3GrysgqSodPPR/GM+xRW9dNEL3kSg2vtheVXBA7gRZy6by12ctAxa3gNjjWXSAOUL4HZ0NPaF9L9N6ZK0EuKWf/YcNLzWiIi+ZNdkF140C5Np7B/roLdsvY2fCUB3S/yzeA2jkimeamBrSrD4oMFaZmiSqgQ28wKPR/JKbfQHocTaFyB7l5bfV6z6hJMxhFmUlT+qyWGxZ4zKoy41GTFOZHIwfqs1I+4iz04zVYbTwmWEscqXqdgFgNG2VztTLxXNvnJz5lvaFaxuUfnNiyFaBddrn7CcVhLn02n0dOcy46p3BhSQ5DNiDe9qOMcYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=132X75BNOcJB+60bkxR/zHRFpTLQ5uf0oWURnWR8xTo=;
 b=QnFrOsF6KW6cYqL0+TTd5GCoqJ9YfNHHf5cQmXQcHNDe3fXtNZhXuZAYUhq6ypvGNkskNzf/hperIcT9Wtbo9MRiPLwoHUCMEcpS4VAGxJiUoD+zZLsVZaN8oonNn8ZqyQGKW1oZxIALOUlzHMCLV+I/iA0ZZWN3GlapyVf4Pm3NH2nppGHgu1IcDkrVQqF/mkEVGFGJJlWOg8aRfUB944ZATtWtDAYhecNp/9a5gfimxqKj0IK0ZH3Mihwm8BEDL/Q6uInX8zTiHEPZDOeiD2DfgWU1zhVqjnojTpfb+KrQg3emD2zMTiS6Kfch60Ny07EWGi234tkumVl661FS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=132X75BNOcJB+60bkxR/zHRFpTLQ5uf0oWURnWR8xTo=;
 b=SueSuh5SuFlhRgVJcTb58yQs5V+LpfY84aASMOA9TqD7kYrXJ1WwlPgAG/Z+Gz+QObIkPYCY81zgII2sliKj2Q2y/mLip8xCtY/ZDUIaTHOR0/HdjKpCzOiMgORK0y8VrZk9NbVfJnntMUkEaf1cG+gCkmha4xTF0fblfTjImdo=
Received: from BY5PR02MB6520.namprd02.prod.outlook.com (2603:10b6:a03:1d3::8)
 by BY5PR02MB6404.namprd02.prod.outlook.com (2603:10b6:a03:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Fri, 11 Jun
 2021 18:30:24 +0000
Received: from BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::d880:7694:92d6:7798]) by BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::d880:7694:92d6:7798%5]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 18:30:24 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [RFC v2 PATCH 6/7] dmaengine: xilinx_dma: Use tasklet_hi_schedule
 for timing critical usecase
Thread-Topic: [RFC v2 PATCH 6/7] dmaengine: xilinx_dma: Use
 tasklet_hi_schedule for timing critical usecase
Thread-Index: AQHXLWnYyET0Sdl3eEuBNLLlieUfgqq1Mh8AgFotgtA=
Date:   Fri, 11 Jun 2021 18:30:24 +0000
Message-ID: <BY5PR02MB652096A6F787E277BFD404A2C7349@BY5PR02MB6520.namprd02.prod.outlook.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1617990965-35337-7-git-send-email-radhey.shyam.pandey@xilinx.com>
 <52f01459-13be-ff29-1c07-b98636169c74@metafoo.de>
In-Reply-To: <52f01459-13be-ff29-1c07-b98636169c74@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6b0a1c4-b9ae-46dc-976d-08d92d06fa5c
x-ms-traffictypediagnostic: BY5PR02MB6404:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6404A6BA0EED2A9AA9591543C7349@BY5PR02MB6404.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4a7WzI8lmDofjSsrA6+lpV5IZUBkBHocpamMmqOow3yplCd+vSlKZjqyKeEHC6dlGYp63BP78Bzg5RUgzM4zIaRrO3y1ZJ9h/MRHQDQxWJmAp2Ev2ZhKpx6q2VlabJYIWfWeYBqPFC8UuTY+WKgD3LJ1jnt/SXbhgrz7hDZxLbLxCJXQJ48SOX7cS60DchZWDuOirrANl+oBu1xslItM9wLpyv+DEn4186DFYWoE9g0KboC8leFGXmdK1Y4MclfnUXqQtMzog3pFsbZuG66FGeipQhQVt676VCA936FAF8BDqZU/5NSBs6VQ3ybzNbmNTCrlSCDwPGGtDfxpBKOtTJRlRZa0h/9kSHdvnvjC13CyzYCXXjI14fBNFUxhqkgsl0hSloe/IagNZvnMQlZg9lleUvg+FZZC5FM4L6/EFQOXBUo/wwacqBFxaJ4aEavIbCvxaHRgKnRZQRxX80sIyY0ye780rNOpG9AOGXTGfs3hLHwCOad1Wb0hgFoDm+iHW0GlBFcicPtZXwdZHbonVGTQ1py4FlIdrPzfcQJ6M5/ffwux8RXMIF/F210/qTDayD1iE5SYKOsu0BfHTD0exAEaB0EN3pEBbYK3BM1Olyc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6520.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(76116006)(8936002)(7696005)(33656002)(6636002)(8676002)(55016002)(83380400001)(2906002)(9686003)(66476007)(66556008)(53546011)(52536014)(66946007)(54906003)(110136005)(478600001)(4744005)(316002)(66446008)(64756008)(122000001)(38100700002)(4326008)(186003)(107886003)(86362001)(26005)(5660300002)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmtCMlAzOHdyQ1ZRSjdEejRxSjVYS2lmVm1OK0tFV3lyaVUyZXZHOU1KOFlU?=
 =?utf-8?B?ck9Jb1VKOTZodkd5OEtxaHRKQktNQXNkNFMvSThGQjlDbGlkeXI3cSs5ZENs?=
 =?utf-8?B?UzJVV21NMXpEaDZJTWpnK0hLVDZmSWFmRW9PcjdCRUw5Qk9LR0ZKUnE2ektw?=
 =?utf-8?B?UW9zVTdWSnZjQ2xmUFNXTGh2bnBlV1ZGQzZPZm1KVFhvbUdlbWFTUG1UcVFT?=
 =?utf-8?B?aFVPMlNtdFY2cW41SEZvL2xWVUdLcmR6WHBNQlZxZzA4L0dEQVhKOVExSVRR?=
 =?utf-8?B?dVRDMFEzTExQc1ZkaVEzOWZrN1o2VkRIU25EQWRCRkpMSkxENmJVcUxHQkJL?=
 =?utf-8?B?TGtvd2Y5ZXhBN3c0T1lWZkNFamFsVEF5ZFZFbFRYbFNEMzh2OEZPQTM5d3BP?=
 =?utf-8?B?Y0JYMWUzVEJjTWZPaDIrOGpQVXlzSzBWYkV1WCs3MCtBZS96TGdNTTRFRDA3?=
 =?utf-8?B?QU92Y0M1YTJvb09mZ3IxU204ZzBIT0Z4bmZyT3UxUThITFBVdWdqNnZ4dk43?=
 =?utf-8?B?bXBOQW5RYTQ5bnFhVmV1Vnc5V0VOa1M1OU5LaXBQR3EzeXJqY1FIenluSUxM?=
 =?utf-8?B?dS84QnNTTXZKalhjNUVGdkRBK3F0RDF5cmsvWUVmZVNCTVh1ZXQ3K1Q0VFdn?=
 =?utf-8?B?SWFzRGxzeFU1WHh5ay91aFp4L0o3cFltWE1qcEluMHZVNkZ0eTJyYzVrVjNN?=
 =?utf-8?B?UXVGUWhnWk4rdjc0bDRUMTVKbUNFSzJCWXZybUtTbC9RQ012OEZsMVFFamhD?=
 =?utf-8?B?NVpQU0Jwa0RmTXhtZHVwM05kWGNEb3Vaek1kUTBJWk8vSWFSdjhRdTdLd3A4?=
 =?utf-8?B?VVY5QTlnODJTTEk3UmN1a0F2Nyt4M0RFODdDYkExRGE0V1hKbEE4QTJDQW9M?=
 =?utf-8?B?YnNCRlhybkxvTlpISVpBTFJ6MGxxMWhBVEorT2tzb01JYWdRcUIxU292Mjkv?=
 =?utf-8?B?SVc4UkF0Tko5ZmJidDRncytQTk9lOXBtUTZQVjEyYkFtd1lLVXA2N04wZko3?=
 =?utf-8?B?K1BnQzR0c0NPUmNXWVhLZGdwR0hEb1JDT1NETjlZL3EyYUJKdlRmQWl4MVJR?=
 =?utf-8?B?U0IzdFlUb09FWkNOUGpNbUJpWUl1WUZyY2UxdklQTzJmeXFHNmI3SzJ1NjdP?=
 =?utf-8?B?TklKaDhmU2plc2p5QnF3OW9LeGtPMktlN3lCR0N0aWROdHNFRDRBS3FXOXJo?=
 =?utf-8?B?dVIveDZpYkJud1BKSjl2eWhJOUkrU1pKMFRTUXQyNVJPWDI4UWcwR0k4OWhN?=
 =?utf-8?B?K0J5cmt3eGhZa0xyYUFKU1huS3oyZnBBUnpSZHlaUWtMV1RXWDlsbHdnUkJ6?=
 =?utf-8?B?WnczcElVR0RWU0dSNVlBb09ydG9yRHdrREEyK3Bad1RNaWw2eWZWZk05Qmhw?=
 =?utf-8?B?akFQYStJMEZJQVlXNUhKdmxNUTJObnB0WXRYSXFkRmkxdkZzcXZHMTRKYXJa?=
 =?utf-8?B?d2R1OWEwaXZBa3ZQdHZLcTdQUG5zaGJOWEVwelpYNnloQkRyd1NPSmpOeUpU?=
 =?utf-8?B?TnNsVUdMakJHaGFUVU1PYkg5RktJNFo1N2xsUUZibHJpS2VLdWdwZnJTQm42?=
 =?utf-8?B?V1VzODd2UmxPU04yTHBteFJPdmttdit1ekFFODR5VmFjbFJ0UkgvaFNsaktK?=
 =?utf-8?B?d2k0WVV6QWlzTUJndE1MS3g1RkovSGpGa1RJMEs2bW4vWmxocTlaZ3QvMlJ6?=
 =?utf-8?B?QU8yZElOUDBWNGFnczFnUXA2TEFqbHdFM0o5eE9ycHVFTzAxY0toRDVPMDJz?=
 =?utf-8?Q?mZdRLIixLAUgv/GJsl1QkXZPDjsnKKhRGEEe5zV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6520.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b0a1c4-b9ae-46dc-976d-08d92d06fa5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 18:30:24.1916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbTcy0iEqS2ZuaHViH0QaydrvDoK2YZVCvsdPj5raSildkFwyg6aRFvDsrVpLAFt3Xs4MTKZIyTrv3OEexAQfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6404
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4g
PGxhcnNAbWV0YWZvby5kZT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDE1LCAyMDIxIDEyOjQx
IFBNDQo+IFRvOiBSYWRoZXkgU2h5YW0gUGFuZGV5IDxyYWRoZXlzQHhpbGlueC5jb20+OyB2a291
bEBrZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IE1pY2hhbCBTaW1layA8bWljaGFs
c0B4aWxpbnguY29tPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdA0KPiA8Z2l0QHhpbGlueC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUkZDIHYyIFBBVENIIDYvN10gZG1hZW5naW5lOiB4aWxpbnhfZG1h
OiBVc2UNCj4gdGFza2xldF9oaV9zY2hlZHVsZSBmb3IgdGltaW5nIGNyaXRpY2FsIHVzZWNhc2UN
Cj4gDQo+IE9uIDQvOS8yMSA3OjU2IFBNLCBSYWRoZXkgU2h5YW0gUGFuZGV5IHdyb3RlOg0KPiA+
IFNjaGVkdWxlIHRhc2tsZXQgd2l0aCBoaWdoIHByaW9yaXR5IHRvIGVuc3VyZSB0aGF0IGNhbGxi
YWNrIHByb2Nlc3NpbmcNCj4gPiBpcyBwcmlvcml0aXplZC4gSXQgaW1wcm92ZXMgdGhyb3VnaHB1
dCBmb3IgbmV0ZGV2IGRtYSBjbGllbnRzLg0KPiBEbyB5b3UgaGF2ZSBzcGVjaWZpYyBudW1iZXJz
IG9uIHRoZSB0aHJvdWdocHV0IGltcHJvdmVtZW50Pw0KSUlSQyB0aGVyZSB3YXMgfjUlIHBlcmZv
cm1hbmNlIGltcHJvdmVtZW50IGJ1dCBJIGRpZCB0aGF0IGEgbG9uZyBiYWNrDQpvbiBhbiBvbGRl
ciBrZXJuZWwgNC44IGFuZCBhZnRlciB0aGF0IG9ud2FyZCBJIGFsd2F5cyBjaGVja2VkIG92ZXJh
bGwNCnBlcmZvcm1hbmNlIChoYXZpbmcgYWxsIG9wdGltaXphdGlvbiBhcHBsaWVkKS4gSW4gbmV4
dCB2ZXJzaW9uIGkgd2lsbCANCnJlZG8gaW5jcmVtZW50YWwgcHJvZmlsaW5nIGFuZCBjYXB0dXJl
IGltcHJvdmVtZW50ICUgaW4gdGhlIGNvbW1pdCANCmRlc2NyaXB0aW9uLg0KDQpUaGFua3MsDQpS
YWRoZXkNCg==
