Return-Path: <dmaengine+bounces-2049-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E778C7ADB
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 19:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22F0284A8A
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205B714B940;
	Thu, 16 May 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fztTBE2g"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274414A0AE;
	Thu, 16 May 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879387; cv=fail; b=XjqbQU8JtGOaF/kABOiOOCDVyc7AaYvtasN4nr3AEtXeY1G82cxoPYJx390o0GYXyTshIrjCveHhTR4Pp4GGR1RZX1M1NGkm23b5Pyw/g3tcAgW3SAxDhG3P1+UAvYzINjnjzhSRlDKeZbJfKT9KVi5PddVsahaRILlz45fO6Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879387; c=relaxed/simple;
	bh=EEbz7i9qbLHbG4h4ViIIl80U9bBXKJxLSyo3gH9tm8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZV2rdt+BeEfaiYH0pdtDNIHsnYaPakH52o9RTfhW4E/J1/CMbEpyy9mH2bzUDhZz+P1SXsaAISRH22kd3fLtTbE1CDvWXAW9rLbR9Vaa0MsRp+C2b7rGu0lcbBD4LoPcFt0ntLYw9FCS6JXR+8935hgHeEWjbafYqy3IyX+V0rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fztTBE2g; arc=fail smtp.client-ip=40.107.105.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie9eZwU5F06vr3QbeudDx9U3ff4PHSlc7P94AhEhYeqxW+1oBmBBLKKuKBkAR11dfWS7H/98rjezR1vqQsxY2fWdC5+6XfsKIKF4GGTmn0AxMZvF+QQmyUk8CGTJgtV00JDvNzs+nB/dZpcEFoCzdTLC4bNpHJDblPE+0bNKA9u24LrG7C1LyYgi5Qluz0VBwrqh30J3oxky0Cp7It1CR83aR0hB23NcrIbNAA8M/K3NkcR0zPWR0Y1DkMztUxk85XIaDxIPu2jT+NGPPFE2JmmRAS5xxtskBvBiZvIy0icDcaXezCmdWXbhjLUXblfSWqfs0WcNngGo1wdtPKPMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7/ZkXvf2XXUnKaA5YxIXvSp5A4+S3mnlx4ixq8GkHM=;
 b=j0PFwj6if1KrScW0sm8l8B+tzKOeSsgdbGNicckgz+UiRT71rCq2/70e2mFqKTbVoZgTd+DudLK2W/GN4bdEqqdRONUmIS3bcIh7ptZERQYp2yDRYZuTbcrwA+/YCSltNqJwJmtppLi39hwzJXBQjNoGZAZmh4XiKiQwMlX0u5baFpfEl8aQS/lqmtK1JF1ZHzfI9+E1oXYQ4pP3n2zhd73qhCnFxRyxU6en8oHJ0qO4crGXN5LFnYid9qZ7c+oUWo+/IHpG+09SqoXBOV5jobGe6x2akT7eUpGd/BZOabg/kEBoa653rfmD5gKf6Roa/CURiOQy9DOLQP7gVCseJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7/ZkXvf2XXUnKaA5YxIXvSp5A4+S3mnlx4ixq8GkHM=;
 b=fztTBE2gUT2UFdu9t5fTyGy+JZpBtP50ypqBCCxS7aRs58XDsZZK8uTlQ3tzF41WXNRJASn1VLrCwvG0Qp42B9mr36aOtSIby2P91YM/41QCxaiWvwTIG4dqkLvT14QiVwvjwXtsc4tayoSqRmBxCk9j4cMTWQxu0M7fkgJspU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7414.eurprd04.prod.outlook.com (2603:10a6:10:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 17:09:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 17:09:40 +0000
Date: Thu, 16 May 2024 13:09:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 05/12] dmaengine: Add STM32 DMA3 support
Message-ID: <ZkY9zIfvaiA8h7Oq@lizhi-Precision-Tower-5810>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
 <20240423123302.1550592-6-amelie.delaunay@foss.st.com>
 <ZkUFYoRCOOpAoIus@lizhi-Precision-Tower-5810>
 <408b4a20-680e-4bad-8971-ff98323ce04e@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408b4a20-680e-4bad-8971-ff98323ce04e@foss.st.com>
