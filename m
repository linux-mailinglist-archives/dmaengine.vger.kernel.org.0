Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F74B57D0B4
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 18:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiGUQGk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 12:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiGUQGe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 12:06:34 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF484EF7;
        Thu, 21 Jul 2022 09:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJYRsBCrpuBZ2VOuQ+tu0L1oM0ly2n/Sr5YcYZbFn5gOpHpE0Kj7Vs0yh41ZhkIoYqe/p+bIxS99oW5a0bFiknv1v/VTUikK1yD4UMdzaewEKIV9SQWnrxcjKTNgs/8fOOswh1Rzi/tvpnNiByvyHE750WESy08C5nMw7WYtP3gE4frZv9AmBiu6yyozuSJIT1Al/25YHLrD6Zb8xOoGcmprHTNWRr5QleTZDP2FhQoUoG9UolQX0OtZcn+GMG6iFQYlljtUIIcrai8HTONZnOoXwUJDD/hRvxxP8dVCUEBbxkfPJj4SnaL5QQfYyWcBMHYQsx79Ugo5w7aAteMyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njn3CJNnaPE+b0YQd2Ent81vw/pkS5shsC+y9uHEqnc=;
 b=c3VZ8S4H57oJoem/W2A7tTeXM6GGsHh7gEWjRGEwbXSUmsG554uRg7TB1WHsf/Osu5gW/9n8fSncy6rKolqz6nU+UHwMS80O5HotTc82FoNcivRNPp6XLCYpBC8TrUrZuCBAajywj8L4XEemufk2kQac2GthaUK8oIHr9cWOeG39Y+vHYB0fINd7GSZlwV2r0WrYPiwRnVY8+LyNhJd2+SY4B90i6v0kx0P2J9bE7/Yf7XfaulxlTAM8nBvhwjh+f+3KQPaePuvmg99HFu9j0YS3ICoP5UKGZyc3V/M91jz0Mpu78VXQbNq74eh0fcg5C92PbQ7g2T1PP1Z0QrnSIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Njn3CJNnaPE+b0YQd2Ent81vw/pkS5shsC+y9uHEqnc=;
 b=P/VNkYEMhgu8j8Syxnh0z/bp/QK998lrUeVI17A9FdRAcL+g0Ozjxs7f2eGmrorzAfKUV6iUxSixQ3VgbKtsUuMxaYgcYXc/00L3lwDmq9L5r5uUPl0wB+0Y11nPAbLI6eW2p33wSHuSCgIzmKsDpY0emaNN5fYg56677Mxt7Ms=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10596.jpnprd01.prod.outlook.com (2603:1096:400:318::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 16:06:25 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 16:06:25 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3] dmaengine: sh: rz-dmac: Add device_synchronize
 callback
Thread-Topic: [PATCH v3] dmaengine: sh: rz-dmac: Add device_synchronize
 callback
