Return-Path: <dmaengine+bounces-10036-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C0OFlXT5WmmoQEAu9opvQ
	(envelope-from <dmaengine+bounces-10036-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:18:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D4E427A7F
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B203300291B
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 07:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B02EFDA4;
	Mon, 20 Apr 2026 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BZomjc3m"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58CE256C8D;
	Mon, 20 Apr 2026 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669519; cv=fail; b=PYOm7+BTGaK2l02kasLSzF0H/pLoitSt0x6fYNVjzBQbLxjmYWKkS5OLw6blFkwC5TS6KpSpxJj742K0dxelvLSCYp076bzKr/CTS/phvWN3VuXh/39oGKA04q+JuXDes09uwu4D7YMqbelyWD1lOd8rNihNjKu0U/cyF2Vp3g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669519; c=relaxed/simple;
	bh=GDYFnzfYxsuc618BCtRjnpoiLNhT0c0f4WFlQr7VqzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E8hoCvu4d8k+H0y+WDS5DCtduHmYPvp5S/fkCWwEB/90O9p74A1KQoCVcoU2VqJ3xEPhJ+r9+0kQsBIVr1kRzXY43MIzBeQpbcllFQSMt+NQIV+FqzmcKoJgIFjJaKpCyV5e/x1uwxSOrcDDdOjd4rxbztRNuRYbKUlhsMfv/5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BZomjc3m; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EX8b/2Iy/DdLnw1P5+gWg1xbmRPrEMDioaascU78N7FMjcc33NlrNHgdPmre718xXqOkYjim710ZaAe/JEtqSX3tt8du6ZeEMBt2e2FGZxZv14ZhIDRwxXI/iIgergmsaaUudPsKbj/N2p2+LY9x+ZFizaNeUxpJ7J3UFmQtRfzsrg8bM/syk/sQXpWEtoMq8gmSfQK7MboDXvPGWwTTlThvGUmVx4BfOuyAzYJW8iyb1Y6HtupNviEn8iMtubdDHgjOGasS0WW0OvjNgNZVuzeJv/4TQ2U3ZPYU9WSo6oW0Sp5bK5JmtHiGAPLL8hQ9mHQmGHTzZbbtBaowKi6JIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8d4rDi0od6aYv4vGVLeiMoKEFQKAQGhqvQXhL/IkZM=;
 b=BvniFyq2uctI9oZh1+evfvMsIipZvBhGXYqFXPkoGwCsxSfBj8vbc6k9sx8m3Bj5mEcFaKdc6J6NFD8PW0VGE885aU3++jnTza6vlfwd/pn8a5gnKopAaLiFdWRkgJfCtnOykH8RiWqH981I4X5WYEGd5eYI2l+ZqUYOWJ2Clhpcc+e/DxCA/wWhvWCG8yQGp4QP/9CiP8ri2IPP/CUqaMmnU0pNWfWS9k4yTsJB7EsaM5U+YdO6HoplqG2xzUBxLlqYmUzl6cAI9SObQV5260k8Tn8L6/gepFMdJNvKE7PlKzRlSP2ONo6gxKpQKm9iiEaj9IHmW2sZGmI6mTRCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8d4rDi0od6aYv4vGVLeiMoKEFQKAQGhqvQXhL/IkZM=;
 b=BZomjc3mfJaQ997TfMibbsWP/iI7m/uH2woHpCFf/sfw72aX7PljNcueeiL/qZM5ATDYajUR4YRLf6O4TjYJijh8K03TPenxg6nc879yuh78VF8KjMhetX6R7033+PZ2TxldyQxwc5vZZaxvFtCSuBjb6ZJhH8EYPqndcZamPRYkwC4a4UDkSYLVUzGfTO1+SQrYAVqpbNen/O9SZu7mJMaKUFisLCx1fbPrCYUve+FS6AdH3kwaXm6lqt+r9CA+OynK2UFw9Kzz/50brszmULBMmFnyHdP8fUrZ63RhDbxiiez8l9pNTD6SOn1126ZQQO03IJ/72Kz9+miL1wTGQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Mon, 20 Apr
 2026 07:18:35 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 07:18:35 +0000
Date: Mon, 20 Apr 2026 03:18:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com, John.Kariuki@amd.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/23] dmaengine: sdxi: Start functions on probe, stop on
 remove
