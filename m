Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637BC4962B9
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jan 2022 17:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381783AbiAUQYk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jan 2022 11:24:40 -0500
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:59278
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232442AbiAUQYj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 Jan 2022 11:24:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fduzZF0+wS9RMRtnILsB3E2kNDWwITdnIPgacVmlGTo0xv3TO+M/r2ivdIzbCHmqpqCB5IhMGObuGIMbhS2aIKJ5JnsLmaT0h2NgUDtRPGt7ensxcp22MDq1WRu2quj+57Co6mp/HUdn+zYXbvnCG827tiYUQMgwPWnC04o1YitLf8a7TBHTjrP/QUN8e26V9/qGXPcH7OqGjIbavigLSh+93YTeUhN809iY2/QZTDHmj1m6EIRJixgIzICRBTSkJdzTv+/qD1iVwVJUnGB11sub/yCXXzAuJ/9VvOxqLLsQs/CVGypLsTD74VX7IuLgxVXEUsZZeEUZQywYYa0e9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw2kNLIvM7+18Wz5BNdz7Cxa5vrET4uRQq0XB0fzOoc=;
 b=DzmD0EO0NnNYiy2emzlUkgOTBMOajOHoxaXxfwXKG3r4OouWRo/wnyelyTng4qUxYLY+2al3a/Op+MLfRIGI445RUmvn2Zq0lR3hQ6+GeWg+SIdi5Ga6pwruwe5Ug6thmbJ0L37v3kVnUQ2vwoNq7xPvatKG2rrQSs0Mfc8IHPShM00dQHNRHoVxu8cOC5nqcto9VwxCJztGT1SQAZ1iI7/H1tReysza0jk8IOMvd8FmdUrErxnU+XQae4aq3vAyJlGRBcgjUYZelNFFLey3X5Dr/mYYIm1fX9tTX6rVeeaIz5xIKSCymGMy81H+kGLNNKdnNCzq5+1id6ZKLn9dYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw2kNLIvM7+18Wz5BNdz7Cxa5vrET4uRQq0XB0fzOoc=;
 b=oeJk2pcFnl3J8RZMds5gpYYU4Eg7mugED4tzQiDWetWp3NWtlbtX4/sNrzMtan7d+DlC66De5w1rInRmXWaWb2FUs8Vtunnck/xgnI+kLFgsw4eECv1G22SMEyQELKRNOTnx/0/+orHEKE6MxCUzJ6o/4ESwQYr8/pukSoPV/QzADPN+5YZHWGLEiRV+8NQ5gfT+Lys9b2uSvy2xGIF2iWXUuP2XxwNA+xv97t1KxQIY7VzhLsO0zxPXjSXiASkdDCzgT7NJUWFvDpCnKFChtrCp0L/dKKOCj17nPCu1TocjSwkjXp4jV0MGRCOqNgIHW4oI0d2kNokzz/GFjksTjQ==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by BN8PR12MB2980.namprd12.prod.outlook.com (2603:10b6:408:62::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 16:24:37 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::880d:1407:db31:5851]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::880d:1407:db31:5851%11]) with mapi id 15.20.4888.014; Fri, 21 Jan
 2022 16:24:37 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v16 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v16 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYBjv6V3jR20SoJ0WlGaDgyuzZEaxib1oAgARSzJCAAKKnAIAA14lggACbUICABOB+0A==
Date:   Fri, 21 Jan 2022 16:24:37 +0000
Message-ID: <DM5PR12MB1850D67F9B5640943F1AEB2EC05B9@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
 <1641830718-23650-3-git-send-email-akhilrajeev@nvidia.com>
 <16c73e83-b990-7d8e-ddfd-7cbbe7e407ea@gmail.com>
 <DM5PR12MB1850A5F5ABA9CD5D04C37086C0579@DM5PR12MB1850.namprd12.prod.outlook.com>
 <1db14c3d-6a96-96dd-be76-b81b3a48a2b1@gmail.com>
 <DM5PR12MB1850FF1DC4DC1714E31AADB5C0589@DM5PR12MB1850.namprd12.prod.outlook.com>
 <683a71b1-049a-bddf-280d-5d5141b59686@gmail.com>
