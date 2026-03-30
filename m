Return-Path: <dmaengine+bounces-9736-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIInGk+jymmx+gUAu9opvQ
	(envelope-from <dmaengine+bounces-9736-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:22:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B73CB35EB33
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FB2F3080D46
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF93B378D6E;
	Mon, 30 Mar 2026 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ObnxSOjc"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7D376BD3;
	Mon, 30 Mar 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886664; cv=fail; b=mOPoJq38jRVWH1Oa0U4H7X1+nuJKQ8mRMlXVzE/xmFKgt/teQ7YFbUTC0H2gxsfhAClyvHIqPRBjvF64iTCTHCyL1NIY0Qo3OUEg8lOEjT7vxzZDbQp5gQMADkB5oGPimaZgGgseRG3NzzZzqsCZiL2LWj3lgBDY1FvePPVW/48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886664; c=relaxed/simple;
	bh=wT0KNeyZLujXevskOzkgWlxQ42hiK9OIyn//Nl+7tXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JMIUk/FH6KdV6wUlDGoYhvdPpSeUTzjwfCdv267wRAv/xTa/UBhSdxfQrUcyw2MsQNL+/QrbzJRSzQorltKZVExYLufv9HcooHQUT+fXHnPHRupm0gcJXmEgMoOjIm2br4e8lbXfBv3EgovUFKkTmNRaZnyN4lyYAqU1HctqAoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ObnxSOjc; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9IIZJ2l98XnCcO0j1l7fa/EQWrqHotXH9AysUfRlLVvrCXD1/YsuvViWZUmmUCVk3np6nslPKAc4/BikUHv+zh+sm1QLQQaXE0CZyIF2jiaHvAWSH3M0j4mgZo+qLCkxfq+3rks9owazqkm94IkEQSBmCnYUFhcVOW6Xpg9DcTwfN0tywYKVcs+ZLpSGHjRVVmuyw2w7OkF9hu4ksyHOyv5aZWPE3w8L8iWQ4A3HvKp51h5p1M8O3BoM6eKIyrykgn3TEReXzcLxpKHOijjKRDrSDnaOk6Udngl0DV+aNUFI4ndo2kHbdoJ4VNnDDCp6hNFgB58J+/rgQQ01ch1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cK6CHQ0JYSO7WKzfUcaM8seLmBH8P37jyo8prhZDYfM=;
 b=v8n7G2EXTZyRfDe99cAGZFsHYXA78kUnwLqXykfIi+pQkmFLBrbDhIxsxeOjTtZ+UcB/lpJN5xTzZDnz9Ythno6FdPUxBWyEWyE2tDNg1nU4KSJlye9uvo9BSxV3CT0Net3edJwUidUFuGcTdq9mM8HoBYhMcBlN8vwNEyVeLSbb3v3ubWIS61jULSRv/ME2rScoEl1nvn62edhGIz1gxOuz+aoxPXfptDg2mZbFcbATr48bIeT190lm4t4EoPHG/qesIoP6B997Mdpd4UlQYUaXwXgBh3uSVp6cgZyOF28HEkfvfGkEnGO53bfY5TDERqsqYKgGaJTeqjplb7uu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cK6CHQ0JYSO7WKzfUcaM8seLmBH8P37jyo8prhZDYfM=;
 b=ObnxSOjcPPcTF/2o3p0SFflTONibhOg98I110qgfqh9RHydlZWM18OyFh46JjJh4CUa7nYu7ua2hZ2BASUK2elTZhlxj1H2MCERWa1e/5mberTpIIp8WDYrFvIo5LL/PYGE4x4WPSCvm6/5AGqB/Djp23DCOZF80xlSBX5F0qX6+gHgY/qF41uojO+e6lJ6eMDu1uUUixlJ3sTAa6tySuwlzai5XVJt/91NmfNCtIHqnueu0tVRtc6zlOdMTOYhWCK7a/1B5V6P5XcsWQeWqfyibq7istJA8dV5+3EX3mg7JQQIUc0gSM6R8kvH8wJRyBeMVLPHCr3BJKsrtOJr32g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 16:04:19 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 16:04:19 +0000
Date: Mon, 30 Mar 2026 12:04:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, git@amd.com,
	Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Suraj Gupta <suraj.gupta2@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>,
	Folker Schwesinger <dev@folker-schwesinger.de>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Kees Cook <kees@kernel.org>, Abin Joseph <abin.joseph@amd.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 5/5] dmaengine: xilinx_dma: Add support for reporting
 transfer size to AXI DMA / MCDMA client when app fields are unavailable
