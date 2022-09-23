Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992A75E7816
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 12:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIWKSF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 06:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiIWKSD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 06:18:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042DE12DEC2;
        Fri, 23 Sep 2022 03:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q59OF9INey7yS6A/n7PbrUFMOjBCBTAn82eNDKdZwUohl/w0idm7jNJ0oos0gM5upmNWS+DSuN6GlWs/zpw+0dNspMAVrGvMnFuO/dDrsct1m250saC2dxkM7hpuJrm/ODakWFCG52amKSKyYTDryowXX3pHJ6i3kM5YFvX/L3D5Xuw+Q5ooJzW4dVcmsMpZ/1FkkRq8Ei0bJfRt2E5ODbgSfByOY6/NTNltPECVj0KBDOSHJH0MrZ5ij/MCn/hXqXYvW4LaazSu78LU80wlpO2YyJdMxgHCo+WXKhFtnexjfxoMXdFvF5Q86OFws25/RN0Qy6VKTgZ+0zqYjDA24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5eaDIaeNpD6hcSRnHO9MT47eTK2WobLFblXybkrXhA=;
 b=XqYlvlmT6VoJkMSucE5TWNJ9s9x9tLC4CUyyb7tfWaD34Fy9NVI3Hz3pSr4vySUTI6uUKZGLiBpJl3M93Ol0H2tCLVEVl2b2NsMixGSaLWwh4hvAcOTUDeXYofkOnuTTkVFnHlzetncHSOCvYgV1e84FMwbqjHAlnk9s7irKD6Wk28u2nhiz4Zadf5svgzveTDdpb2DWhfQVaDXU7HeI18llv+ALBDIuxGzBgW7ktlMhovPFvqpBBHDZTox5fEzVGLwKCVK0VmkCqNNhMjJVzLk9j3KQHNtTngcgSnatbXnMo7Ik16M00mTJK1XHpG7GOdB0T3o2m7bsqrVnLTJXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5eaDIaeNpD6hcSRnHO9MT47eTK2WobLFblXybkrXhA=;
 b=FqSYj7QsJdvYgs6l6JSfTvw9NnJ4qz6U1k96mkegM5y0c47nxe0HBHWrMrYazIZa8a1gMQuo9ocOZY4YmOt+ygghOlVJe7CXENPaoDLoHGRHSGcAo0j0s3WyOVNQq+FK0JkNzf/5BaMmaSDNI3pOsCb3MhfVHvg009XxYRr+4HNIc9PYlAAVQ9DSDzSiaiM6mOXqprkQq5BJI2LIk2Lq82a822GosceQemiREYQRI/8ksyv6CJrmq7Pn0rV32KN9hK9Ue9a4WQ5jlAspRtrTZEL1NN90JeraZNH0/Fg9lBSV3NUwYABxsjN7Jt4F1+mAsN7GeBEgZUDnNuioc0ZJ2w==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.20; Fri, 23 Sep 2022 10:17:56 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::2db9:5c61:102e:dfd4]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::2db9:5c61:102e:dfd4%6]) with mapi id 15.20.5632.019; Fri, 23 Sep 2022
 10:17:56 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] dmaengine: tegra: Add support for dma-channel-mask
Thread-Topic: [PATCH v2 3/3] dmaengine: tegra: Add support for
 dma-channel-mask
Thread-Index: AQHYzBq1VH2N02dZjk2+4dPkKtVnFK3s0MSAgAABj3A=
Date:   Fri, 23 Sep 2022 10:17:56 +0000
Message-ID: <SJ1PR12MB633958099C6DDAA4A428ECBEC0519@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
 <20220919112559.58195-4-akhilrajeev@nvidia.com>
 <8d15c575-a490-e1ed-7e97-5a5cdea0925f@nvidia.com>
