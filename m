Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DC49732E
	for <lists+dmaengine@lfdr.de>; Sun, 23 Jan 2022 17:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiAWQte (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 23 Jan 2022 11:49:34 -0500
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com ([40.107.237.49]:22177
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238904AbiAWQtd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 23 Jan 2022 11:49:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgNJ4gtrKjvrlayHfo3e+rvsbdMznkfn0aPHSkHe6muzFqVqFMEhdmiHQ9ZLX1nKgSmDtv0ic7D3Qu/BDh7Xav3XZERTrfp2JgkBRF0G2MkACEg4BsrxwEzLBNTao0cpQsbAqbKopp1Hy4k4dlh+2Gee+84/GCk68J3FaLkymY7psSsWsX9HJWVRmaIXiBDaYJYX/iGpBzF6kCi8rrrt3SdOkSPX98QFGJE1XMFwBGRVnBqBdkO8hE+OzY2LCuuZs4cWaj7HIQ7TVEC9gjvsRJTp9AVIDa+Gl1duDPXrmGCvTQsd+VPWwMqzdhlAhfUk1F58krBhTTDB/X+71ftuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVof2CIBNbkYZlmvvlPbAbweEdvJn4NGLcLcaGNLR4o=;
 b=PaXKa62g4R19axtxYeaeFAObGkUge806+XcApuuWRSD+v3qEMxrt+p5KK1yiH7s0QNr4k2zlJFZ6Q4fl+YpKf38BjVhB1Wcq1QTvrs5qyg8ZSCWTdy5SsZzZ61CewX6G8tU3t4i0Ptq/p6uqMgpk6z6e7DZExbTP1fNq4FfpFAIt3gzny3FewU+CJDT46oOioA2PrnMjP0dV4o0X/PexC9ABJ7ng+XkZboH12xXd3WF98dxZxYPi3J8kq+kUFCmz/ASsVHZMX+rhdkAh1QyLDi1Ru3Ap8EHkttAjLgHRMNG38fdqv1ZKieiRDBu684wz/dhIXYzlmmq6xaunHH2O8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVof2CIBNbkYZlmvvlPbAbweEdvJn4NGLcLcaGNLR4o=;
 b=PWQglYZ06kyNwoTvVSaQTKkK3q+lMfNGj2ezWHS93x19vcV+9X0MSzrQJmM+7FgkE6IBe0wRJQPwy5QanavkD9hdondXVED0bdblzdURobFfLO54rrk6Us8tQt8EYam8REhM4Vc5t48fzYh8c4LgoBQSl5KTkTy4Dq+p0VvnMIcRR8wlTshDKFldQe89MAW+aUtzSkfVf6v/CDowX66UXZVpmd9xYcsmRYEGQ/fUqy13lRp+vAv9D/Nc9mBk62gfKTrPVgsuwzL6mBszhNYSCAxe+qV3FRK1ah1rm8UbarsDLX8RJhL7locOyApqLkBGNsz1K19aVel3ds+K9zBi1w==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by CH2PR12MB4822.namprd12.prod.outlook.com (2603:10b6:610:6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 16:49:31 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::880d:1407:db31:5851]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::880d:1407:db31:5851%11]) with mapi id 15.20.4909.017; Sun, 23 Jan
 2022 16:49:31 +0000
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
Thread-Index: AQHYBjv6V3jR20SoJ0WlGaDgyuzZEaxib1oAgARSzJCAAKKnAIAA14lggACbUICABOB+0IABt/qAgAFghpA=
Date:   Sun, 23 Jan 2022 16:49:30 +0000
Message-ID: <DM5PR12MB18502DF12B324E50D5E50BC0C05D9@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
 <1641830718-23650-3-git-send-email-akhilrajeev@nvidia.com>
 <16c73e83-b990-7d8e-ddfd-7cbbe7e407ea@gmail.com>
 <DM5PR12MB1850A5F5ABA9CD5D04C37086C0579@DM5PR12MB1850.namprd12.prod.outlook.com>
 <1db14c3d-6a96-96dd-be76-b81b3a48a2b1@gmail.com>
 <DM5PR12MB1850FF1DC4DC1714E31AADB5C0589@DM5PR12MB1850.namprd12.prod.outlook.com>
 <683a71b1-049a-bddf-280d-5d5141b59686@gmail.com>
 <DM5PR12MB1850D67F9B5640943F1AEB2EC05B9@DM5PR12MB1850.namprd12.prod.outlook.com>
 <31ba2627-65c7-1340-e6b9-7c328a485456@gmail.com>
