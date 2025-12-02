Return-Path: <dmaengine+bounces-7457-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EBEC9A51C
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F04EB3462AE
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6822F9DA4;
	Tue,  2 Dec 2025 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uLRLXK4s"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011030.outbound.protection.outlook.com [52.101.125.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C221D3CC;
	Tue,  2 Dec 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657173; cv=fail; b=MLFXKmGv0HE7vZjQgIXZ/cl7ih+SolF5zRBq1WZazctYOwcJIXuPTnr4Ipro9hukGiD8TuUBUDWOiTfp3VniBUpgOkoJb0fRaXc99gi/BwNYuOfO8/ezCbg4tjP9AuQwYE5m+ok7+azKMYnDcQ90QuP8sTZK4E2+w1MMVLCkROo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657173; c=relaxed/simple;
	bh=CQl/Fv9O3k62uC4sMRx7uDrHkM9yhY0I3vyrcFG3u6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qvBORHXZR8PFO+eB4ZZi4Wg1yPObqXCkZyWOLZDvBXqTCVmW6b5iQg3QltfH8wi12ZVu9LwYotp0Ox+8dGMBLS/nttXdhN8LFSW+11bcm5uUl3PLGCC1WtHH37sk5b/n6dsNtOmt1Hl6sGdyKuE+6XxYu5eRlbLj24odcLmPWE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uLRLXK4s; arc=fail smtp.client-ip=52.101.125.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aavT0v+N+xVe2mXfp9Er1l8qAht5PjcNB34/7SQVeM4moqVuk5Da6G7gkdCeEPLWn+82aKGUCrGyb+Lg2Lqqad5eqKujf5kM6QoNQQZirSEW4Be8Zr04tMZwvK/uL4hRSOshxFpiHLk9Z5AmSA1FjaqHDCTx2jr2KiINr3EcKsK3Jb0oPydwBCuyqHxZYe4pg1f6QQd7pKF+3HCMuPIsYMq3oOtOriCAonFcaLFyqBgTPR1bwzcHerDQhEXpcBVoLAu1z61KNiD4kvlMCp5sa2799ZG2W7W4jd1dwrn6HFOxHzTS85ybffxvrZTfP93HiDZvRYOgFoLSAcw3hUANWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pNVeGf6Tq9qu5RaiHxoFQhk++S3cwg5YsfeA+idIxI=;
 b=cxWvpqMJ34ukQ+P+g/Xug/tvfxi1YDJyYs0O89tG7XkDIelhTf9uIM8iwoeASRSvFZ+zmD6xFe1cZOKRePJ+Yf++m2d5jkYhOLaeXLGW4u+rbOi+DWKcXhPrpkMvn3m0rB2T1Hy7JXs2bvEPO0O0TF8qOJh/dhf6oAbwjexi3SgukUKwIpGHC2bmsgQKVouqGL0NVU5HcJ0VgrchaoMnN0525lmKQzwK8zfdqlX7edWc0kjWrV37Ik7sFtjtrRN3aXzuOnnZwdMEh0jbIL6yyk9yJmUn38xXjTAEeaHsLdN4I+TAvNTx/Gobab6NtjdNOzjFk9sbBHsUEbGsAFN0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pNVeGf6Tq9qu5RaiHxoFQhk++S3cwg5YsfeA+idIxI=;
 b=uLRLXK4sAX66uhk+GAEUCE7fNGdmf6524ppv03Z+EemcF17hDQ9gXKhX0ZTApQRKcNiAUmGNhz7jwo9Cl0HfYyy4ZEYi6iL8uoSqdSlKZWH/dvKaV1f0ZZ1vQg9ihk6ck6HF9bSEu1GgBFJBvfqbKTZgxkMtn7/ATB8IXhsfwFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TY4P286MB7525.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:351::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:32:49 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:32:49 +0000
Date: Tue, 2 Dec 2025 15:32:49 +0900
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
Subject: Re: [RFC PATCH v2 12/27] damengine: dw-edma: Fix MSI data values for
 multi-vector IMWr interrupts
