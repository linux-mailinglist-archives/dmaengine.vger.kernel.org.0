Return-Path: <dmaengine+bounces-9250-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MqoJZxjqGmduAAAu9opvQ
	(envelope-from <dmaengine+bounces-9250-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 17:53:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F65E204A9A
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 17:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7FFD3112075
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA10C283FC3;
	Wed,  4 Mar 2026 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gqFu/RP7"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919FA36C0B3
	for <dmaengine@vger.kernel.org>; Wed,  4 Mar 2026 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641994; cv=fail; b=E2rZBb5zrXsjhLy1iBUzH3uMqQ9BGa4GwXwihw3V2F+zmErKHbJb1TUxTjN7lYzU51yXiUpWt7w/6MnctRiQlUNKA1lf7mbxHycryAImJWGAARkQTT3iaddWBcBIipoqRzzJICgYHssvo2p4ufhAtPQStfVueeHWNiYzbTQIQRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641994; c=relaxed/simple;
	bh=JA+cotbYQW+M4yiCHWuOqlADtyOZhYTCP93suWD7AjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q+yuwdlQ0X9zkv0cdbFipvgIQ1sfg3mNRDhnFZG0eKNHOFQLKZGzCJdbZ7S766z4IdPKMjvnng8iq6GyH3dc3Rl7ZHCkNZAVzdvNguXtZrTfr2UHk9c5XQUFs0fFRADQb3NjKo6mZA9gF9pYUcnN78MrPFrNzSCcGUzC1qMph6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gqFu/RP7; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlRE179p9w5WEBDiJgCyhGhHw4qTXXqVQgfpg3+1waKkTYiJg/NZYJfxKWG7qvDWIM3Ptxqte/ct86WqmLQfeQ5tO4XglBDtD4CPOZqi21g7mXb8yarmJ1k7HUPvRvIU1JP2xZXW3Pz/6Pj/TAiDmWngbHaTrFeQeaC4cvwH5wURuX98vKm+gg7XsdiLZi9Jw/5QsoeYYaQs217QtFQUMk+y03gb4i/E/K9y0fy+cQ6gXBsqOByLbQo5qFU8t3ZXR09nesal+swCLuXw/Y6LYwdCGmXlA6FZ59BHm0zknwAXP9rD+QY012eFrbz2Pzs6k4N/TIZT69nWWCONsEl+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5ffY+YtihveRaz99wJv0tH7TLDmWburFgcSGs3h3Hg=;
 b=wCt3lux3Lkzvo5/mufGR2y/89bAxrQJ2TB08mLQyTZsE47KUpD8AYnIE8BGFRSgo2BLgtaFjKQ3DIw5TE7IhuWJigUZ+YtzwurUW2g/GDVrVZ+byRhWGXSE5KhbXq3Gf+XlfjA85jnOLU0MLhZDP5DFtIvdXs9ArRpiiyI86mIJHBaJWO+YSnWhw9QlezvL4hmc0BfvaHfaZWLG5Udlo5qRzrZu3vBhshp3AmXZvTOaUbIK8XiZoVd2kr4i2XXtdm+XOtxzPbM3Oa4NyO9VhXlREd8Gg+FcXdXOanIYUv7PcVVHK8wQCyf+K1maqHTI6ie7xCrJltXJzwo2YsnezQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5ffY+YtihveRaz99wJv0tH7TLDmWburFgcSGs3h3Hg=;
 b=gqFu/RP727FgFoLapvHiqVB5q7Xc+Xf9gfsLQeykfNvis3ZrGusoe/cOPTATeh5M66Ub5J5ksYKNYR+/s+gZK6KfslPHsYkG3a0DPi/7Eiv00DuX2R3MTtxUVDWwZEhmBwgrBjkTSyxDs3/luQpV2OLqXtRcIqsPJ0NDB1/IIsM9ZUMG9tXp+KDxZ55R96udE2t0vWPeWWRVlyUjUmtCehu0MtxG3NWDCzlTyfZV24/fMz3Mey7eDLqlLFNfiQ1eemtUyJXNUW3iUuytZv0Gw+oEblZJ1wsazHSztxqazroVUthCMv8c//x5txRN6LjF8HlGN6hitI35lLGXnrXgeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 16:33:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 16:33:06 +0000
Date: Wed, 4 Mar 2026 11:32:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 3/3] dmaengine: switchtec-dma: Implement descriptor
 submission