Message-ID: <acqe_AF3YHPLNzoV@lizhi-Precision-Tower-5810>
References: <20260313062533.421249-1-srinivas.neeli@amd.com>
 <20260313062533.421249-6-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313062533.421249-6-srinivas.neeli@amd.com>
X-ClientProxiedBy: SA0PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:806:d0::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: f189232a-85c1-46ab-fed3-08de8e760049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	oFlmOb014+NHhjpWrBdyLQ1bXAwmWg1mavcF79v2JL3s3SZFfO501HQXSoOppJA9NOhDPKVSN5nc6f5PMWDeSr3K9Y/Lqv6vxGemmLGrj2ONJ30zys7chCUShjbKAdLmxpZgTQB3jQKEjTK/hK34vj1LSyVw/pnXMJPGLG2MDX9L5xJ0l2YbPeD/BhaSZxVA33YiJ6TZki0/jGhuWyrIRxp7b2sDvD3Oz8LWIJZWV1jMLvdMX8TOhRGGbWmOqwehk4xZVodfdz0jnueCDuoa2i33AtMhdolYMx5oee+aSeZVCJOzX+nzrwnjWfgFW45hwuPr4s1u8U4PPocdt75M26iR3ofeRX2M9sfIxHrPdTC67fxD+qlMm4p3v5O1GeJUQCODmVRv4X0+WUpiBqJw/U40B7WEq6zmdMohcBrZj4LXVIh9CUeaNigC6TTKcX6IeUwRJxcWwBnqrv4o3TABeH9ZBCrfo31tTtxCXyUb0cgo537r2CE9i+2o/efhts5beyurRD5jARI6OJWyV0rM9dfZ6k4MyNVIk1k6nkL8cavy7toJ6EcTADKOFUYNm0xFObH4E+lGtfXjCxQ2Da1Tmad2XzCrjInyordEs2aSrp/bPvnzZoqR/88AxzAehzA5y1sM8lYu9QXndud3x+HRAqNaXU4ytqUiEC6nGe3TlUzPafcZpE4sOU3cbV34gVhfX1hU1aMhGvS0h9rVeP8XdLwd7zEyCxzdvmASQ8Td3l2jiMasYWYVmfoAkfPWmTwH53309vIuMsbak91VXTdSk7Sf1BHbpdwNWPaMvuuXM3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6RMRlxV0vnmrLDssuECMbpm+r0GySv1DS5IJhjebT1gKFOov5Za2+TXv4fBS?=
 =?us-ascii?Q?lSYLFfycHABx+RXqeMwQFY6OH4Zg8Q04A0a8k971+km2z0R4ncb8+/0ak1EP?=
 =?us-ascii?Q?ZKZfQXkZqqSCc3+LvWNeYEiiWknhFaj0znzPqS8RZOzmtFPoTDHGbOCmvEdZ?=
 =?us-ascii?Q?86dmsbIjC7gAektTLfgPNNqF9eD+fKDgUTbkACW/2+NrVCaudDlB4WbdkHkd?=
 =?us-ascii?Q?paOHQ0T0673p6uWW1SXJIj3wJgUKx1Va0mcOSCf4DnEhhPG76MZqIer8iv7w?=
 =?us-ascii?Q?HnM2/04nvmH4BQxeQbDTYTvk4nMsUQk7W2HRnUD8H28uHkPTFrJ+5lcUS8lf?=
 =?us-ascii?Q?YcWa1FR+XFHPoE58W/FC4rqpyYX3iCBZ1kv/XTXWBsNR2vUDgCc3DtQTuNkX?=
 =?us-ascii?Q?1PcwwUmlaSgIE/zvejS4CasR6VcHgxtkKYw1Se36z+ztS/wfhNRzFpr8vix8?=
 =?us-ascii?Q?3qHUxJpANDePk7sZ9sHu3B9xyKXWyZP6erzfMCsxhPndg3QFSXR87wFB3yNF?=
 =?us-ascii?Q?j1gOGR2iAM7D4W6x4A+6Af0Fhbj+pKO+bqK+i7mQ+CuSy7aQ9Heky+Tlw9Wp?=
 =?us-ascii?Q?oIkWQGcfJ/PMUbubAL6uplcOtHCvHVyImR67J5CKNAdjoKPzK3JH5j2beOSt?=
 =?us-ascii?Q?Vvb3Cm4Lle1cnpN8QXucu1DmeZkdvq2AhfkbI7RhR/paxWenhcgZiCMndwdk?=
 =?us-ascii?Q?c/XGNSJ9W/fAjYuyspELfpZXdUkqadZRcFjw7RmxYHBnjLpRUyaMcCESppql?=
 =?us-ascii?Q?rf4XAoAgBJtzsDuCGLJImctPiMk2EdDYc0+A4S0HOvOHRwlJqa6Ox6vQznIm?=
 =?us-ascii?Q?bTZ6iFmZpLtiGoOXVwyEH5R4H0dygaXa3Bgl1MnQbL8TfnlTbvqcF4Grg7GT?=
 =?us-ascii?Q?I/s2fzvO6zCttIvX21AIGFiBCrvNj40ij+6lXcnKbaIa9TA+inKWdNKGg/hI?=
 =?us-ascii?Q?qgkOLyQFegk+cIp3NNaZybGnSIMGQcPgml5+owCc+6ngLu4mJGX3RtoNDlGj?=
 =?us-ascii?Q?JM+i+XzaN5rzfMF6JpYlmxYHk2/TT0u+oXGW8iK2UAycRfd785xNnR0mgUxO?=
 =?us-ascii?Q?cammEz7ZPjo/rbwYU/IAwVbPk+NY0bO3hGU7INgxgwNBM3niIniZ0YtX+NGO?=
 =?us-ascii?Q?9jRwBAimHjUhkTOKnHv8S/5MddSDTcAi/IVJ7pugaSgT0Lyz1X72h4ZeETNA?=
 =?us-ascii?Q?GSSXkK6kSQrxIqEKqn40gCoY7h13lvj0vsl/W4FKzVD5xDVhCLzfvK39KLGQ?=
 =?us-ascii?Q?HAPHG4yfRQKtXU0zjyId8vG+FZsVjsyLWl7R54HizdjQL+cmIGzFOYptdzXJ?=
 =?us-ascii?Q?RCjkhDVF62LUICwy1v+a5VhTvY3NoprJXLB0qbagEjqU06/82DFCJC+8c3PV?=
 =?us-ascii?Q?RHxnCCs8oH58aC+Kr0RR+vK9VD3JLaZcd0RwsrP/MDrhgHfRqBQMoanj0SvX?=
 =?us-ascii?Q?BsTyrXNZ4VIRrQTiXOane4FQnrNj4hGuFQfaPfBsLETm9WEYUpjOFApYevlY?=
 =?us-ascii?Q?SbQkLBh42iHEDK/sUoh9xuQN6/jEtukZzDeTZAPmimcyRpsit2C1IPBEk0QC?=
 =?us-ascii?Q?Wo47EuRnzze7t10OjxJpfnCt2cAJOrnrOHDYzGdcMjRAtItUnkK3lBlmMAbK?=
 =?us-ascii?Q?T5BLcvlSJp2uzbu6ZueIhsaCD4iQnUcntJvjUvtsJzjazERsxJBMbqmNFcHs?=
 =?us-ascii?Q?8tPVF91tyRY2L50Z4eexcx77ZirenWaKgC8w5PdTVeIJKrCo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f189232a-85c1-46ab-fed3-08de8e760049
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:04:19.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhemQrNMxg4+6BwAIrGETU6C39tSZSbM36yS9hkvLVOZtUy7VpfUI8GmdzX+/ESYJ844l1g5iMmBObI3Vs2JKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9736-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: B73CB35EB33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 11:55:33AM +0530, Srinivas Neeli wrote:
> From: Suraj Gupta <suraj.gupta2@amd.com>
>
> The AXI4-stream status and control interface is optional in the AXI DMA /
> MCDMA IP design; when it is not present, app fields are not available in
> DMA descriptor. In such cases, the transferred byte count can be
> communicated to the client using the status field (bits 0-25) of
> AXI DMA / MCDMA descriptor.
>
> Add a xferred_bytes field to struct xilinx_dma_tx_descriptor to record the
> number of bytes transferred for each transaction. The value is calculated
> using the existing xilinx_dma_get_residue() function, which traverses all
> hardware descriptors associated with the async transaction descriptor,
> avoiding redundant traversal.

