Return-Path: <dmaengine+bounces-11567-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QYGLEdTuMWqwsAUAu9opvQ
	(envelope-from <dmaengine+bounces-11567-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 02:48:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93463695DEB
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 02:48:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=lE8C7hCU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11567-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11567-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81F763008510
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 00:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8273A1C9;
	Wed, 17 Jun 2026 00:48:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021113.outbound.protection.outlook.com [52.101.125.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EA134CF;
	Wed, 17 Jun 2026 00:48:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781657296; cv=fail; b=eEWBYIy3/tqneVDUQWMNrT4ABnoUrM1r5OeD9FL3tYGtSw2dtJFG9G7rb0TfRkutkOnMC3j9q/TO3l9NmFLWk7OAtbJp/W+G1Ju4a7cM9jqRdOEMr/vuKVWL1hJyDBvnBQN/MABM+kuWb1Vq1h1D/HwMScEhCFlMMaW2Svvj25g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781657296; c=relaxed/simple;
	bh=p1OZV4kAwiAoK91vlLIYEe6wlely28bmHKj523WCNgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j9NydWTfzn4MWtCJd03G5rKYTM9subnev/38jC6CnfucTV6/ylpK2AElOp2mJD3nM+MMVbq/ubo9CaHIvaqY/mpb+rBQeDUNri0WgLKjFHNY6N0JTEQEFaXO4Lf90NLJ780dHnA3752yL8T88XaF98Q6sme6AdQkiZZUutSD3Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lE8C7hCU; arc=fail smtp.client-ip=52.101.125.113
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8psXrXwmPU9Am90DHiu8jR2Q50RT2iB/WNvv4SteYTAIBZJY6Me8U/r9av5WwrGzmdDEnWXPMo85KjgYGldvHgNd/jYORa+rw3pFX4MVvJelEDgGOdNZhQSR1ZZNsMqoyXzQ40zAZnvIryi82p0g1T4oHyLP+bmE0OaT2zv86slBioswOcJhvRGfpqTOe7cjaXuu2PbXnPY9DAH2qu7a9XPFuRgklY8VUZuz2FRpEBNMgXNaxIcgMpdjQ1tVYOD2Z3A1+pgN6bqXo37wwxVdgXRxSOjn9D9sXJoUrHhQ7sALhhw5MeKvAKL6c6I8+4qL2pVZHcTCYGelDc/cVFuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx2WECHgr2tKUlKTaPwsLlItIFnlv8a1emE2oJnWHKM=;
 b=pafji9y6b+4gffBVtx/pERd7+9ySPNm7BC/USZY9P0n5cZcAIGOcUmeFFLYiXBy3RhJI7uTadRUdsxlYeJ3y2aj1wFnNBm5YrHBCO/qGgwbFra9MuOMPNotnawHCKSwyrN4cbfTNMmcFuKWyWOBmIdWMzJUqw6eRYavkhmasiOsKglGW6Bu9xFywWUaDrn2uDMy1Y+/AJkJYnfCsXxejdVDr4Ywm9cl5MV9j220cefJwuUn0+uI76DSvHGZTNtQJ5HQ8ddZnFlnSj5QbPC5g5pX/TDnnYjUfNFQXq8lXdiveOHa+ju/htwO2PDC42L+dn0q6+Nokez0SPf6FeJdwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx2WECHgr2tKUlKTaPwsLlItIFnlv8a1emE2oJnWHKM=;
 b=lE8C7hCUWZhM4KqoL/L4CuUSvvH/tHz+nxjXiEjmMrEKFGi+Zzd2sJIvl40nqzVMBVSJIowHFS8ST+UvXAD9Cgb5PlssRZvmqLvbf4/ufs9nLvjdi6xGtxq2yCTetVNSRTvxRa7zWXNMUnCoroEsiFPiwhJ59WgpqCdZoXuH308=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY1P286MB3408.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 00:48:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 00:48:11 +0000
Date: Wed, 17 Jun 2026 09:48:09 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
	Kees Cook <kees@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Serge Semin <fancer.lancer@gmail.com>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Devendra K Verma <devendra.verma@amd.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] dmaengine: dw-edma: Support dynamic LL appends
Message-ID: <o3hk5mr5ugtepucgo2zjwabcuii37uf2bd6jcgeq36iau5pyhj@r7vzjddl5f5s>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <ajETw7uwVx_U9o5F@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajETw7uwVx_U9o5F@ryzen>
X-ClientProxiedBy: TYCP286CA0198.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY1P286MB3408:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6c8043-4973-4c1c-62e8-08decc0a1b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OThfHVuyhla7IlqRjJNS8J3GAwPpY7dlSNz4Ea0pHfbhMiICwnF1SbrGP+oSaboqRjnHj98G5cuAMfpWXuh1V9Tc401Hihg9W0p2re+Dj6DHBtYsKOII0akBB6UvgH1mbRfu7y/VgFHXgIwdOAGhKTU3MFVD0fPJNUFzJi+VxyPPVMDXigTNzFdhzxehb2MGt4KA9C/iRZMI0LzNDhhEyuNAr5ASKV3q5P7DxI6w27iNNbsdV2RlijokVJddAP4tMZ4IMZA23k5NTlk2aahDO8DVVpuXXzHnqCMl7+3MBp0vmANJ8odaAT8VvA4a1/EUpeExpN4wWlSFrZ0K91pKK7/KpIY4lhMTDyO0+I4L6QHdbVPRuOYIpjFv+ybEFGD8A7WoFiD5e1N4v6wKTy99GOysh1qWENTPwEESCho0mZmGK8YANqhyVQ1mlzN6CPq0IbzP5PM3gsdT3Yb135aBQPd/dS9nFkd+uspIyVhMKcTZeLuazJmgtlBG7Y3beTOVSmuVp9IbGHvXySFZ6d1EH5bRoYkgvXbNaNFcNYRQ30hbY1c4Kf7kSbcIRpHz8xXWFPNX3QInQpfZU5HMBvQHYNk+qXd8FH1metLv1DjXBfHvrnyBaXgqa+U5HydETj+amGPAOE/nJR0qi23j3fQ2cSItYVqOoEbgIB1j2mXVvp+ZsQZF4grbsjUNyyieWmYO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kgFy2Mg/0xlteR/x0/m3JWlOY2h6t1A1fioeBNutAR30TCscjO41LK9jaBvB?=
 =?us-ascii?Q?rlJtqW+eV5b0E4oGqn5p17iH9ypdupZfIxcnzztt0+iPz7oqEpLcoUVqqIrX?=
 =?us-ascii?Q?l2XBh21md7/GZ3wGLH54RB6BnwAI3XCYzKt/5EEciwZdiAUoBUWm75T2kK3d?=
 =?us-ascii?Q?jriBaDXjaSImzlG57PmK1A09zNmX+tlv1/g+c3vp2M1P4J7V5nMnT8aeDKoq?=
 =?us-ascii?Q?Kszngm4DhbC8gR8EXGgiAxDN1I7AyNDhaPCKjZ9fFd/QSZsInFfJ/dui4eZ9?=
 =?us-ascii?Q?4RAkAENHCmNWCEbdBNtcWpxU1k7gBSI6r3h3OixJKX9r46neTiG+CYSsZLfX?=
 =?us-ascii?Q?IE3ZNHFeiX5OOD86FQIpN30+E/Aiyy/H+stCNX3XR8AFU5gHnnOogngvAnaH?=
 =?us-ascii?Q?CZghvmBX7g+/TkLRQTKF5dhIp3c8F9iYgV1QpFXntSYCp/R3/OYR5KB+4ePJ?=
 =?us-ascii?Q?eW0WdFtYTZMSyUR35CEg9e7mGD2gsgJGWL9rQ02RiHPGYL1lD90AyuQJpKYX?=
 =?us-ascii?Q?VVIa6nSXTh0halfBFitizxS1jUS+L+Je1w1r3laPK1iaSG9VvLV76SaX7b8Y?=
 =?us-ascii?Q?4JV8Qkwx4wwyU+lpt2wi3utinww4mI/qv+6M2MIXkzMfeCToQMSrwtaxkngG?=
 =?us-ascii?Q?o2Ts+MKfQLySWqS49YYK1KYmME8A/AflLC3mK1f6+I7kLLPdVXVi9si6XBdb?=
 =?us-ascii?Q?b1+0mAlDBbvmjquyrl+r/J9IjEipiBnLG+aAaz22IABI+WnL1NlAPZJrE5aW?=
 =?us-ascii?Q?E06leRHTZ56ggsdACY501q0WIVOEdIFET3EowxTrqVCdogzeUDwu1Tyi4rM6?=
 =?us-ascii?Q?5LYEB6fkjcjcbW8U5cHCgAPnVs9bFB3ldQUbCcp48tz+0jjLFzKxpv24+roQ?=
 =?us-ascii?Q?rfd/UfBJR1NukHxC1KqFgFADTfN/qj0LPcorjXpHp/RzsXknpKhX48i42Tu1?=
 =?us-ascii?Q?WzKF5dhNdRhqROX2WEylkY2SGzgnUWHFgUJJEIxDLJI1q2zbRET/NK858OH3?=
 =?us-ascii?Q?nEsM1K7lbxzSRaDeNZnRvBOPAlcouYN/33o5VC7J9smm1fXnSML7l4A4DU2h?=
 =?us-ascii?Q?60bhlRqPgENRcGPbGM/Mvkq/3H+TKOytxwvMffZpqOZIAKPkXCgEx7Ongbm8?=
 =?us-ascii?Q?Qu6QwD77A8CiWvsuReMpeDExMdvRJBA+hKX0NRFuAEZMkQG73m4I24vO47Im?=
 =?us-ascii?Q?9brzLJq2yReHNFshvGUBr3SxJDBczAWl+WF+g1fhVX3MSFNcvEO+/0YoNQhJ?=
 =?us-ascii?Q?MwK85FYurglV4/92ZVcz6ZfgzlRhnIV8wKR4i0iTeR6he+wBPNR4vFpZh9J7?=
 =?us-ascii?Q?pcc8fUwO2dYhJsoARDpA/M7bg+TIPPAHQQl9DD/5v2ZRRSYh65A9AceIFYmc?=
 =?us-ascii?Q?KZzpVScj+Rk44vpdaX+1lVbt63d160i2hEk6KW0CHokOLkG+Me2E7yg1y8P8?=
 =?us-ascii?Q?qx5uVLyD7MAaBRxO9EBWSM2LodqPmQcCMrL3q0aBknlJBacnxdjdEB+cv/+t?=
 =?us-ascii?Q?Y+z1ZRiTKgUfPL6BZ1OPbshDgmEM2lJSDojvbOLNNaWKf0WK93Mhvuwtl4aB?=
 =?us-ascii?Q?/m5XFVkmuG3WcjzQUMkE3pQe1E8fMxg65CAGkefkPWhLyuY0K2T/Td/VJZ0Y?=
 =?us-ascii?Q?3QPRw9usJ8xYMgS/+X1mhzMJnF91xMtGCLWIBTRuGKjFtcWclC7Dd6vepgWf?=
 =?us-ascii?Q?wCbG2D2ipHNw+5WtoFp36VZhq8BSY53e46VVNwCPkoyLRUnBcGw4xZn2Kn/O?=
 =?us-ascii?Q?xcmo56FOpAkuRUbztmh15diFHxw5fB0uHc6hADVyFBGaIVJQ29wy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6c8043-4973-4c1c-62e8-08decc0a1b0c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 00:48:10.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mD44NDVs9J7obNGU/5mSGgiN91YgrgRqEuKA250IaOQnyAF0ZB/zfOhRRlP35brelUDyHyc4KxSB57c8gArPHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3408
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11567-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cassel@kernel.org,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev,amd.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,r7vzjddl5f5s:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93463695DEB

On Tue, Jun 16, 2026 at 11:13:39AM +0200, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On Tue, Jun 16, 2026 at 12:40:54AM +0900, Koichiro Den wrote:
> > Hi,
> > 
> > This series is a reworked version of Frank's earlier RFT series:
> > 
> >   https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/
> > 
> > After discussing the HDMA test results with Frank, I am sending this as a
> > standalone series that keeps the main dynamic-append direction, while adding the
> > fixes and HDMA handling needed to make it work reliably on both eDMA and HDMA.
> > 
> > Several patches are kept from, or based on, Frank's RFT series; the individual
> > patches carry the corresponding attribution.
> > 
> > The series has been tested on both eDMA and HDMA systems. Both completed the fio
> > test set reliably; performance results are shown below.
> 
> Great work! The performance increase is significant :)
> 
> In Frank's earlier RFT series, the change
> "dmaengine: dw-edma: Dynamically append requests while running"
> broke the pci_endpoint_test selftest:
> https://lore.kernel.org/dmaengine/aXNQcowVEMaE1xr5@ryzen/
> 
> I can see that you have included a modified version of this change in
> this series. Does the pci_endpoint_test selftest pass with your series?

Yes, I verified that the pci_endpoint_test READ_TEST and WRITE_TEST cases pass
on both eDMA and HDMA platforms, with this series applied. Perhaps I should have
mentioned that in the cover letter. I'll do so in the next revision after
retesting.

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas

