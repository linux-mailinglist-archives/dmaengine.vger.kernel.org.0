Return-Path: <dmaengine+bounces-10050-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFO2BY/q5WnxpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10050-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:57:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E27142891E
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 845F3307DA4F
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FCD38AC83;
	Mon, 20 Apr 2026 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QwLmZy5c"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F41438B149;
	Mon, 20 Apr 2026 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675133; cv=fail; b=ePgMDodKb2M0amHHg0iBWqXRITYELCrs7TpF8M5AOPSzeMS4V8lzznqkSN6SFtA1Q7cS7nZ9hj8riIu76mpbZN9qH5lm4qNTVtWCDy9UHCUfJ/ZyrLLvH82/4soylMq1PraxyI7GWvhXHuWT48gRajA8LarmTaZ4NCadzPzjxlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675133; c=relaxed/simple;
	bh=bPzKSZJHNwhI3V++2mlmhlx4xvROuF+JrVq/7XdFkjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BdsCRXCiK1+xHDcCYqJIk/ugEVXaf8eWvtbkejyjftZeg57rd2SN8ZXX61P7pke+5F6g0hz4NyibPTHlQvW8zCiBT3dcbxhAGM/TFo8c55c1EVh//tjZnICn3DyW0ceWEEGw2y+DlehdCw7BAmHbAZH+8mklLC9iTq8CIqyNmvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QwLmZy5c; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oENTYAT2DkLYGalqFD99kDb/grcT/72IplJ2DT4lCuy4jh+FO0YIcnYE5Lslg7jzJigih35qxwxP9a1c4lNHRHwpHsLBq4h2ZPfmZRMX3EGKg7glovfIyi9qDS+04Nx4fdL4L/QM2x01o5a9lFZczsP409E6kde+dKdMVgIjDE395xoeQcNVE5MMMSAFLuBir/eR72RqJqsQZUdZDX5e1Iu06CVNgruz5DY7QabHsrbOtS4WDQwLjyllSRKQhg3QWxubZnWMTWN6mKd/DcBCXVWtZUAV+MUASNyPpn7oUzolKwrk6VXIzancxwbrLMq4Ghvg1dpyskcgk67Fn3vaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUCBJGvngyb6vj4Z9SEFW81imzOqxL79TSFHSuP+8Ls=;
 b=qnUIeoTzuUKwnZZzhSRVyaus3mnT5arIOYBNhLFGDqX9YoW5Oou5Qk22omR6WTaahho8AIVnzuw1yXtU0tUXhoPcoVn34ACyTHP5mdiVnPO0GxSLSVhffh3fBENLTsxDIsVIsGQ0Rvo8zt4WwrgtMlwmUpjGlHmubGzWQmh9xaQFG/ynpcXXgi0jB79oio1RkcFvSo/xREm4XIH6+e8j4NNhFqYu8fxNA0WhGe98JEXl6rDACwDONVovz7uEh0jKoxcjhWERNV9QlJ8gViWhjpWQhqoT7LCmZvS08FKEqDi4EDbV+IxzG4ZOF4OZwWenSaWxLW09fX+uSYAwTO12zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUCBJGvngyb6vj4Z9SEFW81imzOqxL79TSFHSuP+8Ls=;
 b=QwLmZy5cMpqHEmosMdgK5hmoST/Ja5TUKdYK5l2NSrnFE92Lo9mw9hAJh3zn8vMPEBV8+S7r00XGCVM+o25BRlIzJNlqXTC651Man8b10U3XgShL5G7427huKFsZTOwu3Y1I1Nvl/J30gx+2rPKnvbGQC+AEBWq+bG5KLReINkMY8k60XM+xhaJt314V3G5fKOZ4bADoLWRmffTHkZCSycgScueDpDNdXvcTZK1gP7PhNpzuVc5BPI/b5zGxzywIFJMGSX1+p58IrrhphbQ8t50DhMm3AwUVExEnQyD8MBHNdJ6/kSYEz+lIIsVk/ammppBEq7/8RXPeOuqyXqOZtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB8267.eurprd04.prod.outlook.com (2603:10a6:10:24b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:52:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:52:06 +0000
Date: Mon, 20 Apr 2026 04:52:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com, John.Kariuki@amd.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 20/23] dmaengine: sdxi: Encode nop, copy, and interrupt
 descriptors
