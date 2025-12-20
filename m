Return-Path: <dmaengine+bounces-7852-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2E0CD324A
	for <lists+dmaengine@lfdr.de>; Sat, 20 Dec 2025 16:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44F9E3011A46
	for <lists+dmaengine@lfdr.de>; Sat, 20 Dec 2025 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63F27935F;
	Sat, 20 Dec 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="S8dJbT9e"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011046.outbound.protection.outlook.com [40.107.74.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB922257E;
	Sat, 20 Dec 2025 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766244985; cv=fail; b=hJwcwLVX/t2I+sncg8AhF0Q53llK60RDXKuZoxScEkGCIY37DD4EeiwKqV5WDPR63aPT/XvcMjWjGvphaGzVwe6mp6Vn3acoXpFHRGimwR3vMTsfzQ6+kmcTbynL9AqdzZQc1yLos9A3AGsDVbFY9XfF+2spR4eKuxMvQzffT08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766244985; c=relaxed/simple;
	bh=UwUxgbGnNfOvtd8bFlr/TUzRoYSF5uQ9edzwcW16l6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OF85OG5A0O8u3WnYlmFazxjH7YucuDvZeX0KflUZ9ju/kj8UrslkXFh02hs+sLjCl2ZPflSuiT4U+Ie/pbpWpUjgxjAE9WerVGaXbcpTvwpXWI8aBPVhRZyBv64vShwCsqO4/atCPfjQIY9885lKVgZtVCg5ebELyXAbD6r5jhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=S8dJbT9e; arc=fail smtp.client-ip=40.107.74.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVkDnuUwXtPvYZdNWepr7M/6XejD+f9u3AaLijhFdKghSj7cSMPLEXSvtiFy/DmOybaVDadtFgiK4SGaxLFDA9ZsNFIfm4SCxlIWD1gCzlRK2iXMpkAv9f7Ief/GUJU7rCZ9xLBZlp2011Nnp9or6tebl9BTiyoMdxdbxBXVJguCrgfiM9b8rXHc5LwR7NhhVF7ud/+yaF10dw/M3/X/2MAmBy9TqSGp8/1l5LHJTE8/cElUKwpV5dPDOLImgQY09aTCM4XQfpmpX/WxxI0lNiMW08X/5TQV/5/xqvQyLxp2qEqNmJBbi9XVrJGo56OGHFQxCuFhe4v5XiVafEvbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMpmX0ANYILxv7DTpDWe0+IGVsuXh3a9lnqTB8NwUoE=;
 b=Kj/UoqOpmc9IMQG5sQ29bn9WjsRDMWGjeS0iy6Gq+juMz6L9ZkZhsMpfTYhD7eNMPfXhzW2e3vIfMR4GAMrnCwBDcMis/N1AvtghsN6bBlWoji90g2reggSe6cc2Qem3QFcBg4tzsZVtQq61GhBr8PJx4LPPQiwrX/bVJrFwamMWUpu93lWU5TJjvfmSJhzEFokXJR8b6eCLTokC9ot1bf/JBkkywZ51VrAzDULF63Wmp6pkUoMvzbhw5nE4gbeXG4Hc8xpGEJTCvUGbqSv4Der8Ahvs5AeSvlrCp50E2xGUB0QLlemIrWifASSHA6HRg6aX8NYembdKj44916zYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMpmX0ANYILxv7DTpDWe0+IGVsuXh3a9lnqTB8NwUoE=;
 b=S8dJbT9eaTCV7hidVkPIA1p5z+YQ6bUMr+6AROiv/FFPe8oWEPR/VeOIUhxiok3J2q54KslwlRsQDFiPLUeyz7bfB9TcybWEk+y02XNSZE9cNKGRWXpxWvlsT7MwK2HQvPlPj7KSUIfNfw0ARcgB6QOIF7bMll/KFErbwjEyfYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 15:36:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c%7]) with mapi id 15.20.9434.001; Sat, 20 Dec 2025
 15:36:19 +0000
Date: Sun, 21 Dec 2025 00:36:18 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, geert+renesas@glider.be, magnus.damm@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, jdmason@kudzu.us, 
	allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Basavaraj.Natikar@amd.com, 
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, logang@deltatee.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, utkarsh02t@gmail.com, 
	jbrunet@baylibre.com, dlemoal@kernel.org, arnd@arndb.de, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v3 03/35] PCI: dwc: ep: Support BAR subrange inbound
 mapping via address match iATU
Message-ID: <nhf3f2zaxjbzbyrmi54nytf7mqgoxjx5mk3mwaqj67d45n33tk@7hwh244msz45>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-4-den@valinux.co.jp>
 <aUVe7r0BkaF1YXrF@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUVe7r0BkaF1YXrF@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:405:4::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2742:EE_
