Return-Path: <dmaengine+bounces-9735-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAx0ETmfymmg+QUAu9opvQ
	(envelope-from <dmaengine+bounces-9735-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:05:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EC635E570
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F50C300BDB8
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DEC375AB2;
	Mon, 30 Mar 2026 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f4rSIpXG"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08143431E7;
	Mon, 30 Mar 2026 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774886347; cv=fail; b=jbCeNvkMm0LCOpOBtaV9erN6MdHJzJYPqrTjk00SUmCGkTN9AWb3UQOUHEyCsNEz0ov7EB1F5m+m+CFsecO79+I9ze3/na8sD+iDXyep8T/KeIgShN3Nu25/EmFSJ7jtVX0xGhz5EFLZAdLgCUlfIiVuRRE/2lWe2g2LyWXSj2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774886347; c=relaxed/simple;
	bh=FQQ+rMoRGNvE74vxeHC8YW+A89ndEyYhTonFPUsDASE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RWOnGsqtbUR7UfDrbqF9yswOvv6SpXKIVL6trLHD38KwKvly1i6MrJVenioCLQBvFc7gUu8xnayvd2FyXOIUCkU+5hWsSags7YXf7RQ0yQlGa2+4829zI41fwyp5Hfkv/KX+j7tiz6m4pD1ILzGCbmXsYLwFyB6BzxziMIFkino=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f4rSIpXG; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCzmbG9xLIvRoK+mXCOQVihPP1lJNmr9GuSPXLEjOZ9R0c3OsFoe5zulEeDOTatD1FYmIKxjaOhhumERB7GXE+XcbOv5S963s+GcVgEIJRynrUesrR5LTCi1t/I454voe66GJt6/myDt2uNORlAN2wDk6borQ463hT8OhMkwJmpSoL+4ibHaVdn9NzdivRm2sM2fOeMhqsHr6yek2fFY6tDw55G0GkdrmKusNtjLmD/NoDj3qqGAlEh4u3I4NFwOBZ37RvFncyQO2Ibxi5NvZn8lglFkrZWijRD0hJp+i/FCX2Xz6dXunLEqCWmFUBOurphsgB3Fv6PsTwB7Ee8myw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWDiTD+U+UjgLErWuzI2cWp9sivMplzLUYOmq3MVyQ0=;
 b=C6SZNSNw8LK/vrpxxIPaZHPm+9JPvPDcaoCzXsrAggZhkoNnXHPnwXWw1KISr87maUeUbaOto1aRNvhgdtw3y6H0d7B7oKkLg4ZNYwARd5nSqvD90doOhSNZbWYcWQLxZ1ptRqjyJbrMVmQh+bDGT9DsAV8v0ODXW0ut2rBNwnf9k2Vxy1r3xlRwumgBkAf8VBadxNpRFJlcStO9+1HSlgXhN9CkK5ojXA3QTe3VUPIDVnNgKBSmWohxNX6DkTX5CfQv80wng2+0zHUNltcWcmANAM89LhZQS5sra7RN0AUiUQXTvenbE9vJONazEpA8I5FN6tqgNt3h8J8kJL67lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWDiTD+U+UjgLErWuzI2cWp9sivMplzLUYOmq3MVyQ0=;
 b=f4rSIpXGfqczcqZnVVg83YQfFhRLm2N92QqbiGkkadWoFzxSw/3NfYVYFsMYDb1WrP2OBajFLWJVDx8QX6xVPQhsccOpl+mXcU+GIxjaiDf1Rpz5C//aBgnY+DUOQGTcJriIeKAI1Avv1WGiEsQFiW005/W+HL8U9Im5VNLpNDvYaoF+dQv1AEy9EGQsYTDeTDwPMCiPQk0gher8U7dgqj7onwXLRqsB3cy2auNmKusDJJvolyw6+Pvz0H7MNnTiy8EqocyOthxreD1qLz7KiV+/xCKbAX2oYExdomx0LdcuHTCVW712XfcmYKllNG3NT5z4e+1LerBm4KQpnwIH5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10377.eurprd04.prod.outlook.com (2603:10a6:150:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:59:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:59:00 +0000
Date: Mon, 30 Mar 2026 11:58:51 -0400
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
Subject: Re: [PATCH V2 3/5] dmaengine: xilinx_dma: Extend metadata handling
 for AXI MCDMA
Message-ID: <acqdu-oEKU1o-qrU@lizhi-Precision-Tower-5810>
References: <20260313062533.421249-1-srinivas.neeli@amd.com>
 <20260313062533.421249-4-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313062533.421249-4-srinivas.neeli@amd.com>
X-ClientProxiedBy: PH3PEPF000040AA.namprd05.prod.outlook.com
 (2603:10b6:518:1::4c) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7720121b-ba73-4420-2a64-08de8e7541d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BQ0tPT/AsSv9s9cjDjiofKoo5t3xjhz13WyG04okT65GftLrl41/g0Gc5QcA3wV0iKVh7X7kO9uXcAuCnSpxXNBEhIyeuO4TRt9S1uHAX3yNlFTvjV8xgGvM92ClvFuMIsOr8AUp80c0yiyUdUgOKQMl4zPZVwvhXi2AhQFM+/G4vpFXTRMdaqzFDCjK7LVL3B8W6GHoSqowIIyLawIjxdtbPcbg7Ne7LhrrwEyxVC5cLDJQe7RHHFZJVQ0PZqBJFhMc9GopCslzPHPSDdcfAKkyGVFevE5zqqKMJefAFY83jQ5V081RULMtLTYgAirXVJpZin64RIWciYVLdpzyO3eyjCvAMPWPYYJXDT4+Oe5kmt/heAtPOGr/mdb+K9mOyCY9zJQXJa16w5Z16U12nIXex/XTSqef/+QGRpRLu0ObfKLg/DI2XNpEY1ovxC8BEntQ4VIbQkhcj24NMKXqOMuF1bRT4FVXUdhKfOT9mUKqe9/yrcLFH+nz1SpKCmYKgAQHzGnPNmrbPUOx+QlRLsr9BAB5mIQ6kJKTFDQAj7qYPmwVkbWCsgkSJWPIlEti89nOFdvrdEXJOZGgxVvmMiHRlOn49GJmeS1Q9qzKul7LSJTDUepRloji+EUQMTXePpUtIGgXv1vH7dM9UNia+rzoVcmm/9NTN9uDLCgQ4Z0lgMQqda8QxsY8MrrMIrv8U/Sd2SWYhYfEuB3+fT9Aw1mIGq7vDF+/cXjCvy7UbHnpmOCQhMLEzZLTmmk3CvHmz05XVnsf5KIOnRh6EPuKUzzDcdcs7oTZkJbVU+xVZbo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+vxTq/zuy+dXZzFOLsb21aKmuIOspNTIDsK3SGzKWyH8pUb0AzVt8nY5y36H?=
 =?us-ascii?Q?Hc4MfoiLMTt3z+ybM6p8i4nHfWm7Z02P89l0f867wyBYo/LGcxxbtS4T33oD?=
 =?us-ascii?Q?Hx4vvBJtrEB+HcTXC8iT8F1fJMwmcOn3+EfxlhRfgamF7RRh45ptg7LbMAAi?=
 =?us-ascii?Q?+2gzzTFo+kye7Lh+zUrVwoCjJbywbKznQA0nlbpVMoWI7DHRN8Rf95rsvucW?=
 =?us-ascii?Q?ZU586aLtTmUgYmK/IKSA06SRu8FwN4uSNhY6tbEoGau07+9Wym0bmTzE+cJM?=
 =?us-ascii?Q?3KWBOxQhg1wdMqD7Z7skJTtrPHmEIxTSaY6cBnAE+HwCIs0l4HP3TB7X9mWp?=
 =?us-ascii?Q?EG0jQlDOrI9LU4v79mgAZRnw6PqoykbNSFmHY39eNgj2ajelqUVC9Wh7+b5+?=
 =?us-ascii?Q?XbaRQWaMeIrPZY7s9IRCe5Y0VUEMQ3Pt9dj1qsvenuM2eIbvLI4b0ahShY5E?=
 =?us-ascii?Q?T14Urx5MEV7fwoyD6RkHz16SJiQyFwpc9VNeu756cak3+V062QR4WPdNeslh?=
 =?us-ascii?Q?1JECIDk4RmynH91zYWpHwAG2xJ/NZ88fSMJ+8TpBjIuf+88YouY/IMohpwO8?=
 =?us-ascii?Q?dPcHXtDzxX9+5TOE0sQ6UMjlWMbAulEw3/X4pzRN3MSDaG5IzNs2tgdGjgzE?=
 =?us-ascii?Q?D04QXykM55jHp64wn6lZ613d4y6EWKCgZ1QQwkM5+OKGu4amvICvqNC4xYXH?=
 =?us-ascii?Q?6M8bP7QPjFM+Q5HKS+okE4Is44pOTbU3SAdqJ8pBHeRn+n8ILIPfg3ZrCMq7?=
 =?us-ascii?Q?2SYK8bmEdHkOIQznIROyCjzONtkoRfIZbi2CnumoKuFq35kM7KlPhnDM891q?=
 =?us-ascii?Q?cYnVbhVggj5gmgmSvrzbIThSbAjY4kmvldwCs/ih1MMEuAObztYnoGXuvY+K?=
 =?us-ascii?Q?iIXkU24rSbNnru1ZAkI5sW2Mad3AaN0y3JG9RsmsXPZxO+3ZYnSagY7dvsvY?=
 =?us-ascii?Q?OTo8CyyiV9mEdTKc0+9uK37Q43nrTisBCJcav5zBTa5td5QlXxWb66WdKfQs?=
 =?us-ascii?Q?CJ+YuRYsXXKnwM4rybztncCkNsZVyuIaMqlv+JNkCIWAW7y4NmghOZj+GuUJ?=
 =?us-ascii?Q?li/WUDLDZV5YVmV/y4jPjImooOjNPpE+GHVIjTIjnyR0PtYLpERQu1JoScNb?=
 =?us-ascii?Q?5cshZDNZNr5SBu0qPU+ZtwciPzQtnlaWRm24B3i6KBYFrR1gXevQ1tgq9cYn?=
 =?us-ascii?Q?X0rqsUIY9+GlxGpWoULB+ZdiuACDL/DPcDODK+dwLhgVrHkhqKvdVtYMLfri?=
 =?us-ascii?Q?7p68I2L1kBBU8FvTEiN6JH6JxVpNyt2N4nkq+UV42YZ8aOh/2Ikq+Ww9BSbq?=
 =?us-ascii?Q?SnwCTUozogK1fU71jVnRRuUqiON5h/SDpBTZpr7EdsytejfFmNEmh2787qFu?=
 =?us-ascii?Q?YAJDEe5wiLVB4crgZ/rnPfyjXa6NFL1nhaVAm6F6EYArpqBJ0dvSJNLUkGWG?=
 =?us-ascii?Q?KNB/v6G9I/ou+z5nhNHWd1CJmu/ZhRENSJMJAGgEOREjzX/KDZxC8otxqQ4f?=
 =?us-ascii?Q?a9Soz5PBLjf1PEnlVY7kiexch+LisV7ZKTL5mYb0A+FOSuuKObdgSb+C8HQJ?=
 =?us-ascii?Q?f51cAw8WIvSqymrFIyPxPMIZTGYzlv9zF9ce64CkhgjG5FpX4/lGlLctOeVS?=
 =?us-ascii?Q?EY++JEnIvhTTiEcDy07BMSVExLvJtqGv0GTVp6eFIs0h9LmLDje6gXhBpHMZ?=
 =?us-ascii?Q?s0irtVJrrM6W7W//Nd96h2Qeg96pqVVG3OQ+RMrqiqO6L5LHjKuKfpoLYlG9?=
 =?us-ascii?Q?CInOcN+/oQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7720121b-ba73-4420-2a64-08de8e7541d0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:59:00.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9o8hlsLq2vUCjRrHYdVDJADqy8FvfNg8obp0FVR59dic6OVLqwV80WMSaVLKBpOoc/R2cFXm9y5E6yl6yo6ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10377
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9735-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,amd.com:email]
X-Rspamd-Queue-Id: 96EC635E570
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 11:55:31AM +0530, Srinivas Neeli wrote:
> From: Suraj Gupta <suraj.gupta2@amd.com>
>
> Extend probe logic to detect AXI Stream connections for MCDMA. When
> an AXI Stream interface is present, metadata operations are enabled for
> the MCDMA channel. The xilinx_dma_get_metadata_ptr() is enhanced to
> retrieve metadata directly from MCDMA descriptors.

