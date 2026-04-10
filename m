Return-Path: <dmaengine+bounces-9952-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCFdOrtq2GkhdAgAu9opvQ
	(envelope-from <dmaengine+bounces-9952-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 05:12:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 427023D1C31
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 05:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8B7A304C7C1
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 03:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6431327D;
	Fri, 10 Apr 2026 03:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A6THVb+Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E73126DA;
	Fri, 10 Apr 2026 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790655; cv=fail; b=LnIlummzr8nRXpYF+wB3LW8vkMF7NkOiwgE5NdrtfnNXsXTteCRcaxqNq6y4WMElYgk1ouY1YaY02d7Qm2q1UMfDfwSa25DFyNeJmEf22loCIxZkggG6MoJmi0puWT7+nW94VaN+iFTEYt62afTBmEAIvOJITmu1YrzJ48XPyBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790655; c=relaxed/simple;
	bh=FPP5kVbktX0sx2L+BXeit7QI/l86bkac8ZjFlRXOoB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j11R+1py/57tdXCgNPgifSQ8gptGQNohE2m1pIjG71m1Q/UI8+EtnyH9CVjPmuMgaMrFx6ycFYe8weHMbVR28u8mL8FUgPPkH/nDDB3RAu9XXRn6RrTvCDsd7EGm42R3Gf0bn08lRut9Fe4K/Y2GM6jFcha15la4HKvAEY9CQk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A6THVb+Y reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAwRHCdw2iKW5ytdxvvsTcSZeWkZwWLVkYTOEw+8/cCneB4pE6nEDH95CvokyuUXvsYAvmbSTShzAZ7djUkote355HQB/imyWaShihFoI87rHNrsGBvXUexUmvDni3E4edhgtgP5kyybk73Lj48QyvJDUltRW5uU+KttXrpCP09MzwO/U76mUmPxt9isft/m2FzykkY3hxjMBlobIOgrAG+SXx5vHZmNea2nrq+ODfGhEuAqz9rhNzZQP/hodFmbnSi7HQel0iyCbvyTYxo8nqbarCpJCcBnPvL383JZM7j25rrycrdoh+3uiU5Uq+IL3vZEWaRDUiuEc9CKFKsOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMD7jFWgvK0KwpOE8FB4O1uNNOBQEqmxpyBNWSJxi10=;
 b=XNNIMp/yK/8Tf6+gGSOlYd0Merc266NQz2l77HOgyggl4Ic+JKSFozh+7K06O6+7RoX2GasvpY+RByJSfqT/lzFuYidxtd6QBjLhd9G4jZGG7bbvT4nLeXd9bFeeUf4hbna7EHgQRE/VEmT7TUtQlpRbOHADjsvReKUYgVDaOQxFeCOgu6OM9gQ8xVMNbP/gTmIfs7wf5WC2hUGf+AfPTC98qiAPGwA2Pt1xyV1oTNrGVvuFtXsc3Xm7CDPD6MVWWk2UN/asCJoZKDd15ghM7zN4scsWf8N1cYGtGEpzUS3myKwrONfMyN58dGW87/yZySqP2FklOMv4CFFlnbUWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMD7jFWgvK0KwpOE8FB4O1uNNOBQEqmxpyBNWSJxi10=;
 b=A6THVb+YBnKr3jynNdKnpejr3Zp+va+gV5M3irnD6GtmQ4NZJgpiE8HMf60z+rnUQU9V7MQ/bWwbFheW+Zz0NZCSguD9aj72UOXrzrkBmfDggjlTx5rwm/dT7dtSHBMTOKARkmxkUZpYIq+tDx7qzHAw2RbJWfrb/EwFgqfCFW3+Lr+6p1LVqwpIkZzu+QwlqADtONpkxX/eCOJk3GAJ9n+Gyw86I7PrinQm/ZfcHcLBRm/CcX/xceD5Pm2pwRqeblYK5SdqPlGRqPCK8try6QmpqtC1jaa5xaGet+HOQ4UuBI/r/gomvkw2YFOWn9TfUijAnV3hIf8lUZw3pMBPJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8993.eurprd04.prod.outlook.com (2603:10a6:20b:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 10 Apr
 2026 03:10:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 03:10:51 +0000
Date: Thu, 9 Apr 2026 23:10:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v3 4/4] dmaengine: dma-axi-dmac: Fig BUG() on vunmap()
Message-ID: <adhqM6l5zqMnakgu@lizhi-Precision-Tower-5810>
References: <20260408-dma-dmac-handle-vunmap-v3-0-2456ad292154@analog.com>
 <20260408-dma-dmac-handle-vunmap-v3-4-2456ad292154@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408-dma-dmac-handle-vunmap-v3-4-2456ad292154@analog.com>
X-ClientProxiedBy: PH8P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f45e32-aa3f-460f-2dc4-08de96aec51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	AYlb2qkDtNq7JvMEUsEAqI58Yb3/DfwUARJ0kWM5McqgX/GvzqP6h0QvhMF6urdqg0R8GL2gVdgbZnC8YGZoP+o3WyLo/6JtnrfqpPi4FcFJr/9F0tdR46jF26DEIYnhRRIfeyTt8GATTCQyn70CVXHC1eCtfLwoBVwG7fT5/gpko0xoNLj+XkoNZOIZJtylvkekuzIr2zQw7R0uC4x/Mz6J7JHxrRPy3yVQPVt8DziZGsMIy+dS85h7dyadKmHIyswElxkgPvDapmLIWZioZsYXHgQOFFxs3u4iP10RXrw/jmvijTbAFRfLwUw9lkaEXDapp9dSNDx0kXx6iXE/bQTxdHLTJwHB7StrDNJS0bZC3P984RTBqH5KocTxitOO8E1nmHsTtXkqbQJCCFAcQ7fFjD3t/1D+v7+XI80fUohCPEEKIK/2mpy/mvawcYR55yOv0ZVkbruyTkhINWGQRArO40o0hBhdrZxiTxVt0Z4Mi1Jh5f0LVcqhR0zbZwDKirAXKUYg3+AN5paZ2x8iG3mHWUcg5sKGdECv3iWGSbc4q2nIkxhLAPSLg26CvnkE3gcvceRr4NWWjOlz8Hatg3dJOd8LOS5xHmPyapYVcdT9d/U6PbIxu0OyRxfNBsSDU82kCeqH8KE61Gobqa7kuTUc4vFG5g0d2e9dWq/GoUaEI1/zBzvHlCjv4wX8QIKyc6e70OW7uKhD8g28kk+byHjChKUvxHuv6gTlDGcNYCYyCHDwhTeh19CLtx48gcSW2bSoJuj9bHEWxPSQFjUGV7oouGhN5a08Uwd+BuhmCJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?JgovCwOM0ZAdZXfa+BEOfwqV2wMyNtVmEuYYBy4yIfEMEJXOVEqF3tOolq?=
 =?iso-8859-1?Q?uy4qOiPkWJFB4SZSREA0egrW9uM9J/W6LXpLXVvOWB5QrZLKijZOl7eTer?=
 =?iso-8859-1?Q?0PAy3joe489ud3PsYX+8nIR92VeWvBVly3GcJjbpERx4SrPLx3FoMh9KWu?=
 =?iso-8859-1?Q?Qz8J2ZvcFXtj6GBHaKHnR5/wqI3wRJ0l0afsZSmhEMhVOD6fF3pYyoTR+i?=
 =?iso-8859-1?Q?XEnCgKioUrjzPv520EfpLNalEbLCwGTwFFJvAautTNN+5BTTAQVe2aqDtU?=
 =?iso-8859-1?Q?NvlfxCsArJhrSb8XY2BhpXd4lf977zAfbGrwjt4MEjSxCkzVo/LVI49vgJ?=
 =?iso-8859-1?Q?rSdAyWcj0VozcLD7oDJ3wxEQPeA1vEUDQ7wVUEwZdf5rYX6p6lCLmAPDXm?=
 =?iso-8859-1?Q?B2DXg+UCDV3HhtYQ+NM7lSA/+vNM2bpLLELzxgYwv7kPg79cBMddOm1EVu?=
 =?iso-8859-1?Q?z6Dad4ukNqQaDDs0w/ggE73QUMrIGjAwjQYRp5DHw4yPlO21uj2lh28cQK?=
 =?iso-8859-1?Q?muU57I6YoS8roV221lRU2SMa3kTMgoiIp92rOu0/8cyY/SmJNI4IiiuafW?=
 =?iso-8859-1?Q?8sJ7HxRLeyXxT9PBJVvv6/fBsVDFmopEz3y4Gn5hC3SCby9xqKNOPRx8G7?=
 =?iso-8859-1?Q?Dl7WjnJAOi3sUjD18xcuVCqHuZhKJ4FLfoxHOqWnSPB9ScHcGlCw2MdReg?=
 =?iso-8859-1?Q?S6aCnZwe0ljtiG20XbeyojZBantHhw41/GFvTCCBST0jo9h9cURBIxlm1y?=
 =?iso-8859-1?Q?aMLMDqLTfkUtaWa4HCsCav10fp4UrC4462SPu3CmFjVmyuHflCQsbVvIuU?=
 =?iso-8859-1?Q?1JhWs9beBU17jfw5T7msseb4+F+/zO+rjhm0vhFlbrZDYwKw7/76ejddDk?=
 =?iso-8859-1?Q?I7Pm70kfCboT7KmKRSVgnpHAB5NTAmZuqwbxXKNdIgMA1wYCME66BvO4lc?=
 =?iso-8859-1?Q?/yGL1nXXsy26Qb+ZO3lRiy0D9dcgtsyZDHQiTD3y5NxPY9s9PP12QMNqdg?=
 =?iso-8859-1?Q?EEbxBWkG6QDebtHhwK9tnfS2VMqdDqjEPNSpWDks2sWn+1HZnbdMozIfZB?=
 =?iso-8859-1?Q?Qhwik7XybmkqCdM8xv7WhSfYTCsyVypnALOLsm43TJWpHx2LOt7YnrANVP?=
 =?iso-8859-1?Q?m5tQxdGNvpyzJ5WvIt/Cus7msySUqfuZXeyfHHhu63wvKKp2Z1x6EogVVU?=
 =?iso-8859-1?Q?sES/iRGFjHNai4xIaqbPrEHAfIJYFXbzaYe1iVK6Y4KtAyC6v7w3kdMY2x?=
 =?iso-8859-1?Q?jdW4xgtPOA81zEoGm7ezvyyHSgMV4Ee08zVVV/0NHSgzw37wLcVc/PLGCl?=
 =?iso-8859-1?Q?XvFWN8Tn2CYDFoQukLzQ6a7Ut1hlAYE0cqPsKoA0DT19D4rlcHlfdILdgm?=
 =?iso-8859-1?Q?x3VLe4wMifMY7mX3UpK0mLRJisumlzvjfJBMahl9+DRbsp35imo8l566JA?=
 =?iso-8859-1?Q?5DXip5E5wAmxDnqkZoQHJkwrnwxLAxNdEPUWSoIAFzIltnOnE78zwVP6o4?=
 =?iso-8859-1?Q?IWpl1hdRQvJ1y1ToUAjcEm50+5aPw1i017aPBKi23DazNhzhsKf9+xJ0m4?=
 =?iso-8859-1?Q?Xondb+FeB4WpBckg+4LEnX/Zc3YYAIZ89OkROE/gQ0Ky8Ue5EQsqR7lNLt?=
 =?iso-8859-1?Q?to8COnJ8knpzw3c5gac3HzeUL3/nDj9l+Bf8e+4Y8K2Ir0brAEpgIKvs41?=
 =?iso-8859-1?Q?N8iIOdr3P4YWpiyCNgnlF4XSetGK2WhPAwXShAf19e93TBN5CaT/3/g7nB?=
 =?iso-8859-1?Q?ZGb+NEjZkKF8HE69z6XEHZwsD0krJBC9tUEqYX/85rAGh5r9Dt9UI2Ixke?=
 =?iso-8859-1?Q?5uvlMProBQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f45e32-aa3f-460f-2dc4-08de96aec51e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 03:10:51.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4JrBT2QsbDViMBIVFEll1/0Rlmqq6xlJkMra1aTzwpq/jDmOCIYmsnw4Se339shRNfakmqzkXP2lTuw4lkPlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8993
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9952-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 427023D1C31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 01:42:43PM +0100, Nuno Sá wrote:

Subject need update to:
 use DMA pool to manange DMA descriptor

> For architectures like Microblaze or arm64 (where this IP is used),
> DMA_DIRECT_REMAP is set which means that dma_alloc_coherent() might
> remap (and hence vmalloc()) some memory. This became visible in a design
> where dma_direct_use_pool() is not possible.
>
> With the above, when calling dma_free_coherent(), vunmap() would be
> called from softirq context and thus leading to a BUG().

Add fixes tag

Frank
> 2.53.0
>

