Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611C142EA91
	for <lists+dmaengine@lfdr.de>; Fri, 15 Oct 2021 09:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhJOHxN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Oct 2021 03:53:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22947 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbhJOHxL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Oct 2021 03:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634284265; x=1665820265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UnfIzQ4/b9WtXgnqtUUYpeUyBFIoib34fvHCHuaJOUk=;
  b=YVWoIzACISDUYkSPi+1/wep3aQHuHmaNlxPQBQd8de2S4H+qjLr+Z6k8
   fr8V6eUSDk8Ov/L6tVMpBUNhOBjV3HclSqK5ByzhjnXDXWFBafx3hjhx1
   l+imKw2fRcYWU408uwmPSz55+e0XNPAER6iXbpoCP070Z2C4XUX9gJNLm
   GuRy/0Y0YQcd+sq/uiamKdMl/yyicXVrReTOvDRrrpuBv8nWjPtzJJlKw
   yh9dy683SKpLJHMw6lo3l5Vv6rVkb/v95/e0atpbDFqVTZEnp4qAqhK4M
   dBBl4PMSbjP5+KbTaxc1bsDb09Qb5p66gbPsp2E1Hm1gnzKBWxzn/2+wb
   A==;
IronPort-SDR: QiaheDG2DmbBzeCF/XolKn+w6oltQWRJY1zRM+X3AHY4Y2KWu/OeNsQtPCyNY9pMMz4ccbRMFe
 A63toQH586RWHk/YWy7ZiUDNOEERqMT48FUDBGvd4kYYx5gLgIeud2bl+ZZBF6oADHTooCksLq
 Nz/0UyUxQQxM4qC0cxkDYYrXr+ox7+cMhD9BzzgzNTCkEmevncIwoJAvuJ87fT0TvqZUUh8gf/
 /hDIujHhdRZqI8XtrroDkLpnUwal5PaZseDNMvWeJYMue4UH9FnMh7unnQEkAg10VrOpWwDO9j
 Amrq/9giJRg0yWGOLoaSXwpM
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="140403206"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 00:51:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 00:51:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Fri, 15 Oct 2021 00:51:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp6wO2FHrTy7fkKbVGeDsRs0Ra49c4MLs4nbYbE5QV+vMfbvcaFvpWhN0hvuCjKdtHTxJfaG7IF8H2hKi0Ke6lnLwNatqQHoqfSRnW1laGsv38Nl3xVRLXzTTLUh3uYF/scSm15Y0R+WqxgjYyq9pt9jyrkUk51yHEUDDjsGMGOA2Vv9DxYWp4Sjc2tZXMfE8xR8g9sNxyQVJDVcM4SX//eqKz4hZGpdBZdgVuP/R25iKuIiimRUhD6Ih/469TbWs81ojbsiorDCUrlUMZtxLtfb8u9KIvLpFK88EJ8w7WxSrFnsPkMHn7wcS6IReR/d3589od6nXmLVdCv9ArpJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnfIzQ4/b9WtXgnqtUUYpeUyBFIoib34fvHCHuaJOUk=;
 b=ZTluJPLt2EbI0VzAlCNXX0sjAsM/t6FD1XrM6jTXVa+eVVquG2r7RK1YFcnk3oSAzT1On3xQVg0rOBs+cCC5SXt3P5BbIOepT6Ze52r72AhbD+UgPEeCAx/uQOajApqEdUO9+MpcYGRh0H0QaB1mmi5S47QQf2iuUBnECVXjomF0SAS8dKUMHiUf7Ft6DpuiKWtJVvklNkGUf+2ZL35dl3YQMfpN6OdJod5G7ps1TQVL7lYbAN2RWJiUHjv/W1DeQNgsuc1MsT+gdIuB1ygwt5CdM+fg1PI8pGYh6P5EZoSjq+vax777lC6JNRN31y2WWExgWIsy9ZYfzDMbx+zE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnfIzQ4/b9WtXgnqtUUYpeUyBFIoib34fvHCHuaJOUk=;
 b=UAwAJx3sH2dTFkzYXJ2ok+FKBOm2zfSl3V4YVWLpqWx60LpEFuWd865HbzIIoaPHk6pHzDHVi85iPKe6zw8xpE2TNQiI/p4pzVWWIZWvPdG1m9OGE9G6cwO87XhXKwdBdf5reA7EtAn2DkJTu8fGc83iSVMAorAThtAO0/TM5dQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 15 Oct
 2021 07:50:54 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213%9]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 07:50:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] dmaengine: at_xdmac: fix AT_XDMAC_CC_PERID() macro