Need extra empty line between paragraph

> Add corresponding channel reference in struct xilinx_dma_tx_descriptor to
> retrieve associated channel.
> These changes ensure proper metadata handling and accurate transfer
> size reporting for MCDMA transfers.
>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 00200b4c2372..52203d44e7a4 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -222,6 +222,8 @@
>  #define XILINX_MCDMA_BD_EOP			BIT(30)
>  #define XILINX_MCDMA_BD_SOP			BIT(31)
>
> +struct xilinx_dma_chan;
> +
>  /**
>   * struct xilinx_vdma_desc_hw - Hardware Descriptor
>   * @next_desc: Next Descriptor Pointer @0x00
> @@ -371,6 +373,7 @@ struct xilinx_cdma_tx_segment {
>
>  /**
>   * struct xilinx_dma_tx_descriptor - Per Transaction structure
> + * @chan: DMA channel for which this descriptor is allocated
>   * @async_tx: Async transaction descriptor
>   * @segments: TX segments list
>   * @node: Node in the channel descriptors list
> @@ -379,6 +382,7 @@ struct xilinx_cdma_tx_segment {
>   * @residue: Residue of the completed descriptor
>   */
>  struct xilinx_dma_tx_descriptor {
> +	struct xilinx_dma_chan *chan;

async_tx already include dma_chan's information.

Frank