X-MS-Office365-Filtering-Correlation-Id: b66aed64-ac42-4c24-28dd-08de3fdd858e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bPTEoCUs+5H9VaV4xFl1z86FWUuXikSvDJODPE57KJ+AN+52+epWfQEGMzpJ?=
 =?us-ascii?Q?Ci86uxNVUTTPBRellbJB0xL2+lE1PtLe/2r0hXwXPK8Y993+RTCt2h74cRNL?=
 =?us-ascii?Q?p0mbMPW36x3ozC2IVfxFwOVaSgWJNF6mUNBjkhRSnJ0d4/RgGgfvWIjNRC60?=
 =?us-ascii?Q?4D3y3OTLuxXOdTmXRiFsZ8O6D/l5RDClb5lBd7KAmCyZUJ8ptvj9F3gOxG5B?=
 =?us-ascii?Q?SSvnVe8fxnp/nWK0rCeJ2dIMcESMpIgSTVOBsBt5JbDJc5MtAvswhWXtsAda?=
 =?us-ascii?Q?Eny9ZMdkJ5lNkurZZpkNgyc3MfXVrODZ6dgbF+fJeOlSIu+zsgmWeEAaghkJ?=
 =?us-ascii?Q?LgD4oHx8ApHeKYapacv/PnJMAhfj8m3Aheu9xrJsiWY8JtWDejArIp+QxOkL?=
 =?us-ascii?Q?1BvE7RalrL9Q10lAYJzpQlxhiXZ80kVkonXFez91vo3/c015B6/P39lRnSP5?=
 =?us-ascii?Q?KyOMiX8Hxj7jkTfZU0NR6idwoq9QyUAZzgKG9Vu5Fr1E91n/GsQ0balj5pFi?=
 =?us-ascii?Q?Ldyn+OrAOLfv18+HezXqOKe+TuocRK2xoZxEMj/j6TRPx3azXVN8aGrv/tGO?=
 =?us-ascii?Q?1YM5f/FPW1bSaP+nzIyH7vw+oKEkV3fuBkt3Yn2HE9dGQYHsPOJxtYrDxUYo?=
 =?us-ascii?Q?YgtunLh2+Lig5VaaI/yCYuWj1TnoQYPmy4uGpVCgU+ZFX7TSglmE6f4gm0Ut?=
 =?us-ascii?Q?8335yJcwmIXhiO8DTACrIQ85U7xySn7rmyOSWOpOBDGbMMzLR1tj+rfysvkr?=
 =?us-ascii?Q?f1DY0oOKInwwlrTZ5eFqTvehLyYzaBjnz3NVc1xEtOjvRuk/K6zSAa9rvIHC?=
 =?us-ascii?Q?45sqpz4miR/2BsSbi93tkq3Gc4GrIzFmLSwAMTIsqf7gFmLK2c8iNsYYD0cB?=
 =?us-ascii?Q?aBNVyS7Zgj3q79lLbapXm/tKdmhx1XUeBI7jBhNEmYNqvtoEJQZW0Zx71w4v?=
 =?us-ascii?Q?XjjQ8lmBH8PRKE3FDQfvttICyuKgzxeVqzc3vnu3pzU96jxv36cV7GADoPEo?=
 =?us-ascii?Q?v8UJY9rfBk0lGBUJWn0FEDrOKKJZyuhWawdu1W9xySHWg+FWvv7mgwYwf+CT?=
 =?us-ascii?Q?cM8GTIDj2qHHpyQ2eSbEwTqwVO1gNuWhl8I7BIj2PVStGVkrEpgdPbgJPQvV?=
 =?us-ascii?Q?zuc4rapJEsy+JbarcA6dxmSnEbhnsg7nt4LKs6B9r1guThinrb3+Kd1WdVA/?=
 =?us-ascii?Q?vKftAjERWw8KlG9/EhXx3PlxF5/kOUap0Mj9KNp7y3tAFJ82YUq4Bx47ldhN?=
 =?us-ascii?Q?g4DlnwXpIVoU5WPNEdttlD7S5dLU4lUiL6EtNv86IK4TJEGOVhCOBlJg5Grh?=
 =?us-ascii?Q?/rltWpqZ7WqPW6/FvCpXjCyCgL1r/FwypXgF6o+pxd6U/Wk+BUtVgntsEyTv?=
 =?us-ascii?Q?QOTA2ow8vYmmlLPXHO/PXR+V0QlLAZQxnbkQJVYhnodHxIPmhzIh+UiXIlrU?=
 =?us-ascii?Q?NZFA5XPdYoSjiO1YPT/DmpQe4vK9FOOJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FRkyU6Xb/0AX9YOvcPV08oFdYG6A/PA+Y1iL4qXq8DAcqPrxHGBFdyFNw41J?=
 =?us-ascii?Q?aO616ahFMXh6EToNZCw5k7Ox6vtifDEdoG6vpsMypWxbuwvACfHUHYRUxEnV?=
 =?us-ascii?Q?j2isQChGeuvhvE2czr3tHqhSu57KALQiCQkvfM8vz4qLdCr5JJjtAAY+0XBJ?=
 =?us-ascii?Q?PHupg700d1viZw2sluCvqII2m2WXCHKJLaFvPDK742ytKa2q5MtgxT+ncVM3?=
 =?us-ascii?Q?3d7VAN3Kl728QQG1n2UzDcHYsUD9Kz1eJXB8aR9EJQK06azhaxvWa7PbCT1m?=
 =?us-ascii?Q?9hkY/1/s73aYZy/qLKwhD/WwzDAuiJ3reeBXwPnBvho8lmYUhuRf3ItBcTCB?=
 =?us-ascii?Q?pf2vyrng5g2gJihW/drzSlawOWCBSK4Ulj3L7cfwMgIuLNDQVM/gQQEPrqlQ?=
 =?us-ascii?Q?6X1Is5JZwWvRPGRqnqaeh92IlpL7VTtfzP5K+rw2AFec6pZ0DCMBq+8x/wC6?=
 =?us-ascii?Q?aKfTYWmwpLIXNTwJ9mXN8yqsob+fR8DKo3wQf1oGMujFR0vW5uDK06f65uun?=
 =?us-ascii?Q?oRKZrH4xo2NIcO8B8qWhfndKV4Ey1mbJTRSDqa4a1g9Y8SH+PI2Pl4VEX0J+?=
 =?us-ascii?Q?4atzmcPxepd0F4JJQ1dRP/KL3HDQVm46yHnGoLcp/tps8rw+CbwFBxoFjsda?=
 =?us-ascii?Q?tL6TbL4DV19huFopifN7uQXg1y7eGOd71+XfKYqzBXRr4nhn9BOE/ct66rnH?=
 =?us-ascii?Q?Zl7UARAPkzesW7mjm8QZPpOcs0jlkLfkGTTVrbannWP539/Ur2N0aolhEymZ?=
 =?us-ascii?Q?oUHKmWmx5CDMPjZ/dsXJttH72UW1cfzwhQsb40R4IV47EXEE+J7jGxEqDAiR?=
 =?us-ascii?Q?lrTP3IcgKMzQ2Bd2gPaUqXx3YtnjkovRarf/IN8xc0LkdB+W7wXeq74HWki5?=
 =?us-ascii?Q?l5jiM/JH5cKPq0CUeYtkHuhsdAJLlZSjV9RyXEM9qWQQkAyJmvaekPuREb4Y?=
 =?us-ascii?Q?ENt0m/W4SwVqr+xJ5L6akDojofFCMZNR4la4Q2lpVAx4+iGqX236H9tKThJv?=
 =?us-ascii?Q?hxRINEJ0CReRMSMjCQkHo9U/9sQAxFAPv01suyMAusGxxmYSxo5hGeY9b1w7?=
 =?us-ascii?Q?TFtWdj/lYTsiu/sZcjfh7w79MR5RR09T0qC8j/5JVp+6rhtsFiWrtqm6ZkFk?=
 =?us-ascii?Q?gO6BtNYzJxQ4QxPDCsS5nNi5r9C9P6MN/nmHEoAkj0de0vtx1zLVpZhXjeav?=
 =?us-ascii?Q?hYwI+5ZbHPl+Te+SDz5LCvEPtb1Xmkh8KWcpBVuiohqwEekkumAgZliAyfxW?=
 =?us-ascii?Q?Bhc+mbABExE3RDWfJaLA8hOVj1P3lNyAinYBmsiQ4i3j5vIAKfigMbW5UCoc?=
 =?us-ascii?Q?4DAmow2a6JuQBZ6jqaxg+7/w0IBJDAAWR0WE1puXKUppdX89VLK405qMEfgE?=
 =?us-ascii?Q?hQC7vcylllUHZAxkigRh4OXPgJUrKIEOyNVdX80izL0vlYbKUu5rqCzO4Lep?=
 =?us-ascii?Q?wbJlUV5iid7hLT4Avr12KTUmy8Hhjv7PyLkbMR/XmIVyU7e/3rLInx5vXunM?=
 =?us-ascii?Q?XqX0XZALuLaRU0E5v14SxJnBYwx9ac20NB1/SlOOgCjZLkZD9sFB/GAhlEoX?=
 =?us-ascii?Q?rOBXi0nWbUxHuWZuEUBOAtDhJtXHAXkRhpX99UemGQgXM85PwAU70sofDlDD?=
 =?us-ascii?Q?46PyBhH0idu6tHT9S1Nq8CMvIN/wzLmwXXTIDEmFwBRSlPF1U0JQgYfnnYTn?=
 =?us-ascii?Q?j4z5qrn7G38/bDhp+7QweRku0pbfOHYcRMmwk0bssRRyeqVRStIfe1wzdwz8?=
 =?us-ascii?Q?hwExlGe54vZ3A2W5qWX3Ab0REUF+RhuiX7iVBSBWHZ+xZEPRk+wa?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b66aed64-ac42-4c24-28dd-08de3fdd858e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 15:36:19.4718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBS+q3ximacqJ6EeE3r40OSlbgt1y/Y5La8EoIpVbZVFPhsp4sU33qjKvoVh46VWdNmq5MesU4ooR4jeiOWyCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2742

