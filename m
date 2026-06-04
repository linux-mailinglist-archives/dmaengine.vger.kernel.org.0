Return-Path: <dmaengine+bounces-11161-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S5cDOEFiIWoEFgEAu9opvQ
	(envelope-from <dmaengine+bounces-11161-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 13:32:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A20E63F725
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 13:32:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=PQ+rdUro;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11161-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11161-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B282130A7B6C
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 11:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7668A42316C;
	Thu,  4 Jun 2026 11:26:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A83311C38;
	Thu,  4 Jun 2026 11:26:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572389; cv=fail; b=hPeVXR31oBjqidZ7vjfmdfS8ib10zSEiY32Yi36rNE1oDtBdT6TcHVZck4wnZpAu+kFr1e1S6ESnahytLLb7ZTSk72IRpqfveMpIZvL1/OLJ4eCuWWDEUcfdcY1TLWsULx55z9J4mPmjIPJ0fBrc88xDzsZ6TdoEBIOUzqhwyNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572389; c=relaxed/simple;
	bh=TYHMR7gO5gqq4iskKivoZ1OWmr4oHfLLxV7ITh4bYOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tg13j/d5WJjKUNrjUk/Pp8rIR0OylpraGvQZAsh26E86tDN9coIQ4ShqbJ5pzaOKY8kLk5mjsVBM/UxATH/fpfS6n+0tSwRfo1zCl4apEmqmo46k7Eo+bCbOny/hgiFO81J3BKJWIyz77YLmft4MI+BuZpvsVZlAGyWIZ/z6QJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PQ+rdUro; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIg4dBimoLwCNo066EK8I/3m0nlI/ue0D74d6g9BBh5JcO2BID2nOLyu4eZUUemA3sRwzDr2OKucItdwvluswq/jPRJCDYhCSAdiWNoaWpZ1hZSG7Kj5700puCbtQka9U/Biot+eujlhLo+3ep5jlxlk61tZXNVHTbjY2lyS8PdYwQf9baOwD+sXlx1J7fOyjxLExTPQTGO02xp3b9me7fKrNJE7uTwvFHK3AzLPZcqaAEq7miaUsAl1IpJ+PfdMZ/TMsCasB3afZtUQSMWlOPWQSpbg2n9a+RgEEDVC4ZvIIHSUZdPvAa8p2tn5/LL3G0NXRiO7ByZD4RyBGGD2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYHMR7gO5gqq4iskKivoZ1OWmr4oHfLLxV7ITh4bYOk=;
 b=PPpzLt5VtRxQYAJmpfvyz6nFGelrdEAFpsVTqWRRyrMYaQTOrEjYWRyie2GseF6dA4KOvemAiuZpRAa+CpljXdgv2cmKiWStWpATq2PorxLgJf7Rkb+Hiu/ZwhJllaUdvVe82qIFV+pPxSQVrU3UlHSjLUfWzhMLdA3cS2NvlzGycQ8HcZa/dNVPdwxx5wFgFtLxn/D8pWSVWmZRYWRhx3wqStAscp1IUDIORohc0r2p9SAJYTuL3F38hkwD/KQVmGwZiGb0gVM8+T7Dv2xtrq5sL7teDfLVbq66i89312eL7UrJ0mCldOc428rEN7p+USeh0/l3suUhEPKH4LYsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYHMR7gO5gqq4iskKivoZ1OWmr4oHfLLxV7ITh4bYOk=;
 b=PQ+rdUroNEuuVwhP/4rnwiehIaPj2ifkZKDqSzzO0b3/7xzEDQj6mr9WV0h1rOsxCcoBFvG6EvsXmzjxhXu1eAPFjEr0OEpjTVCE1QFfZGKeNr3/TDvLgRgMS+JqFC3WO0dkgpAEHqrUzZaYC92hb9Zs2Q4npHFEuPsyzKt+cuc=
Received: from DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:26:23 +0000
Received: from DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f]) by DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:26:23 +0000
From: "Golla, Nagendra" <Nagendra.Golla@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: dma: xilinx: Add optional resets
 property for ZDMA
Thread-Topic: [PATCH 1/2] dt-bindings: dma: xilinx: Add optional resets
 property for ZDMA
Thread-Index: AQHc7DR3iNIqcbqW70Cn0v+WtZBYg7YekveAgA+96QA=
Date: Thu, 4 Jun 2026 11:26:23 +0000
Message-ID:
 <DS4PR12MB99907538E3782F009C4436D7568E102@DS4PR12MB999075.namprd12.prod.outlook.com>
