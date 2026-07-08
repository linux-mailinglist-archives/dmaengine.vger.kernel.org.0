Return-Path: <dmaengine+bounces-12123-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xFmzIWNzTmoRNAIAu9opvQ
	(envelope-from <dmaengine+bounces-12123-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 17:57:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD7072857C
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 17:57:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=IUZHpYmd;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12123-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12123-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C68B3011A6E
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04A409286;
	Wed,  8 Jul 2026 15:57:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358B439337;
	Wed,  8 Jul 2026 15:57:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526239; cv=fail; b=mEW+TyvLMltcCzreWFqHo2p6jJ23eqh95MCy6cv9tiB/d5Cpa17YihpJvGh0h3JjhmZmRXDbFei1RLFXGdQqO8i5Xbnso++gZbwum/jKjJfhxasWdQsvUKp2Nbyhl6y6QWXeNjy4GdvdPGYW7loT7QZLOgCUKWPSPrsXBxchJgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526239; c=relaxed/simple;
	bh=1ozWx6msHaAZS4jEoJZrEuIFkg7xrRZTmMuCC/5yk7g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m5gw69IlRqu7uXz+eRexELr9HJhAiXeISWrKOJFrIj5MWw2uUGCl9X3NwdpLoek1g/BWvUHE4KTaemoJc4pylV6arHG4Z8IkC0moyP72aTl0TgbtBn6F1FDr/WGIUp+hNiRY/KtUejRzBjaoGN/BMV9HNTyN5DHAjPTwxWacuxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IUZHpYmd; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYDpvmHgEoOgZ00gXu+uh4NJoybSs5JYGg8fjJ2Gi1dcLFthTHZivzFnVJfiEoaysYeRE8GVXLuNQ2UNiGQ6vNKjsG09ON3HrJTwE3ebybBzCAGkKC4DLzDpAqVdrRwTBViExRqyM8R8R0QR7VkMy7aeTKvIQymClvP0BMiirecXMvmhQ5Wcx4weVNfrFehBEucG1CVUjlUo2z9/7HX7RhFer4ZtXAcgo/AEXYUNNkN4iwLxQprXOHJg7JaFPqSUOfYX6T7WxeARfEn1OHPuc3a/toSNgCzJLe5P1f3txFJB2sfC60qpBwgjKeX59m0/CZyc0ucype167wqrAMyMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiVXL4I5vnajX3RW2E00xVb4sve/CQZy+lpyfm/0CTk=;
 b=pr+cXSG5QrWIdj83C6+scHAs5jurZb3OtBCNHIWqq4dtcKd3sg9CABdKRxHmEr4SImhlNFLfVRNzecfaO0anPOatZikT8efONF7kN1+PeXahjMiEQLBWEwvn3gAodiFvFdc5JXTQDRh6sTPhY8aGVy0HTnPt0JNJUDoAIUc9Whb0xjPVyFvuNE24VrYSSN01WKUFKtq4Cz7rghKo2fA6CZ7DT186Ty2toWRTgvh3xwBiRqHNmcuhwowV23tcQi6maO3r8M30qdaUiYgxC0whDW8S8n7SHMkIY6/JolgGAb0biF8g6KPxj2iZu+wFfCh8+7L2oPUE2BfmvwqbtJMXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiVXL4I5vnajX3RW2E00xVb4sve/CQZy+lpyfm/0CTk=;
 b=IUZHpYmdHRngZ0Xnqofwn6PM+Br0tTmHVnwHTfkZb7XuyFjvAOKR2BpoiNCSkydSugKIs/zIBinBaPyQgrkmRsd7ltM+RhGIsuzmVbFqqRoCnxc1LaMCH4ri5Dz+/mMQg6cQhceRh9dAOWJ2ctzPfev49KYjXH3j6H0un/CCUTU=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 15:57:12 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 15:57:11 +0000
Message-ID: <c5c9473f-2a60-4385-9c5c-0d0fabe6c8e1@amd.com>
Date: Wed, 8 Jul 2026 21:26:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/4] dmaengine: xilinx_dma: Move descriptors to done
 list based on completion bit
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
References: <20260708100652.603074-1-srinivas.neeli@amd.com>
 <20260708100652.603074-3-srinivas.neeli@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260708100652.603074-3-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e0044c-e72f-4319-b0c2-08dedd09924d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|366016|376014|4143699003|5023799004|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cmP1jVVzDwJNItLHrsTVljswJ0Dvo8GiAk65uOCpa75AEvO8xJj34g4rKSsc7cgdQETMhAIVM7S3bzOriwPICVDiMGzmOCpiVGxkhMwOs+rnWblAD+gHzirlZZbxoUfTR6+ZD+t8kMfcu5DW5aU53tWzIVJns/HQ3utCtr8vK9IgVwZDmX0GLE1a987rKlMrgqnVMnn40L3evSJRnj17UXyyjxN9is7uId2C3MkKW+s7nXqpyw1jULIxgsEhyPve6RMqIOSss1PmGHsPGffJo3aVgbfwY1xS+6ib/CmYD7TRDT6Av++fj6bUJQ09BMw4u2Voj1ZFSTdYISAzbI5gc8tx+IZ9WnrG+x2OGXWnZKPi5ltp9pp5+574dkfzvF124fZy2tNLBecOitllWd87zU9LW1GQ389q8NkVGgNEZpODpUTwQ5s52CHhywMmxk1GtI8WwP/zDTSFOPh4n19/Z8tfnUbaHCjk6b4hCFIdrAMiLoMbdhE0MyDTAUt+ldk5mzMx6eVUo2tW/HFaQQ3jB0fghdY3fhHCcp0ZTE/BRXvtsianoDu5BW/FCZz6/UlYlko7frHyVXmc2knVLH1sXM/By7IePvI6kC25ffjVy2Z9BEKgs79YgZtBw/S9fUI9K4AFjVtBGjS3bNXZ9z/RsgxT0C1WvfXp4kgPxig1fQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(366016)(376014)(4143699003)(5023799004)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGttSE11STJnRmpSdGpydlVKNjA1Z3lzdTlSVmd6QzN5TnJ0SDF2YlZQeWx0?=
 =?utf-8?B?a0g5dVBURzB5UVovdmx5SzJvUkRIenozR0lhT1cvYm1CNkMvODg2RXNTOTBo?=
 =?utf-8?B?ZmVlTktEQnYzRjJpT2VBRU9Cb3lDTkNHY09wOXhBYjdBcVJlR2lRaXllNnJW?=
 =?utf-8?B?cENSTkxkREswaWl4bE0xRmlCS2hSRmt6cm5DUFpoR0d1bXdZUW9nWVBXUkxZ?=
 =?utf-8?B?aFBKOTZ0RUhFeDJ4eWdkMkQvQVVnUDlDNGhkMnlMOTRMZlF5YXpmY2s2cVJP?=
 =?utf-8?B?cmQxRXIzRGtsMWE3c0tDZ242UGhYdkF6aFVIY2NjRlJRN2sxZFF5QnN5Rklo?=
 =?utf-8?B?UkRmcUNjNTVnRDZRNUlBZEdIZ2Q1YWpXdjlxK2M3aFFvS1pObDdrM1VxV0pZ?=
 =?utf-8?B?dENqRTJuWVZnRGhNcWc1VmRkemVVNzkxcnhkR1lZMCtUQ2Z0T04wbEFQTi83?=
 =?utf-8?B?RExqWGlRakx3OHhQQ1RTVloxN2M0TVJFakMvQUpabjhYdFRNMmV3a1lTenFp?=
 =?utf-8?B?MDJaejdjeXF1bVlZejNTaC9IcXh1RS9xYXFGOWRmSEZ3VkNwVTh3clVyQnZN?=
 =?utf-8?B?V052Q3REZkdYS0lHR1JOb2ZCSERWRVZMM2hFTWxoWTc2RExIdWlxUko1Rkt4?=
 =?utf-8?B?c1lXeTJ6andCeGxwMmZNUFNqMG1Lajl1V1I2N1VqdGNWRDhsQ2xtdjlTQ3Ev?=
 =?utf-8?B?Zlpva1FkOG1WOTRXa3dxSElRQ016dkxKZHM2Nkowb0FNTGlVeXhJdGJjL0p5?=
 =?utf-8?B?RDdtU3dvZko0YUgrQUpFM1lHVUhhS0RzYi9OdkJFRnpWbnorZEw2dTh1UVBl?=
 =?utf-8?B?SGRScXFVczBOc3hRS0x5TC8zRUViNkNyMm5xczVjN0thcUwraEdRbkNIUnh1?=
 =?utf-8?B?NUU3cWVlVGoyNlNjeitZb3Y2eGdqcWx1QTYwbS9lWGk2KzBSZkNwMzFnbTRv?=
 =?utf-8?B?T3FsTVg1VWZoNDFUN04ya3FxYkV5WXd4QjBxZmsyaGM2aTladWZ6Tk1LbENw?=
 =?utf-8?B?TkJ2MFZYbmt3MW5sZjhHWHc3UGpUWG43VHhKbkxpVnd0ODY4Z29OQVdZMFVS?=
 =?utf-8?B?dG9yejd2VlBLVXQ5VTd2UGpsS1poVFBmNXJJRitPRTI0dDJyaEw3Lys4S1BF?=
 =?utf-8?B?c0xCNVU2K0p4UHlScWMzZTF4cWZQOGtocTFBK0UxbWp0cVRXOTV0Yk12RTcv?=
 =?utf-8?B?Z3dwTTZuQVh0N3dQZ2pqT3JjeTREbGtxcm9TRUtHRDR2ODhwZCtteFY2Tnoy?=
 =?utf-8?B?eE9YU1dnZ1pKNmdnMCt6N2xhUDl2RjZjTkFrWVZjYzJBZnZaZUpObmJmQzhk?=
 =?utf-8?B?TUxQa3Q5S1VVdklHekQyMFFXSEJtYUNrZk4wTE9rQmFaTlJzU0NtN2k5UFpo?=
 =?utf-8?B?QW5XVDB1L2V5dmpubGpEOENmc2Q1eVBGblYrT1AxNEFuOXU4dy9DYUxoSmdX?=
 =?utf-8?B?ajFhNmhFUFVRSWxadlg2ZVU3RTNKZE9DaWpyOTlBOG9Eck03R3ZDaXRvUUZU?=
 =?utf-8?B?QUZjN0ptOFNzTTQwV1dUdGFCc052Y0VCdE1ub2VGUE5sSWN1SFVKd3hIZ1BB?=
 =?utf-8?B?YkhLU2NqcW9wN1FpalJkZU5ZdWNNckZKVG1lMFJYQlhvUVBHSlk0ZVlpSHVw?=
 =?utf-8?B?Z1RnaXRCM3BDd2xRNmV5TTQwb2xXdlVzZ05lY0RwbUZ6aThhejR5MWRHamNk?=
 =?utf-8?B?b1N2SmZ4aEF4Y05kNmZEWjRqQlVVU3hzaU9aemZHNERaL2REekszVmxma3ZD?=
 =?utf-8?B?anlEb2hjSUE3QjNsMDBiaERCRUhFK0oycDRQbzQzalV0VE5wQlA5QW91SHQx?=
 =?utf-8?B?YzBJSndtYTVMQ091bTJMQlJFMUM3NzdscSt6VHg1Wlc3eEN2TmFoUDNSUnFo?=
 =?utf-8?B?ZWdveVhIdWN0bWVlb1NoUUJXZUNCUWxEUmRNQmRYUmVkbmxvblAva3BYNW1h?=
 =?utf-8?B?MnVYd25vRGNnaHo3QVJMNG8wZTJQS2p3aTVlaXQ3L1hIaU56QXlhbWV0eHRW?=
 =?utf-8?B?cEY1cjBXalZvYlkwSjlsL2xzOW8weXZ1YWxBYm5YL3hCZS9yNjRFSUFXaVp0?=
 =?utf-8?B?TGkwcjhQeTBLZ3d4UzhjL0xyMm5VbS9LVllSNks1UmdBcDQyRHB2UW5LRTdL?=
 =?utf-8?B?Y1dzL1ZSb3pxWjRaeFFxY0ZiS0FVby90SXFCaXRTcE9xZUNGN1JINnBvV0h5?=
 =?utf-8?B?b1dHSWRKMEFCN2hjRHhmOUM0K1luK0pnSkg4UGpzbkpHNXpTeTVhMUhHZFow?=
 =?utf-8?B?NDBrRCtKTTVoV2NHTUlxNXpRM0hCZnVhbjZobHVaRWRtSkJhN3Q0a3NvN3Ra?=
 =?utf-8?B?RFVCWTZHdVczZ2ZTdDVpbDVmekx5elhyZmVhOUtJUisxNS9qcTFOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e0044c-e72f-4319-b0c2-08dedd09924d
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:57:11.5849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXp1zDYZW26gHnW5Z9CaaLVbgaVIkS3gWD0U7/ThkROkXMHOYnbxtbjZiw3ao5Jz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-12123-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DD7072857C