On Fri, Dec 19, 2025 at 09:19:26AM -0500, Frank Li wrote:
> On Thu, Dec 18, 2025 at 12:15:37AM +0900, Koichiro Den wrote:
> > Extend dw_pcie_ep_set_bar() to support Address Match Mode IB iATU
> > with the new 'submap' field in pci_epf_bar.
> >
> > The existing dw_pcie_ep_inbound_atu(), which is for BAR match mode, is
> > renamed to dw_pcie_ep_ib_atu_bar() and the new dw_pcie_ep_ib_atu_addr()
> > is introduced, which is for Address match mode.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 197 ++++++++++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
> >  drivers/pci/endpoint/pci-epc-core.c           |   2 +-
> >  include/linux/pci-epf.h                       |  27 +++
> >  4 files changed, 215 insertions(+), 13 deletions(-)
> >
> ...
> >
> >  #define to_pci_epf_driver(drv) container_of_const((drv), struct pci_epf_driver, driver)
> >
> > +/**
> > + * struct pci_epf_bar_submap - represents a BAR subrange for inbound mapping
> > + * @phys_addr: physical address that should be mapped to the BAR subrange
> > + * @size: the size of the subrange to be mapped
> > + * @offset: The byte offset from the BAR base
> > + * @mapped: Set to true if already mapped
> > + *
> > + * When @use_submap is set in struct pci_epf_bar, an EPF driver may describe
> > + * multiple independent mappings within a single BAR. An EPC driver can use
> > + * these descriptors to set up the required address translation (e.g. multiple
> > + * inbound iATU regions) without requiring the whole BAR to be mapped at once.
> > + */
> > +struct pci_epf_bar_submap {
> > +	dma_addr_t	phys_addr;
> > +	size_t		size;
> > +	size_t		offset;
> > +	bool		mapped;
> 
> Can we move dw_pcie_ib_map's neccessary information to here, so needn't
> addition list to map it? such as atu_index.  if atu_index assign, which
> should means mapped.

The 'mapped' field in pci_epf_bar_submap is actually a leftover from an
early draft. I'll drop it, sorry for the confusion.

I would still prefer to keep the atu index in a private structure (ie.
dw_pcie_ib_map). pci_epf_bar_submap is part of the API and I think should
remain a declarative description of the requested sub-range mappings,
without exposing driver-internal state back to the caller.

> 
> > +};
> > +
> >  /**
> >   * struct pci_epf_bar - represents the BAR of EPF device
> >   * @phys_addr: physical address that should be mapped to the BAR
> > @@ -119,6 +138,9 @@ struct pci_epf_driver {
> >   *            requirement
> >   * @barno: BAR number
> >   * @flags: flags that are set for the BAR
> > + * @use_submap: set true to request subrange mappings within this BAR
> > + * @num_submap: number of entries in @submap
> > + * @submap: array of subrange descriptors allocated by the caller
> >   */
> >  struct pci_epf_bar {
> >  	dma_addr_t	phys_addr;
> > @@ -127,6 +149,11 @@ struct pci_epf_bar {
> >  	size_t		mem_size;
> >  	enum pci_barno	barno;
> >  	int		flags;
> > +
> > +	/* Optional sub-range mapping */
> > +	bool		use_submap;
> > +	int		num_submap;
> 
> Can we use num_submap != 0 means request subrange?

Some existing pci_epc_set_bar() callers seem to use a two-stage sequence,
ie. first they only initialize the BAR (with phys_addr == 0), and later
they program the actual BAR-match (re-)mapping (with phys_addr != 0).

If we used only num_submap != 0 as the discriminator, Address Match mode
initialization (num_submap == 0) would be indistinguishable from the
existing BAR-match initialization, and we could end up programming a
meaningless BAR-match mapping with phys_addr == 0. That's why I added an
explicit 'use_submap' flag in addition to 'num_submap'.

Koichiro

> 
> Frank
> > +	struct pci_epf_bar_submap	*submap;
> >  };
> >
> >  /**
> > --
> > 2.51.0
> >