X-ClientProxiedBy: BY3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:254::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 001f350a-538d-4ec9-6d57-08dc75caf8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|7416005|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2l96pEiAKIcdqlnJ3a6VP+DSd+P61QWozmTFfln5zmgJRRB6a6GgVlvbPjEE?=
 =?us-ascii?Q?PmiI7waCLX297n4jquZumLwOkkoAaUNIlc70lCLPwBOYlpnjhjf8F+q/7oA4?=
 =?us-ascii?Q?6iiYk4/est7dKDU0gU6rr8oV9Y2ZgR6oHZATbAMoZaYE+6C+9QIkTNVr4SYt?=
 =?us-ascii?Q?W88j8T6bjcsYkdw550Io1pKMNTB2hhTKM1TPcilkWHcuYHRa6Esk91rcMXcN?=
 =?us-ascii?Q?qyycn5BNbGLDgX+0sC57PTe93e9zo9jyWjRe21Aqu3TuEl3yyO/f7h60SVjr?=
 =?us-ascii?Q?XWRRAnlq/zeB6GYeuHKUTZc2HU6RqiPX/Afx4MKkX8NxeZDmebLX+8Pin5l5?=
 =?us-ascii?Q?woRxSdLNOjD3ExG4alkiKheGvyVBF25HeBtLyQAZOcifTHMi8u6Zwb+rR9+g?=
 =?us-ascii?Q?aLsjmuisQso4h5ZqSJySGWdO+puAT0K+p8IqJPmXpD7ivkpGLga5NP7Rumm0?=
 =?us-ascii?Q?u6frbdf3MCeYI0dgqsedVsMLH0izx+wqHI3SPSnTOwh30gMJUXw/gvp+qdWI?=
 =?us-ascii?Q?ngY9/oX0WXX9w9lZKitZMvFSvPcy8gmAkH/Qb51RMkAiRTcOLexMHkanSL3N?=
 =?us-ascii?Q?bQ1OH0lLGpxmHZ9gFBBC5JB+ybth8b1+VssZWhG0fniXj8U+Gmltt9adKzqf?=
 =?us-ascii?Q?LF2/0VZGCq7qOiyqMa3UjyJjQ+hN0ubnMjBbJdf3f4NCuPgmXmiwjeUUtowE?=
 =?us-ascii?Q?0VXEq9VR+D+OlvSjmMK8T7JzJt+sw9YK0gSSoCa0NEw4up5IYFQF6He+Bu+O?=
 =?us-ascii?Q?Xto8TcN84CfshAYJUqaS/fikm2ARf/8y7jtf60D2k8w8D1YNymlqirwJ55Yc?=
 =?us-ascii?Q?HhIyBxEw9XO4azu/+xv1XQlaWHPPkJgv6ZxzEKytrDMkdQXTexLc/X/cQPZB?=
 =?us-ascii?Q?Mj2Kq/cHsh6Dr9LlOanNPCB2mQjNhLZ7xx5lW7yeZ4avHFLZsIBh87yr5Iml?=
 =?us-ascii?Q?JV4Ml+V171sVaOcjn44OrqrKYuZ/IEz8FCyWTmhkWxxknmNHLhoWicyhzU0Z?=
 =?us-ascii?Q?u9kW9rBqrtLbdYLZdgnw8pjl0vKMwvzUbF8sHF6lFHLOPutY37qljGJM/KTv?=
 =?us-ascii?Q?EeyE9i7Dz1fOCoEPHCd/DNshgb8roqqJqareIm6loYps/dTbfb0/1pZZtKaa?=
 =?us-ascii?Q?K1EkaUS9WJEQbQoPu5G7r2nxiCG8xN/90yUUJWizZH1ReC5JFofoag4sA8/l?=
 =?us-ascii?Q?jIYv1fwq9vK+3DWCX7u4OuiWKjh8za8cfCalsbRFQlzKGqDamp1lUb9Z3Rq8?=
 =?us-ascii?Q?i2EMpjUucvtATpfK0HhV1Dc6ih+p8XMF/VfL1wM2kkaH1Ncu9ySP0ZtKoQwT?=
 =?us-ascii?Q?VcadebOfE40DhuETiNeduaYyNeHRHOkhzUnITkyG/d3U1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lCI1zGV1EZTrKbbnH4CpWeJwEKBMuS+38EsU+G9W/XQghjduP9L2SWzBAxJO?=
 =?us-ascii?Q?e4H873ynGMaT+sOzZKZbwUrBl1XdtZA4iPrsyVIOauJf3TCKiAqfgvmLdQnu?=
 =?us-ascii?Q?kODcbaqJWZjXGXOfZKWVqX8RK6m+D96/42U6XnyAJI1wckkHqHxT59rt82r3?=
 =?us-ascii?Q?JCs7oCquC3fmQCUiXHfUWN1GULaMCxzM9do6kvJVLr2vQzro7VyeRzRJCRmR?=
 =?us-ascii?Q?apDtWc8hl6WxwlvyDjpZxagFOo3IWjxZAu9z+mcjrVutFG2Gnp4IMMoAKfp4?=
 =?us-ascii?Q?MiIaYSPN+4DULpBM2yOn6VSaQ7eW8VdTq2B5E6yjfAD8xwPezM062Gkbau+E?=
 =?us-ascii?Q?sfml2sp66XuLR5u5Gx3aqbj+RnOGTtaXyWdA3otZ3vhrGQdQrpq0jdgOIyWg?=
 =?us-ascii?Q?UpxGQQ0K3gtd05dCrT1bj00WyvWOgXJy6UOGNsrqQmqeGem8J/CpGgZ02Zcm?=
 =?us-ascii?Q?chuT4+bNcWXRqSpvO+1+T9GiubDCMrm0AlWtOqB/iENw7Jjssuy89lcBGLIw?=
 =?us-ascii?Q?L2eau9ClJyosT++nnUjxFHEtypSbQm24DfuRb9hNCPVNDvNHAe0jx3iXW9re?=
 =?us-ascii?Q?2iDJOgQtu+O/JkZ0fnpJXLnJlI8tuqdWj0gZjuAOWJJxMzb75ZmfzBAvsleC?=
 =?us-ascii?Q?vPAzaggtD3763X9Ebdd8oPTe6T8zlQEyJdvoofyJmoctvjmy6zbtvaCxwWzU?=
 =?us-ascii?Q?GEx5OBBlqCy26tYXS4QmVxjOWTavXZKuwjJ7RjsRwlULs6NNkJzJDBSDpaNw?=
 =?us-ascii?Q?cw6cHArOKyjI/fmQDcR3znvHuNQ7wu4Gy2qWCdyzEGi+emImE6DQrz2Ri6jm?=
 =?us-ascii?Q?IPAOp1alxJVCsBFJxZI08kCVT+OmwhvaG7rueu42pmGkayPf+z4ezKY2FUnz?=
 =?us-ascii?Q?TnnQuYTzSNed6GKUujJxUCmZjQ27uINOZQbZpgQ7bRTkNZ2KOoflUhafLH93?=
 =?us-ascii?Q?vujBwavoaPsYs/Z4QPprrSosf1tJphSaH1miTEzO9qzDLc09tNHUeVxFfv0Y?=
 =?us-ascii?Q?ng/+SJFhLgUhNXI5pzRCLmvIS9FH+Y0Mgh9vRLwbf9vkAQYD3+WDlo8uRsWU?=
 =?us-ascii?Q?9X+d7An+xUoivdKHVrnlh8rO5zaVKunCOIq+yxebaiJI24GDNunb6KNRhJMb?=
 =?us-ascii?Q?5Gqf4K6kbeapqufyh9pHLXRt423k7nkSw7EDfwtcg87V4qtlkbQB9nBwqWiv?=
 =?us-ascii?Q?aSVwm980sWenp2kSF+sElJsn+1bvJC+3k56XKtSdkeWKTwgmMu2J8pMG87BJ?=
 =?us-ascii?Q?+9or+MNxl+MYfuaGlJWBH3juv2f7cdigfdnr3FkMZ0CbH88BG5m64FGeBKwB?=
 =?us-ascii?Q?YlUEfZ2fS7iHTvvmDCK2p8Lz9hNX5SWiK8s4E2T8ZrpW4zYmJGO+WieCU8Ip?=
 =?us-ascii?Q?QilJY/bU8Xlk8ZwxKD/5pSwugf1HaCUrT6kLelyTImMLgYZvTw4UU1HhxdQF?=
 =?us-ascii?Q?UlyOMi6NjNpB3kT/lt+IY2XSweKA63OHlezhtGRdBBWOcxBWmN/cEDaESYRO?=
 =?us-ascii?Q?r/10VLzjxyxxyA0i25qkRGljsysYAU/5JITsXmzgMwT5ajaWg6/t1YMZcEtJ?=
 =?us-ascii?Q?EfsH+uH7zS3nFYFYe/DyV7Vd81QSPLGzl7zmxUc7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001f350a-538d-4ec9-6d57-08dc75caf8fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 17:09:40.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld1fxovLZdWGt3cvYxrumwkIncflq5KjQ4NoL8clgcncBl1ZPV443XTIHmDe096obaaef7D7rUfFFZrsKS7QSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7414

