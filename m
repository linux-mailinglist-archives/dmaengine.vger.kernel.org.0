Return-Path: <dmaengine+bounces-7508-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C66E8CA5F5F
	for <lists+dmaengine@lfdr.de>; Fri, 05 Dec 2025 04:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F6823052AC5
	for <lists+dmaengine@lfdr.de>; Fri,  5 Dec 2025 03:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41BF2EC54A;
	Fri,  5 Dec 2025 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AANtehWn"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010035.outbound.protection.outlook.com [52.101.228.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153B2853F2;
	Fri,  5 Dec 2025 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764903873; cv=fail; b=c76CdTfAnqI51oyMAASfjQYUfo4aTMfsJfiq+g3R4+2syIkwXIfTpkeSjHA77EfjrJajCMmxvErFo9ge5VkGuYAziIcnyy9A7XCtHc6SjK7dsyQVTjhPBdMeaXHMjtxae+lHeGKrLI/e0fWPrlr4vrT56DO+cKpnfhewUDCUSeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764903873; c=relaxed/simple;
	bh=WSyClt2XM/FldeDAiOuZ85lueiGmk8qN51+eC+zgAqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PnosNI4pT9KJtYM+08hK0CgyCPbxK9qBhpJMujdaBxuMUrXMU79cefBn5CL1008FnU4Ls0pn3yVTFNf3/FkDWyOve99/nMaeKzA7qMw7p0rQkmI3ebk8u8IVPz/9tuQKaqrg4UtBd2ExaPMMj31LSXMutO3aV+Vj79ZllgFgeQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AANtehWn; arc=fail smtp.client-ip=52.101.228.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+uo86j6spn6K62e0ZIPDh2DLU1flrEUlvoY+HIikPsH0+oJpnilM0rUnnSr74BVnBqh8NxKbjEy2/LB7NjrgDsXyQG3Q42BDjlzRo/+90CGDgCHQ603B8NvLrd0Gk4Z1dwUPvd4nXBb6Qg1432hNpyPDtj3GZmfzziaVH9p9H2aLqBuKV2mg/mjxY+0rUj+5VWXOS8F6x34qfW94SiPR0UO7ZuZ/eWxIQFUI63g7ctl2M+7Hhh6XecnNdYy5diUSM6mKBlZJIuMZbboCwwNyos0Peh0ym45PXU9IqDVX5PCwFQ8HtqRC1WIYmpUfOGuG944pxUpdR1/HqyE2Wa4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSWYurGH6NnHY/kQlZFKCmC6CwoO0kLb0URn9MNNsFU=;
 b=A5pnHwFXn6YCn8l9HjxdqOndeRR28xY2L/EbYzRA7BxRfCpzMCH0cn3EmQT7n2TG3n+yFr2sEM3/L/HOaM7KllZGXyzqcQTp46I1vW0wuAx4oowv8n0+aZt2I62k5KBvjfNyMwgclsJRu2j929/BlP70yGq+v/VQyMszD1vGgMQLVn8UKibGSufdtc9f7IwD0UgYO48eMVjI1fIvpwg59N+cO8VbnIcAzh75Y17LG59jmMjYjoAXVRwimLkcrYi75ocOEWp5hYUFF7ppg382dO/Svj48h6yS1CPENS41BZ96Gclp6bEFsgYI8k0ZbzBur/KXJ2Wt22QS7vcDfBBYcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSWYurGH6NnHY/kQlZFKCmC6CwoO0kLb0URn9MNNsFU=;
 b=AANtehWn66WfMAV/BwKjWqX9xTxHhJBz+4EbSgxCrJr4WgLIJZPZJokxMLBxtqhEp8ESCEYnfrdkScEgX/Wc/i9V4rHp3UFJV0Ykc238s3jXRJRYaIUgBQE7xRlhQLIjS+OSEsAalcv7PY1dru2sGrS4t8PecQ40AQrMGjV8EO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB6693.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:416::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.20; Fri, 5 Dec
 2025 03:04:27 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Fri, 5 Dec 2025
 03:04:26 +0000
Date: Fri, 5 Dec 2025 12:04:24 +0900
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
Subject: Re: [RFC PATCH v2 20/27] NTB: ntb_transport: Introduce remote eDMA
 backed transport mode
