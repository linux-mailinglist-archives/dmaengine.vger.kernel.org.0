Return-Path: <dmaengine+bounces-9728-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PHmJB+Xymla+QUAu9opvQ
	(envelope-from <dmaengine+bounces-9728-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:30:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1538435DDFA
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9952C30E5947
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE033F8A1;
	Mon, 30 Mar 2026 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jiUWo2MA"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2AB33F5A6;
	Mon, 30 Mar 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883719; cv=fail; b=eQ4DlNInYmpYsrpmy7qST7VXEjCnWTAPnvVIVtaRAZogCaeItOMHKDgc5xErRIqbl5sU94Mxr3DwZg4cyyPfpHBIMNgVEPYY6J9GvajByQZu9GyDRUbi3HL5BVpGV6g+7V4a31dJLS2Rp4a56jOxAArvjLa+KJnbM0Eisy0ZFB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883719; c=relaxed/simple;
	bh=FRnirEqoX2sCLkwDCDJSATdjBU7bz0Ee405SZqHnwrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TtvjXAr8F05OY68QyAfS9TIwWxx5CgVZBYedzv6Z+TLKNWPrHkUwu6dSebdo7ukJsFNqUO0HaMn48AF7dTSGZhyFC/K5KnEL/oTMst1dtM37Dx7MWWBD7jEh+xw3CYhkfVTGLlmWs2ZKW7sI3xUhFV+i1umTz1NOHMGBCHP3+kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jiUWo2MA reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTzxZwCB6lCbYMNcsbfTaXJjhKqpu1NVydyi9R5SkF8HzljwRbmNKqnd+txtsYJ9Raha4YP2IMBymVgaci8M7uq1C/I/Ip1tYVwzLKGB0a69klNlYtOYa947NGLpgZGDtmHf3QFICFGqpvSVuAtHc4+NTOUiP0RQKSaoAH56M1qL7+27PfJzGRjjCch8u4OdB3vNN4luGi37d+D0Azdh7F03ktXHjPwZbN753cpd1hnVfftZKLfgLZenq66INYy5lJoE1584YzZYDWm0ffcx5XA8sC+LGvrOIwah1eLUCooQa3KHMnTUL2RDM3k6DYv2r+3ljf+me1iP8NsOsXA2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2ADNz6ok+flohqIEHGWSEOlQWCAO8IFbGySl7BcYvs=;
 b=SWbJx4iiYKmQWKwILxm3Sxu1zhFvtnZ/JPPxxlXXc5kZXWIu7bpTm1y7SAsim3j6kzqHwGC6FFm3ddzFozr1YHXIZ/e87gfuHK303hEn+gVZ0FFaVB39cNA8I7J2gHTz9DOhxy1RDUV4zSlVXck8sxgiIOkPkL5i5bMZGivKwxpo7UoOdIUFkhAs7ADnOXM95sOuoow7Fl0YfR92dsI1ObTIs9qltIwndYHJcQv4g1Jtyf8mJjUFcUZKOAZMuEOAXtoazYa3C7MLDklO2NaA/Qnk+WrB/lCZ8PT4G+Xbumd761FNvUnexsln+ynBnPneZvoZzfDxDnlO0FXaD/Wg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2ADNz6ok+flohqIEHGWSEOlQWCAO8IFbGySl7BcYvs=;
 b=jiUWo2MAICKUeG9ec4xo47LwOwcEOW0usYNr5LTlOff7sf+hOKzSbcmZ1hq8tzg7UK9lqfVTR9pUuQsWNA/3RL5zTROecR/FD43OicZZVsfDMxh06pnzdiy2GZ9nbkMHddHfyavHc2byIsBSr0w+XEhlU9BG3xS2/v45R8ehgnzekD0eaMd8nYClUVIgk2RKKkxZcbBgD+hffNZiw+GIAaosERjuZrw0NHzpoZVfrx1Q+w4W3tne7XPKL+ORpptAJioTtOO/OMNABrBJjKCKxFMplaIqUJyr/e6GmUMxW0iiJBmqlUvYGpYm6uwAh1WsDmfZTXj9c1WIc0ANtypjAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB12321.eurprd04.prod.outlook.com (2603:10a6:800:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.27; Mon, 30 Mar
 2026 15:15:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:15:14 +0000
Date: Mon, 30 Mar 2026 11:15:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v2 1/4] dmaengine: Fix possuible use after free
Message-ID: <acqTfPjPe0vF4xXd@lizhi-Precision-Tower-5810>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-1-021f95f0e87b@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327-dma-dmac-handle-vunmap-v2-1-021f95f0e87b@analog.com>
X-ClientProxiedBy: SA9PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:806:20::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB12321:EE_
X-MS-Office365-Filtering-Correlation-Id: a2edc3e6-144e-4c9d-f37c-08de8e6f24ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	mE5e4jrOsA3vn/IURz7/E3X+sFyjzpo6UBLJsWcNPPQfxn9p55MK4c1902VyKO9cNys4vJibfW8tSSzFP+ADE93/i1S+G4Z+bs7WRvRfNwS81o4DFpWzNAeoGzLpEK4oaGlALYVSjirRgK8gRtbQjYfdSF1HJq3nh+6esodvj3yOZGFlF48vRxxHo92SevHmiPTGoUe+ieXX/9hWlbCKEVSrK0dK1SrTOfHsjZ0Bf6FL3B20NxQ4sYddXKn7vumI1XqFOKZXKvxDMj9i+Q/eO3CHZ73GU+DdItBI2v9aelVsizYiVGX4RgCttNrGS1xniYXMWghmWMdf9ZMM8VWagm+H9UghXdQC5qdAs/2SjIqnG8BQMGh680V88BtdDgzGRAcaqepm3HGfsm0mu0LDXFFbhMqvt4Td80XEMhF0E8iVIz/WPdaA1jkYpTC0FvLX9EPzArAr2hHS4jZUkRRwYefROXrhl8gYqCx6eh6+FQQqXTgTx1uxQeIvlfEJSmuyOiStMpNWdlmIEh8ntchQ5dUuNGvszepHYV68XAvq5+LZVDiOCxnFHdL88osFA6aN1GTGztn4CkqrswpQfZmUZcTXvShb92xP+zQjrjlDflejp52owe3bljkI4cJKQ6HUJ+X3wjmVaofjme4eeEVZPIPIg8bdoUC/s8+BNn8YAxrMRrgrbk5uELBVaLNcGSVR/uhD5Msf4vFeWHqC1njWKr2tgSBAff9bBaiyXTkI/+gkjpwwTM7T84Xm+3NIPwNGbWAxq1/7AANba6UfzTGjEdYtnbg/Al5aMEuHRzvQUlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?CpeHkzsF2ZkszGqhDPUA7D7magejW1E2N6KjoDu8cVE6XUv9G7V+K5D2iO?=
 =?iso-8859-1?Q?fyW/SvEUQyDCkwzqvwZEGTt8lsV3pz0jTu/74Yt9XnqpPMyh8ywMmzb1ki?=
 =?iso-8859-1?Q?mPhcGMI8SxpL0pJvE0RG1/i2QvmgQMEaD8xGqi+vIqvM7OeTqk5wa2D3Vy?=
 =?iso-8859-1?Q?BUs+N98uOc9+Ipbt+RXUcIYzZd5ZXoEJXVhOLCaoqfafxlShPr5TySpUQg?=
 =?iso-8859-1?Q?wZ0WwkgnhIP4aF46cFR+28eCAVdoZa6PSthjOn65Jr549tre6ANS+/sd2Z?=
 =?iso-8859-1?Q?rm9jQhtJUuQJfrSXxHzoiFetuIa9MpxsfGkcHhw9RK+Lgu3ze03uye6wox?=
 =?iso-8859-1?Q?l6QGkWmREkh/g7KvLkbkj7No2OvyQH8nDh1Lz1Hw4egzoDXRknXKaCkT7T?=
 =?iso-8859-1?Q?Pq6xhYbMMVmfdCQh+26tZgedt+VzgUxAuq4EXbIBf0zFxC4gIXrW2Xccbj?=
 =?iso-8859-1?Q?6mstDtczsQwxqp1YwuwvmCPkVd/3Q5tHfLWmHE6xnDXEkeboJRpXkn4iHH?=
 =?iso-8859-1?Q?yEDHgHvMpyVs1qKNYK8F89w80WwAnJkfh9zjd0J9b5RKNu6lCCjDlN8qCN?=
 =?iso-8859-1?Q?kw5czqZf+oHGiy31onrhTb7odQ8vFwUTYg87tjVHshkVRXdD2qvIfJXtCJ?=
 =?iso-8859-1?Q?oGRbHe0Bnx66HOXbJBBScNLdmLtRh0qQsFQwS10O6ro/oIxuP8zEg25ANQ?=
 =?iso-8859-1?Q?8q75kq7UBQBFCyRfztG938oiNr8NlmYEezN9lls6WJR0A3Ww3Xsvfq/JFZ?=
 =?iso-8859-1?Q?xNY1kTZohvcNM1Ya5LrqdVo9kALFgo56NgCLsUjg6eUsT8Pz93dddOJ0cN?=
 =?iso-8859-1?Q?q9LE39wmhbbwbIOgA6v3SRZG9jTfYhxoE/QH+whKnSyTRsRKafyYPD4lp1?=
 =?iso-8859-1?Q?ZHk+ualCiHhiI7DEfJVu4hBuklDeUnmNJ7MV+0VgfbGwrlRLd0xrLqBlO/?=
 =?iso-8859-1?Q?pMzI+3TnlwEDNGCsfCIAGwZOis93SkwndYp7ofxNwfYvEr2u+mY8QCCgA3?=
 =?iso-8859-1?Q?tcW0xXgtO1EvtoICGXxmmV5wy283IHqqpQxPMqCDLVQCwICUXeKrKffzfi?=
 =?iso-8859-1?Q?aoU0oirdUkiqAn9PT2RPsFQ6s0n02Nf8Ov7jvnWcqG5ezJEX8TbU29ZW9w?=
 =?iso-8859-1?Q?PIP6Od/w2OZGRYIVG7XF95p37txTSiVRQwO8Hi5n/8nQzbYJZLMWxs/iHr?=
 =?iso-8859-1?Q?acK8id9pPhbNSYyWpAMMVAVRA633YKxKiimkzLtRgngbliGzHusZmcbjSD?=
 =?iso-8859-1?Q?H3RLNCr9Ps67H1P0f/KUPimyBlxbcBGaL6RZtqSQsl7rEO4lnQHPMIrEuu?=
 =?iso-8859-1?Q?JonTpzN1HTzdRBHaGzJ5fFrITBmcAft/ZAZvFx5HZaTG9btPZUEdDc7Dpz?=
 =?iso-8859-1?Q?UqWf83jHCsbkq3By/G+clnrmjbc4dFHEUXfgrQMf7cp0TMZKITmsc1qXIr?=
 =?iso-8859-1?Q?HXxpWHrCcYVmBZdVvwiNoa6sEpSw3MvWFJNvjMPTgJQCPOJXU/1/OPJ3BE?=
 =?iso-8859-1?Q?jPy7XE5ea3hl8k0X1r824cwOd/9+t8z9WBUhF5KrWdK8Kr0yNZ2W1FPVLL?=
 =?iso-8859-1?Q?/WQ/n01h5B5iUwrCHt8Jx7YY8u2GoJA5+50Bbk3m0Og6bH03vzhJJe949D?=
 =?iso-8859-1?Q?a39wjvg39OLm1ztZePLmr7V5Q3tX1bRbT35Gg3eBRtWX6CL4QJqblr5bt9?=
 =?iso-8859-1?Q?NfMR0SSuV4woChFlucqMYRSDlQEed+Qv72N8YktfjJ5pemwSAPTAvn9DiD?=
 =?iso-8859-1?Q?SHjz7fqihsHDesakiOfFqGU9vTTeoFMpVs3yjWvOydI/0T88RIOmh5I581?=
 =?iso-8859-1?Q?r/dkHkVzsg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2edc3e6-144e-4c9d-f37c-08de8e6f24ee
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:15:14.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9MhKBeyxv8QuXBJPcJ7yb1X39ZOpVhzAhGF6WbWcAKrX0x2xxtHlkYR+JD/ucPKJwtaQTIZLx7Nqk4sh45f+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12321
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9728-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1538435DDFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 04:58:38PM +0000, Nuno Sá wrote:

typo at subject possuible

dmaengine: move dma_chan_put() after check dmaengine device's privatecnt

> In dma_release_channel(), we first called dma_chan_put() and then
> checked chan->device->privatecnt for possibly clearing DMA_PRIVATE.
> However, dma_chan_put() will call dma_device_put() which could,
> potentially (if the DMA provider is already gone for example),
> release the last reference of the device and hence freeing
> the it.

Avoid use "we"..

In dma_release_channel(), call dma_chan_put() before check
chan->device->privatecnt, which cause DMA engine device potentially is gone
when the last reference of the device is released.

Fixed it by moving dma_chan_put() after check chan->device->privatecnt.

Frank
>
> Fix it, by doing the check before calling dma_chan_put().
>
> Fixes: 0f571515c332 ("dmaengine: Add privatecnt to revert DMA_PRIVATE property")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/dma/dmaengine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 405bd2fbb4a3..9049171df857 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -905,11 +905,12 @@ void dma_release_channel(struct dma_chan *chan)
>  	mutex_lock(&dma_list_mutex);
>  	WARN_ONCE(chan->client_count != 1,
>  		  "chan reference count %d != 1\n", chan->client_count);
> -	dma_chan_put(chan);
>  	/* drop PRIVATE cap enabled by __dma_request_channel() */
>  	if (--chan->device->privatecnt == 0)
>  		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
>
> +	dma_chan_put(chan);
> +
>  	if (chan->slave) {
>  		sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
>  		sysfs_remove_link(&chan->slave->kobj, chan->name);
>
> --
> 2.53.0
>