Message-ID: <aaheutOqxlP50v0U@lizhi-Precision-Tower-5810>
References: <20260302210419.3656-1-logang@deltatee.com>
 <20260302210419.3656-4-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302210419.3656-4-logang@deltatee.com>
X-ClientProxiedBy: BY3PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::32) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: b316ffe3-ebe0-46fb-1bb4-08de7a0bb65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	bdW94pdkoYJ9dmdznfNhviWI3dYOSiaSYmUNdVI76Tq6hftget88TdiFxbXg2Isw6Qembgiwx6p+3NHOTCdEfG0eKhBkcLqH2WavgB8k9iM2RWzYl2+qZIlc5HqYWBmTLSUD1CTetPV1o7cYbq7kiQSSaECq/pmFPnxR2SspFjIP8QhRRvL2KT+Fwjss99d9XdS3VoCxF9c3QeeVjaAY5bcp3e1gUgtDCbRyUkNzZQLLdoS5a2EaieUpllA67/OKuJtj8ahQN+SW7ZUGd1KnKBKpcVdyiHLId6ywr8qLnByND0Z20MmjnXd8IMh3Dwn/RZvJW3KdnFQTjPNqKYTT5hnkz4S0nTZLKyXb4YKyyMVlW28KRY/AJxF3QN8M1HXE24cZoKk95y6qrSR0huqJgGF2uh/LZDpsaaJ2B0WUiLFuPMTegMajkjh6X0skpNfOk3oAPaNWNa58K1SnIicFTCHOmXOuGtXnNnbv+OGILHTaYaDLCgaM0g1DFDOnIB/95n4suGX/tZGlg7mmvzaJWSI0DGCGy5NSPWi0t+CqBCwb+Z5fQUeuUwPUyEkx6l7HdjZ2ibXY35eC7i7A/OTp1PUDw6UBJvf6zlYBp0PUUbsFS0xY0VpB/Rhg+vgifB6v7kiRzdAk7xoboBRZWf0ffTxx/qt7jzwbWoqc0AxKIIJbJvSHX9svTo0jPQZ+kcizFHZj1gLD8HngFKaqdiUdM7PkRtscZ1+Lq8oeJd8coKWvRzx+sZNWa3fSbbDcW4rrRUJ47U8Exx6aWKYp6vgBFpzXDpcDo+81sUHlZzFJ/mo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kQ4D3Hgv+WIidcleEu8R1/jjkV/BfT7Q8pkqmuQN3bEBQv0vsIe56FSt4Lki?=
 =?us-ascii?Q?Lv8LVqUxdKFtI32DdP1S/xuXt6XPCA9G9HnUSeijxid4V9fKuDyNHbYGsRHz?=
 =?us-ascii?Q?qoxYYJuum2SrNFGMZVZPINeAL9xx/lh5qUyMP1LAHiUzjQqs8HT4Df0OyI9h?=
 =?us-ascii?Q?n+4aEX9LFbpGOuA/7rWsxIW6/luo+k2HBo0SgKHw0eqqhRqRI8C7tt/GnKlm?=
 =?us-ascii?Q?IQbSusMxR2oI6PzvPUyBzrZMRlQsLzUA0n91k8OuRM9fPyisAzDTxxfYVEuP?=
 =?us-ascii?Q?95IvOvGt5CY0GZuVVDp52ZOqy3wNtaostsXZbuxa4u/QEO1jO07NrA4IKfga?=
 =?us-ascii?Q?xsxtIaBKgwPoAHX87C4EtVuz2Rx0WvLmCoNcysUgpogK5MOa18x9MsyCEDcK?=
 =?us-ascii?Q?CHzJ91j84qoYIbP4miYMuQ7eywrRFQM4Abq1Dkq/zVmVMJZoTPtOto6dFNf+?=
 =?us-ascii?Q?CZvXN6ET/mJ1ZmUKINCgdXUgYW+lA53kuWGNvX76cw9E31G3jloocilFM78y?=
 =?us-ascii?Q?bTDDcbygSB3WlKKn8SWWxD4DDMngm5GKPNPQgVtJZH/0xEyGBXFSv6zhz1W4?=
 =?us-ascii?Q?jSL8kPgNqL6tZmBEgQ3FYplFmuA3Qt6ofJEOvgi6D2OhyQUK8KARt4VJXGsK?=
 =?us-ascii?Q?KYQt3Z0LFJO9X1WR1fwO5P0VlifCzv8PSnrEhprNhkSiFnGkSzOTrkkEJNRN?=
 =?us-ascii?Q?V4MbZQIWF9P9OombVAe6INXdOoj7rUnFcFoR8pDnCh4avKKpP/Mfi2XuoFz2?=
 =?us-ascii?Q?5+9eRSl1cPy5Fdwd33NZN7DDO10zXPHc2Aqu9Osllr6HW6sFlhQnAHaiNNpd?=
 =?us-ascii?Q?qGr661cshZvPf8mwqOMnKycj26PO7mjiiWXRKxjr+YXj9C20e4IH4/JtfaaX?=
 =?us-ascii?Q?vYjaWw8AZcG7B99jTnBuLVooOOxExzJNHj2/R5kSeqB/9vn0XTWHJwso2Gj/?=
 =?us-ascii?Q?BVUbVrfTbBx3iKSLc689d+pTrCJLl1AAiP59Uj0wv+vmUeQrzdXa07jkuBjb?=
 =?us-ascii?Q?UIejC/UMTHcMkDtulZ1Gyb/UM/qZESt7613lGOWgPs/FFeepuDPNkDkU5V3a?=
 =?us-ascii?Q?Z1VS8kNYN8UXyHDfIvpK7piHS3oxS+m5Tb0TM2wR/32p6xDBbhbYr2td1u3n?=
 =?us-ascii?Q?PJgNC0Hi8lGz1Ku7j+UxQj4hce7fffZwTfkGM/epmQLTShEnE0pX8rOisRhp?=
 =?us-ascii?Q?ncjjwOK1NYV8ujPyEDoea/mHqCcPXWBjjrMd5ORP+SEUo+qMU6x1F/KsxV7W?=
 =?us-ascii?Q?LZ4k3JVDBizm6GP07NMuBhXVkzDOrWlZf9pnns4uEtLTF6GHQUBlCfxdssue?=
 =?us-ascii?Q?EtqZQn8Gk8AdHxn+3+5bK3xwYq5B9m1C3Vc2OkAN2ryE5lx2l4XV6hJupJNw?=
 =?us-ascii?Q?sSiE54wI6Y/035jhgzUYFE5tz4LHV19jsyyttqNahg/k3UOZKYB+Mf+t4P3g?=
 =?us-ascii?Q?3ZddUCMY0O+P7ah2S9RCRRZAhleKsN9Bqg/tglzBAUL4LBXGTGI/zVg1K0TH?=
 =?us-ascii?Q?4pCcCIuPtcGFbxbz0/ACtIJQfrQHVZ0EbB08Jx9zheNqYHBTU4OBrv8wMeaJ?=
 =?us-ascii?Q?i9tCzP7XD9clOLPHe6XyfSNoqShMqUL8Peba3PtYF8pwEDP72m+pwVl8Qrse?=
 =?us-ascii?Q?J4Hypv7Ojq+iy3zBnAuV70qr4DRVR8Xc1mUnFBd1rrM12SlJ+lYggtTU2mym?=
 =?us-ascii?Q?7wiDXG7Zs9YtQzJ7PFDuO1+inqDavM7rjQqamqHejmKvoq6C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b316ffe3-ebe0-46fb-1bb4-08de7a0bb65a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 16:33:05.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V98icCNySAzwfAm1c4Y/S7Lz6giiqv0V7Ht1lMw4rWpR4UMKvecibYP8GYKKLUGHD90Kdk4sD7ppXDfOWEfyEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617