> In AXI MCDMA scatter-gather mode, xilinx_dma_complete_descriptor() walks

avoid "scatter-gather" mode.

> the channel's active_list and unconditionally moves every entry to the
> done_list. The MCDMA IOC interrupt handler invokes this function on
> every interrupt-on-completion, but with interrupt coalescing
> (IRQThreshold > 1) an IOC interrupt may fire after only a subset of the
> queued descriptors have actually been processed by the hardware. As a
> result, descriptors whose completion bit is not yet set in the BD status
> were being reported as completed to client drivers.
> 
> Add a check for the descriptor completion bit before moving entries from
> the active list to the done list, using the appropriate direction-
> specific status field (s2mm_status for DMA_DEV_TO_MEM, mm2s_status for
> DMA_MEM_TO_DEV).
> 
> The MCDMA completion check is intentionally not guarded by chan->has_sg,
> unlike the AXIDMA branch above. AXI MCDMA only operates in scatter-gather
> mode (has_sg is always true), so the guard would always pass and is
> omitted. The completion bit is therefore checked unconditionally.

Not need to talk about has_sg check and compare it with AXIDMA but if 
you still prefer make it precise.

Once addressed , feel free to add.

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

Just a note that this change aligns with changes that were done in past 
for AXIDMA in commit 7bcdaa658102 dmaengine: xilinx_dma: Freeup active 
list based on descriptor completion bit

> 
> Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
> Changes in V3:
>   - Added Fixes tag.
>   - Expanded commit message to explain the interrupt coalescing scenario
>     and why the has_sg guard is omitted for MCDMA.
>   - Changed local variable from 'bool completed' to 'u32 status' for
>     cleaner status field access.
>   - Simplified completion check logic.
> 
> Changes in V2:
>   - No change.
> ---
>   drivers/dma/xilinx/xilinx_dma.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index ff5b29a808e9..1b5b00f08c5f 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1784,6 +1784,17 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
>   					      struct xilinx_axidma_tx_segment, node);
>   			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
>   				break;
> +		} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
> +			struct xilinx_aximcdma_tx_segment *seg;
> +			u32 status;
> +
> +			seg = list_last_entry(&desc->segments,
> +					      struct xilinx_aximcdma_tx_segment,
> +					      node);
> +			status = (chan->direction == DMA_DEV_TO_MEM) ?
> +				seg->hw.s2mm_status : seg->hw.mm2s_status;
> +			if (!(status & XILINX_DMA_BD_COMP_MASK))
> +				break;
>   		}
>   		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
>   		    XDMA_TYPE_VDMA)


