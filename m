Return-Path: <dmaengine+bounces-10217-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGV3OYue+WmQ+QIAu9opvQ
	(envelope-from <dmaengine+bounces-10217-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 09:38:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5724C818E
	for <lists+dmaengine@lfdr.de>; Tue, 05 May 2026 09:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DBAD3000FE2
	for <lists+dmaengine@lfdr.de>; Tue,  5 May 2026 07:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162EB3DBD7E;
	Tue,  5 May 2026 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JSfdHU56"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4C3B19DE;
	Tue,  5 May 2026 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966730; cv=fail; b=ZQtk6Qd0oxrycaHJc+kmhzWijxoVMQ/ywV2TgVinLWyH5FGc8z3XjAidEta31Xg9zvXq33NtW83RZX6O4vLvC7MmLjKCkRzXhYoaspVatWUL/f9abe7w/a/WJ6E9JP6CyjGiXzmnSOTqfupKoMXPNdSHLcCBHyDOLP6lwR2CIj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966730; c=relaxed/simple;
	bh=wf5WBnh8xfaA9nJ6uNs/elS6FQvWlIo598eJBbFrvzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rZNebe3I+R7gSXdIyESD/GYEYLWFsloXk0508K5gVFT5F7JUZM8wmQSk8MGlQuBqKYK8k25xvSEA3R39CQ9lwfeRaNtxMESCHY0inN3UYcUqm8Z6uMlvwjqbj+l9QUriUIHzN9HkrpfSnRZenPLwF2plgJmEUqVRILxXHVCYmws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JSfdHU56; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKCR+ZlSS3bPfS65wTi168hBP8cxlUXfAghckUxvpNcSgd1tPpPSt8iiFG0+g21Oklv6Fkce8Vo0VoBgEnxoDbxpz8048bnc9PqtDvR6PQachVd2I3xBUwtp1J09Fmo8gWwevAqxawPHjN03ebglZdRxlx8w8TtLgoa2wikGE0Ssxu5OC/zV7Nbc6XKjABkd8GuNA3ekv9Ig5fWkPSxek1a8hzkkG/Jo+8w3siW2dO5/Vafe0+8Da5TX8PmljRoPoeRg6fn6Y92iLiF2oJSWyDbJGNAqPIkRWlLYRwO+fAXXOUmGESW7jg+ZTW+6EBzTeFMLhbU7jAlBCdy6jDlc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6hIEy1d97oFm7Aqwqmhr1WwrgiNGifUEKLbFNpnXng=;
 b=T2NfDPu4z9YqsCMRpu8x6tS7ItIT2XXFdb8KsdCjGbs5ZHNVxKuU16akzJIh7JLcio1Mo3C/hRjaLrtBRlfG+3zfq81z6vBO+8lGID4Ag5wkfqJnhsd9PnnDCbjhM8ARvBT+Xmt1RZx1/3+hJfpNyisusV6zB4xJdIf2hbKUE1YX72VBhTXFtIHBxj1jFTy47Paam1VeafUoIbXs8WFZ7mgsqD43zLy5BYFGfVQ51MHvqIXfIcblxUTSoxBfX/9IOeFPwgN9QM3GaPAXmSbaxuxm61c3Stxv8XnXl0oD2zD+zPRudchbFSr/G4IGEw6lFuQw6nOt14trzFAm1whnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6hIEy1d97oFm7Aqwqmhr1WwrgiNGifUEKLbFNpnXng=;
 b=JSfdHU567GoeA6IFYRjHUNnQmtwNUoyHemJTzjQ0lXmBQlFgbfDwIj7YDoKcwYiptrod8q7tO8sj6Rfv4OzjuQt/HV7uklcV/C3NW9CRerM1Fl3p3lu+ZDere56ooIjOthp5cB1SN3bg7nS7yarp4bf9PHp6CDjIxJZZ1CxZahQOG+mMvafbDRdDKRKjiPZXSFYOhwzwX44Y//50f6izZxLXBvb2WUg09sUA71xrRR4KyybZCcMs5cnYXkBbfxAoEQ2hE517k7CSR2/Rg6wBk+INTR10G+PVZNyZAOqS2oNq8FxCyzwwMe+8dqFNouS5JN9NM1BOvKEbCPHQLtTuTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 07:38:43 +0000
Received: from PH7PR12MB9221.namprd12.prod.outlook.com
 ([fe80::8930:f4a8:bdae:4bb6]) by PH7PR12MB9221.namprd12.prod.outlook.com
 ([fe80::8930:f4a8:bdae:4bb6%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 07:38:43 +0000
Message-ID: <a0e3c643-dee0-4352-9493-a7bcf2b5f934@nvidia.com>
Date: Tue, 5 May 2026 13:08:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dmaengine: tegra210-adma: Add error logging on failure
 paths
To: Sheetal <sheetal@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
 Vinod Koul <vkoul@kernel.org>, Thierry Reding <thierry.reding@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Frank Li <Frank.Li@kernel.org>,
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260413064545.2157410-1-sheetal@nvidia.com>
Content-Language: en-US
From: Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <20260413064545.2157410-1-sheetal@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0108.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::16) To PH7PR12MB9221.namprd12.prod.outlook.com
 (2603:10b6:510:2e8::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9221:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ebcf86-0550-4dd6-d3da-08deaa79556c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vwdlttJlCBVh2AqnOkE5fQ8sh/mGtpiY55obdunQ/vtu5wv9XM0Fwd5gAkoiouohmsiT89FI1Q3D+xjBwbC0hXP5dYAIrS8GvJ+biNp9JLR4e40bxt7EJ9TlZPGectsj54ZOKkRijIc5L6+u8i+Vk9xpvuY1uQazLjaAreLSP3iMvqcxNo6oAFYLr0935vEjh3DZPYCYCFx40SKKdhr55tygfewhHWm7M+5kL7AUKS28PZO1YJvkaxcqYlmSc4PB3MByG2dqjcSOzqwMnN2/VR5t/R8o9V7JhbBVgMaJvmXZLbUh/8y7/zR6qfGgIkdAfKrwlAYnpDm1ScqUVG4/sVbNp7RdbNdoxHp+idA0BeImPmvXbCzz+g+d7K4bdtegocwbSRTQConwmZjnztkFKB0Jzy9I6GRxMiXtBicRpMMpjUA6OzdZBYwikKWvae91gtnAjPdBOoLezaMX24uExyVGEc4Mf38mBM7T7+4soWk+5EQDvmBOZGBeTXjT8963x8iZV8+P5wYG920964X7wQbgiHK/eVrsRbhsfqqwWCBlnW7EqJwvXmKzV35kslQJGxoaaylXi0VBoCZZ2NMzeVwCwm11IKSJdyDDHYbvbs9xscC4eSFcqaJEAmni97ENnzMRghE/Op8ADG16RNNjfZLKqxcKODF5gIrW3VvALlmV3YvaCD4KJgMkkknIT4nN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y09QVFUxcXJidVZQVjZ5d3dwNTdNYS9KcktPTllOeHNvNk1LU21heDdrd0Yv?=
 =?utf-8?B?U1ZOcHpES2p0U3Y2OTVneSt3U0owVDIxb1JuajMwWGp1WFQ1RFFpWEpxTmVY?=
 =?utf-8?B?ZVQwSG1Ld2N4T003YkpubHUySGptREExR2lvWDJDNWlYQ21ma2U2OWM5LzM0?=
 =?utf-8?B?djdyejJSY05sTkgwTU1ycUhvL3MvTllHa0hibDU0TGpmUmJtK21xcjdaTEZX?=
 =?utf-8?B?emxySlQxei83amtUWHpSbmdsQkxBLzFxaXBSSkp5dXMxOFhOaDJ3cHFqVmc4?=
 =?utf-8?B?UUwwb1A1ZHIyMFFEaEhXbFIzSERTc0p4bEVsVTg4RUc0SXBYeTJoZXhJZGZn?=
 =?utf-8?B?OVRoWVJjUWdBMy9TMnN2YWNSSlJhcCtTTnY1UmVjeTB0TDNCb2tkNkFyWGtM?=
 =?utf-8?B?aU1RaStCNkhydmtlMDJUOE9tWnVQdEh6WGlpZnoyWGN0bWhSNkZYRGE2UjV4?=
 =?utf-8?B?Zi9qaVJ0aUNIYVczZy9DaHEvOHU3SEczdEtWR1BodUJhUlhZYUg5ZmlPOTVs?=
 =?utf-8?B?QXBGOFFRL09rK0JJVTVrR1VyeE5iR0tOdEgxQlVidWhaOG5LcGQvTXRSbloy?=
 =?utf-8?B?bXdGd0xvMG5Xb3NVemNjcEhLUkZTNXFkS05rY3B6cSt2Wm0wQnJYTXBOcVdQ?=
 =?utf-8?B?eHBvb3BZbzd2dVlqZTFMdHFPWDQ3Nk9qZzN4Y0NVWDYxbWVyVm5XK1dvbEZC?=
 =?utf-8?B?anp3SFpkalQrWkhVcUlLaVdmQVhIY0VKYXBjL2NEVmhyOUFMSVZIclIzQTlY?=
 =?utf-8?B?NWJJaHJLbTE1QTl3eDBKbjQwOFNnUXZJRkMyenh6OGlZTnd6R3E3VUkweGlF?=
 =?utf-8?B?Ykl2dnhpT0I1bDA1TzhMMVFXdEdsUi85cmlFMlFTOEdwQ3o5NFQ3UDZVc3Av?=
 =?utf-8?B?Y0duakQ1dUgyNHpRU21hb0RnVUVKa0ZKLzVrSDBVZVRiOURvL21IdmtRYjBN?=
 =?utf-8?B?L3BTckR6V29ENEMxM3VIYzc4RktXdWorWVovMlc1WlNCd3piOTgxNVp4VUM2?=
 =?utf-8?B?T25wYU5aL3FBdElKQXRjNUpBMlNjbkI4TnBZSE85N2tqK0FFYWltWTNQMURZ?=
 =?utf-8?B?WUtoTnc3eGVtV1lmN3FXL0lEaTBYelcyTUZ1bFc1MWEzRTk0K2NiN2k0T3Rw?=
 =?utf-8?B?Yis4eWZPWFI3UjU1YmZSaUpCNVVqRWdTNVJCcThtK01USkF1ZDdVbUZ3S01Y?=
 =?utf-8?B?S0pVMTdLOEcwd3BPQ1F1Vi82dUxUVUU2aXNoaktmeTBsMDB6Z3BVSWoxaG9y?=
 =?utf-8?B?dzAxQmtScFdFcVlGelR4QXAzTVpBY2liWEFVWXUwN1YzR09INFBvZS9sMUxm?=
 =?utf-8?B?VktlU0kwVlBoNlRPRjZCUG9Fb1lNQlhCbkVaZHdSbGhiUlFxMzBybnRaaXBG?=
 =?utf-8?B?WmRiNjdJZ2pIQzdabERnSFNpMEMwRjdJd1hocHpWUlF4Y2F3Q1R0UlEyTERC?=
 =?utf-8?B?UVpMOFdCcGt5bUpHaTQ5YUdySzBDS1RZdkpNcTcrelBkRkxLRXIrZFl5SHZG?=
 =?utf-8?B?R3M3aE5kVGtWZkRLdjNFRWNtankzUVRyVjV3aEpRUDNMajQ1UEdHOTJaWUZM?=
 =?utf-8?B?b3ZXM1BSRm5sTzdkWlpyUmxhVEE5U0hVV3UxelI5OWFueG4yOForbkJibDFN?=
 =?utf-8?B?citwM09TZTJ0czVhcWxuYTlGcU54SFgxUVRKOW9vd3VySUdVN245NWxzc1BI?=
 =?utf-8?B?VWJralRvN3Jmbzhicm04TTRBMElWd1VGMG5QTndhSEkrODNUU09acHJoZEpw?=
 =?utf-8?B?c3h0ay9oVytQeUlnM3MvdEpFK2FyOEJ0QlBwM2FiRUlPbXRuWTlFSW1maVNp?=
 =?utf-8?B?MWg0SlZCaGpHYUt2V3VvdTRQUlVLWjZSQlVoUFRkVEt5NjNVUmRZRE1peWNa?=
 =?utf-8?B?TU4zdXMxYmpoLzM2MDFlQ2R4V201SEVHa3lCZUpPVmsrd3NuN0xMNEVsc1Qx?=
 =?utf-8?B?ZktnVVAzRUpFTzM0ZVJuSUdRelB5enpSWkdLOXNjelVTVm1JVk9RNE9mNGVK?=
 =?utf-8?B?VS9IYlhQdElvRU5PWWh4V21rYkxlSllRdm9TdGhBcnM2SGhRT044MXB3MVNh?=
 =?utf-8?B?NzZFbWtlV1FVb092M21mb0kreU9VbEJZVG9BYWxwd1J4RWJKTHBJSkJmMGJ0?=
 =?utf-8?B?b0s0M0ZqZWR2WFB5dksyV0djUjFlT0FZVGhxcXl6bWd2M05EQ1BKU2pRVHBC?=
 =?utf-8?B?MUNJRW9DYStEQ3VaZzVqUSt4Z0VScGFtRTZNWVFhZ2VsaVRWWHFYa0VyNWh4?=
 =?utf-8?B?dDNGeGlVaW04NnRaejc1L1dWMVBxV2ZUaFlRQXdVVzVRQ3BPOVZ2K0RLeEpp?=
 =?utf-8?B?bGpadG1QSHlsRzR6TWpVZklqcDdhWkh1RFFYYjdoejFqOEtYYWY5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ebcf86-0550-4dd6-d3da-08deaa79556c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 07:38:43.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVVnEPahdzliwaNSTUbL2Q3DIkf7q47kSo3RJYtfFGk3dYsxnbvuMO1hMLtDeWNP+mlh+6oq/7+iPj8qyna5ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
X-Rspamd-Queue-Id: AC5724C818E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-10217-lists,dmaengine=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkumard@nvidia.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+]


On 13-04-2026 12:15, Sheetal wrote:
> Add dev_err/dev_err_probe logging across failure paths to improve
> debuggability of DMA errors during runtime and probe.
>
> Use return dev_err_probe() pattern consistently in the probe function,
> and dev_err in non-probe functions. Also convert existing dev_err calls
> in probe to dev_err_probe for consistency.
>
> Signed-off-by: Sheetal <sheetal@nvidia.com>
> ---
> Changes in v4:
> - Use return dev_err_probe() pattern in probe function instead of
>    dev_err() + return
> - Use dev_err_probe consistently for all error paths in probe
> - Convert existing dev_err in probe to dev_err_probe
>
> Changes in v3:
> - Cast page_no to (unsigned long long) for %llu to fix -Wformat
>    warning on 32-bit builds where resource_size_t is unsigned int
> - Remove redundant dev_err for devm_ioremap_resource failures since
>    the API already logs errors internally.
>
> Changes in v2:
> - Fix format specifier for size_t: use %zu instead of %u for
>    desc->num_periods to resolve -Wformat warning with W=1
>
>   drivers/dma/tegra210-adma.c | 52 +++++++++++++++++++++++++------------
>   1 file changed, 36 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 14e0c408ed1e..1ced5b37d0d8 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -335,8 +335,16 @@ static int tegra_adma_request_alloc(struct tegra_adma_chan *tdc,
>   	struct tegra_adma *tdma = tdc->tdma;
>   	unsigned int sreq_index = tdc->sreq_index;
>   
> -	if (tdc->sreq_reserved)
> -		return tdc->sreq_dir == direction ? 0 : -EINVAL;
> +	if (tdc->sreq_reserved) {
> +		if (tdc->sreq_dir != direction) {
> +			dev_err(tdma->dev,
> +				"DMA request direction mismatch: reserved=%s, requested=%s\n",
> +				dmaengine_get_direction_text(tdc->sreq_dir),
> +				dmaengine_get_direction_text(direction));
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
>   
>   	if (sreq_index > tdma->cdata->ch_req_max) {
>   		dev_err(tdma->dev, "invalid DMA request\n");
> @@ -665,8 +673,11 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
>   	const struct tegra_adma_chip_data *cdata = tdc->tdma->cdata;
>   	unsigned int burst_size, adma_dir, fifo_size_shift;
>   
> -	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS)
> +	if (desc->num_periods > ADMA_CH_CONFIG_MAX_BUFS) {
> +		dev_err(tdc2dev(tdc), "invalid DMA periods %zu (max %u)\n",
> +			desc->num_periods, ADMA_CH_CONFIG_MAX_BUFS);
>   		return -EINVAL;
> +	}
>   
>   	switch (direction) {
>   	case DMA_MEM_TO_DEV:
> @@ -1029,8 +1040,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   
>   	cdata = of_device_get_match_data(&pdev->dev);
>   	if (!cdata) {
> -		dev_err(&pdev->dev, "device match data not found\n");
> -		return -ENODEV;
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "device match data not found\n");
>   	}
>   
>   	tdma = devm_kzalloc(&pdev->dev,
> @@ -1056,7 +1067,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   			unsigned int ch_base_offset;
>   
>   			if (res_page->start < res_base->start)
> -				return -EINVAL;
> +				return dev_err_probe(&pdev->dev, -EINVAL,
> +						     "invalid page/global resource order\n");
>   			page_offset = res_page->start - res_base->start;
>   			ch_base_offset = cdata->ch_base_offset;
>   			if (!ch_base_offset)
> @@ -1064,7 +1076,9 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   
>   			page_no = div_u64(page_offset, ch_base_offset);
>   			if (!page_no || page_no > INT_MAX)
> -				return -EINVAL;
> +				return dev_err_probe(&pdev->dev, -EINVAL,
> +						     "invalid page number %llu\n",
> +						     (unsigned long long)page_no);
>   
>   			tdma->ch_page_no = page_no - 1;
>   			tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
> @@ -1079,7 +1093,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   			if (IS_ERR(tdma->base_addr))
>   				return PTR_ERR(tdma->base_addr);
>   		} else {
> -			return -ENODEV;
> +			return dev_err_probe(&pdev->dev, -ENODEV,
> +					     "failed to get memory resource\n");
>   		}
>   
>   		tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
> @@ -1087,8 +1102,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   
>   	tdma->ahub_clk = devm_clk_get(&pdev->dev, "d_audio");
>   	if (IS_ERR(tdma->ahub_clk)) {
> -		dev_err(&pdev->dev, "Error: Missing ahub controller clock\n");
> -		return PTR_ERR(tdma->ahub_clk);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->ahub_clk),
> +				     "failed to get ahub clock\n");
>   	}
>   
>   	tdma->dma_chan_mask = devm_kzalloc(&pdev->dev,
> @@ -1104,8 +1119,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   					 (u32 *)tdma->dma_chan_mask,
>   					 BITS_TO_U32(tdma->nr_channels));
>   	if (ret < 0 && (ret != -EINVAL)) {
> -		dev_err(&pdev->dev, "dma-channel-mask is not complete.\n");
> -		return ret;
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "dma-channel-mask is not complete.\n");
>   	}
>   
>   	INIT_LIST_HEAD(&tdma->dma_dev.channels);
> @@ -1130,6 +1145,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   		tdc->irq = of_irq_get(pdev->dev.of_node, i);
>   		if (tdc->irq <= 0) {
>   			ret = tdc->irq ?: -ENXIO;
> +			dev_err_probe(&pdev->dev, ret, "failed to get IRQ for channel %d\n", i);
>   			goto irq_dispose;
>   		}
>   
> @@ -1141,12 +1157,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   	pm_runtime_enable(&pdev->dev);
>   
>   	ret = pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err_probe(&pdev->dev, ret, "runtime PM resume failed\n");
>   		goto rpm_disable;
> +	}
>   
>   	ret = tegra_adma_init(tdma);
> -	if (ret)
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "failed to initialize ADMA\n");
>   		goto rpm_put;
> +	}
>   
>   	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
>   	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
> @@ -1172,14 +1192,14 @@ static int tegra_adma_probe(struct platform_device *pdev)
>   
>   	ret = dma_async_device_register(&tdma->dma_dev);
>   	if (ret < 0) {
> -		dev_err(&pdev->dev, "ADMA registration failed: %d\n", ret);
> +		dev_err_probe(&pdev->dev, ret, "ADMA registration failed\n");
>   		goto rpm_put;
>   	}
>   
>   	ret = of_dma_controller_register(pdev->dev.of_node,
>   					 tegra_dma_of_xlate, tdma);
>   	if (ret < 0) {
> -		dev_err(&pdev->dev, "ADMA OF registration failed %d\n", ret);
> +		dev_err_probe(&pdev->dev, ret, "ADMA OF registration failed\n");
>   		goto dma_remove;
>   	}
>   

Reviewed-by: Mohan Kumar <mkumard@nvidia.com>


