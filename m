Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D8157C8B2
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 12:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiGUKOm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiGUKOl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 06:14:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2126.outbound.protection.outlook.com [40.107.114.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8B78211B;
        Thu, 21 Jul 2022 03:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwyzAux3+ekn+ISguBWvMqwo4xg2gnKGC+/jeMX5JlqGBDen/nkIa58QpWFa+ZfOhfjZJtrHI0i0mWfV8YnLWM//QkiU7c6TI3/D/NKqIidQVk8u2bqEQETyPyqMD6fJgVXeYJxUezQbPBXu7JoHD2N6RXoPa1lt4gFOy840P/EJATRnvOca6kUnyz01++TgckCphhmC8DTVSCz/p7lUd3siAKuhrjDklZVH0A3K+xJda882cfWzQMZjWZER5oMHn6ROHYTMMP6MbudGvYmCiGgJJKVAkbLYMSUdyPnkZywnucOI6ujFfEtB7aqu/ENX+b8lDPQMOzO6DMnwZYYPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/LZk5R7mpGktum/iN96TuhaLh1t5AexZGOM9JxuFQg=;
 b=NvXUFLanrYVoIRDLNsX87hVCw5GXhX6kQIca9jskFEPFcsHLpKum8XKJ11Rn7LSqtUe5qW+g3rzQytAiL16XWUqCZE7BcqqiKIBfhkuvn5m3bY8tjjY2qL1gyH5VKrqEon/7AxuLLZe6oKjz0fVh9jbIYNeVuBNZ8WOseLyUm7Cv2jwjVYsXgYSfD3fb9yOsUmBQOwsVlxq7JWWwZhCiQX4hzqi77rQV66aNqihYVz91m2t4CF3D36KPheqXFWbafII2gNeA0un4J0OKEEKe7ztLS/VHAFpb+232CE+l6ILcmSMXDqEsby3IqmWTC3ghhKbR92iqRKf92bvC/2YbJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/LZk5R7mpGktum/iN96TuhaLh1t5AexZGOM9JxuFQg=;
 b=upvaQdLNWXIB1L0dkZ8GG+NHVQXKtM4nGTEdOWyvN8SPVm8VCC2v8uw5ehhMUAmlKVwCd5WmP21egy3aqz+GpitMlDN0FNxRFBkpg2djvxlSUA5xXPQi193/vXGnQA3W2HjY2vW14eN+ejLNZbYrylCXxEZaUCSF4couh3lI+8o=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB2610.jpnprd01.prod.outlook.com (2603:1096:603:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Thu, 21 Jul
 2022 10:14:37 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.025; Thu, 21 Jul 2022
 10:14:37 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dmaengine: sh: rz-dmac: Add device_synchronize
 callback
Thread-Topic: [PATCH v2 1/2] dmaengine: sh: rz-dmac: Add device_synchronize
 callback
Thread-Index: AQHYm4A9SxOtiLZTzkSonUjFKh7hMK2IlrAAgAAHXrA=
Date:   Thu, 21 Jul 2022 10:14:37 +0000
Message-ID: <OS0PR01MB5922E6A3C526DF721E7D90A186919@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220719150000.383722-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdVoU4LHiZmxM_DsGz5kMFAbRzvwJwtkcgCKp3SBtYW6ww@mail.gmail.com>
In-Reply-To: <CAMuHMdVoU4LHiZmxM_DsGz5kMFAbRzvwJwtkcgCKp3SBtYW6ww@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a85fd37-1483-463e-cf61-08da6b01d131
x-ms-traffictypediagnostic: OSAPR01MB2610:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wr3HPssa8e1MKJStd2eSiuHv/VcXHhw+6QBZZmt9WQzQUGMpqEbVaZyIOfp3yIMWcnb8ZnVz1/ux5OsnVi7iADsVEvFwBz6filuOxB/LNnnv5dold90aQGjcoKl9JDk889A3fJ347myshDZsHJAQE+gW8VmTcc04mVTo+MxtMXZambk8wf8TYi/qun+oGuu2QpGi2Sg2Oihc/qEZs14QzEDLnIZNArbDAreIUdwIO13Izd3cUvKsBEqCQJKIJphFLAiH6QnKwgfi/PSHb5KuCdpRKN8eEMgBgKQ9UuEBj8FtIA3PVcC5PTXWxYX/9/HyPQHMah+D6SqxQ1o845zQKh6WZ20hTBB4nEerHAfU4F35AtScHjynRMxb+QHiGWdzGLA6aQc83x9CY8kX0tE2lXwXEzNLGRDWTs8HKEW2ZInM9Mijv3G0KphzO5YS+1K6esXfUTH6z1Qh6ZIgUMayq41WFuYGQa9MeFvcyrx3QuJSnIIiFSDofTYElG5TgJIMLIsgWFBu2uYlnczf0J13K4waSmZXKSIOHEGOzqgViYD0sQ51HBT6HmK0K/5AB0qowH90/m+RPpAL8DJeayjUSA+0g6EOHl5qkFF26vu2G1V+HbNMmWWSkfOEntu0331Y4yEYu/0t7VbvREV+X1kGOubAjCbBJt1/3BpcPsyE2cxMxj26mU1d5AfG0gL25P+PeEKo5BNyaqfoGYqPzsKj9Ncn4BbqOu25iDsLa6cIJKVNm1+h3yuxpRbTMp72bEdCWreUWx+JadusGqY77qh81+CBhUgzPLql3BOSWUkkL6w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(5660300002)(316002)(478600001)(6916009)(71200400001)(64756008)(76116006)(66946007)(54906003)(8936002)(8676002)(66556008)(66476007)(4326008)(52536014)(66446008)(33656002)(41300700001)(2906002)(26005)(53546011)(186003)(6506007)(83380400001)(38070700005)(55016003)(122000001)(9686003)(38100700002)(86362001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjltamIwc3JEOGVJRHFUVkxtN2pVc296clNXTzlFTHR4UE9nZ3FraU9LYTRT?=
 =?utf-8?B?Rm9NY2gvblYvT2MwVlBpY0RzWXBHajBhVEVETjVXaWlENEdnYW9qdVZQOGFi?=
 =?utf-8?B?ZVNDMnkzQlpFTG02WTNwUDBUZ1oyRlh5ekxLZ3U3Z1VWSDVURG1yTUZYeHFp?=
 =?utf-8?B?Qi95cDlvbXpHNEQrRXpjTm9lZWRscFlseEJnK3h3Q2UzNEkxdVVXQlUvWnI0?=
 =?utf-8?B?R3J1TVY0OHVmMEJwVEdXVTQvSWxqNEo5UTBMbTZFRnV3ZDFyWFk3RlYvcG5S?=
 =?utf-8?B?UEdBQ1pPSk9GM2hKVll6bGRNNHBsUDZLeXIxbzBrZ3l2T215cjBkTXJCQncr?=
 =?utf-8?B?OG9NYmhrZUhCbWN2TUlnTzE0L1hWN3I2OG1DZ3RzaGd6ZFJzeE15QktsbWRj?=
 =?utf-8?B?RmFLY3QrWmswak5lK1NaZ0hnbzNsVVRuRC8xZTUxNnE4a1FYNlBsQmNFUHQr?=
 =?utf-8?B?TUhpT0dVQ1ZRNmdoQUtRc2VpTEVyRXNyVHVoUXpJakdLcE42MFExeWlEeW43?=
 =?utf-8?B?a3A3K0dpbEM3bjN1bHpWaDlxTUNhTUVFTmhZM0hCb1V0V0tvL3FoRFhER0pt?=
 =?utf-8?B?blF2Y0I3VS80MzNDRnFPTTByc2hpRjAwMmhDZU5MRTczaWdTNFFFQjhLR3Vr?=
 =?utf-8?B?RUwwRzFaNHYvWDZCcHBHR1pjT2VaUkF4YmsrQkR5UENSbFRNaE9jeVIzZVlo?=
 =?utf-8?B?U1QxN1ptUVhEdUVGY1ZrQTQ5VE93N1BucEZiVEIzMjRkelhIb3lkamZhTGtI?=
 =?utf-8?B?enFqci9FK0dDL2dhZDlEem5SSGo4czB3Q0MwN3ZXWVVlV2dnZFp3cFNNQU9V?=
 =?utf-8?B?OUlMMXJMVXFhSmNWZzNzYzZPTEw5ZEk1R2UvQTFic2dpZlZtcTV2N3JSYTFZ?=
 =?utf-8?B?ZEF2WERjZEJzbkdoUUJCY20wSGlBZXJrVy83ckpjc0o1dlhFWEd0UGt5dzNW?=
 =?utf-8?B?cFFhei82VGp0VFlzR0ljRFZnQ3h4MzI0WjBtVzBYblRTeTc3Q3AwOEJGdGl0?=
 =?utf-8?B?OGNxanJ3QlBRdEJNRzlxZEhuQVZ3Mkd0bkJNUlErUFgyVFEvNzJuZ09Pd0pu?=
 =?utf-8?B?NXN4L1lhcnZhY1FUYVdDTk9CSlRBS0FYS2w4RUU4RjhqVlZJV1ZNZFlqRDFX?=
 =?utf-8?B?QTlnVjhQbjhOZFVDbVVnbzFJSlRpYUsxS1crSWhvUTFsbzNIYkkvUytXZ1pU?=
 =?utf-8?B?Skd1SWdmVXpJdmFrWlA2OG9HZGt4YmRPNDUzck9pZ1lWSHBsWFpRNlVFVlZy?=
 =?utf-8?B?Z1VoRXc3UXpPL0QzSFVRU0V6c3BEM2hzQWJLN2pIcU9YL0V2cXpCOFBEclFS?=
 =?utf-8?B?c1hGK2IxaEYvSlIrSko5N0NrdWtmR1FyS2tEbEJJVzBxZVlFcnVYcENSUUU4?=
 =?utf-8?B?OVR1WnF4R0pQd3Z6SlVlNWZmaXdQSU0xQjc2UG9qWHE2N2dSangrOEdLV3JT?=
 =?utf-8?B?M2RCdmFnVUorK0FYZFBSTHF2V0hnT0N3VE9tTk1uTjdtdStHYkloTWdzWXdY?=
 =?utf-8?B?UEU1RXRKMU5JTW9jZkF0ZStVMXAwN0xMVThZeGk0bEVFYkJzY3Q0NmZGZEcx?=
 =?utf-8?B?WkhWdWNmRStyb2ZSSnJPMVJtMTkyREovOVc1R2t4cGFUYzR2S3RSMTkzS0s3?=
 =?utf-8?B?WW1xbllZQW1ONlZlZkxVSU9mMW8yVTNVMUJmTWMyLzFLL2dTTjc3MUplcjAw?=
 =?utf-8?B?K2psOVVqYVRRNkovMklXc2Njai9XdG9SYzBzRXcvRnhQL1ZUREZFNWZ0WTgv?=
 =?utf-8?B?MVZ1Q1ZwVFhGeVVIby8xMFJaK3NaRE53TGJCeTJSZ3dVYkJnSWtsRjhyUEhz?=
 =?utf-8?B?ZVY3VTlhOEc3WlhaTFl0V2Y1QUJ0aHZ5SGdJY3VBRWFSVW85Mkc4RXloNHNp?=
 =?utf-8?B?TkVDdEdHS094WVF0c3ZLWTBMWjZOOFU2L0hscGNocDUvM0hTYzdnNTRCcW8z?=
 =?utf-8?B?SXR2SDFwNk5FSjNxNU9BcDNhZHNtTVR5OFkydmNsTk5VWDIxWjdod0Npdmcz?=
 =?utf-8?B?YVhhQi94T2hFdDhDTFhtNnV1RjhjZ3VmUFhrVDE0VkxMVVlGZjFoWVViYnBV?=
 =?utf-8?B?U1Q4UWxrMXFPV1ZlbVp1Q3YwVDV4VHFvQmMwZUFPUnJndTRhdzU3b2NwSlpy?=
 =?utf-8?B?UVJSUTBCdEEzQjNjZ2p0TlhZRW1iSzRub2NnYkYzZEFKVm5tQ3RBeHk5UU81?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a85fd37-1483-463e-cf61-08da6b01d131
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 10:14:37.5032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miKgzbDZtu6MxJerEFZChsrtpBTtO4HCcUmf1EYQJxQ1FsVovf/qIuWJxRfxJ24sFunhB6XVpBlHZdRl4WmJ9Uf1lj1MEwlF1wF9XXtJufg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2610
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrDQoNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiAxLzJdIGRtYWVuZ2luZTogc2g6IHJ6LWRtYWM6IEFkZA0KPiBkZXZpY2Vfc3luY2hy
b25pemUgY2FsbGJhY2sNCj4gDQo+IE9uIFR1ZSwgSnVsIDE5LCAyMDIyIGF0IDU6MDAgUE0gQmlq
dSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiBTb21lIG9u
LWNoaXAgcGVyaXBoZXJhbCBtb2R1bGVzKGZvciBlZzotIHJzcGkpIG9uIFJaL0cyTCBTb0MgdXNl
IHRoZQ0KPiA+IHNhbWUgc2lnbmFsIGZvciBib3RoIGludGVycnVwdCBhbmQgRE1BIHRyYW5zZmVy
IHJlcXVlc3RzLg0KPiA+IFRoZSBzaWduYWwgd29ya3MgYXMgYSBETUEgdHJhbnNmZXIgcmVxdWVz
dCBzaWduYWwgYnkgc2V0dGluZyBETUFSUywNCj4gPiBhbmQgc3Vic2VxdWVudCBpbnRlcnJ1cHQg
cmVxdWVzdHMgdG8gdGhlIGludGVycnVwdCBjb250cm9sbGVyIGFyZQ0KPiA+IG1hc2tlZC4NCj4g
Pg0KPiA+IFdlIGNhbiBlbmFibGUgdGhlIGludGVycnVwdCBieSBjbGVhcmluZyB0aGUgRE1BUlMu
DQo+IA0KPiByZS1lbmFibGU/DQoNCk9LLg0KDQo+IA0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRz
IGRldmljZV9zeW5jaHJvbml6ZSBjYWxsYmFjayBmb3IgY2xlYXJpbmcgRE1BUlMgYW5kDQo+ID4g
dGhlcmVieSBhbGxvd2luZyBETUEgY29uc3VtZXJzIHRvIHN3aXRjaCB0byBETUEgbW9kZS4NCj4g
DQo+IGludGVycnVwdCBtb2RlDQoNCk9LLiBXaWxsIGZpeCB0aGlzIGluIHYyLg0KDQpDaGVlcnMs
DQpCaWp1DQoNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gdjEtPnYyOg0KPiA+ICAqIE5vIGNoYW5n
ZQ0KPiANCj4gV2l0aCB0aGUgYWJvdmUgZml4ZWQ6DQo+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0
ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPiANCj4gR3J7b2V0amUsZWV0aW5n
fXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2Vl
cnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBn
ZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMg
d2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLg0KPiBCdXQgd2hl
biBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBz
b21ldGhpbmcNCj4gbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0tIExpbnVzIFRvcnZhbGRzDQo=
