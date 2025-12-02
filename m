Return-Path: <dmaengine+bounces-7452-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A73C9A408
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B183A5125
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D71B30103C;
	Tue,  2 Dec 2025 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="f/0i1l7/"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011048.outbound.protection.outlook.com [52.101.125.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3AE223328;
	Tue,  2 Dec 2025 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656774; cv=fail; b=hJ2x2jiz+Jid7qxtQuq5MtHR/FIjJVZIiifrpLAdUq3MaiqhGIXBypb7soceWGBrIu4NXhm1Re/Q+C0GGhZ12YvOkvQNkaAJ4GP/ULu7HxrsUmck0hdZrEHeTE4A9tg5e5ZtmBVlSuvSx1zRgwrSJmsS+LhRfMBBNVEkd4GnyHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656774; c=relaxed/simple;
	bh=/hQqN9Z8wLpL8oqUxsiGDlBLYda3Kx77S0q4ZTvMrTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RBrc+nFHdUh9dp+0KHiLehrqW5ZoRhpizT6lHEJtjyNgUyEmEuQcRYMihaiM+4VK11DWSOK862RBLbe6kkdYROOeYG7iy+UlXcETO3RqJkm4XBpPLMLO26VfeynNOHQyaTrGc7VoU0AwqyonQTIiOJJjxaNXu0XUG251M3TCfLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=f/0i1l7/; arc=fail smtp.client-ip=52.101.125.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgZZeGu5Cahf7M8CTYT2rjuNmcQW81G2IL7Je3mqkF/IkHfDcPBURKO/T+nSmpQGssz0+gsuY34HJsJvsOmziqNepYoGUbDjgNDQq01O6r2Ylx6xVx2sKKoT3m4pOOrvEcthC8hAIxiPlsUx2Jud73ljsHbhGDvAr8qclQWTuHH0+6MBGdYFvUV8mhOkDIbkpy2m8hzzNoBKK6fgf4siVj2tkdGN9JpajgvpBogu/S8N5213nHN4GaZkgxy8DKnay5NnP5hSW9CzskkyHCMe9eLVX4ffUpLspAo134WE8PagnQ4bgy7GrhVG/MxVtCYJ91NaU8ZfzZoHrFmv5p+bpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQySoHjI4j7aymXMFYhFQ0gwTenSj/cMug+XbQFmncw=;
 b=wxr6LoU1uklb2LVk8n69XqMX3XLmKVGHpJL/CMSRC83vgp96Oka38p0/CSabBgqe4ubhQ8HzVbUz7j38zvYnnxf8FDW+h8OaZHSx4teb1xYg3vCiwEwhHIYZgocPY8eNNp1wELpREAS5DjmzAZgsOy6VVJ7Se9D1vjF3Yek51+XoByzQs/rlg9KosEHAV0pR7yDDmfMF086EtmJrPid547Q8oBwk1k/JrMwRe95r5KzEQayacXtE0QmcO24DHjkYDphqPUiyr6q8JWuQghgMNv0C+C8LMyYIoxNOLRuf7Wo/x7e+frDMAMP4dOEWkrSxkYaHLPWf/zdgyV7pVEBebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQySoHjI4j7aymXMFYhFQ0gwTenSj/cMug+XbQFmncw=;
 b=f/0i1l7/c9vy15Cyh/iL+bPMWpjAKWgzEuv30z9QSm044/HjEKoy7S2MEqd51rgkN0ZLhypV1uBqb2tfEci10C2RilBOV0MneEuAdb5/U11NCbJHzDHc/r+J4sG81g/0t5RN2CVEjbUqnUn2lx1Yhp2f0u5ByowDc5vDBGs8wlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS3P286MB3322.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:26:07 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:26:07 +0000
Date: Tue, 2 Dec 2025 15:26:06 +0900
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
Subject: Re: [RFC PATCH v2 05/27] PCI: dwc: ep: Implement EPC inbound mapping
 support
Message-ID: <fwfg6kcklffiaqjslpcspuj7zbbvpqpk5ykph3fy2d6xuwsl4s@z4doqp5ttzof>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-6-den@valinux.co.jp>
 <aS3tOi39GEqLMdzR@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3tOi39GEqLMdzR@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::19) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS3P286MB3322:EE_
