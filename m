Return-Path: <dmaengine+bounces-12118-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kb/BBIVtTmouMgIAu9opvQ
	(envelope-from <dmaengine+bounces-12118-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 17:32:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 756FD72811B
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 17:32:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=PmovbEYB;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12118-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12118-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4964530E5722
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9EA47AF57;
	Wed,  8 Jul 2026 14:59:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021123.outbound.protection.outlook.com [52.101.125.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC94C6F17;
	Wed,  8 Jul 2026 14:59:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522768; cv=fail; b=g8PVmaztw0u7Jnjtn1702Hrfp9YVhGk8kvA5dHOAc4VlExyLO0GG7xSYLaBzlvpTdug4/gkTEMYEtaUHEyKbN8nh1BJMS/RzlW5nKMn9YODLuoQuRErecRgN5fl6yIWHItvG3pNJBQvaDrZAqs6u72RnSgr99Fm4hQJXETNNcBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522768; c=relaxed/simple;
	bh=eNIKwONsp71McZJNBY1dVB+jS1MbHIo8s1WDvgvYwjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LWAbuh2rTLqMTILyfowK/GfhaSoDxRrAIzhu95/DfFKCxhuPSzYxMF79CjkxSquVa/szkFPKIJZbdgG+4QG+DQukOmZ9+LB55qlpzf2vBVPjPrEqfUV7L1/nHUemPfoN7UKTL7326Kpy+Kh1BUC1qYM2zuLyNdwyjvsmLXwbqnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PmovbEYB; arc=fail smtp.client-ip=52.101.125.123
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/ZHIak4yIFchA7PedijbD/XEoapTMETACyp9Nc8m7HUc/Cydg2c8XwMgTwYL5TT4m4LUSK+05PJRd+OvIgX5Bl17QDAe4pgmSbK4G7HzZX6aLrBQQvSjTXLXLxUu9eTqtzPBJBUF/J+sHdYe1TcHid1RU7AZlY5YILZF15CBO4L8xGUZphcznocX6gad78nyusjMfZWEJwIwJB3Xb0MEVqIHq2VmihD9vY6151gTKMpK8HgtuySGYQuZojFS0/BGR5WQp2T4IaoffEbDcsDZAaeaG7FIbqt+TT6h1zTtBsfqb4ANZJ5MtVmHzu3kkcXVNVaK8KRlXlBWrd8yQ7rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ7gHoOpTW5FUvLG5q0wLKL/3AqrhvNpgjdxkKlT0w4=;
 b=r4z/yY3bEdh0Q7wJGc6EV0ec5Oagx9t+e0xSSJ8yC3A+mVwIe9CQDASBfwlNBOo47SmbIjGZEc+vNScnxYOkE1TBdzkadbYrQMNDNmA4VfuUI40+I/UApNxpBhiYd0FwoCnAjVSYjNRl6h8x6MsONQd6Yc3W+avwC2XA4MI8nH2S4QNHSkbsobfJP8tqhXfX53sSQx4AhwR4ZDbosO7Y5dpYIOHfa11OWpA9NQavwpw4ubB9ADANKOzFH1A576kchrUJJdha9uuLibUwS8OK+2yTbhlTRQEO+UPCb9d11/xI6Eg24TNiffLiXZjwSE/OfnRPiroATZ4wdS9cKXlEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ7gHoOpTW5FUvLG5q0wLKL/3AqrhvNpgjdxkKlT0w4=;
 b=PmovbEYBn53MpL/7NWXsel4ac2QP8kujy/bc6/7hnz4B+ykqPnIXr02Qz0ndi57DM1tf6vuJs4skUhegvEuEzLdi/jQP3EcDhWMsp0gzR31Ij1csz4VUAk+86sKtBut0S+XPZsduUoZuURF/AKDtlz6IO5wTvNderAwZATdbHXU=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB5531.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:36e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 14:59:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 14:59:22 +0000
Date: Wed, 8 Jul 2026 23:59:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@oss.nxp.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 00/10] dmaengine: dw-edma: flatten desc structions and
 simple code
Message-ID: <2z2ba5kwgtyjzipkhxqf2jxjscerbx35ep7jndedv5zk6l6xwk@esy2ayjyhcoo>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <gfylpnuieclkt52xzbcghzaza7oirunstgzfmru7aqpnapdlit@dpgmjrs6ww7u>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gfylpnuieclkt52xzbcghzaza7oirunstgzfmru7aqpnapdlit@dpgmjrs6ww7u>
X-ClientProxiedBy: TYCP286CA0086.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB5531:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fc028d-2a98-433f-8318-08dedd017ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|23010399003|1800799024|4143699003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jL9g+AQuXa85tCT02tZ3w5JApEPodmMPX/JhTQVY/O9pZCvysVcPyCWDrBrlaGQTOVydCvTFl7dyEaRlcqG96rXXBuXEAt2d+/eEhcrWlpGSFbNyZioFlSnxXJK2yHUyp0XdLKQ7nVpq9hYYp1fORvm4vAStWnFZEiOcHQreY59u7D5Jmyi0IWCgBVLXdCsyO+oD6BgPvkZWrfvEeeLwjuUovbMf1INZcI2vY8wGDhvtMkUtQyzk3fcnrNDBDB9h/FOy/yLWjgwDxINUwkylHttD4B7Ee9RNaLuDHg38NtUsBriFvM2CU2hdFGsw10eCIgSju+2LMM9K3S5QZ1kyLSLd9JCcKJGx19tB9VaI2SHYL+tHfzJTxaFxfHHBrDf0zUw7kxsleKy+B7KGQNi8o7AbeVtLaAhLsUF2Pz2OqzNRv7b4Ruy5wsUoqYWyPOROiXXPN/peMwSdDR4v1raDRFeLwZLd0S7/mDUKkwOH/1SxfU2MLc64qJyAnH9l2SBG+Ra12Tw/Wvuj2xsAxaanKcrVOiml2+blpxyooKrFaFWr+1XWbbrKbWBO89hCKji4CkeeDVnLc+DQed1DTevSvT2mMQ3VDouQR+hXeCXjZJPLcsYKsAm9qm0RV+121HXCR5GD3PKS8eR19lj4gVpiqB7bjacf4eTwxC6MeF4Nhjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(23010399003)(1800799024)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXpHMTNyaDlyK1Zlc2xHRkk5QUpvRkI3eHZBbmVwdnROTVpzTDB6Ty9SZXRt?=
 =?utf-8?B?cmxxcGV1ZnBsZXdNUGkxelJobHVaMnQ2RnNiZUtudldZUUNvWVlEVnc2aUdL?=
 =?utf-8?B?SXY1NHBCNlhENnh6bWx2WmtGQzBWK2ZtYW03OWp4TERIc0xWRzR4bS8zOS9O?=
 =?utf-8?B?dndMWVBuT012cXRUVUhXbFpEcXFaUEZTbWc2RFozY09uUmNSYmptT01keGYz?=
 =?utf-8?B?VVRid0w1YmxTaDQxdXdRTDV1NSs2U2Q3Ymd0ZUFzNHFOV24reDN5dVgrYUxL?=
 =?utf-8?B?QkF0blJ2NUJXT0llQ2VPRmhla0NBR3Q0aCtCcHdWWjFJL0E0dktaaVFlbjJl?=
 =?utf-8?B?SXdkak9aZkFWRjJ0VzRveDJ4OFhqNXIzNkloVWJuMTcrS2Qrb21qSU9iZlVq?=
 =?utf-8?B?UkhNbDE5WEtZcWhZTzN5SDREVjdiWnBNUU9sb25PVU9Lbm5nbU9aRnlqR0o3?=
 =?utf-8?B?U1A0bGhiUzhqdFVuUVUwNGhXWW1WWHVjQkpER3krRDNTTmhCRjhlUE9IQm1T?=
 =?utf-8?B?WU5jSHZ3WVVBVGRuWDdSV2JBc0RFUWNpSDA5TkIzaGpqRzA0SHN3VDIySE53?=
 =?utf-8?B?ai9HK0hiUnpwVE9MdUMvNlVTMnVKTnEzcm9lSllJb3luZHVWOGFhdlZaaFRa?=
 =?utf-8?B?RFlsajA5UWMzaGMwTEpUNXEwTGRjTzhOZm9BMGtnSDdUSVhCY1h5SnpqVVlI?=
 =?utf-8?B?WVlqWWJqUFc0OWcyNzdzbFFhTmFvaGtBb2hrYkZyeVBtZVREeG1DUDZ1VExm?=
 =?utf-8?B?d09CbzZnWERyNmp6aEFUMU96Qk9jNXgyMllTOTlkaCt6VVFIT3JLbUd5K3hE?=
 =?utf-8?B?ZU1WS1R4cE8yeFYrVlpxY3RaeTZNY0Q3c1V3bGNPL2dyVUtBVDlBTGIwSUNF?=
 =?utf-8?B?czBCdGhiU0x6c2hENVNhUWg4cUNhZlFYbUY0OFhMZzF6UmxEbXdZUjEwelRt?=
 =?utf-8?B?OGpnNGpLRGk4VDRLeXMwZmVtUTMxdWVkZ2E5Y0ZNRGlTUVlkdXJBcHpRZW95?=
 =?utf-8?B?QUtXTXA3Y25LaUN5bWptM2pvUkVzUWVLeFlvdU53bThPMXZaMTBENWppTkY4?=
 =?utf-8?B?c2FQWThPWEdLMklJR3BzRVNBazZsT3Iva2JHQXEzcHZiYlFlM1p4V2tWblFR?=
 =?utf-8?B?WkZGZmJHeXFOR2IrQjNZMWZxRWFpbVBjQlh5WVZsZmkxaUQwN0dRRnBKYm91?=
 =?utf-8?B?RUY2ZFgvY280cWdGMVNJaXJvTzJMNmRSWkFVUHRicmhyelArbXA4di9FOVJr?=
 =?utf-8?B?bUpCTVNWeGRsNXR5c2lxWEFPRXZMSkErbGRUeFZmL0tSaklvZlQ2L0pIWnlG?=
 =?utf-8?B?bFFZZXdXRTlLMHE5L0dDNkNnWXByRXlKaWNqY2FPSFJEaEZpL0FJUldURm1q?=
 =?utf-8?B?akhKNldlQTRKb1hUalByeXQva2Jyell6c0tIMGk5OThVZ2s0YVhMVGdhM2c2?=
 =?utf-8?B?RmVEZjdlUjVGbDVNNmFVdE84c1EzZlBTempPQThCUExFVjB6NFQ4K3ZJa0Z0?=
 =?utf-8?B?bkJSMno5QzNPU3JLOVA3NjJBWDV2UlRVSWlVcUtLZVFVblFEQWVxY3Z6dkx5?=
 =?utf-8?B?TVR2aWdxUDBWNFJRWmxBWnBtWktmSlg0dC9DVXVwWTJVWnl5aE1lNHZhMHNl?=
 =?utf-8?B?M0FEeDBkOFczbGVjaHZmdzgzQTFPMFNreWh6bkR5ZWZ6UXIzcVVYS3ZBdG5x?=
 =?utf-8?B?cnhRcjlTNk5sYjh0ankyeXhFMS84UngzekYrdHJKN2thNERqeEx2TnQ0R2d5?=
 =?utf-8?B?YlMrMXFBem1pVlZpTzZWZGJiSzkzRXJMcnRBODBmV2I3Qll1UWlaK0x4Z1Fq?=
 =?utf-8?B?UlVWOHR5MlJ3Um1rcnovY2crU04vNkpYTkVvZlpUMGFlcVMwUU9ZVTRIWisv?=
 =?utf-8?B?RHlaaEN5Q3VVWmhKV0NuOVhFa20xOEp4Wm5KR09tYkViZndEUmdkVHZXb3dZ?=
 =?utf-8?B?Z0dQeEdFUVR0TndsTzl5YzdVTTRYeGpUSkJNYmJyOTlUZWhXZDF4b2gwb1ZK?=
 =?utf-8?B?UnhMaFVncVJScUQzLzFaSFBRWHowaUVMamlqcTNtVFVXQkc0YkVrK1lJT1c4?=
 =?utf-8?B?UHIzVWQ5Y0Q3WUZ1cGpmS3pJd1Z2TmViM1RGN3VXZW42UzkvM1BkaUYrZ3V5?=
 =?utf-8?B?OHF0K0dIdFdBMDR3Y2xSOGVaZEFjeW1rNHZKaXNSWVJZcmpUWXpDZzhQQkRW?=
 =?utf-8?B?UWJxQS9MbXM5Uzc5aStoUUE5SWMzTm1BQmN1a09qUkJ6aUdpK1dlcUR1MHJU?=
 =?utf-8?B?Nkh1M2JQVXZjT2ZpaHlTYzQ0QlZxampIeS9HSlVJZTZBUHF1OGJuK0pqSkhJ?=
 =?utf-8?B?V0RtV1VNa3UvbGtPVnozM0F0VjljRnNpbHExa0sxSFVzY1RpVnZBbUZIU29a?=
 =?utf-8?Q?rOqA8oPhHK4YnNR89q29VQ9x5/K3gKPW3zJEO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fc028d-2a98-433f-8318-08dedd017ed9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 14:59:22.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHQmcly1LYJ7YJB7Lx4KuAX3ilWL5DXSM+kBfAHE+3THkUbZHkCW1UET295l4dL2WvAuGmXEf0wVZ5cTKOZ2jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB5531
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-12118-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,esy2ayjyhcoo:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 756FD72811B

On Mon, Jul 06, 2026 at 10:20:38PM +0900, Koichiro Den wrote:
> On Thu, Jul 02, 2026 at 05:21:20PM -0400, Frank.Li@oss.nxp.com wrote:
> > Koichiro Den:
> > 	My hardware temperately is unavaible recently. Can you help test
> > it.
> 
> Sure, I can test it on my side. I'll report back once I have the results.

Here are the results. For the series:

Tested-by: Koichiro Den <den@valinux.co.jp>

* I don't see a significant difference between Before and After, but I don't
  think that is an issue at all. Most of the differences look like normal
  run-to-run variation.
* Each full fio test set was run three times in alternating order (B-A-B-A-B-A),
  with runtime=30s and ramp_time=5s.

eDMA:
  - Testbed:
    * Endpoint: RK3588 (Rock 5B)
      controller IP version: v5.60a
      ll_max: 170

  - Summary by group (BW delta %)
    all          n=26 mean=  -2.3 median=  +0.2 min= -28.0 max= +11.7
    read         n=14 mean=  -3.2 median=  +0.2 min= -17.3 max=  +3.1
    write        n=11 mean=  -1.5 median=  -0.2 min= -28.0 max= +11.7
    qd32         n=16 mean=  +0.5 median=  +0.3 min=  -3.8 max=  +3.1
    q1           n= 9 mean=  -7.6 median=  -6.7 min= -28.0 max= +11.7
    small 4K     n= 6 mean=  -4.0 median=  +1.1 min= -28.0 max=  +3.1
    large >=128K n=20 mean=  -1.8 median=  +0.1 min= -17.3 max= +11.7

  - Before mean -> After mean (MiB/s)

    Case                         Before             After              Delta
    ---------------------------  -----------------  -----------------  ------
    Rnd read     4KB q1  1j         33.4 (sd 10.1)     32.0 (sd 10.9)    -4.0%
    Rnd read     4KB q32 1j        196.0 (sd 28.6)    202.0 (sd 29.5)    +3.1%
    Rnd read     4KB q32 4j        196.7 (sd 29.2)    202.0 (sd 25.1)    +2.7%
    Rnd read   128KB q1  1j        497.7 (sd 12.2)   420.7 (sd 181.3)   -15.5%
    Rnd read   128KB q32 1j        2248.0 (sd 6.6)   2277.3 (sd 34.2)    +1.3%
    Rnd read   128KB q32 4j        2381.3 (sd 2.5)   2386.3 (sd 17.9)    +0.2%
    Rnd read   512KB q1  1j        627.3 (sd 15.2)    585.3 (sd 78.2)    -6.7%
    Rnd read   512KB q32 1j        2376.0 (sd 5.2)   2381.3 (sd 21.4)    +0.2%
    Rnd read   512KB q32 4j        2379.7 (sd 6.7)   2386.7 (sd 17.6)    +0.3%
    Rnd write    4KB q1  1j          28.1 (sd 4.1)     20.2 (sd 10.1)   -28.0%
    Rnd write    4KB q32 1j         120.3 (sd 6.1)     122.0 (sd 6.2)    +1.4%
    Rnd write    4KB q32 4j         124.7 (sd 3.8)     125.7 (sd 4.6)    +0.8%
    Rnd write  128KB q1  1j        318.7 (sd 44.7)     327.0 (sd 4.4)    +2.6%
    Rnd write  128KB q32 1j       1080.0 (sd 20.2)   1077.3 (sd 37.6)    -0.2%
    Rnd write  128KB q32 4j       1069.7 (sd 20.3)   1056.0 (sd 46.2)    -1.3%
    Seq read   128KB q1  1j       486.3 (sd 138.3)    402.3 (sd 38.0)   -17.3%
    Seq read   128KB q32 1j        2245.3 (sd 3.5)   2258.7 (sd 26.3)    +0.6%
    Seq read   512KB q1  1j        662.0 (sd 29.2)    594.3 (sd 13.7)   -10.2%
    Seq read   512KB q32 1j        2375.7 (sd 7.4)   2382.0 (sd 22.9)    +0.3%
    Seq read     1MB q32 1j        2380.7 (sd 4.7)   2385.3 (sd 19.3)    +0.2%
    Seq write  128KB q1  1j        342.0 (sd 58.9)   382.0 (sd 101.1)   +11.7%
    Seq write  128KB q32 1j       1080.3 (sd 48.8)   1070.7 (sd 37.0)    -0.9%
    Seq write  512KB q1  1j        509.7 (sd 35.4)    502.7 (sd 39.2)    -1.4%
    Seq write  512KB q32 1j       1043.3 (sd 56.7)   1074.0 (sd 47.8)    +2.9%
    Seq write    1MB q32 1j        989.3 (sd 23.0)    952.0 (sd 57.4)    -3.8%
    Rnd rdwr  4K..1MB q8  4j       841.3 (sd 15.1)    841.7 (sd 12.9)    +0.0%

HDMA:
  - Testbed:
    * Endpoint: SpacemiT K3
      controller IP version: v6.30a
      ll_max: 170

  - Summary by group (BW delta %)

    all          n=26 mean=  +1.1 median=  -0.6 min=  -4.4 max=  +9.5
    read         n=14 mean=  +2.1 median=  +0.7 min=  -2.5 max=  +9.5
    write        n=11 mean=  -0.1 median=  -0.8 min=  -4.4 max=  +4.7
    qd32         n=16 mean=  +0.6 median=  -0.8 min=  -2.5 max=  +9.5
    q1           n= 9 mean=  +2.0 median=  +4.4 min=  -4.4 max=  +7.9
    small 4K     n= 6 mean=  +4.8 median=  +4.5 min=  +0.2 max=  +9.5
    large >=128K n=20 mean=  -0.0 median=  -0.9 min=  -4.4 max=  +7.9

  - Before mean -> After mean (MiB/s)

    Case                         Before             After              Delta
    ---------------------------  -----------------  -----------------  ------
    Rnd read     4KB q1  1j          66.3 (sd 5.8)      69.4 (sd 7.0)    +4.6%
    Rnd read     4KB q32 1j        300.3 (sd 45.5)    329.0 (sd 21.7)    +9.5%
    Rnd read     4KB q32 4j        312.0 (sd 51.1)     341.7 (sd 3.1)    +9.5%
    Rnd read   128KB q1  1j        705.7 (sd 34.8)    736.7 (sd 51.6)    +4.4%
    Rnd read   128KB q32 1j       1507.7 (sd 25.6)    1486.3 (sd 5.9)    -1.4%
    Rnd read   128KB q32 4j        1549.7 (sd 7.0)   1534.3 (sd 16.9)    -1.0%
    Rnd read   512KB q1  1j         848.7 (sd 9.5)    858.0 (sd 15.5)    +1.1%
    Rnd read   512KB q32 1j       1530.0 (sd 27.0)   1536.0 (sd 14.8)    +0.4%
    Rnd read   512KB q32 4j       1519.0 (sd 66.7)   1544.3 (sd 15.0)    +1.7%
    Rnd write    4KB q1  1j          64.0 (sd 6.2)      66.9 (sd 2.2)    +4.5%
    Rnd write    4KB q32 1j         199.3 (sd 7.1)     199.7 (sd 2.9)    +0.2%
    Rnd write    4KB q32 4j         199.7 (sd 7.6)     200.3 (sd 3.2)    +0.3%
    Rnd write  128KB q1  1j        558.3 (sd 18.3)     533.7 (sd 5.0)    -4.4%
    Rnd write  128KB q32 1j       1248.0 (sd 21.3)    1237.3 (sd 7.5)    -0.9%
    Rnd write  128KB q32 4j       1248.7 (sd 23.0)    1238.0 (sd 6.1)    -0.9%
    Seq read   128KB q1  1j        640.7 (sd 60.1)     691.3 (sd 9.0)    +7.9%
    Seq read   128KB q32 1j       1507.7 (sd 24.2)    1488.3 (sd 5.1)    -1.3%
    Seq read   512KB q1  1j        866.7 (sd 45.8)    847.0 (sd 32.2)    -2.3%
    Seq read   512KB q32 1j       1532.3 (sd 31.7)   1516.7 (sd 40.3)    -1.0%
    Seq read     1MB q32 1j        1550.7 (sd 7.2)   1512.0 (sd 32.9)    -2.5%
    Seq write  128KB q1  1j        514.0 (sd 34.7)    538.0 (sd 15.1)    +4.7%
    Seq write  128KB q32 1j       1248.0 (sd 22.1)    1237.0 (sd 7.8)    -0.9%
    Seq write  512KB q1  1j        755.7 (sd 30.0)     739.3 (sd 2.1)    -2.2%
    Seq write  512KB q32 1j       1248.7 (sd 22.6)    1238.3 (sd 6.7)    -0.8%
    Seq write    1MB q32 1j       1248.0 (sd 22.5)    1238.3 (sd 7.6)    -0.8%
    Rnd rdwr  4K..1MB q8  4j        869.0 (sd 8.9)     865.3 (sd 1.5)    -0.4%

Best regards,
Koichiro

> 
> Best regards,
> Koichiro
> 
> > 
> > Rebase and compile test only now.
> > 
> > Verma, Devendra:
> > 	Can you help check if block non-ll mode?
> > 
> > Frank
> > 
> > Basic change
> > 
> > struct dw_edma_desc *desc
> >        └─ chunk list
> >             └─ burst list
> > 
> > To
> > 
> > struct dw_edma_desc *desc
> >             └─ burst[n]
> > 
> > And reduce at least 2 times kzalloc() for each dma descriptor create.
> > 
> > I only test eDMA part, not hardware test hdma part.
> > 
> > The finial goal is dymatic add DMA request when DMA running. So needn't
> > wait for irq for fetch next round DMA request.
> > 
> > This work is neccesary to for dymatic DMA request appending.
> > 
> > The post this part first to review and test firstly during working dymatic
> > DMA part.
> > 
> > performance is little bit better. Use NVME as EP function
> > 
> > Before
> > 
> >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
> >   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
> >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
> >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
> >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
> >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
> >   Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
> >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
> >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
> >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
> >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
> >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
> >   Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
> >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
> >   Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
> >   Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
> >   Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
> >   Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
> >   Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
> >   Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
> >   Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
> >   Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
> >   Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
> >   Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
> >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
> >   IOPS=261, BW=132MiB/s (138MB/s
> > 
> > After
> >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
> >   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
> >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
> >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
> >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
> >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
> >   Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
> >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
> >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
> >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
> >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
> >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
> >   Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
> >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
> >   Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
> >   Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
> >   Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
> >   Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
> >   Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
> >   Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
> >   Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
> >   Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
> >   Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
> >   Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
> >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
> >    IOPS=266, BW=135MiB/s (141MB/s)
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Changes in v3:
> > - remove patch dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
> > - rebase to vnod's dmaengine topic/config_prep_api
> > - Add non-ll-start() callback to handle non-ll mode transfer
> > - Link to v2: https://lore.kernel.org/r/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com
> > 
> > Changes in v2:
> > - use 'eDMA' and 'HDMA' at commit message
> > - remove debug code.
> > - keep 'inline' to avoid build warning
> > - Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com
> > 
> > ---
> > Frank Li (10):
> >       dmaengine: dw-edma: Move control field update of DMA link to the last step
> >       dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
> >       dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
> >       dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
> >       dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
> >       dmaengine: dw-edma: Add callbacks to fill link list entries
> >       dmaengine: dw-edma: Add non_ll_start() callback
> >       dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
> >       dmaengine: dw-edma: Use burst array instead of linked list
> >       dmaengine: dw-edma: Remove struct dw_edma_chunk
> > 
> >  drivers/dma/dw-edma/dw-edma-core.c    | 216 ++++++++----------------------
> >  drivers/dma/dw-edma/dw-edma-core.h    |  65 ++++++---
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
> >  4 files changed, 302 insertions(+), 388 deletions(-)
> > ---
> > base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
> > change-id: 20251211-edma_ll-0904ba089f01
> > 
> > Best regards,
> > --  
> > Frank Li <Frank.Li@nxp.com>
> > 
> 

