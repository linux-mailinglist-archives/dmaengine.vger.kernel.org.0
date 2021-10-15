Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78C142EAE8
	for <lists+dmaengine@lfdr.de>; Fri, 15 Oct 2021 10:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhJOIFp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Oct 2021 04:05:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:26810 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbhJOIF2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Oct 2021 04:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634285002; x=1665821002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/QxtljvZ5WlNkR7ppacs8C7HnM4W7QMnEr7p7O4moXw=;
  b=tBxVaZ6PrlC5fHr1lIj5b5Y4vLPej2O7/YUtQ8DbS2G7HEKN6BDYVmb6
   bzSMGp36l+ERnr0y4iChtzf6Kfe6HBNLHofrUUug8H4nTgqQoKw5PsRKa
   RTJ0+hjC1vfYc8K4jdOC7/tn2LH0m4c4MhH8YJol58mJl8b60KaIx4rIP
   NCgtQAc+hQtdbj1+2qb6DspNB4bs1A0EZFPozhkaaRXEasCwRBiui2gWW
   Go1BQ8s84JcRTVDXHGYFTtw/wAdXkt090nLYrK+8ymGeuLoCkLJcX27/i
   wni/zEXXvSo09gLGrVD2JLKtONpKm7eLp+EJDL/lZ5xYRmdX4u/U/mz81
   Q==;
IronPort-SDR: ChQIgehvYsSsu44RvGQR4fs39LF14RW6O9OGmeLswvi/iZ8Y4/xu9Qy7iK7zj2g2y2lRYahCpW
 gOBJ+34eldLvtI3/imrLlkOgtSbiVARYK0nEq1psN/3bmqjHowWd4MCl2z6COSCCRLgQLuvaWz
 V1YEfPK6a4Vbbq4AAyQUFpsF6xYOe7QV/Dq2Si6Axo2PlOh66sV35nkl2EkyWl4wdnbScj/K7q
 UfmWYCbnighB7rLiRzW/OfCcwqxiQp+Uqph8Yq0o37tkacZJjQKeO46k+ahE9zWwSGbRQI2rCH
 P8UrjVW8KECTG1Kz8PPRCtFK
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="73044914"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 01:03:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 01:03:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 01:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdX2lLOeuY+GVTGWdlBjBsluZqGiE6TFe5y3aSOZ9XF97Zmem0NXN2pQBnbfOZtGuNbp29E9KLE0ivR8oP8zDWVa74aUx+kYvm7Uwfj1oKYW3E7Az2AomGh9F/2b6oXhlpqXq9zFgMNkBRI9F5R4lkmh3iND8Rbl9tnwvIZ3My0X7ZaP7ygaOK1KcyO7BPuhYNC1Mx7LIYOsksXOhu2tIe9uDYCfA60TE+DWRjpXna+46IBBuxae/wsw4ponwjcPpullv7xP0icjVIl2KcC5lD4Uldvv4aSV1b6PoTEPRuhSlAI3poVJt7UqBDEn0ocrJN/xgiYk6IGkL3oNW6l07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QxtljvZ5WlNkR7ppacs8C7HnM4W7QMnEr7p7O4moXw=;
 b=f8YJi/arpWo1jZepigbQBpq45KZC9pHhBv9lwjRTERFXt4tP9fcm91r3NRwtcTX3w7/KAuuYLQpfdM615SGQuoPcHoIM6spmT/l2LQiFy7SMkTsZaa9IsDzW8P4rn4HjeyHwtLEFE1xYOeYUJw9oSBkuK/uty/7kMpH2myCVVtkvacuGyJGR1yIKe6//kMnLcSnAlDAsd6mFpxWg1zMrG8t31OM1Mx+vYou88yAGXUmQi0Jo7W8vt0M1+7FO0GGw46kGgkRjB4N9Ee8sVId4LYQct0QNcPeY7oMLehyifIa/Kxd+TigH50sATQF+xRHbQISLsQNb183oXdjri9TBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QxtljvZ5WlNkR7ppacs8C7HnM4W7QMnEr7p7O4moXw=;
 b=ES5OC9iR7sXy+kX6m32i1/mlw8GLkAFVOL8CWLlxZSvrY5spTMFRWoiDxdrBKFxYWasl12O5xygahHIACq+/XtEUpOn+FcJwxnHJhQc6YiOsabOz1bAuZV8HLowJT/pZ5JlyVjsh1djyTEuq+aFvuIL9d0ia5RN3esQc0/mGoIM=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 15 Oct
 2021 08:03:07 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213%9]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 08:03:07 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] dmaengine: at_xdmac: use pm_ptr()