X-Rspamd-Queue-Id: 0F65E204A9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microchip.com,infradead.org,wanadoo.fr,lst.de];
	TAGGED_FROM(0.00)[bounces-9250-lists,dmaengine=lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 02:04:19PM -0700, Logan Gunthorpe wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
>
> On prep, a spin lock is taken and the next entry in the circular buffer
> is filled. On submit, the spin lock just needs to be released as the
> requests are already pending.
>
> When switchtec_dma_issue_pending() is called, the sq_tail register
> is written to indicate there are new jobs for the dma engine to start
> on.
>
> Pause and resume operations are implemented by writing to a control
> register.
>
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dma/switchtec_dma.c | 225 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 225 insertions(+)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 4c0dacc24608..3ef928640615 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -32,6 +32,8 @@ MODULE_AUTHOR("Kelvin Cao");
>  #define SWITCHTEC_REG_SE_BUF_CNT	0x98
>  #define SWITCHTEC_REG_SE_BUF_BASE	0x9a
>
> +#define SWITCHTEC_DESC_MAX_SIZE		0x100000
> +
>  #define SWITCHTEC_CHAN_CTRL_PAUSE	BIT(0)
>  #define SWITCHTEC_CHAN_CTRL_HALT	BIT(1)
>  #define SWITCHTEC_CHAN_CTRL_RESET	BIT(2)
> @@ -41,6 +43,8 @@ MODULE_AUTHOR("Kelvin Cao");
>  #define SWITCHTEC_CHAN_STS_HALTED	BIT(10)
>  #define SWITCHTEC_CHAN_STS_PAUSED_MASK	GENMASK(29, 13)
>
> +#define SWITCHTEC_INVALID_HFID 0xffff
> +
>  #define SWITCHTEC_DMA_SQ_SIZE	SZ_32K
>  #define SWITCHTEC_DMA_CQ_SIZE	SZ_32K
>
> @@ -204,6 +208,11 @@ struct switchtec_dma_hw_se_desc {
>  	__le16 sfid;
>  };
>
> +#define SWITCHTEC_SE_DFM		BIT(5)
> +#define SWITCHTEC_SE_LIOF		BIT(6)
> +#define SWITCHTEC_SE_BRR		BIT(7)
> +#define SWITCHTEC_SE_CID_MASK		GENMASK(15, 0)
> +
>  #define SWITCHTEC_CE_SC_LEN_ERR		BIT(0)
>  #define SWITCHTEC_CE_SC_UR		BIT(1)
>  #define SWITCHTEC_CE_SC_CA		BIT(2)
> @@ -603,6 +612,214 @@ static void switchtec_dma_synchronize(struct dma_chan *chan)
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>  }
>
> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_desc(struct dma_chan *c, u16 dst_fid, dma_addr_t dma_dst,
> +			u16 src_fid, dma_addr_t dma_src, u64 data,
> +			size_t len, unsigned long flags)
> +	__acquires(swdma_chan->submit_lock)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(c, struct switchtec_dma_chan, dma_chan);
> +	struct switchtec_dma_desc *desc;
> +	int head, tail;
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);

