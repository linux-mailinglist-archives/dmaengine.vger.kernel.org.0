Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07985713A5
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jul 2022 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiGLH4y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jul 2022 03:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiGLH4r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jul 2022 03:56:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520509C255;
        Tue, 12 Jul 2022 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657612605; x=1689148605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cw2JqLbehBKQZ3CgbizdhsM4ibUhsUBTBjRDdSrjgcE=;
  b=2YUSz7ess7pxG+QSyL4LNcDbTYBjJeb/SkiPNi/4ZzaRwo+008xkT+qp
   lhjfcP2Iw1rshcR3KEcsJdMalaxFuq3Hqiyvk8ZrulZDIgkZsi0tz3C0u
   aOEz985GMCLB7y2qoSkN3WDSx4l1GuraK1PFok/4mtia/RDZe6DZ+gYqR
   pbZirSctJT3oKJVE1VS43KX/ClA6JrZbtZKVcnLVR0mC5bwCy9PCjNtph
   KZ4KDdh8blygSyp9CwIcnswz95Zx3oVlBpDek5GWxvgnhTOBMcFoRCnPf
   O9Q7I4DzWeNj6MDV5ky4uDgNSoH6p9Mhi2dIkJZv/NMxLOynS4Zp2sCoN
   A==;
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="167416887"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2022 00:56:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Jul 2022 00:56:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 12 Jul 2022 00:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z10hxPYJ+oWnILw4+6jxxwMsokdRrhY/XgkSDpIgDFGzN/2NKSNfI/NtsElY5dpV/cplRfuiYew4/N5li0w7x3lxi3deYeCLUQgYEDIIHonnL60LsreQx+EV5KdA2ypbVWPwDqka8zA8Uoo2bomkIGbKyCp0e74ACZrco4IR0krFY3BjnzMLqjTAT2sQ2o3BpHjRJ+cdxu/0WHcMmj18ZX2pGQIBRKGAw6redw3/TGh7IqL2Jv/bHNznOOFYnNCBDqneYHN5av6NVXmJTGZ/UI66m3W+ErGNfXEzZZ1QK+bf3KT/bDAglvryvw5KrCdUHkz/pEfwBLx2l3JwDvngvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw2JqLbehBKQZ3CgbizdhsM4ibUhsUBTBjRDdSrjgcE=;
 b=NGGg4UPPuM8uWtoKkJCB4grSjcvnrTDfTfgRjAtmhjrkoJ5/eYlHdMBGjGP3I5//Lb5/W8bk70VrTSovoht17WRYgvd5CRG1vTlgKISg+U8HbHmdObNAFwAxlqgtsnhNhc30Z8lwRpW/7ktUDxxIj9G3I31Yky23YK9S5QqSsgS4VjnDsKeEs3MTGRMMA/JaJHVDzDsCVUr3K2FzPKQc8CKNPV5bGA6F6Vt4qlBW1YtmL+4kuS+tsYSd7A9Pu9Whr34FLqs+bJYU47LsKVNq2vOI6dbYR3uk2A0yF62WQiGmFo9mrguBAmb6hcrAg2Su0ZbgIyZDxA10uxzrNV9CHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw2JqLbehBKQZ3CgbizdhsM4ibUhsUBTBjRDdSrjgcE=;
 b=ARubUkL0hEsVlC5Us2RDsW8+UbZnLEatMnsvV3AWpdXNza4gA25OlF4IznCvd3AtVtrBial702UWzXBrlGB4WOeXuhLpUq12RJiHzwHIBGmE7bqsB3205IGy3LOgACt5v7IBvPvd9dlVVqHhaSGEJj7UQ0OAKISyk/DlI4b9Uq4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1652.namprd11.prod.outlook.com (2603:10b6:405:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 07:56:30 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 07:56:29 +0000
From:   <Conor.Dooley@microchip.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <thierry.reding@gmail.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <masahiroy@kernel.org>, <palmer@dabbelt.com>,
        <fancer.lancer@gmail.com>, <sam@ravnborg.org>,
        <palmer@rivosinc.com>, <vkoul@kernel.org>,
        <daniel.lezcano@linaro.org>, <mail@conchuod.ie>,
        <Eugeniy.Paltsev@synopsys.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <niklas.cassel@wdc.com>,
        <dillon.minfei@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <robh@kernel.org>
Subject: Re: [PATCH v5 02/13] dt-bindings: display: ili9341: document canaan
 kd233's lcd
Thread-Topic: [PATCH v5 02/13] dt-bindings: display: ili9341: document canaan
 kd233's lcd
Thread-Index: AQHYkLmcGD25Du2KgkO9uXqnRhnbjK16aGKA
Date:   Tue, 12 Jul 2022 07:56:29 +0000
Message-ID: <2b265d13-fe69-9f5a-e3fa-7bfdf4ca6d95@microchip.com>
References: <20220705215213.1802496-1-mail@conchuod.ie>
 <20220705215213.1802496-3-mail@conchuod.ie>
In-Reply-To: <20220705215213.1802496-3-mail@conchuod.ie>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b6a8c72-9b6b-4c29-378a-08da63dc0748
x-ms-traffictypediagnostic: BN6PR11MB1652:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGEUFRl1JrEvr1K5KfCfsBgabzxWph4MPbYLy4bQyFzy/bZVHc4Dh/fjDB04NbKKR5cXZRTy7Kcr4Y3wJ6HkwrIvVvK9NgGyotLTMP9C737NOAiQUyNi5RaemdmggmJt2eTDzGNSq8SkDeNREDVnd0jLWPEorfSBJxq6KqJ1QnrG4DPHToOiImSqAiJzMbc7KxDDyc5VfiP2lp3yxU3YrDIrSLw3lERX59tMBFaVSGg3vZSIB5m0K+1Jt5BGf7EZgpl2npUuJFiBfO6kDJ71irEKOWzyTi02xkRV8M3LIS9xhCsmiJkv5l2DHgheYzGZ2fpJ1HnD/Ldz9VZ+x159w1RIlBvWpdySPK+qOcL4nO9GO+bbFFc0VNRuNnOmiwBSZZhqsa0r4w+XS4u8TgvlWcEnLPdetxFLjArAFlN5unhBmoS/YZQw4vpHBPwF3MkWsB049tAdm/6fPqFm//UFHVFV/uuJnB96NIRC3L+cZ+5gnCsoxErDgx7Ds1geD4SNQV5pdSwtlvLOoK5nlydCuxB4WIcP7NXxKhHPDNlv8HgM0KDUI3zpAUfzeMZob/DbivwKd7ODVSKCSUPYxjJfeaAexJKqW8bWimG0TdLKSjzKDwsi52/vOmXQ15fSPbukR8tVQwlTlTavFD1j4UDFD9zIpwqUBF61E7IQxM9zN3WgqL4GKYP+sY0wgAekaG9qwXLdhDkl8jkhvCwexncAfLAkEDZDwHYYZw+yrXcp6F6Z79KGc3tE69EE2R4f7Ak/7wnQIFpQt6WnZ/2zo0bG5IA/U/suNwN/vzCCT+N/h5MaQzLyuvi1Bzw5U85n8AMZ+nthh6Wm/TKI1D8lp0Hs6kwRNvxpnOtS8HhfhpTJe9YLAB6Y4ReyZklbc5WraNRbqsPXNhpcs745jPkmFkEKDLabB7+98WNTSAH1Rhcn9eI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(346002)(396003)(122000001)(2616005)(38070700005)(8676002)(4326008)(76116006)(66556008)(66446008)(64756008)(91956017)(66476007)(66946007)(26005)(6512007)(86362001)(7416002)(53546011)(41300700001)(5660300002)(6506007)(31696002)(8936002)(316002)(110136005)(38100700002)(54906003)(186003)(71200400001)(966005)(6486002)(478600001)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2hENU51dis0SUxldzJiYXJ6S2ErS0ZVYk1lMDR1SmRTNVBjbmVBMmcvSThR?=
 =?utf-8?B?TWhZOGNhREd3dmpFMjduL3FkbkZLczIxdUVXRFQ1dkVKWTd6S2d2S3pwMXdv?=
 =?utf-8?B?NkM4MzFXV0dBSzNOZmo4Y2tRQ0V0MWgzOFR5MGVWQlorSWFPUkZLYVQvL2lr?=
 =?utf-8?B?bTM3ZXlyU0ZMWm91bmhCMzdNZitwRklTQytMQUlUTEU2ZU5ldmZGcURsR1Nn?=
 =?utf-8?B?ZnpacUVXSG5Sei9ka0EzeUFHTEpWcldiZ0J3UmJOaVpoZE16NEZ4aUsvalNa?=
 =?utf-8?B?Z1ZmQTlOWngwVXpVY29leTg1THQ4QzFSeFNmQTJRYjJTWk85azd2OUlwT2VS?=
 =?utf-8?B?bC9pNnFqVDlOcVQvd1FrU3pXeTJiczAzVlJXc1JJcmcxTHpSUUNNQk9LVnVE?=
 =?utf-8?B?OGVKc1pNZmJUMk5jc1lqaUlMc0RacnZRdDBlMzFUOW9xYzBXQmJBM3Y0TWRa?=
 =?utf-8?B?WjVOdnhPbW0wb3ZzcUk3a282OWZhUHBpdjVBRUErVGpNK3ZRdDhOQWZwQ0tl?=
 =?utf-8?B?dTRCb3hpcDJLTjNLVG1neTJaejBlNFZWTEZ1VkwrNkJsWFJLU3JBVkRraW9E?=
 =?utf-8?B?czBZdXYya2U2d3FydFl4WnJtUmNMUmowbVozbGxKQTAzeU9rR2p3SHdYc1gr?=
 =?utf-8?B?dkR3aVlNdW9hZDRILzZEcmsvVHphNFZVN2xIZmJFa05nczBsekcxTytFSFh5?=
 =?utf-8?B?aXdaWWZSWW4wSU53am1kbU1SUGxEaVdrTkw4UnoybHBlajVEWWRwYUlYMDZE?=
 =?utf-8?B?VUs2bWkwYk42VnhRamZTOWgxY0liWGp0dkhXV2xiMm85bEU5NmJtcnFHSHFk?=
 =?utf-8?B?anEvTVdOWGpyWVNJMUd0ZklFU2RhM1FIbmdjZ09GVDZwcUl1MTlIWW9rTXpM?=
 =?utf-8?B?WTJzUE1BSUpzQVR5QUMzTGkxZ1hNaUNKczAvSk1YS2p3WDQweVFDT2hiVVQ5?=
 =?utf-8?B?ekF0V2VuYm0xQ1J1aGd0QlVnRFlFOEtvUjJwUmo4QlZrcTM0ak5rQ05aWEpq?=
 =?utf-8?B?U3pBRE1Pamt0ckRPa2MvMFo3dVhybFJ4ZGl1SlNnTkxxNklldGc1VlVSQndD?=
 =?utf-8?B?ckErNldUUVl6QUxRQWx0ZW91ZnNJVEZxU3JKK3c3RDZPS1lIM1RBVERlN1lu?=
 =?utf-8?B?WCs1dkxvVElrUk9mbEtmMWV2dk9zNVNoWjEzNDFVWGk0N1E5Z2V0bXNaWXAz?=
 =?utf-8?B?dTgzOTdIelRUekVDV0sxMm40RVF2bVd0MUdCZ0xQRzh5bFM2NXRQWmVGR3Vk?=
 =?utf-8?B?OWEwcHB0ajBpRU0yU2lFckZaNTYzTXVhdXh4MkRtQ1NySnFCbFBFSitBVjNF?=
 =?utf-8?B?UE13RmV6YUU0L014Q0FPUXVxeVdQT3NLV1Y4S2JNUEk1bW1BTU8rMTdLS0VY?=
 =?utf-8?B?cWRxcVlGNnMvRGRTMzRnYitTUkpzUDZFRVl3SlRwT21hYUpMMk9wMDhxSEdE?=
 =?utf-8?B?RFpMcnJSSHhTUzlUd0dTOGhSK0RnZGhsc1VtMkw1N21IeDhiTjJkbEtITmoy?=
 =?utf-8?B?UmhjMVJrcGw4eDIrZjhEc0NvajR0bGZ2NlhSMUVTR0RhYUh6Yk52TkhFZ3pY?=
 =?utf-8?B?amJ2YWlSekhSNnZudHFEWXdiSG83VnZzUWZyakdOaHdrYUNNOVgxZnJQOXRR?=
 =?utf-8?B?M3JiN0ZUUGJ0SDFpTjJFR2ptZmJYN1RqUVJYUXpNMnVyeGdrNmtYSkxWTnN5?=
 =?utf-8?B?Z2xzL2hVT0p4Y0Z0UjdwSkx1c1YxR2dPYlRyNHdDcEdveTE2d3krRjdyYyt5?=
 =?utf-8?B?dnU4aUI0a0VxZWxHelRQRUE1UjdCa3FxM25ZejNwQmd4UG0xYnF3aGw1YjhQ?=
 =?utf-8?B?U2RocEhjUmJkZXVhNWV1UXRwRGtyL0tJcmpsWnROVlUrMVRpUzJzaTR1SUdJ?=
 =?utf-8?B?NXN2b01VN01tKzRCcmlJUUNDOUhBRm9RKzZVaC9HTFpLWmlEVFlaMlZaS0Nm?=
 =?utf-8?B?ZDlJNVZrd25GUHE3Q25UdE5oTlE5OEVSbzN4dDN4M3NLTUVST2Z0V3I3MnNO?=
 =?utf-8?B?OERURWdEb2I4bGRORG41c3N1TFVWdkYvd2R5Mms2MjducVNSL2xiVDZGWENq?=
 =?utf-8?B?OTFwNTY2QmhSelRMZWh4OXUvWkVWSHowaXRFUDhEQTJwTytKWkdCTmZ5TEVC?=
 =?utf-8?Q?DkwIhjsH7Ct7vOdxHrDarH4U/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72D7613120F3D94D8D5E1585E3428F8D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6a8c72-9b6b-4c29-378a-08da63dc0748
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 07:56:29.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ib34FtoMniqpNonl5mwrybCxU5ZXvGYEhnfoDeROsLh8aM3BLSJ8RnQdDENVHnZSK0HZPCSZsVrnb0SdhFJ1tZNZLCJashZm5He77IX98WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1652
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

RFJNIE1haW50YWluZXJzLA0KSSd2ZSBub3QgaGFkIGEgY29tbWVudCBvbiBwYXRjaCAxICYgMiAo
dGhlIERSTSBhcHBsaWNhYmxlIG9uZXMpDQpmcm9tIGZyb20gdGhlIGZpbGVzIGxpc3RlZCBtYWlu
dGFpbmVyIG9uIGFueSB2ZXJzaW9uLiBJJ2QgbG92ZQ0KdG8gZ2V0IHRoZXNlIGRldmljZSB0cmVl
cyBmaXhlZCBmb3IgdjUuMjAgaWYgcG9zc2libGUsIHNvIEkgYW0NCmJ1bXBpbmcgYSBsaXR0bGUg
ZWFybHkgYi9jIGl0IGxvb2tzIGxpa2UgdGhlcmUgbWF5IG5vdCBiZSBsb25nDQpsZWZ0IGJlZm9y
ZSB0aGUgbXcgb3BlbnMuDQoNCldvdWxkIHlvdSBtaW5kIGFwcGx5aW5nIHRoZXNlIHR3byBwYXRj
aGVzPyBUaGV5J3ZlIGJvdGggYWxyZWFkeQ0KZ290IFJvYidzIFItYi4NCg0KVGhhbmtzIQ0KQ29u
b3INCg0KT24gMDUvMDcvMjAyMiAyMjo1MiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IENvbm9yIERvb2xleSA8Y29u
b3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBUaGUgQ2FuYWFuIEtEMjMzIGRldmVsb3Bt
ZW50IGJvYXJkIGhhcyBhIGJ1aWx0IGluIExDRC4NCj4gQWRkIGEgc3BlY2lmaWMgY29tcGF0aWJs
ZSBmb3IgaXQuDQo+IA0KPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4NCj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlw
LmNvbT4NCj4gLS0tDQo+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9p
bGl0ZWssaWxpOTM0MS55YW1sICAgICAgICB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9kaXNwbGF5L3BhbmVsL2lsaXRlayxpbGk5MzQxLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9pbGl0ZWssaWxpOTM0MS55YW1sDQo+
IGluZGV4IGM1NTcxMzkxY2EyOC4uOTllMGNiOTQ0MGNmIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9pbGl0ZWssaWxpOTM0MS55
YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3Bh
bmVsL2lsaXRlayxpbGk5MzQxLnlhbWwNCj4gQEAgLTI0LDYgKzI0LDcgQEAgcHJvcGVydGllczoN
Cj4gICAgICAgICAgICAgLSBhZGFmcnVpdCx5eDI0MHF2MjkNCj4gICAgICAgICAgICAgIyBpbGk5
MzQxIDI0MCozMjAgQ29sb3Igb24gc3RtMzJmNDI5LWRpc2NvIGJvYXJkDQo+ICAgICAgICAgICAg
IC0gc3Qsc2YtdGMyNDB0LTkzNzAtdA0KPiArICAgICAgICAgIC0gY2FuYWFuLGtkMjMzLXRmdA0K
PiAgICAgICAgIC0gY29uc3Q6IGlsaXRlayxpbGk5MzQxDQo+IA0KPiAgICAgcmVnOiB0cnVlDQo+
IC0tDQo+IDIuMzcuMA0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiBsaW51eC1yaXNj
dkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg0K
