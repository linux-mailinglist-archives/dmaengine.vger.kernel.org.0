Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E38E42EA82
	for <lists+dmaengine@lfdr.de>; Fri, 15 Oct 2021 09:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhJOHv1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Oct 2021 03:51:27 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:15789 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhJOHv0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Oct 2021 03:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634284160; x=1665820160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+dYNWnIHWfKJQ/6EW1okRuuyG73BWJ7M6EZxfjNd32M=;
  b=PKT2ft/Wh7ANfXlpo4uYD2UyfVVylg5EFUnsF2BGvn+Vt9taREFkeGGb
   30HLuL8pfzfjx044xOdXjdHAkfuhxe+8bMDsvrVV19LMQDoJuMzVzg4Ab
   hqmIsrnFGIck377oL4XUdtwXuH9f/ptztP/VDhWgCfDcMhzCKTTDkv0MG
   o9hW/OEJO8SSwC2zSaomwZYAgVRLBoyqrZWSz+QgiCmld+19o5doICOsC
   KnKlKSiUrG/TOuXL2IVB8212WQStgebQj087dDOOzbPFAAL70GounUu11
   7y0AttB6/icyn6O3FBoEVsde3L4Cf4xHy1StqnZU2b6V3dRkBQ8PzcsQ4
   Q==;
IronPort-SDR: VKdYJRtyUNKB6V0h5DhOnSGYMbEfA4JgVszJn/MqlExy/vR0UuqFw/GkmgIXLDXrZ/l8O+UDI8
 EJmXw9Mb3pvAEbnFnF8TyHe6ltDsKu4JM4gbVVG+Z1mbTuyjFwe2MHzvkAQPqWZ4hGWGU2Ee29
 pqzKsBzrakp79Hebvy0ZOpo5owRihePNjl6QXlJzt8hzFnTxw69Xto63gxnS+u2kg/Lkq0qizZ
 5/02zzbgcq3Q+n5IIGb3u0By431adv/ixjhfFFVlcxFcF2Ov0Dd9WfEp2OzKsA8LjzgdS8v8Cp
 Mq4a8J1nSvUsQSDMfNGhqDgt
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="148207526"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 00:49:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 00:49:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 15 Oct 2021 00:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWr1eRx3oLzxCTr2EqDLXwUr7NTEUebWC2hZKonfJPZsYls+R/DnR1/f7kzsags2/ZEaW0qtNs0sax3Xwb0wAT0SQmfrWNXZO0b1jxkQJCxDpHaI35GygHGa8GdYSFG2RX+zV7GMSD9luJHTvkp+WhWcfs7Jj1t2EegJ6RHOtL71WpwpyA8bogjg9vfhJMG5tzjuLFN4cB+igdeSRCmH6H/mOJ8Dx6Dwu+7FIXP+q2mxu8SA8ZhLu4TwrH9vibaQyrU9fk8jrxccTSBfGmk51uCThhpfnR9pnhfKj+wQNgh7lPR36kcNNkMlIQ9JYTyG7+UwI6u3m/mSaVw9ksqxpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dYNWnIHWfKJQ/6EW1okRuuyG73BWJ7M6EZxfjNd32M=;
 b=QMLfMxJDagXh2F6Kjgy3ZvYGERoYEwKA3AW5Qidw8Abdi+LxyvHtRmGPoZkzzxKj4mvyXC+V1BzUdHMoxcwcGquL2wq2Z5pD+Joo09g9IoZPYgaZCNlRMxtPH4pZn9tkRqf16Ac9xDOZv98L6Zn9YYivG77Rdd8oMEn+zF/rrXVYQXs3Xo1pGelGZzPF9U7sWSIs13kBpv/7R7ydzbVgCFTiLthIGlc8xF2FyaPOI7Za1dtZYjcbHcoFKE/x24C9ZbQ9grFJANj+ZQk0NZ/Pp36vBQr4XvADy3mq5aB9eB4Sr/jRBcNxJWAovW1inH9lkSlxg5c4lxVSOj6md2LCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dYNWnIHWfKJQ/6EW1okRuuyG73BWJ7M6EZxfjNd32M=;
 b=BuOaJpEZwsFSSVzZ5WGX30QY7FAcSs+eR/SxLRQ907qrCOc6s7omSAEquT15m/rcGJQyWsjI6fZAkZkJkUdYB1PVDbte2CXMF59D0AWTe8l/XZejXpWqHSvdQ51Pqu/bIaAbW/YdoGzMWkg4vpJ9zc5dlulYx+MhikMLBCrNhrk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2879.namprd11.prod.outlook.com (2603:10b6:805:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 07:49:17 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213%9]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 07:49:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] dmaengine: at_xdmac: call at_xdmac_axi_config() on
 resume path
