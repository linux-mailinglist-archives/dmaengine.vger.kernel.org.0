Return-Path: <dmaengine+bounces-7447-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB27C9949A
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 23:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B1F3A38F7
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 22:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F2E288C86;
	Mon,  1 Dec 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k+AHfBLl"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7FA281369;
	Mon,  1 Dec 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626594; cv=fail; b=T+K3OEutO7wRaVKLFr1f0z9oqu4kMeYg4rEUV/WFtTMfl69U36t4tfHsTpjMrXH8E+UNm8PvibEEQXoHLdeT4IyI1o7Ubw+1xmvnnKutwSC3kkXEhcyhoalB2H/BuTNFvsdQ7Ek6OyAZwPzHwx/+bTEA2GiB/I0QzLUCw3FWLVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626594; c=relaxed/simple;
	bh=FVcWEGl+JIfHz4aaJutnoY9uVZ6rktedg4U0hweynPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oeofY51osq2Qds6gEOPLq+EHacXzBZp+d0QtRInVMvzB1VFq8nl1J67v2meXtf8LJ4ZRYCVVPCqFgt8GNyieJu59JOFUe5TGddqa35i5a9ZIUIQPORf7LewnXHEgGssBJMCstm1XsDejULEsxaf2b4EAshVc6lsT6nxeZQVtuDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k+AHfBLl; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7L4gmnSrVATZWGXvsM5qRhUamYAEDqCbhFuvRHoOke+GnRt9yqSXcoQzJGkHXyYOeZ6TPkEaOEs+uzzMlzOmtC1GtRD4TDTp6RSwhWINUiCqM42SozVgOjLKQcDoCVv+Q9pdStXCYYWCM8aSbFJpM5pwbATpHJkQzlPe/fh0KtWSeiACAkepNpN8i9pf+dvN799uCr3Ap9oToNWgFjs0HPiPLP61/aNAcAbUtgV0x3K+1lQbvpy8g/pYpzd0XvV9CYiHKiIyGYLnj+jLWZiQ+RvUYZK51rXxhJC/hyYpTCAroZ51uKmbuWOMblK3hWevjpN3+ru6O/tsTxCac80Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHsQvLyKE/D9CkkhXNOByovjzuuzAFMXNPHjrE2Bss4=;
 b=Zea7rFNp9wwh2RQXnLndxMHTiEaJevNNGcLWCSPfY3ihkTD1susCBLKuVMDvE6JEO0rY1hI+FZUNeparsotUfrdmVuXaavLQmQ8yevS7ETK8FeDnCQioJC/vWkTSHrRXxOzV+E8iradApui/z6MzpYUA41Kxp4bApW1x69mJoDomxUgTU3F/HoBDfP/b11yz1EFi5ijJC/ekL2c+nwqOUO0SLCjpBnrucu7EVZyWnTkijROGETQTSXq+dh6WtH2WcPEjgVUrMtXHpyNSUINWPN74FDaC+AO7XZoyuhfb3I7X4OsERB3VgOsCX+mJlNxLZJqfwXEWX3QWzoaG2kf58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHsQvLyKE/D9CkkhXNOByovjzuuzAFMXNPHjrE2Bss4=;
 b=k+AHfBLl5Fm6Al+GFK7smBHTrSsZiJVW86wuiUdsRCBBWlzZ2T35DeRv/npqS/vZfsEhRBop0AX42uNJvNuTjSG07bW9U/jJA1NafyrQdvYs/vY0A68mo7XQ0atVrZZ6+ChhK8+8771fH6nYZPPXvmsLUL/Jzn7lnSmj/FL68whJotrB5TVhLObkZ0ld2Ufrs6BBZPxn/R9v7rWqa2OoEed2al6k6gJ6g7XEOYTIIKpjImk5CRqtYKDNMX0pqQUp9kVT7JH0rsaYbFL4hCN7H7LlYE/BAGUq6/6MqHJn4kxFxu0E/zko8eBhMiKNN7SCNLLuzXtZ80/DBCxlmmdnZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS5PR04MB10017.eurprd04.prod.outlook.com (2603:10a6:20b:67c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 22:03:08 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 22:03:08 +0000
Date: Mon, 1 Dec 2025 17:02:57 -0500
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
Subject: Re: [RFC PATCH v2 00/27] NTB transport backed by remote DW eDMA
Message-ID: <aS4QkYn+aKphlRFm@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
X-ClientProxiedBy: BY3PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::27) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS5PR04MB10017:EE_
X-MS-Office365-Filtering-Correlation-Id: 80149a78-bdb1-41fc-612a-08de31256957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Cvq4MyjgBI5rKDHnXirbzDZJQEmxVrA9EA8qKYndvaWI0nz0vCP2xSSzQS7?=
 =?us-ascii?Q?F/fOzk6NRJFJUFSr2oyQjotUDIuBkPi3EHDdmpacnMDNjr7ELzhT6QojPbsq?=
 =?us-ascii?Q?q1Fk0hEiW2xX+Ptn/pVUF/ZBDkoXPxFQxeK/FyYa5e2fLEIQXkzZBrTQaa6K?=
 =?us-ascii?Q?KInPqhNeUsGS7TSht9vIfI8cBvTRs4FbNf2LikSxuw9AX+ZvB1icICy5zdfi?=
 =?us-ascii?Q?vu1hFIX9G+wyPsc87us3XzilU+Z4aLKjq0mor/f57w4zf3eiewWHh/8r/FXR?=
 =?us-ascii?Q?XIn9Sx9/mWirb+nFVKpYyetOI7QgZm7Z4meWhUVbvDqgbzWh9iBrJhRPJXIv?=
 =?us-ascii?Q?wqY8OyK/Jlya1XgHALag/HnoHA9xuq/MFgfIUnHMgmvyavKSJ+PNgBAd6WEM?=
 =?us-ascii?Q?lUT4p5IqI/NlPnTqNlZ8a/kCqM/V9gYCKYhqcfvsa+9AwR+WChNFYxONQ6/L?=
 =?us-ascii?Q?BNR6WaUazLYElGKP4AXMXVtE8YWetMwIDZynX0VfsKhrgXcld58hFE0pRTgX?=
 =?us-ascii?Q?AESaztVe2c3NGGuOjJL6YwgRnl3q2o08WRvYRbrxBvsfnQY33bkxJahv+Ty/?=
 =?us-ascii?Q?ARIsowFpUUHxbdY92M3KRDT+sxgjwbhI88L8yAQaJSUYLFElkiJbehwfHjJG?=
 =?us-ascii?Q?df68ySi/TCEK7uwo48FhspBrNu0OkEM/aAxdKFA+Bsi6zaZ1S7CMq12rVXiS?=
 =?us-ascii?Q?Jw6W5ZJtzXRXUWoVU+xj1C3S6Dr6S3tSjBEgCtmeZf2klg1zmHE56LW1MHRO?=
 =?us-ascii?Q?k8p6IkpqlPfYxH0DgkT8N9XeF3uN1ZRzzk4aDr2MB2iVIl0XBnHVjCeSnZ82?=
 =?us-ascii?Q?9yFPQX/+M3fph3a1Sh2TdaTvwh8PBIpzH4EpaWaavEoBhYRQV3M0aGiLYe/4?=
 =?us-ascii?Q?0SU/bIL8MHD4b9FxgnmquHwjfPNwqtr3g1Ytx8XpUES1lvt0uVxgLqn3rFMs?=
 =?us-ascii?Q?RWZkLdlGAkRzOoU2j1/jtXvQNV2XKa09snrC04NVHyqai1kbgvjFxrAqgwMo?=
 =?us-ascii?Q?U6OTKg1fgGPWZi5lwoJg/udRk4Erh6qighY5TQEbsxdVzRCsIT/3V3nzef06?=
 =?us-ascii?Q?5DRYj3uGI7205WfnvgwjrOAnWTUIwRd4e6yVC6/SjyTVIhTelpun2rsuuFrm?=
 =?us-ascii?Q?TC7iKXkevLrFVC8Vve2hX7p5tAVu/vbJAJ+ogCpVGgGxZXU+HUrnTQkgQ+lO?=
 =?us-ascii?Q?kfmRQU1Ov/MynpH4CcLSyAnLZJZeXTKeSmYdj1+seYe54a4WbomBh5n9NAnU?=
 =?us-ascii?Q?o6eVjs6MArlMokHpZrCdfE6zPkf3oheGDdFOR3Yw/Ui/7LmDGjYUtpw0xrju?=
 =?us-ascii?Q?Yt66L4J4AZQeX02E+f5z51yXERmxcn6DxJcQFqkFjQ4ZPt9hL55Ua+jtIY0F?=
 =?us-ascii?Q?f27St+Kw5RD2vgecNqV9ShTF+58fEsPuBsSEKT7J2crpWQ5WqIaaRP0H15N6?=
 =?us-ascii?Q?CKyQ0h6e84/St99u5DnbvVYO6mHUCqFcsgk0kUghw+tP4cJvXarm2BA9/UXT?=
 =?us-ascii?Q?m42ROhZmnYE4dXsTyHHbmkPByaolYObBPLiC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smTAkW8j7MRkEoMMetkOb4cFQHRkD4Il8XTnzaHoTezkPDjeHalBQ/G8DeFm?=
 =?us-ascii?Q?8T5PMDxwj5LPByCkQWcEXyqMCrx+3yboziBEWrpT/zyoQAfhOjeXis9sRqOP?=
 =?us-ascii?Q?TbI2whHgwI83bZcaan/zFoMCRFEi/59mKHdZtVFLXJOc7mRw71mvfqABtZLb?=
 =?us-ascii?Q?qjYNW0nDbg0f1Y47Ldtyco1fVVXoEjM46CNHn5rWRp8k+hapDFSE0zykjos/?=
 =?us-ascii?Q?/VirYeo71yEO8qNaN4rO4S86L6UJXTYckiXrTOn2M/TEMmtqCy+OAq2zbw0P?=
 =?us-ascii?Q?8YNA1xXDKuWWy2y0NYKNzu5HDkB0SQCc1WmlMXFOXdLUWuic65ynBmT+d0wh?=
 =?us-ascii?Q?jhIke6OCRyyZhhGvtzqXPUbh7FS49dS26h6mb/GRSqSvgZkUDqE3c8gMkng7?=
 =?us-ascii?Q?QciLRVabFRx4LKwQWVn3kqVGqyHfsrNWevZTr7K8J9v2H8iP0CP1YjLXX+Nq?=
 =?us-ascii?Q?ct7g0MToQlWOJJWB8xmm5RnXMDZt08wGuNWSFwWSS21KC5y4n064mftfIbrr?=
 =?us-ascii?Q?K2sJIMQ6hGUQi4EDFOijKzuR5g83eTEbsF7FT3J8Nkgo4SEXSOPutcarhnSc?=
 =?us-ascii?Q?gYO5NLUSjBPiOmXzCY3z7SwB71AX6sYXkDG5at6kXj+/zKMHTfaN8K3d955l?=
 =?us-ascii?Q?4DHEZ7Vw60CdoEGt9/wVOlRRxpXYKA8PBufVw3iDAtv0emkBMKWt0fNwJOD6?=
 =?us-ascii?Q?32vBh2HBhW22tRrZ9BsEd33HAYiVxzHKnuT4jP4uovCeCniQPanMZLG+1+cF?=
 =?us-ascii?Q?lISW7vlXdvRRaCsJMNg8uabGje6wKCfp8tLg6cHmDqPnpLia6s4IqKNOxrR2?=
 =?us-ascii?Q?RHMV2i2/mptqFGj19TiB5+c37okPzhoaY+HRzPFtGSRVa1uXbU5aZN8qmmQu?=
 =?us-ascii?Q?yO/x/X1BDtlCpT5lynpRsfWu2XHlx7nfpTDnSikFRpCUA1DHuWYMiajSfjFw?=
 =?us-ascii?Q?jNuokudeATMFdqu0WpUHia892CwLLU7jEYJnpCdlJpDNICcvJZJY1TUxysrw?=
 =?us-ascii?Q?Epu2/1Q8rV9BnxVy0/TwsfMOe6Yojvbfm81D2GleIFvn2QExsv074Ih0ZdlV?=
 =?us-ascii?Q?aY/eAl+vtnXa6CTMEbezDnHhg/5xvQJOMDJgKwaj/DyWxyW6aSZplNE2GpZr?=
 =?us-ascii?Q?0hEPAo7AhWz1jQRgSD0vL6YxwR8djNmgC4F0QaVtmma/d0sT0BcokaNdfVUG?=
 =?us-ascii?Q?Orj6x6+HluKCltFE3vaMdeTYIMcgFiVLAzlY4U6VuZ5gPAmMoQVkRqLBPKB0?=
 =?us-ascii?Q?ij3KIZb/ReBmJat69IFQ81j4t5dAR+VvLh/z68IvGT483hvoly7d/Upip4TA?=
 =?us-ascii?Q?BPOpH/0ba9HdKKHK/OzFRX6Bo8YdqYuMFi9wx05GlEeFPmqxA27dx0I9Yd39?=
 =?us-ascii?Q?PrrmhHiW3i7mVMCYCHN6/NkrBILF/4ZCWiDsxipwiYuX7qTgKVEMjd9rRKU+?=
 =?us-ascii?Q?ewibT5zw8QHctxscvjvyVdbKnlnT9jdgQDcsedLV3eEBkudlNk78/z5FjruA?=
 =?us-ascii?Q?iwfzMSiQjwKNYI8F1aGMTql5vsGkxAz2AQuwms1yJN9KxRo5HWuE4PFkknzk?=
 =?us-ascii?Q?r5XimkJCTVh3A6TG4IU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80149a78-bdb1-41fc-612a-08de31256957
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 22:03:08.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMFOUGjlSeBQFQzRkQX1Kr6XURUcIxKRE1JDQ8W3S1n5+dpZOOS+BsflUuRnAQKqQUD/QU2RZXore+c/z47/tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10017

