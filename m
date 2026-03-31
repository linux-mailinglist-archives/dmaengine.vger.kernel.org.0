Return-Path: <dmaengine+bounces-9787-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOgnOkQQzGnGNgYAu9opvQ
	(envelope-from <dmaengine+bounces-9787-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 20:19:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA79936FDCD
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 20:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C06CE306F7B6
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 18:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F15D44A72C;
	Tue, 31 Mar 2026 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VTjc7TS6"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D144CAE0;
	Tue, 31 Mar 2026 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980375; cv=fail; b=PDGNe01C78ewpH4apeQCuf22ZlGjA763t9Scwo3ibkGN+MHKEUcnIRo6megcPnRtKw+u53sFnp42XuVijnFLRQWEUdjoWLUkXueIIrHvQKvitgJGiu6+DPdyX4f3Jds55hzhCPLW2OXr7QZkcK2RoaXYoYZYCn4EWeRuQhTpP64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980375; c=relaxed/simple;
	bh=n1Tdkv0htn74nl+7OXbj/5dPjK2ps/WCDremez7GeOE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6vaduALkmCyQgkbCT1ZVIqTBjfQtJOuWk9adsnSRfzd6Ea9urFjYUCX3phEbrYhQT/NvwLDwK5b4/b4o1QtVujb9T3EkyM9e6Dcd82ofVfHr7VjmQNcRF2q38hjsNFy/KO/ZHmuZiChEdoLrn5yrtH7e0DgcEc92tham6WZA7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VTjc7TS6; arc=fail smtp.client-ip=52.101.48.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muo6cOrFia6kmEAs98b9m855lRK0Lp6Fa7UQv4/OL7RKPwmR2lsJ/8Cquj9UKcd2P4e4f/xEhrpai4xxJzuhUmXSAhWvigRPAU4SRHG5yEAG14+ce6hcFce4IsIyKKwD8vW9mcruvSqWWa7/4+Em7qMiQ4JJuLZca2OYTafKctYHtLGx7DlcEDJ8AFu8DepVUH7DCpVCHF8LGH5nRYOlYf8UyhAu0qcMLe7mCqCHexpbyvH/Jr0gfrGIUEYP4D0ayF1yuW0CTkbD+7ADhRzyVoOPqd7lqQHH5+/9XGj7AuqqrRZPW/1SkJLmdL6G8XHsPCtzbjcNVKKRMCUzITQFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExQIrbzvebczaz4KbMRS45ZfS9SFbOpeGX1qHW/Qv7Q=;
 b=v1HGeG7Uf+NG7QJnIB/BePoYvuP3PBftXBFzFJKdueEr32Tti+osDBrqlhBrVs73aeNybCsJUcq6EcnKUsACm88xS+V4l/VR/rluUE0OsqykDU4QJWWQP45B09WejzvPUi6rxJNbJ5cAqTI3Nr+PK++XaOHjj+rQkbBGXP7Exw582o4lj7bw4LoJeLNd05R/xuH/6QhBbM4StLiBhwuM9mPQxhk7D3NpX6BHFWzuw2XRdGH3RMsngQ85+q812tmhjk7SQ5jGIPNZ0Bx3WP1t8vWhoM+HGbALAvGa1qZXPG0aZ1n9ldCVjVArSN+mmR4wQ4ormfrV6jOvVPOS+fQvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExQIrbzvebczaz4KbMRS45ZfS9SFbOpeGX1qHW/Qv7Q=;
 b=VTjc7TS6l+denQfNVftiFy5Ee3mnNoJj/Pl3Thjy4ACgQBOKgS1LknW/IEESB+HElbypGTEHx1QN61wc3JgKOtnfhRHVymv9yTQGA4iRIy5GvlE+PI1kPygpeeDZHRrPR/3+IhueRidPrcTvpMqjaBD4frhmBysOe3vxlegl+k1iFPJhlaUW69DkJw90r42HHCslk5S8kqnKUNn8drRX01mLWktdIshlO6994HOEPwXt2DH6KNLRtA1VvPwBp5uTYM3ZxAFVXIIJAWgg85jzPVEYkc+tHk9RgkHFghjwUPdu/CPV9rwa0ckdpTo6p0gHKHNbZo+RXdCJwIXPKcBYsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 18:06:07 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 18:06:07 +0000
Message-ID: <586052f6-d415-4603-accb-be15bad80db8@nvidia.com>
Date: Tue, 31 Mar 2026 19:06:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Add GPCDMA support in Tegra264
To: Akhil R <akhilrajeev@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260331102303.33181-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::24) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f63ac25-0e41-43e7-50b7-08de8f502e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yCRssDo6zIGZW5njTyJKn48KhmlucCq6oqnmkIk0pxfJ3KEJ7efUjR9gWhdbBVifQDTHRXBiSyGXUr/xmZJYY9pqOZG8EoJo7I3fYyOs0ZDSDhsK3WjJ/XgOXKuJWNS0KLcugwCXwcSJVLQtSDp+spVUQ3BlDdCWLL562qK+fgD5WPrLB1D6k0RSovtolOtm9m2tOEWwzKXAb7hze1mhlIx1kAr0WYa5baNcxVynKhjoLgoGvPG1/yY0uRWsZNrmmOBcrdzdjpsCHBW+VVALdpz9/RrUw5E/1SjXOiQAiYnRiEO0koAIHcqBJdfsQSMqc6jFeLTjnD91ZBp3reQSCUi3ic4Nn5J1UKDFRHP98IAM0H2CB57LOe3PPOYT5B/zx29VdsVcH3OEBOjj6twalWoAqK/gss/N8O+haxf+qbgy2HrHLss5TyM/LS5IwTWGrDyI3aM9YxPrdRfupRO7uaHSRA7vx3/oOITEO03Wfjnq7GxGn494hE/RVHa3yzxCVtXHMCH/7U0Z6+V0iLVgVY7OUUTSodNRNr15GCltzvO8b1rmEIM7OsbU/+dCD2DRBj/KAMsby9WtKQYIhRwEwv6X35vr7+nH5i4DRj0eGE/PXZLdPrXUM1BCQe++81MNP3OI+yhEv7vl6oEanZ/eTFnhYETaVvqJh+RS8TcNL+Ij6C3hIavnyeFSwK+w5vcd91s+6vnr1ZP2ZCpTZbNaIfWZ5FrUG/5e1aAaAfEMuEYgQ846DWd1d9tmFUVN9e/rJjCyHVsvKY9QGKlbcN8dDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU4yR3dBN2VZNHovUWRXNy9wZ3puY3ZHQkt5R2VXbzZwUjRHQnVhM01rNzR3?=
 =?utf-8?B?SU1acU9jN0NXckh4M3BSSnlhMi9hL254eUNkR1hOby92SmJ4Z1Ryb1h5QWNR?=
 =?utf-8?B?cXpUV2J1SEY1cEhqT2JjakhSYnJ0M0NaWW5FZHl3Wk93QXI5ZEFZVG9RLzdx?=
 =?utf-8?B?eXhPODE3Y1BQclExalhOLzhzRVp6N1g2VEVXOHRoMVJCbDh6RUhrOTJaZHRN?=
 =?utf-8?B?UnVWK1MvWmVIN3IxZUVPd01JUldlMlEwdTNGN1QyY2wyWkhUQlF6ZTZVYVVU?=
 =?utf-8?B?QTJ5SEk0RnFrdjQ1Q3NGamQwelg4MnlMWm5ZUFN0U2d6dUxzTXFkVzdpaFdQ?=
 =?utf-8?B?czhmMTk2VDd2UjB1R21qMDNpU0ZyR1daZE9QbUJWMlorMXdhaEF6RFlTRDly?=
 =?utf-8?B?YnRiU3VPV01xL1I2NGNtTk5ldmczakNRNnR4eTFwSG5ZZzNIN1lCOVdTNVBm?=
 =?utf-8?B?SGhUWFQwSmxkQkE2NDdQRVFOTCttS3A2WWxkb2trcVFnaUZNeUEva0ozVkxQ?=
 =?utf-8?B?UGdrUklGWVVhMDJhMy9YdEIwQ3B3eVBzOFRYRGNUa3dGUnZ0NFhGK2UrTmZE?=
 =?utf-8?B?T3VLKzN6amhKSFFHMDQ3UUFTNUd4YmlWSzhxVlZsbEprSGpuY2dac2lkUW5U?=
 =?utf-8?B?MVk5aHJRZmg2ZWk5RDNDMExhRnQ4R3ZYbUlxWE5iN0FuanRDVE9QcHVTTDBR?=
 =?utf-8?B?VG1NVEdSZ3VBbVVQQTdUQkdSeC91QWFVQnYyOHZrUGVQMU5nZ2FwaTV0cGZV?=
 =?utf-8?B?UjVDN2ZweG81amdnRW0rS0l4YUp6eGJiQ0dubi9qSk9hcWlNNjVNQVZ1MFlO?=
 =?utf-8?B?Vy8rM1M1MTlpREJtSUxnY29rYlFaZjNmQXNBTkhwaGc3Y1o2VGJSR29mQUtG?=
 =?utf-8?B?My83VDlLc0l6dS9acUtzSHM4SGZnSVovd085cDJVMmZyQ1hnbkJPa3hKaEZ5?=
 =?utf-8?B?SHVMNXN4M1BpLytZL2RWMnBxcmxFV091azdRVFBIenRPWTZ4N0VPcjl6S1JZ?=
 =?utf-8?B?bWhsR3h2cTRhSzBMcDNQY2srUHc4TWpqWm9iM3NEYnBoYU1Ed1haNDVCaDg1?=
 =?utf-8?B?VTNyS0JIaGhkS3RRUnN5cllZcitYQmE5SVd1VFA2ZnBMSWtiaDFnWExINWZM?=
 =?utf-8?B?ZFVEM1FrMmxBRXFmd1NlcWtkaVN6c0RVSHdId01BdGtFNUFhZk9KL0hTWTVP?=
 =?utf-8?B?cWNTMExKRWVFMEJHODdsNmwyOWdTTWp2Zkd0dVNrSVV4MGkrZjQ3M3o3TXhB?=
 =?utf-8?B?bkt2MFpkV3l4VFRqM1JINTF2QWxCWklicHBQNWVIWURleFgybU1ueTRVajQr?=
 =?utf-8?B?U0dYNHFVcjRFNEU2T3Iycm9xdFQrNklsYmg3Yk5RS0x4bDhJVzlpUCtkWTJ3?=
 =?utf-8?B?bUV0RUlBbWFaSjQ1KzBOMlVoV1Vra2RYQms5KzcwQ1hTQm9ISmhlOE1oNkRq?=
 =?utf-8?B?Tmg5UGkvdHgveDhoVDExcnZ6Uko2TTBkM2o2TWNDTHdWWGNiTmMxaTZCY1Nh?=
 =?utf-8?B?QkhMcU1HTGNSUnlUTzRJSWo4Y29MOVJIdUEwcmhKc2xDb3BlNzNOaUFLWnRp?=
 =?utf-8?B?VnZUK1NOSlJvdDkyaVp5YlZDWkROTmlnMEdxOHAxWTR6Nk5IL3VmU3RFdWl2?=
 =?utf-8?B?VjZaWmRIVW1iNjRsOUczVDczVDFVZGFHc1FRU2ZpbmI5bDZibkZJeHFqdVdz?=
 =?utf-8?B?UCs1YnNDZ2dOdStJdXN1ajlFV0tiOURNNGhRODRHU3FaTVhQMzVFbWxSbzJ5?=
 =?utf-8?B?Uloybld5czJwYTUrY3dJZTZkTjBFN3NLYTVHN3M2RVZXZFZXWXVXeG5ub1M1?=
 =?utf-8?B?ejFEMG9YRUQ3Z3NEcVVaUXJ5dGRjUHFlalRaZWhSc1NKUTNzMVlVRGorcmN2?=
 =?utf-8?B?S1ZENTFIdW1JY0J3djkrUHZXVHNmYkFNT2ZXcXQyWmxCMHFUeGwxNFlHNVFL?=
 =?utf-8?B?V3NmWHdsVTJDa1pKbjR3RW5tMU4vTjZkUDNXb0lEV0ljaDlsVWlpZFRucE01?=
 =?utf-8?B?TTZ5NHY1amtDWFg1R0Y0YnVPcWJSd1hkWTM1NHdOaFlKMVBjSnk3TGFRL1Q1?=
 =?utf-8?B?OG5GMFdtdHRyZml6aitIZUtWL1FrNE5DNG5TczkvSDFMZ3lmNkI2ZnFhWDBa?=
 =?utf-8?B?Y1NpVHFxOVlMY1RwU0gzcU9SUHY4SzhtYUR2ajVmS2Z0MWZubzhuSEF5RzlD?=
 =?utf-8?B?cVRzaVE3UUxrREE3ZW10VUgwdGE1K0VhTDJmTmsway9tekJvRFlYQVJYd1Bq?=
 =?utf-8?B?UVRzUFpodnRNM3ZJOUtJeC9yWDVkWEhGVTg0RUlEOTFDL0N4bjVtMUJwYURr?=
 =?utf-8?B?MENmbzVzdlBGNVdGMUltcFZtYTIvN0dBOVpmVHNyY09kNG05Q2YvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f63ac25-0e41-43e7-50b7-08de8f502e27
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 18:06:07.0127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xo9hvDxVFKieAUYTJmrQYL7In0AfekevbLL7SU9YtaKHbqX8r/WtrF/F2wXXtMdD95DLbxObnADCGoKOW2IaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-9787-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,gmail.com,pengutronix.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: AA79936FDCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 31/03/2026 11:22, Akhil R wrote:
> This series adds support for GPCDMA in Tegra264 with additional
> support for separate stream ID for each channel. Tegra264 GPCDMA
> controller has changes in the register offsets and uses 41-bit
> addressing for memory. Add changes in the tegra186-gpc-dma driver
> to support these.
> 
> v5->v6:
> - Replace dev_err() with dev_err_probe() in the probe function for fixed
>    return values also.
> v4->v5:
> - Use dev_err_probe() when returning error from the probe function.
> - Remove tegra194 and tegra234 compatible from the reset 'if' condition
>    in the bindings as suggested in v2 (which I missed).
> v3->v4:
> - Split device tree changes to two patches.
> - Reordered patches to have fixes first.
> - Added fixes tag to dt-bindings and device tree changes.
> v2->v3:
> - Add description for iommu-map property and update commit descriptions.
> - Use enum for compatible string instead of const.
> - Remove unused registers from struct tegra_dma_channel_regs.
> - Use devm_of_dma_controller_register() to register the DMA controller.
> - Remove return value check for mask setting in the driver as the bitmask
>    value is always greater than 32.
> v1->v2:
> - Fix dt_bindings_check warnings
> - Drop fallback compatible "nvidia,tegra186-gpcdma" from Tegra264 DT
> - Use dma_addr_t for sg_req src/dst fields and drop separate high_add
>    variable and check for the addr_bits only when programming the
>    registers.
> - Update address width to 39 bits for Tegra234 and before since the SMMU
>    supports only up to 39 bits till Tegra234.
> - Add a patch to do managed DMA controller registration.
> - Describe the second iteration in the probe.
> - Update commit descriptions.
> 
> Akhil R (10):
>    dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
>    arm64: tegra: Remove fallback compatible for GPCDMA
>    dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
>    dmaengine: tegra: Make reset control optional
>    dmaengine: tegra: Use struct for register offsets
>    dmaengine: tegra: Support address width > 39 bits
>    dmaengine: tegra: Use managed DMA controller registration
>    dmaengine: tegra: Use iommu-map for stream ID
>    dmaengine: tegra: Add Tegra264 support
>    arm64: tegra: Enable GPCDMA in Tegra264 and add iommu-map
> 
>   .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  32 +-
>   .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |   4 +
>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      |   3 +-
>   drivers/dma/tegra186-gpc-dma.c                | 429 +++++++++++-------
>   4 files changed, 284 insertions(+), 184 deletions(-)
> 

For the series ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


