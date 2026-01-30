Return-Path: <dmaengine+bounces-8629-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGepN8PqfGmdPQIAu9opvQ
	(envelope-from <dmaengine+bounces-8629-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 18:30:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 170A9BD2E3
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 18:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F246E30449B6
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E1F352F80;
	Fri, 30 Jan 2026 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RI9oZq54"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020089.outbound.protection.outlook.com [52.101.228.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E935EDC2;
	Fri, 30 Jan 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794028; cv=fail; b=t+J6YY3bkgGngMDiUurFW1rChzYGs+Fp1tyJvG7nSsL3BoyI6Zet5jjgYDI/vZF0NY0Tte6lPlYtV7Q9pttjTEkQyvRCHQ/lvlQWG24NGQUMkDyUyoQ0y7Dutb7Yc3o7GWl2pkd60SHQiluoTpR6Im2TEYLKsNmvq6LjQj7/ajY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794028; c=relaxed/simple;
	bh=aEUIp2K7GASQWsqKBT5ZKw5zsvPXfmlQGO1PpNBnbIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=poMOpyX8Bjhh5l8qQQt78P37IOe/3HnlDnUCEQRfPJDye5hV5M7mJhsEJ8szUB0E61MykbTDyG2jlOfUZEPv/sYaZe0oCtRoN6DCcUBZJKWymeMOrQnWWc134DJ+yoBZxLPxfwQEu2pySAeVTqntcOtgtzamR1ug7f1n8nom8Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RI9oZq54; arc=fail smtp.client-ip=52.101.228.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cq3IiecqCidvOdXB20poaF+efGE7qbdNlUgBBghrnZvApZBPgrwIxRD4DNreKKiSe58YHce2MyF2XhM8GhyHYOosXlnUUw1XHobygnOkURW0/9ODY7HzSk2unPaKMuujRlv4z29ybqN9/enLOImFXotqDBMu5zTdl5B2qWpKtzg7Quz43iR1dm3JF6lKVrX9oHQ6VwyOPcencLbvCJKqr5aaZ75gYTPDczrVPoK3utSLlm+2XnM6y1q7ftAEe9pk3XPuPjvERc3B4IO4L+f92qRdlBx4CaNatgPnDyi3+s7CX26fBwPKnr3+B5U1Bie2NznLSHphccjL3QQEpPh+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmWPvVWFPEbHvMA/cQ8pLBrYDtzBi/0P7v+6n/fXhLA=;
 b=QwEQiXGjUsKwjl0zDNbEbT5jXZbc9ScQeGM8q/ZUJiB/13PPShKf/DdJ7kjMgQu2PWDxZhx/qNVrd2lnTckSBb1UPkU/sUhv5ONDKpxUXwQOzAHmOpPfIzJ2+oHrfE/xjvZYPDbEuGOPDFcJ+GIu5P7pevJai4pEd1sk5F9EKEZHeWVXoNalxi79Mj9RMtu51/4iTUMEzohKDp3Ikwhg+ZFCPkSHHBdwiV68kUbPeununU8Uc0kvuvohdQgH8fhTfhXbenpuciCM4bnqoWY0IgLpa6rnhtJBT5zFK7DLs1LFCNA430EN/okGekLHFFJnFgE31TIFV0SL9qpC8YBqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmWPvVWFPEbHvMA/cQ8pLBrYDtzBi/0P7v+6n/fXhLA=;
 b=RI9oZq54MdssbFTRDda8xMeXLWa57pw+aNSxH74UBjcb9E0k78nvzz9i2TJ3FFaCs7hGPPGddLGXGZAqMrOinvl5+aWBuaWLGul6uT7rNBQW/vx6H4NTeCbUFxYGGD8/hmNALSK1+dqApqwXZzu66TiCEByyfzi8MAxIxq57jN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5812.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 17:27:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 17:27:03 +0000
Date: Sat, 31 Jan 2026 02:27:01 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] PCI: dwc: Add helper to query integrated dw-edma
 linked-list region