Message-ID: <n77eybnm2lyzujpwlszcd4dlfxvs44scedvh2rzlity25svlq4@2vucqeqby2op>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-13-den@valinux.co.jp>
 <aS3wo94XbxTCkm25@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3wo94XbxTCkm25@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0148.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::16) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TY4P286MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0a60a1-47dd-4061-84fd-08de316c9d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cdRqcYsP5LrKoXT2wVbm9/dj3sMBlwUNEV7XcnLwJAUg7mExoQiuwEj+bKmz?=
 =?us-ascii?Q?vHDhByWQIKzegZttd+6Sa3Y8igRnQRceFBvQa8UiA/DTyNv3QDGiaeMji/qL?=
 =?us-ascii?Q?+Ta0GmE/0CTm0tCNoCqLcMdXRAvGNfaECd+8MRGm3YXQkQ7oGaPQs7taudP9?=
 =?us-ascii?Q?pMuVKIXZkLgFma9T4JIeX+aaLmE0cySWxYPksuVbFKKmPpxbuJ2LPOscD8JL?=
 =?us-ascii?Q?Phbo6DvyU0ULHm3fLKeCd+3XR5zZ5+OqzN6rh8cofzVSF7qXCnL+vRpx8rz6?=
 =?us-ascii?Q?FzEJJIy/0SkcHqZ5IpE8PgPgS98Tvur/uIpeWiTnwUwZcq3LtT8qeyqT+Z4h?=
 =?us-ascii?Q?K+IBRE08ZOVDs2aA+YLcgg9QjWs/7JxkZ1qo1vB0noPzK2lKrnuiyVd9/7+N?=
 =?us-ascii?Q?1jvgVwxYbTrXiYBggebArKFo89ioKpC3UqHgFlk6+ce4H3Fo9oIRsivPJuYb?=
 =?us-ascii?Q?9XgFLxwqD/zYR6hsJfp59/P437oWGeAf/j9KkR1j8D1t8VvToJkd9UEgYKJn?=
 =?us-ascii?Q?fEUsjAxtFAZKDbRFqGTgwoASNTNHzDQlfYMCuP+oAsXb7C8vFeCmajnRP27s?=
 =?us-ascii?Q?KU30lhHxX/pmrdLCCAnGoonMKWqHKpACdXKgDkZdDmyfjUfRTbod6C23MP0S?=
 =?us-ascii?Q?03vHtMxAU1NBgrW/gglHZeUOldc9RorCPNf0HoGxCY3/a2C1NhgV2F+rH4dc?=
 =?us-ascii?Q?NnBBB/rUwQjLdoTRxCJE5h29+AcIGwqqD5fy1Ea1t6RAbrTng3TEU3KAyn+c?=
 =?us-ascii?Q?R5Nvum3VtuzJlsn2j10WbpKwM//dT3kVCtLgHAslWFll5nzlCu4wuha6JIqj?=
 =?us-ascii?Q?XaS8L9SXszdPgh/eUaHfNDOrpCgtEL2yZmWreCtujf92PUVDREA8IKGrUOT4?=
 =?us-ascii?Q?FQst9ip3Dg0YMRuyVbCsT8P/tmCiIG2p/SGcSdByaZaCC1+GQATbN7GHK+qf?=
 =?us-ascii?Q?m6vhXNnXRONAfHSNkiIToDNX5jVTXa26npB+LSciyoJrMQ55HrVrK65GFaPG?=
 =?us-ascii?Q?GGPLrs69TEX3JXJKPMAECTZtnwNmfHKBThTyxa27BePhn32IbJcIKFFkEoQb?=
 =?us-ascii?Q?5jmTN1nQzODG56vjoQxg6/scP5kxF38M9+gD3IleQ7C4PtcVDKLpaDHgKePW?=
 =?us-ascii?Q?nYTP6SjkFhPCQ7EuCe95hGeCu/kJsE1J6+OYD2e0+yX8M472b8514cEs2b13?=
 =?us-ascii?Q?dF35KTeI5y+b84pIJfaFqekycDsbvG7O+hc9zgiFxyyHrzb6pGje6gavmWJg?=
 =?us-ascii?Q?NSHPhefdHXK0ICTVoOkIz66XF6TaTxprNq35avndFOZpM9raZlbxMkyHxSBi?=
 =?us-ascii?Q?f1wG02xwsn0fGdTLEALBmDmCO3lPLcKrW+BZcADsRW6rinAjdZGxqQVK54FU?=
 =?us-ascii?Q?htZ1B3TrNilvo2XysoFvhVttKbNMQfDO1tjz9YyJHLGJh8wQHMLa44ZAyS/K?=
 =?us-ascii?Q?eCoQalslu2i282sSglkNiLwE5GTP/eM3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CtVt8TupgAGSpypyG1Ra/oNXJu2LNIQ/Q6o1T3vTfFnxWUBK6RF3VUNYZX8o?=
 =?us-ascii?Q?XO8KDmeCk8Sh4TSqV9cypF4my+x/IVF31+JoWJeVWO9CF8yXNhgkYSSPid3N?=
 =?us-ascii?Q?mNetolqqvYBFSrknHRThxHimXKRfuw9NcA6pF067IajIlO3V/4pDDUrIgSvh?=
 =?us-ascii?Q?3pI4Z4RD4UudWOh2SaSLjLypRIvwf/4xSwY++mLgRT3kk4yI0MkxNbIaYY92?=
 =?us-ascii?Q?KCYvTLYy2y5tj1JXPGPgZUOfPYTn723nZP+gA0E9hfnIqzwwRg86GCYI9s6B?=
 =?us-ascii?Q?jeL3CkideqHjrI75bNWNQZW9lsIdRVsropnwO0jvyEro/zCeitTA1azBlHwo?=
 =?us-ascii?Q?1aelwb6I9US0pEZQxsCWPoJR+0duDjf55wv7AR4Qoxe5+OKOf82VYeimkHZo?=
 =?us-ascii?Q?bYhqX1vk2a7oxtvKrV+HIlPA1IyaUJDN/DPEDQ8VNGDSEgrNjL3fdMmusPvs?=
 =?us-ascii?Q?JxWohrAFxbvpCHZ5Pua/E3BrVDLD41GkBMMFuR5Z1a5lNqOgldjufMdxOPF9?=
 =?us-ascii?Q?hm3iixNwtT01rdntcK5ObwMABYqEWMoYxcNALZ8A1IdSFB5j/kuL7ftloP1j?=
 =?us-ascii?Q?qsoJFfr9xNI/IWlKCicEzPCfbkvC43rVPJ7AkN6eJqo+KW0USrT+J5Jam7OO?=
 =?us-ascii?Q?HJFKh/ErDULuOx2oCD2OQfQ/6q6ofRB74ad6PrkyE/+YJdrSAKO3HzocuxuT?=
 =?us-ascii?Q?f7t8Yzau58STl9ykHEbvdnPqsxUOely3Z4OV6TSOV9OvtL9vjX1BYajnTf1y?=
 =?us-ascii?Q?AryPWGD+duJm+njMFdNqVaCFSTP+t0ATfhkZd/2fmxEU3kQzIGcwBvbbhkSv?=
 =?us-ascii?Q?qEffYZ73MgNyWP5cISdcEb1lYiW7z056ps0lJT3t5A6TK2opgDqoh85iuqOo?=
 =?us-ascii?Q?Nj5M28BN6ZkqxhUTOIFSf6L0LJfhMpbtSjVnoHDuefhkgUahvF9qRcunaSWM?=
 =?us-ascii?Q?lv+0xgTperxYOxkIHAo9WhLL4Cuzwcnt+ek/qHqRQepeNgPtXxBw+w8U/DwR?=
 =?us-ascii?Q?KPexm5Mo0ZELZY8l8I6+ITqc4T6g05MP+K9718AJRhtDbKsFMgo3b90iUZPd?=
 =?us-ascii?Q?FGdIJp8KEB/fNW7gTFcFzZSTBtDQj4sIWDqp/xGOH9q0hg6qm+j4HtAva3HU?=
 =?us-ascii?Q?Sy9qva2g+4SrigfjTkdGCWjisSDZC6ecJMI1Z8NvI4+FqajKtDObuMTryBxW?=
 =?us-ascii?Q?EolgMrHU6i+QYqrq/ekociR5biLoYEJIRS4CqYtp5vZnR+YACMJ1nZmjrKSK?=
 =?us-ascii?Q?SKqC59HXHwheW/etm2pOHjive62jnUOiS2OemlkuK3Pou6LSZBWdL6sfuLNj?=
 =?us-ascii?Q?r30wpGLAdOOHZMzNttAPCjUluOB/vEzEZIty08jZFeWRLk7IEeB6dNhxO5s6?=
 =?us-ascii?Q?W1RLNU1J9N+x0lZBfQuazelDeKtgqGwUQv4HPcbSMkZetSyvF78oBuUh1Bft?=
 =?us-ascii?Q?WcrgdGEK4Qv7//GTg54oxka9D12bw16XzNRyn3Nxa4thEvRJikrLAh98KIxp?=
 =?us-ascii?Q?GC9p0V9CyuHJhWTjq1YHYmvcGGpN2UvCN1KaL8PoxrPF4QGzT6W/8/lX3aPE?=
 =?us-ascii?Q?vJTE0PGRHZjpLUCMbr+f2hJuBZ4KaHNKQnDoXnEPPDy3AM/5Zw2BdoUKmMvJ?=
 =?us-ascii?Q?DLVWgQEY6QzNGj52QGJBAzw=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0a60a1-47dd-4061-84fd-08de316c9d3b
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:32:49.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGghCFUrf4avwqmbU3LeAD96Tce7VW/HyadSCUE5I4n3GnXuFUIDiygN6mGEnhe3YxpUALUBXbcHjBbJpfSo4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7525

