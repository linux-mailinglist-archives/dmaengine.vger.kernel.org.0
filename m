Return-Path: <dmaengine+bounces-6047-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D2BB27DFB
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 12:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D4AA041E6
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7FA2FF160;
	Fri, 15 Aug 2025 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="u/UXdrhr"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6E2FABE6;
	Fri, 15 Aug 2025 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252381; cv=fail; b=b1iTKUyig8h+R6zQMq+KrRkOAWSywDMAHUZci2Ymhwxz3c3e/FyCZA9cgMXyLNTscRIYz0Z5DS4EjwqxAvaEn4bALO4MoDWuZ8wMoGfYZH4hOPwW6/cnD56r71JyxW1fU7VqRmBh1XVqukczdZn0FgBU7/nS2pOLC2zl2fEpyHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252381; c=relaxed/simple;
	bh=FPsrzGtzcYo61wDV10E9BMKGFgJCN695XQj++IxNLBg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fw2/mXFxMjnhe3QK0jwTr1Yy1WSOuZY8/SJE7hHyuZ3zwas9guClSuFkYvi+ggCbW+5QScDAl7qkD7/iImP9/9b5F7Yxx27iGxobZXiy5uMrl3ReqzVqcw9S89El9lKZOkeupjjAgn46MdWq1nRzSeNFeyoU60X37Oi72s6rUU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=u/UXdrhr; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3x/CCRAdNZLLYRd8dafq50T6YGmA61MsBWbyJWudkK/3Fa4LNNU/UU6Ta497pA6y6yzNsTwzTOB3+uJvYXCLVmXT0ZTUwQ6AEyf+0s1SSs1mh5UBjBAVz1EbuVf6PWl+pTekjjYSvo1DpMFEsc3lIlJQGuru4j/gLOH6/mibc6wn7LRFu2zToL/UnMRcsHFcdMnis9RBFNS02YW3gxCK4tCbetw/B8dbSW6BANu6Udlkpq4viG8GkEDPS9d/jYn9GpsO0aE2cRaeU2TrzmLE0Ac11ct3yLPa6Qwds/W1sp0xAnfKCCaG9WzonsjgqNmqF6rQIb5eZPHuH6RZUDOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPsrzGtzcYo61wDV10E9BMKGFgJCN695XQj++IxNLBg=;
 b=ZI88MUjI5HGZRMWwbENwKhpfOqkF9wTrS5ZglKw2DZMdcZnCyqqRpW+mB3cZ5znTy/cF7OeQhlKScCDcU/XODbru3EQm/GVMtw/Q4hg3Xv0Z24k0Ilz6rYInOwK62vUeVx5nyLF89kxUeK+ShQirvgUATwarhEe7ouuspmeXO6x9OBxBnO3fpH8zWsAXnmL9jChTtHZ6V9KwDd80Gu6FpvVZC1Ln5P8fYviZvEOXxpeOrfEwH//OZCOurv3coRPAeeMYGoT3pVo9d9cBRoW2uD6xGr7LMld1C4U27beWEVgZIfSxef2yATYZ4L3ih/KVlQg3b0zd3yVFNw5+ZHqOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPsrzGtzcYo61wDV10E9BMKGFgJCN695XQj++IxNLBg=;
 b=u/UXdrhrI1OvAVDV/OgrZp/lMocwHeywbSX2Jp4vuXVDqt1pEJwWKeGitcjkpYot/hjzrq/rYcZdF0eYvZNFuxU1Gm+gODALm7Pp2Zr7iWkxu0UILFjTIvLQECR2MGE1AYCf/+hzCAKW6S34+AdindSpKCskUT8U05USEvbbUjcoIqYMzk517+rX1Toyxq2K1S80iTkjrb3J0UXrnuABWAEf5zXkmIYxLHjTdRmsMrCDpyTRHq/R8syirbVAom0rSy7/yG26LB0yr9zq6PU8zKHIr+9u8niAPKMigQJk1cx0bmhs3YKfM7SgTmZcxztBktx9iHFHS+OLZd/ifl7vIw==
Received: from SA1PR19MB4909.namprd19.prod.outlook.com (2603:10b6:806:1a7::17)
 by PH0PR19MB5574.namprd19.prod.outlook.com (2603:10b6:510:141::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 10:06:13 +0000
Received: from SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f]) by SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 10:06:13 +0000
From: Yi xin Zhu <yzhu@maxlinear.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "kees@kernel.org"
	<kees@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"av2082000@gmail.com" <av2082000@gmail.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: lgm-dma: Added intel,dma-sw-desc
 property.
