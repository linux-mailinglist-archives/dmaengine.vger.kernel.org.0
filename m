Return-Path: <dmaengine+bounces-11803-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yLLFDR40PmqkBQkAu9opvQ
	(envelope-from <dmaengine+bounces-11803-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 10:11:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1CE6CB3A1
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 10:11:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=4GS0SiL8;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11803-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11803-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3DD33032591
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCB23AB298;
	Fri, 26 Jun 2026 08:11:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098E3A83A8;
	Fri, 26 Jun 2026 08:11:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782461467; cv=fail; b=Sk6NkG2aWeKCcPhxfSZ+QKvgoNRL0cCO6l49zgDKrOBCpRd7b27F45rKdOmQ87pMv4ffoFgIOCxQ17HkF+11Oqd0DoWs0WMAWFW4YVoxDYNiMeX1NB8bJjFMU6bekmT5OYQaptE8ECssFB/HGTkDKG3KZyoVeyGyJqCZ60lipK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782461467; c=relaxed/simple;
	bh=nkg4uGlF1IENSw9PMq32uZquHYQGQAoTDReVcM/fJAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rXteuaU/GX3lC0IQVrF0RGbJfE74SYiOwcxrX5HU4J/L5PZlYuA2XIllhxp/V8RwmsflU4GigZM7iWbhzTIda9SfkVckYWpC1ceaUZ0B2/fsz1rdaW6HaKfSEnoa6N7vLlRdeR/m120pa4U2yYYmxu5FgJrrSaexAK001g3HJnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4GS0SiL8; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2jqujJJemN57kcYw/LfUyzVC0PYdJGUMQCgKT8c17l4yCXZrKINXLu5QsuOI70jJyh68z7+mYWzu5/jfiJFQU4JekL2pBTsyWjHAoHca/q18zKLBYqwQSbjntviFjk6W59Dsid3QgA2nP8DzIihj40pfhVvrx90bJtHpmmZUz/IJxsXw38VmbMsI7wEsOdlWcVviVtycPiHt3MClRD+k66NyD6o+ufKB9L55r8giR2ZMoHJPcY1kzvyduot+ygcLnJzqd/QYfZ3TvywSlB1d6ZyTQlub/GuhY7G6YZlaQzZfJF7mv4nZtf+ufnRyqLarRteF2igWp+nuojn7M/xxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQLCmWN/4I1WLBrd2OWCevzdthRd1FxS5lv12Xj/0lM=;
 b=khkmn+Gj1lUcHU6vhE+Jwjn4+Iels7g10HWlT6vRIT3G5fUAgqjp0SYhRe1MPMcYpxcKGdZjV+87//X5xTM9KEjmIf7YUSbrNS71Zkw0nXq4x/C+jcQd3jQ8T1OsbJ9GS8g58r3TRG2UazMcSIagwUpH2tnRwMLPCmCha4If7sfBpUbLOSy2sVLmqgSfms7Cko6Vj83fkAsFw1TtddAbtGXviuNK6oFumk3i4ab6SvD0q0yNqky+/wXkXT921SMWifqP9U5dKbKn4ykuWQm+xtVcQnLgYBdmRsE9X/alkgBKtgDQ/Q+7FRXZq851jxFA6/s7Gwj8AQjYudUiQZU9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQLCmWN/4I1WLBrd2OWCevzdthRd1FxS5lv12Xj/0lM=;
 b=4GS0SiL87lDOigJZr4QAsy4jLTm4t44nz/3eJQRt3tF8UOahuEqwjXT25hUBe6qrEy557f4jg0q5g0bRPQvKHBl7gyvNFoqrAr9yAVgXMGaBBJHGO/Rg+z8f5N0Pj97OPDcHDEaUdulCkg84mybhomH6qHHPL5GRck3Inxdf/VE=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:11:01 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0159.015; Fri, 26 Jun 2026
 08:11:00 +0000
Message-ID: <244488e8-81a3-49ec-ba71-3ae40a334e55@amd.com>
Date: Fri, 26 Jun 2026 13:40:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix CPU stall in xilinx_dma_poll_timeout caused by
 passing delay_us=0
To: Alex Bereza <alex@bereza.email>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Tony Lindgren <tony@atomide.com>,
 Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Suraj Gupta <suraj.gupta2@amd.com>,
 Frank Li <Frank.Li@nxp.com>
References: <DsE3FsHGEnJCtXR3Z9SV8EKrNPT5Ts7jJzvuFbYxFFwXiTIk9D95VxhojlLSRRnswrBlhXLZAePfM5VH9axGhQ==@protonmail.internalid>
 <20260402-fix-atomic-poll-timeout-regression-v4-0-f30d6a6c13cb@bereza.email>
 <DJITDJYQEOPN.I0S9T54IS104@bereza.email>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <DJITDJYQEOPN.I0S9T54IS104@bereza.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::13) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dfa9db-85d1-42ed-6d0c-08ded35a755a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	KwXbj7DrzMxKmbgqx78RvyFdrpymWJrCdr9TVLGwbm/6j0t8EL2n3AAB+ZPcXCBxTppgbMb/Z+Sm/SMZzFphAntCA7svszjDzwIjMSmsDhzxWXS8V8bgsNqzrgtoCn/VzVlRH7y3AEJR5qFL6iimpTX7q0mKFXHR4RCd/Ff40y3BPeVqs4EnDkqEzew35IJZj7SckNDC+GA9/cUoPhPCrTLQsVAzZ0GxWfhjiYpOk3QUhG9TJoWxcWcEM7sLoCs2Q/A+uEs+kUgVJqxfTtQkXj3EhEaS3klQ+noLmusXSXIiMdZQ1CT+qSJdpo/j2hnUJ6LQDyWBW0xxeyq/yO/7EuL/mX46e1Tq3BRTV6NduD2JTt9VunoBbZgIXjT9Z28O6D5X5XEZdr7i3K77MZEyAeA9ZiZpjHPB2yMqhYue//FG6WIvtfP9eE26TUKnSCjZQjM9tfLiE64dITx+ws8KNYNrB9uhNuE3IR3BWuuNqAZvtKCeQ56guFFCfpV1JyctInsX33g6RbU9mRs+WK/L4auU1Zozj1XqQWM1yBsJHn2DgWjBZCWFfg6s0163f2OcK/NTiR72JPm5VMmvG+vzlvB4nhjSWRYMJ+bB/+g0Vc2vhM1Oe/RndK4x1/L8t1El0K8FLoiaMZjCGxcEVLmStVhX5JKpZNIHh2X9pEN98M4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEIrNGE2T2tnb3Q2MWlMTE53ZEpndFRkMVdoRTlDbHBPNjc3dlJuUFNaR09X?=
 =?utf-8?B?MTB1dGtJYmtLaE12YVJlcndNS05nd09OdDB4WitrOU12c1NGUG53WTJ1UVFr?=
 =?utf-8?B?cWpaeTNwL3Brb0l4NVhFMDhPUWNaL0doV2VaVmRNekdNc2VtUVZmOVlIMmNH?=
 =?utf-8?B?OEdYbE8rOGtQbkNvMi9vL0l0M0NWclFkMkxOQTdydkFldXp2bXJpbHlOdW1G?=
 =?utf-8?B?aGdYK0NUSTZ6dURVYVh6RW9TdjdDSG8rM2JmS2tNUTVoWEFCYnRjL2orcDU3?=
 =?utf-8?B?NWFCU0luaDJjT2htbC9vck1aWUFXQmZyMlcyQjVBUUx5S3c1NmJVUS9TbUpU?=
 =?utf-8?B?UXB1T2RUNWliY3VPV2loRysxbEtZVFNlMXMvZGF5VlFrM0Jldm5EalhoakNQ?=
 =?utf-8?B?R3g2L2xqd1BXUHZWL0s5K0NqN2RvZXFmNkFGbkhBYk8vNXYyS0pMUEZuVGx1?=
 =?utf-8?B?L0s2OExJQ29aUHlKVy9VMExZcWpWbE96OTcyYWFKdHdIVXF1aWl2WlFNakZp?=
 =?utf-8?B?R2drOHZDM1piVjZoUGxTR1hzUzhpUXJMQkFDVWwzRWJLRG9JMWdvM2JYaWVR?=
 =?utf-8?B?d2NyMGkvWUhzKzVCcWtFSk83cUtEUzBYWW4yQ1FPMVMvZml0TGNLdXdaLzRL?=
 =?utf-8?B?K1ZnRm1CRncxWUxlb0RyUUUvaTNOclpWWkJib3dsdVEycklacFBJeDBDVXRm?=
 =?utf-8?B?Y09vcHM3ZU9FM2tuWDREaDBZSTI5RG9hT3QvMGc5Q0JjZEFpZzVCbW9pMzRP?=
 =?utf-8?B?T2I5bFFJWWVSV2tIV0ErdzlWZHV4eHlzaTk3MFpLS2plWUUzREFUZ05EWVhQ?=
 =?utf-8?B?M1lMMG1JaFpzd1ZPWlA0cDZsYVJEaUlYdTRXTkxsdVAycC9TNzdQWU9Ec0J2?=
 =?utf-8?B?aDlvYXpDYVh1SzdiUThpRUptZUlmZDV0MU5jc3FWQ281SDI2TWRSUm9TSGpT?=
 =?utf-8?B?bjEzeXUyRFZzTFNHeFFZYlNrRGZHaFVKb2Q2R2dXTnRMa0hvNHQ2ODY1QzJn?=
 =?utf-8?B?UWx2T05md3J2MmliQjBFbklvSklUaEdOaEtiWHpzT3ZjbWJZam93Wjd1ZG5G?=
 =?utf-8?B?b3hRWjhycTNwL29neDErTUxrU0dVSVVIV2xZY1Uxd2tOSHI0WlpNSVNob2xD?=
 =?utf-8?B?YWhLOUM2Wlg5TFRzK1p3TmlNT3JyR1N4Q20zeGoxWkpPalN4S1pCcDNOTmN2?=
 =?utf-8?B?OU1uaXljeHV4NGJDb09RdnlkMUMvMXB6WTdaQ0ZyVlVwUWNSNk5tYXdmZldF?=
 =?utf-8?B?dHYyMnFMV1k0aFFtOVluMG54NFV2WGVqOXJKcjA3UFZtaUJDRUErdFlzMTZP?=
 =?utf-8?B?WEhEUW5BeENKeHo2VmlvRUFaNTVUNjZ2Zjd2SklRQit1c3ljWlpwdlNLUXJa?=
 =?utf-8?B?M3FKUFlSZEcySzQvVVJTajFzSjk3V0Y0b2xhNHFxRkcwOVpLa1Fnd3VPbFhQ?=
 =?utf-8?B?VXdlNExnRzdYeE8wVVJUSUwxQmpqeWZnWGVPUU4wSnpXOUJuRW5haXBIWElq?=
 =?utf-8?B?MjM0eVhBZlByU1ZJejRSR0k0Y3pnRzU0SWlRLzdIWVh1cW9GNjVXQXlObjB2?=
 =?utf-8?B?N0pDUmJLd2gxR29WNU8zb0hRRXNGSmlOSDZha2w4d2kzTks0NWtCRUxkSitw?=
 =?utf-8?B?STl2eHpyWTRwUWVpQkt0OXA0anBpNUpSM3hMNGFRREVBd3BWVm9nMTV3aU9V?=
 =?utf-8?B?Vk5XZUsrOGFabUVmdDlFVjFJWEtpVHd6Z21ZUlZUSWU0NktGZVRBQ252cjZh?=
 =?utf-8?B?VEgvMHVEeUJDdFA1dXY2cjJsUEpFTzV0ei93STFuOEZYQUNpeHBBL3phUzV6?=
 =?utf-8?B?UmZNOWRGbzJDSm9MMFB5WWNNNTUwYUpuYlZ4Yyt3K0RMUnpxV25JTVI1S2Fq?=
 =?utf-8?B?d3FqQzllQWF1d0JycXNYV2dZc0VMajVhSjhFeGgvcHBNTkJtTzhOdkNtd1VS?=
 =?utf-8?B?L21RWXJ1RGZmK2xhcEd5Z2xIeDVkeGNleHcyeThMUWREMGdVODU0K0x2RGNS?=
 =?utf-8?B?WktiRy9HYi9CSUQyRFc2eFQ5c0RRZTNDRkg2SG9sSW84ME4rck0rb201V3Fl?=
 =?utf-8?B?aUpQWmlQTmJJZVdkRjJ6ZFBzdG1KUTI2QUY0Q2RRUXpJY1REM0V3NDhqb2N3?=
 =?utf-8?B?VEQ5MVh4dUFYbjcvQ0NtSFRHODBZcitnaEd1NCtGaEUweUJXMUptNHJ6Q09L?=
 =?utf-8?B?RHI3UkN3L2luWVg0YnJMZ1k4YVR5NDNIbHBUek0xR2Y5cGI1WHZtSjJoWnFt?=
 =?utf-8?B?Y21VbEtvTFpncy9yK2RsbDU0UXNKV3VFSVorZkRaLzVNVW9nV0JPQjhURkpQ?=
 =?utf-8?B?K1lQdW9OS3hKRjJ6ZnFpV01ZaFEyYmYvRzkwWi9lVTM5MUVkTnQ1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dfa9db-85d1-42ed-6d0c-08ded35a755a
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:11:00.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JOhWDBKAZV+NYVSTF9yaxpsOZoaR+BCfiNg+c4a1YHKph6ZdSRUitdjUoPRbAQV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-11803-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alex@bereza.email,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:geert+renesas@glider.be,m:ulf.hansson@linaro.org,m:arnd@arndb.de,m:tony@atomide.com,m:appana.durga.rao@xilinx.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:suraj.gupta2@amd.com,m:Frank.Li@nxp.com,m:geert@glider.be,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E1CE6CB3A1

On 6/26/2026 1:18 PM, Alex Bereza wrote:
> Hi, could it be that this patch was forgotten? I still can't find it in
> dmaengine tree. Is there anything I should do? It still applies cleanly
> to dmaengine/fixes.
> 
I see both the patches are reviewed. So let's wait for Vinod.

Thanks,
Radhey

