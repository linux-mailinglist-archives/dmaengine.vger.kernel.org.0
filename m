Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979A96C0907
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 03:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjCTCzH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Mar 2023 22:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCTCzA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Mar 2023 22:55:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E1BB87;
        Sun, 19 Mar 2023 19:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWFNoQngE53fbQ1JiX+wuXMmhS+FFtkPegz8AUiJnSJmDaWFmMFIjA0w7VuyQYwIbFGzMz6nhG3eFgXCD4QDa2NFq0aim6N7VzeHVZP6wvucWRkaJUc2nc49QqI61OivgSwty2B5zxBuSAQk+hxnbaHmkK8jydESX7io1Rn2jBUdJgm2ZHUPSDS/Pxpa83mNOcrQVK2qobnFZzSryCTuJ8yQhZSNUQJ8cOuJ4eB8ubRvusY9O3+4rh1rC31x3Rjda5a4t9t6T9DZZ8enrGhtb0HgR8TAqe87mnx5XnghFznV92GO/hbWk6D/Hh6+wVjsS1kpZxjowdaQhhzD7G2cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BchrPsEPS7drsFaqce9TW5q6NvpxA08tZQk2JDxWVI=;
 b=WA6Iu2jAXpaItoH2ZJ5vkztl78I/LK3i7fEYpdxkO0X0tMmxDSmkWAt1djWYpxvpKZG5eQGULjthyTZXs2H7pjlHYOaUTmP/eBRdx8FoDOy4IWeCojf6d4CwLcUrgUprk7Wj2JMcz/TdTxFyUymhU1jwmdTWuqbcIfbplMB9VdHxseUX5RFj9PZ6FPoC9E8w2fpg+NR8Qpcj8559cTbZ63iY0r+1S3wYriN9VI2DEptdUL/UoXW4riYMwlWOEGOWTaouzOdYpi5yBJ1OLA7ki+JMfL94MlOV2Xg3WH0EeJAGtCk/j5Ut9awVOPrh8Tl3gi8QO/c+viIGP3zSak1b0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BchrPsEPS7drsFaqce9TW5q6NvpxA08tZQk2JDxWVI=;
 b=YDscqt/9OPWMFgC3i9yOO1WavS7yTRUYLiBMqble0DiOYQ310RZFrGNFxHCONCZGEH+Z/OEFbEJfSe/JJ2nkXKip/uGNfZ0FzLdytDUzbinDret4ts3r9jKz3lwa77wZQaXs4gmJ6E5HST9ZMwLNZDOK0cPDWWpXWaCyo8qJNpj0Jy+AKFc/rKAJZW3J2cXYfeznU24ctLgwlpFlMuCz4Xea5rgswD6S++CYq1q5OV2QLSQA57f3HC0+42vH9S5jD5tHfELvSrLnY9+vKfc8ZdcpKlTwoBjkAYBNlEleCj6GFLnMyXkolEzWcCVyA48OvI4Fh8/Pu/QozD3oTyIRDw==