Message-ID: <aeXTRBnAmb3DYEWt@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-9-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-9-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SA1P222CA0154.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB12026:EE_
X-MS-Office365-Filtering-Correlation-Id: 208fd17a-3209-40c3-38ac-08de9ead08da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QHBRtIt7UaQm24PtT3eLqdKfX5nqyp93lI5GjF5tdTO1p1fclLqcvib3l2f8XKEdVJ8iOBkaqxAWagUTbXDABdthPsr5Y1TIafhmSimsisFhvB0E2+t1rX/mrsHBs+hkFoMR/TumtaS3drEWKkoNQIeDn18yqdUzvog+ZcpFCqQyD75BeNniegTMwOEGjG9JsXugSpNOMHsMW79hRnutHPr4xfqBxeACr37NCkufhyIoSK8R/yVLbfaflVTzq2vRWSthrC5KK7+l3z+JjI5RW+Q08aETUk1AFE80edFzVJcvxuZByAQN4nbstbTJ80psb5K/Ki4DKOk0WpHdk7n2sRfb3ARaVTpnQJpLnJeYMbDQT+PhR6U+cefiCx9v3u5rKSK5PctYvmvvYA22H4YCdNBxZJWzRvTFoFBreMtm5n0U3lamtHc/5wCrHx4FOC3M0I6IpnwAZVHjowlzfe6lyw6cYcShUJExr0WvODcWcugiZJK1M0WXtFHZKYtOWEgs11j2mBXa2UkbUIiPaPF4cJLkAyQWaRZiUMbiZMzZXgD21SUap+rgdVVWt2RCYxNJwXRcZ0QmD/fAg9Gqt/t6f82LCDZZlQr4aceElBS0a0p3zu9frzzR+WnWbrRBvJ4pbIqpKLLTxkImaD/iLCon1kpmQnhU5XuQfYuUUJv1fXlCl9uwzabczpotPNjtQvzoL5o5kQfQXzCr+FDWFe+gV0p/nKVBoehRctKxYryJAbWv7RCjTtYpN6BEA76ud6tKNP//TCUYf4GEolcM2eSHp0VRtiOuwdYOaXkcaIkhvZ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uaKcEu2LtHarEtgEle8ZelmCJewPpNVbKshWRhhs7GwKVLApZCYx1ZAs/jQn?=
 =?us-ascii?Q?2wnd94350uRthUkPGOv/L3CqOwbQK90h2qpKQ9B4PISIHznH92fYPD0zJ9tu?=
 =?us-ascii?Q?RShcGqkPYLMK5I0hStSPRfweqPLzbkKi68X6HcsgmD5UGHoUJ2hqZ7kQpA4O?=
 =?us-ascii?Q?ZgET6czLXItjK6WFRt9WOXjymi8VAYXGkzQImBrUMsPCTMuXVDCp/Qt8+GlW?=
 =?us-ascii?Q?zV0X2P1sEprb+GayL2Xoh7bZ5tjx8hRtcPkUclTlXTyb5082+VLa1BdTIQKU?=
 =?us-ascii?Q?8hx5+LDq1D6m6GnDDrGRvYxtUYge29XJkmI8kXiewQmJKifGRcvJal8kvH1a?=
 =?us-ascii?Q?WtpsGBQGUt+wEdfdriSzSJ+xkveDHKEDpn6zqAew5C1pEDXh7/ZNCjU0C6ru?=
 =?us-ascii?Q?E7+nA8/JN8zkKT9ciEX3sBgEovRfDeDwaO+CUK9tgWOnVKXjuypo/4AlPQA4?=
 =?us-ascii?Q?aLLP3NyavVnzqhx6WeMPdodFEQ/KZy2+epM61KLHDLOg55SM2xvEJQjO0ls0?=
 =?us-ascii?Q?g4QxKmHxAxdUM4BiIP5vklmX4zqxqvOS91CHDCDRXKZ0sP4UMPXZQj3bgjFf?=
 =?us-ascii?Q?cK3QMRrgtYA+VC2RhZ1aUVon0Dlw79NgXxpujRsRPpRCBvtKTleOXkCHoDp8?=
 =?us-ascii?Q?PwtHkaQkPN5O0ioXlbSaOYILk4ktDc8IRe5yIVDf3Kov2kq/NALwxwSPE1Ti?=
 =?us-ascii?Q?vxp7cNcNtLf98Y3IlJ+9S5fFEsX2rNjK2I/hZF7C/I+Ad7jfuMZH6ROWm4zW?=
 =?us-ascii?Q?dXG1dlb04KMdnQ2YeGsE9wnxdhU0S0TobziJSUapOOYaaiBdlykLhtWWiAvO?=
 =?us-ascii?Q?6kz23wWpWBP6d0+WLN6gBDF0HJMytGFNf1CsgXNEBKUq2Q5JqhK2sS0W5qsi?=
 =?us-ascii?Q?WRpIgirk+O1uunTEEbVV8dMLe4XazL8QNEkD7Z/LYETk0LOAmeVU8jhAKhyH?=
 =?us-ascii?Q?hyveLb0zP/MEcDi8+Ii+pPGqu4+YgQvsaG1/ryrk4Nr8wehduhU/VtH6HkKH?=
 =?us-ascii?Q?7cL0qc96ufItQk+W0ceTGm/DRTEWu53kl0kvVJK9dchA45x5ydVO3930UfJC?=
 =?us-ascii?Q?y1qBd8ZZrL9GRnJr278VzZH9GYJWvEFcyZKygqILydiA5LOLtvnmXvER7soU?=
 =?us-ascii?Q?hH9vJVkbBIPs+BoqsPpORyTj/T8fiJh13RLWyldM+X/l1xE9mlBLzvir38te?=
 =?us-ascii?Q?kFcIBVpUK4Gkkh6OD0jsFB76FMqwG/Uidtrcz5j3gwqnHine5VTf2Jipw0gE?=
 =?us-ascii?Q?yFijN244ZMcfUEjIgiIVb9mPu/h49AGqbdZfNOLivxt3VNz4nI9EoinkuCUg?=
 =?us-ascii?Q?Urk+h6okjGQt/B8c4EHhxTMqvdQMzPFpqMQys97HTQnQCIhZuMDRsDErQVWz?=
 =?us-ascii?Q?5k1fUIXklhlwjfz7oNJzCzWRrHK3uDES8oC/lKotoO3of1Aco9u+3E51aRFo?=
 =?us-ascii?Q?pClsMYFGfIFsY25PxQhLJ2pwcJmPt2sA+K+Y3gg85XCKowrdB/8vTAWJfFdK?=
 =?us-ascii?Q?xxBmTg67TKPiJLPhGBw0eudXJPHwMWL+LgyuZ/Vtm6QsWxpfSGxzwKfBGcn/?=
 =?us-ascii?Q?uWjkyXodIh2jeyBJRumwx6Pur0mXOdlFfhrj1rUbJ3HnvAc3gW0Uzm//dp4B?=
 =?us-ascii?Q?bTWJxJwdkJ55Z7y9PCdsfUsSeruVHMg5kZgw4c7OFjbBy6fgANtIhW7t2ocq?=
 =?us-ascii?Q?k4BrbnQUAnvq1KMEKFhQUT2zXsQZufy4IOiZYpxaHeW2JXSRe1JKi9Kvt2ZQ?=
 =?us-ascii?Q?dJDHOu2eeQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208fd17a-3209-40c3-38ac-08de9ead08da
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 07:18:35.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXFtZU09YDejxJEYLoPlHQmmcUbsyjnm01N4ODNBXH4/6FDoISEO+pyLwiVTHYqY6PuDFvLlGpUYUsQvv354EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12026
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10036-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53D4E427A7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:19AM -0500, Nathan Lynch wrote:
> Following admin context setup in the previous patch, drive each SDXI
> function to active state during probe. This is done by writing
> GSRV_ACTIVE to MMIO_CTL0.fn_gsr and polling MMIO_STS0.fn_gsv until the
> function reaches GSV_ACTIVE or an error state. A 1-second timeout has
> been sufficient in practice so far.
>
> Introduce sdxi_unregister() to stop the function during remove and wire
> it up via the pci_driver .remove callback.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/device.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/dma/sdxi/pci.c    |  6 +++++
>  drivers/dma/sdxi/sdxi.h   |  1 +
>  3 files changed, 62 insertions(+), 1 deletion(-)

