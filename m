Return-Path: <dmaengine+bounces-8242-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA64D1B8CF
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 23:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61B5B3019BB2
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 22:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4F352C4F;
	Tue, 13 Jan 2026 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aHF/232d"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933D31AF3B
	for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768342266; cv=fail; b=DlvUY+FZUaDfbYXO6OOed+l3vkfEO+Du2+S+4XrQFr4YP0R0fBBg9QtM0eP8K7ZELqoPC3PWq1VlM5RuOoEApeXMccCRTBjEIy+mt+If3J0+H/NO0P5TcJoUhwJLlW8wq62YiUT+qBDqwbYfDqwrk+nqTCnHZQvRyalWWuLQtyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768342266; c=relaxed/simple;
	bh=punOsh54YofJcXF4ouCRfb/8JHk+M9VtsQ0JY45v2o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZHJAcM968HsOU5VhmUCzHq0BDz/4qyv7BotiRo78XZ0bW2Gmc+Edeh6626uGYe2ELccsgwZOxEF+QD1tSGwZOBdhPg+gwh/uE6Ijjz3I8nodkbmGTm0rcUESnKnBFvewkZ8otYH4PVg+tNCGcHdqNr2mw7AAQyMM2YcTaLlN64Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aHF/232d; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5RJgqFFT9DZsJpAON5lpl7trGewlA0LpSbDDFSWTSZARaNCsHMefpljGqib0prSPkFcSMwqGialOBCfdItSjCvaZHHoTyZaNQZbmm+yQM55zUryQkmZbJLcSj7/0e1j1GU0JzAhP2oGXR5es0o2lF4I6Gd997+Hj1UCZsB2Wy4AXr6vbvuEchCy+noG08lkjNBtSVr/w2KhfkInOk3kbiqU3V0VMxFpWMQvuLlQsL/0xERmHfnrCD15fNKwsHZDzygnNxGa5a2TmfZF3v0pHghtdEacm+Kuh5ePg23kFFdJKxzU77tBEfNS1YnaBD5PjNY5DCMQcBWzWXkzzCkmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XQsm7q/bHMtcs0MTZeZYEVR2Zqs/4vuCgirRbHZwA0=;
 b=PsWwXRt5jUW6NWeNTFnFMHaITyPbGEwhV7dNb9aOVhdfmsDiq5ZkvOcAfIcYLpA64IIRwEyWVkcPKnXfoKouabi6Tt8gOPtxfM6Ce7DPtfH5U8tljljYdkTCEZ5m5wiC209CBmPptPU1yOzSUgQjwGXym1+io9Ovo7/C86l7Cq21DNZCuew+8O0iIbIycwzEBNU0G4AMj6GmQuzjsVvzW40rqprEtgx+3WLcO4eSSdUAxNybowKFer4/tC0+54SDHXHXLREbH3WrSKIiA1QV7yoqBGvTeTq6cc0rvNhk7P36lXdjgGYedoLV0Zz+Ce14YSXwFAy5Wi4TqIrc5JQtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XQsm7q/bHMtcs0MTZeZYEVR2Zqs/4vuCgirRbHZwA0=;
 b=aHF/232dA0n1aCA9GEUgIzFOBlIvvFLtYaEgj8GrzSntvVBVIRIH6jr9zmJ0QXbx8g5zgaaskWTjSATFt+krMJ4XYSaJqpwFZRg3TIPXShPc4CwYBiEhijdLaSn1wLOsUMgbVf84IiRstQfVTOC9gowJ9ZSE2DW2Yxiy/umzEoBvClsJ4v7o+Os61WB5KyYngFk/j/8dlBFGc5jSaoH0KdqJF6X/Is8SI9Mder446vBATUrYH1ucG4J22FF4mOiijNfGZh+OmET9gcE5OyZSgvoLv000nrrg9FuCfQCByfskapeyXbogncfuCu2/njg6Dnpewo+/tIwI5OX8Blr11A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS8PR04MB8500.eurprd04.prod.outlook.com (2603:10a6:20b:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 13 Jan
 2026 22:09:49 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Tue, 13 Jan 2026
 22:09:49 +0000
Date: Tue, 13 Jan 2026 17:09:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 3/3] dmaengine: switchtec-dma: Implement descriptor
 submission
