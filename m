Return-Path: <dmaengine+bounces-10671-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHj9KP8rD2r+HQYAu9opvQ
	(envelope-from <dmaengine+bounces-10671-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:59:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB4A5A8D15
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2586632036C0
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CADA29AB07;
	Thu, 21 May 2026 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O4i8+byl"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764C188596;
	Thu, 21 May 2026 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375578; cv=fail; b=G+qhxk3EnI7rk6I4ogPHUnrAYtgddQj57p6IRNAQLPdi6DM3T6PTwC5LFAob/O3NoN5F4gw3OIBsiKC9uUaRc/LFCzUQ9uXwQpK0iKDd38ym4kA2WMTjGS6jixmyJ4L7XPMO5cOB3buXfm1wUj3BPO3FCtV9cD7wrio2B0ZXXBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375578; c=relaxed/simple;
	bh=Lg0ZpbyaRGEeJ5kioSO6NBITjINBL6m+tBMxLLjuWQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CDVCK0Xg6aCpe/wvyWDEtyVXgH5bWTR2tv7LTuwl/VS+k/zj+5Jy4iUfyv8e722RJ1jE1QiRo+AnOm9yJ7r5n+gdVdAKmYjvCIE5OsGBpiI3I1jsmKjyzKvpJW5PoWLpdKoTDpGo+qYK74rPR9ii99dSnhvmGM+ObQHtzk8WylA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O4i8+byl reason="signature verification failed"; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAR88byEpVHfQ76A3kPK1XGCjdBDyhXt9kCE7w4tYKv/B4CK6QYvKuPIKDN7bvwmFCA5NtauHgnk3ktKEs8oDMjcRPuRj+WmgVAD4t6w1zw+I1ktSJA1tL0LBhB0mzBLs05n+VnQp02JGBitw063WD8t5Z67I597k6H6qxT+/uosXZ6oLP7rZ5nSs3fwSsQCeebzBISRsHoRkehTjfEuDVVQ3FOuZ0QAjoxg0KosNV/1XI8uv9mmgjuuQx6mvOB5J9rKNsjD5v08aKo11nKB52/duxKocMHtpm9cjfceXdruMG7TUthVUakfsfOuWDmwKisMdHLYVSMW4+QLHjGJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WS+iMkqDdy3UBJkgKrobdV3YekSpo7JQR3e9vtU5K8=;
 b=ZVuBKACOwmZgRErQAA2BNrGWngVcZ5INigcP3v1taIUv7gXGGfHUNUIB9zXY4KbYRB/UcdsIcbbBsuAuk1W+FeCSe6MjaWWBs1yrQ8FGDS+GkBdHDwmvc+G8gjN8qsiqtfWChmGSsV8ZO0pKv7q3yu0n36oWUKQQ0mDulSYPuA1ck3BgRUwqdMpJCMc+KT3K1OZ0vl1/BCaF5thEwKDZGhVoh3/Dri4+xZVZOEMCLWFjn35ew52HBG+wF/RI/KySvmRawAAtWTx7ndHxwbGEg+v+05zzatY6m3hEF616I9qa1VLZm03MPitz6M/O28CXAsB/Lp8ha6kwwYBX7vYFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WS+iMkqDdy3UBJkgKrobdV3YekSpo7JQR3e9vtU5K8=;
 b=O4i8+bylRgqbToAz29P2PU5VDbX+NU0nYyetY7RB4A17qtOz/RyYSetXdHoDRm5KRo4YOoQ2oLGiGtEWe5N4+ivpPZs1TA9pk6Dmng5XhV+0X0/MGJWoGVAZfaXTjlbl4lTQlwxu8Wi+hnvJV6rp1NlAuue6YZShopkviC8Axfs1puB2HBbslKjruMY/beyi5DZ8z/3+WtgOPuc4rCtCqVD+2FoJoNOEx0l7gjPFrbo8F/once3PBRSnZHu1r/tX/12xzPQJDuaAN4LR9dN/yH3BIxveX326nDI+KS/HrpchrltswKW+hEzY0G1JApaNLC2WK39+2FqlKUWE7+u0aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 21 May
 2026 14:59:34 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 14:59:34 +0000
Date: Thu, 21 May 2026 10:59:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@oss.nxp.com, vkoul@kernel.org, Frank.Li@kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v6 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Message-ID: <ag8d0BW30I8ZE_lR@lizhi-Precision-Tower-5810>
References: <20260520-dma_prep_config-v6-4-06e49b7acb38@nxp.com>
 <20260521003159.A88F11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521003159.A88F11F000E9@smtp.kernel.org>
X-ClientProxiedBy: SA0PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:806:6f::26) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: f59171cb-0b32-4158-a8c7-08deb74991b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|52116014|38350700014|4143699003|22082099003|56012099003|11063799006|18002099003|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info:
	JkEfYu0lNscYtMAH3HZ/4lC2JjfiKnmrGkXlNUn17dyUocrZ7vHLZQKYyIpZqx13qXljIlP40n/oOSw75WNdzfe7C5M0G5XXGaJV4+9LrWUmtmlLDLiZi0O+iG9GZsi870nuAW810tuCClNUgYygRFCB5X6lUtKx5jKhJaXhSCqUHD9XGr2+hyKtlge5rh7u+Ol4J9GX2NrybydVEhn2JrFhoU9+do3PRR1U5ToP3H33oyRCd5qKRmkmg3NHKvySHSG5ClstgwC2zCC+Fjs9a+B7dk84CMecXSRb3vOCZ0tZCRo2nL/bxH2bhbqhMYEJyduVc51YDYeAVCX0tBeno7NrqwG/OGq6/dm60TQmVa0cPTQGAV7xxeRYTeNWAgcr6HgJxpm4iGvDEAFv82mvI1aclYs6y36fU5dUbsThK5FU617torf4j+vnevHRjdVGVHNwaJPRvL1SUTKQxVvrnZRRcgVLQ7czw/1Pxm0wvA4U0BgD4jLGV4Iyu/l9mjAnWEcIGxqRDyD6IzF59es+jACVaehSke10Aig/96bLO5Py8u44IFaoKoi13o4mV/1OwBbaMlSnLSIEV8KGAcVxdD7L9rUPWeAun3nCDojZ7zyFiHDmu7yoRwOMrESd+7IDLp8AKpVVkQOLXYv6mxTxYtzqbJVFFxMOEv274Fai1QIYe+/ljVpA/eZJ2jMr28qn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(52116014)(38350700014)(4143699003)(22082099003)(56012099003)(11063799006)(18002099003)(6133799003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?z064UDGLV1wD+QfBYnH+aAIKGEJAtn2XnjKTMCHGC6GoQqdjU8ErLDl2FH?=
 =?iso-8859-1?Q?26CzhuQ+n5qRs8lQk3oWzG0ml5PnymsOH4JGIpVNPVpZ/m2UnWF3iPxZ5+?=
 =?iso-8859-1?Q?Z1KGqzxH1lPWETuApZvcG06R5dYLX9tAphV0bdvxMLY2mXG8TfVsgPywm6?=
 =?iso-8859-1?Q?EiU7H4j0Oy5N6V8GleFBdWqCxol2PG+jwoizFKvXqg1M0w7HtqCc/tgiX0?=
 =?iso-8859-1?Q?kHGy7rSIZ8rv0ShO6sprPk4RXFjcJxzd3/7TzCH9KUnYt5nmXLVlgfIZRp?=
 =?iso-8859-1?Q?NRvt0XoVyMghWC2DAPekwKhSHTov5rQ7Yv7w5UzaxyqlJ7ntl8SIZ016lx?=
 =?iso-8859-1?Q?7+q541JtIBoVU1zGzSGgl5a1QSGAIjJbUW+rKSH1xCXSit5mI30qOKVmTT?=
 =?iso-8859-1?Q?vvy1+L44wmueASAIvTaTUiGJJ08w58eLgyVIcfWLFavn/rek+YXzvODOTY?=
 =?iso-8859-1?Q?If0zMWVX4eQVf2lPV24uHwRKkUV8g3THPrd0Od70h4swaDH02bXe2t/jNm?=
 =?iso-8859-1?Q?+lgjzbIksGOoIQqqKgBF/vGygDDXNPfSOv3jkvy7OghOJL6XkEfRwzZQz8?=
 =?iso-8859-1?Q?3ddyneKybsMewFFfQaqCLKG9Mpm1/25DsuLJ6oPyJbPwGpJCooWlNul6bY?=
 =?iso-8859-1?Q?QD6V3zALhItHXQZCK23QyF0N0k/MhAoscjRlbLVHzNxbEaX6X1magemLgV?=
 =?iso-8859-1?Q?JfOOB0hzTSbcqDxHYR40NrHOwCoDpKhPVysVFaM11A4gjTHipjCaeXOAWr?=
 =?iso-8859-1?Q?yX5yJIF573hdrKOgpfoO77HOA5CjTu3UCpkGqB8Xzirmkim5nG/aql6PYj?=
 =?iso-8859-1?Q?Wry+y+kSA9XOuV4yPYsDDHECXa436RAxkZhTqTvPf3utPvaagq/cPBBA4W?=
 =?iso-8859-1?Q?szoKknxchEgpzGuX4VYgwNr/LmDn8iPVplzImKzmmYE4Lf6wOggaz5Ont6?=
 =?iso-8859-1?Q?wdC1ug+ux/yIp/x1LvAar9ivDumyFZlgTtxbpCsOw8vHKOqQIAY8wttOEm?=
 =?iso-8859-1?Q?BXUJAz7iJLUa+k9tIP6Ub//QRJ35g591olS/HrFyHjo5fvd8x5pp/vTYA5?=
 =?iso-8859-1?Q?yl6sU/+/mZbRY5UMWKSNho6Lfc0ovljK9SLDDF2wFptSVShjET7e6ui4Gs?=
 =?iso-8859-1?Q?wcR/Wq+5Eg4qS2rIrjFB0hcwybtJkGFFufLoEYuxjXnCJBpZz5byohZd15?=
 =?iso-8859-1?Q?WZ2X6ATuR1Iw6EhLxA3upOQ7e2D6FMPWBcF6nfWJEfA0iWpD8vqe9mJxE2?=
 =?iso-8859-1?Q?LQarlAcSCCH0X0Wf2DygXr9oGEKqk2/Iu1KuFMjBnevlfCVoTrwkDdYh89?=
 =?iso-8859-1?Q?DOZCU61oLe/r88L+JWxy8uOJ3QFPzj0xe75tydqytgyZAh+LoHNytHjc6O?=
 =?iso-8859-1?Q?nl2EZzZpykfMq8nTxQR/yzVnOSOuZgBYtmvGZv5tBqz6wi//4piWXUHQ68?=
 =?iso-8859-1?Q?CTvnzVtmtc6PUEC5GcSDA/BA8Y5sPz57/bHG1s56iNzGiHxkDeNhAqNtyd?=
 =?iso-8859-1?Q?Nm6tqGfeLV+H0waDB3SaEqCb4EI77WtuofC++9LP/7etUGFgEvj6UWNmWD?=
 =?iso-8859-1?Q?Ov1u+Kz0P1K6ghNS14p84sg9JjDw3IRwD2GxiWpfFummM+6gvJw/NrCXJK?=
 =?iso-8859-1?Q?FONeycd+StpNx0616bEL5GiwrKbleUjqQEzS5PV12ZcBIRlwS/ol/DROkH?=
 =?iso-8859-1?Q?Fg6J3NUa6dp4n4LDJc5lMXTiXiq0kc+lr8uW1JUZHj5DdfgN8K76rKUdaq?=
 =?iso-8859-1?Q?3Z/fUON0PDX0gYhTt7Ch1c3O8bQ6wYlfHjcOFuoh9rnkNr7yolu65DCG1E?=
 =?iso-8859-1?Q?AwOpjKo95g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59171cb-0b32-4158-a8c7-08deb74991b5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:59:33.9379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WFEKs6ijuOrgcX/D3r6MqxsgYcFn9jG8WDtwKsB1YzuBc8XFRjSnwELDt7R/sWEWq3dWCea7Abo9bWVX0y+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10671-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 1AB4A5A8D15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 12:31:59AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The newly added `dw_edma_device_prep_config_sg` callback modifies shared channel state locklessly, violating dmaengine API atomicity guarantees and potentially corrupting active hardware transfers.
> --
>
> commit 3f734236aec2497e34a2baf98f60bcd0cd1c6525
> Author: Frank Li <Frank.Li@nxp.com>
> dmaengine: dw-edma: Use new .device_prep_config_sg() callback
>
> This commit replaces the device_prep_slave_sg callback with the new
> device_prep_config_sg callback to combine configuration and descriptor
> preparation.
>
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index c2feb3adc79fa..92572dd8131e6 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> [ ... ]
> > @@ -577,10 +577,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> >  }
> >
> >  static struct dma_async_tx_descriptor *
> > -dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
> > -			     unsigned int len,
> > -			     enum dma_transfer_direction direction,
> > -			     unsigned long flags, void *context)
> > +dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
> > +			      unsigned int len,
> > +			      enum dma_transfer_direction direction,
> > +			      unsigned long flags,
> > +			      struct dma_slave_config *config)
> >  {
> >  	struct dw_edma_transfer xfer;
> >
> > @@ -591,6 +592,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
> >  	xfer.flags = flags;
> >  	xfer.type = EDMA_XFER_SCATTER_GATHER;
> >
> > +	if (config && dw_edma_device_config(dchan, config))
> > +		return NULL;
>
> [Severity: High]
> Does this introduce a data race on the shared channel state?
>
> By implementing the device_prep_config_sg callback, the driver bypasses
> the dmaengine core's per-channel spinlock, which normally protects
> configuration and preparation.
>
> However, dw_edma_device_config() modifies global channel state locklessly:
>
> static int dw_edma_device_config(...)
> {
>         ...
>         chan->non_ll = false;
>         ...
>         if (cfg_non_ll || non_ll)
>                 chan->non_ll = true;
>         ...
>         memcpy(&chan->config, config, sizeof(*config));
>         ...
> }
>
> If multiple threads queue transfers concurrently, could this corrupt the
> descriptor configuration?
>
> More importantly, if a new transfer is prepared while the channel is actively
> executing, the interrupt handler might read the momentarily cleared or
> overwritten chan->non_ll.
>
> Could this cause the interrupt handler to invoke the wrong hardware routine
> and desynchronize the hardware state?

This case never happen. change->non_ll only happen once after request
channel.

Frank

>
> > +
> >  	return dw_edma_device_transfer(&xfer);
> >  }
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com?part=4

