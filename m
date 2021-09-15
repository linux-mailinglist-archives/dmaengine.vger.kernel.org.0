Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9E340C13C
	for <lists+dmaengine@lfdr.de>; Wed, 15 Sep 2021 10:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhIOIJi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Sep 2021 04:09:38 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:48024
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236528AbhIOIJh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Sep 2021 04:09:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSTMJ/rBTFpkgHJzv2uWhUuIfwUa9xFelYUO2xxAn294H2DYfXojxpjOv6Tud+Rr8Id6pZs0MBKpvWtRLej9xbYaEzWDHKQqE4ck3gt1eRNE7hyBu2sz1ShIfpd6lgM0ltXxcEfUCHQWc3VVHK4GblmD+GbidrOTy9/ssqiePPH42fZ1dCl2VePmqOo/sIsLuW28/ar9FoTtKRB/FoCZAFVOCqvnipdMzp91oYS2+PizSNuA8bh43I7oNwTrzTFqNng3a+Hf9mMdHgtWVQJYstt3hJDIRQy0NRLOyi7X8uUXjLMuYDEqnyCSdW8GvTuWzxWlmSbe3iPRpbee9CouZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GIuOsMgNJndbsjMvtNL9elSiEfP+/qlOljoXI3KvAqk=;
 b=NpOpHYOpm9Am7NptXxAswYG7yVh7qcbC81UAgnGImDo4X1nsjrkTxi2vI1RVFp9s48PShYXMw1OfhXOfE6PTBt6j26j2mpeG9v4p6pEpQm7Y9N8Wt8Y31QcuYlipFEl8btmKqJPDVeID2B7w2PY9Y71ZoCNzSL+fuFHF8lUGu3DBFl27qo77zFk/C1da9NILv0l41wB7uBhtIstnpXds4cqoSvCXXLPZU3llE+Tsh2tPs/VFvUiRRd1PFGDeB0zBDFGVAMCDM377/ZIkCe0nw3XopMkg+lbb0jcFMjfGwU2kDEpt0p6ogd5b90xaHDIPg8Ettek5pdPz6G3hy5QSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIuOsMgNJndbsjMvtNL9elSiEfP+/qlOljoXI3KvAqk=;
 b=SCT7zm4i2UR66StNDKyZVuYbpqBNdHstD0W5co1aCPDRYU2UfSUt6JdPBGu7Qru57L3juidN6wmS3UZfzRGqkUlSPFdBhhsmUMNZm8vPLVsgfcMVxIvCAqO3+9eDq7lR2OF8bnKwDztzF+3MCRctFB/jTIQS78vnAJRZM1SIDrlYbd3PHE0lkRTtYOZ7gS6qVYSsniKpc087fTjlPiCMHpluXsB1d55lWtXYhmyM5aQet7S0jl7sWkUU2TtZQX94Y+Ib9RrVWieKLwx3ryEQPF/MR5N2qk8ybsQQ+tLIsTrYSMlHqi0ojlcIan9cd4Vft81CrxmdWrV2MqQdPC+djw==