Message-ID: <aWbCpnS8b+jw1Vea@lizhi-Precision-Tower-5810>
References: <20260112184017.2601-1-logang@deltatee.com>
 <20260112184017.2601-4-logang@deltatee.com>
 <aWVhOZnWUhIBbI+I@lizhi-Precision-Tower-5810>
 <f0611171-1f26-47dc-b40c-f49105c4a864@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0611171-1f26-47dc-b40c-f49105c4a864@deltatee.com>
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS8PR04MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: ed45ed2e-d5c8-4567-92c6-08de52f077ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gw72WB0YQ0t65UFjLkqmc5ZaarAtSMgz8dFupX2O/l0jHuSbr5ZVujoG8ATE?=
 =?us-ascii?Q?63UjBXa7s+IJ4qdIKsHxYprrH0hYKzjz8yN7VcI4PvlWL1bXHvTsO1GWS3M7?=
 =?us-ascii?Q?uHnUI2ht1KaLpkPFsPXaFCTAM+MKGpqWkm1Ul8nSwH+qnImKeTu+c+uOsUwD?=
 =?us-ascii?Q?gbqSwWAGHTm9OQnSt4n9xfOm3xSL0MqZsC99jkTTkh6zsZLJ1KFa02pOaqBn?=
 =?us-ascii?Q?9nCm1YQHlKkzMwxVwtR5w1WcQYEpBSLxwnMGOfzCRWbGEmudgFSt77Y+XwyO?=
 =?us-ascii?Q?Bi35qYPJiSbr0jjJAURkr6F+okNhAmUiycQ9LsRlolAv5Z3FhLMxyhMTMxhS?=
 =?us-ascii?Q?9qmp45Zjdr3QhH2PCF2LrgogCogkcMVMwkkolMVOA1tAisLuwFid5u12cmS/?=
 =?us-ascii?Q?vmhvbczfzaCF5oRasT89UAbb5vXBobRPTRPRXB8ek057dJ9cYzOvhHQqxvEK?=
 =?us-ascii?Q?uFpIpTvCLLHcbDtzZSa1pajSEfDZzPyxGN0t+TtHLRSX8f2I+j7mLDWYtNGe?=
 =?us-ascii?Q?qKR0J9L/JNkC+1mCiAfwk/KLKyT/qiAy1AwVPlldfuR4lgTgtUcQwIrUvugw?=
 =?us-ascii?Q?or/sY2fSR7TKIR/wABulAtcWOk+KoaSt6kf74tTyfD9lpZu95ZZfTZchcqOS?=
 =?us-ascii?Q?U4qJgSMBQUAHSERc0t5OsnMbIEO1+ns+mRtacV/jGShz/zjeX3kvzgWFPGHH?=
 =?us-ascii?Q?2TJBm3L0lc8dF38UDaCWIG3A0F/GM8tz9RLFpuzznqcDPccjye1NyEbStAcj?=
 =?us-ascii?Q?JkabKqheA8tG7g5jNluJBHdl1oLBwMz9tNqyzLltHwMpHOS9v3L5Q1jjp6lD?=
 =?us-ascii?Q?RHTS/9BcPaqbEKxItSFZFzYo6oTxvwinY7omHCmx+bdZcz+BzhBglxM/N1Fx?=
 =?us-ascii?Q?hePqmDusPGsYaZZ0McLxSzgtc5Zd/bg1+v7qHfqok0WEwOLBTep5eN/pbjIL?=
 =?us-ascii?Q?78t+6i2QAGkEEQhluIleZpxucbRn5k7udKca6ftCadxHZcciXsgzfqCzv0JA?=
 =?us-ascii?Q?tb++/jaRPy7ygNk33lxqI5HlQJiAru88s2Myi6hmDn/2QmXqyu6JiCdR1Pdb?=
 =?us-ascii?Q?HWnoRInjCS2yLwebiEvGYbj63GNngKZwXW/hGAj5+Q9rd0SaGo08wm5caIfr?=
 =?us-ascii?Q?JFa1fg/HETWt2c7B07oy8dTq1u+Ygi48l2uET2FzHVU5Jsm8RGFfMJRrNz2M?=
 =?us-ascii?Q?DSFK20NsLmDCTspx9ozYuEvPi73nK+VL9kgQtS+im0o8NuSJQUXbmZVrGucH?=
 =?us-ascii?Q?XTTDs1LBeWTvTllf8cbDULADIJri+EeYcQWsOFrLaLeZNZuzTU6LjH8LGhLF?=
 =?us-ascii?Q?PUQow+udDtZCoyVtJPneSephbYcLEqss9L+mdWMypc0+Q2SQSD8lSBo4AScE?=
 =?us-ascii?Q?efKqraxvypje9yivwQR7+2sdORdMp2EfTAXf/7yrNghh1AI9C08wi2F9jV9z?=
 =?us-ascii?Q?V0WkiISgUpNk2gANMRDKfkYWYl0ABOI1Y+0UZ4L9CFfgefiQackFPVb4c91w?=
 =?us-ascii?Q?zdpN2fb3/az97lFHlmGmpeW9QC93srnvIi+Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G44R4J1z0KGp+KrGabOcE6QU6xWrIUqu969X8ruyBZeXQ21Xq4wl/btaAp2t?=
 =?us-ascii?Q?1SB3b7dO3o70iPk2IfeNIZRf8Fx/JIH2NB95W5Td98Ce9q/77LMyFQJh7YmD?=
 =?us-ascii?Q?PAGv2ZUdaURyKoeyHSjniusInvHIyrNTnL1u1h1v634eAuk0J6EKPuTClvAL?=
 =?us-ascii?Q?lw7ny/Tf0qLytRF3pLKXe2x7jwb8dtxJ78b5GT/25nPiSQsJgvIcZeBQBdNK?=
 =?us-ascii?Q?LffU+g3rkzeNCPEK5wjIs42ZAT2JGrgjkAh30h/fdyZUwcY1hGclG8OvGYNH?=
 =?us-ascii?Q?5XH2SqxCbFtpHv11xKvdRU3QklLq9xGrn8uQaxA1nfO+JFxFpGUPYsvUgt6W?=
 =?us-ascii?Q?ji2Yg/BLcZlersiTQDoWei2Ljd5RngYSEthL1m+qD1Un3Dr9qjFs6GN8sROc?=
 =?us-ascii?Q?yiPM7iguBac1v4iA9xM3+2mj+KBvzvjHmREuIvS+jKwNbV8oPn+EXOGUs+eM?=
 =?us-ascii?Q?TtMRnvE5euUozMg7y+pXVtjozJhPerOi4mWLJ5+xNKZTB/WF1Q6e/Cjpgkl1?=
 =?us-ascii?Q?losIztRuD5iXfrf/Si6nKR8dZD471XkL15L8ix8oMjrQeQQc5G1cqEXJPgb+?=
 =?us-ascii?Q?01maEQphg1aLZTtHK0DAg/fitw+shfHgPNmGWA3zYb8mO2FLOb3cpR0U8LoJ?=
 =?us-ascii?Q?IaBsaSwMKS6i+kdwgmsPTSXMUElU/Wv7026AXynXr57F2GNz50Eem9tq85dT?=
 =?us-ascii?Q?43dNS66HcKgDAwy5tVmaakXqDS8XfA682BEJhUxEGX28YLRgbzlh4djOGruL?=
 =?us-ascii?Q?h/2sCZQZDnjsfu6w1ey6oM8VkvU1M634PFiANBFiPWE+KBVHkuVIdwZBBlOW?=
 =?us-ascii?Q?wcvErJ7FOsNal2kifTmTMvAT4habP9wXkHyQCOQ2X1ToPlaE9oYz+n7G/oT1?=
 =?us-ascii?Q?zPFIqQS5F8zys4UqBd6Hm636w1nSO/W2M7K0V8fHCTDDf5BPIja4fHcwszuq?=
 =?us-ascii?Q?XwEM9P7ubwaGdbuaRaKtcs1YLhfcFYlJTt13EZ6ZktmNWeb7CR5SijDASyow?=
 =?us-ascii?Q?lDmtTMycALL2F44TCQ3b39R0CrMeCK799KRMIwbMN1S7tJsDfuEqvNmrcaSg?=
 =?us-ascii?Q?jjmObma9yq4nV2nU8FJ2oZMvT2yKEckh0T3Q6wEEqy9mc9i6EDn2tqJP27OC?=
 =?us-ascii?Q?pm08fGfKlaLLssIPIr0ZvA3qVfK/OpLDrKAyQfcMdvA35xwog37a640E1Q+R?=
 =?us-ascii?Q?JFYcHMZuToJnmYOzWHB6KuZxpe1w+s7VU/5GL0AhbkyrCkGu6bQU7i4s4iUS?=
 =?us-ascii?Q?sHpCT0k6mVILhKqBVduH3nAUIjlEi50o0oe7NrqZDIKwZBdNbjn2F2W+0t+E?=
 =?us-ascii?Q?3qRCyWotXK2vCgw+PdUOLkTVkcUliUbEKK/2ucl3lVsiruiIq23lX1M8OyBQ?=
 =?us-ascii?Q?USFivQnk9QMax6PcO9AGpiImANYvn9gl38xTL+X9GMy8YbdrWFT/8LuX33wt?=
 =?us-ascii?Q?G4XTCjr00KlqXDYQqBnsAzb2J6M6QCgu58Jb2RQFz90RR7uFRg4zuibGyjoa?=
 =?us-ascii?Q?qhdPYbZFsGy5Wkm8V0BieMpClPYFuf98ZhUN0W0PW15NAMQ9WN8V8gTLOntR?=
 =?us-ascii?Q?Ta6p1ogesLaQiOrY8BMDGcWwj0+N3YhrxhyKPs/ilawXhPTehIyqmbPH4gOL?=
 =?us-ascii?Q?5K5bxxI9CSodLFNvpgniRNmk9AIH5AJQ7/ei9a/ZqYmk4rv2o4LZFAz3PkbY?=
 =?us-ascii?Q?lK8aJe7wAZztKpMF/hI/WHRc/YWDPHllD3UUXTUELGrO3K3UMQVkbWxL913l?=
 =?us-ascii?Q?+GVMCM82NQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed45ed2e-d5c8-4567-92c6-08de52f077ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 22:09:49.4543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01G1P1W67JanSahKfBhgl4NfDGGH66kw5TFs3FxAUU3gr31TS/Q5UaSADtvbTaFKVxcW/NFjr2puA8GgL9RnyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8500

