Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629EF491F15
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jan 2022 06:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiARFgF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jan 2022 00:36:05 -0500
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:36704
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239686AbiARFgE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Jan 2022 00:36:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6Paxu8rnxMhLPB7iGZdoot5X59JwrJiepPPvhYLzLjKmCZDLSe76TG6K4HPL6oQ8e4ypUjlHLuMVmW6K/VeYhAmjUPmV7wNCxYBBHDzlQxQ6lkGLGaSh0fLRklS41zEEHchGmcQCzuXEeE3T05KiXz6TBT+SgL/fjnj3DVYCfUGqDTGMuFKVOKRiuMT/vCejgNPZy8+QirA7JeM1iHij+pdco7vmUhD8vGEHQQHua08kq8lfkK/Cu3ipI6wcvvW1c3G79Li+hmP7ip6u0wquAuSYn44stRhpAYFyJU/dg2yUqLFFyVMHH4YHh6ua3dDrLm72EMqg7SADQeBoxONPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqOT7mCoxPjEEN2m5pX8YjqIOBHxAyxUijW3xdy00eo=;
 b=Y1veG0loXp6XHX6vvNOkX7d//SDxZYnf0c3NFmJVCEzvvr0DUvo5ABxoVskrocjsnD0BIjU8CaAt9RMWESRmFI7wmr3lUqveSttztx/cwfNCOKGOosy+aLESqTa3M0yVC50GVaOTsMSmZGeC/HImCVVxiPQy4QWPSruQafu0z8pAhuBT9Q9MPEqTJ7DtQgeOFPKuqL/UDJtraPsJwzUq7d5NQ8+DzhHBbvIY6psp0pWp82+IEkbI/v5XtcNB2NpxxXITFO0RgHWSMcfaxhXWbVCJCGzDB2Q7clFuiwM7mgpRKTUiraAq62vKppbOAMixVNztkVyRMII1ZQgV6fIfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqOT7mCoxPjEEN2m5pX8YjqIOBHxAyxUijW3xdy00eo=;
 b=SIrfizHeA9HO+UrIxoXpv9N53rrs+UvUUuFFMRnbg2i1nW3bXFDpXhycbQd1OZMgxy7mTgCc+accSOtyw6LbDvjoQm3m9ZvWd5PicH4OOh9r6uOWRRXs1NVDSMRQZAdnX4Bue3PSc4b+ye5DU6EW+5yQ9nP3b5i2xGWHLYLH7ZeT7eq3K9CCF0UsnDguBfPSdDN2wQIlIyLe2QcLXBB7ntVHO5MI4BYUGiI+lyJvBaPaC0+UGbiIqkelY21ys+cvR+XuWkfaamzXUzCZwvn7dFzZLcOf+DBxWeZ79xyt1OEWZVLvFP5tkhi/bDQCM/IG7U2uhVOt75n6Ty81jHfwcQ==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by MW3PR12MB4524.namprd12.prod.outlook.com (2603:10b6:303:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 05:36:01 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::880d:1407:db31:5851]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::880d:1407:db31:5851%11]) with mapi id 15.20.4888.014; Tue, 18 Jan
 2022 05:36:01 +0000
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
Thread-Index: AQHYBjv6V3jR20SoJ0WlGaDgyuzZEaxib1oAgARSzJCAAKKnAIAA14lg
Date:   Tue, 18 Jan 2022 05:36:01 +0000
Message-ID: <DM5PR12MB1850FF1DC4DC1714E31AADB5C0589@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
 <1641830718-23650-3-git-send-email-akhilrajeev@nvidia.com>
 <16c73e83-b990-7d8e-ddfd-7cbbe7e407ea@gmail.com>
 <DM5PR12MB1850A5F5ABA9CD5D04C37086C0579@DM5PR12MB1850.namprd12.prod.outlook.com>
 <1db14c3d-6a96-96dd-be76-b81b3a48a2b1@gmail.com>
