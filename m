Return-Path: <dmaengine+bounces-8089-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D75E8CFE0FA
	for <lists+dmaengine@lfdr.de>; Wed, 07 Jan 2026 14:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A16AA3002973
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jan 2026 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C448332F748;
	Wed,  7 Jan 2026 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="FViZy3qJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010002.outbound.protection.outlook.com [52.101.228.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD5F23EABF;
	Wed,  7 Jan 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793692; cv=fail; b=rtPrCTNXw4RM1GkYMTxJi6FmARX2ETfjcYZVNGgq7U/sS4Yq07BI7qK6Afh/n/3wioX5/jm7zb+tBZvTqQ48/bLksyjuldGiZt+BLO5hQVVY8Mu4O6IfMX/iAfsOCi6SA4zAUi1+lAXFTfnV4tMlw7NoatIFRomP+V0PzWUmkkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793692; c=relaxed/simple;
	bh=4rLMQmfxIOK0J8mvY1h9eV3BRgyXrp+uq++yIIX7a3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B79P5JQ/xZFP76SP7m/Zgd+mT5AtZEeVa18f0H1CVvNH4kBqKfoP8niBxbjvkVBqgxGsINijgcItVQebW8ri7Oe6HTURLqifSaxVdsb/ZQ/a0Is2DXiDjnXCDVoCa0QAGj0RWb6/mzF8Ewl5zB9/BT7qFwKqaD6nnTEVbYwQuUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=FViZy3qJ; arc=fail smtp.client-ip=52.101.228.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3MfYc8H7OoMI1lGMOTS6sSUwRUQ/77e9WyTftpsJC6vheG597rvsFlR8qTctdKdDxKGy7V8dc5gtxCF2L8nQMO2zcbwqp0UrnabNfxrDjGahWO4OgeBO/JL2JwaWwIqQHQ9l2FmeOSCvBcVwsVmFfhgmFLzelLLNkKRTdNp05De58Veq6PA7m/QFByV3kIiYXNDYCV1m5jbUQgYJ2EgFYFOzxGfyKUxc52RtiY2b5kNQHnRujiXNGmZreERMuEWjEPDMRr8U1LKAKfkwvx57CmaXvZDbIYGZbUzZl4QRwtgVaIuLfLzjHguEu6kbwYE1XpJxgpgGIrgpYqqmiq1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rLMQmfxIOK0J8mvY1h9eV3BRgyXrp+uq++yIIX7a3Y=;
 b=Fpr+dESGSgIyGoYZmBPFO+Glxr2yRpKoRUsgTtPZs1AJMcJ5vb/kFA4f9c4OmqeAoWbtb3js91WwLJRPsnMa+NDVcg8gJf5cSMTCIU3JzJH1ylIdIxBqbkytBbBuyq8XScHjpfwz5rzPbSxW1WXXz7xnm4blL6L4xI5ntE3ro3qdwGFfK0VwgPcJRc/K1uDuolrPX4o5hM0REqL9+MFb/FNFRcEiAXxwERvEuQ7cMT6CPHkuv0QZWdx7tU3AV9or9BSKv22Po2sp5Nt2xN1FiqdyhkqQV3IyKfwRMZxajP4jGa6qWdnwWtbgecXZW/evpUvCqQrxo/jwg5HnV8urNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rLMQmfxIOK0J8mvY1h9eV3BRgyXrp+uq++yIIX7a3Y=;
 b=FViZy3qJzS8sz72XidOg4ZB//VAwwghzFU/oOba0BVqdq7bgZke8fX1U/a2K+Gnfi8O6SMANK5SPnEeq46nSNlW8r1km1B9hniFrOqaJ+KHHgInwZb05okn9L4Z4/Qat9d1O7ni6HGse/oX/l42thAY3Z/JJyzvRT6tUQ1R7HBA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB9714.jpnprd01.prod.outlook.com (2603:1096:400:228::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 13:48:04 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 13:48:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v6 8/8] dmaengine: sh: rz-dmac: Add
 device_{pause,resume}() callbacks
Thread-Topic: [PATCH v6 8/8] dmaengine: sh: rz-dmac: Add
 device_{pause,resume}() callbacks