On Sun, Nov 30, 2025 at 01:03:38AM +0900, Koichiro Den wrote:
> Hi,
>
> This is RFC v2 of the NTB/PCI series for Renesas R-Car S4. The ultimate
> goal is unchanged, i.e. to improve performance between RC and EP
> (with vNTB) over ntb_transport, but the approach has changed drastically.
> Based on the feedback from Frank Li in the v1 thread, in particular:
> https://lore.kernel.org/all/aQEsip3TsPn4LJY9@lizhi-Precision-Tower-5810/
> this RFC v2 instead builds an NTB transport backed by remote eDMA
> architecture and reshapes the series around it. The RC->EP interruption
> is now achieved using a dedicated eDMA read channel, so the somewhat
> "hack"-ish approach in RFC v1 is no longer needed.
>
> Compared to RFC v1, this v2 series enables NTB transport backed by
> remote DW eDMA, so the current ntb_transport handling of Memory Window
> is no longer needed, and direct DMA transfers between EP and RC are
> used.
>
> I realize this is quite a large series. Sorry for the volume, but for
> the RFC stage I believe presenting the full picture in a single set
> helps with reviewing the overall architecture. Once the direction is
> agreed, I will respin it split by subsystem and topic.
>
>
...
>
> - Before this change:
>
>   * ping
>     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=12.3 ms
>     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=6.58 ms
>     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=1.26 ms
>     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=7.43 ms
>     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.39 ms
>     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=7.38 ms
>     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=1.42 ms
>     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=7.41 ms
>
>   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 2`)
>     [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
>     [  5]   0.00-10.01  sec   344 MBytes   288 Mbits/sec  3.483 ms  51/5555 (0.92%)  receiver
>     [  6]   0.00-10.01  sec   342 MBytes   287 Mbits/sec  3.814 ms  38/5517 (0.69%)  receiver
>     [SUM]   0.00-10.01  sec   686 MBytes   575 Mbits/sec  3.648 ms  89/11072 (0.8%)  receiver
>
>   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 2`)
>     [  5]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  3.164 ms  390/5731 (6.8%)  receiver
>     [  6]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  2.416 ms  396/5741 (6.9%)  receiver
>     [SUM]   0.00-10.03  sec   667 MBytes   558 Mbits/sec  2.790 ms  786/11472 (6.9%)  receiver
>
>     Note: with `-P 2`, the best total bitrate (receiver side) was achieved.
>
> - After this change (use_remote_edma=1) [1]:
>
>   * ping
>     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=1.48 ms
>     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=1.03 ms
>     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.931 ms
>     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.910 ms
>     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.07 ms
>     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.986 ms
>     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.910 ms
>     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.883 ms
>
>   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 4`)
>     [  5]   0.00-10.01  sec  3.54 GBytes  3.04 Gbits/sec  0.030 ms  0/58007 (0%)  receiver
>     [  6]   0.00-10.01  sec  3.71 GBytes  3.19 Gbits/sec  0.453 ms  0/60909 (0%)  receiver
>     [  9]   0.00-10.01  sec  3.85 GBytes  3.30 Gbits/sec  0.027 ms  0/63072 (0%)  receiver
>     [ 11]   0.00-10.01  sec  3.26 GBytes  2.80 Gbits/sec  0.070 ms  1/53512 (0.0019%)  receiver
>     [SUM]   0.00-10.01  sec  14.4 GBytes  12.3 Gbits/sec  0.145 ms  1/235500 (0.00042%)  receiver
>
>   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 4`)
>     [  5]   0.00-10.03  sec  3.40 GBytes  2.91 Gbits/sec  0.104 ms  15467/71208 (22%)  receiver
>     [  6]   0.00-10.03  sec  3.08 GBytes  2.64 Gbits/sec  0.176 ms  12097/62609 (19%)  receiver
>     [  9]   0.00-10.03  sec  3.38 GBytes  2.90 Gbits/sec  0.270 ms  17212/72710 (24%)  receiver
>     [ 11]   0.00-10.03  sec  2.56 GBytes  2.19 Gbits/sec  0.200 ms  11193/53090 (21%)  receiver

