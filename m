Return-Path: <dmaengine+bounces-7479-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100EEC9E494
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 09:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD42C3A2B89
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 08:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD722C21EB;
	Wed,  3 Dec 2025 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="YPYO+GSQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011003.outbound.protection.outlook.com [52.101.125.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877F2D4B71;
	Wed,  3 Dec 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764751412; cv=fail; b=Ov8yK/K2xXbX/jYwUx97Tv+jwZ1RO9RcN+SCb5CE/FghqOeIbqUz9LovVi7DsuYNXNa1nbB2ZGxF6iF1Vxzc2z5DUTytPovD8GTOBwh8ox0B2H1CUrlq18ANLJTK7Y2B8JG9eAom4LRZeknP2H6dUQDpTB/NDoeRlULDebP5WZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764751412; c=relaxed/simple;
	bh=Tp32C4naFSj4J9qOhNTe1QSMIVwmRft6h+nBiWThMD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G7InBsxeimn4fpI1bH1BxQWIe2A8jjJTaTxNC2W8ZHiozzB0foEVTLgD1SroneGkrWhMK7vQmlaMBMgxPoNS+t2wY870jZOFnpSg5pLMv5KEtWj+/z+lAx1PeyUGDNN9gebfuK0OSbhaiXuCfAMqgyf7+d2Nj28VWtxlR/raeNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=YPYO+GSQ; arc=fail smtp.client-ip=52.101.125.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJyRr0zJaahK8kdsBPF7DN1x8pfjFvbi8rfNxzYtfBMhmK1DeMIYVxDCAMVZ1tFfyZmQyP792k53rZfpsh1ha334+D2tTiymoRs6SsWFJ1mtXwtzIRslIIGvvqIbA6bYGvYmppNLyGAslDtN7PjeMk8K4RjcQQmtC/6MTozpxy8afM7NbFXjcFtsLjPvHESZmiH4Txxms3fitixGPkqm7C5h36w47eYMiRVSTuWnSWp/eSLrf8E6o3paOJyDfSiqY8Ik5jQ9JKj76aH6Fxx1Y3gYO0yft3turq8LyDNc+FDodoUsqWG735wV29iksDqyr53JShyoWzZ7vDYwLzALog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7HzYiwDdkiNYweqzWSUtY1F6MJHOxdehA2eniAhPMQ=;
 b=Hy+pluilt8HkVHNH3ZalhJgH1dpMm6vTjO/xB94L54xNk0bgEVMNQuA2YT/XCjR+nO9Ab/AypTu9zImeGHMg62RiDX2p4s81Sl/W2ACDVYwMxTxj85DDpIY6Rfjrpwjr3yk7f79O81E83duesewO816kxCyUtae7lvmKvji7rtQ9i8GIneQ9CQR08JuPnKhEAUo/2P80FmN4duF2tYaQd8CQGbuw/TerKgjzGP7J+B5SiJDRYWD9ZXY7tjjUvkAhPxCoVDjL9CB/dbNdcz4XtkWs2a5B8bxwwkai5E46c71dnlGZGPUrkQbynrmgRDaqFHT+DTOT4UY2TLiWVXEnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7HzYiwDdkiNYweqzWSUtY1F6MJHOxdehA2eniAhPMQ=;
 b=YPYO+GSQ8yWt/cn2nrCcfTEv/TsudvtIl9jmds1P1ESJrAjMCezfxSxdzKVDh0HNZJ3ml+BEJM8GtW5OWxEigSvgSua0PZZUAMKEp8YZrWy/y9xQnNGUJ3EVKaD/mIx3b13wRgSNV/4wHVGWFdhQ8R1jc2xkpgpDHHfbWNOT9s4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYWP286MB3445.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:393::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 08:43:25 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 08:43:25 +0000
Date: Wed, 3 Dec 2025 17:43:24 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 00/27] NTB transport backed by remote DW eDMA
Message-ID: <lcd4tdtioldne3ixae5qdxqfj2tf47ox5m5423gl6nmhefpwyy@t5nkhl6n5pg4>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <aS4QkYn+aKphlRFm@lizhi-Precision-Tower-5810>
 <hp4shyyqwjddo54vac6gtau44qyshqw3ez5cqswtu4qhgg3ji3@6bi3rlnbqfz6>
 <aS8Ou7YacTs2yLqk@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS8Ou7YacTs2yLqk@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYWP286MB3445:EE_
