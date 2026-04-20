Return-Path: <dmaengine+bounces-10046-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAJQLJbo5WlkpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10046-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:49:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BA84286EB
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05AE330E5D73
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A3388E55;
	Mon, 20 Apr 2026 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kTT3GhAI"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9940DFC4;
	Mon, 20 Apr 2026 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674473; cv=fail; b=b8LVwEfY3BsvhGdVfvaCKQTt7g268WQb6btZmZoAdOII+Q63XxTXOvPzCUIWIIhGyoZtfOGj4Sqy0pTvTBSjzdQJPokgLlfDbpbOQq0ugebtsfdZqwagYYl/rZtIIk2u95NrZlBiF0yg1fgrLHTTzxu44ky2/CfKnwRGC2vj/8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674473; c=relaxed/simple;
	bh=KCFd3yZwEkyoQQAl1Ii7F4oVHFuOKlnyyIgCLyR+QEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ks5V10nA9fDq2egr9lauDGoZ0M5Yfbv24acXtsubG2VZWOPvWaS1lsScRIi1EhTGWwcgvpBvi39yiQct/M9Ce/MI+SR4XgELNr5awo/HTN2Ubj8aOtHwo9UPBSMrEVLsujA2D/ziZpSSJeFwIe/qnf3EYgBvlnTHiHdMEqKGzPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kTT3GhAI; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAv8+vrkSNJ1z+lYtGwRIQQdheqmUM9eRLYKdF5605WBaLmBNlwEWChnKoDh7lfX70/XhKS/+/B1ZuGhd0jWV9AAm13f+oU0UuSWLghx5j80uqU0f+jVuyquaJL4tsjzo9AfSBq1U1Ykg79xau7aICwsLUH1oaL89bjJ236LDcCeCYIVErp2KP80ix5hdeEEGwrhsmDTUwXLqSMt99xM7Zhgz81WIJVkyR/b61Qg3Nx8t+Mg3plZdaiOksbpku5uz6bqMdpPlkCTNTdtv9iQMUq+epVgKi9ZGE2JpxX45APPDu0nMu2mUVza4wzzAJQebKMD78J/00WTz5BylR49Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESyJrfs8N8/S+p5KiwvZebLqn8elj33SFUq8uG8+uoM=;
 b=PIKo55iz51hPGNX4dnKhIEmBcwHNA3l5LTQwtOq9QweBRIv2Gd+SodBjxAJy/ieZs/UsXsvuqxum3dB9NIk5SbBfNZbbufMHlL+cmGwVWFuTedfywV4h18GFIWQW+pTlQ5JMMAFl4ouJ9FMZ+vnf2ip+kKt0VH6KKTY5fwO6d9LnwP/+YOAbN9scvXpThhyH2XQaSqdbcjYYTNC13IpgJ69FMbtN96uLkkF/cuZGzHQehLPUdU4a39GOyskfBjkZpa3cLgb3aA3fVDk/mQmpyq2rWtpvOUwKmmayJ04IbLECHoc6k6y72LX+14FGW9CZ+cPl4To+rMFIuDeEZJLz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESyJrfs8N8/S+p5KiwvZebLqn8elj33SFUq8uG8+uoM=;
 b=kTT3GhAIavDl2/83YeLiL6NTAVEtzSN9zrwV/bElg2bvoM48Im0iByvlfJtqJUsALl8vNsn1oS7O8Xqh9Ru0mgNIy04ZjYS8VRNwTCnAuWhTJ/fYp62gbyOVvtSAYGKi1yyKvMD8HxkKG4HRTXuy+K/vjlEpsgrfh9lQj/92ZcEq7/KK9cDEEP7y8OF7ItyA61vorme7vbDM/1bD4F698kA0NCCzroHX1Mmyq329g/yn9h9E8P/iUATxp7eBdPD+vD4UEhB/bgpagH1Myf8S65bQX/KaQ9QLcerYKq3/Io9R0MM2wdsJVOdMq+K2xjFtSTLRuUHyzZJi37VTYvrkfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8192.eurprd04.prod.outlook.com (2603:10a6:102:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:41:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:41:06 +0000
Date: Mon, 20 Apr 2026 04:40:59 -0400
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
Subject: Re: [PATCH 16/23] dmaengine: sdxi: Generic descriptor manipulation
 helpers
Message-ID: <aeXmm7W6SD4YGDXQ@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-16-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-16-1d184cb5c60a@amd.com>
X-ClientProxiedBy: PH7PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:510:23d::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ad9a32-a2bb-4433-3142-08de9eb8906c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|1800799024|376014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	j7hU/NETv+jJFJFQ2gVxc4C44w7uAhRy0TbvqIkmgX0y6t+LgmtiwDzck8VGq7PsdJQQb+eAPk9NAcJuwhBvzxXo8zN7Qxg4cpDFzWJT1pCjZumKCc8W8w/wkEu0p/CMkztara26YzPOtv5mMcdHCIBPcagoElHY8DsyZ73AGf7Ok7gXCh7Yq5yK5Z035xeh7R1HO+/+SMHxQ8o853pfQNlilwz/SUugH6q40nDU24pvtHzlF0rvDjIMmeWoH9EesvJH1Yo8JYG4MwijLQg1huyxFVSWDdVePtz3uzIs586wczMqkgyckoDPJPRJ0LEDkZrKAJL/fkg7WBTYuHNNR5VaQQVsuhqba3Aqms22dYE/HMgMMEm8Co59fWVOMGpvaxCBvqFk+f48nLzBB5Basmn7Wj229wCrIVc1CN15jjV1afDj3RDp/eXnbX6wNrdRUVjQSwxlVsnuspD6iORy8pCcJzq/3OyhxmJxp9/Ln/0xy7nhzqukrEUIgVSliIuXCpZlJouYbWOC+GgJc+nMm286ye1hDj63rsxMBP6uYDiIou+K2H826Pp5sqiu/tH9rADCMGhcv4QF5Rytdo3uxbEp2lI9JKragtzYgI1MsWWknOFw+iRj196DU0rU4UFqkOgRYvI/BbFze9I8PWiWRyqwhuvGduChaOSEPZvN3weCJWCm00O2+XGKP74jMswFQW1p556gFTgAuc9Zkwc9+bPeKlMGOZGy3rKKP+zslPrSmvojmz4z48D7JB1TJuhEEcOsEwT2F/nmXp17LR6wM2qm2r2nNg1RR7sFCU0/KhA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vB2VriAZi0aWFczOpXrjueIt+58NHx2NA87gwwiJjRS9g8p/wy+skyFQhxvU?=
 =?us-ascii?Q?BOlzhydXho7HFjlEP7AicE9fdLXzv7ZoTlv3durX2/XmukpO/9IITCL85amC?=
 =?us-ascii?Q?VfSRjGuFOx/G7RxgmgtkLb8MCuUee66stY7FnORF2gm6jJVasWGGEGDwDD4m?=
 =?us-ascii?Q?ZeBWfak2XdVmOv3asJvhiZwX+NgGTcLqHkZjNaaquAfm0XMCXJJBMsO2HzBx?=
 =?us-ascii?Q?rNVodpxG8pkDzhvxAUkulb65OE0FIB4pFDa0Bik22husPfwMYsmGM7h8fSXZ?=
 =?us-ascii?Q?uUkzN9kAhQHilHWPYlmnIB3P4w8TkEbw90myTprsuDUp12kQorUhcaQZgqaS?=
 =?us-ascii?Q?GVls7q38X2mbcFTO8CTVaxGUUv/TdYpTeMlLCoVZzDpQvC4Sn1vKum+/nrqc?=
 =?us-ascii?Q?Q8ChvWvkeRWJ9ztaK5c3BDvTHCtES5zXfQk3RWQjjec1axDjQGL8d80Hkw1A?=
 =?us-ascii?Q?iMuEpYw6ZIFkgqIOKFeI31Xytv5MzO3vJRCm86upHNIkfxB5W8fzLKfEf+wB?=
 =?us-ascii?Q?spLSg9j4HEG8tcsNtSKOW8X7+oqzkG4aul+zdclUFdWU2ns5OtIhbXiFqPav?=
 =?us-ascii?Q?XxrNuQp+v5CIjndL4U46daxRESQsCMTIHrmtLQxgawPvv8ZHTSZUKaMVOkt3?=
 =?us-ascii?Q?qZM/P4fj/rc8OO7SGcyKIQ9ba0t8XXDQcMhaVBWEoDMOWRJYB6m46my4/hiA?=
 =?us-ascii?Q?hGloTPIQTxArglBg/+wbod1VVghVXmWkpGiSMXwbytXH1Rb6/QCBAezS0naj?=
 =?us-ascii?Q?o9myOGrpuMswjuUQigUspMyGGjUlP28F5UCQJnFhTA+f+hpRwvJ3YRuLbUcz?=
 =?us-ascii?Q?pSeoz0jKboDP5KWKFM7xt4+EVKAskVon8M01kIQbFwMspPmORaxfhk6xjRvd?=
 =?us-ascii?Q?UMMx3PBnHwcL9hf6uzMvYLJjBjyhGn0/+WUwZzuwc6Yc/9uejRs14R9nHqws?=
 =?us-ascii?Q?9s8k6Kwg5VzspzBJAD4oCuCxrOyxFqremOgQgyyUf3lsCzmgh8WnBjBNKyzz?=
 =?us-ascii?Q?vy5UT8XdYws2FDS1LFiuIJjaYWswksUAleSeY+o1nqURvi/phDBiPDDPdkl0?=
 =?us-ascii?Q?vI+ge9OiSqrO4G9R6zQawl9jFkytbEnZrAZbiNSnVavAFxi/FCJgcMPz5HzX?=
 =?us-ascii?Q?hJzYI2zCDwGKsp2cKk0lJwAquoojOEiklgdP+mbHlGiROEDl4miljUOlX7jL?=
 =?us-ascii?Q?xPVpEdX2GNCfbJSHr+si8BMpT2GTtVTZpKapAmJQ9rHiUolRwOl2dkQUbDFe?=
 =?us-ascii?Q?4NCuKB67VsI36OhhOfe4G7HOSPpUAxUhSad4aZ3HzoImAjGwmg/7kyKkWchK?=
 =?us-ascii?Q?j4Y5VMrSBzKKuraB5yNReq7bM1YNQ3OLnHo762i3fV1yCvSFcHBJ3etA3nt+?=
 =?us-ascii?Q?rhCOtY1EsXbMApKKoNssUf5q5BQdZb6e6fxH8aCxxOZz5zePDSqfaL/lio0U?=
 =?us-ascii?Q?K1VNYFjs0g11yXycxCEUXuCyqyEY1yOpo0ZUKZmqVHj+FuXI5ysReIeEB2uM?=
 =?us-ascii?Q?URBuujxR2I6eHMH/lUKram2UtYIH9SFO98m7WOXXzyh8uTGJjYannBM1lCR8?=
 =?us-ascii?Q?dbTkBKWB0eNkRBtO8QNoGIL1ahds47ckhCo2i/dK+xk7Ov+R+eDfU2yYUPJj?=
 =?us-ascii?Q?ikfwHdfBJLG8MFB0ZIMvV5VDOOCh3GCSe0p9WR1jrmL9rpi/R827KvHqIyh2?=
 =?us-ascii?Q?tNcGqfQPrNI5xE6qPbA1FGIq9W0YGHwzUyCzWSNEp/x27Rs9n+99K1RHnE9y?=
 =?us-ascii?Q?mqjG5JHzbw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ad9a32-a2bb-4433-3142-08de9eb8906c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:41:06.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: capD2mNDUDCPJiRQUNqEI8J9WSg68xoavmI4DoDC0mqvjqjtAguZs0QOZEYQmtxuiUqNEl67OF/DmyJio6IrVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8192
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10046-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,amd.com:email]
X-Rspamd-Queue-Id: 50BA84286EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:26AM -0500, Nathan Lynch wrote:
> Introduce small helper functions for manipulating certain common
> properties of descriptors after their operation-specific encoding has
> been performed but before they are submitted.
>
> sdxi_desc_set_csb() associates an optional completion status block
> with a descriptor.
>
> sdxi_desc_set_fence() forces retirement of any prior descriptors in
> the ring before the target descriptor is executed. This is useful for
> interrupt descriptors that signal the completion of an operation.
>
> sdxi_desc_set_sequential() ensures that all writes from prior
> descriptor operations in the same context are made globally visible
> prior to making writes from the target descriptor globally visible.
>
> sdxi_desc_make_valid() sets the descriptor validity bit, transferring
> ownership of the descriptor from software to the SDXI
> implementation. (The implementation is allowed to execute the
> descriptor at this point, but the caller is still obligated to push
> the doorbell to ensure execution occurs.)
>
> Each of the preceding functions will warn if invoked on a descriptor
> that has already been released to the SDXI implementation (i.e. had
> its validity bit set).
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/descriptor.h | 64 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/hw.h         |  9 ++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
> new file mode 100644
> index 000000000000..c0f01b1be726
> --- /dev/null
> +++ b/drivers/dma/sdxi/descriptor.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef DMA_SDXI_DESCRIPTOR_H
> +#define DMA_SDXI_DESCRIPTOR_H
> +
> +/*
> + * Facilities for encoding SDXI descriptors.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/ratelimit.h>
> +#include <linux/types.h>
> +#include <asm/byteorder.h>
> +
> +#include "hw.h"
> +
> +static inline void sdxi_desc_vl_expect(const struct sdxi_desc *desc, bool expected)
> +{
> +	u8 vl = FIELD_GET(SDXI_DSC_VL, le32_to_cpu(desc->opcode));
> +
> +	WARN_RATELIMIT(vl != expected, "expected vl=%u but got %u\n", expected, vl);
> +}
> +
> +static inline void sdxi_desc_set_csb(struct sdxi_desc *desc, dma_addr_t addr)
> +{
> +	sdxi_desc_vl_expect(desc, 0);
> +	desc->csb_ptr = cpu_to_le64(FIELD_PREP(SDXI_DSC_CSB_PTR, addr >> 5));
> +}
> +
> +static inline void sdxi_desc_make_valid(struct sdxi_desc *desc)
> +{
> +	u32 opcode = le32_to_cpu(desc->opcode);
> +
> +	sdxi_desc_vl_expect(desc, 0);
> +	FIELD_MODIFY(SDXI_DSC_VL, &opcode, 1);
> +	/*
> +	 * Once vl is set, no more modifications to the descriptor
> +	 * payload are allowed. Ensure the vl update is ordered after
> +	 * all other initialization of the descriptor.
> +	 */
> +	dma_wmb();
> +	WRITE_ONCE(desc->opcode, cpu_to_le32(opcode));
> +}
> +
> +static inline void sdxi_desc_set_fence(struct sdxi_desc *desc)
> +{
> +	u32 opcode = le32_to_cpu(desc->opcode);
> +
> +	sdxi_desc_vl_expect(desc, 0);
> +	FIELD_MODIFY(SDXI_DSC_FE, &opcode, 1);
> +	desc->opcode = cpu_to_le32(opcode);
> +}
> +
> +static inline void sdxi_desc_set_sequential(struct sdxi_desc *desc)
> +{
> +	u32 opcode = le32_to_cpu(desc->opcode);
> +
> +	sdxi_desc_vl_expect(desc, 0);
> +	FIELD_MODIFY(SDXI_DSC_SE, &opcode, 1);
> +	desc->opcode = cpu_to_le32(opcode);
> +}
> +
> +#endif /* DMA_SDXI_DESCRIPTOR_H */
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index 46424376f26f..cb1bed2f83f2 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h
> @@ -140,6 +140,15 @@ struct sdxi_desc {
>  			__u8 operation[52];
>  			__le64 csb_ptr;
>  		);
> +
> +/* For opcode field */
> +#define SDXI_DSC_VL  BIT(0)
> +#define SDXI_DSC_SE  BIT(1)
> +#define SDXI_DSC_FE  BIT(2)
> +
> +/* For csb_ptr field */
> +#define SDXI_DSC_CSB_PTR GENMASK_ULL(63, 5)
> +
>  	};
>  } __packed;
>  static_assert(sizeof(struct sdxi_desc) == 64);
>
> --
> 2.53.0
>