X-MS-Office365-Filtering-Correlation-Id: c72585e5-93dc-4b6d-0337-08de316bad72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RWBMQcI4tAQj89ykO3TP7G2qFE+1Hjc90dFDYK4SbW/lOybrk5430yZztxx6?=
 =?us-ascii?Q?vWXv5zUCzkgv7ES0zUqGiVCPWbWuvLQXtVOnTzNjz2RkdbkMB+zUtRR76Gz+?=
 =?us-ascii?Q?Av6W5pi2cjH9gkXevdgh9jWZnNuPTTfxXVEqCmmj5VBtRqVBVZ+e9M9baFLB?=
 =?us-ascii?Q?WlOXhkkIq43jvFJxoU7kRCDYgqHrYTyAnVEifOvogvm/nS46ajoOkBY/urdm?=
 =?us-ascii?Q?pMxPLAVZRk4Gm/TiZ4pG+WEoK0fbTv6Qkbji9rkKHRSXXnIfNljJ1IgmOhz8?=
 =?us-ascii?Q?OaO4zRWgJQC8umjWBArUbn2094Vx7OzUU0u7csUj30VR25bbIVG53HPkKC3H?=
 =?us-ascii?Q?o+lUJUtY38LUaBgPHDFioy3TnqhvSzOJV+fX7QflgJOOOfBSY24acL3FvCYP?=
 =?us-ascii?Q?+WECctzluurmSN+J6Ihvkw1lHfDtZY2rOpwOHCzU6x7qid5sfvk5h7SRpD/s?=
 =?us-ascii?Q?CL99TsDPToAq7DJlL5Y5RceIMGRQquJ61+IVVEgKUocrvowoBBtJgVGaXeNc?=
 =?us-ascii?Q?uQCL7GOKkWImk4rRnm/cduq0znWLoGBM+4b7yllo3sMuKYFCYNuWvSaidRgT?=
 =?us-ascii?Q?eH9nh6wx0v2f5+wLhT/gPQ5agI1C1UlsI06UITO3Lr7ItIG9ZMhAwRu8JuOh?=
 =?us-ascii?Q?ahazWlo5LuxogzcZag2L6SMdLHzWAcGrdiwSgJ99nJdHgNCPyWEKuf2h+5l1?=
 =?us-ascii?Q?7ck/8WvMAZxzJ4Tzer+ia5UTbRWJ6Y0xrfz5b0c8AgkHpQgh3K88Mn3T3dRe?=
 =?us-ascii?Q?g3B5KrlMl+gPAz5BoQ9a7OroUFHl/jkiTHbJf0jlzxcKs+F1Wb5C4LiNR4kG?=
 =?us-ascii?Q?OF8/BfUsiEqHBYbjqpDE4pKlBlKH5Y35XPi8oVdrqAMqRkyoAR4esjmlSt+3?=
 =?us-ascii?Q?sGxdJ2LrBG0fGQSverGMawbIqEyD/h8dojDrkEYmaO2vFOM6P2mwgqfgekkf?=
 =?us-ascii?Q?gmD9XCHzlKHtSJBcOvCoxe2hhyWh1Ww5BkwST6V4CZsrJHgSFDiKM8TcukJU?=
 =?us-ascii?Q?YR3k9iqQUvsxNrZukXDSZ9YeMaxCPtpuH4ZXrShkt39ivj3Zg6K8lamYjCWx?=
 =?us-ascii?Q?UvcGElalb/AGgj3YMvmaPGBpDoO1DOKdLuccpD4pF98a4iSIGNH9+YvyYzDO?=
 =?us-ascii?Q?ZOY2CXNcOu1YR0NjgFQotYBqUYPhnOpIbrap0U8K2Bhqq2AKPg0avMPvcr/z?=
 =?us-ascii?Q?DWuuZRseSyOwMMUC/eONGxb0FM4hyYqivS3Vra0qIIKa4lcGeP138YM3An2k?=
 =?us-ascii?Q?2AkN8ekqIfl9N6dSOXe38Owx77gSwGu36Ue0beASoJxGXftHsLJNvT9jnOrk?=
 =?us-ascii?Q?WR87IUtFnNMnijvV9My2IaLQ81D18qAnqY8b18fJCiZXFUpLzBu2BY4nnjfQ?=
 =?us-ascii?Q?M7n99E6lS0/wf0YfAFEs9UBA5+h5qfoBUhqN3XgduwVvliOBQ6+HXXzFUOIv?=
 =?us-ascii?Q?KMirMjx6thHswrVEZCje78KmQvRBN/B4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FFpHw96tjnCMu5HL6dRM8jBC/X8NrDCdOk7DdoEj4HgeP+RCl+WedgVDS+zQ?=
 =?us-ascii?Q?rl3ptItuEQLiNdc1FEqGmNU8UfOqMeRUyFv0GVIbwDFiMfYKEVcwxc3beEXJ?=
 =?us-ascii?Q?ZqgZ44Oqp3fn/N3tZWxEU6tE7qUcTDcn1wfxe5Q+EqZ2xDjqcXfBuglX6jlr?=
 =?us-ascii?Q?hu0g7S9Ifs9B1D2U/JJSC8HQ2l1CwItpjUrTIZOCQp3suJpYAu04Q/6HD3Di?=
 =?us-ascii?Q?ZJ793sAaB4ie0iwfzSFuoADb8WODSXp7Fwk6eJTr8slE3yw+oiCPGJm7KKBn?=
 =?us-ascii?Q?pv1DJIvYbUC/Bzr6Rpq42lGCXBdLLzv7EwehxgCbftL5MUbSCF/C2u6mx/1l?=
 =?us-ascii?Q?1mtelY5fV9JS9ZgyKWTRI4RvaA53QAPAnntEiaY97ZvzZbxWBYzCUNuu0/hK?=
 =?us-ascii?Q?myDdAFoGOXDo3aivxcWtrTE/R2mxSwWsF3+WcRrhvEkduarTunU+FZrclZTL?=
 =?us-ascii?Q?jzdtYHak2HhSgtc0l3od0cg3jKrZs2VRmjGknwZeUGnT0kyAJU9vKSWbIFFd?=
 =?us-ascii?Q?t9RJ6uejtdWP8b/7YL5I8s0XY4VuxGIXPidcpf9M5kC3TtAWGice6pcHJl0i?=
 =?us-ascii?Q?U67NNQRVC2kcu90GkKKRFSPJWYIGnqhhi0IhUtMtq2RneggFwQS3ML2m8dBR?=
 =?us-ascii?Q?oCC9TV7NCe//JMV/qJjY6ApMigFVZlKEHaQ0nuLULXAugl7Jnh3LqrtFxln7?=
 =?us-ascii?Q?DQPgl4Lg/TgIc7JvAlb/ctC5TPFdh9PeDxaYe6m4xKFfOD5MJgxp4Lxy7Ep4?=
 =?us-ascii?Q?mernOCUNEJe8RcgqCvSZDkJc1TLr2FO0rz6FIZJYIXuu8JAnJDl+Azg1B3bd?=
 =?us-ascii?Q?SJZDESYcMqEfGqQdA1Xe1Etr5H+DYsDYDsfyVCrY8HRDDzEGSHbIG+eSaB9+?=
 =?us-ascii?Q?GfPu+leJSK8n3y+cFIAlFQhCkcyMdWiirU28cB19+Wp15BOdvZg+axaOT5Dn?=
 =?us-ascii?Q?Yb0xcPQAgdsDrwh5eJLwjyHdylzwYP6tjYYo0eQdoI0msByTpJQhfChG0K5r?=
 =?us-ascii?Q?jf0rBGXI0CrgVCjDeXyAEK3SHEXCNpsMnhR0ZXSyZakNEGDU6c6KwKrla0Js?=
 =?us-ascii?Q?83CJMjyVWhWWS4p+IuYVTtdUheA9HVNAdbJ8bLmxqJ/esbSAi30H1DkRdS5A?=
 =?us-ascii?Q?0f2Xj+pxA27LxGKLsrwz3Gnig/Vk+eEd1isip8vZJF7vFYlvQhc+vrtBA7uz?=
 =?us-ascii?Q?B4xz4yTiLwrerJV5zDGO1sHZ1Hhv3PjuNJIUQP7NxYUizTy1a1BH7cMaY6e/?=
 =?us-ascii?Q?A5RqVm01R/dOKf1gWUDo6BX35f6cPBYj6D9rPCmFQOoMjc8twlQCg/0QACuu?=
 =?us-ascii?Q?SX2+SFYUmiaEYO2tAmbJHoap1yRYaIaD67ZrgbBDu0jLA0Tr4+9kZzJ0XRZv?=
 =?us-ascii?Q?zYaGNXP36OSDtIWlCLLAREMboSsPy5oGi2CgdiacV14wFMwtWIuZc8/L/ima?=
 =?us-ascii?Q?CeziF0SNLRxqOPJS/5o5+OtXRhciorUc4fb3MCcyjQokVMQ1rQaLOX39vhNi?=
 =?us-ascii?Q?K8EXJrIkdYz3OQvI6suftGIF2wDqaY9Aiw0ckztChPZTluYSY5mT+gsk3Ioi?=
 =?us-ascii?Q?0bGLxL4TBUPMeqUljrqxQVfDw/rQtPhtq3zEPC7m1bfitzJrwmiBvHsuCMt5?=
 =?us-ascii?Q?cysQr04TD3lNIPf6475iJgw=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c72585e5-93dc-4b6d-0337-08de316bad72
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:26:07.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQZelBEXlf9aRCqF/JI0ZfK67WMestJgY3YoLXMkL0Vc+SSzd8mCxXF/VW5MCqecqVw73Y//tbQVAwN4hgDhFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3322

