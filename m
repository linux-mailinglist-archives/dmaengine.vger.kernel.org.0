Return-Path: <dmaengine+bounces-10047-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MeMDJw3p5WnxpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10047-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:51:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 076F8428794
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B882530718EA
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C9388E6D;
	Mon, 20 Apr 2026 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LKo4mVIh"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A653845CF;
	Mon, 20 Apr 2026 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674658; cv=fail; b=Z3wRbp52yuohIce8yAbMxGmu5pUOHKS7wGj8u0l5EzD7Z11KD6iWAP8OkFSs134v+HLp/+4mdZNx//hplSlURsMAn0Jh/YvVkQ6XSlkPVRwnlVCgSHupkKAieVWOAMFrr77KAFPBNAqjJt65qMbWkMDenLBZgja61kPSh/Aaelk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674658; c=relaxed/simple;
	bh=5yMAwBO7+b9NAHqcQqinclUyjVJQLQAl+6mJaTA9XDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nhGPJC/C0DDioBNukfTHiwB+Fw/eAeYXOc8UplB6vuyHGYcOC7TgecgVdJwxdP6HAsTw3u6sqHGmoSeW2CZiu/ulrZGKNTvf6/1Buo/IHf39UKiUVoGYcoUJiIThwrx321+C/7U5Y4lPigAwtnACbKX6QdzzIp50t51EhsmBTtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LKo4mVIh; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJljvbC3yrilZNfJrBMJApoilA5MN9mIEYD7CCd5ZQcGn+R8zRhTBFLSu6u7BzgA2wnB2kszS7J3s5sSX/i8/n970lWA+P6ZApxWZNwmNXR7w89dxsmefgJMGtBYW+fl0n1yDweL6JDsuh8+Tfp/n0HWCyxvc8qdx+Yj1BECfYmYtZUCIdLVvslohrfEe+9EAzeZdxT5pDutC7/eZRymfXa/fvaFkIjg+LdOEV0nLktiWXSkWft7mrPeuk3uXV8bgWEjjc5EDcLx/yHmxAiKBOxbasgSGz57RG2qspJUn8bPgrGN17/h9pwmnO9Lgjx00E4kgtuSA0ueiKnC3tajsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+EfjyRMcpCIo3vZbNwtQH9rlPFVWEgVxnI8aLhw8W0=;
 b=y/O2dZ+JUP9oQbvJE0IMrXF09+9PthsBDYc5agrWpPhvLcyFyhx8YWTVut7I6Z9kO2EfyWi2Idv9eet/0rNw5MTH0+nN9tqHa6iNbh7uRssuF9gIiuLrsTAtic211+nQh/n2LU8agwSrViSiP3BJdPRF6iAos3vd2PKPKMlQGVa6BgabQLBHg8kFBn9+/9XNbp/p7hUaYLiSuwLWZTYHF6KxuDxj50lUeSGPY2P3j2Ymjrvq6yWqoQXcls10ldC3dZGEcAkS3TckdigFbTuR8RyOXABx31bxOzwVrD/Py9RPyDzWM/YExpxDu4pH38RWVf0x3WxwGuIkCJYnFPt/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+EfjyRMcpCIo3vZbNwtQH9rlPFVWEgVxnI8aLhw8W0=;
 b=LKo4mVIhUhjgkTb1YIhKOGav5vkbl6lkRrW/FxYVUNVpp7r81UO0z62TOuIbkOfRZ99VuYdjVwD3A0CXjAD2WNsuLIkB+B/Kln/YFyqXja3Gra4vrPEQ6NxH94UVsZCl2IMcThJEVo2lOZ0f7BfzScSSl9gONpqmeHmt9tX+7AYM/ByiSaJdYTMr/LvldWIsSoOTQetVmhjBqrdUXgEOnvm9iT5YfyCTVTWbBhI0L1cSEIBkqbuKqOYlDdwnj+orycwibVl1UyohhhrpU1Tn69Q9UQQsEwZq/jXR+nCfWBJOFE5V1TmGK2PQrqqiYj/FeLbxsG8hARF4xxTEZ7X0pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11360.eurprd04.prod.outlook.com (2603:10a6:102:4f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:44:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:44:13 +0000
Date: Mon, 20 Apr 2026 04:44:06 -0400
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
Subject: Re: [PATCH 17/23] dmaengine: sdxi: Add completion status block API
Message-ID: <aeXnVhcoubdRrT9X@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-17-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-17-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SN1PR12CA0043.namprd12.prod.outlook.com
 (2603:10b6:802:20::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11360:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d81ab6-21f9-4554-1abd-08de9eb8ff52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|52116014|376014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VwCOYvGoeZWJpSKDDo7NkDsGhsodTs2iM6Nwr8OJs9nX6XRYqI3YQJ6Ls/T90/46zVc2/KnjiJfcWYT4UkSRU0az3dPU2yojqbpmV2bRy0XOybcqLtb4MSsPHEkOhKv4Lbh5ZSmnOMjPdmlWh6lblpBWha535vAScGZ2HtBg+sEg1T7/Mg0p9CfzZzM04TuR5te5LH9L9KAPdiaBH/wsSsH4Yz8IS3ETq/w/G6tR7LyZJnmj1a+0BqCSoy5/hnFjX8hCyJgXXRXT9MeP4Q/WtOZQ+50KnyWNrakte/Hvhgp8gYiBt8WD/Nw+luOM+I0dHCNeBIMLae/B56+Ng+KvDwbIfLoUYJcxlTutlMuAnDrHDZ8iroW7f5XqbdBCQHBgjfJiL3w7oSd7nZKmtn9ZlKD/kMSiFIpHRyf2ECB+U5tP/jLJ276byaR1hEqtrEhYKp5jcKe4p2St1w7bsHgPEgKx6BDjPCMIJgwI5avTmc9yhH6h0Oec3wKHFRecIK3u+uiMrB+wtAJga09PMF5aSccrCAmuIeYIHTJ9ygiM6twNanw6ycN4IrdUt/66hUMwG4KuXf3QexKWUwqUACU+wyr9Y1xZNY3JzK+Qlfd9Vk+utqV4vZSlXsMGvfaRICDRN+FaKfSrzzdmnwhSlAbQ8e7Xzht11J0rcVUuE0bwNv3OIK6Bx6fmfN2ycieookZTrDGS/ECXRMtdzKAlF+WhqNFWxdxY9CZYFe4WFKwLAYf0cKr8WAr+3oPnxCw/CzkP/inqyIdRkRimszTD1SdDPFiIXrh3Gdjh8YZmd5MWNRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oKIeNai7TpMdTK/2Epd3rL4bGcByf33AwEgBTGPuPx5KQLZkd9pM7eUL7tQj?=
 =?us-ascii?Q?cyLCvbp9QGx1AKC3TdbuLg18IqyT7ElMhoSD2bewaqlNi0Q+3ghoCBY5ngP6?=
 =?us-ascii?Q?7xBA6rSEgOEgTcztZev5LAcMvLljoF0+gDddZVpIOQRgQXjUiEsydPpUtEQi?=
 =?us-ascii?Q?NKAkJsfAwT7fYjIpBuUaMeVf2s7teNKb4ZvPcv9RILpxQ4LScoLO4uKw8yRR?=
 =?us-ascii?Q?iN5b21lL1DDp2tH56/vAv5ItWaLH+qxlh2nflxd4Z7LIF2VTdV10gx3LDOeQ?=
 =?us-ascii?Q?xEp9zJs1JbN9m6by3MqFGuLEvIVyFcdGi9AC3YYX6s51apdAgUJc9+ayd55I?=
 =?us-ascii?Q?rUKJljfqecwbHiyYzQGlsaA2ROITB3C1Y6tC+3xOV8FJf2cOZ/sZvNVI4Sux?=
 =?us-ascii?Q?UCC0ZaMevIdnno3G1dBj5ggmSIoQzIeCJBB6YsrbX8X5wC67j1IAQ9NVDHUu?=
 =?us-ascii?Q?fdz5KAflychylB2GDAhnkFO61W60zIjL5KtuxUpqkf4QFDrSbeqt5btD0CK6?=
 =?us-ascii?Q?+IKYcmY7JoADPKVAd4vIxCpMWBf9cZsVTPXL9ghP9ExvWx2BgH4Ainnx8fXt?=
 =?us-ascii?Q?jbxI06CLHzcV+qKLEkdugHF7EzYoYa+Jc6MJJf+HpBVTj3zHvjlrUs9OHpo0?=
 =?us-ascii?Q?zr0DqyDhhsWUoV32V2LFCnep4ujhniXal5YarhBaM+c70hIgP/sobRF8Gxfi?=
 =?us-ascii?Q?Z7mnDwGaFjalPN3VTVkI0dPyomb7sv+zwWrHwMch90TRcT7FkdB6n06cNa//?=
 =?us-ascii?Q?YqIGUw6tRb+PzGP/tDMvSsqMGWMSUIu8khyGgm2gyl9cMkEHlnbh6YSSOc+6?=
 =?us-ascii?Q?4xPQlPx7Xu2hLZoIOTcTLk3KEklDt4wmKuNsuusVIgvIdC+BKHn+AOr7dFKh?=
 =?us-ascii?Q?mhA5XG7oGHG+gWQRyZm1Nnx9VTGPgZHYOv1Sc/ygMH4FX1TlIiwdsnHmgsb2?=
 =?us-ascii?Q?8w3K2ambRe3PUpKBqqnBNkH1NbFMd7hIRKVOZ/ol9QD/dH7U4Nw5S3LRfPOa?=
 =?us-ascii?Q?qrr4hbMGnCdy7ABm4Xk2cU0K5FavzNQEf13j+60+IN6Mdl4GxEeb9tD6ARSP?=
 =?us-ascii?Q?3zDuJQb9I6cyhAm0/qbk+kIIqM/NqVYh5CpDkFUfrJcmYomw9U/6C+LWMwrs?=
 =?us-ascii?Q?TH/nejbtGDf98x5e9fBjTEGudwBKSIOxb6+ztPA7Cbn5JE3hN2v9eFQKQ4R3?=
 =?us-ascii?Q?GTn6OnB5bai6FSSnpUbSDq3TsoJI+2el1lFagE00rIGVHUM/GpOcO5PTvJt+?=
 =?us-ascii?Q?ePCnF4AYjH2w7b0tGUhf6b5ZsL+w4WPOtfnw12JjC/JIwx3Wz/cMb38SEfAw?=
 =?us-ascii?Q?HhEK5p2t9flXCCwVsEcAZQSjv3+tSywB0GzFXpC8RL8lFiZRjeJVj7a5bH+L?=
 =?us-ascii?Q?CD/kVLXsdSZuyaFoBdkvL2fHqvcrLzlXVxw4v0/gLflIaWDetad5C8+cMjby?=
 =?us-ascii?Q?JHnd36i7EwPLh/kHjknXpIPymb2slW5Nth6ws6QRAe1xxq+w+2UfhNCX3URd?=
 =?us-ascii?Q?uugXilY+28QMTeFy42yCLnaUS/6QAs3jt00g0WHrRg2YU3ylcTQ/b6FwX41J?=
 =?us-ascii?Q?VAunpBGPjiFkILkBCnAaO0+U48dtGX1o63k8cugJNt3lA2qH/S5Bu3s9SbVB?=
 =?us-ascii?Q?qsbl+BQXvMLxrlSi81n20ILHnvt7m7TiEmCzOWrZUOnwauiR+FfoZj3C+2aR?=
 =?us-ascii?Q?d699dcqg0qeOCTTCAvn/f8cKg4On4agdde9A1MwTUGanm99M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d81ab6-21f9-4554-1abd-08de9eb8ff52
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:44:12.9885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbxqPaHX5/D7lt/yx3lqED/gbam2WbAAej1mdQPQSOGe0F9N7u7LRsX9C8ubfcxte2vScj+HN6dpZ7ATr+Asew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11360
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10047-lists,dmaengine=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[nxp.com:server fail,sea.lore.kernel.org:server fail,amd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 076F8428794
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:27AM -0500, Nathan Lynch wrote:
> Introduce an API for managing completion status blocks. These are
> DMA-coherent buffers that may be optionally attached to SDXI
> descriptors to signal completion. The SDXI implementation clears the
> signal field (initialized to 1) upon completion, setting an
> error bit in the flags field if problems were encountered executing
> the descriptor.
>
> Callers allocate completion blocks from a per-device DMA pool via
> sdxi_completion_alloc(). sdxi_completion_attach() associates a
> completion with a descriptor by encoding the completion's DMA address
> into the descriptor's csb_ptr field.
>
> sdxi_completion_poll() busy-waits until the signal field is cleared by
> the implementation, and is intended for descriptors that are expected
> to execute quickly.
>
> sdxi_completion_signaled() and sdxi_completion_errored() query the
> signal field and error flag of the completion, respectively.
>
> struct sdxi_completion is kept opaque to callers. A DEFINE_FREE
> cleanup handler is provided.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/Makefile     |  1 +
>  drivers/dma/sdxi/completion.c | 79 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/completion.h | 24 +++++++++++++
>  drivers/dma/sdxi/hw.h         |  1 +
>  4 files changed, 105 insertions(+)
>
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index 372f793c15b1..dd08f4a5f723 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_SDXI) += sdxi.o
>
>  sdxi-objs += \
> +	completion.o  \
>  	context.o     \
>  	device.o      \
>  	ring.o
> diff --git a/drivers/dma/sdxi/completion.c b/drivers/dma/sdxi/completion.c
> new file mode 100644
> index 000000000000..859c8334f0e7
> --- /dev/null
> +++ b/drivers/dma/sdxi/completion.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI Descriptor Completion Status Block handling.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +#include <linux/cleanup.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/slab.h>
> +
> +#include "completion.h"
> +#include "descriptor.h"
> +#include "hw.h"
> +
> +struct sdxi_completion {
> +	struct sdxi_dev *sdxi;
> +	struct sdxi_cst_blk *cst_blk;
> +	dma_addr_t cst_blk_dma;
> +};
> +
> +struct sdxi_completion *sdxi_completion_alloc(struct sdxi_dev *sdxi)
> +{
> +	struct sdxi_cst_blk *cst_blk;
> +	dma_addr_t cst_blk_dma;
> +
> +	/*
> +	 * Assume callers can't tolerate GFP_KERNEL and use
> +	 * GFP_NOWAIT. Add a gfp_t flags parameter if that changes.
> +	 */
> +	struct sdxi_completion *sc __free(kfree) = kmalloc(sizeof(*sc), GFP_NOWAIT);
> +	if (!sc)
> +		return NULL;
> +
> +	cst_blk = dma_pool_zalloc(sdxi->cst_blk_pool, GFP_NOWAIT, &cst_blk_dma);
> +	if (!cst_blk)
> +		return NULL;
> +
> +	cst_blk->signal = cpu_to_le64(1);
> +
> +	*sc = (typeof(*sc)) {
> +		.sdxi        = sdxi,
> +		.cst_blk     = cst_blk,
> +		.cst_blk_dma = cst_blk_dma,
> +	};
> +
> +	return_ptr(sc);
> +}
> +
> +void sdxi_completion_free(struct sdxi_completion *sc)
> +{
> +	dma_pool_free(sc->sdxi->cst_blk_pool, sc->cst_blk, sc->cst_blk_dma);
> +	kfree(sc);
> +}
> +
> +void sdxi_completion_poll(const struct sdxi_completion *sc)
> +{
> +	while (READ_ONCE(sc->cst_blk->signal) != 0)
> +		cpu_relax();
> +}
> +
> +bool sdxi_completion_signaled(const struct sdxi_completion *sc)
> +{
> +	dma_rmb();
> +	return (sc->cst_blk->signal == 0);
> +}
> +
> +bool sdxi_completion_errored(const struct sdxi_completion *sc)
> +{
> +	dma_rmb();
> +	return FIELD_GET(SDXI_CST_BLK_ER_BIT, le32_to_cpu(sc->cst_blk->flags));
> +}
> +
> +
> +void sdxi_completion_attach(struct sdxi_desc *desc,
> +			    const struct sdxi_completion *cs)
> +{
> +	sdxi_desc_set_csb(desc, cs->cst_blk_dma);
> +}
> diff --git a/drivers/dma/sdxi/completion.h b/drivers/dma/sdxi/completion.h
> new file mode 100644
> index 000000000000..b3b2b85796ad
> --- /dev/null
> +++ b/drivers/dma/sdxi/completion.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright Advanced Micro Devices, Inc. */
> +#ifndef DMA_SDXI_COMPLETION_H
> +#define DMA_SDXI_COMPLETION_H
> +
> +#include "sdxi.h"
> +
> +/*
> + * Polled completion status block that can be attached to a
> + * descriptor.
> + */
> +struct sdxi_completion;
> +struct sdxi_desc;
> +struct sdxi_completion *sdxi_completion_alloc(struct sdxi_dev *sdxi);
> +void sdxi_completion_free(struct sdxi_completion *sc);
> +void sdxi_completion_poll(const struct sdxi_completion *sc);
> +void sdxi_completion_attach(struct sdxi_desc *desc,
> +			    const struct sdxi_completion *sc);
> +bool sdxi_completion_signaled(const struct sdxi_completion *sc);
> +bool sdxi_completion_errored(const struct sdxi_completion *sc);
> +
> +DEFINE_FREE(sdxi_completion, struct sdxi_completion *, if (_T) sdxi_completion_free(_T))
> +
> +#endif /* DMA_SDXI_COMPLETION_H */
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index cb1bed2f83f2..178161588bd0 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h
> @@ -125,6 +125,7 @@ static_assert(sizeof(struct sdxi_akey_ent) == 16);
>  struct sdxi_cst_blk {
>  	__le64 signal;
>  	__le32 flags;
> +#define SDXI_CST_BLK_ER_BIT BIT(31)
>  	__u8 rsvd_0[20];
>  } __packed;
>  static_assert(sizeof(struct sdxi_cst_blk) == 32);
>
> --
> 2.53.0
>

