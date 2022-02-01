Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0F84A5BD7
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 13:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbiBAMF7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 07:05:59 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:45089
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237573AbiBAMF7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 07:05:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCHuS6+gbItQDSeOdNNtjBkmB6vYgSyUx5HWVP6D8VQuT9kSj1dW32khcGK3KRA9KWOakedj2d4m0baV8BKH8GtbfscCWODZ+jdk0SpQLFtmu5fdyE3qIj1K3iUY5F+FxFx3kYz8mp45i/lprmXvhpGdI4IlfsDkIECYMxQIdO4UnlnnMgwDk+NMO1J21E0HQAqYzdFKqiAVbl00/6Ta4cA2NgiJOTc/HIMl9L9Mfl3a6f2yVl4u8FsqM6iWNPTYJ+fKCDSqlFhAI7NRTciRVIVBE1QSIzjo+B5D8t94/t+nyj2XNuDo64UaGPjMBpupki7ZNKUU7ArR2VSD6Su91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcNxyrELPj8/xfW69ZYVCkKZN4wqwVcTMJABurdkSLs=;
 b=am6o/I6iJNNQ1C2Ds6K3Vuw5yKwoEXSD7mdnUgnsFmlX/ogbPKCxtr7jNvBgFVe44jdjdttrvSlRSfStosRkXQpoc+tJj5C7XM6iiESQfi3+3+FgpS2elCsnnI6ncN/VcoCi2QKFd5ShAJ9qAOppEespifqGTyHu7UdxZDJ+5h0M+1c356VH0Av1AzCee3mTcdeCSvW+KAgtr0Agdb5XVEgoTMcKWofN/gJnNhT1HQtrfBj+JWa6TkgbVWPCRxlywDQsYzqRKOQ8iP6sGyG0goLkFFvCWSqe1HcaCCDCgvDteeo3MuRN0xrekfY72JWG+ryVmKQ/R/ScoJ15yokzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcNxyrELPj8/xfW69ZYVCkKZN4wqwVcTMJABurdkSLs=;
 b=lY1aNPXZco44Tyxf6KM7EOQiNa+MIybrMYby/rCU9ShoG6JNSMN+eHPd2L3qG1Fj+axLGxtZ7a0Syr7LBthaE4FEAFurV3PwIWt1NRBQKc9WwtHKSo0Piu9U7Zm79e2rOlEjiZJ2sEtTs0WA3XnSSObytZj6Omd/ce37Q+xhmXyVbKYI0D28b/7Gw3sQ65PY1JjLjvKX599QioIT4EJHiQlaTm7uPiFpN3xBtefUh9nWFbrZLLpRw8oo3CTyUEH7ue/kiCwz3aiSSl+tpA485/vEhn2Sza2cG3Pzi/t9NJRGDF5ukE7fN28P4gzfLsQPNZyaedH4Ux38Jvko376zbw==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 12:05:57 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 12:05:57 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYFS8ttZm9vnsYMkmLjfwGSkse9qx7V3sAgABn8UCAAHOwgIAAU3IwgAAqZYCAACYYkIAABPUAgABaxWCAABhugIABTS6Q
Date:   Tue, 1 Feb 2022 12:05:57 +0000
Message-ID: <DM5PR12MB1850689286F20C18B12ADF1DC0269@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
 <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
 <DM5PR12MB1850D836ACDF95008EF74CC7C0249@DM5PR12MB1850.namprd12.prod.outlook.com>
 <08f6571e-af75-b6b3-443e-e86e3bdb365b@gmail.com>
 <DM5PR12MB1850FD5F3EF5CBFEA97B3611C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
 <20220131094205.73f5f8c3@dimatab>
 <DM5PR12MB1850D677140466EC74C621A4C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
 <8abf2da8-9a11-8f16-b495-d8ef2d00ab51@gmail.com>
 <DM5PR12MB18505C4CB4A34F96E74BF28FC0259@DM5PR12MB1850.namprd12.prod.outlook.com>
 <6dfdfd02-bfc3-1626-f819-7ddcc8bf9c1c@gmail.com>