References: <20260525105042.2249542-2-nagendra.golla@amd.com>
 <20260525110025.E5A6A1F00A3A@smtp.kernel.org>
In-Reply-To: <20260525110025.E5A6A1F00A3A@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-04T11:24:01.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR12MB999075:EE_|SA1PR12MB6776:EE_
x-ms-office365-filtering-correlation-id: 5afa2320-9253-4f26-db24-08dec22c1bca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099006|11063799006|4143699003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info:
 uIn+vqpZLgQVe7EiID5SrN2UB4N+WUgCSZZCMOZ9e79cLi6W0+2CBxoksjBcOWo0DYfnF7A3+17Kf51/FDyWUHpITrxKIADViRO3CvLWlMBJMPXOnVWcu0SaDLM6Mvr0sYqXnZ2HJYEx/Clian2vTC49azuU037xQF6qTmdVrQIiJnQlc3Bgxt/nDkEn6Xd0EVxtvGMWyBVup/B4GS6VtKKkYf7luShiFG83bhZejIjUZ6Lgxb428CMKX4jIrupmUAVQkA11qh2OPsA40OsGwd9+Chl6WWIaOBKHpuMB00fbnLyh+0ecHsU9D/oSio7wUOEcWb+lFEFIaOKQAIkLmT1ZmyIJYIl81wbP3OjuU2TTRf91k19Rfj81jEpgKAF1eSFHMXvAmi/4jBl+UxjfW3HCaN6th8L5Cy1v7cNsti13VklKAQ5lmG9h8H7D+bWbWJsmPmN3eELA03RWltZKnvIUEQTDZvM9TKp93CFMT/k4/sgfizQud0tI81CPbYz0Chi00JOINAoOBrgoN9jsyoqJs86ZBB0Xqlaw0NcjSiad6iBCjrvXYiiSjNdbCAFkd8OdhEQ4p0RyjTybAR7YqK9uXqbjz5CdQuunC1pzZkQg3Ny9NlC9ihy6NvXi5r1DD91AqhLf7iLkLkdqfBxULsEaWE9uGCEpPNujVen82otQM4knZBKD+pWiygiHWwqq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB999075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkdjYlRCczJQZnMxRlJLWVJCNXVtaTJ0dlJWbzlPOURkSWZlQm0xL2tDN0Fk?=
 =?utf-8?B?MThDL2Jidyt3TmlVSjZ3U0w2ZjFabFRrNitiOGZ6VXUzbFh2VWR2TzZlNEo2?=
 =?utf-8?B?QXRyMllwVmlMOXpPMG9ZQjBvVHEybHNQc0ZHaThBcG9BSmliR1hCMmR3OWlE?=
 =?utf-8?B?ZlRJRklYNm02aUczYThORElzZmhYQ0RWWVZZdkpqVGpNcFJ2Qmh3UE5RNkdO?=
 =?utf-8?B?QVRkYXRsMEtEejFVNmFYUkNaOXIyZEt4UlNLOGpmTEdtUmRaN3ZVQW9OLzZl?=
 =?utf-8?B?VGNXRW5sUUxKMzJoSzNTekNwQjRtSjI1K1psd3RtTGpYaWJLZFBraGVEdUZ0?=
 =?utf-8?B?bmtxZXNVam80bVNsa2Rpcm1iVU5rRDBSUnV4eERhN090a0VaUjA3UXNIUkNH?=
 =?utf-8?B?cUV6L3UwSHJXa081VVVIL2UrZi8wUThYQnB4cUJOQUxJZm8vYlUzWEJFeVpO?=
 =?utf-8?B?cXNBQzBaYkpIWEtuUnlSUnFJZFVBY0hzK1lPUEZJekxxZyt2Z2V6MmRRZ01r?=
 =?utf-8?B?N1BCUjJjL1o2dzNOMWRKWU9QN2FMVFlDeFpORVVLOW5VOWNoRUJ6UU1MdkI2?=
 =?utf-8?B?SDJjSTZnZUd2OVpWT0hRQ0x0MUxYVzJ0RmdxaWZOOHJYeisvTDR3aVBCYXVY?=
 =?utf-8?B?YXExUHlwb0JzOGdQUHoyZXBGS3dtN2NqMm1oTUQwYnJQdWp0NkVZS3k2c3p5?=
 =?utf-8?B?WjMwQzZ0QWEvZjgvcDBtb0dYbk51SjZYRTBnY2V2NW9CT3RnV3ZSd2NJLzgw?=
 =?utf-8?B?RVM5ck9COGwwQzB0cEczY0RadWRKSHRjbUVvK2RMRE8yN3prREcwVisrVTVC?=
 =?utf-8?B?a3FxRHFtK0hmeUVwWkNISExWVFdxMFMzT1dNamNoZHAzZDRyUWU3N3FEVWlP?=
 =?utf-8?B?V0VianZaYXFJL0pYSXBBd3J6RFA3dWhWdHpTMFNKZzVuUzlrZ1JUbVdPN0RB?=
 =?utf-8?B?MHIyOTY4ZzFiYjdDVXNHRVFUdEtkKzk2aUZGZXhRbmh2aW5GQjlkTU9uQXJO?=
 =?utf-8?B?TmxadjB6M3N6bjQxWG1LRWYzdHozNDFKOVFvVGpMZE5YNG80VEY3cEFNOXBB?=
 =?utf-8?B?a05RekR1dWlkMXpJSFRBeGU0WUt2a3VlU3V5TDJZVE5RakxHc25BUnN1UXJU?=
 =?utf-8?B?Y293cW5Pd0lXM01zN0Zhc251TU8vSUNWWkdITWg2NEdCTm9adkluM2NuVUxL?=
 =?utf-8?B?M3ZzV0Z4dWxUMmlsQ3pzTVZPMkJ6N2VGMVN4ZW9aSjgxRTA4Ujdyd0xlK1Js?=
 =?utf-8?B?VjBZNTlycVlXdHZIbGp1b0FPVGFpQU9TZ25MUlJzMjd1SzE5cVlSRUk1c05p?=
 =?utf-8?B?YmFnaXBYUHFGM0tEZ3lscEtnWkowWmVsMEoxa21YT1Y1ZXg1b1pGVjBSdGhV?=
 =?utf-8?B?Qk4yUEtBRFphYW1sbWNsaXAzNnBMcHJ2VFpKL1hqS3VOY2lBTHRuWFhMeWsw?=
 =?utf-8?B?cGUxdnoxU3dkQ08xZkg0TS9ueTZIYlRCL0NQbVN2dWxwVjV4cm9WUENZZUo5?=
 =?utf-8?B?TjJJcEw2cm50YjdVeWk1NzBCRkhPLzM4Z1lnVitDbU9ROFNUalBac2tPVVFw?=
 =?utf-8?B?RzZPZXBiSWVORzJZTEpYUFdTWitlcHBwbkd6cWp2REQ2end4K0U3bi9Qd09J?=
 =?utf-8?B?NGw4WTlqZVA5cWZpM0VUa2o0RG4wY21KdG0xMDJ1WWoxZWNPcW1uVUpZTkFh?=
 =?utf-8?B?SGdDV3RDWGtOK0pjeUVoakd0NDNBZnVmZFNoNUNHUlVMWUxpYUZ2VXkxUERB?=
 =?utf-8?B?Yi9mNXRoZWlENTVHVVI2cW5jR3duMUs1cTZhMzU1TTZBTStlRXlFWG9EWnVM?=
 =?utf-8?B?d0xxSHVXQnhOU09zd0xGY0JTcE90UnVJWmw5amNxRTlYNWJJZEp1WFBoelkv?=
 =?utf-8?B?NkZWRzdhd0s5U0ZPU2FTVGJuR24reHlSbUNnSWVYaTJGVjBOWWUvcDlFSHhW?=
 =?utf-8?B?eC9Zb21haTN4N1FReHpPa1VUTGYwbHUvcktsSmxwVzlJTWN1YlcrZnZPWVNj?=
 =?utf-8?B?bXdoS2xVVDI1VnJCdkV1M1haemlhY3ZUMjlJMFUwdEFnTUhtcUtBd3d4N1hM?=
 =?utf-8?B?eEhsL3FTalJsSnlmZlIvNWJ3dVV1M1V3WU9GSzNwMDMyUlE2NW5ZSEFWK0di?=
 =?utf-8?B?cHhKVmxIRmJzU1poWHQ2Wlh3VE5LU0hTcnlzNnBxdW9BUHNJZTlUTmhrNVBK?=
 =?utf-8?B?WDVycTBUcWl2U3lMMDUzNVVzV2lEUTlyQ0E2ajVLWFZlQTFudkdWK0pYNkNL?=
 =?utf-8?B?emtWZXE5NVlBL3lPb01PbXhWNWIweFZuakVwM3o2ODJreTdnK0dTZ2VKNUEy?=
 =?utf-8?Q?GIp2QiJDbmRSy44TXJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB999075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afa2320-9253-4f26-db24-08dec22c1bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 11:26:23.3726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uCkNJmS2yx53Hzkl0V4q3esWeft1x1K/ZFVF2NNL5VhTQxxvL7PIZoYDVY2iX6xgA+LiBR4zJUGm82q0xi1cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11161-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:robh@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Nagendra.Golla@amd.com,dmaengine@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Nagendra.Golla@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,DS4PR12MB999075.namprd12.prod.outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,amd.com:dkim,amd.com:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A20E63F725

