Return-Path: <dmaengine+bounces-8307-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF0D334B9
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 16:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8293B3027CD8
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D86133A9E4;
	Fri, 16 Jan 2026 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nm1vkJAJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305933A9EB;
	Fri, 16 Jan 2026 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578190; cv=fail; b=k+uS6eN95LPbQSZpgmH4NaiRqqOZr19Kh6HB4q19EfG+SVgQq7/zRrTH/F2Ev5JUSDSm5DHNYmefrEj0n/DZJn/X250ZALnKQWuwMRMpI8Rkl+7nYmrgbjAUuCFnIkR+B/uCwb6dzdsNgR6p45QSN5JjWd268cDMVEMiHYBBjrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578190; c=relaxed/simple;
	bh=mPrqMS90Wcw0EWko7nohIviWzlw/6c3DjGcEcJf8MWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CY7um2vQDAywTp7SsJE8sO/wFIrg8qOF09PI8h0QLlQK12vBNU1AXsCy5oiYzJeXkcIbXCvxNQPrpgR4BC8Aj5cXGPPhYhYuzAuXzofUtTEuJEvWf72sb/MfBkk8jPSSTbQy7nf5pCCqCQ13Vfjnv8Q6oF6Nl9cyl0Y5NQC3d0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nm1vkJAJ; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuKXvYzjZu2JtH4nSNfmU9ZpxBOsLY05slrQlT4T/qSTsTbWXKoxqEmp8oXw5dBY/jB8xnceJtHI0MT6TOaH/Ug1/Q1BA8BLpIGBz/U+p0CDP+at8Gdoy/pCLKhLSmSXZ7gAQHb6kyeXJ9P31ERqC/0u65CU+XXSlkp7DO+n9+UBs4IX+hYZQAxo+96qmNKJTy0iUxqyU1FJjuRmRc7CQKMwwpAiVIViQAKm2vxJcKxmkrAAKAUj6YTQWyjGFODiMy0QbiN/rWVVV5PnKkqQOUF60dOkgtrZuTERmp7gO02me7gfwow4YzIxswZ270BhN2c0P3zWmugToIc6Z0A9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuLYBJ4NXhVskwDDL2M+S5I33n7q/vpYfTCFM5D05ZY=;
 b=ETE+x8DbhwTCUJpr2vG7Og1howzvmI4Lwgz2lK+lBxIoebPoIfu3lASVxlUseL+LUpHByqc6HWiT8Hl+WvO0gZCTckJi72Xrgc8gbrSnIPRHdL6n17CbDrYWUaLKUtOA7SOM11oJTeCoOV2s4uDYbV8RqRSuNPolp2SJ+9p/HFyQLtXCzU8G3tG9L+629IY/psMbOitBCGpwoSsJO8bm5CN4s36+bHJ8fsHB8mXrkR1x/imz91BW0y9TnRY4UABIGTgrIYvw1XwmmHv2KAkcTLGc3lyJTrxGunlvcCQpsumkB5XX8was2k3/cy6eAZwjMdP1+XJgjsSos3VPJrF4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuLYBJ4NXhVskwDDL2M+S5I33n7q/vpYfTCFM5D05ZY=;
 b=Nm1vkJAJdPHNv+WsqpYJeTuUQkvgQVepNP0/UPQhiRV1s3Nn5RrAsNmkW0Ehqj1kDx08MjsyQpRRBys7l5yLazQZiuSOs5ZPmjEv1tqlUD8ce+DbNgDSja77ViOQf2QWZbpqmEEXiT/aZVo4C/CA0I3coTf3ORSR0QOClWrlIHWJWxyNtyRUN8eyfUsy67nT++OFlkYbT8EGNgJNqiW66Z69Aq/bZ179qlVf6wWLWyaFSCWjyKYlHFYHHfIC78kL/O+BwjSCWJUNBWl/MelcHNF/TLR16o7YxLjA3S5AveOnfhZSbPD1KcWl60HqLdfimuBcn0NEOdQ9ieerqTPwxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB10378.eurprd04.prod.outlook.com (2603:10a6:150:1d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 15:43:03 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 15:43:03 +0000
Date: Fri, 16 Jan 2026 10:42:54 -0500
From: Frank Li <Frank.li@nxp.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>,
	"Anton D . Stavinskii" <stavinsky@gmail.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2 3/3] riscv: dts: sophgo: cv180x: Allow the DMA
 multiplexer to set channel number for DMA controller
