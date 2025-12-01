Return-Path: <dmaengine+bounces-7434-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474AC98D68
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 20:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA7AD345187
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD64245019;
	Mon,  1 Dec 2025 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KDe5eWVh"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC8242D76;
	Mon,  1 Dec 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616812; cv=fail; b=AQrVpC21woQ0ObYmvZjeSHrGWm5wuRhKvLXHK1ptjh2+NE2VYxkEdun+zO1TpuLA0sj/1dksdXEVulhbB7PSqFl3NhItl1/kG04gcIEhcZtxtHnQ4kjWzuVDZZO2DZnfbrBraEIipIALuCDHGd8MQ0AyhRcw4hIKCx6EyjtrTcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616812; c=relaxed/simple;
	bh=aCW8XtIIzCOJNDzkr50lrCBWzXEQRO2KAWZiILUQqzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JO1ekKVw2AzuyN2eAV/3l7PGvlrCZt1hE1uctp4C+VoZM7ac6vlpwkoyH+28bJdDlZVYSI49+bbM9BvaP1Na7a5Tsk06qhdWXTzDX2qATcnMIFlhQ+AA161XqAnnKRRvSwBRetgfrAQD2p+6eEnagVxxBXvhU+k4Wolojq7T6Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KDe5eWVh; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF4hQpSDhgK+kq4gidaRVZ0T2c5dilFJM123wn8BGP2i5jYvi5ypY9R30RI2gzUQ0zE8M0xKa2gQUZudIVMpnRFHgAsFbA2Yj7e4nADwa4o6J4zJwL529f3It9GZKPkku3D4Ku7WhW871t/GmFwSFsiBDCzcTI+EsjMV6eND5Yz0j/Ml1SuOBz+2f3H3AKI0WUynpIkTqw/e2f34ZUN22Ej2cRY5nEGPmativ7BC5HBrBh/YABKMR2mc5gNV9lAUIMAbCSHr0p/urkz3lgTnBN/6QoChsq1Ah6vNcV7HRCcNmEjeKMHLLwnfERbHV+3H8awN6EyfXp6XNOw2HzXXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKnkZVECXhJKDeuYxQ5C+jTXG/1jsSQ6tiqEHWNnzLg=;
 b=rX/WuH3JCZtUwpIZln24TzxwabcUCu8euZj+H2pj2scoGNNFE5ZUCU6ZjUXZLRsxNMG2tupmfxbzqVqXzBxqEVf2RJFgGTv+W52RwCWG+BBEs1PaJni1Gmx/d4xlO3pV/IvALERKnhucxuz23io/dNkKn41xaJ5JQki8vbY9ZF3PQiXC0K8C0xQhVyp8VEJe7FrIavVPjN60S0TpPz/fCHZtcRSLuqDGIgGBB24+IA4GV7sbITw6n1zDmBB5SMx8z3WNRJeLsS9QHfQqzYcTZS+avJ7xREoQsPmTFHZtQnWNLe9otFEm1um9c5ZcDr5kIE1178n/TmGUC0g812nrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKnkZVECXhJKDeuYxQ5C+jTXG/1jsSQ6tiqEHWNnzLg=;
 b=KDe5eWVhbtCZxSzXbMjCVKPXMIusLLoqWXIFTBc+uV8WGMd38OzAkKcr2iUddasipVChn4T/CsioHnTv6ek4pMzvtdK6lGBLCBikzuCCaIGT6i0Ys/nbaIu6DZ8wgMtPWfgeXu9vFP5MUIxtUctcANL7Et7rJ1Sj2zrK6f1MflKcBykJVkvbZIo8QAOm+Ia1zyggQp0YRf3FxJ4zJ5LAHGu2Kp4385Ve0kDZMH5fxOP1US5hP+ss2bBN1pyvSWYCoJ3d4+/JCUHvXXxIqVm3ZYgcoKmjXEME9bLErsfV8Wn32XwR5XWlcUg+CjTxkx9/VUlM/8YEES0elkkXedJ5Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI0PR04MB10686.eurprd04.prod.outlook.com (2603:10a6:800:25d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:20:05 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:20:05 +0000
Date: Mon, 1 Dec 2025 14:19:55 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 04/27] PCI: endpoint: Add inbound mapping ops to
 EPC core
Message-ID: <aS3qW0LX/ueo2ZP6@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-5-den@valinux.co.jp>
X-ClientProxiedBy: PH3PEPF0000409C.namprd05.prod.outlook.com
 (2603:10b6:518:1::48) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI0PR04MB10686:EE_
