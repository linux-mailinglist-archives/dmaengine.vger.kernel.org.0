Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6127CD7AB
	for <lists+dmaengine@lfdr.de>; Wed, 18 Oct 2023 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjJRJQg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Oct 2023 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJRJQe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Oct 2023 05:16:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36C8106;
        Wed, 18 Oct 2023 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697620587; x=1729156587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eWrqEwkPbDxFN4okV293eczzm7byZiVRjRw5oAXAmRk=;
  b=ewwyeW0woRSNV4185Vj9TdgjJtZqlMeHIMcmGLMZzGs7vVOEZkqettYG
   dxWL/HMLR8bGg48IAQF86ge5Dm7twHo4wNO383HHKuIUHyUJMrfHMUR46
   XisFGB7UGrtDX3lnrPpIaxyRyRpV3kGvYwQOPItrB5WLnM+oXUOd97WV4
   k+dj0aCiG5X7A8zkfvOnegxVkR3z5D/KgB1bFMgceCP7CF63W8/cPLxVl
   45WMrk93wd9azxWXDg33g57IoVWZuw3+tVKme9qS3QLrEIIY7MYu9fKWY
   T7zqPNncicW9emGzpdn094HnQPpMul1sXnROJUd3pcRwXM485OXHb0F4l
   A==;
X-CSE-ConnectionGUID: Bs8xqLmiSAeyZGycmmzgIQ==
X-CSE-MsgGUID: izYO0DQkRkO6bV3V94PiLA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="10174152"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Oct 2023 02:16:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 18 Oct 2023 02:16:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 18 Oct 2023 02:16:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUuTur+Mst83o9XcZDkyWPqhNH8pdJT1nNUCiCyyyVDbljZ9gcz1bQ2PyhXZaZbnJMmTf31HEZvBqRawIQxQdlDtPTN35K2mtdgssDZ2aiOv+9iTxaIixNsHOX85ve+/sHhwN3KmBTvgqV2k9GOmsZKUS3HG2svqArhewOqd1UNjfUnVMa7Lej0s2pUfoQkaKRMqv0pzEr21A8zt0b+fJJ6mIZutCBzbGozRrLMRrGsCk8SDJ3NTS5zyz75DJ6d1Nk2phTuuxNPH14s2q5PdD+nzHiUDyEsP8LibDyGs0YCgAnrnmPtSZWOxb3tLe0iisircombxampaVy6R8QFW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWrqEwkPbDxFN4okV293eczzm7byZiVRjRw5oAXAmRk=;
 b=Drf8Ra6fHhbB9NqxSH3qox6I2k3CLjKfrMONc5f4ETrtw7bWwFr5WUuS0IUKvkH8XZRXKXWbmuJka6vtbvC/ouYqaC6RT7cI1t33y/6YBpnaieiPao1LmnAfjvjl2HJYHOYFHZubhEFxz8CJZigoNSGqntECa5PGpvJuoh13tC41GwnX1zllzufFGBH/5yIZMzj42rB31fplco7mXzyhFdS+jD1vYZDZZvn2dU1R3+uhOT0kqtnR6CLoleWX9UVq8sOLFhwGklqVlxAIG4YkhTpbtbT0AeS87rKMA4IdaF/wFO8fBE8mY++8WOmLCGSZijlW5UM5ezEIdvUlAycF6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWrqEwkPbDxFN4okV293eczzm7byZiVRjRw5oAXAmRk=;
 b=QqaDuC1rUoNew1pDK4opV/T6F3iFRDbhT4WQqGv8TlVSJyE/9B4f5iKEWkTEbKV3iLzZE/kZlPFZivRfpNHMJtRuUzI5G19ZIAqgIHdMuAhKdPkcTZ+y0n1tTblHV3MZSypbVf6C+S6z8NkzYh6r3CkzAHfloo6ATmUqvODM3gQ=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 09:16:11 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::7e31:26a6:698d:8846]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::7e31:26a6:698d:8846%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 09:16:11 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <samuel.holland@sifive.com>, <green.wan@sifive.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Nagasuresh.Relli@microchip.com>, <Praveen.Kumar@microchip.com>
Subject: RE: [PATCH v2 1/4] dmaengine: sf-pdma: Support
 of_dma_controller_register()
Thread-Topic: [PATCH v2 1/4] dmaengine: sf-pdma: Support
 of_dma_controller_register()
