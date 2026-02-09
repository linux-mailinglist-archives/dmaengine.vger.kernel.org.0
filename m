Return-Path: <dmaengine+bounces-8854-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB6PIwoQimlrGAAAu9opvQ
	(envelope-from <dmaengine+bounces-8854-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:49:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE2C112A86
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86440305DB33
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 16:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E12B37F740;
	Mon,  9 Feb 2026 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nTN8T+Dm"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24001E9B3A;
	Mon,  9 Feb 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655517; cv=fail; b=CT4AiZPd2Hpv7FlUcuvMpetj0o75+xKFM7X/lZpfAAqPqPqnQucNQiJiIRqOzjmz6P5AxgKnywOTdJvMoHRniuur3YBqYEu1nDm5ZkDh+r2iz98ZPi8uGhyM4yxqvZYEa7aCUg+KXoOnQaMLq8JuzEaSs1CBMlLI8eSo2FBka/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655517; c=relaxed/simple;
	bh=xpC4ythxNLPsLKA/4GJzmNDdhvA95CgSuez59g6gOLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OvJp9kuzFv4tFb65jdG6Dzt/W9h6ZZ4SJrj3cReTVIv5fX2dtqUh8uNQUlilo3wG26Hk671b+xJJNAGCr5tka/eKda/yQr1X1ifohy9RwCaMmTLKTxnj5HEFkzCqcrRyvJXn3Kufo1SenkvdTYr62FpZGZ6B43K6j0joK6Qacz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nTN8T+Dm; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuWl11ITHR8C7SYwaOPz2wAVrFyz8AnkF8CThz/hdtzmUIjPngDx+TZ4p3TOysUKoeQUYBhE2RDMiHj/RkYHHxcAVCSoIx0Ta1F3oq76WP/9ehnx+6cxbstIgDgWGzvLx2xm4wVvEDcvy+D7OrKSnw1JkGmu8rPIlnSj4JGwpfuF0HTp3mj8GX8BCvFQYFmBTAzBJa76SvQT93iZCJt8bRrwp0y8SteL3GajxV482J7a3sgJDw0SWfnbzn491bnb47wskJmCSfDsoZoQ5TTnBT47hQJdahfXLm61BiVwgdijzaCphw1iEFyudNy+ufir7YjUBaM6002f5u/2mU2pqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+iccYQuQNAAeBvsuqEIlVti03Aj/EtMzDYETePTFA0=;
 b=m9ztPl6BZbJUjUzhvPLIpuCrB9JFv3s9AAOrtAihocfRxABiE3LPW3fZ3TGM75p/EOex/pcmp4ToSE63fWJPeOoJi9Y+FddOWvkvtPKltQp2fAjLyvpEgaXsO8d9ZhozPXRcZ8Ai1ICQJbP6unEF0OC+W+71OSn6rTdOUKe3VUn0bkU6RiusG2AM6T0KgN8Zv+yuH3vkxWrFhlZ4QSWk0FJaDcMXfVqKf931pYy+ols9lFX1w7zJJV8sW9Ik57SLYaA0o0FO39QI4uOQBW4kuJKbCfwGMGt83ivk+RgK7U5H4T5XirgqcBP2kfvTjcvVgczccD0gSkq6rZBhmmRrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+iccYQuQNAAeBvsuqEIlVti03Aj/EtMzDYETePTFA0=;
 b=nTN8T+DmQ+a3QTjRHZDElgR5LrXIB1Js1ArIE4DQbz4CV8urSItlANZmu5cnt9lpIJU9m7OqhlOZcSyYdjzslvOPzm1cii1GQI5A3hUgIbKocsDx7gP6fI1a3xzloPQ3R/9WF4Sbafkcz87OX8wDAO1eQD5ufUGdKfd5wvLY3HifDTMXQ0pqDxbu73NMt8F6vwOEZOR0dyZ+BEbSouzOehgBZTlKrqI5/GQDhS0XtbXYaiDMT/Wa1Lznh0K3mhZeQ5jYfH8RniQNBFIJBQv/pTESn1wUqxW5WYcfmVCiKYZ6iFw3DsEZNIi6aeArEYKjIu6WONguJpQfQhuEKcF8/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBAPR04MB7480.eurprd04.prod.outlook.com (2603:10a6:10:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 16:45:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 16:45:14 +0000
Date: Mon, 9 Feb 2026 11:45:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shi-Shenghui <ssh.mediatek@gmail.com>
Cc: vkoul@kernel.org, manivannan.sadhasivam@linaro.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	brody.shi@m2semi.com, kevin.song@m2semi.com,
	qixiang.zhong@m2semi.com, tom.hu@m2semi.com,
	richard.yang@m2semi.com
Subject: Re: [PATCH v7] dmaengine: dw-edma: fix MSI data programming for
 multi-IRQ case
Message-ID: <aYoPFMpJxg-idb1h@lizhi-Precision-Tower-5810>
References: <20260209093642.273-1-brody.shi@m2semi.com>
 <20260209103726.414-1-brody.shi@m2semi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209103726.414-1-brody.shi@m2semi.com>
X-ClientProxiedBy: PH8PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::17) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBAPR04MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a8cde9-afa2-4aba-e134-08de67fa9949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pZgzDy046YNFHdanlCeLX5d3RBec421q5KDQO7sp3Fxvh0xLrduR00+Fxm5P?=
 =?us-ascii?Q?wbhK02dL15qNsNsTlEVt+/0qK5s3xFk8b2E5dRW6lQkPTOshCqqD4KA46psZ?=
 =?us-ascii?Q?PwQLq4uY8PY5Se/GsCEowqYPLJv+r02upxQGEb3cz9DoBx6BFwlKFoRGc9HJ?=
 =?us-ascii?Q?dcyI/6dZ6YCn0YpgS7unK5f/QUK79qcQ0WsgR5YzPNBLljaSL68SXvHT8zUZ?=
 =?us-ascii?Q?sURUtvBWXGRCke+i69aFRbjdtuNL3NYmzI3SpdWi54B6QlQ5EjY8bBsZcoyo?=
 =?us-ascii?Q?G4kJ1bj2j9L7oSrAwyTpb0ZnnZxGItqcdGQDnawOD4MHVCuYXL6Mw7EIDI1x?=
 =?us-ascii?Q?cYb3hwRbculoAXvgv2zDCv/lhIHYV7NBvE8VGgcXXMtgRjEECI7ghz480hPR?=
 =?us-ascii?Q?OPEN8BJa6T+5izk2l09JbJ6aXAKvM7YRLcUwA99popX7qF0VM8roCB9tVB+C?=
 =?us-ascii?Q?T3A0RcCG1vWm2coL8Js3cPEOMIr6L/5z2rE5iQgn9nZZfpSc56YuHxtQK5+n?=
 =?us-ascii?Q?a5uCdyopv9/JQUG3HA3rvpSYWibsCvnp2IihfC1YwyQEeuHjJE2w/Pd/s2Xx?=
 =?us-ascii?Q?qRP3/q/3+XakqY1dszIBNO5YR5F8yLrnZWHIEg/uO2QHJw+TAOjur4rDIYZo?=
 =?us-ascii?Q?agfivSSLLZOhMLxHM9x78ERh4dMnyB6nrochS7mFItJ9FesSgBd26vLIsyZl?=
 =?us-ascii?Q?zqWtk20MnnAwJyBPiszON0XobxZ4yY0sHimeGbB1Pz2D9TIHqpXE+C2aSjFy?=
 =?us-ascii?Q?Qf6hZc3gY1Qs5LybfvtyZUQe4mhatQ9PFl5Ovp9E3arav8a6oKU5QocQAIa9?=
 =?us-ascii?Q?svz6HrHGyThtjJTxbqaK6AB+EPBZ2sjKNoaMEx2Eni1U6LeIgc1sn9N21P+O?=
 =?us-ascii?Q?xPbtt5P+tJkkEiSDCk0myvkmZwC7gLfpJf0ypIKIknt/XeFt4wPGtW88zb/l?=
 =?us-ascii?Q?bRm3S7zV/VRkP3olb1irGpTeNk7z4CBXJvP/gQQIvc3XJapDLENZWyzTujnZ?=
 =?us-ascii?Q?G4ccYH2d2am8h8rHfZRpTFLQ9x00XdYOh64qj+OkTmFA5VkXQk3Wl6WGdg2X?=
 =?us-ascii?Q?ftLsIqnVtfwNvtdUFKFI8keJyuZHz/YQmtrqBNEXKhTNIZY1pElZ3yGtd5ZN?=
 =?us-ascii?Q?BvCurnHP3HnQEPXigLaoWlMddRWRp798THQ3Atu18mZVPyJNuuAx4FPA40Gd?=
 =?us-ascii?Q?Ial/D8dSvPVeh5YQdPyozdbjIEMEHdLQlAhadSfLkGsiGrrF6uyYsvMlfiL6?=
 =?us-ascii?Q?QxGmuMY2pSR+YkwPI8E6oJaEvtjUeujqgCIn8Yvi/xCw2LANwrBt5+0cZytU?=
 =?us-ascii?Q?il5kyfrAGJqZVSgpqHlVjpfZQQOgGblckh4AjDjHx4mSiWHziFk6xgh9V5LM?=
 =?us-ascii?Q?dh8pmMRfuF2nSiA+SACNymMMBAp3sjbcG6lmompkLKiGfZDXSfxVfkxYopdh?=
 =?us-ascii?Q?WtzR0Fy3s/cM/0iCJcji6AFThnPchGFQY6TgIpYb/wCdV1W/yc96Cnz8U1nE?=
 =?us-ascii?Q?2UxTpVyFiAdtJiAyEopewQ+66QV6PZaS+idlIMdyIQECDWyJ0plvn0CSYcTj?=
 =?us-ascii?Q?0W43zVAdsaJbYmd9pfLjbk/sqrEp400vqkJdF0bInNfekEjxmSJu12PO74rQ?=
 =?us-ascii?Q?cyZDGVtkwFnSoWDEbapF/eY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mui0eR/hLZ3JypasPZRl6y5PP39wknh8cvAk8Gen4/90sZvluTpbvFYayzDB?=
 =?us-ascii?Q?gngN7bhQCKGS7lj/wWEp8dgS1H32hUpSbonjt6VEhDsdMAbGSfbWywW+zAjr?=
 =?us-ascii?Q?U/G4ufY6Blubsum39QoHSVdn5wSs3T1V5bLtHIMFTI0wY4AGj4FF0LH/pdrp?=
 =?us-ascii?Q?NcrbvE8nF8xOVRwMUJrTce3Mr5s3LCkKtma4KG+Xmi9wX1meDHJqqhDusVPC?=
 =?us-ascii?Q?RsI2LZ9b4uMTGzr/Y/mGbGv8w4AV5lUWXCAAPR80oryx6zNWx1ceOfeeJzO0?=
 =?us-ascii?Q?mGOborWaTOcjSivXpWtySMdJNLRDZ/C9Fr3J3W+J/QEYJQa5QQqxiHU/1TTj?=
 =?us-ascii?Q?3PUMFK44WGu+rFcCX04/DaSZEloDz068gAp3qal8NoZfqPZIfZcE8dRxJmCB?=
 =?us-ascii?Q?E71HjpFwGzqEO6stJflYEDbcojiR+zzkOH3T2KlAoHFXp9d8Aikj1TQ3qf3+?=
 =?us-ascii?Q?FdD4XA3tEQkG+jgxsnyKQXjfXqrxWOfvEqRUxWAr4NxuJodcsRqXrz+BFZEt?=
 =?us-ascii?Q?SQuHUWpJP8zf/PmSVObH7jiEhibO/7HT6CA5DkpO8PvHttohtN+HrxIqGq1M?=
 =?us-ascii?Q?7yByK2x9687O2+vhlOapncwB1fUN5VhXwIvOnXiYz0hznRNvfle58lfLvOpc?=
 =?us-ascii?Q?xkVh9Y+btRlisSvmjl35kZmeSHyEEbnIkwoxxaGGmrKMSkL9V9baUXGWwk7T?=
 =?us-ascii?Q?qn1eNUH/QIu+xIMRY5xAGfh35YMbPYW+9xdm2bNNHYiqHr2337zrRNYChMsQ?=
 =?us-ascii?Q?O5uLI8rETVx6klQllYcV70ALG0dY+yPuaZ+hZaezhSAiXznQVZl3Kgn1hkTV?=
 =?us-ascii?Q?3NJ3VB5pVaVAuhtCL9/6erwNbgkQWyWUcNpDqz3wG++XqGFFMoyTu8/a/ybO?=
 =?us-ascii?Q?pnSBCEaVn8iJB8WsuYMaPQLxwh+tSa1xqhUUUfhnlEJeiwJ0EV+qHNa7aOyH?=
 =?us-ascii?Q?bab4WEbi1kprLSXPJ0cLinkl5llqUNkIL8S5QJo835GH4f4We6F9+lQJQwD+?=
 =?us-ascii?Q?thLnSMftBPFnC6NKrXEPzOCdQHEDlSZPl1bwFQX1IPWdiwtrEe9YOfj7OEjW?=
 =?us-ascii?Q?ZmujltgvYaK4kpCW5q+F5QBLnO0Iv0SQH3/+gBHjTGOvqslBZ4opFwOeRc7J?=
 =?us-ascii?Q?1DwmiaSKJSGCi8g8JW98kAX/uVDeKSZnplv42WDdCIWxnEU7mhVb3/sgFCC2?=
 =?us-ascii?Q?AFqxareusE+H1zkZWzrGJPkbkeg25MmJTWZbS75bWFf5vXkjmJa6n13E7GOu?=
 =?us-ascii?Q?u/zmI385byaHZe+g9CwjAGoT/1Xz8dPlzEYlCDBudb1NCxr5tKDoAcUO63Cp?=
 =?us-ascii?Q?OkPR4dbabyly1vVC/M30LEQSr2KQ7RbyPy/Uut54ZwVHm71q8uGAh2KzPlyX?=
 =?us-ascii?Q?67KEKHdQwBWKDg4PWxrb08p+Zo1X4mLOeFqWQyJ/5Ap5p3SU2yi3G7lpWEZl?=
 =?us-ascii?Q?nIh3eK4pTPnYn3ELM0VyrJWpdd5193adwHO5qUS5BaCX4iHKaleoXWs61Ygg?=
 =?us-ascii?Q?9jQKJw7iuVSRdGoZ+7H48NaTLVPszMp4TKH3SPhodKQrgZFFQAvdLOGUxM9f?=
 =?us-ascii?Q?ZDeemG5sMEnfzQqOX2rQo/rNhcFsEKV7D6zFtRVOvTY/wwN7acSLeUy1G9kk?=
 =?us-ascii?Q?WoEsETzZqbRFPyQ2Miq/hAUbPEqkFonbPN/090gxBKzh+qneYrAhzSsXXr7E?=
 =?us-ascii?Q?Bu05TKh6sgMCuuItss1zETqpkf8ahUFOfwmcfOvT0xNkyRprMxCDSLA78aKf?=
 =?us-ascii?Q?Fvcopm3J8Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a8cde9-afa2-4aba-e134-08de67fa9949
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:45:14.6592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqaCpAfzYvpfikS4Ats9xyMnIGOggFQDvvTRrEuZK9UDCmSw+blPChtuXFoFA6c7AdK2bIuZ28Q4VVR4zuiA/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7480
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8854-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,m2semi.com:email]
X-Rspamd-Queue-Id: 0CE2C112A86
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 06:37:25PM +0800, Shi-Shenghui wrote:
> From: Shenghui Shi <brody.shi@m2semi.com>
>
> When using MSI (not MSI-X) with multiple IRQs, the MSI data value
> must be unique per vector to ensure correct interrupt delivery.
> Currently, the driver fails to increment the MSI data per vector,
> causing interrupts to be misrouted.
>
> Fix this by caching the base MSI data and adjusting each vector's
> data accordingly during IRQ setup.
>
> Fixes: e63d79d1ff04 ("dmaengine: dw-edma: Add Synopsys DesignWare eDMA IP core driver")
>
> Signed-off-by: Shenghui Shi <brody.shi@m2semi.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 8e5f7defa6b6..22d906426d75 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -844,6 +844,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  {
>  	struct dw_edma_chip *chip = dw->chip;
>  	struct device *dev = dw->chip->dev;
> +	struct msi_desc *msi_desc;
>  	u32 wr_mask = 1;
>  	u32 rd_mask = 1;
>  	int i, err = 0;
> @@ -895,9 +896,12 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  					  &dw->irq[i]);
>  			if (err)
>  				goto err_irq_free;
> -
> -			if (irq_get_msi_desc(irq))
> +			msi_desc = irq_get_msi_desc(irq);
> +			if (msi_desc) {
>  				get_cached_msi_msg(irq, &dw->irq[i].msi);
> +				if (!msi_desc->pci.msi_attrib.is_msix)
> +					dw->irq[i].msi.data = dw->irq[0].msi.data + i;
> +			}
>  		}
>
>  		dw->nr_irqs = i;
> --
> 2.49.0.windows.1
>

