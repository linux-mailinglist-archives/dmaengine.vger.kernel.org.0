Return-Path: <dmaengine+bounces-12372-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LDMkLPy1VGp9pwMAu9opvQ
	(envelope-from <dmaengine+bounces-12372-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 11:55:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C5C74981F
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 11:55:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=WphZrTq8;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12372-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12372-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E9B8300B9FE
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB93E3D85;
	Mon, 13 Jul 2026 09:50:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0551A3E2ABC;
	Mon, 13 Jul 2026 09:50:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936224; cv=fail; b=l8paRtBiCEfrxcpTA9FYFBwG5AshEInJgJ7WXl9N+fNMH28aTWJLWJIcWxwU+bxiv3Bdn5kztBxhw4EyqHYNLDyUGLduFAOJSJsYHO0pCpg4ZJnssi4OGSsw9Z3fEVswslsS/jkySD+n18KLJBSxgZWN5WLAu72Fxgw7prewHo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936224; c=relaxed/simple;
	bh=8ppA4GftsSWGHUB6pVVUqrQFbFVXnGR6Lmf7+Ae0Oyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rBYRZg+aUUNG0BmM/3P9E4Lgm8Y9PXZaRgbcfLlHDQ+KlKzqqQD4EdfZqo+MferyP8vBqEUDZfe+5lAI0S6hnnk8FBTYib4UKIEw8mV6+p0F2cJyrT3PB6c2h3h32l+BP95jKpSELuPtPVtuCP8eCyBKb28Mu8LwtTJg0Ljfl3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WphZrTq8; arc=fail smtp.client-ip=40.107.209.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFP75uQSiSXlYd6i272ZDXc+L0OmBjM0qbRj9bwSOPqS7YENdFtRXHTHZ7ShgvTTtXVP+ICwGsK7IaAtaChqEm6Ik0A0QN+kKmzffjYbs9NebqYTbkLJDzG0QetQMXkIPAR1IONilLtu46ieH74XkxKUtyFZaP2hiOqHoyi9l0oRZhfPZsUQov1BUwJXNa9mSePi4SBRMQj2IUlu1Nbw7DDtMJ9XTX9LJNiftl4m48C7DQ4Ilq+hKIUQuHLSoBhp0nau/5kTqs7RxnZ3cHvHLmk139CEtcw8RpNXZJvcIw3abBXzCMaFi/u/oiZHnvGMLrSGV3sooD3mKTpm3cT7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOvGy1KCn8qD+l1g7q9q1FoO24CHFo3HFQCAWzwqy3k=;
 b=E7zup212L8ToK3xz8BDt7Y2sU0RVpsL53t6kLtSqxvZFKq1/xXDoldH7r3DP60XJAS8tXv1SL00qhpnKAPwPzWsYrGJEBwjdgC+y4tHNTIZiPLdW/Cq/nzeS5nhLamCyVEAl5g+3c0i0K/RKBKQ7KcDYKBqX7QVRSlhrQ4FVBesz7ALcdUBr5FZZ0s4cya697pFnbWrrmKBWosagKZ//91nslJQNRxm3A98xCtozeD+Ou+pL2UFzRZk41e1H2/73YzMl5A39aCpXB8C8N2P8VaqhU10VljybaAuV6QUdC6yaX1O9qUv82mlDxOcFS/2AhE1UZh/QH32LO3QYLxRAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOvGy1KCn8qD+l1g7q9q1FoO24CHFo3HFQCAWzwqy3k=;
 b=WphZrTq832HKAsLJFnqSA5KT8xkW95e76vEodFIFhNjD68v5yUKn87n2XjGoItomnwp+QaY7sw0m0qyUxtieDKQ6JHPN3B48AIhogTsmMjPbHPun2TkMGaTunsKrWH5n3ihzrhcUAY5hq5oouuqg2mFpmPproZrWHRlpojuSqok=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 09:50:14 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 09:50:14 +0000
Message-ID: <5a23062c-cdbf-4c82-980e-392e431aea55@amd.com>
Date: Mon, 13 Jul 2026 15:20:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] dmaengine: xilinx_dma: Extend metadata handling
 for AXI DMA and MCDMA