In-Reply-To: <8d15c575-a490-e1ed-7e97-5a5cdea0925f@nvidia.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|DS7PR12MB6048:EE_
x-ms-office365-filtering-correlation-id: 38c2091b-7fbf-4674-2817-08da9d4ce21b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FgTem4rwEVdxloZZNu1t7feKPyc5Hn7jN8KuyVkfKt7Wk5RBGcgD2mnZTcOwHI9WWHfPIjUlkryBDtbqA8uXEbiMr8PF8AI/P9oYPRzbWo35o0I2cAhBke1Io9LqwYvSUZ+q9G7NajpG0W7IgnPctFQ/9JByffrc5hglbFXvSUI439/hAzLfFwe8OGFzEQixM+IrrPLdlMfjTj1CRcxskdnHxEGgUkf+GEcMW81v/G0sr1hg7pV/TBFoX69KfuP9+fL4tTQAzyTO/pY2m1PE4lmhTvrJNkNFrKQ6XG6FKLPYFxwAnObhCHr09b+53++lszC8iDdr8/CPO9WcrPKZNHNv3M90c655rhYQ42svDQHFg/auZRG7y6bBggHd/bIQYzoORHVlH8wFib71KgzpadDvB0KOuNStaI2LZb4Dx/3/IyxubBDSrovPP60FgMrqm4+vgMOYAIQmhaE5O1G6IqevU/ASiNM1C+quKx8V0H5VtDimdyugsjeDZANZ90LoobwxL70apehHjAsmQAPVWqIdGv1vwIIVCgxk0B3Xwh5eyP8fyME4W5zYeGKqZye+JFr9RDbMs9ES0ikXHAZKQav8YPn5qrg7d2rhbRZxtUo1gT5dz3u+xxcCkGguhQGqVe3Buh0KGkJ+OFaz8Azli0NZjqI/V4Edgs2UXxnGNpPNeMo3r6elY9SYJa7r/I7wjaMeTMWQvu3fY+q5EO0ULvmRHqunzrkskds9XNjt1ldnEPup6s0rOfpCvYepJaDXsZwaDCgPZFukG+qazg7QZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(53546011)(86362001)(26005)(9686003)(7696005)(83380400001)(110136005)(66476007)(186003)(6506007)(316002)(33656002)(2906002)(38100700002)(66446008)(5660300002)(41300700001)(122000001)(52536014)(8936002)(55016003)(64756008)(66556008)(66946007)(8676002)(38070700005)(76116006)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnRVcEs4NVp3dkdmaUhTMlFKMmhHc1dMQWpWcUhOd0xxWGl0ZUdsR2pCTTFE?=
 =?utf-8?B?UStQWGtjaFRSMHJwT1hodlZzOTFLcCs4NW10ZlhoSDhlYWoyc3dac0tOeGJt?=
 =?utf-8?B?bDRrQXg4WXdVdzR0dEZpRDZBVHlVUHZpS096UWdRM0xCdTYxcm9aYmxtTFR1?=
 =?utf-8?B?RldqVWhDRGJmMTZYTU1IQ0RNUGxET3lOZ0J1OWE0QkJyUXppdC9OTjZwa2l3?=
 =?utf-8?B?SlN2c1FodDU4dGNHV3N0T21yZWNvaXV0TjZtaS9QcUlwZ3J0U2tiVXNVTzlt?=
 =?utf-8?B?UUhvUzRScDZIV3VwK3VmYW1qSHJWdDRUcFZuaEhzR25ONTgzaWxEdzNITERy?=
 =?utf-8?B?NlNKNjg2c01KQUxzUjVuT0FRYm5NV1d0R0I0RlJLVktRRG9Ec2k4cER0d3FL?=
 =?utf-8?B?VHUycXFuMW16UFQrb2JScVY1ajZBT0c2bmltRGpkTTZYUHdFeXhNUXhRWGpL?=
 =?utf-8?B?elZBZ0U3WGQrRUVLSGorczhmQzJwdHU5T3RlWjUwN29laDd4azZEYmVNdXE4?=
 =?utf-8?B?Nm1VVXJLZzVWQklUbmR6cUJkOG9uTzBkYWRTTkdTWFhYNGdrNmJFR2l1dHJC?=
 =?utf-8?B?Y0NJRUZUT25qbVhaeHhNZW9SZ3ZvMlRwUXlBdTZ4T1Y4aUtTYXdwdXRwdmN0?=
 =?utf-8?B?OUN1MlN5K0hNUSt5YU1YZjNYR0pzeXJMMjRlK0UraWZpZWpreHJuQUQ1YW5y?=
 =?utf-8?B?NDk3bGFhZnJPY1hWenJjbndDVWVSalk5Z2hmWk5UOU1qb2hWV2VuM3VrTHB5?=
 =?utf-8?B?ckw0VDZycnh2OWF3a1Rld2xnOXpVNFBKRnFPZ0Rmd0lranJUVk9OUXhnZTZX?=
 =?utf-8?B?UlVRL2dDMHZFd1c2c3RPdnhaM1VQc1lBdWM4Rk1DWUphN1Z0S1J5RzhNOHVv?=
 =?utf-8?B?SDRaMFJML0FaR1VhQ1JwdHVqY2cycldpY2IvSUtCYVoxWmVMS1E4ajdXdXE2?=
 =?utf-8?B?QlE1QmtjMXRvbW5aOC90WW1pcWV5RWI4NmM5dVNpOU5oa2FNOXF0TEtrWkkv?=
 =?utf-8?B?T3FDMk50blZYK3BXOVdzTVdybTBqbDZ0bmRWdEVFdWxWVnFBeThlV2wzcHJv?=
 =?utf-8?B?cjB5WWkyMlNhZzJ0UXNWUDdKdUhsbTV3WERTWkdTSkYyeDhJUjVJLzNhSFpG?=
 =?utf-8?B?ejgxZWFPM01MN3hVbGFkSTNUNEpIdjlrOVMydVE2MytoVFllYUQwYkpwSnhM?=
 =?utf-8?B?SWNpK0tlVTNXZHd3SFU5OGFhVGZLNW1ycElNbHZvc2MwSUloQjhPN0pKdUxH?=
 =?utf-8?B?Zll4VURiWVpBN3BRbEpMY0UxT09BbG9hcm5IMWd4YXEwQXZ4SlFaMTZSd1pn?=
 =?utf-8?B?WStuQXJRcjc3UnVkdkozMWtuOHRla1FmR1VpbWJIMGZKbnBaR0ZYWGo2RmJq?=
 =?utf-8?B?VytEYmt2cVBiRklHZVgxcnlsdUpQeHJlaSszNVJ5bXoxWnJvWXNGRDRCK3ND?=
 =?utf-8?B?aHNyK1k0eW1DaXJvMkhGaTBwZDVMUk5VZnRvWXljaFF2NXZoN2FWMUxPSGd4?=
 =?utf-8?B?TDdmOEpRUjhYd3hQc0FST2NIOUU3R1ZkcTM0MlNNWlVXOVcwY2xWeW9pOE95?=
 =?utf-8?B?eUZYRjBpbFVEYXhZZWFKUTZTWXMwVHRCUGhlZXZSeStjQmxvbUM2em1tczg5?=
 =?utf-8?B?ZWF2VDlmcnVNSHVYVlpWNkIrSjZRMTFVNkoxRjMxOEJUK1dYMld0Nm9SdmJm?=
 =?utf-8?B?SHd6ZExSSzJ0ZXFSZzlnendnc1h6c01qcEphRXVMUGRaalFLSm1FVllRRFlB?=
 =?utf-8?B?RG9QZ3VTelFOcnFTN3ZRa0x1QlZ6RUZFS0lqam8vSFFPdysyY1F3Q0plVVZZ?=
 =?utf-8?B?aDZEUGxJajZMZ0oxWVpZZXJydnpLTUxtdXBGNFoyQncrYWQydWdCUE5PZ1Vh?=
 =?utf-8?B?aE9kUUlJZ2ozZ2Q4QVRwcWh5QktpNGhqcVNxYjJ3Y1BIVnJ4M3ZZaFdQdDdo?=
 =?utf-8?B?L1NUV2w5aGdpdExVZlR0cUV1cU1CRnBoTmJHSEI5YTlCcENGSHo4akx2RUVX?=
 =?utf-8?B?R1creVRhc0J3dnpudkNiZDRPcmpQc1VlaXFkNW0rY2JSOTNUcHZPQU1lMjM4?=
 =?utf-8?B?b01TbkFTeGI2cEhTVnB4QTFYdXdIRXY2L3RDWUhKeGYxQklPZ3BucmpHRnEr?=
 =?utf-8?Q?sN/FLeoSERwK5RArd9KHXA9dp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c2091b-7fbf-4674-2817-08da9d4ce21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 10:17:56.2528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqA9thlK52ZqvAPyv7RMH4huDSl0EvP4cms2eBJCzN9ocAD3Z22eHsA5nT7oaPXKbLfvgP0zSWQERMRnDWZV4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBPbiAxOS8wOS8yMDIyIDEyOjI1LCBBa2hpbCBSIHdyb3RlOg0KPiA+IEFkZCBzdXBwb3J0IGZv
