Return-Path: <dmaengine+bounces-4655-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A00A54C69
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 14:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A365170BCE
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 13:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D520E6E1;
	Thu,  6 Mar 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="VdYw93hO"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011006.outbound.protection.outlook.com [40.107.74.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7091199B9;
	Thu,  6 Mar 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268470; cv=fail; b=ZDRZ7QLGqLB2z+EeAmZmHNhOMncB3zPoJQfu7lxSgDQ3PVzq7Jzaca7h1XVGywlwyhBTSmdhJFe4Ym4U0VkbE1rud1SEJmUUQetO0tlTI3SGXorKeLcdwG+uqpboLxOdwjGE2AkKv0Oj4YKkuxLUgG8r2s+RTgZ707KAArOiD6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268470; c=relaxed/simple;
	bh=FXJdi3R8x/BBnWQ7tN2i/TtPETkPHLjd2INf7aK1BXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eCrzhQPHdmVib/5aZjCIjDNIfhpUCQh9mS+F9LJ8zOa5F/4mtPVl1zeBWCN4csoKnrriuQJcwRtqRFSZk/Q+TTD5cx0mhKHpbivD9dSItvdSe+wr662yMAsirCV3pjNYCGmos0NDsTGeVcpxcVrDCZgBEisc1LuK7AIdfAFdhNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=VdYw93hO; arc=fail smtp.client-ip=40.107.74.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSVYlMtLAZAqGxsEAgXTYZuUmsJhfCp4ECuUg+jZFJdwjUWhh9sqxrlXA9la1VbAdEAlgoUw8oQGV+dopmS5ufW30xOIBzag2ETbc9GT6Uuk2V9Hz9PXrmNn/5ftmJPEZ9Z///EOGOKzAPlKfaVhjQXb4hNSNbafYhhF9pu89S8Gc8yfgdvlGPWiG4XCqLOCd3Yx+wvgHL2Lsy8v6hW+w2UUL4q62eKGZjh1VMuI1f447gK5gZN/RxaxjkImyf4VbJWFPgOT3zwpmpS/skWXWGsBy3b4ri9iKVtaJKqAdksHJMpm1wZeuehGYG8YhHyCt/Lw4sFcUPkg5rU+Gr41lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXJdi3R8x/BBnWQ7tN2i/TtPETkPHLjd2INf7aK1BXg=;
 b=vxdkZahtO48dPvRcCNLySN/V/Pu2ySjdPTC7aMQgdDz9SEPIudcx52t0VGEkQqKgp72lQog/nmOjQ1C3r2awTdwq2lxlvrU8BRwwZHrxwp2l3Zk28iZZIF9yO/UeWoaItXOzFJUIvZRAw6v+Gy77+KmQi3ypQArDLb4eDYSMp9qT/e5SgeiWsLatev3qPLXXwqZzyb1Ld8IS1Ez40tro5t5DcNhHx+ZfA6Pv8RzrlurDtSklAnedQTg/WbkICJsH8vdBm51/QfGOHVqiU+iXtEZc/DuG2cEEVS2iV+7swHMR6JOajsmUc6H/2Zu3Wq7vBXUXXaF16qsiXr/UhPcZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXJdi3R8x/BBnWQ7tN2i/TtPETkPHLjd2INf7aK1BXg=;
 b=VdYw93hONkBw/X3VVjiPTbVaSZ6TKab0PbLYlzAM2Yf4boyhny7/TTjc4vuza02aOdm5X/GlDZw+ijZwgvfqsABgepjGQG5H2Bj+nCe54Z9gpvw66Vu0ey167DrYCM1J3b0q0vpCuTUdGe0zWeieIjEDtAZwAOHP2cetqxWnDrY=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TY7PR01MB14473.jpnprd01.prod.outlook.com (2603:1096:405:242::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 13:41:01 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 13:41:01 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus
 Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v5 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Topic: [PATCH v5 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Index: AQHbjWSPUX1HH0xRgUuEfUBuZoXkH7NmHB8AgAABvQA=
Date: Thu, 6 Mar 2025 13:41:01 +0000
Message-ID:
 <TYCPR01MB12093F6DB584A044473146B9AC2CA2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com>
 <20250305002112.5289-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdVeLiQKHm5BQXhqEjKTP4p7Y20b5ocsjvNCnicDQym19A@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVeLiQKHm5BQXhqEjKTP4p7Y20b5ocsjvNCnicDQym19A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TY7PR01MB14473:EE_
x-ms-office365-filtering-correlation-id: 8a1c75b0-3c45-4ebd-2f59-08dd5cb488e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUxBS1ZqeDd0eVhQaHdaS0krdWJoQ29mMFJTL1NQaXU4RkYvdkp1Nldlb2Fz?=
 =?utf-8?B?cml3K2N5UzVaSTdhOGpSbnlubDhDL0M1QzNUTzdwTzgyWXMzd0dEa3M3ek5k?=
 =?utf-8?B?ZVpmWGRIVUZBRXEvT1BNclZiMEFTUXk4T0tFcGdVV2NIUk03WDNQWHgzbUw0?=
 =?utf-8?B?YUVoeVRkd1ZkemNKRVhoQ2VBK3hiNUVHdmxPNW5ES0pJLzhrbWRvZnZsTmx0?=
 =?utf-8?B?THpTd0pDbWljYmg3cnNjVk05d2ZSVElPZFhnTm00SEFWRE1ZZ2ZIUWFaN2dq?=
 =?utf-8?B?aVoraHBNL0VheWFDNHFDaWZBRGppNFN6WGtGTW81NmlUQzU4QmZZZWpmMjBW?=
 =?utf-8?B?R0R4VVhSL2hzMEpKbUxsVkJ1U0wvS2pIdyttbm5XSlJVbEU0czkvRFFpMVFK?=
 =?utf-8?B?Y3ZiVDk4R1pqUnlYUmJQd2FHMUpldXEya0RuM1RQYW5PVC9iRFZQMTliY2tT?=
 =?utf-8?B?MXpDVmQ1aHU4Y0RQRTJ5THVMYndIRWoyL0hjcUpkVTdWVmJVLyt3UUw2Wmt4?=
 =?utf-8?B?YTBPcEZXOWV0Z3Zqd2E1Rno5MDJEUTZlcFhBSEFOYVZVZmdPM0x0YXBDVmV2?=
 =?utf-8?B?eC82bUQrcnFFb0crWVAzUlJ5YUJDcHN5SUQxakFVMW5MbzNqR2VQQlYxSmVs?=
 =?utf-8?B?R0dCRklwbTk4Nm5MRkR2L3FvQm5ZOTZEWWJlZlEwWDZDUnp4dExNWUJncGl6?=
 =?utf-8?B?Nk5MYVIxRlpHRDF2SmZSOVYzSUZ3ZmpUQzROOWt4Qk8yMnF2dFc3cDZtTUNB?=
 =?utf-8?B?S2h2RlF5OHhYRU5YWC95TGIvMzNnbFV6WnVOWW55djZVNlFTZWtqdmpVS1o3?=
 =?utf-8?B?YUxuTy9FVnRvRWJyMEl3d1lCYWZWYmJ1Z3Q2TGFEcWdLUFlCNExlRG5lbUh2?=
 =?utf-8?B?TmxXTnZNRGlMZE52NFZUZ0taVHlFbC9vZ21LNVpNaDRtMUM0dUNZN2llVG9Z?=
 =?utf-8?B?NzhYaHFxR2k2aEd2ZnJucG44UEFzc2FVc2ZoMFhVOWVpZTRZRSt1akROcnpJ?=
 =?utf-8?B?ODJNQkEvd0VSeENpdlZlWVZLczRTZWZCcjRwSngrY0NQdGdPUWNnRFNxQzl2?=
 =?utf-8?B?bStNM3Fxa3l5djExUzBpczFhdzRDRHpKOGgweU1udUJub1pZa1pJK2ZxbXZt?=
 =?utf-8?B?N2hxZlo5Z2psb1JLZGE2dnQyM0NjTXJoeG5xV2wrSSswNlVVNlJZVUpJNzdM?=
 =?utf-8?B?WDBoeVVEZlg0Q0V5ZVNtZFN6T1VyUHlIa3BPY3ZZUjRaUzVXc2Fpdi9zOEJ3?=
 =?utf-8?B?MGUwRk41S0lLS2pud0FQZGpxTjZscUcvdWR6UHNTZUczNFVnejFFQkZQQ01Y?=
 =?utf-8?B?UVlzTjNrWThKL2JLc21ibng1RTNSL0JMam9mWUhycVU3UzBiK0Q1Nm5qYmZX?=
 =?utf-8?B?a1VnMytSa0lPNi8wcWdKbXpubEsvTjBJTEY0bXYrblp4YXJJR0hHTG13NWRl?=
 =?utf-8?B?cTgybkdlcEVWZFZtYXdleWwxR04rZXNjMHZVaFllS1h0N1VKTnh3b1pOelpE?=
 =?utf-8?B?Z3FTRlN6WDRTblNPZjVnTGxkY3BzRjkyUXFYZS9jL0dLWWp6K2FOdVNpTWZF?=
 =?utf-8?B?K3F6YXcwQit3RTgybG8yYkZlelZkU25Qd3pXVVg0WTJZZnpBS3V6YklXTGtn?=
 =?utf-8?B?bFlNbjRZTXJTYkc5RFI1RUpZaTBJNlNFSHFQSWJOUWpRT0Y3VGU1NkdId0d0?=
 =?utf-8?B?Q0h6VXROK2NlL0lvdTFlb043N1BTQndCMk00R3lGTjdhNENCOEgxVVpjR2Fs?=
 =?utf-8?B?QmtuN1U3a0Z2aG9hMTZUVVVtTzJwcCsyWkZRT2ovdyticUt6RndIbG1FMXUz?=
 =?utf-8?B?OXp4Vk1QVHpsSXA5dHArR2EydEpUbmE4RWkyQkVXUjU2L1drK1ZsN0hleld4?=
 =?utf-8?B?NlN2N0tMMEpQQmErcEtlZzh5K2hlQUcwdktCZDd1NFZKVnNwdHhTb2FaRE5B?=
 =?utf-8?Q?e9tMnGF0kV7ZinPjLvb8urRaUP/oVJ75?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkVXakU5N0JDVk9HTFNBZUVEaGpGa0dpbXpaV01QdzZPd2hSbDFUWkxSenR3?=
 =?utf-8?B?Ym1CZnU4QVJZMTVlMXFwM1hYak00cmxKZFl2RFcwZGlUWjR1WmRCUnVVa3lP?=
 =?utf-8?B?SWo0cTZsRXJHcjhYY0dud2lNRjZuQVpta3UxdkVwQnRiQ1ppcGFhT0FQOFZz?=
 =?utf-8?B?dzBiai9ZNHgvcmpiVDJlckVTVnJkak1STEdMSndHbnlRdmZSUWJRMFBBY2FF?=
 =?utf-8?B?T3RCRDB2VmRnYmZBTmwrNkpBMjZld1N3dXFmNEljVERaOHI3R3I2OFFOc0pk?=
 =?utf-8?B?V2lzNnpSN2F0cVAvSUNObVphR0RicVkrRUtYRWhJS2hwYmNzcHlLR3E1V3NW?=
 =?utf-8?B?cUp3Nk1GUktGLzZOUUx4L3FLSkRBL0VsakxObHRBVGF4cmswUzVXU2dDdUFv?=
 =?utf-8?B?NEJ0MDRCUklySmtkLzhxeWFpTDZuelE2cVYrSmhqVlgrc1BsdHdpenNmKzZa?=
 =?utf-8?B?a3NOcDFtQmVkTGVqUnc0emlTVDF2Y3drTFJnV1ZvaUZJNWZzWXBwendUMllI?=
 =?utf-8?B?cElQODIvZDJMMzVzemRKRUdpcEQzeWlmb1lTdnZ0dVZpbFBKSTFMZWkwNHB3?=
 =?utf-8?B?SmcxcFlLNFlOcGc5NW5VcmdQT2g3TWNVNEVCclVJN3dKWDNCaXc3Q081dDRo?=
 =?utf-8?B?UHhYS0x1anFzUjY1NitpTVhWUzNHMTV6OFlzTWJXSWF4bHFxV1UrWHRDNXgw?=
 =?utf-8?B?Z095cXF2cE50NC8ydDM5dXluY1haOGxVQU15MTI0cmcvSDdaRnkzZ2RLZmJY?=
 =?utf-8?B?SkswaEZIczRIbWFxNUljR0JGRk9xZStrd1oxbi9POFh5K3NraE00dlNzT0N1?=
 =?utf-8?B?bXJ2aytHZmovZm8yWDNrd0FrV002eU15YjlwMXJyS0x1UnZnZkJGT2g3SWRv?=
 =?utf-8?B?bUhWM1RWaHRmUFFld1orWVRPOXhKQXdFYW56K2Z1Vlo3QVhsVkNna3NVMVRv?=
 =?utf-8?B?OExoSjlMRjEwdzZPMjh3bHd6OHppN05XS2lFWURibk9vWlZjMDZERDBMNk1K?=
 =?utf-8?B?dWpkQkpIYm81SVF4bmxSSGZnYzdRU1dWTHdrQTVacExxTVBTV1prWVBjRVVy?=
 =?utf-8?B?cmp4U01FWHJDbGtJaTdRZG9tbHl4NW0xdFl3NWlYQXdxTWN4Qk1vVk5MSzQr?=
 =?utf-8?B?Vmt0V0dwM0NFNjd1K0h6K3p6WnJJUU15SnpudXpibDB6NGFsSm8wYTIzTDBF?=
 =?utf-8?B?dzhFaTQ4WXVJcnVTbkdtOUZqbWNyenY5bk1PY3Q5YnlucUZ5ODRlQ2JJMGRM?=
 =?utf-8?B?VE5Ub25zRVVTTmF0ck1zL0lYNmRQQjI3UHJHWCtyYnE1aWwxblVPZG1ZbmRE?=
 =?utf-8?B?Q0IzY0ZIUzVWWUdVZXU4ajhVVWw2S3ltNzNXcERXVEJzNFdGWGZOdnZMNitB?=
 =?utf-8?B?MnBuc1VKaXFIaG1QVStxZytWblFmTC85L1hYRldYY1hoNjB6Zm9DSGJZeXQ0?=
 =?utf-8?B?U0dsc0h1QVpjSHp0RzRQend1dXZGU1I1SnBKaWNhdE84UVhZTjZ4KzNRWHhj?=
 =?utf-8?B?YThjeEpWemdiYUh5RzdtM1BObHVpNmk4SjhsQXZ4Qld2TlRFbTZ3bis5UVdi?=
 =?utf-8?B?STRPNXA3RkpDRm16d0NqNVVRTFN3MG94Rzh2K1ZKeEZ3SlRTc0VXbVRZWWo5?=
 =?utf-8?B?Q3E0ODBrMjgwbXFTRTVZZ1dTZmRwTHU3V3NlcGNWOUNobGxnMG1mNzhERGo2?=
 =?utf-8?B?aW5aWnVyWndWdlgxa0p0VmREdEowOFBTclZLQVVNbWxJSjNwQkc5SGsvbHVm?=
 =?utf-8?B?ZkZvMnRxNXZ3Z2Z3ZnU0OEp1YndsYmtOdjNuMHlMemEwdjVDQmlDTm5MNkgy?=
 =?utf-8?B?SHlBU3RqRGs5QU1mbFRrbmlTdDdxWkRwYlFIYVdPZ003RXVjVHQ2eGhxQk9m?=
 =?utf-8?B?K3laUW9Sam1uNldndjE2M1lZdFozc0tBei9kYkQ4VXliZ202YkF5SFlURC9s?=
 =?utf-8?B?MEI1d3p1dERpeWJKUlhscEI0c0pidkdyN1dUMUkxKzhBcmZtQXc5SGwxVFE4?=
 =?utf-8?B?dWV2ZEFOS2VpV2RhMWo0Zlc5YUxkRjlxVGNqYjFqWE1LUmYxV2JvVGlDQTFB?=
 =?utf-8?B?c1dxSko0MU1UdW9teEdzRVRNYmJIS2VHQXFMV3NYL2FFNUFOT243RzNFMmg4?=
 =?utf-8?B?aGpSL25rQkN4cGtHa3RDYytMeURjRmFiVTdWMHozQnlaUG03TEtVMWgvK0hl?=
 =?utf-8?B?ZkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1c75b0-3c45-4ebd-2f59-08dd5cb488e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 13:41:01.6859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DucYfIshxO+EatFsd7DSQ8CZZthI3xMsfQAgkeBwjet7seCsAHfc877/nXuu84TfL6h+lt/J36MeClK12rhOIMIfjS5K/NcrCBVzSE5UsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14473

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAwNiBNYXJjaCAyMDI1
IDEzOjI3DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi82XSBkdC1iaW5kaW5nczogZG1hOiBy
ei1kbWFjOiBEb2N1bWVudCBSWi9WMkgoUCkgZmFtaWx5IG9mIFNvQ3MNCj4gDQo+IEhpIEZhYnJp
emlvLA0KPiANCj4gT24gV2VkLCA1IE1hciAyMDI1IGF0IDAxOjIxLCBGYWJyaXppbyBDYXN0cm8N
Cj4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gRG9jdW1lbnQg
dGhlIFJlbmVzYXMgUlovVjJIKFApIGZhbWlseSBvZiBTb0NzIERNQUMgYmxvY2suDQo+ID4gVGhl
IFJlbmVzYXMgUlovVjJIKFApIERNQUMgaXMgdmVyeSBzaW1pbGFyIHRvIHRoZSBvbmUgZm91bmQg
b24gdGhlDQo+ID4gUmVuZXNhcyBSWi9HMkwgZmFtaWx5IG9mIFNvQ3MsIGJ1dCB0aGVyZSBhcmUg
c29tZSBkaWZmZXJlbmNlczoNCj4gPiAqIEl0IG9ubHkgdXNlcyBvbmUgcmVnaXN0ZXIgYXJlYQ0K
PiA+ICogSXQgb25seSB1c2VzIG9uZSBjbG9jaw0KPiA+ICogSXQgb25seSB1c2VzIG9uZSByZXNl
dA0KPiA+ICogSW5zdGVhZCBvZiB1c2luZyBNSUQvSVJEIGl0IHVzZXMgUkVRIE5vDQo+ID4gKiBJ
dCBpcyBjb25uZWN0ZWQgdG8gdGhlIEludGVycnVwdCBDb250cm9sIFVuaXQgKElDVSkNCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2FzdHJvLmp6QHJl
bmVzYXMuY29tPg0KPiA+IEFja2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNy
b2NoaXAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFo
YWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gdjQtPnY1Og0KPiA+ICog
UmVtb3ZlZCBBQ0sgTm8gZnJvbSB0aGUgc3BlY2lmaWNhdGlvbiBvZiB0aGUgZG1hIGNlbGwuDQo+
ID4gKiBJIGhhdmUga2VwdCB0aGUgdGFncyByZWNlaXZlZCBhcyB0aGlzIGlzIGEgbWlub3IgY2hh
bmdlIGFuZCB0aGUNCj4gPiAgIHN0cnVjdHVyZSByZW1haW5zIHRoZSBzYW1lIGFzIHY0LiBQbGVh
c2UgbGV0IG1lIGtub3cgaWYgdGhpcyBpcw0KPiA+ICAgbm90IG9rYXkuDQo+IA0KPiBUaGFua3Mg
Zm9yIHRoZSB1cGRhdGUhDQo+IA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9kbWEvcmVuZXNhcyxyei1kbWFjLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZG1hL3JlbmVzYXMscnotZG1hYy55YW1sDQo+ID4gQEAgLTYx
LDE0ICs2NiwyMSBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICcjZG1hLWNlbGxzJzoNCj4gPiAgICAg
IGNvbnN0OiAxDQo+ID4gICAgICBkZXNjcmlwdGlvbjoNCj4gPiAtICAgICAgVGhlIGNlbGwgc3Bl
Y2lmaWVzIHRoZSBlbmNvZGVkIE1JRC9SSUQgdmFsdWVzIG9mIHRoZSBETUFDIHBvcnQNCj4gDQo+
IFBsZWFzZSBqdXN0IGluc2VydCAib3IgdGhlIFJFUSBObyIgYW5kIGJlIGRvbmUgd2l0aCBpdD8N
Cg0KV2lsbCBkby4NCg0KPiANCj4gPiAtICAgICAgY29ubmVjdGVkIHRvIHRoZSBETUEgY2xpZW50
IGFuZCB0aGUgc2xhdmUgY2hhbm5lbCBjb25maWd1cmF0aW9uDQo+ID4gLSAgICAgIHBhcmFtZXRl
cnMuDQo+ID4gKyAgICAgIEZvciB0aGUgUlovQTFILCBSWi9GaXZlLCBSWi9HMntMLExDLFVMfSwg
UlovVjJMLCBhbmQgUlovRzNTIFNvQ3MsIHRoZSBjZWxsDQo+ID4gKyAgICAgIHNwZWNpZmllcyB0
aGUgZW5jb2RlZCBNSUQvUklEIHZhbHVlcyBvZiB0aGUgRE1BQyBwb3J0IGNvbm5lY3RlZCB0byB0
aGUNCj4gPiArICAgICAgRE1BIGNsaWVudCBhbmQgdGhlIHNsYXZlIGNoYW5uZWwgY29uZmlndXJh
dGlvbiBwYXJhbWV0ZXJzLg0KPiA+ICAgICAgICBiaXRzWzA6OV0gLSBTcGVjaWZpZXMgTUlEL1JJ
RCB2YWx1ZQ0KPiA+ICAgICAgICBiaXRbMTBdIC0gU3BlY2lmaWVzIERNQSByZXF1ZXN0IGhpZ2gg
ZW5hYmxlIChISUVOKQ0KPiA+ICAgICAgICBiaXRbMTFdIC0gU3BlY2lmaWVzIERNQSByZXF1ZXN0
IGRldGVjdGlvbiB0eXBlIChMVkwpDQo+ID4gICAgICAgIGJpdHNbMTI6MTRdIC0gU3BlY2lmaWVz
IERNQUFDSyBvdXRwdXQgbW9kZSAoQU0pDQo+ID4gICAgICAgIGJpdFsxNV0gLSBTcGVjaWZpZXMg
VHJhbnNmZXIgTW9kZSAoVE0pDQo+ID4gKyAgICAgIEZvciB0aGUgUlovVjJIKFApIFNvQyB0aGUg
Y2VsbCBzcGVjaWZpZXMgdGhlIERNQUMgUkVRIE5vIGFuZCB0aGUgc2xhdmUgY2hhbm5lbA0KPiA+
ICsgICAgICBjb25maWd1cmF0aW9uIHBhcmFtZXRlcnMuDQo+ID4gKyAgICAgIGJpdHNbMDo5XSAt
IFNwZWNpZmllcyB0aGUgRE1BQyBSRVEgTm8NCj4gPiArICAgICAgYml0WzEwXSAtIFNwZWNpZmll
cyBETUEgcmVxdWVzdCBoaWdoIGVuYWJsZSAoSElFTikNCj4gPiArICAgICAgYml0WzExXSAtIFNw
ZWNpZmllcyBETUEgcmVxdWVzdCBkZXRlY3Rpb24gdHlwZSAoTFZMKQ0KPiA+ICsgICAgICBiaXRz
WzEyOjE0XSAtIFNwZWNpZmllcyBETUFBQ0sgb3V0cHV0IG1vZGUgKEFNKQ0KPiA+ICsgICAgICBi
aXRbMTVdIC0gU3BlY2lmaWVzIFRyYW5zZmVyIE1vZGUgKFRNKQ0KPiANCj4gLi4uIHNvIHRoZSBj
YXN1YWwgcmVhZGVyIGRvZXNuJ3QgaGF2ZSB0byBsb29rIGZvciB0aGUgKG5vbmV4aXN0aW5nKQ0K
PiBkaWZmZXJlbmNlcyBpbiB0aGUgb3RoZXIgYml0cy4NCg0KQWdyZWVkLg0KDQo+IA0KPiA+DQo+
ID4gICAgZG1hLWNoYW5uZWxzOg0KPiA+ICAgICAgY29uc3Q6IDE2DQo+ID4gQEAgLTgwLDEyICs5
MiwyOSBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgaXRlbXM6DQo+ID4gICAgICAgIC0gZGVzY3Jp
cHRpb246IFJlc2V0IGZvciBETUEgQVJFU0VUTiByZXNldCB0ZXJtaW5hbA0KPiA+ICAgICAgICAt
IGRlc2NyaXB0aW9uOiBSZXNldCBmb3IgRE1BIFJTVF9BU1lOQyByZXNldCB0ZXJtaW5hbA0KPiA+
ICsgICAgbWluSXRlbXM6IDENCj4gPg0KPiA+ICAgIHJlc2V0LW5hbWVzOg0KPiA+ICAgICAgaXRl
bXM6DQo+ID4gICAgICAgIC0gY29uc3Q6IGFyc3QNCj4gPiAgICAgICAgLSBjb25zdDogcnN0X2Fz
eW5jDQo+ID4NCj4gPiArICByZW5lc2FzLGljdToNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+
ICsgICAgICBPbiB0aGUgUlovVjJIKFApIFNvQyBjb25maWd1cmVzIHRoZSBJQ1UgdG8gd2hpY2gg
dGhlIERNQUMgaXMgY29ubmVjdGVkIHRvLg0KPiANCj4gQXJlIG90aGVyIFNvQ3Mgd2l0aCBJQ1Ug
cGxhbm5lZD8NCg0KWWVzLg0KQWxzbyB0aGUgRE1BQ3Mgb24gUlovRzNFIGFyZSBjb25uZWN0ZWQg
dG8gdGhlIElDVSBpbiBhIHNpbWlsYXIgZmFzaGlvbi4NCg0KPiANCj4gPiArICAgICAgSXQgbXVz
dCBjb250YWluIHRoZSBwaGFuZGxlIHRvIHRoZSBJQ1UsIGFuZCB0aGUgaW5kZXggb2YgdGhlIERN
QUMgYXMgc2Vlbg0KPiA+ICsgICAgICBmcm9tIHRoZSBJQ1UgKGUuZy4gcGFyYW1ldGVyIGsgZnJv
bSByZWdpc3RlciBJQ1VfRE1rU0VMeSkuDQo+IA0KPiBUaGlzIGlzIGFscmVhZHkgZGVzY3JpYmVk
IG1vcmUgZm9ybWFsbHkgYmVsb3cNCj4gDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55
YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAg
ICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgIC0gZGVzY3JpcHRpb246IHBoYW5kbGUgdG8gdGhl
IElDVSBub2RlLg0KPiA+ICsgICAgICAgICAgLSBkZXNjcmlwdGlvbjogVGhlIERNQUMgaW5kZXgu
DQo+ID4gKyAgICAgICAgICAgICAgNCBmb3IgRE1BQzANCj4gPiArICAgICAgICAgICAgICAwIGZv
ciBETUFDMQ0KPiA+ICsgICAgICAgICAgICAgIDEgZm9yIERNQUMyDQo+ID4gKyAgICAgICAgICAg
ICAgMiBmb3IgRE1BQzMNCj4gPiArICAgICAgICAgICAgICAzIGZvciBETUFDNA0KPiANCj4gT3Ro
ZXIgU29DcyBtYXkgaGF2ZSBvdGhlciBtYXBwaW5ncy4NCj4gU28gcGVyaGFwcyBsZWF2ZSBvdXQg
dGhlIHRyYW5zbGF0aW9uIHRhYmxlLCBidXQgd3JpdGU6DQo+IA0KPiAgICAgVGhlIG51bWJlciBv
ZiB0aGUgRE1BQyBhcyBzZWVuIGZyb20gdGhlIElDVSwgaS5lLiBwYXJhbWV0ZXIgayBmcm9tDQo+
IHJlZ2lzdGVyIElDVV9ETWtTRUx5Lg0KPiAgICAgVGhpcyBtYXkgZGlmZmVyIGZyb20gdGhlIGFj
dHVhbCBETUFDIGluc3RhbmNlIG51bWJlciENCg0KR29vZCBzaG91dCwgSSB3aWxsIGFkanVzdCBh
Y2NvcmRpbmdseS4NCg0KSSdsbCB3YWl0IGZvciB5b3VyIGZlZWRiYWNrIG9uIHRoZSBJQ1UgZHJp
dmVyIHBhdGNoIGFuZCBvbiB0aGUgRE1BQyBkcml2ZXIgcGF0Y2gNCmJlZm9yZSBzZW5kaW5nIHY2
Lg0KDQpUaGFua3MhDQoNCkNoZWVycywNCkZhYg0KDQoNCj4gDQo+ID4gKw0KPiA+ICByZXF1aXJl
ZDoNCj4gPiAgICAtIGNvbXBhdGlibGUNCj4gPiAgICAtIHJlZw0KPiA+IEBAIC05OCwxMyArMTI3
LDI1IEBAIGFsbE9mOg0KPiA+ICAgIC0gJHJlZjogZG1hLWNvbnRyb2xsZXIueWFtbCMNCj4gPg0K
PiA+ICAgIC0gaWY6DQo+ID4gLSAgICAgIG5vdDoNCj4gPiAtICAgICAgICBwcm9wZXJ0aWVzOg0K
PiA+IC0gICAgICAgICAgY29tcGF0aWJsZToNCj4gPiAtICAgICAgICAgICAgY29udGFpbnM6DQo+
ID4gLSAgICAgICAgICAgICAgZW51bToNCj4gPiAtICAgICAgICAgICAgICAgIC0gcmVuZXNhcyxy
N3M3MjEwMC1kbWFjDQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgY29tcGF0
aWJsZToNCj4gPiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+ICsgICAgICAgICAgICBlbnVtOg0K
PiA+ICsgICAgICAgICAgICAgIC0gcmVuZXNhcyxyOWEwN2cwNDMtZG1hYw0KPiA+ICsgICAgICAg
ICAgICAgIC0gcmVuZXNhcyxyOWEwN2cwNDQtZG1hYw0KPiA+ICsgICAgICAgICAgICAgIC0gcmVu
ZXNhcyxyOWEwN2cwNTQtZG1hYw0KPiA+ICsgICAgICAgICAgICAgIC0gcmVuZXNhcyxyOWEwOGcw
NDUtZG1hYw0KPiA+ICAgICAgdGhlbjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAg
ICAgICByZWc6DQo+ID4gKyAgICAgICAgICBtaW5JdGVtczogMg0KPiA+ICsgICAgICAgIGNsb2Nr
czoNCj4gPiArICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+ID4gKyAgICAgICAgcmVzZXRzOg0KPiA+
ICsgICAgICAgICAgbWluSXRlbXM6IDINCj4gPiArDQo+ID4gKyAgICAgICAgcmVuZXNhcyxpY3U6
IGZhbHNlDQo+ID4gKw0KPiA+ICAgICAgICByZXF1aXJlZDoNCj4gPiAgICAgICAgICAtIGNsb2Nr
cw0KPiA+ICAgICAgICAgIC0gY2xvY2stbmFtZXMNCj4gPiBAQCAtMTEyLDEzICsxNTMsNDIgQEAg
YWxsT2Y6DQo+ID4gICAgICAgICAgLSByZXNldHMNCj4gPiAgICAgICAgICAtIHJlc2V0LW5hbWVz
DQo+ID4NCj4gPiAtICAgIGVsc2U6DQo+ID4gKyAgLSBpZjoNCj4gPiArICAgICAgcHJvcGVydGll
czoNCj4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+
ID4gKyAgICAgICAgICAgIGNvbnN0OiByZW5lc2FzLHI3czcyMTAwLWRtYWMNCj4gPiArICAgIHRo
ZW46DQo+ID4gICAgICAgIHByb3BlcnRpZXM6DQo+IA0KPiAgICAgcmVnOg0KPiAgICAgICAgIG1p
bkl0ZW1zOiAyDQo+IA0KPiA+ICAgICAgICAgIGNsb2NrczogZmFsc2UNCj4gPiAgICAgICAgICBj
bG9jay1uYW1lczogZmFsc2UNCj4gPiAgICAgICAgICBwb3dlci1kb21haW5zOiBmYWxzZQ0KPiA+
ICAgICAgICAgIHJlc2V0czogZmFsc2UNCj4gPiAgICAgICAgICByZXNldC1uYW1lczogZmFsc2UN
Cj4gPiArICAgICAgICByZW5lc2FzLGljdTogZmFsc2UNCj4gPiArDQo+ID4gKyAgLSBpZjoNCj4g
PiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAg
ICAgICAgY29udGFpbnM6DQo+ID4gKyAgICAgICAgICAgIGNvbnN0OiByZW5lc2FzLHI5YTA5ZzA1
Ny1kbWFjDQo+ID4gKyAgICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAg
ICAgIHJlZzoNCj4gPiArICAgICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gKyAgICAgICAgY2xvY2tz
Og0KPiA+ICsgICAgICAgICAgbWF4SXRlbXM6IDENCj4gPiArICAgICAgICByZXNldHM6DQo+ID4g
KyAgICAgICAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICAgICAgICBjbG9jay1uYW1lczog
ZmFsc2UNCj4gPiArICAgICAgICByZXNldC1uYW1lczogZmFsc2UNCj4gPiArDQo+ID4gKyAgICAg
IHJlcXVpcmVkOg0KPiA+ICsgICAgICAgIC0gY2xvY2tzDQo+ID4gKyAgICAgICAgLSBwb3dlci1k
b21haW5zDQo+ID4gKyAgICAgICAgLSByZW5lc2FzLGljdQ0KPiA+ICsgICAgICAgIC0gcmVzZXRz
DQo+ID4NCj4gPiAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+IA0KPiBHcntvZXRqZSxl
ZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0K
PiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMy
IC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25z
IHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdo
ZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Ig
c29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAt
LSBMaW51cyBUb3J2YWxkcw0K