Message-ID: <nbjr7ovjgvrvcr7sntrgcjyui5tukp6utd5bvqc3hsdopsl3vi@or4vjl3owblf>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-21-den@valinux.co.jp>
 <aS4Lcb+BjjCDeJRz@lizhi-Precision-Tower-5810>
 <jiigiyxb2hllpeh3znbfy4octtubvkkrbxv7qfzzivimvz7ky2@i7b7a66peapf>
 <aS8I5e2UguQ2/+uU@lizhi-Precision-Tower-5810>
 <27mhsc7pksxyv62ro2m4u4xblednmlgsvzm6e2gx4iqt2plrl2@ewtuiycdq3vj>
 <aTBh86H5m6PpIxMk@lizhi-Precision-Tower-5810>
 <47ns4b4oskh5yukig7sr4okhw6gvqf4q5yin2ibrpue5zrcplp@ybozsroia2fk>
 <aTHsGerE5phzLrgk@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTHsGerE5phzLrgk@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::20) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 45aeae38-4cf2-4556-da8d-08de33aaffa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V1D+zWB9h4n4NXIr3W9Ccj36zrQJnNcymiz+etXclK+HSAV/tCJ+xer1Z/MS?=
 =?us-ascii?Q?CFLDZq75LKOUTIsLDuabMx65i8TnMtlFKsx8P9z/4l7jNchXxSVqTReBUUO7?=
 =?us-ascii?Q?Ca11szBHKUxkeTLx8SNJWvyU7NXAxjQ3cGxnd7KOPhrZXOZHPj2azkXufXrz?=
 =?us-ascii?Q?E1Yu1CD0sX5iIncosAERdIjeH3e6PShidOf7N6rbyUTaUuJy7WRWEROFKb3u?=
 =?us-ascii?Q?90JO+zHvsH17hLnvadlANKTjp4Kz9OufbiTfI4SuxOuQYga9VBCwwA6QLG+Z?=
 =?us-ascii?Q?IEEs1E8F+wdthJ5j75eLdEE93t6uaumpLV0cVZhV9ocbN+H5qqv3xYmGYBjf?=
 =?us-ascii?Q?VmAK8v0lOmnjIrkopCM5yPixzW36XTcXwQo9RlBjSSCzdpiS5NBegieK8w+S?=
 =?us-ascii?Q?jd5+e1mdu8uaJ4keh9K0YY6K/xviBTyR9FfA8fm7hkq+Y4GK5h/5DT4OOVtx?=
 =?us-ascii?Q?RtyfK1vRczj/6bHleh4Jm+BL6zyFHxpMkKKXls0lSwjJ8KIIfbdc2B/Yyrgd?=
 =?us-ascii?Q?8gkNKAiEneB5lE7+7+FUhQ9mG7pkdW+s7ppMyUR/0is9LNvQRp9RtDEblxOe?=
 =?us-ascii?Q?t8BZQll/+Y/UZM0AfiQ//aLjTHjTU8waqWTVkkJ3P4t0hLVG8EWTOWtICRlz?=
 =?us-ascii?Q?dyQViBACQzjMZEs7Ejq2IaAPW6VYxJ+oi+Pa/qbeVr4/tVijArAmbU640adO?=
 =?us-ascii?Q?MIML3oU5KM8C84QOoAbuBrX7p/5kmY6UPQJs7BKQ34edekGoamF7olnwMoyk?=
 =?us-ascii?Q?rBW9ucjmEHsRJUwwAtFzbEb8ohhxGngunGVdSjb57NTfX5z7Yvy19dHUF5/5?=
 =?us-ascii?Q?lE/BwbI2s64A8PIEg3T+LaTnp40Wf5rkxuFmfbymue6uLydCNgVDWda4wbHc?=
 =?us-ascii?Q?U65i/A/FDdiyuGr50UtoxE3c6XhLCNQQ95hzMVk7wIMen2HUUEiqYkN1WOhn?=
 =?us-ascii?Q?tXYpWMKzc/lt+NRqTVUEuuWhLR2fozFehu8/d/Us22zLSsudlHpkpBrNiXh7?=
 =?us-ascii?Q?NguNZ9g8kC4k4Zw6pmMWfsW1n/FjWuRyZariMQoyz3fMq8Sv7KbrRz/K0BAi?=
 =?us-ascii?Q?YNxffibIJL5fH/fOuSSBmbG8kNk6FoA8k8DO61DbQvhL5GAF0vA50FGJ1BLd?=
 =?us-ascii?Q?bLjHgeA8YD7tXhor40mI8UErgXQODzIc3+AXSxo1lB4WgvBSrR4ef7s//Xda?=
 =?us-ascii?Q?LdYEaJa8SNgRmyaqHK7ZduLCEmAogQdaqeFbtfTzuap43YfiQDRcB1tn+Cdt?=
 =?us-ascii?Q?xdKYsALUZS5pdweb1qQLgILrBvCP6Pmbq8uRH2XynngzcEvAegnC2c28VdgL?=
 =?us-ascii?Q?MSIbAiuCwFcCwokHhjCyKXKFz3HO+WTMnO13+/7P98rIKoU1J+KYbrv2DtKg?=
 =?us-ascii?Q?lGz0iJ3FK2gF6AdXI6cws3UQAQA5DyM91Qgl6mjZqjFf0gri+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?etgxNpxNF2GzGvSymLhtiOgJOJi8GJQFhZR6P4x40bIz+GA3BqDUk+3TeYyu?=
 =?us-ascii?Q?tt3hi1AzH6DJDcqK3Pm8HG4vmbudUg/0CgcBAkrmVFAb/cyVtbq/8xu78ftO?=
 =?us-ascii?Q?s+rrNuiIQLGkxoepv18WmjHloskOfZXIdI/lOF7U8VzNarg8ij8dNDQXkt3Z?=
 =?us-ascii?Q?19Gm1/bMms+8VOK1AEpreH+5eRNPfZfkV/I28tCElI1ZlLrfmQCNO225I4pw?=
 =?us-ascii?Q?TryTNuc/Z+VU1YqTOEVCCIdvbkVWj9OS9wJe8iwq2w9MKO9vsS4CrCaobGFf?=
 =?us-ascii?Q?xs4hw5hoB30D2WST4BWnmWTiWoDjBwq1uqStzzrzAoG7z8EIu7d+Uzw28/nN?=
 =?us-ascii?Q?zU5uYH8jtSAjc3EY7yf349k34gBrmOT4nZfxlVQ3DF0jqDIoKzDtQV9iqXRj?=
 =?us-ascii?Q?KObfHa3XhACHekIBwTI32JpwyrkZ2Ys+ZoSubNjc2htGFka3oeMWZytJPcgS?=
 =?us-ascii?Q?pZ9wUa21AAQetkz1EGaemx+rFcLawvAzR6eCcAS+z3v5mXer13YEDrrJaTQE?=
 =?us-ascii?Q?GkSay8EDutvYgK9F3u56EFRF0W6sn2RB3XlgYsw6Uuvcy7MU5j365jqO/FeW?=
 =?us-ascii?Q?7APdVE+CyhXmBDZTunNtVOpryHH+erL0axrQ7ippATTHT2QiS05wN0gXQSMN?=
 =?us-ascii?Q?RaNPQH9jLunDeMhWrGwzaWBoTUVQBaJFupNd0iYF0vsjOBzp1FK4HdyqaTq+?=
 =?us-ascii?Q?vPgm3H5BFEZh5XEp5z0vDQ9R0BFCUhmyKsCtDv85HMBw7wOCW4IHzty6ct/I?=
 =?us-ascii?Q?+GMu5S2Ri4F3uh06n6rSy10/9tsJiq7CesOn5ukB7sdzkNmguOjFfVEB8i2x?=
 =?us-ascii?Q?73WECQxkJKMsm0zuzqQoxss8kIVal0EEgWAWzhx5VLRqKFOGc0dez8Kf2pq/?=
 =?us-ascii?Q?+cpg4NhCjCHtfIMDWsKCslfTaD20u5KoCIAjRX5CkttNwiXCrmrl81qdF8AI?=
 =?us-ascii?Q?BYqg6hUzLu/Bk4TU4NlZVY27mYz0l8B5OMmslIh5bXGq3BbkRhUvP5OSIITf?=
 =?us-ascii?Q?bhnbHRA+Uo9HwWRIM88/t42HVvpP1OAa7Cleb0WtuBNB9rJd/2A2YdVBokIJ?=
 =?us-ascii?Q?5XiSA0SKIvdvNhQD1J5QWeDGBTRfxqFhGPNV0N3hxFHowNBf0wyU3DvL67wF?=
 =?us-ascii?Q?ZSL83eMyvBM47qTDIET8g/uPNKaXOlSqer6I98mxi1Rs0g8oiEI1BPPocnM6?=
 =?us-ascii?Q?S/vtEny8sbB/xFLV/Wc7L7S2yAmjJASN+2kYyF3/pVxg4igOKpzIz83yXjRo?=
 =?us-ascii?Q?mMziaHhKQLrQAZdx1PtgEKd2/EVVrpZD8fVamIOkKlRg6xGSM8yS4j7dGpox?=
 =?us-ascii?Q?PrC/tA9OT+Ul7NOGrHDjvf0Gr/yFsGSRD9SmmPFpw+N1TuK18+PDJbm8EqkY?=
 =?us-ascii?Q?4z+gc+AnFFJpXcM4gwCJXtTAr8Oi+RKVwFw+SPzXfOSijGWODeZgMrWnPNYf?=
 =?us-ascii?Q?c3vZxKpQ5QRSnYiZHI8Qjca2xf0ikaFl38ALoIqQUK75YN8pvRfTBUGSEyWJ?=
 =?us-ascii?Q?ZYY1Xst5t5scEKshFVLAb0Xk1Uc86h10aCXO7hKbHhR1HCnBoMhM5DkG38Js?=
 =?us-ascii?Q?3ezjnIeSO+NToPfxBOjWM2Q3dsu8+Sb+W7tOzwRT1bx9RzOBs7VXacKfS/rZ?=
 =?us-ascii?Q?/TUAO6c5wuuOkeC8w88fLrs=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aeae38-4cf2-4556-da8d-08de33aaffa9
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 03:04:26.1589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yVIHcIB6HKYUpWQhZAE21KonOP+A44aRAU5OZDm6vP5vdPWiWWzKnimeFEOiF+EDqnqVXdCI8jxv3+r1VvJkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6693