Received: from BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 08:08:17 +0000
Received: from BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::b54f:5a6c:caf8:7445]) by BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::b54f:5a6c:caf8:7445%3]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 08:08:17 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Subject: RE: [PATCH v4 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Thread-Topic: [PATCH v4 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Thread-Index: AQHXpL56LSpoe1uUWU607pXvC88bZauaWB+AgApuU7A=
Date:   Wed, 15 Sep 2021 08:08:17 +0000
Message-ID: <BN9PR12MB5273B8EC67EEC1D97DE9A7ECC0DB9@BN9PR12MB5273.namprd12.prod.outlook.com>
References: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
 <1631111538-31467-2-git-send-email-akhilrajeev@nvidia.com>
 <f65b59f3-00b4-11bf-5509-c47c4ed862f3@nvidia.com>
In-Reply-To: <f65b59f3-00b4-11bf-5509-c47c4ed862f3@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de7d1be1-c991-4618-d58b-08d9781ff96d
x-ms-traffictypediagnostic: BN9PR12MB5097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5097AA1DF20B459BE9CA5426C0DB9@BN9PR12MB5097.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mdosUCZvNg7IOTHWaAIjNfQ3x6pG3or9p7pzYEERAw6n7XMN8UjS1DQyx3KWrj4JrGAWeImd8ONdeWptlOeLkEbyp+uat2n6ZK9iQOQjuR6ve08Dl5yMm+B87Y9nI0s9iaMa2SNqIYTTwEsAd60wisXwDoiblWyKw/rSCH3Je5jMPcYOJ/cTQWmtfFSG0mn4+wwRwhultyRgdN/pWwJ2VxjjSv1ea+cmnyaJh9ypavtPBNKCE1vnjkX63LH7usCFJg5o1P+zIaxEcHqLCrsf5w1Wa1FwVE6xnFz2qpqS4jB/oDmUag/YO9EzE2BNfWGP2FDU1DHKEUJuWdP3wgUXKnbZOqPhA95VqC3IDSvugF6mzAj6OXdE3a4MNyTKMJN6N871s1Pmehvm5HbG9RWi4lUTqHLwDtVVkqQ4xr8xDDsUSWAaF1MOUyOKRUyhXL41OGNbxvgFa4sg7m/kNgx8fjamBE+LAH8cdMapA2zHmUL7HIIKkt7fc3In1q5mqoJ578wHgtI7We8MomimtZyvSAdgUJmAxS2r6KVUfWtWwoOWQBKPYFHZ/rjm9ct1QbHgYZ6VRRR3zeRXRbTBKCG25RqoL/RUOcoXlaZWlIYUV44kSmPflWWbaLo6A0MXn7ssTpTKrLoXKlDyKrMCRwQpHOkleNZ1Cbso0ey6Zjp/5tf3UqfSmoQUHnHIzQ7ZzH/fdhWxF/7RD8aYhVcUaitEM8sFMQHbA6C8P2NfR6X7gfpoe//YmAIjxpvbweZZJ+sS32A8kho1697Rf51Ejde6FteREK9jmTkBCJQ5ovKxa4llDVpiFmxZQr3EMrgF+LSIvApgzbJwaoqMjGiT0MH1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(76116006)(66556008)(66446008)(66946007)(66476007)(86362001)(122000001)(83380400001)(38100700002)(38070700005)(33656002)(8936002)(71200400001)(55236004)(7696005)(6506007)(53546011)(6636002)(2906002)(8676002)(4326008)(966005)(54906003)(5660300002)(26005)(186003)(55016002)(6862004)(316002)(52536014)(9686003)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXc4UWhONGJNdGJKOXBHZEgvaXRpWTMrdXpWT1hucWFualVKeDg2WG5ZTVNC?=
 =?utf-8?B?WkR1aWFXWmpqMWRUWEFVL3oyNEx1VEJtRHovU0l4ZFVKc2oveEFrV2o1OHZn?=
 =?utf-8?B?dENnMGlWZ1FYbXZiT0dIVUt4VSt4QU5udGo4ZGJqWTducmI5MFo1ZnhzK3NO?=
 =?utf-8?B?NHZDMlhJRU94cVB5NnZHSlB6Tm03NXg0bHpQSCt5Nk1YWFRQNXo3dEdoUWxW?=
 =?utf-8?B?QjB3VEQwU2FGclBtUU4zWUd5MzE4a3ZtRVVhY1pueHVzbSt5Z2FVaU41SkNw?=
 =?utf-8?B?T2dvQjA1SlV2SkJad0o1VlQwNE9IUE1UcWNNOHdqVGhDYkp0ZXh2eTZDOUNn?=
 =?utf-8?B?N0cxQUp3UEx3akJIMFV6RzlVMEI1bThlUUorcWdxa2JxWFZDVkJjV2xWb1ZH?=
 =?utf-8?B?SFpXdUY1V2E3MElpNkgwWGk4RkRCME1OZzNhOStRTVhtVHFPeGM2MURLc0c4?=
 =?utf-8?B?RDAybnlpdjNLb0h3bVhBWi9OSUY3MFZTT1JyY0NHSnI5akR6WXBoa3Q1ckE0?=
 =?utf-8?B?TUJ2dFREM21FU082eGphTi8vUFhSY3ZEWHBGYzlGRjB3UmFKUDVQTEJUa0xG?=
 =?utf-8?B?ZjMxVDdRREV1bzJ5RlJBYkZDWTBTcjJacTBCbWR2QmhJKzNmaDd6YVVhV0hk?=
 =?utf-8?B?NmxlVDNFcFA3UzM5QmU4d0ZncndYQ0xBYWhHQXhwbUMvbEZ3L0FWNUI2QjZU?=
 =?utf-8?B?SmZycUV5T2ZLNUxwR0ZhVGtvRmoyRGpjd3hqMi9IcjRiWm52b1VPUngrSWdE?=
 =?utf-8?B?VVFzV1k4SWkrOTlwRGR3eWdsOHVuZjRlQ1JPbmpPUGZPeE9UMUhmbC9XY0lL?=
 =?utf-8?B?K2w4NnI5UTBuamdabExvdDBWSWlXN1ZTYk0vdm5NaytaSXNMaXdMOTVWNW0v?=
 =?utf-8?B?TFd4S09HYUJ1WWF4aFViZ2Q3NGJUcE0wQnVzdjlmNXVuOEU1YjJKalZwY1hP?=
 =?utf-8?B?SHdiamNXRXp5c0tmS3NKbUN4Q3VrL1BEVGpuQnEwL1ZINFRUZWw0NDRZZTJm?=
 =?utf-8?B?bkZ6UmM1YTlSNi9FWWJaTFhtOFBZL2JPNTBGdGxBZWdaeVU3RCtXSFptaDE1?=
 =?utf-8?B?RVBDTnAxb0FDck94N1ovNEtFVm8ydjM2TkJMZTE1YmNlSW1hd3FXZXhteTZj?=
 =?utf-8?B?VjBLMU1FOUJySUdPTHVEemhkeGJjOVFXbXZQbDBhY04wbk50OTFzL1Q4Wkhi?=
 =?utf-8?B?MkZtemVHaE1YbGdYa0REVEpQM0dnaU54eFVDamtBeFEreS93d0diY1M1U1pS?=
 =?utf-8?B?OGZWdWNDZXBhTHJIL3dVTUNaaDJNOGZRMWgvVU1QUmRTb2dibU1YYms5Rkk0?=
 =?utf-8?B?WEo5WWdoQU5jVVppRVFMcTlRcE45ek9yczNYWVZCWWE4MGJNRHdGWGdPaGJT?=
 =?utf-8?B?Z3lMc3gxTE94dTdPUm9WYUFZMmJUNWhqdFBabUl1TElCWnU2UmRDS2pPNk1R?=
 =?utf-8?B?V3hnRWhNVG11UjVmd1p4Q1Jpdy8zUEtKM3JoeWtjWUkwZFdYdklYRUo1djg4?=
 =?utf-8?B?bVBNNEtuajkvUVFrMXZUVEhheWZVRXFpZmsxcmhJTEV6MU5KM0h4MFV1VlI3?=
 =?utf-8?B?R3poRk02V28yV2dKTGRjbWpSaVozQTNyYkF5RHlvYi9NVHZWdUd6K3JtYzV5?=
 =?utf-8?B?UENPKzFVS3VDQXl4a1ZPa1RPSFk2RGZheThITHZUNm1Kbm43Zlp6ZExmcEZH?=
 =?utf-8?B?VWtDVkxyK0Flc0ZUQk9pSjRIS2UvczduYUU4SWRDSTFNbEcwaGZKTm1KSHMx?=
 =?utf-8?Q?VZz1r74y31R9ZpjNptfd+dCKhLEhRnAbMfSJyUh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7d1be1-c991-4618-d58b-08d9781ff96d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 08:08:17.1400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jiOAvk15R759i39ga7S7eaZC0wTKR+QvKi+KrsfLhWSNhX8KYIvYqUg3X2KpckJJfiwAw7zVjqOSHmlOT2zjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBPbiAwOC8wOS8yMDIxIDE1OjMyLCBBa2hpbCBSIHdyb3RlOg0KPiA+IEFkZCBEVCBiaW5kaW5n
IGRvY3VtZW50IGZvciBOdmlkaWEgVGVncmEgR1BDRE1BIGNvbnRyb2xsZXIuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBSYWplc2ggR3VtYXN0YSA8cmd1bWFzdGFAbnZpZGlhLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBa2hpbCBSIDxha2hpbHJhamVldkBudmlkaWEuY29tPg0KPiA+IC0tLQ0K
PiA+ICAgLi4uL2JpbmRpbmdzL2RtYS9udmlkaWEsdGVncmExODYtZ3BjLWRtYS55YW1sICAgICAg
fCAxMDYNCj4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTA2
IGluc2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvbnZpZGlhLHRlZ3JhMTg2LWdwYy1kbWEueWFtbA0K
PiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2RtYS9udmlkaWEsdGVncmExODYtZ3BjLWRtYS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZG1hL252aWRpYSx0ZWdyYTE4Ni1ncGMtZG1hLnlhbWwNCj4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLjAwYzU1ODINCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2RtYS9udmlkaWEsdGVncmExODYtZ3BjLWRtYS55YQ0KPiA+ICsrKyBtbA0KPiA+IEBAIC0wLDAg
KzEsMTA2IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkg
T1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2Rl
dmljZXRyZWUub3JnL3NjaGVtYXMvZG1hL252aWRpYSx0ZWdyYS1ncGMtZG1hLnlhbWwjDQo+IA0K
PiB0ZWdyYTE4Ni1ncGMtZG1hLnlhbWwNCj4gDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IE52aWRp
YSBUZWdyYSBHUEMgRE1BIENvbnRyb2xsZXIgRGV2aWNlIFRyZWUgQmluZGluZ3MNCj4gPiArDQo+
ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgVGVncmEgR1BDIERNQSBpcyB0aGUgR2VuZXJuYWwg
UHVycG9zZSBDZW50cmFsIChHUEMpIERNQSBjb250cm9sbGVyDQo+ID4gK3VzZWQgZm9yIGZhc3Rl
ciBkYXRhDQo+IA0KPiBzL0dlbmVybmFsL0dlbmVyYWwNCj4gDQo+IEkgd291bGQganVzdCBzYXkN
Cj4gDQo+ICJUaGUgVGVncmEgR2VuZXJhbCBQdXJwb3NlIENlbnRyYWwgKEdQQykgRE1BIGNvbnRy
b2xsZXIgaXMgdXNlZCBmb3IgLi4uIg0KPiANCj4gT3ZlciA4MCBjaGFyYWN0ZXJzLiBJIGFzc3Vt
ZSB0aGF0IHlhbWwgZmlsZXMgaGF2ZSB0aGF0IGxpbWl0YXRpb24uDQo+IA0KPiA+ICsgIHRyYW5z
ZmVycyBiZXR3ZWVuIG1lbW9yeSB0byBtZW1vcnksIG1lbW9yeSB0byBkZXZpY2UgYW5kIGRldmlj
ZSB0bw0KPiBtZW1vcnkuDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEpvbiBI
dW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPg0KPiA+ICsgIC0gUmFqZXNoIEd1bWFzdGEgPHJn
dW1hc3RhQG52aWRpYS5jb20+DQo+ID4gKw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6ICJk
bWEtY29udHJvbGxlci55YW1sIyINCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgIiNk
bWEtY2VsbHMiOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArDQo+ID4gKyAgY29tcGF0aWJsZToN
Cj4gPiArICAgIC0gZW51bToNCj4gPiArICAgICAgLSBudmlkaWEsdGVncmExODYtZ3BjZG1hDQo+
ID4gKyAgICAgIC0gbnZpZGlhLHRlZ3JhMTk0LWdwY2RtYQ0KPiA+ICsNCj4gPiArICByZWc6DQo+
ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHRzOg0KPiA+ICsJbWlu
SXRlbXM6IDENCj4gPiArICAgIG1heEl0ZW1zOiAzMg0KPiANCj4gWW91IGFwcGVhciB0byBoYXZl
IGFsaWdubWVudCBpc3N1ZXMgYWdhaW4uDQo+IA0KPiA+ICsNCj4gPiArICByZXNldHM6DQo+ID4g
KyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICByZXNldC1uYW1lczoNCj4gPiArICAgIGNv
bnN0OiBncGNkbWENCj4gPiArDQo+ID4gKyAgaW9tbXVzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDEN
Cj4gPiArDQo+ID4gKyAgbnZpZGlhLHN0cmVhbS1pZDoNCj4gPiArCWRlc2NyaXB0aW9uOiB8DQo+
ID4gKwkgc3RyZWFtLWlkIGNvcnJlc3BvbmRpbmcgdG8gR1BDIERNQSBjbGllbnRzLg0KPiA+ICsJ
IERlZmF1bHRzIHRvIFRFR1JBMTg2X1NJRF9HUENETUFfMCBpZiBub3QgZ2l2ZW4NCj4gDQo+IA0K
PiBXaHkgZG8gd2UgbmVlZCB0aGlzPyBEb24ndCB3ZSBhbHJlYWR5IGhhdmUgdGhlIFNJRCBpbiB0
aGUgaW9tbXUgcHJvcGVydHk/DQo+IA0KPiBKb24NCg0KVGhlIHZhbHVlIGlzIHJlcXVpcmVkIHRv
IGJlIHdyaXR0ZW4gdG8gdGhlIHJlZ2lzdGVyIFRFR1JBX0dQQ0RNQV9DSEFOX01DU0VRIG9mIHRo
ZSBETUEgY29udHJvbGxlciAoaW4gZnVuY3Rpb24gdGVncmFfZG1hX3Byb2dyYW1fc2lkKSBmb3Ig
dGhlIERNQSB0byB3b3JrIGFzIGV4cGVjdGVkLiBJIGNvdWxkIG5vdCBpZGVudGlmeSBhbiBhcGkg
d2hpY2ggY2FuIHRha2UgdGhlIHZhbHVlIGZyb20gJ2lvbW11cycgcHJvcGVydHkuDQoNClJlZ2Fy
ZHMsDQpBa2hpbA0KDQo+IA0KPiAtLQ0KPiBudnB1YmxpYw0K