X-MS-Office365-Filtering-Correlation-Id: 799bb84a-963e-4708-a52c-08de310ea214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sSCtQ+y1BUrLA7gjz18jk45h92RF8s1gN1gWu/DeXaUpj5bNV+IBmb32TD7E?=
 =?us-ascii?Q?Dt+DGoJ487ApUekNVVvcu8qWGk/y50EIF1S2PaFAaJam2S2N+UQ5kKVPjqfg?=
 =?us-ascii?Q?o7SjfT/jjYoosoiY8bz1xxMz0Vc2oGQ1+XBerKigmDxi0ZN/MzDeG/mcs6VZ?=
 =?us-ascii?Q?/1qndpNe2bTeTOOojdj920zF/0JiLz30BJ+zTPrMFndnh3MRObM8nJlknb87?=
 =?us-ascii?Q?j5jys3zri+LzugJ/lNhr2/rimQjuTHz+ljhHu5Yw/GtbeKHbSvcr5TboytfB?=
 =?us-ascii?Q?baRIoOUPAm5vje9PrfW7yLWFIoSfJEQluQy+mmzQvgm9MyT+Bj4j9c/gGqwN?=
 =?us-ascii?Q?cU7KtGBTmyA9EqBSafcmM/KI6QhE82Zcirq85itd7E5GrHo5WiGCc42i2aIR?=
 =?us-ascii?Q?jPMsvVQhP2dh3zc7amqDzj0QUgNb1t6NuvnkiAmvrBAFg7vLGnrc6Y2qkYo3?=
 =?us-ascii?Q?rY/vrLO/XEVD/FNmv8+AMjKFeHBKNX8BdS1EZp2i7y12sLaarht3KJdxvq2A?=
 =?us-ascii?Q?KYEFl5gVcEc6datxeavowgKzSTMVTN+V9P/PWgGTiPZwkuHnqa8JOtFpNujb?=
 =?us-ascii?Q?JPpgwuJJMXURpNdwXMaxW1TQRfYLQknn+llzwuggVOJyB1m+3b+Gby39Pxam?=
 =?us-ascii?Q?BBtJhCwjFT2OEAEyOGq99xf6wlhl1I74YQPSsiaXYaPZWQWOB2hCmJsC9RBr?=
 =?us-ascii?Q?DOm8jmnM4PTXMkE6TfdR4VCJLS8IXJW/6XEgQlqeJ7fPT0LysQPFB/XRTj3F?=
 =?us-ascii?Q?Y9hiyLvltxjJoTV5bVgL3PMEKppYtZv2WJvRjHPnahRqglhkgchaxsQwu+n1?=
 =?us-ascii?Q?jsDGeBWqOluVLZp90F+1hRnEjJmv7kITZp+59132RXFftryb+Fni5cgKcVWI?=
 =?us-ascii?Q?JzUZZPgoYOdW0JWx1J6ePdTdVvkDEDKgmQQWjwyirY9aDksQEIwlQC9pPumz?=
 =?us-ascii?Q?IX/c/6aykq6BTTwzxiWizZKgaSF7Xcg57Lsu7pY5SysQ6YvR7Zs/bp9oomGx?=
 =?us-ascii?Q?3omKrkVkcPzD2vydNr6pxIO2oSM4ZCPTWcinj9DBvUJhiDWUumvdAPsv4X1A?=
 =?us-ascii?Q?SEq7Fk4yCuHo3bnMgW4SOCQMmHqLuSzXERoLQ3KORRojhpbb7JwxhVCvbBb7?=
 =?us-ascii?Q?dX99gri3GJzkyA2rbu5/kc+xGwL+xrlfZXPLsKZjyW31ovw4zPLG3dXW/Uc9?=
 =?us-ascii?Q?Sd67uNXZ4q3EwfkyU8kWr5crHZ0LkCYF4V8kVmBHp0PgB4XSC+FgcZmeIcmD?=
 =?us-ascii?Q?KMpAU4NtvRV9R2wtVOxtsdk7L846n5dvdlFI4JUUaiOYiiz4vRIHIz6UJJpI?=
 =?us-ascii?Q?sE494oo53J1LvNbwmlfytmuOMfU97WXlgiyRIPZDooxTbaekq4RE9AR4ciu2?=
 =?us-ascii?Q?oj4hit9KRhAxEe3VqkRMVFaOMfMN0OGyfW8mBI4i2q3t0n86RVpNDs7PoS50?=
 =?us-ascii?Q?Lh3uIKBB+KgTGM9dORDwQoi5808eLHhf9ULoHRpqDkC0PgynctDMA1ghfwUG?=
 =?us-ascii?Q?phN3ooqNb9iwGbPpe2oSoUq+xd2i4F1RCseY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jiiCuLK5jMeu1YM09q6rRPVKO/ig493jmxIKW1JAwBkD3yVu8Pi3Vgt9A56J?=
 =?us-ascii?Q?gdPgJmlckSkvhGkDcz8hFxxYWOa5g+rrTRCRk0tNoSmhsOyld/AXe76UkuP/?=
 =?us-ascii?Q?RYeBBiU4VegC7lU/iO6aXnmY5Q1x20H3p9za8gtrzOFkbydklxo8CioyFI9I?=
 =?us-ascii?Q?c6SgMUZHS+SFIToaC6YvjvySg8+8VPMo88aAFi4ruku7BNdkR/dJJI9um4ZH?=
 =?us-ascii?Q?hSjZK67VBCUcUFiChnEmYticJgqJZ9vHouCAB2Xlq+iqD1e/SuhT8GMUtV5m?=
 =?us-ascii?Q?109y6uG1sYnUvOUxxb9nNOhXqT/vlF/tjz4qcnrKxqLn5ll+zBfL+5igVaxF?=
 =?us-ascii?Q?X9u2URmp0csLB1cF+wu7R39uSbCaaR6tgSxrpPVKwbQkKoQGDfV2ZkwlB/0C?=
 =?us-ascii?Q?8sKrA6scJgtBKKw0HpaDkaJcHUQvRLYqN+dTf2TbK5hkQAcS+Mtg3doy0GZg?=
 =?us-ascii?Q?TPzIxhNMDs1kVfwigD1eRjm4C+0lVA8cjpqVRp7kczEEEiaIbTm1Z1NRY4Ho?=
 =?us-ascii?Q?5EoU0AYocqeBw8wOaHN/BCofgKjz1fJkFyyIQBkuM02nuqQi3OEhmZC4laF2?=
 =?us-ascii?Q?8xHNvtv1Dwjpa84XN/6lbqy012v5RRt/NoNQP/tNTiCBZBTQksnTk6zqZmNY?=
 =?us-ascii?Q?V3mjaSwovE7Jkgid2LhQxnUZgtzA+BWmhhVt7uMVSoF7hrE+/Kua9YxGEeqH?=
 =?us-ascii?Q?8evfAnql1Tn+9lbe9eYiKb4cuMA6FotC2hzRYZOqadDGzvgm6gALdWP4DzjQ?=
 =?us-ascii?Q?NQ0ea01ll2fEeMbla6Igm8HZfZ9XXTEmg2laOqB06jJPBFSswVD3etkP5Min?=
 =?us-ascii?Q?VOkpyUW4EQgkN1/ext5KccnT8gow/4RtyM6kewgHE+l/fUlOnqFn6lfrVwvp?=
 =?us-ascii?Q?WoXUbDXPQXKcnVfg2W3fUZmNT36J5nNwu6TpZP+kKRIStde1/Iqn+KrAe1F8?=
 =?us-ascii?Q?0InASHGmY12edvLwlfmJ3bkdRZlB+765AT9TednXrBoR0jctzl/15dmdGzHf?=
 =?us-ascii?Q?7a7EU5OX3AkaoH4D3SmhOdXl5eEzjcMSy2YPH9pddSAP1HP1Uttp6R9B+KWi?=
 =?us-ascii?Q?3DhKgmnXJGS/0U4s+6QFydz6Zyjh5w9kwhif9mWqtQx0wiqf9xefBPoR4Idi?=
 =?us-ascii?Q?EnLx8jwFaj5Y3U3JKGCUhCrVgl7skXVTGLIS5kv90fVRsNlT+XvkdkpTrNsW?=
 =?us-ascii?Q?fWYxKrvlUCJeqdUIzGLXA88YdelogKplwPVG0kQp6mSzY7ktJeaLWINkND8R?=
 =?us-ascii?Q?hlwfrBXwWhzxZQz5gGvfl7/xsY/G0y6CzLfe4UrlV6lDTPMwJmFw6THVjqLk?=
 =?us-ascii?Q?/95r8zFWu9nCXRuqQr7p2k4gRiKRR6iYRzhIOsFHOydTMgt+TBx8lUg9TObz?=
 =?us-ascii?Q?7gvTYrDFVOcPUNhgOvVI30nXGY+p0YMaUpSrvpRBa7su7u/BqezSgXCLi0yr?=
 =?us-ascii?Q?VpMDOH4tEg8IoVClvAZPRrkjUDb+LYdMIKTuWscoXT/fxUP2T+xY5q2aHnTx?=
 =?us-ascii?Q?hyjT6oKYfUk9UzeM46oZ9pLRUPaS57j9Lhumvj4YvSYGspqmGbUGGf1MBqxO?=
 =?us-ascii?Q?tvVoBGVmQndU+XZ/pUdUqXp6McstETuRlO4DN3ye?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799bb84a-963e-4708-a52c-08de310ea214
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:20:05.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i6AVcvlWMrVKS46yREBDociUgLvbstVpNWMgknO1hR5cbD1jBWzhli51PMMmdWW6fpNvXFKZdCNAcxlCXSMUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10686