Thread-Topic: [PATCH v2 1/3] dt-bindings: lgm-dma: Added intel,dma-sw-desc
 property.
Thread-Index: AQHcCBPALrBJpgW7V0mdzTs1Qi24hLRYReGAgAsMz+CAABtMgIAADGZA
Date: Fri, 15 Aug 2025 10:06:13 +0000
Message-ID:
 <SA1PR19MB4909BA87E8CE98B5A6389349C234A@SA1PR19MB4909.namprd19.prod.outlook.com>
References: <20250808032243.3796335-1-yzhu@maxlinear.com>
 <32a2ec88-b9b8-4c4d-9836-838702e4e136@kernel.org>
 <SA1PR19MB490961745C428F56D7E114F7C234A@SA1PR19MB4909.namprd19.prod.outlook.com>
 <a0a1bc99-0322-4f63-a903-12983facddc9@kernel.org>
In-Reply-To: <a0a1bc99-0322-4f63-a903-12983facddc9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR19MB4909:EE_|PH0PR19MB5574:EE_
x-ms-office365-filtering-correlation-id: dceedf8e-1148-460f-24fe-08dddbe35dd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MzNVVjhxMHc4dkxmb0FXZTcyN09zOE5ia2crYTkxb0x1R3VpUkpKN0V4NU5P?=
 =?utf-8?B?bGVNRFBvZVVBcEc0M1lWUk9oUkVSbXNFSEFwRmJmSURvVmVoT1dZK2Z6MTZN?=
 =?utf-8?B?VS9JZVVtZW9WNnpuWkM1ZnM5c2lKbXhVUE1YRHhUanBoeWNBTGp0YWZ4MVBh?=
 =?utf-8?B?Q1BvUmE3VzBrdDg5YThvVFBpR3pLSy85V3RrTm9FVUcwdU92Rk5hcnFFZUlD?=
 =?utf-8?B?UUxVTm1wRWcrQWE3anpFS0lYOVNFcmdHV3IxN3NmZUxveGo1UzJCRDhCQkM5?=
 =?utf-8?B?dkxPRmtYZUNwUW5WT1FndFREdDJ0RDQ3NktOejFGSjFKblFrSTRDTi9wVXM2?=
 =?utf-8?B?NzVnNXdKWnRSeDc3QkNHR0lCUnRkMkhmbGNDck14Mjl4MCtaODY1a1ExckF4?=
 =?utf-8?B?ZllTblQ4cm5XT0dxMHJURDlSekN0U2dEaUp4RHMzaXJ3ZmVJQXRoMW9YOXJp?=
 =?utf-8?B?WlBWU2wvQXFjVXRvMkM3cld1OGNNTVBoNm9UTFZpMUNhL1RXSGoxMUFZZndR?=
 =?utf-8?B?VEhXNXVLNWZLM3F1TEV0Q1ROTlo5dVFwSlN5N2lIQ1psSFdIYU1MUWhvNHov?=
 =?utf-8?B?c2cvSVhIc091Umljd3lYRVQzTTlCbGM2UjRiVG9sK3M5dExXV2Jtd3JKSlUr?=
 =?utf-8?B?cjBQd0V4YldQdEdaRGI2WEFRejZLak85eUpNZmdmVXhXcG9ZUjBzVTRzL0pF?=
 =?utf-8?B?SkVYL1ZjRXYwWExlNUY0d01IWXF0eDFyMWEvOFRScXhIK2JQN2pzUnp2VkVk?=
 =?utf-8?B?U245MjY2STJUWExCSkdvaGs3NTFJOHlERHY4UDd0cTJ5QzVuZVpZVytUd0Mr?=
 =?utf-8?B?VHpjWnIrNzR4RVV0aDdqN29uYkdpaE1iNUl4YVVnVmRMeG53QXd5VFE4OXhR?=
 =?utf-8?B?T1gvR3QxeWpsWXVQY0V1VHRlcUgzWG9JRVhPZjBnbVFNTjIydjBuNWhtbU1T?=
 =?utf-8?B?VElrcWVXVG00NUdQQ3FwM2N0SGV6NEMwR1dyRUErd1QwZGk2ckw3cFBuSGlH?=
 =?utf-8?B?dkxsSUhIT3ZQYmdXRkhUOVBjN2VMUlZGY29SaWdpS1VZcGpOaVFPd1cxVmd1?=
 =?utf-8?B?dHdjVnZqOTVuN2V2eXNXSENpUXJuSlBjWUZDM1VFZk5ySTNMaXBPeTU1TXJX?=
 =?utf-8?B?NmxvOGtGT2FZTEdQLzJPV1l4M2dqRnd1bUIzbk1uK2ZkN1NsYXRKQVZNWjJr?=
 =?utf-8?B?K0FmSnBZWEJCZk5kN2NRSk9Zek9nM0NESTJDMVhCcHlkdzltdE43a3Bjb3Uy?=
 =?utf-8?B?OXFUQWZ3VG1RLzIvQ0swWU5aUnJucUkvSmFZdXFMZmRKdUJzcWI0dm1oa245?=
 =?utf-8?B?SWhNM2UyZmsxejQ5ZE1nYmpqZllkWHk1eERZbnJzcmYwek9QU28xUVF2ejdN?=
 =?utf-8?B?Z0RZS29OamdHdUcyQVdQV0xtNlFsRXhHVjJpVzhkaFEraEtHbzRZUzZYZXJN?=
 =?utf-8?B?UGNhSDFzWS9OTWdiMnVYcXE3eWtNVzlqY1cxNXY2NlBVaTdhVU1zRkNWUFFl?=
 =?utf-8?B?c0k3eGpvbUpVencwOTFvTUE2YWliVmdOalZCemtMWDIzYUs2Q3VIL0h6T08z?=
 =?utf-8?B?NWtuSDdMNEFkb2lnSFJGY3E3M3FhdnVsSXpaeGE2b29uZnUwRU52SzhHa3pP?=
 =?utf-8?B?OW1lM3dGTGsyL2daaEVWbVYxWTgxYW9MeW5qYjMzQXFXb05jZEFyeGd1RHFq?=
 =?utf-8?B?OUltSEhoY0FrTEkyaFhnNnRLd2hrL2cvcVpBTkxxazdIY21mbW9RMFBFSDND?=
 =?utf-8?B?Q1prT1RVTytxSTdOTW5qVjNYWVhTU3lIVVFaYTdYbFZvVlVPTUxQZXJkRUZY?=
 =?utf-8?B?c3JISHkwazdGdXU1ODlEOWhIV1Y1d0R1K09mODRUNWFIbXlPQ1B2aXRteVA1?=
 =?utf-8?B?dGYwVzkzN3g1eHRpYVdJc0R4enpGMTBxSDJ6Q29BeWJSYjloajFsTmJ2QTls?=
 =?utf-8?B?QXYxcGMrOWwvT3h2TkVnOWxnbHF1MGQwNTNXalBQOTVrVHJCNWF5bkIwYzVm?=
 =?utf-8?Q?U9vDVtibRNMEKhU39z68fuMZXpjiUI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4909.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1FUckJCZlNTVHgrNjgzRTdFUEVkS1VkNTlFMVZucUhPaEZ4dDArdEhWZDYr?=
 =?utf-8?B?OERjcVlNTEtOT0FSaXVhQ2IyUldKK2M4S1hERllvYzBiZ05pZ0tOUmFSNnF2?=
 =?utf-8?B?L2hLZjdXckx4SGZQRkJXRXpaVUo1SEtURFRabEIxZVpMNCtOYjZiNmZDT0Za?=
 =?utf-8?B?djRRTmJwWm82U0F2UVcxQ0hCd0EvM0FQbWtvdXZVcVZ6Nlp1YWwrRkFjOFBM?=
 =?utf-8?B?Zzl4QndyWTQ5MUtib1JEN2ltY3BYclh6UkwzSG9WRktJVzZMZVlSdjZqS1lq?=
 =?utf-8?B?em1BbHY1YkdaK1U5NWlvR3FmRExzZnRqa0pwS1pOSW1WMm1BVzE4WmlBZkpV?=
 =?utf-8?B?UXcrbE5ySzJIVHJjWGE2OUVrc2lWUUwyS1kyMUN3YVc4dTlNNTFHT2JBc0hN?=
 =?utf-8?B?TjBiakZDdXVCVU1VN2MwWXJWM1J3MEcveVpNZUtrT042Zm5rdUY2M0x0YVVz?=
 =?utf-8?B?K3A0cWxrRG1YTU5sZlY5TEJKSWFMdlJ6V1o5S3JYVS9kczYwNTZOVVcwN3l5?=
 =?utf-8?B?YVlnaU5ZTU5DZUhEbmtBMDRQU0tiVk1ZckREYngxdGdvbmx4b2xLQjV3NGNk?=
 =?utf-8?B?SG1LOERhd1hmcW5aNUVDRjVLWFlDbDNFeG1sS1JuVTZOdkpZMWwzSk13SDRj?=
 =?utf-8?B?UExIdzlXbzk4NWlTS1JucWEvMEo1Q3Z6WDJIMjFRWWJhSG83b01tWmRFVXV0?=
 =?utf-8?B?Z21KMEdPY0svekFKT2d0bzRka01INExXZGdDNzhZUUhoOHJTd2RLWEtTMFRk?=
 =?utf-8?B?aGg4d0J1MGc4VVBCSUpJZ29OVitvbzdZd1RSS0x4YjU5c1lrUFUrWjJFSDBh?=
 =?utf-8?B?VjZkNkxNbkJ3M0gwTG9vYTByWUxuVDRPNU43WHJtVGpOYXdqT2I5aDVjdmFO?=
 =?utf-8?B?bEQrNTIySnUvam9PWVZqK3ZMMHowUEFsSStGamhiUTFEWDBMYXZuMks0cW5W?=
 =?utf-8?B?YlM4dzErYlZqajdFVHJrTEUrVU9EM2V0S1FPbnFBN09lUTdPbWREbWYyRE10?=
 =?utf-8?B?MVhqWTZHczUyZWlsSUpNZDhKK3Z0OXUxRDZhRTFmaUlNQkVHM2xRUFdzVzhm?=
 =?utf-8?B?VUJZQi8rajQvQTNQMFNnZStQaytPMHV4WDBmUFVPUFJmbEd1QVRDdmdpellL?=
 =?utf-8?B?YWh6NG1rS3ZSS2tJT3FRcGNHa2pDamhNempIcml3VVlYdC94VWNJQjcwTUlj?=
 =?utf-8?B?NFFpYXZ0czQ2QWVZN1Z3YkQ3U3A1WnFNc1M3ZDZOMUtzMjdqTTFIanJGVHRY?=
 =?utf-8?B?Vi9IRDRGWkdrQ1B3TUxRZkhUbG5IRC90WXpNc2RXeUxISUJZei9uTU9RY0xt?=
 =?utf-8?B?VkNEOHdBM29WRFNiaWk1KzE3bktoUG5JQkhhR3lZUlFkNjNnUEt5TjBRaWto?=
 =?utf-8?B?SktUOE5VN0dWM1I0Wnp0UGd0anM4eTg5WnhBdHczRnRjZGJzQVFzMjk2TE0z?=
 =?utf-8?B?RUplQ2hoL1JUZk5yeWZkL29SRGYzME1aWlhwNG1uMGVDZnFaYWZPNno0Q2RL?=
 =?utf-8?B?TWl3bnBiK1owUTVVWUg1SmV6MUdHOWNnOGtONGhHSDN6Z3o0MjhHS2FleTVi?=
 =?utf-8?B?bDIyS3ljVUdJbFJhMkxQS3Y4TDROcGtOQlMvdGRKbDlDZDUvTU9qb3JnaG9t?=
 =?utf-8?B?SWxScjNoU0d4S0RDMVNINld4U0lWVzRmU2RnUDJRU3RXclA2eEZvQ3Zia2NK?=
 =?utf-8?B?T1k5aWlDMUZ3Znc3QksrSk41dXVqM3VjblpJMk1LWnNZcm1MbmhqOXp0RWZ5?=
 =?utf-8?B?TFFkWGY5WFFVYzY4R0JpNmZ2K3JoN0E0WVNXVjN1MnF1MW5ReXZDcy9qL0E4?=
 =?utf-8?B?Kyt1NzZXNFUvSjFKWXNmWEV6RmttUWtrbGsrdTdtWThyMERvNU43SnJ3K05y?=
 =?utf-8?B?K29EUTNsdTVOUkFPUUV1Mk91OHN2eEdhZFV6cDBKZlNBaCtWQzVTNVVMb3l3?=
 =?utf-8?B?d1ZiVTZWMnJuY2pXbXBEQVV5Y2JSRVVNdXRMR2FrTXluYmZaVjRUVWRGalFE?=
 =?utf-8?B?MzZvcWZBNFQrMS91VWNWQzZMcHIxNlhJSmkyYStXN1YxaHQzVlA5cE9iQUhn?=
 =?utf-8?B?MURralVsdlJJSWxmVGREOW5qN3pHQ2c2SW9sYld4RmhCcGxWa2dRWTlVK2o3?=
 =?utf-8?Q?4FKNsGygJVDdpdf3Hz0AqXh0J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4909.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dceedf8e-1148-460f-24fe-08dddbe35dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 10:06:13.4542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8KK4nk17bJ7ZzQSsSSk3e7/0TncURcJRAZ9RyD2R629f2gzuXqGsCQqXMPheH5wJPIYG9fXJjcmPduhBtQNLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5574

