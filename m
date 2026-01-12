Return-Path: <dmaengine+bounces-8216-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A3D1376B
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 16:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A35C302E330
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FC72D061C;
	Mon, 12 Jan 2026 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lno/IOpx"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010000.outbound.protection.outlook.com [52.101.84.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C82BDC32;
	Mon, 12 Jan 2026 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229694; cv=fail; b=aJTRg5RZWtb4VsUCh/y+q6TQI6K9++ecNZ79FQ4OrSXB6uAQ5M6qMgeHbvMjGeIibJXUrc6+5Cc6b4B98LCLkEVM8UuoNgQf3KtYW365W7pHcMZ9wyjlue/C9JF5MM2y1hkz9XQCp/WtiBNB1zdIGPiHVWoXZAcqi4u7RWsB/TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229694; c=relaxed/simple;
	bh=6gRGVXW0BgFSfrUsTm//oP0Faa+w5rN2i3CzjU0uHUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=odj91PZd3E5SMVS1VlCkF92UKPjbp7F+Hk5I3YPTZ8ZzzjP3ii7ypS4r0o2lN332ce9qN+LBxa0Hs3BJXiLbOR38h2jZMNjpu6le23ZAawZ7R8UZjHBtl3Hh3i3dpoCmuxxSSwbeEUM0VH8z8t67BqrXqd/eU10wD6k5Nlgds6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lno/IOpx; arc=fail smtp.client-ip=52.101.84.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOerrvQqz20oywG+BC9T3630PF2C7qQUWwGLmjn98Ev/Up38SdzJPEkPsgwOW+gsXSUSatrde5pVouSeO+uOrvoSvf7X4AhMEZToKjYc22zvNeQb3ERVcYBV7C6p3JK5NKwM4fDDLMsOjKZLL30BmfFThj9+pHBQsk5UaHuA7SUZCjj6vU5IdBRVfhopZ5qheJzeEV9LQ99aDJeAZzz1XjMbbe5Rp0jIOc1vB8YftI3BfEV45wCi2+3EZPTF5THeVanfbA0tVsRbCmjlfwxK+ia4vy36jeZPHbmqG+gXMl8CiX/0kv+v7z+vcZBofNLL4gIyLUwT7I5e5AAHnkG4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4twENRyTF+LUYmH4dR8ZH3nYZPf5tdmzoRXaNACJeo=;
 b=I2+ISarZyoI+m4F65T66sJvkaHnizV8s54RqdexBEqD/4zDtX8tQQXN30LI776mGoiJU69/17zhXwr1Ak3rkHj73pCC2evoJwlZBVo2OySpCeb1E+UNd1mDe7lOO03dq29PbmmqOJTvVm0YqwUL/QuDUgjMs/XaETpnxZ4gfiJ//jmnwHX5xC5aBE46tbZLsOIhbGpYyZRIFJ/Icc92VK4qTSz73okpCwMkGfrKsI/XSaRTJ9qmjRIV97XVAoI+vi3+kOBVMrqYqvxUT9J4UdcVmx0NnecvyK3y3mHlnmtGyPyOpP8z7YV6IHYKKgY5FyzK02bKMOMbwDBzbs5kpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4twENRyTF+LUYmH4dR8ZH3nYZPf5tdmzoRXaNACJeo=;
 b=lno/IOpxHg9YUipjHy/oMiu5jB8SkcqNjW9xdRJTj88mcOFowMFyzPbMrQ+iqc/EOLpjfWj1tT8zZHZ5QcKKS1beTGbA7Fgka3adJ1vAxkYbae2vhqeOc1tjTJRcAWzadjn7dovtEt7Vj5S1LReyzt/6mrFsHge9ITkMF/opBTBiZAKg6YDOv+pBrZGFzwoWz2P0Va008NFlur5mRDBh8eoI3Qf4YyThy/iSOMLE7XcgmhKxwMV1C/GPT/NXN924hJ/b8nm4pVK0I7xG39sVWPxcOOKLVpSBGfWqxy2Zjz9Lh85LH6iaKT428NGuo2en/xou9uMpPZ8kCLZ4bC0A7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI0PR04MB10855.eurprd04.prod.outlook.com (2603:10a6:800:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 14:54:49 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 14:54:49 +0000
Date: Mon, 12 Jan 2026 09:54:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH RFT 0/5] dmaengine: dw-edma: support dynamtic add link
 entry during dma engine running
