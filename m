Return-Path: <dmaengine+bounces-3701-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBED69C3F34
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 14:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D810B23280
	for <lists+dmaengine@lfdr.de>; Mon, 11 Nov 2024 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F309119D8BC;
	Mon, 11 Nov 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XI9lTrXd"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0A19DF62
	for <dmaengine@vger.kernel.org>; Mon, 11 Nov 2024 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330296; cv=fail; b=Z5d3XEMeG4K5ArIlk19hbzxDmnDe2zpeLxjq6TYaoFGA+ZG4w51RzWzrhUdsenVgLWQOvHX0bylzOi8eLupcxH2K//bZrlXtgEHotSV90cM3dUpDYTm1bU/ZuT6s5qz+58ss3rZG8F/njp1D7+scpo9gatMMV8gdPmo8VEGtcJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330296; c=relaxed/simple;
	bh=l5/LobYdGHGVbwv9vInfMeSadD+wJWxPqXdq057tcZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U6HZZBJ16oW7tuIOEZN6tH3rsEBP1X7KHNBpyahQ6agi51JfnYYF4aOWl6iXcPwG0lhM95Ni9gLN+qzYZooliC0emFRK5C7BOG3aqUYwH7J0ykYkr0e6l8WYL4unWl974x25qUfWCVzd7rZ7MmS4F6fZeBKiRjbNtcnyJunyhbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XI9lTrXd; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGLQc/yhypQaUjBRns7xdH6rjZ2xcVcoyw4C0U3PtdAVQAt54Jqs1ukXK4quzS1EKdb4H6V6xO3xQ4btNgZJaZiVcmmFR5PruZEKcCAJmFoqdk1PC7eqynSg3lo70y2ZuPyP4Ob8nRrguGvx+j5XRtgR8RhFIyOFqfg9mGCUqMjYHWGAZpPUq1fd8V4vD2txYvDezzJ5tA1dh8FeMo2QBFrT0r03VPiWnxh/Oy10JL5mfRgEKXSU3IdkS5RzENM3mZ0G3Njq4JaYc8eY4WMG03l67j9ZCI9bnxwOPWpEtK6bn6UDiAXuitnJF9JEuYoKPdqYX9MInpxknnJKSUuDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5/LobYdGHGVbwv9vInfMeSadD+wJWxPqXdq057tcZc=;
 b=uEhbaGDhBH02lGuKGqM0fBquPiOYnoVEO3Nh9r9/ffXWN/9gY2uqMA1Kq/Bmtv1YiUKTYZNjj6gzPyxSqAB4n/DjJbjw4TqY9rh40SQ3d/i5xvZ3ud3h8iT9J3fKr+WsaPOc58rT4pI3O+N2Bvr1WfQaQ2RZmJ3HcnVEvdUc+AK865ZHBe2xJNrcWrFmnuKbZ1wp548c1r34PLDggB0mlRKWkqxN9l/kytxbyV2hQEK72kp77kZf/xs/esl4rWXXrGEWIr6wnHckt3ZMeFTsFDG9SyliRE8QRD3Yihj8kdUIn4n9+R3zpV0kPTENHSXYKIwLgEWlXBWIXrFNGpLc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5/LobYdGHGVbwv9vInfMeSadD+wJWxPqXdq057tcZc=;
 b=XI9lTrXdVtiKGjIa/ow1FqLNcSTD1wWoDGeSMOPxhwPU76L/cRnJm5Ffg0YAqvHOqWVgzmdQMQalMXB1Fbz8IpYed7DVgsstMiNsVDQ8p223cN+O4ywc9FKrNT9avcu0wzhPYms57c4j7Hg+GfFgFq4OYaHndTvMaFFUYWboULw=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 13:04:48 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 13:04:48 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Marek Vasut <marex@denx.de>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>
CC: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
	"Simek, Michal" <michal.simek@amd.com>, Peter Korsgaard
	<peter@korsgaard.com>, Vinod Koul <vkoul@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Katakam, Harini"
	<harini.katakam@amd.com>, "Joseph, Abin" <Abin.Joseph@amd.com>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Fix freeup active list based on
 descriptor completion bit
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Fix freeup active list based on
 descriptor completion bit
