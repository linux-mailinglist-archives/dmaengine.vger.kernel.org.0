Return-Path: <dmaengine+bounces-9357-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH9VEkHpr2nkdAIAu9opvQ
	(envelope-from <dmaengine+bounces-9357-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 10:49:53 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC15248CFD
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 10:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B46B305CE29
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA8036921E;
	Tue, 10 Mar 2026 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UWY3ZKuQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52442199D8;
	Tue, 10 Mar 2026 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136080; cv=fail; b=BwTXFehcpB7YeiOkQpgu3iLCDbanU21UCIeBe8JlRO5mcwcH8Yg4NbYe5IUWncR6HVbAnCvwxycTzn7ysavbwWVS4DhpsEC+TjscGjRZluGuBjOtVNjNd59Rs0jKVYovogTaXolxCCq7Lsm9XziynzNn22SHVifCHDw9rKV3GXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136080; c=relaxed/simple;
	bh=TOdFD8+NyQwlGGBVn5n9Etmylvwn55uiB3WBs/BQ5UE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EwXzt3A/eVlz/doNwTtIGViq0+Kn8oFzSIR+phU0JJGncIjCWMWn6HrWVpxVl9RhukRExtTm6gfCSbFWVEJ6WHxReRhTLBUwarSs026TldXEjVByuGiItJRjeiO/GfPdLrnFgvzYGmF/KXTW0wj2/z9/uzxC469QS1Vv/XjKgQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UWY3ZKuQ; arc=fail smtp.client-ip=40.93.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8AoCZB7x5+1gjH1uLWGUYPEnZ3PpVfTMXCBLwDc34QBadHTlQP9MGlXnK2nQ3vLsQdn801qartiDIOG2LZ/IF8DUl/9CZdot3lp0HnaMKKBf7QoLRaVIyEcF8KHasMWMzrRnb8UZkl2zsQpBomG2mcuvjI0kq7ImgIWmkqltTlkhrVAg4QY4CS31eQEjmTLlKIllvDLucKrFcxAQbFM0bnQTNSqQHAp1v47At9ENL4kOSxfPlMa1A5B+EJTsxA6RA6VZ6ebI4BoHQhkKkg7wv15zB33lqVvX8mcyrNSmaUuxWrTwFe03qcj+Ns8gx6sPpI6g1ZgIhVLyNEf62sKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gxx0AR4IUlLyNaWYh4rgHChIcAGnyyHMG8BfWrsxCwM=;
 b=eQH5peDK0pm/AqenVp4EesWufaNJoiFqvnd8m9UxInmD/mT3yfFs+USAkifVQ1CjWUq6cdsJ9z7+pLfNryPUZu7kGXN5l89RxbSXijjFhiBn5eScn1H92o2HWkt35rMCbVNDndsDiCoxfnfcbJI+iy/sc4Modo4DuTJ52vMAmERGbNAr0QqJZlaNvz50XBqJgg5y7MKdrL+U5hkApPiCnFJhmn5DkL9mRwoObXI3pa8EuXa2yZe08rF3lbmOwmeR/fFGOHBYnT0zCTYByia5ArhN/u/TA42IQRVKd1H3BKuIAKENwwgjPqyjmu+3debqCio5gJIC7mIdVfT/tLKoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxx0AR4IUlLyNaWYh4rgHChIcAGnyyHMG8BfWrsxCwM=;
 b=UWY3ZKuQSUBpMTssK47YRgkKdDfsRENNvIfZdHl1lR4jbPM4lW7yMpRN2cEfqz1pSDshZAAQyd8mibhGWpCI2xq4Llf0MPrEy8adgRize75s2ikWAjVds7ZONnV0MJ13t1zOiykT3V8FSqe62PeJ0rMdVEe76UbrEnjLvKlScPu08z09j+jknIYMRvpdXHV0VzNi+R966Qybk56N2OJjQ09kl0+qGOqC/CWYJvugUjr/ZLXUK7CNYT4ktD/83KJpBWlLzKS+KRpqJhy3KN+zs1l6ofako5v7BwGUVCphZanJyoGhv/oDB9BCuWCZhYnuS/dqestBUzEnGSdtETV0Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CH3PR12MB9315.namprd12.prod.outlook.com (2603:10b6:610:1cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 09:47:54 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 09:47:54 +0000
Message-ID: <4af40858-c2fd-4eba-9d71-39fa403dd4af@nvidia.com>
Date: Tue, 10 Mar 2026 09:47:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add
 iommu-map property
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, krzk+dt@kernel.org, krzk@kernel.org,
 ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, p.zabel@pengutronix.de, robh@kernel.org,
 thierry.reding@kernel.org, vkoul@kernel.org
References: <9740033b-0fa4-46c6-9628-f4c3ba1cceae@nvidia.com>
 <20260310044426.53519-1-akhilrajeev@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260310044426.53519-1-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0089.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::9) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CH3PR12MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b00608c-c5b5-4cb7-6f87-08de7e8a1a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	1r4s9Nqu7tgSMcQIjBw1HLDKaKnxMm4cGx6jjR6tH+t25QCmqUj9U3o6zMqk8SXHIXUXsuiaSXXsgKHBK+UP8Kjk/Odi+fndHduc6Ude4R/Jmps9Tz5ZzQe0TD4QokN7DVQN0F4AL1vS2NhiTp5+1SLYZMLO7u8/G6CGHkk+h6TzQDAQEZ0VQZSV/+t/3raNPR8w4Peteglm4CmCtM0nTd0soboO5wwzo97stn0DmZPNx0m+AWPt8CbS4A1SP3aOAtDQ2EvDTf5PUbbHbHlWyDdlCtZLbANQz3nqtvMeYg/7EIZZVXjoGth0zofQwCsQcNI3Oj5Szv9nNfqQRpLsOIpvZcSiJA2bLIMXnkUFyuZTowsxfTlIWa/dTRoEQRLOPyY/vu7Mm4sJ0perm6IYlNRJozmKLHMCN8wNjc9HjiulbmFhTxfYIaDyNcoCJkU6STybGrhPc0zsgfjtW6Vr681KPE+/Sm+a2BNurS4AQcMD8ghDwS1Cxtq25VkLEE+fzL0TtEC/uA8j7P9Ai+58O0xxCZEvnrtJfP2IBDwmnzOREHJzoe2syEkaaeRPh1/kxXa4NXYPJEcOHQ432HCQfcMQcuCk3M0S2NjLAXTvnTeXqrRRG7srdvZyRL/dDFEo4NYgymaMLSU9ahWHSl4dtFV13OI7XTH4uJRpMz+aSQa5O9Q/UbA27/73oA4h4Yv3PI57vBT+9q4jszgUIH/lKqZmKxehPYAfs6Gbm2c94nQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1I1T3RoTElkdldjcno3d0x1ZC9iWXJYN3hYTCtTc2FodnhkQmcyVjEydFJu?=
 =?utf-8?B?SU1OOTQ2Sit1bEVzNkcwRTFJTFFGZWFFNCtHTEtXb3JsUXBsMlRlWHlPbTUr?=
 =?utf-8?B?dU8wdUpDa0ZWeEorMkRtcTlieGVWMXlMaFBmbkhxREc4MjBvcGJxeEtEMGVm?=
 =?utf-8?B?YlFvQUdYM1ljN3VDUzFHNFV3WCtkNmVoMjFEY3F4RnI1cmJZd2pzUVBaM2FH?=
 =?utf-8?B?a2N1dVlLY3czaWc0MjNxMjJmWEV5aTVFME1WbURpWjIrcG1HbE9sdFo3elg0?=
 =?utf-8?B?M2dMSlRYQjNoN3FkaXV4WjQwREI5M2JjMnREeVlOdzJsdDhWM01wbE0wN1Jr?=
 =?utf-8?B?K1hPRmEvdHp0NHJZWHNFNGFsYnlHNkV4bGlDWGpHZmdTSVUvSnVpa0JxbHZo?=
 =?utf-8?B?RklNc2RLOFFVNUVENU80ZDBTUmNWZGdkTlprYjRxVU4zN3FoS3JTSG1KS0tm?=
 =?utf-8?B?b0taRmcvK0FjdGpmdXoyVDBxZEtaOThBNFpsbnU4RlRYWm1wYk9RdHRwVGEz?=
 =?utf-8?B?czBLU0hadzIxazdvODRrejVadWNyd2I0eHloRldhd3crTWI3Zmt5ZThUV0xh?=
 =?utf-8?B?V0trc3htMW9MTDV5bXdDbGUwbitQVkRVeHI2WGd4K1hsbjlYYjFmOG9yZ2Jl?=
 =?utf-8?B?QjRCaHFWdEg3a3BzaktpQ2xyKytYRm1kRzFNSDFzQjNObWVNRFhZcTVCa0Nw?=
 =?utf-8?B?cW9jenc5blJIYkxHaWQzNGpsdlNMVS9WWXV6Y2I4bVhCMHhCaXJHZGhvQUdy?=
 =?utf-8?B?OXZpSVM5ai8wR05sU1JMa3Q2N044NkY4d1F5aE5seS9KaXpHMVdoTS80WHdn?=
 =?utf-8?B?Q0pBTHoxQkQ4S2tZTWF6MUV6ODJTcnJjMjlhWkZ5UWs4SE9IN0g2bjZ2eDBq?=
 =?utf-8?B?UGd4VVZwZUE0VUpoTVAwRTBnZTNrdFBDS3c0MW1najlJWE1iazA1T0hQandQ?=
 =?utf-8?B?TTg0UFp2Q2hpaEdNZy9wbVRKRWxiSituTk4zSjdVUWVDTEUxWW04Y0ZEQThq?=
 =?utf-8?B?TDhOazlOai95ZnMvOVV6Tmo2N05BQTdIN2tqcDNKSFpXNFNMV1hOdWxMVUs2?=
 =?utf-8?B?RTIyRHdOalUwWHVnUkh5VEpIaU82WjdWY2VkaXFFOGwySUUyNGMyZHkyTFNn?=
 =?utf-8?B?MTNjTEl6MWFYdXVlbytya3kyZWdiWkRDb2xSVE1jSmpEdEhmVUhLaGxJbUZu?=
 =?utf-8?B?OGg4NVQwQmo3bjdjbG00eFJCaVZISTYvWk5KV080clpidmpWWUJDTnprbjJB?=
 =?utf-8?B?RGV0MXRubFRSclEwNzZyVmN3cVhSMlpPQ2lhTndlK1UvSGs0ekNuMjBUNHZK?=
 =?utf-8?B?d3pTdFB4M0dZL1FTRXU0aS9tcXI2a2NlcXdoMU9Kd0kzU3l0SjM3QkFwc0Zl?=
 =?utf-8?B?Vmx6cW9kOEluVUJtZC9vaVhRWEpaM2tNdzVENzR1b1VabDNTWmczbHZCaGJJ?=
 =?utf-8?B?NXViemd5UkhlSXowZnFPdVlTUFYxbHRCTXloaGpuSkpoT3NpV1dQY1MxeERH?=
 =?utf-8?B?dEFuZW40aGhPOTQrUzY1YkN1T2F2dllxUkZ4aEc2TVV0bVpjZXBnZkJBZk90?=
 =?utf-8?B?VmtxZ2NNZU5NalIzSXhsN3Yxd1FuTTVXd0J5WkdlRXRTYWM0UlYra3BITHNP?=
 =?utf-8?B?cmZoNjA4MXBqVU0zUlY4TmR3MG1uUkVZOElPVnRHdXFFVStSZnpJUnJKVm5R?=
 =?utf-8?B?ajVrUlR2UDlwYmZUU2xxUDVRT2dNVUg4eHNwUk1yUVZZMnd6dkc0Ylk3VGFO?=
 =?utf-8?B?cmtPdGdvUGQ5R2xmRXE2ZmtGbE55R1JwRzNxY2ZNNHkxMlRLZVQ5a0JLd01E?=
 =?utf-8?B?VnVpbUw4RjRIaDFnajYxQSt4U1hOSGFGNmcrWm1DR3dNNCtwbU9acUNVY0F3?=
 =?utf-8?B?V1R6NDVnblhUQTRubGkyVjMySExuN2ozYy9JOG9GMVFlRTBTOFhOKy83TXRy?=
 =?utf-8?B?Wi9UYVpaM2ZFSHR2Q1NjM3FycjBtSkV6azR0ck5TYTdZbks5WDAvcUZOVVFP?=
 =?utf-8?B?T21YczFBQ0IzTlpTMHFkRjRUUUxmdjNaZmdxdWJpM0ZaaXdJdmF2SWpBSVFO?=
 =?utf-8?B?OGxzeEcrYlVhdmFVeVRXSDFjKzBRdXRIaFJvZDgwalcyZDVEdlFNRjJFdC90?=
 =?utf-8?B?ZTh0WE8wOTdzbGpoaE9sRTBxOS9UYlR2S2JvQ0hPeEFBUU84Z21BTVg4UUtx?=
 =?utf-8?B?Ri8rZWpjTFc0bnJ6d2xOMUdXZzdiNCsydURDeDMwRjRyaW5nQW02L2ZPNHRG?=
 =?utf-8?B?NzkvWllQUjhLSHBlNEt3aDRkTktpSTk2UWN5VUpFT1BXSkpka2piSHdObFJl?=
 =?utf-8?B?cHp3cjI4cUdqaGJJbXhub29ENUdnVXVROVBscFQ2SVZlYVdwZERXd0hzQTUz?=
 =?utf-8?Q?eMxFEBU1YnWqkxQ11DKn7U3VNqSEbbaPjxeM8gzYxw9kp?=
X-MS-Exchange-AntiSpam-MessageData-1: N5bhRz6F6RtDvA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b00608c-c5b5-4cb7-6f87-08de7e8a1a5b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:47:54.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipH64rkxfc70FMQzJYc1iudscAnsaKiofmAkCImxhQF4NLS8e9LOYagRTwBumYOjqjvU8lfh+egIkX3rcLz+bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9315
X-Rspamd-Queue-Id: AEC15248CFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9357-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 10/03/2026 04:44, Akhil R wrote:

...

> Looking at the qcom,sm8750-camss.yaml, each iommus entry is describing a
> functionally distinct hardware block like IPE, JPEG, etc. Here for
> GPCDMA the channels and the stream IDs are identical in hardware and there
> is nothing functionally unique about any individual channel to describe.
> 
> If the channels and stream IDs are consecutive, as Frank mentioned in
> the previous version, we would need only one iommu-map entry for all
> the channels. In a virtualized system the hypervisor may assign
> non-consecutive stream IDs, or a scattered channel mask. That would
> require multiple entries.
> 
> I will document this in the description. Please let me know if it sounds
> good or if you have any suggestions.

Even in the non-virtualised case we can set dma-channel-mask property 
and only enable specific channels. Given that the hardware allows this 
flexibility and we could potentially have various different 
permutations. So I think that we need to have a flexible number of items 
for iommu-map. And yes, let's describe that clearer in the commit message.

Jon

-- 
nvpublic