On Thu, May 16, 2024 at 05:25:58PM +0200, Amelie Delaunay wrote:
> On 5/15/24 20:56, Frank Li wrote:
> > On Tue, Apr 23, 2024 at 02:32:55PM +0200, Amelie Delaunay wrote:
> > > STM32 DMA3 driver supports the 3 hardware configurations of the STM32 DMA3
> > > controller:
...
> > > +	writel_relaxed(hwdesc->cdar, ddata->base + STM32_DMA3_CDAR(id));
> > > +	writel_relaxed(hwdesc->cllr, ddata->base + STM32_DMA3_CLLR(id));
> > > +
> > > +	/* Clear any pending interrupts */
> > > +	csr = readl_relaxed(ddata->base + STM32_DMA3_CSR(id));
> > > +	if (csr & CSR_ALL_F)
> > > +		writel_relaxed(csr, ddata->base + STM32_DMA3_CFCR(id));
> > > +
> > > +	stm32_dma3_chan_dump_reg(chan);
> > > +
> > > +	ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(id));
> > > +	writel_relaxed(ccr | CCR_EN, ddata->base + STM32_DMA3_CCR(id));
> > 
> > This one should use writel instead of writel_relaxed because it need
> > dma_wmb() as barrier for preious write complete.
> > 
> > Frank
> > 
> 
> ddata->base is Device memory type thanks to ioremap() use, so it is strongly
> ordered and non-cacheable.
> DMA3 is outside CPU cluster, its registers are accessible through AHB bus.
> dma_wmb() (in case of writel instead of writel_relaxed) is useless in that
> case: it won't ensure the propagation on the bus is complete, and it will
> have impacts on the system.
> That's why CCR register is written once,  then it is read before CCR_EN is
> set and being written again, with _relaxed(), because registers are behind a
> bus, and ioremapped with Device memory type which ensures it is strongly
> ordered and non-cacheable.

regardless memory map, writel_relaxed() just make sure io write and read is
orderred, not necessary order with other memory access. only readl and
writel make sure order with other memory read/write.

1. Write src_addr to descriptor
2. dma_wmb()
3. Write "ready" to descriptor
4. enable channel or doorbell by write a register.

if 4 use writel_relaxe(). because 3 write to DDR, which difference place of
mmio, 4 may happen before 3.  Your can refer axi order model.

4 have to use ONE writel(), to make sure 3 already write to DDR.

You need use at least one writel() to make sure all nornmal memory finish.

