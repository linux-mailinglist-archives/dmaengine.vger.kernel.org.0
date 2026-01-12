Return-Path: <dmaengine+bounces-8227-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F296D15643
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 22:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84C023005003
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5AE3382DB;
	Mon, 12 Jan 2026 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="USW0ZEL7"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E294D32D7F9
	for <dmaengine@vger.kernel.org>; Mon, 12 Jan 2026 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252295; cv=fail; b=A2W8B3VJG9NoCnQFFI+XxKmN6hYoJXdpfFxl6IwqByj1G5+BGpBRRG0h0sOqAVzTK7egfkklEzN6bYbHjd3cMT8CFdBRfcdoPQ7DSdd/8tsJKJdEsTeLZMAJdYTwgXXIflghNxwFFq1y40jJKFQyPRV4Prs1nvyuKsJIPBnowDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252295; c=relaxed/simple;
	bh=D5+StHjbDVlWNs5EPItCuzKoMVZICnCmxON779IvfIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HezAbWBA5SJb8DRXM2g4faEHqg06Qp89afo7X4j/667LIZg7LPZ0tL3bbSEGSdMD9EzwCbkAK0nIUscwd+5NepAQZIjKQCtzm27pdP32bpAgP+sKB2YEKx9DKhWTldhnFuLqmmAnamDmXhku8ZJNCk8GYSguk0Cdnz0Ckgmg2b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=USW0ZEL7; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkiE2qwzn4zqNBBIH9AO3C3FUR8latu9YYJ9m56HN3m3nMxoRPg+FmNTYmZw5Kjx3mGSS+xaEN4YY3yke/pJpB/sLe1+AgLWGzc38eonLFzeimTIcXu3zpX6VNQTP4CkpZ0L4RIAo0Lz57vM03f5LV+b4ZOhGwh+J9p4aD1HwkE2JVeLnqgX5tszcNa4cqVfda7axV6QXd6Vz2M1Z6/ykB8bEhOBITICXqSzYMPqyux/h2AxW9lvv66sOsjVYX6B3USMTIug8GNFl3pl3FPvobWIKXSNrNtufNlQgqeL04ec8cVeYuBgm3tCzppQTFtXZBr4uqiBKmZq9FwqAiP+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI+TWobIkSlCQ4vS0r7cJFR1YsG0VM8uiinGcLZcrNI=;
 b=l/CL+3CGhZKnxn2Vc8ItzzbHzq6ctb0J3RwDxUUBtYz/dEgJksqPJ2R/jua59Olh1Q5JajENWaO1yQOxz2xLZEYL3qm7WABCjTXjpiHNzEgeBH/OuMYMOxkIUTIhsyinIRBPYYytRMaPkWMYi+sBrOIsiTTS7jpnz2tB7LV4Q0BTtHqFYrN8aFls5H9M3kVXynhSSLDsmxSbLsf/McEB7yo77QNfo4pbOrIhsoy1j2QMYH2QwWDwBDor99iUia3+e0FZdnACfLA4sMp98Of8zS6K5ANxWMu0UNj8yUSi1f1My74MEcE1mzAC28wVypdHLfl/NFP4NJ+5HXguShNWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI+TWobIkSlCQ4vS0r7cJFR1YsG0VM8uiinGcLZcrNI=;
 b=USW0ZEL7Sg0ixLmtC002y34iOGlU5o4xhDzlpp4X7X4AZbTUB11CN/OTwb2HL3/r123MRQKauMrGrxV+SAIicCkKh07lrwJDLEDc9c3C9g/I3zsiXzbOS/11+Yoo7jlXs8dP7dxKAJ/+0n6Tsl1JtVHlMYEOKItOJtJYJ2QTwgEACiFLJayYRcXzJaC+zCDNfUc25YuTSLCbv9ywStznAm1ggf7tOw1Acxn6IS/R8OO+FkhN7rhTbZhHVQ4ChJRQKaiPcc0wM83qYyHTCvj/cAXHF6F3wD0bEVUkDBfF+VlezfkN4K14zKK821fpPEKWO78ffxeFZzVypdrxheqQfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI2PR04MB10114.eurprd04.prod.outlook.com (2603:10a6:800:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 21:11:29 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 21:11:29 +0000
Date: Mon, 12 Jan 2026 16:11:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 2/3] dmaengine: switchtec-dma: Implement hardware
 initialization and cleanup
Message-ID: <aWVjesSxFp1STEhV@lizhi-Precision-Tower-5810>
References: <20260112184017.2601-1-logang@deltatee.com>
 <20260112184017.2601-3-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112184017.2601-3-logang@deltatee.com>
