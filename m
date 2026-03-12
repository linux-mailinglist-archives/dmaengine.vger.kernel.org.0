Return-Path: <dmaengine+bounces-9411-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ICyGmkds2mDSAAAu9opvQ
	(envelope-from <dmaengine+bounces-9411-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 21:09:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5F27888B
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 21:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7997E31D6916
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 20:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E32D401A29;
	Thu, 12 Mar 2026 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UEo9Wp1s"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011070.outbound.protection.outlook.com [40.107.130.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B985E401A2A;
	Thu, 12 Mar 2026 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345936; cv=fail; b=fuI4bRGs9px7P5H7DD90Ez93++wLj+fPduZ0Gnh2otQEEjfMw25u9AV07mkxNDf7iCL8kn5C+J7Xl3Ql2MjCnS7AEtykaBX2dfmCy5FHtT6pVlOijgIjzbysAhvp1nlRBoW28zj35B6HKyo1LPlQIOREddC7PzVGg50mkhjQNiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345936; c=relaxed/simple;
	bh=Xt3TvoK8YsnA0OnoHi5HdPIwAWmSaVj0M8b8xVNcp2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ta6lWm2YotgEiuWSnYqSJr7pgz3fIHe9nLO1i8KCYdcwosKAzHBhvZ4QKlqMmXmC0Vh2BScHVcWvNPXdOzPCPWaPXwr8XWe3p4zHzN/KMgGoUqmMKXq89z2AUV9XpQHi/zen4gl8dF3XzqCnFHlvf+ZNLTgCmeJ3UD2nsyfKQjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UEo9Wp1s; arc=fail smtp.client-ip=40.107.130.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyAwxXcWobfbrqP8c27EbBLXi1vIjmRwCINefvRSV77M8OGyvS5gnHeSB72ZPRetNOVw6WM1Y3TnNyeLgfFKCQfJnCorYbrt3SPu86Iola9ZPTaV4J+FpOiqGImcYYVeWNMIFbpcqoly+FrphFkQDalaiQPQKWFvlUXfTSktdwgGwFLOQxDjPaGTrWC80xgpJwKOjT2tui71DmheklUITc9ZJXeICli9ernbu5P/0xlu+RpoyrQXXnB8y6k5nKd8smdHblwzAmqatJDjEdOcs/xfmR25rCR953PX3MqP/pDH3wxnMcXVxEoyJmWvnq1052/7b7o7AgiEnCXICWUnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBjCunag6a1h8fyjZiq2mXW67o5EG82mGw82TGCOaO0=;
 b=K93ruEGIV4Rmp8i0EK79/2UyHWrWKP2Um5bTtUBTmUImNZSOjOigK7ajaTpQJwFJDaasgIPm7bZjRwvZ2qtPy8h7PZ9D7tmpmMi15maYrdSVROykEYIUbrftfxfJPrhqiYDAWdnmNTrIkjumaTvxu56jSVonx2E2eWKr1P1LpBBZtCFVpTOW/iVXnAaEUrl8jRw+3sSM4ZXiZuwiGFxfYdfz9duNrlq6BwZk7xVRxjE4oIjEAJWnpRogrmW3O2dds1k2nPg9vWnnYvhcwV4euI0MQli10TKxGdFuBh18H+mAImoa9ZKYve4LlvleEHj1naFs1aRFtOKZ5ia3eV4S3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBjCunag6a1h8fyjZiq2mXW67o5EG82mGw82TGCOaO0=;
 b=UEo9Wp1sRtrsFAxn3AbUHU9E4w4V+m5nwKcR3GWda1aa4zo2MplSyGw3qciDc4YLfA5dqeU30umeK8dVs1PbOklc1khJ6oEnRAqxURfWCJjKwGu94GLy/x9bhVND55sM+XBL9pwoIypQT2jIdW00AtTiFyROO8PnTCFQ5Bx9SaHZEOfcwZw7XowuypK91WdrxYkXt2QNFL33VNZcenSU4X0nvBcCT+29ubiFb+lA+PLL0AU4PfAH9wVx5eLZFWgdZmsz6MxB0yJiRqxPAqPXjxjD8LorOLcP3KNySX6pDnGrNl9tJW4jOgCiCOX04/X+yeTEMQ5tkltehZQ8QsynYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB10466.eurprd04.prod.outlook.com (2603:10a6:102:450::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 20:05:28 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 20:05:30 +0000
Date: Thu, 12 Mar 2026 16:05:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 01/15] dmaengine: dw-edma: Cache DMA channel IDs in
 dw_edma_chip
Message-ID: <abMcgQOHDD55Yv0e@lizhi-Precision-Tower-5810>
References: <20260312165005.1148676-1-den@valinux.co.jp>
 <20260312165005.1148676-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312165005.1148676-2-den@valinux.co.jp>
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB10466:EE_
X-MS-Office365-Filtering-Correlation-Id: 349add3c-c752-41bc-b4e9-08de8072b5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|22082099003|18002099003|7053199007|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	4di/aFqNyYie6EX6SpjkBuGHjr9OzUbjxmBUfC+R1gJyGApyXOihs+9gTQLInKzneLHNAi4Jsa/6jS7l6bkT0OMBG2LfZNpPv9ZeabnESuu0hGjQAB5wvLRsQo+bay36M4KVVhibCGpfPQNa30oASY9/yWhFQD+DTUb6F2WNtqXL59BZCAaWpbvoG597mExPoYmljr3bIsYkkSQyS+WWuLiWOwyACixmLI4HXsMPpWWAmisAYSF+qdUHBpl1S/hqcKKsoX/2Tw9Q9rMMWFLCz703m6lNFwIFrp2G4qNLZW+7lR2j8LgC0L81f1Q0DwoS7b0c9JlHMAviv2W3s0X2aeaG/hdfgi+vmhP9HbsywnYcQTzgmoQje86FSRdrMSSAYy+ooxDChXMMZHF3rxBhdTaKA6LUrDjLKjvRnM3d5QZ8E8Hc8VHJZohE8WhIHqwqdgMYBrphvB6G4MZUcVqbm8JleFxbBG1egy1L2W1lwQV+UbK3ODoGnXK7kzJZgRJQgUwE0J7lYZd2LYszGlbY5PbkunE1Vs4eZvDZegafUlXC7a5iuWIE1XbSBHD5ncs3MpRGGPKgxSK/wnCUFyURLACNwc415D3qRi9Ahg7kZzJrGW8CLY9wOlaaiFlQfu6zAIIMBCuRShqRLZQFx0/5LPwdZ8OtqSq84sgFSgI77Ium7Ud6roa/1haMnpaXd3+bUC27HOb2kqkWRsusEtmPhuu927MnYO8P8F1BFsa89je7Jgd+roW1D4Ke6KLoLJfXdfD98UUTZXKRXw6tHZ0Gz4J0fvm4ttTI4eeeKsTyEpo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(22082099003)(18002099003)(7053199007)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vayJNKJOTmqrawCm178V9ue4qiDDSpbPlD9dBrwMucVBnvnMF3aG9lhhenep?=
 =?us-ascii?Q?vSvid2sAIA3asvlbSfzEmpp+QONzuIr0Xh0Xrew2Uiz6JCE7VGGFBFgz6p0p?=
 =?us-ascii?Q?+q2+m4SVz3S5Mt1o8hcnjRJhhhT5gHAZ2o9Ro8MAm9ULn+iFwi9SI57fo/gR?=
 =?us-ascii?Q?Z9+nytXHHg+bPYWyn5aLizYh7YIul4BFz2qoEv+epyLPvpsJszu2GgQbpe7c?=
 =?us-ascii?Q?RURCB3/OQ8MyAHysi7C4l2+7x0SMfA0wXAH0QFxVqF3mvDMbBpB+dYf77MT7?=
 =?us-ascii?Q?UIlZwSkliIC8+mdVSQFsigSIZQ0Cp/rrXPdaSuVrKcm5KwFwlw3N0zmNtOa5?=
 =?us-ascii?Q?6HMYZye0Stsi/zWTR/UwbrVI9GOL+K5jN9yxp0/0wKH7bZIzVu66rM0YLZWg?=
 =?us-ascii?Q?2uExb0WMJAv57XFZ6nvO8hlLnlY3puLLMP3GGwpVRm3OPIyMGwOcho8uQY4D?=
 =?us-ascii?Q?iZXOzOt576LvJiFwXU7H3eY+gzJrLPJlPpaUbtSqfvedBCbXRYY8PWIC1mTr?=
 =?us-ascii?Q?k1HsxClN8NLwC7y9fBmsHzlxH4DdSJCTdjFoaZtllgnIx5xXpLOc79B7URco?=
 =?us-ascii?Q?whRt+YN6QfDx01HMotglCTRZciZm1EnPtP0bqYk97r1flpwcfxFPY2rp8AUL?=
 =?us-ascii?Q?kj6vorh8bCGRMi7/e1Bef3DNrsFT5BFlNT84L9+E3FDc84gwE6GrzW9i+R91?=
 =?us-ascii?Q?0l85o/PXqWtCboNi1/whQNc/rRsrD/H0gcr1r0v31IQG3tdk+DyCw+3dIHer?=
 =?us-ascii?Q?+wjEo0TkW6oboclfLGvQK0inXUAMmRSznxs47Ka9zuYnsjMrlBY3l4s6fmOp?=
 =?us-ascii?Q?X5UXCsBEsQbJ0SMEGQWPYDvI3U0aNIXPi+LLB/v5vPi3xRyq7gfiV+8/YR/5?=
 =?us-ascii?Q?kyC+rb1zhZKExAmSeWU/mb65RxsP97WsRnRDGVDmJYiI2fM231g2zI5Z111C?=
 =?us-ascii?Q?dbmflW5V59RMzjADsD459tZnU042aySD51L5oUmgbw0hkTKBTyjaPFLdHbxZ?=
 =?us-ascii?Q?Lhbm7wwy/FnMxfbEJbw2Nvcj0PbkonqcesQUZltFdlpJ28Zd3TYoTEFw/Z1B?=
 =?us-ascii?Q?9kTC1NWtW5dbgVhr1lr0kHKCbpcsFM8JBmj6vofiRXrjLM73COyhEHFnXjJK?=
 =?us-ascii?Q?COMcj7uoCut0Z5/Hi5oN3ahFL3zck/uP7Lnz65QGVF8lIwTlwh/8HKPm2mYz?=
 =?us-ascii?Q?K/I08dNI0pQqWgmpCERbHLLsCYb8rq8lx+B7C3F7Tp0R7r2XkzM2Vqdl8DwX?=
 =?us-ascii?Q?q3kdZoe9NbHlraLDSDipvc2S3+C1GnVi8xKRxe13CNE4qoCH3FSejByaVCU7?=
 =?us-ascii?Q?6WEDKFPNZAu8q2ETPRT/LLj6Hf9iX9hDa+sHrllbsk5B9/C5ilentf+NPgLz?=
 =?us-ascii?Q?/IJPFHf1kzlNKff7CtB6/zpfOGyTAwpE2RMq8S/dn8NFAPu1Dw+HEahcBhqz?=
 =?us-ascii?Q?5UDGqHAum6AW3K2AIrNeqir6vHQpeS3yVj0ZpdPxB1ZdcZdI8CFfMJ+t+2ur?=
 =?us-ascii?Q?0SNjFsdhVXo7AlIn7hT7BbIoYU8J1nfPwm00UyRzc4+TZnjfwcMUQhVVTAAs?=
 =?us-ascii?Q?qziVmkdPz3/mX+0MBxz92bqNihdboIBguswFTTNjKMjmBvSG8HwyF8AAI/VP?=
 =?us-ascii?Q?Ute0sdpG5viBat+qlculA0X3SakeMUDwAw+TgkRf+bQis7ciqdW9FPO6Rsko?=
 =?us-ascii?Q?kwOcfYVSNOLvXsWlYwylfPdudZrqGOPJNlHoRn3eenrETBux?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349add3c-c752-41bc-b4e9-08de8072b5e2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:05:30.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDIC4s3dsKAyfHN9tGUyBsJjteKysg9lvRoBc9NWNHijSSJ1+pme9OdMW2BkcBNn2cy5qSdrw6HvbksLgkMLfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10466
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9411-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dma_chan.id:url]
X-Rspamd-Queue-Id: BBE5F27888B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 01:49:51AM +0900, Koichiro Den wrote:
> The exported-DMA path needs to describe each exposed descriptor window
> with the DMAEngine channel ID that owns it. Those IDs are only assigned
> once the channels have been registered.
>
> Cache the dma_chan IDs in dw_edma_chip after registration so controller
> frontends can later publish them as auxiliary-resource metadata without
> reaching back into the live channel objects.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 18 +++++++++++++++++-
>  include/linux/dma/edma.h           |  4 ++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index cd34a3ea602d..a13beacce2e7 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -837,6 +837,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  	struct dma_device *dma;
>  	u32 i, ch_cnt;
>  	u32 pos;
> +	int ret;
>
>  	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
>  	dma = &dw->dma;
> @@ -932,7 +933,22 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  	dma_set_max_seg_size(dma->dev, U32_MAX);
>
>  	/* Register DMA device */
> -	return dma_async_device_register(dma);
> +	ret = dma_async_device_register(dma);
> +	if (ret)
> +		return ret;
> +
> +	/* Cache dma_chan.id in dw_edma_chip */
> +	for (i = 0; i < ch_cnt; i++) {
> +		chan = &dw->chan[i];
> +
> +		if (i < dw->wr_ch_cnt)
> +			chip->chan_ids_wr[i] = chan->vc.chan.chan_id;
> +		else
> +			chip->chan_ids_rd[i - dw->wr_ch_cnt] =
> +						chan->vc.chan.chan_id;
> +	}

why need cache in dw_edma_chip? you's cache into chan.

Frank
> +
> +	return 0;
>  }
>
>  static inline void dw_edma_dec_irq_alloc(int *nr_irqs, u32 *alloc, u16 cnt)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 9da53c75e49b..0b861e8d305e 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -100,6 +100,10 @@ struct dw_edma_chip {
>  	int			db_irq;
>  	resource_size_t		db_offset;
>
> +	/* dma_chan ids */
> +	int			chan_ids_wr[EDMA_MAX_WR_CH];
> +	int			chan_ids_rd[EDMA_MAX_RD_CH];
> +
>  	enum dw_edma_map_format	mf;
>
>  	struct dw_edma		*dw;
> --
> 2.51.0
>