> 
> > > +
> > > +	chan->dma_status = DMA_IN_PROGRESS;
> > > +
> > > +	dev_dbg(chan2dev(chan), "vchan %pK: started\n", &chan->vchan);
> > > +}
> > > +
> > > +static int stm32_dma3_chan_suspend(struct stm32_dma3_chan *chan, bool susp)
> > > +{
> > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > +	u32 csr, ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(chan->id)) & ~CCR_EN;
> > > +	int ret = 0;
> > > +
> > > +	if (susp)
> > > +		ccr |= CCR_SUSP;
> > > +	else
> > > +		ccr &= ~CCR_SUSP;
> > > +
> > > +	writel_relaxed(ccr, ddata->base + STM32_DMA3_CCR(chan->id));
> > > +
> > > +	if (susp) {
> > > +		ret = readl_relaxed_poll_timeout_atomic(ddata->base + STM32_DMA3_CSR(chan->id), csr,
> > > +							csr & CSR_SUSPF, 1, 10);
> > > +		if (!ret)
> > > +			writel_relaxed(CFCR_SUSPF, ddata->base + STM32_DMA3_CFCR(chan->id));
> > > +
> > > +		stm32_dma3_chan_dump_reg(chan);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void stm32_dma3_chan_reset(struct stm32_dma3_chan *chan)
> > > +{
> > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > +	u32 ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(chan->id)) & ~CCR_EN;
> > > +
> > > +	writel_relaxed(ccr |= CCR_RESET, ddata->base + STM32_DMA3_CCR(chan->id));
> > > +}
> > > +
> > > +static int stm32_dma3_chan_stop(struct stm32_dma3_chan *chan)
> > > +{
> > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > +	u32 ccr;
> > > +	int ret = 0;
> > > +
> > > +	chan->dma_status = DMA_COMPLETE;
> > > +
> > > +	/* Disable interrupts */
> > > +	ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(chan->id));
> > > +	writel_relaxed(ccr & ~(CCR_ALLIE | CCR_EN), ddata->base + STM32_DMA3_CCR(chan->id));
> > > +
> > > +	if (!(ccr & CCR_SUSP) && (ccr & CCR_EN)) {
> > > +		/* Suspend the channel */
> > > +		ret = stm32_dma3_chan_suspend(chan, true);
> > > +		if (ret)
> > > +			dev_warn(chan2dev(chan), "%s: timeout, data might be lost\n", __func__);
> > > +	}
> > > +
> > > +	/*
> > > +	 * Reset the channel: this causes the reset of the FIFO and the reset of the channel
> > > +	 * internal state, the reset of CCR_EN and CCR_SUSP bits.
> > > +	 */
> > > +	stm32_dma3_chan_reset(chan);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void stm32_dma3_chan_complete(struct stm32_dma3_chan *chan)
> > > +{
> > > +	if (!chan->swdesc)
> > > +		return;
> > > +
> > > +	vchan_cookie_complete(&chan->swdesc->vdesc);
> > > +	chan->swdesc = NULL;
> > > +	stm32_dma3_chan_start(chan);
> > > +}
> > > +
> > > +static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
> > > +{
> > > +	struct stm32_dma3_chan *chan = devid;
> > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > +	u32 misr, csr, ccr;
> > > +
> > > +	spin_lock(&chan->vchan.lock);
> > > +
> > > +	misr = readl_relaxed(ddata->base + STM32_DMA3_MISR);
> > > +	if (!(misr & MISR_MIS(chan->id))) {
> > > +		spin_unlock(&chan->vchan.lock);
> > > +		return IRQ_NONE;
> > > +	}
> > > +
> > > +	csr = readl_relaxed(ddata->base + STM32_DMA3_CSR(chan->id));
> > > +	ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(chan->id)) & CCR_ALLIE;
> > > +
> > > +	if (csr & CSR_TCF && ccr & CCR_TCIE) {
> > > +		if (chan->swdesc->cyclic)
> > > +			vchan_cyclic_callback(&chan->swdesc->vdesc);
> > > +		else
> > > +			stm32_dma3_chan_complete(chan);
> > > +	}
> > > +
> > > +	if (csr & CSR_USEF && ccr & CCR_USEIE) {
> > > +		dev_err(chan2dev(chan), "User setting error\n");
> > > +		chan->dma_status = DMA_ERROR;
> > > +		/* CCR.EN automatically cleared by HW */
> > > +		stm32_dma3_check_user_setting(chan);
> > > +		stm32_dma3_chan_reset(chan);
> > > +	}
> > > +
> > > +	if (csr & CSR_ULEF && ccr & CCR_ULEIE) {
> > > +		dev_err(chan2dev(chan), "Update link transfer error\n");
> > > +		chan->dma_status = DMA_ERROR;
> > > +		/* CCR.EN automatically cleared by HW */
> > > +		stm32_dma3_chan_reset(chan);
> > > +	}
> > > +
> > > +	if (csr & CSR_DTEF && ccr & CCR_DTEIE) {
> > > +		dev_err(chan2dev(chan), "Data transfer error\n");
> > > +		chan->dma_status = DMA_ERROR;
> > > +		/* CCR.EN automatically cleared by HW */
> > > +		stm32_dma3_chan_reset(chan);
> > > +	}
> > > +
> > > +	/*
> > > +	 * Half Transfer Interrupt may be disabled but Half Transfer Flag can be set,
> > > +	 * ensure HTF flag to be cleared, with other flags.
> > > +	 */
> > > +	csr &= (ccr | CCR_HTIE);
> > > +
> > > +	if (csr)
> > > +		writel_relaxed(csr, ddata->base + STM32_DMA3_CFCR(chan->id));
> > > +
> > > +	spin_unlock(&chan->vchan.lock);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
> > > +{
> > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > +	u32 id = chan->id, csemcr, ccid;
> > > +	int ret;
> > > +
> > > +	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
> > > +	if (ret < 0)
> > > +		return ret;
> > 
> > It doesn't prefer runtime pm get at alloc dma chan, many client driver
> > doesn't actual user dma when allocate dma chan.
> > 
> > Ideally, resume get when issue_pending. Please refer pl330.c.
> > 
> > You may add runtime pm later after enablement patch.
> > 
> > Frank
> > 
> 
> To well balance clock enable/disable, if pm_runtime_resume_and_get() (rather
> than pm_runtime_get_sync() which doesn't decrement the counter in case of
> error) is used when issue_pending, it means pm_runtime_put_sync() should be
> done when transfer ends.
> 
> terminate_all is not always called, so put_sync can't be used only there, it
> should be conditionnally used in terminate_all, but also in interrupt
> handler, on error events and on transfer completion event, provided that it
> is the last transfer complete event (last item of the linked-list).
> 
> For clients with high transfer rate, it means a lot of clock enable/disable.
> Moreover, DMA3 clock is managed by Secure OS. So it means a lot of
> non-secure/secure world transitions.
> 
> I prefer to keep the implementation as it is for now, and possibly propose
> runtime pm improvement later, with autosuspend.


Autosuspend is perfered. we try to use pm_runtime_get/put at channel alloc
/free before, but this solution are rejected by community.

you can leave clock on for this enablement patch and add runtime pm later
time.

Frank

> 
> Amelie
> 
> > > +
> > > +	/* Ensure the channel is free */
> > > +	if (chan->semaphore_mode &&
> > > +	    readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(chan->id)) & CSEMCR_SEM_MUTEX) {
> > > +		ret = -EBUSY;
> > > +		goto err_put_sync;
> > > +	}
> > > +
> > > +	chan->lli_pool = dmam_pool_create(dev_name(&c->dev->device), c->device->dev,
> > > +					  sizeof(struct stm32_dma3_hwdesc),
> > > +					  __alignof__(struct stm32_dma3_hwdesc), 0);
> > > +	if (!chan->lli_pool) {
> > > +		dev_err(chan2dev(chan), "Failed to create LLI pool\n");
> > > +		ret = -ENOMEM;
> > > +		goto err_put_sync;
> > > +	}
> > > +
> > > +	/* Take the channel semaphore */
> > > +	if (chan->semaphore_mode) {
> > > +		writel_relaxed(CSEMCR_SEM_MUTEX, ddata->base + STM32_DMA3_CSEMCR(id));
> > > +		csemcr = readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(id));
> > > +		ccid = FIELD_GET(CSEMCR_SEM_CCID, csemcr);
> > > +		/* Check that the channel is well taken */
> > > +		if (ccid != CCIDCFGR_CID1) {
> > > +			dev_err(chan2dev(chan), "Not under CID1 control (in-use by CID%d)\n", ccid);
> > > +			ret = -EPERM;
> > > +			goto err_pool_destroy;
> > > +		}
> > > +		dev_dbg(chan2dev(chan), "Under CID1 control (semcr=0x%08x)\n", csemcr);
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_pool_destroy:
> > > +	dmam_pool_destroy(chan->lli_pool);
> > > +	chan->lli_pool = NULL;
> > > +
> > > +err_put_sync:
> > > +	pm_runtime_put_sync(ddata->dma_dev.dev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void stm32_dma3_free_chan_resources(struct dma_chan *c)
> > > +{
> > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > +	unsigned long flags;
> > > +
> > > +	/* Ensure channel is in idle state */
> > > +	spin_lock_irqsave(&chan->vchan.lock, flags);
> > > +	stm32_dma3_chan_stop(chan);
> > > +	chan->swdesc = NULL;
> > > +	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > +
> > > +	vchan_free_chan_resources(to_virt_chan(c));
> > > +
> > > +	dmam_pool_destroy(chan->lli_pool);
> > > +	chan->lli_pool = NULL;
> > > +
> > > +	/* Release the channel semaphore */
> > > +	if (chan->semaphore_mode)
> > > +		writel_relaxed(0, ddata->base + STM32_DMA3_CSEMCR(chan->id));
> > > +
> > > +	pm_runtime_put_sync(ddata->dma_dev.dev);
> > > +
> > > +	/* Reset configuration */
> > > +	memset(&chan->dt_config, 0, sizeof(chan->dt_config));
> > > +	memset(&chan->dma_config, 0, sizeof(chan->dma_config));
> > > +}
> > > +
> > > +static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan *c,
> > > +								struct scatterlist *sgl,
> > > +								unsigned int sg_len,
> > > +								enum dma_transfer_direction dir,
> > > +								unsigned long flags, void *context)
> > > +{
> > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > +	struct stm32_dma3_swdesc *swdesc;
> > > +	struct scatterlist *sg;
> > > +	size_t len;
> > > +	dma_addr_t sg_addr, dev_addr, src, dst;
> > > +	u32 i, j, count, ctr1, ctr2;
> > > +	int ret;
> > > +
> > > +	count = sg_len;
> > > +	for_each_sg(sgl, sg, sg_len, i) {
> > > +		len = sg_dma_len(sg);
> > > +		if (len > STM32_DMA3_MAX_BLOCK_SIZE)
> > > +			count += DIV_ROUND_UP(len, STM32_DMA3_MAX_BLOCK_SIZE) - 1;
> > > +	}
> > > +
> > > +	swdesc = stm32_dma3_chan_desc_alloc(chan, count);
> > > +	if (!swdesc)
> > > +		return NULL;
> > > +
> > > +	/* sg_len and i correspond to the initial sgl; count and j correspond to the hwdesc LL */
> > > +	j = 0;
> > > +	for_each_sg(sgl, sg, sg_len, i) {
> > > +		sg_addr = sg_dma_address(sg);
> > > +		dev_addr = (dir == DMA_MEM_TO_DEV) ? chan->dma_config.dst_addr :
> > > +						     chan->dma_config.src_addr;
> > > +		len = sg_dma_len(sg);
> > > +
> > > +		do {
> > > +			size_t chunk = min_t(size_t, len, STM32_DMA3_MAX_BLOCK_SIZE);
> > > +
> > > +			if (dir == DMA_MEM_TO_DEV) {
> > > +				src = sg_addr;
> > > +				dst = dev_addr;
> > > +
> > > +				ret = stm32_dma3_chan_prep_hw(chan, dir, &swdesc->ccr, &ctr1, &ctr2,
> > > +							      src, dst, chunk);
> > > +
> > > +				if (FIELD_GET(CTR1_DINC, ctr1))
> > > +					dev_addr += chunk;
> > > +			} else { /* (dir == DMA_DEV_TO_MEM || dir == DMA_MEM_TO_MEM) */
> > > +				src = dev_addr;
> > > +				dst = sg_addr;
> > > +
> > > +				ret = stm32_dma3_chan_prep_hw(chan, dir, &swdesc->ccr, &ctr1, &ctr2,
> > > +							      src, dst, chunk);
> > > +
> > > +				if (FIELD_GET(CTR1_SINC, ctr1))
> > > +					dev_addr += chunk;
> > > +			}
> > > +
> > > +			if (ret)
> > > +				goto err_desc_free;
> > > +
> > > +			stm32_dma3_chan_prep_hwdesc(chan, swdesc, j, src, dst, chunk,
> > > +						    ctr1, ctr2, j == (count - 1), false);
> > > +
> > > +			sg_addr += chunk;
> > > +			len -= chunk;
> > > +			j++;
> > > +		} while (len);
> > > +	}
> > > +
> > > +	/* Enable Error interrupts */
> > > +	swdesc->ccr |= CCR_USEIE | CCR_ULEIE | CCR_DTEIE;
> > > +	/* Enable Transfer state interrupts */
> > > +	swdesc->ccr |= CCR_TCIE;
> > > +
> > > +	swdesc->cyclic = false;
> > > +
> > > +	return vchan_tx_prep(&chan->vchan, &swdesc->vdesc, flags);
> > > +
> > > +err_desc_free:
> > > +	stm32_dma3_chan_desc_free(chan, swdesc);
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > > +static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
> > > +{
> > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > +
> > > +	if (!chan->fifo_size) {
> > > +		caps->max_burst = 0;
> > > +		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > +		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > +	} else {
> > > +		/* Burst transfer should not exceed half of the fifo size */
> > > +		caps->max_burst = chan->max_burst;
> > > +		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
> > > +			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > +			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > +		}
> > > +	}
> > > +}
> > > +
> > > +static int stm32_dma3_config(struct dma_chan *c, struct dma_slave_config *config)
> > > +{
> > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > +
> > > +	memcpy(&chan->dma_config, config, sizeof(*config));
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int stm32_dma3_terminate_all(struct dma_chan *c)
> > > +{
> > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > +	unsigned long flags;
> > > +	LIST_HEAD(head);
> > > +
> > > +	spin_lock_irqsave(&chan->vchan.lock, flags);
> > > +
> > > +	if (chan->swdesc) {
> > > +		vchan_terminate_vdesc(&chan->swdesc->vdesc);
> > > +		chan->swdesc = NULL;
> > > +	}
> > > +
> > > +	stm32_dma3_chan_stop(chan);
> > > +
> > > +	vchan_get_all_descriptors(&chan->vchan, &head);
> > > +
> > > +	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > +	vchan_dma_desc_free_list(&chan->vchan, &head);
> > > +
> > > +	dev_dbg(chan2dev(chan), "vchan %pK: terminated\n", &chan->vchan);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void stm32_dma3_synchronize(struct dma_chan *c)
> > > +{
> > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > +
> > > +	vchan_synchronize(&chan->vchan);
> > > +}
> > > +
> > > +static void stm32_dma3_issue_pending(struct dma_chan *c)
> > > +{
> > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&chan->vchan.lock, flags);
> > > +
> > > +	if (vchan_issue_pending(&chan->vchan) && !chan->swdesc) {
> > > +		dev_dbg(chan2dev(chan), "vchan %pK: issued\n", &chan->vchan);
> > > +		stm32_dma3_chan_start(chan);
> > > +	}
> > > +
> > > +	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > +}
> > > +
> > > +static bool stm32_dma3_filter_fn(struct dma_chan *c, void *fn_param)
> > > +{
> > > +	struct stm32_dma3_chan *chan = to_stm32_dma3_chan(c);
> > > +	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> > > +	struct stm32_dma3_dt_conf *conf = fn_param;
> > > +	u32 mask, semcr;
> > > +	int ret;
> > > +
> > > +	dev_dbg(c->device->dev, "%s(%s): req_line=%d ch_conf=%08x tr_conf=%08x\n",
> > > +		__func__, dma_chan_name(c), conf->req_line, conf->ch_conf, conf->tr_conf);
> > > +
> > > +	if (!of_property_read_u32(c->device->dev->of_node, "dma-channel-mask", &mask))
> > > +		if (!(mask & BIT(chan->id)))
> > > +			return false;
> > > +
> > > +	ret = pm_runtime_resume_and_get(ddata->dma_dev.dev);
> > > +	if (ret < 0)
> > > +		return false;
> > > +	semcr = readl_relaxed(ddata->base + STM32_DMA3_CSEMCR(chan->id));
> > > +	pm_runtime_put_sync(ddata->dma_dev.dev);
> > > +
> > > +	/* Check if chan is free */
> > > +	if (semcr & CSEMCR_SEM_MUTEX)
> > > +		return false;
> > > +
> > > +	/* Check if chan fifo fits well */
> > > +	if (FIELD_GET(STM32_DMA3_DT_FIFO, conf->ch_conf) != chan->fifo_size)
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static struct dma_chan *stm32_dma3_of_xlate(struct of_phandle_args *dma_spec, struct of_dma *ofdma)
> > > +{
> > > +	struct stm32_dma3_ddata *ddata = ofdma->of_dma_data;
> > > +	dma_cap_mask_t mask = ddata->dma_dev.cap_mask;
> > > +	struct stm32_dma3_dt_conf conf;
> > > +	struct stm32_dma3_chan *chan;
> > > +	struct dma_chan *c;
> > > +
> > > +	if (dma_spec->args_count < 3) {
> > > +		dev_err(ddata->dma_dev.dev, "Invalid args count\n");
> > > +		return NULL;
> > > +	}
> > > +
> > > +	conf.req_line = dma_spec->args[0];
> > > +	conf.ch_conf = dma_spec->args[1];
> > > +	conf.tr_conf = dma_spec->args[2];
> > > +
> > > +	if (conf.req_line >= ddata->dma_requests) {
> > > +		dev_err(ddata->dma_dev.dev, "Invalid request line\n");
> > > +		return NULL;
> > > +	}
> > > +
> > > +	/* Request dma channel among the generic dma controller list */
> > > +	c = dma_request_channel(mask, stm32_dma3_filter_fn, &conf);
> > > +	if (!c) {
> > > +		dev_err(ddata->dma_dev.dev, "No suitable channel found\n");
> > > +		return NULL;
> > > +	}
> > > +
> > > +	chan = to_stm32_dma3_chan(c);
> > > +	chan->dt_config = conf;
> > > +
> > > +	return c;
> > > +}
> > > +
> > > +static u32 stm32_dma3_check_rif(struct stm32_dma3_ddata *ddata)
> > > +{
> > > +	u32 chan_reserved, mask = 0, i, ccidcfgr, invalid_cid = 0;
> > > +
> > > +	/* Reserve Secure channels */
> > > +	chan_reserved = readl_relaxed(ddata->base + STM32_DMA3_SECCFGR);
> > > +
> > > +	/*
> > > +	 * CID filtering must be configured to ensure that the DMA3 channel will inherit the CID of
> > > +	 * the processor which is configuring and using the given channel.
> > > +	 * In case CID filtering is not configured, dma-channel-mask property can be used to
> > > +	 * specify available DMA channels to the kernel.
> > > +	 */
> > > +	of_property_read_u32(ddata->dma_dev.dev->of_node, "dma-channel-mask", &mask);
> > > +
> > > +	/* Reserve !CID-filtered not in dma-channel-mask, static CID != CID1, CID1 not allowed */
> > > +	for (i = 0; i < ddata->dma_channels; i++) {
> > > +		ccidcfgr = readl_relaxed(ddata->base + STM32_DMA3_CCIDCFGR(i));
> > > +
> > > +		if (!(ccidcfgr & CCIDCFGR_CFEN)) { /* !CID-filtered */
> > > +			invalid_cid |= BIT(i);
> > > +			if (!(mask & BIT(i))) /* Not in dma-channel-mask */
> > > +				chan_reserved |= BIT(i);
> > > +		} else { /* CID-filtered */
> > > +			if (!(ccidcfgr & CCIDCFGR_SEM_EN)) { /* Static CID mode */
> > > +				if (FIELD_GET(CCIDCFGR_SCID, ccidcfgr) != CCIDCFGR_CID1)
> > > +					chan_reserved |= BIT(i);
> > > +			} else { /* Semaphore mode */
> > > +				if (!FIELD_GET(CCIDCFGR_SEM_WLIST_CID1, ccidcfgr))
> > > +					chan_reserved |= BIT(i);
> > > +				ddata->chans[i].semaphore_mode = true;
> > > +			}
> > > +		}
> > > +		dev_dbg(ddata->dma_dev.dev, "chan%d: %s mode, %s\n", i,
> > > +			!(ccidcfgr & CCIDCFGR_CFEN) ? "!CID-filtered" :
> > > +			ddata->chans[i].semaphore_mode ? "Semaphore" : "Static CID",
> > > +			(chan_reserved & BIT(i)) ? "denied" :
> > > +			mask & BIT(i) ? "force allowed" : "allowed");
> > > +	}
> > > +
> > > +	if (invalid_cid)
> > > +		dev_warn(ddata->dma_dev.dev, "chan%*pbl have invalid CID configuration\n",
> > > +			 ddata->dma_channels, &invalid_cid);
> > > +
> > > +	return chan_reserved;
> > > +}
> > > +
> > > +static const struct of_device_id stm32_dma3_of_match[] = {
> > > +	{ .compatible = "st,stm32-dma3", },
> > > +	{ /* sentinel */},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, stm32_dma3_of_match);
> > > +
> > > +static int stm32_dma3_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	struct stm32_dma3_ddata *ddata;
> > > +	struct reset_control *reset;
> > > +	struct stm32_dma3_chan *chan;
> > > +	struct dma_device *dma_dev;
> > > +	u32 master_ports, chan_reserved, i, verr;
> > > +	u64 hwcfgr;
> > > +	int ret;
> > > +
> > > +	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
> > > +	if (!ddata)
> > > +		return -ENOMEM;
> > > +	platform_set_drvdata(pdev, ddata);
> > > +
> > > +	dma_dev = &ddata->dma_dev;
> > > +
> > > +	ddata->base = devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(ddata->base))
> > > +		return PTR_ERR(ddata->base);
> > > +
> > > +	ddata->clk = devm_clk_get(&pdev->dev, NULL);
> > > +	if (IS_ERR(ddata->clk))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(ddata->clk), "Failed to get clk\n");
> > > +
> > > +	reset = devm_reset_control_get_optional(&pdev->dev, NULL);
> > > +	if (IS_ERR(reset))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(reset), "Failed to get reset\n");
> > > +
> > > +	ret = clk_prepare_enable(ddata->clk);
> > > +	if (ret)
> > > +		return dev_err_probe(&pdev->dev, ret, "Failed to enable clk\n");
> > > +
> > > +	reset_control_reset(reset);
> > > +
> > > +	INIT_LIST_HEAD(&dma_dev->channels);
> > > +
> > > +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> > > +	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
> > > +	dma_dev->dev = &pdev->dev;
> > > +	/*
> > > +	 * This controller supports up to 8-byte buswidth depending on the port used and the
> > > +	 * channel, and can only access address at even boundaries, multiple of the buswidth.
> > > +	 */
> > > +	dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
> > > +	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > > +				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > > +				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > > +				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > +	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > > +				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > > +				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > > +				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > +	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
> > > +
> > > +	dma_dev->descriptor_reuse = true;
> > > +	dma_dev->max_sg_burst = STM32_DMA3_MAX_SEG_SIZE;
> > > +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > > +	dma_dev->device_alloc_chan_resources = stm32_dma3_alloc_chan_resources;
> > > +	dma_dev->device_free_chan_resources = stm32_dma3_free_chan_resources;
> > > +	dma_dev->device_prep_slave_sg = stm32_dma3_prep_slave_sg;
> > > +	dma_dev->device_caps = stm32_dma3_caps;
> > > +	dma_dev->device_config = stm32_dma3_config;
> > > +	dma_dev->device_terminate_all = stm32_dma3_terminate_all;
> > > +	dma_dev->device_synchronize = stm32_dma3_synchronize;
> > > +	dma_dev->device_tx_status = dma_cookie_status;
> > > +	dma_dev->device_issue_pending = stm32_dma3_issue_pending;
> > > +
> > > +	/* if dma_channels is not modified, get it from hwcfgr1 */
> > > +	if (of_property_read_u32(np, "dma-channels", &ddata->dma_channels)) {
> > > +		hwcfgr = readl_relaxed(ddata->base + STM32_DMA3_HWCFGR1);
> > > +		ddata->dma_channels = FIELD_GET(G_NUM_CHANNELS, hwcfgr);
> > > +	}
> > > +
> > > +	/* if dma_requests is not modified, get it from hwcfgr2 */
> > > +	if (of_property_read_u32(np, "dma-requests", &ddata->dma_requests)) {
> > > +		hwcfgr = readl_relaxed(ddata->base + STM32_DMA3_HWCFGR2);
> > > +		ddata->dma_requests = FIELD_GET(G_MAX_REQ_ID, hwcfgr) + 1;
> > > +	}
> > > +
> > > +	/* G_MASTER_PORTS, G_M0_DATA_WIDTH_ENC, G_M1_DATA_WIDTH_ENC in HWCFGR1 */
> > > +	hwcfgr = readl_relaxed(ddata->base + STM32_DMA3_HWCFGR1);
> > > +	master_ports = FIELD_GET(G_MASTER_PORTS, hwcfgr);
> > > +
> > > +	ddata->ports_max_dw[0] = FIELD_GET(G_M0_DATA_WIDTH_ENC, hwcfgr);
> > > +	if (master_ports == AXI64 || master_ports == AHB32) /* Single master port */
> > > +		ddata->ports_max_dw[1] = DW_INVALID;
> > > +	else /* Dual master ports */
> > > +		ddata->ports_max_dw[1] = FIELD_GET(G_M1_DATA_WIDTH_ENC, hwcfgr);
> > > +
> > > +	ddata->chans = devm_kcalloc(&pdev->dev, ddata->dma_channels, sizeof(*ddata->chans),
> > > +				    GFP_KERNEL);
> > > +	if (!ddata->chans) {
> > > +		ret = -ENOMEM;
> > > +		goto err_clk_disable;
> > > +	}
> > > +
> > > +	chan_reserved = stm32_dma3_check_rif(ddata);
> > > +
> > > +	if (chan_reserved == GENMASK(ddata->dma_channels - 1, 0)) {
> > > +		ret = -ENODEV;
> > > +		dev_err_probe(&pdev->dev, ret, "No channel available, abort registration\n");
> > > +		goto err_clk_disable;
> > > +	}
> > > +
> > > +	/* G_FIFO_SIZE x=0..7 in HWCFGR3 and G_FIFO_SIZE x=8..15 in HWCFGR4 */
> > > +	hwcfgr = readl_relaxed(ddata->base + STM32_DMA3_HWCFGR3);
> > > +	hwcfgr |= ((u64)readl_relaxed(ddata->base + STM32_DMA3_HWCFGR4)) << 32;
> > > +
> > > +	for (i = 0; i < ddata->dma_channels; i++) {
> > > +		if (chan_reserved & BIT(i))
> > > +			continue;
> > > +
> > > +		chan = &ddata->chans[i];
> > > +		chan->id = i;
> > > +		chan->fifo_size = get_chan_hwcfg(i, G_FIFO_SIZE(i), hwcfgr);
> > > +		/* If chan->fifo_size > 0 then half of the fifo size, else no burst when no FIFO */
> > > +		chan->max_burst = (chan->fifo_size) ? (1 << (chan->fifo_size + 1)) / 2 : 0;
> > > +		chan->vchan.desc_free = stm32_dma3_chan_vdesc_free;
> > > +
> > > +		vchan_init(&chan->vchan, dma_dev);
> > > +	}
> > > +
> > > +	ret = dmaenginem_async_device_register(dma_dev);
> > > +	if (ret)
> > > +		goto err_clk_disable;
> > > +
> > > +	for (i = 0; i < ddata->dma_channels; i++) {
> > > +		if (chan_reserved & BIT(i))
> > > +			continue;
> > > +
> > > +		ret = platform_get_irq(pdev, i);
> > > +		if (ret < 0)
> > > +			goto err_clk_disable;
> > > +
> > > +		chan = &ddata->chans[i];
> > > +		chan->irq = ret;
> > > +
> > > +		ret = devm_request_irq(&pdev->dev, chan->irq, stm32_dma3_chan_irq, 0,
> > > +				       dev_name(chan2dev(chan)), chan);
> > > +		if (ret) {
> > > +			dev_err_probe(&pdev->dev, ret, "Failed to request channel %s IRQ\n",
> > > +				      dev_name(chan2dev(chan)));
> > > +			goto err_clk_disable;
> > > +		}
> > > +	}
> > > +
> > > +	ret = of_dma_controller_register(np, stm32_dma3_of_xlate, ddata);
> > > +	if (ret) {
> > > +		dev_err_probe(&pdev->dev, ret, "Failed to register controller\n");
> > > +		goto err_clk_disable;
> > > +	}
> > > +
> > > +	verr = readl_relaxed(ddata->base + STM32_DMA3_VERR);
> > > +
> > > +	pm_runtime_set_active(&pdev->dev);
> > > +	pm_runtime_enable(&pdev->dev);
> > > +	pm_runtime_get_noresume(&pdev->dev);
> > > +	pm_runtime_put(&pdev->dev);
> > > +
> > > +	dev_info(&pdev->dev, "STM32 DMA3 registered rev:%lu.%lu\n",
> > > +		 FIELD_GET(VERR_MAJREV, verr), FIELD_GET(VERR_MINREV, verr));
> > > +
> > > +	return 0;
> > > +
> > > +err_clk_disable:
> > > +	clk_disable_unprepare(ddata->clk);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void stm32_dma3_remove(struct platform_device *pdev)
> > > +{
> > > +	pm_runtime_disable(&pdev->dev);
> > > +}
> > > +
> > > +static int stm32_dma3_runtime_suspend(struct device *dev)
> > > +{
> > > +	struct stm32_dma3_ddata *ddata = dev_get_drvdata(dev);
> > > +
> > > +	clk_disable_unprepare(ddata->clk);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int stm32_dma3_runtime_resume(struct device *dev)
> > > +{
> > > +	struct stm32_dma3_ddata *ddata = dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	ret = clk_prepare_enable(ddata->clk);
> > > +	if (ret)
> > > +		dev_err(dev, "Failed to enable clk: %d\n", ret);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static const struct dev_pm_ops stm32_dma3_pm_ops = {
> > > +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> > > +	RUNTIME_PM_OPS(stm32_dma3_runtime_suspend, stm32_dma3_runtime_resume, NULL)
> > > +};
> > > +
> > > +static struct platform_driver stm32_dma3_driver = {
> > > +	.probe = stm32_dma3_probe,
> > > +	.remove_new = stm32_dma3_remove,
> > > +	.driver = {
> > > +		.name = "stm32-dma3",
> > > +		.of_match_table = stm32_dma3_of_match,
> > > +		.pm = pm_ptr(&stm32_dma3_pm_ops),
> > > +	},
> > > +};
> > > +
> > > +static int __init stm32_dma3_init(void)
> > > +{
> > > +	return platform_driver_register(&stm32_dma3_driver);
> > > +}
> > > +
> > > +subsys_initcall(stm32_dma3_init);
> > > +
> > > +MODULE_DESCRIPTION("STM32 DMA3 controller driver");
> > > +MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@foss.st.com>");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.25.1
> > > 