In-Reply-To: <683a71b1-049a-bddf-280d-5d5141b59686@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e1692da-430d-42b9-1eb4-08d9dcfa84ab
x-ms-traffictypediagnostic: BN8PR12MB2980:EE_
x-microsoft-antispam-prvs: <BN8PR12MB2980B20279E21581FBBF3BE5C05B9@BN8PR12MB2980.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CBQi/8i4I+A11fUpIf+e/1yw4Qxlabak/Qf/2Fc4reoPuUYA6/+5yhp0aeEiV1SncO3YqEmAruUyvCOqs92Qa0zdq5+o9vQwtbP4ol6wrrzvoY5wUXA4/SOCCljpfAGso5qU8w9kpn3BMVT7jLetRXn3pDtDSsIs/klmH+gBtJcoAfoafFZbYBtbAYeI5nTwErLW8xehf0Nt1c5is0WAoEWy9vD4p3PwIppR/CYY4UExzWb5yEbCHttIxN2k0umHYVPL8mTF0iZOwKy94PApr5DIpZJlbcYTD/yZ2M91vuhfSl0Q+a7LthelDe0lwaeXv/cRtqUtwFiym7Nc0jlgZ366mp7BQ0aqVqEjYuFZEfHrE38U7f6FlcswJB+JraScw8cpwZejp0Ge4zH51ecGtHcNiM9bbbUdtfle7sVIg/WuCXzBbL2YSNZ9g9jMndWVIFNHluigVQXi63w5WKMJQmN6XEdVPPjGAKQCvjRz+/k2CmEiE8tUhqWUqXGOoEBF6sJn0RLS/RKcknfu/KL8P3z1A75UEvpeIFE97voXOVW+2PLZHdA38Jph8n9rM1OmoeTnWO+Vhs2+vJU196uODzzK022EB+VVBtCp+0LKQSlWT2sfcy9dMQOmoPROzhAfy38pFuz2FEZv2iz1OI0jaZyzQP8MvIo9Sy4/UyH3pQzFZVNqXl0PNb7tUFYPphOauCs0yRE63KfJnH+F+Acbr7ofihyeUovdCUtC6aYS3Hs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(9686003)(55236004)(186003)(38100700002)(83380400001)(110136005)(52536014)(6506007)(8676002)(66446008)(26005)(66556008)(64756008)(66476007)(508600001)(7696005)(7416002)(71200400001)(33656002)(316002)(107886003)(2906002)(76116006)(38070700005)(55016003)(86362001)(4326008)(8936002)(122000001)(921005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlE2Vk9MNk5KeU16WWZLUCtmeGxOVm1WWkFFNEVQTWlVejNMOVBYSnVFMkFE?=
 =?utf-8?B?Ym5HcitCM01LQjVvUUFTcExEbFpFVjZjYWNIT0RZamFQVE1XdUJPY3d6SHJk?=
 =?utf-8?B?dVNSaGZtNFdycFdrNTBtNmNyWnBIU2RNclkxYlFoWU9PdnZQbjF5UTBrbFBx?=
 =?utf-8?B?WjVDNEwybUhpMmVRYmRVQ1NJWW1WRkpyS1MrQ1p3YThIU20wWUdPTG10VzJz?=
 =?utf-8?B?UE5OMm5ObHdUTWUvTkl3ZlIxZUJFK0tuMk56d1lmby9SSFQ5Z1lKTStieDNZ?=
 =?utf-8?B?WnczSmE5bEFsZlJzdkoxekdwRGtBVFdkbThyZDJndnRJcXh1NDVhQXFKRGdi?=
 =?utf-8?B?b0wyYXRFVmg4SnBxLy8vNXczTmdWS2NwY0lJRUJXYjBIY1EvbmF3QWdrS2Iw?=
 =?utf-8?B?QVhJWlNld2t3ajUyWUNpWHF3dzA1Snp0ekVINHlTcFBDTnUwU0FsNm1XNVhU?=
 =?utf-8?B?RURaLzVWMm96OXVTNWtCQ2FOaFdoWGpyQ1d4UFhtaDVOTnQwdFBpOHBULytX?=
 =?utf-8?B?c2RObnM0TmN1SXBicUtyRHFkQ0R3SkltdjllTFRvYXpMbStyb0F6S1cxYkth?=
 =?utf-8?B?N0hzeXFwazErdlYzcldhWDRKQlY5V0hRT0FtMFVXU0tDL3VwdG05VlpHWGZS?=
 =?utf-8?B?K0NJL3FhRGpuZWJUWjZwV2s1UkVuNnlwSENjK1Yxem5Oa1NxQWFlNVd1U3ht?=
 =?utf-8?B?Qzd3TWFiR2NJdjR2NmNGbzlxY3JaeDlkYUt4cjhoQXBxSmhUVXhJRnptVDVy?=
 =?utf-8?B?MURYQzdUL094b2t5bFl3U3R6bGZjZStmV0VYNlVqbEhjZDdPUUJMQjY3OTQv?=
 =?utf-8?B?NkpjdnRJK05iNUVTRHFRVWNRVk50S2FieEZNUnVvZUxRU3lXdE12d2VXeGVI?=
 =?utf-8?B?NUM5TXlJem5iVEd2V1lPNThDVDBpVURJS1dhcm1RSG96UTBvK212UkpnRlpl?=
 =?utf-8?B?TStBbVVzUjBMR3FmbUpxNmUrQ0YxakVDdnpVVGd4OUxvNVlsejFVRXY4ODd5?=
 =?utf-8?B?cTlBQUM2OWNmSk44azdNQ0U3cEtrcnVJRFF6ZWR1SFRXZmhXM2dXT0s5dmVq?=
 =?utf-8?B?M3BpVW9EMUVwR2tackQ3dDk3WkErZG1LdzN4c29tOWVMNkFCNFpuUFhQS0Nm?=
 =?utf-8?B?RXM4MThCcUl0U3U4VnA3UTR6UTRMYVhxWVJKUWp0Qmd3U3FYV2ZRM2RMdldF?=
 =?utf-8?B?T2xKOXBNMC9ReEdwcEFGRjhMRUdrZ0pZNVpGbUs0aHhiaGplZEQxYTZFOFkx?=
 =?utf-8?B?T3cwUW5qN0EvWUtGdG5hWkRxYjk5aGxwMGdQcFlhaGlZbTk2M3AweGFITUtD?=
 =?utf-8?B?ek9TMURyWEFXZmFSVERGSDNLM2c2cUV3Rm9zb09oS3FPRCtCSFlVRHFUKzE1?=
 =?utf-8?B?WTR6U1FTRkJLVUpNV1VrQWkrYWJDYzRQS1VKT2xFU2M1a25aRDNXUitFWTdG?=
 =?utf-8?B?NjEweHlmRzU4clpCSmtpU04yaFBPN2JNWVM1cU8vRmNBekNJbmU0eHRyV3Fh?=
 =?utf-8?B?VlVVYW5oaFJ6WTdGMlZQbnBxQ0pVVFR1M29RaE9XcGJZdEtOWHBtVmZRUC9S?=
 =?utf-8?B?MVJMaVdPZk85Q3FkeEJKbzZKYnJpVWY0OTVZVXRiL3VlMUVhTllWSm44dDZN?=
 =?utf-8?B?K2s2VDg3SHdqZVdPZHRVZUdQbXZ6QzdaV29xQWY1bU8rT2JFQ2Nja1hTUVQw?=
 =?utf-8?B?OEVVUmRpc3dGRkFCTUdONnV4Y1hpM2R5SlRxaTBsQnRRdXhvNHB0VHNnUWZL?=
 =?utf-8?B?SkhiNXE1ZkZuNGtSQmN2blpBOGowZ2ZFeWxUSjl3dXJNWlY2MFQvT0tYQ2JC?=
 =?utf-8?B?d0UzNCtFTU01dHZYMzBDS2dlUkNQTzFNNFdwcU9LV3VmK0hqeXFtWUEvWUNi?=
 =?utf-8?B?cmIybDdtNDlXMFp4S2pMcVhHdTBuT1BCM3I2R1NBSnpPY2tid1V3a1lISE0v?=
 =?utf-8?B?L0FXaERBRzFVUldKUlMvK3JxRlJCVkEvb0Z1dVNtSEdjcnp3ZHhBREM5VDYz?=
 =?utf-8?B?eEJhWWVSNTVBSGhiSGNnUUFrdVBiUFI3ZkwwVmhIOEUyQXFsdDlCTi9PSTBp?=
 =?utf-8?B?UWQwNDZWay9oUzgyVE1Pc241ODlwaHZjQ2UwS3cvL2tDUzdOdTkrc1BGejRn?=
 =?utf-8?B?SGFNYU5YUzNCWnQ4SWZXcExZVGJ3QU9IVFhpb3lKblZYNzZsS2I3NU9RWXpx?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1692da-430d-42b9-1eb4-08d9dcfa84ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 16:24:37.4752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4m91pApJk1EB6j/qtdH/Hk2RH29gQ8CCAvyu1LQ/yxhzh++kIm4r9blC1P8drVwZOhmmjde7EogFqgxgxNacXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2980
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiA+Pj4+PiArc3RhdGljIGludCB0ZWdyYV9kbWFfdGVybWluYXRlX2FsbChzdHJ1Y3QgZG1hX2No
YW4gKmRjKQ0KPiA+Pj4+PiArew0KPiA+Pj4+PiArICAgICBzdHJ1Y3QgdGVncmFfZG1hX2NoYW5u
ZWwgKnRkYyA9IHRvX3RlZ3JhX2RtYV9jaGFuKGRjKTsNCj4gPj4+Pj4gKyAgICAgdW5zaWduZWQg
bG9uZyBmbGFnczsNCj4gPj4+Pj4gKyAgICAgTElTVF9IRUFEKGhlYWQpOw0KPiA+Pj4+PiArICAg
ICBpbnQgZXJyOw0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsgICAgIGlmICh0ZGMtPmRtYV9kZXNjKSB7
DQo+ID4+Pj4NCj4gPj4+PiBOZWVkcyBsb2NraW5nIHByb3RlY3Rpb24gYWdhaW5zdCByYWNpbmcg
d2l0aCB0aGUgaW50ZXJydXB0IGhhbmRsZXIuDQo+ID4+PiB0ZWdyYV9kbWFfc3RvcF9jbGllbnQo
KSB3YWl0cyBmb3IgdGhlIGluLWZsaWdodCB0cmFuc2Zlcg0KPiA+Pj4gdG8gY29tcGxldGUgYW5k
IHByZXZlbnRzIGFueSBhZGRpdGlvbmFsIHRyYW5zZmVyIHRvIHN0YXJ0Lg0KPiA+Pj4gV291bGRu
J3QgaXQgbWFuYWdlIHRoZSByYWNlPyBEbyB5b3Ugc2VlIGFueSBwb3RlbnRpYWwgaXNzdWUgdGhl
cmU/DQo+ID4+DQo+ID4+IFlvdSBzaG91bGQgY29uc2lkZXIgaW50ZXJydXB0IGhhbmRsZXIgbGlr
ZSBhIHByb2Nlc3MgcnVubmluZyBpbiBhDQo+ID4+IHBhcmFsbGVsIHRocmVhZC4gVGhlIGludGVy
cnVwdCBoYW5kbGVyIHNldHMgdGRjLT5kbWFfZGVzYyB0byBOVUxMLCBoZW5jZQ0KPiA+PiB5b3Un
bGwgZ2V0IE5VTEwgZGVyZWZlcmVuY2UgaW4gdGVncmFfZG1hX3N0b3BfY2xpZW50KCkuDQo+ID4N
Cj4gPiBJcyBpdCBiZXR0ZXIgaWYgSSByZW1vdmUgdGhlIGJlbG93IHBhcnQgZnJvbSB0ZWdyYV9k
bWFfc3RvcF9jbGllbnQoKSBzbw0KPiA+IHRoYXQgZG1hX2Rlc2MgaXMgbm90IGFjY2Vzc2VkIGF0
IGFsbD8NCj4gPg0KPiA+ICsgICAgIHdjb3VudCA9IHRkY19yZWFkKHRkYywgVEVHUkFfR1BDRE1B
X0NIQU5fWEZFUl9DT1VOVCk7DQo+ID4gKyAgICAgdGRjLT5kbWFfZGVzYy0+Ynl0ZXNfdHJhbnNm
ZXJyZWQgKz0NCj4gPiArICAgICAgICAgICAgICAgICAgICAgdGRjLT5kbWFfZGVzYy0+Ynl0ZXNf
cmVxdWVzdGVkIC0gKHdjb3VudCAqIDQpOw0KPiA+DQo+ID4gQmVjYXVzZSBJIGRvbid0IHNlZSBh
IHBvaW50IGluIHVwZGF0aW5nIHRoZSB2YWx1ZSB0aGVyZS4gZG1hX2Rlc2MgaXMgc2V0DQo+ID4g
dG8gTlVMTCBpbiB0aGUgbmV4dCBzdGVwIGluIHRlcm1pbmF0ZV9hbGwoKSBhbnl3YXkuDQo+IA0K
PiBUaGF0IGlzbid0IGdvaW5nIGhlbHAgeW91IG11Y2ggYmVjYXVzZSB5b3UgYWxzbyBjYW4ndCBy
ZWxlYXNlIERNQQ0KPiBkZXNjcmlwdG9yIHdoaWxlIGludGVycnVwdCBoYW5kbGVyIHN0aWxsIG1h
eSBiZSBydW5uaW5nIGFuZCB1c2luZyB0aGF0DQo+IGRlc2NyaXB0b3IuDQoNCkRvZXMgdGhlIGJl
bG93IGZ1bmN0aW9ucyBsb29rIGdvb2QgdG8gcmVzb2x2ZSB0aGUgaXNzdWUsIHByb3ZpZGVkDQp0
ZWdyYV9kbWFfc3RvcF9jbGllbnQoKSBkb2Vzbid0IGFjY2VzcyBkbWFfZGVzYz8NCg0KK3N0YXRp
YyBpbnQgdGVncmFfZG1hX3Rlcm1pbmF0ZV9hbGwoc3RydWN0IGRtYV9jaGFuICpkYykNCit7DQor
ICAgICAgIHN0cnVjdCB0ZWdyYV9kbWFfY2hhbm5lbCAqdGRjID0gdG9fdGVncmFfZG1hX2NoYW4o
ZGMpOw0KKyAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KKyAgICAgICBMSVNUX0hFQUQoaGVh
ZCk7DQorICAgICAgIGludCBlcnI7DQorDQorICAgICAgIGVyciA9IHRlZ3JhX2RtYV9zdG9wX2Ns
aWVudCh0ZGMpOw0KKyAgICAgICBpZiAoZXJyKQ0KKyAgICAgICAgICAgICAgIHJldHVybiBlcnI7
DQorDQorICAgICAgIHRlZ3JhX2RtYV9zdG9wKHRkYyk7DQorDQorICAgICAgIHNwaW5fbG9ja19p
cnFzYXZlKCZ0ZGMtPnZjLmxvY2ssIGZsYWdzKTsNCisgICAgICAgdGVncmFfZG1hX3NpZF9mcmVl
KHRkYyk7DQorICAgICAgIHRkYy0+ZG1hX2Rlc2MgPSBOVUxMOw0KKw0KKyAgICAgICB2Y2hhbl9n
ZXRfYWxsX2Rlc2NyaXB0b3JzKCZ0ZGMtPnZjLCAmaGVhZCk7DQorICAgICAgIHNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJnRkYy0+dmMubG9jaywgZmxhZ3MpOw0KKw0KKyAgICAgICB2Y2hhbl9kbWFf
ZGVzY19mcmVlX2xpc3QoJnRkYy0+dmMsICZoZWFkKTsNCisNCisgICAgICAgcmV0dXJuIDA7DQor
fQ0KDQorc3RhdGljIGlycXJldHVybl90IHRlZ3JhX2RtYV9pc3IoaW50IGlycSwgdm9pZCAqZGV2
X2lkKQ0KK3sNCisgICAgICAgc3RydWN0IHRlZ3JhX2RtYV9jaGFubmVsICp0ZGMgPSBkZXZfaWQ7
DQorICAgICAgIHN0cnVjdCB0ZWdyYV9kbWFfZGVzYyAqZG1hX2Rlc2MgPSB0ZGMtPmRtYV9kZXNj
Ow0KKyAgICAgICBzdHJ1Y3QgdGVncmFfZG1hX3NnX3JlcSAqc2dfcmVxOw0KKyAgICAgICB1MzIg
c3RhdHVzOw0KKw0KKyAgICAgICAvKiBDaGVjayBjaGFubmVsIGVycm9yIHN0YXR1cyByZWdpc3Rl
ciAqLw0KKyAgICAgICBzdGF0dXMgPSB0ZGNfcmVhZCh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX0VS
Ul9TVEFUVVMpOw0KKyAgICAgICBpZiAoc3RhdHVzKSB7DQorICAgICAgICAgICAgICAgdGVncmFf
ZG1hX2NoYW5fZGVjb2RlX2Vycm9yKHRkYywgc3RhdHVzKTsNCisgICAgICAgICAgICAgICB0ZWdy
YV9kbWFfZHVtcF9jaGFuX3JlZ3ModGRjKTsNCisgICAgICAgICAgICAgICB0ZGNfd3JpdGUodGRj
LCBURUdSQV9HUENETUFfQ0hBTl9FUlJfU1RBVFVTLCAweEZGRkZGRkZGKTsNCisgICAgICAgfQ0K
Kw0KKyAgICAgICBzdGF0dXMgPSB0ZGNfcmVhZCh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX1NUQVRV
Uyk7DQorICAgICAgIGlmICghKHN0YXR1cyAmIFRFR1JBX0dQQ0RNQV9TVEFUVVNfSVNFX0VPQykp
DQorICAgICAgICAgICAgICAgcmV0dXJuIElSUV9IQU5ETEVEOw0KKw0KKyAgICAgICB0ZGNfd3Jp
dGUodGRjLCBURUdSQV9HUENETUFfQ0hBTl9TVEFUVVMsDQorICAgICAgICAgICAgICAgICBURUdS
QV9HUENETUFfU1RBVFVTX0lTRV9FT0MpOw0KKw0KKyAgICAgICBzcGluX2xvY2soJnRkYy0+dmMu
bG9jayk7DQorICAgICAgIGlmICghZG1hX2Rlc2MpDQorICAgICAgICAgICAgICAgZ290byBpcnFf
ZG9uZTsNCisNCisgICAgICAgc2dfcmVxID0gZG1hX2Rlc2MtPnNnX3JlcTsNCisgICAgICAgZG1h
X2Rlc2MtPmJ5dGVzX3RyYW5zZmVycmVkICs9IHNnX3JlcVtkbWFfZGVzYy0+c2dfaWR4IC0gMV0u
bGVuOw0KKw0KKyAgICAgICBpZiAoZG1hX2Rlc2MtPnNnX2lkeCA9PSBkbWFfZGVzYy0+c2dfY291
bnQpIHsNCisgICAgICAgICAgICAgICB0ZWdyYV9kbWFfeGZlcl9jb21wbGV0ZSh0ZGMpOw0KKyAg
ICAgICB9IGVsc2UgaWYgKGRtYV9kZXNjLT5jeWNsaWMpIHsNCisgICAgICAgICAgICAgICB2Y2hh
bl9jeWNsaWNfY2FsbGJhY2soJmRtYV9kZXNjLT52ZCk7DQorICAgICAgICAgICAgICAgdGVncmFf
ZG1hX2NvbmZpZ3VyZV9uZXh0X3NnKHRkYyk7DQorICAgICAgIH0gZWxzZSB7DQorICAgICAgICAg
ICAgICAgdGVncmFfZG1hX3N0YXJ0KHRkYyk7DQorICAgICAgIH0NCisNCitpcnFfZG9uZToNCisg
ICAgICAgc3Bpbl91bmxvY2soJnRkYy0+dmMubG9jayk7DQorICAgICAgIHJldHVybiBJUlFfSEFO
RExFRDsNCit9DQoNCg0KVGhhbmtzLA0KQWtoaWwNCg==
