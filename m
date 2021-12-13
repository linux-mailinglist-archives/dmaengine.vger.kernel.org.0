Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78FE4723A4
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 10:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhLMJWI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 04:22:08 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:61925 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhLMJWH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 04:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639387327; x=1670923327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s/WDQ+OCl8p/i48v0fXb0T89rFUao1gPkiVYca/6sms=;
  b=uoYC4fLXC7ugSZwWHzoaYVp2JBRQ8aQUr3TI86hiF94CKLEvWxHOvRwx
   TgD2Rp+iF3LHGXJr6xdjykHeq1wU5cgK4/cIyJD73arcgKIlTleG3VOTa
   8EpF/0lB+fuBWRvci/y4Q3f+DwMqsC7IYgmW2YXFQkGRb1qIgbnqzUMXq
   R4yH37ozVFzjaR3IJHH2Cuwnr/1kS2WT05+d0FndeKNAoVyD8Gna6Y471
   /RSPqSXAWxUzfmu1d6QG6OkiBX2R9jWB2V/ePwBtgt7lUUIdkYBkQMiyO
   2soTiDCbJxduA9mhDhnb0Uex1ol+mLGbw+JIY2JtI4dtFTve6x6g+rhEZ
   w==;
IronPort-SDR: zZsawRMhc21D8m3zFXcVnhbDcTkdLJ6FMwtKhxtk3Kqofxob0GC9H9ii27nSa9CZzq88F1Pvhz
 fbVkP6Gj9nSaqhlFD4iZ6+B0WuENf3wHpN9xBNpYbJEW/+cIRigtzqD930EDJfVV9jAurL0TSg
 loM7pA82m6a5rAArrb+uCarYEah6+rpL9T6E8di8byaI2b+DwKr3yKwYH9Ppn1YFRzxtnOLHky
 gy5LoqXtFrzoGtq29n06TwT14uLufc+5R+I1fSEXY+sCxTLz9e3m8+h2HWjwMOfu8zC85288Ge
 Bw/cSg4iZG682mnYkWzsS7OS
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="155246214"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 02:22:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 02:22:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 02:22:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXCXNcSayUwK2lP8IquvsfQJSglg24Zbe6OhY4Xabgj3GkVhEaRUazHec6pYm45kLYLNmFlk7OZ9yaSxpkF3paOegdMLgwAlg89HYbqjNEbE/t9gK6kINaXH5uky1W4dS4q1uHeYDjT6+72uYg3yk2MMr27zA9OkGr5dHPaI/n3aAaYUAXwFYkIvaY9BusREEpoY8CPgn2KSUuLHQFDK7/gJbL0eyB0mJQooefuEku/Kq2Zv/60X2PUea4G0fFrM+tnhluSZB6y7yj19dyPj2/QuFotTalINiN7lUJTFI1U3r1rCi25xVRw0Dn/CqIW/kurTvpHPfQV//xF7lOU+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/WDQ+OCl8p/i48v0fXb0T89rFUao1gPkiVYca/6sms=;
 b=Hd1jRFK7sCQy/XqqWYQDZ8VooeDN0dlEieM7KomtdpXu1E8oU7MWTO07elX3SlvSqoqA/eNuWViseLZbKal60A+6VMxjSS8SVzngcM/zbxtNP7tNkHcNgpIet/wCAGigBWjclGgEUdV0q7cYG4N3MIsGOYthx8Xj5pYrZJGsBmVFPVaBpO5wwJi5sF8A6djgoxtCBMYYksJ3pMN4vcDTx9EYOykN9Hpr9oQfKybvk8C4nB4/Gh1Hc7phA/BbRIrp3iinlNVkJ6a/IJf96qbqWpHokREhuhDYqgnyJwL/tWBd1dBozBHIaWwJeRa4PbeA5CyRxswVU3fbA41BoeCzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/WDQ+OCl8p/i48v0fXb0T89rFUao1gPkiVYca/6sms=;
 b=uWUj3TflMnbB5OpNZDrAWMpNZnadmhtiBHVHoXVaWQR08FqqQDpK4GFzvcTfVVKvwe4DaB9do/oYC9oKPt+r/ypYbtsF8SJlpnWFJJkbCoAvziNagWUrNXEzwxzr9PIX1V3ZbdYpgGKI2msHZnTCVT51q4HEfw2j8F1skMUXUjg=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3533.namprd11.prod.outlook.com (2603:10b6:805:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 09:22:02 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:22:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <Ludovic.Desroches@microchip.com>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] dmaengine: at_xdmac: Move the free desc to the
 tail of the desc list
