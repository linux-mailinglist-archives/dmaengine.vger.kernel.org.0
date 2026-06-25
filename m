Return-Path: <dmaengine+bounces-11787-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mVnZHftHPWoG0wgAu9opvQ
	(envelope-from <dmaengine+bounces-11787-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:23:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6356C7074
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:23:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=htA12gPK;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11787-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11787-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A4B23039471
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A823E7BCF;
	Thu, 25 Jun 2026 15:23:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E551342C98;
	Thu, 25 Jun 2026 15:23:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401016; cv=fail; b=sM0z6UgMFEolxxpEa7wgvMwU7ASTiwR10ifROEWjFwkdeG5f7ENYdAQMRqwKLTUhRZTjsx0gkGJgbsqeHYuGScsMMaSMLfopsRX7mG14Hy7BVg2vN1WZAWe4DZJtEQN5UcyJa2MyCAxGk2Ds+vcz6SMn9kZTkCVqtxsSyIbEJRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401016; c=relaxed/simple;
	bh=Ikt+r52gm8IvuoHjzanSO5uVaTseIwvdcK/DRlUqPAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i3V7AbL2jXx2Q97EwaTs37UjSJPesJmBcV5DurRnoKEU/FYZ8S73pIxtzn6e0AIua8YgfrMoOGn/sU664JaWy2Jzpt+S5BWcSW+Sv/mPeFQhXsSja33x2gBlVp6BcTntPmCzLKaUwVca+Xo1CAspOnPSwujiVbw9lwip0DNPakw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=htA12gPK; arc=fail smtp.client-ip=52.101.66.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjTuIAkhat1Q5Y6js/PMe8aXF3yO1eFPhLL1SP2MUwiiNSgdmmjjesKPKJid8z1MH9dBqd56bQMfT3/BBS+BrHo3refSyk41XiQafwrxvVdabwBJxGTpolhnriq8CRGAC7PVV+gPH6HBacYm2c+03o+Xp/wvWQn8vpf0rbzjcWr7ZhDsiDYBfSPkFvjsWNZi6mK1UBxoqAMO35TmP5Vt50BK+hi/3C+5JjeWh1E91bJUdc8ey9Jbz0PdFKn0w5jMa7OpeE2j/pXnXxh3TAPXaw41CiAYSvoBQZP4muJefZhCQCwxBbNsaJKFA1TIkQF6x/+7GY47SnKXZTBlvTS2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5of1qOCmiipm50n1zIzD49KJ1j9ChtQMVWBask6fDU=;
 b=fTrMoIicT5HZhjkIO5PFa1NRkb+wBEDoCgW6vxJtMOfnON1QuRi3oTR5VLKADVqBI/tLWrFuYFIF+gpu/oOG1qPZmrlecqHqaj+M1+1Nlf7unfBb1R5VOu2EQxDvE5EIBGtR7Vsy+AJxtlrXAnvhh7xAb+y3N3r1LYILqBRSFlcXMkgFjvOzU7dQywHG4HKxOtxItVkhB7mMpqtDzqoebse6x0O++3yO0DMFWiGyFOYSX3+8+x2QaueVl+OilfcNZImM3uVoMNe5q2e37emG2HdHwBKNIJFXAPxt1YWL11cVnfue20xdpwOiTr+wvbORcmNHnwe6ApsvVMKiyASr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5of1qOCmiipm50n1zIzD49KJ1j9ChtQMVWBask6fDU=;
 b=htA12gPKKtFlP77r1X0MvLSIVo1FShzaSM/NEkQQa1y1ax1sXYfrGHCJuldD51VOKfV76LphnjFkAWlox7iIbaK0tLHIc7CFVeUkGeRZ2V6kd+GpxfXJAYcD8RvNeJoru+wifcUlEmT1pPmuRGS+5cDoa9sbRiOmG2rXvtGc54T8etFTbYx+S0qGXx08AK5g4CudjIfwabGlf+ms3y4Q229XqVyf8RZ4J6xpdfClEuNUY9ngZy3Leg5ebiGdLQMgCDhxibFu0diLvc23cPoMK2u09Uk4yNjdrUDAPR5Zr0N1bBuT4IxwLSSXgAwyQxQWfJBg2qLYBB4y2UhT2U3CBw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7753.eurprd04.prod.outlook.com (2603:10a6:10:1e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 15:23:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 15:23:32 +0000
Date: Thu, 25 Jun 2026 11:23:24 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Angelo Dureghello <angelo@sysam.it>, Frank Li <Frank.Li@kernel.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dmaengine: mcf-edma: Fix error handler for all 64
 DMA channels
Message-ID: <aj1H7IovjO64TtIk@lizhi-Precision-Tower-5810>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
 <20260625-b4-edma-dmaengine-v3-4-44be00ace37d@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-b4-edma-dmaengine-v3-4-44be00ace37d@yoseli.org>
X-ClientProxiedBy: PH8P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: eceae977-b27b-4c80-da64-08ded2cdb794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|23010399003|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PieHZDuosPH07zVDj3WybscYFwheQE24L+bqkKzHuGBtB8+KD3MrUKVoENK7uJ0jxeklnNwVLjogq4z5/CLW1O0/bx+D34zxgQtcHxO5x0FInYK2oe0gV4iemisArPN0w5phj1onV5AIccZRNpXOqMhCIC6o23zr39jVwjPvWGYX4PW8ATutNdbF1/AQ3Bg1GNJacl8xssKqm+EpIkB5dMpU55/v3G3AG9bYd5fFFkxuRPUjVP9TMkk9uNUw4TFCgZEu1kN6dk/tTuej4bH+vwzeKN9KFxDbQZU5poZN1O5aRo1E9DpkqHJJIJA+56io6N/3CXwuJJWkKGcmAovoqHA7f2cB3Lqc783XS0XnyIV3qDS6y2Zpcnn0VeaIrm0ZuiRzBhm+J2f/gvO0jrmiSPJT11Rh27TFgXChjb4IXN1MaxetnsGPLtwQgi9TtuxITAuiE3QsHtxBWCf+u75Hwb12stvKN0G2iH9qMzk/63IGgMnl7deImURQpIqpSvjbuqqqrDnKJHJKczOt0cRJ/qM34uJPnfVl7JrdtzGT1cXBkKpm0pcxQlmTlS4nMUBTGcNDFrriTxSAqHCBxagEyqe0/ayb0SDwP3P1A7ZcVobf9ht/IRA4cQM5dl4jfP2/0VlNBiM7AVKJq3l/hM5V7BzDR5CfQw+JzjQpTaLlKOI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(23010399003)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AbAjG1SOH80e9fbx5kUfD/TU7e7YDK+ibhMmCCrPOL/S9u4xQgz7saoluRCB?=
 =?us-ascii?Q?zHKF4ax/EbDX/jnwAnh9s8G1xkuExdEAjvFUS9DjYYIw5YA5fMGgPMfn6EYJ?=
 =?us-ascii?Q?7Pe1pSP9Wsn/VDCPOi9/NoqyZzReGZTjhsV6qPrHKEqRS+DG4YuaPI9ECFq+?=
 =?us-ascii?Q?8QXaGheN0xzJBzAX+8qsMddLUMbzsR4DwTodh1aydDT8DWx5D8lnbfpj8ZRs?=
 =?us-ascii?Q?/JS8QaqEmRAqbWdY5GvLiap3KgUUZwcx2roYGMNqk7yMGowYVSmcBwS6/y0x?=
 =?us-ascii?Q?7oMIpmV/2qAMuxvOTWU2p8YPs5dCZ2cLLcWnTg+LrkxbgVtkmcS/zvq7fxSB?=
 =?us-ascii?Q?atXYFsGhdTekMD7++Sn0Mc/l7VOJx5pq/cuGBbLYZ7/fUEN7R9dro6CEZpa5?=
 =?us-ascii?Q?t0fPXUeeCYYt7fKu1XznqGU6jUVjfE2a+wm3afL2tEumAkrSPr8EthKISNJv?=
 =?us-ascii?Q?PuoNb0rcQUnoBUwxPnozaKFOI3vanyw0WMGO5wHvHNHanKeTfZiafe5L0tfq?=
 =?us-ascii?Q?arbSpv67PjSkPn35CZAxHPBvCrLRzcAn7ezxFFhUee4RQDuWvi793f7nnUV2?=
 =?us-ascii?Q?9vgreSkdA/OO+rBe/m/mSgm3ukM6kzS/FunbtxTMYoJo9682tJ2K9W2iQRRb?=
 =?us-ascii?Q?iZfos3H48yXyfusloRRvphzsaNkpAw5pHB1IihDk3RBGPJB65b5bUlYhykNW?=
 =?us-ascii?Q?N6UjkvjwPEV4iW/zfcdcFkk4Bz76QbODY/ETQavPClRM3CDxe+hvZ5EHMoyB?=
 =?us-ascii?Q?nto0xong/Bz5c1Q3CH7dKGcXQk4gDG8s2uhGWkvad14xBommRX84TEPWVjbV?=
 =?us-ascii?Q?pylEXHkR4W4FLz4dkVRiLFaOzxVNiMttG9Zj89smL6Xixp0aonakVn4f1XWb?=
 =?us-ascii?Q?kFIjSXSo7/cbMtW/Jdt/iUofK8aSgbKlbhHRhYFI43O+5+7E3mkJ2b4H+81A?=
 =?us-ascii?Q?ZSEynMeFnaIBCRp5lGrFe3FMVpvIMlcGu4DMUBxKGGa/Sw5k5Gx4aUWsDEvO?=
 =?us-ascii?Q?7EGybs/5v3R4vK94d7UUUNvnosime3EOv8b2xARLn0Gx4lEoBXuZoyeQWpDo?=
 =?us-ascii?Q?TkRDPvl2nrvlz5mbriog4umBnBEPKSCckuigwM4WlYDq7MIkjtSRCpkojWsz?=
 =?us-ascii?Q?JXrvSCobbDMV13ffLKmn4UBceFpyteI9QNzIJttNlis3xhkJ4pcuSSPxxFvu?=
 =?us-ascii?Q?MJd8WG2XBEONWcHMEiHqzb2hQdNSPpm/3jmnUv5nNchvjLvVlAAtEcWZPiVp?=
 =?us-ascii?Q?00QQAmQtVmpWcVVdlrRSkJB/hHRdkU9AeFaKEqLRdtRlIWq/BFx/xcqmvZv+?=
 =?us-ascii?Q?QhPUbaN9SMc8IbzcGs9Kn/SZ3YKWTz7/L01A+1TjHl4opb0mq0TIajbSqg1v?=
 =?us-ascii?Q?mMAFWEqeF1IGCWoFjPxc7cjC/wVz6ZUpThgMB3Fr64GFW6sWGo0GnptzffwM?=
 =?us-ascii?Q?Fm1bx7bRpVRyuIXIcsbmyNDTs6gTNqYNa0Fv7moAyAaEsxQLZcVDmxeEFYfH?=
 =?us-ascii?Q?w2iV7x3bXfVrZyxIrNAyFYO4AEvWXDED4mUw7agfbONXyqEz8QyONAVY+UEo?=
 =?us-ascii?Q?n9f9r7F/UunS+pLRRT0sm9Bn9VtHMb94r7VmCReOZupmoMpBKNMFDp0qUo/O?=
 =?us-ascii?Q?oMWdcMApyL22LVPIJCHMo7SHshqtndVZ3guWgHhZWCyzMgnA9LO/maq1VZLz?=
 =?us-ascii?Q?CZ4Xo/xqnkIL29ZfHVFtCTJRUWmHYUxoYShTP1+ycLnW67d8XMIc+xT+FyWt?=
 =?us-ascii?Q?QzQ5oAucnNCVZ2FeFBaW1PqEfv6qsO1wKob636kpN/n/8kcl+W19?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eceae977-b27b-4c80-da64-08ded2cdb794
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:23:32.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Obs7pumUOnX2oQ9yqC6omNtHpdB9np5cjF7kGwLmH9vJ59ibLuCa3k0zoLKJKJWFOJVVgxzCBfhob8VDN7tRgiJiiPkzAA1yLMpuwXRH6AND+YeJo6ekJcqhMoHNXno5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7753
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11787-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jeanmichel.hautbois@yoseli.org,m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:angelo@sysam.it,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lizhi-Precision-Tower-5810:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,nxp.com:email,yoseli.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E6356C7074

On Thu, Jun 25, 2026 at 10:59:40AM +0200, Jean-Michel Hautbois wrote:
> Fix the DMA error interrupt handler to properly handle errors on all
> 64 channels. The previous implementation had several issues:
>
> 1. Returned IRQ_NONE if low channels had no errors, even if high
>    channels did
> 2. Used direct status assignment instead of fsl_edma_err_chan_handler()
>    for high channels
>
> Split the error handling into two separate loops for the low (0-31)
> and high (32-63) channel groups, using for_each_set_bit() for cleaner
> iteration. Both groups now consistently use fsl_edma_err_chan_handler()
> for proper error status reporting.
>
> Fixes: e7a3ff92eaf1 ("dmaengine: fsl-edma: add ColdFire mcf5441x edma support")
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/mcf-edma-main.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 953b20f99f25..3dab5d475d1b 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -42,30 +42,22 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
>  {
>  	struct fsl_edma_engine *mcf_edma = dev_id;
>  	struct edma_regs *regs = &mcf_edma->regs;
> -	unsigned int err, ch;
> +	unsigned long ch;
> +	DECLARE_BITMAP(err_mask, 64);
> +	u64 errmap;
>
> -	err = ioread32(regs->errl);
> -	if (!err)
> +	errmap = ioread32(regs->errh);
> +	errmap <<= 32;
> +	errmap |= ioread32(regs->errl);
> +	if (!errmap)
>  		return IRQ_NONE;
>
> -	for (ch = 0; ch < (EDMA_CHANNELS / 2); ch++) {
> -		if (err & BIT(ch)) {
> -			fsl_edma_disable_request(&mcf_edma->chans[ch]);
> -			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
> -			fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
> -		}
> -	}
> -
> -	err = ioread32(regs->errh);
> -	if (!err)
> -		return IRQ_NONE;
> +	bitmap_from_u64(err_mask, errmap);
>
> -	for (ch = (EDMA_CHANNELS / 2); ch < EDMA_CHANNELS; ch++) {
> -		if (err & (BIT(ch - (EDMA_CHANNELS / 2)))) {
> -			fsl_edma_disable_request(&mcf_edma->chans[ch]);
> -			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
> -			mcf_edma->chans[ch].status = DMA_ERROR;
> -		}
> +	for_each_set_bit(ch, err_mask, mcf_edma->n_chans) {
> +		fsl_edma_disable_request(&mcf_edma->chans[ch]);
> +		iowrite8(EDMA_MASK_CH(ch), regs->cerr);
> +		fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
>  	}
>
>  	return IRQ_HANDLED;
>
> --
> 2.39.5
>