On Mon, Dec 01, 2025 at 02:46:43PM -0500, Frank Li wrote:
> On Sun, Nov 30, 2025 at 01:03:50AM +0900, Koichiro Den wrote:
> > When multiple MSI vectors are allocated for the DesignWare eDMA, the
> > driver currently records the same MSI message for all IRQs by calling
> > get_cached_msi_msg() per vector. For multi-vector MSI (as opposed to
> > MSI-X), the cached message corresponds to vector 0 and msg.data is
> > supposed to be adjusted by the IRQ index.
> >
> > As a result, all eDMA interrupts share the same MSI data value and the
> > interrupt controller cannot distinguish between them.
> >
> > Introduce dw_edma_compose_msi() to construct the correct MSI message for
> > each vector. For MSI-X nothing changes. For multi-vector MSI, derive the
> > base IRQ with msi_get_virq(dev, 0) and OR in the per-vector offset into
> > msg.data before storing it in dw->irq[i].msi.
> >
> > This makes each IMWr MSI vector use a unique MSI data value.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 28 ++++++++++++++++++++++++----
> >  1 file changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 8e5f7defa6b6..3542177a4a8e 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -839,6 +839,28 @@ static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
> >  		(*mask)++;
> >  }
> >
> > +static void dw_edma_compose_msi(struct device *dev, int irq, struct msi_msg *out)
> > +{
> > +	struct msi_desc *desc = irq_get_msi_desc(irq);
> > +	struct msi_msg msg;
> > +	unsigned int base;
> > +
> > +	if (!desc)
> > +		return;
> > +
> > +	get_cached_msi_msg(irq, &msg);
> > +	if (!desc->pci.msi_attrib.is_msix) {
> > +		/*
> > +		 * For multi-vector MSI, the cached message corresponds to
> > +		 * vector 0. Adjust msg.data by the IRQ index so that each
> > +		 * vector gets a unique MSI data value for IMWr Data Register.
> > +		 */
> > +		base = msi_get_virq(dev, 0);
> > +		msg.data |= (irq - base);
> 
> why "|=", not "=" here?

"=" is better and safe here. Thanks for pointing it out, I'll fix it.

Koichiro

> 
> Frank
> 
> > +	}
> > +	*out = msg;
> > +}
> > +
> >  static int dw_edma_irq_request(struct dw_edma *dw,
> >  			       u32 *wr_alloc, u32 *rd_alloc)
> >  {
> > @@ -869,8 +891,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
> >  			return err;
> >  		}
> >
> > -		if (irq_get_msi_desc(irq))
> > -			get_cached_msi_msg(irq, &dw->irq[0].msi);
> > +		dw_edma_compose_msi(dev, irq, &dw->irq[0].msi);
> >
> >  		dw->nr_irqs = 1;
> >  	} else {
> > @@ -896,8 +917,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
> >  			if (err)
> >  				goto err_irq_free;
> >
> > -			if (irq_get_msi_desc(irq))
> > -				get_cached_msi_msg(irq, &dw->irq[i].msi);
> > +			dw_edma_compose_msi(dev, irq, &dw->irq[i].msi);
> >  		}
> >
> >  		dw->nr_irqs = i;
> > --
> > 2.48.1
> >