Thread-Topic: [PATCH 4/4] dmaengine: at_xdmac: use pm_ptr()
Thread-Index: AQHXwZsWoLOHOLPo20e30HI1NNh/yg==
Date:   Fri, 15 Oct 2021 08:03:06 +0000
Message-ID: <26d866bb-7a6d-d3b7-953f-caeb6249eacc@microchip.com>
References: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
 <20211007111230.2331837-5-claudiu.beznea@microchip.com>
In-Reply-To: <20211007111230.2331837-5-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e64767fe-e893-403d-c6ec-08d98fb238dd
x-ms-traffictypediagnostic: SN6PR11MB2575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2575BD0C3F79E4186E11CC12F0B99@SN6PR11MB2575.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wzAMNxzdNx2kbfehpiuT4AkfppG3h0sIw58ceq3bZs6nA/v8dQxrGFUFLl8QLyZs66mlK2ZTuNO4eqL3km8Xq40pPQZ8+uAaOo8l2I4BVI5Hzjiq8Nc7cSKEBkVKOs6zPogD2+L+0TEDOBFFplQE100amG2Dc0dKl846QDkdLwHeA0V7P4ntY+EWzc5N0L8uDWYTEKYrA+Z2x1GBpAUhjpb4rAMriPt7dIOWPKYIX8bzxF4cpqGXQA6MKIDoF1vTS4LJdTPoUoCu0kKztFUrLurFSmuw1OmsQpB+MHQIItA/4gHULVN7nYy2ZB1D4GXnkCOUPR33qWEJLJf7KtRCidIFG1LKzpN2ZqshZk5zqhgi5bugqfC8DfRAqrBzZ8qlSrxzyS69YiLfKnr4MSZwxBb0gST1lD2gSzxQs9yyznt9BUwE2AIf0JpVMItQE0XzWobwYWbb0QOvCnVB+kzRFFyiaUd8tq3NKExNWtnTqHLtezyKghONpumutunoiEQp9VpY3uluw+uFOM11wAvtje9CIK4f8Jki/jFBS9gSDe4tm2e6wZTcqRQ50uR8sTIk9yHcGTrd+WqMGrLk3gjdPt3OpMSSM/oG9CIMdfwh4M9mTFkqBXuYKAwz/p89kzOuHSoMePGJcUxViNM2RAPUkev865CKoayNC1Yp78IO87aECt8DvGq0VYRYF+3bhNoyz9RNkAbDkoKf5f5yPuoXRDg2l+rm72hXeKJwivDOsbvJoLWEwdGWFIqGC+EGudJx5DRKylEMfXIagK+Chd8AOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(64756008)(86362001)(110136005)(91956017)(66946007)(38100700002)(76116006)(4326008)(31696002)(4744005)(54906003)(53546011)(31686004)(6486002)(26005)(66556008)(316002)(122000001)(66446008)(66476007)(38070700005)(6512007)(2906002)(8936002)(6506007)(36756003)(71200400001)(5660300002)(83380400001)(508600001)(186003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUlSM3N4WGN0c0xKVHEwdGZoa3kvYTEzWTdDd1g3RVd0amRtUHhEWHJIdnZl?=
 =?utf-8?B?dHZlS1FENXNtVExUME9lK0xmQVhzb3Bma3k3L1RqYUcyTlB5b1VobmNyb0dl?=
 =?utf-8?B?WVFRQ0RKTlVaM3pydUZ0dll1d1NzYkd4UEx3My9rbyt6YUZNQlo0NEdVeWE0?=
 =?utf-8?B?Uk1oQ1cwblVxdzdGaytVLytkSC9BV2lPRUdDSFVqbXpKY3F3TUpYQmxMYTFR?=
 =?utf-8?B?bjNhMmNRdE1jckhhVzdiTVoxcVpUQmxsRDRQSGNncDRhVDlzZHVBVk52Z1d3?=
 =?utf-8?B?MWdVZDlpZFQ3bmRCQlBCdGpkV0Jya21rNmllNE1IZ2t4bm03VE1OMlA0S3Nn?=
 =?utf-8?B?b2JMZmtVTDF3dXdyNmJpM1FzUWs5NDBOY0JjVFZmbGVZUEN5ZENVVmZZRmVa?=
 =?utf-8?B?cjUrT2tvUXhuWmpxVHk3aGZVbDdPaHVnczBsMGR3WkRjUmRiV2k2dmJIdXRE?=
 =?utf-8?B?ZnRncmJCaVkwYnN4OUppcC9zczlQRWJuVEZrNGNQd0VTaFp4Q1JXbThzZ09j?=
 =?utf-8?B?Tm1zWjBpTVVOU0VUbTV2RldiWkIvWlhwTU03SzlzdFN0VnJ5bThWQkhBRERo?=
 =?utf-8?B?YmVWeTNzN3JQZTZGMW5GQjRXRHhwbi9DMkxKbUh0VWdmQ2JkM254WjExcjJm?=
 =?utf-8?B?aHVJMkEvSnJlbUErbnJvL1dYY21hYU9HclBKbmdVZ1diTlNOa0FFYVlwSWdq?=
 =?utf-8?B?bUVsM3c3Z2hsMVMzdjBDWDEzVXpTV1Vxb1h4U1c2dlRERkprUDBLbE5vTlYx?=
 =?utf-8?B?eUhwdE1nSDRjWVlkcGtuY204eEpSZmRVOXBDL2xSTzJuSlNJay90VVppeXhT?=
 =?utf-8?B?eXk0aFk1RXhEaG1sYzdmQXduTkQwaVpHekhVT3FkenBMbktWYmZvd2o4RS94?=
 =?utf-8?B?c0tMNWF5RTd5L0hhOFF5bGUwODYwa0JiOU9PZ1hpWldIS2tkUjRvK011Uk84?=
 =?utf-8?B?RGJuL3JmdUx4a1FyWjMzL3ZWSk01OUtTTzA1U3AzbTFXYzNsangwOFdPWlZP?=
 =?utf-8?B?Q2NOVXREakt5bjFnZmJlb3dneUFQQk1QNWw3NlNOd1lmWVhMWG91SGk2c282?=
 =?utf-8?B?MkRjS3lPcUdWb21QRkIxL3lJYnBzcExQUGJJSEo3R0crRWd6K0lua2YvMTF4?=
 =?utf-8?B?M0xML1RDcnpMVW8rdnBJVmtFUTlZODl3K08yV3hqNHFJV2NYUDc2RFVkdW50?=
 =?utf-8?B?VEFBTkE5a0tBd1B0VjRGU1dBbklaY0dTTC93ellVdThIaFJRaGpxMzV1eFh1?=
 =?utf-8?B?NGc2dTl1WnZwZUlKVDVPQndnSWw2eXZ4VHlUK2xJUncvOG84RlpPdnBrSXls?=
 =?utf-8?B?dzdscFdyRm5wSm03cThodlJiNkJaYWJ2RWFySktaWmFpMm9jR0QzTzlhODJh?=
 =?utf-8?B?aGkrRzcvTzJzMis3ckVFcE1zMmlvN0NncFd5NEIrS3kvMVYyeHVQSTBEN0tj?=
 =?utf-8?B?RlBrdVk4TmorWWFJbk9JQ2h5Rm03T2hNbzZLbFlxbmplYmxYTHBpTXZFOW1p?=
 =?utf-8?B?bmxNRXFOS0w3TTdDQUdwTGk5MGxmNFk2TDZYSXBha3ZBaXVuZ25ZR0pMQWxz?=
 =?utf-8?B?VmhiZWNENEVJYjBjdnAxKzF0SFZBbHRRTC9rL2NNYk9mTUtXdUJxaThVQjQ0?=
 =?utf-8?B?ZXZxM3IxTmptWi9ydDlJTnVLMHduT3ZOLzhpb2hJRWc2enh2bzdVUWF3MDNP?=
 =?utf-8?B?QVJTbytnQk9HQ0pJb0YzL0VtMVJJTmozc0lFSVhKWUl3Rjl3MWhxQXZOUDI3?=
 =?utf-8?Q?8lrEHQc79JiY4hiloQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5C6C642DE18F24A91C09553C680199A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64767fe-e893-403d-c6ec-08d98fb238dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 08:03:06.9271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywIgbwVG4glZEz0IcvkmEwfCfPS02oWw/yHH8IO98A3O0EhLscUqBLeuAc5dsaxnCuq9cv4LRocaLff0b/4A9LBgsac6E6j159PmDBvjK7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2575
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTAvNy8yMSAyOjEyIFBNLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4gVXNlIHBtX3B0cigp
IG1hY3JvIHRvIGZpbGwgYXRfeGRtYWNfZHJpdmVyLmRyaXZlci5wbS4NCg0KSSB3b3VsZCBhbWVu
ZCB0aGUgY29tbWl0IG1lc3NhZ2Ugd2l0aDoNCklmIENPTkZJR19QTSBpcyBlbmFibGVkLCB0aGlz
IG1hY3JvIHdpbGwgcmVzb2x2ZSB0byBpdHMgYXJndW1lbnQsDQpvdGhlcndpc2UgdG8gTlVMTC4N
Cg0KTml0cGljayBhbnl3YXksIHNvOg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpu
ZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNClJldmlld2VkLWJ5OiBUdWRvciBB
bWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJz
L2RtYS9hdF94ZG1hYy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvYXRfeGRtYWMu
YyBiL2RyaXZlcnMvZG1hL2F0X3hkbWFjLmMNCj4gaW5kZXggMTIzNzEzOTZmY2MwLi43ZmIxOWJk
MThhYzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZG1hL2F0X3hkbWFjLmMNCj4gKysrIGIvZHJp
dmVycy9kbWEvYXRfeGRtYWMuYw0KPiBAQCAtMjIzMSw3ICsyMjMxLDcgQEAgc3RhdGljIHN0cnVj
dCBwbGF0Zm9ybV9kcml2ZXIgYXRfeGRtYWNfZHJpdmVyID0gew0KPiAgCS5kcml2ZXIgPSB7DQo+
ICAJCS5uYW1lCQk9ICJhdF94ZG1hYyIsDQo+ICAJCS5vZl9tYXRjaF90YWJsZQk9IG9mX21hdGNo
X3B0cihhdG1lbF94ZG1hY19kdF9pZHMpLA0KPiAtCQkucG0JCT0gJmF0bWVsX3hkbWFjX2Rldl9w
bV9vcHMsDQo+ICsJCS5wbQkJPSBwbV9wdHIoJmF0bWVsX3hkbWFjX2Rldl9wbV9vcHMpLA0KPiAg
CX0NCj4gIH07DQo+ICANCj4gDQoNCg==
