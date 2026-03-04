Return-Path: <dmaengine+bounces-9248-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN0CK5paqGmZtgAAu9opvQ
	(envelope-from <dmaengine+bounces-9248-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 17:15:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE50A203FC2
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 17:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D21F30CEBCC
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A7B21578D;
	Wed,  4 Mar 2026 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ATFO6VRJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3DF33E7;
	Wed,  4 Mar 2026 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640155; cv=fail; b=CnfRI4vREVn5khe/wJQYkZjAkgswisBQct10wcUY9LjUf6pZsmA8nJJ0B7B0pRimtfpuhGPQZt9G1zOlz127S9r8ASRmsEnAt6NPrS5iDYdtxW9SPnmYAXSz27Wrbby2D86H3yemZ0zwblwzeWV6sk2vblLmleK6414KhVH8uxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640155; c=relaxed/simple;
	bh=/qMma5LeN8HVkvkohgEpo6cQGypAcklD2dfuxIjg7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZofGVXvd9DSw/iiFNhULg4lkRT6zDLcfPr9pdLxZEYyO7NH0l2TAbphHr28ft0NydVi51wKiT5HjXHzHoCf8C2zlh0YzKCx+dn1BoLEXH/Ha9ki+U8XKHq/6a1C9ooLxx6yMyYxs5Bp4KTz9FeS+Zlf/RzieACewgtMP63mqFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ATFO6VRJ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueVNg2y6Nw5ST+WOveuqm+xiGVd+A2XpS7mxvT5XbBsb2EOGQLX3l+rd5YykJOBSc6q4PlzG06wBAwjKTwUnBbxmByZEQTKPun+q9VfjRYnqtJ6sTewkleCYCGPUHAN9QHd0ztUAreRd7N4Xs0NN5Ro/dZqaV7VgUPqdu1/Oneivp84w64AOnFxMJgEQ2lZY+ie6Kf7VbdIkZ06B/xRDHg20gMzPtDk87S0G61fyTZrIZ85K22Wqe/vIq4pogXGN6R7zxrwOhTvh/MR795kPEYFAnAu7iqq8s1LWSYvr8+cBvSQPbN+XelwI6Yo+ibhVng2cClj4aglGTiL8NnTlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68e1MW5pgiihVdc8U4J4JM2CQUn4EcTVB/4ywtHob0U=;
 b=pXmuRYTuINdDi8Ur1xClSblLrSvRQ6NymDOcoiOFFwWQiCh/DZAMT76/FXEBvK9XM6gH15F/wUk0LB8+gbxqviTW8O0zs1XeF4qiD0qmNI6r4SvRgOGwkiPKkOUl0nES9FjKtP98edx+wajmgAQU2eE5KQqwXOT1yGwQPvHNFdoM0KjOabq0PzJtLCpjMhqKvJ3vhDpqMxkNMk2l1DMOX7pD9zhwC4mVnPRmzYR06ozGoTS1A8qwyhss1DuGPsHEPvvvby0mGqcC9zUkc0mfST/XX9ZHOkDqUS8DA0woSdGvfxi3dSCj+HnJ/J3GlXg1F/768ouRXZ96bZkdueCjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68e1MW5pgiihVdc8U4J4JM2CQUn4EcTVB/4ywtHob0U=;
 b=ATFO6VRJ5R2SpoPmcbhVQWzGNfWJ65BLA4WrIhVIUAiDOP+lUVfjzZBORjTDbEJnVl12kf3mAWJ1wMDOSX7/E/cyqnA+heMAVsy0kl4SWQ43t3NI75u+i+ZvY6sj9q6ECTJ2OIufDWx0Rfj9d8UV0xc7pMj8rVrOp8LWyvA8E5lsuSMIrg1a5AbS+2+bs8vUFed7Xa4PsbtK9vxjUKHHu56QKX+Pk6mOhDzhBKiiN21tfeshv4DTH9Ng3WDwMrZdxrGPLls3mANdAIB/Cvi5OnOYJg3949R+0eJk7t/Sfy051GQaCtAugrNFYxykzqa/f37Wk4Hu7WqBylfN87PfIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMBPR04MB12286.eurprd04.prod.outlook.com (2603:10a6:20b:733::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 16:02:32 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 16:02:32 +0000
Date: Wed, 4 Mar 2026 11:02:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dmaengine: ioatdma: move sysfs entry definition out
 of header
Message-ID: <aahXkROc8TkgeoLM@lizhi-Precision-Tower-5810>
References: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
 <20260302-sysfs-const-ioat-v1-2-1229ee1c83f3@weissschuh.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302-sysfs-const-ioat-v1-2-1229ee1c83f3@weissschuh.net>
X-ClientProxiedBy: PH8PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:510:23c::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMBPR04MB12286:EE_
X-MS-Office365-Filtering-Correlation-Id: b801fe16-857b-456a-20e7-08de7a07718a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	q+wuMo91qodMNABmaJ3ovgdp2kijZw3mqyQ2/Da/Wn7tzPbVRkGCQOkVq4RkBKv03F7Di5fnFjTSlzrQPxQvm2fhlwmh5cH08tcGIwQvzt5c3F/BCvMd1zuIE+ufPaSzx85tBdAlpR0nUpQtb5/xh7nAQH2U3dD6xtl54yW2Yd78nPM/F595D91gJbANh9zdK8DaWw+ZxlYUH2PhY9zqz66TYvb0Ivk43MQrULgaMIsBrroL77Sub12w/hCwz1NW/n5QnF19uyxW0K8VHzL+hpTVdDL9h7Qy/YlRp2qMU8GhhK884TOHUyQSeC9uT02pNgArQjcryqOtAOehEB6ZLJdl+UOFHV2t+I04bLDvTNPd1ZD4Y8RKb/G1hXaql9arp2szJ1mmnC9CAMPRfFoXWLV7Jh7/+R/Z7RxDVsIUNYsN9szj4cXo3OAv55RXPXYtV3cEHwwj73O86zZ6ReLm9StjgoBaYLbHu3Iq1XN5xrGScU/rg8hM0UBeAzP2SMSojDWTtostwjpaIeIeHXpRiCHi7hFJ682PXDiCsnMNDDrDa8/CEQU0UIjr8eZdDS/m2Hp4X01xU6hcxK1cgCkvuoYVcv84EmoKvhmOSJJevY0eTe3uDoc+mJJTGnV3KbCjnJ6R0/qAXZjCtmIWg0Zs2LWNVuOpcG1209g3iIk3IZJEyonVgMoEXXlObI7Miz6WRxft+cNGk9QtIt93HalR4W2ubpdDNW1rTnhrSReEJTOhrgFZdHAwpey2Kr7d0D3VWRvp9Sv9LWmQXq9y1ovJ9j5AoBt9PdHhhmhYpvSpsho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?r4Idv6C7HOgMNVqd5ERfmPzgUgl4OVPjAmPVIHnIMytou5V0AbabLKeach?=
 =?iso-8859-1?Q?EPK/i+iZjFl3x4qi8cWmxcZwc8PBh14gTIeDelPQu5guJvGXwwMS9D7TcK?=
 =?iso-8859-1?Q?MKZeCYtD/WPORtIK3pPTQrQoIZL63Meec/V/3K/G0wdnfc/Ngqm9idjIlY?=
 =?iso-8859-1?Q?HGBGO3lNLgfPZHUxxhA/hitjPRPGxn8tODkuiclF47tdLiyQux3w3jlAKV?=
 =?iso-8859-1?Q?QMfbdAv0+mn4onWrZ0a+z1wmdsoE/dywkAR4r4n5QpWTvt9pmRCGr6BLTl?=
 =?iso-8859-1?Q?rDu9XbEod4tj57i/XB9ixxtylBUuENB3Y1EZLAPuiH57gAijD9L4Q/tck+?=
 =?iso-8859-1?Q?zhVJHdc4FyLxYBw15uShbap1fYurdFs64VpOBtaBZCAF/JSITtOSJwjTUH?=
 =?iso-8859-1?Q?vRlVHdKdCdsluInQA4YLmXD/rARBh79uM7/IbEAXleZDXRYp5yKJxHR251?=
 =?iso-8859-1?Q?w91suLHhAzPVGdVUKrIiPvpCwIifj5v8jqS3vu502YeE3lf/YGDPUc8L3Q?=
 =?iso-8859-1?Q?dj+SylvqCYlyDQKZdORUts5RdTegAr5XDKaSWz8E9Amg68Dbt6ubZpfiNX?=
 =?iso-8859-1?Q?7pK9Yur5vgHG3XsJYkp1HCS8nHI2BIkFUZ9glvgwBIrpTVvIUWL7NHL74y?=
 =?iso-8859-1?Q?CfOegDRzwJkgctw4RjXwzomDBy8r4UNYI+DfCiD5YZik7D9xUIWjh7hvtX?=
 =?iso-8859-1?Q?30+G+qx0zZbs2nhwupprmSyEDzS6Fxm9CJmB/eEPqknB2kJOAg2Rl+RPOp?=
 =?iso-8859-1?Q?ZDYpF8GmSadrEGaNWUY49DuaIWYS9Ad23QwCkm5Ztbz52hTwhPltHkBn96?=
 =?iso-8859-1?Q?nETg/RtkVewr3CDxphtStwrs+ivAE+fO12O5KC7KQ8h3F9mZep9uMXuWHj?=
 =?iso-8859-1?Q?LDlNKbRgEto3fjCFlhnC8vqbv/GkrX4gMLuw5NU4zqZxPgaAM4B9K4d/Kr?=
 =?iso-8859-1?Q?lmNyaSuY+9lOZ93lWl1MI74NczIVKYbr75AlE1Maawc85Db9/5saKuVFYd?=
 =?iso-8859-1?Q?0d7vERCjEWSoo0bmmpvOppzxZsS25AirMtIoKwkCzDl5vcdfh7f2RdrSqx?=
 =?iso-8859-1?Q?usiJIBD2a52rT1Xfmj01DGb44l+Azes60q2r5wjymHvc+RgebssMQe5oaP?=
 =?iso-8859-1?Q?1IKJLTt5GX4gI/nvl72nNFoarorPLId4+yoWuUsfFYMefdDTRz9nowmt4K?=
 =?iso-8859-1?Q?U/qAIZts5zcpuGZ0nuIxncZBHXUSU3JRDA5MxZuR/uKKeHswE7yn68e6wr?=
 =?iso-8859-1?Q?F1ppXdc5QZVGJQebjXOQcD3mGUcorUH0L0EFh0/ZMYOzCDQIfzQq+aQdEb?=
 =?iso-8859-1?Q?2dP/A+Sm3dyTkMKRG+BO9M2PZ9iUe7jP7PjL+YfPwkx1dz2qahiKXztR6d?=
 =?iso-8859-1?Q?tl/OxFvgAYNc66T/hWIFIgaJ+N+QFz4GL+TptFAmxza6D9GGCZGaUmWQIf?=
 =?iso-8859-1?Q?shD9RU3hzfSaQiaaf29xQ7By/CwiM1Nn3TGUErD3wHuEco+p8ojw6E5zHH?=
 =?iso-8859-1?Q?/WZDX9uestTbcwzTYKFDbZhNLNtvviMO0crmWj38IFQrOJpgxdMv1LkEmR?=
 =?iso-8859-1?Q?vDFjrDw8ydky2KqmrlxVMI3WBkBIqOkySu01rDAXfdAQ4XUXbF7ZHLhTBK?=
 =?iso-8859-1?Q?GZElmZN+oyOZ3nCJqsEJTbajJ4bVYpN73h2/Y/t35dWG/z6dnB07bDxG4s?=
 =?iso-8859-1?Q?T6RqzPJHb+T5AOEzEsQAFXC7hPfDABLIpFfoopLaMwsuELBBw8mplbPt0I?=
 =?iso-8859-1?Q?a2tWDsvrcn0PrfwdSNugvkah+QvOEuc1tgJqHPoa4mKLdaC1hwTpsCgfAF?=
 =?iso-8859-1?Q?wFvUHG01sA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b801fe16-857b-456a-20e7-08de7a07718a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 16:02:32.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LT7ZwGWOUfCpZNjXATFDLS71IytRbSBHaY38+hMbxjOfRGv8iWp0yE7c/MvZLHZ735Gmb7YhvjEPk/yekMgZlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12286
X-Rspamd-Queue-Id: AE50A203FC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9248-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.459];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:15:54PM +0100, Thomas Weiﬂschuh wrote:
> This structure is only ever used from sysfs.c.
>
> Move its definition there.

better descript which structure.

Move struct ioat_sysfs_entry into sysfs.c because it is only used in it.

Frank

>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  drivers/dma/ioat/dma.h   | 6 ------
>  drivers/dma/ioat/sysfs.c | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index 27d2b411853f..e187f3a7e968 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -140,12 +140,6 @@ struct ioatdma_chan {
>  	int prev_intr_coalesce;
>  };
>
> -struct ioat_sysfs_entry {
> -	struct attribute attr;
> -	ssize_t (*show)(struct dma_chan *, char *);
> -	ssize_t (*store)(struct dma_chan *, const char *, size_t);
> -};
> -
>  /**
>   * struct ioat_sed_ent - wrapper around super extended hardware descriptor
>   * @hw: hardware SED
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index 5da9b0a7b2bb..709d672bae51 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -14,6 +14,12 @@
>
>  #include "../dmaengine.h"
>
> +struct ioat_sysfs_entry {
> +	struct attribute attr;
> +	ssize_t (*show)(struct dma_chan *, char *);
> +	ssize_t (*store)(struct dma_chan *, const char *, size_t);
> +};
> +
>  static ssize_t cap_show(struct dma_chan *c, char *page)
>  {
>  	struct dma_device *dma = c->device;
>
> --
> 2.53.0
>