Message-ID: <aWULLXSYLmVqUEgQ@lizhi-Precision-Tower-5810>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
 <aWT4p7RnFykJnuOz@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWT4p7RnFykJnuOz@ryzen>
X-ClientProxiedBy: SJ0PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:a03:338::10) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI0PR04MB10855:EE_
X-MS-Office365-Filtering-Correlation-Id: 88bec7a4-7e07-4292-dc7b-08de51ea88a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wnU5VjKd5AorUCQUVu9XrtZEaPasPAH6TnCyayUq8h/EMWgu8LeT2KZtTWl9?=
 =?us-ascii?Q?orsenBVRCH+nHR9mtP5k/dh/F+Gb/OflTzrbAY/oRXnpt+uFfwGyeDMeelu/?=
 =?us-ascii?Q?K0+7PS4HlSxKym1/bKGihm7xBT+729FYUrrtKULqRunrQbRGLfrb9tg3ajcO?=
 =?us-ascii?Q?1trrhxxdwHCL6CGZw2rLUarIbcrm0WTc6Jz7UOm2wV00p6YQrppF5+4M9++h?=
 =?us-ascii?Q?J9mRmabUNl1bUklhY45fKyLM7uNmpvATMeaXvfJH1p6QxRCO8QjBv3LMQ5uT?=
 =?us-ascii?Q?crq/csn5UcfDBhH2E7e4I66tur7veaBqxn14ViF8flB/DNDEELpx2r8Ly3bi?=
 =?us-ascii?Q?JSxtLsdsgPLm+0aMCLtm/25IbCli10/v869IkTrcF37dKEAWPX5rPHGJNomO?=
 =?us-ascii?Q?NSJaJboRjgKP4wLjUiPl8xgQYfoskIGBXPD5EF9iexMx/UozyopArhTMBPE8?=
 =?us-ascii?Q?WTUi4APNYQfxXrgln1NqIqDD+U+xftOMO0CnQa/6q7OP3qMKJEPzmeVyBjNF?=
 =?us-ascii?Q?0aJ+ANbl2T7cjoATirEGXbP65OiPMgg4mVQe89ZrfAjFsaR1mqeQy3la5tAR?=
 =?us-ascii?Q?RCNHPngDXEanefJw3jKYwcUShDD+xHRZoHPU0g4fjRhPYwu9Ia+Fhe9t54UD?=
 =?us-ascii?Q?gq0T5vJU5FB7JbX2bGARvYRk9WEDfl+oRDbn3nbqrfdH5Imni2iuDTZUTe4M?=
 =?us-ascii?Q?fPrZSKWt8F0EpeSTvm5iw6895C6/Gwg4fRjavFyHDTrqmOhWi/wOrpbeb84v?=
 =?us-ascii?Q?UhHoLMd33bwpQol+0y74zrLc1Kwa5EdblRTBdXcYQA2AOJEoJ6o5T7KuekmN?=
 =?us-ascii?Q?OIRYtFKRTJrQknKMbHnK43S8GnobXJxo9p6PdXh7dt7dNphBWfHOd8io7o6i?=
 =?us-ascii?Q?7m7JmDz/Rt0j7BsOP9faf3EAdfMp4zJzwXCATI0sbB2SaVqeIXo8r3LARtf0?=
 =?us-ascii?Q?n8kqb+zSsMoubu9CoNjR0veMawDYNw65kziJVwYFVgoD/ExmbXEAs0t84vQq?=
 =?us-ascii?Q?WDSdX5OuW//+06afAJMOYOsGccU+PxCMiY+QDxUPzN4eTCop+e/WfaHqMKOD?=
 =?us-ascii?Q?kR1NfT/jai9qIXxufJFh9DeIdalnOLjqbb4DQSrAgtTVfs2cVhulWinqo+ur?=
 =?us-ascii?Q?jlpQ0esrMFHLwVBasAm95yWg2JIlr32S4v1qiMHdKLr8ybGHriocQfqcY9l0?=
 =?us-ascii?Q?6nWnqIQ0SMlziHI/+oI6otsHQ4xflc4smHMXO2CRnztxkSIQ8PWJdYL6Bqbo?=
 =?us-ascii?Q?m9i89rf8qbx7ssIvOaxGnCwQ7ucnBzFPPo7qO/3dBRCfZQ6wQXGrJxjOYBAV?=
 =?us-ascii?Q?8XSQtkoPkQRwA6NLk+pjF5OD89mHtGbKAiv5YEF9wZv8254Qwwa2pOBHCk/f?=
 =?us-ascii?Q?aQKGKkWfEfE8nTb50zU9DwJN4ejJCFKboj+bQ6kJAhVlM94NmD0q2XlslYe0?=
 =?us-ascii?Q?fe/X9NKTQpHC1U9pX9jvMp25KLAtZX1CIfku3FGZAWANxsdTpExz7y54CGUW?=
 =?us-ascii?Q?wa+5DmWeOSU5CrJawH58OHqfzDQEzk0Fmcq94DUxb5LSTLU3K3NSt9+fzQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nyl84j7Z4tOfe7NOWRHUAGNYxIVi4f0o1BGU17SGSf89tlgxjqRv7f+P5VjQ?=
 =?us-ascii?Q?xAqpaAFVEZc70VfY/FGTcmIbmjlzc9L0NkY23StZOiCrW+XNRhQ0NMIBk6FV?=
 =?us-ascii?Q?n+UeCEQQDFBVLDwT+aVP9T/TCrwD5WpoML8+8GlhRwizqXG+igJ76J2iqSxb?=
 =?us-ascii?Q?8o1BZczO6+1sm0bKpFY8775kPtbM/GmAlY6QRhZBQJYgV7KXO5ykv4y1Z8WE?=
 =?us-ascii?Q?xn32rH4nVuR9cEvb6fShlk9hzh/dWGp/rf3yUL+sU32gYNX4Bxck/K/9AtMw?=
 =?us-ascii?Q?R0vNsGXdk+rinRXyMSVTaUrp6C9Yn36pYyWAaq6aC509FO2W22w7MDHhLzU3?=
 =?us-ascii?Q?qBWLe8Aq2WyaIcpOBrcpxr7ZSNJyD8YF1ptKjxrEOJsi0QeJnk0xO7Y53fnj?=
 =?us-ascii?Q?tINO9eO3YJ/nghmqBhdxMrmP2GBiAJwN9ecqVBTEjs2+bDbTNZQSiJJC9hBL?=
 =?us-ascii?Q?nlRHFD2AbxkYcA5gLYXGjXtnfUCdq/tM/zn8RLrqCq6GhlmCeNec7tL0PsEi?=
 =?us-ascii?Q?2v97A1gaPRdABPyZQfDvgF7A/JvktFM3IRVvwoHctzLzRQZuMe2Bizka/A72?=
 =?us-ascii?Q?7b27KptYc3CejvSdNCMd4/HagD3oZV24j2j5sxoVsaoGPTIXIyhP95ryHzG2?=
 =?us-ascii?Q?+kCzEYNTf0pCk2mLHQGJx7wzGmUWaVs0DrY8/JRJSMdzQj6n94o2YR/ESOGG?=
 =?us-ascii?Q?+DxERPezNHvCVjpmTLjozWNZVkQ1U08J4isJpkotHwBAsZuZ2KE58W6MNcoL?=
 =?us-ascii?Q?4Cc/ITuQ3nXdmYZOnyNtvTUriDlvd5HtZ9yB+Gv5yN9GRqibUmHWDRR/vR7H?=
 =?us-ascii?Q?lofJCTT0cZKCrIvOP8NuuvxYTx+BbLLJMdpash1U02K8U0lK/hjb/2/FPE73?=
 =?us-ascii?Q?MpthcDB7Q3xVJ0PDVW4D6tlgmIZD8qG/HYkP2++OZF3gf1Nrl3NNVEhN8wHx?=
 =?us-ascii?Q?7FOrTlvuMX0H73AltfW3GKLAqMC2uVMm3tqGJsekxi3pCkVF/oIGo2U7RKQw?=
 =?us-ascii?Q?kmqTYMNEOFE0JTzlyV7YR1jtgJfqBiWPl/yGxXscBBZOJdzCOMvrXflCNBeB?=
 =?us-ascii?Q?/ydNh8G0ivHSk36yy/s1X85GTNIm/yd9MB0lrCEcUbHa8eycfJhWm7X8591r?=
 =?us-ascii?Q?uAHOw3nsrO/ZpKYAg/79Ij1xsIUSBdU5Hwa721vm9FTGg6whUoaow7JjvF5b?=
 =?us-ascii?Q?rYfft5o1wRz5Sc4MRFEdBLGVIAH8Lq8e9zkv8e3jDC2vkARJX+99vEHFEQ44?=
 =?us-ascii?Q?0AHyl2cyQU/CxLne1XdEkr8OSiqFUhQsq8m52z4dUoLw9+RiK/atKyQNXiIz?=
 =?us-ascii?Q?u8lmzgu1UQLFxbfcyHSXt+q5/0z7uG/SZuo16BmuDM6kKExBoko6IQ24GG/n?=
 =?us-ascii?Q?uBS4fkd2lVJ13S1D/4sW3Rt0pIeH+q0x8M3fKyUnDQ5fFFHHmsLRY/sB5I0c?=
 =?us-ascii?Q?35dn0iCZAi99LHqqLtKSaJDAHOxv1RtxfLHrUWw98FtfnCfPSanZ0MyE7lwv?=
 =?us-ascii?Q?gjh/Qtqgu5XA9dujukNCqknyFrm3OyhzArnUiFAUbKruekqwhXlSbJIHYPtP?=
 =?us-ascii?Q?lVESgi3GbPn/bsx9yjt2PVtagh3UTG5+Er5F1Lhv/qQ3Gr8XUkITtRoTCJui?=
 =?us-ascii?Q?z6P5LemUFuVVcCw7QhreVRBFlQDRocuhD8v9ahTnbFBhTQVtc6eyjL806LXy?=
 =?us-ascii?Q?kE1CDYJJLIxCqxx1nyR20bzpcKmWaSREbIWoif7K4Nr7Ntf9OyiTPwC0ZXup?=
 =?us-ascii?Q?9hKLadbolw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bec7a4-7e07-4292-dc7b-08de51ea88a3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 14:54:49.1214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wj+yGxptueUex+d+7a4WWh1EXrl8YgR2y4xbTZet1sAuCjIMwkipSvWdMVc4elz+GtbBpMJxR8ZszaZuvIqDhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10855

