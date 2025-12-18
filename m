Return-Path: <dmaengine+bounces-7796-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F13CCA906
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 08:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85320301257A
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 07:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72439331A59;
	Thu, 18 Dec 2025 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SjjoudJo"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011028.outbound.protection.outlook.com [52.101.125.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E772A1BB;
	Thu, 18 Dec 2025 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040755; cv=fail; b=ppR7ISxbfNBiKC0nSih+lyia1Ob564XKGY21a4Mdpa8y6jRwO4LIdgGLsS5fI/SHxaP7dLYCtZS4ZcE36+K8egju9Qc24LOVYvQU5YSQ8CsDDWOIDSZsCsViSQcAf+39ccGEGLaCLW0EuH0WMbpx7DFPSizF+ag7sH6By4CCWuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040755; c=relaxed/simple;
	bh=BQ3ioxZJzc2TAxDQvt1MJhGPo8gsvvIaHeWhWFtKz+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zyy5TOu4+6zMcLn303J6e/iRzLXE8ZtyqsR2ftWYJ9znhj220UceTv4eKAS8uZ/V7jMTtrFpi9e5Trdc5uunOzNI9Kn9ZYiq1q6G1FIAvLnIbfZ/+u/9mq7diniirdsoXeHMR5xdnCg4BEucBioKTLtWghEkoiY+QtViaVE/5kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SjjoudJo; arc=fail smtp.client-ip=52.101.125.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hn+phdNpdl6QUGUT6PTHV6dytZWa7aocnK5EGzeFjdiVR7A97iAY3DVXQZmAq5oqC5uIs+MOVnwWA3T0y3mN0RzQ0o0Rl1+3xAZt+ds6m7YN5VmqAxWGE58GcnuG1froONujhpUcUePmZ+1RBJmlTkAnD6z+hzlcPSL1nZuSyzbqWoLm6u2Q3sFxLgmcTFOh0KTtgEgfCkI53yIkakHP1wAKCx/lx+pZByqykLCT1TvK47ovp8ROvC++Xz3kXx/gEpS9vH5vl4XSUH7tOmbbs5foMwLzCuNkPez4sdCYBnUedMG5IeTMYi1cbcMmVYWhoLRsXYHv+DWs5186cUPg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffUOBP+DDtoY+EQPzJZuNlvp8S3dTMNScq7vxsmpagk=;
 b=tCV2kG4zWc7lBltYz+lClyGQZ2lX/LOn78mV6NkZ96ExK6hsw6zjX/hjq5HR6HSg9e1qrUb4hA4Ec4QcXlPL7ClwmVbJJqXO2pcvAePnQCUtmg5Ybi+G90UIGlLGUS79riOUJI6qnxUn2cjXTxXEKtUOwgPrTyUVlyxPRIh5AaWJ4imC+m0Jo9XLJ3VNYv/ciRIWOcHvpsLjdkQCFtG6rF7w043UBrslN8rb0hIlSZ6JpRDA6ALpM89nWt8h1TStrvzMKU3bHzOdc/JBYH1h6sTZCDkujpZniu9E0fpe0PV9dXj8gBn2cchb0VBtOt2Xr9KfN8lKoqivSQZbqHxO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffUOBP+DDtoY+EQPzJZuNlvp8S3dTMNScq7vxsmpagk=;
 b=SjjoudJos6mXI2CPAo77oF+PvF3uUjoUWqO7nAu76+xzxrAYw50nNswWagAYCPlc45SmZANA9I9/Foim/OiAzDcfZLWczz5BSHIwUTzr7iY6BtiCOzLe9/k2W1I/gN70o6cpJnHKBqHeXA3QujdEDpWgMM0Tep5pFczrdW0O4v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:257::10)
 by OS9P286MB4382.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 06:52:29 +0000
Received: from TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b17b:8311:62f:5639]) by TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b17b:8311:62f:5639%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 06:52:29 +0000
Date: Thu, 18 Dec 2025 15:52:27 +0900
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
Message-ID: <immlt7jck44hs5srgmodjnghufivfxpok7r4gfdhoqnfzx3omx@6yvdjmoahjwh>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-13-den@valinux.co.jp>
 <aS3wo94XbxTCkm25@lizhi-Precision-Tower-5810>
 <n77eybnm2lyzujpwlszcd4dlfxvs44scedvh2rzlity25svlq4@2vucqeqby2op>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n77eybnm2lyzujpwlszcd4dlfxvs44scedvh2rzlity25svlq4@2vucqeqby2op>
