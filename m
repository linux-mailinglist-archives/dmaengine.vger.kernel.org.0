Return-Path: <dmaengine+bounces-4520-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E00A3AA3A
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 21:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F613A437E
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2025 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5C71DDA17;
	Tue, 18 Feb 2025 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="jbSeqXub"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22B1A3178;
	Tue, 18 Feb 2025 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739911170; cv=fail; b=rXZOwC0nIaY1znzEfjiXksDhtC043ouIBx94JuDdtqm7Ho5r7po+orDHnE0l3quGyyXRdbtVctcTmVKP2AmkaRkmMWdbfWpU5WFCtEkhSRgolUzpQMJnv1rbDPAzSwRMLwvor/RVplvRoM9yRktKml7/sUkSIlE9ZkW+s8fH9QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739911170; c=relaxed/simple;
	bh=cfI93uWV4DxmCTqgbBX2Qn26yzVd/ajis6pU6poitIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxPXa8vxP7mqlxgCLXPyWt68XPkkZuTsHK8JMFtKTdxrbF2d5fHPXaCtfcp6PudWPxwmlehqrClJnHkgHB+eyJW+4tmg2g7rAZUV+l1lttz2yCYLhX/U6MsuOQXbYLOBnQKfIt6aUzv4Q3677jyshqX/xd+iuRNVBTpAiISvaD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=jbSeqXub; arc=fail smtp.client-ip=52.101.229.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGFWF+8IrVBc+LMkmvVYWVvr2tW3YNPG3WFwH0IbSKQ4WuEunG/D6nCz4r/cbwsi2YMoZf/duFGaJiqJmYbC8SsNCq5JGruiWM/zCoVv1EfvyEoq/oaK/AUh4owcL7cOG6TXD7b3m9LER3LPJebenXn0ErqUvkjc2tTZcZBosbP2eo9PEmMSxsLudxvgaKZ/kk/BCdniKgdoggTcPVU3oq1o0TzxwYcCEnHK5/p6JxUrw7m9BI/aw8sIAuF62dLcz90jrkaJvqWJUClcB647nC+QFAkyxXhlUzmLz7LuwbHHnfRc/clNxXYcRPd+kPFvMbWB7vKtaV4TUAivxvqD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfI93uWV4DxmCTqgbBX2Qn26yzVd/ajis6pU6poitIM=;
 b=OiwQdWpEJXO4mcLFAR9lVMpYqF13cnpV+yEDeenjpDM9JM3FkFptHfm/07NF5JKMAlHEU8k53nh9P+ONo6i6NF+mdNNfwAko5yFnK49tP67aDnR4A9Ruyz3wpvvzs3ktrq+r5NkaKADJG8VzUVG1t34I7Gjjq+CVOff0e5L4Vwu4X9zk53aQfAiIQIAZOINz5KY7i2fp0LKi4CWvMcnK2q+HvVPq0IJfRv4ahTtwcWBWGdeYUOsnhyJGmW0oYvLaBPjPeBOfYsuFujMFqPvyBHEFEYvFvbiJAIOfHcRAt8qM/k8BkLXh26lhXYWaIVJXnl7sywnl3N4okA/TL7W6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfI93uWV4DxmCTqgbBX2Qn26yzVd/ajis6pU6poitIM=;
 b=jbSeqXubYQFXea6tXesAPGTWAMpQVLH7YHwOKksxHhJQ+IqvANVivHX45eU+VbB2q+VcOtTjEblnupaTjpIlEn1BUmeD8RpL0yz0Q57iInNZljLUAaQvGpYNGj90U/1lYVK4RbFoUfGWkBOkpiqi+Bq9970UBS4N58nb0z1TgiU=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TY4PR01MB14736.jpnprd01.prod.outlook.com (2603:1096:405:25a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 20:39:24 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%6]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 20:39:23 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v2 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Topic: [PATCH v2 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Index: AQHbfZtdxIDYq1hzdkW2ZqTI1jppObNFSWGAgAglSRA=
Date: Tue, 18 Feb 2025 20:39:23 +0000
Message-ID:
 <TYCPR01MB12093E4F42DF6FCC966135A93C2FA2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250212221305.431716-1-fabrizio.castro.jz@renesas.com>
 <20250212221305.431716-7-fabrizio.castro.jz@renesas.com>
 <CAMuHMdVUr6Z1o6MhxOj18d8rwV8O-AJQxWFEpMT8pcvb=DHB3A@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVUr6Z1o6MhxOj18d8rwV8O-AJQxWFEpMT8pcvb=DHB3A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TY4PR01MB14736:EE_
x-ms-office365-filtering-correlation-id: ba82de22-f41b-481a-1566-08dd505c5458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUQwMXA5amgybjNpNDY1WW9PRnVabHk0d0lrWHZwY1dKcXEwZGZFMms2Z1o1?=
 =?utf-8?B?djBUTzk5ZXN5cWlCSkx2MDVXWElOVDR1SnJXYkk5S280cjBKTnZ0N2dPNUxo?=
 =?utf-8?B?eHNOKzVRMzV1RC9LMDFGaWZxTzFMWHkxUFJla1JKb0s5aXV4dWVCakZZZE45?=
 =?utf-8?B?TlBVUFlYK3FxS2pHbmh5STB3RitJOUZyVDdiU3JsTzJteDdWNmQ3ZEpiVWpl?=
 =?utf-8?B?MStDNmw2WHMwcHJ1a1V1dG1VaUwzOTFVN1dOTVVHL3IyL2NwRUMvcmxUVGl3?=
 =?utf-8?B?VXBBTEVsd0NSczM0SlIxQ2lVNlhHUGhNbGNpbGFIUTNza25qdVNIbTZacndl?=
 =?utf-8?B?b2JzSXoyNUs0VXJ4YmJBSTY4SGpLWnhpMHJzdVJsTDk1Q2MyaThMa3Vqdkx0?=
 =?utf-8?B?MlhvSnZmZCtDTWdFd3dGcjN1MU53bXdqYzNNNXBxTFhENFc1dEs2bVZodCtO?=
 =?utf-8?B?YlJBRi9jNGhxeXJiSlRYSzVkeW55dXc1MitxVytZaG50Wnl4dURmSXFwNWJa?=
 =?utf-8?B?RU5jK2pjUy9IVXF1NUZCWVdTMEpRZUFtTXFnWW1lem50M1NaNU5STmpPbmIy?=
 =?utf-8?B?b0ZiamYrREFWZmJlS1Qxd2xzeFBlR3VPYXl6N1VyZTBPcnJwTk1LZUVhNEpE?=
 =?utf-8?B?QnVHZTZXSUJHZUZCNTZ6SllDeVludVNDZVNWbkFySnlGWnluekdialRSb0Zz?=
 =?utf-8?B?TWdVZWh6RElRRE9NR1Rta245OTZoYXNGRFIvd1JMRDhNdFVGUmVwNHlKOWxX?=
 =?utf-8?B?UTVXa1Y0WTBvc1dMVUFCblNETUlLd3M4NWFUVmtnaXBqTXl6YlViRGgzbnNj?=
 =?utf-8?B?bTRPR2o0Rk9VRk5HU1k3Yko3cWdoZko5bG9abG9xY0xHUkYyWXk0WnVRQkVO?=
 =?utf-8?B?cy9KNkZzM29vRXJLOUV2VTFtTTVXUGl3aTVpSzlvQXZhSG1DTXM4cFcvcm9o?=
 =?utf-8?B?bFU4OXk2YnJUN2RLRjIwK1lZQmEyNTA0U1hqSlNMcHhoNGRtaXJFYlVCaS8v?=
 =?utf-8?B?em1qdjJTSGZHRWw2TjJid1FUL2N5aHE3WFRCUUt0WnFYZmZNcUMwcWM2ZG5U?=
 =?utf-8?B?enFRSXFheExwYzRTNnc4Z2FNWjd5eEdSMS9iOWRLTnB5Q1gxZnowS1h6azh3?=
 =?utf-8?B?T21uU3ZJTjdxbVkrWXNzRUx5cHIvTUJEV0FESmZMU3VHVmxSSlcxdng1d2Fm?=
 =?utf-8?B?UEJENWdvVmNXdElMZmEzWDhRWTdwK0RpNUFiaHY4RVpnZFpIWXdEaCtpZ1M1?=
 =?utf-8?B?dXhBdlpZZjlqelgxak5ScWxaTlBBT3FGV2FiWFE0SzJpVFRFYlBsbnUrbUZw?=
 =?utf-8?B?QlJBYU5CcC9kc09YWGh2WngvSnBhTm9PM1JJRGxrOCsrdEt0UDFVbGV6M2tr?=
 =?utf-8?B?QzR1V0xTa1BXZFdYdWFiQW8xbmhyM2MyQnFidk9kTlZUKzRNak5hQ29jeVBG?=
 =?utf-8?B?ZkNZUjRrUUhIVWZSYmU4MUhBWUg0TUNRNTRQZnZCOUpDTGZOaEFHMFZtejhJ?=
 =?utf-8?B?bElDbEVVYmVnb3lzZHh3UlM3THlZb1N0Vk5yZXB0WTY2eWRReUdCUWRBcDQy?=
 =?utf-8?B?R3VjbjhlT3I2aWhqUVNrZUFYRW1KZU9tT0xISXFSVW13czc3SS9SNDNwTVZr?=
 =?utf-8?B?VUtQNERkNDlEYUJvVnlaNktDenlTQmpRdWErZ0F1d0xab29wNnpHbFJMNWhk?=
 =?utf-8?B?dFlROW12NC9XWkttdkZ2SVZRNzdRMUl4bEQ0ejFYZng4aDNxSnZyZWlzTmtY?=
 =?utf-8?B?MjV4YXlYTzMyRWNkUWoycS9MdjV1bFVJMDdmdzluZ01pVkJqSW5xdHVSd1RD?=
 =?utf-8?B?bTJicmp2RUZOSEtQQitpbmxvVStTcVlYazRRRDJmQ3haNEw0bHpnZllHT3pv?=
 =?utf-8?B?TXM0ZUVHZ0c2SzR0WlpzdUpacHNhQm1sVEFSQk80cnU5a3p4bFMvUWhXYTIw?=
 =?utf-8?Q?PVi6nwtSKK5sIWEE/ANt2Jzeg014lrkn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFlMVVZncGhic05tQ1ZzSVhOUUhOQlJGNU5mZUFVSzhWWEZhMjVOcWhZeUkr?=
 =?utf-8?B?a1dMSUlEVnhOVitEYmJCVm8yd1Nwcy9FVUlPU29SNmVMYUx4RS96QkNhL1pn?=
 =?utf-8?B?Zk5sbmJOdlg3c29SWFZwV09Hd0ZxdVlVUjRBY0ppSm9PRTNMcVdJdzFkNG9V?=
 =?utf-8?B?b3A2V0lISGpmVmc3dDJveVNNSWRUK3dkM0hKZGlDYXRCb1NPb2hJMW41eHZq?=
 =?utf-8?B?Ui9hWkFNNGlVdUhQYURYTTJhMjZocS9qdVdXNjI0QUZ1TUVSTEdyVmRqQ3hN?=
 =?utf-8?B?K2NIM3A2MlZaYVMwd21yUlBkSjJOODJNclp6Z21SL2hBcFV0M2tzV3pmZVlD?=
 =?utf-8?B?eUVublJiV1RxbTRTMUZOWFQ4eWc2TlZoa3Y1R3dmSUhWOEdIa254V3NFa2F2?=
 =?utf-8?B?SkVpSXlTYTY5M3N0djMxTVorMDhYUkl0ZkRDekdOb2JXNlZ3eUxWZ2FLS3g3?=
 =?utf-8?B?ZklTWi9kWmhOWEIxSkllYUsyNnh4V2xCQVJJcGtMdkIzUHl1YmJoRldCRzVx?=
 =?utf-8?B?WUxEV2dnTmpadW4weFVqTGE5djdscFVTano0MHhZTkdrUk5kd2ZoL1lmUWtl?=
 =?utf-8?B?SU10ajBmWm5qSUYxWWRHYjgzRG52a2Jham1mNkt4cllIci92QUJpY3JOQytn?=
 =?utf-8?B?c0pUM3R0ck1jRXlhdCtQeWcwcDRiVXVQREsxWnF6TmhsYUx1aHZNTHZYVkdB?=
 =?utf-8?B?MjE2VFJrRWhKVGZvcGFBYVZhT2xRb1NCaWZXK2Z3ZTdpdDBjUUpFZ0RvYUQx?=
 =?utf-8?B?Sk95NFVQUUVFS1Q2dUZ0VkRvR0JXQThXZ244NGdRUk1mRFdUSit4OFVWUXFR?=
 =?utf-8?B?amtZRG9JMTdjYUxLeFFpc0dNeUh4UVoxbUxGNTZMV2k3MVJsYXl4T1EyNHpM?=
 =?utf-8?B?UE5BNnJKRHhBbFZjUXJXOE5lNEJKRnpQTWt6Sy9ZVmFZTExwa1luZ1ZVUkpn?=
 =?utf-8?B?WkcxRitKSzRySEtiR3VaRVphUWRJb21RRlFvQWRPekI5YkJ3N05ETDJ0SHRX?=
 =?utf-8?B?WUtLYnNsQXAva0lMVDVoY1FJMFIzSWRHa3haOUQ5OWRFOEo3bEgxMDJWS1dy?=
 =?utf-8?B?TXBDYXFNeHdUNEJBRXJlNEtnUzJybm85ZTIwbFp6b0tWOVVnSjNlQmY3UzM5?=
 =?utf-8?B?WVV2VjE1a1FISGhjSG1Zd3ZMSDBCVHNaMHZmOXdKZVB4RlplVHYvVUs5emNN?=
 =?utf-8?B?ZzBUaEJseDVQOElqN0pITkxkY2dsd05xaUFHK3hqV0ZQTHBDRWkraWR6M0h1?=
 =?utf-8?B?UTBrRWNyRDVpelNOVHc3S1YxUGY0ZXBsa3FXYlVGOStiamtPWXZhbEVBaURB?=
 =?utf-8?B?anJXc3FvT1NxM2o2di9JRW9nbnNNMWRSd285SSs4Sjg4bWt5TlV5bE1XS3ZB?=
 =?utf-8?B?bGFLc3ZzS3hyL0tUalhQdlhLRC9hTGJIb3BFTlVEb3ZxTnN6OTNSbEkwL2s4?=
 =?utf-8?B?SnpRTndkaVI2OFlzQVBOWTdRNDFhSFUwSjBOeERXWXp4Y29GemZrN2VBZkk5?=
 =?utf-8?B?RUdMWXJCRjZobmpoMlJLOE5qY05YQmFPNlRKVGprdW9rQ25DTU5wbk9tYzB5?=
 =?utf-8?B?Tjd6SWNPb2tHbERDZTBGYUFobzF6WG1NN0d0RER2aktNOWs1ek9DaEkwV0pK?=
 =?utf-8?B?c3hCK1k5UFlHcjlKYTBCVUJVSFVwWjVLOGcvTUx2Y3NpN3JGRHF2by9PUU9X?=
 =?utf-8?B?SWlWWktmeWY2QyszYnRlaTJIcDZYUXptME14eGZxUW1qSi90dHN1a1VGNjlp?=
 =?utf-8?B?RlJJZ0NKaThndkFRTG8zejJySGtocWY4Q0dncjBIa2UyK1czb0JubG4xejFr?=
 =?utf-8?B?Rmh1ckViY2dGMWpoWFZoSTV6WWhGZEIxNVk0SktjdERFTW5LWFVLSlRhd0pG?=
 =?utf-8?B?MXFhb05HREZ5OS8rUVNkcHkzaXM3ZDR3MUxBMy92VmJXOE82TCtUSWoybHpX?=
 =?utf-8?B?TUkxKzR1LzN0OEFidXZTeWtLMFdodTVDcVQ0eWdkMy95UysrdVBPZkcvQ29x?=
 =?utf-8?B?VmhsZXNuQjJXallMZWhaS0ZqRDlJZVRoUFNvdU1nT2o5ZksyeVZhRVdWN3Zo?=
 =?utf-8?B?NjM5TWZzQ1gxbVR6YkNzZHdwVWUrUjFLNHE3K2QraDVNZ2UxYVZIVEI3RHlj?=
 =?utf-8?B?bTAyOHpXbDFneWtoUzFmdnc5K0s5V25na3E3Wi9wMlRKRzMybEE5TnJlTkJw?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba82de22-f41b-481a-1566-08dd505c5458
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 20:39:23.8350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1l8EGW4zsZU3h7nfPcMqFYWs6G4R/50rDke6g3XsU43nyla67fooZ084VR5el/ncnPR9PvwkJEuE4sAOGQpfp3sUWHTPNyMSvWDvAP+xwUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14736

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAxMyBGZWJydWFyeSAy
MDI1IDE0OjIwDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNi83XSBkbWFlbmdpbmU6IHNoOiBy
ei1kbWFjOiBBZGQgUlovVjJIKFApIHN1cHBvcnQNCj4gDQo+IEhpIEZhYnJpemlvLA0KPiANCj4g
T24gV2VkLCAxMiBGZWIgMjAyNSBhdCAyMzoxMywgRmFicml6aW8gQ2FzdHJvDQo+IDxmYWJyaXpp
by5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IFRoZSBETUFDIElQIGZvdW5kIG9u
IHRoZSBSZW5lc2FzIFJaL1YySChQKSBmYW1pbHkgb2YgU29DcyBpcw0KPiA+IHNpbWlsYXIgdG8g
dGhlIHZlcnNpb24gZm91bmQgb24gdGhlIFJlbmVzYXMgUlovRzJMIGZhbWlseSBvZg0KPiA+IFNv
Q3MsIGJ1dCB0aGVyZSBhcmUgc29tZSBkaWZmZXJlbmNlczoNCj4gPiAqIEl0IG9ubHkgdXNlcyBv
bmUgcmVnaXN0ZXIgYXJlYQ0KPiA+ICogSXQgb25seSB1c2VzIG9uZSBjbG9jaw0KPiA+ICogSXQg
b25seSB1c2VzIG9uZSByZXNldA0KPiA+ICogSW5zdGVhZCBvZiB1c2luZyBNSUQvSVJEIGl0IHVz
ZXMgUkVRIE5PL0FDSyBOTw0KPiA+ICogSXQgaXMgY29ubmVjdGVkIHRvIHRoZSBJbnRlcnJ1cHQg
Q29udHJvbCBVbml0IChJQ1UpDQo+ID4gKiBPbiB0aGUgUlovRzJMIHRoZXJlIGlzIG9ubHkgMSBE
TUFDLCBvbiB0aGUgUlovVjJIKFApIHRoZXJlIGFyZSA1DQo+ID4NCj4gPiBBZGQgc3BlY2lmaWMg
c3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMgUlovVjJIKFApIGZhbWlseSBvZiBTb0MgYnkNCj4gPiB0
YWNrbGluZyB0aGUgYWZvcmVtZW50aW9uZWQgZGlmZmVyZW5jZXMuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4N
Cj4gPiAtLS0NCj4gPiB2MS0+djI6DQo+ID4gKiBTd2l0Y2hlZCB0byBuZXcgbWFjcm9zIGZvciBt
aW5pbXVtIHZhbHVlcy4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHVwZGF0ZSENCj4gDQo+ID4gLS0t
IGEvZHJpdmVycy9kbWEvc2gvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvZG1hL3NoL0tjb25m
aWcNCj4gPiBAQCAtNTMsNiArNTMsNyBAQCBjb25maWcgUlpfRE1BQw0KPiA+ICAgICAgICAgZGVw
ZW5kcyBvbiBBUkNIX1I3UzcyMTAwIHx8IEFSQ0hfUlpHMkwgfHwgQ09NUElMRV9URVNUDQo+ID4g
ICAgICAgICBzZWxlY3QgUkVORVNBU19ETUENCj4gPiAgICAgICAgIHNlbGVjdCBETUFfVklSVFVB
TF9DSEFOTkVMUw0KPiA+ICsgICAgICAgc2VsZWN0IFJFTkVTQVNfUlpWMkhfSUNVDQo+IA0KPiBU
aGlzIGVuYWJsZXMgUkVORVNBU19SWlYySF9JQ1UgdW5jb25kaXRpb25hbGx5LCB3aGlsZSBpdCBp
cyBvbmx5DQo+IHJlYWxseSBuZWVkZWQgb24gUlovVjJILCBhbmQgbm90IG9uIG90aGVyIGFybTY0
IFNvQ3MsIG9yIG9uIGFybTMyDQo+IG9yIHJpc2N2IFNvQ3MuDQoNCkdvb2QgcG9pbnQsIEknbGwg
Zm9sbG93IHVwIG9uIHRoaXMgb24geW91ciBvdGhlciBlbWFpbC4NCg0KPiANCj4gPiAgICAgICAg
IGhlbHANCj4gPiAgICAgICAgICAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgdGhlIGdlbmVyYWwgcHVy
cG9zZSBETUEgY29udHJvbGxlciB0eXBpY2FsbHkNCj4gPiAgICAgICAgICAgZm91bmQgaW4gdGhl
IFJlbmVzYXMgUlogU29DIHZhcmlhbnRzLg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9z
aC9yei1kbWFjLmMgYi9kcml2ZXJzL2RtYS9zaC9yei1kbWFjLmMNCj4gPiBpbmRleCBkN2E0Y2Uy
ODA0MGIuLjI0YThjNmEzMzdkNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RtYS9zaC9yei1k
bWFjLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9zaC9yei1kbWFjLmMNCj4gPiBAQCAtMTQsNiAr
MTQsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvZG1hZW5naW5lLmg+DQo+ID4gICNpbmNsdWRl
IDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+
ICsjaW5jbHVkZSA8bGludXgvaXJxY2hpcC9pcnEtcmVuZXNhcy1yenYyaC5oPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgvbGlzdC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+IEBAIC0yOCw2ICsyOSwxMSBAQA0KPiA+ICAjaW5j
bHVkZSAiLi4vZG1hZW5naW5lLmgiDQo+ID4gICNpbmNsdWRlICIuLi92aXJ0LWRtYS5oIg0KPiA+
DQo+ID4gK2VudW0gcnpfZG1hY190eXBlIHsNCj4gPiArICAgICAgIFJaX0RNQUNfUlpHMkwsDQo+
ID4gKyAgICAgICBSWl9ETUFDX1JaVjJILA0KPiANCj4gU28gYmFzaWNhbGx5IHRoZXNlIG1lYW4g
IWhhc19pY3UgcmVzcGVjdGl2ZWx5IGhhc19pY3UgKG1vcmUgYmVsb3cpLi4uDQoNClllcy4NCg0K
PiANCj4gPiArfTsNCj4gPiArDQo+ID4gIGVudW0gIHJ6X2RtYWNfcHJlcF90eXBlIHsNCj4gPiAg
ICAgICAgIFJaX0RNQUNfREVTQ19NRU1DUFksDQo+ID4gICAgICAgICBSWl9ETUFDX0RFU0NfU0xB
VkVfU0csDQo+ID4gQEAgLTg1LDIwICs5MSwzMiBAQCBzdHJ1Y3QgcnpfZG1hY19jaGFuIHsNCj4g
PiAgICAgICAgICAgICAgICAgc3RydWN0IHJ6X2xtZGVzYyAqdGFpbDsNCj4gPiAgICAgICAgICAg
ICAgICAgZG1hX2FkZHJfdCBiYXNlX2RtYTsNCj4gPiAgICAgICAgIH0gbG1kZXNjOw0KPiA+ICsN
Cj4gPiArICAgICAgIC8qIFJaL1YySCBJQ1UgcmVsYXRlZCBzaWduYWxzICovDQo+ID4gKyAgICAg
ICB1MTYgcmVxX25vOw0KPiA+ICsgICAgICAgdTggYWNrX25vOw0KPiANCj4gVGhpcyBjb3VsZCBi
ZSBhbiBhbm9ueW1vdXMgdW5pb24gd2l0aCBtaWRfcmlkLCBhcyBtaWRfcmlkIGlzDQo+IG11dHVh
bGx5LWV4Y2x1c2l2ZSB3aXRoIHJlcV9ubyBhbmQgYWNrX25vLg0KDQpJbmRlZWQsIEknbGwgYWRq
dXN0IGFjY29yZGluZ2x5Lg0KDQo+IA0KPiA+ICB9Ow0KPiANCj4gPiBAQCAtODI0LDYgKzkwNyw0
MCBAQCBzdGF0aWMgaW50IHJ6X2RtYWNfY2hhbl9wcm9iZShzdHJ1Y3QgcnpfZG1hYyAqZG1hYywN
Cj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCByel9k
bWFjX3BhcnNlX29mX2ljdShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCByel9kbWFjICpkbWFj
KQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKmljdV9ucCwgKm5wID0g
ZGV2LT5vZl9ub2RlOw0KPiA+ICsgICAgICAgc3RydWN0IG9mX3BoYW5kbGVfYXJncyBhcmdzOw0K
PiA+ICsgICAgICAgdWludDMyX3QgZG1hY19pbmRleDsNCj4gPiArICAgICAgIGludCByZXQ7DQo+
ID4gKw0KPiA+ICsgICAgICAgcmV0ID0gb2ZfcGFyc2VfcGhhbmRsZV93aXRoX2ZpeGVkX2FyZ3Mo
bnAsICJyZW5lc2FzLGljdSIsIDEsIDAsICZhcmdzKTsNCj4gPiArICAgICAgIGlmIChyZXQpDQo+
ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgaWN1X25w
ID0gYXJncy5ucDsNCj4gPiArICAgICAgIGRtYWNfaW5kZXggPSBhcmdzLmFyZ3NbMF07DQo+ID4g
Kw0KPiA+ICsgICAgICAgaWYgKGRtYWNfaW5kZXggPiBSWlYySF9NQVhfRE1BQ19JTkRFWCkgew0K
PiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkRNQUMgaW5kZXggJXUgaW52YWxpZC5c
biIsIGRtYWNfaW5kZXgpOw0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPiA+
ICsgICAgICAgICAgICAgICBnb3RvIGZyZWVfaWN1X25wOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsN
Cj4gPiArICAgICAgIGRtYWMtPmljdS5wZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShpY3Vf
bnApOw0KPiANCj4gV2hhdCBpZiB0aGUgRE1BQyBpcyBwcm9iZWQgYmVmb3JlIHRoZSBJQ1U/DQoN
ClRoaXMgZG9lc24ndCBsb29rIGxpa2UgYSBwb3NzaWJsZSBzY2VuYXJpbywgYXMgaXJxY2hpcHMg
YXJlIGluaXRpYWxpemVkIHZlcnkgZWFybHkuDQoNCj4gSXMgdGhlIHJldHVybmVkIHBkZXYgdmFs
aWQ/DQo+IFdpbGwgcnp2MmhfaWN1X3JlZ2lzdGVyX2RtYV9yZXFfYWNrKCkgY3Jhc2ggd2hlbiBk
ZXJlZmVyZW5jaW5nIHByaXY/DQoNCkV2ZW4gdGhvdWdoIGl0IGRvZXNuJ3Qgc2VlbSBwb3NzaWJs
ZSBmb3IgdGhlIElDVSBkcml2ZXIgdG8gZ2V0IHByb2JlZCBhZnRlciB0aGUgRE1BQw0KZHJpdmVy
LCBJIGhhdmUgc3RpbGwgbG9va2VkIGludG8gcG9zc2libGUgd2F5cyB5b3VyIGNvbW1lbnQgY291
bGQgYXBwbHksIGFuZCBJIGhhdmUNCmZvdW5kIG9uZSwgYWx0aG91Z2ggaXQgY2FuJ3QgcmVhbGx5
IGhhcHBlbiBpbiBwcmFjdGljZSwgYXMgdGhlIHN5c3RlbSB3aWxsIGhhbmcgYmVmb3JlDQpnZXR0
aW5nIHRoZXJlLg0KDQpJZiB0aGUgcHJvYmluZyBvZiB0aGUgSUNVIGRyaXZlciBfZmFpbHNfLCB0
aGVuIG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoKSByZXR1cm5zIGEgdmFsaWQNCnBvaW50ZXIuIEF0
IHNvbWUgcG9pbnQgd2UgY2FsbCBpbnRvIHJ6djJoX2ljdV9yZWdpc3Rlcl9kbWFfcmVxX2Fjaygp
LCBhbmQgdGhlIGZpcnN0IHRpbWUNCndlIGRvIGFueXRoaW5nIHdpdGggYHByaXZgIHdlIGRlYWwg
d2l0aCBhIE5VTEwgcG9pbnRlci4NCg0KSG93ZXZlciwgaWYgdGhlIHByb2Jpbmcgb2YgdGhlIElD
VSBkcml2ZXIgZmFpbHMsIHRoZSBzeXN0ZW0gaGFuZ3MgdmVyeSBlYXJseSBvbiBiZWNhdXNlDQp0
aGUgSUNVIGlzIHRoZSBpbnRlcnJ1cHQgcGFyZW50IG9mIHRoZSBwaW50Y3RybCBub2RlLg0KDQpJ
biBvcmRlciB0byBzZWUgdGhlIGZhaWx1cmUgSSBoYXZlIGRlc2NyaWJlZCBJIGhhZCB0byB0YWtl
IGBpbnRlcnJ1cHQtcGFyZW50ID0gPCZpY3U+O2ANCm91dCBvZiB0aGUgcGluY3RybCBub2RlLCBv
biB0b3Agb2YgbWFudWFsbHkgbWFrZSB0aGUgSUNVIGRyaXZlciBmYWlsLg0KDQpJZiB0aGUgSUNV
IGRyaXZlciBmYWlscyBpdHMgaW5pdGlhbGl6YXRpb24gdGhlIHN5c3RlbSBpcyBnb25lLCBhbmQg
bm90IGJlY2F1c2Ugb2YgRE1BQywNCnRoZXJlZm9yZSBJJ2xsIGxlYXZlIHRoaXMgYml0IHVuY2hh
bmdlZCBmb3IgdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgc2VyaWVzLg0KDQo+IA0KPiA+ICsgICAg
ICAgaWYgKCFkbWFjLT5pY3UucGRldikgew0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSAtRU5P
REVWOw0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGZyZWVfaWN1X25wOw0KPiA+ICsgICAgICAg
fQ0KPiA+ICsNCj4gPiArICAgICAgIGRtYWMtPmljdS5kbWFjX2luZGV4ID0gZG1hY19pbmRleDsN
Cj4gPiArDQo+ID4gK2ZyZWVfaWN1X25wOg0KPiA+ICsgICAgICAgb2Zfbm9kZV9wdXQoaWN1X25w
KTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICBz
dGF0aWMgaW50IHJ6X2RtYWNfcGFyc2Vfb2Yoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgcnpf
ZG1hYyAqZG1hYykNCj4gPiAgew0KPiA+ICAgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucCA9
IGRldi0+b2Zfbm9kZTsNCj4gPiBAQCAtODU5LDYgKzk3Niw3IEBAIHN0YXRpYyBpbnQgcnpfZG1h
Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+DQo+ID4gICAgICAgICBk
bWFjLT5kZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICAgICAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEo
cGRldiwgZG1hYyk7DQo+ID4gKyAgICAgICBkbWFjLT50eXBlID0gKGVudW0gcnpfZG1hY190eXBl
KW9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkbWFjLT5kZXYpOw0KPiANCj4gKHVpbnRwdHJfdCkN
Cj4gDQo+IEJ1dCBhcyAicmVuZXNhcyxpY3UiIGlzIGEgcmVxdWlyZWQgcHJvcGVydHkgZm9yIFJa
L1YySCwgcGVyaGFwcyB5b3UNCj4gY2FuIGRldmlzZSB0aGUgaGFzX2ljdSBmbGFnIGF0IHJ1bnRp
bWU/DQoNCkknbGwgc3dpdGNoIHRvIHVzaW5nIHRoZSBoYXNfaWN1IGZsYWcgYXQgcnVudGltZS4N
Cg0KVGhhbmtzIQ0KDQpDaGVlcnMsDQpGYWINCg0KPiANCj4gPg0KPiA+ICAgICAgICAgcmV0ID0g
cnpfZG1hY19wYXJzZV9vZigmcGRldi0+ZGV2LCBkbWFjKTsNCj4gPiAgICAgICAgIGlmIChyZXQg
PCAwKQ0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90
cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4g
cGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNl
bGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVz
dCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