X-ClientProxiedBy: PH7P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::26) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI2PR04MB10114:EE_
X-MS-Office365-Filtering-Correlation-Id: 97eb3031-d107-4284-7fef-08de521f2734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|1800799024|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9dhM/BkHUDa9EsTTipx6Pjj7DGaBDdgn+0OV57Cn9xDQ6uSP/uQvduiNT3/j?=
 =?us-ascii?Q?vdpjU0MGfFIy8txs79wQ3n13LVerKt0KEG3ijsgAj7IICec5EaSGtRb7Flv2?=
 =?us-ascii?Q?oFNTMBGJ+EB4tFSAm6oYIuBh8mdQXIlN9+htK7awUUix+dQSc5/vPuyY9JFk?=
 =?us-ascii?Q?iicW6X77Qfa4Cv6L02BEmgNIH8hdxWYEy7P2MArywv4u90Scmegycz5yuRyn?=
 =?us-ascii?Q?GQS0b6RHh2Dh0jIVEbLh1sq8FdPBR0y+hOwmPT960amImXe9g7WSZP7+YJNc?=
 =?us-ascii?Q?Grc+1bwbxw000Dev6vbKYVtRfXNTIz/Mw7cJbmBHNCvuCpUinsIQaMl7OgP8?=
 =?us-ascii?Q?ykpwOcMDlXm1eo0RpCjdBOq6oXTuNhU6MYE+5HyWfhsZmwhH0j6tE164NbOD?=
 =?us-ascii?Q?6g1casNKYX5+Bb9JlLg2WAksF6B5IKjOcgssegPn3mwEFpfjkBEd2NV8gTH3?=
 =?us-ascii?Q?56hDmEmJB7EfI7Ai+IzMUjg6h7HKcZNfKxyJp5iYYiRMgCzfZa3i6Yzsvvaq?=
 =?us-ascii?Q?rd3ABlNlczJqMjfNSo0dK3sWrIYzA1+w3yYGVfq/T6S7f0Y+cWWFz46sMY7C?=
 =?us-ascii?Q?XGGQVbUnFhMfg2l72TrRclpeDhch1xxrXdhtiDFvbC8AMkho6GIigThJIvpK?=
 =?us-ascii?Q?m7P1f6z6qZTL/MsDoC4qUjKmXL4LLoeJoxU/MmhP7YhTx1KMBAHx4/3Y7r0z?=
 =?us-ascii?Q?kKT1MpvdRwefqYjaWq3aMY4LGR/cMJXkuSXF4VPu4WOFAFNKLlGFj2/K6OZ5?=
 =?us-ascii?Q?lgFRsuN64bgM3H/YD04sHp/HlNPxe5JmAiCYA0KWopKR9VS4kXmrN0X5NPF2?=
 =?us-ascii?Q?k1IyvA79BJhWTppLsHOEX7NTzhPQizjJGYp2xfgoaeGK5ShjdrjwbvJbipNI?=
 =?us-ascii?Q?j1XLvkXmu0WpAF/yRFMc755Bd7HOV2BKF4TLJ/0QqFffuyhtyo9CVsKetMQh?=
 =?us-ascii?Q?cj6d9RX7LMozmR0nEhfQE590PT4C7qsTpl3T/j1IEKWx9xV2t7sbqJr1iBsk?=
 =?us-ascii?Q?N2DmrNJdRkb/toAg/ljLIIvLljrv+nrKMDidbLeZ2BcKdPnsx52t+/FWbKDu?=
 =?us-ascii?Q?28uPtpPhxFOqmfdTRZKUdReuDIJPbLJXvPuGgeHx1XsISG1AaEHE00W1IDLZ?=
 =?us-ascii?Q?noMZifXS3KJDTqhsHsqjQ3LT94AClfcJOWBb7u4debsagTnH8+wtXhUmvGzO?=
 =?us-ascii?Q?pRoPFmrYtxFCy7fHSCUxOeGL/0jAqcpe+Gw896HG8CvkPEz19o5C/YgM1vLU?=
 =?us-ascii?Q?MfwoVYCji+8qsTphdcAbk3IXrGgF2PeTUP2qqKOfTCQVDvph9GOgAOYem546?=
 =?us-ascii?Q?mIj86PzTxl+2SOovnLTI6EFnv5UEtdq1rCzTCx3zmoqVRNm0HzSIINCt4lLj?=
 =?us-ascii?Q?dfF7MRMHbPsS8DCv5oT13BEL7KxSb2OhZtZX0kXl3+p35jIdgagVjtEzQYgV?=
 =?us-ascii?Q?CupHsvjFOTM5rprITT9u9/qSFTfWTUCF4n+RHPEV3YSTLDv2ewZn9hTSOikP?=
 =?us-ascii?Q?dFjFsHlOLqBzwDFvrqWAa+Cx6PLXP6O2VDAs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(1800799024)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1izkcJtHZ8bpkVxo+Cf9qYq0gcYyvn/RrwzeGUTBoGbtLRXnH06slJcEG5Ds?=
 =?us-ascii?Q?HTeCdXOLFU+gpC8JHqi7uZehbM2UPIf4VD7zjD++FmQorgCae0i3PSWFrRjJ?=
 =?us-ascii?Q?MSGCm0Pf0erN4kF00eaV2g0Mpb8P4fP+4q+n7SbOxV5EbN8m7s2EnS16lS1C?=
 =?us-ascii?Q?0ILZ3ushfiU6vJiSf5GWLYx6qKG3xcjZttSv13ByK/LnXnclP2yqbzk+k9lV?=
 =?us-ascii?Q?TamVhpi3D7x66x0xQKajW0g9W3U1rPlRvVBsyocngrUJalEZVysU2KUFDUx2?=
 =?us-ascii?Q?xhLPWCCCF9+7EMb0QW+9ngn7A6DeX8NaFlqqjI1Y9L1TkZC+BGOknHHfOFcQ?=
 =?us-ascii?Q?L8YbnfvY8yfUsemWa8IpYJQPR2xsgMW1XNJktVuSRXxLdh/sogrmk/X4SnsO?=
 =?us-ascii?Q?51yEyncRiBi7Up8rD4yrIEpXfU9vmzU+RjrPGlH+27m9tZUMO1QiKofV3kgh?=
 =?us-ascii?Q?06PJrTgfxG0hhQV+pgagH+hizzjrZlZuzdxhKy4XFHZR7p75DsSSe7w6BJiL?=
 =?us-ascii?Q?Ayz5RH7GG4tRmivkXgRUEUFEE7uRKVcYDszrm37GntUkLpZzqHAfGE9/o9yQ?=
 =?us-ascii?Q?TZCuJxGS6EFiOxLF5cUrlNwdkGwBqUoz+2rRvMlHOvF2QX/9nCRk1HvK2M5J?=
 =?us-ascii?Q?xGbWd1uspHBVp7OnP3Jd5CxXGr2qvVPFEWT6JRXhx4ORWi7wF+OzkWf/+yjz?=
 =?us-ascii?Q?AtxZ2FEDqrmtEedopAoYYjVw/wm7E/2Hxhsctksxe/fgFjY5bJ4b6TblEWqj?=
 =?us-ascii?Q?Iv+JLwC3TH+vtb4HFIUWBWt+i4jIXCQcPe4n/3kofksy8B//q+wZLD0cEjBf?=
 =?us-ascii?Q?PUBZF9BP/iDW0L42xwtR8gdfhIcsbqhpw91oZbA48+l2xwOdXp9/OMjX7Qbv?=
 =?us-ascii?Q?CmRSj55DBnGiFlett/S3ktCfTslrsp6TYYNGkwptoDU2mpaAX8u7/q4jyIcU?=
 =?us-ascii?Q?AhB7IW4+MA5jhPXpw9UPN7RmxC0x/snibyuSt8516p/vSllZOaIpAgU8ZU3o?=
 =?us-ascii?Q?FB1d4XgiT9GUFCqt/w7TaKwLqjRL3vh1J/fNyTFzw5QR7N4dIH56alXrOdfN?=
 =?us-ascii?Q?fwoA4ED3ZTe4cj6ES+JHgS6hwzmQ6YkV8Z/sR9eX0PIEbBkERaeHAkrikBDy?=
 =?us-ascii?Q?ArNuxRAXSNw5nT84a1NAPHME2OEyo8M239dIMv46Spl2CG+jBfyYWutHwqRU?=
 =?us-ascii?Q?GrPZXyvde6MIDjuh8Vh+rrZWZnvZBB3EiieJ0upHbIi4oX8pTvakpcJKfxjL?=
 =?us-ascii?Q?XGR9QP6o45m7YmSJaTvzod7gvv22PKywMCRolTf/z9pM41WVBuRoDZzIh257?=
 =?us-ascii?Q?EFJutStqQgHCMFUs1RwZkdKNnop3kqX7RWo2J8sWU0PL2ziUAuvnRRLcEtvn?=
 =?us-ascii?Q?ukqVWHm7Pbtu1PxMpzFvLhWm213Xf4Tjbglg74842Pi6BPo8Rs2k1fmH7WjB?=
 =?us-ascii?Q?egv2UAGSBlwGyKBOvGkIKfF2RRyDu/HmFXRJqIVaOPiEs+5Odor5qg8Py9Wp?=
 =?us-ascii?Q?XLTqLOV6X4pZ1HAHJ0VY02UGsFYz2T4Ni3Lsl2PMzfo3rnC+xKxXGFvwL851?=
 =?us-ascii?Q?636ZdBpQahjt+GdYi1u42yLhpRgsO8bA9L7c1MIhuQMjtm2nAmwOOafXGLU4?=
 =?us-ascii?Q?k2Um3pvCp4P3/ZXsJzi9LsrDxVq0k9Y+BUSl1nikwV52wCAtW1BQjGJKHSqS?=
 =?us-ascii?Q?3UUpL6Cx4ghIqMg/DqVz/H8bzx6KBamA6nfK7HQ+PWFXAesj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eb3031-d107-4284-7fef-08de521f2734
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:11:29.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egwiNerV14W5L0NbODh0e6LhY0ecFfGeUHh7fOUkILijk4bBkEd4VaqRJHoFIF7hejBiuJMOpLRbXKjKXsNW+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10114