Thread-Index: AQHbK7YsIMHqB+OYBEGVEmCGVyTwsbKqCNFAgAAhawCAB/D1MA==
Date: Mon, 11 Nov 2024 13:04:48 +0000
Message-ID:
 <MN0PR12MB5953FAD7CEBB1C774271BE53B7582@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20241031165835.55065-1-marex@denx.de>
 <MN0PR12MB595370521C2E3D61145D15BCB7532@MN0PR12MB5953.namprd12.prod.outlook.com>
 <f168e5bd-cdab-4405-98ef-20f7ee534e0c@denx.de>
In-Reply-To: <f168e5bd-cdab-4405-98ef-20f7ee534e0c@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CH3PR12MB9194:EE_
x-ms-office365-filtering-correlation-id: d8f82785-84dd-4ca8-bb65-08dd02516bce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnRWa0hVeGVvNUJaVFdJOWpMajZ0eG44aGo1dWFKcmhvRzIwTDBTUk1NY0Ro?=
 =?utf-8?B?QVlGcFl1WXFjN3pLT2VTSXNrQ1NYaSsrUnlFeS96K1ZTcVFCU3JYZlBrZyt2?=
 =?utf-8?B?WmZTVzNoNGEzdnU0bmMvZ1A0djVHaTBLeU43Nm00TGhWWVF5bFBTYTZINTFQ?=
 =?utf-8?B?VHB6WGdlVElaUWdKRlhCTVNRNWFkeWxXdGJqbVArNDVHNkVIbXc1TWNCb1lv?=
 =?utf-8?B?L091OVd3V3dWdmFjV01KNDFiNDI3VnNDLzVTS2ptNkNwK2RjVWh4MklqbjdY?=
 =?utf-8?B?T290a2RLQ1huSG1aSklrQy9ZL3hqREcrQjI5cHVvN2JweTVDSW5OSTE1TmpP?=
 =?utf-8?B?TDVMV2E5ZmE4SGVkMFkvSGpWdEhOTWlwc0x0TzJQbVYycUMvNnRsT1dFSUd0?=
 =?utf-8?B?SDBHY1JSVWZkNjAxL0g0NmRWamhPUkE1NkpkekxTSU5YVnVpdGRXMDV2NVE0?=
 =?utf-8?B?NnpYTGRmM2wrVWhGblJCZzF2bkFoTml4SHVicjBXV0t0U090NWlmMWlQY1pP?=
 =?utf-8?B?WEdXcGE5NVBUWkk4Qk4vRjZIc212TmRDMXpMN0tRV0gyeEw3RHFkY3JkUjc3?=
 =?utf-8?B?czI2cmhObzBSWjRtNmkrbnRGK1dkUU9hSmdOcHU0MUE5NzdRb1hDYksvbGtk?=
 =?utf-8?B?YUdqbnFZdHF2ekNHQnlLK1ExRmkyT2oxWDVxcG5CRXZWOU5DTW9NTUh6dFBu?=
 =?utf-8?B?bFNrVlp5TktpU1RrVGdMWll1RnlGSlVybllkVnlCbmtSSE5LcTNNUjZpTGZS?=
 =?utf-8?B?ZGFGQlpGTUNsQkYvRVNHTUVMZHFxYzFYOXVSRk1qNDFuWDIrMkg4NnEzZGYw?=
 =?utf-8?B?ZFdPM04vWERiWXE1aUU5cWNBMHBZSU4xWTBUVW8yZ3dUODlNVXR4OUJQL3Nh?=
 =?utf-8?B?TVZyWEh3UFVmSlZLaE5CRk1jQVZBSVdJV3d1UytnbW96N2N5ZWhKU3c3d1V0?=
 =?utf-8?B?ZnBXbkxNQzV3b0t6OE4wRWhqSG5tYmkybSszUnVkN1hEc3hXUlY4VDNnWkxB?=
 =?utf-8?B?dmU4NEozS1VaQzdsNjJqUUd5U0p5MmJPbXI4YWF0UFFxT2FpY1l5RFl3aXV2?=
 =?utf-8?B?OVhva1pSWlorZG9PVTE4SmlwU0hDTDVTRkJkOHowRzdTY0ZRMlRuaFNMR1NG?=
 =?utf-8?B?VXVLMnlwSXoyRHdTaXJtVjlJa1NmdnNsT3g2d21KVVVtUy9MU2lhTmpESHpu?=
 =?utf-8?B?SWJ4UGYwcDEySFExc3JRckVubWd4cnA4K2FaSnVoRzJuZUtVWkhlTkt2YnJG?=
 =?utf-8?B?MXZpNGYvc2ZnaDc4YlJXOUhhSnZJNEV1dk5RYkYzUTZ6RmxXMzBTeDdtV1g0?=
 =?utf-8?B?S1EwUUxxU09JM0JHVEd2QU9QZ1JuWGtQKy9ZYkhvUEVabnFkUEFoNkowMDBU?=
 =?utf-8?B?TmxRYm1kNGNPVUVMQURJV2Q2eS9ncEJWMGpmSEV5eitnaTNQdHBiM2tlZmJk?=
 =?utf-8?B?ajh6ZFhKdmx6NVYxdzRCTDJXN3hTWGFSUWViVVBhOEZPR29GK1Z4NTRXTHdU?=
 =?utf-8?B?Qi9haW5DU0ovQkxjS1F2NXJWOWwvd1loRDZtb0pKK2EzamtCc2dLUUhSeTlN?=
 =?utf-8?B?NXhVNUg4M0hhK2EvamJLVEx4T0JjZ29KZXZML205enY5U08vV3pZcXFPSTRw?=
 =?utf-8?B?cHZuTHgweFMvMVQ1ckpYMEhxd2xSL3VqZWcrd1A5SG1IOXUvTVZNRVB3ZTNM?=
 =?utf-8?B?LzhVVTZzVzE0Z3hnQlkxcU52MnQxMC9mNE1lMzRhTFdCUURtT010bjc1bDFG?=
 =?utf-8?B?Sko2WVVscUFJNDRsUGRQOXVtSkxJOGs2Mmo1M2pCZUlwcHJhUXBoK2JNM3g1?=
 =?utf-8?B?dUQxb2Y0SCtMTHpLREtIbnpmT0ZjbjQxNlY3STl5cUNjTDR1cWVrSXE4WkFo?=
 =?utf-8?Q?/VA/7uVZa6qvj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWovZ2IrTVF0VXhkemxIZTZHVUtvWG0vdmxCMWNtTCtaSEFCOGNqSDVVdlAw?=
 =?utf-8?B?R2ZPM3ZMSkplekE4Q2pOQUp4T0JFSnpBNXZZUlFhVzdTb0o2dDN4bW8ycktp?=
 =?utf-8?B?dzVmZlovaHVSZ3paTFF5KzllY25aSkpCbythRkNJMFN4bE03UGNZc2h2NlNo?=
 =?utf-8?B?R0N4YXJQU3BHbUE3b3lTUWhFbmJPT09LbmlDNlZyU3d2ZXZlVm5WZjBMdkpC?=
 =?utf-8?B?UFo0bW5taFhKWm5IUDhiQlhIN05IZURxVm14dU9aaG9uUHZveG56SUhCUFRP?=
 =?utf-8?B?dXVVUXIyUFR1bHVGc3pQcWEyaDFVOTFqWldxZVBQNG9TMXNIOE5LYjdlTjVT?=
 =?utf-8?B?Y01VVFRXcWUwTVE1UG00UHk4ZVlFQmtGUzJmVFhXSHYyTnhJUnZ5RHpIZ3U5?=
 =?utf-8?B?QmE3QThic0FVS1lBb1hVUGdIbkVNQklaaThEdGo1QVQxVU9QaDZmV2FHQndz?=
 =?utf-8?B?ZE85QlNpT2t1cTRHYkI2SlJBSEkxQUdtV0N4UWllNVZzSUVLT1MzditocnZp?=
 =?utf-8?B?M1N3TkVONzl2NDg4NkQzOG05UFdIbVFtTk5iOEpMOU0wQkoxbTNZVXNJMjNN?=
 =?utf-8?B?d3hUTHNHWVBNSnhEbk93SjZobjI3NS84cHVISWltZ0Y3N3VUUElWcGRPc1B2?=
 =?utf-8?B?RGQrNE5NODUwbXNRRkw0bHN5bVBBQXRGWUFTUnR2ekc1SG1wa2NBZVAzV0dT?=
 =?utf-8?B?UWFvMWVWWXJ2b0d5Q1pBZXhCUFlIaUNmS1JxU05Cc3VYMWVDb0VRSnRXdzlw?=
 =?utf-8?B?N0NwODg3dXFwMnNOQUtRVVAxMHM1WlFhNk01M2V1Q0IxSXJxdzkycFc0eUgv?=
 =?utf-8?B?V0tlNlRodWV0UkMrc01oTndUVlNMRkVZQXdOcTlVU0hTbFdqOXNEWGZESWVI?=
 =?utf-8?B?NUl2RzkyRGlOM2d3ZXk1ZFdML0dRWk1PaTViUVN4NEE0OXR5emc0ZURuK29w?=
 =?utf-8?B?U3c1REJLbGZ2N0JlREw0K3NaR3h6eUJuNlVSYmVkOUVjaC9qMjNBK3d5c2wy?=
 =?utf-8?B?RE5RQmVEZjFDNEIxUzJjNS9QNGVCam9FWm1YZk9Ebm5ZbWlIeUlWZWV6NGhp?=
 =?utf-8?B?OWNIS1dOcnV0MlNWcjEycVlpQjhYUWtDbmI5VmJaR2RlZzVORTFoNFIrMjNy?=
 =?utf-8?B?TGxHelNsVGtxYnI0UFdLd013bUFRdUlYSm5LYWlkdEdtcWY4bDVZUkoxRnBY?=
 =?utf-8?B?YmU1UmxBT0xTenZiaUYzU1hNTmJVcDhIWDFMRE9taWFhdDFCTEttT3FiQWNC?=
 =?utf-8?B?Rm0vSFRlWjYzVnoyVjZjQTNFSXgrWUFCTEJ2dmhGdGNWMGJSQUxTeC8zM2pv?=
 =?utf-8?B?QmEvYkhSem5vbHUwamZjTFNpUWV3cnF2Q3pPZGY5OW1wRGVRM1dPWE5hNC9y?=
 =?utf-8?B?a09NRWtaQVJTK0NOVWdqbndTNnlXaXpGOXFKYWxTUUV5QmZ6UnJRQ2NValQ4?=
 =?utf-8?B?dUlnckk1eGNRV3lvQUVVWVJiUldlTlVld25RUWlkQ0FCVUtRY3NWaFlaZ3Nr?=
 =?utf-8?B?d3JsNTkzOU1FUG5PVlVtUUlEbU9qTk9JLzI1eUhXSmRZdWNnMkRBLytXWmJW?=
 =?utf-8?B?Rm8vVzlMV1NyZEhwRFdiT1RJdG4yaUZjVy9PZE9YeUJ0V0hnbnp5Y2RWS1Ev?=
 =?utf-8?B?SUwwRGdiL1FDclFGZzhYMXdsalVRMUgrazBQelBSSUhScVIxc1J4b2tNVnhY?=
 =?utf-8?B?aTJBWm1KcVpkTm9NMndUc1NoSjFlZElIa2dJTVpwZy9UN1MyMzkvQitqL1hH?=
 =?utf-8?B?UmQvTG5wVkFCTVlYeHhCNlhGcXF0eTF1M2YwNXlzOGNHZkVaQ3VxTWJsSlhr?=
 =?utf-8?B?RW90RzJEek45VHhEeFpucEsyUDZuN2F1SUkxR2YwV3c5ZXJLVjZkWGF6cjQz?=
 =?utf-8?B?SW1JdnlwbkVXVS9RbngwenNPVnY4SzAvendoVGhudWpOaVpwUEs3RjZyMFNO?=
 =?utf-8?B?Y3U3YWdPcG1LQThxWHNwTVZldjRRY1FoRERMTk8zMmsrUlk4MVdUMy9BMUds?=
 =?utf-8?B?OG5nQkJzRGladFB3UHM0eml3OVJHUWlPOUJLcWRlL3B6K1J2MHlWblNjdGZq?=
 =?utf-8?B?eGh0QlpaTUJLSktvc1Z4OVJKN1Y5ZHN5ZEZNcHNRL2RSZnFndjI5Vjc1YWNn?=
 =?utf-8?Q?o7zA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f82785-84dd-4ca8-bb65-08dd02516bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 13:04:48.0681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IQG9tRTKB5N4jpjVYhrk5EH0LV3OxviKTeehvbWKWK6XGUMARgEnx3CHaEY9TKw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhA
