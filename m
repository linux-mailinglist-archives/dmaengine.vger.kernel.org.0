Return-Path: <dmaengine+bounces-6924-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1670CBFB25C
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 11:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FEE560345
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EE12FDC4A;
	Wed, 22 Oct 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="fSRJRxMj"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010051.outbound.protection.outlook.com [52.101.228.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1822F5319;
	Wed, 22 Oct 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125100; cv=fail; b=ByL4admeRqLGfUj7VlhMZLR8FNRsmr5tvH9jsjNDL99a2WgLgPixgsQlAK/GLIe32Qm7Ozs4/zh+wFGk5OlsGCsI9II2qyyfe2MV0lAmuiQ/l9lpY5J435KPu8yF6eZrIHwROhQ+yxpMv8dN2mMnRSKd9ULxznmPlFH90pnGZMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125100; c=relaxed/simple;
	bh=DFgndaRdK9mPqz+MuYkD/q3YSu4HQt5aWj1kCLXhA/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aSmBGtD3emtY4XdBs+EZFV9INEl41M80xbcRIMxTXcv6hyD4dGlFDv5IvNf5zDEQGEN1Acmgu3wANFJ3gwqxGJeoEJCh2ZBOqE0lRzme3MIZJBEhc3CUIOtOaemi0zoSXw54ykAlrzWh6VA5/fVVGdWCxLfZRQpbCMEyzeqtrCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=fSRJRxMj; arc=fail smtp.client-ip=52.101.228.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsgAS6idHRea5mncN/1SSWEF5RrDwzmMdYkz6eNY7/EsEzoUKwYcwMQVPmFwb4Fp0V2z/013L/MCJi2G2NMvXSkM/jjbdUArs9OEb3ZgoL+sqdNUw8yLluzMbBucq/H5Et5tIYnmMQgs6UHxGUUm/FQHPwSCttvslQMzbJrhzioG1JXPwGjMBABjJ4MdpYNowXLYkfacjhvFeO5lx+viwioK8bGw96bfUGBxVrwjpGqB17B7j7gxKJnX3kmesNmEGGpq7Rqqa1mEaTnjqv64NpJ4vijlfSqWe0P/oEnKeW6GhHVkFeOrNiFKMi/ZIzKx15ELgmFMsaFqvIDiGiCvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFgndaRdK9mPqz+MuYkD/q3YSu4HQt5aWj1kCLXhA/Y=;
 b=BYxuGuZMqhVTO3mri4S6ajRlASrqAite0z2AYfZkjY3WJwvz/RewPsSOIfBPI2yoDro0HXVAAZqPyF/GD3W5vlUkfH29Ed/NjGJ0eKtLJTxUcE4sfC7GhekAP5M4dvZtJSsPiZYyO8/aBs1CXkVMPkUwIQGzmhbGvz+y1lombClnQmOx9Fbk1IFlVrj+Zd/pA7FpqKH80exlIe7RG9jIB4WqdcRA0t/amlXWGNn8v0QT3rIzaFuZSWSvrjfr5bUkfKyYXDqMpd/3xu91eWxcZLbqXkDJfExRy1lQNiwjV7v867G4hJhI67E2ZtfOPwzaJ17VYxI2KvOpc2GlLzUwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFgndaRdK9mPqz+MuYkD/q3YSu4HQt5aWj1kCLXhA/Y=;
 b=fSRJRxMjZQgW/ZuLr5+tpROQsuAVSyZ1tMIz1s33Dp2y/40RZ4MS3Xv3ED8FONxSb6Vd9GLJ6Ctd+PnI89I3uDr9ssx7RatMmW5oTlkc6HSWlIdmr8bmlCDfBe4H5EKWAZhlVwH+ZzlxYdMaIwSrRAsEATI1yJgKpKn3LuFqZNk=
Received: from TYWPR01MB8805.jpnprd01.prod.outlook.com (2603:1096:400:16b::10)
 by OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 09:24:54 +0000
Received: from TYWPR01MB8805.jpnprd01.prod.outlook.com
 ([fe80::6f4b:7755:832e:177b]) by TYWPR01MB8805.jpnprd01.prod.outlook.com
 ([fe80::6f4b:7755:832e:177b%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 09:24:54 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: geert <geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: sh: rz_dmac: remove braces around single
 statement if block
Thread-Topic: [PATCH] dmaengine: sh: rz_dmac: remove braces around single
 statement if block
Thread-Index: AQHcQybwC5L8JmqQzES8XZfKzb3VdrTN48OAgAAAbEA=
Date: Wed, 22 Oct 2025 09:24:53 +0000
Message-ID:
 <TYWPR01MB88055BE7CD799D9AFEFEE25D85F3A@TYWPR01MB8805.jpnprd01.prod.outlook.com>
References: <20251022073800.1993223-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdXqXGPfQNB3SUQkcsHkaWhxjfN2KG0CNeYdoKwNAT7dYQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXqXGPfQNB3SUQkcsHkaWhxjfN2KG0CNeYdoKwNAT7dYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8805:EE_|OSZPR01MB7004:EE_
x-ms-office365-filtering-correlation-id: 6493650e-a4d7-479e-9e26-08de114cdc07
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y09uazNOTW53N0lKMms5UUFyRjZ6M1dnOGN0WkduVFB3eHY1Zk9pODRCS1BS?=
 =?utf-8?B?R2V1S1NhS256SmUwRjc4Q3dkVitSM0FBMlV5R0V1MFkwRGdCR1pFOFppZElQ?=
 =?utf-8?B?UDZva2pSODZsbmxxZ21sSkJCY1ZsOWMwWDhrbkRjbHk5TElOcVp3VW9VQ1Mr?=
 =?utf-8?B?dWxCVE12b1N1Zjd0NDcyVUpOc2cweGJDQktyU2hTM0s5VHVJSDY5c2hNeGFK?=
 =?utf-8?B?bmJ3N2tLK2U4MEFrbEZodVZxMXk4c25HQkdvRW9CS0Y1UlJ6KzBhOXkzQW8w?=
 =?utf-8?B?b3RMQWpmVmpmSGdwTDZvaksrME15b3Z0MDBiTERPaFc3NThsVFB0NnRvL3Rs?=
 =?utf-8?B?VjMvYXFRbHZDQVBNb0N4b0w5ZUl3eVQ1VEtHN3B3L2hoRVNVdDJNc09jM0JT?=
 =?utf-8?B?a1gwTDdrdy9lVzF5T2JkVHpWZlVRNFBnT0t0VnVPRks2dFkwbzRhcHl2YTA5?=
 =?utf-8?B?ajljSlpVQzd6N3dEdXdBNFc5TXlxMTdBL1I1alpnU3prOXdhb0t6YWZFZXFZ?=
 =?utf-8?B?azI5d2hibWxJcmtYTWFWb1Q0L0tRTDh6TEFORGs2M0RnWDh3cmFBSW81aWNR?=
 =?utf-8?B?YjhVemYvcjZRa0FoME0ySFNBdXNteUxZeGNTMlVFS082R3ZFUlo0SklKclZC?=
 =?utf-8?B?c1FIT21pVkZabFprdXcrdmgzUFFDdzZTVG9ERDU2SHh4Q3VnUnc0ajhxRTNr?=
 =?utf-8?B?dHdjeURZQ21SYWNlbnE2Z0RaY2dUMnY0T0Y4disrMXN1TStMOEowcittUE9a?=
 =?utf-8?B?MVc5Y0Z4cFR4U0pURDc0VmhiOGNKMTkvTUkwcWxjL04vcWUxQzh4MDZRdEFt?=
 =?utf-8?B?T0h1WjRoMndSRzMwMVZrQ1JrTzJLYVNWR0JwalZ0U0VTcWJGVUZ4QVdCaytX?=
 =?utf-8?B?dlJjWFVjZm9rRWZtd0NFdXhYZ21oazlTVk1ydmdGMnhUMldscEdNYXRYSHFU?=
 =?utf-8?B?U0hnUVYrSTBrN3k3WGdBcjdlRzY4VmdoNUUzbHZzbW5TVm5adG9PWnU3czhJ?=
 =?utf-8?B?ZWNza0VGZzRuRmdEUWZxU2VCS3E3MzZQckxGZzBtaGpMZkxSUzY2czZ4bURj?=
 =?utf-8?B?UW5jZlV4UmlmMVBFSHJDWFlBaFFQcnEvR3BJVlBteTM4eVVYeFRRYngwYzU1?=
 =?utf-8?B?M20wdlJWYjl1SGFXMGRCU1BxbEdueGo2ZFNaSnRjY2dPZnBvNFBXNEwwRzJC?=
 =?utf-8?B?dHordDdNN1I5WENRbmdpb0JjdmMvd3ZCRWp3ZzhtL2puMG5KMC8yTTJPemRq?=
 =?utf-8?B?d01zWjVYYlpiY0FIalZBRVZhOXhMaHh4c2hnK3NKdjEyV3paSW1zcmR6RmR5?=
 =?utf-8?B?UThGSXhuVzNFRVNIdnFoT3FMNUNnRUtwZXd5Vys5aGpxc3FMR0pSLytpVi9p?=
 =?utf-8?B?dU9hbTBZaTZ6c2YrUDcyWDNHRnM1RWwzRmYwU1FOOForOHA5S3YyWDJPL2hF?=
 =?utf-8?B?MzNkaklnYlBSVHVacmx5OG1ZOGhLS3RZdDNzbkw3UkFCa2d3WU1tY2kvWXds?=
 =?utf-8?B?Rm5UNGZ0cjNDTmVoajRiNkI3Vmtvd1k5UjQra2x3YXlPaTcxamJWNVAxdnNP?=
 =?utf-8?B?ZXJEdWduSWE0WE16RUh3MW9WWSt6SDJWeXlXU1FiS3ZDTlZZVEFnMUNEaUs1?=
 =?utf-8?B?eE9CL2w1L0t0MXRnemtCeFB3OHE4UVNJTjE5aGlISVpSUVlrcnVmZVhISWJ5?=
 =?utf-8?B?cENSSWt0S29Pc3BIR0ppRE9zV2NrVXFGc2VqSWdRTVdRdjN1UlorRVRlU1dL?=
 =?utf-8?B?UEphampJVzJOV3ViYUdZVGpScEY3Uk51YUFJbDJwbERiUkp0QnNoQnJsS0hO?=
 =?utf-8?B?NitPdnV5ZUhIU0lqR2VxSzlTWWlDWFhQV2FGam5GZWpTcHQ0MnM1dnlKcy82?=
 =?utf-8?B?UXRJY0t1ZnJkYjdZaDBRcHFXajNOMTNKNzRGb2NyOVJkS0pZcHhWU3JVak52?=
 =?utf-8?B?d2xJWWlKaEJsdkNXd3FOcmIzc05zNG5Wdk1PTW1oUk56a1VwcVJXM0c2OTNR?=
 =?utf-8?B?THBoemRQOThmSlN1ZEk1SzMwZ1VYVk5hWEJvNjJaVlhUa1M4V0U2TWFwRlBz?=
 =?utf-8?Q?1dTTX6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8805.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUxRZVVtWGgwYjVkbzJ5ZnBwSmtYR1E4ZWw5ekx5RWxOOFcyVnZSeS9xM3Nx?=
 =?utf-8?B?OHhOc0lkT3pubnBLaE1mSVh2UkFmVkJNd0RBVzZtb0RqMkYrUHVkV0YzMzZ5?=
 =?utf-8?B?eTJCRVRZMjhRZmdQNnNJLzJmSy9KTGNueThQZHlaQzdYR05mbTF1R0FhVHRa?=
 =?utf-8?B?U1c1VElIdWR0TlR2RmhCc1E0clU5QlEvVEFsV2c1WWxuQlMxWTU4aVoyU3pV?=
 =?utf-8?B?bWJuQ1ppRnk2cHdHc2Zlem85eHNLS0JKZGZKL0xpZC9mOEZScUVqUHp4bERD?=
 =?utf-8?B?bStYbGVIVjIvRlFWUWpVdWYweDBsQXgvZWRsbUF6TkdlV3ZBcGtJWVJEUm5X?=
 =?utf-8?B?UFN0clU2ZXBTeHpjWTdZTjY4QWNSZnpqbVduVlNuWUphMnBncjgycHlWTWI5?=
 =?utf-8?B?SjNLRVhZakZIV2YySjFNZGQrNncvUWpidUxZQXFQTUdKOVpzcDdLcFdHUVRK?=
 =?utf-8?B?bW1ETlM0VWd1ZEJ2REgwSThTMEJLOWpGYXM1Q1JQSDVETzFGMzUzN2hkdnNX?=
 =?utf-8?B?UTJpdFlaOHBaRmhPaDhZczFDL1FCODFCVTQ2NW5GVDVhcC9wU3pHbU5Sa0hU?=
 =?utf-8?B?TTUrdi9Hcjduc2FrcW5WaDZQdy85VjdBUEtZMXA4SWxocFFpcGtnT2ZYdHlZ?=
 =?utf-8?B?WVRpS09OcWsyVGtNck45OGhiUFR1WVlCRHN1NjNvMEVTbzR3cjFMOENOMDB1?=
 =?utf-8?B?QUV4bEQ0bjJwaWZnUXRoT3VReUh1b1M3VzF1UDlveS9CbzE3eXdHYitCcnJj?=
 =?utf-8?B?SW8raUJpaklaT29oQkNIQVpGa3lMamhlTlRmdWx1aXJ0THk1d2lPcENCMlA1?=
 =?utf-8?B?aUt1L2E2WUxIR3FuREx2SkpSUDdCZ2xtem9IUXZsRFVZUlR5TExZVHZhMEx1?=
 =?utf-8?B?RWVYZTVsVHZMeVZyb04yRGRLNHphOWx1d0wyKzVTWGpaYUZ3NVNBMjlEMXZt?=
 =?utf-8?B?djI1OTlqanpDc1dibnQvT1cwYkUrVmFNd0dtUWRwaXhFSXZ4UjBjbEkzV0J2?=
 =?utf-8?B?S09MTzBpOU55eEZSZEJzWUk4WnIxYTU0ellHOXFnRVBkV0lzWVkxNHhXWWFv?=
 =?utf-8?B?UHdwd2doUDJkY1N3bDUzRkpVekxGOFg5TnMzOE1MajZpNWVPbFlXSUtoREJN?=
 =?utf-8?B?dWxTRHc4dzhqNTBUNWUrN2hRTVpKelpNRFo2aEQ3RllQMUVsMC9EWDJwb2xq?=
 =?utf-8?B?Rkh6dzNuRDlVTnkvQXdVWVVRSGhZZHJlUzQ5Y2ZYQ21IOHZFZFBSTHd2UDdV?=
 =?utf-8?B?QklObGR1d0JycmFoMW9oQVFob0hNYlZuUHp4TEtDSVFrdzRyWGwwN1VpSFpQ?=
 =?utf-8?B?emhXV3pkRVZZR2pzRUgwcXdJS0hxOU5Da0wwOTNJQ24wa3pRQXZDbFR5ajZU?=
 =?utf-8?B?UUpjTHkxWWJrS2ZWK2FpSkswSEExT1FRTGJacDQ2MHZXdEZBbTFhT21FMTFk?=
 =?utf-8?B?SHRhQ2VmOGswWUxWakhHWjRsRTcvQmx6QUM1cTU0Y3ErTi9meW14RDFJUnFD?=
 =?utf-8?B?ZEVTdTBDcHcyUG5nZGpvRHprMElKV3BSY0xwVFZjbjg5dHppeGNML0Nucm5N?=
 =?utf-8?B?WVpVblh4YzJtdHJDQzlpbDlTbHZzOTA5TlVPa3F0QmRZc3hEOGZJbGRseFVB?=
 =?utf-8?B?UVh0d2plZ283amRjQ3dqd2kvS2p5aFk5T0VZMlB6NG5wc0MzaElPeTZ3RHUv?=
 =?utf-8?B?NkJEMTZXNFRpV0phbENtVUJlaG5EYSt6MENERlNQWEdxdVNSeVZPbkVOMDF3?=
 =?utf-8?B?aXRCWTdtY1BRZk85cEVmS2tTRXVFbmVRSzZNaGxoVkZRamM0RHdQdDRodENU?=
 =?utf-8?B?eXZ5S1MyenFnQ2c3aWozTWUvc21PQk9BdjhsdFdBY012cWFBMW0rZGpyMDVJ?=
 =?utf-8?B?WXVzQTE2blJQcDNLTW42QU5KalE0ODViazdwM2RmTExzbWJ1S0s4WklaY01u?=
 =?utf-8?B?R2U5bkdtUFJkVDBBWUFmL3BxMndJQlRLNzFNcHBVeE9iV3l1d3lYKys0dzEr?=
 =?utf-8?B?aUVBa1hDbjNOdkpCaEhrWkJxT1ltdWpKTWJVbStVVHdaOWxUR0RrNzU2NnRh?=
 =?utf-8?B?ZlhMUXZJSGp3T3NPaFlGYTdJazVlcUlsZ21kMmtHd2tvakN0MHdxNkZvTnFQ?=
 =?utf-8?B?a2hvQVE5OTF3UVlOb2txTjl0NG5LbEdWQmhLbHZQK1pjYnNESFpmZTUwM2c2?=
 =?utf-8?Q?yl5RmgTikPv937z5/r4X9XQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8805.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6493650e-a4d7-479e-9e26-08de114cdc07
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 09:24:53.9591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIln4hIntzrTj+Imzrhy889P8Gcjs3TX/ANsG88xjcDR9+0y7/w51bEi4NK7AisGKJYaz8fjGj61n9/XnI5uU5u7T4ebV/WGOX6rK+HLMth4gknpW8W8nF6FnI7SHXjs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7004

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9l
dmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIy
LCAyMDI1IDEyOjIwIFBNDQo+IFRvOiBDb3NtaW4tR2FicmllbCBUYW5pc2xhdiA8Y29zbWluLWdh
YnJpZWwudGFuaXNsYXYueGFAcmVuZXNhcy5jb20+DQo+IENjOiBWaW5vZCBLb3VsIDx2a291bEBr
ZXJuZWwub3JnPjsgUHJhYmhha2FyIE1haGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQu
cmpAYnAucmVuZXNhcy5jb20+Ow0KPiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryby5q
ekByZW5lc2FzLmNvbT47IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRtYWVuZ2luZTogc2g6
IHJ6X2RtYWM6IHJlbW92ZSBicmFjZXMgYXJvdW5kIHNpbmdsZSBzdGF0ZW1lbnQgaWYgYmxvY2sN
Cj4gDQo+IEhpIENvc21pbiwNCj4gDQo+IE9uIFdlZCwgMjIgT2N0IDIwMjUgYXQgMDk6MzksIENv
c21pbiBUYW5pc2xhdg0KPiA8Y29zbWluLWdhYnJpZWwudGFuaXNsYXYueGFAcmVuZXNhcy5jb20+
IHdyb3RlOg0KPiA+IEJyYWNlcyBhcm91bmQgc2luZ2xlIHN0YXRlbWVudCBpZiBibG9ja3MgYXJl
IHVubmVjZXNzYXJ5LCByZW1vdmUgdGhlbS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENvc21p
biBUYW5pc2xhdiA8Y29zbWluLWdhYnJpZWwudGFuaXNsYXYueGFAcmVuZXNhcy5jb20+DQo+IA0K
PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVy
aG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gDQoNClRoYW5rcyBHZWVydC4NCg0K
PiA+IC0tLSBhL2RyaXZlcnMvZG1hL3NoL3J6LWRtYWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZG1h
L3NoL3J6LWRtYWMuYw0KPiA+IEBAIC0zMzYsMTMgKzMzNiwxMiBAQCBzdGF0aWMgdm9pZCByel9k
bWFjX3ByZXBhcmVfZGVzY19mb3JfbWVtY3B5KHN0cnVjdCByel9kbWFjX2NoYW4gKmNoYW5uZWwp
DQo+ID4gICAgICAgICBsbWRlc2MtPmNoZXh0ID0gMDsNCj4gPiAgICAgICAgIGxtZGVzYy0+aGVh
ZGVyID0gSEVBREVSX0xWOw0KPiA+DQo+ID4gLSAgICAgICBpZiAoZG1hYy0+aGFzX2ljdSkgew0K
PiA+ICsgICAgICAgaWYgKGRtYWMtPmhhc19pY3UpDQo+ID4gICAgICAgICAgICAgICAgIHJ6djJo
X2ljdV9yZWdpc3Rlcl9kbWFfcmVxKGRtYWMtPmljdS5wZGV2LCBkbWFjLT5pY3UuZG1hY19pbmRl
eCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hhbm5l
bC0+aW5kZXgsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFJaVjJIX0lDVV9ETUFDX1JFUV9OT19ERUZBVUxUKTsNCj4gPiAtICAgICAgIH0gZWxzZSB7DQo+
ID4gKyAgICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgICAgIHJ6X2RtYWNfc2V0X2RtYXJzX3Jl
Z2lzdGVyKGRtYWMsIGNoYW5uZWwtPmluZGV4LCAwKTsNCj4gPiAtICAgICAgIH0NCj4gDQo+IFNl
ZWluZyB0aGlzIHNhbWUgY29uc3RydWN0IGJlaW5nIHJlcGVhdGVkIHRocmVlIHRpbWVzLCBJIHRo
aW5rIGl0DQo+IHdvdWxkIGJlIGdvb2QgdG8gaW50cm9kdWNlIGEgaGVscGVyIChpbiBhIHNlcGFy
YXRlIHBhdGNoLCBvZiBjb3Vyc2UpLg0KPiANCg0KR290IGl0LCBJJ2xsIHN1Ym1pdCBhIHNlcGFy
YXRlIHBhdGNoIGZvciB0aGF0IHRvZ2V0aGVyIHdpdGggdGhlIGFkZGl0aW9uDQpvZiBzdXBwb3J0
IGZvciBSWi9UMkggYW5kIFJaL04ySCB3aGVuIGl0J3MgcmVhZHkuDQoNCj4gR3J7b2V0amUsZWV0
aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4g
R2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAt
LSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3
aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVu
IEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNv
bWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0g
TGludXMgVG9ydmFsZHMNCg==