To: Srinivas Neeli <srinivas.neeli@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Suraj Gupta <suraj.gupta2@amd.com>, Marek Vasut <marex@nabladev.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Alex Bereza <alex@bereza.email>,
 Folker Schwesinger <dev@folker-schwesinger.de>, dmaengine@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20260713072146.45269-1-srinivas.neeli@amd.com>
 <20260713072146.45269-5-srinivas.neeli@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260713072146.45269-5-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a82ae41-dc4f-4901-8c6c-08dee0c42365
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	p1NnlBMh2MN4UsZ0KWwNVNA0v7m38oicBJXbhn7Ro24EHSUCf4mbbpyW7G8yoWfs6sEdd6TUA3isbEmGzyZnwFqB7Ayn3A0jAdi4InDHjhGInG1w0AZjP24yJmCTNHCFXL59UpNw8Rosd6JqS1JyZKSCSW3+TXya22Y7RehXWhUuBUdTmpHGE3EEbwcPGaU8evNgh2+3a1BU4Muqp28eG+oVKjgd9zL7cS/yZQziANob3tHx+fAAzJr0LI94MXm9TCqb5yA5LrFFRsCAzo+niPvcq5VqlxZ70QsnpneJDSwHQnxOhUob7LVD6wQwy0pGKxqHSoskxcVpxLtIvr4TYUUbyF0SYU9IAhQOleXlojQ1rwOy+xOx4YNnG8ve5iIjQLmBUpZXGYMkzTAQDCzwEz3klhpXrPmIvO1fKAklPN+cXeuX3K3lHgA9Uj7r7LEU7yTDkaJz43d9b3Kfv3YAUwRbWElaTVmE4ORpLVmNIa/kT1KaPpNE76qAp1/V+ycUPktFKqSqVB3kdbrqFLjFHIzM8C30uBMpWGjqipJnaNBaGm96s8q8D2dPNMrEpUkOgG7DTEDrda/Cfwmln3COyxI/hPg0onr5C2R0RcAMds4a0A+NUQl75PIJhisYrpAjiqAGw512w9LWAeCZWUJM4tP4yBEuii9/Tdod32psrvc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjRrSHRlWERDZTBuM0pEZ1NOWHhSOHJsWHdxak5uYVZ2T29mUkxKcmFuMmMw?=
 =?utf-8?B?SnJ3Q3kwQlgxdzl2czlZdWNCS3A0d0RwcVgxbjZZcjVSc2FWVGU5ZERsVUVx?=
 =?utf-8?B?NGs1cU8wM20weHgxWkJWMHI2elBGNk95R2FuZUNOV3RSQ25LUlNXRTRlMU9R?=
 =?utf-8?B?UFFEeXVWcy85NERyVEU0QlZzRDZMaXRzSHVPZGdOTk5DWktOLy9IQnJ3Wkwy?=
 =?utf-8?B?dzczYmwvYzd2T25GSllhTWZoSlZ2YVZVKzFPeTltTktCR0l6V0JscWdoMzB5?=
 =?utf-8?B?cCtOUFNXVzN5OStLMHVxK21OMi9WQ1NJakRjYi91VDlWR0JiUVhCRVdPYmxO?=
 =?utf-8?B?Z2JNSVdLQmJINDJIbFNQNFZoYzJXNlZ3RkNhcjl2T2REREdjVnJ3RCtiUnlQ?=
 =?utf-8?B?SGRkVjhzYnA5TTZWcldPVFd2Y2dkU3lLaXB5bnYwYXI4a1g0b29WVVZxNEY5?=
 =?utf-8?B?TGJoRUZoNklQd2RwY2hjak9wcTA3V2tyZjJIWDZKUEY2cytzZm9OZWNJUy9n?=
 =?utf-8?B?WTRVUklRSWFkRVA4OXQ3Z1BRMXQ3cnQ5RWV1cmUvSTdOZWlhazduTTh4T05Y?=
 =?utf-8?B?dCs4ZTU0cW5INkdON1dmQ0tYazBaeXBmOS9PTVdLbTYvL2ZUWFR5U3RsRjNY?=
 =?utf-8?B?RjNudmE2UTE0cWg4UEs0TlB6Qmc4TWx0WjNnODYzZ0x1cHBWRjF4Sk91alJv?=
 =?utf-8?B?MU9JQnZSRXhDWjJGVGJKOSttZ0VEdFlDREtHU0NDSjlvYjM4U2lKd0pIQXdm?=
 =?utf-8?B?MmJ4Z0cwVzhGNmRnVzJaVGhlaUUwQzFhYU8wdU8xTkdEdzArV3ZwQ0ZJSHJQ?=
 =?utf-8?B?SzgvbmRWclp2Wm5qL3lSM29KaFRiY29adkJmUWVsOUJhd2lPeTl0bTUrNEVy?=
 =?utf-8?B?MGc3RnlVZElXenFkWGNYckhmc0h1UUx5WTc2d2xNRG5nNnR4WDlqNHdCOHdE?=
 =?utf-8?B?M0s5cGxtVkxRT0lCSEdTbGNNMUNNUDVGVGs2MFRVclBhQlAwMjhBNE9FcXFl?=
 =?utf-8?B?S25VSXN6TitGVWZta1Arby9kcW1lWVN1NlUzelJMcUd0T1lWajFhM2NHRTRF?=
 =?utf-8?B?YzBWZnNVODJMNWlkMDNoRU1LTFlZNDFjeUVwMnhQN1U2ZmN3eURIOGlVUnNH?=
 =?utf-8?B?bUZVUTFEeDdBM21qeTR4VTBGU0RoZk9iQ3UzblQyOFI3TFIwdG55c3dMRC9C?=
 =?utf-8?B?UUJOcUJaWXF5UVBUY1NFaU12dXVkdFU1cXlIVnYzSmxZWUlCUTcxRFhRT3BY?=
 =?utf-8?B?SDhzRUQ0bDNYVjVreXRrWU92Znl2NjRJaUsyNVNnMEM2MEdSNStoTWZySTU3?=
 =?utf-8?B?L3BLK2UxbitSd2p2SHkxSHFINjJNK1dFeWFQRzVGcTZRalNWL1RGaWUzdmIr?=
 =?utf-8?B?VGhjME9GS1JubmJneVM1T0tabkt3Q0d6N2RXUkJxVWJmU25HTHgrK0c1dW5Q?=
 =?utf-8?B?UmJ6ZmUrbEpnUGJIV2czYjkvQnMzNis2aVdWbktWTm9IRzg2YldBaFMzOWdq?=
 =?utf-8?B?YWV0eVNxN1o4V3lxZ2R6Q2dmVXVRN1lkYlh5N2NpT3kxWnNQVmowRDRHQ1V4?=
 =?utf-8?B?dVBBWW9LeWdiMmVhNU42ek9JeEIyelJXSE5qUElCRFgyNnZnTkcvNzY2VmFk?=
 =?utf-8?B?cnZqOFpZRm5BTVlxKytabmlXK0E2THZTV2tuRkJGQW9vS1gyMGpuay8zQXA4?=
 =?utf-8?B?MmwyNlZESVJuai9iQzZzZWo4aHN0SVNkK21aUzByMldFeXNYZ3JKL0ltQmhj?=
 =?utf-8?B?TEY1L2x6eVRNNFczbjQ0aFdCTzltZUJSdjdsVmZlaXUrY2NiUzc2ZE5PbURR?=
 =?utf-8?B?eUlYQ0JoM05rakd5UmpHQXB5QVVVSTFoL0hmVDRwNkk3K21IWENkMWl0c2Jl?=
 =?utf-8?B?WE1UM2JnWkdxeS95cjhGUjVvZXZpbEkrQUh5Vko2alZacDhtb3I4SWw5bWxY?=
 =?utf-8?B?OVRBaUZHLy92d0tNUnE3VE1FRzU1OVNhNjNpWjMwbWVyYnZ0K0VXdmh2SXR5?=
 =?utf-8?B?SjdlSkFGeWtSNjBaakZqSDd4bU93akFqRzQxdSs5MlR4UlJFTSt2ZllaYS8z?=
 =?utf-8?B?Smg2bDRtYWdSRVY0MnVlU3AwTmpBNzB4a040VWpyNk9uaFpNYmZ0SklFL3Nu?=
 =?utf-8?B?S0JwYlMzdEZreEJScjNqQnI4Q1JoQ0Nza3ZzdGkrbGRFRGo2RFNlNXFBaU1D?=
 =?utf-8?B?eitkdGJDcVQyMDVtSE5ZakNBTWhJbGZ2emtxSmFpbDNyaXY5QSt6a2w0VEE0?=
 =?utf-8?B?SDhST1NocWhNY0E2am9kR1RUZ0I4bEN1Zk1vckY3SGU0YTZLTlV5T011VWEv?=
 =?utf-8?B?NDlyWW5NWmhzUnQ0bTZBWnh0aU1mbU04MThjTFJWRkp4ZGs0MXd2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a82ae41-dc4f-4901-8c6c-08dee0c42365
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 09:50:14.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95SymfNz9jQV74PvwB2t89mQajcjhjOFsawkQCD7tIaHZdsGC0g8BZAQGpgrDWLD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-12372-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:srinivas.neeli@amd.com,m:vkoul@kernel.org,m:radhey.shyam.pandey@amd.com,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:suraj.gupta2@amd.com,m:marex@nabladev.com,m:tomi.valkeinen@ideasonboard.com,m:alex@bereza.email,m:dev@folker-schwesinger.de,m:dmaengine@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:git@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06C5C74981F

