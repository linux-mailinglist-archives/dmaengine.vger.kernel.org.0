Return-Path: <dmaengine+bounces-3291-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F701993204
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 17:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0305D1F25777
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660D1D9325;
	Mon,  7 Oct 2024 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oJRyirPE"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6851D5ABA;
	Mon,  7 Oct 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316286; cv=fail; b=BKwoAMSVq43CJB2U9xU6/wGEXdb7YTLydYEQR54VdW6k7CuoccwTWLZEHVmioLSCC+dGnThfjRuIEaBdfD8bGbjX4b+NWtW+pbINW81zLW20LTvewFQHPHI0q97QfKPIw+PQlzEpDkpxklV1NqnKbk4I7Ymz4S1uDYcYGwWnD1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316286; c=relaxed/simple;
	bh=DB9qFpwQZ+uNpxohVDbK9GdG9HsD6VEV/8hdpS8MN6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tY7q/SfvJ0xyC4CkAfaJSgngXi8hgPsyhMNs2/3996BkJOqkXWCWY7eSFqK0bGV9oOqe8b9+S0viU4MEo+3U+eUnEk8aE7nyHvhPI4wUzon5PpDjbrWGXslqNEFEYCSYZXKyyrjvCiovMUXZ5PnmAAoM8IeGSfKFufCiD48KRc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oJRyirPE; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhJRc3tE0bYDliY1Hqvk30a7OMVCzLz8xrPUTJ5CvUfz1VLOBeD6gv1Zapz4uGLDFxvJpgCLkTUWDtxiItGdtaHBZg01cTPG+31WBvgd3Xi5aycyDCyMUWx1dqgAKq/prWXkhcvEuoq6VS2VcfXRUOCFMe5yrX1HMvdR3yttkHhFhXVD5J9xxed1qjzk17YCpMEyHIsxFM0on66ZoPp+WRfRWxtgBEtrVByrNAEkXWStyipK7dy81kEflV7+aC77bJFKFJICTND4IZnbrqsNKDXsPKXFaSYEHznoKWV2VMhqp1xeBObMjzGIPrznNHyzfYHqe8Ja/atWOM5TX2PeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvZd/NBMc3j/tGXQ6zdtHccNuoZhhCjg+uFvbhRHiXs=;
 b=mZ6QWy6+oFeesamk4+vOYcaSrBGUOE3Ve+WHy8KNrMjRcafvU5k6Ji1JXO7tZkN0Pna3nVOpekIVh/CrfxlwlyHF5T/Em0tXmvR0URrrQ70/uC9RYbCJVkaGPxqJuqoGzZs8uRc8kDMwNVI7DRFLhlDzBQtCasgi50NLZHp20huBX4+xXJTCDTTs3csZIYyVoIT9stpX60wOA4ngbEWxlkNA8xuNeh60ePwGQTYY+QVh3O4JAQ1n/UNJEKbZ4OxZBVibUQRsQ5xZLZK+JPA39LFHmnyG70cd/1ysAfqm35aCeQ+YfWlnQVZ8i41CGJTvQ3MGD2hK3LBYqA9HiNWWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvZd/NBMc3j/tGXQ6zdtHccNuoZhhCjg+uFvbhRHiXs=;
 b=oJRyirPEBpm3Vp4ffl1W9E3dDoMif9aWmyYiLYyrtg89ziS/XleAhMyOHwShB1S0VGbnagCUpSTj7+ahItWg0z4TZRtxp17lmoWBnIZUWkvlD/5D/n97WlCfzx8f0U6Mql0fCpmhqG2fMgKRQFB0ex5YhDSeq34MNr5IPm+GPbSvduALdOqSPWlcbDh/y3VY/rdlFO5pqBjuCc/npXVxoOu8p3xs+xKhH+ep4As3m2hRfrYIM3dhGqyEMJ1OKWKHpbsjxFWRYfIm5Hj9BS6pOh+CH5LKrOVgpBQzsBi8IjhXn2RLIdpZD061O2uo4PSi90pMPpKgHxZCCQ/nz6dAew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10886.eurprd04.prod.outlook.com (2603:10a6:10:580::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21; Mon, 7 Oct
 2024 15:51:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 15:51:21 +0000
Date: Mon, 7 Oct 2024 11:51:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 3/4] dmaengine: Add a comment on why it's okay when
 kasprintf() fails
Message-ID: <ZwQDcrJuW+DXMBD+@lizhi-Precision-Tower-5810>
References: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
 <20241007150852.2183722-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007150852.2183722-4-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10886:EE_
