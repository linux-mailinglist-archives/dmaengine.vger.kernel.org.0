Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDFB6C0E8C
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 11:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCTKTo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 06:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCTKTm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 06:19:42 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3533C1715;
        Mon, 20 Mar 2023 03:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ynzpb34DmqKWlfpVoiy5c2PFGITZwE/Oud4B9SHK4V7LK9NTEaoqMWU7O2vavpQwW4uOt4dRi9FGBm8MO9faLcYmHVr184b2t//3zOhcQ+ZRzmUoROwFBGvturYAll+9Il4dOXc5QiYLiTlqRxxqmn8mHSB9TBWvyHwOwd/jeAjck3/9/E35TVz2JcWpWANGenQG2269w9qtGmnzauAyaQvb2NcXqpRCEDx8TcWK2rJDt86A0zwERXYDt5Ih1/nsupLctJ9yL+DYkGqrlGu7m1BkTI55qMQm+2Ixzj7xUGBMc8B8/WmzzkOp2UDJ7BHRhlIY2uUuFJ2m6pObLcOYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeageUknSMFLh+cV/hLMSjAsAo4dbJvTeWq8699RZ8Y=;
 b=AVOBxJhisa9oqBvhLwdxDoYUs8lNu7YnNvMFkVdaayg5l57Foq5umyUTTjHfedfOYNi5HZB/+oJguVUa/+HUw8ixJIZyksS3FdNw4ClpR4jF7v/Bw8Dg5mQ/2ZP45akWlkMeAcGuHOzSzFE4ZbF5EOe3hnc4X5YdiJOxNL3H4yAsvhwqgrEiW1ziLAYimc+SfFBqFCQTRNe506HaYRwbt/V4ZF3+chsoGd3VkHy2mCxI33uD1tULgktDBtZtD27INPS9tSRWVWMUr5fv22umWJuKieKyJKhMK0oVUFwF01TpaadguC9EFFaiUvtJNCVlb61QsI1z9WOzC0AJk32ybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeageUknSMFLh+cV/hLMSjAsAo4dbJvTeWq8699RZ8Y=;
 b=w92KIPXQcHx9fDI/F8Q+PyszKsHYcsGD8Zp/gAnV/UP2ZbVp0v1eRgY1dN1TP1sLPNjon0O+JpjmLU4fVCCP1hkKnEpFAaAfyN9CMkogLzRjqMJhiex9S1Sa+6oBGA9DeeqgxefbmFSkZIHL1sMOqLleajStQACia/RTGnfQ2amWH3rLUC2hZ0j1aisttl/FeC57j+dlSJAvkZo88CWliCIO3U8pL9uCztzXvgWvrTkJVTxioVyr8xAct42oLtwXOUgDvVcxYpK6XocK+GhpMXjXx31XvhDle/b57eV5r/zM2QiobXgTz0ZzIL5hxfW1p/oYNLWNbYjVYWylKcJM3g==
