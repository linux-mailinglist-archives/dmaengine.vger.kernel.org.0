Return-Path: <dmaengine+bounces-12052-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R7upKuy2S2pUZAEAu9opvQ
	(envelope-from <dmaengine+bounces-12052-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 16:08:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFB1711BEF
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 16:08:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=mNR4nun+;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12052-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12052-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDDDC3066A27
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 12:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FDF3CF952;
	Mon,  6 Jul 2026 12:33:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E195A3EFFC9
	for <dmaengine@vger.kernel.org>; Mon,  6 Jul 2026 12:33:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341201; cv=fail; b=DTNCmAbeAByfdCoMk7JBF782VieKSIAamk6XWE7g0BWx+9kk2V3179OvEaXt8YYTKWvPT+p1b2n5aKQHr0doSRqdSZ8/HEhB5mBT2mc7Hs2E3P56FoD3LeVDWSN63fT8sHRqUpY0GBAvvEg/HVDJJ8xPLkooSpm900+EzMYRTvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341201; c=relaxed/simple;
	bh=rfmcPgyYXH346bZqn8ce+1fMjOP7w4Tpc7TGMBCw5CE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SNy5yJ7jtfAd6OOmu9NdV5JEVupVxNz2RKrcNVfvLNGODCg3TTb8giuT+yh1gm6YSQu+ymwP8YKPeaS7hFNl+isNQ0NrFZgOIqhKPpFAGRBuDAj5Cm6G3mUCeLoNxBb1/HfrPDDAERFF0IPCw0fjsOkGDSpytYkkpe26G7WsK4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mNR4nun+; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QppB/xR7c24YHamh3IuzseEBUox4ZfA10bPrxlyy3T3ueZfb1zRtwfs6S7SP6baWZ0vK7YavOBiXSg2hpAk9fxthFv90Qlc7IZfLXzb3M/QODzHU5ipd3CNIXqogkSNn0SbbrLO5dbxJ+CFyqshRCwGPetA4eiFxbcehjJFF8PDtQrppvjNbgdP00ObcaWDxsQI9hYmSdMSSu54lqMY8j/EhZ3uEB9r86KySsnVeIiyp4h+LYS9/UYCUP3X4mg2Zjk+LvVfRG9Ft0zMQ2/Dap8IzzvrH+gkXokyOBKTCDqf/JpNB78vIE6SNosJrgjEV2vkHXOjg35jxP3aTksGAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDjWf/rh8JZxmn8TdBu+QRJ0cqynXFVQhb3vroFFvzo=;
 b=LOOr4pI4gmY6mSP8Wc1/ctihKnPsSDBxE4GaYmGOBtn/9OgXNQbhYbrU6e0Kty+3VieHskg/9EVQNEnYUKjvYpQ5StGkuIfSCGNqE8itimvnvH6reCvs8jfbuZ+Q0g3vWa/RChlUlmJNG6zm98lM9BtKo5SWtMggkqS2WinBQAFKV0KVrN0qWKUxyy8tsdEJcTWVucmmmHLomDSU1ew7bcoiWaT+hB46bmCbRHab0I7Mw0WctO3nDLj0pWtCIm9sRZLDykRLnOON3CCi8XrbOsGHIxPGv6kmX+QAQd5gS0tN/aw/N/rRhowN0PhIG+Gi4p2x5rAEjSxqe8kpMgUQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDjWf/rh8JZxmn8TdBu+QRJ0cqynXFVQhb3vroFFvzo=;
 b=mNR4nun+2pE8ciuFAaY40h9qS08yujlmavN3CrTpmLMjN5LP6uw8rry5OjIXRsN3HfqhFtYBpaJvWWF4SAAjVsqLor2f4e5cYXfIAVQLZ7hcTDaaBovfm0ZS1875ISNNzA7gEhchmQ5DqPCUodfaEbwFe+hWTTWrfgJ2ZaGKlM4=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:33:16 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 12:33:16 +0000
Message-ID: <539fab55-4c78-4aab-a4c0-c847112693bd@amd.com>
Date: Mon, 6 Jul 2026 18:03:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dmaengine: dw-edma: Enable HDMA 64R/W Channels
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.li@oss.nxp.com>
Cc: sashiko-reviews@lists.linux.dev, Devendra K Verma
 <devendra.verma@amd.com>, Frank.Li@kernel.org, dmaengine@vger.kernel.org
References: <20260626132151.1875965-1-devendra.verma@amd.com>
 <20260626134641.87D161F000E9@smtp.kernel.org>
 <3ac6b44c-febb-4c20-a737-aba34de5c208@amd.com> <aj6iIr61LI9Sm10h@SMW015318>
 <akTT639rZ712TZ5t@vaman>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <akTT639rZ712TZ5t@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::19) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9dc7b2-2b72-42b8-c76c-08dedb5ac104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HIOC71GM+lSn/uFCGngUqH7UhY1/0YCM/TOq+s6TvS+uMFvEY22Orzxlx2wnkXkg8S2gfPjaCkjoelzY+rEoTt36d2Y2jgqF2tSo/MqLNtLQ6vKEZrb4uyo0ClLhLMC3pRvJh+AsTR3eqnSaJ1ZSpLJgkH16xXY5vya4B14PUzUGm+qDPlX4PoL+/bGYjaGKXZBQi/0hSGV4fRBhUDvibMGsfAWMr5HcT1l+bco+r3RcXuAV4EjCF8eP0QAmqXkQRGLgiuvN5SP3089Vxp2HNxYHDXfSJd9xO0MBL8Liw0ojzpPhpxk1WYlgj0Fx/tezJC7Mrlq6kwX2wNZLOXkhsWBTqFq4ZZFHjrmzqzGjSVlrUhNzYsApHZS1jmoVyBTIJcALwvU9um7Jlh6vN5jlRVOE7gmr9auG3pXQpVc4aN+gCHIvciiah8S5HWfv/uzIMvCO0H+OHOq+uvqzJAsBFkCcsAgSUJZeE43ymPcEmIA9LfJvTFUpgEMtrGu1YwHI2pIEQ3sEVrjr7E8CcOEKmZQAl2n0+bf6+9hHIng20ih5ufOLDVTwNPTAbqErcV7/0aU6nTW5ZHbrh+oqaI8Pb7LY6Ero7uAAZSl35I99ixL2iOzAibd3HxXpl3IVnRNhRp7gA+ZwIOHRlIPEvbx/z1TD2SDlCYG5lCh07P4argI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2UvcGhXUml6Z0dHbGZGTldGTStPZm1rUVM2cnZ0N2dXZEw3cHM4MklnZVNV?=
 =?utf-8?B?a0JjYk41YzRPdFVYbDVWeFBoWStHVjNQQStKcEYvbyt0WS8zdUY1LzVIZ2Nk?=
 =?utf-8?B?M2M4NG9CVFJwdURhUXgzOXVId1BJbHNwbDFqTGIvN2V3OXY4WmFTZVQ0MGg0?=
 =?utf-8?B?S2ZtRzBQTkhhb1NZL1NMQStWNHMzSDJ2aUpYVkVGWGgrY0ZJRXd6aW5rODFl?=
 =?utf-8?B?NU00bmlQVmh1Yk8zdVR3ckErc01GL3FqcXFjanVzRFFHK0ZWblBuY01UNDB5?=
 =?utf-8?B?WWgrdnNOcjlSQTlKQWgxeWN0d0JhaEJBaXBXRmNHSXUvbkdUVmQ3NlhxV2RO?=
 =?utf-8?B?SjVrQVpkYzlYdGF6dGRhclRPaUkzdUc1cDRPUEwyaDZpUi9HcHRkZFdLOTNx?=
 =?utf-8?B?K1FzMG14OHVEYVJ4VHlBcVVwcVRIRzZRazVkYTMvMTg5WStDYUJCZTczeGwz?=
 =?utf-8?B?bWxwdlVaZ2lDaXI4LzRoNCtoRGNsNXgyQ21Yd0QxR2JPOHRtVWxnN25mMzdE?=
 =?utf-8?B?dzN5WWRhcnNLZnJWaDBnR0NGcVZya1BNbzI2Q04vc1RBYmRnZlVCNTlEbHdn?=
 =?utf-8?B?SkI3T1dwSU9MUnh4QU1YdmZWdTBtZXdkNVU4UytBaThONlNFSVZvMkVGaVBS?=
 =?utf-8?B?SUd0ckZJQnc4VzFaQXNmWXo1MWZhcHNzRjRXbHd3ZWNpUVRJMnNib3JZeTFD?=
 =?utf-8?B?am5XQlVvdVpZUVQxTVNDQm4vNnZvcHJzanRZM3dmUGVuS3hjQkFhTFFVZEtu?=
 =?utf-8?B?UmI4dlRVNjU2Q0NyVXhxNWQwdHdad2hCWWNVa1BZMk96a2wyWEVqcEdKb2t3?=
 =?utf-8?B?a0FzSVpiTkhXV2NKS2ExM3UzYlIyR2JHZDVhT1BZRmR3NjhhTUlsQU9EN0N3?=
 =?utf-8?B?R0xqelhsMUQvbHNpMURJNzBtbkM4NGVDd2FiR3UyTUJ0VWJxTzRNOW1pTnhE?=
 =?utf-8?B?Mmw2YXFUZi8xSHNjajhsMXA3OFo4ZlAxS0JvbmxxUWdPdmh5dGJVTE1JUjU4?=
 =?utf-8?B?WHU2NWhxVVF2RE5rTktnT2g3czJqdjc2ZWtpZFBncFlKV3dZaEYrUlVOc0pL?=
 =?utf-8?B?OHp1MG92MldOa2FEWUFqQnpQcC9uQ2o3STdiM2RUa0tOKzBxSUttN0swRERq?=
 =?utf-8?B?VkpRbS9rRjRiT2FhVVNnNGtFY1EzWTRobVBWdHp1WlY5bFZTR3hIbnRLZ0Uz?=
 =?utf-8?B?OXFnRzl6VDdOYVl5bGR0TjdzT3Vtczk5OWRKOGk4dU1lRjBUNFRwTlhnbGhy?=
 =?utf-8?B?cEdhd0tuQitScktOb2Z2bnAxKzVrUXFzOTVBRkFMeXRSRlpGYXQyRkNoRWN2?=
 =?utf-8?B?NXdaNWFqL1l2OG1yZ1B6ejJsZEJzZlczWWRUa0xhSFMzVGFERStuRzdaU3Ra?=
 =?utf-8?B?R2pHK2ZiVGRQRWNrc1FtM0paUUMyZW1icE8yYjM0aTlwR3JiSUJuMEZBdVFm?=
 =?utf-8?B?cm0wUnFMYmhqNkphdXJabDNDS0dHdHhmazZuaDdKNEt2ZVFRTkhKbWpiZnA0?=
 =?utf-8?B?Ylk5dXZSUzhuZ1lWam1MUSszYjJNVEpGYWNJNTZ4NWlRWUhNT2ZlM3czazk2?=
 =?utf-8?B?R01zeDJ0M2NMSjlVV2E3S3Q0ZjVUdVBkQmFlVmhSRzVtT2o5aTNsTXZUS3Fi?=
 =?utf-8?B?SXVWb2F5UUJwSkJWSmRQQkI4Mk5VN29sQTVkSDdHN1NxcVhqUFRtbWdJNU5o?=
 =?utf-8?B?ZGtYVUxCRFJtM3p1azlFNWs5dVVCY1ptL0o4cFppbGtqSTYzTlI2RkNTOE8y?=
 =?utf-8?B?ODQ5MDRHWEh4T0NQaWVJL0Vuc1JDUXVFR3dIelVjRmV5b0IwQmRwa2Z3U09G?=
 =?utf-8?B?M1FQRnlqREgvNVpPYTRUdGVQZWxXOVp6OEMrUFBkeW5WRE9VRm51amVNT2t2?=
 =?utf-8?B?ZG9TRnVyNXBDOGhtNHJvN2k0ZExoN0x5T2ZqRnBLK29kT3d3MmZWZ0xidTBx?=
 =?utf-8?B?NkRtUVBNUkJZVjV2QW1iSGU4ZjVQZUZsMlRlNUpIZy9TL3lpS3JHbi9ENXZM?=
 =?utf-8?B?U0ZsRVJNcFFUUk9nNDFoNlI0MVYzQ29SS3RHSTBNdlJZWGxuUG5RdmpCY2Vz?=
 =?utf-8?B?Zmt1ZUhTZ0o4TXpMSTFKWEN5cll0Mm9yeEFBVHRaYTBCME1sNDAzd0JmL0tK?=
 =?utf-8?B?Sk5rSHhGTHZ6L3EyRjd0N2ZVRW9IODNEeHliNEZRSmY5cjI1ZFhwRDEyTHdk?=
 =?utf-8?B?UDRpSTJuRVRleXBKV2RBWlo5c1J4am50NHhxbXJsMXNsdkpkUXdVMnVuWXZn?=
 =?utf-8?B?dlpnTnp6TnllaWh4QkMvSEMrMktzSkZYTWJjcXdOQ0k4cXA2T1V5WGJFWk5v?=
 =?utf-8?B?OEdkcmEyNDJvbjU5bXhNTVR6ZWEzYWV0VEdtSGQ1Nkh0NnBxRGNudz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9dc7b2-2b72-42b8-c76c-08dedb5ac104
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:33:16.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewzXFiMnLsPSUy9tzVixmdw8zjSU/MioIWUAQptJPsTyM8YPLZvcCUwmG8O51WdRVzvIv4cO0+E0/VYuuVtHlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12052-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,amd.com:server fail,sea.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.li@oss.nxp.com,m:sashiko-reviews@lists.linux.dev,m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devverma@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:from_mime,amd.com:dkim,amd.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BFB1711BEF



