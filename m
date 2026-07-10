Return-Path: <dmaengine+bounces-12319-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TyJQFtwPUWpr+wIAu9opvQ
	(envelope-from <dmaengine+bounces-12319-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 17:29:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B5F73C3D8
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 17:29:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=xmo3kYkq;
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12319-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12319-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09666302313E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6446D343889;
	Fri, 10 Jul 2026 15:19:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C12F1FC7
	for <dmaengine@vger.kernel.org>; Fri, 10 Jul 2026 15:18:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696741; cv=fail; b=DTDt1JN4bjGbwvcqgJi7D6RJrCgmZAk9Iqbjn+PczlZwfWpylNqxuICTdMM7/zU6VDnslRXlVE4/YP3IsvRA19em6zc7yVWE9Q2vzATpcqHfv9wr4XOJ5DEh79vD4ipQdlY4LxiQuc/zvHnW67RoazDq1oRh1N91jLZcD5ax5ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696741; c=relaxed/simple;
	bh=2clNZoXSjTfQx6aeJZRKkfWELQcEqKS2lUVM8THqFzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KKqeUgU1hvEcVfTH8ZgEmv/l3bzfOzN2FiJAVDg939hR1DndwfJ+Vr1Kr+6w23WxHO6xHaa6BO5Mj9GI7zPRrAFNJ17LuI9jYWDs7Xjkv7TF56TH0PifB5yRKY/HHak3hUenPaHoLdKuJW42eXHvC5Nc3t3s7QWBJtJ3lCwRERI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xmo3kYkq reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEcmsFpgU3mby4PDEoYKzsGTBUmr0wFrM5Xm2IjxpMced/ipqFXJTlQmZVqIylEQpOU5jk6/OWxxA1WTK2g8GmWiIeCfgEP8M5gd/KMt2H95ptGuH13pvYIjvs4CTR/iNbCyKx3KUTQ9zk0G/k3yT0YiitvxBXPAui7RObwc4r32nWf/ex1FCeymj8Q3WFXNc+DE7mzUrLe2k+Ngh189eypCzogRe5CkfA+/p2ROIFVg67wlxmYzuNrlGeSLbo1a72iNC8n7902rmRKiBs9P1mqZkRCoGnhZJqyumtMpMxXQwHy/vXoEs/WC+Jn1jHS1Ad28reqmB0c91vh5tJFDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtBQEP3+3W2HKxQLXODe20OOAb23eeSP7Z9lQozzkNs=;
 b=YelUySHCOVbDycKBKbBCDmdM8/s+KkCPjeBqwoY/yWIFR6N/SDe8kypEwXJIV1EutW5LrOWRa5rmaRGrqF040Ng5CxrjzuBvu1h4whqhrUTjy6E17z/113/jXHHi1DcYpwYfWZdiW/pj6QLBQcVM7JSdospGa3X6ZR7Q/R7S+03RoAccP+ZHTq0XOiefenyPI4S+951gLird7ibD621kPmfbNXlal+ogyLr35W0wgUoPab7Z/8vTSLxqyh8aMU2dEWhtjggSVD6/Ip4RIpFR/ElftyFToHgZDZU/lCTVWK/z8qIbc4quJgzPo/GCjGrW6Wdfu4NRh/4qPfTaUBXU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtBQEP3+3W2HKxQLXODe20OOAb23eeSP7Z9lQozzkNs=;
 b=xmo3kYkq+vHwP9dVhPwmrRb0wmsuOWk9BbZ+NAJMuMDBbA1iibjjuDQx6TnF0oouMQ3kOoRzUT2O5HUNTFVkC4WWvPXFYQ3hFj5RbB+lM1ChaVHmg8bgN+tU62k0FlEVzS7/I9ZDJl4hxQzXNpSs103DY5Ww+g3GIYLeyc4NvnSKiZzVxn58rb/htbj4Pz9jcFs3CbF+9uRUopayw7RBTxlrbZaK4YCwv7lKPEi/Sx20do+cicPvPWtG7u3NV5myt2QZSx4t4xaepycpDVRsvHqLE8Wse20gGoNoN7XgGWmMlWy/W66VjK2ivR69bs/mE68URBPnxmP+8hsuph+deQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB12122.eurprd04.prod.outlook.com (2603:10a6:20b:747::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 10 Jul
 2026 15:18:57 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 15:18:57 +0000
Date: Fri, 10 Jul 2026 10:18:50 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 1/2] dmaengine: fsl-edma: Implement
 device_prep_peripheral_dma_vec
Message-ID: <alENWvKlCNk_EJBd@SMW015318>
References: <20260710-fsl-edma-dyn-sg-v6-0-831b96be3f31@bootlin.com>
 <20260710-fsl-edma-dyn-sg-v6-1-831b96be3f31@bootlin.com>
 <20260710122359.674951F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710122359.674951F000E9@smtp.kernel.org>
X-ClientProxiedBy: PH8P221CA0042.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB12122:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7ce952-d9cc-46a6-75cc-08dede968fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|6133799003|3023799007|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	nKF+ny+uhaPV3Qr+CLD7ZrbEUOMcO9OyxgPo3zFmxYAAZZHnYOrijYlEBjMfbh5sAs8jq6+ZrBok3Uk5cvtT95qXnXga2aEw3+qTZeMndnPqDAHtIyPiFf+IjMpYt4hbAy/vAj4U1X5jfHgGkKOBj5ckbowCit1COqFMhnGw/KODoEpPO/Ez0PvrFf4Yr7YagiRtWJp5/QPPdY0wJiAc3AIid/DttYdoLFQ/D6ZRIQtWsu3mM2t4SId/kvpUgmXVOgOk9T8MBxBfjznuRe4SgstTwLsmxCZlcVvwI+sxaHyibEec6IuxS2GOu75pAmZ7MRAjKcs/IW7Ii1wMXTj0iLm4GCr+mEishIns+gkZJ/I2fC7uqt0ijpwmby2IGlJ6cmVIHtECykQk9XwoaJqRGmqebzZMdWQGJXL5ntUMQymYl9SRDnnhBmn6VutXZnUmqNkZW+LMEPBUJp2pD9PR+vN3zZj0I/fR/ZJWXVVrxFnK03wYZeQ2ytHMSSyOtA57UTZGs8e8w8dbqyxDZ0V2s8LqpMfMe2aYC0qA881F57a/jKubMEF+ZME629EQn+FjLZl+j1qzyVZshCQKPQWRg7vnpl6mARiB1AxG6o9xBJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?SLk5URP7b01Oh23tPNp/rXYBIsIarGJujqkwBx/wdVjeVwBGpKcjrXpjaD?=
 =?iso-8859-1?Q?Am7GxXMjnnWvh+9Md9NfU5Qo/Lwj9ZYNLnv/Zi5TWe33LZuKe0dJzQF4Li?=
 =?iso-8859-1?Q?jGY8i2QphOjTpY7aNoyy8KrIppRaTvt9kXI0TJ1IsBqzEGTIO6SRnnoWKS?=
 =?iso-8859-1?Q?PBUjkx7XvWQ2Y+FzM1a3BxPEvmrNivtTiJo43CkwrhorS9gONag6hJCeoY?=
 =?iso-8859-1?Q?/mtMfWSkCPclQtzieV6ZVdG5tPofuYn+I/Eq/2k9JPIFBJHnkG5Cb66FUB?=
 =?iso-8859-1?Q?gAMeoba1Q3cPkLCc0ViT5XtgdrqZYaQOcBYjSURMZS52cq9BR9T40FoPRr?=
 =?iso-8859-1?Q?1Q38XZqRng0jv+LVTvXGgaogasDIUU9LxS0pbztXh0Vfyj2azTciacx4En?=
 =?iso-8859-1?Q?ZpdhVP9WH2CWnU8n+Hk2syIMfBbJgBUC2eo6gIKtw/+0RdkjTDq9O2FrFi?=
 =?iso-8859-1?Q?M8fpeneLTsebTuSDr6VqBb55dfbxZ9vcxJVXO/DgEkd9IFaRjARODET6Ey?=
 =?iso-8859-1?Q?ero6Hb2jf2US9LHXuqXolA4YcK6nKSgIlczpAEayAPmRrMqqBEm1+HsDbx?=
 =?iso-8859-1?Q?KenGQYG4egVjDHCtgSOnU7vdeXTaH0fM/WVc2MbyYUH3r6iKhfGK8JeQ42?=
 =?iso-8859-1?Q?e8T0i+VTVf8CddW13CCRJBuKCVSMqycGe7Xr4EIyNwzK1kkjwQFQk8QP/a?=
 =?iso-8859-1?Q?KXQlYT/VSt5umuM5EkoOzhLM0z5XfywtoZF3x3qCUB/dlVGci2br3i+z6W?=
 =?iso-8859-1?Q?Q2v+IwQkFmB0m3Pkoko2Zct9dPFGvfxNVYb3GG1pEUFi9OGONfDfMdscJh?=
 =?iso-8859-1?Q?aIAriqf7lwdDqP3KU4UsB6YChATfB4A+FWAt269Lj+69SWMSHDdPaaEGms?=
 =?iso-8859-1?Q?4dogHIMTZXziObBbijKE7Vu4OhnchRHZXqeXPFWjQB5C+3pDW4nxCRm1Ik?=
 =?iso-8859-1?Q?UPbM9UERiqee5syjJrehiqqlR/VvrP/O1yMkvPKGw9kdguZiUCG3JRMat8?=
 =?iso-8859-1?Q?JjBSsd6irQtFOU2b7INWJsgec3stCfxYCW0W1OHXEjsW9UbtS9OxOJIJ56?=
 =?iso-8859-1?Q?A07iqTajqN+PMePzTzlpgnjXOZxKtGgwFCG91LBkYjR2mZhyQ/dIVdTWQp?=
 =?iso-8859-1?Q?oET76mz6GSjpccUjMVXaujBzq972EO5sPo99eh/q2MAjskP1SuxMTyTtSy?=
 =?iso-8859-1?Q?2a0yzdn9pvwpdbnHzHQ4owTPMIqJ07QS0SlVmb3jQI4lWtGEQnac7gBq7i?=
 =?iso-8859-1?Q?qj13dSz3gYRmHvwX7ODglbWj2vF9TJ1vGXRZswoEdmVRdST+vP6HBzG9bG?=
 =?iso-8859-1?Q?+WZkdBf7xDFimggaRulbr5ZgaxbvXERylgBucJgjQAFuNNTlMPO0F3HwnH?=
 =?iso-8859-1?Q?fS9V3hbXt5QfjBHx1JGS3WrirfxEJsrkd29apYYKcNa1JnmZWtEc+skBoy?=
 =?iso-8859-1?Q?n5ol8C4vifp5+HjoGqREzFg/FerDnZfh6K3V2jRV5Yy3qpz95toClhVfwr?=
 =?iso-8859-1?Q?33w80PSc40q+O0/04YwrQpFHBrTDv4stJLTY5tdGCpyOb953WeJgFCbq5b?=
 =?iso-8859-1?Q?PsFNf2Kdz9Az3E30fYuVOsBNeUOccPZwcoIKUWUekwmPhE0temanfFAOTC?=
 =?iso-8859-1?Q?d3P2PksIkmRxkEAGB+dOCvpXZmu7Y+tDloqs2yBIDHOZcjcEwBY7yLgKpR?=
 =?iso-8859-1?Q?sSxLaZDXRA0yjcJgp1lV6xdHgKrgZ29CWd7BJc2Z6SBgv6bcu7L18uFWq1?=
 =?iso-8859-1?Q?fQtdve+QqTZX8u0nlN6VlbD3kEQCfMbehvY8tAws9kU1Uol6VIVryznhS8?=
 =?iso-8859-1?Q?vEVX+eCjovaEFOM9YOfkiGdQxbj5KJt/ZpuMAuPhOrSeIgcbeJYD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7ce952-d9cc-46a6-75cc-08dede968fcd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 15:18:57.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJcudRwNA6RFS7csia+273rSmWC5X4oF6CU4Ki0vWR4yQSzp3RQ6Kc1ZiwRwPlYJQlTI2PZmEA3xIQYKxyf6SviaOoHYDfbS7hrib2giw2rVopiZ6jffA++kHOgkjqCg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12122
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12319-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:benoit.monin@bootlin.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33B5F73C3D8

On Fri, Jul 10, 2026 at 12:23:58PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
>
> New issues:
> - [High] Missing validation for maximum segment transfer length causes silent 16-bit truncation of the loop iteration count.
>
> Pre-existing issues:
> - [Critical] Unconditional division and modulo by zero occur during DMA_DEV_TO_DEV transfers due to hardcoded zero offsets.
> - [Critical] Missing `is_multi_fifo` and `port_window_size` handling causes the peripheral address pointer to permanently walk backwards.
> - [High] Missing validation for `nb == 0` leads to a zero-length flexible array allocation and a subsequent out-of-bounds access.
> - [High] Missing validation for slave configuration parameters allows clients to trigger a divide-by-zero crash.
> - [High] Calling `dma_map_resource` with `DMA_NONE` triggers a BUG_ON in the DMA mapping subsystem.
> --
>
...
>
> > +					nbytes = j * width;
> > +					break;
> > +				}
> > +			}
> > +			/* Set burst size as 1 if there's no suitable one */
> > +			if (j == 1)
> > +				nbytes = width;
> > +		}
> > +
> > +		iter = vecs[i].len / nbytes;
>
> [Severity: High]
> Does this properly handle vectors that exceed the hardware's maximum segment
> size?
>
> The dma_vec API passes raw vector lengths directly from the client, and
> iter is a u16. If vecs[i].len / nbytes exceeds 65535, will this silently
> truncate and lead to a partial transfer and data corruption?

Please check this problem

Frank
>
> [ ... ]
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710-fsl-edma-dyn-sg-v6-0-831b96be3f31@bootlin.com?part=1