Thread-Index: AQHZ9bEK4k81E6qr/EinIsu+tf8oRbBOZXSAgACloHA=
Date:   Wed, 18 Oct 2023 09:16:10 +0000
Message-ID: <PH0PR11MB5611B16C380A9F1F989737CE81D5A@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20231003042215.142678-1-shravan.chippa@microchip.com>
 <20231003042215.142678-2-shravan.chippa@microchip.com>
 <e5d2e96b-9b16-4aaf-9291-76d1d2222c44@sifive.com>
In-Reply-To: <e5d2e96b-9b16-4aaf-9291-76d1d2222c44@sifive.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|SA3PR11MB7581:EE_
x-ms-office365-filtering-correlation-id: b28703c8-a355-4a2e-5724-08dbcfbade69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pd/tCDGbH2TcNP5ebRyU42iVRHueXbBcqAsCYSai9ukyjT/DaWjg2uQNEu1eVw4k+EUhn7gqHcYG7uQI9+Kkjz85Ntf156TSFkp9EcjBfN1tpe5ahigPpkopeiIt6q3i8NjtP03i3Oea+5DkK0p1EYeK4BrUEp9u4BGYCbjRo5/JO5AmIRcOnAujxqRJyhvR2efpo3Evq0naA3iG6KK1WI+jNczG+Qh4RktjLJfJU9SWg9hDe1lQ3GIwoKrtFCvORqpm09gBIBkrdVDGz2NDOuR31virWqAcq3pvqt1fPbaYnKCoKmZxC0rr60ckwmvUqFq08FVGFl+LfCQbn8yoH86Gj7XCZrn4lOPbyPvm1FHrkWHlcjjtxUVe8rg4Ml5LeW38orRuB9i0S4bqwYT7V++8QEBNPV8IXLf+4rpTs9DXR26ajsHl/2kkYNm17Bwl8znFZlgWqirqt0whHDW6dgWctq4kV4BNRUoKRdl31Bbzb9XRPjEK/QXSDcSeDaekOl6SzjJiPR8zofuZcPtQ5pTyVJsCqM5EbVJ/vEGmTvTn8lNia3WDICTnZoh5/p9zJ0EheFIc3I69NNQE/GYgmalKvqvOcWro65+mvdge337l78JPzagQWpNPR1Vr9xbl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(64756008)(5660300002)(76116006)(316002)(66556008)(54906003)(110136005)(66446008)(66476007)(66946007)(478600001)(8676002)(8936002)(55016003)(966005)(4326008)(38070700005)(38100700002)(83380400001)(52536014)(7416002)(86362001)(107886003)(33656002)(122000001)(41300700001)(9686003)(71200400001)(53546011)(2906002)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU55dUtydDFhNlVJWHhNc1UyQVB2YW1BT0pNZlE1M0lJSWtsMStyY0ZvZ2FU?=
 =?utf-8?B?UjVzRWlwSVEvUnNDNXJvZTdQa3NEWWhMMURsUmQwampQZzl2WFd6djQxRU5v?=
 =?utf-8?B?UnZRZnpLZW5nN0k2V2xCb3hmMmpNSURrSkV1dlYzdWZvNmtVQWJHZnNZU0gz?=
 =?utf-8?B?WnNHbDlvMG4rb2V2UWtBMERKRkRUczN4am41cjYwZENLbTJGOEFEeEh6eWNu?=
 =?utf-8?B?YzZPWjlXMEJ2UVJHMUFmY1IwaDUybW55aUVtc1REazRkdjFYSUdBYUJXZDJK?=
 =?utf-8?B?NkZMRW1oQ0tNOFBhd0d4dDBqWENYZXZtbXROelNNdDRSRjN6Y0pCYmcyMnJU?=
 =?utf-8?B?di9Zb245QmxMQnJtZFRZbjBIWTdUc1BhYUREMGJ2NDFyMVJXNDdjVlJHM3VN?=
 =?utf-8?B?cTFtdkE5MS9uUWhZbG5nTWdTZHh4aEgzekplT2hMRmhENnZHSE5oYzhSdmw4?=
 =?utf-8?B?ektRMmFoVURPWGNTWXRoNE92TExEa0JoQ3l2VVF3WXJndVN1THllTzI5VDNn?=
 =?utf-8?B?bEpIYUV4aTlGZFdGRDZJUGh4TVdzcFhwS3JTWWJ6MWI4cHVwTFBqdkVZNGkx?=
 =?utf-8?B?aHdCT1hObFZnL1NZcWREZXhUVTVBT2RobGNjbmdyY2lPczBuRG1LTUdrT0NZ?=
 =?utf-8?B?Ri9Ib0tqTGRuVnpHMFV1bTVETDB3aW1oVkRlSzJiM1hxU0JlYzdrbC9uWmpL?=
 =?utf-8?B?UTRmZ0RJaUpwWncxR2pzRG9PL2k0Qk9wdERLd2sxNGFxWmtQNWRCc2dzWUpJ?=
 =?utf-8?B?RGFnSTI3WVErWjhPOGh4MXZxNTI1eEc0Vm9hQTQzZUplK1V6K0hSS1FUbm8v?=
 =?utf-8?B?d3lvbDc4bzk2aTM2a2RXeDB6V0NnKzFTTEh1S1Zid3RwdG44emxSMmhHVkt2?=
 =?utf-8?B?REFnVW1WV3BTcWlBOHVKNzQ0akE2Q0tueTQrbHBVYzYwcGdJTGtWU2I1ZUZS?=
 =?utf-8?B?aTFKeHVPdUZ6NU9vRzdrVXRLSThaTmpEQmJ6eGFzU3pmK1V6Q2NEb2VzMGlF?=
 =?utf-8?B?U0tuZEtKWWswcU9ocE9JUmZNUFRwWUt5UFA3SEd2U0UxSmxBd2lBc3FQTHpM?=
 =?utf-8?B?RUZrenM2M28xNzJ6cDVPWEVaY1hHQytkQWZaOTcyaG0xbkdKdW4wZjJadkJ0?=
 =?utf-8?B?VjdaT1JtVDlzNUZuMkN0RlpRdWVmaGN1SnFzaTQvcjRESzJlTDZsS3M0YmxZ?=
 =?utf-8?B?OEFDM2g5SXh3K1BvTGVSemswNjVzdkVSN0xRcEFTWVlhT2VVVUJOZFV1THBn?=
 =?utf-8?B?LzRVMXBLSWZJUmI5Wk5qWEdwc2FDOHNyb0dWTldRYnVPdTZXTFd1SFFpL200?=
 =?utf-8?B?RTNGSHhzQzZDT1dnK1J2SkJyTkFOV2NPVFNSOEVjZERKR044TXY0T3cyMHVF?=
 =?utf-8?B?amJaM0Z0UDZKd2h2WWRLNlRUZmM3YXRsT0dIS2drcDlYN1lKQ3JnTWRWWndo?=
 =?utf-8?B?bkpJOU0wSXl2T3J5bXdFNnY0eE1mMHVNeGdxeTZmbFZjZHhwQk5xWHlrSTRT?=
 =?utf-8?B?SjJ4UVR1dThSdldSZ2JOQ1NtTERBbitMUXJiTkMwR1IzSks3WVpDYzEza1Bt?=
 =?utf-8?B?N3FjU24vdCtubzNoajU0aVMvSGJRWXQ3RGFuZmJSZ3ZXYXJMR0t6Z0RwQ2V2?=
 =?utf-8?B?TTVxMFRFYjY5NHp5aTYxUlg1R0JBUVNDdS9FZ0JXVUp1NUZnMjFqUmh6Rldw?=
 =?utf-8?B?RytzbmQweTBnRTJ1VTBXd3VQRXBPTE9Bb3FIZDExR2tvSWpORVBJczVLRXV1?=
 =?utf-8?B?ckM3RHdnNWZKTXZmZHp5Zlk4V2FhVzdMeFYwWFJEZTI0b0w4WVFCWmVXNWJh?=
 =?utf-8?B?VXlta1N2SDMxREE4Q2IzUWVRRWtrU05JQnhwSVlKYXB6MTZiZjV3MVo1WnFS?=
 =?utf-8?B?K0VDWVkvVE0yK3QxcVlYWXZhM2w2UlpySkVFS1V0MExIaDRLVVppa1Y3aHA5?=
 =?utf-8?B?dm1JbTlBSk5SNHBMR2p4bFkwM1lLNnY1SjBUZWdrMnd1TE9BSjM3Ny9GSkQ4?=
 =?utf-8?B?VzVPOGJLYXYwbGExUEo5SWx4dHA1dWZFMEFwWnNJYWQrQjFGTFdsV2ovc0gy?=
 =?utf-8?B?NE1janU4OGhoUWlQeHE0bGYrZGN6bjk4WXZDeVZxdnVPR2tKcDNwM0psdU5L?=
 =?utf-8?Q?ONk4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28703c8-a355-4a2e-5724-08dbcfbade69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 09:16:10.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ale4PWfSX3JBhgFZMwJ7n9VZvRf7pDfOXabUDsTv82ZjFWJaM3W9Oh8T/sS5WeTt0rVAAOuIFtLlNW7k3Gj7fxzx3+sAExdE2ZCdQVC7Q+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FtdWVsIEhvbGxh