QU1EIEdlbmVyYWwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogc2FzaGlr
by1ib3RAa2VybmVsLm9yZyA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCj5TZW50OiBNb25kYXks
IE1heSAyNSwgMjAyNiA0OjMwIFBNDQo+VG86IEdvbGxhLCBOYWdlbmRyYSA8TmFnZW5kcmEuR29s
bGFAYW1kLmNvbT4NCj5DYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGRtYWVuZ2luZUB2
Z2VyLmtlcm5lbC5vcmc7DQo+cm9iaEBrZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3JnOyBGcmFu
ay5MaUBrZXJuZWwub3JnOw0KPmNvbm9yK2R0QGtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW1BB
VENIIDEvMl0gZHQtYmluZGluZ3M6IGRtYTogeGlsaW54OiBBZGQgb3B0aW9uYWwgcmVzZXRzIHBy
b3BlcnR5DQo+Zm9yIFpETUENCj4NCj5UaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBT
YXNoaWtvIEFJIHJldmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKQ0KPnRvIGNvbnNpZGVy
Og0KPi0gW01lZGl1bV0gVGhlIGByZXNldHNgIHByb3BlcnR5IGlzIGFkZGVkIGdsb2JhbGx5IHdp
dGhvdXQgY29uZGl0aW9uYWwNCj5jb25zdHJhaW50cywgYWxsb3dpbmcgaXQgdG8gcGFzcyB2YWxp
ZGF0aW9uIG9uIG9sZGVyIFNvQ3MgdGhhdCBkbyBub3Qgc3VwcG9ydCBpdA0KPmluIGhhcmR3YXJl
Lg0KPi0tDQo+DQo+Y29tbWl0IDgzMmM0ODI5MTRlNzYzOWNiMWE0MTBkMDYxYmY5ZDYzMWI0MWFl
NjgNCj5BdXRob3I6IEpheSBCdWRkaGFiaGF0dGkgPGpheS5idWRkaGFiaGF0dGlAYW1kLmNvbT4N
Cj4NCj5kdC1iaW5kaW5nczogZG1hOiB4aWxpbng6IEFkZCBvcHRpb25hbCByZXNldHMgcHJvcGVy
dHkgZm9yIFpETUENCj4NCj5UaGlzIGNvbW1pdCBhZGRzIGFuIG9wdGlvbmFsIHJlc2V0cyBwcm9w
ZXJ0eSBmb3IgWkRNQSBvbiBuZXdlciBTb0NzIGxpa2UNCj5WZXJzYWwgR2VuMiBhbmQgVmVyc2Fs
LU5ldC4gT2xkZXIgU29DcyBkbyBub3QgaGF2ZSBhIHJlc2V0IGxpbmUgcHJvdmlzaW9uLg0KPg0K
Pj4gZGlmZiAtLWdpdA0KPj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1h
L3hpbGlueC94bG54LHp5bnFtcC1kbWEtMS4wLnlhbQ0KPj4gbA0KPj4gYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZG1hL3hpbGlueC94bG54LHp5bnFtcC1kbWEtMS4wLnlhbQ0K
Pj4gbCBpbmRleCAyZGE4NjAzN2FkNzllLi5kZmYxNjc2M2UxMWI5IDEwMDY0NA0KPj4gLS0tDQo+
PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEveGlsaW54L3hsbngsenlu
cW1wLWRtYS0xLjAueWFtDQo+PiBsDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZG1hL3hpbGlueC94bG54LHp5bnFtcC1kbWEtMS4wDQo+PiArKysgLnlhbWwNCj4+
IEBAIC01Niw2ICs1Niw5IEBAIHByb3BlcnRpZXM6DQo+PiAgICBpb21tdXM6DQo+PiAgICAgIG1h
eEl0ZW1zOiAxDQo+Pg0KPj4gKyAgcmVzZXRzOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0K
Pg0KPltTZXZlcml0eTogTWVkaXVtXQ0KPlRoZSBjb21taXQgbWVzc2FnZSBub3RlcyB0aGF0IG9s
ZGVyIFNvQ3MgZG8gbm90IHN1cHBvcnQgdGhpcyByZXNldCBsaW5lLg0KPlNpbmNlIHRoZSByZXNl
dHMgcHJvcGVydHkgaXMgYWRkZWQgdG8gdGhlIHRvcC1sZXZlbCBwcm9wZXJ0aWVzIGJsb2NrLCB3
aWxsIHRoaXMNCj5hbGxvdyBkZXZpY2UgdHJlZXMgZm9yIG9sZGVyIGhhcmR3YXJlIHRvIGVycm9u
ZW91c2x5IGRlZmluZSBhIHJlc2V0IGxpbmUgYW5kDQo+c2lsZW50bHkgcGFzcyB2YWxpZGF0aW9u
Pw0KPg0KPlNob3VsZCB0aGlzIGJlIGd1YXJkZWQgYnkgYW4gYWxsT2YgY29uZGl0aW9uYWwgYmxv
Y2sgcmVzdHJpY3RpbmcgdGhlIHJlc2V0cw0KPnByb3BlcnR5IHRvIHRoZSBuZXdlciBoYXJkd2Fy
ZSBjb21wYXRpYmxlIHN0cmluZ3M/DQoNCkhpLA0KDQpUeWluZyB0aGUgcmVzZXRzIHByb3BlcnR5
IHRvIGEgc3BlY2lmaWMgY29tcGF0aWJsZSBzdHJpbmcgaXMgbm90IGZlYXNpYmxlIGhlcmUuIFZl
cnNhbCBOZXQgcmV1c2VzIHRoZSBvbGRlciAieGxueCx6eW5xbXAtZG1hLTEuMCIgY29tcGF0aWJs
ZQ0Kd2hpbGUgVmVyc2FsIEdlbiAyIHVzZXMgdGhlIG5ldyAiYW1kLHZlcnNhbDItZG1hLTEuMCIg
4oCUIGJvdGggcGxhdGZvcm1zIHJlcXVpcmUgcGVyLWNoYW5uZWwgcmVzZXQgc3VwcG9ydC4gQW4g
YWxsT2YgY29uZGl0aW9uYWwgYmxvY2sNCndvdWxkIG5vdCBiZSBhYmxlIHRvIGNvdmVyIGJvdGgg
d2l0aG91dCBhbHNvIG1hdGNoaW5nIHRoZSBvbGRlciBTb0NzIHRoYXQgc2hhcmUgdGhlIHNhbWUg
Y29tcGF0aWJsZS4NCg0KVGhlIHByb3BlcnR5IGlzIGludGVudGlvbmFsbHkgb3B0aW9uYWwuIE9u
IHRoZSBkcml2ZXIgc2lkZSwgZGV2aWNlX3Jlc2V0X29wdGlvbmFsKCkgcmV0dXJucyAwIHdoZW4g
bm8gcmVzZXQgaXMgc3BlY2lmaWVkIGluIHRoZSBEVCwgc28gdGhlcmUgaXMNCm5vIGFkdmVyc2Ug
ZWZmZWN0IGlmIHNvbWVvbmUgZXJyb25lb3VzbHkgYWRkcyBpdCBvbiBoYXJkd2FyZSB0aGF0IGxh
Y2tzIHJlc2V0IHN1cHBvcnQg4oCUIHRoZSBwcm9wZXJ0eSBpcyBzaW1wbHkgaWdub3JlZC4NCg0K
VGhhbmtzLA0KTmFnZW5kcmENCj4NCj4+ICAgIHBvd2VyLWRvbWFpbnM6DQo+PiAgICAgIG1heEl0
ZW1zOiAxDQo+DQo+LS0NCj5TYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2
LyMvcGF0Y2hzZXQvMjAyNjA1MjUxMDUwNDIuMjI0OTU0Mi0NCj4xLW5hZ2VuZHJhLmdvbGxhQGFt
ZC5jb20/cGFydD0xDQo=

