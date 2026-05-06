Return-Path: <dmaengine+bounces-10237-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEHJLBNX+2n+ZQMAu9opvQ
	(envelope-from <dmaengine+bounces-10237-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:58:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 132AC4DCC09
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 229BE3062949
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9147E48033C;
	Wed,  6 May 2026 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dmDauxtS"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5128480355;
	Wed,  6 May 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078823; cv=fail; b=gBtDcUabtm6yMPXmeNr5yTltj9wkZfGBLPLq8w8u4KjaX+UR/9vkDIVi/gqxUTa5OCO6/h49mmVb45zWZloxUntg53HyeVKFNt2J12ehxn/K8CdK3zQoWthmIn4/IeF/8dmGgRSWc9SmLDNKBzBzU06jZ/9njUDQobDuUgAVqRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078823; c=relaxed/simple;
	bh=bW8QuCzFdidKTY1UA4T19ABZBb9tisrml/zwcEfHOXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P8mOLR9BuizA8TyK4bsyUkHyY7zavfqyVZjAGeh5u7xqV0R29mSrbINFtMA1rh/vg0q5LqirJXsBCuTsGvu2djB+KNL+LcYJB81HXHtExOcaPeDgzbB23O4ZEEQd4PXuq6XzatX1oOH4shgqlow9hZiNFobQvD34V4YM+Nj/QpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dmDauxtS reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmhf3TBpJNxoEOpE8IURmHv1vFDWZCPhCvY8rEZ1met5oi29DU7MT3/KEfyRZZzNY2KpBL7yOS2g3VedYBRF1SYSqH0ewFhTT+jvymryjcExyy/ehTG1Nd2Jgdl2prN9jjoZO+n1BPPrs1BJwNj43tFWrgOti6b9D6sCXUi7NdjQ8ElQHdhXtxRYxBYAl4A0Uj3ud0uuPY89Uh5MavzWNq5sLr6uvDqN+bB6thKYyrjdZ9r/6Zy9vdMR5lHUgQTjeqY90HsXF+6VVtlJavOyUyu0OQqyvKMSiIYiescZIpBMTvU7c0zWQBPlqSIyTOPG1PmyEOnhtD8af6FLLWOSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyZgg7NxxOS6qrs/HTZTlH8lopFKVxICv2Fe9Q44+eg=;
 b=wXdZ/NxXWMJe8yJOkeijcTP91GOxyhZm0Do1Sa5y4H1nEw+Qi91i73Lrj8kCKc71icGRHaZurrmZ1EvGOtytAGrg3WOAvrazvC7f+v9n87ZdptHXzdNYUMCrAN+9ThnBjUUFpd272fYrIwJxWLQngO5nUJqQt8wJDR9VRLu4Jp+u1WL7oRJVv16hASOKVodxtrQQBy+O05az/kEcci9Cg9zC2DwYl+7JHw2c6pkbdj5pl7cA0VmANQpwToFDgiI8BcnAb/va9fpFwgyWADAHzOufRYOxtovteyGWQijSxuQ10ItePENioK2RpyBXrWj2XicxfOlQSCoexDlrJq778g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyZgg7NxxOS6qrs/HTZTlH8lopFKVxICv2Fe9Q44+eg=;
 b=dmDauxtSoGEP8BRecJQye5qQUwua7WkvGTEDWnQHmsK/WfWhPHwQtBgFh9UsFgJlbywzG3R1OSABxbiaLFWWbv/4093u6ySvT9qTQKqJOcL7tgJ1z5LaLJoP5G9xRjmw3VtnRpw7uSFnqy+ZEMpi6skXAO1R8xtBcAGqj+WYg58SMvUd3UtGa7gJEuVnz3qsiF9yBT94fizvS/I6A7phic/P3Tz3NLuo7YI+RPPx6y2s7Y1ym/Dmz8WXEsCNE1HZJ9VHEFsoJM/IKdPoZnCCZkIZQ6FShtSLEr7zASY1N7NnkeImBRQVnvVZQDB/5TpXRq5k5uvFkYLxMvf6l4RldQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS4PR04MB9689.eurprd04.prod.outlook.com (2603:10a6:20b:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:46:54 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 14:46:54 +0000
Date: Wed, 6 May 2026 10:46:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: fsl-edma: Support dynamic
 scatter/gather chaining
Message-ID: <aftUV3F8T4i4KeaT@lizhi-Precision-Tower-5810>
References: <20260506-fsl-edma-dyn-sg-v2-0-66439cdd414e@bootlin.com>
 <20260506-fsl-edma-dyn-sg-v2-2-66439cdd414e@bootlin.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-fsl-edma-dyn-sg-v2-2-66439cdd414e@bootlin.com>
X-ClientProxiedBy: SN7PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:806:120::19) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS4PR04MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8b18a1-976f-4873-9ca9-08deab7e50dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|56012099003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tVl+Qs9/N8Jgwt5vpOHwGBU87M4PPkijzbU4kRa4YZ4VOWH0YzVLntqm1QwMk/aMIL7aOhpeSliItr4dmiqBnsdzOlmGLcIhN8IuezF2Z+Yiry01k/XKCG5V7rzxwBOp/4sPrPpPwEMQUlMz9wndO75L7BQQoyPc5lZvGDs67uVp0EyNGiDIVT3L2k3rHYM8aU9tjabSJmErJl7qG39Ua7LZ6nv6qfze3Bxz1svILw7bS9aBt1PVvB3ttCz4KJdfMZZU9XcW60JiWsAkqpx4SN7zn8Xt6E3IWf3buOq5bJ2t9/9Q8Cv+OTV7iXGslWQd8GXHMw/SZ/+i9Wi8D51f8WEpL4UP7zXk4by6BJkTxtlt+AE6ksjN7GmUiXa7sMcwsPL3Ao8vogq/sMkNMQiYtINu7uzgoX/w2GFFVoA35zhfet31/50W5OzIv+N1Wjgq45fO1yTfqaPBvxVnel7WcTjnoyTU3HkL8vK995J4AnX+1tL5NQxusQZnbI0V44muWeLnhqpggDSbVClJc6AvTOJ775j0kW44JYw43fqDOwlbaZ8X6hira50rQeaggNsR/aJjXZ3Mq6KaMhlLVBgfh426fAmur/XzvJnaYAWcUStU3sLAIYlni5edAPkiXvvGOOP25j6QLqESqFjcPpJYST9v5vuCvCxXAWtGlRM7iywAi1p2z7bhzdlBJ5FpiTu5i0vPR0VnhmUMkFCwhwAxlVN1raOGV9NFqiNqzC+MTZ9Nz0P1w9jI/oklky35CUPo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(56012099003)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?fPg29KnAvbsa2s3Lz6efv3wZCF0/h3GV+25L8SMkJKsRqA6umxmCkhDLna?=
 =?iso-8859-1?Q?kHSHS3MA0tFaVUW8aD0KItXMavLB4KhRwmQmxIrHv0XOM0VgXKpo+/8lc0?=
 =?iso-8859-1?Q?y9PN3IJvxcBfUCw2pN0SHVJePpYr5GvRYwLzRbgjI2DlnuUoX+6UBGKUUk?=
 =?iso-8859-1?Q?0svi8nUUuVV/U/i8XX3mXM/mFwDE2z7a96+Wm2vC5LPLYruja68QAX2WkH?=
 =?iso-8859-1?Q?wA+2V7rG4n6TTz7xzCYdnm/qOdqPbNifcimNOlAj+vp6OXgt5FdsJN0iS7?=
 =?iso-8859-1?Q?vAGymHAQskVPrSMoW1APfjNl8420z6eCUr0EFb0ngIBBQ5j3LGil+Zde1s?=
 =?iso-8859-1?Q?AXXvTSMcBbi5VQz808xiKLBn/o7gyvb1KxWE2Zr1XTVnzyFgZ4V+vfU5iu?=
 =?iso-8859-1?Q?mrWXDTMCFjNg6o7T1WXZgkBpnUaHoujJqD8EB4KgQgy1YOz9XXtRpDIK+4?=
 =?iso-8859-1?Q?kdO52l9ipx7WI2cuIXe+NIyP6tZTXtPIwdclbJabUwq3ChqfO3CWgnBuCO?=
 =?iso-8859-1?Q?8W6+ZurYO/IZj58RwpVsgKFCJvqs3Ut1pgF1en0Sv54ZoeFHiyh6pHc+xV?=
 =?iso-8859-1?Q?ZvWpQtACAkMztzfmgl04iNxKLGDqkPvTb10Bzuw2P2LJ6Um5F3MvvjkA3V?=
 =?iso-8859-1?Q?mWC21YlHR0iX7pu63O0Ot2+MR0QPqaR69zlCMRg+q2qFvBz3+6YyECv//I?=
 =?iso-8859-1?Q?CKEkYtfSpYxSGxe9ct0aCKTHmaPx4iaaAZx1XmJDAgz8uljkPSn40MGulL?=
 =?iso-8859-1?Q?a1isbdOAYZFHN61IhYclsT9Wx+2STUUqHzTOA1gyg/uXMXXI1Y6+FGYMTt?=
 =?iso-8859-1?Q?gczSlSzr/keBLJNcyksoC+sGXGCG7Yzb1H7E2x0mfzd1mpPsAvTdOioxGx?=
 =?iso-8859-1?Q?/F3s1MGVlbkK7AHth4kvDVLiePQJFiFdGspbX0FOeXsmFRe138nrfnoZgf?=
 =?iso-8859-1?Q?EbCsXaQNoLu+e3+Q3CSmQtmJ/vNIxdJsjRS2GjJqZ8Tmoq9zccUz0Jx1O4?=
 =?iso-8859-1?Q?GZjJx0AZUHK8JqKlfW/vPLXvB27EIHOIdu/zOr8TNF4Wl6hJMUA0tM3nOJ?=
 =?iso-8859-1?Q?WfwX/RzQmw88TVXXD0qJXS8nxzTjIiwQKAPn3b0CsmUXfvzi/+Q15DmKzP?=
 =?iso-8859-1?Q?PNX9bqVY8SyCQbz56d/xLNlHJ0C9NeI4kGZBMFMvlOmg5eNJ7HTznLhLpb?=
 =?iso-8859-1?Q?Btz02dF9gh8TW2XT3Od8Z6AUO6dHN9xWhbLGoFLJEy8YQAWnoDvEFFCO2l?=
 =?iso-8859-1?Q?lbIBUgaNUHr0L1hoBCQ4CBw21/XpxZAhYFYsIrCRBbwkpH4pV0MC/cW2Vl?=
 =?iso-8859-1?Q?yhfiExYC5Zzjx4tyl7GaMQCn+DEAVxqCNICGTqG6Jt21aDtw+75Teu+fYx?=
 =?iso-8859-1?Q?BuL3GzqWpdd92I2eh2fuk6B1G2XP2o+O8RT1LQDnU8onDIVRSAE0s+iau1?=
 =?iso-8859-1?Q?+bHLkJ9RwYNT/Zesq4G7Q5quweTb5xeR4tegT+sY+1cTSz3HoCUQcXUnYv?=
 =?iso-8859-1?Q?MCtgoE7KnyYOMcqRC8BEyA7Rt66zin9xwf9Pf2yi0zhVs+pVVn/F1DbukK?=
 =?iso-8859-1?Q?iwyHd8Ng0S7cUZP/z8ZhgFqeNMdJehqIYNNj06hWkeQnYCPECLTnXz129W?=
 =?iso-8859-1?Q?G24MAnaEShUk2sSDw201ZC54D+ddZpoUS+fSZ/e6zKgPAEmmCrXIcJwISs?=
 =?iso-8859-1?Q?Sppq1jw07gAwVR2DNvZD1GMcrhFmeXLa2Jm2wysQG1eTtPtjsMjAa6ZAwv?=
 =?iso-8859-1?Q?YsdNGeotHzzUl6ZafTnKhFb/u5F8cse90NWw00W+8Gi5fr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8b18a1-976f-4873-9ca9-08deab7e50dd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 14:46:54.5717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BemPUTB1gIkJ3bwmyc2hOdzP7XNsvp8dE6D/eoxXemAH8CyDRRjdqQP3ZPcC/MGke+Q3IWLpHMTZMVXvjA+8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9689
X-Rspamd-Queue-Id: 132AC4DCC09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10237-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]

