Return-Path: <dmaengine+bounces-11220-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 27wTEahSI2pnpQEAu9opvQ
	(envelope-from <dmaengine+bounces-11220-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:50:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96A64BB7A
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:50:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="SEsZcy/S";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11220-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11220-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B39253025882
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E013F413B;
	Fri,  5 Jun 2026 22:50:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156A17993;
	Fri,  5 Jun 2026 22:50:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780699812; cv=fail; b=U+2iybFmOHqKkxpdKR+Fp6xt9jMRNf22khTrRoc8PgxYhpsSe2lIOEuL/AJpQuyv0nwWBbr22ECOCqA07iCouqSC5H6Y0FCcP+a9dIAFmNG4DFfZeW/JTrAjuHQLBVu4QiHpsfa0ZwGXd/NmQKno21TPmSJn2fTmCzC6d9BWbbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780699812; c=relaxed/simple;
	bh=nHVC33w+dTiUJ7AWateuH6q7T+uai/OXqzw0rfNOpiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HISaCvK6KFQEb36mrww86kVRtUrYvKCJbLVuyeEpSPcD/pNKBw5l6HFXdBRnlj5dAF2ejVTzJWvPpG87emeVXW/+/xjmr1IfsiRKuL25O4pRcjoZpH3zwyocDYJvXEGyQu7ru0GDh+/C8oAk4LopDCDkq/uym9QykRE/mVUMhzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SEsZcy/S; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YebQWJPCVwQjzXMYMzlwlXmqUBRU0mzOOrT5WwGrlPlr09BTctO7m23qc9Angm8NmZFsHp31lrB8QF8Prc7slk3C/Rq4fBHERONcHPpT1xNiZc3FkfVRYurBYNQG5QM7Ri6UO6meaC9Iw83iNFNjbSwqrZzFKQnxDgs24GRE7nlyd0R+eXhKVRrBg/owWe8W4duxvR8oAJJX7K7GhxyrjDC02dcFFqHKQffzmZeeiyPo2wVWM5K5qGKE30Fa2T3OiJqKUxGoo3nE8L9Ub73n0mZj2WPZDQcXXGKSapDB2i5En8qbhd0Z11gJOi+5BUi2kD5ukvVDSA2A2RAu4Vm9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpe2Fu8WUeR0NHOMvQDSzBzyAJvti7H/2jG3OM5PqjU=;
 b=Qo4y0jWCwmHnEet8Hg4dL+kv+l2ig0ZUPnIOb6BuR7I+wdmiSY3Lh6F2INWtXIUSpLD4sZoexwDAmn0VR6oXeUp71+kNCKMW+C00a73CeQ+BYYTbgKXRMeUz/E+gnHHBShkowb1OQEtJHLyFGi00cBRIo36EsU5NJrUfYtu9WqT+eJuVyfRdGLtndHJu3ED6Aq/A+Qo0ZD7ijveW0J+mBUUhOCzmH6KLdNMX8rJ3IbDNSWsx2y4AXJX7i3id2LXJuH66gfT/j/9uSRoRFRout/Qzj9vnq5V3MZg4z8yPqlnr+gBjf3vF5lWvVML0cj50BvEp0JLjSNjHUOmy3NZn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpe2Fu8WUeR0NHOMvQDSzBzyAJvti7H/2jG3OM5PqjU=;
 b=SEsZcy/SLFBCYOFeGe7zrmrQiGLNaCilU2UfSyMr9rCqo5fzpuZG4pek95Cs6mr2GliF8hEWJszgjRzTNbn6aaaoGvp9DjS3A4NQw2pTSFzWssewIvyjbTaQl/GS++rNBzwKA5t453eDpuw51dbp0Ttzd44Aow4XKgPNfMeDLLKhb4985t7ThWEaZnQxM4GD/qtzyYHxwwvfiA2jo6n6MQzwdN4xzybzVlJH0PRjJ0eE6fHnFiMWtxmO6rnSzfdfoIK5Vg3iPMD0qmwxCT+WOB/PBzxQ44/4HnpkrcHY43e5mA6mqtvXDOiy/VtT+/tPxcbfS2gLs92mCwdPExfFaw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MRWPR04MB12355.eurprd04.prod.outlook.com (2603:10a6:501:82::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 22:50:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 22:50:05 +0000
Date: Fri, 5 Jun 2026 17:49:56 -0500
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
Subject: Re: [PATCH 07/10] dmaengine: fsldma: convert channel ioremap to
 devm_of_iomap
Message-ID: <aiNSlBpVjYq6aEgg@SMW015318>
References: <20260605220134.43295-1-rosenp@gmail.com>
 <20260605220134.43295-8-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605220134.43295-8-rosenp@gmail.com>
X-ClientProxiedBy: SN1PR12CA0082.namprd12.prod.outlook.com
 (2603:10b6:802:21::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MRWPR04MB12355:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3cf3cd-0a5b-472b-c7b0-08dec354c8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	yKaMF8FAVJy7EyJdJtLysxC10Es+GEUuCC6mzrkfwcgG7xJlsuu+3w2wBiCVirJuDjVLNmdvSGCXJ9U20jYAX9LSdiKRxdO9RZsHWbBWhC79alsoOJqbCJXWMGHs/QvBYPUVjGdQ0irXkvuvuaCMIIQ3FQMkpSJ9S+ybfv5UKYUOeC9W6eW7QnnVbuyp4Zs4m03M+dVbXWGJm0bNnHNhd4Uv38pIch/VRy50NN+Zc9MRqQv/PcGzTsf/PApZOSqTqQDCS/3iK2Eow//aKZcT0AmNd24FpCIP9X9SKTF9PPAbSLH9XldipUm5/r99h52afd/qkIokkEWL8Wao6+zWY89aL1KmiTPdXdJI070uKzCFrox1/Tq9cgd6ANuaV7zMG5n0vJk56FhN43jJWdnr+jDNsR2uLeEaonJavUyXYQjdez/hUfzuXtADqpwX85DQtt53fxcwfEb71JSJTd4sWaYw7XdkhaB3AtDv7fzmmfDTm0vNhch1d7+iGc6sypMrjsMzEDIk36Uczoz0/1b5UsuZEJH3WYGhZT9CJgE/Osbv/HnuFPXhP85UM5C5/OfWC93sMWw/vQaXGJkprD3R76ScJnwnfkrAS1qpng5OhipWL67tl6u06fpKVbQFGXDicj9w7RbraYfqzqdjuDQCncwDd0tqt4nGJhMZkgZM0KLWpGJ8k35YAfUvBzO64IKM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+swQKjZLSvM0Eyd5ZDeKUi/FSy+fdGeieeGWsCN4sm9WqK8fVI6FQlV6hWYx?=
 =?us-ascii?Q?KldIhBEZu994tTflj4bcDDwb3oqmBq0AGX/QRItG+dNjoaINKA6KCYEHxQsE?=
 =?us-ascii?Q?XsHLS1Gu1LeMGcYHiwXGJMrXSi19MhG/B7f9OrLoibSCuHm+u6XiJvaa6i0L?=
 =?us-ascii?Q?7BV+YDxK0bVN7HPAHOYJf5o3iRFoUpXjFfqk5BKhj1AsM6jOmpDhw17R3AN7?=
 =?us-ascii?Q?fZUAEkCoohKrzyoh3R0uYG9lnmIea3t3s+VKu+g+gX8wXA5X/z1vC54kdhkG?=
 =?us-ascii?Q?sB/cIRZFZdmZVi9HfCR9HSBsrp0SLyv4oUBu3xthtbAdIh3Zgxyj0HUGVpQE?=
 =?us-ascii?Q?UzCUjvR3wWZpmOeuHgLXPMyCPIgG2Zm6GigtnpcXTBLzF0RmzbMrMqgC8fTW?=
 =?us-ascii?Q?9wQr/UPSZIRz4vs17mGEuIovAHGuJEraHGj3XUciGTEP9KLSYlp6K2OMF9kD?=
 =?us-ascii?Q?09mR6qnmOJig17hGixKjvZlj/lv/PualYQKJyOqX8W+9/Up4VR+7dc7Gk8L7?=
 =?us-ascii?Q?CnTKQMpQvvg7onDn8GVmYkIHOc6tchO8cs2xKGV7FsIL+peAn7JjTRYlzU4F?=
 =?us-ascii?Q?0kZ5yn/vQdFclxcxbl8H1gCAIaDTndtPEkC4Da3sm/KUkk8vVyv3PeJkvX4c?=
 =?us-ascii?Q?5rarRWgSK+ggt+f9FMnlPtJ7Veh0L7L4X+m1opeF1NArV/Koq9rymhBH85Sc?=
 =?us-ascii?Q?1gIS+ZL/Org0LG/i697M+00/o9spisRp0XVRw3bb3BYyTAJfkPFh9nLKmDDW?=
 =?us-ascii?Q?NSZumb7TuVsJD6sSKaAOsQ74bFIs4Dt8ScBdvXHmm0TIxh1PARK87soqkSZQ?=
 =?us-ascii?Q?9RyrW4LM1qfe1H4utywOkcdvdWewtERS3AU6dO+kgbGXkDOfQvFjEZLujPl3?=
 =?us-ascii?Q?maD+psRbRC9mm7MmhfndC15/bwCWuFJ/e3eUyVWrMXLkY5NP0mNH5qodZsUc?=
 =?us-ascii?Q?g6zZREXB1xJc/Q4vG5BPuT08PbE7gGXxYy8A68SFgRbomuqK8uurEowlKMw7?=
 =?us-ascii?Q?rCysK8PSvC/FAMC43iP0UIfUWW2AfuLyOCyxxWU2GPGj1O2oz78CPNtyTrW9?=
 =?us-ascii?Q?22vHrryzHLHgHzt9+tiiVNFmhjhhAK+vmZUT1OPD7eHT1pX8W8H1DHAEL7A3?=
 =?us-ascii?Q?8F9eeoltlQKNxk1zMVHPbjCeoNoUNNPOjFnz3Gqw3Mq+F9/uzr2MH2TI1Mdk?=
 =?us-ascii?Q?/WykJK3XjK1GMA1obB5fyEy/i7U0ruhVlUwnXCEzxyZEg1YjdBydEhqiULZ9?=
 =?us-ascii?Q?mKoEQNb16SywMQgB5qsO0aAz46XaR8a2aawOvr68iMD15sWYFvvQu7KNe2LU?=
 =?us-ascii?Q?G6DLgR2OniSWB3McZLVLAOQujZvPsXL+el/fs8q+TOIxvEVfCQIkI7Uyv7NA?=
 =?us-ascii?Q?jsbkn9opCG9bIbmjD0HgU6gQqZjVNbrok7cyAMItzS/cVmWUV1YJxpyKNOJt?=
 =?us-ascii?Q?wS7+OGcP1ZlRjF3hsWGGAryg+g1q7a8gCcLm+g4cIAw3mfAyuBF+V/ZxnRBI?=
 =?us-ascii?Q?PbYKIPgw4mbQUDZs0LCyON8ZpThbziARZ23ZNea8NbNG8JV5p8TcAC1McZTG?=
 =?us-ascii?Q?PTHurib3rvvpeN5KMB94TlmUlMFzVOxQeSOFligio8Yfar8VbCQvrqphnUyC?=
 =?us-ascii?Q?3gmqyK2sJJCrrOfKvUVvh3jiXt9c/XZaYLu8DyNUHFN+nCq8Pdnblc+OwgxX?=
 =?us-ascii?Q?Jmit4vKWci/rvy1am1DBh+RIbrNjLYMVbc/5XylG+qBG8AzKOpnUYYUievZO?=
 =?us-ascii?Q?/Q5M6KebC4AGmMgpusLw6BqN1LPKUnGGQGjWdjVVH3dTBePl7OwG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3cf3cd-0a5b-472b-c7b0-08dec354c8e4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 22:50:05.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrxITXv9/uWntYOQtQuubRHjnJAcuhpXvNj7QoEDQYeSNnkUp1D1r0YMt2LH5Wuj5L6BsfQe4La7HoefbYPN/NwubCnhg619nvEfH1n122pYjrf8DF2twpLYfvx8+clr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12355
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:zw@zh-kernel.org,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11220-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,SMW015318:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA96A64BB7A

On Fri, Jun 05, 2026 at 03:01:31PM -0700, Rosen Penev wrote:
>
> Replace of_iomap with devm_of_iomap for per-channel register

all funcation need (), devm_of_iomap(), please check subject and other
patches

> mappings. This eliminates the iounmap calls in both the probe

Needn't "This", just,  Eeliminate the eliminates()

> error path and fsl_dma_chan_remove, and simplifies the error
> handling by returning directly on failure.

commit message allow 75 chars each line, can you wrap it at 75 to reduce
line number.

>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/dma/fsldma.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index ee6e595c2972..0d73ce3dbfe6 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1108,7 +1108,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>  {
>         struct fsldma_chan *chan;
>         struct resource res;
> -       int err;
>
>         /* alloc channel */
>         chan = devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
> @@ -1116,17 +1115,16 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>                 return -ENOMEM;
>
>         /* ioremap registers for use */
> -       chan->regs = of_iomap(node, 0);
> -       if (!chan->regs) {
> +       chan->regs = devm_of_iomap(fdev->dev, node, 0, NULL);
> +       if (IS_ERR(chan->regs)) {
>                 dev_err(fdev->dev, "unable to ioremap registers\n");
> -               err = -ENOMEM;
> -               goto out_free_chan;
> +               return PTR_ERR(chan->regs);

dev_err follow return use

return dev_err_probe()

Frank

>         }
>
> -       err = of_address_to_resource(node, 0, &res);
> +       int err = of_address_to_resource(node, 0, &res);
>         if (err) {
>                 dev_err(fdev->dev, "unable to find 'reg' property\n");
> -               goto out_iounmap_regs;
> +               return err;
>         }
>
>         chan->feature = feature;
> @@ -1145,8 +1143,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>                    ((res.start - 0x200) & 0xfff) >> 7;
>         if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
>                 dev_err(fdev->dev, "too many channels for device\n");
> -               err = -EINVAL;
> -               goto out_iounmap_regs;
> +               return -EINVAL;
>         }
>
>         fdev->chan[chan->id] = chan;
> @@ -1192,17 +1189,12 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
>                  chan->irq ? chan->irq : fdev->irq);
>
>         return 0;
> -
> -out_iounmap_regs:
> -       iounmap(chan->regs);
> -       return err;
>  }
>
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  {
>         tasklet_kill(&chan->tasklet);
>         list_del(&chan->common.device_node);
> -       iounmap(chan->regs);
>  }
>
>  static int fsldma_of_probe(struct platform_device *op)
> --
> 2.54.0
>