Message-ID: <aeXpMDSdukX4pE85@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-20-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-20-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SA0PR11CA0204.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c9e9f3-b72a-40f6-c18c-08de9eba1979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|7416014|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I77+DcAYUeWG6btiV6tUAXh4txYURA3AAblSursBeKjAmZ/7TlEB6rESt4Mot9dsp0aPBorxYye8/0j1cEIlJfAGpGRVl1Mk8iyhGo3+3WwnC7WQNHGlXKypDjz2sLDyXYJrK2zDAcDiYXLxnxa0Yh9DqfTAd8nmUvc2na0IHBbBGFRfpBfPATQOpJev/natMm/TBXFBSfmxSKIuOOrYdz7W9WbdmSw7gqPekPD5JhyTydP/Ck2io2IveNcgiYYfOyPI8jZV/EHsWH/dlEz+zwmFVo57Tjwu30iUra9Jt5E7fViYwkezptzG6iuP2vU2QSPX58hlZ0UHIaD500c6f3nPk0MkyAWtlLeeB27kgcBS4fDGzYsLELT7AFoPYT7E8BrAyr721Yq9dKyXfWLAXgXmjoDxwnC+rmueDS7Py/+Sqkl0XeeaVtqdqBOr8O3sZSH56ykQlgvkQ0s/lgZvwyS2KNWVWQTZpcuxWcNTTM9ETIRgR9IC8osgvV6o+eKBfF0knMXyGxkdfWT7c+FkLAgaW0+aoGRfwiXQ362JvOaBhzw7FxEsrhb8o49otFCnSLCEJoS9o8eWtXgp4dVBBf2BcsaUdhlYkaKejjHXO6V24uAbl3zGIYlv4pEDMLlsNrgRgoTWBfXaUNww3yymXWca39T1IC9/p+MJfiMAc4/YJC8XCQhaiRugSDBtZCf9XUkLtC3NQnv6312LZtPpVa06Zlqqsy0nGsWUrglU2UXu9dpXMEjozVfN24CAkH9+PAz8zrIqffLo86WjF6AIaWxMwhbzSWVMWqQwfIH9Eyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y/lX4pLARUhoaG5fBjzj7RSoCibNE6tXrI3KVgS3sqd8+bvyWihUE77KfrbS?=
 =?us-ascii?Q?0TigfOCX7mr57iJHkkLXVuAddSY457Q2jLSZKo39APMXhFXq6IlJM1XUKd20?=
 =?us-ascii?Q?FMug+9g/4SadqR0oiWTD0+UzrPsCuFletUfJK/uow0my5ZH7VHx52zDdlz6d?=
 =?us-ascii?Q?ebrYmdn0plai+GNhW6kufvlbPxtn7MVIV0oaQbYLhsmHQPgJAwphFES6hyde?=
 =?us-ascii?Q?vpLMnp2cVKweAjMGBSqnZzRbArHmrqq9WycF31b7QMvOnBZnfXBJcJ381M9H?=
 =?us-ascii?Q?gPyPQggCrhQrgEhBQaDRk9SxazzIpI+j2qzHL2qGHxSaNZHIr/QEdgWCY7V+?=
 =?us-ascii?Q?e1XuqYhLO9HSzxAq8CZuTq8dqYOrJ97CnRS6eMz7m4zRX4v9jLcUZamIbqSY?=
 =?us-ascii?Q?vctvBh6Lucz2jVvghg5GEC0L5rw+C8yFkDjSaCCq03lYzC/w21rmUZtEZWrD?=
 =?us-ascii?Q?wbjDzdwSlrY0jH/QCu5bmXv+y1cfKKGyYx3EcW6/dZ9hOEBk2mRt0tLLSeps?=
 =?us-ascii?Q?GUeb5Xz3/YFY4t770I8KARTSSkqj06s0pPg5lOzRWHXrlSwPCsMXjALqVESE?=
 =?us-ascii?Q?veztgP5b1Rb7Cz3q6ZqwdcqeHzT+IjlLlg3OMnbHGu2FaYYBJnZ5YYSlop0Z?=
 =?us-ascii?Q?qcQI5CKKUuq+UUPZ9Oa6Pat1UWwP+3XMLunYDDY19Mk2GV1gnJaB//WJCrcx?=
 =?us-ascii?Q?gtcEBGc/b6lylDJY6mboHZPQIv2Rn99fZC3RWq1ld3OjnGruqupEiJ1w21iH?=
 =?us-ascii?Q?Z8QKyNrBC139tNFO6i0SnJXga+Dm+MuYjnoWbT0txFA8DR2BgrLeoiwYIhFQ?=
 =?us-ascii?Q?GiSwFQtqc5JkaUuNUuqOtlI0FabrZovgec6zhOHLG7AKdNkKibn2aVlBDvIO?=
 =?us-ascii?Q?iogSUK5YBzHIEUkjOxLn1rHeaBnkya8Vv0lUWdd+m16mBgWxUHJfLnBY5u9K?=
 =?us-ascii?Q?aa+Yj9zlhAJtQNJdAt6U25GwC9Sjn4b0WG5H1/iga0EDcuu2OftlYe0Ppw/V?=
 =?us-ascii?Q?aqjS/86CSLBSyN7DcVxUYLmpMftWmBuYlMPTWAOwFcGaTwAFhSXvQu+1aHYw?=
 =?us-ascii?Q?oaAfXnNhl/nuKl9HxzfTSU1zikzPclLHmU/QplMOG1O7amRUifz6lJ1APdcw?=
 =?us-ascii?Q?SATx7WHk4fCqILcEfBoYsAVLTHK1TmOYiEy0mSGULAAIUEtzbHO6gko99AJB?=
 =?us-ascii?Q?zrPWKtzY5XqvNN8GKMGprrRuHJb/Aiw31St24WC36j2efvk05xNNpH/W2fR/?=
 =?us-ascii?Q?duB1bi2SDKJMHUL8I5c5mgboW5K5VLAtpe5zDvmNvJhbnNOmO2a5xAE9c4es?=
 =?us-ascii?Q?KpZVLMNVkf/6206sxE7Fuc+TB22TviXTeIVrjBBL4fTc5XZh+aAaqYzBLeM6?=
 =?us-ascii?Q?QsF38RzeiVmOOpIYHhaIYx+voxnQ8q8vZPudZZlGIdkqOuX9SGkdErtVFTgM?=
 =?us-ascii?Q?w7/Lsic0UypqgM3AXf6fe1JSlM0a0h3NOzWydqjJuYH+ezvuwCh+oCBJbDPG?=
 =?us-ascii?Q?6kYYlr0JoQ9HGJB+6qrbFGnfXSzrk3ZTEBEoPNqwlkKVXYFljz2VUBqPKHbe?=
 =?us-ascii?Q?m3SErG7DPZ5g5w7HeHIqGUCooCR01iPtSDho5vzQdVMWKD87rteBQ0bM5QUb?=
 =?us-ascii?Q?QHabw53RY2/3gnvLWQmcQPXK0ByB/qGEP5tS5C3SLBL8lw8m45nUXK3bNSPM?=
 =?us-ascii?Q?rN1nzIIBuAfX6TY0/LcwkGLtBAcTE9kdS3rCzntFI7x59H2N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c9e9f3-b72a-40f6-c18c-08de9eba1979
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:52:06.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzQB9HBFBbb/l0OknEXkQlKVUIXbipGhOgoSk/LPqQ4wnxbx6128FGHbUTpzNiseKhfRQnEofIfUqs0DiQS+BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8267
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10050-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E27142891E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:30AM -0500, Nathan Lynch wrote:
> Introduce low-level support for serializing three operation types to
> the descriptor ring of a client context: nop, copy, and interrupt.
> As with the administrative descriptor support introduced earlier, each
> operation has its own distinct type that overlays the generic struct
> sdxi_desc, along with a dedicated encoder function that accepts an
> operation-specific parameter struct.
>
> Copy descriptors are used to implement memcpy offload for the DMA
> engine provider, and interrupt descriptors are used to signal the
> completion of preceding descriptors in the ring. Nops can be used in
> error paths where a ring reservation has been obtained and the caller
> needs to submit valid descriptors before returning.
>
> Conditionally expose sdxi_encode_size32() for unit testing.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/descriptor.c | 107 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/descriptor.h |  25 ++++++++++
>  drivers/dma/sdxi/hw.h         |  33 +++++++++++++
>  3 files changed, 165 insertions(+)
>
> diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
> index be2a9244ce19..41019e747528 100644
> --- a/drivers/dma/sdxi/descriptor.c
> +++ b/drivers/dma/sdxi/descriptor.c
> @@ -7,12 +7,119 @@
>
>  #include <kunit/visibility.h>
>  #include <linux/bitfield.h>
> +#include <linux/bug.h>
> +#include <linux/range.h>
> +#include <linux/sizes.h>
>  #include <linux/types.h>
>  #include <asm/byteorder.h>
>
>  #include "hw.h"
>  #include "descriptor.h"
>
> +VISIBLE_IF_KUNIT int __must_check sdxi_encode_size32(u64 size, __le32 *dest)
> +{
> +	/*
> +	 * sizes are encoded as value - 1:
> +	 * value    encoding
> +	 *     1           0
> +	 *     2           1
> +	 *   ...
> +	 *    4G  0xffffffff
> +	 */
> +	if (WARN_ON_ONCE(size > SZ_4G) ||
> +	    WARN_ON_ONCE(size == 0))
> +		return -EINVAL;
> +	size = clamp_val(size, 1, SZ_4G);
> +	*dest = cpu_to_le32((u32)(size - 1));
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_size32);
> +
> +void sdxi_serialize_nop(struct sdxi_desc *desc)
> +{
> +	u32 opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_NOP) |
> +		      FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_DMAB));
> +	u64 csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.nop = (typeof(desc->nop)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +}
> +
> +int sdxi_encode_copy(struct sdxi_desc *desc, const struct sdxi_copy *params)
> +{
> +	u64 csb_ptr;
> +	u32 opcode;
> +	__le32 size;
> +	int err;
> +
> +	err = sdxi_encode_size32(params->len, &size);
> +	if (err)
> +		return err;
> +	/*
> +	 * Reject overlapping src and dst. "Software ... shall not
> +	 * overlap the source buffer, destination buffer, Atomic
> +	 * Return Data, or completion status block." - SDXI 1.0 5.6
> +	 * Memory Consistency Model
> +	 */
> +	if (range_overlaps(&(const struct range) {
> +				   .start = params->src,
> +				   .end   = params->src + params->len - 1,
> +			   },
> +			   &(const struct range) {
> +				   .start = params->dst,
> +				   .end   = params->dst + params->len - 1,
> +			   }))
> +		return -EINVAL;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_COPY) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_DMAB));
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.copy = (typeof(desc->copy)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.size = size,
> +			.akey0 = cpu_to_le16(params->src_akey),
> +			.akey1 = cpu_to_le16(params->dst_akey),
> +			.addr0 = cpu_to_le64(params->src),
> +			.addr1 = cpu_to_le64(params->dst),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_copy);
> +
> +int sdxi_encode_intr(struct sdxi_desc *desc,
> +		     const struct sdxi_intr *params)
> +{
> +	u64 csb_ptr;
> +	u32 opcode;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_INTR) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_INTR));
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.intr = (typeof(desc->intr)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.akey = cpu_to_le16(params->akey),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_intr);
> +
>  int sdxi_encode_cxt_start(struct sdxi_desc *desc,
>  			  const struct sdxi_cxt_start *params)
>  {
> diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
> index 5b8fd7cbaa03..14f92c8dea1d 100644
> --- a/drivers/dma/sdxi/descriptor.h
> +++ b/drivers/dma/sdxi/descriptor.h
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/bitfield.h>
> +#include <linux/kconfig.h>
>  #include <linux/minmax.h>
>  #include <linux/ratelimit.h>
>  #include <linux/types.h>
> @@ -16,6 +17,10 @@
>
>  #include "hw.h"
>
> +#if IS_ENABLED(CONFIG_KUNIT)
> +int __must_check sdxi_encode_size32(u64 size, __le32 *dest);
> +#endif
> +
>  static inline void sdxi_desc_vl_expect(const struct sdxi_desc *desc, bool expected)
>  {
>  	u8 vl = FIELD_GET(SDXI_DSC_VL, le32_to_cpu(desc->opcode));
> @@ -80,6 +85,26 @@ static inline struct sdxi_cxt_range sdxi_cxt_range_single(u16 nr)
>  	return sdxi_cxt_range(nr, nr);
>  }
>
> +void sdxi_serialize_nop(struct sdxi_desc *desc);
> +
> +struct sdxi_copy {
> +	dma_addr_t src;
> +	dma_addr_t dst;
> +	u64 len;
> +	u16 src_akey;
> +	u16 dst_akey;
> +};
> +
> +int sdxi_encode_copy(struct sdxi_desc *desc,
> +		     const struct sdxi_copy *params);
> +
> +struct sdxi_intr {
> +	u16 akey;
> +};
> +
> +int sdxi_encode_intr(struct sdxi_desc *desc,
> +		     const struct sdxi_intr *params);
> +
>  struct sdxi_cxt_start {
>  	struct sdxi_cxt_range range;
>  };
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index 4dcd0a3ff0fd..11d88cfc8819 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h
> @@ -164,6 +164,30 @@ struct sdxi_desc {
>  	static_assert(offsetof(struct tag_, csb_ptr) ==			\
>  		      offsetof(struct sdxi_dsc_generic, csb_ptr))
>
> +		/* SDXI 1.0 Table 6-6: DSC_DMAB_NOP Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_dmab_nop, nop,
> +			__u8 rsvd_0[52];
> +		);
> +
> +		/* SDXI 1.0 Table 6-8: DSC_DMAB_COPY Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_dmab_copy, copy,
> +			__le32 size;
> +			__u8 attr;
> +			__u8 rsvd_0[3];
> +			__le16 akey0;
> +			__le16 akey1;
> +			__le64 addr0;
> +			__le64 addr1;
> +			__u8 rsvd_1[24];
> +		);
> +
> +		/* SDXI 1.0 Table 6-12: DSC_INTR Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_intr, intr,
> +			__u8 rsvd_0[8];
> +			__le16 akey;
> +			__u8 rsvd_1[42];
> +		);
> +
>  		/* SDXI 1.0 Table 6-14: DSC_CXT_START Descriptor Format */
>  		define_sdxi_dsc(sdxi_dsc_cxt_start, cxt_start,
>  			__u8 rsvd_0;
> @@ -207,11 +231,20 @@ static_assert(sizeof(struct sdxi_desc) == 64);
>
>  /* SDXI 1.0 Table 6-1: SDXI Operation Groups */
>  enum sdxi_dsc_type {
> +	SDXI_DSC_OP_TYPE_DMAB    = 0x001,
>  	SDXI_DSC_OP_TYPE_ADMIN   = 0x002,
> +	SDXI_DSC_OP_TYPE_INTR    = 0x004,
>  };
>
>  /* SDXI 1.0 Table 6-2: SDXI Operation Groups, Types, and Subtypes */
>  enum sdxi_dsc_subtype {
> +	/* DMA Base */
> +	SDXI_DSC_OP_SUBTYPE_NOP     = 0x01,
> +	SDXI_DSC_OP_SUBTYPE_COPY    = 0x03,
> +
> +	/* Interrupt */
> +	SDXI_DSC_OP_SUBTYPE_INTR = 0x00,
> +
>  	/* Administrative */
>  	SDXI_DSC_OP_SUBTYPE_CXT_START_NM = 0x03,
>  	SDXI_DSC_OP_SUBTYPE_CXT_STOP     = 0x04,
>
> --
> 2.53.0
>