X-ClientProxiedBy: TYCP286CA0252.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::10) To TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:257::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2708:EE_|OS9P286MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d6c07c-e700-427c-457f-08de3e0202f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?My1HNiOvpl2fO6eluZjAnzwxNBZM7FuHG/nMEiwgTzJd10605HHrrg7Q8ppi?=
 =?us-ascii?Q?gcPLncs6tnBHRWQUpd56s3CrCe6EVBCcM973cK7LqN2oXdZaUzqVUQgsQaTg?=
 =?us-ascii?Q?o4nLXdyRsBRJ5IyuwVKvRdad7ZXLRsgiPLezi6jI+7Bbk2kAgA0H7qEVRGlQ?=
 =?us-ascii?Q?xAwosEeteZ4Pdb3fxIbh5FNjM72dSfpuNPP7NQ1ewE1qR70JhYL65hsWQsSU?=
 =?us-ascii?Q?odhlLVfEZC0QVd1aPFv1l29lnSdfZTCZA65syEQx2mS+/ncSoAWbjM232BtX?=
 =?us-ascii?Q?Uf4ow2Rmr/BuWY2Hw1dmIsh04AiSYFk7j3iOjRgW6hkhuiu/BjMe5sULJfPM?=
 =?us-ascii?Q?ekRV+1teCt8NLgyAtKBdj1sehWtzP/wOXbXl+r6NlcnFtmqcpy5Hk1Dfw/cO?=
 =?us-ascii?Q?22H8uixADlTpombCuizRnV9u65d6CoyGnbQ4NmuqbfJRFDWHbMPtCxKUwb9t?=
 =?us-ascii?Q?T/C+eVFrd4K/Jb3OJUvGxu2yJphzGO0/6ln3G6LV+fhmvPkTU2TLg/aDUtRC?=
 =?us-ascii?Q?JGcWBEa9G/o/cPheZTmpwVkSjnCPOaVv1Y4DGl5E2Wtk5OVTSCoxkhlwZ6yD?=
 =?us-ascii?Q?+In3LvoFahJ4lyb/V9ynkQxY3GSyh0jLBfiMHD5TOT3xq9wePa/UdjxnWwVC?=
 =?us-ascii?Q?0DoEm+0Slnxksu6Z8AKgwa6BibdOu6h9kJQNSYGi0pqFQkt4/5BRFYliLnBb?=
 =?us-ascii?Q?C2jRIlKnnBMJ80jR0KTNmYE1ho7RSn6jHIRKwTVYjtBAtpo3haKFgGDFLFhM?=
 =?us-ascii?Q?CD43h+IXYkEXVvD+BVOmigJus81vjbr+pI9BQjI+58rcjiXQ+NVbW/KBWyg5?=
 =?us-ascii?Q?0n08gWHpw+5+4m/lxvtlOh2jWXVFLV2sWgqViUiIOqCHTa/JkLRvtBfvSDFF?=
 =?us-ascii?Q?DdGwJ4Wwg0inKypDKq9Ot6P5rAJy8yEZNqqSdB/L26oc0Tii9T8O5hrz2/Fh?=
 =?us-ascii?Q?MkifTF5b5yWo9PFdLTUBiEqc+8/QveTp/gcrfoyHBoGE4hksIYPaVOrHhEB3?=
 =?us-ascii?Q?nc72e7CQQ+ChBvKjscJFfOYkOAOWTt4o9z/7ik3570uarGqLN0JP5K3h86Ob?=
 =?us-ascii?Q?fn5NajxbNWhMy1e6Ui9LfS0vZ6wqlNPN2NfYOYZVrvFGSEKH9BV3kxg7vSAP?=
 =?us-ascii?Q?cmbPZU83hm7ffA8bFMKK03EctDK/nJIDDJhaH9LF3Ck9OENBkRHBQMb/m1Oc?=
 =?us-ascii?Q?nDP++xbdEneyIq3RrJ/RZBF05MNXPxrdsD3v+Altol2imJQ3gSSNJYKjPxLS?=
 =?us-ascii?Q?EX8VUNCijnwpIWVPKcauglX8axNVns77NsOHhsqPp2GV727orpd8teEeINky?=
 =?us-ascii?Q?NVs0RMUw0dh7ClP0gi6QGUGhYrqUKvb5TUQLPEyI6MJgv53mzZFjXUbbhFXo?=
 =?us-ascii?Q?uwJa2um7iq3tNoER3tP9XQb5pTMHYlBU+TxxUKQPXF3ak4BycL2UlW0Z/RHs?=
 =?us-ascii?Q?h/aNRjUO23RKI8Ica6O6AqfHUYyp0r8s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9nbeIWaZ8QHYwE/gtuAPtBNLfn2Jg9q0djKl5XgtS8gMen0gehb76EdIFo2x?=
 =?us-ascii?Q?APh7CscmT5o7+RDR8VQC+SbImmuODuQvZqpqnNVikqrxsV8U6MLLnLF2r7la?=
 =?us-ascii?Q?bRAfYHUZKIBzESlVLFTXezGx9wDpqTyDdpx46oVG6Ne42PLGLLjDavrIeMiU?=
 =?us-ascii?Q?7NNnSLvb0J5CF7/Qdgo18cVtlFgIeVXGVsz+Vfid2Tw/b3fYGy080RDtasiD?=
 =?us-ascii?Q?KQ2C/DOjxgzsZXAIEZhWyXCsNLlJiKalKDcV+21jnrdo58ktp8lxcElWq0ls?=
 =?us-ascii?Q?hmnCq04QYH+KEnxXUU6929aYkWvne8HpvJkM3u77XgHZMhBnuPSWZSJ3bw88?=
 =?us-ascii?Q?9cKJOT+w9OGyqthekT5BoJYbi8tA4uWwpcBnj/dvyKcmC+rtQbZm5esCsdss?=
 =?us-ascii?Q?I3VYNi6rMcONIa7qJfihdgyRWvLqkfF4Kgtah08Q3g78G2qKsY2bduEg3CKE?=
 =?us-ascii?Q?qz6qn0ynbGqRS1EnxiLdP0XsdqhrIW0h8pUi7sFeykE8DFodtwN/mELFTMf7?=
 =?us-ascii?Q?6jrJ0WCuaOwSfs9Xije7svVeeceA/B+t1o48zS8z905zHtlp6QDR4kMVVV5X?=
 =?us-ascii?Q?Ix3jm1UfB4tAv8UwfqlIl7+t7lgRacA7WZCNT0nsFqTaFiQy4yivzY/wYSUP?=
 =?us-ascii?Q?iNdGL87lrjuiuSs6lhGz6YyLwZKVfDphL6jMBmd9irD7cYRxv1surgQaR9Wb?=
 =?us-ascii?Q?aiwKFc9aJ1XI5WkYnDtyus7SZGiM0M8shC9QjGf1QJ0Gq/eTXd62I8NZs2TF?=
 =?us-ascii?Q?U4bUw7UgLagreOLvwWaFgYYCjBPEZx8y03kp7bAPMpj6Hy3g8JuYDiyQkVCB?=
 =?us-ascii?Q?JjA2ICf8lZdJta9QVM4KxHqZ+S39uh3cgzCdjvkKzQsxo5UUG0i4T2FoZLlJ?=
 =?us-ascii?Q?He+7rTL7GpLCEJ75PqHh92t0vYPBBm33QBvEEE9HhQuTt21B83iuwTm/5ms0?=
 =?us-ascii?Q?n1hFA8gUU18iHLTMGWUyzpZI9eXsYxRMVdqjMLKSfAgwaIN4t+zxdtefhyup?=
 =?us-ascii?Q?0V938Anl0DMcMfbXitxwPBR/j2QkoTJfGSobGwXLXp6Fts5t1ossGsCgKnE+?=
 =?us-ascii?Q?hQDVSNJUGK0EZ6IfDpjUvN1N/tR7tB0PTKul0kTZ5vtvbi5Jnau9RwFWOaDb?=
 =?us-ascii?Q?I9j93Kc0oimsueRmUmDSSKXP6Kes+RqvgBCHDnHoVB32Sof6KYWKWxuDnAXI?=
 =?us-ascii?Q?WN1Ex89sImfA0gTZkOL9RuDxNkPwy5CdiEtaoVV4ScLfTd4Zr+cw+IzpW3p6?=
 =?us-ascii?Q?1x/CP4smeZ5dfcU4Ah41xEeYVtagbP6OMs7yPfkU93Gw9PUEBMbc87iDuyDt?=
 =?us-ascii?Q?HrbdNznaYY6ZLd4mfPgvgD/b8KdJ7J50NiULBAUcmg+3Uy9HDq2GhuN04oWB?=
 =?us-ascii?Q?j8s1rSJQoS9Lxsu1hJDbdib5UHMiOrCP6jWC2d+nQThvjWBs5QbOVynZjkPm?=
 =?us-ascii?Q?5G8bcOmTstXj/36ZbmFaG9Ijgw08GBmILQQmNbwISCDoriWUbGGjc85w7InG?=
 =?us-ascii?Q?ni/6RCzkBRbV0rlISKBQPrEcw7ukrvIg2Q8kGb0DEeOpFYLObMjbMQXTO6R3?=
 =?us-ascii?Q?3VpeN4dL2cQCcSptPQe/WV4K1v/yB0gZHXiRtGSlpNSFRDOFUFvQSO3f4YPs?=
 =?us-ascii?Q?WfRQk5qx7ou6cCXq+7JR8SU=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d6c07c-e700-427c-457f-08de3e0202f8
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 06:52:29.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgwZA14aTqf5oQHem4sRZqLmZIwl3HXuPtXH9C39wEjCGobzOdbpaM+k65Iy8xVSHKw3osqSfT7M8qxc93bnIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4382

