Return-Path: <dmaengine+bounces-11928-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h7+xGqAlRWo27woAu9opvQ
	(envelope-from <dmaengine+bounces-11928-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 16:35:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC76EECF5
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 16:35:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=atwnDB1L;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11928-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11928-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42DEF30DBB48
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD613438B0;
	Wed,  1 Jul 2026 14:27:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6DA34252B;
	Wed,  1 Jul 2026 14:27:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916054; cv=fail; b=osTBkcPk888c3ZCsAUWaF0l+sm0ifOoApIDsdC23RaRygoOpD4ZBcni1wTFVeCbpRSlvoJg/ULlDCBqkjOEXySUl1rzgZDOQEDg9/GKgfsTcEJRmRUXMKTiaudqsrsEwdQvWjDvIvTRsCenXyxF3rz9Fqlz+X17eIPbrNSYIyVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916054; c=relaxed/simple;
	bh=1J2FXS+jU29cfANsszGqu1Hj6lB8ahLFJ0I+MFSO74o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KQ+7GxkqFZobp3OCaEGhstE6RkXexFE2lhj4lMTxLuISrH35HxuCkAOagyI6pYpu6ylcrfnkB2tI9H3G4ahJaePoJbEemYk8IPoQJ79cVPwF+GNhU+eDOXdZemovjlotAJKwCaoX4G9JIZY1d7TCbM1Fryc3Sn4RCEJcc/lXPrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=atwnDB1L; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6Ye7U+wvrgs+hd5vBn+OqK7X0xPEstpBfafWOxgujhtr33AaoKdkQTS5VWg4F9G6TlV6DJil4KCoFcWXxeJA4dti+FMhFnMRpcIIyD+pCTlKYqoqqN3n92oj4sYQPj3sLuPnxeRZvYNrRYl2Y/EHJpE3s/DlzrGnBmKHSecqXc7Njwquv6ZluLV3lTpzGbu8P9ku8Hy/ofme9vBMgooh6nCnU9URoy98ilkHXJ0oImxe/y7+BuPMXujA+VLThkZUlB4E+B/IhnqVUcEjw0HCz9JnQIO6mwDIUKJi2QRL+nbOc5ZhBrRnGthThjiQZqZr4nT2egEMeu37dJX8pnllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzVONWZNt2Spa6S12VNg18SEFPz4QCJ1fMNX/FGjUgU=;
 b=OHpKVqRrMRCtBsipq1N2mLk7yDx1nhJQPDK4e8blK+iyfESJf3B2JGH0o2xYSOBUDki9IXNF1GITeTb8/gW4bDSS9iU1z/kt1N7EpKaZQJuf6RSRYgZE4hmRgJ7WPEKUeyrn9CTeLLM82kssWHcFTcnxTW6CdB0oVQGESIW6MlxfCjXFq0/wzMRB3kc3HCVUDAknaE5q0LkbrxR3r07Np7TVOKTfMOQNaushlThfx1517B8TrCgLvgR/+b8X2T1OI1gBp1vWeGTdvl63RcafucJA0ces4QaBqLOvn7g8gOf+3+bUHES2LLhMS0teQx119pGMNrDANXmE7qLD2DxwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzVONWZNt2Spa6S12VNg18SEFPz4QCJ1fMNX/FGjUgU=;
 b=atwnDB1LL6WbOaUah4KW9idjubdGY94VbwbWbVBIv/gt5OYIU6zyFsGFgKdK7/TDzJZ+hBJy69Hcjz8DTHu+UeUBKrhYwsVST6bzFL9vAEgbLFtSZ/gluap1UzkSp3vZnOCKTMU/u8LjGjv4DulgKtsM8YwLGIfTHEq0xxAE7yLel5WYSZbEZj89v1Mj9bCZknXa54hXNQIaX3sr6i/MMxUkvx6k6YzTrp7ukVDuVDwUSZPjpuLSdd+3+40vZ15DIUF2604+Z99WdfQBm2cmrVYZutmgTOu3IDoDIVAtMalSbd35Tk+E8ZwSPvUzRt0mVxBD94N1RYze0CtJ6lx73w==
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 14:27:22 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 14:27:22 +0000
Message-ID: <4f346d8d-eedf-4599-b007-3fdfa9929b65@nvidia.com>
Date: Wed, 1 Jul 2026 15:27:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4] dmaengine: tegra210-adma: use platform to ioremap
To: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260609212531.22044-1-rosenp@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260609212531.22044-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: d11dd97b-652c-404e-49d0-08ded77cdd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Yvlw866IIgO4kkCRYJQASyQTZBWTVOdYsRXcGE+TXYSj7feSK1vMPiB5C6fzajfozx++vZDqMorYbTmk59Duur0rZ0n20hmeR19Y7mpbAVUCf6vJivbJTfms6OhG3/iWpEpCC+UNE1uQrMQAIJ1Sj/9A/EHvgRdXBMdeAWV8dbvfX2w/RD7+98awsuyPqB1eU9WYZh7+e5fVX9SmJnzS1UQez08Pc1v99t2vnbtY7cJsNusUfx0+0p+n4suQ7aArVpgUzs7fzi0wdxG6gRQJsBx9MnbrVJyzOy6bimOE1zevwdtqB3MEMOi19IEBJz+CHV9Az3n5LThWgEAEyWlVpnxYs7GSJUC6cnjz3Ibjv8THqy3OG7E+WnLfx4DuSIEKVQMF4CmkcNv6X3H+hq5vf/4X5ls1eGfsiZp4s3b4UNoWW4tw4J1qGu0CPes9M+AppymYrypMOWzcOK8aFHsp8UUhIElNAAYS8tY4e/1WWHZYgwPCOsnHhi4o6yrCnjWlCpbsDOdk5HVxKEvlbY9KBpNE/+uAhy1O77T3hsSUyaKurJEGSWHpFIBpx4iBwlNwTdpI9YZsY4OijEcVHP8ZsZQx1c2WDEma7gzUt3GhwiEW7hLhsbc+Z1I4Wo17Z78hcj3wg6jrNgAd9xzCGgv2Xlo4zQGhGAvRfBXzP2Amlfc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGxoWmZUU3UvNDZIMys2dVBoL0l5ZjY4bCt5WDJqSzJSTC9kRE9tbEozeUVs?=
 =?utf-8?B?aXd4QVBidGNBTDdEaGlqVjdUZTB6OG1vMUJOYUg2YUExbGNmSnQxWkVNUEdm?=
 =?utf-8?B?aWhBNXVMU2JhaFVnWTVVL0ZXaXZndVlpUWtOcUovYVREcWNFUjVZLzJZTXkx?=
 =?utf-8?B?enFiQXFMN2U4UTJlNHhmbUtPUktRUVdHZ3Q1djNWM1doWVFIZUxkUXZUYlha?=
 =?utf-8?B?SHgzTEJtcXpTV2F0Nk8yMTFIcEZpV09XU1lPaUFIQmpNWEh1WUhoZmkrT0dN?=
 =?utf-8?B?cm0wMWl6anVvTG80NWJXV2ZrRWl0RzNCbE5KTnc2RzUvckFnT3RwbW9uZUdw?=
 =?utf-8?B?WjdPcHRMRTRsL2tveU51c1FPTndjNi9pRkE3TnI0ano4bE9EelpPZkVQR1k4?=
 =?utf-8?B?UVhjUHZFVVFvb0dIVUc2cTVRbXJVd25PeW1QQ0M0WkdtTGE3Z2JrSSsxb3Ju?=
 =?utf-8?B?czRhblg3ZlN1cGY4MlhoM1ZMQzE2RXhXQnBpQjN6MkQwVTZQblpIZjkvampH?=
 =?utf-8?B?Q0M5L0pSQ3hxM0Z3bXllRjB1dXdNQnhtdXN4c1lhQXU3eGFrVDBST1RWWi9z?=
 =?utf-8?B?cGxmRlpScGxmM2RaZy9ZcjIvK0hwVTU1QUxLRndzVmJZWFpEWmlCL0RDcFQw?=
 =?utf-8?B?OXFqTjRJWEltOUNTYk5GQ1B1eHVjWk4ycHEwZHJpVExwWm5vQUJaQmI0bEtX?=
 =?utf-8?B?ME9JZGZmTjIyUnF5OWxKaDVVS0cvbVNiZ2lQekw0NG9XbUwxeG1ZMFlFR1hk?=
 =?utf-8?B?Z3luOWNHZ2VCSld3VmxFQU1YSUFYTnFMcFQyaEdzWExpdURTRWc0Y1VJZXhO?=
 =?utf-8?B?dHNjNUwwVnNTRmtnY0tNM0JzL2Fzbzl6T1R5dUlzT2Q4NjJ5SVROS0R0LzJh?=
 =?utf-8?B?NVpXdExWRE05NnA5S09CWVpNVitSZDVEaWZ4Yi8wV3BJeUg3RTl2UVdRMHZq?=
 =?utf-8?B?NW1YK3d3Qngyc090M1h3LzRwOC9wcURLMUFlU3hseEpNMUNKTjhqdHNVNTBz?=
 =?utf-8?B?VnJ5THB2eHJwSXpHd050WStqY0E2SFEvVEpoK2JnV3lkS0Vzc0pscXNtdHJh?=
 =?utf-8?B?UWVXNkRjYmVla0lCdm1JUks0TzZ0QTFpNnZPbWk2clM3UjlDUlByQkZnVTJW?=
 =?utf-8?B?WDNCS2FLdHFDeHlHak1xZ0VMd3dscWZoek51QTYxdWhhWVJGWmdudmF2N3Yx?=
 =?utf-8?B?Rms3cE5DNmUxMUs0VTcyYWx0UEJKa2NvaUd0by9EWE85TGVMb1BRd25HTHlP?=
 =?utf-8?B?L0F1L2RYTGRiSGN4OS80blBlR0twakkyUkhJVm91NytFUXRpSU5qd0hhRUlF?=
 =?utf-8?B?YVp2MHJDbldOSzUwOEprMU53U2xjZ2R3bGdlMXRGV2tnUlMzQ1NmTlZaZGZ1?=
 =?utf-8?B?bW1iLzF0Skgra1g0M2dSL0NEY003YzUrQmZXK3RzUGFVdUdXMzc4NWpuUHA5?=
 =?utf-8?B?ZFB4aXlNOHBRakVobjlKZWgyampORXl6U3VEaE1oTUFtUkN1VkE4Q0U1SEJi?=
 =?utf-8?B?cjJBMTc3YUh0OGN3QUE3WVVGNHhJMG9kc21uTmlBcVZ1ZEc4WWhZYjRCY0ta?=
 =?utf-8?B?aTAwZk5WdFJDT2haRityMzIrcnlHaklPZXZGZDhoZ2Fvc2lkOVJORXh6Unp3?=
 =?utf-8?B?M3QxOTFXL0hFS0NrZ05UMWcvYmxydXIzeUtySlFNblVZUnN5NzlJdDNFQjRq?=
 =?utf-8?B?cEZQeC9BN0h1TTczSVRMdVlhSGZkY250andTeHVUMWorU0E1VEJQQVZhVWw4?=
 =?utf-8?B?NHZmRkpydkg2U3MzYmJaR1ZVdytvWFZoNGl0Wi84Wm5RWWtCbHpxdXdkTVNB?=
 =?utf-8?B?cStGNk5kbVBTbUJxVStHTVg4UERPU3puejRaRXRMcER3NUQrazhXMU5jTlFz?=
 =?utf-8?B?TUNSVGQyQkNkUk5TZklCMmZvM0h6SENOUWZqY1d5WWlmbHo3VVFPaExvaXVU?=
 =?utf-8?B?MWxEdmtrYmg5TU1oemU1ZTM0eGNkOGUzZHJKeU00QmY5QkVRWHlxTXpZQk9v?=
 =?utf-8?B?eEZ5SzkreTFGcVNnbEQ1UjJacWhHWXM1NTdyR1BSQTNySUMwRkQxbElrU3lG?=
 =?utf-8?B?UTRxbCt1bGwxTC92V0pEaytlL3lzT01hMVAxdXJtbC8vaGlISmlwd0VHUDcv?=
 =?utf-8?B?RzZlRFBOUjhhZk96RGdzTldMZy9WWWNRdWUreGRLbGFEdjVzZjNKanVQem9Q?=
 =?utf-8?B?VU1WUUU3ZlY1RVU1WHVtYm85WlExSnc4UFkzaS80S1hYZ2N1QVF3SGRNMXhz?=
 =?utf-8?B?dkxpaVhwU29VNU9TNUh5QzVZMy9wMFd5MjVRbmdZTjRNRVJqamJmOFV6L3oy?=
 =?utf-8?B?QjAzQ3Q5T1A2YUJWc1B1SVBzZi9YSGlGVDdyckJxdFF5Q1NOWjlkdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11dd97b-652c-404e-49d0-08ded77cdd02
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 14:27:22.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1a9AedkW0x+diFZ0mOtMx3Q3S/RuvbWkMk1zFMqca265xoVUBqkp5MT7z+pqHsdgn3OSUnCZyZinunV9s7MiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11928-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:ldewangan@nvidia.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thierry.reding@kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFCC76EECF5



On 09/06/2026 22:25, Rosen Penev wrote:
> Simpler to call devm_platform_ioremap_resource() as it returns multiple
> error messages for whichever part fails.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v4: rebase and reword commit message
>   v3: change subject
>   v2: reword commit message
>   drivers/dma/tegra210-adma.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index ceaee1e33e68..21a381d022cf 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -1087,15 +1087,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   		}
>   	} else {
>   		/* If no 'page' property found, then reg DT binding would be legacy */
> -		res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (res_base) {
> -			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
> -			if (IS_ERR(tdma->base_addr))
> -				return PTR_ERR(tdma->base_addr);
> -		} else {
> -			return dev_err_probe(&pdev->dev, -ENODEV,
> -					     "failed to get memory resource\n");
> -		}
> +		tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(tdma->base_addr))
> +			return PTR_ERR(tdma->base_addr);
> 
>   		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
>   	}


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic


