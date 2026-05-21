Return-Path: <dmaengine+bounces-10696-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A96FQoyD2qSHgYAu9opvQ
	(envelope-from <dmaengine+bounces-10696-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:25:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213B75A93B4
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BCD0304AACB
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873F136A367;
	Thu, 21 May 2026 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T1rFvsUk"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1867B3783AD;
	Thu, 21 May 2026 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380168; cv=fail; b=kV497fPAI9A4WqoOrySAtdwoixUUh09/Vh3zaD2micSzJGT5IdzcV+kzwQYB+YtkEmS3kRQLHm/xo56uunE+oiTqk4yTg66eC2zJ/z1BkgI/9p4Bf2FPQd3cdgarLSFQRdHDzcRVpqi2cjyCqQ22l3VJl/biQZ0w/xYQUyMUTfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380168; c=relaxed/simple;
	bh=nvY49HlDEZk8XvItSvoD0BgeVP4/c+niaBDbBVlvCdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iayD7cnNreIhHqP1HybYBqpX7YhUi5Wlx8kF1vN4HwG6mgjNJKBfHNfWyfJCHw2ff9WVFhIsMLSAA5enjyTHh6ssFidc+jRPi93xGSaTtDz6CLs3R9N+PblTpEJpS6wsaW8Xw/Fr+EMS9LIqH+aNQa5VV2kiXqRBLsY1ObkjiUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T1rFvsUk; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uuy9PizyrkAH5kffBLJoAi9TDPsUyhRo6YxIfNOibyOslQLZ/4SJs2CXYgDSxjSnALAgUYd9xTDSQ/ktjFtpn68S6LVr/dZAey92C6KONE5vU4J4gYlmVOQtbVvGuiVan8UqC7jrHMzOl7M/IpFYB1fXn9D7aW2JubSKkoXMmg4CJsAoQcUYpwUX9Z7G5O1zyYLnwkrs+gJsgAC/7iXH6/wichLF+v2oZNoByVEhHHTl4ce/bNZR1yZuHhiKhun3xWpDU5RjRn1tDGyYySKwwjJaz0mFQfI7ZV1f22+rqo2xJ3WrqWT1yPheHQGS/iHao/bmC+bEXj4EhMM15XAkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQRcSJBJchZJeh5lnvZRV38R6GxUfoM3R+7KywJGgpk=;
 b=ikiEgimDFsFdozbD318RHq9qr4Rr25O2Nup6FSLNjRhkFVw7JxQYhyCuk2waEPvb3AuTbFHx62xcCp3Cgedt/vWJexlFHhfGzZ4Wl3H3EdANG0Mlwv93+dxgnka0Pz48KMq72mR67iywHA4otrH1yn6ZkVbkmxcHbLHv+EcluaQFlXXLA0w70qHbLy6JjoNKajFd108tZpzuqmrmsswqOU8/+VNCecCb0ZTn2CC7PRCdXrquRCoNHHj7KYdjOJbBGJBcvcb2wIltG4fG9g0opGwXSchNS62+SorAN4bAGE3D7VYJp39dAvsoawgsyj4WGNVvFwswHuXOWUc2unnoBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQRcSJBJchZJeh5lnvZRV38R6GxUfoM3R+7KywJGgpk=;
 b=T1rFvsUk7IYBokWwUeKJPVJlYsmfXdu9ucDSv4kFHAmsDy4MFQiyrkpbz/e7NV5exyHuylDbqVmgRtPsADcOgHuV14XaTsZ6o54pJDHGunJkx6mpl1UL9tHceZ4bU7qf/9QBpefpJCQ2ek7C2PXLCWu/zmFb1oc5WNegZx/+QLpiXmdSTdFVA+BlhVCDCiikiBjSR9zBjW++5a7PXZzklDwlhgB6rrv8rG+xVY0uDubsOKbqARFvYpDCmV/UBzTJf3BME9otam+RNgtRTyWUhikTqoUGsubQmD2ko68GzsRS/Mi35cKNPI4PyrJF1V9pparTwMtJkfmyFGIX8YC/kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 16:16:04 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:16:04 +0000
Date: Thu, 21 May 2026 12:15:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] dmaengine: dw-edma-pcie: Add raw slave address
 match flag