In-Reply-To: <6dfdfd02-bfc3-1626-f819-7ddcc8bf9c1c@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7543c9da-97f1-4710-4493-08d9e57b3498
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_
x-microsoft-antispam-prvs: <MN2PR12MB41594DCCAC06A8A35FE7B11BC0269@MN2PR12MB4159.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SgN7DZOD1RodQf609nCORsmfvJhizD6TfiuIZtfaoV/QEBApAbJULbFZxT3dZeh2Qu2XdKJfInpgt8qLXWrUiTO8VnXfGKb3o5rB9e5KrzXoylDR9I7GQ2PiQobJo2hm1scU3A9irBcg2sUKDwH8JYuY0g/vk1SX09biuPcGxBGpYkWdwRDle+F7IcH6lHF89kgkBJQZgf4UBSWRZEe1aHgtDhW0bmRk9qR8tMFrB/RBFsSNO9I4m9yAhFOE+IjyuLaWKCv2hK85QtgrfL72pDetodQJ4Nq1x1S4aFEOsI8bM+qIXwZxwAP2ll5DjSQBJOWrIneTP7nR3t/gMQS/Wj/Q45SksGU8m350li4tck+1gvwDRJDhQ6hVf2w7hQGGrGPe6lWa2NCnirGMH/q/wsMFFR9qKQtOqyjV5OY52Lq5cH81uplV45sA06qbmyacv0r8MMSqrFk0bP3kCZTbfrQVoeO2/XC51Pujl/ngG/PpBkHp/mlf42j0GBlgDxhIT58O3baOn8hJRyWAI4eW0BNOmcZApVE0esYbu2iRmroYzPjze2m4A3kdfvsgoGMt1DnH6Gk6j1xMNp4OpUX8aX7Ta5aMBrel94+PWl1nY95OrKZFfxUPhmwPNiBeBLpOQmHSRtTzQ7NTzcuT0U3O37eAwLRaSnOBk4w1MjrGsDmHSScj/V7BvlK4AsuVyqKyAvuTvaPAaEmCBxte6ZCQ2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(7696005)(38070700005)(107886003)(6506007)(55236004)(186003)(38100700002)(66446008)(66946007)(316002)(76116006)(66476007)(64756008)(508600001)(66556008)(8936002)(8676002)(54906003)(5660300002)(71200400001)(6916009)(33656002)(52536014)(83380400001)(2906002)(86362001)(9686003)(55016003)(122000001)(4326008)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0VJdWtBN3VuNk82WllYM1JpQXBRbXZCeWdFTW45VUFPNHM3QXFnWXJnU2J1?=
 =?utf-8?B?NHhaNnFoLzJFTVNPK3RKc2dPVVR1MHVLWnl0ZzhUemx1RDhaMGJoakFqbnlx?=
 =?utf-8?B?UjIrcHE1OFNWUUZ3MEthaFE4THZBbVZBUzNnSmg0Q0VrQkJxUzB1TTQ5Zmk3?=
 =?utf-8?B?ODJuaGNoVkVaNFNjME1CUk94YkQzVFRyY3l3VFh0RDF6ZjE5MURsNXVlVE9a?=
 =?utf-8?B?NitvRWhid2toNVg1ejBYaVdZNWhkcDZONVJOQy9ZdC9aOU9BQUZmQmlDNWlj?=
 =?utf-8?B?ZTFMeklWRzhtNGdoa01sLzVFMGl3VkZBOE56UUF6SmJoQ3dSUldpa2hCeEJt?=
 =?utf-8?B?d05pWi96Y083dDNqZzZBN3kxMVp2L2ppNjhIUTlic2l5ZElzUm9MSHIrZ3ly?=
 =?utf-8?B?Z2dNUDc4K3F2WE1UZUtPRnBiL3BYaWp0MnZKUUh2ODA4dG10MnEweGxFQzNu?=
 =?utf-8?B?SXl1enIzWlQyQlp6SFpxOHMwR21GRG44OUJEK1lENE10MlF5VFhzN2dwTVBE?=
 =?utf-8?B?TWU1bVg2VXRhTUIvR24vOUhkM1hSTU15eFRnTy8xTHErU3o5a2MzcmZUZ3d3?=
 =?utf-8?B?a1lzdTNDRnVmdDJPY0VNTk1sdHpwLzNRUCtRbm96RjBTWThHejZBMnhPQUE4?=
 =?utf-8?B?cEFzK1Z3citGS1puczVCZmtHZWRLY3hEYjhZUXlraytnczRtQ3hRaXk4MVo3?=
 =?utf-8?B?TnhCbDRpSTIwUlFYMlhkMnZsRUFYZ1BWby9scHlMT1FmMmQzRzh1N0NSSnBC?=
 =?utf-8?B?N0gwN0M4aUtVbTd5blVhK2pTVWtaKzZIM3NCRzgvUndYUnlWWG9sQ0NwMHlW?=
 =?utf-8?B?dkZQNlM0aE1SQXZFWVZYUUlYQ3FDNEswY3FlblJHUHFXdVlsbm1oQjdneE5J?=
 =?utf-8?B?ODBHK1h5QVY2eFVsS3FsNW54SzBBeStzOUpOU1kvdGdJVFVrdzlaOWRpSTV4?=
 =?utf-8?B?UXBRcExiM2w4L08ydkJ4TjBJMXNsY1J3OEY2ZUFQWW1vWG5UWVRlTmJUamE1?=
 =?utf-8?B?NEt3QVhBZmdSRHlGVXBnYTR5THpOckx6RDYxWnRFRXdTQjV5a1RCMVgwT2Rv?=
 =?utf-8?B?bGtNNnY4ZjJCU0ZNRHlLL0NrVXhialMxYlRxbCtXcXc3bTRUdFdIRmZUdklL?=
 =?utf-8?B?QXpIaUNQUVRGRm1XUWNwVTdKVHpxdzJ2a2c3OGhob3J4cmFmbElDRUxicW9T?=
 =?utf-8?B?NzZLMlJMN1NKbzZnOXFhaWF5SlVIdkpJakRZazJSUllrcCtFYkNFV1RPY1ZU?=
 =?utf-8?B?MHhZMytUVU96anJXb3FaRGJpTGp5V2xMa0NIYW04MWwwSlRyZVIxYmhkK0FI?=
 =?utf-8?B?ZjNzZEx1UW9qbDZtNlNzRkkwYmNCQzFCMm9jMUZTcG9FcjdlWGFQaE90RzRZ?=
 =?utf-8?B?QndvTzJaVERSSjVma2tQK0tiTnBKOUNEdmFiNkhtNmlQT3lVcEFsN1dnNG1m?=
 =?utf-8?B?d1B5VmEzWk1tTFJ6L1lSZy8rNEtEMHBzcXovRnVRdTQ1d3p4Q3lTOW8vRlZr?=
 =?utf-8?B?QytTYkk1d0pUR25uQnd6dDNSemZPYjhJb2V6dDY2YXF4dzY1WEtWNWNhSVdt?=
 =?utf-8?B?aXZNaDl4NWIzcWRoQzVBZ2J5QXZ5YjBwN0h1MHNrQ0s0VWxmZFh5ck0zZXZD?=
 =?utf-8?B?d3h0cy9RREk0UUJlWkN2S1dCWU96ZzhIc1NlMkJHMzdObS92aHJKdzdnRVBT?=
 =?utf-8?B?Z3lvc2ZSWXhna05CRHVWTkNrVmMyQVZiUEphOFZGWXVlMEd5QlhBelp3S1hO?=
 =?utf-8?B?aFliTU5PNkp2YWlkQVE3OUVIMGZkUTZsaXNZUGFvcWp0RFRLcFpuMnloUmlm?=
 =?utf-8?B?dEZ5WXI0ZjQ0ZlVPTTR6SEkyQ0xsdHRNOEJJTjR5NDRxcjlkNTlETktWSm0w?=
 =?utf-8?B?RG1TSTBEMXpzNU1sVUhmOTNCU2VpRzdLVlh3QU8reWllTTdKMTdyenpDNHRi?=
 =?utf-8?B?N1J4VFlkUTUwY3lMVytrRis5WXNiTVhqYzdKcFh0MHVITmVtVmJGdDNSOEVh?=
 =?utf-8?B?OUdwZmRueHA1YlJ3aUcveDNlMlArUTZHUTYxZkJGMVhjVlJ1ZkZjbi8xb1Az?=
 =?utf-8?B?aFpZaFloUWRuRUJ2SC9WYW1VeFQ3ak0vYTgvblZEZnpmaTlVQ2FtZDFsSnBY?=
 =?utf-8?B?Y1grNW1NNk8yMUZlcm5VQ055cmYvbEU0SUNDQldKc1BBWEI3YnRVODROUDlJ?=
 =?utf-8?Q?1S1aV6Z5muvBJZfY8B46oqQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7543c9da-97f1-4710-4493-08d9e57b3498
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 12:05:57.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZufYBUdl/tf0bSJHxobGqJULEln55THWQ4UCTBrTBVjfeeH7eevNZRjj8UfQzsWcFMu4wH1LCDKIXDcsjjbog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAzMS4wMS4yMDIyIDE4OjM4LCBBa2hpbCBSINC/0LjRiNC10YI6DQo+ID4gRG9lcyB0aGUgYmVs
b3cgbWV0aG9kIGxvb2sgZ29vZD8gYnl0ZXNfeGZlciBpcyB1cGRhdGVkIG9uIGV2ZXJ5IElTUiBh
bmQgaW4NCj4gPiB0eF9zdGF0dXMoKSwgdGhlIHdjb3VudCBpcyByZWFkIHRvIGNhbGN1bGF0ZSB0
aGUgaW50ZXJtaXR0ZW50IHZhbHVlLiBJZiB0aGUNCj4gdHJhbnNmZXINCj4gPiBnZXQgY29tcGxl
dGUgaW4gYmV0d2VlbiwgdXNlIHdjb3VudCBhcyAwIHRvIGFkZCBzZ19yZXEubGVuIHRvIGJ5dGVz
X3hmZXINCj4gPg0KPiA+IHN0YXRpYyBpbnQgdGVncmFfZG1hX2dldF9yZXNpZHVhbChzdHJ1Y3Qg
dGVncmFfZG1hX2NoYW5uZWwgKnRkYykNCj4gPiB7DQo+ID4gICAgICAgdW5zaWduZWQgbG9uZyB3
Y291bnQgPSAwLCBzdGF0dXM7DQo+ID4gICAgICAgdW5zaWduZWQgaW50IGJ5dGVzX3hmZXIsIHJl
c2lkdWFsOw0KPiA+ICAgICAgIHN0cnVjdCB0ZWdyYV9kbWFfZGVzYyAqZG1hX2Rlc2MgPSB0ZGMt
PmRtYV9kZXNjOw0KPiA+ICAgICAgIHN0cnVjdCB0ZWdyYV9kbWFfc2dfcmVxICpzZ19yZXEgPSBk
bWFfZGVzYy0+c2dfcmVxOw0KPiA+DQo+ID4gICAgICAgLyoNCj4gPiAgICAgICAgKiBEbyBub3Qg
cmVhZCBmcm9tIENIQU5fWEZFUl9DT1VOVCBpZiBFT0MgYml0IGlzIHNldA0KPiA+ICAgICAgICAq
IGFzIHRoZSB0cmFuc2ZlciB3b3VsZCBoYXZlIGFscmVhZHkgY29tcGxldGVkIGFuZA0KPiA+ICAg
ICAgICAqIHRoZSByZWdpc3RlciBjb3VsZCBoYXZlIHVwZGF0ZWQgZm9yIG5leHQgdHJhbnNmZXIN
Cj4gPiAgICAgICAgKiBpbiBjYXNlIG9mIGN5Y2xpYyB0cmFuc2ZlcnMuDQo+ID4gICAgICAgICov
DQo+ID4gICAgICAgc3RhdHVzID0gdGRjX3JlYWQodGRjLCBURUdSQV9HUENETUFfQ0hBTl9TVEFU
VVMpOw0KPiA+ICAgICAgIGlmICghKHN0YXR1cyAmIFRFR1JBX0dQQ0RNQV9TVEFUVVNfSVNFX0VP
QykpDQo+ID4gICAgICAgICAgICAgICB3Y291bnQgPSB0ZGNfcmVhZCh0ZGMsIFRFR1JBX0dQQ0RN
QV9DSEFOX1hGRVJfQ09VTlQpOw0KPiANCj4gWW91IGNhbid0IHJlYWQgV0NPVU5UIGFmdGVyIHRo
ZSBTVEFUVVMgd2l0aG91dCByYWNpbmcgd2l0aCB0aGUgU1RBVFVTDQo+IHVwZGF0ZXMgbWFkZSBi
eSBoL3cuIFlvdSBzaG91bGQgcmVhZCB0aGUgV0NPVU5UIGZpcnN0IGFuZCBvbmx5IHRoZW4NCj4g
Y2hlY2sgdGhlIFNUQVRVUy4NCj4gDQo+IFlvdSBzaG91bGQgYWxzbyBjaGVjayB3aGV0aGVyIFQy
MCB0ZWdyYV9kbWFfc2dfYnl0ZXNfeGZlcnJlZCgpDQo+IHdvcmthcm91bmRzIGFwcGx5IHRvIG5l
d2VyIGgvdy4gSSBzZWUgdGhhdCB0aGUgaC93IGJhc2UgaGFzbid0IGNoYW5nZWQNCj4gbXVjaCBz
aW5jZSBUMjAuDQpUaGUgY2FsY3VsYXRpb24gaW4gVDIwIGRyaXZlciBpcyBub3QgYXBwbGljYWJs
ZSBoZXJlLiBUaGUgcmVnaXN0ZXIgc2hvd3MgdGhlDQphY3R1YWwgbnVtYmVyIG9mIHdvcmRzIHJl
bWFpbmluZyB0byBiZSB0cmFuc2ZlcnJlZCBhcyBmYXIgYXMgSSB1bmRlcnN0YW5kLg0KDQpUaGFu
a3MsDQpBa2hpbA0KDQo=
