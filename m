Return-Path: <dmaengine+bounces-11749-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rlg+OkFuOmqN8wcAu9opvQ
	(envelope-from <dmaengine+bounces-11749-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:30:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F16B6B93
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:30:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="UQU/Nz8V";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11749-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11749-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31C8630A0134
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 11:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CD13D45F7;
	Tue, 23 Jun 2026 11:29:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327023D47A1;
	Tue, 23 Jun 2026 11:29:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214145; cv=fail; b=pHwLiwIonLZ5AR+3Hp52QHjssxDzmMiL/2OK1P5iXu25miEVg1O8KDcWSS5m0RXf4xVfznbdL+qw4AEpkZtRvSlZ2mcCnDyvCw1fI3Xc2AGN9QXX2Ln+jomTzjMON4e2OYSwscn9FcC0ehvuHtCdMuqWigk80WckTiqB2X35Bkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214145; c=relaxed/simple;
	bh=51aSU0e1K1Mi2edKHYUntmJH1uQpfsSyD/FL7lhRDfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pmUn0skFmGcj7ecY5dwKxsryvefge3JRN6aeEuwPRUJFABRPCqtTHcqPhkU5DLlmhd/F97eTfADOf1iXxVcQBRzRe1JdrPTQNVck964y7C2kY1c/KTPz4u9o1mLrf972S+azyperjG30tCDgzZrh2vI519KBhgC4Evr+oJ9zgtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UQU/Nz8V; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKhfmRd1MwePHFzsFyOVfKSuzYNhxWjYkmjzi3DBagEGSvhi8ZLRI+St0CGwuosKCqr75AdMEON6A0ZS8xqUo8+iFeCr//fHouk4yNqmhIuLfbxeU7AEnDwK2h3P8d3tVyAw6SzdjK5S+awIM67AVOBHlYhM/A6PhH4Xz5SA5Lxyk08bm1mCZoHL2nhz+y1AIydYQMA76piUnKlKfS+ZrZ6a3g3qL8Zc3DMIdqXOr+SO2wx6atGnOe33Nb/rL9HJNR2+XiA+265Iikd4UwIox22uVQ9zFfraessBWZVth1oPXynQ67bP1Ic+YwHRIKMJHmKilffWbGUyTkWN+WJU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggz5cO8BkEwXhATm52cESLCWglqlUMkGlC5RLd4DyD0=;
 b=CgTCDDOXy3KjxMvYvNarrnEFA5Eu8fAvpw9cYfw/qUIrOohOgfAnKx5vG2bT7nIWTKHX+m3tRFNmbov+yWM9kTC8RDbxhf4y+WiIG0q9WI8oufkYJRVTFfsxQniyjd1Xhyf02LHNuK53FDxjIkeCU0ZVfTNG6MZ6EVg19jdvjV2TTChTKVrZ6xyjaavVS4X3L6UEcin6yROKBCYeMsp7ikfETQjQExZE5OOUGV1B2a+B2wWaH28pKk2hDbfebSoyVSDRZiVfESVcK3ZgzYKW4aCVGInq4pVc9qRyBnobB+yA7cIO4i1fgWGnuaHF9RH+z1ElW2w4cYYDy8YqLw+QlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggz5cO8BkEwXhATm52cESLCWglqlUMkGlC5RLd4DyD0=;
 b=UQU/Nz8VX1VTtjsOb9yoYFd4WoROiZs3OuLWaxwJeAzrQB7Kic2rdkjJ+j4kDacUVKSOsvcEHdK4hixABbebwNwr37gXfpVNOrNrZiGKhlgrNjdjR36nMw4k1LUbiuibakJfnqKsF4JC6YiNq8EQwiOXEm6pd0N+u2+wzq+fdMU=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:28:57 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 11:28:57 +0000
Message-ID: <095b8734-d599-46eb-be59-98107e73404f@amd.com>
Date: Tue, 23 Jun 2026 16:58:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: Devendra K Verma <devendra.verma@amd.com>, bhelgaas@google.com,
 mani@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 michal.simek@amd.com
References: <20260623112308.3377168-1-devendra.verma@amd.com>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <20260623112308.3377168-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::8) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 251b0cbf-373c-4b3e-fc5f-08ded11a9d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	4j2u7hIqg2j2xS/iM7smT7DQ/vwrpSvMJYx+2oQuEeT2ZriCetZkxZDVQGtZ0WnqOW56pFsGFbU4gyfmyip1b3EmSaKQoaeUYKWNWhTNvwnT8reZmNrVIVgPi4Pr6UzSW3KdxbBVs/h7Q/8v/k9lPRK8z2p83CPnVyQ4l3DU+/9NDcUi/28rMZGCueC/oJXQbWl8Jofgqa44RtXuGqx6At/eIKuhGe97zoR5zG2vO9rhVOBrepTPqiBV18LqulL4khx9wR2uQv2zLk9/gxccwY7Ru+LsoWbOpS9Xd/jp5KKUDGEI5L9gxZfiPTRqRveWFC1hSzABcOyra13cFP4uVOl39cBj/myn/v0OBAvhlOc4c7CBqcJlUKonEwEcol8uBFJguD0vEjzAahQgwmtupWQi0EA/f0nB3dMiOhCVjMDl22gOUk/slQ6Bl95SWVZmZ40MHCTv/uEGS3JMHb2juzxlWOceB5OIVZQa7rznsHuVOk/pm3aC0YSofuj0OUR9Q93o7jiKJh5GA3dbeIa5gmJbFxP0Ix6WxdXzEJxefYkgOxBUB9SgwIhUvVP0/D9QsihmuSNPYOFC9hb6zEcHkRfA0KI543I7J7OoooJ7fIsG4PhizU88CH5ALNDbVXvJCoTAIOXbC1wtDhW6QOtRE7TUuvIkwfrBxh+Ho+VyDlY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTJoTEZOcWdpN2h4SkprY1EvVFg2a2dueWFYTXJRWW1LdURVUWpnSmR0UXlY?=
 =?utf-8?B?NXQ5UlljT3NndHFzaWx5SjRGVjJxN09INFVaMHQxNzdqTVVQby9sZ3ozalZu?=
 =?utf-8?B?djc2aWpvVkVEN1pVSXkrU1hmYlVhQTNWeWRhdnNLK1JRdDR2K0FpaVlUcGx5?=
 =?utf-8?B?b1hYUGw5TjV3V3FUTWRheUFUazFXdTZmMS9ZelMrdE9VY2pJSGJYY3VYR0k4?=
 =?utf-8?B?alprT3hhUElDelhycU5TMGh6N3lQQi9wdGtCdWF3eGFzejZnM3M4cUJpcW10?=
 =?utf-8?B?dG5MdDkwUVBCTWd6OEVUVUR3bnRqOG1FVE16WFhZNHQ0c3hrZWZVY0h4c2E2?=
 =?utf-8?B?czMySFQrTUtEc0pSdzRZYUgrU1J2Z3phdXNUTWl2R2I4VTN6Q1YwQzZrODdP?=
 =?utf-8?B?dGozK1pMTEFnUTYxVzl1cXlBM2hyMmlnM2FKMFRpZm94WFpvbnB6Z2VkTzNr?=
 =?utf-8?B?S2laTEN3czlXZHZrRDNka3NxK2NqRjN4R3dGalRUd2FNRzU3RzNoeTdYb3JP?=
 =?utf-8?B?Zm8vamw3MHZyTTBjZFB1dndXSEh1SHMyejh5R0w0NnpibDAya2dGbWZSTzIr?=
 =?utf-8?B?SW1uNEVUbE54Z3E1TVlVVFU3KzRLcjIvN3NjOUh5TWNUWFN4VXhiWXprdFQx?=
 =?utf-8?B?QVU5S2o5L25iNC9MM2hwcUF2NUtIcWNseEpvUmYxK0gvLzZkcE5ucElhbGR1?=
 =?utf-8?B?TkNtd3AxL3Z1UzlVTVdGLy9IamJ1TzUwdEVZNWkzNWZYSWNqQ2NGeFJsL2Fy?=
 =?utf-8?B?aWJZY3ozMW5CSmoza2pkcytJNGxYUkl4SkdGNnJEeFhYbjdTWjJyNDRmVFBB?=
 =?utf-8?B?SGVVeHYvM3JwQTJrUERxdjliejlreDhwM21UNlNOaWlpczQyaWV5blJ1aWFD?=
 =?utf-8?B?VTdHeWhKU2pDbHB3KzUzODRhQlNYRnBqdzk0aWN4Yzh5cFNlWmZYYXdkdHF6?=
 =?utf-8?B?T3N3em5hZDcrUXd4WVRGMm1YaVRMOUJodm1vQXRNa0hQVStMOU9EQ2gzRFM4?=
 =?utf-8?B?QUtGTkdGaGJoZXQxV2RlY29YenRKV1pIeHJ0bllrWTVhTEtIWlJjaHNsbThC?=
 =?utf-8?B?aVdzU3dTTFlKSE9WaVVDMnk1a1dCL1g2T1RIZ2pZNmFZZDNlNEJKRG5laWgx?=
 =?utf-8?B?U1REZGcwd3dieWhoakJFOWRPL2lWTCs5Z3BYS2YvWTVsc0o2L1BOUVlFcUV2?=
 =?utf-8?B?TnlCTXJkN3NiM2RuZ05TcU5obHltbEVnRmdTdHU2Q2ljeVlodC9xeFEyQ2Jt?=
 =?utf-8?B?alViYnZjOWRIdUludFo0eFlwcS9YL3g4RmxmRmlEMHRCNGhNcXBsSitYb0g2?=
 =?utf-8?B?M3ZFZzN0N3RKeko4MXBCbGUzV2ROTUNwNk5NZDk4WktLUTRpRkZaSUhVQS9X?=
 =?utf-8?B?TnZwSWczMGVybmF6MzBMWEtmbzJvTzJlUWNTalZBZXdUQnV2dEJycDE5eG9n?=
 =?utf-8?B?TmhBbndpdmFOM0JYaDdSeXV3R3V1cFRRYjByTEo3d1dzakFleWh4dml3b04z?=
 =?utf-8?B?aHduanIrcy9PWGRRY3FlNUV0WE1UVVpkaloxaVZ2d2FhbzBnWVczTFdVdGV6?=
 =?utf-8?B?U2hySGhNN0x4OG4zcTloVDUwa2tXRENZeUZwQktYWVhiTVlrL2QyM2FNK3h6?=
 =?utf-8?B?WDBZTDZsSUxhVE9jOWJUSDQyejFqenZBdWQxTE5qVHRWR0pvNzVvR3NRWTRM?=
 =?utf-8?B?ek5FOHQrUG1OM2hDdks0V1NSQXMrL1ZoS1VmRFI0Yk05V05ZNjJXT1UyN3Fi?=
 =?utf-8?B?V2hOMDRibjhJMlc2MERENkVQZXFCU3AxK2dPZWs4eHpGRklFa1ZnSnlycFA0?=
 =?utf-8?B?cEl6Q1VCVlg0d25MNCt3M1JVdUk2cEZaNy84VS9IdXFnYkhWNm5PNzhIeWxl?=
 =?utf-8?B?QldHZVRVK2JQZTAvMEJUMyt1Mk5vWk9Qb1VZYUZFakZDRlZyMnVZbmtZcVdM?=
 =?utf-8?B?eXhEdzhpZ1NBTi9aYXRVY0hSSWVOTFhxNmwvWlV3RXQ2SGZENExGUU5ZOWlM?=
 =?utf-8?B?Z1lHR3p2Rit1VFl0UmFrYVNwTlArWS9TRlVpeTg5V0J5Q1Q1VTI5d2tjcHk5?=
 =?utf-8?B?bUFWdko3ZEg0STIwZHlZS1daYjhjakl5ZFVncE5zOGN3akMvUE9vdUZxMVds?=
 =?utf-8?B?Z2NOQXRhZ0F6am5xc3dnUTF3bVkzK014NTVDeExaaUlsVWF4Y29FSXVnd2hr?=
 =?utf-8?B?OHorMWM4V29YcDhQR0QzTDVKcEhnRFh5NDJSUlNQcTAvWURKd0Rmd3J1cC9a?=
 =?utf-8?B?TEIzL2RGdlRnMDkxWG5ZaURtelVNZ2J6cktLUjlqLzRxTlluTjJXWFpuNHJo?=
 =?utf-8?B?WndDTHByN2JiSThJMGVQOGw0amVubm5DeFFRMWlGZ3dHMWxscHRUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251b0cbf-373c-4b3e-fc5f-08ded11a9d66
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:28:57.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ciyeXZsBNDtZUKVY4fPfjVBjGK5WB1gX2qraIYKYtEoy2eZNfofilO9GB6f0yJNECWjqFdeENmSpbn0IqFKtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11749-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 544F16B6B93