ciBkbWEtY2hhbm5lbC1tYXNrIHNvIHRoYXQgb25seSB0aGUgc3BlY2lmaWVkIGNoYW5uZWxzDQo+
ID4gYXJlIHVzZWQuIFRoaXMgaGVscHMgdG8gcmVzZXJ2ZSBzb21lIGNoYW5uZWxzIGZvciB0aGUg
ZmlybXdhcmUuDQo+ID4NCj4gPiBUaGlzIHdhcyBpbml0aWFsbHkgYWNoaWV2ZWQgYnkgbGltaXRp
bmcgdGhlIGNoYW5uZWwgbnVtYmVyIHRvIDMxIGluDQo+ID4gdGhlIGRyaXZlciBhbmQgYWRqdXN0
aW5nIHRoZSByZWdpc3RlciBhZGRyZXNzIHRvIHNraXAgY2hhbm5lbDAgd2hpY2gNCj4gPiB3YXMg
cmVzZXJ2ZWQgZm9yIGEgZmlybXdhcmUuIE5vdywgd2l0aCB0aGlzIGNoYW5nZSwgdGhlIGRyaXZl
ciBjYW4NCj4gPiBhbGlnbiBtb3JlIHRvIHRoZSBhY3R1YWwgaGFyZHdhcmUgd2hpY2ggaGFzIDMy
IGNoYW5uZWxzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWtoaWwgUiA8YWtoaWxyYWplZXZA
bnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZG1hL3RlZ3JhMTg2LWdwYy1kbWEu
YyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZG1hL3RlZ3JhMTg2LWdwYy1kbWEuYyBiL2RyaXZlcnMvZG1hL3RlZ3Jh
MTg2LWdwYy0NCj4gZG1hLmMNCj4gPiBpbmRleCBmYTliZGE0YTJiYzYuLjFkMTE4MGRiNmQ0ZSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RtYS90ZWdyYTE4Ni1ncGMtZG1hLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2RtYS90ZWdyYTE4Ni1ncGMtZG1hLmMNCj4gPiBAQCAtMTYxLDcgKzE2MSwxMCBA
QA0KPiA+ICAgI2RlZmluZSBURUdSQV9HUENETUFfQlVSU1RfQ09NUExFVElPTl9USU1FT1VUCTUw
MDAgLyogNQ0KPiBtc2VjICovDQo+ID4NCj4gPiAgIC8qIENoYW5uZWwgYmFzZSBhZGRyZXNzIG9m
ZnNldCBmcm9tIEdQQ0RNQSBiYXNlIGFkZHJlc3MgKi8NCj4gPiAtI2RlZmluZSBURUdSQV9HUENE
TUFfQ0hBTk5FTF9CQVNFX0FERF9PRkZTRVQJMHgyMDAwMA0KPiA+ICsjZGVmaW5lIFRFR1JBX0dQ
Q0RNQV9DSEFOTkVMX0JBU0VfQUREUl9PRkZTRVQJMHgxMDAwMA0KPiANCj4gV2h5IGRpZCB0aGlz
IHZhbHVlIGNoYW5nZT8gVGhlcmUgaXMgbm8gbWVudGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2Uu
IElmDQo+IHRoaXMgd2FzIGluY29ycmVjdCBiZWZvcmUsIHRoZW4gdGhpcyBuZWVkcyB0byBiZSBh
IHNlcGFyYXRlIHBhdGNoIGFuZA0KPiB0YWdnZWQgd2l0aCB0aGUgYXBwcm9wcmlhdGUgZml4ZXMg
dGFnIHNvIHRoYXQgdGhpcyBjYW4gYmUgcGlja2VkIHVwIGZvcg0KPiBzdGFibGUuDQpUaGlzIGlz
IG1lbnRpb25lZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuIA0KDQoiLi4uIGFuZCBhZGp1c3Rpbmcg
dGhlIHJlZ2lzdGVyIGFkZHJlc3MgdG8gc2tpcCBjaGFubmVsMCAuLi4iDQoNClByb2JhYmx5IGl0
IGlzIG5vdCB2ZXJ5IGNsZWFyIHRoYXQgaXQgZGlyZWN0cyB0byB0aGlzIGNoYW5nZS4gU2hhbGwg
SSB1cGRhdGUgdGhlDQpjb21taXQgbWVzc2FnZSB0byBoYXZlIGEgY2xlYXJlciBjb250ZXh0Pw0K
DQpSZWdhcmRzLA0KQWtoaWwNCg==