Actually this try to force prep_desc() and submit() call sequence.

1 tx1 = prep_desc()
2 tx2 = prep_desc()

submit(tx1)
submit(tx2)

It will wait at 2.

Most dma consumer is that prep_desc() then submit(). If mantainer vnod think
it is okay, I am fine.  But I thinks

save dma_src and dma_dst, size information to software array or link.

At your submit()/issue_transfer() function to move to hareware circ buffer.

So needn't submit_lock.

Frank

> +
> +	if (!swdma_chan->ring_active)
> +		goto err_unlock;
> +
> +	tail = READ_ONCE(swdma_chan->tail);
> +	head = swdma_chan->head;
> +
> +	if (!CIRC_SPACE(head, tail, SWITCHTEC_DMA_RING_SIZE))
> +		goto err_unlock;
> +
> +	desc = swdma_chan->desc_ring[head];
> +
> +	if (src_fid != SWITCHTEC_INVALID_HFID &&
> +	    dst_fid != SWITCHTEC_INVALID_HFID)
> +		desc->hw->ctrl |= SWITCHTEC_SE_DFM;
> +
> +	if (flags & DMA_PREP_INTERRUPT)
> +		desc->hw->ctrl |= SWITCHTEC_SE_LIOF;
> +
> +	if (flags & DMA_PREP_FENCE)
> +		desc->hw->ctrl |= SWITCHTEC_SE_BRR;
> +
> +	desc->txd.flags = flags;
> +
> +	desc->completed = false;
> +	desc->hw->opc = SWITCHTEC_DMA_OPC_MEMCPY;
> +	desc->hw->addr_lo = cpu_to_le32(lower_32_bits(dma_src));
> +	desc->hw->addr_hi = cpu_to_le32(upper_32_bits(dma_src));
> +	desc->hw->daddr_lo = cpu_to_le32(lower_32_bits(dma_dst));
> +	desc->hw->daddr_hi = cpu_to_le32(upper_32_bits(dma_dst));
> +	desc->hw->byte_cnt = cpu_to_le32(len);
> +	desc->hw->tlp_setting = 0;
> +	desc->hw->dfid = cpu_to_le16(dst_fid);
> +	desc->hw->sfid = cpu_to_le16(src_fid);
> +	swdma_chan->cid &= SWITCHTEC_SE_CID_MASK;
> +	desc->hw->cid = cpu_to_le16(swdma_chan->cid++);
> +	desc->orig_size = len;
> +
> +	/* return with the lock held, it will be released in tx_submit */
> +
> +	return &desc->txd;
> +
> +err_unlock:
> +	/*
> +	 * Keep sparse happy by restoring an even lock count on
> +	 * this lock.
> +	 */
> +	__acquire(swdma_chan->submit_lock);
> +
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +	return NULL;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_memcpy(struct dma_chan *c, dma_addr_t dma_dst,
> +			  dma_addr_t dma_src, size_t len, unsigned long flags)
> +	__acquires(swdma_chan->submit_lock)
> +{
> +	if (len > SWITCHTEC_DESC_MAX_SIZE) {
> +		/*
> +		 * Keep sparse happy by restoring an even lock count on
> +		 * this lock.
> +		 */
> +		__acquire(swdma_chan->submit_lock);
> +		return NULL;
> +	}
> +
> +	return switchtec_dma_prep_desc(c, SWITCHTEC_INVALID_HFID, dma_dst,
> +				       SWITCHTEC_INVALID_HFID, dma_src, 0, len,
> +				       flags);
> +}
> +
> +static dma_cookie_t
> +switchtec_dma_tx_submit(struct dma_async_tx_descriptor *desc)
> +	__releases(swdma_chan->submit_lock)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(desc->chan, struct switchtec_dma_chan, dma_chan);
> +	dma_cookie_t cookie;
> +	int head;
> +
> +	head = swdma_chan->head + 1;
> +	head &= SWITCHTEC_DMA_RING_SIZE - 1;
> +
> +	/*
> +	 * Ensure the desc updates are visible before updating the head index
> +	 */
> +	smp_store_release(&swdma_chan->head, head);
> +
> +	cookie = dma_cookie_assign(desc);
> +
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	return cookie;
> +}
> +
> +static enum dma_status switchtec_dma_tx_status(struct dma_chan *chan,
> +		dma_cookie_t cookie, struct dma_tx_state *txstate)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	enum dma_status ret;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +
> +	/*
> +	 * For jobs where the interrupts are disabled, this is the only place
> +	 * to process the completions returned by the hardware. Callers that
> +	 * disable interrupts must call tx_status() to determine when a job
> +	 * is done, so it is safe to process completions here. If a job has
> +	 * interrupts enabled, then the completions will normally be processed
> +	 * in the tasklet that is triggered by the interrupt and tx_status()
> +	 * does not need to be called.
> +	 */
> +	switchtec_dma_cleanup_completed(swdma_chan);
> +
> +	return dma_cookie_status(chan, cookie, txstate);
> +}
> +
> +static void switchtec_dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +
> +	/*
> +	 * The sq_tail register is actually for the head of the
> +	 * submisssion queue. Chip has the opposite define of head/tail
> +	 * to the Linux kernel.
> +	 */
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(swdma_dev->pdev)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	writew(swdma_chan->head, &swdma_chan->mmio_chan_hw->sq_tail);
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	rcu_read_unlock();
> +}
> +
> +static int switchtec_dma_pause(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
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
> +	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, true);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static int switchtec_dma_resume(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
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
> +	writeb(0, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, false);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
>  static void switchtec_dma_desc_task(unsigned long data)
>  {
>  	struct switchtec_dma_chan *swdma_chan = (void *)data;
> @@ -721,6 +938,7 @@ static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
>  		}
>
>  		dma_async_tx_descriptor_init(&desc->txd, &swdma_chan->dma_chan);
> +		desc->txd.tx_submit = switchtec_dma_tx_submit;
>  		desc->hw = &swdma_chan->hw_sq[i];
>  		desc->completed = true;
>
> @@ -1047,10 +1265,17 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>
>  	dma = &swdma_dev->dma_dev;
>  	dma->copy_align = DMAENGINE_ALIGN_8_BYTES;
> +	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
>  	dma->dev = get_device(&pdev->dev);
>
>  	dma->device_alloc_chan_resources = switchtec_dma_alloc_chan_resources;
>  	dma->device_free_chan_resources = switchtec_dma_free_chan_resources;
> +	dma->device_prep_dma_memcpy = switchtec_dma_prep_memcpy;
> +	dma->device_tx_status = switchtec_dma_tx_status;
> +	dma->device_issue_pending = switchtec_dma_issue_pending;
> +	dma->device_pause = switchtec_dma_pause;
> +	dma->device_resume = switchtec_dma_resume;
>  	dma->device_terminate_all = switchtec_dma_terminate_all;
>  	dma->device_synchronize = switchtec_dma_synchronize;
>  	dma->device_release = switchtec_dma_release;
> --
> 2.47.3
>

