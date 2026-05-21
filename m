Return-Path: <dmaengine+bounces-10690-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEaMDtwxD2pSHgYAu9opvQ
	(envelope-from <dmaengine+bounces-10690-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:25:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAECB5A9388
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6C293171B32
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDDE35F612;
	Thu, 21 May 2026 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SRIcSFK4"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98E365A0B;
	Thu, 21 May 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378650; cv=fail; b=bTEcbZ67hraug1TGFr89jfa73emp+3Qt3urhqNyKY56ez0ck0zxp3I31ZDuGsrz/LgN/Wlvkwzw7/uv9DO24A0pApfZALbHmcnPMh/Q75UBMHScrukdPU7Xf1qWTlWoG5+rCrCLivG8DFtkyJXWEJ49Gpj0QPBL1R4vmDaRjypk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378650; c=relaxed/simple;
	bh=lkblJGXbi8EAqNJbc9Czk2955onQvo57R3SZarkDeOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p9JqVr6x3fUrtDbKBuKWGYt0cnPFYzVQ5MMBw141zOfvH894zQU1AE+dQew7/HHMFCnFKDK8b+L5gaq4UGLTtlAXrzf3DZXoXJr7YnIyJN502FEchfEBHvUXaNj/N/KQ+SUrpgQVH71ufDwURTpTtxDNE99NhcTE44d62XUbcNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SRIcSFK4; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNQ3CDIacDK+yGajsyJGHmhyfHBLiJHbE3c2p/WQ2bLLax3JGL2r/x/EbDVM8lFiiRBhq7Xf2jlAsoudNJKrRwjQyJmJz7SjW9eOJlOmP6fRCu5QKTyfmBCupNxTxecB3PPoozJIqRhE04xvZjgtwiryALM76uGZjkDYiBR/W/NiHVYwResVMHefe34yTl3xLTs7/kXCEXtyFMAY0Q/BlWTBSAQIiRSMInitDSJjsN4yLgubdVJdYgIM7Qlgo18wIIfOCaGf0vWikSzr2b6zcnBwkQ5r33kGbIyA4shrpoyoT3iaE2ZLUaL+px8wyzidnzFom5CxmHpRbIYVNxxLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhvhmzXtVz5xI1Bup74mmK49PicS5yI6M81A36WczXE=;
 b=BTu99Qu4TCy/p1I7gSWF3x0+0NCfHm0cqa7f3fA0AhVLU/dkcRwZFI2tU8s+lbcJyHKM1bczyCJZ/KO2fqoPJWf1gc0X2qLow54dFAIiVcNHfgkFTeGRh5AaIddxXqzLKwwgxkVuCO8yhkNVEqB1lEXo9wRuN68LZgm3Qz1QVQi9KJXJGfYniMWKHvESm8ru6U8TZSBLRq4R3qSvq4t1rfd4Ukca4TjyL5ROah4EFqhSs2y2Tr2wz5nprNG6y1TA8dgYVVg6MZFNHchkpJBOrvEGqFESTrhFk6kDdzj4IMdUeSyfOm3frl1HWa+rE2KyQ3iWFIR4csVsCPNdBZB7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhvhmzXtVz5xI1Bup74mmK49PicS5yI6M81A36WczXE=;
 b=SRIcSFK4Uoi+1Xj5yXDoaQdx0NQxxW9Xz92KObHdnXjS7f54fvR9eMhxytXAE2ywA082GDYZh60mnyhbiuys+8FlOynosRk+h9Z6RvCd+Q6zWbAVxqwM9xv0xTqFz43NRnlj0DeMSdJuvGI7XFd4s3SxNNnwrxFQ2HMibcTwYkpYpoQjfJsaNSEQJXxGjtR1Do6kg+gei3OpuvO/VpItzN6+Ne/QPcUI6bT9Hyhcq45V5I1XbdHVQE7wsBYtiYPUH9QEcBiwzsLZRUIqaDVpwJtEF3Nxng9CKpQToYJudrSRVhB8g07Rln3pRV41kloOFvD1fIo6Y6JLDchcXrl64w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB12224.eurprd04.prod.outlook.com (2603:10a6:102:561::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 15:50:45 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:50:45 +0000
Date: Thu, 21 May 2026 11:50:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] dmaengine: dw-edma: Add channel lookup helper
Message-ID: <ag8pzpEW7yHfJcyu@lizhi-Precision-Tower-5810>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521063115.2842238-3-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:510:324::26) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB12224:EE_
X-MS-Office365-Filtering-Correlation-Id: 0891d3cf-8684-42b0-d40c-08deb750b85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	7Aguo1ayuX9DzCMeStPjhWjUybHjlIpyjYh4qqPQjX7GArWyGW+xcZEnjwxdgEVWjzYi5eWQMqHCUr8RHLGenVvuqeXNu3eWZJaNLTO24/U1m+rqUy+e3J0oP0gRsJLh0SXvC+7GlhAhJeflXcFiK3Syexjex9GXA2ReA/UJdAVd+vD+uI2o5SQlGltXGtb5uevpKkkO7M/B/FVPsT+wmq6dYKzALBkT09gtaSr9db2XlhKbJn9GlMSrPVSgQwD5rQ05v1cAT4Rjnz7g/FM+bXM+COmSoH8tDkr9k9GvzgvMIcZeBcKDToURA0fvzK+CuDlDVDQOZwJQV3KDhedMq01UQSpgeWUvNPxYR/EtCdBSMyg31DP9XC1lzyz0iEL1hv1/6pZy3DEEvwI+wojyd842Urmx6+ODSQ3khdIyZzalJuG9rCGblkbSCrMxUDKNT6ugEdIFn/vBtP7/eXVprUOEKdavkyhbL8asQ4YdPRDk2SEC0UuJnNg35IUTtBAmpdmvWy3t+lAVMPGUS7vuXst1gkfdZ9s3rDlzkWCGJJaFj+rZtJ2WihaCycFaKC9ImqyIb1uq21bBMaUadCVV3PBJErmyQrHtNDcJI1q6Cf9q6azvRSP14fKqeIzCIWaX5WpUUhBNpTT/BqaH0ueBvJT7WvRMa2ajMFKY04MSUA2QREwKKgNhz6HS12PD3PicU+ipHznqlKQs7ev3xXikIfb2TSaBEmzxnxLtobpL/p2SDtqfI05TJe3dpQKbKWLB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?keQLc8KXsP8T9WMhQ110XEHIvxYvsDetyx0f93jQTbgE0cmTWveaNve0DEhb?=
 =?us-ascii?Q?nao2GtQWJ7EwLbbLOi7sJnbg7hD0sBJ5R+acKhFuAclCL2j31+ZeI4EJsBp1?=
 =?us-ascii?Q?hR935oVaetsvP08hzEPukDxvRTLEVu4KXSuSMz9qwxvh7k2gUS0WWrz87SaB?=
 =?us-ascii?Q?acOoFYaYX9YQieHZzgAHffZbsk+Hq853dpiDav1oMvIjbHoLfX+LuMq0Y8KR?=
 =?us-ascii?Q?J9MRATZE2LFPKbsHTjPJ4ao3ItcedcscbRFzTzdp6pBIT7yQWrPo6tt5C/tk?=
 =?us-ascii?Q?cwXCnyUci4E0O2uJFTCIjXh66Oa3JFqB7FiNSJx6D3Ni5wBcGQDHV2xK3Im2?=
 =?us-ascii?Q?EMtIMf2N1GE5hvrt3lEiJBjEY4E8malgZhvBiDVOf6ITyLN0xJ4274kcQMHp?=
 =?us-ascii?Q?1qsJ3//MDOe/XCCUJgphe1zL2gVNyIpV7BO4UqftqNOZnMlXFbff/LtvHlXc?=
 =?us-ascii?Q?lJuVXdVzZaCHV8rj/QOlT7f/oERPr1M6bKutTpUTfvlIZpLhkdq5XH5Mpyhg?=
 =?us-ascii?Q?DjUe7yOL4E5eKBCOHjU5P/sD9UW/kkXS9BDYCIBAKQjdCq24GG+hhwxFhjvb?=
 =?us-ascii?Q?cnuvYAqJpDmG6n9BE7Bw/yb7TVArTEIIXOyZ/8VbGjB94LPXGGNwQhrgMQJL?=
 =?us-ascii?Q?/la3GcIRppWWHoUzJXPBjDX6RmMnFKYdwtZGMiFVF65md50Viq92NvTW2J9O?=
 =?us-ascii?Q?GDgCgjNEKaXkGhDYjQHdINct/w5Zh8+nOrI9/8T9e4eDZkNg/sUrHKVAK1gi?=
 =?us-ascii?Q?wQQ48NlHAgsqZkUTt78YM4RmOhBzA09MwdwAEWGIvMnmqPpiRgVWRrDqT55S?=
 =?us-ascii?Q?7XNzCmG2ANq0jru5W9ELHKzSA0pm1KdkgAnG7YD4z6lpMLQynbu4lhvcLZ5N?=
 =?us-ascii?Q?7OFZyU3QddW0B8SbontH9mFdZfCd48qHGwLvFnvH68P/a1TxjP77sTAvazW5?=
 =?us-ascii?Q?j6q0JgfkF9ZcBR0fBW3r9e3F3H4+AhAjXiC3sE+xYoI/AeJ7xH2vFI2zuf+G?=
 =?us-ascii?Q?d3GU2ZqXLWv3R9974Xi4unTBYe/iddc6EG9n6zy5KFCY1GBrI+egBXulVmks?=
 =?us-ascii?Q?fXanOyv3Mqd3qpwZpVO6EEygluknkNS07RP4U8O66VngcgNDRntILRZNBk+A?=
 =?us-ascii?Q?EmorjKqCUTm2rYX6syjVZ4bUSvuFU11P8ZBzVA6O1KD1s8uKeVnbrBq2xOHm?=
 =?us-ascii?Q?icEpoknGoHvbohM6OAzrGChBCLX9sWN/BMA8P3T+BQZTu/JSENBKmJtKkOkH?=
 =?us-ascii?Q?MWtiGR+NQhuhCmevJW11LnfZXEP0Ao6Xd9neViTEKwha8E/ygpNbEss6dpnw?=
 =?us-ascii?Q?LEdxnRksykL+EcHMKXhe+SQH2tShEEiwEm7mof7dgHedj3xU0iFyI3ow1gKF?=
 =?us-ascii?Q?hg1Ro/u9DlN1I88eH/4ZEXQ+lsxD4I/lIxLyLU815B6QnhP3WTba9HVY+3wj?=
 =?us-ascii?Q?wNiep54kEdGJj04Khf4xXzmshqhUMltXncyWqZoLLPGTcIFgC6DsDNkQkugQ?=
 =?us-ascii?Q?gdJfkXgdtRNaVDcsXL+ahfhFMQrsng+EZPjSyKYV8V9ixnLi7GkLhT5fxAx7?=
 =?us-ascii?Q?2CAna6iv6QH+KnQSf2fpp+upF2uq5b/Kx0u/u8aogzRoBX20vYXfP0BxIIz5?=
 =?us-ascii?Q?OIOzZhpzIL88mOC+dFyqJc3Md3VzdsN5vvQhJr+/UJMUdS/V03aRql/EKCyk?=
 =?us-ascii?Q?LyJjcj3kn4y8OoniQDE68ohFQuAVJBhYVbcu2Lo2o6flaJEtPgNfUpELXuyX?=
 =?us-ascii?Q?EEzfWd7dag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0891d3cf-8684-42b0-d40c-08deb750b85e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:50:45.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB+r+0vAk7s+sFbwox/b3zmat9wwp9fqH5JGzVRry7hyvl1volpa3RpWfShWmfdxzrsLECCWp58TnwNl9+fcbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12224
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
	TAGGED_FROM(0.00)[bounces-10690-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email,nxp.com:email,nxp.com:dkim,synopsys.com:email]
