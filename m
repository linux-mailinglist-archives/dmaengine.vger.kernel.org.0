Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A62D57D1D4
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 18:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiGUQos (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 12:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGUQor (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 12:44:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2115.outbound.protection.outlook.com [40.107.114.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B960488F3F;
        Thu, 21 Jul 2022 09:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcMAH4DZZo6iac2MVRVVBraPFXLsowS6MonI6CXxBtTi7LZdTv+TlYEmY9QccrZrno4S6IIXLM2gIdtsqJeHLTFTpEkcOu1ayNkayQYpNe0hX+XupV7Hs4iG5L0QSENdcs5ijNSqBFqyRkIJuhsDPvz4qi20vZpBYPsx+/RsBU3Pw7L1Hnqhjz1vND+8tGEote4jXBuyKAcsUHFhKwPOeSONTNSOEjJ0S9cjURbD8aAIAGg7LCMSEHhHKfuOmSV0nXkDgF9zcWX5Xmi0r8oihpDns/6gvwvuFkgA08WsziFT89aJoHgkmTe6/rH+rdVtXKISquEG4/XTGnsN7LBcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nh2fz0SwoAVroZS1CXGY7VpiyRExo9b9vO6WswmJMxA=;
 b=VB84LEhhIJsr+nmXlVCOuwcW6B2QxMRT+cScWZweF32T6H8n3MrsiQ2qMKl7DdcQrIKfS1Mc+W80z9cDWgmFrw9dogGO/euGFLwckaiQwh4CXsaV63qqFwCe0MQRsAqf0Oxq57AmrSipvKq6fK58r4EeiC6h0jN0FpruWMnnm7odioCTiiEi9ildjgaPZMCJKl5gTCTpCDy9Cb4apYhdUeqo35BoJSrsbFHnLMg+3VNrY9DRtTMHG4q3o7iEvgFtq4iJCWCZcB8DpP0Bue/ugQ/cggd8Adw4KkbsDEnqauyUBqyJLkqUe9rUo3gFGURnZdNlhTUTiGcL/HUQCXQ6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nh2fz0SwoAVroZS1CXGY7VpiyRExo9b9vO6WswmJMxA=;
 b=u7eaxNY+WBvR54ttx7ypSTLhaYN+273cQcoYX69G/KpNeOauzw5CkA6d+KNZAslwedu3Quw3OkxwmtUhHQVH1k4oFVb+RUHWiOt6QQY1ZFZrO4TUhTmwosLvvUSsMqc9e92JF8Fvu0bv41Z88NW6pkul0GDdSoy6IRPpiIUj208=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY2PR01MB2348.jpnprd01.prod.outlook.com (2603:1096:404:6d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 16:44:43 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 16:44:43 +0000
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
Thread-Index: AQHYnRDFZdhO+aiL/0ep/IvgrGJIGq2I9LaAgAAGMeCAAAN/gIAACRHg
Date:   Thu, 21 Jul 2022 16:44:43 +0000
Message-ID: <OS0PR01MB592202175CF0FCE35B621BE986919@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220721144708.880293-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdVgXA2T0bcxuVUaDW2jeh7tmjEaXroqf8hkeSVmNc2ZcA@mail.gmail.com>
 <OS0PR01MB5922D9885E8C485DF4FB9D8286919@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdVXdm6e6HveWfYA65_gnLg7f3cUaOpramsFL_wCudMM+Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVXdm6e6HveWfYA65_gnLg7f3cUaOpramsFL_wCudMM+Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0170946a-4cb3-46f0-1b3d-08da6b385011
x-ms-traffictypediagnostic: TY2PR01MB2348:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h9doD3MruunXsVB8KOAsafarxytaWC5NuByJVI1EwNVbrBZnwEU/z+TW3sUX8cYiwcxUjZkmsyEukurM0npi2qwKw5R8ebmUt7t0Xm5knDLnzLYshVFgIFvLdMcwmk+vi60n084g1zc+CGszYzJcojm+5by+fvVfTfleyc4Cj95RhuSfVHX2P9fCyaEFjB68hF45nrISBENqkpiDzS/8yxZVzt0+RAj2gAR8pDLXelYA2hNnDQMRyUND7s7YiLhDHYaW7LqLOUtIM1AmQiMEMYE2tSE0bWLLP18UfBdJftISE8rkCxRb3zHUAkwUx27d0FpsPvWAXDRb02d43lemj5FaX0y08qkxrWCfm1xpCq+jhrFE7MSKeIkeDKmz4W2md1w076Wy9VYUulh+BWXNerTaW39zMB1xUCioJmTzWE0537e7+nBR/Ii9WQsX599wz7b8rugW5Qg8qCVlcK86o5mhKPc3aF36yploDAecwLn6n9cJrZeCf0fGdiZeh2jANYeIvIHjyEKNncTffO+OLghsoY8LbV7DQXhugRgNL1j/q53W09+JthpkARwXeBV5UY0l/Gw0U4lT83c8afPb1ECFjBgr4Y5t9/Im+0hOeeS1/AczOCtVJ1Kihp0FdDMRxRvKUpQ+/ij5JUlEw8Csolukhka44GYfS4LvG44Q1QFE+07oBCGTpzqRV8npHC5L2JSsoPkxOdsCH1R2mLR8TUsYEre6ZLGjeUJM/RM7UHSs3fmwOo+VLUf7pzqyj2Q+L8610B5VqB297AewwvEMWkjNfgOBVDqJouB+6Vnh17b9FsPuRYgmgd0WTYOBNng7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(66446008)(52536014)(8936002)(478600001)(9686003)(5660300002)(122000001)(41300700001)(33656002)(53546011)(86362001)(7696005)(71200400001)(26005)(54906003)(316002)(6916009)(6506007)(76116006)(186003)(83380400001)(66946007)(64756008)(55016003)(66556008)(2906002)(4326008)(38100700002)(66476007)(38070700005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkRlVTAwb0ZxcGRCdDV0L3VDcWtTMk9aWllSRS9RamRtdjNGMXdwRnBvUTVW?=
 =?utf-8?B?SGtjRUdRbWR1VGE4K3lzZldwclU5WGsrMkI4Qjk5NEJHSkhNdUtRQjhWcWpI?=
 =?utf-8?B?ZG9ORFZKMytmZ2hFRmhlaytjRG5iOHplVy9Ub3NMNSszQUM1NEFrYm5aOWc5?=
 =?utf-8?B?VFpDNzRDQmZNdkxORllIU1hjU3NHaDJBbmRWOHZ2bzFWcnFtSndqa2ppb0F2?=
 =?utf-8?B?TFJIY3U1S1ZPMFduYkZuTEkwS3ZKRDh4WEJ3c2VvUEVnSkU2R2RzQWJUS29v?=
 =?utf-8?B?MmpMSkE5VkZ6eHdSNy8rVFBGU2ZTd010Zm1lckJnU1FWdTlyNnl3M3dZRGkx?=
 =?utf-8?B?UnhUcitqazRpaVFrVkVib0UzV2Y1YUNEcEJDclRlbmtnMi9iNFBRbUFseVV3?=
 =?utf-8?B?dDhLU2w4b1JrNFVEYjJzQVdSUko2NkpKYWZjZk5aSFhkOGxBdk1aZVhBS3RW?=
 =?utf-8?B?eXkrUjByZXQ4ZGNEWGdHZFgzYzF2b0R3S2djUFFNeGJpV3h0Vk5RdE9Bc1Z2?=
 =?utf-8?B?TTFMQ3JHMFpJOTBWbXZ4ZnBZakJwMWsxNWdFZzNDK2wxRzJqRk1DbTJwd241?=
 =?utf-8?B?ZWhzVzdCV3J4RXhzVmsydEhFU1pESTVvK3hPekVxOE1aeU1qbzcwNThqMkd2?=
 =?utf-8?B?YjNkRkZOZjhhSHk2aGZ2Qm5ueU1pZDBDRHNpUUNVZTdlYWRrS0NWWisrYTV5?=
 =?utf-8?B?aWRFUjhqdXd0bjdrSlNQTEV6SGZsZ2NLbHI4Nk11MVVCc2FSeGQ1aDZhajhJ?=
 =?utf-8?B?VVdLRU5ZWUNMYXl4VkprR1ZqSUY3V3Frdlhkemw4UHllVTlJMHBCdW45cEI0?=
 =?utf-8?B?RGxGcllJVXBxVEtNL0VtTzBLQXo0di9Xd3FvUytSdWI0dDk3UFpsNG4xcHNG?=
 =?utf-8?B?azc5cnpVcjlxLzZVQTFmaVFMVE1UOWtSUkZ5d0syR0hYQXBDVDlTV2pwY1Rv?=
 =?utf-8?B?YVR5SmNqdU1KRmVrWitLdW14VDlnL2ZpQ3R3NnI1QTVHWkxwOENpc05ZNXha?=
 =?utf-8?B?cUZSc3dFOEUwZnVxckdya0U2bWdpQ0F1d010TTZMeFFCM1JwQzg4T0g4ZGNu?=
 =?utf-8?B?dFF4Rng1RUlQRHljWDJCeHhvMG54c2NweG9LaWlPSG84WUp3MW0vUmlaYXFY?=
 =?utf-8?B?QVQvVlFqY2V6VEo3dXFCeTVnSGZpZXBEUk1teVkzZlZrc0J3OU5rd3FHYUJQ?=
 =?utf-8?B?ZGZFcVh4bUJmYit0Rm9jYmZPcDFEU0xEMGpuazEzdVVjT0JRZCtrSzJXUVIr?=
 =?utf-8?B?YVM4eG9jTjBsVnFWaUVtOEJyaEdNeWpKL0t5dGJNMlJHcVhUVHdmMGF2aW04?=
 =?utf-8?B?Y1ovaWFYZUJBMlNRd3JjRGdzTHRHVTFFQzgzaVhSaWpuZjJsZ2pleU5IWTRy?=
 =?utf-8?B?ZFZsMTMydWVkbVRYYTVSNTZscEhBSHN4Zys4eTVXNTFhQTVkSTZUZG00VUFX?=
 =?utf-8?B?KzRvUUQycHVraGRMSzl1ZjR1NjgzNVBQSDV5MEtDYm8ybDhBRDBaRVo1MXE3?=
 =?utf-8?B?OW1ZZUxiM1pYV3czOXhiZm1URmdPQkZWdGhLcnJHdko1Q1ljTHRpaUJ0Yytv?=
 =?utf-8?B?eitMczN6QWVoMlNQa1RzRC9HaXpnTVh2N2N6TjBkeUtuS0hiZGxrUHdjaHlY?=
 =?utf-8?B?Sk9tdnQwUlUvVjE1cUtRWUxvS0QzVTJseWQ3bUwrS3hZNmxPQjZUTmk2eFFx?=
 =?utf-8?B?TnB4OTZGUmtidUJIWTFZbURqdnAybU5ZMm9RYitVQ2NQQ0h2MWlWNFpFcFRJ?=
 =?utf-8?B?aHU2UEhrVjQwOWlpVFhBVWhmN2Q3WUdhZWloMmxpN3FjNklwU3hCWXQrdXhP?=
 =?utf-8?B?ZDRFc0RDM2dNT1UvQmoya1dOdXBBWnQvMFpRUjRYanE0VW40aUZ1N05kNkV3?=
 =?utf-8?B?WnVJdTZXUmdzTDJrVDJuWW9FWC9nNDJ6dlpRenpEMjZEeWNWdG96bUc3dmw2?=
 =?utf-8?B?Ui9OekJHdXVpbXJaRHYrV0pYd2NXa2FhMjFEeHcrM1NubVdkS3RESW9QMGI0?=
 =?utf-8?B?WkdGZXMxaTh3RXUyMEthVlB5TW1BdDU5K0xneTFKQjlHV1ZrOGkyMjI5WXFr?=
 =?utf-8?B?QnA3VHBvRXFqWlp6cDV5NmFHbGFPSGRwWjhMVHJwa1ZSNVcyMmxCN0MvdEhQ?=
 =?utf-8?B?a3FONlM5d3l2dHlpb2ZzRzFBTVZHbm5uc2Q3SFBXVlh1U2xralFKSXUxSTdq?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0170946a-4cb3-46f0-1b3d-08da6b385011
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 16:44:43.1516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdG2nyc2G7O8runrXIR7P9FMh4Z3Xz0A3pkGtRfQa1BRFEatG+bkoMn6+jpeDZ+NvrgAn5WgUnE4Tyig++8thM4scS9lrOqnDDIR8tISQJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2348
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
Cj4gDQo+IE9uIFRodSwgSnVsIDIxLCAyMDIyIGF0IDY6MDYgUE0gQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djNdIGRtYWVuZ2luZTogc2g6IHJ6LWRtYWM6IEFkZA0KPiA+ID4gZGV2aWNlX3N5bmNocm9uaXpl
IGNhbGxiYWNrDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBKdWwgMjEsIDIwMjIgYXQgNDo0OSBQTSBC
aWp1IERhcw0KPiA+ID4gPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gd3JvdGU6
DQo+ID4gPiA+IFNvbWUgb24tY2hpcCBwZXJpcGhlcmFsIG1vZHVsZXMoZm9yIGVnOi0gcnNwaSkg
b24gUlovRzJMIFNvQyB1c2UNCj4gPiA+ID4gdGhlIHNhbWUgc2lnbmFsIGZvciBib3RoIGludGVy
cnVwdCBhbmQgRE1BIHRyYW5zZmVyIHJlcXVlc3RzLg0KPiA+ID4gPiBUaGUgc2lnbmFsIHdvcmtz
IGFzIGEgRE1BIHRyYW5zZmVyIHJlcXVlc3Qgc2lnbmFsIGJ5IHNldHRpbmcNCj4gPiA+ID4gRE1B
UlMsIGFuZCBzdWJzZXF1ZW50IGludGVycnVwdCByZXF1ZXN0cyB0byB0aGUgaW50ZXJydXB0DQo+
ID4gPiA+IGNvbnRyb2xsZXIgYXJlIG1hc2tlZC4NCj4gPiA+ID4NCj4gPiA+ID4gV2UgY2FuIHJl
LWVuYWJsZSB0aGUgaW50ZXJydXB0IGJ5IGNsZWFyaW5nIHRoZSBETUFSUy4NCj4gPiA+ID4NCj4g
PiA+ID4gVGhpcyBwYXRjaCBhZGRzIGRldmljZV9zeW5jaHJvbml6ZSBjYWxsYmFjayBmb3IgY2xl
YXJpbmcgRE1BUlMgYW5kDQo+ID4gPiA+IHRoZXJlYnkgYWxsb3dpbmcgRE1BIGNvbnN1bWVycyB0
byBzd2l0Y2ggdG8gaW50ZXJydXB0IG1vZGUuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4gLS0tDQo+
ID4gPiA+IHYyLT52MzoNCj4gPiA+ID4gICogRml4ZWQgY29tbWl0IGRlc2NyaXB0aW9uDQo+ID4g
PiA+ICAqIEFkZGVkIGNoZWNrIGlmIHRoZSBETUEgb3BlcmF0aW9uIGhhcyBiZWVuIGNvbXBsZXRl
ZCBvcg0KPiB0ZXJtaW5hdGVkLA0KPiA+ID4gPiAgICBhbmQgd2FpdCAoc2xlZXApIGlmIG5lZWRl
ZC4NCj4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIHRoZSB1b2RhdGUhDQo+ID4gPg0KPiA+ID4gPiAt
LS0gYS9kcml2ZXJzL2RtYS9zaC9yei1kbWFjLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9kbWEv
c2gvcnotZG1hYy5jDQo+ID4gPiA+IEBAIC0xMiw2ICsxMiw3IEBADQo+ID4gPiA+ICAjaW5jbHVk
ZSA8bGludXgvZG1hLW1hcHBpbmcuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9kbWFlbmdp
bmUuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gPiA+ID4gKyNp
bmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9saXN0Lmg+
DQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gPiA+ICAjaW5jbHVkZSA8
bGludXgvb2YuaD4NCj4gPiA+ID4gQEAgLTYzMCw2ICs2MzEsMjEgQEAgc3RhdGljIHZvaWQgcnpf
ZG1hY192aXJ0X2Rlc2NfZnJlZShzdHJ1Y3QNCj4gPiA+IHZpcnRfZG1hX2Rlc2MgKnZkKQ0KPiA+
ID4gPiAgICAgICAgICAqLw0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiArc3RhdGljIHZv
aWQgcnpfZG1hY19kZXZpY2Vfc3luY2hyb25pemUoc3RydWN0IGRtYV9jaGFuICpjaGFuKSB7DQo+
ID4gPiA+ICsgICAgICAgc3RydWN0IHJ6X2RtYWNfY2hhbiAqY2hhbm5lbCA9IHRvX3J6X2RtYWNf
Y2hhbihjaGFuKTsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgcnpfZG1hYyAqZG1hYyA9IHRvX3J6
X2RtYWMoY2hhbi0+ZGV2aWNlKTsNCj4gPiA+ID4gKyAgICAgICB1MzIgY2hzdGF0Ow0KPiA+ID4g
PiArICAgICAgIGludCByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICByZXQgPSByZWFk
X3BvbGxfdGltZW91dChyel9kbWFjX2NoX3JlYWRsLCBjaHN0YXQsICEoY2hzdGF0DQo+ID4gPiA+
ICsgJg0KPiA+ID4gQ0hTVEFUX0VOKSwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAxMCwgMTAwMCwgZmFsc2UsIGNoYW5uZWwsIENIU1RBVCwNCj4gPiA+ID4gKyAxKTsN
Cj4gPiA+DQo+ID4gPiBJc24ndCAxMDAwIMK1cyA9IDEgbXMgYSBiaXQgc2hvcnQ/DQo+ID4gPiBJ
SVVJQywgSSBjYW4gc3VibWl0IGEgRE1BIG9wZXJhdGlvbiBmb3IgdHJhbnNmZXJpbmcgYSA2NCBL
aUIgKG9yDQo+ID4gPiBsYXJnZXIpIGJsb2NrLCBhbmQgY2FsbCBkbWFlbmdpbmVfc3luY2hyb25p
emUoKSBpbW1lZGlhdGVseSBhZnRlcg0KPiB0aGF0Pw0KPiA+DQo+ID4gV2lsbCBpbmNyZWFzZSB0
byAxMDAgbXNlYz8/IGlzIGl0IG9rPw0KPiANCj4gUHJvYmFibHkuICBBcyB0aGlzIGlzIGEgc2xl
ZXBpbmcgd2FpdCwgaXQgZG9lc24ndCBodXJ0IHRvIGJlDQo+IGNvbnNlcnZhdGl2ZS4NCj4gRG8g
eW91IGtub3cgd2hhdCdzIHRoZSBtYXhpbXVtIHRyYW5zZmVyIHNpemUvbWF4aW11bSB0aW1lIGEg
RE1BIHRyYW5zZmVyDQo+IGNvdWxkIHRha2U/DQo+IA0KDQpSU1BJIGludGVyZmFjZSBjb25uZWN0
ZWQgdG8gUE1PRCBGbGFzaCwgVGhlIHJkL3dyIHRlc3Qgc2hvd2luZyAxMEsgdHJhbnNmZXIgc2l6
ZS0+MjEgbXNlYy4NCg0KQ2hlZXJzLA0KQmlqdQ0K
