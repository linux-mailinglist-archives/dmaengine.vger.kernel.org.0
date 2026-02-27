Return-Path: <dmaengine+bounces-9151-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEAhFpNpoWkUsgQAu9opvQ
	(envelope-from <dmaengine+bounces-9151-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 10:53:23 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B81611B595C
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 10:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D10183152F7F
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E230F951;
	Fri, 27 Feb 2026 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="wSWzmf0s"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022129.outbound.protection.outlook.com [52.101.126.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F02D73AD;
	Fri, 27 Feb 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185748; cv=fail; b=adLj/lxOSISg0RN3YKoahK+BP/V8TViYb7HvbS95scz365NCmonol/mpVIlcBqMEy/R21jpPo/E0LXP9cGoWdUG5Yfpu0WMii7oetisW+8ikd0q9J8vhRwMcZnAPk1HpdSw/4IgeRS12ffMe2WHDGDXqUm+dkeBll1pxWw2hkrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185748; c=relaxed/simple;
	bh=Y+pCJYhlk/CRCda6KlARD2wOYQuVkeKfdGvQbIpFZqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DfYrALl8vUxfhSKu+3HHoZYzIMeEOaSUCWO1CQd/N7RHHmWQ7UpFbr3RuMU4vsdvF3pAZCg1Fzx6sh74ViiDkxZ/k4UYZ5D74x3rII1F9TUjdxCr33PuwSEd+6OXaGfg732sEL2dMS2UZOk4vDq3jV4AtpyYntJhFmzAobLzqgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=wSWzmf0s; arc=fail smtp.client-ip=52.101.126.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OE1u49a+pnedE//E+AbitRLQL0n9sUuxbF2ADXd26JZRgPQ3zbMkC/Hbi2tbdKu78p7r8Qn5vVx1ga8f0EX0ioOrU2nF74AjGbWZX9eij3D4T+NDQlf6OFcHwpyVtN8TDW72VF+XTVgwaE7aEVRwLzLK2r+BUoWAirvVSFhNx1Fxrla61zs4j5QdSNcEQnHtnMTmL/1o8QPSmzHs+W7zacrNuvWs7fgvi1ev+Vl+K+ZVnhn0A4P38uwvTDL0tG1V2KMXnY5ksyQfn8vZx0vF2PcOht2cbHHmDtWgozQBClrI59t+cMceQZ2uuVd9TelfY0YTTKBXdehB51O+9XRGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24D92vMmn+hLpGXpbcBoI3ixwLQjFsC9tqRVUAGpXL0=;
 b=CT3e2MqdJ/EJLsun3JbO6HVo+o3yf3rusAhNV96rZB9V+qcSz2ZIxOnxB0jK4S1Vt5xP7ZxwO19piTEK6xxaqTiUa32Y819OfbaPWKk6+dreG8uhmEvfIcLrfw2pUWf/nwkRS8/gL6igv+qbBvnlC0tyvu++p4pi+Uoy/gr41xwmfpNR9sCap5XdbPrw9lwdA1X+8I1bYUI8D0CbXhf6ilry72v/cDEGMv4/KOmYanEMEg5GrSUeMOKB7+Y5vsUkM9dJp6OUy389CTK223lzzl1MH7G/onXHS0pjLA8bcBB4NWajch4RAAZSBMUhhQdeOLda+alDIWNe705zMwIg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24D92vMmn+hLpGXpbcBoI3ixwLQjFsC9tqRVUAGpXL0=;
 b=wSWzmf0s5dXPI3aNG/j6UY3n6N/YlQpfRrZNjokdu5eX25QMVeQ8wVJckSMOqmA10u7LlrP8/jCJgG4j2Q03Pjq6Zw/2564nMW7erlUgd2fsy+faLRqxTUe7TQpLohitCJttAVxAmbDz6IlXNkZxRdbySqXAMwdckQp/KK5u0ShxtCMi+nSUanSO4fxkYCbCzqXSgZwlqwfuWkCU5BYBUiwImRVldUvYk3bAoZSXH/83OtMJwp7EzmXGMDF170ARnWiWLgUldWUXQBvLszcJ96y5LECMwDvUSJcmUeYKgtod/LIVvteL6hU44WEWvhGkZ8cSbtqNDo4JAjmU/YsBtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB7708.apcprd03.prod.outlook.com (2603:1096:400:432::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 09:49:04 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%6]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 09:49:04 +0000
Message-ID: <c47d44f6-3d0d-482e-b45c-7f6e98d9ac4e@amlogic.com>
Date: Fri, 27 Feb 2026 17:49:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260227-amlogic-dma-v4-0-f25e4614e9b7@amlogic.com>
 <20260227-amlogic-dma-v4-1-f25e4614e9b7@amlogic.com>
 <20260227-crafty-just-cheetah-7ef8a2@quoll>
 <4fa16352-5f74-473c-a568-406e3ca24395@amlogic.com>
 <9a5e2241-8343-4854-88c0-56022f8a76da@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <9a5e2241-8343-4854-88c0-56022f8a76da@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYSPR03MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0ce31f-1b8e-4b50-cc68-08de75e5716b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	krpfMEtKO3pXhEAoD/rS9BSb8/Vv7fiMlVmIRNu9pJmcKVpqd5ZotAcFfkwMNMVNgFYcIp1xAluigzpTbudLb6YTXzQAg/lVwX0ujOdapC0aoGddlwh4Rhi2Zuvs6c+NiTvdHlx06LEN0D6Cb5JgTPg45EWxnt3trhJ5z4M2akEy2JTPgU5ovV44vJNI+Zn9yML/iZKJXgl/hoX7pEQoDdrClNwT8Q7P/7XKk0USXCkE1IYtT+uLmWGqcyNjiJneYe/vNqJs/zv9jN8lUUKYEUQoQbKU/XJCoKQz9JS/3whpkY9EbL8rnvTQDYgdgZx51kYRvC6dghkTQ5xQpAoqelTx6IY38PogYJxnAHTxIc8ATXKmhjsrXHBrQ+jMhpx1LQ4Mb5IKN4aT0aZfEBaij9mHfHR9KDMnSx/fEh7GtWob5GjVB6AirZH0iS9gyG4sG8dmS5Kp2Y6xUXvjFFxGBqhmR0/GatlOLggmCZIQgF5bX5RzSUTLBjhzw0uxnuIwDAFZV6HON3BuSVeahwgl56zCqSyIin81ePva4Q8A3T5zQ438KouI5lT+UG74w5TPIa6ClVzMlAzNiOOgzg+Zq3SRGvVckj9ZGJtsF7kvX46RNG67/IOjdebrZpJc9ovSvCdqEp/ZEMQx/D/AtaOLYN6Brb7Elvdc9Wf4Brj4BakxRNSyPY6hZCub//aWFDSpipWeuwYZJNh50rOIp+WNQ2N6XlxtCxo9hY2N89Ftajs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGowS05Pam5tUlQ2L2p2UC84b3pMbEJlMHh0ZEhQanUzN0ZkNUZIMSswOE9P?=
 =?utf-8?B?a0NNT1ZpK21IT3FKcjBpYUVRQUc2N3BLNjVmaG05QnJ0bjR5YnFFRVU4YVNo?=
 =?utf-8?B?bzlMRU0rVjFuWnJLcGVjeU9VYkdGK093MXlYUGVmYWJvNzh6bytzaTRMM0w2?=
 =?utf-8?B?K0I1U0h0YytCZWhSWHdvb2x5UWVEd3U3YXlia29yQTFYTU5WalhhY1RQSUdY?=
 =?utf-8?B?N1UwWFUrTVZwUEYzK1JERnk5dkR3ek5FS21sMmJReFQxbWVFdGQzZENOOGlG?=
 =?utf-8?B?QXhvZ3VQc0ZBQzBqQk9ERlE2ZWFyNW8wUTFGeDhPd2V6d2x2WVNvVWlOS0l0?=
 =?utf-8?B?K25aTjduYU1xUC9GY0xZVlZESUhxMW9ZQm9ERVI4YmszYjdNU2hjSnkrZmRo?=
 =?utf-8?B?NGpHN1o5cElkM3ZjNnJYNkJ4UVBXaG1ITGxtTFdCTko4Z0NJUkJtSVZEdWxH?=
 =?utf-8?B?YTIvdVRzTEFLVnpPUlhFamJnS0d6Q041Q281ZW8xMU1hZ1hSNVpkK2JPUDJE?=
 =?utf-8?B?K05JbmExcUlRQ0tReFMvVzRlNVZaTS9mS21TQVpzeFR3c0FCQ1V6NnEzNUNx?=
 =?utf-8?B?VitLTlFmUEFYblZsRWFaaE55WFk4ZlJZZnVBZUdxYUR2VXgwVEw4WUhybzZ3?=
 =?utf-8?B?bzdDbXdqbUYvV0lza2lrcFY3WnlZczBiK1Q4U1JZaU5SQ2Jtcmw1N3RKYmJY?=
 =?utf-8?B?UVE2V09QOEp3c0daTEYvMmU3K01yMjVQN2ZSc1NlbVNnZkZiNHdvUjI1cXY1?=
 =?utf-8?B?VUxnd3FPUHVWZEwzeGU1cThQWXd3SnJzTjJZVzR0aHY5emxNMWltS2pHa0s0?=
 =?utf-8?B?dUpTNjE3ZDVDT05ESktyRmthV3A2SmRVU1lTMGpLcUNwTU5sSzVQUXBPRGNX?=
 =?utf-8?B?RzdibS9teUlqaWtKcWRCclNSSVREbkJHalpwZVhQSVhCOURJUVdUaURxWGE3?=
 =?utf-8?B?Y3RpL0NvRUpoMk5tb0dLSVZJY1hhMzFoeStsdHdrRWtRMmVXTC9KZWtBUGk1?=
 =?utf-8?B?NlZPN21qWm1lMEFIU2I2cDBaTitiWXR6SlpTODFVYnhndW5pYUorYjhhUHI5?=
 =?utf-8?B?V1krNHhkNlpxd2ZqVE9RcjVMT3c2bmQ0NVprVU9GNWp5Q3hkcFV3QUFscjJw?=
 =?utf-8?B?Y2s3QkxFaUVkMVBxWjlBY0s4c2sxYksreHBwS2FXbkJEcEpWbnMzVE1RNFJr?=
 =?utf-8?B?SDRMQnFBY0RmUDFFOFpSMFl4R3NPUzZES2EwOVpqR1FqRFRGclBBenBVR1FL?=
 =?utf-8?B?S1BRVnBKNldVNmZjNUZLdDhtaDlRb2tpSXhlSDRKOWdOYzY1NkVINmVjN0pM?=
 =?utf-8?B?blZOMUZSSXBHK1dSallCY2xYTG51aWRpeWQ5YktRSERoRHh3ZUppZ0ZFMVJi?=
 =?utf-8?B?UTN6Qm9EdnZldEMrODV4V1hLRThXMVNWUzJJczQ2SmYrc3BSRUk2a1UwWm80?=
 =?utf-8?B?eEhqTXJEbS9QSDMyYUFmaERzMk44N0NGRnlwWm1GUm9iSGJDREZsdkdBOTVi?=
 =?utf-8?B?Q1NjN0ZVQ1Fnd2Q0ejFUYVFFR2V6bExxUlFnK2hFaU1Ta2hxeTJSWU5Bdlhn?=
 =?utf-8?B?b0FBQ2N1c093S0gzQjJUcVY0a2ptRHFFeFdEb0JkOEpkYmRVOEkxWlU0bllB?=
 =?utf-8?B?UFBMQTN6RWJWSFN2YXVaYmx2VUVZd0xOUmxjQkNmMlhIZ3MxNVExZ0tONjdv?=
 =?utf-8?B?MmtNNFYvYjN4c2hibXFrV25UZ2hUVzJHNUkvYWRDeUJjbGgrVzhVckxFSUFU?=
 =?utf-8?B?TE02eUR3NDV0NjVoU2JnRTh6VVd3ai91RDdQRFZJWkR2ZFl4dDlhejZyemtP?=
 =?utf-8?B?RnFDOWFKNXN5OEtDNGJDby9KRjJNYmZEVUF4VS84NXk2aC9JN0QzdU0vVEpu?=
 =?utf-8?B?NGFucHRsNzh6akg3UEdpM1A1R3JwckV2c1JwWnZhd2pON2lpTklRL0hNSVIx?=
 =?utf-8?B?S2o0a2xDYmtrelZNVmY5L2dSR1BHZU5sTnR6bURqOS81cUtNVUFnenp5Njly?=
 =?utf-8?B?WTRySGVxRkdYUkQ5cUNwanhGa2dzbFhaWjVsamEvRmhKOTRvSEFQQTJ3Vytk?=
 =?utf-8?B?ZUVCQkJBRDErVFVEY1NoTit5cUNBdG93VDd4WlRaRE5hK3BoVzl0ektBSFp4?=
 =?utf-8?B?ZDJGNnBpK0pYN3dyTVJTVGFGTGRDOXpMR1orSUxMYUlyQStXWlpzNDJJZ2Ix?=
 =?utf-8?B?WGY4NURhcUJPbjA2RHF0NmQrTVVXa1lHWDV1MGhlZmg1d1I2NVpjZ3FwbkJx?=
 =?utf-8?B?bHdJR2szZlgvVFRZZU5xcnFJNXUwWGhNb2w4MXVQazNmWHJpU055OVhPalpT?=
 =?utf-8?B?NElaVVJibTRoQ0pxVXFSZCtwQ1NkTW9PV2ZnRy8vU01hOUlXWXdlZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0ce31f-1b8e-4b50-cc68-08de75e5716b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:49:04.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mlEsYscv/L3z77YudJ403J7YBBzk3dU6ffM6n/6wDBomI+ruelWlQEG0COrSYIbBFfTh4KoG0C4QxWKIZfaD+symUNx83pN1KGDHKGrjQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7708
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9151-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amlogic.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:mid,amlogic.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B81611B595C
X-Rspamd-Action: no action



On 2026/2/27 17:44, Krzysztof Kozlowski wrote:
> On 27/02/2026 10:43, Xianwei Zhao wrote:
>>>> new file mode 100644
>>>> index 000000000000..025ecc42e395
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/dma/amlogic-dma.h
>>>> @@ -0,0 +1,8 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>>>> +
>>>> +#ifndef __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
>>>> +#define __DT_BINDINGS_DMA_AMLOGIC_DMA_H__
>>>> +
>>>> +#define AML_DMA_TYPE_TX              0
>>>> +#define AML_DMA_TYPE_RX              1
>>> You sure you need AML prefix? Your clock constants do not have AML
>>> prefixes. What other constants do you expect here?
>>>
>> I will delete AML prefix in next version.
> I assume this is an argument to "dma" phandle (cells), so maybe should
> be "DMA_TX/RX"?
> 

Thank you for your suggestion. I'll use it.

> Best regards,
> Krzysztof