Thread-Topic: [PATCH v2 08/13] dmaengine: at_xdmac: Move the free desc to the
 tail of the desc list
Thread-Index: AQHX7/6cGW4RS1ZeJkC0M7VpsR3jOA==
Date:   Mon, 13 Dec 2021 09:22:01 +0000
Message-ID: <3d57524a-6d88-3027-d8fb-94417ae0b4f6@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
 <20211125090028.786832-9-tudor.ambarus@microchip.com>
 <Ybb/PV5M1Gi59s7I@matsya>
 <8523ca32-d36f-6e0b-0115-5e07553396f1@microchip.com>
 <YbcLjrMF0YrCVgjc@matsya> <YbcLx0wGFvFnvSXY@matsya>
In-Reply-To: <YbcLx0wGFvFnvSXY@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bb157ea-82c2-4f1b-99dc-08d9be1a0581
x-ms-traffictypediagnostic: SN6PR11MB3533:EE_
x-microsoft-antispam-prvs: <SN6PR11MB35331F27E4293238C98DAD4CF0749@SN6PR11MB3533.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nM29GTP/OpZ1RPzegE4UsVop2ottnpWqiuP3wCTZXAkNboMJ+omhSQ/xFbYjbcHwxP+h3TIFHn/wYY8CiwQD2dE4DFxqtOFnZGwm59H1GQCb+N3GpJ4fYzjSnvK0Iof6YlrZxpCXJTyHsY7+fLo1cAHODGTaLN9/YUHEgbwags3k7lFWYfpSRPiMrjtPWWuyhiit5Blg1YtmygtOXiwAAbCWg5GtdAQfRc+nqdu2JUrOCi+hnlrNajvhnGKxZWy+y9vkrqlWn2xmq7NLMP4cG4TYcMb/WEqhlM8bteFBTwUMQMI/ZF8786E4YPnzTa3XjRyCd5u9YBW7Paofm/Ebh8ugnSM/r/NOnum+2gM4LQ3cl/9qBEzXCGbfkLPsPw/TBQPAZk7pQ7sIykw8ISnjO9niUxajaCfcMeO4Q5KUH+lin64IpZ9di0vDJ+affZ04gx0QkFFMj0EM35CeNzuCY5GTy81Uclj67KLxhYrZe4hLUVOcuIg1Ty9OTGajOpU0ECpM2/jq10erf7jHKK08i3En86pjjPUgiBwgU6C5gyApv5DFYfXd2k4/20f8cgej3QSfvWVYDTm/SMOrD18IiFxLyUsEgf01S0qz+ZNIBHogNedz6Pnn3YqArLy1p4586I5zE8h2YUoaCnIK2ImnLZqSFJNWajdaOGzfc6RwjlD02wCtaZvlRQnqMYEBwfnN2PWLVFOq3N8kZEf0f4+0FGXueHFiF5nTVLaH7/bbgHnUCxaelEzVzEmZd8G1Fyp1u69zk+rVMYr4bBchX9W5FA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(66556008)(6512007)(66476007)(2616005)(6486002)(66946007)(76116006)(6916009)(71200400001)(8936002)(31696002)(316002)(66446008)(36756003)(2906002)(64756008)(83380400001)(38070700005)(4326008)(26005)(54906003)(186003)(86362001)(508600001)(122000001)(38100700002)(6506007)(7416002)(31686004)(8676002)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE9OZmJlbWsxU3R1ZzB6bTZYdklDNDVDdWtrNGRWWStyRWJQVzVlTzk2cjVF?=
 =?utf-8?B?aUhhVDJFMVFkZHRWM2lTRWE1Qnc0UElNK3JuSU9ZeDl0eUxLY2xqQXRFWkV2?=
 =?utf-8?B?bGNXYzU4d25tT1ZURStTS3VDU005QlZlWXdhVm9LNGxZTzdrOGVRS3hzTlZ4?=
 =?utf-8?B?Z09VNUhEVzduL2FTQjRCNmRKKzlJT0V2UmpCSzNhMWZmY2lEZnVxdVNRb2k3?=
 =?utf-8?B?MEtXTFI1U0hrOS95NXBNQ3BPOVhKVUhRVGNGQnNmcHBYNEN1eGszaW5OUlNm?=
 =?utf-8?B?aTUwK3VOdWxvdEJteCtFZUEyVXAxYzF2N3ZOakw3b0g3dmFqbXoyNFY3RE4y?=
 =?utf-8?B?all0eHJtZGZEaGxZMTA1SVBraWRYNW9XWHlMQ3RGV0RQUkl5TG1Ha05vSit4?=
 =?utf-8?B?Y1NHS0Q5WDEwUC9IZ2t5cVA1WUtGYk0zTnFFbFhFaURCVmxtSXRLRTBRL0xK?=
 =?utf-8?B?eCtnRTBHMjN4UnJ2eVh1c01EeERsLzB3SlM1Szh2aUlIcG44ektnSTRHTVhn?=
 =?utf-8?B?ZnJ0TEdWSlU0WmVYbFNCVVpwaXBvRXFmZTkwQXdYU3BBTEdyR1d2QTdvUlNI?=
 =?utf-8?B?bGpsRXA1U0E2WE9jMFVESGtuWCtVaWJDVi9kdEU2a0tlSTJRVm1EM0pCUS9C?=
 =?utf-8?B?eTAzMWhZWWNyR2VMdEx6QmIxUTkxdC80c2lQUGwzVXo4VkYrTXRZcjU0OE5L?=
 =?utf-8?B?a1FaK3kyUTA0MDlDZmdRdUY2elVXbGpFZHQ3aWo5SUFEMWI3YVE2VS9UcHVo?=
 =?utf-8?B?ZklybERRUDdLTmdyNzlVWi8rVXNudDI2Q0t1cHBCWlJ0R1QvOVZkNDRBK0dG?=
 =?utf-8?B?Qm5UdklQTnduaEIvVWJJYVBXQzdkS3hCU1Vud3Q3d0xQczlYYUFOdzBSMUZj?=
 =?utf-8?B?N0lLd3FublNKT3ZFamtCT3lSYTlqRXNCdE0wMFo4YTlVYjJvY3B6QURENmZT?=
 =?utf-8?B?enNoZHJycy83K1hRV1l0S1BQWlZqY1BCTGVvNm50ZmtFejVncUQ2cndvTExB?=
 =?utf-8?B?RWxlU0x5YmRpaEx5cURyNFlwNm9lQkRNUXkzOFUxcDhoMk43R3ZxWitUVVpV?=
 =?utf-8?B?bmJDS3BFa1NzMkY3b2doQkpaekw4T2ovWkJETTNGSG1aVnppc1RtVEd0VCsw?=
 =?utf-8?B?ejhQSU5HMHQzS1lEMjZDdnA5WHlDdUxBS1JWc1N0WVczMzNpbW1obVduS1Ny?=
 =?utf-8?B?VDVnUDJtaVpjbm1YYjFwdmhRaHJTMVNiZEt5THhBSFI3T2NOVTVWR0h0VENM?=
 =?utf-8?B?NFJkMEFMOGdJbW9rZzg2Z1BxVlNhejdiYkxCTkw4UXYrUmxaSXVQVDA2QVRu?=
 =?utf-8?B?MjZuek1xd0pNczhWU2M5WjAweERNS1B0cmFuR1J2czFaNEp1RVU4QjVmS3k1?=
 =?utf-8?B?UXN5M0I1SytrbWJtVjFVRHZ3NDhTczV6WThQdFA2Vk8vUG1JT1JpS01qT2cy?=
 =?utf-8?B?aDZLWHJ0OW9CajVWTSt5QXRFODhNMWZQNU0rMjZyV2xYT3llYmhWZExtQUhF?=
 =?utf-8?B?RFJFWkkvQmJlS3lyVWJ6ZW42ZDVjWU5FK2Vlemp2MGI2aEYvTXg5amR3eEhB?=
 =?utf-8?B?MGVqOFozY3RzOEZZV2VmSXZqVi9sTUNnc0hlVnNDREFROC9zV0tlOVgwS3hi?=
 =?utf-8?B?bFVtWXdjNXJFUU1qcFM0Ry9WdFMyNHQrNExBdkowRHl2NlJKZkZvYUxmcG9T?=
 =?utf-8?B?YTkySDdnMzFpSVBWQWdsTzB5STU0a294N05CTFVVaWJDUGVxU0RJbXBzU0xh?=
 =?utf-8?B?RDA5TGNINTFocndMVVc3akpFNkZoUUU0YUtiUDBWM1krLzR5WlpJWGIrREFq?=
 =?utf-8?B?K2RLdzhhRnNqWHc4bEplK0huVGJvNExnT3I1TFlhdytvakk5ZUV4a1YxZmNO?=
 =?utf-8?B?TzY5b1ZaN1dLMjNwT0s5Qitma2ZYQTJWcFRJV1BqOFlzOWJTMmtRQlkrcDJh?=
 =?utf-8?B?T3JVa0dOTjQzK2l4NFBiaHJSNEFVOStKR2JHVFlhVUhlSDdmL2htUkhNMEhQ?=
 =?utf-8?B?VzdTT1hBRGt2eE90aThheG9MYjArb2dBNkdmbVZvYjdGbncxVHphVEtkTG10?=
 =?utf-8?B?TTQvOU04eU10Y0d2YVRteUFLVk9qQTk0ZHh2VnRsSGVhTEQvd2lBdDlhMzRt?=
 =?utf-8?B?QjY2VGpRaERmelJGSnZvN1hiTFh2eFZxcFV4dzR3YjYwazV5YnloM09aWmwr?=
 =?utf-8?B?N2pMZUFKZEpuZFJFZWpadElpMUVRWm1xTnEwc0VsdVdVb1krcit2dERsNjcw?=
 =?utf-8?B?V04vQnpIWXJjeU41VGxBWXJTZ0N3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A42D509E240E61438A338905FBB3290E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb157ea-82c2-4f1b-99dc-08d9be1a0581
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 09:22:01.9247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gLKOmBV9B7gDjCPI7pIv+sFTgfeWDWFZYxx2aHpPNQ39YCYf1xFavP4sBnmezccS1dVmZkYs6AljwpKnQWcwxrJU5m3nfqEznediUPM+QE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3533
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTIvMTMvMjEgMTE6MDAgQU0sIFZpbm9kIEtvdWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTMtMTItMjEsIDE0OjI5LCBWaW5vZCBLb3Vs
IHdyb3RlOg0KPj4gT24gMTMtMTItMjEsIDA4OjUxLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+Pj4gSGksIFZpbm9kLA0KPj4+DQo+Pj4gT24gMTIvMTMvMjEgMTA6MDcgQU0s
IFZpbm9kIEtvdWwgd3JvdGU6DQo+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZQ0KPj4+Pg0KPj4+PiBPbiAyNS0xMS0yMSwgMTE6MDAsIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+
Pj4+PiBTbyB0aGF0IHdlIGRvbid0IHVzZSB0aGUgc2FtZSBkZXNjIG92ZXIgYW5kIG92ZXIgYWdh
aW4uDQo+Pj4+DQo+Pj4+IFBsZWFzZSB1c2UgZnVsbCBwYXJhIGluIHRoZSBjaGFuZ2Vsb2cgYW5k
IG5vdCBhIGNvbnRpbnVhdGlvbiBvZiB0aGUNCj4+Pj4gcGF0Y2ggdGl0bGUhDQo+Pj4NCj4+PiBP
aywgd2lsbCBhZGQgYSBiZXR0ZXIgY29tbWl0IGRlc2NyaXB0aW9uLiBIZXJlIGFuZCBpbiBvdGhl
ciBwYXRjaGVzIHdoZXJlDQo+Pj4geW91ciBjb21tZW50IGFwcGxpZXMuDQo+Pg0KPj4gR3JlYXQh
DQo+Pg0KPj4+Pg0KPj4+PiBhbmQgd2h5IGlzIHdyb25nIHdpdGggdXNpbmcgc2FtZSBkZXNjIG92
ZXIgYW5kIG92ZXI/IEFueSBiZW5lZml0cyBvZiBub3QNCj4+Pj4gZG9pbmcgc28/DQo+Pj4NCj4+
PiBOb3Qgd3JvbmcsIGJ1dCBpZiB3ZSBtb3ZlIHRoZSBmcmVlIGRlc2MgdG8gdGhlIHRhaWwgb2Yg
dGhlIGxpc3QsIHRoZW4gdGhlDQo+Pj4gc2VxdWVuY2Ugb2YgZGVzY3JpcHRvcnMgaXMgbW9yZSB0
cmFjay1hYmxlIGluIGNhc2Ugb2YgZGVidWcuIFlvdSB3b3VsZA0KPj4+IGtub3cgd2hpY2ggZGVz
Y3JpcHRvciBzaG91bGQgY29tZSBuZXh0IGFuZCB5b3UgY291bGQgZWFzaWVyIGNhdGNoDQo+Pj4g
Y29uY3VycmVuY3kgb3ZlciBkZXNjcmlwdG9ycyBmb3IgZXhhbXBsZS4gSSBzYXcgdmlydC1kbWEg
dXNlcw0KPj4+IGxpc3Rfc3BsaWNlX3RhaWxfaW5pdCgpIGFzIHdlbGwsIEkgZm91bmQgaXQgYSBn
b29kIGlkZWEsIHNvIEkgdGhvdWdodCB0bw0KPj4+IGZvbGxvdyB0aGUgY29yZSBkcml2ZXIuDQo+
Pg0KPj4gT2theSwgSSB3b3VsZCBiZSBnb29kIHRvIGFkZCB0aGlzIG1vdGl2YXRpb24gaW4gdGhl
IGNoYW5nZSBsb2cuIEkgYW0NCj4+IHN1cmUgYWZ0ZXIgZmV3IHlvdSB3b3VsZCBhbHNvIHdvbmRl
ciB3aHkgeW91IGRpZCB0aGlzIGNoYW5nZSA6KQ0KDQpTdXJlLg0KDQo+IA0KPiBBbHNvLCBwbHMg
c3VibWl0IHNlcmlhbCBwYXRjaGVzIHRvIEdyZWcgc2VwYXJhdGVseS4gSSBndWVzcyBoZSBzYXcg
dGhlDQo+IHRpdGxlIGFuZCBvdmVybG9va2VkIHRob3NlLi4uDQoNCkkgcmVjZWl2ZWQgYSBwcml2
YXRlIG1lc3NhZ2UgZnJvbSBHcmVnIGluZm9ybWluZyBtZSB0aGF0IGhlIGFwcGxpZWQgdGhlDQpw
YXRjaGVzIHRvIHR0eS1uZXh0IGFuZCB0aGF0IHRoZXkgd2lsbCBiZSBtZXJnZWQgZHVyaW5nIHRo
ZSBtZXJnZSB3aW5kb3cuDQpTbyBJJ2xsIGRyb3AgdGhlIHR0eSBwYXRjaGVzIGluIHYzLg0KDQpD
aGVlcnMsDQp0YQ0K