Message-ID: <aWpcfqHDFaq8Lsv5@lizhi-Precision-Tower-5810>
References: <20251214224601.598358-1-inochiama@gmail.com>
 <20251214224601.598358-4-inochiama@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214224601.598358-4-inochiama@gmail.com>
X-ClientProxiedBy: PH0PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:510:e::18) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB10378:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd746f1-5184-434b-e530-08de5515efb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/eJnA+lYwqOZcDcg48+3DEK+a3pPJRAfi6hHyl1r/r9L5Df/9P1+jAYLpyR?=
 =?us-ascii?Q?flCe/GH45nJn7EsLAJ9r74jEhz3jKXj5FBbPrgS+p8y9e2wX/YWFxr453IbP?=
 =?us-ascii?Q?a1J4i9wE2ojJpCOXbrxbVG28vXJC2WfQREIGvjn643Sw65OIne6Jsf6nU7GI?=
 =?us-ascii?Q?Byb/tKGfetnpToP55g1LC5NtWsAiSvMqFXa4zZfMlMXNwsIkpYma78RRmaGB?=
 =?us-ascii?Q?QuYzQuLLz2mgn+G/L+d+egeYFTAaCSW/GWQrIYHEltUeaubrK6C9QmQZoDEV?=
 =?us-ascii?Q?EPFitDBBCvD1XsCnA9kjCZF+YId50xAHU7jETiIqHn6qdcAxuRK9rqYeWB9C?=
 =?us-ascii?Q?WEc9uqHhOetrulf874fwG1qK9t/eFpkFN59wMIZwv05TccUH1BbQkEL3Zpin?=
 =?us-ascii?Q?EnUDFeDFeHDZQux12StSLsVM+xYU+yFMl3wxfbwsTfQr2uFFkFBSR19N5spF?=
 =?us-ascii?Q?rkz6bAd7PMFQ6zSOKzilYxr5RGxUQ3YRZmhQzgrVMYiAzWzABkI8VFuqw5Ul?=
 =?us-ascii?Q?CEtotEhJglTF1NXSAj5icAy5TR5w3PNEViO3oE8W1b/V3f4u7SDSdSJ8UETJ?=
 =?us-ascii?Q?JWiMzAeVkM3hpyu9sHcYuQX//oaJCtKvMqNVDNki6yoT5khm53YUOHrGy42O?=
 =?us-ascii?Q?HdB5mYxVnn+JfyUKap8zlbpIYk0rQtbFDRcUztpjeJhX1AhvyBw0t9EHXW8M?=
 =?us-ascii?Q?84KzLWTi9rKdFXKTVC2U5mIyCt20c9dksRhrNDi4t0/Jc8tJJBdK33rurlsW?=
 =?us-ascii?Q?npXthZcjnf7WdqUYhfiOBFz9qlLbagM7j6vVjfD46go3LA8zg6CaZbSi30m4?=
 =?us-ascii?Q?HBwCZxiwwik38ADRoHjIz2F54rdqvlWwEPNmJUlG2zOkUXMjixulEHJcGflt?=
 =?us-ascii?Q?Jeb08y85ipjVQyaPzMZF5CX5O/n7GxpF1b3qGrJkaVIzEwIbI09rvJNoljGv?=
 =?us-ascii?Q?v+aXYzwJqfIluJcAhRdwVxkwjvsXIcw/krizIf0BY1PY3DV+MrYtdu3b0Qcg?=
 =?us-ascii?Q?gCOEo8t1/SwCpdabMeIt/XSroy0TG3Uwq01uH+9IWK7HItXIdrAgK7vgw8ld?=
 =?us-ascii?Q?SgRTn9H6SaYsbNb+TAFc1elEPHNr6DntoULJE/GZxrar7Wz2WjXHIW+CnCEF?=
 =?us-ascii?Q?hc1amXT0kAr8tprd7pXDvm3Zh8J9EoxfUsuvy6Akd5N48vBRdy76ImLwovir?=
 =?us-ascii?Q?l7JwIeY2KzaQuLL6xj7SnpbXsi771XTmF6ea8NDizQERj4HBqIe69A8xUgBX?=
 =?us-ascii?Q?Bbe2ST/G6/YSbDyMIss40MJy+pCoigxbZ2pwy2e9rfI9cv+j+zG+9ZlaCV6f?=
 =?us-ascii?Q?TXEySCW+Ipg52P0yNLdXtK52pEdI7ldBxJIfOVVclsB51//R8BrLWloughlX?=
 =?us-ascii?Q?Uw1c4JKTbZ5uATrLYeNh4LWM/EEmQpTzHYxXl86o0HIWLbSDKjW9rMh8Sf9s?=
 =?us-ascii?Q?Xr+HU7+06d2b2Q2uRUOhp2hIq2ol5W2F56HaMGcHXWJiEo/1Bu5mhwW9EXzb?=
 =?us-ascii?Q?u1FgOJhmiLnTnq6dDlR+OnshOXsBrUqmYm70mdEcj6lDVEtx0yPmnmOsc2vq?=
 =?us-ascii?Q?K9KXhgW4rKZ3csd0r2Y8DVKqYgTcYieIcOjrESdVNcP82vh7YEIL4FLWo1ve?=
 =?us-ascii?Q?HHlWs+DCva/JLFUAzjdb54c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J0EwBKHgkbf3wLUDSOENmWJKYHPoEM1KGtrw2+Ium6YiXebyyizkNdCzLHf3?=
 =?us-ascii?Q?m6g6UgVs29qW0epXnH6InwcwfSYmnpX+mVmd1yAA0wnc3Rrb55javQ7Qk3f5?=
 =?us-ascii?Q?8sBDuB43UcTAUQIVQGbKvwmAEY3pWjN0o+0hs1Nu78NcsNmTBhlqlRz+tW1z?=
 =?us-ascii?Q?w2TrTxZzTLNHl9RaIDwQz7/XhNcbMi5ehcKHHlfTgf7GCI3xsaT0+sXlsOEt?=
 =?us-ascii?Q?kHEfKufSqj2mToH8BbfVMnyMULNS7zodm84550sEWqclyIP7+j9gso2fSh4H?=
 =?us-ascii?Q?qm7sZzo6PVpTEpYiMGfGcP8KbjFwp7HrkSoWGXShLlE3fUdjkh1sQ9/Tmgl0?=
 =?us-ascii?Q?wqolpLL1XIjs8JBqDoJPkRS2X3A9Trlou/MvcbKw0xDOQjfqwHnbZAiMDmS2?=
 =?us-ascii?Q?vT7xGNLCJOiUwoKZxnq1DE3qpz/8yjmVBcnuq4ZwIQfAbiU9jJXWImhuzb91?=
 =?us-ascii?Q?fviDAoIkBlpUVmvqka/UOf2EdLfqNfz5aak13mVDWy+A7gENFrRc4pJT877+?=
 =?us-ascii?Q?GZ2AFXUcXjC03EtHzU/1jiXaeDtngOXUrjjAtMs6FUGygHDZTdlWA83VsjRc?=
 =?us-ascii?Q?wsjE/CkZ26yLE89zWIuV1j23vi2pOx+VsIirHeq4m3LuxQVJiq+R1rjPatYf?=
 =?us-ascii?Q?BNRQ9bitsFkd9L9cl0Xq9PCyoqX5ueT25CD3Rp5/B6leK099P1y8acgnfap0?=
 =?us-ascii?Q?/gfFsiVEY4p1/qNlIv5NB0XOfdXwzeJxK1y2msnYoTqhyLxEG1TBOzyxIBMv?=
 =?us-ascii?Q?u4bA8HC0+nnPBgUDSGzyNmQTQ78PyZ4Ug7yzMA3ENbVEPuztVcrgfJaLswS0?=
 =?us-ascii?Q?rj/1r6og1H6ZAzqOoG18gSRABEHp1lYqi1ogx5vGPRDy8ECfaLP1cn/l1VvA?=
 =?us-ascii?Q?qkCWGyCa6DyvQUNkdRfhdEqk8Ki+VswuwfgALibh4MO8wXZtBJdXlVRTf0ZE?=
 =?us-ascii?Q?UJ+gyuEyy/7KtBsoiAqMf1UWOq2NGmynl/ktyPMPFA+0u/SQ8ho29EAuGbSt?=
 =?us-ascii?Q?0hi7Tv3bwh1O0IVlf2eO4vZsdP0bStCBOBoXjpvzMzjXcUDfd/QTSj2Jiq2s?=
 =?us-ascii?Q?+PddN7tXHnzS4FPHSNspqgz0qmjMAIClyI9CsyDtJ95JgedSIN3S4f+ZVWzw?=
 =?us-ascii?Q?vF+XKoNR5M5vkBNBhCB6HJEM0pko9oNguFIJypscaCtsLemmNuwSzH9UE7WO?=
 =?us-ascii?Q?A+qZehfmBKqjFG+rvYN0dnH5Gvrx+z95VI4vn2xF6AGkj4DNR29nYd6MlzAp?=
 =?us-ascii?Q?mg7XRCDqybrsxq4fCR80l5yYMrEkZq4ZHd7OnjmvCmRS4rNhNbGaXfDMJVms?=
 =?us-ascii?Q?w6vpmQaBK6pEmxgYsrwnUQiDeiUVnupFcQ0i7hM5cnxQVcIdipH8IKxtb/2c?=
 =?us-ascii?Q?uuNzxH7KfBqj43HMdfPfze4J9B6sMDuohg/KBjkmDgbnJnl00KdzZQP4qtKR?=
 =?us-ascii?Q?abL4EP5LhtYtJlA7N29/NoIxaL2VWHUycziYqNvOQth86Q8WDKa9SkRMsg3S?=
 =?us-ascii?Q?rUZT7IALAJHuei6UCKLpxl1TRFqRsmHthVVBivO1XMj0nqKK+ooyL+c4CIsb?=
 =?us-ascii?Q?e4Pp6O3DPgaDfXYykGs3jY5emYAxe8C6eZ1WV3xyCj26Pipshmq1qDKR1h6j?=
 =?us-ascii?Q?+oB+3VZQId+/+xmQCucojeBNXcQfP4R1PinXkhtdvXq455+S5ZqQN85aAzLs?=
 =?us-ascii?Q?3b2g21yrKbnPrJ2q9PaO9yGUcaNc84Z2DKZbTukxnHID3upvZitT/cOaNGYR?=
 =?us-ascii?Q?ivoYl9An8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd746f1-5184-434b-e530-08de5515efb6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 15:43:03.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmHnHOomJySm6hiE85tOJSpzUi/f4G+aMO6wLE85pkKLoNUgLms/RI5tCkmickg3cGIzQcDzRY7DppG+YhYFvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10378

On Mon, Dec 15, 2025 at 06:46:00AM +0800, Inochi Amaoto wrote:
> Change the DMA controller compatible to the sophgo,cv1800b-axi-dma,
> which supports setting DMA channel number in DMA phandle args.


Does it need update DMA comsumer?

Frank
>
> Fixes: 514951a81a5e ("riscv: dts: sophgo: cv18xx: add DMA controller")
> Reported-by: Anton D. Stavinskii <stavinsky@gmail.com>
> Closes: https://github.com/sophgo/linux/issues/9
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv180x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> index 1b2b1969a648..e1b515b46466 100644
> --- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> @@ -417,7 +417,7 @@ sdhci1: mmc@4320000 {
>  		};
>
>  		dmac: dma-controller@4330000 {
> -			compatible = "snps,axi-dma-1.01a";
> +			compatible = "sophgo,cv1800b-axi-dma";
>  			reg = <0x04330000 0x1000>;
>  			interrupts = <SOC_PERIPHERAL_IRQ(13) IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clk CLK_SDMA_AXI>, <&clk CLK_SDMA_AXI>;
> --
> 2.52.0
>