Thread-Index: AQHYnRDFZdhO+aiL/0ep/IvgrGJIGq2I9LaAgAAGMeA=
Date:   Thu, 21 Jul 2022 16:06:25 +0000
Message-ID: <OS0PR01MB5922D9885E8C485DF4FB9D8286919@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220721144708.880293-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdVgXA2T0bcxuVUaDW2jeh7tmjEaXroqf8hkeSVmNc2ZcA@mail.gmail.com>
In-Reply-To: <CAMuHMdVgXA2T0bcxuVUaDW2jeh7tmjEaXroqf8hkeSVmNc2ZcA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58f67430-261f-48ca-3eac-08da6b32f6b5
x-ms-traffictypediagnostic: TY3PR01MB10596:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jCChVqfeIhQhgxYsBFEv8YPF/lJzBYgTFG1s3mXh5MfnHsBq0NPWUTuxIGkQOD3ItlEuVUYvZ3h03SP4aDu9AWAK4f8ETVEVNCST7BCwaaL73zyVtIfVFeH1V8v8xwbERObRhn//GAkVzugqJ94R9PiQLq+dycDnd8rijSh+uAt61dOeo33Pa+h/uQ1OYJJajdAx6AyIVwzR0py0YgapzEq9a1opatBm5yYlXHanRfdQ8jLcHUf3llHxZECq0btycEpLeGJJN3wktfLnEtdzFStAB/njsxZCMCwFX1G8hhbLoiBI61ROc1RQ+25ZrmW/w4TnmWcLbVejWwlFsawyLI8XcCp3XMTUE6LLUUXj7B/oQVuM3uLbVu+BSeRBA57fDqdctiulTXYXPXz/QlxkTys2xsvievZLHscp2+M81owZtJAW4WzgcAHuP4vCTYCaxX0YlAtJiKgjl+Z8i5MelZLKLrMUPpdjEV/b/qLjAQxdeplWxJ5mEzM387gdnqTdNBwYAPuE2sw0VZXkHqqYp5rQAy7EDDAbXR5l5GFOUmi+/luaH+JGJJFDWlC8jqS/uMMGctDe1FLqHpeO1rcybO9+p0uWQGWC9+xumLOls3lTFOSCJXmPR9N2vpKPmKCVcwSJm86AS3zpIyC3CkjjX0jL7IArSqK7dvavKqjMpMKDmAqBefQkuwjU3sF0lN2+U5PsjIYgFDHuWkAc7fKNTCVGjEP+TtzhP/5JyvtoDHqjxUUPqg7LUAPO6VHkgSLr8E8llA/ISBPdSX8G4lz9PwV90+SiRD99bsVO3ryVlMie3cBzGdbCafl7NsC1eB4Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(186003)(41300700001)(55016003)(26005)(71200400001)(122000001)(53546011)(9686003)(6506007)(83380400001)(7696005)(54906003)(6916009)(66446008)(316002)(66476007)(66556008)(76116006)(64756008)(66946007)(2906002)(4326008)(478600001)(86362001)(8676002)(33656002)(5660300002)(8936002)(52536014)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTBqbHVWNEFoMFp2cmtqb2xscytXT0ZXOGs4TmRUVXZ0RUZGUGtMSkhkRnl0?=
 =?utf-8?B?SEg5VlpGVFc5enhNc01vemdaMGNHUC9tU3MxR0dHUWZGUWVGaWk0L1hEeGZ2?=
 =?utf-8?B?T0VNL25Eb3BBRXJPTnNhK0FDRE5oR0FyekR6YkdYajVicWswZ3pKL2pmd1J3?=
 =?utf-8?B?SDIzaDRiNXFVUDFrSWJKc0hvS0Jnc0RmeXlweks1NHVoMEZBdjlHdFovUFRj?=
 =?utf-8?B?cUtiR2YwYTNiVDVVV0FSL2dBdFNqN0hoZk1sbnRkWWVxQnV5SEJtR0hJRkR5?=
 =?utf-8?B?aGtCbWp3SEdvVmt6Q0FqOWcvdUs5L3hnVllvK20zUzdSUTVBWGZQVk5RT09F?=
 =?utf-8?B?dzF3eFZ4OXpZeTZEODFMSkh0VjRZRzJ5clhwbUFMUCt1MlA1ay90M0x6Uitq?=
 =?utf-8?B?WjNOQXlnbnduRmNIcklSYzFYTXQwRHV0bUFtY1g5VkYyRVBXSGorc2w3M1dN?=
 =?utf-8?B?OEczVkRHMHY2UHlvNXdmUWlnWU02N1czZFNESDdFWFRDWGRaL01UQ3RnUGlG?=
 =?utf-8?B?SDZaRmo4ZnFCM3laQ0pKTWtIRWFIbHFuVGZXNGU3OUVpU3N6YTRyWmk3MnlS?=
 =?utf-8?B?cVJBVG4yV1U4cFlOWmxnRzFtZHpIQkFYTm1heHM2WXMxUUMzMjBXSEw5UnU5?=
 =?utf-8?B?RkRQUHAxeHcxbThvb3VQNkpNUnIzbGkvWlZOaVR5aTZhV1RFWmJYZG11T3lB?=
 =?utf-8?B?cFBCdnA3QUVEMWNuWitqRG5rcXhuclMxYTkyV2ZEMXVja0JYRnYwaWg4SGJj?=
 =?utf-8?B?RVFWaXZCVHVPNXdTdlRsdjMyc2FiZDBPckoyNmdPN3hIVXM1c29SMVFLTXBr?=
 =?utf-8?B?eXUyMVVYaXdjMlFmWXdxLzMrbzZ5QjJPN0ZLU2NzUncxamRNVkwzTm5nM2Jx?=
 =?utf-8?B?SDF5VC91UWY0UnNTVkhiSUd4eC9qWXRHQkZZeDM1T1lwMEIzYXdtK21vL25H?=
 =?utf-8?B?b1VjRTBpMG93TitnQlB4TGVqek9ZRFZJWVNMdUVxNDBJbzNEdzJGTjJnOXA0?=
 =?utf-8?B?clV3VTRVRVVnUGpqU2Zwd1dqMlUwUnZqNCtwT3RHenVKWmM5eWlJYWU1bGZu?=
 =?utf-8?B?RXpDaG5vcGdLaC9ET083UVRnZnJuenlhdFVFN0xLNjFJV2FjK2tPRFBLVkpy?=
 =?utf-8?B?bGVRUTlSMGQ3YXpsMXB6Ry9YQWtxZUx3NXkwNDNKVWI2QzJKeFg3OUZ2dkZx?=
 =?utf-8?B?L2ZVSHBpUjBTQmpoV0lrZzFKcUJ4ZTVGREZvNlB1RHl6VC8wOHJKSjkyTnI2?=
 =?utf-8?B?d2lzMEZvM2VqZmhkVHlTVHREOG1xSm05S09kalBKVnJpQUljV2MzL2g3VFhj?=
 =?utf-8?B?bkFUU25XaklLVm9KRTlPT0VTUkpOM21iTEVLK2pMMGhXOWRHNjZvSld5NXRp?=
 =?utf-8?B?alowa01zczg1RmUvcEZDdWFwbDlTMGJsZkpONUd4eldWUllHZEk4ZmJTdHRy?=
 =?utf-8?B?TzJuRTg0YlZnRUFBdGR6MVd1QlNuOEVENjU4bEFWVDlDVVlDbkJBRm5JNUwx?=
 =?utf-8?B?VEk2V3lKL21DRVhlTjZhZWN3TXRUREFqaXFZcTdFcFB2TnlBR1lrVXJ1ZHFZ?=
 =?utf-8?B?dnJVUE5SVTJRckNxWUl6UkdlMDlsOWVnTjMxVVpBWHUxZHBDR1QrSVdiNGZO?=
 =?utf-8?B?WStKeGo3OHA5VnBUZFhSVmRHSk91V041Mk9zNHhnaFB6cCsxZHU2dkY2cm1X?=
 =?utf-8?B?UERzdkZZaHpwL1QrWHhKWWJnVElxSUFvZDBRdmV1cVA3YmwwMm9ITGFaRi9D?=
 =?utf-8?B?OGVsZXlXZlBYK0NQVFBzdmM1bncreHZ1TUZYRmNwMHZocFZPMjUvSlQva1Bs?=
 =?utf-8?B?ZlNDS09Ca0JJQzdKRjhFZFI5UWlvTTNtZ05iN0dZSFhZZ0p2R1Q1SkhSTE83?=
 =?utf-8?B?SEV1ZE5HOENZYUFtVnBXWUw4REZnRktBZFRDcXFnOXp4amFLdmhRNHBWTUVE?=
 =?utf-8?B?T3pHaWFlY2Z4UHJzVFUrVDRHNUV6TEprakdpK0VKak45L2MwWDRJZitVUHR3?=
 =?utf-8?B?blo4SEdyazUweDN5cjc4V0NXenYzeGw1a0laSklyWkF0SGdkWDNaZGpxUzNq?=
 =?utf-8?B?bDczOC9RRk9GOFJ5Wmk0cEYrclk2OHRsdkRrOEdhL1psM3YzTHVhNFp0anNJ?=
 =?utf-8?B?c3dXei9UZnd6VGZHVXdjMStrT3lXR2N6a3AyTkI2Z1hSbnV5YkkrRk45TEJj?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f67430-261f-48ca-3eac-08da6b32f6b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 16:06:25.7800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OVvTcksRjOSUY/adH9AX9if7qtu1NJpSttwVMfHRLMW+y5VTPYxX19dd6xM62u0GMcYujlz8umIrm/xJQ+Y6hOjRKoFYzwZkxBGUUEY4i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10596
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gZG1hZW5naW5lOiBzaDogcnot
ZG1hYzogQWRkIGRldmljZV9zeW5jaHJvbml6ZQ0KPiBjYWxsYmFjaw0KPiANCj4gSGkgQmlqdSwN
Cj4gDQo+IE9uIFRodSwgSnVsIDIxLCAyMDIyIGF0IDQ6NDkgUE0gQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiBTb21lIG9uLWNoaXAgcGVyaXBoZXJh
bCBtb2R1bGVzKGZvciBlZzotIHJzcGkpIG9uIFJaL0cyTCBTb0MgdXNlIHRoZQ0KPiA+IHNhbWUg
c2lnbmFsIGZvciBib3RoIGludGVycnVwdCBhbmQgRE1BIHRyYW5zZmVyIHJlcXVlc3RzLg0KPiA+
IFRoZSBzaWduYWwgd29ya3MgYXMgYSBETUEgdHJhbnNmZXIgcmVxdWVzdCBzaWduYWwgYnkgc2V0
dGluZyBETUFSUywNCj4gPiBhbmQgc3Vic2VxdWVudCBpbnRlcnJ1cHQgcmVxdWVzdHMgdG8gdGhl
IGludGVycnVwdCBjb250cm9sbGVyIGFyZQ0KPiA+IG1hc2tlZC4NCj4gPg0KPiA+IFdlIGNhbiBy
ZS1lbmFibGUgdGhlIGludGVycnVwdCBieSBjbGVhcmluZyB0aGUgRE1BUlMuDQo+ID4NCj4gPiBU
aGlzIHBhdGNoIGFkZHMgZGV2aWNlX3N5bmNocm9uaXplIGNhbGxiYWNrIGZvciBjbGVhcmluZyBE
TUFSUyBhbmQNCj4gPiB0aGVyZWJ5IGFsbG93aW5nIERNQSBjb25zdW1lcnMgdG8gc3dpdGNoIHRv
IGludGVycnVwdCBtb2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHYyLT52MzoNCj4gPiAgKiBGaXhl
ZCBjb21taXQgZGVzY3JpcHRpb24NCj4gPiAgKiBBZGRlZCBjaGVjayBpZiB0aGUgRE1BIG9wZXJh
dGlvbiBoYXMgYmVlbiBjb21wbGV0ZWQgb3IgdGVybWluYXRlZCwNCj4gPiAgICBhbmQgd2FpdCAo
c2xlZXApIGlmIG5lZWRlZC4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHVvZGF0ZSENCj4gDQo+ID4g
LS0tIGEvZHJpdmVycy9kbWEvc2gvcnotZG1hYy5jDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvc2gv
cnotZG1hYy5jDQo+ID4gQEAgLTEyLDYgKzEyLDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Rt
YS1tYXBwaW5nLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9kbWFlbmdpbmUuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9saXN0Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gQEAgLTYzMCw2ICs2MzEsMjEg
QEAgc3RhdGljIHZvaWQgcnpfZG1hY192aXJ0X2Rlc2NfZnJlZShzdHJ1Y3QNCj4gdmlydF9kbWFf
ZGVzYyAqdmQpDQo+ID4gICAgICAgICAgKi8NCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lk
IHJ6X2RtYWNfZGV2aWNlX3N5bmNocm9uaXplKHN0cnVjdCBkbWFfY2hhbiAqY2hhbikgew0KPiA+
ICsgICAgICAgc3RydWN0IHJ6X2RtYWNfY2hhbiAqY2hhbm5lbCA9IHRvX3J6X2RtYWNfY2hhbihj
aGFuKTsNCj4gPiArICAgICAgIHN0cnVjdCByel9kbWFjICpkbWFjID0gdG9fcnpfZG1hYyhjaGFu
LT5kZXZpY2UpOw0KPiA+ICsgICAgICAgdTMyIGNoc3RhdDsNCj4gPiArICAgICAgIGludCByZXQ7
DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0ID0gcmVhZF9wb2xsX3RpbWVvdXQocnpfZG1hY19jaF9y
ZWFkbCwgY2hzdGF0LCAhKGNoc3RhdCAmDQo+IENIU1RBVF9FTiksDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAxMCwgMTAwMCwgZmFsc2UsIGNoYW5uZWwsIENIU1RBVCwgMSk7
DQo+IA0KPiBJc24ndCAxMDAwIMK1cyA9IDEgbXMgYSBiaXQgc2hvcnQ/DQo+IElJVUlDLCBJIGNh
biBzdWJtaXQgYSBETUEgb3BlcmF0aW9uIGZvciB0cmFuc2ZlcmluZyBhIDY0IEtpQiAob3IgbGFy
Z2VyKQ0KPiBibG9jaywgYW5kIGNhbGwgZG1hZW5naW5lX3N5bmNocm9uaXplKCkgaW1tZWRpYXRl
bHkgYWZ0ZXIgdGhhdD8NCg0KV2lsbCBpbmNyZWFzZSB0byAxMDAgbXNlYz8/IGlzIGl0IG9rPw0K
DQpDaGVlcnMsDQpiaWp1DQoNCj4gDQo+ID4gKyAgICAgICBpZiAocmV0IDwgMCkNCj4gPiArICAg
ICAgICAgICAgICAgZGV2X3dhcm4oZG1hYy0+ZGV2LCAiRE1BIFRpbWVvdXQiKTsNCj4gPiArDQo+
ID4gKyAgICAgICByel9kbWFjX3NldF9kbWFyc19yZWdpc3RlcihkbWFjLCBjaGFubmVsLT5pbmRl
eCwgMCk7IH0NCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0tLS0tLS0t
LQ0KPiA+ICAgKiBJUlEgaGFuZGxpbmcNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhv
ZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgt
DQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5p
Y2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4NCj4gQnV0IHdoZW4gSSdtIHRhbGtp
bmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nDQo+
IGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBU
b3J2YWxkcw0K