bmQgPHNhbXVlbC5ob2xsYW5kQHNpZml2ZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2Jl
ciAxOCwgMjAyMyAxMjowMyBBTQ0KPiBUbzogc2hyYXZhbiBDaGlwcGEgLSBJMzUwODggPFNocmF2
YW4uQ2hpcHBhQG1pY3JvY2hpcC5jb20+Ow0KPiBncmVlbi53YW5Ac2lmaXZlLmNvbTsgdmtvdWxA
a2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0
QGxpbmFyby5vcmc7IHBhbG1lckBkYWJiZWx0LmNvbTsNCj4gcGF1bC53YWxtc2xleUBzaWZpdmUu
Y29tOyBjb25vcitkdEBrZXJuZWwub3JnDQo+IENjOiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3Jn
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHJpc2N2QGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE5hZ2FzdXJlc2ggUmVsbGkg
LQ0KPiBJNjcyMDggPE5hZ2FzdXJlc2guUmVsbGlAbWljcm9jaGlwLmNvbT47IFByYXZlZW4gS3Vt
YXIgLSBJMzA3MTgNCj4gPFByYXZlZW4uS3VtYXJAbWljcm9jaGlwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAxLzRdIGRtYWVuZ2luZTogc2YtcGRtYTogU3VwcG9ydA0KPiBvZl9kbWFf
Y29udHJvbGxlcl9yZWdpc3RlcigpDQo+IA0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBm
cm9tIHNhbXVlbC5ob2xsYW5kQHNpZml2ZS5jb20uIExlYXJuIHdoeSB0aGlzIGlzDQo+IGltcG9y
dGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0K
PiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUNCj4gY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSwNCj4g
DQo+IE9uIDIwMjMtMTAtMDIgMTE6MjIgUE0sIHNocmF2YW4gY2hpcHBhIHdyb3RlOg0KPiA+IEZy
b206IFNocmF2YW4gQ2hpcHBhIDxzaHJhdmFuLmNoaXBwYUBtaWNyb2NoaXAuY29tPg0KPiA+DQo+
ID4gVXBkYXRlIHNmLXBkbWEgZHJpdmVyIHRvIGFkb3B0IGdlbmVyaWMgRE1BIGRldmljZSB0cmVl
IGJpbmRpbmdzLg0KPiA+IEl0IGNhbGxzIG9mX2RtYV9jb250cm9sbGVyX3JlZ2lzdGVyKCkgd2l0
aCBzZi1wZG1hIHNwZWNpZmljDQo+ID4gb2ZfZG1hX3hsYXRlIHRvIGdldCB0aGUgZ2VuZXJpYyBE
TUEgZGV2aWNlIHRyZWUgaGVscGVyIHN1cHBvcnQgYW5kIHRoZQ0KPiA+IERNQSBjbGllbnRzIGNh
biBsb29rIHVwIHRoZSBzZi1wZG1hIGNvbnRyb2xsZXIgdXNpbmcgc3RhbmRhcmQgQVBJcy4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNocmF2YW4gQ2hpcHBhIDxzaHJhdmFuLmNoaXBwYUBtaWNy
b2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2RtYS9zZi1wZG1hL3NmLXBkbWEuYyB8
IDQ0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2RtYS9zZi1wZG1hL3NmLXBkbWEuYw0KPiA+IGIvZHJpdmVycy9kbWEvc2YtcGRtYS9zZi1wZG1h
LmMgaW5kZXggZDFjNjk1NmFmNDUyLi4wNmEwOTEyYTEyYTENCj4gPiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2RtYS9zZi1wZG1hL3NmLXBkbWEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZG1hL3Nm
LXBkbWEvc2YtcGRtYS5jDQo+ID4gQEAgLTIwLDYgKzIwLDcgQEANCj4gPiAgI2luY2x1ZGUgPGxp
bnV4L21vZF9kZXZpY2V0YWJsZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcu
aD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9k
bWEuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSAi
c2YtcGRtYS5oIg0KPiA+IEBAIC00OTAsNiArNDkxLDMzIEBAIHN0YXRpYyB2b2lkIHNmX3BkbWFf
c2V0dXBfY2hhbnMoc3RydWN0IHNmX3BkbWENCj4gKnBkbWEpDQo+ID4gICAgICAgfQ0KPiA+ICB9
DQo+ID4NCj4gPiArc3RhdGljIHN0cnVjdCBkbWFfY2hhbiAqc2ZfcGRtYV9vZl94bGF0ZShzdHJ1
Y3Qgb2ZfcGhhbmRsZV9hcmdzDQo+ICpkbWFfc3BlYywNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgb2ZfZG1hICpvZmRtYSkgew0KPiA+ICsgICAgIHN0
cnVjdCBzZl9wZG1hICpwZG1hID0gb2ZkbWEtPm9mX2RtYV9kYXRhOw0KPiA+ICsgICAgIHN0cnVj
dCBkZXZpY2UgKmRldiA9IHBkbWEtPmRtYV9kZXYuZGV2Ow0KPiA+ICsgICAgIHN0cnVjdCBzZl9w
ZG1hX2NoYW4gICpjaGFuOw0KPiA+ICsgICAgIHN0cnVjdCBkbWFfY2hhbiAqYzsNCj4gPiArICAg
ICB1MzIgY2hhbm5lbF9pZDsNCj4gPiArDQo+ID4gKyAgICAgaWYgKGRtYV9zcGVjLT5hcmdzX2Nv
dW50ICE9IDEpIHsNCj4gPiArICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiQmFkIG51bWJlciBv
ZiBjZWxsc1xuIik7DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiArICAgICB9
DQo+ID4gKw0KPiA+ICsgICAgIGNoYW5uZWxfaWQgPSBkbWFfc3BlYy0+YXJnc1swXTsNCj4gPiAr
DQo+ID4gKyAgICAgY2hhbiA9ICZwZG1hLT5jaGFuc1tjaGFubmVsX2lkXTsNCj4gPiArDQo+ID4g
KyAgICAgYyA9IGRtYV9nZXRfc2xhdmVfY2hhbm5lbCgmY2hhbi0+dmNoYW4uY2hhbik7DQo+IA0K
PiBUaGlzIGRvZXMgbm90IGxvb2sgcmlnaHQgdG8gbWUuIEFsbCBvZiB0aGUgY2hhbm5lbHMgaW4g
dGhlIGNvbnRyb2xsZXIgYXJlIGlkZW50aWNhbA0KPiBhbmQgc3VwcG9ydCBhcmJpdHJhcnkgYWRk
cmVzc2VzLCBzbyB0aGVyZSBpcyBubyBuZWVkIHRvIHVzZSBhIHNwZWNpZmljIHBoeXNpY2FsDQo+
IGNoYW5uZWwuIEFuZCB1bmxlc3MgTWljcm9jaGlwIGhhcyBhZGRlZCBzb21ldGhpbmcgb24gdG9w
LCB0aGUgb25seSB3YXkgdG8NCj4gdHJpZ2dlciBhIHRyYW5zZmVyIGlzIHRocm91Z2ggdGhlIE1N
SU8gaW50ZXJmYWNlLCBzbyB0aGVyZSBpcyBubyByZXF1ZXN0IElEIHRvDQo+IGRpZmZlcmVudGlh
dGUgdmlydHVhbCBjaGFubmVscyBlaXRoZXIuDQo+IA0KPiBTbyBpdCBzZWVtcyB0byBtZSB0aGF0
ICNkbWEtY2VsbHMgc2hvdWxkIHJlYWxseSBiZSAwLCBhbmQgdGhpcyBmdW5jdGlvbiBzaG91bGQN
Cj4ganVzdCBjYWxsIGRtYV9nZXRfYW55X3NsYXZlX2NoYW5uZWwoKS4NCj4gDQoNClRoYW5rcyBm
b3IgeW91ciBjb21tZW50LCB5ZXMgYWxsIHRoZSBjaGFubmVscyBhcmUgaWRlbnRpY2FsLg0KDQpJ
IGhhdmUgdGVzdGVkIHdpdGggZG1hX2dldF9hbnlfc2xhdmVfY2hhbm5lbCgpDQppdCBpcyBub3Qg
d29ya2luZy4NCg0KZG1hX2dldF9hbnlfc2xhdmVfY2hhbm5lbCgpIGZ1bmN0aW9uIHNlYXJjaGlu
ZyBmb3IgdGhlIERNQSBjaGFubmVsIHdoaWNoIGhhcyAiRE1BX1NMQVZFIiBjYXBhYmlsaXRpZXMu
DQpCdXQgc2YtcGRtYSBoYXMgb25seSAiRE1BX01FTUNQWSIgY2FwYWJpbGl0aWVzLiANCg0KKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioNCnN0cnVjdCBkbWFfY2hhbiAqZG1hX2dldF9hbnlf
c2xhdmVfY2hhbm5lbChzdHJ1Y3QgZG1hX2RldmljZSAqZGV2aWNlKQ0Kew0KICAgICAgICBkbWFf
Y2FwX3plcm8obWFzayk7DQogICAgICAgIGRtYV9jYXBfc2V0KERNQV9TTEFWRSwgbWFzayk7DQog
ICAgICAgIGNoYW4gPSBmaW5kX2NhbmRpZGF0ZShkZXZpY2UsICZtYXNrLCBOVUxMLCBOVUxMKTsN
Cn0NCioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KDQpTbyAiZG1hX3JlcXVlc3RfY2hh
bigpIiBmdW5jdGlvbiB0aHJvd3MgYW4gZXJyb3IgbGlrZSAic2YtcGRtYSAzMDAwMDAwLmRtYS1j
b250cm9sbGVyOiBObyBtb3JlIGNoYW5uZWxzIGF2YWlsYWJsZSINCg0KDQpUaGFua3MsDQpTaHJh
dmFuLg0KDQo+IFJlZ2FyZHMsDQo+IFNhbXVlbA0KPiANCj4gPiArICAgICBpZiAoIWMpIHsNCj4g
PiArICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiTm8gbW9yZSBjaGFubmVscyBhdmFpbGFibGVc
biIpOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+ID4gKyAgICAgfQ0KPiA+ICsN
Cj4gPiArICAgICByZXR1cm4gYzsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBzZl9w
ZG1hX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpICB7DQo+ID4gICAgICAgc3Ry
dWN0IHNmX3BkbWEgKnBkbWE7DQo+ID4gQEAgLTU2Myw3ICs1OTEsMjAgQEAgc3RhdGljIGludCBz
Zl9wZG1hX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4gICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsgICAgIHJldCA9IG9m
X2RtYV9jb250cm9sbGVyX3JlZ2lzdGVyKHBkZXYtPmRldi5vZl9ub2RlLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNmX3BkbWFfb2ZfeGxhdGUsIHBkbWEpOw0K
PiA+ICsgICAgIGlmIChyZXQgPCAwKSB7DQo+ID4gKyAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2
LT5kZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICJDYW4ndCByZWdpc3RlciBTaUZpdmUg
UGxhdGZvcm0gT0ZfRE1BLiAoJWQpXG4iLCByZXQpOw0KPiA+ICsgICAgICAgICAgICAgZ290byBl
cnJfdW5yZWdpc3RlcjsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICAgICAgIHJldHVybiAwOw0K
PiA+ICsNCj4gPiArZXJyX3VucmVnaXN0ZXI6DQo+ID4gKyAgICAgZG1hX2FzeW5jX2RldmljZV91
bnJlZ2lzdGVyKCZwZG1hLT5kbWFfZGV2KTsNCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIHJldDsN
Cj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgc2ZfcGRtYV9yZW1vdmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikgQEAgLTU4Myw2DQo+ID4gKzYyNCw5IEBAIHN0YXRpYyBpbnQgc2Zf
cGRtYV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgICAgICAgICAg
ICAgIHRhc2tsZXRfa2lsbCgmY2gtPmVycl90YXNrbGV0KTsNCj4gPiAgICAgICB9DQo+ID4NCj4g
PiArICAgICBpZiAocGRldi0+ZGV2Lm9mX25vZGUpDQo+ID4gKyAgICAgICAgICAgICBvZl9kbWFf
Y29udHJvbGxlcl9mcmVlKHBkZXYtPmRldi5vZl9ub2RlKTsNCj4gPiArDQo+ID4gICAgICAgZG1h
X2FzeW5jX2RldmljZV91bnJlZ2lzdGVyKCZwZG1hLT5kbWFfZGV2KTsNCj4gPg0KPiA+ICAgICAg
IHJldHVybiAwOw0KDQo=
