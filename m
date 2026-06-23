Return-Path: <dmaengine+bounces-11735-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OFGJHjv2OWrYzQcAu9opvQ
	(envelope-from <dmaengine+bounces-11735-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 04:58:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D4B6B3A7B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 04:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=dzh+Blbo;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11735-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11735-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A6CC3027A68
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 02:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F935386571;
	Tue, 23 Jun 2026 02:58:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021097.outbound.protection.outlook.com [40.107.74.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEDE34AB01;
	Tue, 23 Jun 2026 02:57:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183481; cv=fail; b=rif/eWB5Df+z/N/T0v/1FrpGbA6D7Srdp5wb3ZYJfnUdDzIdQkJRjn5XfmwESMu/ZNWasOBr9wVaheleTeMho4ror6F7QQGiTF4S16Whjx4yP0mPLyEazup46nkM1vFDZyKXfTvjPYZxaIJRbIDsUlAaKwy1HaB6aWISIn1C6hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183481; c=relaxed/simple;
	bh=MMZHKRHaKu74QwdPJu8JbLTiM2n2BSLdoC35i/73eEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qx9VRaRhyMBWyWlPG0fS5mAn5x8qWi2bSWIvymC1/vugN294MQ4I5QM5Mvb/MQoiOrxtpD3SSvshMBkMFfqvJ7dCvSmquOb8cw83eNUebdGtWIKzFGlx4IxRHbG2G8Djc3c9VmjO/0CgWcP7wfZ5ef2bvJ/CdpNuHYHLfVB649Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dzh+Blbo; arc=fail smtp.client-ip=40.107.74.97
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+wUXMbmh+u0mkshpibxlw+Ir0PhpJHizmkWX9YfyYmnwQ4JvOone3snGs0UfIH+JenuOm5Oycg/Fsy1OIff6H+9AYXg3ZKMjO38pxHDQW2zwpTu1p+F4eiQcGEZxOEkS4+yCsQkkSlFwCBhn+HfG7l9O+iVm/qNdfVdFG0aXxktVUeEt6/XDqMfHpuXM3+wZdhiF4yP/XQ5Yv7gF5hD9aVZJjIIwQgJNO15eUidW5OYT+ibcaJS3/Ib8dZdqoKzHW5E5GIcpzZltvPQ6yFAnXlM9TyAIgToMyNbYLIpfWAxaMocJxV4QUX+QNenyKUcRWtIf129NzDM+WsNhAxBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk7rIgLSGKrFw5hKw9Fbu66xIiKSGbFnLCo3eJtp2HQ=;
 b=dzDSbPdYocFIi93HVF1BMW340eXBU8XzMYafAspxWTdojEUzqtyMjsPx3wvlsAEX9jgUdjFjos+tNIjZ0K0ONVOCdIcxSJ8TNpPaDfz2qYNQxlqT3h6vnNg9MNF7PziaqkwZvsD9Rk1nr1lr4m8wQLDAfe+9+CLMMy9xFdIPOmdfvNc6IogaXwVMDFKiA23h+hSRFaMh+3Sw0P0Zg7Tu9iH6E0B4S2b26FigLCdMyIukGqjJbKqVCSwRc6vHrjCGkVGDX0+hzk8Lo+zzBSdTXy7SDK8aeDkZGsi5vNhEiDHc7DkzjKjmOrlCG+DZ1BOS1MXWj7bNhbdklVms4rBKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk7rIgLSGKrFw5hKw9Fbu66xIiKSGbFnLCo3eJtp2HQ=;
 b=dzh+Blbo4qajIfY4ZpUdrrnbnykjyN0RVxg7FvA832RQ5lAjfT9+dTZfq/lh3H86SmoVLHPRaqmgk6uo67/A9A63NNXqBJR5msBTIPBPDzv/XMyJGVA86b1vpdP4hMvAkp8pHrDiAsBmC0fQcP3pIPA+72OfvCihG/+O66b9DB8=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB3274.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:57:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:57:55 +0000
Date: Tue, 23 Jun 2026 11:57:53 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/13] dmaengine: dw-edma: Add delegated channel
 request helpers
Message-ID: <g6urnk4zqgqoc6behtu6dwjo4j7rmxke46gldstdwpdqqnchxs@5qsr7aak46xy>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-4-den@valinux.co.jp>
 <ajlda1gkqvXCPmrs@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajlda1gkqvXCPmrs@SMW015318>
X-ClientProxiedBy: TY6P301CA0028.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB3274:EE_
X-MS-Office365-Filtering-Correlation-Id: 599bc701-1b29-4d6e-ebd8-08ded0d33926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10070799003|18002099003|22082099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	6mj61w7KPhK8MQdPo7c7HfiIp4pq9Y4h1kDP7qTpmJGViOfPcsGRFEGvmSzTrDkTNARji7D0XsZBhMe9Cmd3c276StU9llPIUEHFF77/2UCHhG2G2/E+UTzscCPoA4bpBpAmC4Igh2u8yVTAsWUM5PzrbEh/JZ7OXt3qhS8zcp1f1yQoXdptgx3s6Q+GfYDOW8KYLR/tmYF2cX9aLOQ5DVZlv60sVPWODAgutDwK0EQpttY9LQkrU+Lt8/bc1mi2LzvhH+eOPf2MAKBwkTcL4JSKp2u2aJPtH9Lkc+ljWE1dZJjTpirZJmiSWcl158i1zWpFP0E6idHwcHQD3zuAGg/VRUTvVUyCOAYSrZNmBeGORJmhZb6gxOrRMo4WAGNKXDHhUmjsnKYQbzp138h/IlbJba1j7ztDq1b/D99fkWDN1lXi4K6Gd3K48A7LyQWCiexty7katRdzV2gC7OdISkdCs9SjuVbb2ptRXGoblR8dsIWGTvii6ccozV0MFTBk1B2MLXtv54iKomotANIrgJ1nfi2CMZyc+RABY6oEBsQmZED/PRVsvQmZ9aTlTg2Bz2iMrPSNLRwU8ni2C0BzDiTLneJkvK1tmr0p2dtovDNDCJaGVpc+mD31es2i+q3C8U3oAbf+aIHWdUI0RXtmSzEb7sPu2Nzb51MXsspFR3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1BYcxZfKcl7umT4hTGF5w4OV/cKEgfbzZhEfKd+kjwOBzA0LZYBdvt89p8VQ?=
 =?us-ascii?Q?iVIj81dz0jAitTizR6rXwIj77B0q+SMZ3FGkF1YeJDwwJ0eO5lEC8DEXNyUC?=
 =?us-ascii?Q?iYO7ucOVAbMj0fBd85Pr0C+q/I4YowxkFTvL6g3UF1oG8qynypxkcA1zlA81?=
 =?us-ascii?Q?4pK8gRD/C1GiRtjhnQXNtZt2+SKTA2D5ijY7Vay5TIt9z3ZDgJ8G0ahzTCfb?=
 =?us-ascii?Q?nKWAHb6IsaG/i0vyY9idzf4/7+E6YYl1Y4QCS48XTYSCDM5HwJIGZiGcssea?=
 =?us-ascii?Q?0czXmjcvhNfp7RJQpW/ePmlkRgXpc2AvP0U0C+aGpyxxTKbDB3YWt8yM0JAL?=
 =?us-ascii?Q?wQ2us/8Ykqt1UntvsJZHISXKU6nzi1foNR7eP4jGb+axPm839oUOeNZjzb0K?=
 =?us-ascii?Q?qdoCq0z0BjAoUZyWiwmk1HQkmFuMQ2noG4vPHlazjq47lnzNp7K3lpOmInvU?=
 =?us-ascii?Q?EdWpVt8ndhLs+sWiyTiysIfEYFZvA4GKLwXfQtMaiioTom+Fz+OS2jDmVfCJ?=
 =?us-ascii?Q?CiTS8NlCTapb1kZIaIHPVUP4hNbF63uDvvvMw2XANNG2tlDIHkv0YLMwAPTZ?=
 =?us-ascii?Q?rZrDjdEFcyPDYZPNbf98kf/5CSurdY1WXVEnrzQHwJRMoO6omV63OStVI8q9?=
 =?us-ascii?Q?nLt+clRfVUCM9hL4yvRAdah9vq/NVhxW144kWseo51zd7MI12xucaEj8mCWu?=
 =?us-ascii?Q?TlpD0GS15dxm1q01Vyc5qOitq+sWoklFUXJjBFHXnEUBhW6zlcx1MWKYrdpw?=
 =?us-ascii?Q?t5GIb6S4cHCLS7WbUtlrjFe0aWUaXMFMPI2HHniM6U7yrz8R+C/XPBoEzdDd?=
 =?us-ascii?Q?98dpXGddJ7juVB5vI475FhBAwYCLuTpqiyZWW/qclfrhj05/JhH2SCaEh4B0?=
 =?us-ascii?Q?Ra4+sxmEEUr1lrwXg7YH2QVk7Vwx4c9XJ5uGNnpyjHkzhr9B5EgcW3Y/S9ZY?=
 =?us-ascii?Q?YqQHdOcJ+5+5gF9/QMW69YJd+OYLQegLR9cy+uhg1noZ+z3eEX8NbWyACw0W?=
 =?us-ascii?Q?eNFX1PlvZnY//zcrCBhTkmcugLmI2soMUcxzQMIZb1ckdX0bhytweiCR4VTu?=
 =?us-ascii?Q?ufHBtMjzIvXwtBXEnf8UK1ROWEec2Q6/PGB+Wl1NbX11FRIPJbQ1MUu3zbb8?=
 =?us-ascii?Q?q8JTcnuhJ9nwhoIUTaKH+MrGK1AQmiCN7JkcyACzushLm3OEuESXCkqQ/P2J?=
 =?us-ascii?Q?RnSm/1h3SsOxLdweewoxhntgEO99Jklrl1hxrTGDfWDnQYgIfvZd40O3xGr2?=
 =?us-ascii?Q?PCN2pf647vW1Q+E5e1b0FdEijOhjrbSLj11MaRpkd12W7AgxqDomATrSo5zI?=
 =?us-ascii?Q?j2OlGBxPwOgcw5Wh5Ogv4+kAo8tFnJ8KsL7hQUg7q4ReKryHfWmJy/HP1eTK?=
 =?us-ascii?Q?pKtD5/6f/+ihSgqX8pqTBKQvFOKTXyJUALQvhj26ukiPpQ0O+NJW4hUACxIR?=
 =?us-ascii?Q?YJUOOoZCOCx2ONooG/Ej1wqE8NV4jfiyhz4rq+FH6vNtJUXlyrL/LKfwUbdb?=
 =?us-ascii?Q?do7Tv3x7vY+zClIvkoRIZDS5UUkbTifT+BfBIKgY5QBZP2qCIoN8z6mn76nC?=
 =?us-ascii?Q?2ixcwxHremjpkvj+d2+kNzWADJB3FyYA+SNFp50x0vxdaPX2+bdpafnaXOXj?=
 =?us-ascii?Q?5V3hKr9XNFXUJjCuJx2gdZyZcaJ7IP70Gdre5tdQVAek58Qltx1pE78JZ/TW?=
 =?us-ascii?Q?4sTdu+jkl6BgzkHesukFTSAleEg+IX4n0/YUJfbQNqKUsXgj6Kr9MvmcZQqK?=
 =?us-ascii?Q?UE5OJXa52TP9VEfWosPj6KoYT1mlUljZ3sMLMSYGg+0JtVPTwzBq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 599bc701-1b29-4d6e-ebd8-08ded0d33926
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:57:55.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mV7p3/nBQXxkseECIAcaHo+UgoQc3lZkOxYeDHunwWIeOCEpYWEJBTYbQAyfMt3/tZ2uBOVj8VhgU01DqKoNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3274
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11735-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
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
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,5qsr7aak46xy:mid,synopsys.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2D4B6B3A7B

On Mon, Jun 22, 2026 at 11:06:03AM -0500, Frank Li wrote:
> On Sun, Jun 21, 2026 at 02:00:30AM +0900, Koichiro Den wrote:
> > Endpoint functions that expose endpoint-local DesignWare eDMA channels
> > to a remote host need to reserve exact hardware channels and hand
> > interrupt ownership to the remote side before publishing the channels.
> >
> > Add DW eDMA-specific helpers that request a write/read hardware channel
> > through DMAengine, keep the hardware-channel filter private to dw-edma,
> > and switch the selected endpoint-local channel to remote interrupt
> > routing after the channel has been successfully reserved. The matching
> > release helper can quiesce the channel while it is still remote-routed,
> > then restores the channel's default routing before releasing the
> > DMAengine reservation. This lets callers skip quiesce when unwinding a
> > reservation that was never exposed to host programming.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> 
> I have not see any place to use this functions, can you move it patches
> serise, which use it?
> 
> So get these patches land firstly.

Agreed. Part 2 uses these helpers:
https://lore.kernel.org/linux-pci/20260620170438.3756593-1-den@valinux.co.jp/

so I will move this patch to part 2 in v4.

Thanks for the suggestion.

Best regards,
Koichiro

> 
> Frank
> 
> > Changes in v3:
> >   - New patch. Replace the public hardware-channel filter API with
> >     delegated channel request helpers so the filter stays private to
> >     dw-edma and delegated IRQ handoff is handled by dw-edma.
> >   - Hide the hardware-channel filter inside dw-edma instead of exposing
> >     it through public headers (Frank); add delegated-channel helpers
> >     instead.
> >   - Set endpoint-local delegated channels to remote IRQ routing after
> >     dma_request_channel().
> >   - Allow delegated-channel release to skip quiesce for reservations
> >     that were never exposed to host programming.
> >
> >  drivers/dma/dw-edma/dw-edma-core.c | 81 ++++++++++++++++++++++++++++++
> >  include/linux/dma/edma.h           | 14 ++++++
> >  2 files changed, 95 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 7a24248b84e9..ca0504eac1fc 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -1192,6 +1192,87 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> >
> > +struct dw_edma_delegated_chan_filter {
> > +	struct device *dma_dev;
> > +	bool write;
> > +	u16 id;
> > +};
> > +
> > +static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
> > +{
> > +	struct dw_edma_delegated_chan_filter *filter = param;
> > +	struct dw_edma_chan *chan;
> > +
> > +	if (!filter || dchan->device->dev != filter->dma_dev)
> > +		return false;
> > +
> > +	chan = dchan2dw_edma_chan(dchan);
> > +
> > +	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
> > +	       chan->id == filter->id;
> > +}
> > +
> > +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> > +{
> > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +
> > +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +		return -EINVAL;
> > +	if (chan->configured || chan->status != EDMA_ST_IDLE ||
> > +	    chan->request != EDMA_REQ_NONE)
> > +		return -EBUSY;
> > +
> > +	chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> > +
> > +	return 0;
> > +}
> > +
> > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > +						bool write, u16 id)
> > +{
> > +	struct dw_edma_delegated_chan_filter filter = {
> > +		.dma_dev = dma_dev,
> > +		.write = write,
> > +		.id = id,
> > +	};
> > +	struct dma_chan *dchan;
> > +	dma_cap_mask_t mask;
> > +
> > +	if (!dma_dev)
> > +		return NULL;
> > +
> > +	dma_cap_zero(mask);
> > +	dma_cap_set(DMA_SLAVE, mask);
> > +
> > +	dchan = dma_request_channel(mask, dw_edma_delegated_chan_filter,
> > +				    &filter);
> > +	if (!dchan)
> > +		return NULL;
> > +
> > +	if (dw_edma_delegate_chan(dchan)) {
> > +		dma_release_channel(dchan);
> > +		return NULL;
> > +	}
> > +
> > +	return dchan;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_edma_request_delegated_chan);
> > +
> > +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> > +{
> > +	struct dw_edma_chan *chan;
> > +
> > +	if (!dchan)
> > +		return;
> > +
> > +	chan = dchan2dw_edma_chan(dchan);
> > +	if (quiesce)
> > +		dw_edma_core_ch_quiesce(chan);
> > +	chan->irq_mode = dw_edma_get_irq_mode(chan);
> > +	dma_release_channel(dchan);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
> > +
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index c0906221a7c7..0ba8a1143fb2 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -140,6 +140,9 @@ struct dw_edma_chip {
> >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> >  int dw_edma_probe(struct dw_edma_chip *chip);
> >  int dw_edma_remove(struct dw_edma_chip *chip);
> > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > +						bool write, u16 id);
> > +void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
> >  #else
> >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> >  {
> > @@ -150,6 +153,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline struct dma_chan *
> > +dw_edma_request_delegated_chan(struct device *dma_dev, bool write, u16 id)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline void dw_edma_release_delegated_chan(struct dma_chan *chan,
> > +						  bool quiesce)
> > +{
> > +}
> >  #endif /* CONFIG_DW_EDMA */
> >
> >  #endif /* _DW_EDMA_H */
> > --
> > 2.51.0
> >