On Mon, Jan 12, 2026 at 11:40:16AM -0700, Logan Gunthorpe wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
>
> Initialize the hardware and create the dma channel queues.
>
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dma/switchtec_dma.c | 1007 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 1005 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index cde982db0196..78cfeffed9a1 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -19,16 +19,976 @@ MODULE_DESCRIPTION("Switchtec PCIe Switch DMA Engine");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Kelvin Cao");
>
> +#define	SWITCHTEC_DMAC_CHAN_CTRL_OFFSET		0x1000
> +#define	SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET	0x160000
> +
> +#define SWITCHTEC_DMA_CHAN_HW_REGS_SIZE		0x1000
> +#define SWITCHTEC_DMA_CHAN_FW_REGS_SIZE		0x80
> +
> +#define SWITCHTEC_REG_CAP		0x80
> +#define SWITCHTEC_REG_CHAN_CNT		0x84
> +#define SWITCHTEC_REG_TAG_LIMIT		0x90
> +#define SWITCHTEC_REG_CHAN_STS_VEC	0x94
> +#define SWITCHTEC_REG_SE_BUF_CNT	0x98
> +#define SWITCHTEC_REG_SE_BUF_BASE	0x9a
> +
> +#define SWITCHTEC_CHAN_CTRL_PAUSE	BIT(0)
> +#define SWITCHTEC_CHAN_CTRL_HALT	BIT(1)
> +#define SWITCHTEC_CHAN_CTRL_RESET	BIT(2)
> +#define SWITCHTEC_CHAN_CTRL_ERR_PAUSE	BIT(3)
> +
> +#define SWITCHTEC_CHAN_STS_PAUSED	BIT(9)
> +#define SWITCHTEC_CHAN_STS_HALTED	BIT(10)
> +#define SWITCHTEC_CHAN_STS_PAUSED_MASK	GENMASK(29, 13)
> +
> +#define SWITCHTEC_DMA_SQ_SIZE	SZ_32K
> +#define SWITCHTEC_DMA_CQ_SIZE	SZ_32K
> +
> +#define SWITCHTEC_DMA_RING_SIZE	SZ_32K
> +
> +static const char * const channel_status_str[] = {
> +	[13] = "received a VDM with length error status",
> +	[14] = "received a VDM or Cpl with Unsupported Request error status",
> +	[15] = "received a VDM or Cpl with Completion Abort error status",
> +	[16] = "received a VDM with ECRC error status",
> +	[17] = "received a VDM with EP error status",
> +	[18] = "received a VDM with Reserved Cpl error status",
> +	[19] = "received only part of split SE CplD",
> +	[20] = "the ISP_DMAC detected a Completion Time Out",
> +	[21] = "received a Cpl with Unsupported Request status",
> +	[22] = "received a Cpl with Completion Abort status",
> +	[23] = "received a Cpl with a reserved status",
> +	[24] = "received a TLP with ECRC error status in its metadata",
> +	[25] = "received a TLP with the EP bit set in the header",
> +	[26] = "the ISP_DMAC tried to process a SE with an invalid Connection ID",
> +	[27] = "the ISP_DMAC tried to process a SE with an invalid Remote Host interrupt",
> +	[28] = "a reserved opcode was detected in an SE",
> +	[29] = "received a SE Cpl with error status",
> +};
> +
> +struct chan_hw_regs {
> +	u16 cq_head;
> +	u16 rsvd1;
> +	u16 sq_tail;
> +	u16 rsvd2;
> +	u8 ctrl;
> +	u8 rsvd3[3];
> +	u16 status;
> +	u16 rsvd4;
> +};
> +
> +#define PERF_BURST_SCALE_MASK	GENMASK_U32(3,   2)
> +#define PERF_MRRS_MASK		GENMASK_U32(6,   4)
> +#define PERF_INTERVAL_MASK	GENMASK_U32(10,  8)
> +#define PERF_BURST_SIZE_MASK	GENMASK_U32(14, 12)
> +#define PERF_ARB_WEIGHT_MASK	GENMASK_U32(31, 24)
> +
> +#define SE_BUF_BASE_MASK	GENMASK_U32(10,  2)
> +#define SE_BUF_LEN_MASK		GENMASK_U32(20, 12)
> +#define SE_THRESH_MASK		GENMASK_U32(31, 23)
> +
> +#define SWITCHTEC_CHAN_ENABLE	BIT(1)
> +
> +struct chan_fw_regs {
> +	u32 valid_en_se;
> +	u32 cq_base_lo;
> +	u32 cq_base_hi;
> +	u16 cq_size;
> +	u16 rsvd1;
> +	u32 sq_base_lo;
> +	u32 sq_base_hi;
> +	u16 sq_size;
> +	u16 rsvd2;
> +	u32 int_vec;
> +	u32 perf_cfg;
> +	u32 rsvd3;
> +	u32 perf_latency_selector;
> +	u32 perf_fetched_se_cnt_lo;
> +	u32 perf_fetched_se_cnt_hi;
> +	u32 perf_byte_cnt_lo;
> +	u32 perf_byte_cnt_hi;
> +	u32 rsvd4;
> +	u16 perf_se_pending;
> +	u16 perf_se_buf_empty;
> +	u32 perf_chan_idle;
> +	u32 perf_lat_max;
> +	u32 perf_lat_min;
> +	u32 perf_lat_last;
> +	u16 sq_current;
> +	u16 sq_phase;
> +	u16 cq_current;
> +	u16 cq_phase;
> +};
> +
> +struct switchtec_dma_chan {
> +	struct switchtec_dma_dev *swdma_dev;
> +	struct dma_chan dma_chan;
> +	struct chan_hw_regs __iomem *mmio_chan_hw;
> +	struct chan_fw_regs __iomem *mmio_chan_fw;
> +
> +	/* Serialize hardware control register access */
> +	spinlock_t hw_ctrl_lock;
> +
> +	struct tasklet_struct desc_task;
> +
> +	/* Serialize descriptor preparation */
> +	spinlock_t submit_lock;
> +	bool ring_active;
> +	int cid;
> +
> +	/* Serialize completion processing */
> +	spinlock_t complete_lock;
> +	bool comp_ring_active;
> +
> +	/* channel index and irq */
> +	int index;
> +	int irq;
> +
> +	/*
> +	 * In driver context, head is advanced by producer while
> +	 * tail is advanced by consumer.
> +	 */
> +
> +	/* the head and tail for both desc_ring and hw_sq */
> +	int head;
> +	int tail;
> +	int phase_tag;
> +	struct switchtec_dma_hw_se_desc *hw_sq;
> +	dma_addr_t dma_addr_sq;

Looks like it is cycle HW descriptors. I found most DMA engine use two
model, one is link list and other is use cycle buffer. Is possible to
create common logic for it, so each dma driver just implement hardware
related part.

https://lore.kernel.org/imx/aWTyGpGN6WqtVCfN@ryzen/T/#t

which just abstract eDMA and HDMA, we may extend to more hardware, reduce
duplicate code.

There are some race condition need be confided. we needn't dupicate efforts
to debug these race condition for every hardware.

> +
> +	/* the tail for hw_cq */
> +	int cq_tail;
> +	struct switchtec_dma_hw_ce *hw_cq;
> +	dma_addr_t dma_addr_cq;
> +
> +	struct list_head list;
> +
> +	struct switchtec_dma_desc *desc_ring[SWITCHTEC_DMA_RING_SIZE];
> +};
> +
>  struct switchtec_dma_dev {
>  	struct dma_device dma_dev;
>  	struct pci_dev __rcu *pdev;
>  	void __iomem *bar;
> +
> +	struct switchtec_dma_chan **swdma_chans;
> +	int chan_cnt;
> +	int chan_status_irq;
> +};
> +
> +enum chan_op {
> +	ENABLE_CHAN,
> +	DISABLE_CHAN,
> +};
> +
> +enum switchtec_dma_opcode {
> +	SWITCHTEC_DMA_OPC_MEMCPY = 0,
> +	SWITCHTEC_DMA_OPC_RDIMM = 0x1,
> +	SWITCHTEC_DMA_OPC_WRIMM = 0x2,
> +	SWITCHTEC_DMA_OPC_RHI = 0x6,
> +	SWITCHTEC_DMA_OPC_NOP = 0x7,
> +};
> +
> +struct switchtec_dma_hw_se_desc {
> +	u8 opc;
> +	u8 ctrl;
> +	__le16 tlp_setting;
> +	__le16 rsvd1;
> +	__le16 cid;
> +	__le32 byte_cnt;
> +	__le32 addr_lo; /* SADDR_LO/WIADDR_LO */
> +	__le32 addr_hi; /* SADDR_HI/WIADDR_HI */
> +	__le32 daddr_lo;
> +	__le32 daddr_hi;
> +	__le16 dfid;
> +	__le16 sfid;
> +};