X-Rspamd-Queue-Id: CAECB5A9388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:31:05PM +0900, Koichiro Den wrote:
> Add a helper that maps a DesignWare eDMA write/read hardware channel

Nit: Add a helper dw_edma_find_channel() ...

> number to its DMAengine channel.
>
> PCI endpoint resource enumeration uses the pointer only for later
> ownership reservation.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-core.c | 32 ++++++++++++++++++++++++++++++
>  include/linux/dma/edma.h           |  8 ++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2feb3adc79f..6660380a1bbc 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1189,6 +1189,38 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_remove);
>
> +struct dma_chan *dw_edma_find_channel(struct dw_edma_chip *chip, bool write,
> +				      u16 id)
> +{
> +	struct dw_edma_chan *chan;
> +	struct dw_edma *dw;
> +
> +	if (!chip)
> +		return NULL;
> +
> +	dw = chip->dw;
> +
> +	if (!dw)
> +		return NULL;
> +
> +	if (write) {
> +		if (id >= dw->wr_ch_cnt)
> +			return NULL;
> +		chan = &dw->chan[id];
> +		if (chan->dir != EDMA_DIR_WRITE)
> +			return NULL;
> +	} else {
> +		if (id >= dw->rd_ch_cnt)
> +			return NULL;
> +		chan = &dw->chan[dw->wr_ch_cnt + id];
> +		if (chan->dir != EDMA_DIR_READ)
> +			return NULL;
> +	}
> +
> +	return &chan->vc.chan;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_find_channel);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
>  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e315..b4b42b2278f3 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -110,6 +110,8 @@ struct dw_edma_chip {
>  #if IS_REACHABLE(CONFIG_DW_EDMA)
>  int dw_edma_probe(struct dw_edma_chip *chip);
>  int dw_edma_remove(struct dw_edma_chip *chip);
> +struct dma_chan *dw_edma_find_channel(struct dw_edma_chip *chip, bool write,
> +				      u16 id);
>  #else
>  static inline int dw_edma_probe(struct dw_edma_chip *chip)
>  {
> @@ -120,6 +122,12 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
>  {
>  	return 0;
>  }
> +
> +static inline struct dma_chan *dw_edma_find_channel(struct dw_edma_chip *chip,
> +						    bool write, u16 id)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_DW_EDMA */
>
>  #endif /* _DW_EDMA_H */
> --
> 2.51.0
>