On Mon, Dec 01, 2025 at 02:32:10PM -0500, Frank Li wrote:
> On Sun, Nov 30, 2025 at 01:03:43AM +0900, Koichiro Den wrote:
> > Implement map_inbound() and unmap_inbound() for DesignWare endpoint
> > controllers (Address Match mode). Allows subrange mappings within a BAR,
> > enabling advanced endpoint functions such as NTB with offset-based
> > windows.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 239 +++++++++++++++---
> >  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
> >  2 files changed, 212 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 19571ac2b961..3780a9bd6f79 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> ...
> >
> > +static int dw_pcie_ep_set_bar_init(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +				   struct pci_epf_bar *epf_bar)
> > +{
> > +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	enum pci_barno bar = epf_bar->barno;
> > +	enum pci_epc_bar_type bar_type;
> > +	int ret;
> > +
> > +	bar_type = dw_pcie_ep_get_bar_type(ep, bar);
> > +	switch (bar_type) {
> > +	case BAR_FIXED:
> > +		/*
> > +		 * There is no need to write a BAR mask for a fixed BAR (except
> > +		 * to write 1 to the LSB of the BAR mask register, to enable the
> > +		 * BAR). Write the BAR mask regardless. (The fixed bits in the
> > +		 * BAR mask register will be read-only anyway.)
> > +		 */
> > +		fallthrough;
> > +	case BAR_PROGRAMMABLE:
> > +		ret = dw_pcie_ep_set_bar_programmable(ep, func_no, epf_bar);
> > +		break;
> > +	case BAR_RESIZABLE:
> > +		ret = dw_pcie_ep_set_bar_resizable(ep, func_no, epf_bar);
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		dev_err(pci->dev, "Invalid BAR type\n");
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> 
> Create new patch for above code movement.

Ok I'll do so, thanks.

Koichiro

> 
> >  static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  			      struct pci_epf_bar *epf_bar)
> >  {
> >  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > -	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  	enum pci_barno bar = epf_bar->barno;
> >  	size_t size = epf_bar->size;
> > -	enum pci_epc_bar_type bar_type;
> >  	int flags = epf_bar->flags;
> >  	int ret, type;
> >
> > @@ -374,35 +429,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  		 * When dynamically changing a BAR, skip writing the BAR reg, as
> >  		 * that would clear the BAR's PCI address assigned by the host.
> >  		 */
> > -		goto config_atu;
> > -	}
> > -
> > -	bar_type = dw_pcie_ep_get_bar_type(ep, bar);
> > -	switch (bar_type) {
> > -	case BAR_FIXED:
> > -		/*
> > -		 * There is no need to write a BAR mask for a fixed BAR (except
> > -		 * to write 1 to the LSB of the BAR mask register, to enable the
> > -		 * BAR). Write the BAR mask regardless. (The fixed bits in the
> > -		 * BAR mask register will be read-only anyway.)
> > -		 */
> > -		fallthrough;
> > -	case BAR_PROGRAMMABLE:
> > -		ret = dw_pcie_ep_set_bar_programmable(ep, func_no, epf_bar);
> > -		break;
> > -	case BAR_RESIZABLE:
> > -		ret = dw_pcie_ep_set_bar_resizable(ep, func_no, epf_bar);
> > -		break;
> > -	default:
> > -		ret = -EINVAL;
> > -		dev_err(pci->dev, "Invalid BAR type\n");
> > -		break;
> > +	} else {
> > +		ret = dw_pcie_ep_set_bar_init(epc, func_no, vfunc_no, epf_bar);
> > +		if (ret)
> > +			return ret;
> >  	}
> >
> > -	if (ret)
> > -		return ret;
> > -
> > -config_atu:
> >  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> >  		type = PCIE_ATU_TYPE_MEM;
> >  	else
> > @@ -488,6 +520,151 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  	return 0;
> >  }
> >
> ...
> > +
> > +static int dw_pcie_ep_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +				  struct pci_epf_bar *epf_bar, u64 offset)
> > +{
> > +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	enum pci_barno bar = epf_bar->barno;
> > +	size_t size = epf_bar->size;
> > +	int flags = epf_bar->flags;
> > +	struct dw_pcie_ib_map *m;
> > +	u64 base, pci_addr;
> > +	int ret, type, win;
> > +
> > +	/*
> > +	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
> > +	 * 1 and 2 to form a 64-bit BAR.
> > +	 */
> > +	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Certain EPF drivers dynamically change the physical address of a BAR
> > +	 * (i.e. they call set_bar() twice, without ever calling clear_bar(), as
> > +	 * calling clear_bar() would clear the BAR's PCI address assigned by the
> > +	 * host).
> > +	 */
> > +	if (epf_bar->phys_addr && ep->epf_bar[bar]) {
> > +		/*
> > +		 * We can only dynamically add a whole or partial mapping if the
> > +		 * BAR flags do not differ from the existing configuration.
> > +		 */
> > +		if (ep->epf_bar[bar]->barno != bar ||
> > +		    ep->epf_bar[bar]->flags != flags)
> > +			return -EINVAL;
> > +
> > +		/*
> > +		 * When dynamically changing a BAR, skip writing the BAR reg, as
> > +		 * that would clear the BAR's PCI address assigned by the host.
> > +		 */
> > +	}
> > +
> > +	/*
> > +	 * Skip programming the inbound translation if phys_addr is 0.
> > +	 * In this case, the caller only intends to initialize the BAR.
> > +	 */
> > +	if (!epf_bar->phys_addr) {
> > +		ret = dw_pcie_ep_set_bar_init(epc, func_no, vfunc_no, epf_bar);
> > +		ep->epf_bar[bar] = epf_bar;
> > +		return ret;
> > +	}
> > +
> > +	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar,
> > +					    flags & PCI_BASE_ADDRESS_SPACE,
> > +					    flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
> > +	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> > +		type = PCIE_ATU_TYPE_MEM;
> > +	else
> > +		type = PCIE_ATU_TYPE_IO;
> > +	pci_addr = base + offset;
> > +
> > +	/* Allocate an inbound iATU window */
> > +	win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > +	if (win >= pci->num_ib_windows)
> > +		return -ENOSPC;
> > +
> > +	/* Program address-match inbound iATU */
> > +	ret = dw_pcie_prog_inbound_atu(pci, win, type,
> > +				       epf_bar->phys_addr - pci->parent_bus_offset,
> > +				       pci_addr, size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	m = kzalloc(sizeof(*m), GFP_KERNEL);
> > +	if (!m) {
> > +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, win);
> > +		return -ENOMEM;
> > +	}
> 
> at least this should be above dw_pcie_prog_inbound_atu(). if return error
> here, atu already prog.
> 
> 
> > +	m->bar = bar;
> > +	m->pci_addr = pci_addr;
> > +	m->cpu_addr = epf_bar->phys_addr;
> > +	m->size = size;
> > +	m->index = win;
> > +
> > +	guard(spinlock_irqsave)(&ep->ib_map_lock);
> > +	set_bit(win, ep->ib_window_map);
> > +	list_add(&m->node, &ep->ib_map_list);
> > +
> > +	return 0;
> > +}
> > +
> ...
> >
> >  	INIT_LIST_HEAD(&ep->func_list);
> > +	INIT_LIST_HEAD(&ep->ib_map_list);
> > +	spin_lock_init(&ep->ib_map_lock);
> >
> >  	epc = devm_pci_epc_create(dev, &epc_ops);
> >  	if (IS_ERR(epc)) {
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 31685951a080..269a9fe0501f 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -476,6 +476,8 @@ struct dw_pcie_ep {
> >  	phys_addr_t		*outbound_addr;
> >  	unsigned long		*ib_window_map;
> >  	unsigned long		*ob_window_map;
> > +	struct list_head	ib_map_list;
> > +	spinlock_t		ib_map_lock;
> 
> need comments for lock
> 
> Frank
> >  	void __iomem		*msi_mem;
> >  	phys_addr_t		msi_mem_phys;
> >  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> > --
> > 2.48.1
> >