Can you split this change to new patch?

Frank
>
> The driver uses the xlnx,include-stscntrl-strm device tree property to
> determine if the status/control stream interface is present and selects the
> appropriate metadata source accordingly.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 52203d44e7a4..f5ef03a1297c 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -380,6 +380,8 @@ struct xilinx_cdma_tx_segment {
>   * @cyclic: Check for cyclic transfers.
>   * @err: Whether the descriptor has an error.
>   * @residue: Residue of the completed descriptor
> + * @xferred_bytes: Number of bytes transferred by this transaction
> + *                 descriptor.
>   */
>  struct xilinx_dma_tx_descriptor {
>  	struct xilinx_dma_chan *chan;
> @@ -389,6 +391,7 @@ struct xilinx_dma_tx_descriptor {
>  	bool cyclic;
>  	bool err;
>  	u32 residue;
> +	u32 xferred_bytes;
>  };
>
>  /**
> @@ -515,6 +518,7 @@ struct xilinx_dma_config {
>   * @mm2s_chan_id: DMA mm2s channel identifier
>   * @max_buffer_len: Max buffer length
>   * @has_axistream_connected: AXI DMA connected to AXI Stream IP
> + * @has_stsctrl_stream: AXI4-stream status and control interface is enabled
>   */
>  struct xilinx_dma_device {
>  	void __iomem *regs;
> @@ -534,6 +538,7 @@ struct xilinx_dma_device {
>  	u32 mm2s_chan_id;
>  	u32 max_buffer_len;
>  	bool has_axistream_connected;
> +	bool has_stsctrl_stream;
>  };
>
>  /* Macros */
> @@ -672,8 +677,12 @@ static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
>  				       struct xilinx_axidma_tx_segment, node);
>  		metadata_ptr = seg->hw.app;
>  	}
> -	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
> -	return metadata_ptr;
> +	if (desc->chan->xdev->has_stsctrl_stream) {
> +		*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
> +		return metadata_ptr;
> +	}
> +	*max_len = *payload_len = sizeof(desc->xferred_bytes);
> +	return (void *)&desc->xferred_bytes;
>  }
>
>  static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
> @@ -864,6 +873,7 @@ xilinx_dma_alloc_tx_descriptor(struct xilinx_dma_chan *chan)
>  		return NULL;
>
>  	desc->chan = chan;
> +	desc->xferred_bytes = 0;
>  	INIT_LIST_HEAD(&desc->segments);
>
>  	return desc;
> @@ -1014,6 +1024,7 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
>  	struct xilinx_aximcdma_desc_hw *aximcdma_hw;
>  	struct list_head *entry;
>  	u32 residue = 0;
> +	u32 xferred = 0;
>
>  	list_for_each(entry, &desc->segments) {
>  		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
> @@ -1031,25 +1042,32 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
>  			axidma_hw = &axidma_seg->hw;
>  			residue += (axidma_hw->control - axidma_hw->status) &
>  				   chan->xdev->max_buffer_len;
> +			xferred += axidma_hw->status & chan->xdev->max_buffer_len;
>  		} else {
>  			aximcdma_seg =
>  				list_entry(entry,
>  					   struct xilinx_aximcdma_tx_segment,
>  					   node);
>  			aximcdma_hw = &aximcdma_seg->hw;
> -			if (chan->direction == DMA_DEV_TO_MEM)
> +			if (chan->direction == DMA_DEV_TO_MEM) {
>  				residue +=
>  					(aximcdma_hw->control -
>  					 aximcdma_hw->s2mm_status) &
>  					chan->xdev->max_buffer_len;
> -			else
> +				xferred += aximcdma_hw->s2mm_status &
> +					chan->xdev->max_buffer_len;
> +			} else {
>  				residue +=
>  					(aximcdma_hw->control -
>  					 aximcdma_hw->mm2s_status) &
>  					chan->xdev->max_buffer_len;
> +				xferred += aximcdma_hw->mm2s_status &
> +					chan->xdev->max_buffer_len;
> +			}
>  		}
>  	}
>
> +	desc->xferred_bytes = xferred;
>  	return residue;
>  }
>
> @@ -3284,6 +3302,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
>  	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
>  		xdev->has_axistream_connected =
>  			of_property_read_bool(node, "xlnx,axistream-connected");
> +		xdev->has_stsctrl_stream =
> +			of_property_read_bool(node, "xlnx,include-stscntrl-strm");
>  	}
>
>  	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
> --
> 2.43.0
>