X-MS-Office365-Filtering-Correlation-Id: d575ab83-e881-4b9d-cd9c-08de324805fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+Tk//UCV96imvsBD5LfdgTHWYbfkt1YQparUtkcoIEesqyw7dIJDE95Ve/r?=
 =?us-ascii?Q?paCLXVi+5gRjumML1ZdQ/8e6bxq7OyUjZ77xbzN0UPzI5wllKdL4spIMm5Gk?=
 =?us-ascii?Q?A8H1gAaT/7/2uD2ekRnWFqLhqeHpXLS4sy21Hx9+5moGzdDakY1i7YKYZm/0?=
 =?us-ascii?Q?kTBMoSGH+7OVqovfi8LK1/kVC3BnVeCya54fZdYWzOpwW7i/JBbPsvWYzYov?=
 =?us-ascii?Q?wQjlJqCmsG827NanPI4gkPMnZl/dx2JK6MzZbEZQhkeLRUsxq7NcE/uzaA0V?=
 =?us-ascii?Q?zMT/oj9y7OgshepXfLVMwNyp5Md1pqfHq/pqMsm19FVFxdP1PE3uQP8S7Wcy?=
 =?us-ascii?Q?mWFU0NTgwcVAlQMzmW5EDfgeGIjK3q9HGMj35k2BMR2dR+hGmVA6haXrUmaH?=
 =?us-ascii?Q?owR3zVSFgbefELO6g8BUm2SnnRRY/EuqbUKskTCHpgQ4URkX5tulCKYDC179?=
 =?us-ascii?Q?z/gDt4eoVWXPIc7DJb5sJdOrP6Z2GM/ZgoVZL4LwimeBLPcJgkOa3mQ780HQ?=
 =?us-ascii?Q?+xlM4I/CNKRq3i1GYbHh1RlU2d+J2ZladiEKoDwAND8iRArECFG/XcGdR1bc?=
 =?us-ascii?Q?GPeJH1SuSD2kWwr+ewmkOXkBQa6e1DwGgpfw+he9zYr4gaEtlG1n/LsjKnvm?=
 =?us-ascii?Q?Xg2LcATaajqOJfhtAy7Ff7HYsipyt1oE/xEBlbYLzb++i/pMPuoSGL+KrlhN?=
 =?us-ascii?Q?lGEvm9a4s4jY6q6wnr1Z0JU3TlXiz+nqiXC8+4RYf3QirfO9njjw1GhYpvSP?=
 =?us-ascii?Q?NLyHDEE/1lBtlJMOZbaBLppotOZMcA0ionzF+lf7zMXWWKdZWHP6XPUURGU/?=
 =?us-ascii?Q?nHrRUkDkH01ch8P4krDBQ26T/pqZzXt0gJ7fwsBm3DSYHYZTT8Y7Lbiutuvt?=
 =?us-ascii?Q?rnX9kp8Z+kyREBQrho/FWulZj5SSz+CH+XimvxzQ+iwc12K/j8Y3/z142nn9?=
 =?us-ascii?Q?NwAZiM2xHMEkYBQG8oFq1KQQxC4xiyBnSq/Sv/lkCXpyuZemR4dCLruOC9Pe?=
 =?us-ascii?Q?lbnSFXzhd+a7xavVD4C2jOpaFgqNzFLjkSGMyei9Xdd4xk7UdK8vgjNjsfmL?=
 =?us-ascii?Q?zjQycRMG4uCj5K44Dyxb7AL/2/UH4qxmxofnv2f5py7ZvYX34hmLFlBcvISb?=
 =?us-ascii?Q?VK8MpQ4SDo24IRnCyKbjOTZZ4hRvRcdVYZdFRorFNzTuZ7k9u/GKtRd95/0w?=
 =?us-ascii?Q?Kuax3hrD9JVkCPnPnjFaQUElQZNS7qUuPOu5K2y97Ialk60xrInd/xEYAhQb?=
 =?us-ascii?Q?mzBA1J2OFKi3ZtWUnVfCQYwD6Bq5SCvUiTtlqISCLRrqcgy3ENbdHPeUzbGe?=
 =?us-ascii?Q?FNvT+j7iEL7JsUMiTCLyu74gIoXQj4XWUiiRebRbg/XmUWQ2lfcb+Y5oJtDR?=
 =?us-ascii?Q?o/KoPtxQPB/nb7D1WA6aPsyyVolUipI2yfYexfhPXGpMkt+5XHMHvEy04aqW?=
 =?us-ascii?Q?AATctL/4gKUxbrzlrMilnHW2YwJPctWbQjQusfyWP+q5BYQP0BLjkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yntbMUK049O0v0ZzBKWKPCKyBQy4yDl/8QHr1vDb16NsulAI795a0mgIJB55?=
 =?us-ascii?Q?T6DEoUtnhZ9mLNKOM4qQ/AOkfe8JzZGg3n3GAmb1IsvcLG1TwW0lKbKSeiXC?=
 =?us-ascii?Q?SkzW1y3w75bEogwvrb1qe0peavcOG2cf91P0GD8su3xb3Ldm3VdJ8itln16x?=
 =?us-ascii?Q?OoVTPenb9LXMXlubA9Xp9/tU2M97FSrevokbbtUnfYtxHz7c3W4pLq8e5iOc?=
 =?us-ascii?Q?4FekS31q98NAAe2UMXTr7RANljzv3pK8FFW0yz3NWDA7U4i10e8bHT1GmeMe?=
 =?us-ascii?Q?mO5U729sbOEC1XSQ+BF8biVu8PnuzgnRxJRPfFlsoeb5C3oI2Q7ynjkJ5d1k?=
 =?us-ascii?Q?kO3RX1SYX3x6mxdFkjT/3KQtrRhKOX10saBzEYdbC0ojn9bmFF3nOdJ+WElJ?=
 =?us-ascii?Q?3HKSc0cRvqdSrmohIMAX0PXBVUs5s6pTlL0oqy7x+TkUcUm3+kzXkUdbeGtu?=
 =?us-ascii?Q?0wgkexke5SpUl/OBaKTqN/EsTDVRKIT1DmzSEScifcK6UCmWp0/vs/ZIGYVu?=
 =?us-ascii?Q?+mnhAYfAYurY6adXAidPuLfHiDKMp1ZnB8+Tr1SY29/YfxuPisMPsNnyWTDG?=
 =?us-ascii?Q?OLDPhgL/OQktYlAyG61zq22BXpENuZIy1mZ5RlzFuctBaq8yQSmEifCX3r1D?=
 =?us-ascii?Q?+ZcpxV8URgwAOPPZe1v1+nS5XiS2ZzI9eHDIhaddPPa4DAwwEawOlkfbhySl?=
 =?us-ascii?Q?0SeQUlHr2YJe2JmX5kFBd1pF6BHbH6VtcqtS5HN7EknLp4E8L+Lf7PiNTrEQ?=
 =?us-ascii?Q?Y+VoHoSzRNmuG38hibSs/uZvFGlxKAXC4T0mQs7a6zB/kImxKj54SnrXXTqk?=
 =?us-ascii?Q?C5uZz4rD4qKab8YLzeB774660NY1lE4MK1NH44k9QXSW+smBI2QFQGhf2361?=
 =?us-ascii?Q?b+VBCiPjbctxwp3t+q6J9huIHHjGqo/JzrjS5nTIKN8+ucuBeEyIyEpvBGaq?=
 =?us-ascii?Q?UXK20rzKJKSIk3MB1JXfEIvyevOqLFjQLsdaH3buOxQUkZawVQtk6nc5q2Ta?=
 =?us-ascii?Q?GqbiinvRHSJDM6ux0ahAftX9icoKc9Mg6XgdEuWrvLKNhpJP0vOYpho3Byor?=
 =?us-ascii?Q?D20w+izlF39DncM0cJgo0c0B2f+YpX46hnLtmVgDpTjoFpFA+6b/+TK/WlSe?=
 =?us-ascii?Q?iuZ0FFC0eAx8atHo1ayrGMl7uTp/qW2aFeO3y3yRU8xdNYiWBytNOZ4M0c0u?=
 =?us-ascii?Q?/WuX2omxi9/PiCASY0IkLteZ8LMzF8GipxD8G9wC9mpv9vtVB4CZimq0u5Hl?=
 =?us-ascii?Q?tHhnDjnIr0HBwH8fg2MuEha16j95mJaI1wEy/mZQk8IxF5GtLZWQkJa3V6Sk?=
 =?us-ascii?Q?7mqXGIAHBBxsACEhX/ZKoZDvR/uUmlcwZQkMeQMyvrfozO0yk1biblGruZMv?=
 =?us-ascii?Q?sW4XLrDgU29FuoYHvs/4fQ3ZqXZa3RE+jAJAw78H9l9bqmeyXQNmATd0tnln?=
 =?us-ascii?Q?Ajfjj/xYA/Dv01/5USwriAXKiBauFvcVu6k/p+KgY/3jWHn3bXzg6umczNxs?=
 =?us-ascii?Q?iObrwYjetgAerF4e0/99aj3vRdNBbqJlvQ7SzG3ilevSrPuGaCrXX1vfU/VW?=
 =?us-ascii?Q?4NpfnoNHDyaVzU/ZrE4/AdBIva8SbPdw9Y0RFKmLc/sX1I22tNCuEnnfh6Th?=
 =?us-ascii?Q?JVwZ3rNuQ3LPvvWYnwN2LVg=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d575ab83-e881-4b9d-cd9c-08de324805fb
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 08:43:25.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/pt6zV2af4QzUxLw1X4Yhed/8rEFq6Mb+yJ5oMOyeQfU8o5iXQJBFX6VJdtdxtCAjz/uIIO86dTBoEhwJE6EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3445

