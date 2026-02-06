Return-Path: <dmaengine+bounces-8784-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NV2AOq9hWmpFwQAu9opvQ
	(envelope-from <dmaengine+bounces-8784-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:09:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C26FC83B
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 11:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 318363063F60
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197383644C5;
	Fri,  6 Feb 2026 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Q1cJ4Cj0"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011024.outbound.protection.outlook.com [40.107.74.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506A364046;
	Fri,  6 Feb 2026 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372488; cv=fail; b=Z2c8roZc48+pChkGO6Jj8HtO8jZmJYwgjVX7mnROOH4/un2rrPJyebJuGkoIEDMbIgg/TQMqb2Q/NYfQAI99fvbGEj6hR1rry3Gx03EaT3yvJ0ycZoZeVzzr4w8pXB3VlvVWczZ41S/DUi6lSl1DEFMgxZF7S9XvsR5kuDVENLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372488; c=relaxed/simple;
	bh=MT5GR++7vM5LmLvaXX47oV6UTb9Klbd+zSafC6EsTCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e6nTcczEaq0hK/VY7wBVNcfb5Y1ps7K3g4nBUAe/uTndmusOM031+14UZXnKon7S1iaigmmcuguIkkWODV+IxHcvC8tTA5w6BWOEVxpb3ntCIT4smP7uRy0Up3cUyUPzRNs9wbcNr6U81tYC6AQX14YQqutWh7+bPXjRmBs1OzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Q1cJ4Cj0; arc=fail smtp.client-ip=40.107.74.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3UAVSPMaXfYcbpeMZODV9lCY4MPZin0YMIxHGhPqYB6C+ZGvST+PVRtNs0PfAOQsbkwd675F18NPEObnIeU/6OJLMDSfJg1vEr4e/17H5xOqN/Zou2IVfe1ugeNu3tgQQnVhnkBFjRLacIhjxOxS6xDvnnm4BIe1BXdYRW1w89Cx3cPa7LMM9zTvkYQKt1pH4xYIhU6wRuPsQO5zTbMDHvmXcN0xOjYMxQdoRN3QHxDY13fS/EIMfzCYrxTgsHsFxvh/TilXgwhniqkUPgjLSb8rq9/iS/p6lLeFg4h/2+dujgMgYKePTVvBGFCJhxlPLoV/SHvMDDwcsXDNovkgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MT5GR++7vM5LmLvaXX47oV6UTb9Klbd+zSafC6EsTCo=;
 b=HseYSCzv1WXTf3+di878s+lag1YpmWdTmods0LkaU7mTF7+dNysnseiiYqtrcoh61KD6MJo6h1kActK2v714iomUR73cRatub8J2nf3wopCk4pZRPIsn6ERMpdAiaOEXb4T7I9L6DIItUfU7H3JBc6FJb51qBcb6F+mtZVVC18eRQtqJfRkGhirU7HL3cRXelyt5KAzeXK8pfyJxcdlWz6qe59eq7MlgkcCPktVJZiOngNE9fdqb0tsOS8A6wWUDK4jsCEa6YBLC0VDf08wv8gHabHiIcwOysqb5DY0U68mt3RRfLAKUghTV5Bd7X3/lPeQroIyvQQbEVFzLx6fI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT5GR++7vM5LmLvaXX47oV6UTb9Klbd+zSafC6EsTCo=;
 b=Q1cJ4Cj0g7aSOVEBG+/jh7AouLkK3E+vTmMOgIN5zPYLU8Wpya1c1Tiwnh5anGpWbjmPjnYEZi8GtZCbK2NZL9Vt2jAHtQhDKamHIiK7BZkoH5kesU19KrrPGutYK/ItSRvH+DewLpp2yGoFVmYZaTUfFpFOwHiWUVLHzQD7AGs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB15736.jpnprd01.prod.outlook.com (2603:1096:604:3cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 10:08:03 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 10:08:03 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, geert <geert@linux-m68k.org>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Topic: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Index:
 AQHcjq8LxgsLnLJrc0+4TWo3c3gckrVkQ4/QgAAW+wCAAAEtcIAACGyAgAAC1MCAAAUUgIAAAEvggAAlpwCAD49ggIAAByHggAACRgCAAAWpgIAAOcKAgAAETGCAARKLAIAAARaQ
Date: Fri, 6 Feb 2026 10:08:03 +0000
Message-ID:
 <TY3PR01MB113467EFBC5CE4BABBE2F4FF58666A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <16a6f14a-93e6-472c-8718-d46972f0ac5e@tuxon.dev>
 <TY3PR01MB113463BE8A4B1A40DBB0860538693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5438ccc8-ed5a-4dd6-8995-e8e9926883a5@tuxon.dev>
 <TY3PR01MB11346325F46C2BCA6B2B181D08693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ad752abc-275b-43ca-aec3-188c1a69c50b@tuxon.dev>
 <TY3PR01MB113460006A458AB2F8B96542C8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346C8AD27554E40EC5746E38693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7f0305f6-ae2d-4069-b53a-d2a81e75d164@tuxon.dev>
 <TY3PR01MB11346321A9AAE93C7070C6E578699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdWUpq1bUbNLu4WGheovQ1pYdEJGBMN3jdb6PZqXanN_GA@mail.gmail.com>
 <TY3PR01MB1134661E4B93CE785700FC5AF8699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <32ea84f2-621a-47d9-a661-9acd62d50662@tuxon.dev>
 <TY3PR01MB113460619AE8C46BC674B28078699A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <4dd522fe-8143-4423-b428-2774a185ad73@tuxon.dev>
In-Reply-To: <4dd522fe-8143-4423-b428-2774a185ad73@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB15736:EE_
x-ms-office365-filtering-correlation-id: ba4f44c0-3f04-4dc3-89d6-08de65679d81
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmViSHZBNGNwNGl4T1hiNkRwKys0TXpsejBwS0ZLbmNGdzZkVzNFbk5ncGRE?=
 =?utf-8?B?cmJzS2NoVWE5ZlRHWko4Y3lMVlFOUzZoK3VjdXRRWnNHcnh2QkdXNDAycjcy?=
 =?utf-8?B?QjVZSm04bG9ieGhtK0dQUUtYZnptdmRtblJNZ2tCNExRWXpId1dzUUJzTElv?=
 =?utf-8?B?RFVHc1dFMklCZ3daVndzNDhobFZaZTlNM3ZMS3htdkNvcTZoWldsQW1ZU1Q0?=
 =?utf-8?B?YkhWdzUyeEZ4WEtuUzA1L241d0JiaWNzSng3Z2VyV0FVZE5kL2FuNVIyM0Ny?=
 =?utf-8?B?T2tvRW1veEg5Z2NrQ09xUFRMeEp4R01Kdy9ZTktVVGppMmNXb0JlNHlYKzI4?=
 =?utf-8?B?SlV4aWtaWWJNelpxdmtGanBTV3pGT3NNd3Q3UXdkZmF4aVRWQzVib3BWS1N5?=
 =?utf-8?B?RzViM3hVU1d3bFpUNXl2UHZiQTg4cWlOY1lCdHVyajIxL3JIOUUzSHAvU1NC?=
 =?utf-8?B?K0l6UlpFcE1pNGhtYktDN1I4SXhHbDlRQ2VsR01VejFPT2hldnB3RGRqdU1z?=
 =?utf-8?B?OCt6eVRZQU9LdzAwSXZ0ZXYzcWpsaWVTcTNtZ0IzeFYza1VPYVhHbXU4bkN6?=
 =?utf-8?B?VXpiWjljQWIvRGsrQWJrMytxWHMvZTVGbFpRV05PR1ZTTjRWdm9vaEdHTFhq?=
 =?utf-8?B?MVMxNTA1cXE2cDRUQlBndjZTTkNqb3dmeDNVL3hZSTdzSjRraURUcTVrN1Fs?=
 =?utf-8?B?VGEwbjRtdDRsRlgxdjBsdUd4UGE0c2hGWDE4ek50N1R0bk1IV0VsMmpSZ0xz?=
 =?utf-8?B?N0RnMmtUVnJ4Tk40Z1NMdW1LdlRMeXpVMURaTU9uRVVqZXNkd2xmSVAwNldU?=
 =?utf-8?B?Z3U5NkFtL0dIMkttVStxY2xrRzhxYzVKT2VFVU41SkVYTTJldlNHSGcvYnpQ?=
 =?utf-8?B?a09mcldOa1NRY2REZ1NlMHlKSnhDUnFiUU5YM0Yzd0dxdEZiSldaWXVDc2JP?=
 =?utf-8?B?aTBwREVpQXZERmRrV3FhVTVxMkhhOUlNamhYZ1N4azlsdzE5T2FZZzVZL0FJ?=
 =?utf-8?B?a0tZWUF2b3RUdTZBOGI5WHdOWklsK2tLWE5CdEhtK2duL3QyVFJENGk0bUpo?=
 =?utf-8?B?djI2L1lkZUlzalNQRXkwSWx4bmlWQmhHVTRQUlN4WGJyWTBISmpOaDlQSU5G?=
 =?utf-8?B?R2tJdEZqcnZjZTNZZUJtS3k3dGlUTTJiV0w2dzdtMktoNytHbDZrQndvNE9n?=
 =?utf-8?B?eDNrTktZeFRMalhzcityRkYyS3FSOGEyYlgyaVcvZjU5YjBNVzlVRG1XVTBo?=
 =?utf-8?B?OTlCZzRkWjhiTlpab2loUTQvcjdlckMzUmw5VFdDcHBXM29LQTJybG1sWDZT?=
 =?utf-8?B?dGlUcEtXK3dxdWRtT3BQQmdyNTNSS2JLVGRFV3ZhTm05MWtnTGU2ME9jV3ZY?=
 =?utf-8?B?Mk9yUWR2VmZpQ2xlN0ZNdGc4eXJQdG1qS0RETjk0RnZtRlZURHhmbjRZQUo2?=
 =?utf-8?B?VHVjNm1oM1FORVNETUc0UXB2QWVVZ1hITDZLdTZMQkZpcGp1RmVNYlo2VDZP?=
 =?utf-8?B?YkQ4NEFKYkQ3Uk12QjRWNm1zbi9lOTVCZERkM0ZPaVRrOFJ5bkE5UjdyQWVh?=
 =?utf-8?B?V0paL1NTVS9WTVM3eTZUN3dzemhGdWlmNHdoOFU4QUNYYitqa3doL3lXa0d4?=
 =?utf-8?B?RW5NN2l1RWFNMllqVXVVSVZOSVJnYXBXS1FvamxyL0UvdUQ1TmNPSXVrVk9I?=
 =?utf-8?B?enVrdHgyMjVJeGF1SlF2M3hHQzN4aTNJbkJVUzQxSVBwRHdvZVZxYlc5NC9H?=
 =?utf-8?B?MnFCODZpUEt1dVY0V0E5TXBDd1JNck9DR1JpM1EyV3crNG5XMmhReFVoZVZw?=
 =?utf-8?B?NDlLcVRrN1pWK2JLUGVWNGQyZjllNnl1UUFnZUs0QWZvYzVFVTY1YzVnOFJt?=
 =?utf-8?B?Q0doYS9yVy9GSENyZUtRSUdyd0RiMjdZS2cyU1ZZL2dhZ0ZpWGZQaVpQMDg4?=
 =?utf-8?B?Q01JeGZISGh5bW5heE1CaFhDZ3haRnhaRjJSTVZodXBuaE96L3JtSXBKTFFD?=
 =?utf-8?B?OHhFZVdnb2xzU2FwMytDZmpGdyt6ZkYyMU5kQXh1YWEvcE9PTkhpMXZVaWEw?=
 =?utf-8?B?SGVCdm4rY3ZBbWpYMVhTZHFVc1JhUDBtY2pIa3dMTElTN1FiRDNuam8vZEd4?=
 =?utf-8?B?RWw1MnhTRU1NWlJxTkRtc2pOWm51SUZ0UHNzZ01jR3dNWk44ZE1HUmRscXFW?=
 =?utf-8?Q?T/oiJhToZXAkfNPIZdRttrA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUVEU1lIY2lmbGY0TlNJaytZdUlIWG1pMEp5WWVTYSsrUzVVWUNBMHJNSjZZ?=
 =?utf-8?B?dDliUmpORHJBUFhPMUhpVVRkd0RoOFZ2YnlJZ2tCUFJML2gwRnRFK25aMHJ2?=
 =?utf-8?B?bEVBcHZUZkp5djl6aDNxYVMwbFVRYm1yNzBXWllITjVtM2NQQml5V1hLejhX?=
 =?utf-8?B?R1dLUUFDVWpRajZPQ1RFSDZCbHQxMGh2MWhUMGVxMkl3WEpROHlHRk5hZnRq?=
 =?utf-8?B?ckhmR3FpdnlkdGYyVkFjdVlROHpVbTJRNGZ5WGNUdjlhMEZCQUtIaUZpQmZt?=
 =?utf-8?B?S0JKMDh1QjNpK1VvRi9wMnF1dENDeGxVVGFTTlgwWVJ0c0RyU2E0TWlsKy9W?=
 =?utf-8?B?TnNGbDJyK0dQN2F2c0UweHhSN0o3eUtsMUdDeVZsaXFtam40QjQ1K1AvUE04?=
 =?utf-8?B?bU95RkZZRDJhUXhBNWNWb2M2TXpQbVV1SWlwV29CYmU2R2dNVEV6UXlqRFFE?=
 =?utf-8?B?SEl2Ny9xQzJnMVhGV2tlcGZEdjFCZmdwS0FrOWhoclVHekpudUV4RG8zY0ty?=
 =?utf-8?B?aDNzUEJ0bGFFbCt5NzhVRlFlNFQwZ2lRYU5Cd21McmhRTDJUSU1CNkdBWW91?=
 =?utf-8?B?TVNwQTNXamZWdGhGMXdMdlI1Y3NXTkJZL0FSQnVoaTdWVzcyTHJwU3hZOU9j?=
 =?utf-8?B?NkRyZXV1N3JIaGJDdVBWRnZLL1UrNXhQUGFlYzVYTW1MRlJIdGRWZGhxa2RQ?=
 =?utf-8?B?bXBMdlN1NmV1b1hQOFl4Sm9VUlpBWXVaQUFJUFFOS29RQmx2MFVCdlp2ZUVQ?=
 =?utf-8?B?a09UaFY4cWJzOGFNWHJSVTFmaFlETjFWQ0d4KytORXV2L0dIZ25mVTdDL2Rk?=
 =?utf-8?B?RnV5R2hsTWo1aGR5RktKZXFJWU9UQWpCc0NwTjV3SE9vemlTWHZxaDYxbktM?=
 =?utf-8?B?eEhyVHdDY0QrT1d1OFd0UWJwVno5bnNQYUJBb004KzBCUzVma3VoWDZtVkNV?=
 =?utf-8?B?YnF3K2JpWjFMWEdhSnZXWkVyZEdGZGprTDMvVXp5cnk0ZkFtRG1uMkNUYWg4?=
 =?utf-8?B?NVJLMzdBUjNsUmN0MlI5dFlTK3pTeUJjL0hqVnEvbGFCZGg0MmFCYUxtQ055?=
 =?utf-8?B?KzFQb090UTU4Q2lDNVJLTDlKckZKd1d3MkJRMk1CVzhwNFp1cmxvYjI4N3hr?=
 =?utf-8?B?VkJOWitpN25KOTBvSzltdnFYbTYzUm45VXZVZEFxaWMzQnEvc292ajhRTUpq?=
 =?utf-8?B?bVdNSXhta3hWS0pxQ21zRFVubnd1T3ZsWnFVRDFad1BCcDZobWEvNklYWFZD?=
 =?utf-8?B?aHpCQ01pYm9iVFh4SWJuRzN6NTl6Nk41WFd0SWdJSGY5anUwdkY0L2djZGVK?=
 =?utf-8?B?cGlRQXZuVnZLdll3am5JOXh2WVAyMXpqV0gxbzAvMUtRKzA5V3BUYzhja3h3?=
 =?utf-8?B?dzdVOC9RLzdudTgvQmZCcHMrSWQrUVhDT0ZSVGsxdmNrMnFmc0c1RDZPR3BR?=
 =?utf-8?B?RWs4UHEwTEZuSmJWM0hrQ0RNRWkvUmx1bDNLUzRFM2E4Zi9QbGZTUDROVTFH?=
 =?utf-8?B?L21qc3dHc1JxcU1PNDYrUjZVZFkrL3JSdFAzODlRMzBXQWp5KzlBVWk4L1Z3?=
 =?utf-8?B?RFZTTHN5RGgwek9UREpJMGdjWXF0Q2FOVVhsK0x5dGx4NVF4S3BERlVyN1hv?=
 =?utf-8?B?cjlkSVFOL1JycllnZktLYlFzb3VkM3ZJYW1xZVhEYkRNQ05lRGdjWGJDYlVu?=
 =?utf-8?B?NGVNeGh2dTkvNlBHdHhGYjJoRUZ2UWJSTUszMVIvR3VyYnlsa2RyQU4wRjVI?=
 =?utf-8?B?dWU4a2x6WnlRcTBwNkFBTk9xUUcrQlQyVnNsN0UvdWw3ejN4OXRkWWFnaVRq?=
 =?utf-8?B?QXdVY1ZLOEZxWmtBaWV1Zkp3ZUtwS0JOdXdxVzVOUkQ5TStCaEZpdHFJN0h3?=
 =?utf-8?B?bVlEWFlWNzhQc1YzV1BtRy9HQUNIQURvc09ua29VUTBaYUMxb1JlVFhpUHRl?=
 =?utf-8?B?TTdQQjIwOE9hOStHejZ5UE1GSDRyWUxPWnRhcnRCSXNVUjRxVzhWWkVKelJD?=
 =?utf-8?B?eXRIQjZzTGszWDQzejFGVzdtT0VHSUwxR2tYYW1scFRBakhVa0xLanoyVFdN?=
 =?utf-8?B?b1N1UW5rZGFxVjBMQktSUnkyUGp0U3gyOXlNMmUzNXRaaUNxdHQ0aVBXNUcw?=
 =?utf-8?B?RStkZ1N6MHJzWW40ZlVTLzMzSE5nOG5reGJ4bGJQU3I1aHhHMndGRzFrOHdR?=
 =?utf-8?B?eEwrTXR6NURWTFFEYi9QQTdWVFp2MjZIdGNva09OU2pNaHFJR3duY2JMK29s?=
 =?utf-8?B?UWl6VkFLZzNFQkNHa0JRaWlLUWVvMzFPM2R4ZWZoOURxVS9uek9wc3BnWlVw?=
 =?utf-8?B?cllsOVN2OE50MUdiN0s2QnVpUEMrTVJoSDVOMW51bXN2N0N3U1djQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4f44c0-3f04-4dc3-89d6-08de65679d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 10:08:03.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kk+jLMAg8qh8TeKDGHeji875bS9pxZnga5qrobHc9bsvqwOClEIRcWMmd88rGyyG5QZDAOmQImopvwfz3iqnxyafOLVZp4jIdkD4gCSrnJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15736
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8784-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxon.dev:email,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: D7C26FC83B
X-Rspamd-Action: no action

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiAwNiBGZWJydWFy
eSAyMDI2IDA5OjU5DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS83XSBkbWFlbmdpbmU6IHNoOiBy
ei1kbWFjOiBBZGQgc3VzcGVuZCB0byBSQU0gc3VwcG9ydA0KPiANCj4gSGksIEJpanUsDQo+IA0K
PiBPbiAyLzUvMjYgMTk6NDEsIEJpanUgRGFzIHdyb3RlOg0KPiA+IEhpIENsYXVkaXUsDQo+ID4N
Cj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ2xhdWRpdSBCZXpu
ZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPj4gU2VudDogMDUgRmVicnVhcnkgMjAy
NiAxNzoyMQ0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDUvN10gZG1hZW5naW5lOiBzaDogcnot
ZG1hYzogQWRkIHN1c3BlbmQgdG8gUkFNDQo+ID4+IHN1cHBvcnQNCj4gPj4NCj4gPj4gSGksIEJp
anUsDQo+ID4+DQo+ID4+IE9uIDIvNS8yNiAxNjowNiwgQmlqdSBEYXMgd3JvdGU6DQo+ID4+PiBI
aSBHZWVydCwNCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+
PiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiA+Pj4+
IFNlbnQ6IDA1IEZlYnJ1YXJ5IDIwMjYgMTM6MzQNCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENI
IDUvN10gZG1hZW5naW5lOiBzaDogcnotZG1hYzogQWRkIHN1c3BlbmQgdG8gUkFNDQo+ID4+Pj4g
c3VwcG9ydA0KPiA+Pj4+DQo+ID4+Pj4gSGkgQmlqdSwNCj4gPj4+Pg0KPiA+Pj4+IE9uIFRodSwg
NSBGZWIgMjAyNiBhdCAxNDozMCwgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
PiB3cm90ZToNCj4gPj4+Pj4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0
dXhvbi5kZXY+IE9uIDEvMjYvMjYgMTc6MjgsDQo+ID4+Pj4+PiBCaWp1IERhcyB3cm90ZToNCj4g
Pj4+Pj4+Pj4gRm9yIHMyaWRsZSBpc3N1ZSBvbiBSWi9HM0wgaXMgRE1BIGRldmljZSBpcyBpbiBh
c3NlcnRlZCBzdGF0ZSwNCj4gPj4+Pj4+Pj4gbm90IGZvcndhcmRpbmcgYW55IElSUSB0byBjcHUg
Zm9yIHdha2V1cC4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gRm9yIFMyUkFNIGlzc3VlIG9uIFJa
L0czTCBpcyBkdXJpbmcgc3VzcGVuZCBoYXJkd2FyZSB0dXJucw0KPiA+Pj4+Pj4+PiBETUFBQ0xL
IG9mZi8gQXNzZXJ0ZWQgc3RhdGUuIENsb2NrIGZyYW13b3JrIGlzIG5vdCB0dXJuaW5nIE9uIERN
QUFDTEsgYXMgaXQgY3JpdGljYWwgY2xrLg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBDYW4geW91
IHBsZWFzZSBjaGVjayB5b3VyIFRGLUEgZm9yIHRoZSBzZWNvbmQgY2FzZT8gRmlyc3QgY2FzZSwN
Cj4gPj4+Pj4+Pj4gUlovRzNTIG1heSBvayBmb3IgcmVzZXQgYXNzZXJ0IHN0YXRlLCBpdCBjYW4g
Zm9yd2FyZCBJUlFzIHRvIENQVS4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IEp1c3QgdG8gc3VtbWFy
aXplLCBjdXJyZW50bHkgdGhlcmUgYXJlIDIgZGlmZmVyZW5jZXMgaWRlbnRpZmllZCBiZXR3ZWVu
IFJaL0czUyBhbmQgUlovRzNMOg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gU29DIGRpZmZlcmVuY2Vz
IGZvciBzMmlkbGU6DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBSWi9HM1M6IENhbiB3YWtlIHRoZSBz
eXN0ZW0gaWYgdGhlIERNQSBkZXZpY2UgaXMgaW4gdGhlIGFzc2VydA0KPiA+Pj4+Pj4+IHN0YXRl
DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBSWi9HM0w6IENhbm5vdCB3YWtlIHRoZSBzeXN0ZW0gaWYg
dGhlIERNQSBkZXZpY2UgaXMgaW4gdGhlIGFzc2VydCBzdGF0ZS4NCj4gPj4+Pj4+Pg0KPiA+Pj4+
Pj4+DQo+ID4+Pj4+Pj4gVEYtQSBkaWZmZXJlbmNlcyBmb3IgczJyYW06DQo+ID4+Pj4+Pj4NCj4g
Pj4+Pj4+PiBSWi9HM1M6IFRGX0EgdHVybnMgb24gRE1BX0FDTEsgZHVyaW5nIGJvb3QvcmVzdW1l
Lg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gUlovRzNMOiBURl9BIGRvZXMgbm90IGhhbmRsZSBETUFf
QUNMSyBkdXJpbmcgYm9vdC9yZXN1bWUuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSSdtIHNlZWluZyBh
dCBbMV0geW91IGFyZSBhZGRyZXNzaW5nIHRoZXNlIGRpZmZlcmVuY2VzIGluIHRoZQ0KPiA+Pj4+
Pj4gY2xvY2svcmVzZXQgZHJpdmVycy4gV2l0aCB0aGF0LCBhcmUgeW91IHN0aWxsIGNvbnNpZGVy
aW5nIHRoaXMgcGF0Y2ggaXMgYnJlYWtpbmcgeW91ciBzeXN0ZW0/DQo+ID4+Pj4+DQo+ID4+Pj4+
IFN0aWxsLCB0aGlua2luZyB3aGV0aGVyIHRvIGFkZCBjcml0aWNhbCByZXNldCBvciBnbyB3aXRo
IFNvQyBxdWlyayBpbiBETUEgZHJpdmVyLg0KPiA+Pj4+PiBTb21lIFNvQ3MgbmVlZCBETUEgc2hv
dWxkIGJlIGRlYXNzZXJ0ZWQgbGlrZSBjcml0aWNhbCBjbG9jayB0aGF0DQo+ID4+Pj4+IGNhbiBi
ZSBoYW5kbGVkIGVpdGhlcg0KPiA+Pj4+Pg0KPiA+Pj4+PiAxKSBBZGQgYSBzaW1wbGUgU29DIHF1
aXJrIGluIERNQSBkcml2ZXINCj4gPj4+Pj4NCj4gPj4+Pj4gT3INCj4gPj4+Pj4NCj4gPj4+Pj4g
MikgSW1wbGVtZW50IGNyaXRpY2FsIHJlc2V0IGluIFNvQyBzcGVjaWZpYyBjbG9jayBkcml2ZXIg
YW5kIGNoZWNrIGZvciBhbGwgcmVzZXRzLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJcyBzaW1wbGUgU29D
IHF1aXJrIGluIERNQSBkcml2ZXIsIHNvbWV0aGluZyBjYW4gYmUgZG9uZSBmb3IgUlovRzJMIGZh
bWlseSBTb0NzPw0KPiA+Pj4+DQo+ID4+Pj4gV2hhdCBpZiB0aGUgRE1BIGRyaXZlciBpcyBub3Qg
ZW5hYmxlZD8NCj4gPj4+DQo+ID4+PiBUaGUgYmVsb3cgdXNlIGNhc2VzIHdpbGwgd29yayAocGF0
Y2hbMV0gLSByZW1vdmluZyB0aGUgY29kZSBmb3INCj4gPj4+IGRlYXNzZXJ0IGluIGNwZ19yZXN1
bWUpIGFzIHRoZXJlIGlzIG5vIERNQSBkcml2ZXIgdG8gYXNzZXJ0IHRoZSByZXNldC4NCj4gPj4+
DQo+ID4+PiAxKSBzeXN0ZW0gd2lsbCBib290IHdpdGhvdXQgRE1BIGRyaXZlcg0KPiA+Pj4gMikg
czJpZGxlIHdpbGwgd29yayBhcyB0aGVyZSBpcyBubyBETUEgZHJpdmVyIHRvIGFzc2VydCB0aGUg
cmVzZXQuDQo+ID4+PiAzKSBzMnJhbSB3aWxsIHdvcmsgd2l0aG91dCBETUEgZHJpdmVyLg0KPiA+
Pj4NCj4gPj4+IElmIERNQSBkcml2ZXIgaXMgZW5hYmxlZCwgdGhlbiB0aGVyZSBpcyBhbiBpc3N1
ZSB3aXRoICBzMmlkbGUgYXMgRE1BDQo+ID4+PiBkcml2ZXIgYXNzZXJ0IHRoZSByZXNldCBhbmQg
d2UgY2Fubm90IHVzZSBzZXJpYWwgY29uc29sZSBhcyB3YWtldXANCj4gPj4+IHNvdXJjZQ0KPiA+
Pg0KPiA+PiBJIHRoaW5rIHdlJ3JlIHRha2luZyBoZXJlIGFib3V0IGJvdGggRE1BIGNsb2NrcyBh
bmQgcmVzZXRzLg0KPiA+Pg0KPiA+PiBXaGF0IGlmIHRoZSBETUEgY2xvY2tzIGFyZSBkZWNsYXJl
ZCBjcml0aWNhbCBpbiBMaW51eCBhbmQgY2xvY2tzIGFuZA0KPiA+PiByZXNldHMgYXJlIG5vdCBo
YW5kbGVkIGJ5IGJvb3Rsb2FkZXIgaW4gcHJvYmUgb3IgcmVzdW1lPyBXaG8gd2lsbCByZXN0b3Jl
IGNyaXRpY2FsIGNsb2Nrcz8NCj4gPg0KPiA+IFBhdGNoIFsxXSB3aWxsIHJlc3RvcmUgY3JpdGlj
YWwgY2xvY2tzLg0KPiA+Pg0KPiA+Pj4NCj4gPj4+IE9uZSBzb2x1dGlvbiBpcyBTb0MgcXVpcmsg
d2lsbCBwcmV2ZW50IGFzc2VydC9kZWFzc2VydCAgb2YgdGhlIERNQQ0KPiA+Pj4gcmVzZXQgZHVy
aW5nDQo+ID4+PiBzdXNwZW5kL3Jlc3VtZSgpIGZvciBhZmZlY3RlZCBTb0NzLg0KPiA+Pg0KPiA+
PiBUaGlzIGNhbid0IHdvcmsgdy9vIHRha2luZyBjYXJlIG9mIHRoZSBETUEgY2xvY2tzIGluIHRo
ZSBjbG9jayBkcml2ZXINCj4gPj4gcmVzdW1lIGZ1bmN0aW9uIChpbiBjYXNlIERNQSBjbG9ja3Mg
YXJlIGNyaXRpY2FsKS4gSWYgc28sIHdoeSBoYW5kbGluZyBETUEgY2xvY2tzIGFuZCByZXNldHMN
Cj4gZGlmZmVyZW50bHk/DQo+ID4NCj4gPg0KPiA+IFdoYXQgd2lsbCB5b3UgcHJlZmVyDQo+ID4N
Cj4gPiBhIHNpbmdsZSBjaGVjayBpbiBzdXNwZW5kL3Jlc3VtZSBvZiBETUEgZHJpdmVyPw0KPiA+
DQo+ID4gT3INCj4gPg0KPiA+IEFyb3VuZCAxMDAgY2hlY2tzIGluIHN1c3BlbmQvcmVzdW1lIGlu
IGNsb2NrIGRyaXZlciBmb3IgY2hlY2tpbmcgY3JpdGljYWwgcmVzZXRzIGZvciBza2lwcGluZyBE
TUENCj4gcmVzZXQ/DQo+IA0KPiBJIHNlZSBubyBjb25kaXRpb25zIGluIHlvdXIgY29kZS4gSnVz
dCByYXcgd3JpdGVzIGZvciBETUEgY2xvY2tzIGFuZCByZXNldHMuIA0KDQpUaGUgYm9vdGxvYWRl
ciBoYW5kbGluZyBwYXJ0IGlzIG5vdyBtb3ZlZCB0byBDUEcsIHNvIHJhdyB3cml0ZSBpcyBmaW5l
DQpmb3IgcHJvYmUvcmVzdW1lLCB0aGF0IHdpbGwgYWRkcmVzcyB0aGUgYmVsb3cgY2FzZXMuDQoN
ClRvIGJvb3QgdGhlIHN5c3RlbSB3aXRob3V0IERNQSBkcml2ZXINClRvIGJvb3Qgd2l0aG91dCBi
b290bG9hZGVyIHR1cm5pbmcgb24gRE1BIGNsay9yZXNldHMNClRvIHR1cm4gb24gRE1BIGNsay9y
ZXNldHMgdG8gZ2V0IGNvbnNvbGUgZHVyaW5nIHMycmFtLg0KDQpDaGVlcnMsDQpCaWp1DQoNCg0K
DQoNCg==