suppose need pack(1) and others, which need exactlly match hardware.

Frank
> +
> +#define SWITCHTEC_CE_SC_LEN_ERR		BIT(0)
> +#define SWITCHTEC_CE_SC_UR		BIT(1)
> +#define SWITCHTEC_CE_SC_CA		BIT(2)
> +#define SWITCHTEC_CE_SC_RSVD_CPL	BIT(3)
> +#define SWITCHTEC_CE_SC_ECRC_ERR	BIT(4)
> +#define SWITCHTEC_CE_SC_EP_SET		BIT(5)
> +#define SWITCHTEC_CE_SC_D_RD_CTO	BIT(8)
> +#define SWITCHTEC_CE_SC_D_RIMM_UR	BIT(9)
> +#define SWITCHTEC_CE_SC_D_RIMM_CA	BIT(10)
> +#define SWITCHTEC_CE_SC_D_RIMM_RSVD_CPL	BIT(11)
> +#define SWITCHTEC_CE_SC_D_ECRC		BIT(12)
> +#define SWITCHTEC_CE_SC_D_EP_SET	BIT(13)
> +#define SWITCHTEC_CE_SC_D_BAD_CONNID	BIT(14)
> +#define SWITCHTEC_CE_SC_D_BAD_RHI_ADDR	BIT(15)
> +#define SWITCHTEC_CE_SC_D_INVD_CMD	BIT(16)
> +#define SWITCHTEC_CE_SC_MASK		GENMASK(16, 0)
> +
> +struct switchtec_dma_hw_ce {
> +	__le32 rdimm_cpl_dw0;
> +	__le32 rdimm_cpl_dw1;
> +	__le32 rsvd1;
> +	__le32 cpl_byte_cnt;
> +	__le16 sq_head;
> +	__le16 rsvd2;
> +	__le32 rsvd3;
> +	__le32 sts_code;
> +	__le16 cid;
> +	__le16 phase_tag;
> +};
> +
> +struct switchtec_dma_desc {
> +	struct dma_async_tx_descriptor txd;
> +	struct switchtec_dma_hw_se_desc *hw;
> +	u32 orig_size;
> +	bool completed;
>  };
>
> +static int wait_for_chan_status(struct chan_hw_regs __iomem *chan_hw, u32 mask,
> +				bool set)
> +{
> +	u32 status;
> +
> +	return readl_poll_timeout_atomic(&chan_hw->status, status,
> +					 (set && (status & mask)) ||
> +					 (!set && !(status & mask)),
> +					 10, 100 * USEC_PER_MSEC);
> +}
> +
> +static int halt_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_HALT, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, true);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static int unhalt_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	u8 ctrl;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	ctrl = readb(&chan_hw->ctrl);
> +	ctrl &= ~SWITCHTEC_CHAN_CTRL_HALT;
> +	writeb(ctrl, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, false);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static void flush_pci_write(struct chan_hw_regs __iomem *chan_hw)
> +{
> +	readl(&chan_hw->cq_head);
> +}
> +
> +static int reset_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writel(SWITCHTEC_CHAN_CTRL_RESET | SWITCHTEC_CHAN_CTRL_ERR_PAUSE,
> +	       &chan_hw->ctrl);
> +	flush_pci_write(chan_hw);
> +
> +	udelay(1000);
> +
> +	writel(SWITCHTEC_CHAN_CTRL_ERR_PAUSE, &chan_hw->ctrl);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +	flush_pci_write(chan_hw);
> +
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
> +static int pause_reset_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +	flush_pci_write(chan_hw);
> +
> +	rcu_read_unlock();
> +
> +	/* wait 60ms to ensure no pending CEs */
> +	mdelay(60);
> +
> +	return reset_channel(swdma_chan);
> +}
> +
> +static int channel_op(struct switchtec_dma_chan *swdma_chan, int op)
> +{
> +	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
> +	struct pci_dev *pdev;
> +	u32 valid_en_se;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	valid_en_se = readl(&chan_fw->valid_en_se);
> +	if (op == ENABLE_CHAN)
> +		valid_en_se |= SWITCHTEC_CHAN_ENABLE;
> +	else
> +		valid_en_se &= ~SWITCHTEC_CHAN_ENABLE;
> +
> +	writel(valid_en_se, &chan_fw->valid_en_se);
> +
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
> +static int enable_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	return channel_op(swdma_chan, ENABLE_CHAN);
> +}
> +
> +static int disable_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	return channel_op(swdma_chan, DISABLE_CHAN);
> +}
> +
> +static void
> +switchtec_dma_cleanup_completed(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct device *chan_dev = &swdma_chan->dma_chan.dev->device;
> +	struct switchtec_dma_desc *desc;
> +	struct switchtec_dma_hw_ce *ce;
> +	struct dmaengine_result res;
> +	int tail, cid, se_idx, i;
> +	__le16 phase_tag;
> +	u32 sts_code;
> +	__le32 *p;
> +
> +	do {
> +		spin_lock_bh(&swdma_chan->complete_lock);
> +		if (!swdma_chan->comp_ring_active) {
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			break;
> +		}
> +
> +		ce = &swdma_chan->hw_cq[swdma_chan->cq_tail];
> +		/*
> +		 * phase_tag is updated by hardware, ensure the value is
> +		 * not from the cache
> +		 */
> +		phase_tag = smp_load_acquire(&ce->phase_tag);
> +		if (le16_to_cpu(phase_tag) == swdma_chan->phase_tag) {
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			break;
> +		}
> +
> +		cid = le16_to_cpu(ce->cid);
> +		se_idx = cid & (SWITCHTEC_DMA_SQ_SIZE - 1);
> +		desc = swdma_chan->desc_ring[se_idx];
> +
> +		tail = swdma_chan->tail;
> +
> +		res.residue = desc->orig_size - le32_to_cpu(ce->cpl_byte_cnt);
> +
> +		sts_code = le32_to_cpu(ce->sts_code);
> +
> +		if (!(sts_code & SWITCHTEC_CE_SC_MASK)) {
> +			res.result = DMA_TRANS_NOERROR;
> +		} else {
> +			if (sts_code & SWITCHTEC_CE_SC_D_RD_CTO)
> +				res.result = DMA_TRANS_READ_FAILED;
> +			else
> +				res.result = DMA_TRANS_WRITE_FAILED;
> +
> +			dev_err(chan_dev, "CID 0x%04x failed, SC 0x%08x\n", cid,
> +				(u32)(sts_code & SWITCHTEC_CE_SC_MASK));
> +
> +			p = (__le32 *)ce;
> +			for (i = 0; i < sizeof(*ce) / 4; i++) {
> +				dev_err(chan_dev, "CE DW%d: 0x%08x\n", i,
> +					le32_to_cpu(*p));
> +				p++;
> +			}
> +		}
> +
> +		desc->completed = true;
> +
> +		swdma_chan->cq_tail++;
> +		swdma_chan->cq_tail &= SWITCHTEC_DMA_CQ_SIZE - 1;
> +
> +		rcu_read_lock();
> +		if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
> +			rcu_read_unlock();
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			return;
> +		}
> +		writew(swdma_chan->cq_tail, &swdma_chan->mmio_chan_hw->cq_head);
> +		rcu_read_unlock();
> +
> +		if (swdma_chan->cq_tail == 0)
> +			swdma_chan->phase_tag = !swdma_chan->phase_tag;
> +
> +		/*  Out of order CE */
> +		if (se_idx != tail) {
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			continue;
> +		}
> +
> +		do {
> +			dma_cookie_complete(&desc->txd);
> +			dma_descriptor_unmap(&desc->txd);
> +			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
> +			desc->txd.callback = NULL;
> +			desc->txd.callback_result = NULL;
> +			desc->completed = false;
> +
> +			tail++;
> +			tail &= SWITCHTEC_DMA_SQ_SIZE - 1;
> +
> +			/*
> +			 * Ensure the desc updates are visible before updating
> +			 * the tail index
> +			 */
> +			smp_store_release(&swdma_chan->tail, tail);
> +			desc = swdma_chan->desc_ring[swdma_chan->tail];
> +			if (!desc->completed)
> +				break;
> +		} while (CIRC_CNT(READ_ONCE(swdma_chan->head), swdma_chan->tail,
> +				  SWITCHTEC_DMA_SQ_SIZE));
> +
> +		spin_unlock_bh(&swdma_chan->complete_lock);
> +	} while (1);
> +}
> +
> +static void
> +switchtec_dma_abort_desc(struct switchtec_dma_chan *swdma_chan, int force)
> +{
> +	struct switchtec_dma_desc *desc;
> +	struct dmaengine_result res;
> +
> +	if (!force)
> +		switchtec_dma_cleanup_completed(swdma_chan);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +
> +	while (CIRC_CNT(swdma_chan->head, swdma_chan->tail,
> +			SWITCHTEC_DMA_SQ_SIZE) >= 1) {
> +		desc = swdma_chan->desc_ring[swdma_chan->tail];
> +
> +		res.residue = desc->orig_size;
> +		res.result = DMA_TRANS_ABORTED;
> +
> +		dma_cookie_complete(&desc->txd);
> +		dma_descriptor_unmap(&desc->txd);
> +		if (!force)
> +			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
> +		desc->txd.callback = NULL;
> +		desc->txd.callback_result = NULL;
> +
> +		swdma_chan->tail++;
> +		swdma_chan->tail &= SWITCHTEC_DMA_SQ_SIZE - 1;
> +	}
> +
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +}
> +
> +static void switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_chan)
> +{
> +	int rc;
> +
> +	rc = halt_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
> +	writel(0, &swdma_chan->mmio_chan_fw->sq_base_hi);
> +	writel(0, &swdma_chan->mmio_chan_fw->cq_base_lo);
> +	writel(0, &swdma_chan->mmio_chan_fw->cq_base_hi);
> +
> +	rcu_read_unlock();
> +}
> +
> +static int switchtec_dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active = false;
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +
> +	return pause_reset_channel(swdma_chan);
> +}
> +
> +static void switchtec_dma_synchronize(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +
> +	int rc;
> +
> +	switchtec_dma_abort_desc(swdma_chan, 1);
> +
> +	rc = enable_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	rc = reset_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	rc = unhalt_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	swdma_chan->head = 0;
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active = true;
> +	swdma_chan->phase_tag = 0;
> +	swdma_chan->tail = 0;
> +	swdma_chan->cq_tail = 0;
> +	swdma_chan->cid = 0;
> +	dma_cookie_init(chan);
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +}
> +
> +static void switchtec_dma_desc_task(unsigned long data)
> +{
> +	struct switchtec_dma_chan *swdma_chan = (void *)data;
> +
> +	switchtec_dma_cleanup_completed(swdma_chan);
> +}
> +
> +static irqreturn_t switchtec_dma_isr(int irq, void *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan = chan;
> +
> +	if (swdma_chan->comp_ring_active)
> +		tasklet_schedule(&swdma_chan->desc_task);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t switchtec_dma_chan_status_isr(int irq, void *dma)
> +{
> +	struct switchtec_dma_dev *swdma_dev = dma;
> +	struct dma_device *dma_dev = &swdma_dev->dma_dev;
> +	struct switchtec_dma_chan *swdma_chan;
> +	struct chan_hw_regs __iomem *chan_hw;
> +	struct device *chan_dev;
> +	struct dma_chan *chan;
> +	u32 chan_status;
> +	int bit;
> +
> +	list_for_each_entry(chan, &dma_dev->channels, device_node) {
> +		swdma_chan = container_of(chan, struct switchtec_dma_chan,
> +					  dma_chan);
> +		chan_dev = &swdma_chan->dma_chan.dev->device;
> +		chan_hw = swdma_chan->mmio_chan_hw;
> +
> +		rcu_read_lock();
> +		if (!rcu_dereference(swdma_dev->pdev)) {
> +			rcu_read_unlock();
> +			goto out;
> +		}
> +
> +		chan_status = readl(&chan_hw->status);
> +		chan_status &= SWITCHTEC_CHAN_STS_PAUSED_MASK;
> +		rcu_read_unlock();
> +
> +		bit = ffs(chan_status);
> +		if (!bit)
> +			dev_dbg(chan_dev, "No pause bit set.\n");
> +		else
> +			dev_err(chan_dev, "Paused, %s\n",
> +				channel_status_str[bit - 1]);
> +	}
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +static void switchtec_dma_free_desc(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +	size_t size;
> +	int i;
> +
> +	size = SWITCHTEC_DMA_SQ_SIZE * sizeof(*swdma_chan->hw_sq);
> +	if (swdma_chan->hw_sq)
> +		dma_free_coherent(swdma_dev->dma_dev.dev, size,
> +				  swdma_chan->hw_sq, swdma_chan->dma_addr_sq);
> +
> +	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
> +	if (swdma_chan->hw_cq)
> +		dma_free_coherent(swdma_dev->dma_dev.dev, size,
> +				  swdma_chan->hw_cq, swdma_chan->dma_addr_cq);
> +
> +	for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++)
> +		kfree(swdma_chan->desc_ring[i]);
> +}
> +
> +static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
> +	struct switchtec_dma_desc *desc;
> +	struct pci_dev *pdev;
> +	size_t size;
> +	int rc, i;
> +
> +	swdma_chan->head = 0;
> +	swdma_chan->tail = 0;
> +	swdma_chan->cq_tail = 0;
> +
> +	size = SWITCHTEC_DMA_SQ_SIZE * sizeof(*swdma_chan->hw_sq);
> +	swdma_chan->hw_sq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
> +					       &swdma_chan->dma_addr_sq,
> +					       GFP_NOWAIT);
> +	if (!swdma_chan->hw_sq) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
> +	swdma_chan->hw_cq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
> +					       &swdma_chan->dma_addr_cq,
> +					       GFP_NOWAIT);
> +	if (!swdma_chan->hw_cq) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	/* reset host phase tag */
> +	swdma_chan->phase_tag = 0;
> +
> +	for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
> +		desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
> +		if (!desc) {
> +			rc = -ENOMEM;
> +			goto free_and_exit;
> +		}
> +
> +		dma_async_tx_descriptor_init(&desc->txd, &swdma_chan->dma_chan);
> +		desc->hw = &swdma_chan->hw_sq[i];
> +		desc->completed = true;
> +
> +		swdma_chan->desc_ring[i] = desc;
> +	}
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		rc = -ENODEV;
> +		goto free_and_exit;
> +	}
> +
> +	/* set sq/cq */
> +	writel(lower_32_bits(swdma_chan->dma_addr_sq), &chan_fw->sq_base_lo);
> +	writel(upper_32_bits(swdma_chan->dma_addr_sq), &chan_fw->sq_base_hi);
> +	writel(lower_32_bits(swdma_chan->dma_addr_cq), &chan_fw->cq_base_lo);
> +	writel(upper_32_bits(swdma_chan->dma_addr_cq), &chan_fw->cq_base_hi);
> +
> +	writew(SWITCHTEC_DMA_SQ_SIZE, &swdma_chan->mmio_chan_fw->sq_size);
> +	writew(SWITCHTEC_DMA_CQ_SIZE, &swdma_chan->mmio_chan_fw->cq_size);
> +
> +	rcu_read_unlock();
> +	return 0;
> +
> +free_and_exit:
> +	switchtec_dma_free_desc(swdma_chan);
> +	return rc;
> +}
> +
> +static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +	u32 perf_cfg;
> +	int rc;
> +
> +	rc = switchtec_dma_alloc_desc(swdma_chan);
> +	if (rc)
> +		return rc;
> +
> +	rc = enable_channel(swdma_chan);
> +	if (rc)
> +		return rc;
> +
> +	rc = reset_channel(swdma_chan);
> +	if (rc)
> +		return rc;
> +
> +	rc = unhalt_channel(swdma_chan);
> +	if (rc)
> +		return rc;
> +
> +	swdma_chan->ring_active = true;
> +	swdma_chan->comp_ring_active = true;
> +	swdma_chan->cid = 0;
> +
> +	dma_cookie_init(chan);
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(swdma_dev->pdev)) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	perf_cfg = readl(&swdma_chan->mmio_chan_fw->perf_cfg);
> +	rcu_read_unlock();
> +
> +	dev_dbg(&chan->dev->device, "Burst Size:  0x%x\n",
> +		FIELD_GET(PERF_BURST_SIZE_MASK, perf_cfg));
> +
> +	dev_dbg(&chan->dev->device, "Burst Scale: 0x%x\n",
> +		FIELD_GET(PERF_BURST_SCALE_MASK, perf_cfg));
> +
> +	dev_dbg(&chan->dev->device, "Interval:    0x%x\n",
> +		FIELD_GET(PERF_INTERVAL_MASK, perf_cfg));
> +
> +	dev_dbg(&chan->dev->device, "Arb Weight:  0x%x\n",
> +		FIELD_GET(PERF_ARB_WEIGHT_MASK, perf_cfg));
> +
> +	dev_dbg(&chan->dev->device, "MRRS:        0x%x\n",
> +		FIELD_GET(PERF_MRRS_MASK, perf_cfg));
> +
> +	return SWITCHTEC_DMA_SQ_SIZE;
> +}
> +
> +static void switchtec_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	swdma_chan->ring_active = false;
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active = false;
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +
> +	switchtec_dma_chan_stop(swdma_chan);
> +	switchtec_dma_abort_desc(swdma_chan, 0);
> +	switchtec_dma_free_desc(swdma_chan);
> +
> +	disable_channel(swdma_chan);
> +}
> +
> +static int switchtec_dma_chan_init(struct switchtec_dma_dev *swdma_dev,
> +				   struct pci_dev *pdev, int i)
> +{
> +	struct dma_device *dma = &swdma_dev->dma_dev;
> +	struct switchtec_dma_chan *swdma_chan;
> +	u32 valid_en_se, thresh;
> +	int se_buf_len, irq, rc;
> +	struct dma_chan *chan;
> +
> +	swdma_chan = kzalloc(sizeof(*swdma_chan), GFP_KERNEL);
> +	if (!swdma_chan)
> +		return -ENOMEM;
> +
> +	swdma_chan->phase_tag = 0;
> +	swdma_chan->index = i;
> +	swdma_chan->swdma_dev = swdma_dev;
> +
> +	spin_lock_init(&swdma_chan->hw_ctrl_lock);
> +	spin_lock_init(&swdma_chan->submit_lock);
> +	spin_lock_init(&swdma_chan->complete_lock);
> +	tasklet_init(&swdma_chan->desc_task, switchtec_dma_desc_task,
> +		     (unsigned long)swdma_chan);
> +
> +	swdma_chan->mmio_chan_fw =
> +		swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET +
> +		i * SWITCHTEC_DMA_CHAN_FW_REGS_SIZE;
> +	swdma_chan->mmio_chan_hw =
> +		swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CTRL_OFFSET +
> +		i * SWITCHTEC_DMA_CHAN_HW_REGS_SIZE;
> +
> +	swdma_dev->swdma_chans[i] = swdma_chan;
> +
> +	rc = pause_reset_channel(swdma_chan);
> +	if (rc)
> +		goto free_and_exit;
> +
> +	/* init perf tuner */
> +	writel(FIELD_PREP(PERF_BURST_SCALE_MASK, 1) |
> +	       FIELD_PREP(PERF_MRRS_MASK, 3) |
> +	       FIELD_PREP(PERF_BURST_SIZE_MASK, 6) |
> +	       FIELD_PREP(PERF_ARB_WEIGHT_MASK, 1),
> +	       &swdma_chan->mmio_chan_fw->perf_cfg);
> +
> +	valid_en_se = readl(&swdma_chan->mmio_chan_fw->valid_en_se);
> +
> +	dev_dbg(&pdev->dev, "Channel %d: SE buffer base %d\n", i,
> +		FIELD_GET(SE_BUF_BASE_MASK, valid_en_se));
> +
> +	se_buf_len = FIELD_GET(SE_BUF_LEN_MASK, valid_en_se);
> +	dev_dbg(&pdev->dev, "Channel %d: SE buffer count %d\n", i, se_buf_len);
> +
> +	thresh = se_buf_len / 2;
> +	valid_en_se |= FIELD_GET(SE_THRESH_MASK, thresh);
> +	writel(valid_en_se, &swdma_chan->mmio_chan_fw->valid_en_se);
> +
> +	/* request irqs */
> +	irq = readl(&swdma_chan->mmio_chan_fw->int_vec);
> +	dev_dbg(&pdev->dev, "Channel %d: CE irq vector %d\n", i, irq);
> +
> +	rc = pci_request_irq(pdev, irq, switchtec_dma_isr, NULL, swdma_chan,
> +			     KBUILD_MODNAME);
> +	if (rc)
> +		goto free_and_exit;
> +
> +	swdma_chan->irq = irq;
> +
> +	chan = &swdma_chan->dma_chan;
> +	chan->device = dma;
> +	dma_cookie_init(chan);
> +
> +	list_add_tail(&chan->device_node, &dma->channels);
> +
> +	return 0;
> +
> +free_and_exit:
> +	kfree(swdma_chan);
> +	return rc;
> +}
> +
> +static int switchtec_dma_chan_free(struct pci_dev *pdev,
> +				   struct switchtec_dma_chan *swdma_chan)
> +{
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	swdma_chan->ring_active = false;
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active = false;
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +
> +	pci_free_irq(pdev, swdma_chan->irq, swdma_chan);
> +	tasklet_kill(&swdma_chan->desc_task);
> +
> +	switchtec_dma_chan_stop(swdma_chan);
> +
> +	return 0;
> +}
> +
> +static int switchtec_dma_chans_release(struct pci_dev *pdev,
> +				       struct switchtec_dma_dev *swdma_dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < swdma_dev->chan_cnt; i++)
> +		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
> +
> +	return 0;
> +}
> +
> +static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
> +					 struct pci_dev *pdev, int chan_cnt)
> +{
> +	struct dma_device *dma = &swdma_dev->dma_dev;
> +	int base, cnt, rc, i;
> +
> +	swdma_dev->swdma_chans = kcalloc(chan_cnt, sizeof(*swdma_dev->swdma_chans),
> +					 GFP_KERNEL);
> +
> +	if (!swdma_dev->swdma_chans)
> +		return -ENOMEM;
> +
> +	base = readw(swdma_dev->bar + SWITCHTEC_REG_SE_BUF_BASE);
> +	cnt = readw(swdma_dev->bar + SWITCHTEC_REG_SE_BUF_CNT);
> +
> +	dev_dbg(&pdev->dev, "EP SE buffer base %d\n", base);
> +	dev_dbg(&pdev->dev, "EP SE buffer count %d\n", cnt);
> +
> +	INIT_LIST_HEAD(&dma->channels);
> +
> +	for (i = 0; i < chan_cnt; i++) {
> +		rc = switchtec_dma_chan_init(swdma_dev, pdev, i);
> +		if (rc) {
> +			dev_err(&pdev->dev, "Channel %d: init channel failed\n",
> +				i);
> +			chan_cnt = i;
> +			goto err_exit;
> +		}
> +	}
> +
> +	return chan_cnt;
> +
> +err_exit:
> +	for (i = 0; i < chan_cnt; i++)
> +		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
> +
> +	kfree(swdma_dev->swdma_chans);
> +
> +	return rc;
> +}
> +
>  static void switchtec_dma_release(struct dma_device *dma_dev)
>  {
>  	struct switchtec_dma_dev *swdma_dev =
>  		container_of(dma_dev, struct switchtec_dma_dev, dma_dev);
> +	int i;
> +
> +	for (i = 0; i < swdma_dev->chan_cnt; i++)
> +		kfree(swdma_dev->swdma_chans[i]);
> +
> +	kfree(swdma_dev->swdma_chans);
>
>  	put_device(dma_dev->dev);
>  	kfree(swdma_dev);
> @@ -37,9 +997,9 @@ static void switchtec_dma_release(struct dma_device *dma_dev)
>  static int switchtec_dma_create(struct pci_dev *pdev)
>  {
>  	struct switchtec_dma_dev *swdma_dev;
> +	int chan_cnt, nr_vecs, irq, rc;
>  	struct dma_device *dma;
>  	struct dma_chan *chan;
> -	int nr_vecs, rc;
>
>  	/*
>  	 * Create the switchtec dma device
> @@ -58,18 +1018,51 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>  	if (rc < 0)
>  		goto err_exit;
>
> +	irq = readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);
> +	pci_dbg(pdev, "Channel pause irq vector %d\n", irq);
> +
> +	rc = pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr,
> +			     swdma_dev, KBUILD_MODNAME);
> +	if (rc)
> +		goto err_exit;
> +
> +	swdma_dev->chan_status_irq = irq;
> +
> +	chan_cnt = readl(swdma_dev->bar + SWITCHTEC_REG_CHAN_CNT);
> +	if (!chan_cnt) {
> +		pci_err(pdev, "No channel configured.\n");
> +		rc = -ENXIO;
> +		goto err_exit;
> +	}
> +
> +	chan_cnt = switchtec_dma_chans_enumerate(swdma_dev, pdev, chan_cnt);
> +	if (chan_cnt < 0) {
> +		pci_err(pdev, "Failed to enumerate dma channels: %d\n",
> +			chan_cnt);
> +		rc = -ENXIO;
> +		goto err_exit;
> +	}
> +
> +	swdma_dev->chan_cnt = chan_cnt;
> +
>  	dma = &swdma_dev->dma_dev;
>  	dma->copy_align = DMAENGINE_ALIGN_8_BYTES;
>  	dma->dev = get_device(&pdev->dev);
>
> +	dma->device_alloc_chan_resources = switchtec_dma_alloc_chan_resources;
> +	dma->device_free_chan_resources = switchtec_dma_free_chan_resources;
> +	dma->device_terminate_all = switchtec_dma_terminate_all;
> +	dma->device_synchronize = switchtec_dma_synchronize;
>  	dma->device_release = switchtec_dma_release;
>
>  	rc = dma_async_device_register(dma);
>  	if (rc) {
>  		pci_err(pdev, "Failed to register dma device: %d\n", rc);
> -		goto err_exit;
> +		goto err_chans_release_exit;
>  	}
>
> +	pci_dbg(pdev, "Channel count: %d\n", chan_cnt);
> +
>  	list_for_each_entry(chan, &dma->channels, device_node)
>  		pci_dbg(pdev, "%s\n", dma_chan_name(chan));
>
> @@ -77,7 +1070,13 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>
>  	return 0;
>
> +err_chans_release_exit:
> +	switchtec_dma_chans_release(pdev, swdma_dev);
> +
>  err_exit:
> +	if (swdma_dev->chan_status_irq)
> +		free_irq(swdma_dev->chan_status_irq, swdma_dev);
> +
>  	iounmap(swdma_dev->bar);
>  	kfree(swdma_dev);
>  	return rc;
> @@ -122,9 +1121,13 @@ static void switchtec_dma_remove(struct pci_dev *pdev)
>  {
>  	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
>
> +	switchtec_dma_chans_release(pdev, swdma_dev);
> +
>  	rcu_assign_pointer(swdma_dev->pdev, NULL);
>  	synchronize_rcu();
>
> +	pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
> +
>  	pci_free_irq_vectors(pdev);
>
>  	dma_async_device_unregister(&swdma_dev->dma_dev);
> --
> 2.47.3
>