Received: from KL1PR0601MB3781.apcprd06.prod.outlook.com
 (2603:1096:820:11::14) by SEZPR06MB5763.apcprd06.prod.outlook.com
 (2603:1096:101:ab::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 10:19:31 +0000
Received: from KL1PR0601MB3781.apcprd06.prod.outlook.com
 ([fe80::2cd0:fdbf:62e0:8eaa]) by KL1PR0601MB3781.apcprd06.prod.outlook.com
 ([fe80::2cd0:fdbf:62e0:8eaa%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 10:19:30 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "hdanton@sina.com" <hdanton@sina.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v3 4/5] serial: 8250: Add AST2600 UART driver
Thread-Topic: [PATCH v3 4/5] serial: 8250: Add AST2600 UART driver
Thread-Index: AQHZWwQiNdRDdEacbEam/8sjEiRS5q8DaqAAgAABrZA=
Date:   Mon, 20 Mar 2023 10:19:30 +0000
Message-ID: <KL1PR0601MB37819E400753132F11F0202D91809@KL1PR0601MB3781.apcprd06.prod.outlook.com>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
 <20230320081133.23655-5-chiawei_wang@aspeedtech.com>
 <10864478-99cb-e2cd-8e7b-95c6dca677e8@linux.intel.com>
In-Reply-To: <10864478-99cb-e2cd-8e7b-95c6dca677e8@linux.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB3781:EE_|SEZPR06MB5763:EE_
x-ms-office365-filtering-correlation-id: 40cf0d7c-ae03-4980-ef07-08db292c97a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sOMa6060ip9poasEHhZS6DoR9ZBCxhBBTJ8xa9X0oHym47s8+AZP6hRlmzonLzSX5NBRn06K+Oya/pcXTUBx5Ewclyy7mBSXLT0asxh2+igu79z7RkUXHh2gHtPAPobJIobkxNHKQzZWZLWUVn/iYigvSLUaAMc21UlyABmqVNSKnahlGo8jfHcCC3H2QPQlbI8iNCjsePjZP2pvrAZvvuXeY1XCLXichxbFsBJOqjMHAIZA5C4hjV7ydCNRy8alL/pPzfRuY2xVMOTWj+aQPbvUdybw2X3DQWS/rBVXVMLXQS+E+vhCLQ1hnPFnCXtRZmTXAytknwgoZzV8pvVtUPuO1A3CCMSaJtN7yP8aGlfq5yK6MNH9sn5aLYLiWmPB6is36UqncxIfJTmvUV1CNXU1tZkGBFyrQoTDShgNQvXTUfX7q4HwU7uG9v8Un5Exn1owWLLRT9GENfZ/vRmJO/nkzaNkBVnJMV6cZpUbwfzk7ZmYRvlubpCwBN/LBE4Ktq7l+RhIdzL1sLIRNHjF9wqr/NuW0qujiCf4i4jEfc+3lghJDEveCHD4c91FTbM+WbgziuyIwKN6NXfJ0ChmWBQlfFSGAPJEa3OKyi9h0F21E55EQ9TWZvRJeqMy6m7dLuonin0KEAY7bcVzttQpI+pKqei4qRWAxYdW8c1CQ0w/7eNieVyqeygLnKy6sIVHu/EqRYv+Up0+oKnn4ObLMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB3781.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39850400004)(136003)(366004)(346002)(396003)(376002)(451199018)(7696005)(71200400001)(122000001)(38100700002)(7416002)(478600001)(5660300002)(54906003)(66899018)(38070700005)(83380400001)(86362001)(316002)(66446008)(33656002)(66946007)(4326008)(8676002)(6916009)(66556008)(66476007)(64756008)(76116006)(9686003)(2906002)(55016003)(8936002)(52536014)(186003)(26005)(6506007)(66574015)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0kyMEhoQ1ByRGtwM3M3eGZiaUFKaTUrdVc3U3JNUVlRV3c1Nm5RQW1UK2dP?=
 =?utf-8?B?ZE5IajhnVWM3UENuUXU3WThhbE56aHcva1FUdS9sQzRIVStkTFVheitaSFVP?=
 =?utf-8?B?eFJSbnk0OVdpVWRyVHdkZEFEZ1F3QUZPckZORkhsQkY5a0hJcE1kemx6cVpa?=
 =?utf-8?B?Mlk4N3lIaFBBZk5YZjRza1Q5WUVlcXVSSTNOS3BFV0ZJTy9pREpZeU1nYW5s?=
 =?utf-8?B?MWVWNlJzNmFQbTdFaGV4MWdBakdUUHFJTEtBN2JqVnduUlZOY0l0aWpaNktD?=
 =?utf-8?B?OEdOVWpYRy9TczkyL2VMUGl0bzJFZWxDd1hrdXlFaWp1cGtiOERxVWpOWURQ?=
 =?utf-8?B?YnhhS01EUlp5Y2JOVVE1ZDRUanZkU1hhb1pSYXdZYjJ1NjR0M0h0WUdpdTJK?=
 =?utf-8?B?MktaYnZ6YjA2dkxta1FLeXFOcXROZkdweG81eldmZElReXBheWluOTFCUE12?=
 =?utf-8?B?NVFCN2dSeU5jdUEwb0tPZGhmcUxRZENCbit4c0tENGI2WmRpOWxxczVQZUg1?=
 =?utf-8?B?K1dPVHl3NmJwbWRVcmxZSU5XZ2JmdjBmQTZaaWxsS3hMUnp3eldRQ1oxczhu?=
 =?utf-8?B?RkRHRk0vWEVLeDdyTU1wZk9Cb0lJYytDMmh3VTBpcFRDUUVnSmJwcEJEZWM3?=
 =?utf-8?B?c1VTRjlDeGFTMUxzUklNZEhCdkxVbzhIN2FUbzQ4ZXJVZWJvNFRCVVhqQk8y?=
 =?utf-8?B?QWx5QWxpR3ptcktEMGlvNHdaQThsbG50RG03cndVS3UxeW5xTWhxSW5jYnVB?=
 =?utf-8?B?TjNORHNhSENBV1JodTlydnpLZEJKNzlTd1c1TE8wWWxSUEppRlpNcHB6Y3VE?=
 =?utf-8?B?U2FzYWhmL0hvc3VjaDd4TXd4THV1eFpJejVka2h2dEFaZ0Ywb2dEUTlENi9T?=
 =?utf-8?B?aWRFWSs3a2tqZmliMEpKUHFtUzhUMkl2WW1xNVU3ZnlyRDdOY2xKa2wvRFR0?=
 =?utf-8?B?ZjhRZUpQUUdmV0h6T2hOY3lLTmtpbnoxYnZDZDlrd0p0R0pnZkZMbXRobVJC?=
 =?utf-8?B?RkoyY1MxdVZRZEt4REg2MkVRT0tMZzBOSEZlNCtrQmFnV0gyWjRNSGtxNDB2?=
 =?utf-8?B?K2JVV3pORHhENTBydVpQREJ2b0Rnc3Y1Q0xuU1pQaG92RDdhWWN2RUlZa0Fi?=
 =?utf-8?B?UDNwZ3FVZWJrRlRXL3JteU9UcDBDaWxMYkRFcnRiWlB5YjFxZm5hOVR5REht?=
 =?utf-8?B?TlJLc3FWM3lsOVVSQ0YyREZQNEVEMmY5K2hSQ0Q5Y1lQYW1GbWJyWmgwb3dp?=
 =?utf-8?B?a2RFSEFBZmRZclVhZkdDdDRqOEJkNUlYeVdxQTBJZ2dqb2lPaElWZG9mVkZN?=
 =?utf-8?B?aVZ6MTVlZVFsYk8yVEdGcDh2UWRkd3lYeXQwY294WGpLNzQ4UTlIdU5qa1Fu?=
 =?utf-8?B?TmxOelN5ck10YzQzNjIwdEYrZWR4QjJUR2tUcjZtV0RZdE1qVUh2SzNVVEd2?=
 =?utf-8?B?MXl0d1J3elNVZHpCd1B3aVMzR2FCZUIxUjZyTjRZZGxTOExQMDltbC93bml1?=
 =?utf-8?B?TVBKQnREZnlVWWtJZlZJYTJpOE42ektQRTMxSzNKN0h5YnE1bkErQWV6dXJR?=
 =?utf-8?B?SmJQS2JwUHk3MTRBV1B1cFQwYUx3QThET1J5ZUpSekhUWmNLbGUyUzNjWU5Q?=
 =?utf-8?B?d2haVUZ5WUVDa250RkI0MmpjdDFjRVkvVXR4OXF0Skd2OG50ZVBWekwwQWFq?=
 =?utf-8?B?TWw3bGErQ1luOEsxa3dHb1hDOWZ6TEczRSt2a1FlSnljY0ExSmRnWHRkMngx?=
 =?utf-8?B?WFhBZ2tNL2lMQUNmVGYramdnZlNzMkg3N0EvbTJaRUswM3AzRktSQlFEaHBk?=
 =?utf-8?B?UUU1VG5VVVRlcFdOVy9iUzRuZ3N1Y0lPamMxSnZzVmd3SmZJQlF6bC9GVWlB?=
 =?utf-8?B?TldOcW5VT0tYWG1BV1BvcVkxV0ZuejU4b2E3VmVyNlJkWlJFbE05SWxlTXZm?=
 =?utf-8?B?YXM4bFQvdzJJVmhjaTh3LytnQlozR2FyMXI2ZmMycWVzTGZLRDNtdHZrcTRD?=
 =?utf-8?B?UkdpVjVXSHZjMkVjUGtZK2doSGlyODhqMSs0bzJKaEIwb2dJSFUwZEI2Nmhk?=
 =?utf-8?B?VWFDZTVEUnJYdnVFQVdUM3VkY1UrNE16V2hHdXVEVkJ5M0RPSEN6QTZWODli?=
 =?utf-8?B?QzZFNkRJbmhLWU03L0dlMzJMQlV5MDhQS2hoYm5ORmVONml1dTR6SjZxQ3F4?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB3781.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cf0d7c-ae03-4980-ef07-08db292c97a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 10:19:30.2540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AhvwNjhNLMmGx68wBmt9KefHJ6ly3s76IeXJa8COFtVgmdTz0hP1fncfA3OLFIxNkq3V7Eu0O3G2xun166pNs/kp+XgKj+rD8epJvoEvJwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiBGcm9tOiBJbHBvIErDpHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+
IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjAsIDIwMjMgNTo0MyBQTQ0KPiANCj4gT24gTW9uLCAyMCBN
YXIgMjAyMywgQ2hpYS1XZWkgV2FuZyB3cm90ZToNCj4gDQo+ID4gQWRkIG5ldyBVQVJUIGRyaXZl
ciB3aXRoIERNQSBzdXBwb3J0IGZvciBBc3BlZWQgQVNUMjYwMCBTb0NzLg0KPiA+IFRoZSBkcml2
ZXJzIG1haW5seSBwcmVwYXJlIHRoZSBkbWEgaW5zdGFuY2UgYmFzZWQgb24gdGhlIDgyNTBfZG1h
DQo+ID4gaW1wbGVtZW50YXRpb24gdG8gbGV2ZXJhZ2UgdGhlIEFTVDI2MDAgVUFSVCBETUEgKFVE
TUEpIGVuZ2luZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaWEtV2VpIFdhbmcgPGNoaWF3
ZWlfd2FuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy90dHkvc2VyaWFs
LzgyNTAvODI1MF9hc3BlZWQuYyB8IDIyNA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC9LY29uZmlnICAgICAgIHwgICA4ICsNCj4gPiAg
ZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvTWFrZWZpbGUgICAgICB8ICAgMSArDQo+ID4gIDMgZmls
ZXMgY2hhbmdlZCwgMjMzIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfYXNwZWVkLmMNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2FzcGVlZC5jDQo+ID4gYi9kcml2ZXJzL3R0
eS9zZXJpYWwvODI1MC84MjUwX2FzcGVlZC5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjA0ZDBiZjZmYmEyOA0KPiA+IC0tLSAvZGV2L251bGwNCj4g
PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2FzcGVlZC5jDQo+ID4gQEAgLTAs
MCArMSwyMjQgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4g
PiArLyoNCj4gPiArICogQ29weXJpZ2h0IChDKSBBU1BFRUQgVGVjaG5vbG9neSBJbmMuDQo+ID4g
KyAqLw0KPiA+ICsjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9pby5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxs
aW51eC9zZXJpYWxfODI1MC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc2VyaWFsX3JlZy5oPg0K
PiA+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2lycS5o
Pg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gPiArI2luY2x1ZGUgPGxp
bnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBp
bmcuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2NpcmNfYnVmLmg+DQo+ID4gKyNpbmNsdWRlIDxs
aW51eC90dHlfZmxpcC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiA+
ICsNCj4gPiArI2luY2x1ZGUgIjgyNTAuaCINCj4gPiArDQo+ID4gKyNkZWZpbmUgREVWSUNFX05B
TUUgImFzcGVlZC11YXJ0Ig0KPiA+ICsNCj4gPiArc3RydWN0IGFzdDgyNTBfZGF0YSB7DQo+ID4g
KwlpbnQgbGluZTsNCj4gPiArCWludCBpcnE7DQo+ID4gKwl1OCBfX2lvbWVtICpyZWdzOw0KPiA+
ICsJc3RydWN0IHJlc2V0X2NvbnRyb2wgKnJzdDsNCj4gPiArCXN0cnVjdCBjbGsgKmNsazsNCj4g
PiArI2lmZGVmIENPTkZJR19TRVJJQUxfODI1MF9ETUENCj4gPiArCXN0cnVjdCB1YXJ0XzgyNTBf
ZG1hIGRtYTsNCj4gPiArI2VuZGlmDQo+ID4gK307DQo+ID4gKw0KPiA+ICsjaWZkZWYgQ09ORklH
X1NFUklBTF84MjUwX0RNQQ0KPiA+ICtzdGF0aWMgaW50IGFzdDgyNTBfcnhfZG1hKHN0cnVjdCB1
YXJ0XzgyNTBfcG9ydCAqcCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBhc3Q4MjUwX3J4X2Rt
YV9jb21wbGV0ZSh2b2lkICpwYXJhbSkgew0KPiA+ICsJc3RydWN0IHVhcnRfODI1MF9wb3J0ICpw
ID0gcGFyYW07DQo+ID4gKwlzdHJ1Y3QgdWFydF84MjUwX2RtYSAqZG1hID0gcC0+ZG1hOw0KPiA+
ICsJc3RydWN0IHR0eV9wb3J0ICp0dHlfcG9ydCA9ICZwLT5wb3J0LnN0YXRlLT5wb3J0Ow0KPiA+
ICsJc3RydWN0IGRtYV90eF9zdGF0ZQlzdGF0ZTsNCj4gPiArCWludAljb3VudDsNCj4gPiArDQo+
ID4gKwlkbWFlbmdpbmVfdHhfc3RhdHVzKGRtYS0+cnhjaGFuLCBkbWEtPnJ4X2Nvb2tpZSwgJnN0
YXRlKTsNCj4gPiArDQo+ID4gKwljb3VudCA9IGRtYS0+cnhfc2l6ZSAtIHN0YXRlLnJlc2lkdWU7
DQo+ID4gKw0KPiA+ICsJdHR5X2luc2VydF9mbGlwX3N0cmluZyh0dHlfcG9ydCwgZG1hLT5yeF9i
dWYsIGNvdW50KTsNCj4gPiArCXAtPnBvcnQuaWNvdW50LnJ4ICs9IGNvdW50Ow0KPiA+ICsNCj4g
PiArCXR0eV9mbGlwX2J1ZmZlcl9wdXNoKHR0eV9wb3J0KTsNCj4gPiArDQo+ID4gKwlhc3Q4MjUw
X3J4X2RtYShwKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhc3Q4MjUwX3J4X2Rt
YShzdHJ1Y3QgdWFydF84MjUwX3BvcnQgKnApIHsNCj4gPiArCXN0cnVjdCB1YXJ0XzgyNTBfZG1h
ICpkbWEgPSBwLT5kbWE7DQo+ID4gKwlzdHJ1Y3QgZG1hX2FzeW5jX3R4X2Rlc2NyaXB0b3IgKnR4
Ow0KPiA+ICsNCj4gPiArCXR4ID0gZG1hZW5naW5lX3ByZXBfc2xhdmVfc2luZ2xlKGRtYS0+cnhj
aGFuLCBkbWEtPnJ4X2FkZHIsDQo+ID4gKwkJCQkJIGRtYS0+cnhfc2l6ZSwgRE1BX0RFVl9UT19N
RU0sDQo+ID4gKwkJCQkJIERNQV9QUkVQX0lOVEVSUlVQVCB8IERNQV9DVFJMX0FDSyk7DQo+ID4g
KwlpZiAoIXR4KQ0KPiA+ICsJCXJldHVybiAtRUJVU1k7DQo+IA0KPiBIb3cgZG9lcyB0aGUgRE1B
IFJ4ICJsb29wIiByZXN0YXJ0IHdoZW4gdGhpcyBpcyB0YWtlbj8NCg0KVGhlIGxvb3AgcmUtc3Rh
cnRzIGZyb20gYXN0ODI1MF9zdGFydHVwLg0KDQo+IA0KPiA+ICsJdHgtPmNhbGxiYWNrID0gYXN0
ODI1MF9yeF9kbWFfY29tcGxldGU7DQo+ID4gKwl0eC0+Y2FsbGJhY2tfcGFyYW0gPSBwOw0KPiA+
ICsNCj4gPiArCWRtYS0+cnhfY29va2llID0gZG1hZW5naW5lX3N1Ym1pdCh0eCk7DQo+ID4gKw0K
PiA+ICsJZG1hX2FzeW5jX2lzc3VlX3BlbmRpbmcoZG1hLT5yeGNoYW4pOw0KPiA+ICsNCj4gPiAr
CXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKyNlbmRpZg0KPiANCj4gVGhlc2UgMiBmdW5jdGlvbnMg
bG9vayB2ZXJ5IHNpbWlsYXIgdG8gd2hhdCA4MjUwX2RtYSBvZmZlcnMgZm9yIHlvdS4gVGhlIG9u
bHkNCj4gZGlmZmVyZW5jZSBJIGNvdWxkIHNlZSBpcyB0aGF0IGFsd2F5cyBzdGFydCBETUEgUngg
dGhpbmcgd2hpY2ggY291bGQgYmUNCj4gaGFuZGxlZCBieSBhZGRpbmcgc29tZSBjYXBhYmlsaXR5
IGZsYWcgaW50byB1YXJ0XzgyNTBfZG1hIGZvciB0aG9zZSBVQVJUcw0KPiB0aGF0IGNhbiBsYXVu
Y2ggRE1BIFJ4IHdoaWxlIFJ4IHF1ZXVlIGlzIGVtcHR5Lg0KPiANCj4gU28sIGp1c3QgdXNlIHRo
ZSBzdGFuZGFyZCA4MjUwX2RtYSBmdW5jdGlvbnMgYW5kIG1ha2UgdGhlIHNtYWxsIGNhcGFiaWxp
dGllcw0KPiBmbGFnIHR3ZWFrIHRoZXJlLg0KPiANCj4gQnkgdXNpbmcgdGhlIHN0b2NrIGZ1bmN0
aW9ucyB5b3UgYWxzbyBhdm9pZCA4MjUwX2RtYSBSeCBhbmQgeW91ciBETUEgUngNCj4gcmFjaW5n
IGxpa2UgdGhleSBjdXJyZW50bHkgd291bGQgKDgyNTBfcG9ydCBhc3NpZ25zIHRoZSBmdW5jdGlv
bnMgZnJvbQ0KPiA4MjUwX2RtYSB3aGVuIHlvdSBkb24ndCBzcGVjaWZ5IHRoZSByeCBoYW5kbGVy
IGFuZCB0aGUgZGVmYXVsdCA4MjUwIGlycQ0KPiBoYW5kbGVyIHdpbGwgY2FsbCBpbnRvIHRob3Nl
IHN0YW5kYXJkIDgyNTAgRE1BIGZ1bmN0aW9ucykuDQoNClllcyBmb3IgdGhlIGRpZmZlcmVuY2Ug
ZGVzY3JpYmVkLg0KDQpPdXIgY3VzdG9tZXJzIHVzdWFsbHkgdXNlIFVETUEgZm9yIGZpbGUtdHJh
bnNtaXNzaW9ucyBvdmVyIFVBUlQuDQpBbmQgSSBmb3VuZCB0aGUgcHJlY2VkaW5nIGJ5dGVzIHdp
bGwgZ2V0IGxvc3QgZWFzaWx5IGR1ZSB0byB0aGUgbGF0ZSBzdGFydCBvZiBETUEgZW5naW5lLg0K
DQpJbiBmYWN0LCBJIHdhcyBzZWVraW5nIHRoZSBkZWZhdWx0IGltcGxlbWVudGF0aW9uIHRvIGFs
d2F5cyBzdGFydCBSWCBETUEgaW5zdGVhZCBvZiBlbmFibGluZyBpdCB1cG9uIERSIGJpdCByaXNp
bmcuDQpCdXQgbm8gbHVjayBhbmQgdGh1cyBhZGQgYXN0ODI1MF9yeF9kbWEuIChUaGUgZGVmYXVs
dCA4MjUwIElTUiBhbHNvIGNhbGxlZCBpbnRvIHVwLT5kbWEtPnJ4X2RtYSkNCg0KSWYgYWRkaW5n
IGEgbmV3IGNhcGFiaWxpdHkgZmxhZyBpcyB0aGUgYmV0dGVyIHdheSB0byBnbywgSSB3aWxsIHRy
eSB0byBpbXBsZW1lbnQgaW4gdGhhdCB3YXkgZm9yIGZ1cnRoZXIgcmV2aWV3Lg0KDQo+IA0KPiAN
Cj4gSSdtIGN1cmlvdXMgYWJvdXQgdGhpcyBIVyBhbmQgaG93IGl0IGJlaGF2ZXMgdW5kZXIgdGhl
c2UgdHdvIHNjZW5hcmlvczoNCj4gLSBXaGVuIFJ4IGlzIGVtcHR5LCBkb2VzIFVBUlQvRE1BIGp1
c3Qgc2l0IHRoZXJlIHdhaXRpbmcgZm9yZXZlcj8NCg0KWWVzLg0KDQo+IC0gV2hlbiBhIHN0cmVh
bSBvZiBpbmNvbWluZyBSeCBjaGFyYWN0ZXJzIHN1ZGRlbmx5IGVuZHMsIGhvdyBkb2VzDQo+IFVB
UlQvRE1BDQo+ICAgcmVhY3Q/IC4uLk9uIDgyNTAgVUFSVHMgSSdtIGZhbWlsaWFyIHdpdGggdGhp
cyB0cmlnZ2VycyBVQVJUX0lJUl9USU1FT1VUDQo+ICAgd2hpY2ggeW91IGRvbid0IHNlZW0gdG8g
aGFuZGxlLg0KDQpVRE1BIGFsc28gaGFzIGEgdGltZW91dCBjb250cm9sLg0KSWYgdGhlIGRhdGEg
c3VkZGVubHkgZW5kcyBhbmQgdGltZW91dCBvY2N1cnMsIFVETUEgd2lsbCB0cmlnZ2VyIGFuIGlu
dGVycnVwdC4NClVETUEgSVNSIHRoZW4gY2hlY2sgaWYgdGhlcmUgaXMgZGF0YSBhdmFpbGFibGUg
dXNpbmcgRE1BIHJlYWQvd3JpdGUgcG9pbnRlcnMgYW5kIGludm9rZXMgY2FsbGJhY2sgaWYgYW55
Lg0KDQo+IA0KPiBXaGVuIHlvdSBwcm92aWRlIGFuc3dlciB0byB0aG9zZSB0d28gcXVlc3Rpb25z
LCBJIGNhbiB0cnkgdG8gaGVscCB5b3UgZnVydGhlcg0KPiBvbiBob3cgdG8gaW50ZWdyYXRlIGlu
dG8gdGhlIHN0YW5kYXJkIDgyNTAgRE1BIGNvZGUuDQoNClRoYW5rcyENCkl0IHdvdWxkIGJlIGdy
ZWF0IHVzaW5nIHRoZSBkZWZhdWx0IG9uZSB0byBhdm9pZCBtb3N0bHkgZHVwbGljYXRlZCBjb2Rl
Lg0KDQo+IA0KPiA+ICtzdGF0aWMgaW50IGFzdDgyNTBfaGFuZGxlX2lycShzdHJ1Y3QgdWFydF9w
b3J0ICpwb3J0KSB7DQo+ID4gKwlyZXR1cm4gc2VyaWFsODI1MF9oYW5kbGVfaXJxKHBvcnQsIHNl
cmlhbF9wb3J0X2luKHBvcnQsIFVBUlRfSUlSKSk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRp
YyBpbnQgYXN0ODI1MF9zdGFydHVwKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpIHsgI2lmZGVmDQo+
ID4gK0NPTkZJR19TRVJJQUxfODI1MF9ETUENCj4gDQo+IFRoaXMgaWZkZWYnZmVyeSBpcyBlbnRp
cmVseSB1bm5lY2Vzc2FyeS4NCg0KV2lsbCByZW1vdmUgYXMgc3VnZ2VzdGVkLg0KDQo+IA0KPiA+
ICsJaW50IHJjOw0KPiA+ICsJc3RydWN0IHVhcnRfODI1MF9wb3J0ICp1cCA9IHVwX3RvX3U4MjUw
cChwb3J0KTsNCj4gDQo+IFJldmVyc2UgeG1hcyB0cmVlIG9yZGVyLg0KDQpXaWxsIHJldmlzZSBh
cyBzdWdnZXN0ZWQuDQoNCj4gDQo+ID4gKw0KPiA+ICsJcmMgPSBzZXJpYWw4MjUwX2RvX3N0YXJ0
dXAocG9ydCk7DQo+ID4gKwlpZiAocmMpDQo+ID4gKwkJcmV0dXJuIHJjOw0KPiA+ICsNCj4gPiAr
CS8qDQo+ID4gKwkgKiBUaGUgZGVmYXVsdCBSWCBETUEgaXMgbGF1bmNoZWQgdXBvbiByaXNpbmcg
RFIgYml0Lg0KPiA+ICsJICoNCj4gPiArCSAqIEhvd2V2ZXIsIHRoaXMgY2FuIHJlc3VsdCBpbiBi
eXRlIGxvc3QgaWYgVUFSVCBGSUZPIGhhcw0KPiA+ICsJICogYmVlbiBvdmVycnVuZWQgYmVmb3Jl
IHRoZSBETUEgZW5naW5lIGdldHMgcHJlcGFyZWQgYW5kDQo+ID4gKwkgKiByZWFkIHRoZSBkYXRh
IG91dC4gVGhpcyBpcyBlc3BlY2lhbGx5IGNvbW1vbiB3aGVuIFVBUlQNCj4gPiArCSAqIERNQSBp
cyB1c2VkIGZvciBmaWxlIHRyYW5zZmVyLiBUaHVzIHdlIGluaXRpYXRlIFJYIERNQQ0KPiA+ICsJ
ICogYXMgZWFybHkgYXMgcG9zc2libGUuDQo+ID4gKwkgKi8NCj4gPiArCWlmICh1cC0+ZG1hKQ0K
PiA+ICsJCXJldHVybiBhc3Q4MjUwX3J4X2RtYSh1cCk7DQo+IA0KPiBPbmNlIHlvdSBzdGFydCB1
c2luZyB0aGUgZ2VuZXJhbCA4MjUwIGRtYSBjb2RlIGFuZCBhZGQgdGhlIERNQSBSeCBhbHdheXMN
Cj4gY2FwYWJpbGl0aWVzIGZsYWcsIHRoaXMgY2FuIGdvIGludG8gc2VyaWFsODI1MF9kb19zdGFy
dHVwKCkuIFNpbmNlDQo+IHNlcmlhbDgyNTBfcnhfZG1hKCkgYWx3YXlzIGV4aXN0cyBpbmRlcGVu
ZGVudCBvZiBDT05GSUdfU0VSSUFMXzgyNTBfRE1BLA0KPiBubyBpbmNsdWRlIGd1YXJkcyBhcmUg
bmVjZXNzYXJ5Lg0KPiANCj4gLi4uQWZ0ZXIgd2hpY2ggeW91IHByb2JhYmx5IGRvbid0IG5lZWQg
dGhpcyB3aG9sZSBmdW5jdGlvbiBhbnltb3JlLg0KDQpBZ3JlZS4NCg0KPiANCj4gPiArDQo+ID4g
KwlyZXR1cm4gMDsNCj4gPiArI2Vsc2UNCj4gPiArCXJldHVybiBzZXJpYWw4MjUwX2RvX3N0YXJ0
dXAocG9ydCk7DQo+ID4gKyNlbmRpZg0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBh
c3Q4MjUwX3NodXRkb3duKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpIHsNCj4gPiArCXJldHVybiBz
ZXJpYWw4MjUwX2RvX3NodXRkb3duKHBvcnQpOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFz
dDgyNTBfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsJaW50IHJj
Ow0KPiANCj4gUHV0IHRoaXMgYXMgbGFzdC4NCg0KV2lsbCByZXZpc2UgYXMgc3VnZ2VzdGVkLg0K
DQo+IA0KPiA+ICsJc3RydWN0IHVhcnRfODI1MF9wb3J0IHVhcnQgPSB7fTsNCj4gPiArCXN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQgPSAmdWFydC5wb3J0Ow0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2
ID0gJnBkZXYtPmRldjsNCj4gPiArCXN0cnVjdCBhc3Q4MjUwX2RhdGEgKmRhdGE7DQo+ID4gKwlz
dHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gPiArDQo+ID4gKwlkYXRhID0gZGV2bV9remFsbG9jKGRl
diwgc2l6ZW9mKCpkYXRhKSwgR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIWRhdGEpDQo+ID4gKwkJ
cmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJZGF0YS0+aXJxID0gcGxhdGZvcm1fZ2V0X2ly
cShwZGV2LCAwKTsNCj4gPiArCWlmIChkYXRhLT5pcnEgPCAwKQ0KPiA+ICsJCXJldHVybiBkYXRh
LT5pcnE7DQo+ID4gKw0KPiA+ICsJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElP
UkVTT1VSQ0VfTUVNLCAwKTsNCj4gPiArCWlmIChyZXMgPT0gTlVMTCkgew0KPiA+ICsJCWRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIGdldCByZWdpc3RlciBiYXNlXG4iKTsNCj4gPiArCQlyZXR1cm4g
LUVOT0RFVjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlkYXRhLT5yZWdzID0gZGV2bV9pb3JlbWFw
KGRldiwgcmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpKTsNCj4gPiArCWlmIChJU19FUlIo
ZGF0YS0+cmVncykpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBtYXAgcmVnaXN0
ZXJzXG4iKTsNCj4gPiArCQlyZXR1cm4gUFRSX0VSUihkYXRhLT5yZWdzKTsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwlkYXRhLT5jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCBOVUxMKTsNCj4gPiArCWlm
IChJU19FUlIoZGF0YS0+Y2xrKSkgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdl
dCBjbG9ja3NcbiIpOw0KPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+ICsJfQ0KPiA+ICsNCj4g
PiArCXJjID0gY2xrX3ByZXBhcmVfZW5hYmxlKGRhdGEtPmNsayk7DQo+ID4gKwlpZiAocmMpIHsN
Cj4gPiArCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBlbmFibGUgY2xvY2tcbiIpOw0KPiA+ICsJ
CXJldHVybiByYzsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlkYXRhLT5yc3QgPSBkZXZtX3Jlc2V0
X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZShkZXYsIE5VTEwpOw0KPiA+ICsJaWYgKCFJ
U19FUlIoZGF0YS0+cnN0KSkNCj4gPiArCQlyZXNldF9jb250cm9sX2RlYXNzZXJ0KGRhdGEtPnJz
dCk7DQo+ID4gKw0KPiA+ICsJc3Bpbl9sb2NrX2luaXQoJnBvcnQtPmxvY2spOw0KPiA+ICsJcG9y
dC0+ZGV2ID0gZGV2Ow0KPiA+ICsJcG9ydC0+dHlwZSA9IFBPUlRfMTY1NTBBOw0KPiA+ICsJcG9y
dC0+aXJxID0gZGF0YS0+aXJxOw0KPiA+ICsJcG9ydC0+bGluZSA9IG9mX2FsaWFzX2dldF9pZChk
ZXYtPm9mX25vZGUsICJzZXJpYWwiKTsNCj4gPiArCXBvcnQtPmhhbmRsZV9pcnEgPSBhc3Q4MjUw
X2hhbmRsZV9pcnE7DQo+ID4gKwlwb3J0LT5tYXBiYXNlID0gcmVzLT5zdGFydDsNCj4gPiArCXBv
cnQtPm1hcHNpemUgPSByZXNvdXJjZV9zaXplKHJlcyk7DQo+ID4gKwlwb3J0LT5tZW1iYXNlID0g
ZGF0YS0+cmVnczsNCj4gPiArCXBvcnQtPnVhcnRjbGsgPSBjbGtfZ2V0X3JhdGUoZGF0YS0+Y2xr
KTsNCj4gPiArCXBvcnQtPnJlZ3NoaWZ0ID0gMjsNCj4gPiArCXBvcnQtPmlvdHlwZSA9IFVQSU9f
TUVNMzI7DQo+ID4gKwlwb3J0LT5mbGFncyA9IFVQRl9GSVhFRF9UWVBFIHwgVVBGX0ZJWEVEX1BP
UlQgfCBVUEZfU0hBUkVfSVJROw0KPiA+ICsJcG9ydC0+c3RhcnR1cCA9IGFzdDgyNTBfc3RhcnR1
cDsNCj4gPiArCXBvcnQtPnNodXRkb3duID0gYXN0ODI1MF9zaHV0ZG93bjsNCj4gPiArCXBvcnQt
PnByaXZhdGVfZGF0YSA9IGRhdGE7DQo+IA0KPiA+ICsjaWZkZWYgQ09ORklHX1NFUklBTF84MjUw
X0RNQQ0KPiA+ICsJZGF0YS0+ZG1hLnJ4Y29uZi5zcmNfbWF4YnVyc3QgPSBVQVJUX1hNSVRfU0la
RTsNCj4gPiArCWRhdGEtPmRtYS50eGNvbmYuZHN0X21heGJ1cnN0ID0gVUFSVF9YTUlUX1NJWkU7
DQo+ID4gKwl1YXJ0LmRtYSA9ICZkYXRhLT5kbWE7DQo+ID4gKyNlbmRpZg0KPiANCj4gQWRkIGEg
c2V0dXAgZnVuY3Rpb24gZm9yIHRoaXMgYW5kIG1ha2UgYW4gZW1wdHkgZnVuY3Rpb24gd2l0aCB0
aGUgc2FtZSBuYW1lDQo+IHdoZW4gQ09ORklHX1NFUklBTF84MjUwX0RNQSBpcyBub3QgdGhlcmUu
DQoNCldpbGwgcmV2aXNlIGFzIHN1Z2dlc3RlZC4NCg0KPiANCj4gPiArDQo+ID4gKwlkYXRhLT5s
aW5lID0gc2VyaWFsODI1MF9yZWdpc3Rlcl84MjUwX3BvcnQoJnVhcnQpOw0KPiA+ICsJaWYgKGRh
dGEtPmxpbmUgPCAwKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIg
ODI1MCBwb3J0XG4iKTsNCj4gPiArCQlyZXR1cm4gZGF0YS0+bGluZTsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBkYXRhKTsNCj4gPiArDQo+ID4gKwly
ZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhc3Q4MjUwX3JlbW92ZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4gKwlzdHJ1Y3QgYXN0ODI1MF9kYXRh
ICpkYXRhID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4gKw0KPiA+ICsJc2VyaWFs
ODI1MF91bnJlZ2lzdGVyX3BvcnQoZGF0YS0+bGluZSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7
DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGFz
dDgyNTBfb2ZfbWF0Y2hbXSA9IHsNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI2
MDAtdWFydCIgfSwNCj4gPiArCXsgfSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1
Y3QgcGxhdGZvcm1fZHJpdmVyIGFzdDgyNTBfcGxhdGZvcm1fZHJpdmVyID0gew0KPiA+ICsJLmRy
aXZlciA9IHsNCj4gPiArCQkubmFtZSA9IERFVklDRV9OQU1FLA0KPiA+ICsJCS5vZl9tYXRjaF90
YWJsZSA9IGFzdDgyNTBfb2ZfbWF0Y2gsDQo+ID4gKwl9LA0KPiA+ICsJLnByb2JlID0gYXN0ODI1
MF9wcm9iZSwNCj4gPiArCS5yZW1vdmUgPSBhc3Q4MjUwX3JlbW92ZSwNCj4gPiArfTsNCj4gPiAr
DQo+ID4gK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoYXN0ODI1MF9wbGF0Zm9ybV9kcml2ZXIpOw0K
PiA+ICsNCg0KVGhhbmtzLA0KQ2hpYXdlaQ0KDQo=