On Tue, Dec 02, 2025 at 11:07:23AM -0500, Frank Li wrote:
> On Tue, Dec 02, 2025 at 03:20:01PM +0900, Koichiro Den wrote:
> > On Mon, Dec 01, 2025 at 05:02:57PM -0500, Frank Li wrote:
> > > On Sun, Nov 30, 2025 at 01:03:38AM +0900, Koichiro Den wrote:
> > > > Hi,
> > > >
> > > > This is RFC v2 of the NTB/PCI series for Renesas R-Car S4. The ultimate
> > > > goal is unchanged, i.e. to improve performance between RC and EP
> > > > (with vNTB) over ntb_transport, but the approach has changed drastically.
> > > > Based on the feedback from Frank Li in the v1 thread, in particular:
> > > > https://lore.kernel.org/all/aQEsip3TsPn4LJY9@lizhi-Precision-Tower-5810/
> > > > this RFC v2 instead builds an NTB transport backed by remote eDMA
> > > > architecture and reshapes the series around it. The RC->EP interruption
> > > > is now achieved using a dedicated eDMA read channel, so the somewhat
> > > > "hack"-ish approach in RFC v1 is no longer needed.
> > > >
> > > > Compared to RFC v1, this v2 series enables NTB transport backed by
> > > > remote DW eDMA, so the current ntb_transport handling of Memory Window
> > > > is no longer needed, and direct DMA transfers between EP and RC are
> > > > used.
> > > >
> > > > I realize this is quite a large series. Sorry for the volume, but for
> > > > the RFC stage I believe presenting the full picture in a single set
> > > > helps with reviewing the overall architecture. Once the direction is
> > > > agreed, I will respin it split by subsystem and topic.
> > > >
> > > >
> > > ...
> > > >
> > > > - Before this change:
> > > >
> > > >   * ping
> > > >     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=12.3 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=6.58 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=1.26 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=7.43 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.39 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=7.38 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=1.42 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=7.41 ms
> > > >
> > > >   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 2`)
> > > >     [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
> > > >     [  5]   0.00-10.01  sec   344 MBytes   288 Mbits/sec  3.483 ms  51/5555 (0.92%)  receiver
> > > >     [  6]   0.00-10.01  sec   342 MBytes   287 Mbits/sec  3.814 ms  38/5517 (0.69%)  receiver
> > > >     [SUM]   0.00-10.01  sec   686 MBytes   575 Mbits/sec  3.648 ms  89/11072 (0.8%)  receiver
> > > >
> > > >   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 2`)
> > > >     [  5]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  3.164 ms  390/5731 (6.8%)  receiver
> > > >     [  6]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  2.416 ms  396/5741 (6.9%)  receiver
> > > >     [SUM]   0.00-10.03  sec   667 MBytes   558 Mbits/sec  2.790 ms  786/11472 (6.9%)  receiver
> > > >
> > > >     Note: with `-P 2`, the best total bitrate (receiver side) was achieved.
> > > >
> > > > - After this change (use_remote_edma=1) [1]:
> > > >
> > > >   * ping
> > > >     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=1.48 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=1.03 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.931 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.910 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.07 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.986 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.910 ms
> > > >     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.883 ms
> > > >
> > > >   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 4`)
> > > >     [  5]   0.00-10.01  sec  3.54 GBytes  3.04 Gbits/sec  0.030 ms  0/58007 (0%)  receiver
> > > >     [  6]   0.00-10.01  sec  3.71 GBytes  3.19 Gbits/sec  0.453 ms  0/60909 (0%)  receiver
> > > >     [  9]   0.00-10.01  sec  3.85 GBytes  3.30 Gbits/sec  0.027 ms  0/63072 (0%)  receiver
> > > >     [ 11]   0.00-10.01  sec  3.26 GBytes  2.80 Gbits/sec  0.070 ms  1/53512 (0.0019%)  receiver
> > > >     [SUM]   0.00-10.01  sec  14.4 GBytes  12.3 Gbits/sec  0.145 ms  1/235500 (0.00042%)  receiver
> > > >
> > > >   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 4`)
> > > >     [  5]   0.00-10.03  sec  3.40 GBytes  2.91 Gbits/sec  0.104 ms  15467/71208 (22%)  receiver
> > > >     [  6]   0.00-10.03  sec  3.08 GBytes  2.64 Gbits/sec  0.176 ms  12097/62609 (19%)  receiver
> > > >     [  9]   0.00-10.03  sec  3.38 GBytes  2.90 Gbits/sec  0.270 ms  17212/72710 (24%)  receiver
> > > >     [ 11]   0.00-10.03  sec  2.56 GBytes  2.19 Gbits/sec  0.200 ms  11193/53090 (21%)  receiver
> > >
> > > Almost 10x fast, 2.9G vs 279M? high light this one will bring more peopole
> > > interesting about this topic.
> >
> > Thank you for the review!
> >
> > OK, I'll highlight this in the next iteration.
> > By the way, my impression is that we can achieve even higher with this remote
> > eDMA architecture.
> 
> eDMA can reduce one memory copy and longer TLP data length. Previously, I
> tried use RDMA framework some year ago, but it is over complex and stop the
> work.

