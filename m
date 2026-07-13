Return-Path: <dmaengine+bounces-12363-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f2BCNviJVGohnAMAu9opvQ
	(envelope-from <dmaengine+bounces-12363-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 08:47:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C4D747A1E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 08:47:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=sixhM8co;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12363-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12363-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D894B3001D75
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 06:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8DB17A300;
	Mon, 13 Jul 2026 06:47:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC51DED5C
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 06:47:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925237; cv=fail; b=BQPG7PUspZkv+BZAYUVLXPn3fjv8GuAnkRc9IniPoF+V3qJ++aOaMt5jXuWJ4408QXFMlztTjvbakz7USNvG29yfn1ds3RAqQHZOEEa6v+HsXeXLqRmsHiJVZq4rSw8gtVUp4K80tLNd2ikzFEzVaRZlpdDTOmNMyrDPi2XnDdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925237; c=relaxed/simple;
	bh=V03rvkmshb4mXzSU/D5fI+KoYIDj72tDIhZJA0z94ao=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EuK8OKVGrIPB6i3GDYXxU+cLnkJhuT3IRtTaTaVwiwFJKWopxKOYFZEZGOxzFsOjidirJaCPzq0xr/YnmHTs/4+5maOjt1u2lZOGtArHVjDG1GEBC9+21KMjQbNjy+sv0Uu6xYrtCull0rfa97I4SMPWuwNbreZDFxHlUDsKcZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sixhM8co; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/Tdmkp2Ej/z80TnLGVeTLbdUqsdB/AultuA1O6IhslJ2QvWhXj2506c4tp9GiVUV0dtMesWLOBOhIU3vIt4gX9hKk5TaWlTi0igOU56If5mRsuG7BdI4ZnqQZ43/14m8/bK6h6q8l1p+JdBXlnE3bWlg8dvfp4xdlZqyUq6E2EcELs0rMRjEoZNAD71fk9Rk7WdJzmTqev/E/xQBOS0SXICMj/IfUU71O7NMuxmd+1gInoqGoLtzXFNrMc0gwmI/2Fra3vGNsFrQACaECOYaNXJQbDonP1go3OzM0jZTfckZe4zvImllwiFGLfeSM/FIRFYbH/vtkjaO/1IzBI3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlLGktjmTsIf5ZC3RND2MH8JY+XwGhAuGW6qMXBuT2g=;
 b=nSUa33aTcExCAdHHFvVzQwlUAzlU4b9AC/h5Dwcjk7iV58kHgWZyu2Z+t5I33HiIIF4ICuToxvUg8PYUv7VstYFmatbTIrBfHYYWFnWRCcR2RgzxzxdlMWtHwmxhQh48TVBmagNqsLDcHBVOJJXna3cU9vS48n0CzErMk8EHa4jxqzXfRdxClAGUBx2HiyXCDqQ8FmdUnq9HRmnwakh22Cc1v6sqWzA1OjkizJxw1Jb8Xjt2Ij1aF10611avBSJgZVusnorDVYnIN9ArzadzSJfUNWG3vmu8vIPFFa2PaF9k0eTIk+TAcmiixngBZwydcE90YkSADwZwqr3/pTZjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlLGktjmTsIf5ZC3RND2MH8JY+XwGhAuGW6qMXBuT2g=;
 b=sixhM8co8pwH1wyMi++fYWJ17Gt4zLq7KHB8yOotTLPYJCHPf0rk7e7xec8WgIXujbPfFH6pvQtxA7LxGSlElsU4HCzfAwk7X3ePpY5FD40hvPlV/M5/8asc08ezDwdSq3ONDmwTU9qRxKj0sfVkG1U3o7zulx3PP8UHhtAwGWM=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 06:47:12 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 06:47:12 +0000
Message-ID: <81de849d-a230-4240-8896-65366807598d@amd.com>
Date: Mon, 13 Jul 2026 12:16:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: sashiko-reviews@lists.linux.dev, Devendra K Verma <devendra.verma@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
References: <20260708134343.3806759-1-devendra.verma@amd.com>
 <20260708135950.DEEEF1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <20260708135950.DEEEF1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::11) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 24847e6f-0228-4382-d0e7-08dee0aa91aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|4143699003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VGMun2/BqxwFU80giVyRw8L9rTgTUsHErcP2RrbUzfx/vM/xMobM9MJAVPiL6i83NRhv5WZGyop919gwFrOGBUXB7j1F85c5y28XjkMx01pz91ya8P5KH8QJ3ZhxqSpvCIHCk8TL858G+Nq9myTJrVuKFW82g4m/kdX80VTaxmACTqiMdMnot5lj5/o+jLDVv+9TcoczspyApFjAmBgvecQ+3t8zeDQPNZL3iV/RdwHU9+chgt2Ft3xQIA3gSma+AP5LQYaDi95oxeCj0uxJVop2UPFxf+OcpPPWutHbxiNULd4G6fc6arrSNOUgJj/HiLU5jTB8tSNotpnKSGVH3qIWQinIuk1cl4WkwhvUTzj2f8jDKEBIEQSulN45uU6+sED/3U23MCNsFVWl6hn/EvxFn4BpAdhKw5c7Fy5qjEfpvvErHr4ZI/TDUINtOkPBnd4LhaA2rpNtTWv0B+RgScsl2hokoXBrObl2aphxGF6ePvS58vck0Sj1ISi0KK3Zo2kvEyCgH9JEftJaf4/QXzn9gvqwPX+1A+8XYNXGzjR5TKe76MuYSZt59D9E8zlWH5LwNZRT5ykVrfteoG8pdK0YPJxF9+00MRjCNPEdxZxUBh/2TPSswu0TjR17ndfzDL1XKiDlAk9OJR/AKbG0T7GP3fxe8EYPlcUxEWeMD8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(4143699003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y20yTkJhMStpRytpQ2RzY3d4bFlHd1lWOUN1MVV6YUd0Z1BZUUNEem51MDNK?=
 =?utf-8?B?blI0YXZQeGJhUzZ2a3d4Q2ozVTdMMlBzd3M2VldXYko1QytYM1ZHZlNWQVNp?=
 =?utf-8?B?bDNrVzNzbDVCZG0zQnZCSG1kdXlYR21DRDJPZ1crcVJhaFN0NVFnRURDbzEx?=
 =?utf-8?B?RFFVM0ZUMlZ1UVh3dlgrWFBJYjl0VEF3bnFWS1ozYjhLZ1JGOXZzakJNYmJR?=
 =?utf-8?B?bHJNWDc2KzJEUzgxVElaYThlaWFWd2ZkSW16RVU3cTZJdUxOK0VyRzlkcXBL?=
 =?utf-8?B?VTQ4NjVhTS9sZGFDVHd6TGtmMy9CWnlqdk91V21WNXlaSkRWc3NZQ3orNlFH?=
 =?utf-8?B?QkI4VXJjWEwrLzVJanhDVXdYcWVoNHJhZHN4d3ord2NtN3dUWi9iY0Z4M1N5?=
 =?utf-8?B?WW1BY0lKaVJQeHhHN3hpemt3RWVaZWlQUmx3VXkwckxwTkNEWm91V20wYjFB?=
 =?utf-8?B?enZKMGJZMW0wako2NEZlNlBBZ2pYdVhjTGFINDR5dm1Md1F5Zk1qQVh2a2NP?=
 =?utf-8?B?SVhCQTR4MnBzcDlTb0dxeUhRZG9PS2xud25Ub0NJM0EvcG5CcVNSUktPNDdo?=
 =?utf-8?B?cXRSaktsTXhYN2UrYWJ0S2FNaDNWeEEzR3dIR0h6ZThweFdJWWVFUUtWT1Zl?=
 =?utf-8?B?OVVjU3Yxb3ZJUVNGRzFIOFlaTmhKZHZLU2QvL21ERzNZdUtoYmdkeXM5Y1dk?=
 =?utf-8?B?K3VlNDYwKzZmNWhXU1NZR2JoazYxajFaOEs2dElZcFNDQlB2VnZLN2VhTU5Q?=
 =?utf-8?B?YlRFVHBkL3FTYm53QXprai9NbTFPNlU2cjlJOWQrM3lLRUwycThlcWRwbHV6?=
 =?utf-8?B?YWNSQ2pmRGZlZmkvTEozbzhnYkJXSVhDSy9jL1FlNmJ2ZlpaTHJURGRsQlJm?=
 =?utf-8?B?NmNMSGN6YnNGNTZTdW1DOVhQL2Y1b003dWVVM2ZmOENUbFdNNWx6N1JnRGs2?=
 =?utf-8?B?Z2NFSm83eVgyWWg5Vy9VUTE1Uitld2wyRndMYUtIeGpnRHB3Tk5PeE5jSzJu?=
 =?utf-8?B?dFB4c09kK0UveG00K1JQOStYTkJNZEVzbU1XNFRFTTFmV0FSQ05kaS9GY1Ey?=
 =?utf-8?B?eGZmV3NWb2NsZlBPQWJYaDU3K2hqSXhKVWpCcmNQR2luRW41eFpzZXB2VHN1?=
 =?utf-8?B?bDlSdnVQNVNCSGIrcEczTzB1ZmZPMDFQSzNmNFN0NUNzR1p6RWUxQkF5bjBt?=
 =?utf-8?B?UjArVDZwdU5CdXdqb2Q4RUFuQ0N5ZTdtRkxCQlN6SWJxQUhxcStLMnV5Sk11?=
 =?utf-8?B?UXlvdHpqU2hQaVlaN3JWeGl6cVFlUDhQQnRxZ1MxNThhYmdraHl2UndwUHJE?=
 =?utf-8?B?VWlDT1NlTnRaUWE3UmJjenRtM1NLTnVJamduWlZRK2dyQ293aHJnS3dGcFJ3?=
 =?utf-8?B?S0NBZWVGb2ZlWnFMUmoyRllncnhmbUgxVTUrcStMTDNGU3lKcGxBNi9QajNy?=
 =?utf-8?B?dmxWbEZQTko2NVp4N2xIWFZ0S3A5bkVUU3kxemx5VzhCSmg4THVYZmg4bEpU?=
 =?utf-8?B?L2VkSGhySDY5VytCS0pHUVE4R3VwblppanYzbnY3WkU2OXFJOGFpaW1vRUE5?=
 =?utf-8?B?Vkh2M0ZjZlpCejNCcHVlMk1TMUQ1andoTHJ6Z3QyOThibHJZOTQ3NHAwcGU3?=
 =?utf-8?B?UW51bjh6UkNJMndTMGwvOW1sNHdDYTFseHRmMEoyV25YdW83ZDNqYVRJTnMv?=
 =?utf-8?B?Mis5UEpwREFyeEFKd09yYzVNa2JQQzJYZ0RMMDBteG5RWVZ2L2hLcEJoR3pS?=
 =?utf-8?B?SkRQdTN6ZW40ZVhLRitmbkI4NUNnL3ZRTFByS05XU1hBcW9tbEZBTHcweFRO?=
 =?utf-8?B?TnFCUkdrWk5pczN6M2MyQmRqdGVrTXZCWDY1anIyMkw3QzV6ZmdXWkFUaHdq?=
 =?utf-8?B?ZEtPbWJrYlVFVEg1aUdOZmwvc2tVTERJcnByUkdyRCtxUDB1M0MvRG1LaGZJ?=
 =?utf-8?B?VkYyUnNIWHJ5SU9jRDZ4TlROUjN2d2RlZFNkMUVPVnNsTE9LcFJFaUtGK29m?=
 =?utf-8?B?T0JzbzM5cGI5QWNRTm15Tk5meVdKb0JzMXVPNllNU1FqSUlaZ2djdFc3U2xk?=
 =?utf-8?B?VjRwbmxaUVZnTzVERWduTnVYM1hIOUpQNHgwaXA0bTZvOUVJNkxUMnJzOVdx?=
 =?utf-8?B?dmJzdGxEOWVZekNsWXVwaC9WYkdiUWl5bHp2YWVhNkRKc1ozQmh4R1YycDYv?=
 =?utf-8?B?OXpjcWRwN0c0YlJHdUZNUTAxaHVWb083NFVJMWo1NWk2ejRqL3oySHNuWFRT?=
 =?utf-8?B?Umd4K1FtRTlOcDJlTXRFQUZtUVZIRXREV1QvMzVneHFUTTQ3MFJnV1ZvWGkz?=
 =?utf-8?B?RFVHUDRXSDRhemRMU3VQUHgzQjE3b25kSjdrMFU0U1VyZTgzSFAwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24847e6f-0228-4382-d0e7-08dee0aa91aa
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 06:47:12.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydu8iao7JHgiH+V2gVgYRK0vuoTnZfiWZoPONJ90MXGR3kl6ATK+hJdCmSHxTwtDkQBWutzVbOIugfPOiSOSYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12363-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:devendra.verma@amd.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72C4D747A1E



On 08-Jul-26 19:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Designware PCIe core bounds checks reject HDMA configurations with more than 8 channels.
> - [High] Standalone PCIe eDMA driver statically limits hardware to 8 channels.
> 
> Pre-existing issues:
> - [Critical] Missing register offset when setting the eDMA/HDMA base register pointer.
> - [High] Incorrect arguments passed to GET_CH_32 macro causing wrong channel registers to be accessed.
> --
> 
> --- Patch [1]: [PATCH v7] dmaengine: dw-edma: Enable HDMA 64R/W Channels ---
> commit 4834a312ef82b7f9b290aedb3a1f566db2548955
> Author: Devendra K Verma <devendra.verma@amd.com>
> 
> dmaengine: dw-edma: Enable HDMA 64R/W Channels
> 
> As per 'Designware Cores PCI Express Controller Databook',
> Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
> channels. Current controller driver supports up to 8 read and
> write channels only. In order to utilize all the channels the
> controller driver need to have the channel related structs
> and variables as per the number of channels supported by IP.
> Following changes are made to enable 64 Read / 64 Write
> channel support:
> 
>> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
>> index 1fafd5b0e3153..da7a5cc93ad43 100644
>> --- a/include/linux/dma/edma.h
>> +++ b/include/linux/dma/edma.h
>> @@ -14,6 +14,8 @@
>>   
>>   #define EDMA_MAX_WR_CH                                  8
>>   #define EDMA_MAX_RD_CH                                  8
>> +#define HDMA_MAX_WR_CH                                  64
>> +#define HDMA_MAX_RD_CH                                  64
> 
> [Severity: High]
> This patch introduces 64-channel support for HDMA, but does this break
> when used with the Designware PCIe host driver?
> 
> Looking at drivers/pci/controller/dwc/pcie-designware.c:dw_pcie_edma_find_channels():
> 
> 	/* Sanity check the channels count if the mapping was incorrect */
> 	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
> 	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
> 		return -EINVAL;
> 

This specific function targets the channel detection for non-HDMA IPs.
This piece of code is unaffected with the changes done to support 64 R/W
channels for HDMA IP.

> And in dw_pcie_edma_irq_vector():
> 
> 	if (nr >= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
> 		return -EINVAL;
> 
> Will these sanity checks reject HDMA configurations with more than 8 channels
> because they strictly enforce the EDMA_MAX_WR_CH (8) limit?
> 

This can be enhanced and shall be taken in a separate patch series.
The existing limits, functionality will not be affected and IP
shall work fine.

> [Severity: High]
> Does the standalone PCIe eDMA driver statically limit the hardware to
> 8 channels?
> 
> Looking at drivers/dma/dw-edma/dw-edma-pcie.c:
> 
> static const struct dw_edma_pcie_data xilinx_mdb_data = {
> ...
> 	.wr_ch_cnt			= 8,
> 	.rd_ch_cnt			= 8,
> };
> 
> And later in dw_edma_pcie_get_xilinx_dma_data():
> 
> 	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
> 			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> 
> Doesn't the min() operation cap the dynamically detected hardware channel
> count to the static limit of 8, negating the new 64-channel HDMA support
> on Xilinx MDB controllers?

For the Xilinx DMA, the limit is 8 Read / 8 Write channels only.
Enhancing the structs / arrays for 64 channels will not affect this
piece of code.

> 
> [Severity: Critical]
> This is a pre-existing issue, but is there a missing register offset when
> setting the eDMA/HDMA base register pointer?
> 
> In drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe():
> 
> 	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
> 	if (!chip->reg_base)
> 		return -ENOMEM;
> 
> Should this map the whole PCIe BAR but also add vsec_data->rg.off to
> chip->reg_base? Because all register accesses via __dw_regs(dw) directly
> dereference chip->reg_base, will all reads and writes hit the beginning
> of the BAR instead of the actual hardware registers on hardware where
> rg.off is non-zero?

This issue shall be taken in a separate patch series.

> 
> [Severity: High]
> This is a pre-existing issue, but are the arguments to GET_CH_32
> swapped here?
> 
> In drivers/dma/dw-edma/dw-hdma-v0-core.c:dw_hdma_v0_core_ch_status():
> 
> static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> {
> 	struct dw_edma *dw = chan->dw;
> 	u32 tmp;
> 
> 	tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
> 			GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> 
> The GET_CH_32(dw, dir, ch, name) macro expects the direction as the second
> argument and the channel ID as the third. Here it is invoked with
> chan->id as the direction and chan->dir as the channel ID.
> 
> Since chan->id is evaluated as the direction, won't any channel ID > 0 be
> treated as a READ direction? And won't chan->dir restrict the accessed
> channel index to 0 or 1, meaning it will always read the status of channel
> 0 or 1 instead of the intended channel?
> 

This issue is being fixed as part of this patch series
https://lore.kernel.org/all/20260710080903.2392888-2-den@valinux.co.jp/