On Wed, May 06, 2026 at 04:10:36PM +0200, Benoît Monin wrote:
> Implement dynamic linking of scatter/gather transfers to enable
> chaining multiple DMA descriptors without stopping the channel.
> This avoids waiting for the channel to go idle if there is another
> transaction already issued.
>
> Add fsl_edma_link_sg() to dynamically link the last TCD of a previously
> submitted descriptor to the first TCD of a new descriptor by setting
> the scatter/gather address and the E_SG flag, and keeping the channel
> active by clearing the DREQ bit.
>
> Linking is only done if the last TCD was set to disable the DMA channel,
> to prevent corrupting cyclic transaction.
>
> Update fsl_edma_xfer_desc() to avoid re-initializing the hardware when a
> transfer is already in progress, allowing seamless chaining of descriptors.
>
> Modify the transfer completion handler to check the DONE flag in the
> channel CSR before marking the transfer complete. Since this flag is
> only available on SoC with the split registers layout, we only link
> transactions for DMA controllers flagged with FSL_EDMA_DRV_SPLIT_REG.
>
> Add trace event for scatter/gather linking operations.
>
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
> ---
>  drivers/dma/fsl-edma-common.c | 64 ++++++++++++++++++++++++++++++++++++++++---
>  drivers/dma/fsl-edma-trace.h  |  5 ++++
>  2 files changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index 26a5ecf493b9..7094c747defa 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -58,7 +58,10 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
>  		list_del(&fsl_chan->edesc->vdesc.node);
>  		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
>  		fsl_chan->edesc = NULL;
> -		fsl_chan->status = DMA_COMPLETE;
> +		if (!(fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_SPLIT_REG) ||
> +		    (edma_readl_chreg(fsl_chan, ch_csr) & EDMA_V3_CH_CSR_DONE)) {
> +			fsl_chan->status = DMA_COMPLETE;
> +		}
>  	} else {
>  		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
>  	}
> @@ -673,6 +676,51 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
>
> +static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fsl_edma_desc *fsl_desc)
> +{
> +	u32 flags = fsl_edma_drvflags(fsl_chan);
> +	struct virt_dma_desc *vdesc;
> +	struct fsl_edma_desc *prev_desc;
> +	struct fsl_edma_hw_tcd *last_tcd;

keep revise christmas tree order.

> +	u16 csr;
> +
> +	if (!(flags & FSL_EDMA_DRV_SPLIT_REG))
> +		return;
> +
> +	guard(spinlock_irqsave)(&fsl_chan->vchan.lock);
> +
> +	vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
> +					struct virt_dma_desc, node);
> +	if (!vdesc)
> +		vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
> +						struct virt_dma_desc, node);
> +	if (!vdesc)
> +		return;
> +
> +	prev_desc = to_fsl_edma_desc(vdesc);
> +	last_tcd = prev_desc->tcd[prev_desc->n_tcds - 1].vtcd;
> +
> +	csr = fsl_edma_get_tcd_to_cpu(fsl_chan, last_tcd, csr);
> +	if (!(csr & EDMA_TCD_CSR_D_REQ))
> +		return;
> +
> +	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, fsl_desc->tcd[0].ptcd, dlast_sga);
> +
> +	csr &= ~EDMA_TCD_CSR_D_REQ;
> +	csr |= EDMA_TCD_CSR_E_SG;
> +	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, csr, csr);
> +
> +	if (prev_desc == fsl_chan->edesc && prev_desc->n_tcds == 1) {
> +		if (flags & FSL_EDMA_DRV_CLEAR_DONE_E_SG)
> +			edma_writel_chreg(fsl_chan, edma_readl_chreg(fsl_chan, ch_csr), ch_csr);
> +
> +		edma_cp_tcd_to_reg(fsl_chan, last_tcd, dlast_sga);
> +		edma_cp_tcd_to_reg(fsl_chan, last_tcd, csr);
> +	}
> +
> +	trace_edma_link_sg(fsl_chan, last_tcd);
> +}
> +
>  struct dma_async_tx_descriptor *fsl_edma_prep_peripheral_dma_vec(
>  		struct dma_chan *chan, const struct dma_vec *vecs,
>  		size_t nb, enum dma_transfer_direction direction,
> @@ -780,6 +828,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_peripheral_dma_vec(
>  		}
>  	}
>
> +	if (!fsl_desc->iscyclic)
> +		fsl_edma_link_sg(fsl_chan, fsl_desc);
> +
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
>
> @@ -883,6 +934,8 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
>  		}
>  	}
>
> +	fsl_edma_link_sg(fsl_chan, fsl_desc);
> +

I think link sg should be in submit callback. enhence vchan_tx_submit().

Caller is not neccessary call prep then submit(),

tx1 = prep();
tx2 = prep();

submit(tx2);
submit(tx1);

is allowed.

Overall:
	prep() callback link itself for sg
	submit() call back link current to last of submit queue
	issue_transfer() call back, link header or submit queue to issue queue

Frank