Thread-Topic: [PATCH 2/4] dmaengine: at_xdmac: fix AT_XDMAC_CC_PERID() macro
Thread-Index: AQHXwZlhvPcwAFfJGk+Dm2tpxTLPWQ==
Date:   Fri, 15 Oct 2021 07:50:54 +0000
Message-ID: <f940d670-c149-dcc1-c07d-c2d4487c842f@microchip.com>
References: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
 <20211007111230.2331837-3-claudiu.beznea@microchip.com>
In-Reply-To: <20211007111230.2331837-3-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: b5718ae8-1842-4ac2-711e-08d98fb0847a
x-ms-traffictypediagnostic: SA2PR11MB5083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB50831AD109F75689ABAB3C88F0B99@SA2PR11MB5083.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNqTCwi6NdJUyt5YZmepFTFqDkVCLb1EyQi+Hil7TE707PACJKZpB4H06H4fmGbleWXXwbyFivyOk5e8zpRuNpnTI0PbiOGYKxFgqp0It17M6bAEDCCxcveABmZv814zzt8rWPG16tFVY4NpHmRb/Q4ud86X819Vbv1QWW75eWnfMwMmHcwv9TSWiWbFQv72fZO/foHbcYTD4PQEAxL9PIc92ne3PTle8yrPaeNcwf21phfc/ijSLG7GrEKiKPhFdTV0E5hAKgBWAU5Ub7aJ76EU6ANVXGJ+cVdTXze3irB8uQTc8D6u4yFXsiHqDbO4aEhTfjthdimQ+SO9XA7ukqT4M1E0LmMScHHz2oRpGMerbUT6Kk02NGebDZ5JT9Z6XaKA78QHJa05QIjBNfJtzvoRg7ytN6CmKwzbVbA48XvZM5ORUBTaRUhytVQMjvlPcfAqQ3GA6oZ6D7DioA9tZNjxsOcKfE4hpRr6QcHixfnP/iu2FzyxNN1VIYEYWDprcErbRBffweROGY0ELXpst42k6gu2ShRPWnqiJRqjrX3e6Gfqpf5d9Qm5DEzMVl4ca6kcm84I2NTPk4E7zn2c0VbOOJQMUOwIciKlN+r14T4T8R4OsRze10//CR7DhwYkih5SwLtWRCxTSmozeqtjjLtM9lBWSBL4blojLxjuogUJeB1xs/aHOlaP9Fir1MARRCDXD3el9Cr6raFUaX9yEKzBcWyk9xqN3gJZ+GvnWuwrZFvCdvNg8Vza9JTi/nSfUy8f/13m5fg6dwkvxTwE1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(54906003)(31686004)(2616005)(38100700002)(110136005)(36756003)(186003)(38070700005)(6506007)(66446008)(64756008)(66476007)(53546011)(83380400001)(86362001)(2906002)(5660300002)(26005)(91956017)(8936002)(6486002)(6512007)(4326008)(66946007)(508600001)(76116006)(8676002)(66556008)(31696002)(122000001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk9hZ0ZNUjBOb05LQTJmbCttVWpEUXhtRitaaytRQkpla0Z2WVhvTlFQOS9l?=
 =?utf-8?B?akwvWHh5MzBJUGRUSXpzZVZDNmVQMHpBcmhxNjZuY2pNK3RRT1dvNEw4UGtZ?=
 =?utf-8?B?QnIxRUcwb2R0c1dYbHZCNG9paSsvUnFwQStNTEI4YlVJcHZYS2ZYdktWejVu?=
 =?utf-8?B?dzhZTnI3aXR6d21SUDRLRWhSY1NlMHRIUEI5NUR5ZXlpTlBZRDdTTWNJV3d0?=
 =?utf-8?B?OUN4OGowQmtXOVdsRC80bFpPbjczL0tTRHh5RUUrMGRDOGxoOGw2NTVVbVhn?=
 =?utf-8?B?bDF0d1dEejg5REJPUEtTYTFiL1k0SlgxQVEraHJta0llZEFjRzgwVUlZWFI0?=
 =?utf-8?B?azRQZWd1aVdncDI0SDFBSXV5SUtDUU9TM3BBRmtPNUtib0I4aU9mZzRGSmFq?=
 =?utf-8?B?bHZ0MDBrUWVWY0IvRExBOUg2N2FpZ0wxUDcyTjEwYkF6SDlSbEplamRBbDdZ?=
 =?utf-8?B?THhpQjV0SVljdVVxUit6WFJUSEIxRzgxZWNlUlc3WUhkZlUwTWFBYzEveFVM?=
 =?utf-8?B?RXlFR04yTVJCQ3NSTE1od3UveE9uZS9OUVdodzBoVmZFdUFGRzNIUThoaTZn?=
 =?utf-8?B?Tm9RUkVsWCtrRTVaWXRtNk9rOVMzSGd1b0hncmRhb0x4SlNUZnhrSjN3M2JY?=
 =?utf-8?B?eklFVlo1SlE0cTA0M0pMUDhhYkUrL2toU3VwTXUxQk1qZWRKU2pPa2pmWS84?=
 =?utf-8?B?anRZQm1zSXlraXNyd3h5ZGVGNGc4eEtBcUhqaURUVGJEOVY3OVVYNDByZVBK?=
 =?utf-8?B?Y1NLbmJocVdmYUMvT1JCNXJ2ZVdDcEcvNzlRamEwMHFFdEJtWmtValBzQjJM?=
 =?utf-8?B?ekRLQU8waDRMT0kwOTVTOHhDSzRKM1FjV2UxOGdBYkdrTUFJVWpkblE1TGdJ?=
 =?utf-8?B?Mzkzcld0WC9oWEtWU1lzNmpIQ3gxdURMWW9KZXR3MjJjcGJqM3ZwaFlUbEhY?=
 =?utf-8?B?aS9uY1IvQ3h6d3VpUisyT05NSmZVQkhoUkR6c3BIY3JnYnVaa2kyOUxtN3Js?=
 =?utf-8?B?Z1BXanFTNUd4bmdvRzVzbEpOQ2ZuWmZRL21LUmtNanBmaDRPVzcraWx5Yzg5?=
 =?utf-8?B?Rk5PY2dYWHNYUm41NWtaTWJQbjhscnRzd3ovSStlMFRKak1aZ0YxWFUxNHRk?=
 =?utf-8?B?ZnVtanA2UzE1OGc0blIrN2N4NVVSb3pRZzl0SUpPdVRaMVJuSUJKUXpRTGNa?=
 =?utf-8?B?TG80RkJ6RFdmUFRzMVh5TEw0VS9YNlFFN0NSOEkzQUVZQjIzWDkrdTJieHVL?=
 =?utf-8?B?MUZKODhjU1huWUJTZ1RienpWY0dkeko3ZjNJZWNFR3JOd1dJeU1rRXk3Mzdj?=
 =?utf-8?B?RlhrYUE3K0tFS2pUWUQ2MnJDeXk2ZTBzbmJlSkc3bnl6cFJPRFJtYmJPeEZP?=
 =?utf-8?B?ZWxmTWo5aDF1SmcrdlB1bGRTbHg2cTVENnhCNm9ld3I4cDEzeCtJVERRNzh4?=
 =?utf-8?B?NW5QaTlCZDBGOUdmeTF2TXltWSt6VzJoMGhtNHZlU0ZyUTliS1djU0NIYW0r?=
 =?utf-8?B?WkRXQllaai9MQ1F0ZUl3UzNaekp1Sm9semkwVU5Eam9QRUtnNEMya0dpWVFL?=
 =?utf-8?B?bmZNSVZHYm5FQ1ROeTY2K21BYk9vR2JGTmVDT3NpWEtXbFJsa2hrL1EvMU9h?=
 =?utf-8?B?RGlSb3ltNG5QV2h6bXpJdTUzSGJQbDlwUGMyNXBPd2lPS0VONk1wMnVZSDZ5?=
 =?utf-8?B?TDFUM2M2S2xUYThkRmZhcGs5dCtWUG5PSzAyMEVGZGZWck9QSTJHVFdnMzBZ?=
 =?utf-8?Q?XbP+QjWjl3veBGPDAU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4622BB518F9EEB4F9AECE1B6210C4D54@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5718ae8-1842-4ac2-711e-08d98fb0847a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 07:50:54.7924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRQXHgKnxDmFFy9cvlK83PIB1SPVFoIWnYXCursVX/xUZcDAPjQLMitucdCRBnR1NtB56udo7XjGtc1uTLpHJxf4eRyBYVC97COU/AxvmOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTAvNy8yMSAyOjEyIFBNLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4gQVRfWERNQUNfQ0Nf
