Return-Path: <dmaengine+bounces-11466-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CthzF1bXKmqrxwMAu9opvQ
	(envelope-from <dmaengine+bounces-11466-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 17:42:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFDD67326D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 17:42:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=GJ55Z4yY;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11466-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11466-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C24AD34FD51E
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FDD221721;
	Thu, 11 Jun 2026 15:37:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C84D1DDC2B;
	Thu, 11 Jun 2026 15:37:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192267; cv=fail; b=XLWIT+CoM+nVmiU4XBvxPXVGLDSnEIdSugeJy+a7intXgEa3E+HvnyzZyuB1Z+dFeSilMCB1ZqqxVDArKUtnByCu/p77BUNettWr86PrSxfy/tjjsmQU88byk0nlOmpx/Y5tqdczygIK8e3nCC4whRlCsYy9eISO4zTJEG1vD/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192267; c=relaxed/simple;
	bh=6MY6wZtHtCvHyirdSS5D0CcvqH/G4SmTYPYPMCJ/yMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r0/VpoF9VRObK8Hr4UNnGUyc3PIhZVG6ZG27kMky0vR7Tz5Xs/sZ1f3GlTg3fnGh6p9vF40KR31ThUgDIr5rNr8yDFWza9m0TDn4eJTo4nV33wy7WKO6077G9WaPGEoR/9QSpL7G5YPoXg49dr64e5/wHwPELqeUruO0jxSyGTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GJ55Z4yY; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY7hxzNuMUKgA2AgOWjctzLYs3F3H6lL0bnIlH3hqr0L3+itDoEULyLD/sZIseNFbZfLTsL8i0kcBEtJkvY9FgiZhCpspKGY60qaHxCIxfBMD9i0F58l/VFSEoXTZx7dDAzFX8CRSffkQNRxiPNClBXubezyJVQPSgbUf0YaCPP5US8/i8Y5THnUevhi8t22d1lqQnpayLijfHZj5u/ZfFGAQPBxP2WJtCOVQ7wjVEugBYPQq3CBywYt43yHQjm+AeaHXJamk6SfGX6vHd62CmhYJG4IAedwmDDvZpzYt6aApm9k3lkCcnCX1214MimM9Dl/xTx7E/aUexPEHLgm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3mx5UHvqSN5NDzQYdEctzRNOx9FoEYvc2s+tIan6r8=;
 b=VVOgAVgzlarYBA362LdIeMO5UGAhuYw950sJ7vyV3O2y/LaQmR0Rc4YpGMhlZWx6USL8jo61DCYvrSAL93PIR0w6sOAETme3MAuUBqW/9bmOSE0C5dmaCJDafiNF7IfLSVSjE8kACs7fPIQrUAEPqUgaWYafKg7LtJ/+spu6MQr2vsyGcNA0w/c7xMoNTl2DtNOytuosETwTOhvaoHF9rMzRoF4aalAjkKjfyz8Zn4axMCmum2hNHWirOSVOwWZcnorqmN13KkNI3L94SLw66iOyFhsEyj4nO4qutVPi9lDYKw0AL5ZX2do76eggCPVBpllXhS3awK2Jt8Uc4vV0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3mx5UHvqSN5NDzQYdEctzRNOx9FoEYvc2s+tIan6r8=;
 b=GJ55Z4yY+vuHMi6O/2u0UjZkAW34bB4VKlhQORX3tNOI6pP5Or4Pmte9WQb6Ez5wmPOjXwZwp9LdDo7agOUa9/OmZSIjtvyDtRFFCjobPfCWB++EDSuQd3nhBOMUvlcN/ctsZsAaJNANDzhbTZGtYJ9LTj7VNKhP/RO45MiFNIT0CoQdDFaODUAK8EEK0gXl5r3etiy7rd0iPiBH/HMyP0+WTzBNp/MkrVUD4ag9K5cCsN4XXGOUwFFcbiu7xZ2TNrHFAaI0T/Kuz0EBrUlIQN4XJttveM6/GliCsIsTPpNkvah9jM9h1/kYXgGPj4KIvdx2RrQEyMFUiM0/D2c1hw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8697.eurprd04.prod.outlook.com (2603:10a6:20b:43c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 15:37:43 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:37:43 +0000
Date: Thu, 11 Jun 2026 11:37:34 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCHv4 12/15] dmaengine: fsldma: use devm_of_iomap() to
 simplify code
Message-ID: <airWPl6a_VtVmp2J@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-13-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611035245.13439-13-rosenp@gmail.com>
X-ClientProxiedBy: PH7PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:510:23d::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 78120355-153b-4880-af61-08dec7cf60bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|23010399003|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zIBNsCk+JJr0Q59C8oSZcWEszd2MVvjY/JnfaQl9spCIJe7A6rxop2/tAiupTS45NkkMxa+9vF4rbQQjPdgRyyDHdk4NIQunmEDxfyIfJEWdbtS+spbZ1czfE+7o4BnTOC72eT7IA4aXskItPA7ByXtBK2O4YwKXR7cxC0B5jUEZUu5a+kpNHhtd+Ns2bEHIOgkaPLTWbfrT6U9Bbwx5j4nBgmVoY8zde26OOhHQefRkSAAekMfqPL9YQbyhjZW+uU2KGwEahR88bUg77qZm/XJR9Fo9xwNPKFz4c+ohdr21jfb28IDSc//bTJD4PBXMk85p2kH6aVrq7M6S7IWpfWbqmHpVsIrkpwOi1EyHvf439EyPE5HwY3OnAFfJ0xeLF5wqyFwhMdTdc30P4KONJcfbkVFx96WawqKPn0wNLJrKaBMQ5Shg8aVAp6Z5EpLDD6caqzmbwemDdm+XEUEHDEL/HKHtuhj++qodZ2djh6Y41PFkr3BoCmBtlChi5SxiN7XL+GbpjAl4BBMu/zHkTGxfrsa9IjKKHxufuYrlBDLGeaIYqDQawsLubRYkCSexBd6NRktmRa92oop80W7v3Wbdnbi7mcLAi+fyhC/yUcdi1gLpybkRqeh8R43272atk7GI7IXCLeZZWivM232CLq+PR1CI3q2KdDb1EyDKA2GuJ4ndwwsm5oj4TAIPN1bf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BdQr/7RQr/prFVYG5ONic5Cyj/J26ryQHD9Ck6St2yaaRvppzP46P3Dd/Jcr?=
 =?us-ascii?Q?ecamtZLsf9A10yXWwoYD/QKB6Pg8cQ8Kpn6NB5zvIyKhTkmAAceub2Psre9+?=
 =?us-ascii?Q?mcT7gt3cXY58Z4H5Bq0tbzo3D6eKsQrA2JJufP4KDi/tlSIq6HpSCugIhHSa?=
 =?us-ascii?Q?j99zYB2TdeSxiwG6240OZBxF4BlkxvpT42dIZ1V6i5y5fLgzjCqZo+tp/blL?=
 =?us-ascii?Q?uJ2HJULNA0C6s5BiWF4851oio1UPYoHyVOdLtH4qoULIbVh/Kpep0I8DOmZV?=
 =?us-ascii?Q?lAaRG42BaqVI4eqyIATgLNDI6J79sStXGxKiFvOc/1et91y1Q+ZL0UlxTJSO?=
 =?us-ascii?Q?bEpjsmtcfuimb36HOKYFOPXaZxAOV6GeJxTJC7A949Tb+UQTcMcf669SSw7f?=
 =?us-ascii?Q?w48AyCnMFL8FaSmq8OVjxshFOvqfVTTH80tlDZi2LMnKyB+DZXa/AZUa5Ouk?=
 =?us-ascii?Q?nt1+zYXkMj2fVd7Mx3adVCmtQSgItjQqhakhsGAPMxd6tSldgjJedCStvy60?=
 =?us-ascii?Q?wyWEHNTyya/0Cl7QJGnS1liDolz+Jy1KkQkPGvvinvCNAOkeK90m4b4VH0iB?=
 =?us-ascii?Q?ihYniScVawq6INjtJRBufDqf/YdQ2moaTCsyYQimptvU2yLEKis/xa1JBm6P?=
 =?us-ascii?Q?ysH6Kl3g3SMYLaOwH9u1gTdlY8xuRKyjTmk0du65V+G/+p7cBdKp0hb+BOv/?=
 =?us-ascii?Q?77bmVvnfDDgM5MWXE0lLpRtck+Abp47X126sOeGEQ4bpPeAPSH2lllFH96ia?=
 =?us-ascii?Q?xVdO2Hqb2hiHXFvgODCxAFLnf4dgYg+ggYJjon9OtgrYZRAyCPtvi3wlHsCz?=
 =?us-ascii?Q?GKj7s9ebYCmRfgA8ML+1+6oPzkyGmgQfibH1Hsli1j2O1boHPQOV4ATiaFR8?=
 =?us-ascii?Q?cQ4otFJDvHuT9N0sMMZdJuMNyFthSMh5ZvIqTOfpg1cTTMo9FB84pzAfBJQV?=
 =?us-ascii?Q?rQH6Nx9eHm0gwRs4tyNtVkPTWO9jJ2z6UYUxEovxdln0HR4101r1AFs+RHJN?=
 =?us-ascii?Q?Oxj1VsIwtPOipVYZgeLB006rJ7QLnjPflucEG7nxJvtdttZVlKLI4mXTKgDi?=
 =?us-ascii?Q?SsH4u099717mNmsD7/tlusV/Qxx+Um9nTimERGAISND9Odxa1126MTS6DC9n?=
 =?us-ascii?Q?vC4uZI36Z61HGuyw8xKibsc4KUOIOCoA2jK4bXBt86LfE0E+CcWKFn25mneB?=
 =?us-ascii?Q?MEFekyewcpJ3TOEqYucNSuDrWv/30zrxLPST4Zy7qYmKkemRjsSA650FOWK/?=
 =?us-ascii?Q?tDLN3LQZWWTyICwmcdmgtd4Rau1AW+vfSAibf/DAlOMhlVyoHSxI1zYcBSdc?=
 =?us-ascii?Q?99QQ00usNUakjLp6La/5Os3hihM/0zztRWNbOvKIcqITTjRax78DycUin6fz?=
 =?us-ascii?Q?r3gV/ksdeeWKbaKE4M5HFWBMQ4c5Cmx2fCuucDaMLP6w+AuXt5ldPVmGs1vo?=
 =?us-ascii?Q?k9Mr+6+zIkzsUVMi97v+9wSmrrBWmvPAcxOiJICxEH/gWS0d85skqzyV6sIA?=
 =?us-ascii?Q?yEUGfypX0cvhmY9B5vpOM2TiQYPMuDzivVV4P7a3xMiEVVlS/aGJ5oPC2QXo?=
 =?us-ascii?Q?pHKzxTYskpyqBnub5krClxzDHUOkE5VHNQ/1R1A84z5Ljlejy9vCH7po5SyN?=
 =?us-ascii?Q?0KZDlnkFPBgkdtBm4o19MSUNK3+DyfBQE7t4Inzztg9kXuwB8ASjJEoGh1V6?=
 =?us-ascii?Q?RqOi3ccPcIhzHP3lKCH5uah0MZeXqCfWc+ydGZYtCDCzUXyNKw+bfMyCxyKM?=
 =?us-ascii?Q?INfthWg3tWX7O6iE2wlRctNINRtnxxL0qIDGzYstbowdd0oo1HVw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78120355-153b-4880-af61-08dec7cf60bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:37:42.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCAtlHrWvN5cw+pKk1Bmlt1h9UPKmFVodwPhrpmz1gJcwpoU/CsDQw0Pmt4qsbDgIs5L19FbzHKepQwLIy4+ulu0SiwpfRJLi+/liaeoNWfVX877b0HTC7pVnyeCI8yA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8697
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11466-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zh-kernel.org,gmail.com,google.com,lists.ozlabs.org,lists.linux.dev];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,lkml];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,lizhi-Precision-Tower-5810:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEFDD67326D