That's interesting. Thank you for the info.

> 
> >
> > >
> > > >     [SUM]   0.00-10.03  sec  12.4 GBytes  10.6 Gbits/sec  0.188 ms  55969/259617 (22%)  receiver
> > > >
> > > >   [1] configfs settings:
> > > >       # modprobe pci_epf_vntb dyndbg=+pmf
> > > >       # cd /sys/kernel/config/pci_ep/
> > > >       # mkdir functions/pci_epf_vntb/func1
> > > >       # echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
> > > >       # echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
> > > >       # echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
> > > >       # echo 16 >       functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
> > > >       # echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
> > > >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
> > > >       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
> > > >       # echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
> > > >       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
> > >
> > > look like, you try to create sub-small mw windows.
> > >
> > > Is it more clean ?
> > >
> > > echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1.0
> > > echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1.1
> > >
> > > so wm1.1 natively continue from prevous one.
> >
> > Thanks for the suggestion.
> >
> > I was trying to keep the sub-small mw windows referred to in the same way
> > as normal windows for simplicity and readability, but I agree your proposal
> > looks intuitive from a User-eXperience point of view.
> >
> > My only concern is that e.g. {mw1.0, mw1.1, mw2.0} may translate internally
> > into something like {mw1, mw2, mw3} effectively, and that numbering
> > mismatch might become confusing when reading or debugging the code.
> 
> If there are enough bars, you can try use one dedicate bar for EDMA register
> space, LL space shared with bar0 (control bar) to reduce complex, and get
> better performace firstly.