Message-ID: <ag8vvdZEO7pxvj5u@lizhi-Precision-Tower-5810>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-9-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521063115.2842238-9-den@valinux.co.jp>
X-ClientProxiedBy: SA1PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e71085-695c-46ea-876c-08deb75441ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|11063799006|4143699003|22082099003|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	QBcP8nmp40elqVFR6a6+x9in/9/DW5dPKRnAMjPVOnOkrGNc9USNj5c6xaW81WN8dO91oXD1KLIhVSl07O2SJKPah8mLhge09agzyDkAZIFFzNc+wHa52aWdj9iyS/lNnZrRzicjsb4WdrCP+fjnsVJUsopsWjRqknAVKtgrTpvCNrYbkZ8dYGvZKDPGFoObH8d2icMzGEb+vrM2ymqab9e5inI4B+Xp3LtqtkMsk4chgvIEM01CagEobojQLMc3iT/NFcjhhu89YKYRj3N3i+QQqdVhTg45YM0O5T2vu/Lx8Lkh51vLdFHK4h5Me1pjJr5wRpNeu5SiIkyzybCBmsBGwmCztnPmP+EurU7dsF2TwQHURE06vi/IcbO8kVEhudo2C9WjU/X8+6g1Y4ldGNE2bafTue9xH/orFkDanzFHiO0O66cDYz9JlP96WAtBVzLYVGrtGjKKiwKdV2HHQlOCRiK0eWmACgiBBBZMkd4+J0iwEbF5qct/jXha5TiMg4Vzi1F+YqW8JFf0P+Lqo2VCElDdUAN038V2EpsuhH/UHMQaKjKCLntjZqUfMXmXiPn9cKGWT1bqkcwipPbfHeSEAfUXvGXYN5jpNi7GDr3m7CFKEHFD2qodhT4zEtY2JeG6y35mO+I5yR7CrzK37xjRtP9VLzuP8RqazyVWXF5O+Ic99R7iAAupNJpKBTe4a/ekXiqyQ+ftz8c1Zf2YDnMouN+/IIGv525H76xbQCrdnClpwF+OPMpzSfITmsGe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oa4nf+W5RrNlJzW2sZ4k1WQeB9VNbKCc1XTByW/GPrHnpfj+YGRUdoq31AS3?=
 =?us-ascii?Q?SlsxxQgB4YnKcWrXyZ7vLVnQ6c6roGhlB+xsm32b3HbJzx0ZzNMYvgQAKqW3?=
 =?us-ascii?Q?mhce2ouEhKCIWxjgeybpvU25FvFWhXI1ig2FcIyJtWNDqjQ5xQfu6wSpeWBh?=
 =?us-ascii?Q?EhbFgeVu2glE2R2n/dtIL43Kq+fwkNoPASBSazsBN5sTytjzmIAej7kktDiU?=
 =?us-ascii?Q?CZ9EU7aIzlOQUrBaug5CUp8K+Q/QkGfIxxwYo5v7V7+CbGUDR7o4Cd+EDfP5?=
 =?us-ascii?Q?snMxxvB9HmqO5wXcfNdqEPFw+3KsybNxTWSuiw25+oKn/LRayX8WIIc/19Pr?=
 =?us-ascii?Q?Eo+4GQvazXMCxxJFuWRzFEYpO9pjovfVLLi79Dq0UMJqF6306Do+ZGeSAs83?=
 =?us-ascii?Q?PNWwDk0x/5YPxhsY6QkDLKc+pBuqNGvTbtSYbpzYvb0Pxe7MUO7Cz58Cr85+?=
 =?us-ascii?Q?+cYR0mGyHaiRACEU6EuDtEr4u4VvYkTPQWzHeDQ9DYrGQwiQryobXVewes1S?=
 =?us-ascii?Q?FsB3yJNJXgk8A88YUPL93Ps+H4sWBO133lwTrq6px2vVScalgvLSUvm2y7uf?=
 =?us-ascii?Q?ejXJbMvZjF3w5W3d6DKYTXtMJ+JCxjUBw7cEbbbiBRm8bPDXPkwx4uFqhBkW?=
 =?us-ascii?Q?mz8Y/fUvH1jRKTs6UXE3wr6cFr3723f8ouVM0i+Wp/PFv+FysRDGrlWPGGsX?=
 =?us-ascii?Q?I1WdH5JP8gK/emRA1uzrvSDPkZZKFhS8ZLU10B0+wPvs1G9nft1MpnEAmTpB?=
 =?us-ascii?Q?9ZT/7vn9gLWlonD+2BcZ9x2v+ejEHsQnSyubx9QAHgAi/hKg40mGus4NoH3W?=
 =?us-ascii?Q?mQd+BFILd2Fnc4N/BMBFYpa3W1XNIDqG+8Oy+o8J+fIiD3L5iRi2uwe85APS?=
 =?us-ascii?Q?3GnHBJGrXhnY0P6DjUaF8v+i5/Pi1DAdaiu9WH4PCS5y8GezXM2fuBiRps9K?=
 =?us-ascii?Q?ofQnBKeL0FfZNA/hvDLTU0FaZLHe0FmW4AU8JU+qpn5XAgwOPfXWthkIIyBz?=
 =?us-ascii?Q?0EtHEl80b7qUaDTD6aeQcua4/CzVbd/eEvOh095dHdb9yOTTF7FdZLsYImfz?=
 =?us-ascii?Q?s2qLb9IUa8Tn1Vz9Pb4a+U6q1NnwJG6MaI10cHm0OaB1I9ErbikdpJ4qNx/s?=
 =?us-ascii?Q?qyVX9l4AQ6fqfY0cPl73KvHl7NaAld5rSwMaiJjKTAaTf3VjwNmhbaZKpvQ7?=
 =?us-ascii?Q?ZFT8VgeUVKLs+61SUyYXuqrAL1pathQ8v6ArQ4P1Isf+44MDV/nmcnPBCL1R?=
 =?us-ascii?Q?zNuZu4dOe2fzeY3OUDv/ZCuQxQWw4pA0+Ks3Qxpy60GWcGOR/iVG9KpUZPRc?=
 =?us-ascii?Q?4klMcPaptFkfGXYBMFVD5HaF0Z+uy3MO6DmWRJkQemnI8ZYbM/i0bIAYjrDZ?=
 =?us-ascii?Q?1/bcp/ig9L+ZSEWuLqlcoXgoXIKaptcEepwdIoo2sYGY5UT+zPH+JjedUuqc?=
 =?us-ascii?Q?5eQ08yRFoVmt7vUFtvrDuoVNMFWu6elGno1VThRooAW/2dc97q3/gm3cHAtz?=
 =?us-ascii?Q?Jq9hOGfEts7YsJZTDJ1XA9BNtu7PI4ry28Ozn3IOK7mD8moZUo2ahtquwHLj?=
 =?us-ascii?Q?LN7ZuxkxwxNVY5ooQjqoTNO3ztvzLm6Olr+V3P9DQS41cXjb3exgbBDCxQbM?=
 =?us-ascii?Q?HfQ7g9zNJrpeBWJdaWg+jaooZja302KXvOwi2yP+dAPBPTcGcXzhr6R11pSd?=
 =?us-ascii?Q?rAv3m7PvBFHbCNNsJaK6k3PX2b4iBmp0QL8COWQrcPYPzDO8p4q99rTIhmBe?=
 =?us-ascii?Q?ObgUlH+r7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e71085-695c-46ea-876c-08deb75441ba
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:16:04.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ob0alSTjPHg0p3BLEkhdd08Z/RlZVMjXtDRd7LWzt4rwWgK1fz1+R/lyC7v2id0pWe4jAEzQ2g5m8MmAaqLRNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10696-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 213B75A93B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:31:11PM +0900, Koichiro Den wrote:
> Add a match-data flag for devices whose DMA slave address is already in
> the DMA controller address domain. Such devices do not need the
> dw-edma-pcie pci_address callback, which translates a CPU MMIO address
> back to a PCI bus address.
>
> When the flag is set, select platform ops without a pci_address callback
> so dw-edma core passes the slave address through unchanged.
>
> No functional change intended. Existing matches do not set the new flag
> and continue to use dw_edma_pcie_address().
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index cf2f09f1891c..651269708cc5 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -87,6 +87,7 @@ struct dw_edma_pcie_match_data {
>  };
>
>  #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
> +#define DW_EDMA_PCIE_F_RAW_SLAVE_ADDR	BIT(1)
>
>  static const struct dw_edma_pcie_data snps_edda_data = {
>  	/* eDMA registers location */
> @@ -208,6 +209,10 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
>  	.pci_address = dw_edma_pcie_address,
>  };
>
> +static const struct dw_edma_plat_ops dw_edma_pcie_raw_addr_plat_ops = {
> +	.irq_vector = dw_edma_pcie_irq_vector,
> +};
> +
>  static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
>  					       struct dw_edma_pcie_data *pdata)
>  {
> @@ -435,7 +440,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->mf = dma_data->mf;
>  	chip->default_irq_mode = match->default_irq_mode;
>  	chip->nr_irqs = nr_irqs;
> -	chip->ops = &dw_edma_pcie_plat_ops;
> +	chip->ops = match->flags & DW_EDMA_PCIE_F_RAW_SLAVE_ADDR ?
> +		    &dw_edma_pcie_raw_addr_plat_ops : &dw_edma_pcie_plat_ops;

Can we direct put &dw_edma_pcie_raw_addr_plat_ops and &dw_edma_pcie_plat_ops
into match data, so needn't flags DW_EDMA_PCIE_F_RAW_SLAVE_ADDR

Frank
>  	chip->cfg_non_ll = non_ll;
>
>  	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
> --
> 2.51.0
>

