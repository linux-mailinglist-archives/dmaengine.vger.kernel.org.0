Return-Path: <dmaengine+bounces-7904-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E0FCD98FB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 15:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B1843044B85
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E169B312836;
	Tue, 23 Dec 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="D4mYURbz"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010009.outbound.protection.outlook.com [52.101.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959B2D4B68;
	Tue, 23 Dec 2025 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766498920; cv=fail; b=U4znGpBeMLCdsF8C8B4L8mx1/6p48ms17Ao8d//WKFUY2Lmub//Rd+aF6RhQNaRQy2rlgc74K8vyAUxDOK8dVNKuAxyA4SfXcQVDZdpTkXlFRshb8SiXeXRcqvHGweM88aODTCAOsjHm9+EZPA7zT6rKJkRLMfyqLnXSSfUbqJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766498920; c=relaxed/simple;
	bh=mIUk9sYDXhcXztOMIAprrTm3lxOV0jaaqH5wyePxzlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SukN1mCpAQL4andrxK+IARaZsE3xoeqidgzsBSKuSL6lbxI+xkvv9F4RIasIuAvEVwe6UUbgUzfHms9mrGNNngq5wUwaiSaCl6ZKsp2S5++ooMKMnAb8vMrVpU8ykP7y42tsyu03XduzyK6jP+xasn+eJuSvMxS7XzK810uOLb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=D4mYURbz; arc=fail smtp.client-ip=52.101.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVPok5iEI4AaYuHip0LK4PkLYI+YVYXw/7aPzFUVkqbufK+JoGyF5gAvA7JNP6xEo2Ln/nmTW26UMJVyMM1HSrSlBxiGgYc4KXEzI5qS8RSv1rr2N+H4MgtK+H1b08gcgV6N9XcRBdyygYGKUDc40isy7OrKPVqVfJ1xfOyNEYd0/OM8YRmFGGWlollIR93BFAjbJMZxTFyJbD/fnbGuHclGyA1uW/MFAOuW/h0DQSPZPu8LCwmaG5MDGL7N7MK7+6W0ergDumd8CSM2Ciiqlkx/vkH6JBP3Yw6CJhjROIH4EBS4JjGCCdh2Cgf3ebbVZrXvbbFWc82PwgxRmm+NQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIUk9sYDXhcXztOMIAprrTm3lxOV0jaaqH5wyePxzlE=;
 b=xk6AXRb5stFZiNRwKiCgJswpv5C47M6RYKIb5l1WeQefT+VRKL6P66AZdA1/MkLIBln0kLe50Z6BrItMdIDWsn2GNmpoQOp4AnaC0dYOuOYIFbR+o9FNj7a4Nf6uM8xofdImVs7cNdx0ywrH/rm5QSeL0x0rC4KfiUCgwDvSwFCkgVbThc0JrJ8yYK73t9iPhvryTgNv0UfaKQWezIn3luCLt2Tt/6bnERddZudxyQKnUsZmLRQYSm6Fn2xx7nk5CtdXYoqybtl2U4Ks7TGgTrTr0SQ26Jj55XCC20Wy+RImjqLN4vQ+7BpZ08nfFwScqNoDxpq15+sL9yJOKhWCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIUk9sYDXhcXztOMIAprrTm3lxOV0jaaqH5wyePxzlE=;
 b=D4mYURbzNleyYdNBpoJENqm8BghZdCfMPFJ9zG8RCIgR6Tg9avXsXA5myzGwh53eAsmYkXMGCTEfdG1Hs2aXBpM4p/dfWWEEfwb5Rm3o4G3KBRwbFruSOhruBqQygfiKmybHwMunh0f2AMctie2KOvJMwB7Ym0n1KTKbzp2ScaI=
Received: from TYYPR01MB13955.jpnprd01.prod.outlook.com (2603:1096:405:1a6::6)
 by TYCPR01MB6755.jpnprd01.prod.outlook.com (2603:1096:400:b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.10; Tue, 23 Dec
 2025 14:08:34 +0000
Received: from TYYPR01MB13955.jpnprd01.prod.outlook.com
 ([fe80::52be:7d7a:35ec:4b29]) by TYYPR01MB13955.jpnprd01.prod.outlook.com
 ([fe80::52be:7d7a:35ec:4b29%7]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 14:08:29 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: geert <geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	magnus.damm <magnus.damm@gmail.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Johan Hovold <johan@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/6] dmaengine: sh: rz_dmac: make register_dma_req()
 chip-specific
Thread-Topic: [PATCH v2 2/6] dmaengine: sh: rz_dmac: make register_dma_req()
 chip-specific
Thread-Index: AQHcYsEOwZapbRicGUK5mHW5izV50rUvXzmAgAAD87A=
Date: Tue, 23 Dec 2025 14:08:29 +0000
Message-ID:
 <TYYPR01MB1395515AF65F8522AED6B591885B5A@TYYPR01MB13955.jpnprd01.prod.outlook.com>
References: <20251201124911.572395-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251201124911.572395-3-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdV=EW4YbEBiXH2p0SeC5Kw-YmYWuQwsudpGgM63pgqcfw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdV=EW4YbEBiXH2p0SeC5Kw-YmYWuQwsudpGgM63pgqcfw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB13955:EE_|TYCPR01MB6755:EE_
x-ms-office365-filtering-correlation-id: 061adfaa-7337-4b53-b69b-08de422cbfa1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0N6MkI4dkJCSWFTVHVhL2xoaDkxdmdlbG50N3FvSEJkZzNGaVlUdWVCMmN5?=
 =?utf-8?B?Nis1cC95QlJUK3FRTlVDb251UWEvZmZ1ck5CQjgrZ0I3d290bzY5RjdEOWZx?=
 =?utf-8?B?QnVsY3IxMExaNWdPRlV0aGJKTHdzMHRqSUdKeks3Nm5pT2JJNm1FVlYvRTdh?=
 =?utf-8?B?SkI0KytscUdSbnhWUTdvZjZkNkwwTmFWSHpRQTZIWTJjSlVkV2t0VmwzTFdp?=
 =?utf-8?B?aUpOSGhRRnhDRU1xYXA0dHpZcTBtVnBpcnozK0VMc0dKWERTZlZrbWNManc4?=
 =?utf-8?B?djZSOXlRa25MSWREYmxQUi9tYTM3Mk1ESlVGYUJwSWx1WHNLL2xzVno3YmFQ?=
 =?utf-8?B?WUZJZm5kcW1veUkxc1FkeVhkZEhWVEs4aUU3bjJidnVwc01LNHhxcWQ5WmNX?=
 =?utf-8?B?WnJQRGc1KzJhdTVGS2FRcUduREt1bXpkYjhmS2xpTndydXhvQmUzOElsRGUx?=
 =?utf-8?B?QlcwZnRjYUdsM3RYNjJUSW5FVmZOWnprV25yZEVuT1d2clQ1UXJZd08wU04z?=
 =?utf-8?B?R0xjcHYrbkQ3eXNSTXVDSWpUWlNpNUl3R3hMaXlWSVdJMUdUc2NzSzZjYWpx?=
 =?utf-8?B?NXRxTXJKdENTeVcvWTBKcjFSeUpla01NT015NWtGZDRlTmZwQnBoVUhJeHVE?=
 =?utf-8?B?RjVaU1dWbndKVHQvSkFuRGt6dWZmRjM1VjFHTDdxYTlkSTI1NUhRRHUwNmdB?=
 =?utf-8?B?dStObXdqdEVKd1daUXhqOVVJMDR0dWEwbGN2RVhsd1h1MTBudkNnT24yY2hZ?=
 =?utf-8?B?Sm41UU9JTnRaR0ZpOWtQdEFGRm9naWc5OVZpbFU0Mjl4QnNPejFWZW8rRzVr?=
 =?utf-8?B?UFU4YlpNZVlmNlgwdEY4Z0kvbVAyNVc4OUdFTUoweVp1UWYzc1FlNUtSSnp2?=
 =?utf-8?B?a1hrbkFjQzJZTERISE5DaDRwWGswdUpsQlM3a3UwNVgyL2FVM0pRMDVxbkZr?=
 =?utf-8?B?L3VkZEJxRlYrckZCOWZQOUlpZzRXTnM5UkJnYUhtWTNMMUdOZXV6VWNaRmVY?=
 =?utf-8?B?elJERTJTSzV2bU9nQkg1eWdGNy8yNkkvYXVvUkcrdHU0c1p3VDZkNmRaREFu?=
 =?utf-8?B?NTVIVkgvNzZxcElVSXdMa2RLNzhERHMyald0Tkx6ckdqMnk2Umo4RjgrVklX?=
 =?utf-8?B?Q1pnMDB3LytRd2hGUUsramZjSnRZUlhETFZqY0VQc25tUmZJOHZyQnhtaTQr?=
 =?utf-8?B?Uzg3L0ZLMFBlQXk0WmJhVFFjaG1YdHExQlYvdlR4cm9WcHNvaGlPeEhvTlhk?=
 =?utf-8?B?N3E5YXZMbWVUWURRU0lER2Y2MVd2MTZidTJmdVMrRzZKV0ZEOXh3a1VEaWdE?=
 =?utf-8?B?ejNIVjZYUktjY0NrbTM5WWNhZmlicVF6MGNmVEM3azVDOTBGOTV2aE1ZZDFr?=
 =?utf-8?B?ckhzOVFHWFFZSzFlRkFwKzVxMHlyT0k3ODQ4YkxUK1IxNzU2VlBINlZsZUVS?=
 =?utf-8?B?eTZGb1pMenhPaFZtZlFhL1J5NHBvcitnMkVjeXFzbUs3UW9QazVyek9sZ1pX?=
 =?utf-8?B?L3JjUit2MktORC9WQ1ZlKzNudk1JTjkwalM1YVF4OHNVMzVhWWkrZGNFN05i?=
 =?utf-8?B?TGt6T2EyNHAxRXFEMkUyMXpZSE9Tb25raTdzTXpFRUZMb2cwWkgyalVoUU5U?=
 =?utf-8?B?cG9TRUlJYjBnSUgrSTFkc29iUVdHeEpROW43K1hhWnczN3RSUXR2ektWRGZy?=
 =?utf-8?B?TmwyMlZoTTZrcXorc2UwVmo4dFhrbE9CSzk5Y3liV2loamVvUjRFa1phZkZN?=
 =?utf-8?B?cXlHMVpmaVpXSDZVdW9LS0g2UXVHQnRxTGRad1JTbGxXZndvcEtsbVZyeUV2?=
 =?utf-8?B?UE91NUpxYThTc1FaclRKNHV5d3RNT0ovSXlva0p3czFvV0hZcmFtZ2xsZytw?=
 =?utf-8?B?ZXNOUk53bTJWRkg0RkF0Nk96TWpEU25SSnhuMGx5bW5URWZxRkhabnN5ekFm?=
 =?utf-8?B?K0V3YjVnemNndHdTUnhVdzh2VjdwWVFFRDgvdGMwZDdvbVc5RWpiR1FZUHZC?=
 =?utf-8?B?eXFIaW9iM1hrMnU2WkcyYWdIRXVaRUlaZ09qSTQ4NEdBaGFVQmtMaVhFTXpq?=
 =?utf-8?Q?Mktzzr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB13955.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWN0UTZoaUlxeS9qY2V3V2lHSkl3TVFKSHpJaGhTVWYyQmo4MWhDbGlXYisw?=
 =?utf-8?B?aFBrendtZWRaWGdtM0loSWpwelRUZTNKcEE4TzVwa2hlYWVOaTlGS2dYM3No?=
 =?utf-8?B?Q2ZvMW40cUUzcTFtcmtPdlJxdTRrNzMzd0dMTWNPa0lBK2FJRVFMZ2p2TGdI?=
 =?utf-8?B?QnFkU1I5WnVwc0ZCcTNJdHNSU3N4azY0bThPellhNkVqclF4U0NwREFEMENC?=
 =?utf-8?B?M2dFY2VTeUpaNXlLN3ZNVVJkekJMTUNZb1dqOHZuL2JnUVRhWWJUYmhuZm9W?=
 =?utf-8?B?ZXlJOThGUHI4NlJERHhJZUF2MXpPR3lMOC9USitmcWVyaFJYTmFVOHYwdjQr?=
 =?utf-8?B?d2hXTS9rN2piMkVDbDZLUzVlOEQ3d2RmWHJtalNHNEd3djY3RlhQU3BFUjJs?=
 =?utf-8?B?L3I3a1d1UmVOVlZiQjhRbnhnMWxFT1FxcWhLUkNXamoyKzhsWm5YeXFUMkFh?=
 =?utf-8?B?bkhhenZvSGdGaTdtWnBPWndKNXZsenBzUCsvWlJRSHV4SElNZi91dllKY2pu?=
 =?utf-8?B?NWRsdFd1S0NBM2VCd0VDczd2Kyt0Zk1aK0E5eDEwb0V5MFJQeUFkUldDWGlX?=
 =?utf-8?B?dEIxYy9zc1ByeUxCVEplRk5qa1oyL2dlaXk5MjUvWnJNaStRNS9ya0ZDRE13?=
 =?utf-8?B?c2w5RDNjNlV1N1VFR0pjaTNHNGFPTzVhazBMUGRSbXBocExvWEc0S0FNSUpE?=
 =?utf-8?B?UlFBd3RNb1FtR0NReWVnODliSVRqeG5pTkJKdldLUDF1UGVpQTZubkZXNWNK?=
 =?utf-8?B?VlU4NmFHVjczeHBlTWQrdFNBcVlJejQ4dElYcXJiWlphOUY3dkFCUzZEMk51?=
 =?utf-8?B?RW5uUUdZdFgyUGQ4WElUdk42OGpzOFJSTTl3VG5SUXBpd2p3RWwrOWhiaTgy?=
 =?utf-8?B?TEhCQlhnS1BDQmNRNEJkNy81ZGtGM2ordk81ZVVBeGgvRVdjNEJLSkxhNUNq?=
 =?utf-8?B?bFo0RjBRdVpTY2xubDBFblF2VjhDVzhNU280ZnliYmVjbW0zcVNTQUFkdmZL?=
 =?utf-8?B?ZkFiU29sQkRUYjc5UmZpL2ZHd2gvNFU0NVo0YUwyc2tCakxXdWp0dmt1Q0hD?=
 =?utf-8?B?SXlsaUpoVlpBUU10QmlSdE9NeUlDTmZTT1d6cUVKN1FIM1gvUExtRjBGWnA1?=
 =?utf-8?B?Wm4vUzhTaVlwQnhRRUFGM1ZnbTUwUXdyQXRYeklZZFNlTkR0Wk5uYk5aWk9v?=
 =?utf-8?B?TTRNS1hsR1lyM1pOTlZxekE2VUZDdE1rSUZFQm1NelhRR0pnVGVNOVFlYUF1?=
 =?utf-8?B?a05GNU9GUnEzaDlHN2dPdzk1SFZFcU9Ha0ZpWTU2WUxBbmRNdVphTlQ2dnFm?=
 =?utf-8?B?aWhTSmltdllPQ1RaTjQrWm1RRGhOditUVitxVjgxdHRFT1o1SVVHVjdpUlNE?=
 =?utf-8?B?TW9UVE5nRzFVdzZoZW5tTVNncm5VekxnTEowNG8yVVJZY2J0Mm13cW5vMFhK?=
 =?utf-8?B?V1lBRXJGMFVyeEJneGJIRHgvSjVQTXkwYjI4MzZsN2c2bWc2bG5iT211MjhO?=
 =?utf-8?B?YnN6N1pMeEFBcHp4Zk1oZThwYThuRHdMZHg3RHNoUXpjUFhCNm1uQWpQa0Ju?=
 =?utf-8?B?NjV6a09Fc05aaGZlZUZydWN3NzAzOElVTEU5azljRFdDNzAwRll2bE1ST1l6?=
 =?utf-8?B?Z21FTkNoNFN4MVN4Ny9SV2UzVFJmUit0NldxWFhla05wa0FZZklFQW4rd2hj?=
 =?utf-8?B?Y2tEOE0wSE5lQjQzdllNVWQ4N0dsejhOb1dzdWduWTY1ZGhkbnlJdmhxUm41?=
 =?utf-8?B?dzd1Tm1ZSU1vZERrVTVPdS9hL2FQSllVTDBlWnpwWTgyYTloYVI1TjhxMjJN?=
 =?utf-8?B?WHNER3A1eFpCQ1puWGlsczhJcmdxZy9sTFV1WkNGQmE1bmQzN1BUa2hYRzNo?=
 =?utf-8?B?enFkL1N3OHd6NzcrSm9LeEdIdWNIM1BPRjlBc0E5Zm1jemEwM0h3eG9mbmJi?=
 =?utf-8?B?bXhpdHlTZWVYc0lMb2thajdOWW9jYlA1bUNPTUlSbDhtY2JVR21Fblo2TGo5?=
 =?utf-8?B?akhwWGlJS3g2QTV3Ylk2VlVJTUdCREN6MFY1Ynp5eEFzT1ZXeXgzZnZNbmZB?=
 =?utf-8?B?aTZETmt1K24xTmtVcDE4U00yV2FTdjljeThscytkN1phRFpZbjY2ZnlCb0l4?=
 =?utf-8?B?bjJIOG5MTnVaNTZmZTIzN3lQbXZtdXB5Uk1aV2ZpMGZ6SndlWnd1YytEd09Z?=
 =?utf-8?B?eUVlUVVqZDhWT0Vad0dJdzRKb3FHYzUvUVc5ZzZ1NHBEL1doZTBZNm1VOHpW?=
 =?utf-8?B?Tk9TT2kxODBwVzdJNWJqUVJxUWZ4WDhEd0tZNEZpVDRRRHQ5TWVjOGRteFE2?=
 =?utf-8?B?TTNuQkJVNzVSRG5zODY2b3F6NUlBZGIxbUlmdENmaFlSelNHdGwwOHJEcEpv?=
 =?utf-8?Q?9GoLdz3Qe/Po6YMpKWrzw7jo25lhsybnY8++k?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB13955.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061adfaa-7337-4b53-b69b-08de422cbfa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 14:08:29.3869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsi/FpUQr9kUt+xFv2e1GRXqdXENZUNus3dzOBCs5LLtdxsS7HtcjSCstD1wFZIade2RIUfCGKgOnkVuGOu1iGvqkNrEdI/4jK+nEgdTpUpg8j0g3NorQyc1qsG1Hrvg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6755

PiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50
OiBUdWVzZGF5LCBEZWNlbWJlciAyMywgMjAyNSAzOjQ1IFBNDQo+IA0KPiBIaSBDb3NtaW4sDQo+
IA0KPiBPbiBNb24sIDEgRGVjIDIwMjUgYXQgMTM6NTIsIENvc21pbiBUYW5pc2xhdg0KPiA8Y29z
bWluLWdhYnJpZWwudGFuaXNsYXYueGFAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+IFRoZSBSZW5l
c2FzIFJaL1QySCAoUjlBMDlHMDc3KSBhbmQgUlovTjJIIChSOUEwOUcwODcpIFNvQ3MgdXNlIGEN
Cj4gPiBjb21wbGV0ZWx5IGRpZmZlcmVudCBJQ1UgdW5pdCBjb21wYXJlZCB0byBSWi9WMkgsIHdo
aWNoIHJlcXVpcmVzIGENCj4gPiBzZXBhcmF0ZSBpbXBsZW1lbnRhdGlvbi4NCj4gPg0KPiA+IFRv
IHByZXBhcmUgZm9yIGFkZGluZyBzdXBwb3J0IGZvciB0aGVzZSBTb0NzLCBhZGQgYSBjaGlwLXNw
ZWNpZmljDQo+ID4gc3RydWN0dXJlIGFuZCBwdXQgYSBwb2ludGVyIHRvIHRoZSByenYyaF9pY3Vf
cmVnaXN0ZXJfZG1hX3JlcSgpIGZ1bmN0aW9uDQo+ID4gaW4gdGhlIC5yZWdpc3Rlcl9kbWFfcmVx
IGZpZWxkIG9mIHRoZSBjaGlwLXNwZWNpZmljIHN0cnVjdHVyZSB0byBhbGxvdw0KPiA+IGZvciBv
dGhlciBpbXBsZW1lbnRhdGlvbnMuIERvIHRoZSBzYW1lIGZvciB0aGUgZGVmYXVsdCByZXF1ZXN0
IHZhbHVlLA0KPiA+IFJaVjJIX0lDVV9ETUFDX1JFUV9OT19ERUZBVUxULg0KPiA+DQo+ID4gV2hp
bGUgYXQgaXQsIGZhY3RvciBvdXQgdGhlIGxvZ2ljIHRoYXQgY2FsbHMgLnJlZ2lzdGVyX2RtYV9y
ZXEoKSBvcg0KPiA+IHJ6X2RtYWNfc2V0X2RtYXJzX3JlZ2lzdGVyKCkgaW50byBhIHNlcGFyYXRl
IGZ1bmN0aW9uIHRvIHJlbW92ZSBzb21lDQo+ID4gY29kZSBkdXBsaWNhdGlvbi4gU2luY2UgdGhl
IGRlZmF1bHQgdmFsdWVzIGFyZSBkaWZmZXJlbnQgYmV0d2VlbiB0aGUNCj4gPiB0d28sIHVzZSAt
MSBmb3IgZGVzaWduYXRpbmcgdGhhdCB0aGUgZGVmYXVsdCB2YWx1ZSBzaG91bGQgYmUgdXNlZC4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENvc21pbiBUYW5pc2xhdiA8Y29zbWluLWdhYnJpZWwu
dGFuaXNsYXYueGFAcmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+
IA0KPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRl
ci5iZT4NCj4gDQo+IFlvdSBjYW4gZmluZCBhIGZldyBub24tZnVuY3Rpb25hbCBuaXRzIGJlbG93
Li4uDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvZG1hL3NoL3J6LWRtYWMuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZG1hL3NoL3J6LWRtYWMuYw0KPiA+IEBAIC05NSw5ICs5NSwxNiBAQCBzdHJ1Y3Qgcnpf
ZG1hY19pY3Ugew0KPiA+ICAgICAgICAgdTggZG1hY19pbmRleDsNCj4gPiAgfTsNCj4gPg0KPiA+
ICtzdHJ1Y3QgcnpfZG1hY19pbmZvIHsNCj4gPiArICAgICAgIHZvaWQgKCpyZWdpc3Rlcl9kbWFf
cmVxKShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICppY3VfZGV2LCB1OCBkbWFjX2luZGV4LA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4IGRtYWNfY2hhbm5lbCwgdTE2IHJl
cV9ubyk7DQo+IA0KPiBpY3VfcmVnaXN0ZXJfZG1hX3JlcSwgdG8gbWFrZSBjbGVhciB0aGlzIGlz
IElDVS1zcGVjaWZpYz8NCj4gDQoNCkFjay4NCg0KPiA+ICsgICAgICAgdTE2IGRtYV9yZXFfbm9f
ZGVmYXVsdDsNCj4gDQo+IGRlZmF1bHRfZG1hX3JlcV9ubywgdG8gYXZvaWQgY29uZnVzaW9uIGJl
dHdlZW4gbGl0ZXJhbCAibm8iIGFuZCBhbg0KPiBhYmJyZXZpYXRpb24gb2YgIm51bWJlciI/DQo+
IA0KDQpBY2suDQoNCj4gPiArfTsNCj4gPiArDQo+IA0KPiA+IEBAIC0xMDY3LDkgKzEwNjgsMTgg
QEAgc3RhdGljIHZvaWQgcnpfZG1hY19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gPiAgICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZSgmcGRldi0+ZGV2KTsNCj4gPiAgfQ0K
PiA+DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcnpfZG1hY19pbmZvIHJ6X2RtYWNfdjJoX2lu
Zm8gPSB7DQo+ID4gKyAgICAgICAucmVnaXN0ZXJfZG1hX3JlcSA9IHJ6djJoX2ljdV9yZWdpc3Rl
cl9kbWFfcmVxLA0KPiA+ICsgICAgICAgLmRtYV9yZXFfbm9fZGVmYXVsdCA9IFJaVjJIX0lDVV9E
TUFDX1JFUV9OT19ERUZBVUxULA0KPiANCj4gU2luY2UgdGhpcyBpcyB0aGUgb25seSByZW1haW5p
bmcgdXNlciBvZiBSWlYySF9JQ1VfRE1BQ19SRVFfTk9fREVGQVVMVCwNCj4gYW5kIHRoaXMgc3Ry
dWN0dXJlIGRvZXMgc3BlY2lmeSBoYXJkd2FyZSwgcGVyaGFwcyBqdXN0IGhhcmRjb2RlIDB4M2Zm
Pw0KPiANCg0KSW4gbXkgb3BpbmlvbiB3ZSBzaG91bGQgbGV0IHRoZSBtYWNybyBsaXZlIGluIHRo
ZSBJQ1UgaGVhZGVyIGFzIHRoZQ0KdmFsdWUgaXMgbW9yZSB0aWVkIHRvIHRoZSBJQ1UgYmxvY2sg
dGhhbiB0byB0aGUgRE1BQyBibG9jaywgZXZlbiBpZg0KdGhlIERNQUMgZHJpdmVyIGlzIHRoZSBv
bmx5IGFjdHVhbCB1c2VyLiBCdXQgaWYgeW91IHRoaW5rIHRoaXMgaXMNCndvcnRoIGNoYW5naW5n
LCBJIHdpbGwgY2hhbmdlIGl0Lg0KDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHJ6X2RtYWNfaW5mbyByel9kbWFjX2NvbW1vbl9pbmZvID0gew0KPiANCj4gcnpfZG1h
Y19jbGFzc2ljX2luZm8sIGFzIHRoaXMgaXMgbm90IHJlYWxseSBjb21tb24gdG8gYWxsIHZhcmlh
bnRzPw0KPiBJIGFtIG9wZW4gZm9yIGEgZGlmZmVyZW50IG5hbWUgOy0pDQo+IA0KDQpyel9kbWFj
X2dlbmVyaWNfaW5mbz8gSSBkb24ndCBoYXZlIGEgc3Ryb25nIG9waW5pb24sIGJ1dCBJIGFncmVl
IHRoYXQNCmNvbW1vbiBkZW5vdGVzIHRoYXQgaXQgd291bGQgYmUgc2hhcmVkIGFjcm9zcyBhbGwg
dmFyaWFudHMsIHdoaWNoIGlzDQpub3QgdGhlIGNhc2UuDQoNCj4gPiArICAgICAgIC5kbWFfcmVx
X25vX2RlZmF1bHQgPSAwLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgb2ZfcnpfZG1hY19tYXRjaFtdID0gew0KPiA+IC0gICAgICAgeyAuY29t
cGF0aWJsZSA9ICJyZW5lc2FzLHI5YTA5ZzA1Ny1kbWFjIiwgfSwNCj4gPiAtICAgICAgIHsgLmNv
bXBhdGlibGUgPSAicmVuZXNhcyxyei1kbWFjIiwgfSwNCj4gPiArICAgICAgIHsgLmNvbXBhdGli
bGUgPSAicmVuZXNhcyxyOWEwOWcwNTctZG1hYyIsIC5kYXRhID0gJnJ6X2RtYWNfdjJoX2luZm8g
fSwNCj4gPiArICAgICAgIHsgLmNvbXBhdGlibGUgPSAicmVuZXNhcyxyei1kbWFjIiwgLmRhdGEg
PSAmcnpfZG1hY19jb21tb25faW5mbyB9LA0KPiA+ICAgICAgICAgeyAvKiBTZW50aW5lbCAqLyB9
DQo+ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG9mX3J6X2RtYWNfbWF0Y2gp
Ow0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBv
ZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVy
c29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYg
YSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBz
YXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

