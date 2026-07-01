Return-Path: <dmaengine+bounces-11927-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dCKCHNQoRWoO8AoAu9opvQ
	(envelope-from <dmaengine+bounces-11927-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 16:48:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 704A16EEF69
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 16:48:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="H4pQ/0RT";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11927-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11927-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE23A310B65A
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A66341062;
	Wed,  1 Jul 2026 14:26:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2F2E7BD3;
	Wed,  1 Jul 2026 14:26:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915967; cv=fail; b=g6t+/3G6ZuYIlPZtEMG+ewDF5K8kE27tRmL17IeiHpYIU9wB/ZxdWaDnhJ48gZ8EY7M/InNHBCOZLzR81Eor1ZuyygIBIWzcB8mGtG+7ZWYeXDv71vgEdPLDhpheiAmPmF7G+I+R31Mv+pXX4gfmQoDAM6Pp1IvXxOE2yDfQbkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915967; c=relaxed/simple;
	bh=JuVRg/16wRT1OdlEO0LZrKk0Ov+SSrEiglZx0sc/+O4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OuQNMyY4qcTBv7U/MsW8b4p+VPklk09w4l9F/K8d2pW/DTdQbE9fXafI1J9Rhml/2fyOatsAfq8AvOG3Iw7cdmyjjUH220uBhSYRZjXiisY5OIytyWZXHjNsK+BJ1xxakLb5b44X/kFRPw5UHASgKXGO2UPzEp96howjvATCVyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H4pQ/0RT; arc=fail smtp.client-ip=52.101.52.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejXPfS1ZLhJu8pnxmtJqo7XGhaTZr6cpmHoiPT08v7807AVLubD9Mnf4gCl+pVSTRNIKcciE3Riw6frQ+syrMz0pRepbgTp6mWBpLQZ/XhAex58NYp9w/6cfWmQxyAI63IZSpBbPb+uNqhjfXmb3nuqZhFCloblMmOUASlvmeZLx9ZW60T9+I5LK+2NK5SndRPztBdK0LrhkPyRHTpsb1OlmSBaF0cx+5TU6vx4WLsgCxyNF78N0wrOiwSv6ehBj8voLKojCfOGYOJ1PIObJ+/RfXnPJ1P6GY8jrtjAzY2ZDYODpEiqK8gp3/Juy1ySLsjMHRkvPxzQ3KQ99llUFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tmz/9fPSbOc1sVKtLCVbi4ALfHrFfgWqLfTWrA2LLYs=;
 b=ZAmFzKCSe4/oMrPOtNsMwJtpjmyNYiphMTUNHkEhr6uis8ElHzktKRNbDmfSXNxuWxOKXzDWqfrZnYiy8pInHxJjSUZmuVd8vCGLQiR2NUAJncGpuQjqGVgyaicviwSNNY3lc6nTVPpB3nDKTJ8D0chuLmrHBXUERVqGRSYdpIXXMB7KwSfl4XBi9M2+jFE5q0iKdYTvCskItbp3TFjpORhDYVYLBJyMXXJNaNNUUjXzOV0nvFL5MFJCfvHxqJOq4WxvyG64O5wAtDRTlpTkwNYlkErvNY/ER3a+wx5K/J79KOWOIsKBZgqda6TXDcwdwd/AIbgUHIfTRmtI+ZlLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tmz/9fPSbOc1sVKtLCVbi4ALfHrFfgWqLfTWrA2LLYs=;
 b=H4pQ/0RTW3B30aVePlWL76xq+oF2WjfBdHSH+4KBON6oojWZ76eCFYvfGE1nIR8bYObpM7jWKIFuM3IaCNuU/MTrz8ZmqSAiq/erP2pn2Y3rc4uplADduo4lun12WAatr372jeBa6ntstNMBXkO64PSrmU8oWDOR8IKW4WG49QMKLJdopK1N9mvKOC58eeX7ByBb/U6+VUi4XxHsSlIuQmm2RtFQpYQ6brkcFuAYJP9EuQE8TwkM7U3e4Vf8MlyK9tVd2Zqm+CuLA1MmBaFY2tueVaUxfbJeQXHuGpL6p3KNQFlPDLYAiYxpHSQVNF5xGvJn+LM9kkRixk1Hvx9mIg==
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by PH0PR12MB5680.namprd12.prod.outlook.com (2603:10b6:510:146::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 14:26:00 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 14:26:00 +0000
Message-ID: <d0db11b7-2f48-481d-b284-402d19da69a4@nvidia.com>
Date: Wed, 1 Jul 2026 15:25:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4] dmaengine: tegra210-adma: use platform to ioremap
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260609212531.22044-1-rosenp@gmail.com>
 <60410a5b-226b-44ee-93c1-d9cb3eedf01c@nvidia.com>
 <CAKxU2N-DELS8D=ZFk++s-AW-uZv4gKvqmKM0gzDdbGy2zvrGKw@mail.gmail.com>
 <4bbd8cad-581b-43a7-b644-f6202f7aa293@nvidia.com>
 <CAKxU2N-GX5grrSm75mfAUqDXiXcQ0xMUX5Sbd7CLvELpF=QNTw@mail.gmail.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CAKxU2N-GX5grrSm75mfAUqDXiXcQ0xMUX5Sbd7CLvELpF=QNTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|PH0PR12MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d4e4cb-9b1a-49fe-8ee2-08ded77cac3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hEP+MEXXh6H1XlK+b7FHHwbasnqltojVkVNoV1UoYXOhjbYU8ap+ac40eEIXpMT541BH8Cc96VpmPbfMwlA7IHho9wELxQLMxgIbRnQ14UHCHEIIc7fLAxnVS8KpgBeZZGvG36xu0EKzexnO/Y2FlbQVrP32MJsge3W85lMC0iFsCT0vXZvHoiAP9ZmXOrahCXcRjRNHg68LkwdFYg+379sgxhfssNWvzaBXoW3cqhIDQFO4BVmsXFu055H1ky8ST63PdlIMK7uPPQVbqk4sNJtX8skQXCUrXnW/1PXBeaAGZdXR4ygCg0R+JTaoyuOBnmwmfqXtInYtMolD/ZV0dMPFufPa6qU3ZfYKV71lvkUj/NTCf1ps6REAbup9hb2ytc/GMte0lCo9jN9MWirWvBhB3fReKYIynY0rZp1XWthtIQNDZdI/Q5eY0iNCnQI8bdhY8cN1ixDEkiMzcJ9weVHw17mUZr4d3NL/OXplGQHJlupbw8LjXI9V9lkI8+pJsXcthYV8b52dxeAW6yItpRAiaeuBZxpeMsxyDsJgqXdPeOmnzE4ntxetK/ug6VD/euB8a2XhJyabxqJfT8czk6xZ/8k/K81F8lmhimPg3moISWKxtz358lzy9xVKTpITzDYwlMMaoUq+H9N7deRog40WQiicc+DV4jsAuJv+tSM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWFUWnNvSm5wM0FjTm1GV2JrVDRncGdUVlRrTTh2YzQwTWFhNllRSXFVbXgw?=
 =?utf-8?B?UGFweW9OUjNUVDRtdkQrdFQvZW9PN2NzekQ4aTN5SWJtdDZMUjFndlE2ak40?=
 =?utf-8?B?ZzliRXJUN1lieXJlZWhid0J4NVhnTTZCTWVIM3MrYndRaVF1ZXVidEd1Snhu?=
 =?utf-8?B?U29IeUx5Y3ZBeTg5TlhZUlN1S3VnaXNTM1Y4NkNxLzR5SjRwODRVY3R3TlFQ?=
 =?utf-8?B?bkMrUU1ZazdackJCZVNYRTlEcVJ5RFIxVVlXcjBCbU01STVvWGtkNW5CV3hr?=
 =?utf-8?B?alRpeDNicndtZ2o4TmVJMWRqVHlDZXZwSW5hM29OUnRkQ3VTMHlVK1k3QkF1?=
 =?utf-8?B?WXFNQ0o2clJHcDMxbmh2Q3RLYldpbzVQNlpUOWRMRjFyN3ZXZGtzTk5KNGZ3?=
 =?utf-8?B?ZTIrWlB1M29NNWljVjdUMFgrbldJUW43cmhMQURiY05hZk9FeXEzanVXREh6?=
 =?utf-8?B?emY1bGhZSHRBUDU0L3RjKzU3dkhXbFVXQVp5ZGpCeStkSzE5b0JLWWhib0pS?=
 =?utf-8?B?bFliL1prdFBPM0hSZ21FRVBCTnc4dkVlRm1aY0huUC8ydkpWZjBsTk8rSEJU?=
 =?utf-8?B?MU44OUI1Zks1cFdRVGwydnhXeS9FTDF1ZXhRRjV6OFRkUWNmS3RHTTBuUVpa?=
 =?utf-8?B?czFvNUpUWjNnbG1XOVFXUWdLMWQyaVgwd2dzQWdBejVSUkIyQjU0dVVFTFc1?=
 =?utf-8?B?aVVaWkVIV2NSRWNud1FXaDlhWk5ZbWdaZVVNMDg3cHpWNjVYVUsvMFk2VnE3?=
 =?utf-8?B?VXIwL3A5dUJtdUFLREQrZXhyc1pyN2hpai8wdFFERDIrQlZqdVJWZktCU0NT?=
 =?utf-8?B?cmR0bjFSM0Q0bmdQUkJoYkVaVWpJZSt4VDBCeHdMRDJNdmdHdFl5UlhINnE3?=
 =?utf-8?B?Wk9TdlVKc2Y3ME42UC9jYklTVEZuNXNiRHprMVRybVRaTXJLOSthT0FIaVN2?=
 =?utf-8?B?Ums4MVZPTTc4WStLRmdiU2tRekxlZnlpVXRVdG9lYVJCeCsrUjdFY0o3MUZy?=
 =?utf-8?B?bTRQaGdWYkFmSEVNSnNoNTRxWnR5VEZPejcrMVlBWVJTSGRENndYTFkyc2F0?=
 =?utf-8?B?VUZpTCtFUm9tQVROeGcwdHVPUFduTUNhRzczdExkUS85MUxLYkVUMVI5R01W?=
 =?utf-8?B?UmdFNyt6ZHljOGR1TEtTemdub3l0VlFUdkc4M1hoaVlEMkVnU0Z2WDhJVGxR?=
 =?utf-8?B?a25OdHZmRExLS01URTF6R2Z2WFJ6aWU0TkZWa3l3OUloc2dSUHM0cXR1ZU0w?=
 =?utf-8?B?aGMzQy9JTk1LOWxLVkFPdmZsQWRhcEZpOTlLSjVLOHFzZmVKdE14aWhSQlFq?=
 =?utf-8?B?TlNMSytJNkxKSThETEdVbEwrOUhBODBLNUkrN1E2MkF6Vm1zK2g4emkwVGlm?=
 =?utf-8?B?bTFSQkJ0MUFMOUtHU1k4TC9aZFlwNnNuTGlGMWp6akxlRmM5NXcwcmxLeGcr?=
 =?utf-8?B?Y29HKzNMRUxmRjlqYTdzUG91NFpvV0NtRDJVRmRZSnlKTTZsZ1ZIS2ZOWTZ0?=
 =?utf-8?B?NWZJNEJwRnVGR0RNRXYxVUtaWVh5WlUyYktXVTBaOHlVNXN5d25iSGdIQlR4?=
 =?utf-8?B?TmtvNm9tMURKUmQzcHdXQkkrZDlnQWNjb05Kb2Q5NU10dk9NdHdwS2JOSm5Q?=
 =?utf-8?B?MVovbnRsNTZia24xS1J6TnZVeDA2V0tYY01wWUlsM0U3NDdNK09EVjRvUVRO?=
 =?utf-8?B?a2Ryb3p5bE9taC8xcEJBUG5LcXpBNk1DcW1JN3dhdUYyc0xUVmhGa1NiU1ZW?=
 =?utf-8?B?RWREeTQ3VHdZQzc0R1M3U0lwT1RNVWtQT3dYNDRiWjQya2xxR1k4RTVEN05s?=
 =?utf-8?B?VXJseUFQNjJVYXorYUVVbzhTSTZJcmNsTnl6UkFmRklsT1JLN0NJMW1VelJn?=
 =?utf-8?B?TUlHbURDcDA0RWkyYnRiZ3drdlIvdUd6dndnUnZpeDdXV1NTRFRyWCtuV05r?=
 =?utf-8?B?M3luK3diVWthMTZPWlhHcUxIaGtGQUJka0xwc3ZkN3RseDNVT0VDQmhQN2Zq?=
 =?utf-8?B?NFVmSjdpZWlvc0kva1Jma2pYOW9qZTNQQXBEVWY3UVlma0g4SDNTOEk3aHFL?=
 =?utf-8?B?WXp0cGpFOGV2dXVMRWpFY2lUblF6Z3A1Z1B3YWJmWkt3M05JNXFNTURxVmFG?=
 =?utf-8?B?MHNZRXVEdm9CbU5SYlZQdzJ2T3U5dmlHbStETjEyNTQzandvRmZMajZCZ1g5?=
 =?utf-8?B?WDdYaUlReW0yRE5Ga2FmeWE2b1pFZFROQU8rdDRlUmRPTXhVN2lYMHNUZTlp?=
 =?utf-8?B?Z1pjSUhRVVIxVkUvUDF6Sy81MlBFcFI1cWxCdmdVd1UyUjBUV1Z2dThOeGhv?=
 =?utf-8?B?ZmxjUDhUY3Zjd05tdkpRTHNHQ3NMcldHOGx4LzRBOWJCUFA0MENEQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d4e4cb-9b1a-49fe-8ee2-08ded77cac3b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 14:26:00.1712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EE7Ddrxx4Cw5vLGEhXe2i1i4NgeMaj8oWywkYmVY9nHjl6uXVk3h/Ocle8/L9yS11vxtE74yXBGjrdYd5J5Sjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5680
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11927-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 704A16EEF69



On 30/06/2026 22:06, Rosen Penev wrote:
> On Tue, Jun 30, 2026 at 5:17 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 30/06/2026 01:31, Rosen Penev wrote:
>>> On Wed, Jun 10, 2026 at 1:43 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>
>>>>
>>>> On 09/06/2026 22:25, Rosen Penev wrote:
>>>>> Simpler to call devm_platform_ioremap_resource() as it returns multiple
>>>>> error messages for whichever part fails.
>>>>>
>>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>>>> ---
>>>>>     v4: rebase and reword commit message
>>>>>     v3: change subject
>>>>>     v2: reword commit message
>>>>>     drivers/dma/tegra210-adma.c | 12 +++---------
>>>>>     1 file changed, 3 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>>>>> index ceaee1e33e68..21a381d022cf 100644
>>>>> --- a/drivers/dma/tegra210-adma.c
>>>>> +++ b/drivers/dma/tegra210-adma.c
>>>>> @@ -1087,15 +1087,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
>>>>>                 }
>>>>>         } else {
>>>>>                 /* If no 'page' property found, then reg DT binding would be legacy */
>>>>> -             res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>> -             if (res_base) {
>>>>> -                     tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
>>>>> -                     if (IS_ERR(tdma->base_addr))
>>>>> -                             return PTR_ERR(tdma->base_addr);
>>>>> -             } else {
>>>>> -                     return dev_err_probe(&pdev->dev, -ENODEV,
>>>>> -                                          "failed to get memory resource\n");
>>>>> -             }
>>>>> +             tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
>>>>> +             if (IS_ERR(tdma->base_addr))
>>>>> +                     return PTR_ERR(tdma->base_addr);
>>>>
>>>> The dev_err_probe() was purposely added to assist debug. Please don't
>>>> drop this.
>>> If you're talking about the memory resource error,
>>> devm_platform_ioremap_resource() prints
>>>
>>> ret = dev_err_probe(dev, -EINVAL, "invalid resource %pR\n", res);
>>
>> Well technically it is devm_ioremap_resource() that prints the above
>> which was not obvious. So clarifying that in the commit message would be
>> good.
> I mentioned it returns multiple error messages.

Yes you did. OK, then this is fine with me.

Thanks
Jon

-- 
nvpublic


