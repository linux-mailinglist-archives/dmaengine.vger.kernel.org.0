Return-Path: <dmaengine+bounces-10275-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F17M7vc/GnqUgAAu9opvQ
	(envelope-from <dmaengine+bounces-10275-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:40:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF14ED8D7
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 20:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 560E83009577
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 18:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6FC38E10C;
	Thu,  7 May 2026 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mtzxaBoA"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8FB3ED118;
	Thu,  7 May 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179255; cv=fail; b=DSYCFj1LpcxOc+u6K3KGGJnAQSf3IPuy1ZRZfOsiY0Q4ABstesdTdzORIt2/ADkZHAgVO/3n+En64hAfIk9WJo6n4EWv4TRyOl5FrBJQCVaPqB2Qn94z9jnpblUstGfEsf944WaspFuxE9l2XBs373t+OhK5IgbxWZ0Q3mw0prM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179255; c=relaxed/simple;
	bh=HWqLNaDZsibW9qoA1QWs8xSq1ukTUNRFIwgSrtiqyVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ml6d0TKZqmwc9BMEsZuBhH9jFcs4aJkfHA2YKe/oOu/vJ1rJXRl/RDb1vRIkhIqtYWfcybFQoAbj3QwSzZ/nRCQCOfIDKrAFyRJkhCJv0srXnDVMqY5qkVS7QhxSad0P9FRhio9vZBPimAnenzwRd8twS2CD4XcAq+vJ5xLAO0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mtzxaBoA; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wheWgTXtYl/NR75CpWl/6/o2F742nAaESXR8jxwhGsiTRgQ366mJCVmk/xYbgKHrqid67KX/uRLbIQERcldORLj2m/hOPDkjCvvnMCwECNapTZFlx0F1pDSwooWDoZT/AMMZa9OVPKRh13MbIfyD9qEWpKN6DqmndmSfYxopf8u2aOdRDD0VJ9c2noB7U+wzdL30mBSEmRnuW8do4ewdYbMPpLxrh3mopoPixxTk2MjY/Um9hWJMTelu471HHO7RSIUR6zO/Mpova72F5wi61a9ww5HDeF/h0KpNuZmoQSJQYefaJJB1RuvWCe6p91XNFlqJlyOftYk7XY9yCqsTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GigZ2qJs03OaEesbrj13tEgwx4u7UdMWaZpbgrhMgM=;
 b=i38g1dG3k76TD5B+bO1rtLLixDTEOJ6l8dZ8bFPcHNa70yj6ZDxuhfdjsrgZKLTlxUQ3DwvkcybOGrieX/DHtMX/OBhwZRIS9uLwJODE2rGm9tIayy4fO4wLwptWA3n96MCPbsPaof4svznNC3zUmgRo5yuj2+ASA+DZ2WEHcWEsekPXWhcHp3Z3ujrb4Huw/Fy8UCHssvDoNsLZMwK9fS5nDMqXi1UPE7uWEW2Ye1E8bpnYLuZRNS5hU2ezclRFLLevH26et1ebxik0cgk6A6qWxY3Ui9EtnQX15SDQHYL3yKMCkA8jbEZE4atROwsepei3LIoBPRqu0sIikQp17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GigZ2qJs03OaEesbrj13tEgwx4u7UdMWaZpbgrhMgM=;
 b=mtzxaBoAVcOj0dotl7p3v34L7fbqn/mBU0pXRqorIGOxwBZ72zG6Y+2a9twKYyymbpSxgABVCpMxx5lDypGw3mjA73Up/owXZVqf37k4p3xJfUMJliAqeWfhGHnfuzqWbPUk0FHAmiyXiGs0W0wlA+KjL+4YhcaUe6sws0htqJnzDNQCE/YFYXOMPRBhh3jq2YmAHQPpnV7MQDT9HgxLCa2X8+Uk8iCZKzqAuWLgJwKdGs/9QONuup2n2l395t5w1ZySEqrBQfkbGfZTI/a/7zkuUp7rm4DI667SJlTBl8XbfrOlYxtCTqtXdKcRWjC5PmIfu9gNK5cdpukG1V/M/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBBPR04MB8059.eurprd04.prod.outlook.com (2603:10a6:10:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 18:40:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 18:40:47 +0000
Date: Thu, 7 May 2026 14:40:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Ilya Polyvyanyy <il.polyvyanyy@gmail.com>
Cc: Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: fix vchan teardown races and LLI
 dump bounds
Message-ID: <afzcqvrcNu_CehgW@lizhi-Precision-Tower-5810>
References: <20260429131718.2557247-1-il.polyvyanyy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429131718.2557247-1-il.polyvyanyy@gmail.com>
X-ClientProxiedBy: SA0PR11CA0124.namprd11.prod.outlook.com
 (2603:10b6:806:131::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBBPR04MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da6547a-b83b-4136-598c-08deac682794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SYveG3HtAKgFbhoySM2KCvQUPqQVXgbJrIzUoXLxFDyM5GU9J7C65fKFUjHGJIQYIMDT+UZMSFHx2ccTlj8Z3aNtJqtDMOcoPH8UtXl1JxhgLoX0K0OdMo5oL1eEnPPQXNEH04L3HDZv9HHuroXcrYKw7v8GIgQfc2uHmZg8+yAIaWJEyH6zZOsE6KeJRDnQFWLLn4oNptYFz5FOg6ivK4zXXSqt+mrA8sux/J35plORDL3iEmVF5CWmGnVbxla7etafGqkP5YwTmbVf33KN4azrDrqcCbTYws2dFs93FKW5wWQFtiG71GGxBWKgfkh5yeni6llqzYxxZg+Xj6/3pVwszwtHXZur+3fbOcMbPhkzQaBqrweItC4Uo/E6eOaI2npRwJu1wMwU6LbvQKx4q/YInvOJoKNbmSG5A1oXI6nHJVB7cqyX4ErqTn/hAJadStCowpejoXPbPJfF2yDZJmR9B60QwnOQCDuo+5p+7udhh43C6V6lnB+VcEKnRSWGQ+EFY5ohFFeiraJ/eDWfLnYXSqhm3MhN/WoPzVlQ/CLt/u5m1TaXOq83YpnZ3rYJtImG0Zuk/2jMVi2v7GU1vo6kg/VPl6aX1F6xCjhqoUc0xyhHElOo2Myng/+i6vnCwq5GcH8t2zS0Vdg9nxEWPnLue2k5pHqQSID+Ou3z3Ts+w9q/GB2nlH5l+6yJP0l7DOVcxQ4umBdw9GDs/+0qVq2nupcVSQfIs/abJWsS+46tJwBqJBYVmXLq8xJ9Szy0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dmcPyiN2yw/RWwnYyhozfrow+HmL7YBBb+0GxY2oO3jyZ5OgNGC/q9IIE2U?=
 =?us-ascii?Q?qhM5bNdF9MOSNe/IM0EWMDaATO59g6SDaqyd4DO3rtgo+78ka1T9dGqJgLXC?=
 =?us-ascii?Q?zpqQYkh4T247CKQLAc2KsQAlFIR2V/l35E1j64bO7n9bLr3YH9htbEP6g7qZ?=
 =?us-ascii?Q?WWSaErzOZwYUYUYPhFLXZxQjXLoQi6aQrYj3kh2rog6s3m3whjUEUROkmTTs?=
 =?us-ascii?Q?5sj+G+Ar0Q8Yt1M7SmrMgj7+xZfHBSoMbdY3l+mJ2EfAOvr+EWQnzwNid3ro?=
 =?us-ascii?Q?fqCEIbrlcwAeNXsffh0JbntnZ6c1tNVDCCPwlUgnsJcviQatdkbt8tg0CK5+?=
 =?us-ascii?Q?/Gb6Zu0nFcCNVOyvcWwJQCRx619LDFjuoatwT21d3WDI4SnUV5sQpHmJ+R+4?=
 =?us-ascii?Q?TyDlCFxCzSUIVGbXsmga/ySLFo4+8ywtztYWqWOe2B4KSRDY1iHshdPyJoQt?=
 =?us-ascii?Q?a72dlUn+WAJq/zAGWOU7GnjIH23is2yErKrO5NAyCBRtA4btMWREVjnuQSXI?=
 =?us-ascii?Q?T8bW7JBVi/xrUr/8YlKeyetHo2ToSGTqmXgf6BjzTx6GZAy2+eLbet9xVki1?=
 =?us-ascii?Q?3kKyoguYGivvJ92+jrm4JEOubC49+Wk+6/NueN29MBdaI8iCfLfktC7tgunJ?=
 =?us-ascii?Q?t8lWWt8VET/YRjleGtBdtKeByoyoKG5nFrMohYhzvrYs3/EVRXaf1zzQXer/?=
 =?us-ascii?Q?RrPErP7gr48QX43ZSlbm/y/masLaQaI5hMGaRDgxrM/P+ty4aSnRbLv3Xq3i?=
 =?us-ascii?Q?iMFql7Y8lpnZiWE4LbEyD+EPH5R8nnPL0bzgZpnUszOIAg+BlNHkMK/jphXT?=
 =?us-ascii?Q?iLuoAD70/aRG2sORmKa1CG9osJjZTpgY/hiIpzeUpGidYwZdME/4Gkfi+Wj3?=
 =?us-ascii?Q?qy1NYprBJq9wA73Dp5BB1av+PZjNTxb6qIHqoQiFHIUSoMDXMnogv+1xNvCS?=
 =?us-ascii?Q?TNCHoHeJLZcqrFBWjiupNtccOKiFHXhpnbJCrn8DuItUUGzJAuuR4pB4gLOG?=
 =?us-ascii?Q?2VeG/bxIxaM0bgBJZOcqiOFUKNCRpP9RHGQUD/xaeajSI7Y06q5KGnVhfc+O?=
 =?us-ascii?Q?RBKdSoLgcPD94iYScPj/1Zhy0hTYheYF1q65i9u8T1QHV/tS+FAxNpWegChV?=
 =?us-ascii?Q?dgwy3a/8ZzKkLlqDr1BUPKE4rq4GPQg+LeF/nlOySWvxEZd0Z0bZF54li9Dt?=
 =?us-ascii?Q?a6IXDO5pfi61erUi1zQcdAyk6oiC65Y9CM4LEHQa6p6bKBXM76BmfR/YmU53?=
 =?us-ascii?Q?wKOZDaS7eqD6zRQFFZPSvHGnrg/DAnEQFEYODu9s1/zYxTS5tXbbfUVVJbUm?=
 =?us-ascii?Q?Pfn+sjKeYI2oj2ML+siCfYyrmKeM/cGYzeQ1ajF/e5ZXfcnLM+C01Pnl8iox?=
 =?us-ascii?Q?rdB84kSvZ6sQGS1VCdx9TuGbT759LgHrkmAn+/EAROfOWZk4LTr/JA+xWyEF?=
 =?us-ascii?Q?dUaWSOHsQm5nCLSC9QyftQgNKZdLxZ9dZ/zYIAojHXhRDb8fmlPyiPZ2usOq?=
 =?us-ascii?Q?9CfD55FbKgaxIeIvcRcuBEjV5b9N6GwirPQy89MARlY2ItGrVTH0wJ7IRh2Z?=
 =?us-ascii?Q?Ouoo5UXX5jR1Jf3pErqn43mJByGW7BHMvuFtthNSVMjZU+odNFPv16JiBKYy?=
 =?us-ascii?Q?YU32+MScVGuelxyHHLdVi8e0hyja9fH0mXBoMMoOFByPWeQmJBcbSb5UleKi?=
 =?us-ascii?Q?HsWqeFwv1Xj0ya2DdLXNv4pkYw3iAS59ZZWYSw//Hpwe+UdP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da6547a-b83b-4136-598c-08deac682794
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 18:40:47.6217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+cMxabnYE6urtXTiiu6I33lda/Gh1g63Yz+PRQMUxGHsFp/pl2858Zbi4/6xaVzsibBD+uQH8AmSjN403PQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8059
X-Rspamd-Queue-Id: 67BF14ED8D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10275-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Action: no action

On Wed, Apr 29, 2026 at 04:17:15PM +0300, Ilya Polyvyanyy wrote:
> The channel teardown paths free descriptors/pools without synchronizing
> virt-dma callbacks first. If the vchan tasklet is still running, descriptor
> cleanup may race with callback processing and trigger use-after-free.
>
> Call vchan_synchronize() in free_chan_resources() and terminate_all() to
> drain pending tasklet activity before/after descriptor list cleanup.
>
> Also fix axi_chan_list_dump_lli() to iterate over desc_head->nr_hw_descs
> instead of the channel-wide descs_allocated counter. The old bound could
> exceed the current descriptor array and cause out-of-bounds access in the
> error-dump path.

Use sperated patch to fix this problem.

Missed fix tags here

Frank
> Signed-off-by: Ilya Polyvyanyy <il.polyvyanyy@gmail.com>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 4d53f077e..4c317ee82 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -553,6 +553,7 @@ static void dma_chan_free_chan_resources(struct dma_chan *dchan)
>
>  	axi_chan_disable(chan);
>  	axi_chan_irq_disable(chan, DWAXIDMAC_IRQ_ALL);
> +	vchan_synchronize(&chan->vc);
>
>  	vchan_free_chan_resources(&chan->vc);
>
> @@ -1049,9 +1050,13 @@ static void axi_chan_dump_lli(struct axi_dma_chan *chan,
>  static void axi_chan_list_dump_lli(struct axi_dma_chan *chan,
>  				   struct axi_dma_desc *desc_head)
>  {
> -	int count = atomic_read(&chan->descs_allocated);
> +	int count;
>  	int i;
>
> +	if (!desc_head || !desc_head->hw_desc)
> +		return;
> +
> +	count = desc_head->nr_hw_descs;
>  	for (i = 0; i < count; i++)
>  		axi_chan_dump_lli(chan, &desc_head->hw_desc[i]);
>  }
> @@ -1206,6 +1211,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
>  	vchan_dma_desc_free_list(&chan->vc, &head);
> +	vchan_synchronize(&chan->vc);
>
>  	dev_vdbg(dchan2dev(dchan), "terminated: %s\n", axi_chan_name(chan));
>
> --
> 2.54.0
>