On 01-Jul-26 14:16, Vinod Koul wrote:
> On 26-06-26, 11:00, Frank Li wrote:
>> On Fri, Jun 26, 2026 at 08:56:35PM +0530, Verma, Devendra wrote:
>>> Hi Frank, Vinod
>>>
>>> Do you have any suggestion about handling of the repeated comments from
>>> AI?
>>> On every version of this patch the similar issues have been raised and
>>> I am replying with the same answers as many version-times.
>>> Please suggest so that multiple replies to the same queries by AI bot
>>> can be managed.
>>
>> You can omit pre-existing. Only reply once when patch close to land. I hope
>> there are tool, which can help identified comments and pull your previous
>> reply.
> 
> Right, fixing preexisting is indeed optional but since it may impact your device,
> we are looking forward to fixes on these from you. More important for us
> is not adding new issues.
> 
>> On method may help:
>>
>> After I provided review-by, you can reply you already checked AI's results,
>> so It help vnod offload his checking work.
> 
> Thanks this helps a lot.
> 
>> AI is quite new for us. we are looking for efficent flow to handle it.
> 
> Just like any other tool, it is tool which helps us. People should also
> run the locally as well.
> 

Thank you Vinod and Frank for your suggestion!
The intention to ask was not to complain but to stop flood every version
with the similar issue and comment on top of it.
Your replies helped in understanding the process and thus will take this 
suggestion and apply it for future reviews.
Thank you once again!

-Devendra

