Return-Path: <dmaengine+bounces-12462-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oOofEuXoVWopvgAAu9opvQ
	(envelope-from <dmaengine+bounces-12462-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:44:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD175207C
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:44:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=weidmueller.com header.s=selector2 header.b=fegOgiXb;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12462-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12462-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=weidmueller.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 471573008261
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB0F3B8922;
	Tue, 14 Jul 2026 07:44:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90103D7D83;
	Tue, 14 Jul 2026 07:44:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015074; cv=fail; b=SLxvk6LwCYwQmIx38fuKulgyGbqF9dV4W1htInnA+xpGcbZoeSlBr9BXLljc7HS4va+X9WOsYzjywHvH8sIyxxHhVrqn6jbusQqoXbM7TPQ7aZa6wGmMKlqie1iufuC2P7YHblunsuSwvYuioYbu+kKlo5co/gXiid/NXxJK1zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015074; c=relaxed/simple;
	bh=Zy9GL2B9LmtEySaNRopjcNiW+m7wtdqkXUdnLk8YeQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTjqhL13YT6y2/jQ9nQEw2BuYgjRi8maiCehBNZ/GmJ0/RTicW2Nav/4pN3DsyKrX5Ub18jKE5g/CIIacCYBP8KbfobpxuI+bcChTh8GsHx77f7lrto4foytXsU6qMWtxbMaBuSks4IhuHRDhWFCxHvzeZFTUGlXZEK0vmg17bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=weidmueller.com; spf=pass smtp.mailfrom=weidmueller.com; dkim=pass (2048-bit key) header.d=weidmueller.com header.i=@weidmueller.com header.b=fegOgiXb; arc=fail smtp.client-ip=40.107.130.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4eLrZf+rq/gDSEPaFfuVyi1myRLXnKDUG6Ws/om5FRJgQOcylaOttMlgzfWSfbk8QLrqcGswM1WVv3Lq6AqvsjmSL1MszaoTEUcz1GJrKjrxmVHo9DKbKH4tI3dqUHJFIMwhmvFidz0s9xpBH8yYF1T99d1BA3+HctuONvlvnwHDMl/892LXwvmRjMoQUYqQLv0LkUq7x5EaiwWcORkbgceltClt7cgo//2DrzjcgiEaSNPJixjB9ci2LfKCXR8cVGC4027VZQ13Pe3z2TLj8feAyxaOgorDSt84MGMKjJsNFXml9fNMo+HV0WLjE9/FccAmvpGUAYBQpNyw84Q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJpsacYfZM82TQNVo4oLFoQK0yfF71SVDywwlT554XQ=;
 b=CNPbIYHA0I4y2CMVeaQBt5/sKYliD/sdVMnlhMf0ngttiRlKDCrVMpLngI751iiFYmjwbln44YAIftNsnwxTQfJPfB4aRk3Ro4GWLCZSGk+XKacLOBvQkPn4+0y6IXxp8KfOudHb445IEvnXvXSKFabalM4Bj3ozefBvPfirZpa8vqXCxJ8DtbJjDQHFrlKmsHQFf9p3h4xZhnqBUQ6VceAYjP6+SsEB0bFKHnG+cx70uSiUcsCAKVXpIQu6LnRRoDmgHwGc1xjZMzIk0sYlUPeH9bmsNms0LJVd9e/Za4DCUh11sT2vVwmIsX3+TJDwqtVGVZuTIKgjF8DjKFmEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJpsacYfZM82TQNVo4oLFoQK0yfF71SVDywwlT554XQ=;
 b=fegOgiXbkh2H/PSVuwk3fvhjlnAX8XM/YwFA05I/u/EdF0Fx4Bo/yo+DOVBDWhjz1O0vfsa1bnqTEowmVev146TCc6Ti7mUWutEo5xvWDLrZy0DQrXwp84DWS9qkPPYEyeBtnEuhCmlD8lxvPqmhZWTfOxC6egNd7MsFqY6LpbW47fj7Wgg4pSl8/TJ9sXQOfTvKc/w+hL62OZvEEIJIuS0OPFUtz5K0q0tzhQqt2JoGhjdY/4EB1ABErkPjmWSzyVOR+QLYvc8SWWKNUCm7bAGPc+rDiDuRktCEIH8ObD9PPJm1S3Wex57ZnDIIg9WiZMAsnY3UcsA0WYGr7cnBlg==
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com (2603:10a6:20b:578::22)
 by PAWPR08MB9615.eurprd08.prod.outlook.com (2603:10a6:102:2ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 07:44:24 +0000
Received: from AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778]) by AS2PR08MB9199.eurprd08.prod.outlook.com
 ([fe80::5022:16e9:45e4:f778%2]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:44:24 +0000
Message-ID: <a9eec0a6-6f16-48d7-9864-0051cb8c455b@weidmueller.com>
Date: Tue, 14 Jul 2026 09:44:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
To: Dan Carpenter <error27@gmail.com>, christian.taedcke@weidmueller.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
 <ak96OkpYvJrK1Vbt@stanley.mountain>
From: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
In-Reply-To: <ak96OkpYvJrK1Vbt@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR4P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::7) To AS2PR08MB9199.eurprd08.prod.outlook.com
 (2603:10a6:20b:578::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB9199:EE_|PAWPR08MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: 31594660-f739-4a85-ec80-08dee17bb92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006|4133799003;
X-Microsoft-Antispam-Message-Info:
	Cx15UGMrKRsMSX/qmNOYySaC13BBLFcgoJb/eKVex+ImQ0FG+BTGfzFPfYZUuWoRU14S4NuK9EIVu91E4lhQz+O8pPqwszHd26DaT/JTG3uPKNGJ7r8gb20MT3UdWt2MQ71UVfFLbnlFb0zpqaRlXeUpdUSYWfvbgU4YNnj8ieFaHjVYy9Fawm/qbvmk/611zab07pAwjuiB4S9KmT8D+NTnKtvYZa3xno+2IfAtXgXFqyO06mZpZxzYHk/KpayGuaaEEKGObqhytTIWgh+Zc44w9jGQOEX0Hsd/D+7+9qaEEYmlGSYDfQN4uKc0fmIKRuvQFlonnYDRdxBrs/sjW5lU+HWqDx3hwkff7OMNtatSWQBHvCxZE3SP6QDBAGHehlyVWLBZor0eUBPxYXxqGGR34f91MTOuLH5RqtdKTKwR6Am3m7t73jUwf5Bw610f2RSBjWDGEiBaXQPlnfoPITczBjyvkSwWdUJVCjMK7jrk3f1578sTXOs5xr7qWQc+K9juavgUcm+Bpg5Q6EPNlYxKM2rnvbEzU3+qYf2RFXZ7sZXSF818ke4iyslDnHWPfKruoW5crOGssRPAjg4Go77DzvKJD2FbJHJivzB1m7zlKzhfRvSFF5CcduPY9207
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9199.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmpoSTJjT0lPaEhpYUhiRDJMVlIvaGY4Mk1jQTBZT3c4U1A0QzYzY014cUps?=
 =?utf-8?B?dnBjT2ZWRGZLSHRoWHRpelJvcElzL0YyNldFSGt2anNiUXZOUW1KcDc0MkNi?=
 =?utf-8?B?eGJIMFdSaU9ZTG1yQnViM0lFd2FhakpnN3ZNZjNNWFhUSkExWUkwWEJWN01B?=
 =?utf-8?B?YmZZZGY2T0Vhbm1IL3EzbnN0azI5M0pLMEcxU2pYSVBpZFo5V1hTV1hiMnVJ?=
 =?utf-8?B?RVJiUlFrTkxpUkFzTGt6TVVET0JiTC92amgwQjY2RzQ4VHp1YnFJZVF0NVUw?=
 =?utf-8?B?RjBKVi9pUDZ4QlhwTWxMYWdXS2hONmFPaEsxOFFqNjUvRWJQbm9PcE9pODdN?=
 =?utf-8?B?SURwWFJlTGhralpzaG5QQkN5S2JIem85d1Jya2pPeURRWkVyb1lscldYaG0v?=
 =?utf-8?B?UUJVZlp2Vk8rRTQvWkRlVjV6UkZ5M2sxaEI3OGpTY0NaTkRCYU9SYlltLzlP?=
 =?utf-8?B?M29NV1NLdlRHbEhESVdaeEwrNnpudnZJRkdtTjBZYW1MWFh6cS9kRDFJUFNE?=
 =?utf-8?B?NXhmbkg2WGs1cjRIbWtWQ2xpVWxNRmRJbHIyREg4c1ZXMjdmK013QjkzbUc4?=
 =?utf-8?B?cDR2SFkyNHhxUEMyOUltNmdZNHBZbFNxY1d5T1FRWGFIcjRNUHkzQ2NGSUls?=
 =?utf-8?B?SHJKY2V0WW9GYy9VV0dEL1I2cWJKZXpNSlpsejVHZThpd0ZmMVJuYVRwekF3?=
 =?utf-8?B?T0hSMkFOYldrWDJpMXFOQTNmU0Q5NHloQ0lxa21yOTlWMnJEL3BKSEpQM1Nz?=
 =?utf-8?B?YmNaZ3VNRkRzc2FXZnVteWNPZnFnTTMxN2lrNE5iaXBFREZPN0llR0RvSkZn?=
 =?utf-8?B?V3cxTDFIeG5ndWR4dXpBS3BkS1crVHRqbXArMjB2TU0rSm9tV0tXM3AxenZ4?=
 =?utf-8?B?YjNvdXJwMEVkVjArckx4MXlCcGYreGpiTW5NWEFnbXozeHJpNTdBOVA2TjJX?=
 =?utf-8?B?clQzUldHdlFTL2t5d05oOURmR0NtWFk5cm9BQmJ5RmJ3cGNGU3pUNW1HZ0dm?=
 =?utf-8?B?R0YxNnA1T09hQ2QyZkp5WXN1ZW1oMDZhWUlwZnc5WDZ3VTZvSGN0RnJEMTF3?=
 =?utf-8?B?dWxxSDVXWkJ0TW5GU0l3Q2p2U1JIN2QwM1FIc1BISVN2WXZPMk4ydWJ4N2xm?=
 =?utf-8?B?TDNXVlR5a1VXUXgzY0d3QVdPNmFXUy9uQmVCams4dWhTMG5kNXJtaWhuVmhh?=
 =?utf-8?B?WERaRkxmUUhXK2hkK0IyOTBieFVTVmJ3ajdwcEJ1b09PZTNEQUNkcVRxM3My?=
 =?utf-8?B?Ym9nMHp1K1h1ODJrZjg2M1MyUzlMcllLOWRBOGJIN1dKVEJyR3c1R0VBcklm?=
 =?utf-8?B?eXhYVGM1bFFUNEN3RDNRdGVpZnlGSnoyRDhaU3Y4TWcrd1VPMmdUb0lyOUNx?=
 =?utf-8?B?NHpldzZNY1gvWmxKR1hIZkpYbGhoVnJoQlAyWHBJMGh2TGUydm9iTG1MWmFk?=
 =?utf-8?B?cWpqNUtQRDdRQkpDNFVRdUZrZWY2d0xEdzBlbUdDbW0rMW1LWC9zT1BpQk5R?=
 =?utf-8?B?RmdieGJXcHNYRmdkNnZXNVcrSDNSVmlnRFZ1eHpzNnl0S2Ztd21Mck9aMklH?=
 =?utf-8?B?Nk5MOUR6UnZpbDJTWTVvYng5cTF0c2I1RmRRZHJCOHRSZWFELzBOMFdxc1pw?=
 =?utf-8?B?QmNJVEY0NDVOa3BPbituQk9RY0prZExLR2ZJVXBNNlp3bStoVzl1c2EvNFVv?=
 =?utf-8?B?RStlbG1OK1BXUUQyeUppRnJGREI5VVZZYVl6NEhJMER3Q1kzV2E4bFIrUWhP?=
 =?utf-8?B?NWxQdC93SGE3aXF3SkJxNWFWanFzM3A3blQ1c3hRcjZubkwwU0g3WDVhYlNY?=
 =?utf-8?B?R28zTzhmbzhVOWpqWGJwL3Y2TFI5MXpkWVhGc0dyY1pEUVZlZ3gzQWNMVklk?=
 =?utf-8?B?ZCt3VzFQWGVMYnVVMWV0ZnJIZWIyVHFtcDExVHFUbkRYcFJCNTNvemo1V1Fy?=
 =?utf-8?B?UmFMWGdtTGo2bGVpdWxsSEc1TFpPNUFZQ3BaTWQ2YXRqelZKbk1rM3daejln?=
 =?utf-8?B?elJMNzYvQlJkZnE3ejlwYVlCaFZVRHJxRTR6ZzJEWmk4bFp1MDhBUHJqdHY1?=
 =?utf-8?B?TWxNc2pydjNEcnk1NnVhNzIvYmNKSCt5TjFSbDMyTGZqQTVuTkhKMGZRdHIy?=
 =?utf-8?B?c3lTeW9ZU1FsbmFkVWMzaFdWRDNzVXp1UzBnQ2l2M0c4amFlMmpDdDVQOEVU?=
 =?utf-8?B?TFNqSEFpZFdDdzJlTmpwYUxtWlQ4WEl3UzVaS3lVRU5jSHdTMmZmd3Fmd0FY?=
 =?utf-8?B?L3hyRHcyMkxMOEJjcWRCSmg1MERSb0pvOERRMkRzZTN5K2pMZ0JITjMzUHFX?=
 =?utf-8?B?ZHpEQjNGK01UNXArOUJlTmp0OUNQMjhPV0JoMUR4UVhNT1VkdTZsU2k5TG5k?=
 =?utf-8?Q?5hLZW1weeG1U10FTeg2/st/pRgcKoMSTp2i9i?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31594660-f739-4a85-ec80-08dee17bb92e
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9199.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:44:24.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udXJ3lSBoLOzU9iq1ogoFaROGJTK6RWwqTYyi071j3ijZM9YsO+YLD3aQCO/3XELmCvGkmVo19ZhXwtMUVpbPIun9jY8g7uPviG7RtVmUkPhkvBZEGEcbxt1qe5l96Yl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9615
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[weidmueller.com,reject];
	R_DKIM_ALLOW(-0.20)[weidmueller.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12462-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:error27@gmail.com,m:christian.taedcke@weidmueller.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[christian.taedcke-oss@weidmueller.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,weidmueller.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[weidmueller.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.taedcke-oss@weidmueller.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCCD175207C



On 7/9/2026 12:38 PM, Dan Carpenter wrote:
> On Fri, Jul 03, 2026 at 09:56:12AM +0200, Christian Taedcke via B4 Relay wrote:
>> From: Christian Taedcke <christian.taedcke@weidmueller.com>
>>
>> When one irq is used for errors and each channel gets a dedicated irq,
>> the total number of irqs is num_channels + 1. If the error irq is not
>> the last entry in irqbuf[] but an earlier one, the loop assigning
>> per-channel irqs terminates one iteration too early and the last
>> channel is left without an irq.
>>
>> Iterate over all collected irqs instead of num_channels so the
>> error-irq skip does not shorten the effective channel count.
>>
>> Fixes: 188c6ba1dd92 ("dmaengine: nbpfaxi: Fix memory corruption in probe()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
>> ---
>> Changes in v3:
>> - Guard against out-of-bound writes to chan in case of an invalid eirq.
>> - Link to v2: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com
>>
>> Changes in v2:
>> - Advance chan only when assigning a real irq to fix out-of-bounds
>>   memory access.
>> - Remove now redundant ARRAY_SIZE(irqbuf) check.
>> - Link to v1: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com
>>
>> To: christian.taedcke-oss@weidmueller.com
>> To: Vinod Koul <vkoul@kernel.org>
>> To: Frank Li <Frank.Li@kernel.org>
>> To: Dan Carpenter <error27@gmail.com>
>> Cc: dmaengine@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  drivers/dma/nbpfaxi.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
>> index 05d7321629cc..b1f06f0bd0d5 100644
>> --- a/drivers/dma/nbpfaxi.c
>> +++ b/drivers/dma/nbpfaxi.c
>> @@ -1374,14 +1374,14 @@ static int nbpf_probe(struct platform_device *pdev)
>>  		if (irqs == num_channels + 1) {
>>  			struct nbpf_channel *chan;
>>  
>> -			for (i = 0, chan = nbpf->chan; i < num_channels;
>> -			     i++, chan++) {
>> +			for (i = 0, chan = nbpf->chan; i < irqs; i++) {
>>  				/* Skip the error IRQ */
>>  				if (irqbuf[i] == eirq)
>> -					i++;
>> -				if (i >= ARRAY_SIZE(irqbuf))
>> +					continue;
>> +				if (chan >= nbpf->chan + num_channels)
> 
> Prefer my check, but sure...

Thank you for your review, i send a new version where i try to use your preferred check.
> 
> It's pretty annoying that sashiko bot doesn't CC the CC list.

Is there anything i can do to improve this? Should i reply to the sashiko bot comments and also send this to the CC list?

> 
> regards,
> dan carpenter
> 
>>  					return -EINVAL;
>>  				chan->irq = irqbuf[i];
>> +				chan++;
>>  			}
>>  		} else {
>>  			/* 2 IRQs and more than one channel */
> 

Regards,
Christian


