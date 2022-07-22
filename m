Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6357DBC0
	for <lists+dmaengine@lfdr.de>; Fri, 22 Jul 2022 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiGVIIK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Jul 2022 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiGVIII (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Jul 2022 04:08:08 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2112.outbound.protection.outlook.com [40.107.113.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A0B9C26D;
        Fri, 22 Jul 2022 01:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+pef5qTbeFVozQW1cjBcvwOhDY5Tw1KhklVBXr39iN7JI3CE8MU23NWdsUsdfpoJX6Lp6CShlQxQOuVjZ5gHSQ8oYr9aBlMB/m0cVuhuQJSiFzQ9KXOVvUTSo0PrdIlC4Y40eWRbHVKcMGbbXM4JTauMpu4SPWE9j2Zd0oZHI+IJaaHmYqyeBl7LFLUc6T4Mb+kU1GvJJMWwJS7ekvvrA9FDFBXwbQaMWJDu8vFomWpUiK/N+kVXqxhuiG2irPAD2LGcUdc96jZc8k0bitoMYD1aWnwmHvpx+2r8CJbhDp1fMYOiruwOW1GqGT73WfK6NlCtvvIfG2HDztX+AKVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUWf1ZmQe24+UtUfOvYbV7dx/yV2LvBAjzQZXbV5C1c=;
 b=jmb3Vib3zPNo7ylQ8xFUjuy/5H5zyAaNf6bTNzMzowpM7JyVUssVMR/gKoxU44i82qMJJBsZPpetBKNeK2XkrxkQhqYRgV72ZmuTgPAKmQ5ZWoGJmv2+1dQShDfrFPMOByk05kjKhGElKiaTBG0AAYp9Cov05+YWTvin0NLJs+sWFj8f/ch52W3vqjxm/RREF+62GufGuIZcYnM8+xPTbjUF9sb2FJg8cAuxicw6DR78iOkAmAR4hR4cC2qRlLHbYza11f0RnFkixtrmbxnmziMqICvUwupgTjwAfQInGdev5PqN2W8abDO9Vhn6CHimKNIO9gPsV4gP6sTqpYuzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUWf1ZmQe24+UtUfOvYbV7dx/yV2LvBAjzQZXbV5C1c=;
 b=J4EtR4EmWDFuCTHagH841q0PFxw2ZmypqUnqV23l7vBIHudaXMTFMOK+xdaysB5y6G0dj36j7xiN9l5UYAurCbCfA3wDbCy3+Xp9u5LZrdT3HANAqs1boveZnWCvRtD46yxQmnbY1QL36nJ7Q6q5uXvwtOUEl94CjuKLtyjdupk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB4726.jpnprd01.prod.outlook.com (2603:1096:604:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 08:08:03 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%6]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 08:08:03 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
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
Thread-Index: AQHYnRDFZdhO+aiL/0ep/IvgrGJIGq2I9LaAgAAGMeCAAAN/gIAACRHggAEB3VA=
Date:   Fri, 22 Jul 2022 08:08:03 +0000
Message-ID: <OS0PR01MB59222CE7D61E0F325DDA6AC186909@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220721144708.880293-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdVgXA2T0bcxuVUaDW2jeh7tmjEaXroqf8hkeSVmNc2ZcA@mail.gmail.com>
 <OS0PR01MB5922D9885E8C485DF4FB9D8286919@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdVXdm6e6HveWfYA65_gnLg7f3cUaOpramsFL_wCudMM+Q@mail.gmail.com>
 <OS0PR01MB592202175CF0FCE35B621BE986919@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592202175CF0FCE35B621BE986919@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb100f1f-505f-40ae-c938-08da6bb94d2b
x-ms-traffictypediagnostic: OSBPR01MB4726:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/zzZqQ1eyoIMnt+djiHugiLHtxwfMP9PzkIMXOQQ2DOIXy+KKNp9RXZ0aYOGv+Gx0Vb/PT3qvKe9wGLaorPCecUfXgDQSIPeD0zC0TwdHb5mKIp0RZ5kGim/LD2Oy7J9eMdn0y/Ujxo6nxpLQFiCLODmY/ucxV2eXbWW6t6wC2AiXQio+/0gMhfXyB8ODvSAJkY8idlt9BlXRdRmXt0SlZuiUCZNjaSer8jYkhcwWZRvYYvhub5wzoWMmC/Ozsh/Cb7zeL/igx77GHTED3B00xN+qz5vF9++FCxrgIiKGcPNznuzIr0qW0n2YqXeF5Mi9CJdngqDdV4mAcVpldLGx0Ft1PpJNqaVn1Zg2qH2ZsSnkvrZt+pdglCXYccXiVRvmRaqTZu2T4O7/TpquAUPv4A5BHYpipqvawtbLpOjoj5Bhl3eh71+0oN5OURavI9nhrGf1IfTH4jXEQuyJKj+EEEUIWYrrxloCCUP8s3UJuY2qZ+uam4Wtmfq88JfUHBCAofuzMr/xlQ//eLbmUWxiM/PN3jBemFYmF/mfdLw2Lg5Rz5sYRCK8yEQ0L6lcdt06nXNAGZqf4g1ikW4jrcumlOIbxbAR1aYvy+2luSRvXsbniDJlXQTWmjwno/xk5Ew9YF29e+PDxBXuiJkWS7/Iy7+x5QW9RVw4niMJcX0J+vyvtVKbuL2evE7uEURi1UuDZlc7kO1k5Eao/6hs8LFyCf84lsxrBXWyfbhNdT72jSdvkwH37K/PpID2WSQ0tPeJbDZ5QEEDo17j81igTQL68CVNJUc9IMKzCMXLPESCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(71200400001)(122000001)(86362001)(38100700002)(33656002)(26005)(7696005)(6506007)(186003)(478600001)(53546011)(41300700001)(316002)(110136005)(9686003)(54906003)(66446008)(64756008)(4326008)(8676002)(66946007)(55016003)(52536014)(5660300002)(66476007)(76116006)(66556008)(8936002)(2906002)(83380400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnpvVEdydnhJTzJaMlhPYUpkVXFTNUdET0QxQWFjODFSOWpqNHhMWmdhQkhp?=
 =?utf-8?B?TENNT1Rram1jWU5vSG5nUU9BZFpSNTJwV2Y3UDQ2ejh2OE9KNm51SEVTQkhj?=
 =?utf-8?B?UTU3N1VIeTNVcEpqeTcxTHlvQUpuTnhNemhDUDJ6MWRoOElGamdtY1k4WitF?=
 =?utf-8?B?M2tDRlp6VUhtTEU1MmJmWGtHU1JJL0J0dUo0REF5VlJkVlBzZDI4OHlXUi93?=
 =?utf-8?B?ZThhakIwdXk0ZGVxZWZKOER0SVQxVXNOSG5DQ3BybmlVTWV1eTVuVFhVS2tl?=
 =?utf-8?B?cUQ5VDVkYy9VNWFqNHozUm93NnMxUE5mdGlNOFBoVVNBVllEbTNZR01jQVFx?=
 =?utf-8?B?VFJISVowWXF4RC9GbEUxSmNNbktaWERmMDQ2dVBtamxtZUl4ZEtEamdhbElu?=
 =?utf-8?B?Rnh2Q0k2SjRaN1RhbnRRc1pHZTFEaUkyVmhsYlBMSlR4SDZyTEpvTm0zZkh3?=
 =?utf-8?B?eXV3MnpaZHRHNFA3R201d2R5NXlERWV5VmpvaVdxYlozWmhHZTJJQmVsZkJh?=
 =?utf-8?B?Y05Jc1ErZU8rTTdRWDZKQlplL0w4UzdRZmpIb3oxNlJ6SVc3WVhMT1ZISmNh?=
 =?utf-8?B?MEhMMjluSEJJTGNyM1VqSkpQcnhOVFdUWlVUcnZDVXhIUDRiZlFISTV5SFJ6?=
 =?utf-8?B?b2g5allhQXNnSmVlbGFpZnNrR0JPeitSV2pEOXJyUERoM2NQSkJHYlc2amR6?=
 =?utf-8?B?Yjg5ZExRSVZsa2V3NFIyOHlJV0VyejhEL2NRK2dWeXdUamNVajVxSU1DUVgz?=
 =?utf-8?B?K0RLbFBteWhBdkVQekYzYjR5QTJtbGJnUG8zejdGazRIcnM2eVNJdDdzN0hE?=
 =?utf-8?B?TVRYY01aeXEzTWFpZUdNRU56SFdyTUZ1VFNpMHpXOG5vQWhqV25yNDJSYXZi?=
 =?utf-8?B?dzVUVkM2WVBJcVpGelBjN0tseEZ6ZXNCdDJHZjRwUDhQem83WEdzdHkxZXVU?=
 =?utf-8?B?cHlvQTRLQzA4VS9sVG4zSmxYdGJibDg0Y0tOdEEwR3kvR2g4TEdVNEZMN0ZO?=
 =?utf-8?B?cTUrMEtBNG9XU2h5NVFwMzE2dFB6ZDJkSmJadG9zMjJOa1VnV1VVTTdzLytR?=
 =?utf-8?B?RERRY3E4ajZqc0pEdUVEVHp0a21qd1NoUEMzbkE3M3UrYW9LbVAydC9naXFS?=
 =?utf-8?B?U1R1VnJ4MGt3c0g0dTUxcVlIL2s3dWY0VFY3dVNOVWVVNllrYmFGOWVlVlhu?=
 =?utf-8?B?YWZLYVZSc3preTREY1B2cnRrbWdqcTlucDB5UU55R3Azd3lvMFR5dHBaZlU4?=
 =?utf-8?B?N3dlS3FIUVBGM2pLektmV3pOMktnbndKdyt0bFptYVlSRENJaWJNL3lVV3M2?=
 =?utf-8?B?UkluODFMWjhvQkxqV3FLVnRIUGVKeTB5UUdkQ20rRmtqQzRwaWVxbGdXY00v?=
 =?utf-8?B?aFBFWWFuUmxwYTFLL0JDNjRZQjNKYkViUkFwdlkxYjdVbjNBaFBEWWFSYW9i?=
 =?utf-8?B?VUdaOTZIRUpoM1hQdTMzTGtBWi9HQmhTV0JrUVIxNWdKMUVEaytSSWp2bkR6?=
 =?utf-8?B?Q0FaKzJOby9pNFFSd3c3d1QrZUFvUWduTnh6Kzl4TWtuWVJpQkxTL1NJSVc1?=
 =?utf-8?B?SHZPTXZjRjc3ZjMxdk1iTUlGNXNsQWd4U1l6UkkzQ3MxNDl3Vko4c3dFT2I5?=
 =?utf-8?B?dWdvM0JKdm41cWR3dnl3OVptUVFvckRPZ1lkekptNmhVRUwzQnlrbHE3QXpP?=
 =?utf-8?B?SVRZaldxTGcvZHpvL00vaFBqM2FXblByMkwyRVRGcjBxRVRxRVR6WW9OY0RI?=
 =?utf-8?B?SWZYS09aUmpQQ3VtNkNkdkxOd0ZlWUxoeUkyaUZhZEV2ektVRVRyZXJaZlJ5?=
 =?utf-8?B?cGlJNWFZVGx0Q3J0MlpLdEJhZ1RVOHBreTNJdm9iZlEwaXFCMGN0dTRnS2FZ?=
 =?utf-8?B?M3A3dktXNXlCZVhFc08xdHJpb21RU0g5T2tjc2xYL1RBbDZvTS9pSStnSXJK?=
 =?utf-8?B?YWZBa05UWVhPa3JLZkJUR21RTXIyd2ZEUlkyZzdxYlVNQVpsVnNyYVUwY0ZP?=
 =?utf-8?B?eG1QZU1QTzJOUkJ3WDB3MEJITC9lUjM1aGhVSU55ZUNmMmdPNkZUY2ppRjht?=
 =?utf-8?B?SVJnbzVycCtodjd4b2ZmUWg4blRlTjB4SDV1emdvMVgxR2h5TUdOU3hKOVhY?=
 =?utf-8?B?R1E4cFM4dEJrTHlqYVlPR1k3Z05xbmw5aGtRNjN3S3VwQVozOGJhRWRIcFIr?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb100f1f-505f-40ae-c938-08da6bb94d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 08:08:03.3871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGOc1mNB39rIXCYm58MPMfyOkBSem4TD0ZbhifRzf0ThM9ofhA/yEAGQWHI9+B7kRhx2STDUNikdBg1kUt2oU4CNEAj7u6yOT0K0tXlaN3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4726
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2M10gZG1hZW5naW5lOiBzaDogcnot
ZG1hYzogQWRkIGRldmljZV9zeW5jaHJvbml6ZQ0KPiBjYWxsYmFjaw0KPiANCj4gSGkgR2VlcnQs
DQo+IA0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGRtYWVuZ2luZTogc2g6IHJ6LWRtYWM6
IEFkZCBkZXZpY2Vfc3luY2hyb25pemUNCj4gPiBjYWxsYmFjaw0KPiA+DQo+ID4gSGkgQmlqdSwN
Cj4gPg0KPiA+IE9uIFRodSwgSnVsIDIxLCAyMDIyIGF0IDY6MDYgUE0gQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzXSBkbWFlbmdpbmU6IHNoOiByei1kbWFjOiBBZGQNCj4gPiA+ID4gZGV2aWNlX3N5
bmNocm9uaXplIGNhbGxiYWNrDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFRodSwgSnVsIDIxLCAyMDIy
IGF0IDQ6NDkgUE0gQmlqdSBEYXMNCj4gPiA+ID4gPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
Pg0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiBTb21lIG9uLWNoaXAgcGVyaXBoZXJhbCBtb2R1
bGVzKGZvciBlZzotIHJzcGkpIG9uIFJaL0cyTCBTb0MgdXNlDQo+ID4gPiA+ID4gdGhlIHNhbWUg
c2lnbmFsIGZvciBib3RoIGludGVycnVwdCBhbmQgRE1BIHRyYW5zZmVyIHJlcXVlc3RzLg0KPiA+
ID4gPiA+IFRoZSBzaWduYWwgd29ya3MgYXMgYSBETUEgdHJhbnNmZXIgcmVxdWVzdCBzaWduYWwg
Ynkgc2V0dGluZw0KPiA+ID4gPiA+IERNQVJTLCBhbmQgc3Vic2VxdWVudCBpbnRlcnJ1cHQgcmVx
dWVzdHMgdG8gdGhlIGludGVycnVwdA0KPiA+ID4gPiA+IGNvbnRyb2xsZXIgYXJlIG1hc2tlZC4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdlIGNhbiByZS1lbmFibGUgdGhlIGludGVycnVwdCBieSBj
bGVhcmluZyB0aGUgRE1BUlMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIHBhdGNoIGFkZHMg
ZGV2aWNlX3N5bmNocm9uaXplIGNhbGxiYWNrIGZvciBjbGVhcmluZyBETUFSUw0KPiA+ID4gPiA+
IGFuZCB0aGVyZWJ5IGFsbG93aW5nIERNQSBjb25zdW1lcnMgdG8gc3dpdGNoIHRvIGludGVycnVw
dCBtb2RlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IHYyLT52
MzoNCj4gPiA+ID4gPiAgKiBGaXhlZCBjb21taXQgZGVzY3JpcHRpb24NCj4gPiA+ID4gPiAgKiBB
ZGRlZCBjaGVjayBpZiB0aGUgRE1BIG9wZXJhdGlvbiBoYXMgYmVlbiBjb21wbGV0ZWQgb3INCj4g
PiB0ZXJtaW5hdGVkLA0KPiA+ID4gPiA+ICAgIGFuZCB3YWl0IChzbGVlcCkgaWYgbmVlZGVkLg0K
PiA+ID4gPg0KPiA+ID4gPiBUaGFua3MgZm9yIHRoZSB1b2RhdGUhDQo+ID4gPiA+DQo+ID4gPiA+
ID4gLS0tIGEvZHJpdmVycy9kbWEvc2gvcnotZG1hYy5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVy
cy9kbWEvc2gvcnotZG1hYy5jDQo+ID4gPiA+ID4gQEAgLTEyLDYgKzEyLDcgQEANCj4gPiA+ID4g
PiAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQo+ID4gPiA+ID4gICNpbmNsdWRlIDxs
aW51eC9kbWFlbmdpbmUuaD4NCj4gPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5o
Pg0KPiA+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+ID4gPiA+ID4gICNpbmNs
dWRlIDxsaW51eC9saXN0Lmg+DQo+ID4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
Cj4gPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gPiA+ID4gQEAgLTYzMCw2ICs2
MzEsMjEgQEAgc3RhdGljIHZvaWQgcnpfZG1hY192aXJ0X2Rlc2NfZnJlZShzdHJ1Y3QNCj4gPiA+
ID4gdmlydF9kbWFfZGVzYyAqdmQpDQo+ID4gPiA+ID4gICAgICAgICAgKi8NCj4gPiA+ID4gPiAg
fQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIHJ6X2RtYWNfZGV2aWNlX3N5bmNo
cm9uaXplKHN0cnVjdCBkbWFfY2hhbiAqY2hhbikgew0KPiA+ID4gPiA+ICsgICAgICAgc3RydWN0
IHJ6X2RtYWNfY2hhbiAqY2hhbm5lbCA9IHRvX3J6X2RtYWNfY2hhbihjaGFuKTsNCj4gPiA+ID4g
PiArICAgICAgIHN0cnVjdCByel9kbWFjICpkbWFjID0gdG9fcnpfZG1hYyhjaGFuLT5kZXZpY2Up
Ow0KPiA+ID4gPiA+ICsgICAgICAgdTMyIGNoc3RhdDsNCj4gPiA+ID4gPiArICAgICAgIGludCBy
ZXQ7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgcmV0ID0gcmVhZF9wb2xsX3RpbWVv
dXQocnpfZG1hY19jaF9yZWFkbCwgY2hzdGF0LA0KPiA+ID4gPiA+ICsgIShjaHN0YXQgJg0KPiA+
ID4gPiBDSFNUQVRfRU4pLA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMTAsIDEwMDAsIGZhbHNlLCBjaGFubmVsLA0KPiA+ID4gPiA+ICsgQ0hTVEFULCAxKTsNCj4g
PiA+ID4NCj4gPiA+ID4gSXNuJ3QgMTAwMCDCtXMgPSAxIG1zIGEgYml0IHNob3J0Pw0KPiA+ID4g
PiBJSVVJQywgSSBjYW4gc3VibWl0IGEgRE1BIG9wZXJhdGlvbiBmb3IgdHJhbnNmZXJpbmcgYSA2
NCBLaUIgKG9yDQo+ID4gPiA+IGxhcmdlcikgYmxvY2ssIGFuZCBjYWxsIGRtYWVuZ2luZV9zeW5j
aHJvbml6ZSgpIGltbWVkaWF0ZWx5IGFmdGVyDQo+ID4gdGhhdD8NCj4gPiA+DQo+ID4gPiBXaWxs
IGluY3JlYXNlIHRvIDEwMCBtc2VjPz8gaXMgaXQgb2s/DQo+ID4NCj4gPiBQcm9iYWJseS4gIEFz
IHRoaXMgaXMgYSBzbGVlcGluZyB3YWl0LCBpdCBkb2Vzbid0IGh1cnQgdG8gYmUNCj4gPiBjb25z
ZXJ2YXRpdmUuDQo+ID4gRG8geW91IGtub3cgd2hhdCdzIHRoZSBtYXhpbXVtIHRyYW5zZmVyIHNp
emUvbWF4aW11bSB0aW1lIGEgRE1BDQo+ID4gdHJhbnNmZXIgY291bGQgdGFrZT8NCj4gPg0KPiAN
Cj4gUlNQSSBpbnRlcmZhY2UgY29ubmVjdGVkIHRvIFBNT0QgRmxhc2gsIFRoZSByZC93ciB0ZXN0
IHNob3dpbmcgMTBLDQo+IHRyYW5zZmVyIHNpemUtPjIxIG1zZWMuDQoNCkFjdHVhbGx5LCBpdCBp
cyAxMSBtc2VjLiBFYXJsaWVyIHJlc3VsdCBjb25zaXN0cyBvZiBwcmludHMgZHVyaW5nIHN0YXJ0
Lg0KSSB3aWxsIHNlbmQgdjQgd2l0aCAxMDAgbXNlYy4NCg0KWyAgIDc0LjA4NTM0OF0gW3JzcGlf
ZG1hX2NvbXBsZXRlXSA1NDQgZW5kOiA3NDA4MCBtcyAgICAgZHVyYXRpb246IDMgbXMgMjU2DQpb
ICAgNzQuMDk3MzE4XSBbcnNwaV9kbWFfY29tcGxldGVdIDU0NCBlbmQ6IDc0MDkyIG1zICAgICBk
dXJhdGlvbjogMyBtcyAyNTYNClsgICA3NC4xMDU1NDddIFtyc3BpX2RtYV9jb21wbGV0ZV0gNTQ0
IGVuZDogNzQxMDAgbXMgICAgIGR1cmF0aW9uOiAwIG1zIDI1Ng0KWyAgIDc0LjExNDI2Nl0gW3Jz
cGlfZG1hX2NvbXBsZXRlXSA1NDQgZW5kOiA3NDEwOSBtcyAgICAgZHVyYXRpb246IDAgbXMgMjU2
DQpbICAgNzQuMTIyNTA2XSBbcnNwaV9kbWFfY29tcGxldGVdIDU0NCBlbmQ6IDc0MTE3IG1zICAg
ICBkdXJhdGlvbjogMCBtcyAyNTYNClsgICA3NC4xNDE1OTddIFtyc3BpX2RtYV9jb21wbGV0ZV0g
NTQ0IGVuZDogNzQxMzYgbXMgICAgIGR1cmF0aW9uOiAxMSBtcyAxMDI0MA0KWyAgIDc0LjE2MDYz
MF0gW3JzcGlfZG1hX2NvbXBsZXRlXSA1NDQgZW5kOiA3NDE1NSBtcyAgICAgZHVyYXRpb246IDEx
IG1zIDEwMjQwDQpbICAgNzQuMTc5NTc2XSBbcnNwaV9kbWFfY29tcGxldGVdIDU0NCBlbmQ6IDc0
MTc0IG1zICAgICBkdXJhdGlvbjogMTEgbXMgMTAyNDANClsgICA3NC4xOTg0NzddIFtyc3BpX2Rt
YV9jb21wbGV0ZV0gNTQ0IGVuZDogNzQxOTMgbXMgICAgIGR1cmF0aW9uOiAxMSBtcyAxMDI0MA0K
WyAgIDc0LjIxNzQ2MV0gW3JzcGlfZG1hX2NvbXBsZXRlXSA1NDQgZW5kOiA3NDIxMiBtcyAgICAg
ZHVyYXRpb246IDExIG1zIDEwMjQwDQpbICAgNzQuMjM2Mjg3XSBbcnNwaV9kbWFfY29tcGxldGVd
IDU0NCBlbmQ6IDc0MjMxIG1zICAgICBkdXJhdGlvbjogMTEgbXMgMTAyNDANClsgICA3NC4yNTUw
ODldIFtyc3BpX2RtYV9jb21wbGV0ZV0gNTQ0IGVuZDogNzQyNDkgbXMgICAgIGR1cmF0aW9uOiAx
MSBtcyAxMDI0MA0KWyAgIDc0LjI3Mzg5NV0gW3JzcGlfZG1hX2NvbXBsZXRlXSA1NDQgZW5kOiA3
NDI2OCBtcyAgICAgZHVyYXRpb246IDExIG1zIDEwMjQwDQpbICAgNzQuMjkyODA4XSBbcnNwaV9k
bWFfY29tcGxldGVdIDU0NCBlbmQ6IDc0Mjg3IG1zICAgICBkdXJhdGlvbjogMTEgbXMgMTAyNDAN
ClsgICA3NC4zMTE2MjBdIFtyc3BpX2RtYV9jb21wbGV0ZV0gNTQ0IGVuZDogNzQzMDYgbXMgICAg
IGR1cmF0aW9uOiAxMSBtcyAxMDI0MA0KWyAgIDc0LjMzMDQyN10gW3JzcGlfZG1hX2NvbXBsZXRl
XSA1NDQgZW5kOiA3NDMyNSBtcyAgICAgZHVyYXRpb246IDExIG1zIDEwMjQwDQpbICAgNzQuMzQ5
MzY0XSBbcnNwaV9kbWFfY29tcGxldGVdIDU0NCBlbmQ6IDc0MzQ0IG1zICAgICBkdXJhdGlvbjog
MTEgbXMgMTAyNDANClsgICA3NC4zNjgxNjddIFtyc3BpX2RtYV9jb21wbGV0ZV0gNTQ0IGVuZDog
NzQzNjMgbXMgICAgIGR1cmF0aW9uOiAxMSBtcyAxMDI0MA0KWyAgIDc0LjM4Njk3OV0gW3JzcGlf
ZG1hX2NvbXBsZXRlXSA1NDQgZW5kOiA3NDM4MSBtcyAgICAgZHVyYXRpb246IDExIG1zIDEwMjQw
DQpbICAgNzQuNDA1Nzg2XSBbcnNwaV9kbWFfY29tcGxldGVdIDU0NCBlbmQ6IDc0NDAwIG1zICAg
ICBkdXJhdGlvbjogMTEgbXMgMTAyNDANClsgICA3NC40MjQ3MDddIFtyc3BpX2RtYV9jb21wbGV0
ZV0gNTQ0IGVuZDogNzQ0MTkgbXMgICAgIGR1cmF0aW9uOiAxMSBtcyAxMDI0MA0KWyAgIDc0LjQ0
MzUxNV0gW3JzcGlfZG1hX2NvbXBsZXRlXSA1NDQgZW5kOiA3NDQzOCBtcyAgICAgZHVyYXRpb246
IDExIG1zIDEwMjQwDQpbICAgNzQuNDYyMzI1XSBbcnNwaV9kbWFfY29tcGxldGVdIDU0NCBlbmQ6
IDc0NDU3IG1zICAgICBkdXJhdGlvbjogMTEgbXMgMTAyNDANClsgICA3NC40ODEyMTRdIFtyc3Bp
X2RtYV9jb21wbGV0ZV0gNTQ0IGVuZDogNzQ0NzYgbXMgICAgIGR1cmF0aW9uOiAxMSBtcyAxMDI0
MA0KWyAgIDc0LjUwMDAxNl0gW3JzcGlfZG1hX2NvbXBsZXRlXSA1NDQgZW5kOiA3NDQ5NCBtcyAg
ICAgZHVyYXRpb246IDExIG1zIDEwMjQwDQpbICAgNzQuNTE4ODIxXSBbcnNwaV9kbWFfY29tcGxl
dGVdIDU0NCBlbmQ6IDc0NTEzIG1zICAgICBkdXJhdGlvbjogMTEgbXMgMTAyNDANClsgICA3NC41
Mzc2MjZdIFtyc3BpX2RtYV9jb21wbGV0ZV0gNTQ0IGVuZDogNzQ1MzIgbXMgICAgIGR1cmF0aW9u
OiAxMSBtcyAxMDI0MA0KWyAgIDc0LjU1NjU2OV0gW3JzcGlfZG1hX2NvbXBsZXRlXSA1NDQgZW5k
OiA3NDU1MSBtcyAgICAgZHVyYXRpb246IDExIG1zIDEwMjQwDQpbICAgNzQuNTc1Mzc4XSBbcnNw
aV9kbWFfY29tcGxldGVdIDU0NCBlbmQ6IDc0NTcwIG1zICAgICBkdXJhdGlvbjogMTEgbXMgMTAy
NDANClsgICA3NC41OTQxODZdIFtyc3BpX2RtYV9jb21wbGV0ZV0gNTQ0IGVuZDogNzQ1ODkgbXMg
ICAgIGR1cmF0aW9uOiAxMSBtcyAxMDI0MA0KWyAgIDc0LjYxMzAzNF0gW3JzcGlfZG1hX2NvbXBs
ZXRlXSA1NDQgZW5kOiA3NDYwNyBtcyAgICAgZHVyYXRpb246IDExIG1zIDEwMjQwDQpbICAgNzQu
NjMxODQ4XSBbcnNwaV9kbWFfY29tcGxldGVdIDU0NCBlbmQ6IDc0NjI2IG1zICAgICBkdXJhdGlv
bjogMTEgbXMgMTAyNDANClsgICA3NC42NTA2NTddIFtyc3BpX2RtYV9jb21wbGV0ZV0gNTQ0IGVu
ZDogNzQ2NDUgbXMgICAgIGR1cmF0aW9uOiAxMSBtcyAxMDI0MA0KWyAgIDc0LjY2OTQ4Ml0gW3Jz
cGlfZG1hX2NvbXBsZXRlXSA1NDQgZW5kOiA3NDY2NCBtcyAgICAgZHVyYXRpb246IDExIG1zIDEw
MjQwDQpbICAgNzQuNjg4MzY1XSBbcnNwaV9kbWFfY29tcGxldGVdIDU0NCBlbmQ6IDc0NjgzIG1z
ICAgICBkdXJhdGlvbjogMTEgbXMgMTAyNDANClsgICA3NC43MDcxNjldIFtyc3BpX2RtYV9jb21w
bGV0ZV0gNTQ0IGVuZDogNzQ3MDIgbXMgICAgIGR1cmF0aW9uOiAxMSBtcyAxMDI0MA0KWyAgIDc0
LjcyNTk3Ml0gW3JzcGlfZG1hX2NvbXBsZXRlXSA1NDQgZW5kOiA3NDcyMCBtcyAgICAgZHVyYXRp
b246IDExIG1zIDEwMjQwDQpbICAgNzQuOTUzMTE2XSBbcnNwaV9kbWFfY29tcGxldGVdIDU0NCBl
bmQ6IDc0OTQ3IG1zICAgICBkdXJhdGlvbjogMCBtcyAxMg0KWyAgIDc0Ljk4MjUzOV0gW3JzcGlf
ZG1hX2NvbXBsZXRlXSA1NDQgZW5kOiA3NDk3NyBtcyAgICAgZHVyYXRpb246IDAgbXMgMTINCg0K
Q2hlZXJzLA0KQmlqdQ0K
