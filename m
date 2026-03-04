Return-Path: <dmaengine+bounces-9238-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNqmBZQ7qGkTqgAAu9opvQ
	(envelope-from <dmaengine+bounces-9238-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 15:03:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1150200E51
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 15:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14ECC3015B44
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2059331E820;
	Wed,  4 Mar 2026 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="u4Nae1FF"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011002.outbound.protection.outlook.com [52.101.125.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C033238C1B;
	Wed,  4 Mar 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632975; cv=fail; b=H4pk3TJz/5BWpFIlXywkWQjtQuhnAxOUrAUgoIy8GY4BPDpBYlPAnc2EfvTCf0YVihagePYj3UwBZiKu5WS0csT8UwDEsveolhJtcwtuvPb4Xewy70/nePNfb7dTaodWWspO4FQtCpxGN6aueqi+IdE4w3RAAgPq5c8ssgOU8xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632975; c=relaxed/simple;
	bh=yiun2/1g30lykl35iigf+75kpolx0ZhN5j5NvggcS9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Boc3eFKhpRwlx+0M+J8/HJvYFI0wBC0m4Tpa8fnIY3On36Y6pLf6FIYZ/d51DiA02dDWwQ4+cCoOo7HoUErqartqDjJCg9lF8GFc5PD5kImE/vx7L1dHQIoxKrGKtErluikleerxpz8QNUWvo3X6w3XDXDH5zxnpicRcZ68AopE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=u4Nae1FF; arc=fail smtp.client-ip=52.101.125.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc/M+V8DsGScZTh8Pf7ia4fEEMdWJsYM6xpie5YaSncb8L4xfQnuUZnmlddSN886Lh7+RL0Q47eQr0kZTEQTNRn5jf5jcH4QAi213IiEPh2oH4fQqo916RlGFbzuC5DlmHFhQ+XSrAU7jd0fBERCN/kbTE07iPGmFXVH4FhIr9rKbcEZTGYuFpm4cb919Ja2UI/UhxAoEWRBHxKA8mo2aHWbjfN8nf+vLwngyvV8jPcWN5HNAyk4U/7z1Qi7ayeml4xobaRDBNb3mXpdynVtijpP1l0Y9r2rO/EWMkMUu+0odTC0VZQ1tUwt5l7MOPiePW51KlRwFafpDM2NCv0jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiun2/1g30lykl35iigf+75kpolx0ZhN5j5NvggcS9c=;
 b=UVh7Ro4V3xLXcHAyZeSDfV0JMt+M+jL8+aeDwzWMpVbVA5EbIqjRq+I5NzR/YOIlwzbIaUnOQs5uyuEcVQ7rJDU51Xpe9Suy/GT2JmDr4kjhpVd5dMciW+cuGupqCDg5GtThDSBM/2iui+7SHHcaHZdXbWL7J5pRVW/lzKLhyzMLEHqJnVJ8eLfFCyE46OaPT+jxJ+gDVhIifCFAF8DEuDn/PYncIBXUJU4Dw10Q6Rx12AbSuMJkX5eMoB/+BCI3p5a0Qi2+t+mQFqYR8M2e0mb5Zxi6mr+ql0H+QfY4wCR90tF87qJUHPb1NEkhrPLtzfOIXfVSk+Ou9x8ydKzNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiun2/1g30lykl35iigf+75kpolx0ZhN5j5NvggcS9c=;
 b=u4Nae1FFdDcQYrI1MKRcH2JDo5658Hh8NmnCL/uX9qcbAvN72ZqGx9+QboBM3u2CpEeLXtdMINRarumqxiaXCr6wm0SgELuyJQQZDejLWSYZjlF7+NsWuAQ3v7TN/PRJLGKhDKaAF0gfRj+3+pORYH9OwGwZ1jsel9LyByGv90A=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB14055.jpnprd01.prod.outlook.com (2603:1096:405:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 14:02:49 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 14:02:49 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>, biju.das.au <biju.das.au@gmail.com>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	magnus.damm <magnus.damm@gmail.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v3 01/10] dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
Thread-Topic: [PATCH v3 01/10] dt-bindings: dma: rz-dmac: Document RZ/G3L SoC
Thread-Index: AQHclPgkgk/FyF8IZ0qyb1q9FJiqILWeNgCAgABe1NA=
Date: Wed, 4 Mar 2026 14:02:49 +0000
Message-ID:
 <TY3PR01MB11346A361D75AA2FD37BF6D87867CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260203103031.247435-1-biju.das.jz@bp.renesas.com>
 <20260203103031.247435-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdXDt=VZ9-tpHWqHdZq_Uv=67Try_Un+SRKotRkL9yN94Q@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXDt=VZ9-tpHWqHdZq_Uv=67Try_Un+SRKotRkL9yN94Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB14055:EE_
x-ms-office365-filtering-correlation-id: 4b72b363-8726-430e-4c3e-08de79f6b817
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 eSUwlrzdNdJWqVqqfLmn6g0Or/0Ysp0sZBs+pRlFkq48K7Y9YRRzmYcm4e+mXsdExwD2Mz5dj0HDAM2MhRmoRiL+K/Nd7OTuYN6jN1FzZltK4p8t0bz4/cHUJ7EJgK/jJ7ULnYkSIC26rObm+FO5vNn6Y+Kb9BTEpCOrvM+zlL8+wxHrc3osM6ienB2yYc7kyl1WB2KrKZIt1Q5Y0+Pr5pSCK9NIf85vFbgSgjsY/Q/L9V7eZV22vSLL3X+5zjbzXbf75DVsGyq0qYiK5ouQQhY3g6XYLgX516B4XdadhtA4R6ADGomL85YOfYVezyTPZ7wNdHUkjDAHLAE5hm09Kg4OEKcmRAU1tbGHI0cJIBgQnhdbSvyrPZ7QFeLP3tgWj2/ZQptBN5H7/7fGWsE8dAGyFtdfzDnaYc2tPxplAYl3k/cwTeGW6brGewO5lWHz486g73s4OJZhgfiwBg2dzhp4U8MMfsVC968A/vgZbRvgrhgSWjym7nkBXQoVVtb2DSe6tcaqPvR4kT2Z2MMe4kkT5azxqJ69qRYIMXXoA2qHSjq6VCHqLz+cSQgkH3mjLoYxEBbSfCOEdj5H1VQE81qJL/dtmqEzerRzKX7w3ncKhTaHEKoaKbmujY8bZOyk01v3t4vAuHFIoCkAJom9MbOF22ZkP/3PXpl6u6B4TLEopYHPTnlcjrOJ7cF4UdqetVEvorMoazFkjisvZ75QMC3/rTrngc1hMYV3Su3ipFCSkEiL/hytUr+5GXwqzSdi+j6BjTDMYNQ+xQ/1Rg5BostxPWG62Gq1jzVg739kBBk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWVIN1NOTkhkSVloMCtVUXl1bEMzTkJGazRsKzJaZ29vRExUdC95RGxJWHdT?=
 =?utf-8?B?K3dCRVZaUWVMa2lHa1cxSzFzUUFNYnp4VnlIa2xnVW5PYmcrVVhFUk9xUTFW?=
 =?utf-8?B?K2Q1OGNSaTVUeGpHQTlkdUY3TDBmQm5hb2FsTjFZQnI1NVM0OXh6a3hNNm5Y?=
 =?utf-8?B?ZzB0SnFpRWhaZlRkVkVnVE1hNHNBVmFXRDdmSCszc1lEUTQvQUh5RmJySU43?=
 =?utf-8?B?WEdYWWJBNWkza2V2Qm9sMFQxNEk2NU1jT1JDN2hpRGpqM2tOc0dNWnZJOUd6?=
 =?utf-8?B?SmU4cktmSkxRTFhPWkNjZUpqcHU1MFhnd1h0eHFtalFzQ0g1QytWWVAxc3J6?=
 =?utf-8?B?ZHF4b3d6eHYra0pRaTdrNWVjSEg4UTRHRW9OVlU5dG1xSEFDVUo4SzBuazlI?=
 =?utf-8?B?aTloazVZUTU0a1ZmMytMZEhGRm1HRUlITC9oSEVKeDhxbE82eDVtY3l5cTVh?=
 =?utf-8?B?cmFJbGp1bUhDZmdWOE5MK2xadGVKR2R2bVF2OWVQamFLRzVQalFBbVQ5Sy8r?=
 =?utf-8?B?QmgyOHN3a2JHUk1YSDNSaFF4UzRMbmdxaHRLRlVRem1KZThpUVdvZkpGUXI2?=
 =?utf-8?B?OGZTOEhxbmZ4Y2dQc2E1WUNJcVZZSFlNd2xqUnhXeldtQ0YwV0F4bk5ib0VZ?=
 =?utf-8?B?enFkQTBPb0FnaXp4Uk9oN3FVNjhFT3NZYVduU2Q4UDMrbWQvN09CZ1N6Z1M2?=
 =?utf-8?B?d2x1cDd0WUpWUzlmUElRNVVobktQZ29JcTYyZWVvMXI5bTRwNzc3cVlWSWF1?=
 =?utf-8?B?aVlGLytzdy9OQnhVRFZOTVJtMDJpTzJad0dhOEhBNC93b0kzV0tkNHlSWU1X?=
 =?utf-8?B?V004RHRSRmlwT01pOFZUeHJ0VHdvM2Zzb3QwUmxhalZkdVAwSSs4cFpHWW1D?=
 =?utf-8?B?cFI1TndUaEtkVGs5RkJzZHZUenp1dytCUHlmR1krRUluLzJyTGs0aWJ2amdh?=
 =?utf-8?B?d2RvVUViUVArZXdBVUVva1QrTWgwdThoY2hLREF1RmtwTmpCWlF3MTdJamRq?=
 =?utf-8?B?RW1wczhWaUVmbERYa01IYlpqc3BJNzZvKzBVYk1ldHEvYVA2djNEblFoa1BP?=
 =?utf-8?B?dDd6UmxZalJ3cTgzc1hZVlM2UE9wbml4U2ZDTUlSRXVYdXFmYjN1cUQ3VUR2?=
 =?utf-8?B?aDcwNUVYSm0rYXZzSmo2cFByKzF5YmlPejd0b3NjdnRZVFFzTTN0eldPQloy?=
 =?utf-8?B?V0s0WHoxU00vL2puNTFjYnZpSHMrTjUvYURxTkxBNGZsRjBaYVoxYUtWdU5k?=
 =?utf-8?B?MlE5UW9LQk5XcDJJSFBvcE43S2hJa1NwaGhxS3hrTmtnMFdhMFhKWnArYTlQ?=
 =?utf-8?B?L0hiMGFGVCtGVzhEOTNnemJtMWV2YUFnOUlmdm8wRUZVcmtjbXh3cGJUUndz?=
 =?utf-8?B?Y2Y3NFFueEp0b0hldzIzWjZER3NkUnJ1YVM2TkVlWVE3dTdLNW95SmZJaVAx?=
 =?utf-8?B?azQ4RXFmR2srU1BRcTB5K0ZXNTM3cmNLb0ZDdjR4dWdtVVpxWUJDMXFEaUxa?=
 =?utf-8?B?M3ZJUEZMNW5MSXR0UVdhMzdzbDlYU0RXc3RJK2taQmJCRC8wQks4bG84Z1BU?=
 =?utf-8?B?RlljYlorcVNqMWdic3lvaUtsTjBuQUNuclRBTGZ2SXpXUk4xSjZrMjNVRlph?=
 =?utf-8?B?ZVZaczlzVnVNRGpBL0dZTy8vRjFlNmp1TldpZk1ESGl2azdSOWhrcUxqMTlw?=
 =?utf-8?B?bVpwd1NTYUxMNW1LeHlUcUl3aEs0NnFxRkdGQlJMa3pXWXpMclpEYWVreXBS?=
 =?utf-8?B?Z0dqUkQwWnhJazBiOGlzaUtMZUtzTW9jTTBQTjBpM3NEYmZlRUxoUXdXTGRW?=
 =?utf-8?B?WGpDNHY3TFNYUUlUS0lWUXd2OGFKdzJuTnY1aHRkSlFCd0xEWHdCN1ZSZ3lF?=
 =?utf-8?B?YnJkQkJsQXlZd1FSY1l0M0d3NjVzTXFXQXhOYmcwUU9TdkxPeko5MVR6T00y?=
 =?utf-8?B?OFkvRGJiY0t4Uk9GaHVERHIrYlQyVWwxMXRwVFJIbmNKR1FkYkxJdXY1cVBJ?=
 =?utf-8?B?Z0NlM3dqWE5XK25QbmtKM3RtRGhtS1BjNXZaSXdxa3FYVWg2MUNGNEJzMDZ3?=
 =?utf-8?B?S0w1aWVHNkt3dzNXa096OTNDWUZKN2tQMng0U3FaZWVXS29BdUduSmhmODJq?=
 =?utf-8?B?QVJrcERHTGxac0dlMFVpT1AreU1JTzZYUHplc1gwb2U2WUcyamRTUittS1U1?=
 =?utf-8?B?bnVUdTJ2am4vOWpKc21BQkpHOVpENHJmWDlTSUtZaGs2MDB3WXdnZVZlbXY1?=
 =?utf-8?B?RWhROVdQTmhGdXF5bktFNGJjbmhzZXVIRUJ2d1ZUTnhkaWl1TVdKS01uMEVD?=
 =?utf-8?B?SzNsRFZabU4vaUtsOSswTmVFVzVxbmlDK2F4Si9oTkMrNHFKK1RFUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b72b363-8726-430e-4c3e-08de79f6b817
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 14:02:49.0332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIRdUGK2sNXk+K6k3XrU9beVmq3rPs3rsaBuYkP6UY1MjwGW+yRtoeyNsa0iz75cwteySCy54lVY3AwCOzrFTl50ixyjEH7fjzhDeto9IBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14055
X-Rspamd-Queue-Id: A1150200E51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9238-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-m68k.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,bp.renesas.com,renesas.com,microchip.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:dkim,linux-m68k.org:email,renesas.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:email,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Action: no action

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDA0IE1hcmNoIDIwMjYgMDg6MjINCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MyAwMS8xMF0gZHQtYmluZGluZ3M6IGRtYTogcnotZG1hYzogRG9jdW1lbnQgUlovRzNMIFNv
Qw0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFR1ZSwgMyBGZWIgMjAyNiBhdCAxMTozMCwgQmlq
dSA8YmlqdS5kYXMuYXVAZ21haWwuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBCaWp1IERhcyA8Ymlq
dS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4NCj4gPiBEb2N1bWVudCB0aGUgUmVuZXNhcyBS
Wi9HM0wgRE1BQyBibG9jay4gVGhpcyBpcyBpZGVudGljYWwgdG8gdGhlIG9uZQ0KPiA+IGZvdW5k
IG9uIHRoZSBSWi9HM1MgU29DLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEZhYnJpemlvIENhc3Ry
byA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPg0KPiA+IEFja2VkLWJ5OiBDb25vciBE
b29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJp
anUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91
ciBwYXRjaCwgd2hpY2ggaXMgbm93IGNvbW1pdCBlNDVjZjBjN2Q5Yjk2MGYxDQo+ICgiZHQtYmlu
ZGluZ3M6IGRtYTogcnotZG1hYzogRG9jdW1lbnQgUlovRzNMIFNvQyIpIGluIGRtYWVuZ2luZS9u
ZXh0Lg0KPiANCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1h
L3JlbmVzYXMscnotZG1hYy55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2RtYS9yZW5lc2FzLHJ6LWRtYWMueWFtbA0KPiA+IEBAIC0xOSw2ICsxOSw3IEBA
IHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAgICAgLSByZW5lc2FzLHI5YTA3ZzA0NC1kbWFj
ICMgUlovRzJ7TCxMQ30NCj4gPiAgICAgICAgICAgICAgICAtIHJlbmVzYXMscjlhMDdnMDU0LWRt
YWMgIyBSWi9WMkwNCj4gPiAgICAgICAgICAgICAgICAtIHJlbmVzYXMscjlhMDhnMDQ1LWRtYWMg
IyBSWi9HM1MNCj4gPiArICAgICAgICAgICAgICAtIHJlbmVzYXMscjlhMDhnMDQ2LWRtYWMgIyBS
Wi9HM0wNCj4gPiAgICAgICAgICAgIC0gY29uc3Q6IHJlbmVzYXMscnotZG1hYw0KPiA+DQo+ID4g
ICAgICAgIC0gaXRlbXM6DQo+IA0KPiBUaGlzIHBhcnQgaXMgZ29vZCwgYnV0IHlvdSBmb3Jnb3Qg
dG8gdXBkYXRlIHRoZSBjb25kaXRpb25hbCBzZWN0aW9uIGJlbG93LCByZXN0cmljdGluZyB2YXJp
b3VzDQo+IHByb3BlcnR5IHJhbmdlcy4NCg0KT29wcywgSSB3aWxsIHNlbmQgYSBwYXRjaCBmb3Ig
aGFuZGxpbmcgdGhpcy4NCg0KQ2hlZXJzLA0KQmlqdQ0K

