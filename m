Return-Path: <dmaengine+bounces-10238-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAzSBjlX+2n+ZQMAu9opvQ
	(envelope-from <dmaengine+bounces-10238-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:59:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A30614DCC3F
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E88E83073761
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD9F481FAF;
	Wed,  6 May 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AJR9avjQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A23EE1E9;
	Wed,  6 May 2026 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078907; cv=fail; b=VPX2v5uO4KsiHXk8t2FjjztegKnKhE5cFOEd3eXGRm3y4TCEWTuKf0IAwYSPGNpzuRjMEFy5kEfzAyiYhYqZIRWGyoJQ8POT/qPGxugvG6MlVSnJjL8OgrdssvL2o4V7ArONcSUFkE0+TC61o2DYL7C5Xs7DNA4wsat9NZBaVAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078907; c=relaxed/simple;
	bh=+bpzRuQOdgwvLNiY+puGYBPIw767kNCVs7OI+ftkXao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IbbiU6quX5I8rD+ss9k0EEQIDExFarUHjLYwW+8Qf6GZx2r/w5PkDQTZ63+G7SWiPqMrWNZHZQE2R6RpzKaRrvlGqJAXKYe+zw+ojksynL30YRDLSO+1zaPYGxbhrinxKOk09DPEVJuptIoDyvnv4tVYKjvav0C5L/tkjQE+n0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AJR9avjQ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sj2DZBoV2mG77PeranO5xJYQ09TzggDt6oG13sH1syNVkaZF5Opef3lpEQjZ6yL2Rpx7LMWxMpVb+FBFhz5gKyi0POr5hj+zUCoiaTPk4YYdxEdSfiOpYb/FyNdliOkXvkLk3VrX6vZP9suubd4DH1LzC7MVFK1X8tEoX4/fVeHGF7abh1VmPf0Wxnxo/lawflFYLT8yf6erWCjtyTAVG2L24Y57UcRJwLt0eJXKLUToIeyq2f7IwyZ4+6+aCv5cpP9qtdvAWupysDVmae4Hr96GMGAJxgCT9L8a4n9+QjbrccNlfCmBpSxX9iKE3uYm/l2pOukZyJabvmDhk/OfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BYpj3CVMozcpbDfqq++pKgbQ5ULDYlx40xGV2sYLb8=;
 b=QLx8F7GsAMjMV2vpuFeo0n/54CT0r3E+FkTa3Z6/E8dpoyOJZl9NvFquQObFS69cnr00cLupy1BFMu8tfo2mNN/CuHxVYgBWUblowKSrUqt73OSU8tn0eSn/mu3mDRF9VaJ0ojNyNUEtwBp/Jl4M/9zMGbQQvjbQNddF7SSC+tnl9BG5sHIUM0kXIQAbOq6EAFon2rCt8Su5SCEGfE1v6Y0m6CUlOr0v/AMGd6PyENQZzWJtM1K/CyHEWetChLgaUVX0E9pkDArKNMixp37wbC07RZ14O9wGGcXuzlJaf/IsIKphhVHdoD5fIoa7gpFziJ/8NSnvjX2lWH6DuOwLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BYpj3CVMozcpbDfqq++pKgbQ5ULDYlx40xGV2sYLb8=;
 b=AJR9avjQI/hrJNCIInQ5UTQA93AkpWg6/m3LTrBaaY9b2nG5kY4Zj/rq67XDNBfKXoHSdYOr4ZXo2T5UfSxWlKVxMtZ7RNrMvY/iHyWvQuV2lBg7RmBBmMRPRqnv+fDIE+Z5Nh9gHlfYeHwxqeCWjTrZdzYfIfitReV7AL+K32guCkSwojafkG9YSjF2cHjZqx9D6Uxxos/lWMBdVVE9TLbOpbyTOuiJy5I5+bgVpUHKvDE89BluUIuZ0VMnoO3/f1N3SkaK9driql10TWMOxM4TNt8UPlnFlDD42mQPaewmNciSV8lh1afGbdQcWwrF/U6qN7aE+wzoTsTC6P7Zqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB7767.eurprd04.prod.outlook.com (2603:10a6:20b:288::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:48:15 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 14:48:14 +0000
Date: Wed, 6 May 2026 10:48:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] dmaengine: fsl-edma: Support dynamic
 scatter/gather chaining
Message-ID: <aftUorBAXzTD1BBD@lizhi-Precision-Tower-5810>
References: <20260430-fsl-edma-dyn-sg-v1-0-4e0ecbe2df66@bootlin.com>
 <y-kZDXvATLGuBxQOHfCRwA@bootlin.com>
 <afoHxJM-s846s6EG@lizhi-Precision-Tower-5810>
 <43uRGEDfSHihWPAxby2EOg@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43uRGEDfSHihWPAxby2EOg@bootlin.com>
X-ClientProxiedBy: SN6PR2101CA0011.namprd21.prod.outlook.com
 (2603:10b6:805:106::21) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: e3612e04-5931-44b4-9423-08deab7e805a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DP//BCydTzvqmh4qzP24fWqt0WXdSSltaVjzjQ3/MCsw51T8ZthOjX1Q803w5hJKhYEQrOZVV0TT4pPw5GuPJVEb7VKzXTjmkWqJj/9Q/6F94Y+7f/wn98f00hcWMaoI9FQz0EV+mSo5qF7tWRUQqjJFrdPcXNOD+mJZXtS83CCR8Rlfe++FwXMoXJpx2R/C25Rde76IVFXoxLtoh9+L0F60seJWcsvR/vBp6rEOxmpx02Qbuf38Z5gdv6VKFUYtH6YC4X6s0srBY/GLKGdHHGEJ5a/lQmJfxUAFGxEE1kmc2YDqe6IMGK9EvjYLlKAHwRL8MqIYMD62DwdzAk9qWb+1RMsj07l53hLW01hyMlP6QqmLIj7u4xIeXqEe33+DiJti+v2GYvywhol0BcHGd+j82WB2oUZ6Ee6pgDMFAjYYmOiY2+NsLZ1ylBl62LJDCqmMMk9OGXSVhzvNmlDms2BAgYvNuZaMivDRLP4s8kfaedv7v+XTeSIzEm9rDws8IYqJ4v8eaIIRVH5v78jQ3P7qAuAolQ2AAz/+MY+Cs1WGNoPIFNLhxkswQXl4ODXwYZW38CWSfkiCpBPwNWWLT+CBT53Hd7FDr+DLM/3ONVVHNMnFjrRU18ndQlI0Hvb3RKkrf0HjM3k6LfziZFkQuLgKOBBiz1ARH6GT7Mv7S5KmMn6NzcNp1br7S9waRP5G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?C2Y0dC8eAisXYTmg16EkZxyyOHIaHEAe0hX3MnPSDQTW5pQC8DOc8bhFc1?=
 =?iso-8859-1?Q?JOI5tyo+l3z/4BFBg4RRjierxEobvUlLe2lm7KigG9DW/VNfMhG+uaZ/RG?=
 =?iso-8859-1?Q?YpknOx5oc7DX6wzZcoHFYeztCy32B8QP4vmrGRMXHG8qI+Ar04HXnCtxli?=
 =?iso-8859-1?Q?+EPSED23abiMyHBVQpfOCwu1eSg0jqjOIBNwUVH+3Zdn3q15RHe/fkaDyK?=
 =?iso-8859-1?Q?M+VQgvZO6QEQpxqaKvBbusIewbph07IsptoIHrWeuZr2GxvtmS/Dw+2feV?=
 =?iso-8859-1?Q?SQM8PL2O9tFLxQGeX3OxlZKnX/6M+byA2mKP+ejqkcslGTU8iY96ffLBDn?=
 =?iso-8859-1?Q?B25V1KBSyQxbVe8wcPnfvtHtG96aIIoxrtbHBwFDfo5v4B1kuSyHTV+lAD?=
 =?iso-8859-1?Q?hdun5UwAySxsLjhEwSDvUSXFSQhcM/NBKQSjzfbSsh8i8laL/Jklon4f3m?=
 =?iso-8859-1?Q?vk5EE2YRNqJEhhIH5kZtxwgOeCfie8/JeoR4kqoDfzpeafLH/V0eHzL3jH?=
 =?iso-8859-1?Q?Qmdjh6wY4DyKEO0Oex3lzlJWWpzT/J3lp7F1OjkAOaXNnNmhNz1n88CLCZ?=
 =?iso-8859-1?Q?rGd5t8SawYNQ8LCVE2qQ0dxxNmugkIKpid/fmt66WXIacpsIBS82RQ74Bt?=
 =?iso-8859-1?Q?8tSP10LUd7UB6MTy5iBIT6yADbpzlQmS4l2Az8xN+ScijtlZcdK26Iqv41?=
 =?iso-8859-1?Q?uSMbvLGJ/ArliDNcbbkMNXuKM+WdW1fG7uHiUgOUzW9W3UIaOlu3qiCBBN?=
 =?iso-8859-1?Q?Z7zTrb1HPPfaG57VsX+1EFgLzJzXZckWkdS5vuQa7yVN3eSW118YSFw/Y9?=
 =?iso-8859-1?Q?ABIeGbOwEOKzEDod8mk+Zqv0oBDpqIs70biNLYHlDh6Uw+rGM0ZAxq7pJx?=
 =?iso-8859-1?Q?qodr7HuvblpSxkHaDsg1scgYArpeWmuyHA5vL14V6kALSdWvpvI27Mu90o?=
 =?iso-8859-1?Q?/E/rycSWpv8d5vn5imHiPdbnRPsVNMxWdZY7nTYduvdCvMDZVhe2DGU51c?=
 =?iso-8859-1?Q?f8n16AsJmkpMGNhZoaA4+0QLY0AXRmTkJO5T7wgamR22warlcFHU0H5t6O?=
 =?iso-8859-1?Q?WNzbDoRom5VWtRp7v2NrtPk9InlUJ3Lj0taZ/aek9V2l4QSMkd1FyyOkbm?=
 =?iso-8859-1?Q?qhh1NpNwY0mio2avW2Qi6cyW10xbl6P/vMf74s20CabD/JkoU4QJTk3wNk?=
 =?iso-8859-1?Q?SiVgisSQXdKmA3OdsW5ykmIBuGq7NDfvNIJxWghquOLoW19ndl/+tcKkoA?=
 =?iso-8859-1?Q?fHKjGKxgOOFV4F6gIzdEcSJrtlfkBLhQ+R8VREIRrW4zNjJOvLGfnKz8dh?=
 =?iso-8859-1?Q?sogb6epCKJD2EVBncJXy2mHpzZYqOnhgzrC9FaXjfZZwaAWPX+t0AupwYC?=
 =?iso-8859-1?Q?m9lGY2N5QtjJwq5UDs4euBu1Q4KIGYFtogxSj/0V270vMDfMgjtycLwj2n?=
 =?iso-8859-1?Q?9xyDI+lj4WVTWAe3rhk4purLEghFItUyf4kOJH1FAlGoIdoS1Pi7Lg1uen?=
 =?iso-8859-1?Q?uNJhkHlgUHcpZqrpqekP5IZi4OvpBxyZMu5/kFdP6kFlXxwEncUeI6XcRD?=
 =?iso-8859-1?Q?BfShJSJMeIHNcqTB+wMcfa6L0mGV3/ZRePry0b9Svl9ksLlmxxf6Se6ucd?=
 =?iso-8859-1?Q?YkeMU0JY5ZDQo+DcOXvjxhPEzPFf/PEf1HHgHGnUp0f1QShhQ0JuJMgjII?=
 =?iso-8859-1?Q?Zl4JXPxzxc17V4MOkDlaEwx1nUKce/actp+aGwN3bb0+pvn2c+kaXZlgPR?=
 =?iso-8859-1?Q?ybZ3ai9QPvoSu2tUNj7m2ZD95EsDxGl3VHnUcbLlGGWxhNJx3xCgpe4E+d?=
 =?iso-8859-1?Q?oKooHBZujQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3612e04-5931-44b4-9423-08deab7e805a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:48:14.8779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pALyWhhJvL5VTL0UHBgGfgKzHMXXMnqThvWiW6S5nTdGgw35QfSk0yfmhAYFpOTD7QS3zREbfKZSaqwV3BBYxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7767
X-Rspamd-Queue-Id: A30614DCC3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10238-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]

On Wed, May 06, 2026 at 04:01:37PM +0200, Benoît Monin wrote:
> On Tuesday, 5 May 2026 at 17:07:48 CEST, Frank Li wrote:
> > > >         how do you test it? and how much preformance improved?
> > > I did my tests by doing SPI transfers with the LPSPI controllers, doing DMA
> > > transactions with different number of buffers and different buffer sizes.
> > > Without chaining, interruptions on the SPI bus occur between each DMA
> > > transaction. With chaining, the activity on the SPI bus is continuous as
> > > long as DMA transactions are issued before the end of the current
> > > transaction.
> >
> > Does SPI support issue new transfers without wait for previous transfer
> > complete, or SPI transfer already support async queue?
> >
> This is done with a local version of fsl-lpspi driver adding a simple
> offload support by borrowing the DMA channels allocated to the SPI
> controller. I can then issue multiple DMA transactions with the dma_buf API
> of the IIO subsystem and trigger SG chaining.

Can you include these patches to reference?

Frank
>
> Best regards,
> --
> Benoît Monin, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>
>