Thank you for the suggestion. Once I have the critical pieces (which we are
discussing in several threads for this RFCv2 series) sorted out and start
preparing the next iteration, I'll revisit this.

Koichiro

> 
> Frank
> 
> >
> > -Koichiro
> >
> > >
> > > Frank
> > >
> > > >       # echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
> > > >       # echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
> > > >       # echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
> > > >       # echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
> > > >       # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
> > > >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
> > > >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar
> > > >       # ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
> > > >       # echo 1 > controllers/e65d0000.pcie-ep/start
> > > >
> > > >
> > > > Thanks for taking a look.
> > > >
> > > >
> > > > Koichiro Den (27):
> > > >   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
> > > >     access
> > > >   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
> > > >   NTB: epf: Handle mwN_offset for inbound MW regions
> > > >   PCI: endpoint: Add inbound mapping ops to EPC core
> > > >   PCI: dwc: ep: Implement EPC inbound mapping support
> > > >   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
> > > >   NTB: Add offset parameter to MW translation APIs
> > > >   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
> > > >     present
> > > >   NTB: ntb_transport: Support offsetted partial memory windows
> > > >   NTB: core: Add .get_pci_epc() to ntb_dev_ops
> > > >   NTB: epf: vntb: Implement .get_pci_epc() callback
> > > >   damengine: dw-edma: Fix MSI data values for multi-vector IMWr
> > > >     interrupts
> > > >   NTB: ntb_transport: Use seq_file for QP stats debugfs
> > > >   NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
> > > >   NTB: ntb_transport: Dynamically determine qp count
> > > >   NTB: ntb_transport: Introduce get_dma_dev() helper
> > > >   NTB: epf: Reserve a subset of MSI vectors for non-NTB users
> > > >   NTB: ntb_transport: Introduce ntb_transport_backend_ops
> > > >   PCI: dwc: ep: Cache MSI outbound iATU mapping
> > > >   NTB: ntb_transport: Introduce remote eDMA backed transport mode
> > > >   NTB: epf: Provide db_vector_count/db_vector_mask callbacks
> > > >   ntb_netdev: Multi-queue support
> > > >   NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
> > > >   iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
> > > >   iommu: ipmmu-vmsa: Add support for reserved regions
> > > >   arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe
> > > >     eDMA
> > > >   NTB: epf: Add an additional memory window (MW2) barno mapping on
> > > >     Renesas R-Car
> > > >
> > > >  arch/arm64/boot/dts/renesas/Makefile          |    2 +
> > > >  .../boot/dts/renesas/r8a779f0-spider-ep.dts   |   46 +
> > > >  .../boot/dts/renesas/r8a779f0-spider-rc.dts   |   52 +
> > > >  drivers/dma/dw-edma/dw-edma-core.c            |   28 +-
> > > >  drivers/iommu/ipmmu-vmsa.c                    |    7 +-
> > > >  drivers/net/ntb_netdev.c                      |  341 ++-
> > > >  drivers/ntb/Kconfig                           |   11 +
> > > >  drivers/ntb/Makefile                          |    3 +
> > > >  drivers/ntb/hw/amd/ntb_hw_amd.c               |    6 +-
> > > >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  177 +-
> > > >  drivers/ntb/hw/idt/ntb_hw_idt.c               |    3 +-
> > > >  drivers/ntb/hw/intel/ntb_hw_gen1.c            |    6 +-
> > > >  drivers/ntb/hw/intel/ntb_hw_gen1.h            |    2 +-
> > > >  drivers/ntb/hw/intel/ntb_hw_gen3.c            |    3 +-
> > > >  drivers/ntb/hw/intel/ntb_hw_gen4.c            |    6 +-
> > > >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |    6 +-
> > > >  drivers/ntb/msi.c                             |    6 +-
> > > >  drivers/ntb/ntb_edma.c                        |  628 ++++++
> > > >  drivers/ntb/ntb_edma.h                        |  128 ++
> > > >  .../{ntb_transport.c => ntb_transport_core.c} | 1829 ++++++++++++++---
> > > >  drivers/ntb/test/ntb_perf.c                   |    4 +-
> > > >  drivers/ntb/test/ntb_tool.c                   |    6 +-
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   |  287 ++-
> > > >  drivers/pci/controller/dwc/pcie-designware.h  |    7 +
> > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c |  229 ++-
> > > >  drivers/pci/endpoint/pci-epc-core.c           |   44 +
> > > >  include/linux/ntb.h                           |   39 +-
> > > >  include/linux/ntb_transport.h                 |   21 +
> > > >  include/linux/pci-epc.h                       |   11 +
> > > >  29 files changed, 3415 insertions(+), 523 deletions(-)
> > > >  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
> > > >  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
> > > >  create mode 100644 drivers/ntb/ntb_edma.c
> > > >  create mode 100644 drivers/ntb/ntb_edma.h
> > > >  rename drivers/ntb/{ntb_transport.c => ntb_transport_core.c} (59%)
> > > >
> > > > --
> > > > 2.48.1
> > > >