On Tue, Jan 13, 2026 at 02:58:26PM -0700, Logan Gunthorpe wrote:
>
>
> On 2026-01-12 14:01, Frank Li wrote:
> > On Mon, Jan 12, 2026 at 11:40:17AM -0700, Logan Gunthorpe wrote:
> >> +	desc->completed = false;
> >> +	desc->hw->opc = SWITCHTEC_DMA_OPC_MEMCPY;
> >> +	desc->hw->addr_lo = cpu_to_le32(lower_32_bits(dma_src));
> >> +	desc->hw->addr_hi = cpu_to_le32(upper_32_bits(dma_src));
> >> +	desc->hw->daddr_lo = cpu_to_le32(lower_32_bits(dma_dst));
> >> +	desc->hw->daddr_hi = cpu_to_le32(upper_32_bits(dma_dst));
> >> +	desc->hw->byte_cnt = cpu_to_le32(len);
> >> +	desc->hw->tlp_setting = 0;
> >> +	desc->hw->dfid = cpu_to_le16(dst_fid);
> >> +	desc->hw->sfid = cpu_to_le16(src_fid);
> >> +	swdma_chan->cid &= SWITCHTEC_SE_CID_MASK;
> >> +	desc->hw->cid = cpu_to_le16(swdma_chan->cid++);
> >
> > Any field indicate hw ready for DMA? what happen if DMA engine read it
> > but sofware still have not update all data yet.
>
> There's no field indicating it is ready with this hardware. The hardware
> will only start reading from the queue when the head pointer is written
> to the sq_tail register. The hardware will not read from any descriptors
> before that occurs.

Okay, that means can't support append new request during hardware doing
transfer. Have to queue new request at irq when done.

Frank

>
> Logan
>