On Tue, Dec 02, 2025 at 03:32:49PM +0900, Koichiro Den wrote:
> On Mon, Dec 01, 2025 at 02:46:43PM -0500, Frank Li wrote:
> > On Sun, Nov 30, 2025 at 01:03:50AM +0900, Koichiro Den wrote:
> > > When multiple MSI vectors are allocated for the DesignWare eDMA, the
> > > driver currently records the same MSI message for all IRQs by calling
> > > get_cached_msi_msg() per vector. For multi-vector MSI (as opposed to
> > > MSI-X), the cached message corresponds to vector 0 and msg.data is
> > > supposed to be adjusted by the IRQ index.
> > >
> > > As a result, all eDMA interrupts share the same MSI data value and the
> > > interrupt controller cannot distinguish between them.
> > >
> > > Introduce dw_edma_compose_msi() to construct the correct MSI message for
> > > each vector. For MSI-X nothing changes. For multi-vector MSI, derive the
> > > base IRQ with msi_get_virq(dev, 0) and OR in the per-vector offset into
> > > msg.data before storing it in dw->irq[i].msi.
> > >
> > > This makes each IMWr MSI vector use a unique MSI data value.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c | 28 ++++++++++++++++++++++++----
> > >  1 file changed, 24 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index 8e5f7defa6b6..3542177a4a8e 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -839,6 +839,28 @@ static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
> > >  		(*mask)++;
> > >  }
> > >
> > > +static void dw_edma_compose_msi(struct device *dev, int irq, struct msi_msg *out)
> > > +{
> > > +	struct msi_desc *desc = irq_get_msi_desc(irq);
> > > +	struct msi_msg msg;
> > > +	unsigned int base;
> > > +
> > > +	if (!desc)
> > > +		return;
> > > +
> > > +	get_cached_msi_msg(irq, &msg);
> > > +	if (!desc->pci.msi_attrib.is_msix) {
> > > +		/*
> > > +		 * For multi-vector MSI, the cached message corresponds to
> > > +		 * vector 0. Adjust msg.data by the IRQ index so that each
> > > +		 * vector gets a unique MSI data value for IMWr Data Register.
> > > +		 */
> > > +		base = msi_get_virq(dev, 0);
> > > +		msg.data |= (irq - base);
> > 
> > why "|=", not "=" here?
> 
> "=" is better and safe here. Thanks for pointing it out, I'll fix it.

I forgot to add a follow-up comment before sending RFC v3. Here I was too
distracted, it was intentional to apply OR to the base value, which was
cached. So [RFC PATCH v3 10/35] remains unchanged.
https://lore.kernel.org/all/20251217151609.3162665-11-den@valinux.co.jp/

Thanks,
Koichiro

> 
> Koichiro
> 
> > 
> > Frank
> > 
> > > +	}
> > > +	*out = msg;
> > > +}
> > > +
> > >  static int dw_edma_irq_request(struct dw_edma *dw,
> > >  			       u32 *wr_alloc, u32 *rd_alloc)
> > >  {
> > > @@ -869,8 +891,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
> > >  			return err;
> > >  		}
> > >
> > > -		if (irq_get_msi_desc(irq))
> > > -			get_cached_msi_msg(irq, &dw->irq[0].msi);
> > > +		dw_edma_compose_msi(dev, irq, &dw->irq[0].msi);
> > >
> > >  		dw->nr_irqs = 1;
> > >  	} else {
> > > @@ -896,8 +917,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
> > >  			if (err)
> > >  				goto err_irq_free;
> > >
> > > -			if (irq_get_msi_desc(irq))
> > > -				get_cached_msi_msg(irq, &dw->irq[i].msi);
> > > +			dw_edma_compose_msi(dev, irq, &dw->irq[i].msi);
> > >  		}
> > >
> > >  		dw->nr_irqs = i;
> > > --
> > > 2.48.1
> > >