On Thu, Dec 04, 2025 at 03:16:25PM -0500, Frank Li wrote:
> On Fri, Dec 05, 2025 at 12:42:03AM +0900, Koichiro Den wrote:
> > On Wed, Dec 03, 2025 at 11:14:43AM -0500, Frank Li wrote:
> > > On Wed, Dec 03, 2025 at 05:53:03PM +0900, Koichiro Den wrote:
> > > > On Tue, Dec 02, 2025 at 10:42:29AM -0500, Frank Li wrote:
> > > > > On Tue, Dec 02, 2025 at 03:43:10PM +0900, Koichiro Den wrote:
> > > > > > On Mon, Dec 01, 2025 at 04:41:05PM -0500, Frank Li wrote:
> > > > > > > On Sun, Nov 30, 2025 at 01:03:58AM +0900, Koichiro Den wrote:
> > > > > > > > Add a new transport backend that uses a remote DesignWare eDMA engine
> > > > > > > > located on the NTB endpoint to move data between host and endpoint.
> > > > > > > >
> > > > > ...
> > > > > > > > +#include "ntb_edma.h"
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > > + * The interrupt register offsets below are taken from the DesignWare
> > > > > > > > + * eDMA "unrolled" register map (EDMA_MF_EDMA_UNROLL). The remote eDMA
> > > > > > > > + * backend currently only supports this layout.
> > > > > > > > + */
> > > > > > > > +#define DMA_WRITE_INT_STATUS_OFF   0x4c
> > > > > > > > +#define DMA_WRITE_INT_MASK_OFF     0x54
> > > > > > > > +#define DMA_WRITE_INT_CLEAR_OFF    0x58
> > > > > > > > +#define DMA_READ_INT_STATUS_OFF    0xa0
> > > > > > > > +#define DMA_READ_INT_MASK_OFF      0xa8
> > > > > > > > +#define DMA_READ_INT_CLEAR_OFF     0xac
> > > > > > >
> > > > > > > Not sure why need access EDMA register because EMDA driver already export
> > > > > > > as dmaengine driver.
> > > > > >
> > > > > > These are intended for EP use. In my current design I intentionally don't
> > > > > > use the standard dw-edma dmaengine driver on the EP side.
> > > > >
> > > > > why not?
> > > >
> > > > Conceptually I agree that using the standard dw-edma driver on both sides
> > > > would be attractive for future extensibility and maintainability. However,
> > > > there are a couple of concerns for me, some of which might be alleviated by
> > > > your suggestion below, and some which are more generic safety concerns that
> > > > I tried to outline in my replies to your other comments.
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > > +
> > > > > > > > +#define NTB_EDMA_NOTIFY_MAX_QP		64
> > > > > > > > +
> > > > > ...
> > > > > > > > +
> > > > > > > > +	virq = irq_create_fwspec_mapping(&fwspec);
> > > > > > > > +	of_node_put(parent);
> > > > > > > > +	return (virq > 0) ? virq : -EINVAL;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static irqreturn_t ntb_edma_isr(int irq, void *data)
> > > > > > > > +{
> > > > > > >
> > > > > > > Not sue why dw_edma_interrupt_write/read() does work for your case. Suppose
> > > > > > > just register callback for dmeengine.
> > > > > >
> > > > > > If we ran dw_edma_probe() on both the EP and RC sides and let the dmaengine
> > > > > > callbacks handle int_status/int_clear, I think we could hit races. One side
> > > > > > might clear a status bit before the other side has a chance to see it and
> > > > > > invoke its callback. Please correct me if I'm missing something here.
> > > > >
> > > > > You should use difference channel?
> > > >
> > > > Do you mean something like this:
> > > > - on EP side, dw_edma_probe() only set up a dedicated channel for notification,
> > > > - on RC side, do not set up that particular channel via dw_edma_channel_setup(),
> > > >   but do other remaining channels for DMA transfers.
> > >
> > > Yes, it may be simple overall. Of course this will waste a channel.
> >
> > So, on the EP side I see two possible approaches:
> >
> > (a) Hide "dma" [1] as in [RFC PATCH v2 26/27] and call dw_edma_probe() with
> >     hand-crafted settings (chip->ll_rd_cnt = 1, chip->ll_wr_cnt = 0).
> > (b) Or, teach this special-purpose policy (i.e. configuring only a single
> >     notification channel) to the SoC glue driver's dw_pcie_ep_init_registers(),
> >     for example via Kconfig. I don't think DT is a good place to describe
> >     such a policy.
> >
> > There is also another option, which do not necessarily run dw_edma_probe()
> > by ourselves:
> >
> > (c) Leave the default initialization by the SoC glue as-is, and override the
> >     per-channel role via some new dw-edma interface, with the guarantee
> >     that all channels except the notification channel remain unused on its
> >     side afterwards. In this model, the EP side builds the LL locations
> >     for data transfers and the RC configures all channels, but it sets up
> >     the notification channel in a special manner.
> >
> > [1] https://github.com/jonmason/ntb/blob/68113d260674/Documentation/devicetree/bindings/pci/snps%2Cdw-pcie-ep.yaml#L83
> >
> > >
> > > >
> > > > Also, is it generically safe to have dw_edma_probe() executed from both ends on
> > > > the same eDMA instance, as long as the channels are carefully partitioned
> > > > between them?
> > >
> > > Channel register MMIO space is sperated. Some channel register shared
> > > into one 32bit register.
> > >
> > > But the critical one, interrupt status is w1c. So only write BIT(channel)
> > > is safe.
> > >
> > > Need careful handle irq enable/disable.
> >
> > Yeah, I agree it is unavoidable in this model.
> >
> > >
> > > Or you can defer all actual DMA transfer to EP side, you can append
> > > MSI write at last item of link to notify RC side about DMA done. (actually
> > > RIE should do the same thing)
> > >
> > > >
> > > > >
> > > > > >
> > > > > > To avoid that, in my current implementation, the RC side handles the
> > > > > > status/int_clear registers in the usual way, and the EP side only tries to
> > > > > > suppress needless edma_int as much as possible.
> > > > > >
> > > > > > That said, I'm now wondering if it would be better to set LIE=0/RIE=1 for
> > > > > > the DMA transfer channels and LIE=1/RIE=0 for the notification channel.
> > > > > > That would require some changes on dw-edma core.
> > > > >
> > > > > If dw-edma work as remote DMA, which should enable RIE. like
> > > > > dw-edma-pcie.c, but not one actually use it recently.
> > > > >
> > > > > Use EDMA as doorbell should be new case and I think it is quite useful.
> > > > >
> > > > > > >
> > > > > > > > +	struct ntb_edma_interrupt *v = data;
> > > > > > > > +	u32 mask = BIT(EDMA_RD_CH_NUM);
> > > > > > > > +	u32 i, val;
> > > > > > > > +
> > > > > ...
> > > > > > > > +	ret = dw_edma_probe(chip);
> > > > > > >
> > > > > > > I think dw_edma_probe() should be in ntb_hw_epf.c, which provide DMA
> > > > > > > dma engine support.
> > > > > > >
> > > > > > > EP side, suppose default dwc controller driver already setup edma engine,
> > > > > > > so use correct filter function, you should get dma chan.
> > > > > >
> > > > > > I intentionally hid edma for EP side in .dts patch in [RFC PATCH v2 26/27]
> > > > > > so that RC side only manages eDMA remotely and avoids the potential race
> > > > > > condition I mentioned above.
> > > > >
> > > > > Improve eDMA core to suppport some dma channel work at local, some for
> > > > > remote.
> > > >
> > > > Right, Firstly I experimented a bit more with different LIE/RIE settings and
> > > > ended up with the following observations:
> > > >
> > > > * LIE=0/RIE=1 does not seem to work at the hardware level. When I tried this for
> > > >   DMA transfer channels, the RC side never received any interrupt. The databook
> > > >   (5.40a, 8.2.2 "Interrupts and Error Handling") has a hint that says
> > > >   "If you want a remote interrupt and not a local interrupt then: Set LIE and
> > > >   RIE [...]", so I think this behaviour is expected.
> > >
> > > Actually, you can append MSI write at last one of DMA descriptor link. So
> > > it will not depend on eDMA's IRQ at all.
> >
> > For RC->EP interrupts on R-Car S4 in EP mode, using ITS_TRANSLATER as the
> > IB iATU target did not appear to work in practice. Indeed that was the
> > motivation for the RFC v1 series [2]. I have not tried using ITS_TRANSLATER
> > as the eDMA read transfer DAR.
> >
> > But in any case, simply masking the local interrupt is sufficient here. I
> > mainly wanted to point out that my naive idea of LIE=0/RIE=1 is not
> > implementable with this hardware. This whole LIE/RIE topic is a bit
> > off-track, sorry for the noise.
> >
> > [2] For the record, RFC v2 is conceptually orthogonal and introduces a
> >     broader concept ie. remote eDMA model, but I reused many of the
> >     preparatory commits from v1, which is why this is RFC v2 rather than a
> >     separate series.
> >
> > >
> > > > * LIE=1/RIE=0 does work at the hardware level, but is problematic for my current
> > > >   design, where the RC issues the DMA transfer for the notification via
> > > >   ntb_edma_notify_peer(). With RIE=0, the RC never calls
> > > >   dw_edma_core_handle_int() for that channel, which means that internal state
> > > >   such as dw_edma_chan.status is never managed correctly.
> > >
> > > If you append on MSI write at DMA link, you needn't check status register,
> > > just check current LL pos to know which descrptor already done.
> > >
> > > Or you also enable LIE and disable related IRQ line(without register
> > > irq handler), so Local IRQ will be ignore by GIC, you can safe handle at
> > > RC side.
> >
> > What I was worried about here is that, with RIE=0 the current dw-edma
> > handling of struct dw_edma_chan::status field (not status register) would
> > not run for that channel, which could affect subsequent tx submissions. But
> > your suggestion also makes sense, thank you.
> >
> > --8<--
> >
> > So anyway the key point seems that we should avoid such hard-coded register
> > handling in [RFC PATCH v2 20/27] and rely only on the standard dw-edma
> > interfaces (possibly with some extensions to the dw-edma core). From your
> > feedback, I feel this is the essential direction.
> >
> > From that perspective, I'm leaning toward (b) (which I wrote above in a
> > reply comment) with a Kconfig guard, i.e. in dw_pcie_ep_init_registers(),
> > if IS_ENABLED(CONFIG_DW_REMOTE_EDMA) we only configure the notification
> > channel. In practice, a DT-based variant of (b) (for example a new property
> > such as "dma-notification-channel = <N>;" and making
> > dw_pcie_ep_init_registers() honour it) would be very handy for users, but I
> > suspect putting this kind of policy into DT is not acceptable.
> >
> > Assuming careful handling, (c) might actually be the simplest approach. I
> > may need to add a small hook for the notification channel in
> > dw_edma_done_interrupt(), via a new API such as
> > dw_edma_chan_register_notify().
> 
> I reply everything here for overall design
> 
> EDMA actually can access all memory at both EP and RC side regardless PCI
> map windows. NTB defination is that only access part of both system memory,
> so anyway need once memcpy. Although NTB can't take 100% eDMA advantage, it
> is still easiest path now. I have a draft idea without touch NTB core code
> (most likley).
> 
> EP side                          RC side
>              1:  Control bar
>              2:  Doorbell bar
>              3:  WM1
> 
> MW1 is fixed sized array [ntb_payload_header + data]. Current NTB built
> queue in system memory, transfer data (RW) to this array.
> 
> Use EDMA only one side, RC/EP. use EP as example.
> 
> In 1 (control bar, resever memory space, which call B)
> 
> In ntb_hw_epf.c driver, create a simple 'fake' DMA memcpy driver, which
> just implement device_prep_dma_memcpy(). That just put src\dest\size info
> to memory space B, then push doorbell.
> 
> in EP side's a workqueue, fetch info from B, the send to EDMA queue to
> do actual transfer, after EP DMA finish, mark done at B, then raise msi irq,
> 'fake' DMA memcpy driver will be triggered.
> 
> Futher, 3 WM1 is not necessary existed at all, because both side don't
> access it directly.
> 
> For example:
> 
> case RC TX, EP RX
> 
> RC ntb_async_tx_submit() use device_prep_dma_memcpy() copy user space
> memory (0xRC_1000 to PCI_1000, size 0x1000), put into share bar0 position
> 
>             0xRC_1000 -> 0xPCI_1000 0x1000
> 
> EP side, there RX request ntb_async_rx_submit(),  from 0xPCI_1000 to
> 0xEP_8000 size 0x20000.
> 
> so setup eDMA transfer form 0xRC_1000 -> 0xEP_8000 size 1000. After complete
> mark both side done, then trigger related callback functions.
> 
> You can see 0xPCI_1000 is not used at all. Actually 0xPCI_1000 is trouble
> maker,  RC and EP system PCI space is not necesary the same as CPU space,
> PCI controller may do address convert.

