Return-Path: <dmaengine+bounces-12056-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zbFXAl+tS2qIYQEAu9opvQ
	(envelope-from <dmaengine+bounces-12056-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:27:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBF9711437
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 15:27:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=m4cNntfW;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12056-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12056-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C0FF3051D3A
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 13:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2496041613F;
	Mon,  6 Jul 2026 13:20:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020104.outbound.protection.outlook.com [52.101.229.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5E3FB7F4;
	Mon,  6 Jul 2026 13:20:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344049; cv=fail; b=HP6gVpLa6Cv7f4ZVTZL9f7RhPCgcseteqQ7kUoiusvI6CUFoSbdWdKrO5mX7uoW3QiL1Z1aLGxAXPF2ag/u+PCoRfpMV+5nbmD3Wr8ulmWRH7+ZHaBcryOiYgxJ3I7YCMGndxBzRdY5b6P3OzpBelfpHTz4XHL9mjruSgLgFDEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344049; c=relaxed/simple;
	bh=g8OeGYbkwQ3DGoA4Sb9agfIU+mYNyeMK2hR19YD3Nzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dOq+GtNm18oL0MgaNYW0XVoY65BoN+SJ+gj/JI1gIH0jIwWXy/RaWYUqgBs0fVyZ5ti77Udsba7NcDIXSrifuNzqRUF0PevupEv2RFzfniu7u4VLRXAguNNoHWeGLKB2OzhsfX9zzaUcdQVeroFiwwDSoEFSFd5/u2lymL7uGCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=m4cNntfW; arc=fail smtp.client-ip=52.101.229.104
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQUPWDrH5mw+sjZerFWLIWiYlgV2TOIFWjJUOTEWceg1E/xfWWFevA00C721p2tUKAzh+nb8hBnRUxFHaRVeWiIOCzyKDjohad2f/eqJbrrsgey39N8wJrYMVGUNDBdIdQXdlQRhPinFvbNvkNYAVsaTZCjYLUaGSBXkEzM41Ih2FrRnCtae2vz6ej93GJhKwENnkSSkztkKMGyQFS2O6BZaMi/A4WfxfSQ1nsVwI5sY74d+HD5hZoqmbmONzv8ba2qYSV+K5GEPR3UzM07N4+F0qfMU9fpdcweO+3HF0vhJJdx/dgI4ZPLlB/bLh2xaXHMFcfv5kPVlun5RhTRPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/iXOOdgdMfxRDLYmcgTlP0PnUI2kVt+61ugHMsL9Ao=;
 b=q2+VAjYUFXGJTXtjZMUjrBIqAIgcHqVPR9T9AC41z4bE6Kd+zYGG3Q2Zy3W+v7Xeb3K0hwvkL+nKzwG4iCVp5DjWzlLCXgDVwS3/HBh6eLPCR6M9kTOew95u1Nx/M7V2FTwNNTbi8McHbPd4qTFJiImzVobmpV0JRlLglSh4V64uwOarJO82KVIjbDSX/+Gef83f1O+ENx6N41maGTSe0JFde3H3oVFTm3Nt9I+ZLBj0tG+HiDSElM85ln2Kdqtk9HH1TmNPVfbeL5N7YkzzmhBxPInl8z1Nrtojz6bfG+rm8o7luNgpwbe/JZW1EhAyzVcHk4BWX0b1j9x+QveWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/iXOOdgdMfxRDLYmcgTlP0PnUI2kVt+61ugHMsL9Ao=;
 b=m4cNntfWGwgNliOP/ypymtoFQEWl+IXLRVeHloDa1nd5U+YDMRSDmltSnLdLfYDmjW2140rJ0E6AdNi3HZqIBzmzmC/0fCquIg04UBCs3V7FvoYX+A74vb2bzqkdxJmLacxl2PgmMOfKJU113w05ifaLelCKEDvejC5Pmy1uBCs=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5902.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 13:20:39 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 13:20:39 +0000
Date: Mon, 6 Jul 2026 22:20:38 +0900
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
Message-ID: <gfylpnuieclkt52xzbcghzaza7oirunstgzfmru7aqpnapdlit@dpgmjrs6ww7u>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
X-ClientProxiedBy: TY4P301CA0108.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ad0e54-5fe4-4750-22b3-08dedb615f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|376014|7416014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6pTIDpnYkBgJqhPuVcqnx62WuuCFrOTf2l/wXbMmPyXGsUxfJ9l/ZGZ1zu3kT9Eyxq1APA2oE3y8JuwV7MwfcqpKsCbafjykYBfDkiTfqdrpBq6fTvfSGWvGkDfXri4a6pwFGYRDUW4tqrFJm0rec8FOE60dQhPcYWegyRdDy9aCggRs2tG+6tHOOM+V9WX9qbnEAG06XUb9J19cva72pgIFFWkrP0lhOMCjPmJY5Ap6YyJyZwP1pKNDmd03BRtR2iz52J6sCnDiNDd2P2NX+CpRiEBYiwbBeyHo5O8Npta9Y8Kn35TlcvvfmSMVAFLSRCHq7oR1nJzOaC7vm5NWzybrbP80q5uAquA91h53J88iAHWKRTSKpDh1/npNsJwvW8yJ0LwcxW6+6YxHauVmJwT8VPhvBRBpmHlmqVAbI7Rvnl8iOs4gDgWqd3AUjAsSRSm7OzAV3WLgP9UXIeeMX1ZtGR47MvlcArZ8DuomhkHgCj43/drFEkcBmJ0runD9ggaIE6RzFT94d+8q4CyNwR7fvQ+Wz9TNkAZkhByEW4NNo+ay8AINj4UfU1tmdv31kcseINdIqQ7RpnRHRywpH31Qvim/RInC7Bjb+UPJq7BoB0oGTutypJrTFtsRsoiSVAFiV0rpflf3YXkvMZOVz11A9z09X4dbqqIs0NAIg+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(7416014)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzgxNjdaUm9CUnVyUzZKV04xNG45TjNMZlY5M2VmUGNuaFduaDlFSS9KV0Nr?=
 =?utf-8?B?ek0wRTlOcCtxb3hDUkVYNVhSc2tHQmo5NEdyckE1WEN5c1dncUFUT082K3hl?=
 =?utf-8?B?TmpSeHN1NEZibFJ4U3Y5UFJKYjNDcXRYOHVrVE9EalJzZUZxZnBBZzZOV1JQ?=
 =?utf-8?B?QWpycmx2b1dSYzk4bmdLT3JmWGhtZGxxTVF0SUp0ejNUaDlJV3FscUQ3ajB1?=
 =?utf-8?B?R0xzSjFtRUk5dS9zamRSNDlTSEtpYWszRnVMTEZZZWlDemxTUzVQYkVBZXli?=
 =?utf-8?B?SGNOdmk0NDd0NFEvYWpFTm5jb2kwV0J5SjJVY3RQOVpWOFJIa2x5QjloYUJz?=
 =?utf-8?B?RXdCRTV1Zk1aWFF3SGhBcWs4T3NodndBaU5xWG1obUZPOGJrUTFPZVMwK28x?=
 =?utf-8?B?SmwvQnJuTHJxYUFQdVp5c3JmNXRLMEUwSEgzZTh4SjMwang0WDhHZE15bTZS?=
 =?utf-8?B?aGFVRWFxTDFRRjNMSXZUNWQ4TEV6MWlRY3c1RW52b2llSkxxVzBSM2M2RUxH?=
 =?utf-8?B?QTFoRXVFQkhRZkNRWUg4a1N0eVdVM3gzclU4MmsxZ2FXeCtiZjBPeDIwUmd5?=
 =?utf-8?B?M3pPZU5HTEZUL05MTnZiVFBmZ2ZlVmNBYzdwWE9ESDE2ZTIvR1pndUdkQ0NO?=
 =?utf-8?B?ZUFiOUo0RTJ5c2lNcDdIUnFFbmwxNFBBamtlSzJLUW0xRjBkd1FwclFBa2cw?=
 =?utf-8?B?cWQzQzFCaXFLdyt0ZVc0SERrTkxDUXZmWXJteVR3VmplY2JxSnA4RUJkMitN?=
 =?utf-8?B?M2dPaWRMNmpGMFM4NTRuYWdXN3hWbFFxT1pIT0xTcW9ZTEZnZEpZalBsTjR3?=
 =?utf-8?B?S3pubGd6bkRkQk9aNGt6UGR3RFI2TUk4RnBva2VwS3hDRjB3V2I5bUgyWWlE?=
 =?utf-8?B?VCs4NGQ1OWcwU0J1bnJySjNpRFZrZTVNLzVkMlBPMHJZQklYUTREdk5VSHVW?=
 =?utf-8?B?UFNVZ1dLdjJ5cXRpUzBySmtvUHpaengvM0JsWnp4N0FHWUl2bDB4OWxnNlBC?=
 =?utf-8?B?c2lWYlE5TUd2UDlTZy9yc0tVcEo1Z1dyRXJGUmNnd3YvUVNvZ0lHSi92YXlx?=
 =?utf-8?B?V2RkOGxOREFQNkJWVzhCWXE5R3NDaXlPVStQMFNYVUhiWHNYb3dXTkxWM2pN?=
 =?utf-8?B?WjRkTFlVQnJFNEcxbVFlWmUzLzFxOWNpN01uNS9CMnB0OU5MUmUxZ2NJd2Mz?=
 =?utf-8?B?QmcvcGd1V1IyZHVieEpJTUt4dDRKckU5MmIvSW5adlN2b0VteG5GcERlOVpE?=
 =?utf-8?B?bm5ieEQ4L2pPb05RcUVHWnR4WWczM1IwKy9FTTBGSzJvSU5ldlMyQm96MzFn?=
 =?utf-8?B?Z0N4alN3RElhRmd3cEh3aVpvMVhJWDBXd2daRWNBOThGVW5Wb091bXlNNEJI?=
 =?utf-8?B?TmRUK2VsaFFOWmh5Q3ZvaWEvWUp3N3hYTHhuU25kQ2M3UHVQSVZMTjJWN2I1?=
 =?utf-8?B?bGo3Q1F1SjgzUEkvZlRvVE9IeEtyN1NKY1dYMDNRWTVtclBGVVZvRzljZkZ0?=
 =?utf-8?B?L0hmckhXamY2eDFJTy95cVpYRHo2alVCb2REVGxYOFNkMFQ3V2dvWStsWmVj?=
 =?utf-8?B?R3RmeVplV0NON2wzZzNRUlkzYW1YdHUzM0l5NTY3ejZWclcwNm5iUEFPUVFx?=
 =?utf-8?B?QjN3Y1A1VDZqeEFqQ3Uzd0ZVeERXUnBpMWdkTFBzMVN3SUpYaE0rQVdvcTg2?=
 =?utf-8?B?RkQ2eWxIU2d0M0FMNGpOTkdRYThHZ2xCTDc4cE5Rbmc1cm1WNThvRUNncy9m?=
 =?utf-8?B?SEFSbjFabXFnbnBEQS9TbmtPMExjTXhYUnFYcFl2WlovaVBYamZpdHRxY3Yy?=
 =?utf-8?B?Rzk4Z3FzSkwyR3ZkZUpCY3JoMWh2elE1S3dvMU1Qa1lySGNtVmNIaDJwMm1G?=
 =?utf-8?B?SGorLzBBV0o0RERaSzJ6Qjd0RUJ5d0RSeHJKZWJGelJObUpDaHRiRGNrb09M?=
 =?utf-8?B?d1d6S0lIQTFNcmxBZmFKWWVWU3ViVUZUczRYM1ZMTUQ3QW1EaVdyZGtYeUZu?=
 =?utf-8?B?VXZ1SnUzL1VlbUlRNDFtY0s2azF4L2JZWVJqOFlQTDY3N2ViVHU0b1FvOFky?=
 =?utf-8?B?M1UydkNhaVROLzdIVjlGbmdoMy9Hb2lkQzVQcmdmWEYxR0xkZHpvZC9LUlRi?=
 =?utf-8?B?Q2hKbHVpNUhtR25Yc1l1WVNNTGZyYXV4bWlPcG1KeHQyU2FtU2VmNTU3dDNP?=
 =?utf-8?B?bDZSVWEyTVBXdWlnTzc3NnZDY0I1SElid1Q5cnFQbzA2bjc5RkZvVlloY2Z3?=
 =?utf-8?B?VC9VUVZKRnpMVFFQN3UvYXFTMm9sN3BvUmZlcWk0TnJaVXlvT2dIbEJQMVUy?=
 =?utf-8?B?Q2lQL0tQSXpoa2FJRmNqclhGNXdYWVErMVhxWmVhNjMrN0lFa3BUeTlLeXhU?=
 =?utf-8?Q?Eh85Uw9af9c0RHUV4Rrsz6PKTjZV5E0M8aVF/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ad0e54-5fe4-4750-22b3-08dedb615f4e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 13:20:39.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHPT9FZBrhA4+tLW6ZzHjVHK3/yWJMl61D8Uazl3QVpCZ25Wyq06bLr0b02MU29/HlziIBji0f8USeOmZgWKNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5902
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-12056-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dpgmjrs6ww7u:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EBF9711437

On Thu, Jul 02, 2026 at 05:21:20PM -0400, Frank.Li@oss.nxp.com wrote:
> Koichiro Den:
> 	My hardware temperately is unavaible recently. Can you help test
> it.

Sure, I can test it on my side. I'll report back once I have the results.

Best regards,
Koichiro

> 
> Rebase and compile test only now.
> 
> Verma, Devendra:
> 	Can you help check if block non-ll mode?
> 
> Frank
> 
> Basic change
> 
> struct dw_edma_desc *desc
>        └─ chunk list
>             └─ burst list
> 
> To
> 
> struct dw_edma_desc *desc
>             └─ burst[n]
> 
> And reduce at least 2 times kzalloc() for each dma descriptor create.
> 
> I only test eDMA part, not hardware test hdma part.
> 
> The finial goal is dymatic add DMA request when DMA running. So needn't
> wait for irq for fetch next round DMA request.
> 
> This work is neccesary to for dymatic DMA request appending.
> 
> The post this part first to review and test firstly during working dymatic
> DMA part.
> 
> performance is little bit better. Use NVME as EP function
> 
> Before
> 
>   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
>   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>   Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
>   Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
>   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
>   Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
>   Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
>   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
>   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
>   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
>   Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
>   Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
>   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
>   Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
>   Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
>   Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
>   Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
>   Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
>   Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
>   Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
>   Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
>   Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
>   Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
>   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
>   IOPS=261, BW=132MiB/s (138MB/s
> 
> After
>   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
>   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>   Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
>   Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
>   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
>   Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
>   Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
>   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
>   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
>   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
>   Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
>   Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
>   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
>   Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
>   Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
>   Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
>   Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
>   Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
>   Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
>   Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
>   Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
>   Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
>   Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
>   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
>    IOPS=266, BW=135MiB/s (141MB/s)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v3:
> - remove patch dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
> - rebase to vnod's dmaengine topic/config_prep_api
> - Add non-ll-start() callback to handle non-ll mode transfer
> - Link to v2: https://lore.kernel.org/r/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com
> 
> Changes in v2:
> - use 'eDMA' and 'HDMA' at commit message
> - remove debug code.
> - keep 'inline' to avoid build warning
> - Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com
> 
> ---
> Frank Li (10):
>       dmaengine: dw-edma: Move control field update of DMA link to the last step
>       dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
>       dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
>       dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
>       dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
>       dmaengine: dw-edma: Add callbacks to fill link list entries
>       dmaengine: dw-edma: Add non_ll_start() callback
>       dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
>       dmaengine: dw-edma: Use burst array instead of linked list
>       dmaengine: dw-edma: Remove struct dw_edma_chunk
> 
>  drivers/dma/dw-edma/dw-edma-core.c    | 216 ++++++++----------------------
>  drivers/dma/dw-edma/dw-edma-core.h    |  65 ++++++---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
>  4 files changed, 302 insertions(+), 388 deletions(-)
> ---
> base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
> change-id: 20251211-edma_ll-0904ba089f01
> 
> Best regards,
> --  
> Frank Li <Frank.Li@nxp.com>
> 

