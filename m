Return-Path: <dmaengine+bounces-9310-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uObiMqlEq2nJbgEAu9opvQ
	(envelope-from <dmaengine+bounces-9310-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 22:18:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C6227DF4
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 22:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A362308E847
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 21:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E827F4F5;
	Fri,  6 Mar 2026 21:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W1oMhPns"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15881F4615;
	Fri,  6 Mar 2026 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831837; cv=fail; b=hD1b/LONERXo/u8mh1iPUTubQtST4xKVNeZrcGzA4B+7x2p8DT0O+V/dfxhshi4ja0aDLt5+xLTQBru05qYBYTXcosjv/RHdxApWDcx9hajvZwLxFZj260kVlXIbZDkcTQbsyQGyzGns35dyp9BeLT768muQqa8fs+4RUUUvscU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831837; c=relaxed/simple;
	bh=UkoYJcaTOEOMYSHAx3o4Iq0nsRoS2bnHLy1Y6sqBpA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X1EJYIGRQv+TXkDQC2RHStjL+XTF34rHsp6wc4dP06Xuyt2t6jDoDVOLZ2BfQy4IH+1bD636NL4ScJa8pYquRPXCHs/7T4l3DQvUrJEUCFunYW63uLgvGZN68NVJAb1TZZiboQKztJ2c1tqY4yA9jEcGqlXjqD06M8NSm7ybaMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W1oMhPns; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7t5tmeDeg5aKHYX7ThSUBJv4uOZaz7GxtJC7qJFdER7WXFU4CEI+TAbqHZf8lzDIP9UNRgvNFEqEGNMsn84iSOzqXUMAJZz7R2U+8uzckERi/kwSPcs5HnedMi2aEFDHxiegp5bvkq5xKO5WwoWEvpnTTMgkr1Rs3x/59OvCVeoDC/TbU/7YSd/FYIiTziNDr3q4uye8wQVvL4xfdVoI44cDCXiMOby/JDUwasRVv1XIaPun0qFviUS74AV8qtSiNrJYbAxaqzGFbCW29ISHsUc5dkGi90Nasai9odfw2hSDM8YgEamuvsC7JUBSIJjPiEC6ybF0PX2qTv7wUvzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOyZcvPZKA0RSty6aUd8R4HSt/D83trTPnDe21EJDCw=;
 b=iHiZUclmdlN1WLAxmLcHiooVhaO9zOw2D67gszi8qL2lV7XjiveKdlG7lgomzOcmgWo1lHwLJFq1tRqifp7TZPW8bZIZRPtdY8Ad40CdQmE3F4PrkWVqx5AH+UubcU6oBsW8LXfPI7tqg4nOTOEJ4qrQg/Mkh3eoQnv84hgOGSylfol6PkZdHp9NiBnz48JKp955PqW7emQ5wzUflcQpzaCo4tNhNSkDIA/PK/ffcrmk5SABJDiRo4nTJ+/ksYuoNBOLriJeN+gKocA6bQp0EBDNydzNihK79zH6inieg25QVyK35NBOcrkPv/+d3NYwTAW7ttNvcOLjIlwiEq17EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOyZcvPZKA0RSty6aUd8R4HSt/D83trTPnDe21EJDCw=;
 b=W1oMhPnssZN/+dLY7K72Lr99AcFyRW0lJP6A7CbUnW08LlKGoXS8LS+ZRyg5Dw3RzcQoQNcrjHPZQNbZ8rDHiHfVrskZRih2ZXkPIMzXWOkZQf62sK7cCEbd8+T6NvM4S5fBP9p8+EQcff7+o6mk/MmGrN9zR5AW5h7ziFATerT6Hm1rpNeDrTLKYifJYja/ZSqhUxHKqV1ktG3129sP3Dy7KntUl3hdHogsSmmMP5PS+PBAtMyzeteY7HeZ/ietFjO7FZQjFOyhy1i4PGqxoimkrJeZ6CaNSwHOo1AkJHkMRNqO3A7lIyIpjqsBpVviTOItc3FNMiR79qIwPo1SMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU7PR04MB11162.eurprd04.prod.outlook.com (2603:10a6:10:5b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Fri, 6 Mar
 2026 21:17:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 21:17:13 +0000
Date: Fri, 6 Mar 2026 16:17:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v11 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aatEUuynXVVYEhWy@lizhi-Precision-Tower-5810>
References: <20260306115228.3446528-1-devendra.verma@amd.com>
 <20260306115228.3446528-3-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306115228.3446528-3-devendra.verma@amd.com>
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU7PR04MB11162:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d38b4a0-4ed4-4139-d638-08de7bc5bc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	BlPbJl0RMEgsvk7PQluxBigF0Ih9FRS5Ibca8xyU56rXUYOnEXrmyAIocWXJSzK9fG+bu+Mtt4O8ka9F6asRHiAcccUrUmfx13hrPsRMWAVBeORQkuhgyOOzXUQp2FSSS9HD/xjB2enDmyu3nMdUg3H6rD0mQOo3joaXrm0Aet+rmi2uEsa59g80dKZTCsFwtd2Pvt0TZZbguelUcYuTD9RVeHOdGwZn4jeYIHnixJDesA9tjPc3gDcBhF0KZf5xyyS58x1V8ijy57xuz+xUTBLLDdGY1v5mHE7YsQupY+4ouTn1QmUrAZ24jdTVeYAEQhLxFz6qBTzQ+/wtP2Y02yzowUaorKM6Qza7NAW+5O2iB29YXxuMunF+Em7ifW1Ty0n8jXoLco5YhYbdEmtrjW84LFnH5AdXspkTwatcHnXp0JqrB9VP3Y5iyLKcbpD0s0f6Ev/Le1r+02KkqD2YSciTy7LB64XFgEiGynQvVycVO0ZRo60uua+88tDkHK/oJlow810sEdwR9F61bjSD0TWOd01GrknESjoL07ewHm0zk2adJRCp3/wC1F+r+zTHtPIg5Ha0mcnX5ZIs+zsT+b7gLA/v2DyU3OzsSksxVbdj0sb48C+XsSvnD+VezQ4Lo/4JXrPiSxO3Diwfxqr3qCe6lQfn7IaFyBOyUXAm9FoA44JCkEePg8+xXBVaUdFa/Imv6XH8A81cBAqB/NexFaVF808C2TqZnORB4v7uNIU1HddcsQBHRvCSfZ0mM1wJ2ygosbrwbXd0Avc8qWIE5LUMZu1MX8kkTiNEm4rAakU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ujV1OEAb/vneE+S4RBlIHLRl7FLVL5/QEckY7+LJxTy7AqJdyG39fWjbi/GB?=
 =?us-ascii?Q?cYBc/xMPBjwusbKno60WlLfizKFEyrG0dgSFRw/TYbSy5+erApBidnF2tvcS?=
 =?us-ascii?Q?jEWlITcfyB94/HVaq7MqRrVAMEYMtrIYdTgbKAawrW0maL56K5deOcLH47Jb?=
 =?us-ascii?Q?SA2tsf6SBLmY63Sf44TLrfU3iTDl07mf3Qom0THgoNgixm+lCv+klFwH6WN7?=
 =?us-ascii?Q?p6gcvhP6cFTRw5SxqlnkRDHD5p5eza0hUAGKBLlb1ZOvrEXasIM+U+FIRx1x?=
 =?us-ascii?Q?4fBKYVo5KubvL+kVmfkduMP1ZMUKsnqF3+HdbBy3Ez4lF87nSmLoCrF13fo0?=
 =?us-ascii?Q?MCrkIL3RrLm3IbcQUsPEdeEVcOIHwfxtTZ9mT2GjkIL845CineATGPvrNtvk?=
 =?us-ascii?Q?HtdpDADzJp8sTKt8XvWFIT8VQfwzrzPszfshU1aYsePid9YhdvS38YQ1QgEQ?=
 =?us-ascii?Q?BelnuMznOvGIPPyZltrFLWhfWZG2FG9TLJcDRRbyuAaVKMgutZasz0i+/t5v?=
 =?us-ascii?Q?HNrm2UdsDq7mLvabtbfMPzzKUxIgA8UM6/szVhCXcRMvZwYlS3YS6f8qtY8I?=
 =?us-ascii?Q?Y0d+5oqCtNZwEuAUsu7vLdXHIW6sIgAE0cchHCd6KUzZj8TeJMar/GsdTQXe?=
 =?us-ascii?Q?E0gILQw1h9hH+FybzGeIxJrjhZBoWOUeMksdJFS/3GaloBSvolzh+pJX4QUL?=
 =?us-ascii?Q?rVmu74hbMY+dCbfhFQrU80SQHgUan1EqqbNmMZGQOQrQP19O+gnF0KCeHIdo?=
 =?us-ascii?Q?tTonxtzsBAwlc+pRQ16jspnJlwDe5Hefx9uuIfGkGqCw33VTOtWR8eP5woZe?=
 =?us-ascii?Q?JctqSYaoXTSav0F45SAb5V9kNbzFN3rPzTWCeyoYgBtpeemsiN1MBeVBKE9g?=
 =?us-ascii?Q?6l1RqDh8ZvQOmceE2Kb8LV0uFcsMkdF5N8eDBmZWn8VwfAmM03x187FIzzB7?=
 =?us-ascii?Q?4Nl0ltEOMStVj4RMW/hwFZ3R9mOKBqj0PF1dxa9alE67TM85/gYrcH79GvoQ?=
 =?us-ascii?Q?sjwezdH2UNPZ/Q4bsWsbMDB6O+bXkTF7ozaRGmSpSaZ9wREV7ZhUI/h1xWoO?=
 =?us-ascii?Q?IbFvGPT6nxuAF/Ky4vUEDFtU5e+ab/+6p/CXdABMzMCpBGLqRuBYM+mcQlez?=
 =?us-ascii?Q?2xh12eRT6jYi14aO/9ETf4c5i25bIYu26zV+63dImA9wQ2UmP/c8GzqOyVDX?=
 =?us-ascii?Q?be1sWlqRsgJJV/xoNmqHNZUmZyb44/vddpfe2V8/crzm6TxvypMJLR+vz9zm?=
 =?us-ascii?Q?R63g39EQxFRG1d0qn0VZ2oXycnAKxxFeV0CjgHyvEMioel56hUKmqArm2gd5?=
 =?us-ascii?Q?Ag1Dcqc0pWUgh3qL6mA62QZWoOpP0xxt3OrEbIS/q6dHeuK57FvT65+yvT2N?=
 =?us-ascii?Q?JWLT9tyOjlTxa8IdiTWvKDoDBcb3XWhlFg0Hu2bByJcy6edDcmlcKpVBTSm5?=
 =?us-ascii?Q?ucrQe8FWnlpBxydulMoYSU7hvBkjZqHcUhwKP6gOxi91qobllE9yC6SMkXpN?=
 =?us-ascii?Q?RXi3RhJFxis1IKpl9Yev+VlDdUxIhbEChqlLS/0Zlq438Dtd1W+ZKitfgQ5K?=
 =?us-ascii?Q?zSO1Pd+CdPjnnkXt591W09wWy2NcB/iNI5xmzOQ+aLkuRUsZbuVr3REKpy0x?=
 =?us-ascii?Q?/X4G/4U+rjRztPxFP3dzhgBYDA7XJS08nR3DZLmiDgv+Z6BrKB9nU7frC+45?=
 =?us-ascii?Q?bZiHEczV0chEO+JBP2nqr91Yntg3kq6PtIHmxG36apSwu9nQF8/Htsb+Teje?=
 =?us-ascii?Q?e0p0qsmjQQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d38b4a0-4ed4-4139-d638-08de7bc5bc5c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 21:17:13.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pktCzPyjPjYcg22SnHdFpJfE7EuDLBze4tQ5QZJM1vkUU1fHtNYZjJ1LCXK85Zfbkb5ZFG3j46zePdMYRV8fUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11162
X-Rspamd-Queue-Id: 6F2C6227DF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9310-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 05:22:28PM +0530, Devendra K Verma wrote:
...
> +		/*
> +		 * When there is no valid LLP base address available then the
> +		 * default DMA ops will use the non-LL mode.
> +		 *
> +		 * Cases where LL mode is enabled and client wants to use the
> +		 * non-LL mode then also client can do so via providing the
> +		 * peripheral_config param.
> +		 */
> +		cfg_non_ll = chan->dw->chip->cfg_non_ll;
> +		if (config->peripheral_config) {
> +			non_ll = *(int *)config->peripheral_config;
> +
> +			if (cfg_non_ll && !non_ll) {
> +				dev_err(dchan->device->dev, "invalid configuration\n");
> +				return -EINVAL;
> +			}
> +		}
> +
> +		if (cfg_non_ll || (!cfg_non_ll && non_ll))
> +			chan->non_ll = true;

this logic have a little bit complex

if (cfg_non_ll)
	chan->non_ll = true;
else
	chan->non_ll = non_ll;


> +	} else if (config->peripheral_config) {
> +		dev_err(dchan->device->dev,
> +			"peripheral config param applicable only for HDMA\n");
> +		return -EINVAL;
> +	}
>
...
>
>  struct dw_edma_irq {
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index b8208186a250..f538d728609f 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -295,6 +295,15 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>  	pdata->devmem_phys_off = off;
>  }
>
> +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> +				 struct dw_edma_pcie_data *pdata,
> +				 enum pci_barno bar)
> +{
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> +		return pdata->devmem_phys_off;
> +	return pci_bus_address(pdev, bar);
> +}
> +

Reduce each patches's changes, make each patch is straightforward

Create Prepare patch firstly, change pci_bus_address() to dw_edma_get_phys_addr()

just

dw_edma_get_phys_addr() {
{
	return return pci_bus_address(pdev, bar);
}

So this patch just add
two lines here

if (pdev->vendor == PCI_VENDOR_ID_XILINX)
	return pdata->devmem_phys_off;


others look good.

Frank

>