In-Reply-To: <1db14c3d-6a96-96dd-be76-b81b3a48a2b1@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb38acfb-99cf-41f0-5ffa-08d9da446984
x-ms-traffictypediagnostic: MW3PR12MB4524:EE_
x-microsoft-antispam-prvs: <MW3PR12MB4524D3E570BFCA2CC85F0C8EC0589@MW3PR12MB4524.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TIif0gIaIxH7jH9d82eU+ET9o/npncTY58RrFI4Ns9E4hbnyqZinCKJdTuD/ONSdzQsiv8uEdAgwNWrzWrrk7DhjBuvjj4DXUSxGgtNsPTECa4y7SaVy7uCV69ZNommXmP2HjBS5aMJIWNiELdSv1k7H6VLTZJmIBKvbCk1PnZQTWytjuCHjW7SBcTlXDFJ/JhZcIN9FbWUHb5SQcX5AMlvyA8UTEV+DcIy75zGqELMJkV2/dt7IAoMKP8uqGe7Hvfp1U70AnnUnbja2r/KQQvPHXQMXERp4zSZw5iffLU0faii1M5+ZFwEHZ1lZGUuatWg+4QOp4sf3GBEx1ofsfMCGGQoH1ZyxSSy8ETnlrWmqX+1rVfOhsAejVNmauZFuKJiw+e2ptrnCa0dDSBX10X71rDBAO6YrZDpTfWAVDHLCzbkFwEHaGTE9n4pz4II+6stzPxOJpqfQnmE3q49otkxAsYzg7jYEBI4ZnbdZA0+/UH4BjMJP2D2REoJNpw01aD+Bi2suC0s8K+0vZUQSV0OEew979Ku2WoKOnJPKml28BrfCyR5GUP6dqcHGJWv8xa2nc0AWFA9Y8PclulAGxhbkHocQvrmKm8zx+3hkWBy/CR9T6GEgUcvnhOFb2WlgGbimDBnYaGUbpqnwyXuN8H01QJXcE922hCmuyOqJY1yuY3hCsDNU/wgic6Qlc6IE0DdheMea8v3W8XhwK8IR/9XDnh25QHTA8Ci+rYf0Fuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(26005)(4326008)(38100700002)(2906002)(55236004)(6506007)(921005)(316002)(508600001)(64756008)(55016003)(66476007)(52536014)(38070700005)(66556008)(66946007)(5660300002)(66446008)(122000001)(33656002)(7696005)(107886003)(186003)(83380400001)(86362001)(76116006)(8676002)(9686003)(71200400001)(8936002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGt5ajFIMFBPVnZQTEFmODMvZVFDYUFBRWZ1NW5wK1pnbEtiT1RSbHM0R0RJ?=
 =?utf-8?B?RXVIenJMSlBtdFQzR1FlckNVeFlBejJYU1djZmhhUGlERy9jNUNHdnkwdlVi?=
 =?utf-8?B?bXltajdtNUN2bUFBenpDNEhQM0J2V0h2aTUzaXVGZHduNWtiL3Z0MzREWkVw?=
 =?utf-8?B?SEFoNXdtclU3QlNQcE9wdzh4WDJWbVNFQVZ0ZXJ4bDVQbHVzUFh4MmUxamZG?=
 =?utf-8?B?THNkNjRxeVNmcWhMMlQ4aXNuUkh6VFpsOUNtWTBSMUxWTXlKZVBXK2lXYVRB?=
 =?utf-8?B?M3pqR3IzQURTb1N3aVJGamRhdlVpWm5uUVFXbG1qTmNKeU1KT0NiWS96ZGs0?=
 =?utf-8?B?TW9pWlR5d3NVa0U4V3BnS3JncXRoTnBXM1RIWmw4OU95T01xcTF5K1VvQzBj?=
 =?utf-8?B?YkV2OGlkYlhXT1o2d2R5bU4zdURDWDNSS3YyR09MOXRZc2c3Z3dvTERlTGtZ?=
 =?utf-8?B?RlhjZUF3UFZvM0tGaVJKekJTN1hzcEhYbTFoNkZBZjlKelVjVUl4RW9mL3M4?=
 =?utf-8?B?UEhNSTFSVFJXMHNZVzhaN0ZRUXRUeThBTm5HSWg1UllHN2d5RVZSbnB6Y3lI?=
 =?utf-8?B?RmFtSE1vTGxlKzFRWkZJNkZxdGpQQVl5RHFmM2RDRzlsakhzdUR3OC9kWWpN?=
 =?utf-8?B?bzZKOTg0eFhQTG9qVGxpaFMwL0xZSnViZFpHZGRFazVDVkJsTWFTQWRlWkND?=
 =?utf-8?B?Q2xwa3dFUUJBdXNFcUtIOURRV21tSnVMaW1CcTFGVFV4TnByNkNqOHMwVlRp?=
 =?utf-8?B?OEFoMDgvbW5NOUQ1MGVmT1phUldMTEIwcU5HczZLZW9rR2s4WVJHeTFjUTds?=
 =?utf-8?B?Y0c5TWFUZzdsT1N4WmlkSzQ2dmNFRmhTdEhuRzFWZTlTZlVIVHZNcHIrWUJ0?=
 =?utf-8?B?dlNpN1hZbFV4NENTd2E5UllLLzNPam1INDhGZHRsT0gyWXZ5ZjZIZC9UVVVY?=
 =?utf-8?B?ZG9acHNGUUxKanhqL0FMS2RJb3NQQWpyMVRXM3JUZkpUSnNjWkZITUZ0MFZ1?=
 =?utf-8?B?YU1DMHpURHVSYnIvR0ZsalNRbVJNNFpHWHYwQmUwZlFZZVNPV2tadXViODRE?=
 =?utf-8?B?TDJSd1duNjFia3B3RFh3M3h2YUpMaTZEVTY1R1FIQXB4WXpiWVpvZEVURzdE?=
 =?utf-8?B?VWc5bXF0OUEzS1BmdEZHZDhtOFlFeXkzdnZqcHpsQUdkNGYzZmI1R1BzTzdV?=
 =?utf-8?B?ZDJCaHBPMkQ2RC9GdGdMVUZackVaUmVRc3dIaGZFQVFLSm5qQUk2aHB0ZFhi?=
 =?utf-8?B?US9jYjJCV3l5enRKOTJIbzN6VTJ4ZlhRY1ZGamc0QkhmUnlHYk5CUCttK3kv?=
 =?utf-8?B?LzNvaHUyMFNOemI5bCtvRWhWdHhoaGxydytpb0xEV2VGRkdqL1NpdEN4RTRr?=
 =?utf-8?B?YzFSZjBxM3FWeDN2cTVtd1QvMm9GTW81TG5SS3YrOWhTRHc0Tkp0UnY0N1pM?=
 =?utf-8?B?SW1UNTFiSEZGb0NibGNOVXdYNC9sbi9JaldESUF6TENMejZhUGFNbytoZEo2?=
 =?utf-8?B?YkJuVCtWQ0VFWkZPMW5RbUY1bTJZSEZ3Z1d2NVF4RDZ5dUhBY1dpVDdGa2hW?=
 =?utf-8?B?ZCswK28rUjZtSW5LQWh4WHhCUHpTaUVVcUJScU1IRlpXRkpuMVM4T1UrMXdj?=
 =?utf-8?B?K1RZS2RvSzBaTjVQL1NMNm90NEpYaGhsQXBqSm1MaVl2RHZPcUlBejVRY1k1?=
 =?utf-8?B?U1BWaUZjQk83UW1sYjBTMS9SMC9qRnoweW0zVEVxYU0rd3ExUVRQOURDRFcz?=
 =?utf-8?B?Yy92UjFseHFNSTlKVnRCVmRHT2JaSzhod202NnltcWxvVUpFSUdvNGNST3c0?=
 =?utf-8?B?WlVPSmxybjZlT0VnRzJGTjVJWkZXR2trcjBHbHUyT2pKd05mYTg4dmtzRVRr?=
 =?utf-8?B?eGE1dkd3c0lEWHVMTEx3T2ZBUFQ4aWRyaEYrSmpob1NUNU5qd2dOK1RHQkVv?=
 =?utf-8?B?czdVcjlIUzBjRWkvV21nbjZrUU5VTEdaVkhlamI5U0JadTErVGdtcEtnbjJM?=
 =?utf-8?B?VTNBR0R5QVpYQ01xenRTU0dHdXF4SEh3Sk5GNEZWRDhtdkdWQ1dBQ2ZsQTFv?=
 =?utf-8?B?dW1aRkhUNXpLVUxIQU1paklMa1lnNjNMUGpqSVc2Y3pvMkJBOXY4cFJqV0Ex?=
 =?utf-8?B?QUVrWDg1UkczWXh2SlV6RzYvNnMvUUEwOEhCMVNnaWZLMkc1VGVZSFlQZG44?=
 =?utf-8?Q?xrf1vN69f5Tl8KZ3xPzwCxU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb38acfb-99cf-41f0-5ffa-08d9da446984
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 05:36:01.0831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pV6GSRBkfxBfOiI9sWSSJPQn0XZ3I/qG0A8Vr6zcKkgy/SYQFMwxV2ewhivcD4MDUzHsm9owY2L1ldZ6zj5q1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4524
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAxNy4wMS4yMDIyIDEwOjAyLCBBa2hpbCBSINC/0LjRiNC10YI6DQo+ID4+IDEwLjAxLjIwMjIg
MTk6MDUsIEFraGlsIFIg0L/QuNGI0LXRgjoNCj4gPj4+ICtzdGF0aWMgaW50IHRlZ3JhX2RtYV90
ZXJtaW5hdGVfYWxsKHN0cnVjdCBkbWFfY2hhbiAqZGMpDQo+ID4+PiArew0KPiA+Pj4gKyAgICAg
c3RydWN0IHRlZ3JhX2RtYV9jaGFubmVsICp0ZGMgPSB0b190ZWdyYV9kbWFfY2hhbihkYyk7DQo+
ID4+PiArICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+Pj4gKyAgICAgTElTVF9IRUFEKGhl
YWQpOw0KPiA+Pj4gKyAgICAgaW50IGVycjsNCj4gPj4+ICsNCj4gPj4+ICsgICAgIGlmICh0ZGMt
PmRtYV9kZXNjKSB7DQo+ID4+DQo+ID4+IE5lZWRzIGxvY2tpbmcgcHJvdGVjdGlvbiBhZ2FpbnN0
IHJhY2luZyB3aXRoIHRoZSBpbnRlcnJ1cHQgaGFuZGxlci4NCj4gPiB0ZWdyYV9kbWFfc3RvcF9j
bGllbnQoKSB3YWl0cyBmb3IgdGhlIGluLWZsaWdodCB0cmFuc2Zlcg0KPiA+IHRvIGNvbXBsZXRl
IGFuZCBwcmV2ZW50cyBhbnkgYWRkaXRpb25hbCB0cmFuc2ZlciB0byBzdGFydC4NCj4gPiBXb3Vs
ZG4ndCBpdCBtYW5hZ2UgdGhlIHJhY2U/IERvIHlvdSBzZWUgYW55IHBvdGVudGlhbCBpc3N1ZSB0
aGVyZT8NCj4gDQo+IFlvdSBzaG91bGQgY29uc2lkZXIgaW50ZXJydXB0IGhhbmRsZXIgbGlrZSBh
IHByb2Nlc3MgcnVubmluZyBpbiBhDQo+IHBhcmFsbGVsIHRocmVhZC4gVGhlIGludGVycnVwdCBo
YW5kbGVyIHNldHMgdGRjLT5kbWFfZGVzYyB0byBOVUxMLCBoZW5jZQ0KPiB5b3UnbGwgZ2V0IE5V
TEwgZGVyZWZlcmVuY2UgaW4gdGVncmFfZG1hX3N0b3BfY2xpZW50KCkuDQoNCklzIGl0IGJldHRl
ciBpZiBJIHJlbW92ZSB0aGUgYmVsb3cgcGFydCBmcm9tIHRlZ3JhX2RtYV9zdG9wX2NsaWVudCgp
IHNvDQp0aGF0IGRtYV9kZXNjIGlzIG5vdCBhY2Nlc3NlZCBhdCBhbGw/DQoNCisJd2NvdW50ID0g
dGRjX3JlYWQodGRjLCBURUdSQV9HUENETUFfQ0hBTl9YRkVSX0NPVU5UKTsNCisJdGRjLT5kbWFf
ZGVzYy0+Ynl0ZXNfdHJhbnNmZXJyZWQgKz0NCisJCQl0ZGMtPmRtYV9kZXNjLT5ieXRlc19yZXF1
ZXN0ZWQgLSAod2NvdW50ICogNCk7DQoNCkJlY2F1c2UgSSBkb24ndCBzZWUgYSBwb2ludCBpbiB1
cGRhdGluZyB0aGUgdmFsdWUgdGhlcmUuIGRtYV9kZXNjIGlzIHNldA0KdG8gTlVMTCBpbiB0aGUg
bmV4dCBzdGVwIGluIHRlcm1pbmF0ZV9hbGwoKSBhbnl3YXkuDQoNClRoYW5rcywNCkFraGlsDQo=
