Return-Path: <dmaengine+bounces-9412-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB6fAIIgs2mpSQAAu9opvQ
	(envelope-from <dmaengine+bounces-9412-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 21:22:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9668C278E56
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 21:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AED4301DD61
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 20:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F34A36C9FE;
	Thu, 12 Mar 2026 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LlvzILOM"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B135DA6A;
	Thu, 12 Mar 2026 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346944; cv=fail; b=CTIG7CuP5JKCm1syyyH6HBKQz1zfJj09DTAn1qJhnZfMnCDxGgywUJPGAufuf3zu1EpGOqgHjHWb79dfNCESTOoT52lJcOMN5/pRe295WD4fd9bLhSnpZn2oCtzF1O95bb2uNKzNT4s+t2q04CwWY0zmqr8GyP4RqIq0EC7xjDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346944; c=relaxed/simple;
	bh=cA6D8YB7sqCtGuaIySKdRFV6CQNRPbZciiVpcSioRmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mvLCsMjGpaKW9bmqJpzU+Meej1jDLem6driyiBCaqtk+uC940MA7gjtxKXwmc2KJ8OVqmOwf97blOKhD+MAAqA3UUNwuqiMn6IZ7Q4oyhUz/PtthogrpMDnw+aFTxj7bk+OqteADQqHYyZrnSbJ1ZPYHmPrciYC6O+Oxg1aBc+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LlvzILOM; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZzXyOweBh1MSjZUnoNiw3NyJnObMtZqXNLeG13c5Nljqdk2EDBpzfBYtSJlFgfW/DDBtq9OoYLNsrxD5i+R5RHZiEHMu/LX7ln9l2SHaZe2kvWhTMhAHnIfPfbEQl1KSZ6yb/8o5tQ53RC6YUYiJOXcVDfP1oR3eOMHRcHYFlPe0DXhAVdizcVSmvzV17n98Wg8T/SZ5599kK/4CKHPEgFkN3jw2hNzGXU/3bKCCOpbK5DkXCD+hayqsRJiz6mUukUCF7grXAGZ5Rxsg8UdRsODypeK6LT6OwCDRJgr+HncAU/2WxUhUyf2Ryo3Rc00IXe+IzQmV7JosUrw/EwreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo7x867DRfL/h4uaOOILJTajl1bnIghwMHErsvysgX4=;
 b=UFypxFG2ZOnk5E4nJD8xmxGFIcWIKQz9LkM4VuO4e6fsRaYEtQZ89kzCT5UoCHoN9+l00fSfmZX9cRXQxRoG/+YdK7kOQo4HUBjBTaH+u6A5sUTxtmr+U1LUTeLsgH4DKpwtbjKpsStDONCYTZ3AORkACtbfW4WauJUzgj0OkkFTxhsK6z6GWzNP8FSKV98Gwsd/hOHtOFdfyRUMpH6hxwoB8Id3EYnIsoypPwKIBatnqcP+LXsQsrQE4CWKG+Nhxjn7f3lcSPOtgwU7VGjQg9Emyc1C/4JZdG4RclU2ab5rTEiXS6sb6Q22wzDb0EZIoHgPAH8i70yPoJI1HS+ECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo7x867DRfL/h4uaOOILJTajl1bnIghwMHErsvysgX4=;
 b=LlvzILOMQjj6lX77Ry0orEZxNnQVBU7d6IDH2wDu4WT/qvfDs7B6IaxSK0j+aRaqhvDIb35Cal0BjHrzYftCF0KPzdvdRkwraI8Lz51s86r5XLFDULoaAFVcBJnEZ9mwHvkDuEUlxWVG8peK+yqncV7MVaxuvftLMGY5RN/NBgeh+Hiy/KwE+kMr1i5r02U3WbFWrq2DAWCZdOfO/F7VjBjyGXrDlAEAc0d5TIj3xiQfPvB+/SDlcgY5MerEYnj5GWIJU08DosH7+x0WYYjiUwsJ8ivBAFDM9W/+ndNLXeFRdFFoPFzrUb6ex9B+TCQKn6fIfTLLCbmc7Z8zpaSEsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB7683.eurprd04.prod.outlook.com (2603:10a6:20b:2d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 20:22:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 20:22:16 +0000
Date: Thu, 12 Mar 2026 16:22:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 04/15] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Message-ID: <abMgboE6g2DY7vAh@lizhi-Precision-Tower-5810>
References: <20260312165005.1148676-1-den@valinux.co.jp>
 <20260312165005.1148676-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312165005.1148676-5-den@valinux.co.jp>
X-ClientProxiedBy: BY3PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:217::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 02dc4361-51e8-4b64-9e03-08de80750d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|19092799006|366016|38350700014|18002099003|7053199007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k3qCvQNG1t1qpE9LDiECaIpL75EYXrU/rjYDmYpR9pt5Pk8Lq2Bls0pW04oG56fCcbFW+AsASfMVrPDO0n9ndAkeESR1ManCfr6dthnaIOtDskLyLsCBaqQDG92mhD+kLVo/g0fItzt9e9x4PLdljWzD1bPuttXs3Yi9w2w0kUKc49Qs8o3Z3Nfw6klRr9UuWmYs8NAsmFBOEPA3VC+aByiDvpT8Qq05Y+O9guhXZ/Q9dw+yhs5c4Mo0Tmn+kAEyrRRhyJSaMgwny6IxOXLH7VwJh8GH6/3pSWVWDomZu00rVNMrEjyd9xXi6DHptm7LlR7xLCJhv/SjyfcwfTsVZdO01DpzrQDykFW2+139EgybEuEwxbbZ7ihpXxIAOjJuP3Q5OQTpwM9o7/BQ4fYzBGvb84tGquDnxOtNsm7zkrJlprMbRJh8AaKSuxMikTYP7jTzNVrxUOVRBoHNWc6UfXcpzJQANkIMquYBrMMMq17k8Z8Y176w0C5wXdtCwhIq/JS+NBCR/PojJNw7BuLrMMODBBnSrXuMd/Jks5LGavmPT7vrn1ZTcXyQM8t2QSkNlt9tdabzR+vA4J8bnzxwIpDzSEHYzCJHLIkZjCJW6QbJ6+11LDnll/eV22AQ5gCPyBkywpnvtgvBIVXZ7DEm1X4MB3tL50A/dWWeYtOTUa/z+hxjY3/COYEDisB9HLDGK5xBFDYtbDlJYZCQmq7B/VnkOe7AzS0fUMiSrZxXmbN9UPyTrB+uOXDL+ZN1veaaNVHM2BpGjHHd1EQwIDTNTTqsvKlxqepP08CA9Xf7tz8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(19092799006)(366016)(38350700014)(18002099003)(7053199007)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EH0eajHlwe/1v6ilLDrOi0ZalOd780ZDZELdb7ugJhXh67wrQqaX0PXfufQk?=
 =?us-ascii?Q?LBg94ftLtRvBauRrI5vG56YwNohs0XJyh1H8YQhmdCiz0fASB8mojzTihE8P?=
 =?us-ascii?Q?bv+MxIxVpbXJe2bDiFg81V6Mhv17RQdEYekoZU+s1I+rTXsNj/dDFnNPU+bG?=
 =?us-ascii?Q?Gn5J/c2gXDtJvXYL1Gon9oXxNZcoVjmuyh2zL+v/4n7I/cnhk+FJ8CshoG7k?=
 =?us-ascii?Q?vnEEdNwg0MuL9MAr9/spMeQK0ZfEs31i/91dBEeEQg0Y4bkEmLv/h5I4llqa?=
 =?us-ascii?Q?c0ioLtyqxE7vz/EW8To4584iE12+CkcTn0P2gs+ZZ0seUMJXkPkFjQMGXoJk?=
 =?us-ascii?Q?Xx4ZqDjpVvqkJ3ZFXS0JuEPN7ao6YGzliDePV2iM4VPfbIcwkIUzDWQ/R2Qq?=
 =?us-ascii?Q?viNc5VYI4pdE3D23gmhVUm0qu1DeRHNE2Ug/wjLuIxGGau520l101KC/DpnU?=
 =?us-ascii?Q?wPDO8mYR23snhOSCKryc0go2EpwCfTd5+kPlSX8K30rdZoSiiIqaaBiQeu3i?=
 =?us-ascii?Q?pVafQQHUOtVZD83EkBIdJlawbwxy3XzK6sMmVrmkxNt+h2g42GYZ4+xXRV7z?=
 =?us-ascii?Q?L3CmFLzTh2xJ10KUhrScECJTtCcj9xoWAiuctMFygdpyWiplIfD2DvXV+w09?=
 =?us-ascii?Q?22tBDnP4/ePpUSAD/W1gfjtA+9KEHVjOp78hLUcApFzJ+9pZxweC7As+jvuH?=
 =?us-ascii?Q?hCGdBLuUNimTNEnSYGabT7nG75jwo+b/9H3MOapbkQGTmjnHptcX8KxAxfvN?=
 =?us-ascii?Q?7TuKJYy6xZ3FPt4bAe4KM8dggiYmPLhfT3kfYOraR5GfOMM6RhtuIDEY4XOy?=
 =?us-ascii?Q?p9glRYYjuNx8XCYsO2j1hHm6eikKBo82bnb4I59Bcu0aDk+t+ONXEYXqNRij?=
 =?us-ascii?Q?iL6r7Hi63NGOF5maz7MFlmFQYfiorq63F8G3xCPVU3Jws8JAZSKlD4aXRDCM?=
 =?us-ascii?Q?QW3DON0j2M4RTCVEFHpx/zqc8VaCJT2MReQRSATq9cuxLYNCizBlKLLm3HRm?=
 =?us-ascii?Q?5K6+Lk3xDIQgkDMZwSFeSZLXlJ6KnnSc6s87W4F/IV0rXpetlPDd6tahpmu1?=
 =?us-ascii?Q?Ol+Ga0SSMGvV0IOFijkFkmMd+kJbzXgnwiOlcvreJ9qZeXGkX8Y1NTjzJFlS?=
 =?us-ascii?Q?4KxHeO08f5G+2hrI96hYJ2n7jayzFpLzWHJtKFtPVXy/t35s/VdHK9Vlksqw?=
 =?us-ascii?Q?6XbXWf67zIK+mmFPcRXGXo266Vq5HlaXxsUR++qMZBVgeLgGTvLF4jC9El5+?=
 =?us-ascii?Q?Tm83aJ3RRzMTI17xVLHeysHKNdKiUx3BXcqXp0VOKdQAcWc8FUWuImOWu4JP?=
 =?us-ascii?Q?Gohlcf26jEdiRS3V6/q+/TcjZmrUWLPDgwKKYoDqTG6POP1UqcfC3RTl5B6E?=
 =?us-ascii?Q?xmvOkEKqKGmfQh67WRlbb9u1MLUcfV/PXzXA44IMHljFwDtYT+JFEKCAvUZ/?=
 =?us-ascii?Q?jJzgsXY9KwQL4+0KJwEOA4BrZu3eLGv4KG8AOJKqOeGgduNYHbIkLaZOwqvq?=
 =?us-ascii?Q?/tZeM56LPs7iNFrSiCV3mH8POnovodRTN4xW2y0uT/TaY9TnMcJPK5/EetJ8?=
 =?us-ascii?Q?+Go7l/tSCgB5hTv9vbZCxzII64ey33G9Wh9ky929vv6P8pzWY2UH9btqk4mg?=
 =?us-ascii?Q?n780F29qRliNp1e+oeAEPPHk4i9creOnOEdZtivHEjzG34Q959F0m/FCbSdl?=
 =?us-ascii?Q?7WwsygCfxNBBSRmR8B/c949/hqGDz6gLl4MxWmrm6m9xtPND?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dc4361-51e8-4b64-9e03-08de80750d53
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:22:15.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBDPZmRxl0uVNnDZC79h+mj112fPqGIer4dW7eTe13NlyWQ8xruAySZapG3wcarHHfbyhSE2xCFP76Iu9UsK3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7683
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9412-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,valinux.co.jp:email]
X-Rspamd-Queue-Id: 9668C278E56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 01:49:54AM +0900, Koichiro Den wrote:
> DesignWare endpoint eDMA can signal completion both locally and
> remotely through LIE/RIE. A remotely controlled channel needs a
> per-channel policy for whether completions are handled locally,
> remotely, or both; otherwise the endpoint and host can race to
> acknowledge the interrupt.
>
> Add dw_edma_peripheral_config, carried through dma_slave_config, to let
> a frontend select the interrupt routing mode for each channel. Update
> the v0 programming path so linked-list interrupt generation and
> DONE/ABORT masking follow the selected mode. If a frontend does nothing,
> the default keeps the existing behavior.
>
> For now reject the new peripheral_config on HDMA, where the routing
> model has not been implemented or validated yet, instead of silently
> misprogramming interrupts.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-core.c    | 55 +++++++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++----
>  include/linux/dma/edma.h              | 38 ++++++++++++++++++
>  4 files changed, 124 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index a13beacce2e7..6341bda4c303 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -219,11 +219,60 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
>  	}
>  }
>
> +static enum dw_edma_ch_irq_mode
> +dw_edma_get_default_irq_mode(struct dw_edma_chan *chan)
> +{
> +	switch (chan->dw->chip->default_irq_mode) {
> +	case DW_EDMA_CH_IRQ_DEFAULT:
> +	case DW_EDMA_CH_IRQ_LOCAL:
> +	case DW_EDMA_CH_IRQ_REMOTE:
> +		return chan->dw->chip->default_irq_mode;
> +	default:
> +		return DW_EDMA_CH_IRQ_DEFAULT;
> +	}
> +}
> +
> +static int dw_edma_parse_irq_mode(struct dw_edma_chan *chan,
> +				  const struct dma_slave_config *config,
> +				  enum dw_edma_ch_irq_mode *mode)
> +{
> +	const struct dw_edma_peripheral_config *pcfg;
> +
> +	/* peripheral_config is optional, fall back to the frontend default. */
> +	*mode = dw_edma_get_default_irq_mode(chan);
> +	if (!config || !config->peripheral_config)
> +		return 0;
> +
> +	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> +		return -EOPNOTSUPP;
> +
> +	if (config->peripheral_size < sizeof(*pcfg))
> +		return -EINVAL;
> +
> +	pcfg = config->peripheral_config;
> +	switch (pcfg->irq_mode) {
> +	case DW_EDMA_CH_IRQ_DEFAULT:
> +	case DW_EDMA_CH_IRQ_LOCAL:
> +	case DW_EDMA_CH_IRQ_REMOTE:
> +		*mode = pcfg->irq_mode;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	enum dw_edma_ch_irq_mode mode;
> +	int ret;
>
> +	ret = dw_edma_parse_irq_mode(chan, config, &mode);
> +	if (ret)
> +		return ret;
> +
> +	chan->irq_mode = mode;
>  	memcpy(&chan->config, config, sizeof(*config));
>  	chan->configured = true;
>
> @@ -808,11 +857,14 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>  	if (chan->status != EDMA_ST_IDLE)
>  		return -EBUSY;
>
> +	chan->irq_mode = dw_edma_get_default_irq_mode(chan);
> +
>  	return 0;
>  }
>
>  static void dw_edma_free_chan_resources(struct dma_chan *dchan)
>  {
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
>  	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
>  	int ret;
>
> @@ -826,6 +878,8 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
>
>  		cpu_relax();
>  	}
> +
> +	chan->irq_mode = dw_edma_get_default_irq_mode(chan);
>  }
>
>  static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> @@ -860,6 +914,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		chan->configured = false;
>  		chan->request = EDMA_REQ_NONE;
>  		chan->status = EDMA_ST_IDLE;
> +		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
>
>  		if (chan->dir == EDMA_DIR_WRITE)
>  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 59b24973fa7d..e021551b0b9f 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -81,6 +81,8 @@ struct dw_edma_chan {
>
>  	struct msi_msg			msi;
>
> +	enum dw_edma_ch_irq_mode	irq_mode;
> +
>  	enum dw_edma_request		request;
>  	enum dw_edma_status		status;
>  	u8				configured;
> @@ -223,4 +225,15 @@ dw_edma_core_db_offset(struct dw_edma *dw)
>  	return dw->core->db_offset(dw);
>  }
>
> +static inline bool
> +dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma *dw = chan->dw;
> +
> +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
> +	else
> +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> +}
> +
>  #endif /* _DW_EDMA_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 69e8279adec8..2e95da0d6fc2 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> -		dw_edma_v0_core_clear_done_int(chan);
> -		done(chan);
> +		if (!dw_edma_core_ch_ignore_irq(chan)) {
> +			dw_edma_v0_core_clear_done_int(chan);
> +			done(chan);
> +		}
>
>  		ret = IRQ_HANDLED;
>  	}
> @@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> -		dw_edma_v0_core_clear_abort_int(chan);
> -		abort(chan);
> +		if (!dw_edma_core_ch_ignore_irq(chan)) {
> +			dw_edma_v0_core_clear_abort_int(chan);
> +			abort(chan);
> +		}
>
>  		ret = IRQ_HANDLED;
>  	}
> @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  		j--;
>  		if (!j) {
>  			control |= DW_EDMA_V0_LIE;
> -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
>  				control |= DW_EDMA_V0_RIE;
>  		}
>
> @@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  				break;
>  			}
>  		}
> -		/* Interrupt unmask - done, abort */
> +		/* Interrupt mask/unmask - done, abort */
>  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		} else {
> +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		}
>  		SET_RW_32(dw, chan->dir, int_mask, tmp);
>  		/* Linked list error */
>  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 0b861e8d305e..e4a6302bd04c 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -60,6 +60,41 @@ enum dw_edma_chip_flags {
>  	DW_EDMA_CHIP_LOCAL	= BIT(0),
>  };
>
> +/**
> + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> + * @DW_EDMA_CH_IRQ_DEFAULT:   keep legacy behavior
> + * @DW_EDMA_CH_IRQ_LOCAL:     local interrupt only (edma_int[])
> + * @DW_EDMA_CH_IRQ_REMOTE:    remote interrupt only (IMWr/MSI),
> + *                            while masking local DONE/ABORT output.
> + *
> + * DesignWare EP eDMA can signal interrupts locally through the edma_int[]
> + * bus, and remotely using posted memory writes (IMWr) that may be
> + * interpreted as MSI/MSI-X by the RC.
> + *
> + * DMA_*_INT_MASK gates the local edma_int[] assertion, while there is no
> + * dedicated per-channel mask for IMWr generation. To request a remote-only
> + * interrupt, Synopsys recommends setting both LIE and RIE, and masking the
> + * local interrupt in DMA_*_INT_MASK (rather than relying on LIE=0/RIE=1).
> + * See the DesignWare endpoint databook 5.40a, Non Linked List Mode
> + * interrupt handling ("Hint").
> + */
> +enum dw_edma_ch_irq_mode {
> +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> +	DW_EDMA_CH_IRQ_LOCAL,
> +	DW_EDMA_CH_IRQ_REMOTE,
> +};
> +
> +/**
> + * struct dw_edma_peripheral_config - dw-edma specific slave configuration
> + * @irq_mode: per-channel interrupt routing control.
> + *
> + * Pass this structure via dma_slave_config.peripheral_config and
> + * dma_slave_config.peripheral_size.
> + */
> +struct dw_edma_peripheral_config {
> +	enum dw_edma_ch_irq_mode irq_mode;
> +};
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
> @@ -76,6 +111,8 @@ enum dw_edma_chip_flags {
>   * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
>   * @db_offset:		 Offset from DMA register base
>   * @mf:			 DMA register map format
> + * @default_irq_mode:	 default per-channel interrupt routing when client
> + *			 does not supply dw_edma_peripheral_config
>   * @dw:			 struct dw_edma that is filled by dw_edma_probe()
>   */
>  struct dw_edma_chip {
> @@ -105,6 +142,7 @@ struct dw_edma_chip {
>  	int			chan_ids_rd[EDMA_MAX_RD_CH];
>
>  	enum dw_edma_map_format	mf;
> +	enum dw_edma_ch_irq_mode	default_irq_mode;
>
>  	struct dw_edma		*dw;
>  };
> --
> 2.51.0
>

