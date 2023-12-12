Return-Path: <dmaengine+bounces-505-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE51480F500
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 18:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69941C20BB5
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 17:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E647D8B8;
	Tue, 12 Dec 2023 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A/iF1f8Y";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Pocjsxzi"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F1AE8;
	Tue, 12 Dec 2023 09:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702403641; x=1733939641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zrV+hpWyajGxDmkxPYyw+aJYLmqYAnkBP2JZP9Mr4ac=;
  b=A/iF1f8YbqDg5AWUpDMhTwKzhFXuM63l2f7lNks2iTRWUBDVMLRUye0w
   KcEb6tTNpwqKXZLWTEaN/9jhlquEiPTRYHVArKc6ODqo9LZmCPe3KqS1j
   Da/ascrV9sJonNOeLaV8FjGJX/ZKM7hVdedin2GkN/W0JfKk2zlUkU3Vp
   z1nQy4i7UiuHBaDZ0qtcwgp5dNUYqeAYs24qeBn9pQznl7TWKLDd2tCwH
   bK+KsAb3kSv0vkRwF9NK4nl3+/mM3EvflEvMaE9C2NMDJsT1G2vBn0FRJ
   D0t6jJSKO3mCxq5ZLpQARFvtMMu9prLd8t3jaT3Ud9k5qHS2dZ95pQN1m
   A==;
X-CSE-ConnectionGUID: KRk6ptVZSqyF64gGvGzKSw==
X-CSE-MsgGUID: HY5YCPZsRKC2R10/6bWqaA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="14095370"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 10:54:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 10:53:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 10:53:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al0OpqkDdseUazUeBFRErin78Xsgzs5Vr/0NuKRyOmXbJ2isUIoOjkGcztrXbn08wNi0nqAhRJZO41gtVc4xYy55qPepfzM5TMNyD9+9I9ev4G31FjyTUykexEUBKx5P3ZYhXq0M95vXnQC8V25Si/ePIt4dyop8rFJJu+IMGFvFkUSil0ILORusEdZL6uRMBXBZUelGpQ14afZTlXvbHNeoD2QAWzmSruAntNXYrClBsnIuros7dxLjwVMmAZDsWnriK2fbQo+tX9m6oJFanS9jLNWfWoc1qYNgatC8Bj4lHQpiOD6C5UUcCk6KzwOrodAHK1XGb9ZsKOWVnR93KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrV+hpWyajGxDmkxPYyw+aJYLmqYAnkBP2JZP9Mr4ac=;
 b=bxyioDhxk4pctT6wUkph7a6boJoBfINHiW6h488p30t6pOR7XQk1D+yOXAdAKxnzmg3Ok4pkDxfjwLqWosXGOWhvo30N3/OyE04A/j52cSBgbAZo2Ex8Y+v4S2Fq/BxZTral3KOiqo9CzMcL7o22lxlBbq+LvWBEuWlJtUPRImmTFJTDFXCZP0M+JLn5wL8P5kbqGGjjVyFQnFzsH68sKGwfJ9Z5hrCczz6gMiHojzgz5abr3BCh90nSzcPCfCAUeJqpEqjmF8ifXMpj3cX6t+i3zaUwhWqrP31vaHhETx1tUg9EIGFZJh9nK8KewYRDmlb5Gsk6FejX5N7+dnWmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrV+hpWyajGxDmkxPYyw+aJYLmqYAnkBP2JZP9Mr4ac=;
 b=Pocjsxzix9uGNmgmI/PCYQMNxgIRtoGfQ04bNgpmrRumcYP1ZwwxtT2sonGOBdfxY2Nb7loANNxo+VRJtdad7Z4uqqTwOBukOijHDL1z988u9xyDmbQEqs40IXZEBk0V5B/aLTYMhD0NDW8RDkHyobYFG90aFUfdd07DEh0Jw8Y7aWR+5FE+8x7Sd0u+wz7/okaz0SoKviMceyUNqwkLMccWI7aFQTRR6WxZrkentpm8duZgUWXjrEJyv+B/YxOQ1lMwWxbubCShg/ArMPwo0ZGYCMjE6Dj0amYdqqLZL80Ao500BxdDCYJayQW3uOmcXaGsH0sBiiO+hqyOTWJ3iw==
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by IA1PR11MB7173.namprd11.prod.outlook.com (2603:10b6:208:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 17:53:43 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4585:18c7:f74d:a076]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::4585:18c7:f74d:a076%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 17:53:42 +0000
From: <Kelvin.Cao@microchip.com>
To: <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <George.Ge@microchip.com>,
	<logang@deltatee.com>, <christophe.jaillet@wanadoo.fr>, <hch@infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Topic: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Thread-Index: AQHZwZllP9AErauFFUmKz13YRSBKD6/VzMKAgAIhf4CAZAP1gIABCsYAgADKTQCAA5sdgIACmkmAgADx6oCAAFB+gIAS5mwAgE6fkoA=