Received: from KL1PR0601MB3781.apcprd06.prod.outlook.com
 (2603:1096:820:11::14) by TYZPR06MB3999.apcprd06.prod.outlook.com
 (2603:1096:400:2d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 02:54:47 +0000
Received: from KL1PR0601MB3781.apcprd06.prod.outlook.com
 ([fe80::2cd0:fdbf:62e0:8eaa]) by KL1PR0601MB3781.apcprd06.prod.outlook.com
 ([fe80::2cd0:fdbf:62e0:8eaa%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 02:54:47 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/5] dmaengine: aspeed: Add AST2600 UART DMA driver
Thread-Topic: [PATCH v2 3/5] dmaengine: aspeed: Add AST2600 UART DMA driver
Thread-Index: AQHZVhvh9pkwhrQAjEWUAQl13XEh967/35SAgAMbGpA=
Date:   Mon, 20 Mar 2023 02:54:46 +0000
Message-ID: <KL1PR0601MB37815BD56FC3EEA2553432B191809@KL1PR0601MB3781.apcprd06.prod.outlook.com>
References: <20230314021817.30446-1-chiawei_wang@aspeedtech.com>
 <20230318030113.2024-1-hdanton@sina.com>
In-Reply-To: <20230318030113.2024-1-hdanton@sina.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB3781:EE_|TYZPR06MB3999:EE_
x-ms-office365-filtering-correlation-id: 779d8141-f9e1-4440-7523-08db28ee7719
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J2nDCBTR5sTdvKiyI+ctjAgKIVjzsfOjmayMSRuQwXKOMHYdZnEqmQfhYEDifgPLMyX/++plu11w0TDnABCou/oTRxzOJ0/aBvSmTkBhVfQIrlW83cQE3JcKc0CaeYVOwMBj5fwGHlAX0+35xrGirQfyvcPuoGBPMCe8yPYlJndYABhD96KlePhS0hAEkCZ1yGbBsxOI76R4eQvm2eVUG+DpLWn8MaMgIcf7ho+zic+d0eqWVhoBuBMOrSn5/sApMWMqBuERSQ6g/ECGa2+4V39Y+KrJvLZ8PH9pclTQfNjKpjvef/0t0cFC5YhSCk/riYn6NBs09YioJNH92EQbbOfpziehWVpNwDKPUHjo51nDwTJnmaDufVvtNw6x6av0AQ+T/taKvY76/Rc4N5zBrwnyb41tdT/nhwFNZNyjeHVqhf1jRIvcVFo6i4dECig7FENY9Fao+FnDxlSuGGN6G103+tCTMCJPyDV9THHIHjatVKdahIlgQ/LPdp710Sxj5tky4lCu5Ye0Xmwg0K/hHhYGGUMvqpC6NccH+x2ErpmE2gw1snXms9ZKgMryJO7zjfMHvAZ+bqF2qc4Yugl1A+xlNMQ0h7Fs1BN/HBpbbDuUYJM8VN+iYIMwm7/m8qXw1L7cvTnVDYCGSU7GDRKXmurDhPpLcbVkixRXkasDh+Nn7zJgi43kwTRAq0dkSGPaoC/FeuPCKIAaUym0c59Uug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB3781.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(396003)(346002)(39830400003)(451199018)(7696005)(71200400001)(9686003)(4326008)(83380400001)(478600001)(316002)(66446008)(66556008)(66476007)(66946007)(76116006)(64756008)(6916009)(8676002)(26005)(186003)(54906003)(6506007)(8936002)(52536014)(41300700001)(5660300002)(122000001)(38100700002)(2906002)(55016003)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWJpM2NuNndKQWlCTVdWS0srRk1aeGdCQVd2aTR2Y0MyWW9SeTY4anUyUHVD?=
 =?utf-8?B?SHkwNDIzcXdLeDN4SXJYcmZ5WnVwQXdKYmFTeWdCUHAvQVhtN3ltQjc3WXBs?=
 =?utf-8?B?Q2JRbmsyY3FuTlAwNzVhMVRuM2s5RGRwQTk2MVB2YWpFclUyb01rMWlVeGhX?=
 =?utf-8?B?ZWpMSzlrUmRIVWtvQ3B4azI1V1JjVkxlZ1RlQ01XREpDZFFoZFUvVzdoRlpl?=
 =?utf-8?B?N2g2WHdhSVBQUzlQOGVFM0pNaE1QTzV6NWdXcXFwWVZ0VzhuOWxHYkFlS05M?=
 =?utf-8?B?R2lRYzdnUmdJTGtoMVVOcWVURFZJaklhL0hxb29yMDFIWVUvVGFjWmViS0Mw?=
 =?utf-8?B?c0s0QnNXR0FBZXUvUFpueXlQSFJ3TEx2emYyUUVuY25DdnRTeit3MEhObnJK?=
 =?utf-8?B?Q0pzdUpCMFB0ZURkdFpRcHJ1Q0xoMGFVRlRxdG9nZVJvYmZQanl2VjNpZWdH?=
 =?utf-8?B?NUpHdkc1WXB2eFFzWXhKeXpwRXAxTkNQLytleHg3YU9RbEZ5L3I1SHFqMmRL?=
 =?utf-8?B?ODFucFUwTVVSWXlYb21TbDVreDVGdHM5K1c5bVpxZmxMRzdQaGtNZ1FwU2Nl?=
 =?utf-8?B?NlM1cDV5V1NON1BzWkJGNTBaSTh5cHE0NFFSUEEwc2hhM01LMmNxc0w5VHZB?=
 =?utf-8?B?RHRNUEo2cCtFL3pBK3lyR1B4Y1BiUjZTa0p1ZnNRNU8xbXl3SzFmSkhGVDVX?=
 =?utf-8?B?N1RkKzRUM1hIallLazlkK09sakU1YlpVa25ENmxwSTJmWkxUVXlZUDQ1aWRk?=
 =?utf-8?B?NjY5ZmlpZlZNbHh5RmVhUFpBTnhCdW1MMjB3V1BMYTQwZmN6cEpVbVRrZHlq?=
 =?utf-8?B?dWVnOWtBcUx1czBqTnNIWGRHZnlrTkRPWm55SkhQWU9pUllsRzZ1eCtLNW1X?=
 =?utf-8?B?K09ab2pWdUxySDI1aDJ0VXF6SzZOWVMyTFR1TXlndjJmaEtMNXFYRFpyZkFo?=
 =?utf-8?B?WERyM3p4OCswZUxtZ3hSVzJCSVBwME5QNFJvUGJxTkYyQ0hYQzVHTHp2ZXpT?=
 =?utf-8?B?UjNEUk5qNUxOaFFWa1FnZVNzQUNDVGNyTDNxaXNXRkQrT3BCUG9ZV3lGdGw0?=
 =?utf-8?B?T09ING83WFltZlp6emt4SXcxbHhqbmpPR2JGRWJvaXlFWlk3S2ZuMDdxeVdW?=
 =?utf-8?B?TnpiYXN0dUV3K0JkbVRqQVc5RmtER09XbmVYUVl6bkFzWjUxazgwZW0vUkxU?=
 =?utf-8?B?bm45MEpBc2JZZmY0TEtvSDlUMkN0cWdXclVLeWRZU01VNEdUcmpzWG4wWmFr?=
 =?utf-8?B?TGU2OFQ4cm9EMGFwelEwb3dud3dMc2ZWTnpIUlFIUWV4M09Tc2V1MjN2RTF0?=
 =?utf-8?B?RzFQeHpCR1psOHhqbDdodW40WTlidnFHN1dSWkpYLzRMYm84QU9talM3YlJh?=
 =?utf-8?B?TVhtTlBoRjRDME5LM1gyZGluR1pwcHVVN3FwNFcyWlZTcmZFM1Bjb1JDMUVS?=
 =?utf-8?B?akJQZXdOdVhPcDZBbXQ2TU5CekNETXh0d2UrQys1a0NLSHhvNzBFUzlvTEJl?=
 =?utf-8?B?STZtdWVNQ3owVEYrVnJHUG94ek5TMytnT1I4dkVwak40QmZ2Wm9mL2hFZngx?=
 =?utf-8?B?aXBtSUIwbDlna0lrbTgvcW5hZkk4TFoxeHVqSm41RjNPekhOazJNRXlMeU42?=
 =?utf-8?B?VXlmZmszajlxQ2lNOWl6WHljdEppUjRkTklGSWREbVRXdDY5dUZnczRBOHFP?=
 =?utf-8?B?TDlURVRaYUg5TGxjMlpjTVhFdHBxdDR5dEVyRHNQWmlMMER6azBvMHZLWlU1?=
 =?utf-8?B?aVZaN0EzSlkwZ2xxSWk2cE90K0tzbVRkbER0SDJoOG5BbElxaWlwSXBDZEFR?=
 =?utf-8?B?M010TFhHekZySDBqRTVoM1QwRERmNTE2TENWUjhMb0tZbE9BdUYrUis2dXZs?=
 =?utf-8?B?Qkd2NlFaR1lFbmoraWRUbE1ta2ZGVmtNVlJLanRZcnErd25JdDlBVDA5dFU1?=
 =?utf-8?B?SjdVbTJYWHZoem5IZXM5YVpscXdOb25JQjRJeTAvRzJISm5scC9ZSHF2Mnhu?=
 =?utf-8?B?UEx6ZHpIQkV6MkFCMUJqMUZ6dFBka3VnZFlIS2VibUVhQVdLRFVIZGR4V0VO?=
 =?utf-8?B?MTZlMHluUWRWUjl3dlNZY2F5ZjQwZUdxU3ZLczY4c3VVSllnZ3YwT3JrUG9S?=
 =?utf-8?B?TjdTRHQrUThpdUduVUw4ckRUWTErZDc0ZlFOaTdEZS9BSjVBdnlPNGRha3Bn?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB3781.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779d8141-f9e1-4440-7523-08db28ee7719
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 02:54:46.8229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GahpzeGYjZvCYlv8+QWwefOw4CMziVSbOYGi5sMSh0FQWdVEwxeaQeVtNgnuBCdG23SXkcPCg7gYDbYszkf/gQJdShxCe2wtV+V5heZCnYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBIaWxsZiBEYW50b24gPGhkYW50b25Ac2luYS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5
LCBNYXJjaCAxOCwgMjAyMyAxMTowMSBBTQ0KPiANCj4gT24gMTQgTWFyIDIwMjMgMTA6MTg6MTUg
KzA4MDAgQ2hpYS1XZWkgV2FuZw0KPiA8Y2hpYXdlaV93YW5nQGFzcGVlZHRlY2guY29tPg0KPiA+
ICtzdGF0aWMgaXJxcmV0dXJuX3QgYXN0MjYwMF91ZG1hX2lzcihpbnQgaXJxLCB2b2lkICphcmcp
IHsNCj4gDQo+IFsuLi5dDQo+IA0KPiA+ICsJLyogaGFuZGxlIFJYIGludGVycnVwdCAqLw0KPiA+
ICsJc3RzID0gcmVhZGwodWRtYS0+cmVncyArIFVETUFfUlhfSU5UX1NUUyk7DQo+ID4gKwlmb3Jf
ZWFjaF9zZXRfYml0KGNoX2JpdCwgKHVuc2lnbmVkIGxvbmcgKikmc3RzLCB1ZG1hLT5uX3VjcyAv
IDIpIHsNCj4gPiArCQljaF9pZCA9IChjaF9iaXQgPDwgMSkgKyAxOw0KPiA+ICsJCXdwdHIgPSBy
ZWFkbCh1ZG1hLT5yZWdzICsgVURNQV9DSF9XUFRSKGNoX2lkKSk7DQo+ID4gKw0KPiA+ICsJCXVj
ID0gJnVkbWEtPnVjc1tjaF9pZF07DQo+ID4gKwkJdWQgPSAmdWMtPnVkOw0KPiA+ICsJCXR4ID0g
JnVkLT50eDsNCj4gPiArDQo+ID4gKwkJdWMtPnJlc2lkdWUgPSAodWQtPnNpemUgJiB+VURNQV9D
SF9DVFJMX0JVRlNaKSAtIHdwdHI7DQo+ID4gKw0KPiA+ICsJCS8qIGhhbmRsZSBub24tNEItYWxp
Z25lZCBjYXNlICovDQo+ID4gKwkJaWYgKHVkLT5hZGRyICYgMHgzKSB7DQo+ID4gKwkJCXAgPSBw
aHlzX3RvX3ZpcnQoZG1hX3RvX3BoeXModWMtPmNoYW4uZGV2aWNlLT5kZXYsDQo+IHVkLT5hZGRy
KSk7DQo+IA0KPiBUaGlzIGRvZXMgbm90IHdvcmsgaWYgdGhlIGRtYSBhZGRyZXNzIGhhcyBubyBj
b3JyZXNwb25kaW5nIHN0cnVjdCBwYWdlLg0KDQpXaWxsIGFkZCB0aGUgZXJyb3IgY2hlY2sgZm9y
IGRtYV90b19waHlzIHRvIHByZXZlbnQgZnVydGhlciB1bmV4cGVjdGVkIG1lbW9yeSBhY2Nlc3Nl
cy4NCg0KVGhhbmtzLA0KQ2hpYXdlaQ0KDQo+IA0KPiA+ICsJCQltZW1jcHkocCwgdWMtPmJ1Ziwg
d3B0cik7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlhc3QyNjAwX3VkbWFfdGVybWluYXRlKCZ1
Yy0+Y2hhbik7DQo+ID4gKw0KPiA+ICsJCWRtYV9jb29raWVfY29tcGxldGUodHgpOw0KPiA+ICsJ
CWRtYV9kZXNjcmlwdG9yX3VubWFwKHR4KTsNCj4gPiArCQlkbWFlbmdpbmVfZGVzY19nZXRfY2Fs
bGJhY2tfaW52b2tlKHR4LCBOVUxMKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gSVJR
X0hBTkRMRUQ7DQo+ID4gK30NCg==
