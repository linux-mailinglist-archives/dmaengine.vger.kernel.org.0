Return-Path: <dmaengine+bounces-11175-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u6wQIUTkIWopQQEAu9opvQ
	(envelope-from <dmaengine+bounces-11175-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:47:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D437A643757
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:46:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=dKdA45Wl;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11175-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11175-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 103B8300575D
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 20:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824C33C585F;
	Thu,  4 Jun 2026 20:40:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8DD385D75;
	Thu,  4 Jun 2026 20:40:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605618; cv=fail; b=QQl9cWhwIbY5U1S8Z9DENTl2f6jQf/W021PHM+nHSCEF0zf/vfIk81oZ+gbDK4TSxZiXfm7mSYPU0+UTmTXnc2Qz89e3Arjhpo/Ur66Hw0me+VX6dwNGNMiyB92nDDcOQQ0BUZNo41LCrs0ae4DeWGmfj6AspGWHM/HXIbeDLMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605618; c=relaxed/simple;
	bh=+yMRiKZcUDWHpaSWLjNAv8Twe6nOM8QF36NioQc0phQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RL3ljBdiv5RDQxelMSWmvBNsb7Cfc3wqmoDmwhmGejNONUXxufrFS2r4l3jCQTBsaHHvUvODZJWAf2RZ1MxzWJyyvLAP/Q5WuTWkcR+TwHidpbTcrvsOn474kJk8AK+6Sx/y9EBYZW0tJiASKFyNx0BiY/DzXOHSyUGTnJ9/ngg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dKdA45Wl; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Erq35ujb+S2dvvEFJvmMqkazk9q1gGwRwbzcD22j9Iy6kpTn/GjX15/qOPvAq24AnO29cb9Fi4FyFesDl/p2ASi2cUfLthMwiMpEkal7p7TpW5+xq5YXmbCl+FCm0wwXptsG2XjgPkLiQXqaxK5ozBNYp9pqF1HIefhO6ny2VyJeZqwVtZU8I2MWsabnrR5qUGU3hCYuclBXd0VpuSRWYjV68+6yCobOgaa65XPEmJvBvdkLTdnLAoZvfE/WaucAm7poef+hzPmXsqdFIYUAa4nUYmhYj1nhscy2p5Qx/8asknLPw2NTk/JXA85+KaZVggzoj7ABrYI+YNg6gUyRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDpl7rLn5izZERgTrRSJHX14mnkX9qahPxk2Ocsb+EA=;
 b=jgV0CZq86xHmdC2uI8an6YvtQVyNAqull1HimgM+wEp78oHyXpIr96gLcyvGr3gdHM46RktfDXwceG/bkhqBllQxdShdWjZqUkpYngkG4Ygu2+7L6r9H2rZh5bZ3nVHpxmNfAhjAOgcdwqb8HBAB1gc0GrTN0NCECae3tZmoK93G5ZU3CaeLTqo1Etsjbe1H91vsTkKM72HfkCFR9xPuQUYmV+cqZ6KLOdG9qOn73nkOPe6k547gwPdSA5r4KAJfYGrciFwvmr8JAdubmhnViQKS7E65T5AauEzg5YkJg5yFwXmAZo1P5oPVuC0aX7ZhkgJSkd8rHXB3y/TGVmOH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDpl7rLn5izZERgTrRSJHX14mnkX9qahPxk2Ocsb+EA=;
 b=dKdA45WlcBhqLQ/NggfPHai8Uzlb7Dvibho/J906CP9xXPYL74mIxkr+MlIdRuZMjITm58fWBax202kLKGjqYd06fGSQAzKCU4bHx22yKE3DyPLG7r5j8knm2YgQVpYW5DlOrq/LRq1EV9E1I2RxIh97viOCwLNWBuCSisDX7LKh1tRf9HMVfPyf/Hz7G+7PhsiyJ/QOSfMg48MmUUj0xDqvPgT4nVTobv5x9QfkoHyKN64py3oILd0bVP+icqKgm8NwICz9v8IC/2uFZMj7jrVYHOTdx+Dnnw78SGFffS0Nk7mBsIBf8feD+9x+pMyrWamw6d8lZPSIMsBIjRMeZg==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11310.eurprd04.prod.outlook.com (2603:10a6:102:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 20:40:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 20:40:13 +0000
Date: Thu, 4 Jun 2026 16:40:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] dmaengine: dw-edma: Add hardware channel filter
Message-ID: <aiHipgrBEKYRZqhg@lizhi-Precision-Tower-5810>
References: <20260525062420.3315904-1-den@valinux.co.jp>
 <20260525062420.3315904-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525062420.3315904-2-den@valinux.co.jp>
X-ClientProxiedBy: PH2PEPF0000385E.namprd17.prod.outlook.com
 (2603:10b6:518:1::6c) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11310:EE_
X-MS-Office365-Filtering-Correlation-Id: 00931a3d-7966-4517-c798-08dec2797a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|22082099003|4143699003|18002099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	eBDTiNnyBpwLnbcXb3hjVVu/y6tXk//xTZnv4R5iVZ4T34DuS5y7CMue9TBbOpt7sYv0FYgse/l/b84QNPqRku/NfA4PdJ7MO167xAeGK3o3K54ONua810lZIvNBrgcQbOjw7qbKlmPvIU67Uqp/YHyw6SA4nMnbb12R6SpLUJDvpE+uEvbKGaHiq2C0VivFpsUcQFkmT1zAokpB3B3T98e757zsKfs0Md+SZQbEOJACjC+5ZdjoL83a4V01m64C2H69cwikYnRwzUNiMpuj5PpwXVrzBnqxznHICQSPPB9K9LsXxRtz4Nwo6IQ7uOezWRPgyRiZywSWUkA0ohcQQ2nkl+cvirrwnCKljOLQ3PlI7lq8NBkCPsNpUP+cMdYn4FGOTU+a7i83pc2KO1KkUWJKIhIZoZdcegAqEw/c6EbvFYTAdUsVa0NLpSf+VxGmlYB271zuG/aS47VssNcfuuBq3H16dLnT6+4v2Y9V+4sXevwZXE+UrQIwEsTp4JWLx+Zs1NPSfrKUJx3p1wyEILSuk3Tzco6OZHS3D0yrHx7qpm86i5cHAUM78bkfPlsIcH69SxY5yFvpOhrbBR3HH11niRlrwMCVi7IIptE23li74AqOuUG6Ext+DczY9gawOCch2RHDKjWaCnIqFjb0Ew1ebsmBgCAkRR0Q7Ey8jVADdLq2TLChHAH5/ZNadGFkbnIieGBZ2rzdd2fGQwtZWJV0BbD4saemCajFG2wisqUpPIH19CVjHTNXakNglRSy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(22082099003)(4143699003)(18002099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ebzROD5CqT3YgDy1b0k+9StAWEAw2jjj91hFoLOZLwKmKi/ZQ3j6xVqUbnMd?=
 =?us-ascii?Q?IO7KUGjg94CNxt+yusb5BIfq8xEoD7QHyyODrNM15PGGy/yBwc8jMoIebOAn?=
 =?us-ascii?Q?m/Lj/D5GZMQpufYeCXctKfjJLddh1ukHpbIo3q7GdOP5naEfeSNGAzXqiRKu?=
 =?us-ascii?Q?i/M8fCceqefqsM3BWKnFzwO2DQGRsSL0ZF3MRra52cV6xsNxGK3IxlJm404W?=
 =?us-ascii?Q?OrgzPGb1aZ6+WWa3GUp/s5atVXYmJddPltMown1sHG9yria4DVNnK+IiPdds?=
 =?us-ascii?Q?Itu6C8IxiB5lyi1gdZzweyu+gkuya4F8ohcT5b7AW9nuFDHMGMG41SsFZsSn?=
 =?us-ascii?Q?3SCczIfrm42N+kZlFxpKjanj7oLa4zYsSW8VJqK+agYykOOJBDkAkvo4+qx2?=
 =?us-ascii?Q?wrh+JoFaoWnX25ldLSaBOXF7jkTvIlaMjSUumODHa69MujcMbEQIxMmrt0pm?=
 =?us-ascii?Q?KkGURh/LvosfBAwSkAOr1zK5KUONrJKaEiQjKrfgNKukIn2NBI82drEsD84j?=
 =?us-ascii?Q?jiDtcGalK3N0cHZ/6QnWbxbMpZUP55rja5WN9gnHeZkj1GfwbAIzLTU36QBk?=
 =?us-ascii?Q?+e26mUk/QizOd8OQzGjysJJEqe4aXKY40KKc8ApTDIy7dK3SDgc+iVEyoHbp?=
 =?us-ascii?Q?uP4+0l9R//fx95KFoiD3iSRjkK016G6fjdoVP1HjpjyS7e3pTKXacNsZe5wl?=
 =?us-ascii?Q?usV1DhlNSgEBih+O67LuIUSiSyLgKQJKLXgXte/tg5tCvfMAetfWNXKN7zqE?=
 =?us-ascii?Q?YV+RmlXfr4I/VqrtKSSsLgGIdYkXuHXmczVF0V12fVFoyuvWcOxIc/bkAmHo?=
 =?us-ascii?Q?AnIDis9KOdGXlcUGlamseJ3g35Px4eKJbVASd0YyMPQjRqsBQca6ScBXz0d4?=
 =?us-ascii?Q?qUaJk/GbSGAmboEsnx2zXzIk3eRxmRJfA9qNvXDrP7xtySZpTPhPjnYig8iL?=
 =?us-ascii?Q?GO8X9bhP6jyzZ0x9w7GeLxVdWEB/wVQUczyFiu9hMgVycer8WOiiXfZubcCG?=
 =?us-ascii?Q?juzCotDrZnvt1Owiv1fqbkJ+npWjRxJ/4Ixc0wKnAgnqsLNdDMWWs9am+xNX?=
 =?us-ascii?Q?Rd0Qv1C6H8FyG7hQQ7nvcj+kAQlrxqMoKDRVFz+krXgSGtqEUj7N/M5Rqfcv?=
 =?us-ascii?Q?bmAJ0wcACufK11JQe2WEXUqwoOJVm0aSTKV0xupHyxd2urwnlk9qlarF0mJp?=
 =?us-ascii?Q?hLVwZbqJitfy4h5MlG7IKSZpvvDlc9FwxsJidb4S5KNiLNjeTqSRrQKWhBCL?=
 =?us-ascii?Q?HCH/urbhGyleK68QWbY6nMm3uaUO7uW/vFGS2r74kuVkws1BqQmkUBtvrLQp?=
 =?us-ascii?Q?hZWydtOwdjCpRID02n6DaC40Xxoo5V3Ik+foOJzKzCDSj74ABPYbW1s3qQ4c?=
 =?us-ascii?Q?5Dulb2r80fsPugHPSdEwbFY24fGVoDTyOmwLmEbq/LNQiXklKJ96s5rWLOrB?=
 =?us-ascii?Q?KpXCk6OHSJeGDdRusJH46KW0xXMZQnqczL0pyfnwzaWZykc0YtC7a9iU16Ib?=
 =?us-ascii?Q?UcHHHFfXOLXgkiwnlRuM0BG6InwaZvlqiSiyLEIoabXHPeGbKbmxiD//yajU?=
 =?us-ascii?Q?XBHCOC20/YohyCaz/36DmmCUzT2aq3nysSANFPqFoFrYEvO6xMh/Ag71E/mD?=
 =?us-ascii?Q?+1XmojGviAGc80ZI6BPQJ1ohanMbCiezgfPspTzU/dUTH9ml1JJSKH2Oe4iK?=
 =?us-ascii?Q?zh0vTQgDu1C+EElJjCNfOXMh3RB3Tn8iFgUYdB4MYf66/ZIz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00931a3d-7966-4517-c798-08dec2797a59
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 20:40:13.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJrqTeZqRr95sheZJbg52NweU9rnz6vah3aG0VcZwpzzmdeW6/+9YVNlwCd4Rc3wXcbIz4Xabvsfo5/RS2zYjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11310
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11175-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:email,nxp.com:from_mime,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lizhi-Precision-Tower-5810:mid,synopsys.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D437A643757

On Mon, May 25, 2026 at 03:24:09PM +0900, Koichiro Den wrote:
> Add a dma_request_channel() filter that matches a DesignWare eDMA
> write/read hardware channel by hardware channel number.
>
> PCI endpoint resource enumeration can describe hardware channel metadata
> and let consumers claim it through the normal DMAengine request path.
> This avoids returning an unclaimed dma_chan pointer to the caller and does
> not require making dma_get_slave_channel() public.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v2:
>   - New patch. Replace the raw channel lookup helper with a
>     dma_request_channel() filter.
>   - Do not make dma_get_slave_channel() public.
>     Patch 01/12 "dmaengine: Make dma_get_slave_channel() public" is
>     dropped.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 15 +++++++++++++++
>  include/linux/dma/edma.h           | 18 ++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2feb3adc79f..80b4a168225b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1189,6 +1189,21 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_remove);
>
> +bool dw_edma_filter_hw_chan(struct dma_chan *dchan, void *param)
> +{
> +	struct dw_edma_hw_chan_filter *filter = param;
> +	struct dw_edma_chan *chan;
> +
> +	if (!filter || dchan->device->dev != filter->dma_dev)
> +		return false;
> +
> +	chan = dchan2dw_edma_chan(dchan);
> +
> +	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
> +	       chan->id == filter->id;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_filter_hw_chan);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
>  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e315..3e15cf83b784 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -106,10 +106,23 @@ struct dw_edma_chip {
>  	bool			cfg_non_ll;
>  };
>
> +/**
> + * struct dw_edma_hw_chan_filter - DesignWare eDMA hardware channel selector
> + * @dma_dev: DMA controller device to match
> + * @write: true to select a write channel, false to select a read channel
> + * @id: hardware channel number within the selected direction
> + */
> +struct dw_edma_hw_chan_filter {
> +	struct device	*dma_dev;
> +	bool		write;
> +	u16		id;
> +};
> +

I have not seen user for this, not sure why it need be in this public header

Frank

>  /* Export to the platform drivers */
>  #if IS_REACHABLE(CONFIG_DW_EDMA)
>  int dw_edma_probe(struct dw_edma_chip *chip);
>  int dw_edma_remove(struct dw_edma_chip *chip);
> +bool dw_edma_filter_hw_chan(struct dma_chan *chan, void *param);
>  #else
>  static inline int dw_edma_probe(struct dw_edma_chip *chip)
>  {
> @@ -120,6 +133,11 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
>  {
>  	return 0;
>  }
> +
> +static inline bool dw_edma_filter_hw_chan(struct dma_chan *chan, void *param)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_DW_EDMA */
>
>  #endif /* _DW_EDMA_H */
> --
> 2.51.0
>