Date: Tue, 12 Dec 2023 17:53:42 +0000
Message-ID: <b4a1a955cf4bbab695d364b6d4da4d16167c3959.camel@microchip.com>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
	 <20230728200327.96496-2-kelvin.cao@microchip.com> <ZMlSLXaYaMry7ioA@matsya>
	 <fd597a2a71f1c5146c804bb9fce3495864212d69.camel@microchip.com>
	 <b0dc3da623dee479386e7cb75841b8b7913c9890.camel@microchip.com>
	 <ZR/htuZSKGJP1wgU@matsya>
	 <f72b924b8c51a7768b0748848555e395ecbb32eb.camel@microchip.com>
	 <ZSORx0SwTerzlasY@matsya>
	 <1c677fbf37ac2783f864b523482d4e06d9188861.camel@microchip.com>
	 <ZSaLoaenhsEG4/IP@matsya>
	 <f6beb06cc707329923cc460545afd6cfe9fa065d.camel@microchip.com>
	 <b5158f652d71790209626811eb0df2108384020b.camel@microchip.com>
In-Reply-To: <b5158f652d71790209626811eb0df2108384020b.camel@microchip.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|IA1PR11MB7173:EE_
x-ms-office365-filtering-correlation-id: 68bdb874-eeab-45ba-a0f7-08dbfb3b47cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z1WW/JM4elAgSpWQiqPkXc9CSq/ppRABupD9x5USD/1lCh9/9LArB3XBOD4PtVcpi/fsrE+VOhnVdbDcbHLUgglAnM81HEr/+tg0SWPZa1Rli46l4PjeCwohmAXL1/a5ok1FzLq/HC+bd4ucx5UZoiK0myr/+1wcxIlLU1pKV8wte0QXUO2PrNUeVdwpD98mRZdlQ3HP1NcupHW6C97W03r3nrFjKYEb3ve/5xe2RTi3HIXwOt/vtizWUC6nmFGPtVt/Z1Avow0Y9BBge6WZcXqQDBCv8Odv1lBubPUgBMBjB9PYVgympC00jjjF6YwnQLUpBdcTm8Ptb5zt0C+7RQT72b4uOBcHLerZ6waZ/oHRvCz80LjZzu0EOaDL6wt0flBQ370emXPFlIddFATrOzLr+HazyvkBTmIu2zjEDT+9W4k9/phOmwBB41mzHudYqrWnLY8JT4vtB/TrV1tAwY429hkSLiNZGFcb5Is29J0j5NRm9cma8WepTf/Tptqfz35R9Dtj0SfaUJY1whpbJKK5QX/FkdND1cmcfnbWJa725Ctnjq5G646EO5Do5YNXKKYo4j4jGOl4ETQFHcdLRhFkAk6CKqWmO5PAbXJuGDiDDnYGqXvDB3VT4TzNEsHJH4ULw+wH0GpaxM7HvaYq2H8Lx5BhB95s3uic2so/1xs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6506007)(6512007)(5660300002)(26005)(2616005)(36756003)(53546011)(64756008)(38070700009)(4001150100001)(6486002)(66946007)(66476007)(66556008)(76116006)(54906003)(6916009)(66446008)(2906002)(83380400001)(86362001)(478600001)(41300700001)(4326008)(8936002)(8676002)(122000001)(316002)(38100700002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1EzTlNBMUJDcFR1REt2ZFNObGIzd1hRUmFIb3lMZGhqQXFtVTdmdmlxN0JR?=
 =?utf-8?B?RmpIeXJwVEtGTng3VHFLREYyWkRjQkpGakg0bjZNcmpqL3RHTjZNT1FsUm1v?=
 =?utf-8?B?VGVXVmlUaE5OVnVKL2tKNXQ5b1FKcXFWTWtNUEF6cmNnOFgwaFlvUk0wTlFa?=
 =?utf-8?B?Rno0VjJkTk5Ra3JneHFWNXRYN2RpT1o3T0pDbGlodmxFb0VFWncybGZuRisy?=
 =?utf-8?B?Q1YvanF4YlB6SjIxTCtzcXZRQjhWaVUvYkMwSk9mMHVkdnZ5dU9lN29qaHZa?=
 =?utf-8?B?dE9jNnFOZDY1aDJvZHlCRStPVVlRakVDdkZzYXdmVEFpR3ZhRUNiVHcvNXlS?=
 =?utf-8?B?RVB6QzJ0TjFyTzJ5QTAvRzk2aW9abFVIQlE5ZzdxVnZJSmdJbGlvWmJ6eCtz?=
 =?utf-8?B?NGZ1K1dPeUdUbHYvYWp5QkNmaGVGdzlZU2tUMkk2WnkwcjFqU0h0OStPRGF5?=
 =?utf-8?B?QTdsckczSzJkeGJBT24zN2s2VnF5UHNIKzU1aDJBblVhSU5rZ2JkYzRxNWdh?=
 =?utf-8?B?eDllSHRrRm1VWSt4L1RrL3ZqSnlUbjI1Nm5oa1ZjNlQ4UjIwNVZib3FjSlk0?=
 =?utf-8?B?ZFFreWplRjMvUVBEMTcwNktaUW1LZ0tCeENoR3k3Q2M4eFVSWW03aVlIWVdm?=
 =?utf-8?B?NXl5aGxRUTNOQWRaVmQ3VjVGV25mTnh3UkJtOXFPS3BHWlptWjRZVDcrQkFl?=
 =?utf-8?B?ZWl4azE5dEZKaGZabkc2QkFjYmxuazRUUTd0c2lEUWtrN2lXTFlCN0hiTjFM?=
 =?utf-8?B?Rm5CVng1U0JxY1hTSlY1NnFYRUw2enB5T1VpN2w0QTZhWHQ5N3FkQmxLY2Rw?=
 =?utf-8?B?ZE5Lc2JZRDhJNW1DMFlzTnZnSTlTUUd1THh6aWp1cnVvMGpxU2Zob3d3ck9h?=
 =?utf-8?B?bytuMnc0L1cxWElhbXRRZC93QzA2ZUZrMVpHd2o1SW4yWS91QVRDYU5zd2pz?=
 =?utf-8?B?ZmhVMUJhTEpKMW5oVFU0bnJBeXBHRzh0eUFZck5LWVQwY0hmVUdXeGYwL3dC?=
 =?utf-8?B?RGtBeEtLOFRXZTVDRkVUVnBndFVpdWxzVk5tanlLN1A0b25jaUpnSnR5bEdz?=
 =?utf-8?B?YWFRSXYyZ0lGRnJHQ1llTS9GQlpDelJkTGF0YUFtcEF5dFN3dkNLbDE5S2I2?=
 =?utf-8?B?REpwbmFRVnlvUDNkZjcvMS9CSGhVS3h0VjJwYUdXbnlTMUd4SlZsTDZlNmNC?=
 =?utf-8?B?VTlOMEM2ZE91d0dCd0VtdUh3bUxVaDdBRS9lemFib0JaMGs0cGNSeldIME5z?=
 =?utf-8?B?Zm5XaTBpaDhYYlpvT1FIUERZbDdBZEhjR1JzTUNjeFFLYlpGeDNWWWJoYjE4?=
 =?utf-8?B?Ym1qeEJHNmh6SXVvVm1uMjlPL0MzdkQ1dHdSbndXb0k4TDlpSUZ0bU1peW41?=
 =?utf-8?B?NnQxQklsZitTRzNGbzZZN3oxRWRuWUlQNncwaTBCb2IyMXhyRzJhUklPTkNV?=
 =?utf-8?B?RTZJNEdab2xpYzExUWhqZEdxQnlic3RLdEQwRkYzSkhqOTNrMXpCMC9NTUFp?=
 =?utf-8?B?V3M3dTdrSE1jZW8xcnpOOVNIbWs4bGdlTSt4ZmsxeXYwNm5uUTBCSXVTcGdn?=
 =?utf-8?B?K21kdzBYN2R2LzRFVys2UWhkK1F2a25POGRFV2V3dUE0VG1kRlBmeXQxaUZI?=
 =?utf-8?B?R3AxNlRNMC9USzZ6SFlHUkthSXgyYjk5UTVZSzVVWmY3RGpkdEgvOEY4eWdw?=
 =?utf-8?B?SzBwbWgwWW4zZGMzN3ZkZFpNdWpoK05adTJ2OGRxWXI3OHNGcGlOVSt2UzFk?=
 =?utf-8?B?TTJPTGhjeXFoaDhya09ZcTRINHJNLzhvYmFveE11K3cxYjJmRm1CaEdRcVk0?=
 =?utf-8?B?dlRVcXVnR2NRQzJmUGJLOVpmZEU4aWZhZUxsdFVPTDNKWERKNTdMOTQvdGZ6?=
 =?utf-8?B?b01saGVXUm9lN0RYY0RST3laaEEwTDFWN0lRbC9Ed3RsV05kd0dyc0RJelN3?=
 =?utf-8?B?MGhOc2hDUTRVMFVxUURiN3dmT3JPMzBZbXExVEh4b2ppY3oxT1k3MTdyUFVq?=
 =?utf-8?B?andLWnduWU1QSjVzeEZNTnBpcm8wVlNLcDlPMFZHQlpKWTlBRkFub0N5b2E1?=
 =?utf-8?B?WUt6amN2QjBxeTZGdWp3UWtpKzhBUjBFUEZFSjJ4Q1E4a3UvNWNPNHhsaVRN?=
 =?utf-8?B?SlRHT0VxNTFzQnR3M0hkZ2R0RXdGVVVrcm83MnQ3aFUzQW03eWlTV2orL2dl?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28873F50D2882B48A4150F3927BF1DE5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bdb874-eeab-45ba-a0f7-08dbfb3b47cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 17:53:42.8958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUvt366Eya6gPu4q4DR+ouCde9eXvdytCfhTgYi2EDs9jFFaIiD1OIpSi5dYb2fqGuC6ngemSg6pvw6nnSTUqvH60SYciScJSmT9PWYFUNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDE3OjE0ICswMDAwLCBLZWx2aW4uQ2FvQG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g
T24gV2VkLCAyMDIzLTEwLTExIGF0IDE2OjM2ICswMDAwLCBLZWx2aW4uQ2FvQG1pY3JvY2hpcC5j
b23CoHdyb3RlOg0KPiA+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+ID4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
ID4gDQo+ID4gT24gV2VkLCAyMDIzLTEwLTExIGF0IDE3OjE4ICswNTMwLCBWaW5vZCBLb3VsIHdy
b3RlOg0KPiA+ID4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4gPiA+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+
ID4gDQo+ID4gPiBPbiAxMC0xMC0yMywgMjE6MjMsIEtlbHZpbi5DYW9AbWljcm9jaGlwLmNvbcKg
d3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgMjAyMy0xMC0wOSBhdCAxMTowOCArMDUzMCwgVmlub2Qg
S291bCB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiA+ID4gdTY0IHNpemVfdG9fdHJhbnNmZXI7DQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2h5IGNhbnQgdGhlIGNsaWVudCBkcml2ZXIgd3JpdGUgdG8g
ZG9vcmJlbGwsIGlzIHRoZXJlDQo+ID4gPiA+ID4gYW55dGhpbmcNCj4gPiA+ID4gPiB3aGljaA0K
PiA+ID4gPiA+IHByZXZlbnRzIHVzIGZyb20gZG9pbmcgc28/DQo+ID4gPiA+IA0KPiA+ID4gPiBJ
IHRoaW5rIHRoZSBwb3RlbnRpYWwgY2hhbGxlbmdlIGhlcmUgZm9yIHRoZSBjbGllbnQgZHJpdmVy
IHRvDQo+ID4gPiA+IHJpbmcNCj4gPiA+ID4gZGINCj4gPiA+ID4gaXMgdGhhdCB0aGUgY2xpZW50
IGRyaXZlciAoaG9zdCBSQykgaXMgYSBkaWZmZXJlbnQgcmVxdWVzdGVyIGluDQo+ID4gPiA+IHRo
ZQ0KPiA+ID4gPiBQQ0llIGhpZXJhcmNoeSBjb21wYXJlZCB0byBETUEgRVAsIGluIHdoaWNoIGNh
c2UgUENJZSBvcmRlcmluZw0KPiA+ID4gPiBuZWVkDQo+ID4gPiA+IHRvDQo+ID4gPiA+IGJlIGNv
bnNpZGVyZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBBcyBQQ0llIGVuc3VyZXMgdGhhdCByZWFkcyBk
b24ndCBwYXNzIHdyaXRlcywgd2UgY2FuIGluc2VydCBhDQo+ID4gPiA+IHJlYWQNCj4gPiA+ID4g
RE1BDQo+ID4gPiA+IG9wZXJhdGlvbiB3aXRoIERNQV9QUkVQX0ZFTlNFIGZsYWcgaW4gYmV0d2Vl
biB0aGUgdHdvIERNQQ0KPiA+ID4gPiB3cml0ZXMNCj4gPiA+ID4gKG9uZQ0KPiA+ID4gPiBmb3Ig
ZGF0YSB0cmFuc2ZlciBhbmQgb25lIGZvciBub3RpZmljYXRpb24pIHRvIGVuc3VyZSB0aGUNCj4g
PiA+ID4gb3JkZXJpbmcNCj4gPiA+ID4gZm9yDQo+ID4gPiA+IHRoZSBzYW1lIHJlcXVlc3RlciBE
TUEgRVAuIEknbSBub3Qgc3VyZSBpZiB0aGUgUkMgY291bGQgZW5zdXJlDQo+ID4gPiA+IHRoZQ0K
PiA+ID4gPiBzYW1lDQo+ID4gPiA+IG9yZGVyaW5nIGlmIHRoZSBjbGllbnQgZHJpdmVyIGlzc3Vl
IE1NSU8gd3JpdGUgdG8gZGIgYWZ0ZXIgdGhlDQo+ID4gPiA+IGRhdGENCj4gPiA+ID4gRE1BDQo+
ID4gPiA+IGFuZCByZWFkIERNQSBjb21wbGV0aW9uLCBzbyB0aGF0IHRoZSBjb25zdW1lciBpcyBn
dWFyYW50ZWVkIHRoZQ0KPiA+ID4gPiB0cmFuc2ZlcnJlZCBkYXRhIGlzIHJlYWR5IGluIG1lbW9y
eSB3aGVuIHRoZSBkYiBpcyB0cmlnZ2VyZWQgYnkNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGNsaWVu
dCBNTUlPIHdyaXRlLiBJIGd1ZXNzIGl0J3Mgc3RpbGwgZG9hYmxlIHdpdGggTU1JTyB3cml0ZQ0K
PiA+ID4gPiBidXQNCj4gPiA+ID4ganVzdA0KPiA+ID4gPiBzb21lIHNwZWNpYWwgY29uc2lkZXJh
dGlvbiBuZWVkZWQuDQo+ID4gPiANCj4gPiA+IEdpdmVuIHRoYXQgaXQgaXMgYSBzaW5nbGUgdmFs
dWUsIG92ZXJoZWFkIG9mIGRvaW5nIGEgbmV3IHR4bg0KPiA+ID4gd291bGQNCj4gPiA+IGJlDQo+
ID4gPiBoaWdoZXIgdGhhbiBhIG1taW8gd3JpdGUhIEkgdGhpbmsgdGhhdCBzaG91bGQgYmUgcHJl
ZmVycmVkDQo+ID4gPiANCj4gPiA+IC0tDQo+ID4gDQo+ID4gT2suIEknbGwgcmVtb3ZlIHRoZSBj
YWxsYmFjayBhbmQgY29tZSB1cCB3aXRoIHY3LiBUaGFuayB5b3UgVmlub2QNCj4gPiBmb3INCj4g
PiB5b3VyIGNvbW1lbnRzLg0KPiA+IA0KPiANCj4gSGkgVmlub2QsDQo+IA0KPiBJJ3ZlIHN1Ym1p
dHRlZCB2NyAodGl0bGU6IFtQQVRDSCB2NyAwLzFdIFN3aXRjaHRlYyBTd2l0Y2ggRE1BIEVuZ2lu
ZQ0KPiBEcml2ZXIpIHdoaWNoIHJlbW92ZWQgdGhlIGNhbGxiYWNrIHN1cHBvcnQgZm9yIHdpbW0g
YXMgeW91IHN1Z2dlc3RlZC4NCj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoYXQgbG9va3MgZ29v
ZCB0byB5b3UuDQo+IA0KPiBUaGFua3MsDQo+IEtlbHZpbg0KDQpIaSBWaW5vZCwNCg0KQ291bGQg
eW91IHBsZWFzZSB0YWtlIGEgbG9vayBhdCB2NyBvZiB0aGUgcGF0Y2hzZXQgd2hpY2ggcmVtb3Zl
ZCB0aGUNCndpbW0gaW1wbGVtZW50YXRpb24gcGVyIHlvdXIgY29tbWVudD8gVGhlIHBhdGNoc2V0
IGhhZCBnb3QgYXBwcm92YWwNCmZyb20gb3RoZXIgcmV2aWV3ZXJzLiBMZXQgbWUga25vdyBpZiB5
b3UgaGF2ZSBhbnkgb3RoZXIgY29uY2Vybi4gDQoNClRoYW5rcywNCktlbHZpbg0KDQo=