Please ignore this resend. Details related to version change
got missed.

regards,
Devendra

On 23-Jun-26 16:53, Devendra K Verma wrote:
> As per 'Designware Cores PCI Express Controller Databook',
> Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
> channels. Current controller driver supports up to 8 read and
> write channels only. In order to utilize all the channels the
> controller driver need to have the channel related structs
> and variables as per the number of channels supported by IP.
> Following changes are made to enable 64 Read / 64 Write
> channel support:
> 
>   o Defined HDMA specific macros to reflect the channel count.
>   o The count of ll_regions and dt_regions in dw_edma_chip and
>     dw_edma_pcie_data shall be in accordance to number of read
>     and write channels.
>   o In dw_edma_probe() configure the channels as per the channels
>     of the IP used.
>   o Changed mask types to u64 for higher channel counts.
> 
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
>   drivers/dma/dw-edma/dw-edma-core.c    | 19 ++++++++++-----
>   drivers/dma/dw-edma/dw-edma-core.h    |  4 ++--
>   drivers/dma/dw-edma/dw-edma-pcie.c    |  8 +++----
>   drivers/dma/dw-edma/dw-hdma-v0-core.c | 33 ++++++++++++++++++++-------
>   drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
>   include/linux/dma/edma.h              | 10 ++++----
>   6 files changed, 51 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2feb3adc79f..adf1b3939f96 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>   		irq = &dw->irq[pos];
>   
>   		if (chan->dir == EDMA_DIR_WRITE)
> -			irq->wr_mask |= BIT(chan->id);
> +			irq->wr_mask |= BIT_ULL(chan->id);
>   		else
> -			irq->rd_mask |= BIT(chan->id);
> +			irq->rd_mask |= BIT_ULL(chan->id);
>   
>   		irq->dw = dw;
>   		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
> @@ -1079,6 +1079,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>   	struct dw_edma *dw;
>   	u32 wr_alloc = 0;
>   	u32 rd_alloc = 0;
> +	u16 max_wr_cnt;
> +	u16 max_rd_cnt;
>   	int i, err;
>   
>   	if (!chip)
> @@ -1094,20 +1096,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>   
>   	dw->chip = chip;
>   
> -	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
>   		dw_hdma_v0_core_register(dw);
> -	else
> +		max_wr_cnt = HDMA_MAX_WR_CH;
> +		max_rd_cnt = HDMA_MAX_RD_CH;
> +	} else {
>   		dw_edma_v0_core_register(dw);
> +		max_wr_cnt = EDMA_MAX_WR_CH;
> +		max_rd_cnt = EDMA_MAX_RD_CH;
> +	}
>   
>   	raw_spin_lock_init(&dw->lock);
>   
>   	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
>   			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> +	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, max_wr_cnt);
>   
>   	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
>   			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> +	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, max_rd_cnt);
>   
>   	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
>   		return -EINVAL;
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 902574b1ba86..d12fefbf3952 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -91,8 +91,8 @@ struct dw_edma_chan {
>   
>   struct dw_edma_irq {
>   	struct msi_msg                  msi;
> -	u32				wr_mask;
> -	u32				rd_mask;
> +	u64				wr_mask;
> +	u64				rd_mask;
>   	struct dw_edma			*dw;
>   };
>   
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 0b30ce138503..79f653da8e0f 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -61,11 +61,11 @@ struct dw_edma_pcie_data {
>   	/* eDMA registers location */
>   	struct dw_edma_block		rg;
>   	/* eDMA memory linked list location */
> -	struct dw_edma_block		ll_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_block		ll_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_block		ll_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_block		ll_rd[HDMA_MAX_RD_CH];
>   	/* eDMA memory data location */
> -	struct dw_edma_block		dt_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_block		dt_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_block		dt_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_block		dt_rd[HDMA_MAX_RD_CH];
>   	/* Other */
>   	enum dw_edma_map_format		mf;
>   	u8				irqs;
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 632abb8b481c..84b0076f78bf 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -53,13 +53,24 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>   static void dw_hdma_v0_core_off(struct dw_edma *dw)
>   {
>   	int id;
> +	enum dw_edma_dir dir;
> +
> +	dir = EDMA_DIR_WRITE;
> +	for (id = 0; id < dw->wr_ch_cnt; id++) {
> +		SET_CH_32(dw, dir, id, int_setup,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, int_clear,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, ch_en, 0);
> +	}
>   
> -	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> -		SET_BOTH_CH_32(dw, id, int_setup,
> -			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> -		SET_BOTH_CH_32(dw, id, int_clear,
> -			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> -		SET_BOTH_CH_32(dw, id, ch_en, 0);
> +	dir = EDMA_DIR_READ;
> +	for (id = 0; id < dw->rd_ch_cnt; id++) {
> +		SET_CH_32(dw, dir, id, int_setup,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, int_clear,
> +			  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +		SET_CH_32(dw, dir, id, ch_en, 0);
>   	}
>   }
>   
> @@ -118,7 +129,8 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>   	unsigned long total, pos, val;
>   	irqreturn_t ret = IRQ_NONE;
>   	struct dw_edma_chan *chan;
> -	unsigned long off, mask;
> +	unsigned long off;
> +	u64 mask;
>   
>   	if (dir == EDMA_DIR_WRITE) {
>   		total = dw->wr_ch_cnt;
> @@ -130,7 +142,11 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>   		mask = dw_irq->rd_mask;
>   	}
>   
> -	for_each_set_bit(pos, &mask, total) {
> +	while (mask) {
> +		pos = __ffs64(mask);
> +		if (pos >= total)
> +			break;
> +
>   		chan = &dw->chan[pos + off];
>   
>   		val = dw_hdma_v0_core_status_int(chan);
> @@ -147,6 +163,7 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>   
>   			ret = IRQ_HANDLED;
>   		}
> +		mask &= mask - 1;
>   	}
>   
>   	return ret;
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index 7759ba9b4850..48e40efceb2e 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -11,7 +11,7 @@
>   
>   #include <linux/dmaengine.h>
>   
> -#define HDMA_V0_MAX_NR_CH			8
> +#define HDMA_V0_MAX_NR_CH			64
>   #define HDMA_V0_CH_EN				BIT(0)
>   #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>   #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e315..da7a5cc93ad4 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -14,6 +14,8 @@
>   
>   #define EDMA_MAX_WR_CH                                  8
>   #define EDMA_MAX_RD_CH                                  8
> +#define HDMA_MAX_WR_CH                                  64
> +#define HDMA_MAX_RD_CH                                  64
>   
>   struct dw_edma;
>   
> @@ -89,12 +91,12 @@ struct dw_edma_chip {
>   	u16			ll_wr_cnt;
>   	u16			ll_rd_cnt;
>   	/* link list address */
> -	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_region	ll_region_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_region	ll_region_rd[HDMA_MAX_RD_CH];
>   
>   	/* data region */
> -	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_region	dt_region_wr[HDMA_MAX_WR_CH];
> +	struct dw_edma_region	dt_region_rd[HDMA_MAX_RD_CH];
>   
>   	/* interrupt emulation */
>   	int			db_irq;