On Wed, Jun 10, 2026 at 08:52:42PM -0700, Rosen Penev wrote:
> Replace of_iomap() with devm_of_iomap() for per-channel register
> mappings. This eliminates the iounmap calls in both the probe
> error path and fsl_dma_chan_remove, and simplifies the error
> handling by returning directly on failure.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsldma.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 0df09789187d..dc70a6bf5723 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1119,18 +1119,13 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>  		return -ENOMEM;
>
>  	/* ioremap registers for use */
> -	chan->regs = of_iomap(node, 0);
> -	if (!chan->regs) {
> -		dev_err(fdev->dev, "unable to ioremap registers\n");
> -		err = -ENOMEM;
> -		goto out_free_chan;
> -	}
> +	chan->regs = devm_of_iomap(fdev->dev, node, 0, NULL);
> +	if (IS_ERR(chan->regs))
> +		return dev_err_probe(fdev->dev, PTR_ERR(chan->regs), "unable to ioremap registers\n");
>
>  	err = of_address_to_resource(node, 0, &res);
> -	if (err) {
> -		dev_err(fdev->dev, "unable to find 'reg' property\n");
> -		goto out_iounmap_regs;
> -	}
> +	if (err)
> +		return dev_err_probe(fdev->dev, err, "unable to find 'reg' property\n");
>
>  	chan->feature = feature;
>  	if (!fdev->feature)
> @@ -1146,11 +1141,8 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>  	chan->id = (res.start & 0xfff) < 0x300 ?
>  		   ((res.start - 0x100) & 0xfff) >> 7 :
>  		   ((res.start - 0x200) & 0xfff) >> 7;
> -	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
> -		dev_err(fdev->dev, "too many channels for device\n");
> -		err = -EINVAL;
> -		goto out_iounmap_regs;
> -	}
> +	if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE)
> +		return dev_err_probe(fdev->dev, -EINVAL, "too many channels for device\n");
>
>  	fdev->chan[chan->id] = chan;
>  	tasklet_setup(&chan->tasklet, dma_do_tasklet);
> @@ -1195,10 +1187,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>  		 chan->irq ? chan->irq : fdev->irq);
>
>  	return 0;
> -
> -out_iounmap_regs:
> -	iounmap(chan->regs);
> -	return err;
>  }
>
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
> @@ -1209,7 +1197,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>
>  	tasklet_kill(&chan->tasklet);
>  	list_del(&chan->common.device_node);
> -	iounmap(chan->regs);
>  }
>
>  static void fsldma_device_release(struct dma_device *dma_dev);
> --
> 2.54.0
>