ZGVueC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciA2LCAyMDI0IDU6MTIgUE0NCj4g
VG86IFBhbmRleSwgUmFkaGV5IFNoeWFtIDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+Ow0K
PiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5r
bGVpbmUta29lbmlnQGJheWxpYnJlLmNvbT47IFNpbWVrLCBNaWNoYWwNCj4gPG1pY2hhbC5zaW1l
a0BhbWQuY29tPjsgUGV0ZXIgS29yc2dhYXJkIDxwZXRlckBrb3JzZ2FhcmQuY29tPjsgVmlub2Qg
S291bA0KPiA8dmtvdWxAa2VybmVsLm9yZz47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgS2F0YWthbSwgSGFyaW5pDQo+IDxoYXJpbmkua2F0YWthbUBhbWQuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBkbWFlbmdpbmU6IHhpbGlueF9kbWE6IEZpeCBmcmVldXAgYWN0
aXZlIGxpc3QgYmFzZWQgb24NCj4gZGVzY3JpcHRvciBjb21wbGV0aW9uIGJpdA0KPiANCj4gT24g
MTEvNi8yNCAxMDo0OCBBTSwgUGFuZGV5LCBSYWRoZXkgU2h5YW0gd3JvdGU6DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54
LmRlPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAzMSwgMjAyNCAxMDoyOCBQTQ0KPiA+
PiBUbzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZw0KPiA+PiBDYzogTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+OyBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUtDQo+ID4+IGtvZW5pZ0Bi
YXlsaWJyZS5jb20+OyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IFBldGVy
DQo+ID4+IEtvcnNnYWFyZCA8cGV0ZXJAa29yc2dhYXJkLmNvbT47IFBhbmRleSwgUmFkaGV5IFNo
eWFtDQo+ID4+IDxyYWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+OyBWaW5vZCBLb3VsIDx2a291
bEBrZXJuZWwub3JnPjsNCj4gPj4gbGludXgtYXJtLSBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KPiA+PiBTdWJqZWN0OiBbUEFUQ0hdIGRtYWVuZ2luZTogeGlsaW54X2RtYTogRml4IGZyZWV1
cCBhY3RpdmUgbGlzdCBiYXNlZA0KPiA+PiBvbiBkZXNjcmlwdG9yIGNvbXBsZXRpb24gYml0DQo+
ID4+DQo+ID4+IFRoZSB4aWxpbnhfZG1hIGlzIGNvbXBsZXRlbHkgYnJva2VuIHNpbmNlIHRoZSBy
ZWZlcmVuY2VkIGNvbW1pdCwNCj4gPj4gYmVjYXVzZSBpZiB0aGUgKHNlZy0+aHcuc3RhdHVzICYg
WElMSU5YX0RNQV9CRF9DT01QX01BU0spIGlzIG5vdCBzZXQNCj4gPj4gZm9yIHdoYXRldmVyIHJl
YXNvbiwgdGhlIGN1cnJlbnQgZGVzY3JpcHRvciBpcyBuZXZlciBtb3ZlZCB0bw0KPiA+DQo+ID4g
SSB3YW50IHRvIHVuZGVyc3RhbmQgbW9yZSBvbiB0aGlzIGZhaWx1cmUgc2NlbmFyaW8uICBIb3cg
dG8gcmVwbGljYXRlIGl0Pw0KPiANCj4gVGhlIHZlcnkgYmFzaWMgdGVzdCBpcyB0byB1c2UgQVhJ
IERNQSBmb3IgRE1BIHRyYW5zZmVyLCB3aGljaCBmYWlscyB0byBjb21wbGV0ZQ0KPiBiZWNhdXNl
IG9mIHRoaXMgbmV3IGNodW5rIG9mIGNvZGUuIEJ5IHJlYWRpbmcgdGhlIGNvbW1pdCBoaXN0b3J5
LCBJIGNhbiBvbmx5DQo+IGNvbmNsdWRlIHRoaXMgd2FzIHNvbWV0aGluZyB0aGF0IGdvdCBhZGRl
ZCBkdWUgdG8gdGhlIGlycV9kZWxheSwgYnV0IHdhcyBuZXZlcg0KPiB0ZXN0ZWQgb24gY29yZSB3
aXRob3V0IGlycV9kZWxheSBzdXBwb3J0ID8NCg0KVGhpcyBjb21taXQgaXMgYWxzbyBwcmVzZW50
IGluIGRvd25zdHJlYW0geGlsaW54IGtlcm5lbCBhbmQgYWxsIGxlZ2FjeSByZWdyZXNzaW9uDQph
cmUgd29ya2luZyBmaW5lIHdpdGhvdXQgeGxueCxpcnEtZGVsYXkuICBBZGRlZCBBYmluIHRvIHRo
aXMgdGhyZWFkIHdobyBjb25maXJtZWQNCnRoYXQgYXhpZG1hdGVzdCBjbGllbnRbMV0gd29ya3Mg
d2l0aG91dCBJUlEgZGVsYXkuDQoNClsxXTogaHR0cHM6Ly9naXRodWIuY29tL1hpbGlueC9saW51
eC14bG54L2Jsb2IvbWFzdGVyL2RyaXZlcnMvZG1hL3hpbGlueC9heGlkbWF0ZXN0LmMNCg0KU28g
SSB3YW50IHRvIHVuZGVyc3RhbmQgd2hhdCBpcyB0aGUgdGVzdCBjbGllbnQgeW91IGFyZSB1c2lu
Zz8NCg0KPiANCj4gPiBXaHkgaXMgY29tcGxldGlvbiBiaXQgbm90IHNldCA/IEJhc2VkIG9uIHRo
ZSBkb2N1bWVudGF0aW9uIGNvbXBsZXRlZA0KPiA+IGJpdCBpbmRpY2F0ZXMgdG8gdGhlIHNvZnR3
YXJlIHRoYXQgdGhlIERNQSBFbmdpbmUgaGFzIGNvbXBsZXRlZCB0aGUNCj4gPiB0cmFuc2ZlciBh
cyBkZXNjcmliZWQgYnkgdGhlIGFzc29jaWF0ZWQgZGVzY3JpcHRvci4gVGhlIERNQSBFbmdpbmUN
Cj4gPiBzZXRzIHRoaXMgYml0IHRvIDEgd2hlbiB0aGUgdHJhbnNmZXIgaXMgY29tcGxldGVkLg0K
PiBJIGRvbid0IGtub3csIHRoZSBiaXQgd2FzIG5vdCB1c2VkIGJlZm9yZSB5b3UgYWRkZWQgdGhl
IGJpdCBhbmQgY2hlY2sgb2YgdGhlIGJpdCBpbiB0aGUNCj4gcHJvYmxlbWF0aWMgY29tbWl0IDdi
Y2RhYTY1ODEwMiAoImRtYWVuZ2luZTogeGlsaW54X2RtYToNCj4gRnJlZXVwIGFjdGl2ZSBsaXN0
IGJhc2VkIG9uIGRlc2NyaXB0b3IgY29tcGxldGlvbiBiaXQiKQ0K