UEVSSUQoKSBzaG91bGQgYmUgdXNlZCB0byBzZXR1cCBiaXRzIDI0Li4zMCBvZiBYRE1BQ19DQw0K
PiByZWdpc3Rlci4gVXNpbmcgaXQgd2l0aG91dCBwYXJlbnRoZXNpcyBhcm91bmQgMHg3ZiAmIChp
KSB3aWxsIGxlYWQgdG8NCj4gc2V0dGluZyBhbGwgdGhlIHRpbWUgemVybyBmb3IgYml0cyAyNC4u
MzAgb2YgWERNQUNfQ0MgYXMgdGhlIDw8IG9wZXJhdG9yDQo+IGhhcyBoaWdoZXIgcHJlY2VkZW5j
ZSBvdmVyIGJpdHdpc2UgJi4gVGh1cywgYWRkIHBhcmFudGhlc2lzIGFyb3VuZA0KPiAweDdmICYg
KGkpLg0KPiANCj4gRml4ZXM6IDE1YTAzODUwYWI4ZiAoImRtYWVuZ2luZTogYXRfeGRtYWM6IGZp
eCBtYWNybyB0eXBvIikNCj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRv
ci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2RtYS9hdF94ZG1h
Yy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvYXRfeGRtYWMuYyBiL2RyaXZlcnMv
ZG1hL2F0X3hkbWFjLmMNCj4gaW5kZXggYzY2YWQ1NzA2Y2I1Li5lMThhYmJkNTZmYjUgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZG1hL2F0X3hkbWFjLmMNCj4gKysrIGIvZHJpdmVycy9kbWEvYXRf
eGRtYWMuYw0KPiBAQCAtMTU1LDcgKzE1NSw3IEBADQo+ICAjZGVmaW5lCQlBVF9YRE1BQ19DQ19X
UklQCSgweDEgPDwgMjMpCS8qIFdyaXRlIGluIFByb2dyZXNzIChyZWFkIG9ubHkpICovDQo+ICAj
ZGVmaW5lCQkJQVRfWERNQUNfQ0NfV1JJUF9ET05FCQkoMHgwIDw8IDIzKQ0KPiAgI2RlZmluZQkJ
CUFUX1hETUFDX0NDX1dSSVBfSU5fUFJPR1JFU1MJKDB4MSA8PCAyMykNCj4gLSNkZWZpbmUJCUFU
X1hETUFDX0NDX1BFUklEKGkpCSgweDdmICYgKGkpIDw8IDI0KQkvKiBDaGFubmVsIFBlcmlwaGVy
YWwgSWRlbnRpZmllciAqLw0KPiArI2RlZmluZQkJQVRfWERNQUNfQ0NfUEVSSUQoaSkJKCgweDdm
ICYgKGkpKSA8PCAyNCkJLyogQ2hhbm5lbCBQZXJpcGhlcmFsIElkZW50aWZpZXIgKi8NCj4gICNk
ZWZpbmUgQVRfWERNQUNfQ0RTX01TUAkweDJDCS8qIENoYW5uZWwgRGF0YSBTdHJpZGUgTWVtb3J5
IFNldCBQYXR0ZXJuICovDQo+ICAjZGVmaW5lIEFUX1hETUFDX0NTVVMJCTB4MzAJLyogQ2hhbm5l
bCBTb3VyY2UgTWljcm9ibG9jayBTdHJpZGUgKi8NCj4gICNkZWZpbmUgQVRfWERNQUNfQ0RVUwkJ
MHgzNAkvKiBDaGFubmVsIERlc3RpbmF0aW9uIE1pY3JvYmxvY2sgU3RyaWRlICovDQo+IA0KDQo=