...
> +
> +	sdxi_write_fn_gsr(sdxi, SDXI_GSRV_ACTIVE);
> +
> +	deadline = jiffies + msecs_to_jiffies(1000);
> +	do {
> +		status = sdxi_dev_gsv(sdxi);
> +		sdxi_dbg(sdxi, "%s: function state: %s\n", __func__, gsv_str(status));
> +
> +		switch (status) {
> +		case SDXI_GSV_ACTIVE:
> +			sdxi_dbg(sdxi, "activated\n");
> +			return 0;
> +		case SDXI_GSV_ERROR:
> +			sdxi_err(sdxi, "went to error state\n");
> +			return -EIO;
> +		case SDXI_GSV_INIT:
> +		case SDXI_GSV_STOP:
> +			/* transitional states, wait */
> +			fsleep(1000);
> +			break;
> +		default:
> +			sdxi_err(sdxi, "unexpected gsv %u, giving up\n", status);
> +			return -EIO;
> +		}
> +	} while (time_before(jiffies, deadline));

suppose read_poll_timeout() should work

Frank

> +
> +	sdxi_err(sdxi, "activation timed out, current status %u\n",
> +		sdxi_dev_gsv(sdxi));
> +	return -ETIMEDOUT;
> +}
> +
>  /* Get the device to the GSV_STOP state. */
>  static int sdxi_dev_stop(struct sdxi_dev *sdxi)
>  {
> @@ -197,7 +240,11 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  	if (err)
>  		return err;
>
> -	return 0;
> +	/*
> +	 * SDXI 1.0 4.1.8.9: Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and
> +	 * wait for MMIO_STS0.fn_gsv to reach GSV_ACTIVE or GSV_ERROR.
> +	 */
> +	return sdxi_dev_start(sdxi);
>  }
>
>  static int sdxi_create_dma_pool(struct sdxi_dev *sdxi, struct dma_pool **pool,
> @@ -250,3 +297,10 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>
>  	return sdxi_device_init(sdxi);
>  }
> +
> +void sdxi_unregister(struct device *dev)
> +{
> +	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
> +
> +	sdxi_dev_stop(sdxi);
> +}
> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> index f3f8485e50e3..8e4dfde078ff 100644
> --- a/drivers/dma/sdxi/pci.c
> +++ b/drivers/dma/sdxi/pci.c
> @@ -67,6 +67,11 @@ static int sdxi_pci_probe(struct pci_dev *pdev,
>  	return sdxi_register(&pdev->dev, &sdxi_pci_ops);
>  }
>
> +static void sdxi_pci_remove(struct pci_dev *pdev)
> +{
> +	sdxi_unregister(&pdev->dev);
> +}
> +
>  static const struct pci_device_id sdxi_id_table[] = {
>  	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
>  	{ }
> @@ -77,6 +82,7 @@ static struct pci_driver sdxi_driver = {
>  	.name = "sdxi",
>  	.id_table = sdxi_id_table,
>  	.probe = sdxi_pci_probe,
> +	.remove = sdxi_pci_remove,
>  	.sriov_configure = pci_sriov_configure_simple,
>  };
>
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index bbc14364a5c9..426101875334 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -75,6 +75,7 @@ static inline struct device *sdxi_to_dev(const struct sdxi_dev *sdxi)
>  #define sdxi_err(s, fmt, ...) dev_err(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
>
>  int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
> +void sdxi_unregister(struct device *dev);
>
>  static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
>  {
>
> --
> 2.53.0
>