On Mon, Jan 12, 2026 at 02:35:35PM +0100, Niklas Cassel wrote:
> Hello Frank,
>
> On Fri, Jan 09, 2026 at 03:13:24PM -0500, Frank Li wrote:
>
> Subject: dmaengine: dw-edma: support dynamtic add link entry during dma engine running
>
> s/dynamtic/dynamic/
>
> Also in patch 1/5:
> s/dymatic/dynamic/
>
>
> > Patch depend on
> > https://lore.kernel.org/imx/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/T/#t
>
> To make it easier for the reader, please include the full list of
> dependencies, i.e. also include:
> https://lore.kernel.org/dmaengine/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com/
> here.
>
>
> >
> > Only test eDMA, have not tested HDMA.
> > Corn case have not tested, such as pause/resume transfer.
>
> s/Corn case/Corner cases/
>

Sorry for typo. I need check my tools about why not detect typo at corver
letter.

Frank
>
> >
> > Before
> >
> >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
> >   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
> >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
> >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
> >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
> >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
> >   Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
> >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
> >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
> >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
> >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
> >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
> >   Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
> >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
> >   Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
> >   Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
> >   Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
> >   Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
> >   Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
> >   Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
> >   Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
> >   Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
> >   Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
> >   Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
> >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
> >    IOPS=266, BW=135MiB/s (141MB/s)
> >
> > After
> >
> >   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6148, BW=24.0MiB/s (25.2MB/s)
> >   Rnd read,    4KB, QD=32, 1 job :  IOPS=29.4k, BW=115MiB/s (121MB/s)
> >   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)
> >   Rnd read,  128KB,  QD=1, 1 job :  IOPS=859, BW=107MiB/s (113MB/s)
> >   Rnd read,  128KB, QD=32, 1 job :  IOPS=1504, BW=188MiB/s (197MB/s)
> >   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1531, BW=191MiB/s (201MB/s)
> >   Rnd read,  512KB,  QD=1, 1 job :  IOPS=238, BW=119MiB/s (125MB/s)
> >   Rnd read,  512KB, QD=32, 1 job :  IOPS=390, BW=195MiB/s (205MB/s)
> >   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=404, BW=202MiB/s (212MB/s)
> >   Rnd write,   4KB,  QD=1, 1 job :  IOPS=5801, BW=22.7MiB/s (23.8MB/s)
> >   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.6MiB/s (101MB/s)
> >   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=32.7k, BW=128MiB/s (134MB/s)
> >   Rnd write, 128KB,  QD=1, 1 job :  IOPS=744, BW=93.1MiB/s (97.6MB/s)
> >   Rnd write, 128KB, QD=32, 1 job :  IOPS=1278, BW=160MiB/s (168MB/s)
> >   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1278, BW=160MiB/s (168MB/s)
> >   Seq read,  128KB,  QD=1, 1 job :  IOPS=853, BW=107MiB/s (112MB/s)
> >   Seq read,  128KB, QD=32, 1 job :  IOPS=1511, BW=189MiB/s (198MB/s)
> >   Seq read,  512KB,  QD=1, 1 job :  IOPS=240, BW=120MiB/s (126MB/s)
> >   Seq read,  512KB, QD=32, 1 job :  IOPS=386, BW=193MiB/s (203MB/s)
> >   Seq read,    1MB, QD=32, 1 job :  IOPS=200, BW=201MiB/s (211MB/s)
> >   Seq write, 128KB,  QD=1, 1 job :  IOPS=749, BW=93.7MiB/s (98.3MB/s)
> >   Seq write, 128KB, QD=32, 1 job :  IOPS=1266, BW=158MiB/s (166MB/s)
> >   Seq write, 512KB,  QD=1, 1 job :  IOPS=198, BW=99.0MiB/s (104MB/s)
> >   Seq write, 512KB, QD=32, 1 job :  IOPS=352, BW=176MiB/s (185MB/s)
> >   Seq write,   1MB, QD=32, 1 job :  IOPS=184, BW=184MiB/s (193MB/s)
> >   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=287, BW=145MiB/s (152MB/s)
> >  IOPS=299, BW=149MiB/s (156MB/s)
>
> We can clearly see the improvement, but overall, your numbers are quite low.
> What is the PCIe Gen + number of lanes you are using?
> Are you running nvmet-pci-epf backed by a real drive or backed by null-blk?
> (Having nvmet-pci-epf backed by null-blk is much better for benchmarking.)
>
> I'm using nvmet-pci-epf backed by null-blk, with a PCIe Gen3 link with 4 lanes.
>
>
> Applying only your dependencies, I get:
>
>   Rnd read,    4KB,  QD=1, 1 job :  IOPS=12.1k, BW=47.2MiB/s (49.5MB/s)
>   Rnd read,    4KB, QD=32, 1 job :  IOPS=51.1k, BW=200MiB/s (209MB/s)
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=72.2k, BW=282MiB/s (296MB/s)
>   Rnd read,  128KB,  QD=1, 1 job :  IOPS=2922, BW=365MiB/s (383MB/s)
>   Rnd read,  128KB, QD=32, 1 job :  IOPS=18.9k, BW=2368MiB/s (2483MB/s)
>   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=18.7k, BW=2334MiB/s (2447MB/s)
>   Rnd read,  512KB,  QD=1, 1 job :  IOPS=1867, BW=934MiB/s (979MB/s)
>   Rnd read,  512KB, QD=32, 1 job :  IOPS=4738, BW=2369MiB/s (2484MB/s)
>   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=4675, BW=2338MiB/s (2451MB/s)
>   Rnd write,   4KB,  QD=1, 1 job :  IOPS=10.6k, BW=41.4MiB/s (43.5MB/s)
>   Rnd write,   4KB, QD=32, 1 job :  IOPS=34.4k, BW=135MiB/s (141MB/s)
>   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=34.4k, BW=135MiB/s (141MB/s)
>   Rnd write, 128KB,  QD=1, 1 job :  IOPS=2624, BW=328MiB/s (344MB/s)
>   Rnd write, 128KB, QD=32, 1 job :  IOPS=10.2k, BW=1277MiB/s (1339MB/s)
>   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=10.3k, BW=1282MiB/s (1344MB/s)
>   Seq read,  128KB,  QD=1, 1 job :  IOPS=3195, BW=399MiB/s (419MB/s)
>   Seq read,  128KB, QD=32, 1 job :  IOPS=18.6k, BW=2321MiB/s (2434MB/s)
>   Seq read,  512KB,  QD=1, 1 job :  IOPS=2162, BW=1081MiB/s (1134MB/s)
>   Seq read,  512KB, QD=32, 1 job :  IOPS=4727, BW=2364MiB/s (2479MB/s)
>   Seq read,    1MB, QD=32, 1 job :  IOPS=2360, BW=2361MiB/s (2476MB/s)
>   Seq write, 128KB,  QD=1, 1 job :  IOPS=2997, BW=375MiB/s (393MB/s)
>   Seq write, 128KB, QD=32, 1 job :  IOPS=10.2k, BW=1278MiB/s (1341MB/s)
>   Seq write, 512KB,  QD=1, 1 job :  IOPS=1434, BW=717MiB/s (752MB/s)
>   Seq write, 512KB, QD=32, 1 job :  IOPS=2557, BW=1279MiB/s (1341MB/s)
>   Seq write,   1MB, QD=32, 1 job :  IOPS=1276, BW=1276MiB/s (1338MB/s)
>   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=2110, BW=1058MiB/s (1109MB/s)
>  IOPS=2127, BW=1068MiB/s (1120MB/s)
>
>
> Applying your dependencies + this series, I get:
>
>   Rnd read,    4KB,  QD=1, 1 job :  IOPS=12.5k, BW=48.7MiB/s (51.0MB/s)
>   Rnd read,    4KB, QD=32, 1 job :  IOPS=55.3k, BW=216MiB/s (226MB/s)
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=175k, BW=682MiB/s (715MB/s)
>   Rnd read,  128KB,  QD=1, 1 job :  IOPS=3018, BW=377MiB/s (396MB/s)
>   Rnd read,  128KB, QD=32, 1 job :  IOPS=20.1k, BW=2519MiB/s (2641MB/s)
>   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=24.4k, BW=3051MiB/s (3199MB/s)
>   Rnd read,  512KB,  QD=1, 1 job :  IOPS=1850, BW=925MiB/s (970MB/s)
>   Rnd read,  512KB, QD=32, 1 job :  IOPS=5846, BW=2923MiB/s (3065MB/s)
>   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=6141, BW=3071MiB/s (3220MB/s)
>   Rnd write,   4KB,  QD=1, 1 job :  IOPS=11.6k, BW=45.4MiB/s (47.6MB/s)
>   Rnd write,   4KB, QD=32, 1 job :  IOPS=49.6k, BW=194MiB/s (203MB/s)
>   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=82.0k, BW=320MiB/s (336MB/s)
>   Rnd write, 128KB,  QD=1, 1 job :  IOPS=3051, BW=381MiB/s (400MB/s)
>   Rnd write, 128KB, QD=32, 1 job :  IOPS=13.0k, BW=1619MiB/s (1698MB/s)
>   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=12.5k, BW=1559MiB/s (1635MB/s)
>   Seq read,  128KB,  QD=1, 1 job :  IOPS=3445, BW=431MiB/s (452MB/s)
>   Seq read,  128KB, QD=32, 1 job :  IOPS=18.3k, BW=2283MiB/s (2394MB/s)
>   Seq read,  512KB,  QD=1, 1 job :  IOPS=2048, BW=1024MiB/s (1074MB/s)
>   Seq read,  512KB, QD=32, 1 job :  IOPS=5766, BW=2883MiB/s (3023MB/s)
>   Seq read,    1MB, QD=32, 1 job :  IOPS=3038, BW=3038MiB/s (3186MB/s)
>   Seq write, 128KB,  QD=1, 1 job :  IOPS=2961, BW=370MiB/s (388MB/s)
>   Seq write, 128KB, QD=32, 1 job :  IOPS=12.3k, BW=1535MiB/s (1609MB/s)
>   Seq write, 512KB,  QD=1, 1 job :  IOPS=1482, BW=741MiB/s (777MB/s)
>   Seq write, 512KB, QD=32, 1 job :  IOPS=3144, BW=1572MiB/s (1648MB/s)
>   Seq write,   1MB, QD=32, 1 job :  IOPS=1549, BW=1550MiB/s (1625MB/s)
>   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=2596, BW=1303MiB/s (1366MB/s)
>  IOPS=2617, BW=1313MiB/s (1377MB/s)
>
>
> So I can clearly see an improvement with this patch series.
> Great work so far!
>
>
> Kind regards,
> Niklas

