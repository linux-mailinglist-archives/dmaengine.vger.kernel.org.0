Return-Path: <dmaengine+bounces-9042-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI3fK8wpnmn5TgQAu9opvQ
	(envelope-from <dmaengine+bounces-9042-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 23:44:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1310018D9A3
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 23:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E54C3143FB2
	for <lists+dmaengine@lfdr.de>; Tue, 24 Feb 2026 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DC7347BC9;
	Tue, 24 Feb 2026 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HUSo/Ygw"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D01C84B8;
	Tue, 24 Feb 2026 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972501; cv=fail; b=smvnq6seqGKWOnC/oW7bRedbTjSx9GHhNPc02SLhseEsUiwkPFHNnFwlseOAVJbmPLRaJYw3PswLagp4zG50yIb648EcDmOFQmQUmV0SmKSpQpjIYie9d9K2wub4xB4nKSf33Zx9OR1lftiYk8oLfKJE2uMKLDhtlzVJbM7NLG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972501; c=relaxed/simple;
	bh=vRonfUJKXL3dd2DdGDinqAazenUdz8qGDKt0LIvCRnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KJGZFhOgYRneMCuBfhaJ5c6HLJNoYlrxsjWucmDY3GO+oc+BgByjzSSJRpR81senmnsnR9qRuVZZGtgXnPLU9uEDjmEPAcDei9eAq4Y5aepZ9IxQYtQmVI5T6f9c9IMDRntxiNJx5dSCXl4RFUFBy+YHqN+Cug6lDe+H/ZsuB9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HUSo/Ygw; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHekMqQjowoOq7VXmNOMvSdMvcdXmXWqN1IyDFT+e4f2SqoKuTbhzOIqtUo/vIuMECzQ3zUVYS3fpaFHgyV1cc+ZGc8HR5Z3bF1etT2zr5msXItvZ1bteHxkJiIq8/ZxOFtQvLfbOGc7lQAk5ZGhgsQFvKIyA6rhiQmIA/zb72phwF5ow/hKi9qDKvGX+xPMDaGJabAHeuj1e3BDzaHa4ZhN9CTjCkdrEiBEyu9EvaqAHWV7aLWunM5y6yTDVtBHXM3c2foU0oPWRXjTMjF+FZ8kIDwqo04dDLfpPemPkZCB++K2h9lUO5AFCQ0pBLx/1BwDP9oLuxfuzrNbxSdUUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eSxuXZALcUtTZTzCSU0IPDShPtRQOXZJYtZGvRQFa4=;
 b=y/SKE56CjsjPiq844milMEDje8HJEpyRhmOmV6lEncOComFtTk1m+u/lIFvKPUEbS+j3YJ7lAiFb4UzRrhnyeMMX5/hrr/cnqmTOORxn7Jk8m41GoRExF/xW3ctc4Qrd1lkrEnSlTn/feC4sv5zPeUe9xxYIo7eu8I9zKthXbPFbl+YahYCLyJCVDXqvvDmhZN2ctWrD5WO5wtizIluZ5peWTApR6n68ErVoXAraLjh/ybggdUJ0MZ8IFppgWlvlzYta4MtlOWJn38HdsK4n+JnU5yGL1BGlFk0j1jL1zQawbLLmcvVjetkZt0PNFXcKeHF+Tq7ni0ZDR8FPGvJGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eSxuXZALcUtTZTzCSU0IPDShPtRQOXZJYtZGvRQFa4=;
 b=HUSo/YgwbDJ69d4e2dExW7eJ2T8/WHtkC+aCzcWIQ+0ReRqWXml738w0U9YSvVzTTe2iCHaJkccHgG8Bk7tg6/DVu0iQljis+ZOs7f+y9iwQ+Rqi+pwbAxxuScnaaqRMdOJ8uyPBEtli66mfl7YtCUqLodNLyqQiaWyFCFZZ+BiVeM9EoZKLQUkeqoBgHSMqz/r0qHkyk/KExmoz2mUYsvpVrpVQ/FvhMxtBwomi+cm9FAnByMeSHsMmJRTl7idu2NDJLUH95ONSCBgIFIx8z/uI670DI3qCP4lUkBAn8zIsfF82MZEBLKrhVzmn3p7AO5FGvr9zerK7gPXHh4MT3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by AM0PR04MB7076.eurprd04.prod.outlook.com (2603:10a6:208:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Tue, 24 Feb
 2026 22:34:58 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 22:34:58 +0000
Date: Tue, 24 Feb 2026 17:34:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Gordeev <a.gordeev.box@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] dma: DMA slave device bringup tool
Message-ID: <aZ4njFwdYsMLTcSa@lizhi-Precision-Tower-5810>
References: <20260221132248.17721-1-a.gordeev.box@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221132248.17721-1-a.gordeev.box@gmail.com>
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|AM0PR04MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec9a7d2-8135-4387-2579-08de73f4f0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4sGwtGHVZFoBg3N7hcDhz+t48wPN+1s8JboMx6GbLcXfKRgUldvkV//5fzzC?=
 =?us-ascii?Q?OPqvSPYJzCHSPOGFvW/cKJo06tzkazkBWL92nw9haTvEutpR0ry+d82NWjWZ?=
 =?us-ascii?Q?u4mzzjdt0sieVtIlGiQl/V+98J8ATiukixJIudHuGHS4WQseICJdgbdHvxBH?=
 =?us-ascii?Q?Q2xgX14zfQjClTLu06FhVltxbPJGB1ukeJsZdrbBXFjeLnMSTlZ3nwtayiLq?=
 =?us-ascii?Q?fpYlypxdDfM0yjD4wjY6AHWbkjtfm+vBcELpZnkwSE6iQ+vPweMjJuvKQNeS?=
 =?us-ascii?Q?gvPYBbCmhDxHueU9afkv7LhkwfyUSNSNj9h0wYpebZx0nVW5nulgtojIFP1b?=
 =?us-ascii?Q?7sBSir86AaTVED0NsACmfGO3Y54o6HrueFt62lvgdilJ+txLuE1afdKh6aPx?=
 =?us-ascii?Q?wdEUWW8Ku/RgOrxs2rgAw1JzCCwg+UV75yB/JUriFhIHc7SzUuciCNBr9+Cv?=
 =?us-ascii?Q?Hq0UYQpqZ/dc5k5mrsbGS6NwYg0fjFQux6yi7hXYtINdzkCcW92h+SJzDfu2?=
 =?us-ascii?Q?i+ow5V2br1Z+YAQC0BKbcu6mKIVeSDNDkkfpERIsYALDaFQvcLcMsLM93QMe?=
 =?us-ascii?Q?wr4unqJJ5KmSsCU69KrRNwdWqTouXdJGQIDdulYqUuRCYvxJHLnVuTs6JrYq?=
 =?us-ascii?Q?iUsunxjmeJ52fzN/H+isGw8Ufdb54dfU9EkZVTZ9EdD+cFu4s8Nm6/at76Lf?=
 =?us-ascii?Q?+G1KLN73BD7X/s9aolS2BOIkXt800QG4SZdudUH/rHrEPzTSK5AN4jgYWxho?=
 =?us-ascii?Q?5L5PpLvowYRqhfdNulz7iVbi/yeuuKtXw2RX/cprgVaI/5//y3L/lVUFUnKf?=
 =?us-ascii?Q?kGL5cynuU38xEq/lYMzwAuqyYoL9AiFZ4UNZ7S2+/QoYTNM/T/pdr34C7M8Y?=
 =?us-ascii?Q?+SbHW4+5DZfxQ6tQfdl6l9Rrtyj8pxEBCQH6SKpe5qK563zgQDpDf0ZdnZUH?=
 =?us-ascii?Q?ivSXsxHsauoogBDqnY2fozNdJSL5QBM0VIuRjjCk1j4m1XHssycDH+2xu8EE?=
 =?us-ascii?Q?G4jd8Y7r2UoTjr39u9SUNUMGI20//Pq4wGMfPMRTFb1dian4xZNO/3k4DjYx?=
 =?us-ascii?Q?FXS2jmme6beiMP3ojwyC8FeKPxEAJ4AmcRviMsJToueR+drU0AezbqRuPiAN?=
 =?us-ascii?Q?x3L1P1ohc0APEdaEtwCGNy51RnyPkLC1rVOLeaSNowAyPaKwXvM7iP1y/ijd?=
 =?us-ascii?Q?ZKF0Da6AeGLdPGhWgNuSxM+YDmAYhMY5+HHiuQhaA5v9vyUPJz15XuP3ns09?=
 =?us-ascii?Q?caT97YXbWPjncgnAJxtFNKpHbkDUljHkQi1ElW3myqs4cjW+7BpAHEzSQL2o?=
 =?us-ascii?Q?mMpAeh6aEsavv/Q+E+C0B0NdfZJxjpG4NoWNHsCgi/j4yhonoSA2IZw2pP62?=
 =?us-ascii?Q?nwN3k7acb5s9/cHWD106KcnvRK1tU7+tolGnxTqiKc2y4eA1XdDsDiChZnC5?=
 =?us-ascii?Q?z6DSfx/BtptyvsctVWm7dbccZ4zlyJj2dUM5a7P+tE8KNhOAMSUwWOhzfJQ+?=
 =?us-ascii?Q?ulqAguX0bg3kBkN3SGHlopIllBYcQVWdPdL9ZNHz4BwpvbVwLb4oIYhJCJ4t?=
 =?us-ascii?Q?RK1raKpSa7GWp3vFWExZ76WOHBnPuvMnas4ywtS4FNV8/w/huqfbJl21yfGe?=
 =?us-ascii?Q?5DYVXhNxEJb2rS0/CgXLNmY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sSDmlguUVBwHFHQ2t7F75aW+BI/PFBK7aofQxXF6MPlSCnsADCUqu6Xa9pCG?=
 =?us-ascii?Q?zoUF1BCLyldlPC9ErD6ET+qGNJVIMiNRyP40MuExLc1wGfMW3Wp9+FIO6+Rt?=
 =?us-ascii?Q?7wLg+sJssP3aypVGYYmgtnLb18pVVD9GK5zFUS4qyHElVAxGCkSFdsIYvamb?=
 =?us-ascii?Q?iPhU+xLadKfpa+kE6YCrjSrcS3eo/N/8K3ZdFjKQJjAOVQOak4NlsdCqG9r0?=
 =?us-ascii?Q?viaJ1VqxmHfehzE/GxV3pHYW0LtvR5URrxihl78U4SxHmcrEsXvQYLog2PNU?=
 =?us-ascii?Q?VeBjboX3fcTjmxZDUh7XADbnCkEI9FnO6RdWgKZ35WqC9ggMKBCEEKVgK0IM?=
 =?us-ascii?Q?XuPkozxxZEZqXiZX2LO4vG5XVoHmli+uG9o+JWauKlDi/gIAXfYd5We6DdN/?=
 =?us-ascii?Q?f6s4G5YZU3W9gLT/DYdv3oTHtJT38WQR5iaia6iYcvbTJTdMmayH9Ke/BlJk?=
 =?us-ascii?Q?AGtLRwqT01DhpcZXAXnr2dqWGOcqttc7LNQX3VQeIg26XOp+WGU1UvUlF8bp?=
 =?us-ascii?Q?m4K0v+ou0vvX1qiiKuS6ls70rz7P136AomsJ6wxY1q+xuP+yFX1xD4dMsCMh?=
 =?us-ascii?Q?l1xFsM1QjcSJwqmJYX70+hfdMYfM6ypHvACIUUOkIB0t4I7U+HRs/VCbBagI?=
 =?us-ascii?Q?A3Z2WurPXUe60TiSmETyMQQTpv+89ushKz19vHDyXvhPDiyNMKQqhAbBf+zv?=
 =?us-ascii?Q?gcdCxbk7S4lY/SmYMcfUnz6YTOz6x18yWMFSWEJK/0xRu8cdSgW+shHaIHRP?=
 =?us-ascii?Q?b3y2t7oBQp3pFrLrOwfIu4xPSSNnA0zBDeicJaE3eOusNY7JxYXeAAD8RK1Q?=
 =?us-ascii?Q?EHl14oZlb21BQ33DKyQK1HNMTm7sQD+GiydCD0qyAis7DGAYvpcFpGSO9dKs?=
 =?us-ascii?Q?6E5SzdXtqKPkXRlHPXTAfUMa15TvY3bsUrx3yCs2D808D4+l38vvAvfd7MPH?=
 =?us-ascii?Q?+x9bM8KwMO8fs4E4RvoNoeyGdnBbVAns+n4WJXUReCBAPPYqy8r+2PrLSOcD?=
 =?us-ascii?Q?kkDDdWruZ9HKPI7G/W0RsvdWwT+NAfzuiL4wKkMkY2m2DUKUn73X2XN3RfP9?=
 =?us-ascii?Q?bdbJIK0tomFI5X77z+7drg2ylZ5uAi4G6Gb5WNtdNoxXOmB/1wwbjCVA+G2k?=
 =?us-ascii?Q?NsnXOiCIorpaE1/gJI9DlTXjV7m0WGsD58KQrOg4oI2SINe2vbrSbbidwZLU?=
 =?us-ascii?Q?Zt2M5xTdzbtARMoUkn+pHONQrfqqe61arvZ3zpnEoKmjoyYets/IHMht+dId?=
 =?us-ascii?Q?lIfufZPG6sSTTUwMFZjPFCUdsPDb2diU5S2uFR4GYvO+lyJIYVozT4NzM7nD?=
 =?us-ascii?Q?4lONcoN7m/14pg8UdfhNQTlMuXNPSxwnHTtrvKmveHSgpHqo9QPD/Bf2FmLV?=
 =?us-ascii?Q?jffWHdcJHd3HSK7pW2x+YGbjPxoDy/vdlA4lMigL4HYgAxixHyG1WiObrAd4?=
 =?us-ascii?Q?0Q2DuFSl4hWU0LuNHbW1mwrBBXIub/aw+01oMCtn/YxFjOldS+HDJc/ezvNW?=
 =?us-ascii?Q?XsOrvU4ifIMItMsrJzem4NGrBw/ckAkUSBJq8To6wiRpROGAkJ5aItr60oP2?=
 =?us-ascii?Q?AB4StkzA/9f1o15sfZFSktTEELxbgmUWzJksxWuaTpxnO4HaiGg4m5WJvpqX?=
 =?us-ascii?Q?XloAQPA+mg7UmZoVuAKPFcKQ5Tbtljddkboh17NTnW0/weL/RNXS0tV/9Dn3?=
 =?us-ascii?Q?G43TON5aH5vfWdOIvwjUMi2GeYGKzjZhoJlbES6LsugqV515j5a8XcG3hPXo?=
 =?us-ascii?Q?oH2BNvLIXg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec9a7d2-8135-4387-2579-08de73f4f0a4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 22:34:58.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1ZQN3C1wt35/OBTXZgAqVpbhwg159l5bjjiRh0uhRTXj3W6vm3LAjDxlalOE3uL4k7K/Z+GcI7NDmhgdGvJwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7076
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9042-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 1310018D9A3
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 02:22:46PM +0100, Alexander Gordeev wrote:
> Hi All,
>
> This is a custom tool that can be used to bring up DMA slave devices.
> It consists of a user-level utility and a companion device driver that
> communicate via IOCTL.
>
> The tool is likely need some polishing, but I would like first get some
> feedback to ensure there is interest.
>
> I also tested it only on x86 and have little idea on how channel names
> on other architectures look like. That could especially impact the way
> dma_request_channel() treats user-provided target DMA channel names, as
> exposed via /sys/class/dma.

I am not sure if it can work for general dma engine because it slave setting
is tight coupling with FIFO settings and timing, some periphal require
start dma firstly, then enable DMA. some perphial require enable DMA first
then queue dma transfer.

burst len is also related with FIFO 's watermark settings.

Frank

>
> Thanks!
>
> Alexander Gordeev (2):
>   dmaengine/dma-slave: DMA slave device xfer passthrough driver
>   tools/dma-slave: DMA slave device transfer utility
>
>  drivers/dma/Kconfig            |   7 +
>  drivers/dma/Makefile           |   1 +
>  drivers/dma/dma-slave.c        | 246 +++++++++++++++++++++++++
>  include/uapi/linux/dma-slave.h |  30 +++
>  tools/Makefile                 |  11 +-
>  tools/dma/Makefile             |  20 ++
>  tools/dma/dma-slave.c          | 321 +++++++++++++++++++++++++++++++++
>  7 files changed, 631 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/dma/dma-slave.c
>  create mode 100644 include/uapi/linux/dma-slave.h
>  create mode 100644 tools/dma/Makefile
>  create mode 100644 tools/dma/dma-slave.c
>
> --
> 2.51.0
>

