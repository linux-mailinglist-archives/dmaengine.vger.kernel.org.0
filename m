Return-Path: <dmaengine+bounces-8929-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH2KKdqtlGkPGgIAu9opvQ
	(envelope-from <dmaengine+bounces-8929-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:05:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 403B514EE37
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A38C73013DFB
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DF0296BD0;
	Tue, 17 Feb 2026 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FI/NPZ2U"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013051.outbound.protection.outlook.com [40.107.162.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39E23EA92;
	Tue, 17 Feb 2026 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351510; cv=fail; b=IBK3Bz42W6Lo4AgnjGjNyjXGyq09Awqpsgg2ZxR/89qv139d5h/vtt3KPwNYc/pyASxuOrYYlLOB8ndGPsM+GDuIUwz3u/+1uCT6Qtfx/pG8HyNy5/zW7dfcZJ3tmpAjMcRNSnS065n4DCudkuRwLNq3uGzgyWVHdsub+LmQ0vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351510; c=relaxed/simple;
	bh=GYJjwATs+Vz4jCT6M8y6OUZ8nBliROcOjsiXtkEpxBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HfkIgTN3FczDtuC+yjHO3JhU5LBryrDaec3APqtH6gzwNWl3fh45W1APhLgl2+ert8nOQ+eQDUCqEFDUmB6woRBAN4eFcxHBLDpVhi8R7dr3dLw1zepNHtA2DI4FvbXfSnGTJGWtxQGtCB3gN1ybxDYNUMnQd2AxdzB6uk1fKXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FI/NPZ2U; arc=fail smtp.client-ip=40.107.162.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1y9oD/+wCozJwAtnydOBPWgVX6pSymcI3K9Kx78nV+0RL1k/y6yd1XPA/uG43SLDMSnFcATtTV08M9ACkMf93uiMUALgZfkj5nFH+ExvrQFz+BjpO0KsaAA7iG5j53kqa0tJZXwzCio+j4+sEAxsyxCe3I7Dokg2f3/fFKpfDYDhvgyCqhRjH8QPmrvxPhbtkZSI23GHnyDSBWqZW4uP0CoIg4VV7TvXhp72e/8s25/KkxPq2+GZB/Dbr9MgN2VvqMAsiTCc31Msk3b3GV1QmTYn3KnA0rAjkkPyYRXSmGs6OSUXFU++EMlEm8wis4x5tZYaacshjxYhhpeLcto8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cz7ffjX08G1tZ7+W4WNg3wdImcdYDFriyDoSdwWHiw=;
 b=Q6xbD9YWy+2OjxLY5gS4jq7fhLePqYFa3vxrUxKHkz4vQlrxXEPCJ/YGtR/MH5N3/+m+zeGbwJcNC7gN4NxRKZvSG/UZJ2/byGgmZWVH9X7l4pbeQlsG9NBEYzM55wWOpjTNSZmCi6QmrMXgDjGwrzJDaTWxiQedcdLKVsSdXBCwHftakM7S4nKLNeA53fXVbdpDo1SS+sLGDw5F/vDEW7mAMC5alUHFnK1ZlFeZFWSabIqodWiQeABxLdoDS7aOQs2jlpWlFwYXpEFcNNQqwoDA3PRolEJYUfuMMPVbQbaMO054AEMn6XVAKuuqkgFvcjCfrEbFny3kFRTULONsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cz7ffjX08G1tZ7+W4WNg3wdImcdYDFriyDoSdwWHiw=;
 b=FI/NPZ2U/TbOtaN8HqcvsoddGFLwMqTsmWvuQRtAckx03IyTRDt0dfFcR7Wl9CT+B74/d2Mha9ZcDARold4tE9vwznVr9G8qh9WZEUj2WBZMkntOuHwEAs0nU50HUY/Jv7jE3KTpq/u10frx+NB5oFxR3urhWoTMaQ7+OBsRBG5L99h1HCWKKlnuatXOrPmeVKUs7ZthsYqEuOdtR16iraSroy1D6KdyVk1rG6fdLTS1KYkaDo/bGRTRVh5R+kYjBS1q6qNV7WzKOMR4tuE01ef/R1Tdw77TSriAyr3vtBJApRtavZ3+JBNcsL92dGBa826cnd1/dNyXcGL9o6Tfdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8507.eurprd04.prod.outlook.com (2603:10a6:20b:432::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 18:05:05 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 18:05:05 +0000
Date: Tue, 17 Feb 2026 13:04:57 -0500
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, p.zabel@pengutronix.de
Subject: Re: [PATCH 3/8] dmaengine: tegra: Make reset control optional
Message-ID: <aZStyRaoMYBlNOSY@lizhi-Precision-Tower-5810>
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
 <20260217173457.18628-4-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217173457.18628-4-akhilrajeev@nvidia.com>
X-ClientProxiedBy: PH0PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:510:5::10) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 99753d4a-4f72-4d1a-015b-08de6e4f13f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RzDgAZTBSY/59bM0+JEGJcBqnbWFqHySofw0IwIMpIQ7eSP/HJHJSt77ygBg?=
 =?us-ascii?Q?OkAG0DCe81KVoRI5zEtGPpIII7LpDtcKQtwAVzewtZ+6kjjdomVD5I+TtNCQ?=
 =?us-ascii?Q?MyM2H7nKqArUWr9eUuCV95EyQh1Q1FQaE8wUG20neM9dgVBTtSgTWcydJkDR?=
 =?us-ascii?Q?hNAw017zQO9HRUaHEiyjQ1Rueoz9jp56jZ0e+YDWQOtnuNti6+1CobLCLPBc?=
 =?us-ascii?Q?Yj2QAIcslFRrdfHiXo9RT8LCOAu8FZjB2/EAwHKGiUpNZ9ngQwZWvDS6WacH?=
 =?us-ascii?Q?kWqAtvL4KZpztsXmWsDufE2YF9bMKdcw6LkdlgrOyeD60odDKcqds+owsyFy?=
 =?us-ascii?Q?b2L5pL8mPfPpGdUscWk7ENREfa+8cBVkPylp1BJMF8NWTLuCHMYNsN6hqqr8?=
 =?us-ascii?Q?KIuh62G6vNPDQ+seoulWqCwV+ny9/7vx5lPCgaFLwS5ORuakO/SV9dr09CD+?=
 =?us-ascii?Q?Hhi8l1Txg8I+5eAFEZxK5FrvlpfPfxE9ZGcr5CaHxUmDbfWo6Dl3dNCn/JPo?=
 =?us-ascii?Q?qs6HN6LT2sO7jR5RFR/gMFYsQJLXLQOs/s+ZfkDma0lEyBm8YE0+VBIz64lp?=
 =?us-ascii?Q?s2N3vpcsDDe/773fmqpQSsIuo6N6tSkvMo6c1bs+rXLsGcy6AzGeKZ56Jtlf?=
 =?us-ascii?Q?TBs9CWpDJhUFD6uyXGvPh2hJcUvoVP0/kJlHzOq23cW9lhvnBwbGyOgWceXd?=
 =?us-ascii?Q?EIO3FowI58mSArjFjzM9g2fWswZHLMuKQd1mKkDTrl17oHQrVnSuJMMEHqZ9?=
 =?us-ascii?Q?kSlHAhOk/i555c//DJr/XYx20gs/4RPkOpBEb5KSdeQ3JjimJVXPbq4cKcH0?=
 =?us-ascii?Q?n0bD88YWrRGJKYQbah2R/jF8qvWoWCoODeiMs/7qGcLfT4Vn/w4j2t36YGPg?=
 =?us-ascii?Q?pA6Gb+lPVWTne63ydmQYUxT5B21EIVxsRacX1GKQqGfYWvCIqEtHdASXXThf?=
 =?us-ascii?Q?W94xyKBd75HnyxZXJPzukIPjyv0+3LYTwCr6ux66S2liJyD3LqkwbBlV21m1?=
 =?us-ascii?Q?VKqLSIdt6dN/Yc31ySiKRS/9qslfqEyDuy3kGN6WvRS7c/TjtUShOpm446io?=
 =?us-ascii?Q?hmzDip/SpMPz8avwp84lzUvGR5E9/rU5K0mQ6OTBMZzn4XTQL66tukFHoCKM?=
 =?us-ascii?Q?r6Yeg6tJpJavPXv+tIbcHrBiZcId1QBFZgcgOflR3byFJFnT3sB1aFjWVjhx?=
 =?us-ascii?Q?B9adrftgWJ1m3c/1BYp2afCU2mm+9lz0kU5UCT0pp2cRal6yDFcJC5k3EYSE?=
 =?us-ascii?Q?s0jCzotbL/8chHVGR37jnE6UWLVVonQOZStp85pVMBCUbhHKDXRMc0kv+cWq?=
 =?us-ascii?Q?D6Lx7sGWxKd4fZKXolYGOHydP7fBD/si5dj5rqTpE9450raBFXk9FN70UFHM?=
 =?us-ascii?Q?IWlCs9FpO1AWC4AmWzS2EF7Co4swKSz9TC2RuzgyI4KoHcvxu3YTuTHzffm3?=
 =?us-ascii?Q?AQxDuwDWGymRrTEM3LQwyiVoafEEc1Q4jo80DvfgAmTNE6u9iHo3imt8GpQe?=
 =?us-ascii?Q?pGjS7UwxcKzXJd1QccLFZtEV0tCIqNOQM11uvZzgkQIelW0vk5hNGuqu71QQ?=
 =?us-ascii?Q?ihB/pUpxW072JCC5NDQ+uWNSXWSWDAK3xuEFR9aQoOf1nqG8zD0lgIYFwp3u?=
 =?us-ascii?Q?gPyz5uHKFfucR7IZNVNRi7E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?095Xepf4FCfS1CQAaOqmQOeJnl5+ZLNbsXnOCvkNpZpeStHy8hjEyGbht/T6?=
 =?us-ascii?Q?dw+oKlK8ihnipXO1GK28Zz/oBXlCGkQrc4fjDGHdQ0okjjprUlmOZrtI63a5?=
 =?us-ascii?Q?9jKYnTggF8Ncag0B9eveDhz1dnR2QH02LUw2ENqErZtHVg0asFsmM50QCkIB?=
 =?us-ascii?Q?stKwyoJ8aShdjy46sdmJZoOyFWuBrO0V52sHrTxlmQopuXYbq7d14DxCwhfF?=
 =?us-ascii?Q?quB1sNKEt1/uL1bWrlx33vI45GEskvL9p/RcEXCVQDHCSzqxVXbki/5UbWtJ?=
 =?us-ascii?Q?/TwhJNPVs6p8cyg9JWg61HkoW5CeaIHoOF3bg0c6yw+COW1+5iG7rYAUSpNO?=
 =?us-ascii?Q?A3y3YOce0wqq7gbj0RwbGC4fEyQG80T6hxKmHn0B3xA0CxRiqZR9Y4OJlQlV?=
 =?us-ascii?Q?ZZeKZBheXA4XoAv17BFXs50XswR9LjbvVKqB3ZQXZYWCOJqVpqG/qy/OTpR6?=
 =?us-ascii?Q?U+/8ufS4435VIGFDqHEH5vTn+fF/suMu93DyvM9fUq04Ha1jQ2fqtslJ9Gyf?=
 =?us-ascii?Q?4YqtPUkqwgVvS2kgmX2f3TVHJ9OFVWQaEWfEa4QjoI0ooh0TP2rIoWov6cIZ?=
 =?us-ascii?Q?jIlNdgIallpde0DpjQGiJK3kVqaLb15GyzoRz30GjYJ1GznySS8ZU3SSPjRc?=
 =?us-ascii?Q?r1kA5TxRnYLQcZgX8rtWsnA52CUjU7S8GccafYnBG9v5tcjaG97wWKWGsuNj?=
 =?us-ascii?Q?Tn2676/7nZh8IEb5RFnAu+jNPXK/NU/iAMCS5lkLe5fVf6pGtudCP5byqZ9F?=
 =?us-ascii?Q?dOYug/6Wej06Gf0Pb8LJNsbVBe3FgBp07Dx2SLFKg2RULpGCuALhnjtY8re4?=
 =?us-ascii?Q?uXKZxv+1+PribG/3q4KIMrSRI75mMwAjocqNdwpfD8Xcc1POjODMTDXE9KV7?=
 =?us-ascii?Q?8sO7Fy7Dq/QovakzGUGpYystPanUQkn0bgJ6qeB+2fv7kP5nncvFyw2X7nXw?=
 =?us-ascii?Q?MFRtCJjaA3yNnwawIW7lwbw1zJR7tCEtNdxMjdI5Jx37gmZeMiYBIJdRKqJb?=
 =?us-ascii?Q?krrlUqTSw8ShC8Br3Jy4LRQ652olqBWq6x6pe7f/wlnrCsCvyFO41w9DPPJ2?=
 =?us-ascii?Q?zmNQoq8lJSPKj55pqZP8rBLgnWVGZtKqXyUVs6ufF0KCrMEfu4WBASFN0F0+?=
 =?us-ascii?Q?o1pwx48xnIg8jHUbSwbA/XxyvrvDzPlkuPm78Y7FG/Bu0aRL16jtWHrYMV44?=
 =?us-ascii?Q?zbXhpLlN3myWWlkn8CSFnyryzVCT7EkW+JCwYM02pDOBY4+yDwurOaBlPUwM?=
 =?us-ascii?Q?40t7TH33pM6ZHjx4kxh48E4kgfjsAQml9df/7SbkHiT4Mepz785D6eEPKtFA?=
 =?us-ascii?Q?L1T/6UpV5zRGHL/8FpHpMSGjrOpwXg1VQw8KVpUr+x2XGWnkQ5JYexA0juQs?=
 =?us-ascii?Q?/7sAOw4sTo95n163P7yYBYP3y2pLX0Renxx7y80xReMAAS9gAOB5U3sokFF+?=
 =?us-ascii?Q?fr7MJ8W5pYDYrOKEIPpQv5LA0x7GkV5D6NKPbvz8v1zRXBkRFxyEgKGiOzrc?=
 =?us-ascii?Q?oouZg5/254DxtuI4eA/5/OmUTeb62T2lAYnEL1D5sV+fR0e/8r5OiabMPpMx?=
 =?us-ascii?Q?ejvSTmEEwdj7HLca9dJLx7RBj7aQ3KKze3Yn7zrySe070Fqt9mUvuHUgfVO+?=
 =?us-ascii?Q?H9tsycfTyJ8NKEkT369lzQKewx50zayzynTAgfAs/aS44pDWrbOJNXUaNrDV?=
 =?us-ascii?Q?r6ycOozqUEo6QNC5ycfo+fWTb2s5VVDGu1vgTQHuauuQIqL8FzfmXgHtJjfp?=
 =?us-ascii?Q?/Jz5cSod3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99753d4a-4f72-4d1a-015b-08de6e4f13f3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 18:05:05.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsxx7sYfs0XeSsKETn0QoJusay2CoXOg1IihEr7yUGFJStcHAcj0c8ipENnEV8J2rl5UqAIO3PrXI7FMoH/GGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8507
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8929-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 403B514EE37
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:04:52PM +0530, Akhil R wrote:
> Tegra264 BPMP restricts access to GPCDMA reset control and the reset

what's means of BPMP?

Frank
> is expected to be deasserted on boot by BPMP. Hence Make the reset
> control optional in the driver.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index 4d6fe0efa76e..236a298c26a1 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -1382,7 +1382,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  	if (IS_ERR(tdma->base_addr))
>  		return PTR_ERR(tdma->base_addr);
>
> -	tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
> +	tdma->rst = devm_reset_control_get_optional_exclusive(&pdev->dev, "gpcdma");
>  	if (IS_ERR(tdma->rst)) {
>  		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->rst),
>  			      "Missing controller reset\n");
> --
> 2.50.1
>