Message-ID: <v25s3ji7deayobdvicbch72jqnn4migzo57jibdhuddjr623cy@3e4zygidpkdl>
References: <20260127033420.3460579-1-den@valinux.co.jp>
 <20260127033420.3460579-8-den@valinux.co.jp>
 <aXovtOcilRrkA0Ot@lizhi-Precision-Tower-5810>
 <dpx4s35dqvhp54sloixxsn3qcf3g2k745wieaefdc2svgkbtr6@4vuqgp46czi7>
 <aXrXJbjKiAFXaxOX@lizhi-Precision-Tower-5810>
 <zqcu3awadvqbtil3vudcmgjyjpku7divrhqyox72k43nfzcoo7@hflaengfjy27>
 <aXzJFhcYCqTE5ma9@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXzJFhcYCqTE5ma9@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0116.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: bd36bbea-1db2-4227-cdbf-08de6024c87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JcwKz0jZ6WPbEAM3SuHFEmPj+8+3VdUKKv2qEwbCAKbRhh2toI5srzgRN4DD?=
 =?us-ascii?Q?ri7H0ptEZzwR6EoDQOqm1rINzV81PDl+g0wgF5xGd6Bw5sF/HhKXhm2xlnrV?=
 =?us-ascii?Q?uZTBrKRCRV7nYEMSx+ieIqxJWJ8zBdEFidgHjLc9/o52vJaGr16iap1ZevjC?=
 =?us-ascii?Q?3Mfm29Rb8klHojAu9YAeMdUHnflfNghi4PdgHtqfRCHFALVtau1HdlOhsRlo?=
 =?us-ascii?Q?c4A2yz8G9thwGruQjuDZ6F5+NN3Yfv016U2d42B+Ft0borrkypQdzY8Y1g0f?=
 =?us-ascii?Q?APFlUic1LVOSaMLXSQtl/L9WeqnIvW3/M7sqb+mDXe5mAT3Ehza80G8kF1yX?=
 =?us-ascii?Q?+aub64cwi8SMrOFp4yOF4UDl3vacR/4bdmuy1CrCaQ2rDcziySMZtC49KJZ2?=
 =?us-ascii?Q?H/xN0DcE4w/gp/fdRCm1hXs1qUZ0mfxz2KZlzP+tHKt/Ew7/YHP2JuBAwuV3?=
 =?us-ascii?Q?lCUHaBVomyQIbvO+dKVp6QKfgEhQA+r8eDSQR5ecNUIteqNiT13m2wxRBfic?=
 =?us-ascii?Q?V872cTPF+37lczgc49Hmd4pu2l96INB8o7jITb0eB63UIU8Fh3a+4E0y1XhO?=
 =?us-ascii?Q?WJBA1sHnISZDKLP5WDTK6ilNU5/M9kBiPcI2iOl7QvCcyyYLn3OxfP9QIPQR?=
 =?us-ascii?Q?L49CDMUq/eNq9etHOS6eegWymyyvFYs9xv5oLvFfAC5MiY8dzSyfvlnKQcSU?=
 =?us-ascii?Q?y7+Rub/LIcrk7xhWA2XD6ZQyJbSV4A8CrmcsNA0kDF49TJPm9ha8Hcsd9P6r?=
 =?us-ascii?Q?SewMVvRS8RFRVhgJC/6cT62Jj6EcwsdAuY5iuSUuOwEX4REhmpR4WPZ6w6l2?=
 =?us-ascii?Q?eacKvSWkS4ALe8FFrFbjpXlr+S04Q/231xQM+3Q663Conbeigu6SfhJsC4p5?=
 =?us-ascii?Q?3QNQjP+IntCIYgOFPu7YiKxUOS0w4NiB8AOF7i6e6lGh2sTRxFCobhNKcX/s?=
 =?us-ascii?Q?h1TZiTA/RGvgopKt4NThnVYB1dMtfCvhehVEjRBOwBwnzmmIfPW81vUHbYiJ?=
 =?us-ascii?Q?tKVeZnDK3q6lYYYCH5j8/Y1Yg79oQMtl+PiUaeUgKKfwFrTisTVJQoUOzjZg?=
 =?us-ascii?Q?TqSHBUmSlrVYDXHOJ3zC3gNQhwvtPstlyBOT8H9YxIMZrmYukY1KSd00sm3i?=
 =?us-ascii?Q?CBTW90/Rm+QrmX1ktI5ZTcoIFcAOsEeJzTBIkXAgJka/3NZ9DyyyK5Z7hHm5?=
 =?us-ascii?Q?jv5FyzZyoZ83V8/5nvlG+UrJ94++3LinUscqEmhyF7Cq/YB9zB78u0VRAyrZ?=
 =?us-ascii?Q?NYAwABgD1Xg6RmglIHATnKFE4zOJjnLHx8ZQbPTO2FZ1Xh7Vh/J7zk3mxUVz?=
 =?us-ascii?Q?KehHF5shr2UEdV4Ty1VMz1IIOqwRAF5xRUZ1YDNmx7MmdNB0eQM+/IJG6xPL?=
 =?us-ascii?Q?eUEwkQ8pnkOgPdeBBAtVQRkRHwmyrgeoqQD0VsbvLotL/QS3HfDWrI+HN1nC?=
 =?us-ascii?Q?bv0H1zDIba1FTxkbrg+TdLyF04dZeOFcNtDjkoiTnyLHznSz2yG0Tf3JdjAv?=
 =?us-ascii?Q?TEyPbZhZ4IUZ7P0lw6gDlAfJJcBaCZeXVkfzvy180yDCK1mZiIFnU51zYRWB?=
 =?us-ascii?Q?Zr8Rd9bON1a076TNdG9LTMvQc/hD8hAIf9L4CHwC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Krw4WiLDCmi0WikTx7t7/mJaJv1VlSziThzka1B6AS5w5Q2kVZ9iw2GBDL2r?=
 =?us-ascii?Q?6I0hZtedf2DgF2Bn/30hc5yPBm8ND0HhvJ6FcG3XrWrhG4XZl+2gtwSFbJg2?=
 =?us-ascii?Q?m9D2A71VtpeeEQDP3YxqUosQFVhSqbETOUqy4IAoLE7LVsCpuZuzNKw2CssU?=
 =?us-ascii?Q?6mJ70Z/LHuQc0gEhyE27QlV8Uk8YoyBBpdZYz+flHuK5ksEx4S3X9Lm1r77I?=
 =?us-ascii?Q?o45/aaUgxtQABAbbFF1u+DsUyVVbRfhURE4s0zLXkJEP3+frjqL9+Q1rkMmU?=
 =?us-ascii?Q?hrSwAbWud+uLAsD/wmCenkLL7c0H58qyJkx6vMGlipUrMllYGiYaFnW1wCy/?=
 =?us-ascii?Q?jQzdhBAgXBR3Q4U4Pb22SnrkHlLJi+eg38d4L8M3Xzlpexuy2mnOALK15hQx?=
 =?us-ascii?Q?j7LtLyuMmbn9mi+eO5WnNeL2Y70+7wPdtcVAI8CDf9xfBVbrch+QBy9SPik0?=
 =?us-ascii?Q?GfkGWp3Qoo1WBsrVrI/MGn/mZtrH1vOMoz3PR9t61a08Sjf2ju+abInJ03PJ?=
 =?us-ascii?Q?JFrGGQkwDv93nz65KNumcLMJ93R4fFo3jF7R2hL+pS94wYDZTm3nFlfa1xw3?=
 =?us-ascii?Q?XPZEHRVBPzHXzPSeDY3zodD9ba8QwrOjSlqYHc6npiENsxzJDFLSWWRkPc7f?=
 =?us-ascii?Q?/sW+h0HVuZgkYStc5RaN+zRV29n+3ixSBP7Vs076o4xzpCqQuT4rXPyxv3Cp?=
 =?us-ascii?Q?Ehok5+Yagbi3IwTSbdjD7dpUNvxNu/kwIPJRNQBsJNXKWdPpcsEuOl+01vLT?=
 =?us-ascii?Q?D5uRQfSI4L9uD/feelCoANU4XxmoUXqs6Y98mCSQ05KI/AWkmllefga5VY9w?=
 =?us-ascii?Q?tnXULKH9OJYYGsb0cihRBViQ5XttCwqKEkiPGsHEBQADSujAhgHpTAAL3bGn?=
 =?us-ascii?Q?Zc4LUQVUZVEUIP5VFAcbbC5e4frN+HwVZTPS/jCdJZTYR3dRlZfoWgQf3jeN?=
 =?us-ascii?Q?IJUWCcd9cwD4tyVWbjv5I13dfJh5050P1vBWN9x/J0wajxx8KV7phTMt12ch?=
 =?us-ascii?Q?9JlwD3eBVunOEcZmkQA+iDXzrFCI2AOAHZDAyzXVoFv6SRL7c8iVpa97kEuT?=
 =?us-ascii?Q?Nlg94oFF1RGic/smYi1BpdVgywH3YHaMDlP1jTYHBiqW1YmEYQCxltkushBu?=
 =?us-ascii?Q?J/Sfk2/lWTVUPXOet80Bahe0e0a6PUOIb1U4ibt6TSBuBBQPUKu5ZkidwuR4?=
 =?us-ascii?Q?quwcJamm4QArU40P74ezm/Jutva16bbfJ7X/IsRqd9lgxtOc4XkNijrFVSpi?=
 =?us-ascii?Q?4sXz1bGhX8wOulmnPt77WBr9GXD0H1tQxY2KQKOFQn2L0uyyqtqB65L4oyo7?=
 =?us-ascii?Q?Mt89EbbfOCNQBrOyp8/MbOc+7jcgvBkVMv7EutGjjaUqV/dPKs9kYE3vJusT?=
 =?us-ascii?Q?GPjTXn8AWDk/y+nUj1/uWJWxaT0HlJWZapVFP/DhDDnfBOgEknmwkN+sN2fn?=
 =?us-ascii?Q?JFlp6Q75zvPPnDuMUBftXNznB+CSkK1/1j5OJiQtln0JPWaMcFMzujnwVCMF?=
 =?us-ascii?Q?k2HBunZSE6Rv8NfgYx/oOOZT65iEZDmFZfjbrebil3U368OwnJFqAD8datb1?=
 =?us-ascii?Q?4esJCb/OJ3x7wTg3PytG4mkX8GgFFKAXVrLov+/doM4uLSOaPy2RHwopFVQK?=
 =?us-ascii?Q?b1i6w7XAH/jPCGkS4BwzBXn4BJywxKIUElHZlNxvjHQC4KjD1bbJCpsiA2/y?=
 =?us-ascii?Q?bWGRuJX1Ytt0GhLy+aZTcnI786yJ5GMKpremryaX/5yrWXlgeav+c2Ms7+Wm?=
 =?us-ascii?Q?33LT1ygVaoSiJ0/2fEdG+ZZRT9Jy5JbSZTXoQC7rTGMZkkX6bJ3T?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bd36bbea-1db2-4227-cdbf-08de6024c87e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:27:03.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQoac7VYrjnVzplb0q87C7vCM0R2WPKHN5i4Em7vZYTY2ATpT0qAvgXW1FhXibSgNmWHUx074n4sx/THI5IJRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5812
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8629-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dw_edma_chan.id:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 170A9BD2E3
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 10:07:02AM -0500, Frank Li wrote:
> On Fri, Jan 30, 2026 at 04:16:11PM +0900, Koichiro Den wrote:
> > On Wed, Jan 28, 2026 at 10:42:29PM -0500, Frank Li wrote:
> > > On Thu, Jan 29, 2026 at 01:25:30AM +0900, Koichiro Den wrote:
> > > > On Wed, Jan 28, 2026 at 10:48:04AM -0500, Frank Li wrote:
> > > > > On Tue, Jan 27, 2026 at 12:34:20PM +0900, Koichiro Den wrote:
> > > > > > Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
> > > > > > instance and allocate per-channel linked-list (LL) regions. Remote eDMA
> > > > > > providers may need to expose those LL regions to the host so it can
> > > > > > build descriptors against the remote view.
> > > > > >
> > > > > > Export dwc_pcie_edma_get_ll_region() to allow higher-level code to query
> > > > > > the LL region (base/size) for a given EPC, transfer direction
> > > > > > (DMA_DEV_TO_MEM / DMA_MEM_TO_DEV) and hardware channel identifier. The
> > > > > > helper maps the request to the appropriate read/write LL region
> > > > > > depending on whether the integrated eDMA is the local or the remote
> > > > > > view.
> > > > > >
> > > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > > ---
> > > > > >  drivers/pci/controller/dwc/pcie-designware.c | 45 ++++++++++++++++++++
> > > > > >  include/linux/pcie-dwc-edma.h                | 33 ++++++++++++++
> > > > > >  2 files changed, 78 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > index bbaeecce199a..e8617873e832 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > @@ -1369,3 +1369,48 @@ int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > > > >  	return 0;
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_reg_window);
> > > > > > +
> > > > > > +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > > > > +				enum dma_transfer_direction dir, int hw_id,
> > > > > > +				struct dw_edma_region *region)
> > > > >
> > > > > These APIs need an user, A simple method is that add one test case in
> > > > > pci-epf-test.
> > > >
> > > > Thanks for the feedback.
> > > >
> > > > I'm unsure whether adding DesignWare-specific coverage to pci-epf-test
> > > > would be acceptable. I'd appreciate your guidance on the preferred
> > > > approach.
> > > >
> > > > One possible direction I had in mind is to keep pci-epf-test.c generic and
> > >
> > > Add a EPC/EPF API, so dynatmic check if support DMA region or other feature.
> >
> > Thank you for the comment.
> >
> > Ok, I have drafted an API ([1] below).
> >
> > One thing I'm unsure about is how far the pci-epf-test validation should
> > go. Since the API (pci_epc_get_remote_resources() in [1]) is generic and
> > only returns a list of (type, phys_addr, size, and type-specific fields), a
> > fully end-to-end validation (i.e. "are these resources actually usable from
> > the host?") would require controller-specific (DW-eDMA-specific) knowledge
> > and also depends on how those resources are exposed (e.g. for a eDMA LL
> > region, it may be sufficient to inform the host of EP-local address, while
> > the eDMA register block would need to be fully exposed via BAR mapping).
> >
> > Do you think a "smoke test" would be sufficient for now (e.g. testing
> > whether the new API returns a sane / well-formed list of resources),
> > or are
> > you expecting the test to actually program the DMA eingine from the host?
> > Personally, I think the former would suffice, since the latter would be
> > very close to re-implementing the real user (e.g. ntb_dw_edma [2]) itself.
> 
> Smoke test should be enough now.

I'll prepare v3 accordingly. Thanks.

Koichiro

> 
> Frank
> >
> > [1]:
> >
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index c021c7af175f..4cb5e634daba 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -61,6 +61,35 @@ struct pci_epc_map {
> >         void __iomem    *virt_addr;
> >  };
> >
> > +/**
> > + * enum pci_epc_remote_resource_type - remote resource type identifiers
> > + */
> > +enum pci_epc_remote_resource_type {
> > +       PCI_EPC_RR_DMA_CTRL_MMIO,
> > +       PCI_EPC_RR_DMA_CHAN_DESC,
> > +};
> > +
> > +/**
> > + * struct pci_epc_remote_resource - a physical resource that can be exposed
> > + * @type:      resource type, see enum pci_epc_remote_resource_type
> > + * @phys_addr: physical base address of the resource
> > + * @size:      size of the resource in bytes
> > + * @u:         type-specific metadata
> > + */
> > +struct pci_epc_remote_resource {
> > +       enum pci_epc_remote_resource_type type;
> > +       phys_addr_t phys_addr;
> > +       size_t size;
> > +
> > +       union {
> > +               /* PCI_EPC_RR_DMA_CHAN_DESC */
> > +               struct {
> > +                       u16 hw_chan_id;
> > +                       bool ep2rc;
> > +               } dma_chan_desc;
> > +       } u;
> > +};
> > +
> >  /**
> >   * struct pci_epc_ops - set of function pointers for performing EPC operations
> >   * @write_header: ops to populate configuration space header
> > @@ -84,6 +113,8 @@ struct pci_epc_map {
> >   * @start: ops to start the PCI link
> >   * @stop: ops to stop the PCI link
> >   * @get_features: ops to get the features supported by the EPC
> > + * @get_remote_resources: ops to retrieve controller-owned resources that can be
> > + *                       exposed to the remote host (optional)
> >   * @owner: the module owner containing the ops
> >   */
> >  struct pci_epc_ops {
> > @@ -115,6 +146,9 @@ struct pci_epc_ops {
> >         void    (*stop)(struct pci_epc *epc);
> >         const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
> >                                                        u8 func_no, u8 vfunc_no);
> > +       int     (*get_remote_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +                                       struct pci_epc_remote_resource *resources,
> > +                                       int num_resources);
> >         struct module *owner;
> >  };
> >
> > @@ -309,6 +343,9 @@ int pci_epc_start(struct pci_epc *epc);
> >  void pci_epc_stop(struct pci_epc *epc);
> >  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> >                                                     u8 func_no, u8 vfunc_no);
> > +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +                                struct pci_epc_remote_resource *resources,
> > +                                int num_resources);
> >  enum pci_barno
> >  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
> >  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> >
> > ---8<---
> >
> > Notes:
> > * The naming ("pci_epc_get_remote_resources") is still TBD, but the intent
> >   is to return everything needed to support remote use of an EPC-integraed
> >   DMA engine.
> > * With this API, [PATCH v2 1/7] and [PATCH v2 2/7] are no longer needed,
> >   since API caller does not need to know the low-level DMA channel id
> >   (hw_id).
> >
> > [2] https://lore.kernel.org/all/20260118135440.1958279-26-den@valinux.co.jp/
> >
> > Thanks for the review,
> > Koichiro
> >
> > >
> > > Frank
> > >
> > > > add an optional DesignWare-specific extension, selected via Kconfig, to
> > > > exercise these helpers. Likewise on the host side
> > > > (drivers/misc/pci_endpoint_test.c and kselftest pci_endpoint_test.c).
> > > >
> > > > Koichiro
> > > >
> > > > >
> > > > > Frank
> > > > >
> > > > > > +{
> > > > > > +	struct dw_edma_chip *chip;
> > > > > > +	struct dw_pcie_ep *ep;
> > > > > > +	struct dw_pcie *pci;
> > > > > > +	bool dir_read;
> > > > > > +
> > > > > > +	if (!epc || !region)
> > > > > > +		return -EINVAL;
> > > > > > +	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
> > > > > > +		return -EINVAL;
> > > > > > +	if (hw_id < 0)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	ep = epc_get_drvdata(epc);
> > > > > > +	if (!ep)
> > > > > > +		return -ENODEV;
> > > > > > +
> > > > > > +	pci = to_dw_pcie_from_ep(ep);
> > > > > > +	chip = &pci->edma;
> > > > > > +
> > > > > > +	if (!chip->dev)
> > > > > > +		return -ENODEV;
> > > > > > +
> > > > > > +	if (chip->flags & DW_EDMA_CHIP_LOCAL)
> > > > > > +		dir_read = (dir == DMA_DEV_TO_MEM);
> > > > > > +	else
> > > > > > +		dir_read = (dir == DMA_MEM_TO_DEV);
> > > > > > +
> > > > > > +	if (dir_read) {
> > > > > > +		if (hw_id >= chip->ll_rd_cnt)
> > > > > > +			return -EINVAL;
> > > > > > +		*region = chip->ll_region_rd[hw_id];
> > > > > > +	} else {
> > > > > > +		if (hw_id >= chip->ll_wr_cnt)
> > > > > > +			return -EINVAL;
> > > > > > +		*region = chip->ll_region_wr[hw_id];
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_ll_region);
> > > > > > diff --git a/include/linux/pcie-dwc-edma.h b/include/linux/pcie-dwc-edma.h
> > > > > > index a5b0595603f4..36afb4df1998 100644
> > > > > > --- a/include/linux/pcie-dwc-edma.h
> > > > > > +++ b/include/linux/pcie-dwc-edma.h
> > > > > > @@ -6,6 +6,8 @@
> > > > > >  #ifndef LINUX_PCIE_DWC_EDMA_H
> > > > > >  #define LINUX_PCIE_DWC_EDMA_H
> > > > > >
> > > > > > +#include <linux/dma/edma.h>
> > > > > > +#include <linux/dmaengine.h>
> > > > > >  #include <linux/errno.h>
> > > > > >  #include <linux/kconfig.h>
> > > > > >  #include <linux/pci-epc.h>
> > > > > > @@ -27,6 +29,29 @@
> > > > > >   */
> > > > > >  int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > > > >  				 resource_size_t *sz);
> > > > > > +
> > > > > > +/**
> > > > > > + * dwc_pcie_edma_get_ll_region() - get linked-list (LL) region for a HW channel
> > > > > > + * @epc:    EPC device associated with the integrated eDMA instance
> > > > > > + * @dir:    DMA transfer direction (%DMA_DEV_TO_MEM or %DMA_MEM_TO_DEV)
> > > > > > + * @hw_id:  hardware channel identifier (equals to dw_edma_chan.id)
> > > > > > + * @region: pointer to a region descriptor to fill in
> > > > > > + *
> > > > > > + * Some integrated DesignWare eDMA instances allocate per-channel linked-list
> > > > > > + * (LL) regions for descriptor storage. This helper returns the LL region
> > > > > > + * corresponding to @dir and @hw_id.
> > > > > > + *
> > > > > > + * The mapping between @dir and the underlying eDMA read/write LL region
> > > > > > + * depends on whether the integrated eDMA instance represents a local or a
> > > > > > + * remote view.
> > > > > > + *
> > > > > > + * Return: 0 on success, -EINVAL on invalid arguments (including out-of-range
> > > > > > + *         @hw_id), or -ENODEV if the integrated eDMA instance is not present
> > > > > > + *         or not initialized.
> > > > > > + */
> > > > > > +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > > > > +				enum dma_transfer_direction dir, int hw_id,
> > > > > > +				struct dw_edma_region *region);
> > > > > >  #else
> > > > > >  static inline int
> > > > > >  dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > > > > @@ -34,6 +59,14 @@ dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > > > >  {
> > > > > >  	return -ENODEV;
> > > > > >  }
> > > > > > +
> > > > > > +static inline int
> > > > > > +dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > > > > +			    enum dma_transfer_direction dir, int hw_id,
> > > > > > +			    struct dw_edma_region *region)
> > > > > > +{
> > > > > > +	return -ENODEV;
> > > > > > +}
> > > > > >  #endif /* CONFIG_PCIE_DW */
> > > > > >
> > > > > >  #endif /* LINUX_PCIE_DWC_EDMA_H */
> > > > > > --
> > > > > > 2.51.0
> > > > > >