Almost 10x fast, 2.9G vs 279M? high light this one will bring more peopole
interesting about this topic.

>     [SUM]   0.00-10.03  sec  12.4 GBytes  10.6 Gbits/sec  0.188 ms  55969/259617 (22%)  receiver
>
>   [1] configfs settings:
>       # modprobe pci_epf_vntb dyndbg=+pmf
>       # cd /sys/kernel/config/pci_ep/
>       # mkdir functions/pci_epf_vntb/func1
>       # echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
>       # echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
>       # echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
>       # echo 16 >       functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
>       # echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
>       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
>       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
>       # echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
>       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset

look like, you try to create sub-small mw windows.

Is it more clean ?

echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1.0
echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1.1

so wm1.1 natively continue from prevous one.

Frank

>       # echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
>       # echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
>       # echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
>       # echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
>       # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
>       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
>       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar
>       # ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
>       # echo 1 > controllers/e65d0000.pcie-ep/start
>
>
> Thanks for taking a look.
>
>
> Koichiro Den (27):
>   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
>     access
>   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
>   NTB: epf: Handle mwN_offset for inbound MW regions
>   PCI: endpoint: Add inbound mapping ops to EPC core
>   PCI: dwc: ep: Implement EPC inbound mapping support
>   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
>   NTB: Add offset parameter to MW translation APIs
>   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
>     present
>   NTB: ntb_transport: Support offsetted partial memory windows
>   NTB: core: Add .get_pci_epc() to ntb_dev_ops
>   NTB: epf: vntb: Implement .get_pci_epc() callback
>   damengine: dw-edma: Fix MSI data values for multi-vector IMWr
>     interrupts
>   NTB: ntb_transport: Use seq_file for QP stats debugfs
>   NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
>   NTB: ntb_transport: Dynamically determine qp count
>   NTB: ntb_transport: Introduce get_dma_dev() helper
>   NTB: epf: Reserve a subset of MSI vectors for non-NTB users
>   NTB: ntb_transport: Introduce ntb_transport_backend_ops
>   PCI: dwc: ep: Cache MSI outbound iATU mapping
>   NTB: ntb_transport: Introduce remote eDMA backed transport mode
>   NTB: epf: Provide db_vector_count/db_vector_mask callbacks
>   ntb_netdev: Multi-queue support
>   NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
>   iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
>   iommu: ipmmu-vmsa: Add support for reserved regions
>   arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe
>     eDMA
>   NTB: epf: Add an additional memory window (MW2) barno mapping on
>     Renesas R-Car
>
>  arch/arm64/boot/dts/renesas/Makefile          |    2 +
>  .../boot/dts/renesas/r8a779f0-spider-ep.dts   |   46 +
>  .../boot/dts/renesas/r8a779f0-spider-rc.dts   |   52 +
>  drivers/dma/dw-edma/dw-edma-core.c            |   28 +-
>  drivers/iommu/ipmmu-vmsa.c                    |    7 +-
>  drivers/net/ntb_netdev.c                      |  341 ++-
>  drivers/ntb/Kconfig                           |   11 +
>  drivers/ntb/Makefile                          |    3 +
>  drivers/ntb/hw/amd/ntb_hw_amd.c               |    6 +-
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  177 +-
>  drivers/ntb/hw/idt/ntb_hw_idt.c               |    3 +-
>  drivers/ntb/hw/intel/ntb_hw_gen1.c            |    6 +-
>  drivers/ntb/hw/intel/ntb_hw_gen1.h            |    2 +-
>  drivers/ntb/hw/intel/ntb_hw_gen3.c            |    3 +-
>  drivers/ntb/hw/intel/ntb_hw_gen4.c            |    6 +-
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |    6 +-
>  drivers/ntb/msi.c                             |    6 +-
>  drivers/ntb/ntb_edma.c                        |  628 ++++++
>  drivers/ntb/ntb_edma.h                        |  128 ++
>  .../{ntb_transport.c => ntb_transport_core.c} | 1829 ++++++++++++++---
>  drivers/ntb/test/ntb_perf.c                   |    4 +-
>  drivers/ntb/test/ntb_tool.c                   |    6 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |  287 ++-
>  drivers/pci/controller/dwc/pcie-designware.h  |    7 +
>  drivers/pci/endpoint/functions/pci-epf-vntb.c |  229 ++-
>  drivers/pci/endpoint/pci-epc-core.c           |   44 +
>  include/linux/ntb.h                           |   39 +-
>  include/linux/ntb_transport.h                 |   21 +
>  include/linux/pci-epc.h                       |   11 +
>  29 files changed, 3415 insertions(+), 523 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
>  create mode 100644 drivers/ntb/ntb_edma.c
>  create mode 100644 drivers/ntb/ntb_edma.h
>  rename drivers/ntb/{ntb_transport.c => ntb_transport_core.c} (59%)
>
> --
> 2.48.1
>