Thread-Topic: [PATCH 1/4] dmaengine: at_xdmac: call at_xdmac_axi_config() on
 resume path
Thread-Index: AQHXwZknDGCXkUWACEKB64vCsYQmqg==
Date:   Fri, 15 Oct 2021 07:49:16 +0000
Message-ID: <2d6e2df6-93e0-311b-6a78-91b6a88bec18@microchip.com>
References: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
 <20211007111230.2331837-2-claudiu.beznea@microchip.com>
In-Reply-To: <20211007111230.2331837-2-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 622e6f3a-e997-416c-6d3e-08d98fb049f6
x-ms-traffictypediagnostic: SN6PR11MB2879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB28795299BEE0F7D064E825D3F0B99@SN6PR11MB2879.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Y1iQfVIOnb6ggh6ugVeDfW1h2x+KOyACAfYA/2JJJgenKn+nTlhNa9Vs3+exJIww3UrOdQnlgMZMlvh4rLnWh2GDU0r53IywAfePOPQ0ArFuDoBPHY/dtj7BIEvkNkOtBJVrA+BMtOsgYBlpi84lgOavgr2RxBa9lYBVihEfc7CfuBA3ErnBkdSBSFzZFTXdX6SgKITkAg3U0RS8M2gYJEckDxl2cH5Rgli8g4cJy5s19fcJbmRa1HnT1OENlTTDTaXBQPgep3T+nvbnck/m1OCd1wH/SOH6w26+CainiqiSTFLjrGBUsTStgsYRDKWRxeCSQv7T7s13zM5DUIMc5yBCkwhM5VeLNq5bnT/j5LoB7kJA1NapvD5vkYjbsmhG4o9OACkGqF0Jvi/GHzcCG+H5b0ThkXpQTJ1iDqnsHj2aeHaDDFBaj0aRYyjC94ZZxrOq6She5OO2apREUwhxOwsZfSoueocU0/UdFmYv2Iw3n5lJTtQkSL5WiH9Z22uEjZC3UIHjAtLeGcVPvI+TptabDXLx4V4UTY4Tcu+P23mPAMEHK/lbRjmmyh+ztvk4bDd5DhubCFLt53mn/KOXmjMZ4lbkjiTOuOMh+oPH5BjcIvlh4Yd4+BCmbPlgMwjLXHgl1Pzj4XZpTomszjKBh5c1aDOR6MSB8fUAs+kcXwbUM5Bx/xBEZ9kZzpl8XAXuee0uRPGdfPLYyaHv/JcfY4PFuy0Ne4cRDO4nl+0/ejZxgko73SE6ZkiJAAaGhgAcZ9cRRzbpPaDB6OQTLVmag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(8676002)(53546011)(76116006)(66476007)(86362001)(38100700002)(66946007)(91956017)(4326008)(71200400001)(6512007)(26005)(6506007)(31686004)(186003)(2906002)(122000001)(2616005)(38070700005)(64756008)(66446008)(6486002)(31696002)(54906003)(110136005)(36756003)(83380400001)(8936002)(316002)(5660300002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3hLWEZYMnFnMGEyMHpWeTcvVW5VYkQyZzllSUthVkJ5V0VnMFRwUXlRZFc5?=
 =?utf-8?B?MmlxdGZXN09RN2Y2M2t2WDBFZDlxMVltOW1JQ3JkTkRZTTE1cHlDWXFXM1Ey?=
 =?utf-8?B?UTBsV3AzWTBLR01qb2dnWDBqM0tRb0RLT2lNYlVRVDh4U3hUN081VHY3M1dZ?=
 =?utf-8?B?N1FEang2eDdBRXRmdVM4MHVUUXJoQVlsckU1YVpFVnNla2d4bGVpM05LWFo1?=
 =?utf-8?B?bHAwRmpDR3Z3emgxUVBGc2JhOE9SUllKQ0RWalBEV1pjVExvQ0FJZmhIUkl0?=
 =?utf-8?B?a0xHMUxBTGE2bmJ0eVFCZCszN0Myd2ZFQjFBYkNOZzRlelVLMEkvMktWSXd3?=
 =?utf-8?B?bVZORUtNcEVRbzNINW9GMlVZbUtiTy80WFJyOC9GSWx4MUE5K01qNFVLTXVo?=
 =?utf-8?B?QkJkV0pQZVNob3MzcWlWd0M0R29IRTdaMVB1eVUzL05kU0x5QldrRmdSZm92?=
 =?utf-8?B?aFR5dW16Y0ZRR21Zclg4SHNuenlHY3dLM2N6SWQ3UXRaK2xhTVp1TTlVc0Ux?=
 =?utf-8?B?Q2c3UHZ4bkxHbjZJd08zS0hIbWZDN3NPK2Z0UGkwRjA4Tk9XSEYyam92S3Fs?=
 =?utf-8?B?d0VIU0pzVWh4aUJQeDUzd0s3MEFjMGtmVTRPVDlGZHdveUo5REpCOXRvZTBt?=
 =?utf-8?B?VlE0cmx5MXVxN09odGttYVhSQzhpMEQ1bVgwWktMd3lpcXdTLzYrZGE2QTNy?=
 =?utf-8?B?NFQ2clJQaVByZUR6V0xZV3VKRUpvMHlTU01sUkNDQVpYOHMxaitxNkplQ0ho?=
 =?utf-8?B?SEhHa05STzNwZEplNFAwUXlkZ0pYa3JOSUoyTGUvejlIbm9jUktVN0VRSjFX?=
 =?utf-8?B?VkdXcmNMdjNtNGxzVlh2TkQ4VVB5OGpyQjdjVDUzQ004cmxYaERDaEpLZHpr?=
 =?utf-8?B?WEUwbXBLZzBLNFVGSFNybW85RFNrUDBjeXFhWkJmTnd3SUFDbW9uSmlSWnAw?=
 =?utf-8?B?d3JTQ3RFNTFYY2ZBNWptYVl0Z1VyckF2WHRTWDBabmlpRU1idmZBQmNWVy9i?=
 =?utf-8?B?RHBPWjNDU2MxNE0xNDNMYnVMYmY2eTFQNzR6Z0hReTRtbDRpdW9aWmtaS3hw?=
 =?utf-8?B?VUc5ODMvOFEvT2tic29GWmZ1ZUZuVmJhcnZ6T2dibjNSMUtQYzQyekhHRE9v?=
 =?utf-8?B?aUVMeE5BeWJVSyt5aDhWcVNqMHFYa0xYOHF0MEVsemQ1TmMvZk1ScVFaQzFS?=
 =?utf-8?B?U0tWWCtDS2JBN1RMTGYxUDFuY2piYllvWERzQWw1Q2hRM3dYQi9uU2c5cVgr?=
 =?utf-8?B?cks0Y05nclJ2R1JOejNkS29ZK1JYWXRpRUZNcGpOWHhrODh6MVZZR2hiejI4?=
 =?utf-8?B?RjFSWi8yRkZCQmpGejE3RGpkdkFRdXcrUHlYTjNtSi83M1RUVGJGeW5aaWZ4?=
 =?utf-8?B?TlZSRHhkM0RRZExFbENKdWRBYVVXK0MzRUdqM2l0a3hYR3VjZXFJbHBEc2tR?=
 =?utf-8?B?SERINjJhSG9aNWMyS1ZoMnlsTlpUblZOVEFNTmtGUUl1NkFZNVJrRkpxSldJ?=
 =?utf-8?B?Y2RibnpDWld6bFN1Sm5zQWxZdC9jOU1zU21DSTRPUUNXaW5rd3I0ZnVLK0RX?=
 =?utf-8?B?STR1c0JaRktMcFZpZHpnWTI0WitTL2dhSk9ZZWlWT0F3WDlabFJWK1JYM01j?=
 =?utf-8?B?cGpFNDNLUWl0U0x4eGxKYTRuUHIrVzBBb0dhYldvRXlwVWxGNHNBWUdTbWtQ?=
 =?utf-8?B?WmJWVTdBNE8wLytpcE9wQi9zMC9WbmRNa3FYdXd0cmlFYVBnVkc4cUtBVDNH?=
 =?utf-8?Q?uSZf7gM4NAXz4IZhmI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43334B608648FE45B8F9670079308E2D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622e6f3a-e997-416c-6d3e-08d98fb049f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 07:49:16.5995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txO2Ew1EaDiRAapeJ6wGvNYIEmsg7ibEUfVIwxCnAUEWl+R5U8KMZIJIHxXE1dhhaifS/RjrDXTycc6ASzArXK6TdYn2SvI9guPF4yrllQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2879
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTAvNy8yMSAyOjEyIFBNLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4gYXRfeGRtYWMgY291
bGQgYmUgdXNlZCBvbiBTb0NzIHdoaWNoIHN1cHBvcnRzIGJhY2t1cCBtb2RlICh3aGVyZSBtb3N0
DQo+IG9mIHRoZSBTb0MgcG93ZXIsIGluY2x1ZGluZyBwb3dlciB0byBETUEgY29udHJvbGxlciwg
aXMgY2xvc2VkIGF0IHN1c3BlbmQNCj4gdGltZSkuIFRodXMsIG9uIHJlc3VtZSwgdGhlIHNldHRp
bmdzIHdoaWNoIHdlcmUgcHJldmlvdXNseSBkb25lIG5lZWQgdG8gYmUNCj4gcmVzdG9yZWQuIERv
IHRoZSBzYW1lIGZvciBheGkgY29uZmlndXJhdGlvbi4NCj4gDQo+IEZpeGVzOiBmNDA1NjZmMjIw
YTEgKCJkbWFlbmdpbmU6IGF0X3hkbWFjOiBhZGQgQVhJIHByaW9yaXR5IHN1cHBvcnQgYW5kIHJl
Y29tbWVuZGVkIHNldHRpbmdzIikNCj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNs
YXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVz
IDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2RtYS9h
dF94ZG1hYy5jIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvYXRfeGRtYWMuYyBiL2RyaXZlcnMvZG1hL2F0
X3hkbWFjLmMNCj4gaW5kZXggYWI3OGUwZjZhZmQ3Li5jNjZhZDU3MDZjYjUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZG1hL2F0X3hkbWFjLmMNCj4gKysrIGIvZHJpdmVycy9kbWEvYXRfeGRtYWMu
Yw0KPiBAQCAtMTkyNiw2ICsxOTI2LDMwIEBAIHN0YXRpYyB2b2lkIGF0X3hkbWFjX2ZyZWVfY2hh
bl9yZXNvdXJjZXMoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0KPiAgCXJldHVybjsNCj4gIH0NCj4g
IA0KPiArc3RhdGljIHZvaWQgYXRfeGRtYWNfYXhpX2NvbmZpZyhzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiArew0KPiArCXN0cnVjdCBhdF94ZG1hYwkqYXR4ZG1hYyA9IChzdHJ1Y3Qg
YXRfeGRtYWMgKilwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gKwlib29sIGRldl9tMm0g
PSBmYWxzZTsNCj4gKwl1MzIgZG1hX3JlcXVlc3RzOw0KPiArDQo+ICsJaWYgKCFhdHhkbWFjLT5s
YXlvdXQtPmF4aV9jb25maWcpDQo+ICsJCXJldHVybjsgLyogTm90IHN1cHBvcnRlZCAqLw0KPiAr
DQo+ICsJaWYgKCFvZl9wcm9wZXJ0eV9yZWFkX3UzMihwZGV2LT5kZXYub2Zfbm9kZSwgImRtYS1y
ZXF1ZXN0cyIsDQo+ICsJCQkJICAmZG1hX3JlcXVlc3RzKSkgew0KPiArCQlkZXZfaW5mbygmcGRl
di0+ZGV2LCAiY29udHJvbGxlciBpbiBtZW0ybWVtIG1vZGUuXG4iKTsNCj4gKwkJZGV2X20ybSA9
IHRydWU7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKGRldl9tMm0pIHsNCj4gKwkJYXRfeGRtYWNfd3Jp
dGUoYXR4ZG1hYywgQVRfWERNQUNfR0NGRywgQVRfWERNQUNfR0NGR19NMk0pOw0KPiArCQlhdF94
ZG1hY193cml0ZShhdHhkbWFjLCBBVF9YRE1BQ19HV0FDLCBBVF9YRE1BQ19HV0FDX00yTSk7DQo+
ICsJfSBlbHNlIHsNCj4gKwkJYXRfeGRtYWNfd3JpdGUoYXR4ZG1hYywgQVRfWERNQUNfR0NGRywg
QVRfWERNQUNfR0NGR19QMk0pOw0KPiArCQlhdF94ZG1hY193cml0ZShhdHhkbWFjLCBBVF9YRE1B
Q19HV0FDLCBBVF9YRE1BQ19HV0FDX1AyTSk7DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICAjaWZkZWYg
Q09ORklHX1BNDQo+ICBzdGF0aWMgaW50IGF0bWVsX3hkbWFjX3ByZXBhcmUoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KPiAgew0KPiBAQCAtMTk3NSw2ICsxOTk5LDcgQEAgc3RhdGljIGludCBhdG1lbF94
ZG1hY19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCXN0cnVjdCBhdF94ZG1hYwkJKmF0
eGRtYWMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gIAlzdHJ1Y3QgYXRfeGRtYWNfY2hhbgkq
YXRjaGFuOw0KPiAgCXN0cnVjdCBkbWFfY2hhbgkJKmNoYW4sICpfY2hhbjsNCj4gKwlzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlCSpwZGV2ID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0IHBsYXRmb3Jt
X2RldmljZSwgZGV2KTsNCj4gIAlpbnQJCQlpOw0KPiAgCWludCByZXQ7DQo+ICANCj4gQEAgLTE5
ODIsNiArMjAwNyw4IEBAIHN0YXRpYyBpbnQgYXRtZWxfeGRtYWNfcmVzdW1lKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+ICsJYXRfeGRt
YWNfYXhpX2NvbmZpZyhwZGV2KTsNCj4gKw0KPiAgCS8qIENsZWFyIHBlbmRpbmcgaW50ZXJydXB0
cy4gKi8NCj4gIAlmb3IgKGkgPSAwOyBpIDwgYXR4ZG1hYy0+ZG1hLmNoYW5jbnQ7IGkrKykgew0K
PiAgCQlhdGNoYW4gPSAmYXR4ZG1hYy0+Y2hhbltpXTsNCj4gQEAgLTIwMDcsMzAgKzIwMzQsNiBA
QCBzdGF0aWMgaW50IGF0bWVsX3hkbWFjX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB9
DQo+ICAjZW5kaWYgLyogQ09ORklHX1BNX1NMRUVQICovDQo+ICANCj4gLXN0YXRpYyB2b2lkIGF0
X3hkbWFjX2F4aV9jb25maWcoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gLXsNCj4g
LQlzdHJ1Y3QgYXRfeGRtYWMJKmF0eGRtYWMgPSAoc3RydWN0IGF0X3hkbWFjICopcGxhdGZvcm1f
Z2V0X2RydmRhdGEocGRldik7DQo+IC0JYm9vbCBkZXZfbTJtID0gZmFsc2U7DQo+IC0JdTMyIGRt
YV9yZXF1ZXN0czsNCj4gLQ0KPiAtCWlmICghYXR4ZG1hYy0+bGF5b3V0LT5heGlfY29uZmlnKQ0K
PiAtCQlyZXR1cm47IC8qIE5vdCBzdXBwb3J0ZWQgKi8NCj4gLQ0KPiAtCWlmICghb2ZfcHJvcGVy
dHlfcmVhZF91MzIocGRldi0+ZGV2Lm9mX25vZGUsICJkbWEtcmVxdWVzdHMiLA0KPiAtCQkJCSAg
JmRtYV9yZXF1ZXN0cykpIHsNCj4gLQkJZGV2X2luZm8oJnBkZXYtPmRldiwgImNvbnRyb2xsZXIg
aW4gbWVtMm1lbSBtb2RlLlxuIik7DQo+IC0JCWRldl9tMm0gPSB0cnVlOw0KPiAtCX0NCj4gLQ0K
PiAtCWlmIChkZXZfbTJtKSB7DQo+IC0JCWF0X3hkbWFjX3dyaXRlKGF0eGRtYWMsIEFUX1hETUFD
X0dDRkcsIEFUX1hETUFDX0dDRkdfTTJNKTsNCj4gLQkJYXRfeGRtYWNfd3JpdGUoYXR4ZG1hYywg
QVRfWERNQUNfR1dBQywgQVRfWERNQUNfR1dBQ19NMk0pOw0KPiAtCX0gZWxzZSB7DQo+IC0JCWF0
X3hkbWFjX3dyaXRlKGF0eGRtYWMsIEFUX1hETUFDX0dDRkcsIEFUX1hETUFDX0dDRkdfUDJNKTsN
Cj4gLQkJYXRfeGRtYWNfd3JpdGUoYXR4ZG1hYywgQVRfWERNQUNfR1dBQywgQVRfWERNQUNfR1dB
Q19QMk0pOw0KPiAtCX0NCj4gLX0NCj4gLQ0KPiAgc3RhdGljIGludCBhdF94ZG1hY19wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBhdF94ZG1hYwkq
YXR4ZG1hYzsNCj4gDQoNCg==
