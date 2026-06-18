Return-Path: <dmaengine+bounces-11589-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YVUGEY9kM2p9AAYAu9opvQ
	(envelope-from <dmaengine+bounces-11589-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:22:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D276469D4FA
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:22:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=ifor4bD+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11589-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11589-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 287ED300CD84
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 03:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614A2F8EA3;
	Thu, 18 Jun 2026 03:22:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9D2D7DE9;
	Thu, 18 Jun 2026 03:22:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752972; cv=fail; b=DwLyT4s4nUUxeoLJSL/3+a3CqnE6uABykzbgRGz5kJFA7zybY3hTjganH7PmH8EIVa19tMxTIHFBnGkCtB9uglzVyH9bBKr592EaTHSFNZYQfPY9ffx190pkoSWWTVf8q+GCiSgjvHhNUFBLmk8B/pvP6FVLyA4DL4tSajLpl+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752972; c=relaxed/simple;
	bh=9mP4d0V57nM01/JLxZq/6YGUi6aZgZf1IsCrBUvWu5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RAEpjqETAaw9wQ2gb0VPQfPBcsXbtRJ684KKwZRS3MRqVyS0TyPVoRuxT7Ah6taf1mWElxs8SgIp5l1DDwjVgNTqj6g4BGAGllakcnUU3ySlAWnibEwRYn/8u4254AwtNZxkLcEIOTKBUK+QZ98RWWeYtXgCf0bl3oNi97zT5TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ifor4bD+; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFxqE/jUE+WdG03Dq96kIPZfyX6M91nxuT2yQC4H+RCBA7XZRB5yEtNW0HHaFhI+X12mihiV4hAl/h3TbDH/1vKOydVL7Qmj/F0zJxCgb8ESowF4LhlS45r1LVvsbKyPQAJsHd0SfbhwNHDGP1PvWutWAqgLAhjimlb04Ak1LnBBzwHtSpl5TkDSdFesC19db1Hk4MEtIBuHPeV3vPbh97uSbISP9yIyTflIHpOxgOfnOS1t4Q5vVQLjmwSh77AVL4TAYPiNr6PI1QCeU8hEYuRHVy79Lw6uM4qoDVFw6seN6O59P5LnIHIUIBEs3jFZMqD0LVFYuJtZ1seabSVogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o/5NRD0Zwl94jm5NT7HeVe+nq2xxPf8UxZzATaP5+4=;
 b=NDWdznfz7GD7+1VqZbf5nmI7BPBIJfIdPOYqv7M/ZDUn+VwqO9iPNb0AbzsEnnXdwSR+GsHC0+hcm2HpDwid+x5RxrfXuYfRAILtj0EeajtFBttvTsxmW4SD/quoTFALD4sHH1nulO2BHno5QfQXf9ycJBBK1VHTnNwsGVSgZCqf5z4vTDo3woCabybZfpLGb9mS2DxgUnWtOJrK29/KNcXQya2o1QEwRTnBtpRC66w3/n4ZcV9IkQPB+kh2ChhKpxys+6/FKez2Rbh8kQClyPnjOGNsD7DtguHQld9cWfe6oS8i/fO45alGOy/yqxd0p33lT4f0QFAJP78YFULdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o/5NRD0Zwl94jm5NT7HeVe+nq2xxPf8UxZzATaP5+4=;
 b=ifor4bD+toeaf/avzIazdHglohpfrBqi/LxJF32gf+6LYJR8zyoJRRw6uPiYQqq5xZ9q64kFzcut9CjrNYY5v34Jur2B9/w2grsb8y6H/bIQ4J6WsVlMb38e7YqA0d3ESffbo/wqJg5eacNmuBvCr6ywVDdsJx0OuvJwDv5HOYIWdiYurs8YDGKzzasaPQX7H0YBZYUbDtM23Ibb7tV9VycIaqRcbfQIFAFKV2jgy+tVZLL4t3vSBUdOKhPw3b2W/ybTJmBtEYNKPLmL6jZj8SRtcBis9UDajEo+/SwVnyObTUO3d2mYxxLr1+X4tpEg0IfG+ZPOWScgxv+eRUW8eA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7379.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 03:22:48 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 03:22:48 +0000
Date: Wed, 17 Jun 2026 22:22:39 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
	jernej.skrabec@gmail.com, samuel@sholland.org, mripard@kernel.org,
	arnd@arndb.de, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhongling0719@126.com
Subject: Re: [PATCH v4] dmaengine: sun6i-dma: Fix memory leak in
 sun6i_dma_terminate_all
Message-ID: <ajNkfxiefKOgSdgV@SMW015318>
References: <20260618020609.1155962-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618020609.1155962-1-zenghongling@kylinos.cn>
X-ClientProxiedBy: PH7PR17CA0056.namprd17.prod.outlook.com
 (2603:10b6:510:325::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 988cab15-d7fa-430a-c22e-08decce8df58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|19092799006|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FnrAcuiqA0RnhiuC+Y0h94SLoC/AMubRiB2FREPHr7yavRspRj2Og3nHF8lOe5JO8Wq2BfFQ/lfWjh5rtqo8LBVSDU7EHYEtMrjhNprawTMtYcaYQOIrERnV2R5wbp+q7xxAQTB8KvZbhL95RjYUbsFgWneB4xr4LdiOv2Wbb8fJgWM73UTCFpw1Slv7J4ooRJh0FAY4K+og7TfMq5ogjzVF+4xVtw1l2CAB0QN7RrRcszQMRGRt9II6JQo1Xd5CaTYEFQ5Fq83+kWvSep9NvDPDW4teH8R88JJXcyXX5LiYbGOiyLSSO52gLEklCxaLed+lpHIMGJsUK4AtoE8tzYRoToa081N824xaxxXD+Cs+86B541Soq8DXAg9Lj8GwT20KfFcMLYCdT6UG/SilQySAaN4w4n4RbW5kc/CG4/rTJ2dkbUSyk8I/RLe/FqfwCZ6cl0Qd3l2mPj28eBB4iAyAFIXPDmr/uvFmS1kP6kcJc3r3pmbYiTlxij0oa1FNkK72PnwUXAaL9kb2zCMFEXLaNbAtd8KRm7LYvC5Ea/quPgOYRofcW+yBHwNZng7enHXiLLLTcecGZZy3pOSfuW5oRcUgFDHXTR4hpzxEGnnivyMmU23sSt85aDsYOYv7VqyKDfo/Zs2Zi87l+pg0/XFOWVdpgYGVY7eR09VlMDMDrBYKW7DEpDd81XLP5xIy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(19092799006)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6T4cyzNgl0OR2Gse8lLUDJ8BJliLNDRPuN+p+TKhZXa4gjyiigWYG+AmkSTH?=
 =?us-ascii?Q?PDQrh1Y+KHESf5m/TFKIF4nhZRARBAnANjBfDMVdPp3zT7yRxFzxKtwvm49T?=
 =?us-ascii?Q?JVJvlSuNfUscJeBlclq4ALiH7UZhGsPAGYhtIaP4bkmBHrF087rpTVDpZ9Hd?=
 =?us-ascii?Q?0Bic3ezwci24RnPaVya7DF1PRtK8Ab8TUM7et7tmczIG2hY7Cn6gC4bIDIym?=
 =?us-ascii?Q?WGJjqK2Ck4f/wEdJuOUevp4xGcsvfciaJ+UZPFkMygIYGdrCz3f+tUJDj43V?=
 =?us-ascii?Q?+5zurmYIpiPyaKsf7kf34mRybve4KplILauxh2HsscUJkLDeW4QIRU9sS6d6?=
 =?us-ascii?Q?61qO7JUJVH+nXcx88XwH6Tm+0H0zK4UivRMkaDEs8+dWjB+6ZTrUjrNkdbB5?=
 =?us-ascii?Q?aZXctqu9gPDxFwDsXpfvgxBk/PD8Imi3lfluDSeeNTGQA1txNJxZkjznlh9Z?=
 =?us-ascii?Q?8VpJHfasZl6TC5ZUc9Ag4t1BYFEzM5IPLXTrIHYmZKKdQOT7uQAKYnNWNKHo?=
 =?us-ascii?Q?CAvUresYibEm1zN6lijaFAPVjes0xAsYkRP+O9ycCiJMhwgKQieuvaIOmWCk?=
 =?us-ascii?Q?hdboMbPIR7Rm6IT05vMmmc9Nwoyh9HrIhU8lzKQ87NKFgIIgiO+IcLUhDUYa?=
 =?us-ascii?Q?6jomf8X+DSNr28R3FWIbMY5rB4CrZbTTcOn49ddPs+NFctDerwi/FAM871UI?=
 =?us-ascii?Q?ErbzQOVmM1/EzLflZVPDqjeT/+YEjFvKtJlYPHMf1oozMRRZ4bOvBf/RV+mM?=
 =?us-ascii?Q?kzieN4/Q/QpuPH+Dwd16+zqHdd0VxZr+RKP0EdG9nu+8zdP/pPMG6b+Toh46?=
 =?us-ascii?Q?APBi4ouTySgfTwkBmrRa/dYa6dAuexNrECRRIDNIJb1/aGQhuVcfAYF/NKMp?=
 =?us-ascii?Q?0WjAhtEjCaAxljSc3VQPYBB2elqiZ2A4cPMJ+6XZEnDTWXzaX0xqkY0XWN0e?=
 =?us-ascii?Q?mhDGXITsOoWmg4lpBvNL7dy/aE9tXjMLh4tcNWsrIcntw0WjSgUBXGDzPWuK?=
 =?us-ascii?Q?Vkp3y02aaQROirhSLAMTAqaG6zku4kbggSh9AYl77QMM3gsTKsggpQ0LBkZ8?=
 =?us-ascii?Q?kA6GOHVl59ABKDpfLyxUZP5wLdlt+Cwgh0RyUSTnIuMuKQFqMWYRadPsVrsW?=
 =?us-ascii?Q?YuKv0WBSRANNhWxJBvZaeIyivplQX6/jB7OZg8QDf8IPUBjrSHkKoLfMyzvP?=
 =?us-ascii?Q?+bUQNJm5CkaA8PT/oM++8hQQslvIut6E9SclnsOKZ3EfCPl1xJaKT32qCEqD?=
 =?us-ascii?Q?p36QIq9I+zDeTs8mpmKgYC/8rzPqDvA/3GRu4OGLTYaqe9prt3T6ebLsCp7R?=
 =?us-ascii?Q?UJzBEfMX0ii4YO9s+GtIouM74V8Nxc4FBdOPQUxf7uSreC53CIHOWdNV2DF5?=
 =?us-ascii?Q?lk2crbRiKVmolsO/3G6pEUn0Beh/qePUy2sZfSV3d0mZslxtXXWSyb0tzGxp?=
 =?us-ascii?Q?f3QNoIUhTLsPO2Ji1k70ERHZFRw7IZt58oJxZpKJdabnpxmNfhbW0VGe3aTb?=
 =?us-ascii?Q?+cknUbi+aqF0aa1AcnLbJQ2K7h4kSiJsQFDl7RGk6oHN+cC40pkuOdLn5a2s?=
 =?us-ascii?Q?t5w5+C/uFUeVgn9Zwn57eMntr/3UAC06D5yBZHoiKEAnE/EtaC11AGG+/qlE?=
 =?us-ascii?Q?ZLuA9f/Aykz5Z/8A9RrXB8VkGrHshRW7iPsRZramhUiHW5HtVXNDMrV2zvW+?=
 =?us-ascii?Q?AKVKS1XW2iT7n5WOpdeF9l2pMPAD5CWwAKDdL8dnboHL3kk2OovEy2Hh7ALJ?=
 =?us-ascii?Q?s7DByoyX94BRjZRmOScOP46ua1ZOs63rJ7MsSTAfqn0foJakQd5P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988cab15-d7fa-430a-c22e-08decce8df58
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 03:22:48.7435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEEdOejGcaD5SvJo3eAXMhL7+qPC6w899j56IBI4PfPkB06OHp1wEfg1fllo+qaDhYFGaxsnLNE4/AWCyohLDbi5kst784ktTxw8QqN/HF3ee/9m9AFDGCWRbk1uBv3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7379
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11589-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:mripard@kernel.org,m:arnd@arndb.de,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,arndb.de,vger.kernel.org,lists.infradead.org,lists.linux.dev,126.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email,vger.kernel.org:from_smtp,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D276469D4FA

On Thu, Jun 18, 2026 at 10:06:09AM +0800, Hongling Zeng wrote:
> When terminating DMA transfers, active descriptors are not properly
> reclaimed. Only cyclic descriptors were handled, leaving non-cyclic
> descriptors and their LLI chains to be permanently leaked.
>
> Fix by using vchan_terminate_vdesc() which handles both cyclic and
> non-cyclic descriptors by adding them to desc_terminated queue for
> proper cleanup.
>
> Add pchan->desc != pchan->done check to prevent double-adding completed
> descriptors, which would corrupt the list.
>
> Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Suggested-by: Frank Li <Frank.li@oss.nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
>  Change in v2;
>  -Add pchan->desc != pchan->done check to prevent race condition
>   where completed descriptors could be double-added to desc_completed
>   list, causing list corruption
> ---
>  Change in v3:
>  -Fix by using vchan_terminate_vdesc() as suggested by Frank Li
> ---
>  Change in v4:
>  -Correct the commit message
> ---
>  drivers/dma/sun6i-dma.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 7a79f346250a..134ae840f176 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -946,16 +946,13 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
>
>  	spin_lock_irqsave(&vchan->vc.lock, flags);
>
> -	if (vchan->cyclic) {
> -		vchan->cyclic = false;
> -		if (pchan && pchan->desc) {
> -			struct virt_dma_desc *vd = &pchan->desc->vd;
> -			struct virt_dma_chan *vc = &vchan->vc;
> -
> -			list_add_tail(&vd->node, &vc->desc_completed);
> -		}
> +	if (pchan && pchan->desc && pchan->desc != pchan->done) {
> +		struct virt_dma_desc *vd = &pchan->desc->vd;
> +
> +		vchan_terminate_vdesc(vd);
>  	}
>
> +	vchan->cyclic = false;
>  	vchan_get_all_descriptors(&vchan->vc, &head);
>
>  	if (pchan) {
> --
> 2.25.1
>