Thanks for the detailed explanation.

Just to clarify, regarding your comments about the number of memcpy
operations and not using the 0xPCI_1000 window for data path, I think RFC
v2 is already similar to what you're describing.

To me it seems the key differences in your proposal are mainly two-fold:
(1) the layering, and (2) local eDMA use rather than remote.

For (1), instead of adding more eDMA-specific handling into ntb_transport
layer, your approach would keep changes to ntb_transport minimal and
encapsulate the eDMA usage inside the "fake DMA memcpy driver" as much as
possible. In that design, would the MW1 layout change? Leaving the existing
layout as-is would waste the space (so RFC v2 had introduced a new layout).

Also, one point I'm still unsure about is the opposite direction (ie.
EP->RC). In that case, do you also expect the EP to trigger its local eDMA
engine? If yes, then, similar to the RC->EP direction in RFC v2, the EP
would need to know the RC-side receive buffer address (e.g. 0xRC_1000) in
advance.

You also mentioned that you already have some draft. Are you planning to
post that as a patch series? If not, I can of course try to
implement/prototype this approach based on your suggestion.

Please let me know if the above understanding does not match what you had
in mind.

Thank you,
Koichiro


> 
> Frank
> >
> > Thank you for your time and review,
> > Koichiro
> >
> > >
> > > Frank
> > > >
> > > > >
> > > > > Frank
> > > > > >
> > > > > > Thanks for reviewing,
> > > > > > Koichiro
> > > > > >
> > > > > > >
> > > > > > > Frank
> > > > > > >
> > > > > > > > +	if (ret) {
> > > > > > > > +		dev_err(&ndev->dev, "dw_edma_probe failed: %d\n", ret);
> > > > > > > > +		return ret;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > ...
> > > > >
> > > > > > > > +{
> > > > > > > > +	spin_lock_init(&qp->ep_tx_lock);
> > > > > > > > +	spin_lock_init(&qp->ep_rx_lock);
> > > > > > > > +	spin_lock_init(&qp->rc_lock);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static const struct ntb_transport_backend_ops edma_backend_ops = {
> > > > > > > > +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
> > > > > > > > +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
> > > > > > > > +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
> > > > > > > > +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
> > > > > > > > +	.rx_poll = ntb_transport_edma_rx_poll,
> > > > > > > > +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
> > > > > > > > +};
> > > > > > > > +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> > > > > > > > +
> > > > > > > >  /**
> > > > > > > >   * ntb_transport_link_up - Notify NTB transport of client readiness to use queue
> > > > > > > >   * @qp: NTB transport layer queue to be enabled
> > > > > > > > --
> > > > > > > > 2.48.1
> > > > > > > >