> From: Suraj Gupta <suraj.gupta2@amd.com>
> 
> xilinx_dma_get_metadata_ptr() exposed only the descriptor APP fields.
> Each descriptor also carries a status word, and AXI MCDMA carries an
> AXI4-Stream sideband word holding TID, TDEST and TUSER that clients may
> need. Return a pointer to the status word so clients can read the status,
> the sideband and the APP fields together. The exact index layout is
> documented at the function.
> 
> Take the pointer from the End-Of-Frame descriptor, where the hardware
> writes these fields. For AXI DMA the pointer now starts at the status word
> of the EOF descriptor instead of the APP fields of the first descriptor,
> and the payload grows from 20 to 24 bytes. No in-tree consumer is affected,
> since axienet reads the RX frame length from result->residue rather than
> the APP fields.
> 
> Read xlnx,axistream-connected for MCDMA as well, and attach metadata_ops
> in xilinx_mcdma_prep_slave_sg() when an AXI Stream interface is present,
> so MCDMA clients use the metadata API the same way as AXI DMA clients.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> ---
> Changes in V4:
>   - Restructured xilinx_dma_get_metadata_ptr(): AXIDMA is now the
>     fall-through path instead of a separate branch guarded by
>     WARN_ON_ONCE()/ERR_PTR().
>   - Rewrote the kernel-doc as an index table covering AXI DMA, MCDMA S2MM
>     and MCDMA MM2S, and documented that the pointer and payload length are
>     the same for both MCDMA directions.
>   - Added an inline comment explaining the union aliasing.
>   - Condensed the commit message.
> 
> Changes in V3:
>   - Renamed subject to include "AXI DMA and MCDMA" (was "AXI MCDMA" only).
>   - Complete rewrite of commit message and implementation.
>   - Metadata pointer now returns status field at index 0 instead of APP
>     fields, exposing status and sideband information to clients.
>   - Changed from list_first_entry to list_last_entry to return the EOF
>     descriptor where hardware writes status and APP fields.
>   - Added explicit handling for both AXIDMA and MCDMA types with proper
>     payload length calculation.
>   - Added WARN_ON_ONCE for unsupported DMA types.
>   - Removed the 'chan' field from struct xilinx_dma_tx_descriptor (was
>     added in V2) as it's no longer needed; channel is obtained from
>     tx->chan instead.
>   - Dropped V2 patches 4/5 (dt-bindings xlnx,include-stscntrl-strm) and
>     5/5 (xferred_bytes support) as the approach changed to use residue.
> 
> Changes in V2:
>   - Added support for MCDMA metadata handling alongside AXIDMA.
>   - Added 'chan' field to struct xilinx_dma_tx_descriptor.
> ---
>   drivers/dma/xilinx/xilinx_dma.c | 49 ++++++++++++++++++++++++++++-----
>   1 file changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 1b5b00f08c5f..2be95f0ba3ea 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -651,18 +651,49 @@ static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
>    * @tx: async transaction descriptor
>    * @payload_len: metadata payload length
>    * @max_len: metadata max length
> - * Return: The app field pointer.
> + *
> + * The hardware writes the status, sideband and APP fields into the last
> + * (End-Of-Frame) descriptor. These words are contiguous, so a client reads
> + * them by index from the returned pointer:
> + *
> + *   AXI DMA:          [0] status,        [1..] app
> + *   AXI MCDMA (S2MM): [0] status,        [1] sideband (TID/TDEST/TUSER), [2..] app
> + *   AXI MCDMA (MM2S): [0] ctrl sideband, [1] status,                     [2..] app
> + *
> + * For MCDMA the pointer and payload length are the same in both directions
> + * because the union members overlay the same descriptor words.
> + *
> + * Return: Pointer to the first metadata word.
>    */
>   static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
>   					 size_t *payload_len, size_t *max_len)
>   {
>   	struct xilinx_dma_tx_descriptor *desc = to_dma_tx_descriptor(tx);
> -	struct xilinx_axidma_tx_segment *seg;
> +	struct xilinx_dma_chan *chan = to_xilinx_chan(tx->chan);
> +
> +	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
> +		struct xilinx_aximcdma_tx_segment *seg =
> +			list_last_entry(&desc->segments,
> +					struct xilinx_aximcdma_tx_segment, node);
>   
> -	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
> -	seg = list_first_entry(&desc->segments,
> -			       struct xilinx_axidma_tx_segment, node);
> -	return seg->hw.app;
> +		/*
> +		 * The union members overlay the same words, so one pointer and
> +		 * length cover both directions (see the layout above).
> +		 */
> +		*max_len = *payload_len = sizeof(seg->hw.s2mm_status) +
> +					  sizeof(seg->hw.s2mm_sideband_status) +
> +					  sizeof(seg->hw.app);
> +		return &seg->hw.s2mm_status;
> +	}
> +
> +	/* Only AXIDMA and MCDMA attach metadata_ops, so this is AXIDMA. */
> +	struct xilinx_axidma_tx_segment *seg =
> +		list_last_entry(&desc->segments,
> +				struct xilinx_axidma_tx_segment, node);
> +
> +	*max_len = *payload_len = sizeof(seg->hw.status) +
> +				  sizeof(seg->hw.app);
> +	return &seg->hw.status;
>   }
>   
>   static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
> @@ -2639,6 +2670,9 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
>   		segment->hw.control |= XILINX_MCDMA_BD_EOP;
>   	}
>   
> +	if (chan->xdev->has_axistream_connected)
> +		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
> +
>   	return &desc->async_tx;
>   
>   error:
> @@ -3287,7 +3321,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>   
>   	dma_set_max_seg_size(xdev->dev, xdev->max_buffer_len);
>   
> -	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
> +	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA ||
> +	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
>   		xdev->has_axistream_connected =
>   			of_property_read_bool(node, "xlnx,axistream-connected");
>   	}


