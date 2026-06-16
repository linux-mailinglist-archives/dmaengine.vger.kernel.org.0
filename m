Return-Path: <dmaengine+bounces-11566-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qo36OYG2MWqYpQUAu9opvQ
	(envelope-from <dmaengine+bounces-11566-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 22:48:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD5F69548C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 22:48:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=pm6Xjgjx;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11566-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11566-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02207304705A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6062537DE8D;
	Tue, 16 Jun 2026 20:47:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76D935F197;
	Tue, 16 Jun 2026 20:47:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642875; cv=fail; b=KfJY5Fc5N6FQ9Rudds1vX8OdYrjLn+dCpRk9xbbYLpA2oZ/jmVZ22GNMjsuRqkH4wGhTrZD7WE3STuhMoQcvy3jheKGlravtLEIWIDntI8dXZfpkeRUO8p7CEtT9E+8+6XO842JGm6iT35VY+LXChnrQSjCfm4QQx1oadac1QHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642875; c=relaxed/simple;
	bh=0iABAIadRbQ5l0fDyuUJiKj620CuuCT0ySEUXmYQUa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o1uSc9Ig1yNJtmHphceNZ2rAEAsdnHDdeeSl4dVbBWhtYNJvebtCEh+SPW1GbJSS4BpXtzoPoK5ugdpzMXSHMjD0mMgjxkbDmPTdUc2RYpsHPAs16eGlrSfMDYCaPBVOibtH5IOlheEsIiTaW5T+U0cnIVcOc/IF3GFuhzKJhaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pm6Xjgjx; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoYryzMHt2AJPKJGrQLyzf3rATpaSuZRywpIxgxVjg5b5hwXTb4vtOyt2W0aPLyE42qZ++O1RbhSgRJvYyUnQ3oaHkXSGjBUlSTKU1uU7IUGws6yBHG6JhDSyL6wqcqvN8whMFC/pyHVDy6dZa0r0KpawAhd7mfGHGsV0Ylsb78T8B1Sno0FgJ+gTQ3NdknRxPxsF6MKdxwMHoKmiiWqxsclZ+opNR4OF9jiGQ2ZCZbH0FJaFwxo+5btHz3vG5I3OnuzEyNxWXrOqJKaj2fmpqQELTixPXRm3gbmsVe9uMRtSZppB80swULq1oxdfmCJsDjRps/WNXTsfJtHil9wDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aecnW+H0FeU6Q6eTzXEjo011zFDY2mL+wqX/rWLb9WA=;
 b=xt1H86XuP4GuuqfhSDUceoiBZqr0TIrCBJdRj8xks9F9jL1wA72g2sd+jEofxSgPr8tNw9H7OPJ2nOgUPblUClnUQlPcCKypgDtZOuJt63vOElzMn8Yh47z6b/3YbO8JfO27oAArQtoszz6xVS4WBOR4pvPRfGrCHU1ZSLkZXJlbJjBvASZJNRuSxSU3sBDyVys3cIDAK0jJrGK0vcpXAl7NaipzFD7S0WHj6fTuPxvYi+/QchV2sGT6EgCzis5wp76opSwuIFpK2SFeLHPDEk5f7GVQmgrYiGuFJqu8ybsbNdJ2egeCbdn3Lg29tDWlLsygX5gNuQVE+0QiVIhBUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aecnW+H0FeU6Q6eTzXEjo011zFDY2mL+wqX/rWLb9WA=;
 b=pm6XjgjxXU8bsH04b8HDn4H7alPzjIbtRer5IdNNFz70XjMCsber/ibgMbh+GroQahi15qoh4oyNeaqt/eX15q6Qt+7/a2CcmRm/3/NMyh4qEklYMYmWgGRW1gqOl7a5npLssnk6mFS8GMP4HDtNmODxPhTGreWK1Bhj5EMokJi3ZQR/F6gX+eRmB9VGn/YPDp2tV6bh/tx9EbwsVALsgBBJKGf4mvBk34ReQ+K9YC6noV8plmPVyIDxv+cxZm0LouVtxExSQjBwoGeIBMHCdgWqzYDsWgWp8UO/qeyEj90XFGXm3BYOLb/mgk7ltDG9NBicKRy8SkhNbJWHgG92AQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB11710.eurprd04.prod.outlook.com (2603:10a6:150:2d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 20:47:47 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 20:47:46 +0000
Date: Tue, 16 Jun 2026 15:47:37 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, wens@kernel.org,
	jernej.skrabec@gmail.com, samuel@sholland.org, mripard@kernel.org,
	arnd@arndb.de, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhongling0719@126.com
Subject: Re: [PATCH v2] dmaengine: sun6i-dma: Fix memory leak in
 sun6i_dma_terminate_all
Message-ID: <ajG2aR70B4z6j1fd@SMW015318>
References: <20260616060449.42225-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616060449.42225-1-zenghongling@kylinos.cn>
X-ClientProxiedBy: SA9PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:806:23::30) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB11710:EE_
X-MS-Office365-Filtering-Correlation-Id: aecf906f-6605-4f75-bacf-08decbe88577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	978hYwEd6conq4kbr+JWKOJGjoFSZ+ynZ/RVIInXcvqM1WoKsvfVGqp/devSYG/70v59dCBd/Xu/TkQCPdB6dd67ZZ0UL8VYeOQhY1sS2Rn80M7wQKSXBPTvl1kcM3pQKpAQ49e4+HOgY8qOAZjIylAAkJljb+L3r2uHUNTbd/y4ObDmpUdt13DH4/JWz2iabgqVBDeHsWhZNPkEbtmTGMOtlknN38mLtJpwuOXXsrqQXOT5IJhX8kzdIU8oJWx1+CPDmZfBUq1JvnJjS6lIQWZ+TtW7FgMz8EY8tqfLrL5HEaVjIzeW/QVQjG/3ylxfcxl/VGNGccXcy7nTpWT99C2iJbeE8fWFQXyiVcobymdvMTKPVsVR6LYaD3vm4Mfv9igV6ZKevNljpIlGcJ4040hS/O3JgA1dlitgPj/SMa7mxCe8yngieMOV4B7kBsszEzTnenibb9NeEtSWXqGHs/SY/nzUBd+ZvkmrMGtN13PlYFLpei8Cw4Do7UY1lA0BeAH1xY0jow4XH8FDz8m4ReS66Z2P95+lp0yat1fPGK3u1fZ4WOb8uFjBukoxa0uburS25DzUVxoLRVvQrUsHjDoK4FJqIIo3w3RMxhOOOXG+Tc7H69q1D1GdhvjRhlap+fiO0NAbSkgIhEnzXKwwCNgnLASEf1aP8lTjAW09vxtypJkZFnpOJhJdmPKab15RCE6+x5cJHL6p+JBUjFg1hg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2VAFz3YBnaFffuB/6KyyOme4fAtFDiOYSN1Tp4WjfOCXrtO8Ae/xMIsAjpA0?=
 =?us-ascii?Q?nKtEKh45Q2SiTP7dtnSuSUpegv0Lr4Rn9SJk+XSyydcJW6Zj1VwPa7M7QMpN?=
 =?us-ascii?Q?R+WIG//tof4okNBPCpKXNLnozbuJExurbfDPNzuLQTN2TYM7pBU+/m6yEadN?=
 =?us-ascii?Q?hv21c2pMUrUj+mk2aa338VrVB3Qc84dgW7XK38ywpXpF7xfCzDQK70KsBEm2?=
 =?us-ascii?Q?L8Yw+PoutK+1MQAWXf+MFsqvsF7rbI8XHAuuKzL/p+QmU19pMOIAdcst9WJE?=
 =?us-ascii?Q?RweqpQSCA7+qGrGQMxXU7HqYil7HzUU7Nxz7PSfosombIlXv/DQ+u8KTRw4v?=
 =?us-ascii?Q?YSoIQurgV2THIUE5D7GX1Z/joRWrmG/2VT9i/6wMAWybHKSco6dntZcmh1aX?=
 =?us-ascii?Q?Z+4U0jE/4dJ9UGzrgva+1p1+Nu2JdxcWbLbPn4wr0Sz2mDiVjPItnkmdzTru?=
 =?us-ascii?Q?9GVMUN+A2J6FOF+9XG1E3OIW7acO9JUwbH4bhF15Z8YH5NI4/bcUd6VT6HZJ?=
 =?us-ascii?Q?PqsMBPWDSuj8sOU7qvuNPdCHWK6MCGTGUQX4e2q2pbI9N4HUcucv6mM7xGJR?=
 =?us-ascii?Q?fkh++HcMIJe9gY8Vjr+gQrnsp0uzJqZ8JYWow5GNDczff3+h7X+Wq/Oiw8p0?=
 =?us-ascii?Q?YLETGXURZS+OaSvvTYIjVS09uaQmgAl1G+Co1qnBgzebfH15qy8DEvxW1wqJ?=
 =?us-ascii?Q?lyewwPczydzp1Ocya27cMnDMJazJ9gguttFFRnDHDDvK4cmqGQut0EZUw7mY?=
 =?us-ascii?Q?Q152mzB8zQJsxFU+aRTD4PHXblbT4IlaudeVfzCKY5I4OxQc3Mhx7s9Q+0/w?=
 =?us-ascii?Q?HpxIkK/YGE62L5ZsEib04rWMGXEDQ7wawRHEt5tI8YsK/zPR+jxVtMDE5VIr?=
 =?us-ascii?Q?F1U1pyoRhOtuHPO6dF8gaTrDFrjMLp+Wr4zHSE/TpgFOLTVNhwBEA8L7SD4G?=
 =?us-ascii?Q?fbOD39NCgJcgmWqIJyEh0nXQqta9TZEPsnMZKmMi/z+vQV2QzUWtGPR72zFJ?=
 =?us-ascii?Q?5qWC0KxUTo+4L2ktWyqndfoh0HzLVXIM8s1Y9Oo3noPG+FnkS3hP35+HiCHK?=
 =?us-ascii?Q?JfriHcOon0wzEQsumWhpdHaLQMNJnYhoTpsnxvGw2FbsTrHf/QnLaFRYkSpP?=
 =?us-ascii?Q?jLiqqvYF49dMutEyZrdIwWaK7P7mB5ale2I1NZ7qjBN6UjRP15Ci4FhcvRQh?=
 =?us-ascii?Q?pcVa/vTs6nNhjoEMAhESP+pXqA21PXa6A/UWx7oDVOrGoBABNTCcxGbWaatu?=
 =?us-ascii?Q?Rsy3u4N12M9QXR0HDxvV6q/7okL09dL/c1aJHHN1n5FHIUFSm6jXW+4198QH?=
 =?us-ascii?Q?BRt7wkSUOqAhdX1pxNS6GPdWoShwKi2u5swijIlPXSkXmyyD0zZbqa0Z+N3g?=
 =?us-ascii?Q?GqferCMuMGEes9fvGl5fol8pzyvJy/JiFUhCb7CM2+OAzsKhFX47F+PJwWu1?=
 =?us-ascii?Q?XjtYiqc7Z13Zyjxn1gDKdnFBo434qdLnpg2Xx9Ynj2OG1koMhuWM0McFPKbR?=
 =?us-ascii?Q?EoQvv/hFpBskiFO4YvzQ6pwJajQzBG5ZxwNsTuQhd3vnXKg1Xa5tXl3fN+HT?=
 =?us-ascii?Q?7Xo+tk2K2msbcJSSUsDSFSyJ5AQ7sDbWJYfdjn+kk1PtuYIvi4AldrDqpQXJ?=
 =?us-ascii?Q?B5YU+PZennhW8nq+SzseGPr/UMyzZroZTtOhCNvNb8ComNnjU6pPYrEVoZdZ?=
 =?us-ascii?Q?V1mHMJcT3Q2TnZYX4gXMxJ4StqKl/ohV/NE9sItxtIQvqTUpEvjXKARXTFte?=
 =?us-ascii?Q?qfN7rY1AFYPUqZCwI0oxCYWIUS2qEKckuXYG3P4ImHpQVOlFa/mA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecf906f-6605-4f75-bacf-08decbe88577
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 20:47:46.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T18Tvc5Cmif1CcPoH7SdsrLT+gdI4PL1DohKxvSx/bsLE82K2kc6MzSVB3Dr1EdTBAKpj4IlKJB/wyDCDanmlcEmhFJNe1WzZ0JGDk3YXW/DDsyWmDDytdrbNpfCZVwM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11710
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11566-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,SMW015318:mid,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AD5F69548C

On Tue, Jun 16, 2026 at 02:04:49PM +0800, Hongling Zeng wrote:
> When terminating a non-cyclic DMA transfer, the active descriptor
> is not properly reclaimed. The descriptor is removed from the
> desc_issued list in sun6i_dma_start_desc(), but in
> sun6i_dma_terminate_all(), only cyclic transfer descriptors are
> added to the desc_completed list before cleanup.
>
> For non-cyclic transfers, pchan->desc is set to NULL without first
> adding the descriptor back to a list that vchan_get_all_descriptors()
> can collect. This causes the descriptor and its associated LLI chain
> to be permanently leaked.
>
> Fix by ensuring both cyclic and non-cyclic active descriptors are
> added to the desc_completed list before setting pchan->desc to NULL.
>
> Fixes: 555859308723 ("dmaengine: sun6i: Add driver for the Allwinner A31 DMA controller")
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>
> ---
>  Change in v2;
>  -Add pchan->desc != pchan->done check to prevent race condition
>   where completed descriptors could be double-added to desc_completed
>   list, causing list corruption
> ---
>  drivers/dma/sun6i-dma.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 7a79f346250a..12d038ef5f2e 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -946,16 +946,14 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
>
>  	spin_lock_irqsave(&vchan->vc.lock, flags);
>
> -	if (vchan->cyclic) {
> -		vchan->cyclic = false;
> -		if (pchan && pchan->desc) {
> -			struct virt_dma_desc *vd = &pchan->desc->vd;
> -			struct virt_dma_chan *vc = &vchan->vc;
> +	if (pchan && pchan->desc && pchan->desc != pchan->done) {
> +		struct virt_dma_desc *vd = &pchan->desc->vd;
> +		struct virt_dma_chan *vc = &vchan->vc;
>
> -			list_add_tail(&vd->node, &vc->desc_completed);
> -		}
> +		list_add_tail(&vd->node, &vc->desc_completed);

should It be in desc_terminated queue?

ref: https://lore.kernel.org/dmaengine/ajETw7uwVx_U9o5F@ryzen/T/#m541c24b45fb425c6a8a81d800db225b58411447e

Frank
>  	}
>
> +	vchan->cyclic = false;
>  	vchan_get_all_descriptors(&vchan->vc, &head);
>
>  	if (pchan) {
> --
> 2.25.1
>