SGkgS3J6eXN6dG9mLA0KT24gMTUvMDgvMjAyNSAxNjozMiwgS3J6eXN6dG9mIHdyb3RlOg0KPiAN
Cj4gDQo+IEFuZCBob3cgaXMgaXQgbm90IGEgT1MgcG9saWN5PyBCcmluZyByZWFzb25pbmcgYW5k
IGFyZ3VtZW50cywgb3RoZXJ3aXNlIEkNCj4gY2Fubm90IGhlbHAgeW91LiBZb3VyIHJlcGx5IGFi
b3ZlIGhhcyB6ZXJvIGhhcmR3YXJlLXJlbGF0ZWQgYXJndW1lbnRzLCB6ZXJvDQo+IGZhY3RzLCB6
ZXJvIGhhcmR3YXJlIGRlc2NyaXB0aW9uLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0
b2YNCg0KTGV0IG1lIGZpcnN0IGRlc2NyaWJlIHRoZSBETUEgaGFyZHdhcmUgY2FwYWJpbGl0eS4g
IFRoZSBETUEgSVAgaXMgZGVzaWduZWQgd2l0aCB0d28gY29udHJvbCBwYXRocy4NCjEuIEhhcmR3
YXJlIGRlc2NyaXB0b3IgbW9kZS4gIFRoZSBETUEgY2FuIGJlIGNvbm5lY3RlZCB0byBhbm90aGVy
IEhXIGNvbXBvbmVudCB0aGF0IHByb3ZpZGVzDQpEZXNjcmlwdG9ycyB0byBETUEgdG8gYXV0b21h
dGUgRE1BIHRyYW5zZmVycy4NCjIuIFNvZnR3YXJlIGRlc2NyaXB0b3IgbW9kZS4gIFRoZSBETUEg
SVAgYWxzbyBoYXMgaW50ZXJmYWNlIHRvIENQVSB2aWEgcmVnaXN0ZXJzIHRvIGFsbG93IENQVSB0
bw0KbWFuYWdlIHRoZSBETUEgdHJhbnNmZXJzLg0KDQpXaGljaCBtb2RlIERNQSB3b3JrcyBpbiBk
ZXBlbmRzIG9uIFNvQyBsZXZlbCBjb25maWd1cmF0aW9uLiAgSW4gdGhlIFNvQywgaXQgY291bGQg
YmUgc29tZQ0Kb2YgdGhlIERNQSBpbnN0YW5jZXMgd29yayBpbiBoYXJkd2FyZSBkZXNjcmlwdG9y
IG1vZGUgd2hpbGUgb3RoZXIgRE1BIGluc3RhbmNlcyB3b3JrIGluDQpzb2Z0d2FyZSBkZXNjcmlw
dG9yIG1vZGUgb3IgYWxsIGluIEhXL1NXIG1vZGUuDQoNCkNhbiBJIHRha2UgaXQgYXMgYSBoYXJk
d2FyZSBjYXBhYmlsaXR5IHNldHRpbmc/DQpJZiBJIGNhbid0LCAgYW55IG90aGVyIGFwcHJvYWNo
IEkgY2FuIHVzZSB0byBhY2hpZXZlIHRoZSBzYW1lIHRhcmdldD8NCg0KQmVzdCByZWdhcmRzLA0K
WWl4aW4NCiANCg==