On Sun, Nov 30, 2025 at 01:03:42AM +0900, Koichiro Den wrote:
> Add new EPC ops map_inbound() and unmap_inbound() for mapping a subrange
> of a BAR into CPU space. These will be implemented by controller drivers
> such as DesignWare.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 44 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             | 11 ++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index ca7f19cc973a..825109e54ba9 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -444,6 +444,50 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>
> +/**
> + * pci_epc_map_inbound() - map a BAR subrange to the local CPU address
> + * @epc: the EPC device on which BAR has to be configured
> + * @func_no: the physical endpoint function number in the EPC device
> + * @vfunc_no: the virtual endpoint function number in the physical function
> + * @epf_bar: the struct epf_bar that contains the BAR information
> + * @offset: byte offset from the BAR base selected by the host
> + *
> + * Invoke to configure the BAR of the endpoint device and map a subrange
> + * selected by @offset to a CPU address.
> + *
> + * Returns 0 on success, -EOPNOTSUPP if unsupported, or a negative errno.
> + */
> +int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			struct pci_epf_bar *epf_bar, u64 offset)

Supposed need size information?  if BAR's size is 4G,

you may just want to map from 0x4000 to 0x5000, not whole offset to end's
space.

commit message said map into CPU space, where CPU address?

Frank
> +{
> +	if (!epc || !epc->ops || !epc->ops->map_inbound)
> +		return -EOPNOTSUPP;
> +
> +	return epc->ops->map_inbound(epc, func_no, vfunc_no, epf_bar, offset);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_map_inbound);
> +
> +/**
> + * pci_epc_unmap_inbound() - unmap a previously mapped BAR subrange
> + * @epc: the EPC device on which the inbound mapping was programmed
> + * @func_no: the physical endpoint function number in the EPC device
> + * @vfunc_no: the virtual endpoint function number in the physical function
> + * @epf_bar: the struct epf_bar used when the mapping was created
> + * @offset: byte offset from the BAR base that was mapped
> + *
> + * Invoke to remove a BAR subrange mapping created by pci_epc_map_inbound().
> + * If the controller has no support, this call is a no-op.
> + */
> +void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			   struct pci_epf_bar *epf_bar, u64 offset)
> +{
> +	if (!epc || !epc->ops || !epc->ops->unmap_inbound)
> +		return;
> +
> +	epc->ops->unmap_inbound(epc, func_no, vfunc_no, epf_bar, offset);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_unmap_inbound);
> +
>  /**
>   * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
>   * @epc: the EPC device on which the CPU address is to be allocated and mapped
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 4286bfdbfdfa..a5fb91cc2982 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -71,6 +71,8 @@ struct pci_epc_map {
>   *		region
>   * @map_addr: ops to map CPU address to PCI address
>   * @unmap_addr: ops to unmap CPU address and PCI address
> + * @map_inbound: ops to map a subrange inside a BAR to CPU address.
> + * @unmap_inbound: ops to unmap a subrange inside a BAR and CPU address.
>   * @set_msi: ops to set the requested number of MSI interrupts in the MSI
>   *	     capability register
>   * @get_msi: ops to get the number of MSI interrupts allocated by the RC from
> @@ -99,6 +101,10 @@ struct pci_epc_ops {
>  			    phys_addr_t addr, u64 pci_addr, size_t size);
>  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			      phys_addr_t addr);
> +	int	(*map_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			       struct pci_epf_bar *epf_bar, u64 offset);
> +	void	(*unmap_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				 struct pci_epf_bar *epf_bar, u64 offset);
>  	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			   u8 nr_irqs);
>  	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> @@ -286,6 +292,11 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		     u64 pci_addr, size_t size);
>  void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			phys_addr_t phys_addr);
> +
> +int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			struct pci_epf_bar *epf_bar, u64 offset);
> +void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			   struct pci_epf_bar *epf_bar, u64 offset);
>  int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs);
>  int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
>  int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
> --
> 2.48.1
>