X-MS-Office365-Filtering-Correlation-Id: 22211e0a-36eb-4d9a-f29a-08dce6e7e40a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KB5YKkE/wJG5nU0peowA07IHUgYTQ1mO8spICG6kRdagbJ8NRJ/MwYal9onP?=
 =?us-ascii?Q?gSEQe231O4DqxUasPPXytQJp0KJAYw6PlM3o+FmNhVFWE0oBeoCetiMoa3h0?=
 =?us-ascii?Q?0PySklFiecdVctnYqnOegHbiFRVn9+58aiKf1qcogGCKE6V59OEZuaHjco9S?=
 =?us-ascii?Q?kjTMruHkLfeRB5nt4s7PNZ5vEuqLhUNqaadiwQdrfAkdGr8oF9Sqd3zoZas/?=
 =?us-ascii?Q?yHM7oVO8loB09iDUacMyx0SOTfXEjWUu+YRVJ4hzSQJ0AgLK79EmxO7etn/T?=
 =?us-ascii?Q?x8FkA3GFwrUS36LgqE8xalo7TKvJZLLHWU+T1oAhpZ1JDd2WllEHOS+ftTXc?=
 =?us-ascii?Q?C8hIzHPfIAjqdEn4Vq31mxiuz65/b7DfqbL+TlC0vbGpxQofzV6LcgSH0Q1H?=
 =?us-ascii?Q?5H0i6ZsMujhaffObn5K7sAEipLDD+XzAvpCtd3ZgHR2ji+/CrmokQOU2p9Dn?=
 =?us-ascii?Q?8tbmktGUYh3I/SpTvHFMgeCHohjMhDhCOCReYbm6uymu6R6ypEKAmX4j6q8i?=
 =?us-ascii?Q?+hbRHYjBlUggYHDKUuQ4bq+YjJcqGV5i4NFCn48Ha/xFU9bk5hk/ghxVlNud?=
 =?us-ascii?Q?+dv1Oi5cbal6H/D8uIYLxqGJYtX6vsYGGQob8taoW/0zd8LDjqMi2Egsrj6q?=
 =?us-ascii?Q?spNltqZFiMiTdN7Y07cntJnotXLsmzIWOiT8xnNDsBhLlfrBUR8qeG/92MGR?=
 =?us-ascii?Q?xxyGcOc/IkQMPJZabgf7juMxeGtPkxdU24gTppDNqlV953qWVwCqYXM5n5Au?=
 =?us-ascii?Q?JZepvpMq97NcjtDzkPZnAvBoR89EEy40Hpi0IBTpgXU0GMPm6bjJ3AspdE4v?=
 =?us-ascii?Q?czfjYvgxn6YdcNaphVspYjnLeKKv3dEZPQPG8OYSwTnZLsywOAyjX5QK3d0S?=
 =?us-ascii?Q?WlDr34M8TmyCcQ5pmRZ6iJqSooXnN4xJwcxxUI5ptCY6eAOyaEGCDDtsjmy8?=
 =?us-ascii?Q?RHS92Rl0XqIOIunmymK8eJq3CtDBBZMeg6vai7pXZrQT0Xhn3/1W1ugLGrqb?=
 =?us-ascii?Q?UdvRtKKJ5SE7pO487HQ+z9N+4dBWWvoyplscJpo1pDWT99TEIJxMAAndJbPP?=
 =?us-ascii?Q?eNWdVaOzRak3jMCsDyXlOtrZ0JUqQCqpvpe+UYbhn/2iX5p1gEjhdvl6U1lP?=
 =?us-ascii?Q?3K87CtDnARWpPnL6pi7ex2sVOGOBNXbqavtqNtUn6u/mBD1YQ9OXk+Gs2riS?=
 =?us-ascii?Q?vGNr9ULNWIi1RuG+QIqjn/FwijNH/VTNEvscUgqwrIt6q9o82bkeRT213RtW?=
 =?us-ascii?Q?+mdoVFRVENPO0VWuOhm59GcItbL3d0CPYkCVQpJikSBtEJQu1XDNZjcvQNwl?=
 =?us-ascii?Q?GgHeXVyTm60vyEEuGj+FqJvEK6n4a/7NqPT0X3HjszqUwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0RgalUsl7czthsoURk6d8yhS3ySUfkkk/p4QNyjcN3LJNETJEjzaaUoHiTzq?=
 =?us-ascii?Q?TKmZfEWAfe/snmlBl0SOopjhZeLNRwtSY8uf2ygj5P1ekCsaAAku+rKJupDi?=
 =?us-ascii?Q?Oe1vweeAoB6IdW9qHBwfKybJrIoBL18Ungb47efNidm9tg4dz5lA1EY3KimG?=
 =?us-ascii?Q?R+HoXvHHN8mAxKxpFFhvX4syzfmYinOibBfvflcmUBEqHom9eSVxphri5SXj?=
 =?us-ascii?Q?NXOkVoNnUrpOWkAt0P49W9f6SfTY7mBLrrE0gNg4bOj+XvjE3aWwv42j3+wi?=
 =?us-ascii?Q?131WcHkvi8lr4Op/KK4WAu0ge0qHA6wDg7v8wI+gf1fwpu2eeZdzH7BTS5NJ?=
 =?us-ascii?Q?pH0OduOa7B7e0c9fSHP/NMBrxIx05cJdQr+cjVzO0XI5hzx2/TjhKpl9sbDx?=
 =?us-ascii?Q?/sCMhx6wARjzbtRytz51038VEWZL3v7vK9t29b9mb87j13zdEJku7RxPXE1x?=
 =?us-ascii?Q?SPjlwcNgM0SiZkPclhutHG7XzTc0i0uwHWrn+7btWE5IHX8g+X12SP759dwg?=
 =?us-ascii?Q?7DKiKeQe2LFzTTe+Er8MnUUUwdXTox/zLD1Gap/yNkhqboxw4gYIm4qjZUIj?=
 =?us-ascii?Q?rF1xZoQ6qYcVzi92o6ufI6LAbuUzRjB0VXQbi+8E7+aay5EX2EEr/7O6MNMI?=
 =?us-ascii?Q?A7/+vszqEP17He8o4dneircz9p6wy2YW0qQmLcPIpE4KZcqCXZxolpmGbomH?=
 =?us-ascii?Q?GYg+72n/4AoQc/zc9Q04QX4vHu1sNeW4oFF/37pG8qRIitpHSG9lrGm9jI51?=
 =?us-ascii?Q?a+R19Oj9b7ZrnvZVyFaIfJHtV3KVPjcrhAFJdf3DoUXfJSl5ZD0pNL1ifu+O?=
 =?us-ascii?Q?Ogo/X8nrbEIs2vs2444eM01qgekGM8uCWvEvk+du1r5rR3JQEXxtaSg7XPrK?=
 =?us-ascii?Q?H1MmXlemo3PluL8eGCJ0TPY8yhgoUrBYxiq6uRd/GMWd5NSG7xe1AIDgHBmA?=
 =?us-ascii?Q?mq+qrkfwxQWCOBmCOGXuzUgjLJ4dDKJuWZsU42/lOKeAmB5aa1hbKJ7d+rJh?=
 =?us-ascii?Q?MqO+TvfkiFu4w4N3WY/gqt5m00t+Qq4jMEy9XMe6znH0+wmQGtjixwRzhSOd?=
 =?us-ascii?Q?9pv8TuftCIZSTmbjP2AsS/2IR/pcvv/bSiTjfZo0xB0yHByLa2bxVV4B5v9e?=
 =?us-ascii?Q?PUQ2M+l4hfo4aPST+0E6GdHQmoGt0vRvGnSG68aiOgAd840ZXlE3g6woD2ub?=
 =?us-ascii?Q?4vdH1zKT5c/xQX+Nw4jMLKPfhYydXQoQJ72oNk9SsDqtas9POMk312Aduwdz?=
 =?us-ascii?Q?CHsLkh4tq3jCZJ9MWc0b1L41IDbolyvSYqNwGkiLoOm6wBOfahxguyQV2He2?=
 =?us-ascii?Q?Gy7hzlglxUj3cI7MICmv2QHOKUfsWvgOY+nXzMnUEaiBpKSt4+sw3ZHJHmyi?=
 =?us-ascii?Q?ta4oNE0LtO3UGlhnhqjZUhBkqRpjldVBETI/4/eZF02PwgUxvxw7AAVzh1kk?=
 =?us-ascii?Q?PjdfLevs/VkFjd5ChR9dCymGZVb1akQ8jmH/SoxDE8mO5iSymEzbd6G6TH9e?=
 =?us-ascii?Q?uxnhJx1WdhWwZMjNFp5qLUpyLVsfrLt8MF4EJ2fIRRXOvkmcl0nPyPXmUFAL?=
 =?us-ascii?Q?uA1l7sR4gqXkKIgaHkDlAIAzFXbyvCvY/jYjhYIt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22211e0a-36eb-4d9a-f29a-08dce6e7e40a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:51:21.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trhpKdIhApd8NbRiJ8w6GTKAQEwwiUFmYHMM+sN0q5PTSeoxr81jZHKPc0p92d34DdMDsC0OBLVjAaPwvIlK/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10886

On Mon, Oct 07, 2024 at 06:06:47PM +0300, Andy Shevchenko wrote:
> In dma_request_chan() one of the kasprintf() call is not checked
> against NULL. This is completely fine right now, but make others
> aware of this aspect by adding a comment.

suggest:

Add comment in dma_request_chan() to clarify kasprintf() missing return
value check and it is correct funcationaly.

>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dmaengine.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index c1357d7f3dc6..dd4224d90f07 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -854,8 +854,8 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>
>  found:
>  #ifdef CONFIG_DEBUG_FS
> -	chan->dbg_client_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev),
> -					  name);
> +	chan->dbg_client_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev), name);
> +	/* No functional issue if it fails, users are supposed to test before use */

comments should above chan->dbg_client_name ...

No funcational issue if it is NULL because user always test it before use.

>  #endif
>
>  	chan->name = kasprintf(GFP_KERNEL, "dma:%s", name);
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

