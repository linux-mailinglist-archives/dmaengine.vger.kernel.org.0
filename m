Return-Path: <dmaengine+bounces-1059-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D109F85C2DC
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 18:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8778A2839B1
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827776C87;
	Tue, 20 Feb 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eaVrVHO+"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFF43ADB;
	Tue, 20 Feb 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450748; cv=fail; b=PR4dBcUPFg5hsb7mS6FrDn4UZ0CVZJkr8UbBvSzKD5+y3vEfRKu3Zacl7H6re7GMhPF61apN7+v6I68254QDLFaV1nW6RpVQBHnfabO5CI3UJpDkt0qFv9wnXchDLGAUAe8p9vFOocsI80+3YKpQDPqwLgToQ3uZQHUZ3C2Mqow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450748; c=relaxed/simple;
	bh=9+10DOg2pGdxtG3SnbgMYarbk+q5TVVF1z2bpND/Djw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AzL+onNfVpMhzfmyvcv5VpCO2GdkIjv4Phw6qL1adkLdi2zc7En6LzGaWGDajM+xMQtaVoo5H2N8igsGdzCZU2gkqnDuYJeCh0Ld+0GrpoxeCEJa1ab21aK/a9qS9CdUlFpvVYY6kFTPYY3wu/2S1pqkdFUzZFHZNPDpqd1Ixlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eaVrVHO+; arc=fail smtp.client-ip=40.107.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFJH5YyZmkYxqu4cXymUYJdJEFRu8V309vwXLsh4pyarNRsYj9ab/vMcCk4NBzPswIILKBcwuyA1B6oyyPUhuN18gZ4wbcbDush3gZhlVDdn8tKJGefhyEuXxk23jgVFu1g3hUzwy6bftOA1jVX8ssvidJrexWorsJ28xcVcp9T22rBfZVfVBJbdSQH5/k5OXQBLYd/ec27tqkUnfwxAkY8ZnEqWcilNvwuUxblKWuBNUgAsqw2HVhCH7GUQoZlJOyE7ZJDd6NLSkv8lSX+YhY7np2lzIKlyFolaCVU/Gtnwl0xmgMbQ5MHP3+oTBXsGqQVaWRiCngunYHX8kZlICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYsSUySYbHHDEFlkdkrxJcSYeLRlv0axzv76qjQclus=;
 b=lhB8G+s44sH23RBm9wBUDM162oqceKJ+u57A29EuRMBshR4ImVTSvRGUSt9aoPmpnhXwyuhkA9kGU++OBJHj6Uuk6mYtwwVwhqGEkkyflhLLUn6qBFmS5+yvaWb2jj5EmKdonI8wNopQw+UH/Npwh8YtdAfVE2iFnAjJqeKQTpunRJ66bYsgrGzUrTOo15MpOcKtS3T2E30zbO28oUnOAgWgFoWI9PJzAkwBxSjiD9Svmme3jNdjqd4CCU2KIBNT5YaygT6K3kEaNnpLnbjbccScTQvwyQMEi4CwZFnOrVSbB5lHsh81JhADSDnEerX09MxmMddHbaaGnBR6z/uRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYsSUySYbHHDEFlkdkrxJcSYeLRlv0axzv76qjQclus=;
 b=eaVrVHO+V7sUv+ejN6yqtnYOJQzYtMwv43G4Fsc2GknoCanhufu/K+L3fSjQzMGP0cXsRksYx5g7SIvYleKsbougKxdIl2hUCAplrumnPsf6aDo6+zn4OOy8IRtDqzLM1XRzFL6G/O9h3x564yGdJG5b9UU1nt11JmCkfdqfUvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8575.eurprd04.prod.outlook.com (2603:10a6:102:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 17:39:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 17:39:03 +0000
Date: Tue, 20 Feb 2024 12:38:55 -0500
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dmaengine: mxs-dma: switch from dma_coherent to
 dma_pool
Message-ID: <ZdTjrzYIiD8pwHk8@lizhi-Precision-Tower-5810>
References: <20240219155728.606497-1-Frank.Li@nxp.com>
 <CAOMZO5C4XFGoWYgexdFLgHiXAoAP7-aMdi=K6CG3adQE_mHAmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5C4XFGoWYgexdFLgHiXAoAP7-aMdi=K6CG3adQE_mHAmA@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: f7920f20-7f0c-4702-0641-08dc323ad443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	29txDuJ9v5OEg62kTRAGJNhg9D0Kw4Bz3WtsAi0zxptKr/HIe15PnQqHOJON3ZUxcPGMe5Sjt6fq8hHVk5eCCtUlaVfaSqwHxTC7PtI/QvZYlL2rKqoOBXQPCsIL3IhXUCGwEs6MbMuzUN1t/ZG1YU060kQ5MRPG+d/yIHd708ug3BWgFusoDI1JT1zEFTjCjj+s8X3FmgRa0+EbX7gG16yiywi2heqyN8OPk8n1CblOPBHOt+sJFSOjt0+/5L0D2mzaFqnMrkYbt1iEMYCDrVn6qQTdIXXtPL08lBBin/h3iAUyrOhddhVfad9c6ul3tYgGIXrZAdRAKDMrYBPqdKGKW4FuuQDKxwbqQzG1bILQdzt1XSV53Ej0wzKP75czTDCbKBavNfizl1W4NwlwzhCJBhDLDybyreJl8mKwP+yx6ffqhwhIIIjkfVZ/l2VrwU8/YnjWnZUKCSLTzUxBqTEBAFCONhRuTUFZSfJG+De93/mWep8dOaMHylgmIt4DNse4WKCCktu4aMfUI79IjvhsolwjdcAa6cfsZT5T27MR8XbqfGyBvDvv+ef7bGA5dihSfgGz+W48fMih1q5RsO60dCjsewnI2zvqk06kMhf1uBETNgK5zUCIvRwKeq7M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHovOGp5eDZXZWZXeFJuU2kzQmZwVkk4TUlKS0lPTVk3TVgvcHA2Q3F6YU5K?=
 =?utf-8?B?eVlPN3Bkekdma0QrdHFjb3lqTEUzRm80UlcxbGdtUGY0eGZBOEpBYXM3S1dE?=
 =?utf-8?B?dDFSbGN6MHJSMEpnS24vREtPcDd1QmxGSE1pYVNabmdqUjJ6U1NIZDdyRzR2?=
 =?utf-8?B?Sy9SQ3BDU0FSdjJ3dEk1QzNycGNibnRuVDQrOVQ2VTBrMlFaZk8yRjk3YzZT?=
 =?utf-8?B?amxIUFE0S0htaXV0TWJVdG9DbzMvSUNOUkZ0MXBmZDd4MlZHUVl5NXpGN1Q3?=
 =?utf-8?B?YVBhYkZlNmlqRXFWeUVOWUtIM1lVdWpMTzJnMXJYb2VGVXk2VFgxMm9JRE40?=
 =?utf-8?B?dk1JKzF2SDNxaHpDeXRzZTU0ejVYTU5pRXdyNHRCTzNLckk5TWtTUllKcHhq?=
 =?utf-8?B?S0EzRy81V1NPa1lyelpzSWs3eEZUQzZ3WGJKTGZ4Z0hxR2wxUWlZTkg3aUIx?=
 =?utf-8?B?UFRYL1VsaTBwRytkY3Y1OFZNQVFEMC9CM3NzL005Y2VoeUxDc0pyQ2dxVlFK?=
 =?utf-8?B?N1BUdVFYQWN2SzdkWExhNkxkQndVYnp6WC9zdVk3b25FNkFsMktRdzZVdERP?=
 =?utf-8?B?V3UxRTBaYkFpRlRJejlVN3BaRkplQUt1Q0VTMnFwMVhGMUREcFhsejZRUytt?=
 =?utf-8?B?VmhYVUl3VktjdTVMTFRpOTN2Q01GR0JOVWJWVlZib3B6YitSWHJaYjNCSmdY?=
 =?utf-8?B?WUpSYXl5bGs1Q054QTBxalRlTEM1V2MxNHlzSVkrQWVjQ3JRcE8rNHIyNUdN?=
 =?utf-8?B?bFkwS3VpZXpFNVNCbzVjcVNadnV1NThHZTYwc1BqaGZiVkIydGswV2pkaWl6?=
 =?utf-8?B?YlBGS3N6Wmhwa0dWYjVvRVBxWFBaZWRBZGZmazdFYU90bnNRUXlKY3RHRzl4?=
 =?utf-8?B?V2VlZGJRSlI1cW9zdU9YUVVGSEx6R09GRjRDcmZSZlZZTTdZK3ZHdVhTL0Rh?=
 =?utf-8?B?ZkdVNVZIbnRJYU9ZUXRVQzBoeFpGSmtqWHJ5V2xEV0YzYjB4WjRBZlZuaGcv?=
 =?utf-8?B?Tno4b0tNYzRQVFhQWGk3cUZPRjdRTndPYlREazN5UGNHTktZdnJHalRXVG9a?=
 =?utf-8?B?dHk0VXNONDJuazU3QzNRNDBmcVZ3YjZQdmlhRDl2RDUyclppRFA0d1hwWHFn?=
 =?utf-8?B?dlZSN1RmaVJMTFBvSGNuUmF4V1M0ZDZJSXlxMmNxTzZjRm14WlJjeHlMenV1?=
 =?utf-8?B?VHk3SS95QUZrRmZOQzhHQ1ZBSGJ0bUlQaEZSeStyemhiR3dlV1lFUlovcjFJ?=
 =?utf-8?B?Ky9paWphT29QMnVTWTlqV2YzK2F5R3p5VkZQSTlrVTF2V1d0UVZnZ3c4N3dJ?=
 =?utf-8?B?MklFUEs2TVFRQTVFRGRrV0tEUjI4SlVNT2thWWZUNHVlQW1ZZG13SnRkdy9V?=
 =?utf-8?B?cm1BQys3clZqZFk0Z0k0S2ZKMUorVitmcXRzWFV2NkFZUFliWDhLZmVwMTBt?=
 =?utf-8?B?WUNmeU1sR3JFL3MrY0pXT2h1RkZXUDRkRXBKSHRiVUxQc25ScG1ub3FOSUJz?=
 =?utf-8?B?MzcwMnkzNnptMkp5R2dBWVIveGxzcWRYK0xTcVQ5WjJMeUJjcVB0dE1hb0xr?=
 =?utf-8?B?WnVqRjFWNk10Ry9VaUdJbnZhVk9lMXJYM3hjUWlMWUNOeE9pUmlSQlhJbE51?=
 =?utf-8?B?VzVrY21lb09YVWJlT0MzY2o3ZnRHRUd2TmNabnhkbG1DZEhBYWlDdkZ6WHFY?=
 =?utf-8?B?aTBWVktEbHR6MXlGc2o1c0pFbFp4RnFQdm0xTFQwT3FXL044M0RWbk1tUFpn?=
 =?utf-8?B?Ry9tMVFNVkIwaXBJRkNaOUU4QmRldFpwaGNIZTZxQVJORVpaVFBSdUhlMUNH?=
 =?utf-8?B?L0wzUFhUeWhJQjZTUmlBT1h6dmJ2RWxrcTRwWlROWVpBM1ZEaDIwWTBkRjVn?=
 =?utf-8?B?T0lGNE8yRE40SmtKeUgrRG5uUHc5Z2tlV3ZKS2tqM0JjV3haaFdrNXpidXVr?=
 =?utf-8?B?bDVoMnhrdDhDRzNkaFVlNi9kWmtBSG4vRGRRdmdJVGM4aDM4bVdHNXhaTnVH?=
 =?utf-8?B?QklLOXJ3T3hBZTFxOHRnYXFPTWluMit3eitVeWNKUlFoV3lVRS9HYjdvWXd4?=
 =?utf-8?B?NS9JeEQ2Yno4bklmTkhLYWpyUlgyc2Exb0lPME1tTXNQZmU1YU1lVFRUeldu?=
 =?utf-8?Q?DukE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7920f20-7f0c-4702-0641-08dc323ad443
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:39:03.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuqyjuxzUSEpI6PN0Db5dvkH9wjqrHDs4CT2MXPcvGsXnXLZWxDDQBpQYzyIEfESgeSL8tUI1DUNMQAxy1lEfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8575

On Mon, Feb 19, 2024 at 01:23:22PM -0300, Fabio Estevam wrote:
> On Mon, Feb 19, 2024 at 12:57 PM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > From: Han Xu <han.xu@nxp.com>
> >
> > Using dma_pool to manage dma descriptor memory.
> 
> Please clearly describe the motivation for doing this.

This try to fix a cma_alloc failure. But it is not correct to use dma_pool.
let's work out a better method.

Frank

