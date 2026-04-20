Return-Path: <dmaengine+bounces-10035-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GlAKF9bS5WmmoQEAu9opvQ
	(envelope-from <dmaengine+bounces-10035-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:16:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC667427A41
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81AA1300AC02
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DD8296BCF;
	Mon, 20 Apr 2026 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eqUKqvJM"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F46BA34;
	Mon, 20 Apr 2026 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669394; cv=fail; b=YFpL1naL15c3RFJL/70yuuyebpg6LOYc0cBiPu9RZd8ab4xiPug5F+iOkG/P6hjL893arFxq6Hzkvlmr4ZW0WbHu+6jnd+tHJ4kXLUoEEJlBPQhf3vq0RxVZkPkigt3N884nyx8YPIPXwcEj5HwC8W/vAu1CGgT5/eEJcLopep0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669394; c=relaxed/simple;
	bh=657XiyKPDMZIHdLMRSed6b3ta5NLxGNrMfEMSHX00Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iDUJIsjdAeZnc+nCQmP02Yte0kCSa047eGQvlcKZ4kD4LW7jLMxW2InUk/3mDGUPo/aUdgmZ8S5/zVcwB5wZ4A9JUGI1L8eZ05KgLbhqZkkaiwj91eMIT0WSvp92fVUseE8jkNCt5Ta6gU4ali2YbTDo7oLCVu/NQukaWgUe4Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eqUKqvJM; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUNMWzecbKwuAqOc37L3/AILfh2bRVm/JmNcbsD/xIB3MXEwG6rgVoOkqchNHV7J0AwgApBDeyhyUwPSZhuc2ljI3Ca57CAtUA1eIgXqHE2xvI7JklhLKrFziXq9v63PcoGy/w0j2bDsoXoaoCmK4ATrsfxDdBEjAkwTsMUOijSSoS5fOl5RszA3Ja0yukYdph2Hx2nOjPFnfumolCr8ULORpoGxzTUn9O2wfq487sih8ShTozUNL2smjDw3xabVNziVbgj6aAsxFmPJMSVHQAa25p8IzlT5ZxzQGgl4OJvgEDvSb+057hA44CI3V9yEbmjmpDU2DdZ760t+CEdHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4PV5PZrngVkz9qEdYmeeCMZTnfBjN5CEH+veS2Vh1Y=;
 b=xC12Dkl1KXDA3LT0eEIghECnT6quffNNH+4LkpW59EIZd4cWb+4tdGLSt1UtxM8HS2HhEW/x6ZbKPY2QhO6ewYcqhPt8oPjHH5ibc5RrLr+l9WxOAqK+1Qh4vmLuSeZaevIZjnwijbKhea8pZvm5IoFbBBEZARmPh16qsct4GAG2gvPtkBlVsH2MsOsMtrlcq6Nv5ewSCU+jf82lYlLFPyXjuooXTAzUMvnV0GMCVvucUwR5zdCu6Uvog+rKYgAqzepb95IB9tvjgrnSVw+WfPp5Y0J94x48dbhSAqebgcj7H5A56eXW9Scu/D/KJZvodDh29Livh+/1GMTiXbKlEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4PV5PZrngVkz9qEdYmeeCMZTnfBjN5CEH+veS2Vh1Y=;
 b=eqUKqvJMPWmFeBfxWOD6RtFiJUiR7uQwSO9bOzQiavcMP7V3klM41ag0ChvdZqa/WS08eT4Y5VSd8jLc+FW416P3p+nJfIxP0U0fApgOoOKN3U1o6bQCQQicfkuxPRJXVTYXeJgj7NEg3FpaD2CToSEzYKnBBUAOuEi1HLVxHZC05OTet4yAYN9jj8bY1kI7WqNm92n/OXghXqaaFU6qsuG1MntyPYPKT0g+Uv6zBdPGnr4/bInnvosx0sJaffpkODn4cts2HW0HLFHZh5ZThQ2Ly8sdsJmROXpjTh5DSp7X9KBHAeO5USp6DhvuG7ovCR3pIEjTg5+gb9eavYTUkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Mon, 20 Apr
 2026 07:16:30 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 07:16:30 +0000
Date: Mon, 20 Apr 2026 03:16:22 -0400
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
Subject: Re: [PATCH 08/23] dmaengine: sdxi: Install administrative context
Message-ID: <aeXSxhIxQrNGUCmY@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-8-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-8-1d184cb5c60a@amd.com>
X-ClientProxiedBy: PH8P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::34) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB12026:EE_
X-MS-Office365-Filtering-Correlation-Id: f7617521-cce5-4726-bede-08de9eacbe93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AR9K7BLv2pS3eVEtAyNfQQEHiBA78/pZ5qnprRDYWrTOhUJp1IaUQL2e0YHOnDucq/xZVraLx/CfTyI3rFeWqMXVBZiau6NTUE72+gumDp6RG9Il07MrBuomq1JVCUDzghLTwR//qpVwFqqt7hvDYA4JRVuaKVn+G+b2bps9lQVEcREebqLZ6KjfJmt7ftxAK/8B1yEOl6WC0OeuEc3kIW0zUPnRv4SUcwcKCPUnSkTem+b7j2Scj/yzFqlgD+BglTpB7PdxW/MAU0r6+5yF//7GcImDOuoyVOuUYUXy3yur2kKLJgq8qmrcizCYjE+3+C4zWhx3di6n5jx06zWo1AOsMj58WGBRM8aI8RUYi5NohBi1NWM0H33sp3Q/6Hvx9C77c17evDRBxmO9UCAaDpD4c5caS72HnQil0SjfDkDV+yFtzsYgVVIEN1Xn/NLCN8hSc8zihl9uzWswtvdDBPNVdKCqpRff2qorc6I0xJG/DxoG9eTfgGaYnvUIRT48RAqipyuayNHb062XiLR4dCE68JnQ713O3UGbap6gau5B5N4fhNEMIez8Knh+NWv1SdX0gTdzvzUxaePSv7z3OawhHmzWruzFQujxnEmEsQl0lnOk39rAaj1K9GcYnn9PZlm9P+K+uXzCKMxhR80frZW2bLTUOzryw6u0riBOftvPO4qY0Ak+o+vWAV9Inf1ml4BoRyqriLsHWMoDKpktboTHuOEzjd1OsTVV9U0BM+/3WrqJ3/TIwhLHmXU/XgEMjf5QzHgBobv0YT+/sSdy4cdFnd7yK6OswPoxuzTi4+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDq01w/9yupa+Wq2UOmLKqjQVEPxsOxzUP6qkY9+qhgAO89D9nZdEqUy9clq?=
 =?us-ascii?Q?cxGZKEum9vUY9hAOHNxwQ8XwmLJJUxFrvtaj11Q0UfxWUc6OOAEn/c14NKf1?=
 =?us-ascii?Q?LHKXKjeiaCyv6Zew5AjSmFm6ZKuxvqFrObjk4x3QkiOG0XOcEvVMS1n+aGMV?=
 =?us-ascii?Q?eU2lYY+xqU6uW82hDRs0eyS46U1N41kHljDfRkss+ffZDSlG2teaXF8hxkAd?=
 =?us-ascii?Q?CM2TnzkAp6CrhMrrc1+5s0QCP6B5AifickZqqBCWdc2iaQhlj/mcvDyb4TNn?=
 =?us-ascii?Q?5QVMAvXGzBP3KegLX0Y6nTCtixubw0OeQrvDAmpqCVXWivqdLChoRUB4o2K2?=
 =?us-ascii?Q?WgWu/eSkkBdevo4cLHarOQ+LCp2plqJLklLQsO0Nag6H6tYaqMo9WlIkgsxH?=
 =?us-ascii?Q?mVsxgasXbXGFQ5LhMxrWKeKzfmvGphhh76/Y9gaMH05RErO6VCoAn8+bIM6B?=
 =?us-ascii?Q?B68+QYYcS5lDqKE1tczccHjV47G+u1/gb4xExC1L5jPIDQ9h5k2cUj/UgnVi?=
 =?us-ascii?Q?kDRmnqMLm7yCHERwsjEGc+shAuqWYLiOco+3THduEsD9uBUFc8WnPaN1bVMZ?=
 =?us-ascii?Q?SS5apYBM6X7XTqVZqDjZt/z8WzoUBRQmOZidB3E5S57aoFqtfYiNLOEmubLw?=
 =?us-ascii?Q?riQqA1nWIjxX2G4D9qN50NnphKzDFuy0hhgheGNgZvAevOIv49h9Ek8o/FBd?=
 =?us-ascii?Q?707CmAJtzJHAGVXOC7fLUc4UEzOhy4Nm2K6F2f/MFMuxbOV7k7psQmMgWcvu?=
 =?us-ascii?Q?kZ6l+ToPgdowyabvDCPgWfY0kPqropi9jKc3W2B79/Dp86rQIFtdqKGbexix?=
 =?us-ascii?Q?OtVA5iis/zI0CFi32qMnh9tj7cmmsEi6vIQgfnTJp6wItxPeSk/fX/X4wE6j?=
 =?us-ascii?Q?cMYvWUvNHbAaaISbQkKIdestTdL5eLFpkA1QiWKEm5xMJOXhNeLOUtKowrpb?=
 =?us-ascii?Q?fZWGOK/u21usdHo9feHfM0gcms8LvfDhKp4F9w9UAs2EzLivtZze+e5HFqmB?=
 =?us-ascii?Q?DoxnKbJFAIk8UCisKxyUpC0aBuJH+FyHJPI+3AIO2hOjgoxqevjVWdoXip7A?=
 =?us-ascii?Q?m9vsn3MPcDIvQLj1MDYDlxDTcb5mbU5PLPUWCL5kLM326wm++vuc8lOHEDZk?=
 =?us-ascii?Q?c9wBma1naKdr0gx+nHRPmfTlwojZZD9qPfIcXcnYrO59nWU93A2+c6xMbHmz?=
 =?us-ascii?Q?Jat/mueHLc8bXHa1vvwiPZXYoc+LYRdDFAphXKLmDE4YVQxaZ0hYGOVfvh00?=
 =?us-ascii?Q?kj6vZw01duxlO/fIFOUguB6015G4jVbZzPvIFv4wiT14wRiG0y5KxBAJ0BqQ?=
 =?us-ascii?Q?sQmHgDRV2kxUNXn80vP+t0aJMhVeYrB01XmL3iDfrPDLlZwjOTQlDD7W5XPS?=
 =?us-ascii?Q?1EKxgCgxy+9omxodUJy5imVHdnFgn85UHt0J5HTB3fHc7vbM2vridaVsGwL8?=
 =?us-ascii?Q?MTuGDQk5N4MlmI/2SZ4oUpiW9XfBPyEvotW/k+uFW0fDgunpQGTFyrCmv/VW?=
 =?us-ascii?Q?gK3PeAVxRrB2MyW42YrX4aPhUS8fkuCEjkK+Q3k328Xv1eWXo2zKghuQ7uoQ?=
 =?us-ascii?Q?NQyqeT+XHIp/T3mh5ABr7R3o4y/m6Q4pOI49RfF3RIK/4PMCc7Ce7fG/q8gy?=
 =?us-ascii?Q?DyhVeq+41YrPuIyJw8MJ4mp7pXk4CeDnZa4wBRpa1mHHYbmpZN5XA9bTxzbr?=
 =?us-ascii?Q?XIcqzvASGkZHRzSvWriZ+VgCSYMJbUX/FZdESbLn1B/itHwuGc5yUo2wsZKY?=
 =?us-ascii?Q?ZHXsYl8fyA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7617521-cce5-4726-bede-08de9eacbe93
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 07:16:30.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxuOLDZqZuN5VU6XZD2adgC5hujymn39Lwu1wkSIzjMJALwptsIdE7declN5Nwty2up/0EdxX7ABXVHm3I3ZHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12026
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10035-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: BC667427A41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:18AM -0500, Nathan Lynch wrote:
> Serialize the context control block, akey table, and L1 entry for the
> admin context, making its descriptor ring, write index, and context
> status block visible to the SDXI implementation once it is activated.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
...
> +
> +static int configure_cxt_ctl(struct sdxi_cxt_ctl *ctl, const struct sdxi_cxt_ctl_cfg *cfg)
> +{
> +	u64 ds_ring_ptr, cxt_sts_ptr, write_index_ptr;
> +
> +	write_index_ptr = FIELD_PREP(SDXI_CXT_CTL_WRITE_INDEX_PTR,
> +				     cfg->write_index_ptr >> WRT_INDEX_PTR_SHIFT);
> +	cxt_sts_ptr = FIELD_PREP(SDXI_CXT_CTL_CXT_STS_PTR,
> +				 cfg->cxt_sts_ptr >> CXT_STATUS_PTR_SHIFT);
> +
> +	*ctl = (typeof(*ctl)) {
> +		/*
> +		 * ds_ring_ptr contains the validity bit and is updated
> +		 * after a barrier is issued.
> +		 */
> +		.ds_ring_sz      = cpu_to_le32(cfg->ds_ring_sz),
> +		.cxt_sts_ptr     = cpu_to_le64(cxt_sts_ptr),
> +		.write_index_ptr = cpu_to_le64(write_index_ptr),
> +	};
> +
> +	ds_ring_ptr = FIELD_PREP(SDXI_CXT_CTL_VL, 1) |
> +		FIELD_PREP(SDXI_CXT_CTL_QOS, cfg->qos) |

Align to previous line FIELD_PREP, check others.

Frank

