Return-Path: <dmaengine+bounces-11167-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MNKqI6HXIWoMPgEAu9opvQ
	(envelope-from <dmaengine+bounces-11167-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 21:53:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 324E3643092
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 21:53:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=nxp.com header.s=selector1 header.b=ROwa3+17;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11167-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11167-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 063ED3016EEF
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 19:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037F3C4B72;
	Thu,  4 Jun 2026 19:48:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011041.outbound.protection.outlook.com [52.101.70.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F503C1412;
	Thu,  4 Jun 2026 19:48:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602493; cv=fail; b=t2YAY51/0DzIrUtlZst3xJQOHqNuc4APr4IxKF5fyWrE8O0FisQZdSveHyDjr7FJ1ALj88Xqm6gT4Bgw2/FNAq3gY9As0Pp4rW4KUCnfaEhUTtBB1LZLR9JXnVXVVlYj1jlSdwPLAab10uT2f+/KV/bM+FLiMWlY8mhSsbHhdDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602493; c=relaxed/simple;
	bh=E9aOvrE2MgHcZCLz1uriSlhxRr9M7llrYlxeEZfcl/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z6LuR2JJJ+f1SunmTHLvtCNJ6DZRiGVeDwTMhmS4cGBYnMj0jC8pJSzdINnS8Ct/uf3jo34y4qVR4STBNgzVx4+pr61//C5u3pMqN4PRqz84AuiNsDx/1U6QhFFhIoSSb6sjNm0z3fFS3clP8sWmH6THURXB38yN7GULcX+wXq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ROwa3+17 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQPdLyMwhKP7RMnOa4fzRFAqmCNWJku+F2nhBNKiACEHBpsd6Jna/A6Q31nkQdgvY/psIGjoP0QwnBThTJ7BxZrMRqh8d4bSasCqQ3ExVUVymU/vXGdLQPTimw3D21qyplh5fOVSI5TSowFtjq5WMGfqLMiXvBeO+zhGccgBIqLRapvWiZEUGBCe2AzUkZjZrS9ylQauIM0smEhhkcvoF2XPjaI4vSzLPNnb/t8uK55NrGKIVhbBZA8flyctCxUOar4ljefg4F/dDZpql2EcemLQ0huOwvAByJBmz2WxrsRp0Y8coiK3d/YLnSubWrOdG1xDyJ01SR+/n6IoGkBqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qe9A82OanSxxz+T1BZKryjUD7OT29+LNwDHQTm47lzA=;
 b=Tfb3BPTzwz7W7TVEvhyXuApyBVLK+xo2zZSw4Pq3HmvUQuh4/NwEyo2Xk6RNOlVdaKqUMsr9f7PSTOy0ALttdCTM0THQgU8bt98Hxz223spmQPSOpxFqqfXKCYkyzzsmrGpHH8a7RChWlupEIldTj63e6HgYW0wyF5QOrL5SdTrvGVS1KbUlA8JJr8wmLBUnBrR1ISlN5ofJk2Q7vIVQPuW0LvhsMx96PvZOaYEEQlKjNronGNHCddX9eT3MaUipmstugReoOYWiGyq5IqMr4H2LlfGAQZnxjsMMlLmQAJoxnuRln/gT7s5caxzaC6NWOpavxSnnLwniuQe5PQK4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe9A82OanSxxz+T1BZKryjUD7OT29+LNwDHQTm47lzA=;
 b=ROwa3+177x+vqFvbIYQSP92eOGsLnNnxCNweUP7AYqYk0TNfwvOQcYB8ak1WXfSwCEkgI1dWLp7dRPapjgo2A5+6/sFAbO81Jp9e4pwThs/UrReufJG6Ath4aqtFUysml+2WbJNfxuj9CCzyW/0laAO9XVG60npEskpcMF74pjRXXagk6IsTQiviqjyIzmFcoH43IrPITmbRfLcF+MFhvSCtldRKpmBEFEUEtmvwMW0IFEjb5OII3ZpP6Yl9qjP5iZXJb9xk4RVeoSCGC1u7E9RwI9vzlKLquxoKbGGoWemTyslLH/65P1T7o8PWIJnqTDUwLqDj+LQHInHOC99mWQ==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB7148.eurprd04.prod.outlook.com (2603:10a6:10:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 19:48:08 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 19:48:08 +0000
Date: Thu, 4 Jun 2026 15:48:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Message-ID: <aiHWcdGfP-rdRn0o@lizhi-Precision-Tower-5810>
References: <20260603143158.3243500-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603143158.3243500-1-devendra.verma@amd.com>
X-ClientProxiedBy: PH7PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:510:339::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB8PR04MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 712fc0f0-9d8b-4cb0-a0e5-08dec27233a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|22082099003|18002099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	lU2nqnPRXneXTYiThnrDZWeqszCTjWVFZIR+rZR3zs1e4KM7jAgt87ZMwL4XkuMaRMbiGj06xOVmFNiCyOn4JADeMf0X4PAuW7vHhL8ljrYICFeBT/9VE30YrXRSCOAB1B867glWgNru9yW9uKfpa4bdwCXl4b33rb1KyEetdWVO76TjFVgP+VI/hDUAPlmHQcZkv2+YCpkcehFMiaUhp+6e+lazDnphRQyUKnk3U3b9E/GTdRSho2zXe6j4P4MsW3hWg9hKdsz4ZB5vfGXdLofT5AGjbIWD9KGv92FL+tqVS9SdeLYW1/ZO7E3EjtYUbWq5+GtAb8jcjPoFA4KA+/HDWhRTOdGbs7x+r6PatEOYOFn8bEcuoARj7US4NNnE9N38woUe94t0ty3UhBdDYH+r/AEZMgXm6mtUwdxPP3JLo+Ld7X3xFVBtKtyz3xcs53K4JXIt9UvxitJYbwhw/xsHketMhwG/OZCrve14fOR1Ncjw4f9zISMlyUnWCRgY3lNqA1qquUrK1jq6IWkDxEDTdld4WQ6mHD9o6yA5ghaGFtHRZULH6a1z3e1op36Nhie0v3L1kicbtLURBMlwFehn/nZOU82X8XB4CSle3139PIwZ7CZ1ZlpqX0nI3ELPSrtQWuuF4otTORLfndC8vy1DsovSzQpmb8ytJ9s8QCSUACLzVyDggnwBY4ZaFKwRcUEeqVXrzxt85KFv7+UbX56jLhxTc9S5RZLSXGhNXO8NnQzZg6hEDMRGkDbDk1s7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?wLfLTZE3GoSq0f47apBwK79CNl0AUkKGVTywjutWhQ2LlyX/NuJ1aC/PZ7?=
 =?iso-8859-1?Q?oEFsm55t3T7J81Zt4+jnXFHWAx6HliKmXm/vjhVe33nZlQWFG/Y0vdEiuG?=
 =?iso-8859-1?Q?6h6TjIJd4sQxaY7OVZ4FTCOD1NLaaN8yc0GwQgPFR8mLB815Gd0j1pqGDK?=
 =?iso-8859-1?Q?N3VQg3E4CmF/W/Odr6vPhPUK1DbKUI2jA2DUpa1KXy0jfktTAj0v3S8aqs?=
 =?iso-8859-1?Q?05Qfh3D14ORC5yvMDrCrDhQsjuJHhMk/eQOktiaxv/6c/Hv2gzumqI4H2h?=
 =?iso-8859-1?Q?fEoMgXtUt74djA20Agg7YYyHmA9GVFxBMX71BAWCekKPn/OvaV0G9YFC3F?=
 =?iso-8859-1?Q?j6/khwNL3rXGjDYLRslTgY5DhWp60zzR8IeG/B0iFGWwOFrdEOZcSb2xd8?=
 =?iso-8859-1?Q?Sg5B+OkQA2mW19S2cR5YmWEkYoshJu0AxA6RY4zLYtGxagpQoC0Qn30gZN?=
 =?iso-8859-1?Q?FFO/nRiQnWM8XNj2uvP2wgX43s2mKvpEAjZ+zlRP9XWEJ0daaHBGRh7R1q?=
 =?iso-8859-1?Q?K5pqMPYLdjb3JOdyMLFSdkObx4k4I13UJ8Wx+5Aj3BImClcCLEe1KYPlZF?=
 =?iso-8859-1?Q?aM5gOsJliPUSYrihefeiKCSYulKBR+youWgB2I3znEVmPMbDhagLemBCH4?=
 =?iso-8859-1?Q?DEat3XAsYNOXdtLQnbb3dRdCCVyoyIgFYj+HRYf9QYweLZJkhHAnvkzg3F?=
 =?iso-8859-1?Q?w2r9DzxmlnOpXdQ8vSDcJ7AOucUo53CtWArb7tRl81oyXNjX5W5/UNF/t4?=
 =?iso-8859-1?Q?U9vm+t/ENZk3ntII9JSgUau70wsxeW874dDlnJqzug/l/BSxlj8JWVfZSN?=
 =?iso-8859-1?Q?mlu+FxjpAAU3Rf5b/td59LtKgjY2tsbr8n9CcHAF3pROXFxujLb1iaIQ1J?=
 =?iso-8859-1?Q?r6CkiJUwgvOdpy0J/Ng5ZrB5okNwiAACChlzJd7zHjuk6tqf7im2n9BrPH?=
 =?iso-8859-1?Q?xKGxGM2IUrEseTSeXb3heQ1fViRTT/6mSqh1ktsJ4q30525oMuxmEc8TCH?=
 =?iso-8859-1?Q?L9ZduRh6yCKwvpnbXUy2xC3FzOFP2JQBR6zLlZcqKrPvf76ul+UgrlXxWm?=
 =?iso-8859-1?Q?VzmJObh2DcShFWgXkskqjQlwG0v+zLxffuJr9/DlmIuDCBOaNYLRVE/Xs4?=
 =?iso-8859-1?Q?9vU0lkx51VmJmXCf0MEIlMMMFCTabAi0is7V/UGvlnxkpVLOMbSwmSmHIa?=
 =?iso-8859-1?Q?nt15QK+EkO1JDByCftGVodeVRQv7W10vt+EzAeZHMX38rB5UOok6MNI1n6?=
 =?iso-8859-1?Q?fuaD0V3AMcrQ/duC/u7ghpy57lhxdvtCu4TmrJ2vW34jtqvOjNQ11AEXVO?=
 =?iso-8859-1?Q?712MTeeO7ILe7eUUh0d4HBlq69dDR7c07AUqbkVQ8+TPpnuzXzGcxGYRf/?=
 =?iso-8859-1?Q?0Zgu5ZsecJsWc6nL3PK9oI4NbqwFi7JciU6K3Plbr908oqelgpyRxOxC6Z?=
 =?iso-8859-1?Q?TpIHzmp3Pe+iQzim98QuYPXE/FI2jlhbPsEux67hXAkgAeSmZz+Svh6dws?=
 =?iso-8859-1?Q?6cAQbHmACAdjOXRHmrBeMxWfZ2xv+fwcQutqTVwH0XvLwMXIUiDks4BrRz?=
 =?iso-8859-1?Q?N7sHo8nLyvESyoUh/S1M2Fw8rESfJTrBsLsrnAMOipwMJiLyzJVM9K2pRt?=
 =?iso-8859-1?Q?zVwZBSamkOVATAPQmbxar2uqU9srpn0Bwu1qlEOOyx8gzIidggkVrR7tBD?=
 =?iso-8859-1?Q?oelbyeAPIRlV6X0ZMaoX7pFYlx1+UwZLgUJQxq86ztCMmyAiq6C6TAQYZP?=
 =?iso-8859-1?Q?61qbU3CPGDY1LPmjvgEd0GKtp5xJhYfpnDKc/36rtlBwK+ohTMhph1AQL4?=
 =?iso-8859-1?Q?yb+WzgbBRQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712fc0f0-9d8b-4cb0-a0e5-08dec27233a0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 19:48:08.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y93PMciayYKKXHgnTcr62BzBBcLdi4t2CyhjZP/sVMxPnFNDoChvSmk3A3lE2VxLjXvHS8/2HaWN/kY8r8Z8VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7148
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11167-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devendra.verma@amd.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,nxp.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lizhi-Precision-Tower-5810:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 324E3643092

On Wed, Jun 03, 2026 at 08:01:58PM +0530, Devendra K Verma wrote:
> From: Devendra K Verma <devverma@amd.com>
>
> Add Device ID for AMD (Xilinx) CPM6 DMA IP.
> This IP enables 64 Read and 64 Write Channels.
>
> Adding the relevant dw_edma_pcie_data to use
> 8 Read and 8 Write Channels for initial commit.

Nit: wrap at 75 char

>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 0b30ce138503..4ba368d18cb1 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -27,6 +27,7 @@
>
>  /* AMD MDB (Xilinx) specific defines */
>  #define PCI_DEVICE_ID_XILINX_B054		0xb054
> +#define PCI_DEVICE_ID_XILINX_B00F		0xb00f
>
>  #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>  #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> @@ -125,6 +126,19 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
>  	.rd_ch_cnt			= 8,
>  };
>
> +static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
> +	/* MDB registers location */
> +	.rg.bar				= BAR_0,
> +	.rg.off				= SZ_4K,	/*  4 Kbytes */
> +	.rg.sz				= SZ_8K,	/*  8 Kbytes */
> +
> +	/* Other */
> +	.mf				= EDMA_MF_HDMA_NATIVE,
> +	.irqs				= 1,
> +	.wr_ch_cnt			= 8,
> +	.rd_ch_cnt			= 8,
> +};
> +
>  static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
>  					   enum pci_barno bar, off_t start_off,
>  					   off_t ll_off_gap, size_t ll_size,
> @@ -547,6 +561,8 @@ static const struct pci_device_id dw_edma_pcie_id_table[] = {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
>  	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
>  	  (kernel_ulong_t)&xilinx_mdb_data },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
> +	  (kernel_ulong_t)&xilinx_cpm6_dma_data },

Please .driver_data = (kernel_ulong_t)&xilinx_cpm6_dma_data

Now Uwe Kleine-König is cleanup this.

See similar thread
https://lore.kernel.org/linux-i3c/20260504143324.2122737-2-u.kleine-koenig@baylibre.com/

Frank

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> --
> 2.43.0
>