Thread-Index: AQHcdBMp6GqL2gQeEk68OIbopAhjubUvSY2QgBd+SICAAAWhoA==
Date: Wed, 7 Jan 2026 13:48:04 +0000
Message-ID:
 <TY3PR01MB11346E51F609DDEC61E13609B8684A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
 <20251223134952.460284-9-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113466CA0EB792BF134502A7986B5A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <c0a76fcf-8dca-4268-9d07-b5bae8c26c46@tuxon.dev>
In-Reply-To: <c0a76fcf-8dca-4268-9d07-b5bae8c26c46@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB9714:EE_
x-ms-office365-filtering-correlation-id: 9fae31e0-3d36-44b3-4a2d-08de4df36198
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2xGOXBSbjFIZUhDbm5nNG5yRmdXNVpYVnl3S3pmdGdqeHo1SnNGMWJDazhY?=
 =?utf-8?B?SEphU1dDUm91bWhsY0ZIQlVnK0Rsdm9uRmxsVVJzbllzQnRiemU5WCs0N3NQ?=
 =?utf-8?B?c2l5MVlSUDkvUUFPQlVKbGdKbjBxWDFja25yK2kyMlk3cDk3VTBQbk1iMVFE?=
 =?utf-8?B?bHVXbmMrT3AzeG1EZG1LOG1OdHl3T2FhNmEvbmFZTFJaWjh1V0hQM1ZKNjFS?=
 =?utf-8?B?clloNkIwZVFYZjVqZzFtZDgwMmRkRklhRVJ3UHp0VXRvMDFIM1JuRS8zdGl5?=
 =?utf-8?B?WmtvajVzZ0JvM0lFbWVKaEtXbzA5TUpFL3I2SjNuYVNWbTJkUDJjeCt6QUxt?=
 =?utf-8?B?S2RmV1BJM3M3SkhYMUQxeExuSms0T01TeldXOVZ4SVp3R2QyYWg5dnNYZ1ZP?=
 =?utf-8?B?aVRhaTc3eEpMSHFSemtENDlqbzRYUSt3RG5iNUdseFV0b2Z6d1RJZ3lySlJB?=
 =?utf-8?B?WkJIOHNVaS9YTGRyajZmWlRnaWNCOGxMRFpaTUVEWUtqNnorOGtiR2NjRmFO?=
 =?utf-8?B?TWpZRFBBelRsSEhkYU1nWDUvZEdQTnMxSmFKa0poTXhjdXNLdXkzQ3VzMTl1?=
 =?utf-8?B?VXR6MG1nVGp5N053ZkxxbGF0TStpZzgzczBxN3hIby9qTnNsRFVnTWVsa0dM?=
 =?utf-8?B?RkhnRGROMzJTejA2THlKbUxFaDdwVW02U3dMUzNzUUhwcWg4aWJnc04zYXEz?=
 =?utf-8?B?Ry84aUdONE9IZVUzOXRBdU9XRmpGOVJqREdzU2tyaXA4Y3NkajJodm5LZUV5?=
 =?utf-8?B?bGlDcjN4RktlZWxGbks2QjJKamxUcGd4VlQzRFRmYXRCQWhMVUdTOXNwV2VM?=
 =?utf-8?B?SmladStZay83T0lSQnJQN3A3QzE2MWxkN1FoTVIwS1ZZREUxQ1FoZXVKcS8y?=
 =?utf-8?B?SDVTYnd5dzl6R0RSY1lvWDY4SXU1MGNJQlpVWTNxMXZmdFRidDdYRlJyRXZt?=
 =?utf-8?B?UFIvQU9VcGZlVFREOTYwT1MyUUhBUnNkWTVyNXBIWHZseXorYy9HS1I2VVZG?=
 =?utf-8?B?MTROSzdzMXdxanRieEhSN09zZHlXQ1pPajh3QlRON3hJcnRKT2tWbGo3WHFv?=
 =?utf-8?B?SEhMMHlWRCsyT2diUG9WUGFCUEs1c3JlejJPM2lYNGVKMHNsWjd4MjVzck00?=
 =?utf-8?B?dTZwZ1JHM0M5c2hYQ1BrVVhHc0V6ODdPSEFkREpYa3NTTjJZdE1QMzNmZTRt?=
 =?utf-8?B?NjNiYTNGczhZNnhhMUxvdy8ydHVRa3pabVZDSjQrM2NTQklzUGNmVVF4NlUw?=
 =?utf-8?B?VWhrcDQyMkhhd3ZtNWx5YXJsdzVxVDlIWnUrQTBRL2tkRlQ4L1huR0NSbmFW?=
 =?utf-8?B?V05NdVYvNmRzYW5tb1lYZUcxQkFiRUc4NWY3c0wyMEt1Uk0zSWg1M01rUnl2?=
 =?utf-8?B?THpqMEY0OUhpVGRhc3JqNWNOVitFTm8zVUlFL1g1TE1EK2UrYkx6NklBU243?=
 =?utf-8?B?RC9BWTRreEZiQi9pMGVGVEJocGJSZ0srRTd0YVFTdmVFSitmWlFaUDREWDhp?=
 =?utf-8?B?d1hyQW5nTUVIRFZCaHBZYk13UFhSTHRFVkMwTVlYKzJEVkZkb3AxandjUmdK?=
 =?utf-8?B?NzN5aEw2VWM5UklXVmpsNHJXNmFVTzBsZTluNmliMGE0SDB4SGFRRStheFhU?=
 =?utf-8?B?alZvRXdhRUhQVXo2MnE2SFJXdHZJaVg1bm1ZTFZ1OG94VC9DbmZzUmhVRHlq?=
 =?utf-8?B?aWE4aEsvaEJEVWZseE5UZENuMnIrRHFDcU9uY2NLMnVPSE5zb1JVTVVqWVVk?=
 =?utf-8?B?OFU4Zk9vazJRT0FkUE9UWlJHV0VlL2M1Y1VkQk9PdnhkRTB5NDRFdE1Uanlw?=
 =?utf-8?B?d3hrbWx5am9WaHYxNmdNdkZjcFpTaUVidXBvRXVZSWlrVmdLZG5uZUYwVU8r?=
 =?utf-8?B?SnNSL1JCbm51djdhYjkrOE4xUzB6cGFrbjRjaVlLMEtPTHAxcGlRTkQ3Y2hK?=
 =?utf-8?B?VjFDbmdhbGQrZndIVEdlYXR1SW9ud2tnQjF5ekZweHBGaHplVFN5OWMrK253?=
 =?utf-8?B?cDNnQnZDZXJxa3l3Z2ZMVmtTekxIVkQ2Z3AwdmphbFMxeFczM08rT2JTczRn?=
 =?utf-8?Q?HD6YG2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YURFT3dpUTI0cXdUcVZTemZKM3VHVXJDMVJXNUZOblJmL2t3L3JRdzJkWnBM?=
 =?utf-8?B?VUJPcXd5Ky9LM2NJZ2E1RlE5U3RTNHlNOGc1K3NSUE82cVFibVYvVHRoVTNX?=
 =?utf-8?B?ckFDRXVEOFhqS1E2d096dXdvaU9ZUlN4NEM2Qkt2NGMzbU5vSHRXeGxLRUl0?=
 =?utf-8?B?UkRKTWZ2Z2UzOFhEeHFOekVXOXpKRDFNZEdEOVcxOVU1UzdDbXpnWkswaGxR?=
 =?utf-8?B?ZU0vcXpscmJNKzVPZkFCSGRaTURiM1laR09RKzcrL2NHQUFucStCaTJweW1Q?=
 =?utf-8?B?MTVwR2daZ2ViTEVqWFJRbTZjampQci9YK2tYdnFxZG4yL1M5dGx3a3dZa1BW?=
 =?utf-8?B?V3ByZFVmN3RBTDBPbUl3WUtNMVAzQUlNK01HU1JBeEZOaytWR1gvMEZhM1JV?=
 =?utf-8?B?NUxXN0tkT0h0RjE1MGZpT0xaUGV2cGMrbXhaSXRWQkpUb2ZGYis4NVdKckRt?=
 =?utf-8?B?Y3dFZWpPODRlNmFnZ0w4eE5jMDhSZEgrVUU0TFcwdisrZ0JmTlUybllsVzBx?=
 =?utf-8?B?K0tSbXlKVFNWWmc4MHBqcStBakIwM2JQSGVXQ0F3a2lBeXQ0MXFacXIzNGRG?=
 =?utf-8?B?aitzUVJsWFZFZi9ucGtNQlR2SGtuTXFDVmJUcjFoWmhuS0owT20rMVpvbUZi?=
 =?utf-8?B?Umh0K0dFR3MxOXFucElPUTlLdHZONEs3YnI0NHNPNHNqYzBDeFFOaGFJUGRz?=
 =?utf-8?B?bktWNU1xb3c4ZTJGQlMwYmhtS1JoQUtRV3J0ZTJqTUVsNldjMHpHc2htVks0?=
 =?utf-8?B?dTd6djdyR3ZZY1RTZ3BzWjljZm9Cb25wVzZDa25Ibi9tdVA3THFqRW04TmR1?=
 =?utf-8?B?dFBjbk04T3BMU3c4T3B1encwdFZ4bEM5VDhaMWJ3bGF1YUJNL0FKWkRiQ0hm?=
 =?utf-8?B?QWlISDF1dnVQTUNlRVBPT2pUOU5VY3dncXNQdllFaksvM3VYSThndExzMmJp?=
 =?utf-8?B?TWc0OGFTR2c5UXBhRTB2eVE2WWo4eDVUcGNsdUxhTE9wVFJSdWE3Z1I3dFNB?=
 =?utf-8?B?WnBFcVc0eHA1WHdyUUNtUlRuWlFYdmpBYUROS2RpTHNjalNic2xXUEtqT0xR?=
 =?utf-8?B?VDdTQ1ZNajJMZWNwbWxoSHpXY1AwM3p4T0tEODhlTWRYaDdDaklDZTRGWUNN?=
 =?utf-8?B?UFRTWXNjV2hPWWFaWkRDbXdtcEtnM1VwS3g1WlVFQVhEL2RERm9WbFBKMHBx?=
 =?utf-8?B?SHNnQktMbTc2RTN0Z213VFBwbndZNmN3d2J6ZktBOEViTTd6S2pXRUMxeEJL?=
 =?utf-8?B?WnFjSE1vblMybEFIclpKNW1jTGI2OVlJOTJFSyszKzJZbW5WMnNGQlpQNTIw?=
 =?utf-8?B?TUdqZU5KT2RtSStsaERTd3BldEplNDVrWm4wTE56N0QzM3JVUVlGamVQMGZi?=
 =?utf-8?B?Zk1lL24yc1VmWkpDL3NwRGUreHNwNnplNTBWY3lrYkxRMjhtNFY1N3V3QmZ6?=
 =?utf-8?B?cTQ0TWpTUkxPbXNYNVdMUVZMbXdJc3BUbFRyekJOM3Q1WTZscVlVa1VIZHRB?=
 =?utf-8?B?Qk9sVkhKdVd5U1o0RlA4TmRHMGZ5cVVGK2hIVEsvZHlpMm9OeHB3eGlUcGFD?=
 =?utf-8?B?MGJGR21scU1ISzVlVGF6WHJwQUw0K1Z3bldkSFhFdE1Pd3FsTzhhbUJUTC9S?=
 =?utf-8?B?YSs2MVpwMzU3c2FxVnMrNmNLb09UQlREamp4dExXSGVJWDFsaHhYMVNGK2E4?=
 =?utf-8?B?ZEtlb2VMUExUQm5kN1hLUDRhSlNKZ01jQmwzdzZmSUdiay9EWSswOXpwV2VF?=
 =?utf-8?B?YmVNeDdmaWljZ1NtQlpoeDBzUGVPT2F3aTFJZ0lya1hwLzBmL0RKTTRhUzdo?=
 =?utf-8?B?a0hJNHl5aVRGaWJtT2ZZS0NidFhCUERLMUJ0SEwwakdGTmFOWFhiYWwrWG45?=
 =?utf-8?B?NjY5RGJ0cnBwaThsWDhzTFZtMjR1S0t0Zit6a3lxRG1KNkliaXNFSnNBcVlE?=
 =?utf-8?B?dGFhVWpnZEU5WFc4aFdDdXlEWlBvUHM2S05CcTA5R0tzNHZ1aVlOS21TTEZs?=
 =?utf-8?B?dkowQVU5Z2UzL29CMWNGRkxXckN0WkJIVFdtS2FsUUxnYkRaamhPekFlSmxS?=
 =?utf-8?B?UzRxblhTb2F2eXZNYkpsWk8yYWJiSnRwTEJGWEt1QmY0ZmxVR25kS3J0TE9W?=
 =?utf-8?B?MGxBMWkwanN1YlBQdkpHbnkvaTBmaUlaSmZXRTZuZjZQSDlJVFhPTTNidDA0?=
 =?utf-8?B?WklqMFJLYmNmK1BxVzVEZDlGdUVyaG9GM0hFSVRHSk1DZWFoSW5qVVd1Q0xs?=
 =?utf-8?B?ZHBxM0h1Z2ZYTExlYTlxSEJjdE5NRmhUZVlNZnhUUWhTVGs5VjhtaVZVMXlp?=
 =?utf-8?B?YWlDeTVGS0hiRGppaTRCcWRpRjFIWjY2ck1MS2Qwd0NJOEo0NWt1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fae31e0-3d36-44b3-4a2d-08de4df36198
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 13:48:04.2548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dhg/jFAjDgu8F/tfVRZWISHFzECntEpT7CFLy8w6yI2XGJ70wucIZLlajRhg0gDOalwM59QBSur8TBm+q6fmN4EJ785EVG1CXiimJNOChmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9714

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiAwNyBKYW51YXJ5
IDIwMjYgMTM6MTgNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiA4LzhdIGRtYWVuZ2luZTogc2g6
IHJ6LWRtYWM6IEFkZCBkZXZpY2Vfe3BhdXNlLHJlc3VtZX0oKSBjYWxsYmFja3MNCj4gDQo+IEhp
LCBCaWp1LA0KPiANCj4gT24gMTIvMjMvMjUgMTY6NDMsIEJpanUgRGFzIHdyb3RlOg0KPiA+IEhp
IENsYXVkaXUsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJv
bTogQ2xhdWRpdSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+PiBTZW50OiAyMyBEZWNl
bWJlciAyMDI1IDEzOjUwDQo+ID4+IFN1YmplY3Q6IFtQQVRDSCB2NiA4LzhdIGRtYWVuZ2luZTog
c2g6IHJ6LWRtYWM6IEFkZA0KPiA+PiBkZXZpY2Vfe3BhdXNlLHJlc3VtZX0oKSBjYWxsYmFja3MN
Cj4gPj4NCj4gPj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJl
bmVzYXMuY29tPg0KPiA+Pg0KPiA+PiBBZGQgc3VwcG9ydCBmb3IgZGV2aWNlX3twYXVzZSwgcmVz
dW1lfSgpIGNhbGxiYWNrcy4gVGhlc2UgYXJlIHJlcXVpcmVkIGJ5IHRoZSBSWi9HMkwgU0NJRkEg
ZHJpdmVyLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRp
dS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+IC0tLQ0KPiA+Pg0KPiA+PiBDaGFuZ2Vz
IGluIHY2Og0KPiA+PiAtIHNldCBDSENUUkxfU0VUU1VTIGZvciBwYXVzZSBhbmQgQ0hDVFJMX0NM
UlNVUyBmb3IgcmVzdW1lDQo+ID4+IC0gZHJvcHBlZCByZWFkLW1vZGlmeS11cGRhdGUgYXBwcm9h
Y2ggZm9yIENIQ1RSTCB1cGRhdGVzIGFzIHRoZQ0KPiA+PiAgICBIVyByZXR1cm5zIHplcm8gd2hl
biByZWFkaW5nIENIQ1RSTA0KPiA+PiAtIG1vdmVkIHRoZSByZWFkX3BvbGxfdGltZW91dF9hdG9t
aWMoKSB1bmRlciBzcGluIGxvY2sgdG8NCj4gPj4gICAgZW5zdXJlIGF2b2lkIGFueSByYWNlcyBi
L3cgcGF1c2UgYW5kIHJlc3VtZSBmdW5jdGlvbmFsaXRpZXMNCj4gPj4NCj4gPj4gQ2hhbmdlcyBp
biB2NToNCj4gPj4gLSB1c2VkIHN1c3BlbmQgY2FwYWJpbGl0eSBvZiB0aGUgY29udHJvbGxlciB0
byBwYXVzZS9yZXN1bWUNCj4gPj4gICAgdGhlIHRyYW5zZmVycw0KPiA+Pg0KPiA+PiAgIGRyaXZl
cnMvZG1hL3NoL3J6LWRtYWMuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9zaC9yei1kbWFjLmMgYi9kcml2ZXJzL2RtYS9zaC9y
ei1kbWFjLmMNCj4gPj4gaW5kZXggNDRmMGY3MmNiY2YxLi4zNzdiZGQ1Yzk0MjUNCj4gPj4gMTAw
NjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZG1hL3NoL3J6LWRtYWMuYw0KPiA+PiArKysgYi9kcml2
ZXJzL2RtYS9zaC9yei1kbWFjLmMNCj4gPj4gQEAgLTEzNSwxMCArMTM1LDEyIEBAIHN0cnVjdCBy
el9kbWFjIHsNCj4gPj4gICAjZGVmaW5lIENIQU5ORUxfOF8xNV9DT01NT05fQkFTRQkweDA3MDAN
Cj4gPj4NCj4gPj4gICAjZGVmaW5lIENIU1RBVF9FUgkJCUJJVCg0KQ0KPiA+PiArI2RlZmluZSBD
SFNUQVRfU1VTCQkJQklUKDMpDQo+ID4+ICAgI2RlZmluZSBDSFNUQVRfRU4JCQlCSVQoMCkNCj4g
Pj4NCj4gPj4gICAjZGVmaW5lIENIQ1RSTF9DTFJJTlRNU0sJCUJJVCgxNykNCj4gPj4gICAjZGVm
aW5lIENIQ1RSTF9DTFJTVVMJCQlCSVQoOSkNCj4gPj4gKyNkZWZpbmUgQ0hDVFJMX1NFVFNVUwkJ
CUJJVCg4KQ0KPiA+PiAgICNkZWZpbmUgQ0hDVFJMX0NMUlRDCQkJQklUKDYpDQo+ID4+ICAgI2Rl
ZmluZSBDSENUUkxfQ0xSRU5ECQkJQklUKDUpDQo+ID4+ICAgI2RlZmluZSBDSENUUkxfQ0xSUlEJ
CQlCSVQoNCkNCj4gPj4gQEAgLTgyNyw2ICs4MjksMzggQEAgc3RhdGljIGVudW0gZG1hX3N0YXR1
cyByel9kbWFjX3R4X3N0YXR1cyhzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4sDQo+ID4+ICAgCXJldHVy
biBzdGF0dXM7DQo+ID4+ICAgfQ0KPiA+Pg0KPiA+PiArc3RhdGljIGludCByel9kbWFjX2Rldmlj
ZV9wYXVzZShzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4pIHsNCj4gPj4gKwlzdHJ1Y3QgcnpfZG1hY19j
aGFuICpjaGFubmVsID0gdG9fcnpfZG1hY19jaGFuKGNoYW4pOw0KPiA+PiArCXUzMiB2YWw7DQo+
ID4+ICsJaW50IHJldDsNCj4gPj4gKw0KPiA+PiArCXNjb3BlZF9ndWFyZChzcGlubG9ja19pcnFz
YXZlLCAmY2hhbm5lbC0+dmMubG9jaykgew0KPiA+DQo+ID4+ICsJCXJ6X2RtYWNfY2hfd3JpdGVs
KGNoYW5uZWwsIENIQ1RSTF9TRVRTVVMsIENIQ1RSTCwgMSk7DQo+ID4NCj4gPg0KPiA+IFByb2Jh
Ymx5IGZpcnN0IHlvdSBuZWVkIHRvIGNoZWNrIENIU1RBVF9FTiBmaXJzdCBiZWZvcmUgc2V0dGlu
ZyBDSENUUkxfU0VUU1VTPz8NCj4gPg0KPiA+IEFzIHBlciB0aGUgaGFyZHdhcmUgbWFudWFsDQo+
ID4NCj4gPiAiDQo+ID4gU3VzcGVuZHMgdGhlIGN1cnJlbnQgRE1BIHRyYW5zZmVyLiBTZXR0aW5n
IHRoaXMgYml0IHRvIDEgd2hlbiAxIGlzIHNldA0KPiA+IGluIEVOIG9mIHRoZSBDSFNUQVRfbi9u
UyByZWdpc3RlciBjYW4gc3VzcGVuZCB0aGUgY3VycmVudCBETUEgdHJhbnNmZXIuIg0KPiANCj4g
T0ssIEknbGwgdXBkYXRlIGl0IGFzIGZvbGxvd3M6DQo+IA0KPiBzdGF0aWMgaW50IHJ6X2RtYWNf
ZGV2aWNlX3BhdXNlKHN0cnVjdCBkbWFfY2hhbiAqY2hhbikgew0KPiAJc3RydWN0IHJ6X2RtYWNf
Y2hhbiAqY2hhbm5lbCA9IHRvX3J6X2RtYWNfY2hhbihjaGFuKTsNCj4gCXUzMiB2YWw7DQo+IA0K
PiAJZ3VhcmQoc3BpbmxvY2tfaXJxc2F2ZSkoJmNoYW5uZWwtPnZjLmxvY2spOw0KPiANCj4gCXZh
bCA9IHJ6X2RtYWNfY2hfcmVhZGwoY2hhbm5lbCwgQ0hTVEFULCAxKTsNCj4gCWlmICghKHZhbCAm
IENIU1RBVF9FTikpDQo+IAkJcmV0dXJuIDA7DQo+IA0KPiAJcnpfZG1hY19jaF93cml0ZWwoY2hh
bm5lbCwgQ0hDVFJMX1NFVFNVUywgQ0hDVFJMLCAxKTsNCj4gCXJldHVybiByZWFkX3BvbGxfdGlt
ZW91dF9hdG9taWMocnpfZG1hY19jaF9yZWFkbCwgdmFsLA0KPiAJCQkJCSh2YWwgJiBDSFNUQVRf
U1VTKSwgMSwgMTAyNCwNCj4gCQkJCQlmYWxzZSwgY2hhbm5lbCwgQ0hTVEFULCAxKTsNCj4gfQ0K
DQpPSy4NCg0KPiANCj4gVGhpcyBhdm9pZHMgdGltZW91dHMgcmVwb3J0ZWQgYnkgcmVhZF9wb2xs
X3RpbWVvdXRfYXRvbWljKCkgd2hlbiBwYXVzZSBpcyBzZXQgZm9yIGEgZGlzYWJsZWQgY2hhbm5l
bC4NCj4gDQo+ID4NCj4gPg0KPiA+PiArCQlyZXQgPSByZWFkX3BvbGxfdGltZW91dF9hdG9taWMo
cnpfZG1hY19jaF9yZWFkbCwgdmFsLA0KPiA+PiArCQkJCQkgICAgICAgKHZhbCAmIENIU1RBVF9T
VVMpLCAxLCAxMDI0LA0KPiA+PiArCQkJCQkgICAgICAgZmFsc2UsIGNoYW5uZWwsIENIU1RBVCwg
MSk7DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICsJcmV0dXJuIHJldDsNCj4gPj4gK30NCj4gPj4g
Kw0KPiA+PiArc3RhdGljIGludCByel9kbWFjX2RldmljZV9yZXN1bWUoc3RydWN0IGRtYV9jaGFu
ICpjaGFuKSB7DQo+ID4+ICsJc3RydWN0IHJ6X2RtYWNfY2hhbiAqY2hhbm5lbCA9IHRvX3J6X2Rt
YWNfY2hhbihjaGFuKTsNCj4gPj4gKwl1MzIgdmFsOw0KPiA+PiArCWludCByZXQ7DQo+ID4+ICsN
Cj4gPj4gKwlzY29wZWRfZ3VhcmQoc3BpbmxvY2tfaXJxc2F2ZSwgJmNoYW5uZWwtPnZjLmxvY2sp
IHsNCj4gPg0KPiA+DQo+ID4+ICsJCXJ6X2RtYWNfY2hfd3JpdGVsKGNoYW5uZWwsIENIQ1RSTF9D
TFJTVVMsIENIQ1RSTCwgMSk7DQo+ID4NCj4gPg0KPiA+IFNpbWlsYXJseSwgZmlyc3QgeW91IG5l
ZWQgdG8gY2hlY2sgIENIU1RBVF9TVVMgYml0IGZpcnN0IGFuZCB0aGVuIGNsZWFyIHN1c3BlbmQg
c3RhdGUuDQo+ID4NCj4gPg0KPiA+IENsZWFycyB0aGUgc3VzcGVuZCBzdGF0dXMuIFNldHRpbmcg
dGhpcyBiaXQgdG8gMSB3aGVuIDEgaXMgc2V0IGluIFNVUw0KPiA+IG9mIHRoZSBDSFNUQVRfbi9u
UyByZWdpc3RlciBjYW4gY2xlYXIgdGhlIHN1c3BlbmQgc3RhdHVzLg0KPiANCj4gSSdsbCB1cGRh
dGUgdGhpcyBvbmUgYXMgZm9sbG93cywgdG8ga2VlcCB0aGUgY29kZSBzaW1wbGU6DQo+IA0KPiBz
dGF0aWMgaW50IHJ6X2RtYWNfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4pIHsN
Cj4gCXN0cnVjdCByel9kbWFjX2NoYW4gKmNoYW5uZWwgPSB0b19yel9kbWFjX2NoYW4oY2hhbik7
DQo+IAl1MzIgdmFsOw0KPiANCj4gCWd1YXJkKHNwaW5sb2NrX2lycXNhdmUpKCZjaGFubmVsLT52
Yy5sb2NrKTsNCj4gDQo+ICAgICAgICAgIC8qIERvIG5vdCBjaGVjayBDSFNUQVRfU1VTIGJ1dCBy
ZWx5IG9uIEhXIGNhcGFiaWxpdGllcy4gKi8NCj4gCXJ6X2RtYWNfY2hfd3JpdGVsKGNoYW5uZWws
IENIQ1RSTF9DTFJTVVMsIENIQ1RSTCwgMSk7DQo+IAlyZXR1cm4gcmVhZF9wb2xsX3RpbWVvdXRf
YXRvbWljKHJ6X2RtYWNfY2hfcmVhZGwsIHZhbCwNCj4gCQkJCQkhKHZhbCAmIENIU1RBVF9TVVMp
LCAxLCAxMDI0LA0KPiAJCQkJCWZhbHNlLCBjaGFubmVsLCBDSFNUQVQsIDEpOw0KPiB9DQo+IA0K
PiBXaXRoIHRoaXM6DQo+IA0KPiAxLyBpbiBjYXNlIHRoZSBjaGFubmVsIGlzIG5vdCBzdXNwZW5k
ZWQgYW5kIHRoZSBDSENUUkxfQ0xSU1VTIGlzIHNldCwgdGhlIHJlYWRfcG9sbF90aW1lb3V0X2F0
b21pYygpDQo+IHdpbGwgbm90IHRpbWVvdXQsIGFzIHRoZSBkZWZhdWx0IHZhbHVlIG9mIHRoZSBD
SFNUQVRfU1VTIGlzIHplcm8uDQoNCkp1c3QgYSBxdWVzdGlvbiBhcyB3ZSBhcmUgbm90IGZvbGxv
d2luZyB0aGUgaGFyZHdhcmUgbWFudWFsLg0KDQpBdCBoYXJkd2FyZSBsZXZlbCBkb2VzIGl0IGhh
dmUgYW55IGltcGxpY2F0aW9ucz8gDQoNCkVnOiB3ZSBzZXQgdGhpcyB3cml0ZSBvbmx5IHJlZ2lz
dGVyIHdpdGhvdXQgdGhlIGRldmljZSBiZWluZyBzdXNwZW5kZWQgDQogICAgDQoNClRoZSBuZXh0
IHN1c3BlbmQgb3BlcmF0aW9uLCBpbW1lZGlhdGVseSBjbGVhcnMgdGhlIHN1c3BlbmQgb3BlcmF0
aW9uDQogICAgDQogICAgT3IgDQoNCmRvZXMgaXQgd29yayBub3JtYWxseS4NCg0KQ2hlZXJzLA0K
QmlqdQ0KDQo=