In-Reply-To: <31ba2627-65c7-1340-e6b9-7c328a485456@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7c0f038-3db4-424a-4a3d-08d9de9053b6
x-ms-traffictypediagnostic: CH2PR12MB4822:EE_
x-microsoft-antispam-prvs: <CH2PR12MB482225B4CD1258EE777B2D4CC05D9@CH2PR12MB4822.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gt7WvKBvRvYrBqBo55je99oDtaV6XSIUpbjjjG38L6+0kTvIccd8g3aQQZ53sl1IckD01ATbKQWsm+qQNh4PwxiNcUHX1sJBzS5GzrxVHOQVH9xPpp6P3vwJpP/1EG/TY48t4UR6P76GzbPGCHM68JBBi8BSgrav3EhYfnfGrQLs2PPdFbZBJOUs6YzUKusNnTVRvEtAC44I4vFlNaBQI7J0/jwh7mm8RQ7gizByZrFPt4U7r1WfW0PPJD1qp4zUlKiKjwbsnFpaAvgwh/k1C/oj1+jNTHAXdRdNRY6Cq3KRxG/Y+16w3/LIq93cd0uvqsxDcJDw1nsrig7IsmgkBXiKtKIeY+pT31hYao95IYb4nTyzB03gFPWnnccE05krdQPhJZyuQQTBUyEFayJHQnCa2EvPNcQRTbQbVA/7KyGSt4NhW7GLAdbAEAjEH6NATxjVf2dZoTjkk4FWgARLD6EZ5o7M6asqNfXCLqKb9eW+2Ci1TeZVINAueflbaykVdcShSLXSW+BFmrCfVaiXEbXuLY/g5p8PSPpYMvXMJEWgQNpx+hP1GuWWa5Z6jBDU+f2YXSjG99/X/rvom6W9X5PCw1eEimzEFOzQ/f+bW5QnEFRF1ez2f8SJ5wvLzgCnTiGUP/AmZAU52Dkq5i9Wnm5u19ypiC2BTfqigByHaq5S3iGQheUNxagVL1TJa+CQ9JgK6lYGH4ekbzp2Q565XzQJz7q0oxfY7HQN/QXrtSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(86362001)(83380400001)(71200400001)(7696005)(55016003)(38070700005)(122000001)(26005)(186003)(38100700002)(8936002)(5660300002)(52536014)(921005)(66446008)(8676002)(76116006)(7416002)(4326008)(64756008)(33656002)(66476007)(66556008)(508600001)(9686003)(66946007)(2906002)(107886003)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWlyeVdONlhvZTR4NTV3YXFXeFJTcUhyZDJxN3NQL2tMUGNLSVlwNGJuVmJz?=
 =?utf-8?B?K1Z4ZFRvZGc0elJYanRITlh1V2syWkY1MUVFRUdJWGR5VDBwN2R2RWZPUitv?=
 =?utf-8?B?b0owVmlnc0NqZVdGTzl2MFc5WnhEc0ZJL2M0RnBSQ3R2SE5UUmtyRTVtZTQv?=
 =?utf-8?B?LzZxeUZXeGtEeldNdEg1ZjRpNHdjZ29vYitMZTRJeUpFVXpyUW80c1pHY005?=
 =?utf-8?B?ZnRIRFZDSTlab3BJam1MR1hVRHlIY1NKQURvU2tiWEh3SWZ0bkY2emxrdHNO?=
 =?utf-8?B?dDBWUHNiUzF3Qmt4aDJ5ZTdCM1dvZ0o4RWpiL25hSlZINTRPS2VBTUthUFFY?=
 =?utf-8?B?WFNhT0RlUGJFbHloU1RReGZoRlppbkJjOGl2MzNaN0RjcGtnSCsweTZiV1lI?=
 =?utf-8?B?eUpLanYrd05sMUhuSFU2TjZlNHo0YWZQV0xKMVd2dmFUS0twb1ExdEhzeGYz?=
 =?utf-8?B?a05SVWkzMzFkSkpMTmkxYzBHcXpqcUxkblo2NlhIb0RJcmhHYnpJTXVXSS93?=
 =?utf-8?B?TUhGZjhiTFpxWlV4YVBHdFFRdGI5REJuOVFBNGllUGh0ZkpHSTd1NFZUb054?=
 =?utf-8?B?dXR6OEVxN1lib3ZSQXYrK3NoK0wwSElkbzRPZWs3VW04Z3BRQUZuKzJlbm5I?=
 =?utf-8?B?Q09DeGloajVTczBUc3RMSVhGeUhsUGx0ZDQyNkNidEJLTHRXQ25MZ214dU1E?=
 =?utf-8?B?K200ZGx1ZnJMVUhYRklib29id2xIYzgvK0Q4dmwzVENNMWtpZ0s2ZzQ4RDFF?=
 =?utf-8?B?bi9Ickl5a1FIV2ZXcjRCYzVXRXIvWHhsTGFQRHlUQnVNcEdnQ1QvUi9sNTdZ?=
 =?utf-8?B?eWlWZmkxY29jSTYrVjdNMUNQS2lYNi9MM09EM2w4VDhXamlOK1ZuUFdhVTMx?=
 =?utf-8?B?ak5qLytDSWc4RG5MK1AwNUhPZTE3TWh1Rlp5OEJ3V1VnU0kzY1NaaHB0a0Ji?=
 =?utf-8?B?bklTM3BDTERNYXZJSlFRTHhaZys2RWJsL3kyZXBwaTZmMCt0MUJCRVJsNWtF?=
 =?utf-8?B?UUVBMDdMNEpTYlVSU1FtU0J2NmpFbFlpRUtRMFZoaHQ2NnBjblJOdUZlOHVB?=
 =?utf-8?B?ZWMwZCtFR2Y2R2J3eDQrY2pseVNHQ3dVcytVRENOcDMyVXR4Yzh0VnY0N1RD?=
 =?utf-8?B?Z3h6OFBrT2RhTGhRNFFEZ1dzKzA1YkhYcnFsRWk0eDd1MUdPc3ROMzNQdjRF?=
 =?utf-8?B?QkN6QzhxMXN1ZHk0Wk85TlVhYU45QVhwVTYwd3FJdHhzbzJpbk50REFYdXRR?=
 =?utf-8?B?SkEvc1Q2Rk1JT3lINXdCNGRoZlBJaGQ4T0Zoc2JZMGxqZG1CTzh4c2t6c3pw?=
 =?utf-8?B?MzE1dFRvM2s4Tk1iNW4yTVhiM1FkWkVKMHB6dk5rZFlKZHlvVmJXTFBtZFpH?=
 =?utf-8?B?aDVZdzREaUZySUVRWlhINXJGc0lLbHlRci9qR0JzK3FzYU1YR2ZyaFdjREc1?=
 =?utf-8?B?Z1dYWGNhUVY1V29ZaWNwNXE0WWhUT01FM3FFNXlQeDlPTVduMmIraWV4M1hn?=
 =?utf-8?B?djFzVkxlNkhhRW1Cb3UyOWExd1ZiVWplYWk3YjRhcUxndkdYaGw5eVRXdXZX?=
 =?utf-8?B?bTd5dWxiR3htbE1jK3YrRGtPWTh4dGVsYitjSVB1WlRLNFdHTzVwRzBGTUNa?=
 =?utf-8?B?ZktGdCtwbm45WW9RNEV1TzlGRWMybVk4ZWEvdU1zZGZob0FxMkF4MEtmWHRE?=
 =?utf-8?B?ZnBlcjRudi9OZGEzeWk5d1l6YnNHTklLVmJ6bUhLWUQwUzhwbmhFdVRlcERT?=
 =?utf-8?B?U29JRGtzWmlkMnNNTUlMUER6ZHA2dnpTTUgrRlFHaHkrVUtvVDlRaFVxL2Vl?=
 =?utf-8?B?RHRWaXBxQTFkZGkyNkdvSThCQ3JKbmFubjhMMVU3MU10MDVha1lDdjZXc0R3?=
 =?utf-8?B?WGRLMzRSTTllazl0UVJtSytzL1dFTms5bzQyTmI1cWFKTDdkblZZcEo3bko0?=
 =?utf-8?B?cHBDNnNaeXk1MzV1c3Q5c0VEMDIzbXFINDIvOG5tUlZVSlFLelJJQWcxV1Jr?=
 =?utf-8?B?RjN3ckRUcmg0aENSQkREcUtobEI4NmZLSHV4b0dRUmtVSXU1alBOK2o4TWxm?=
 =?utf-8?B?TlZnZzBLOTJ0RHVSY3JNUTNRWUYyeWdLa0JpUjR3QVZnaVozSTB1Y2d3dEZP?=
 =?utf-8?B?Z0JlSHdBbjBlVDZaVnpzSDVYMGdQN1FJRXJWMWdYY2JtZzlkNTN2VjR6RXdM?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c0f038-3db4-424a-4a3d-08d9de9053b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2022 16:49:30.7154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbzoRDIbb2ECrqEbDG0wfmvLfGEtBLoI5vkZ1zgDF4AucQCOsAXnJIhJWciIFygJ0ktH7g2NX5c9ktDPkD+bKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4822
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAyMS4wMS4yMDIyIDE5OjI0LCBBa2hpbCBSINC/0LjRiNC10YI6DQo+ID4+Pj4+Pj4gK3N0YXRp
YyBpbnQgdGVncmFfZG1hX3Rlcm1pbmF0ZV9hbGwoc3RydWN0IGRtYV9jaGFuICpkYykgew0KPiA+
Pj4+Pj4+ICsgICAgIHN0cnVjdCB0ZWdyYV9kbWFfY2hhbm5lbCAqdGRjID0gdG9fdGVncmFfZG1h
X2NoYW4oZGMpOw0KPiA+Pj4+Pj4+ICsgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4+Pj4+
Pj4gKyAgICAgTElTVF9IRUFEKGhlYWQpOw0KPiA+Pj4+Pj4+ICsgICAgIGludCBlcnI7DQo+ID4+
Pj4+Pj4gKw0KPiA+Pj4+Pj4+ICsgICAgIGlmICh0ZGMtPmRtYV9kZXNjKSB7DQo+ID4+Pj4+Pg0K
PiA+Pj4+Pj4gTmVlZHMgbG9ja2luZyBwcm90ZWN0aW9uIGFnYWluc3QgcmFjaW5nIHdpdGggdGhl
IGludGVycnVwdCBoYW5kbGVyLg0KPiA+Pj4+PiB0ZWdyYV9kbWFfc3RvcF9jbGllbnQoKSB3YWl0
cyBmb3IgdGhlIGluLWZsaWdodCB0cmFuc2ZlciB0bw0KPiA+Pj4+PiBjb21wbGV0ZSBhbmQgcHJl
dmVudHMgYW55IGFkZGl0aW9uYWwgdHJhbnNmZXIgdG8gc3RhcnQuDQo+ID4+Pj4+IFdvdWxkbid0
IGl0IG1hbmFnZSB0aGUgcmFjZT8gRG8geW91IHNlZSBhbnkgcG90ZW50aWFsIGlzc3VlIHRoZXJl
Pw0KPiA+Pj4+DQo+ID4+Pj4gWW91IHNob3VsZCBjb25zaWRlciBpbnRlcnJ1cHQgaGFuZGxlciBs
aWtlIGEgcHJvY2VzcyBydW5uaW5nIGluIGENCj4gPj4+PiBwYXJhbGxlbCB0aHJlYWQuIFRoZSBp
bnRlcnJ1cHQgaGFuZGxlciBzZXRzIHRkYy0+ZG1hX2Rlc2MgdG8gTlVMTCwNCj4gPj4+PiBoZW5j
ZSB5b3UnbGwgZ2V0IE5VTEwgZGVyZWZlcmVuY2UgaW4gdGVncmFfZG1hX3N0b3BfY2xpZW50KCku
DQo+ID4+Pg0KPiA+Pj4gSXMgaXQgYmV0dGVyIGlmIEkgcmVtb3ZlIHRoZSBiZWxvdyBwYXJ0IGZy
b20gdGVncmFfZG1hX3N0b3BfY2xpZW50KCkNCj4gPj4+IHNvIHRoYXQgZG1hX2Rlc2MgaXMgbm90
IGFjY2Vzc2VkIGF0IGFsbD8NCj4gPj4+DQo+ID4+PiArICAgICB3Y291bnQgPSB0ZGNfcmVhZCh0
ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX1hGRVJfQ09VTlQpOw0KPiA+Pj4gKyAgICAgdGRjLT5kbWFf
ZGVzYy0+Ynl0ZXNfdHJhbnNmZXJyZWQgKz0NCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICB0
ZGMtPmRtYV9kZXNjLT5ieXRlc19yZXF1ZXN0ZWQgLSAod2NvdW50ICogNCk7DQo+ID4+Pg0KPiA+
Pj4gQmVjYXVzZSBJIGRvbid0IHNlZSBhIHBvaW50IGluIHVwZGF0aW5nIHRoZSB2YWx1ZSB0aGVy
ZS4gZG1hX2Rlc2MgaXMNCj4gPj4+IHNldCB0byBOVUxMIGluIHRoZSBuZXh0IHN0ZXAgaW4gdGVy
bWluYXRlX2FsbCgpIGFueXdheS4NCj4gPj4NCj4gPj4gVGhhdCBpc24ndCBnb2luZyBoZWxwIHlv
dSBtdWNoIGJlY2F1c2UgeW91IGFsc28gY2FuJ3QgcmVsZWFzZSBETUENCj4gPj4gZGVzY3JpcHRv
ciB3aGlsZSBpbnRlcnJ1cHQgaGFuZGxlciBzdGlsbCBtYXkgYmUgcnVubmluZyBhbmQgdXNpbmcN
Cj4gPj4gdGhhdCBkZXNjcmlwdG9yLg0KPiA+DQo+ID4gRG9lcyB0aGUgYmVsb3cgZnVuY3Rpb25z
IGxvb2sgZ29vZCB0byByZXNvbHZlIHRoZSBpc3N1ZSwgcHJvdmlkZWQNCj4gPiB0ZWdyYV9kbWFf
c3RvcF9jbGllbnQoKSBkb2Vzbid0IGFjY2VzcyBkbWFfZGVzYz8NCj4gDQo+IFN0b3Agc2hhbGwg
bm90IHJhY2Ugd2l0aCB0aGUgc3RhcnQuDQo+IA0KPiA+ICtzdGF0aWMgaW50IHRlZ3JhX2RtYV90
ZXJtaW5hdGVfYWxsKHN0cnVjdCBkbWFfY2hhbiAqZGMpIHsNCj4gPiArICAgICAgIHN0cnVjdCB0
ZWdyYV9kbWFfY2hhbm5lbCAqdGRjID0gdG9fdGVncmFfZG1hX2NoYW4oZGMpOw0KPiA+ICsgICAg
ICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiArICAgICAgIExJU1RfSEVBRChoZWFkKTsNCj4g
PiArICAgICAgIGludCBlcnI7DQo+ID4gKw0KPiA+ICsgICAgICAgZXJyID0gdGVncmFfZG1hX3N0
b3BfY2xpZW50KHRkYyk7DQo+ID4gKyAgICAgICBpZiAoZXJyKQ0KPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArICAgICAgIHRlZ3JhX2RtYV9zdG9wKHRkYyk7DQo+
ID4gKw0KPiA+ICsgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJnRkYy0+dmMubG9jaywgZmxhZ3Mp
Ow0KPiA+ICsgICAgICAgdGVncmFfZG1hX3NpZF9mcmVlKHRkYyk7DQo+ID4gKyAgICAgICB0ZGMt
PmRtYV9kZXNjID0gTlVMTDsNCj4gPiArDQo+ID4gKyAgICAgICB2Y2hhbl9nZXRfYWxsX2Rlc2Ny
aXB0b3JzKCZ0ZGMtPnZjLCAmaGVhZCk7DQo+ID4gKyAgICAgICBzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZ0ZGMtPnZjLmxvY2ssIGZsYWdzKTsNCj4gPiArDQo+ID4gKyAgICAgICB2Y2hhbl9kbWFf
ZGVzY19mcmVlX2xpc3QoJnRkYy0+dmMsICZoZWFkKTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1
cm4gMDsNCj4gPiArfQ0KPiA+DQo+ID4gK3N0YXRpYyBpcnFyZXR1cm5fdCB0ZWdyYV9kbWFfaXNy
KGludCBpcnEsIHZvaWQgKmRldl9pZCkgew0KPiA+ICsgICAgICAgc3RydWN0IHRlZ3JhX2RtYV9j
aGFubmVsICp0ZGMgPSBkZXZfaWQ7DQo+ID4gKyAgICAgICBzdHJ1Y3QgdGVncmFfZG1hX2Rlc2Mg
KmRtYV9kZXNjID0gdGRjLT5kbWFfZGVzYzsNCj4gPiArICAgICAgIHN0cnVjdCB0ZWdyYV9kbWFf
c2dfcmVxICpzZ19yZXE7DQo+ID4gKyAgICAgICB1MzIgc3RhdHVzOw0KPiA+ICsNCj4gPiArICAg
ICAgIC8qIENoZWNrIGNoYW5uZWwgZXJyb3Igc3RhdHVzIHJlZ2lzdGVyICovDQo+ID4gKyAgICAg
ICBzdGF0dXMgPSB0ZGNfcmVhZCh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX0VSUl9TVEFUVVMpOw0K
PiA+ICsgICAgICAgaWYgKHN0YXR1cykgew0KPiA+ICsgICAgICAgICAgICAgICB0ZWdyYV9kbWFf
Y2hhbl9kZWNvZGVfZXJyb3IodGRjLCBzdGF0dXMpOw0KPiA+ICsgICAgICAgICAgICAgICB0ZWdy
YV9kbWFfZHVtcF9jaGFuX3JlZ3ModGRjKTsNCj4gPiArICAgICAgICAgICAgICAgdGRjX3dyaXRl
KHRkYywgVEVHUkFfR1BDRE1BX0NIQU5fRVJSX1NUQVRVUywgMHhGRkZGRkZGRik7DQo+ID4gKyAg
ICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgc3RhdHVzID0gdGRjX3JlYWQodGRjLCBURUdSQV9H
UENETUFfQ0hBTl9TVEFUVVMpOw0KPiA+ICsgICAgICAgaWYgKCEoc3RhdHVzICYgVEVHUkFfR1BD
RE1BX1NUQVRVU19JU0VfRU9DKSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIElSUV9IQU5E
TEVEOw0KPiA+ICsNCj4gPiArICAgICAgIHRkY193cml0ZSh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFO
X1NUQVRVUywNCj4gPiArICAgICAgICAgICAgICAgICBURUdSQV9HUENETUFfU1RBVFVTX0lTRV9F
T0MpOw0KPiA+ICsNCj4gPiArICAgICAgIHNwaW5fbG9jaygmdGRjLT52Yy5sb2NrKTsNCj4gPiAr
ICAgICAgIGlmICghZG1hX2Rlc2MpDQo+IEFsbCBjaGVja3MgYW5kIGFzc2lnbm1lbnRzIG11c3Qg
YmUgZG9uZSBpbnNpZGUgb2YgY3JpdGljYWwgc2VjdGlvbi4NCg0KT2theS4gU28sIHRoZSBsb2Nr
IHNob3VsZCBiZSBoZWxkIHRocm91Z2hvdXQgdGhlIGZ1bmN0aW9uLg0KRG8geW91IHRoaW5rIHRl
Z3JhX2RtYV9wYXVzZSBzaG91bGQgYWxzbyBob2xkIGEgbG9jaw0KYW5kIHJlbW92ZSBpcnFfc3lu
Y2hyb25pemU/IFRoYXQgZnVuY3Rpb24gYWxzbyB3cml0ZXMNCnRvIENTUiByZWdpc3Rlci4NCg0K
UmVnYXJkcywNCkFraGlsDQo=
