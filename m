Return-Path: <dmaengine+bounces-8913-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ry32GtNvk2mg4wEAu9opvQ
	(envelope-from <dmaengine+bounces-8913-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 20:28:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB4914749B
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 20:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0826301DAFD
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3082E9EDA;
	Mon, 16 Feb 2026 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="idNJYuGL"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD095263C9F;
	Mon, 16 Feb 2026 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771270096; cv=fail; b=JYxV1Popat1tM3cctKit2mHRvjqDQLmtV5JF5eghUtauJXBUFOy4Fa40xVIEtDfHPGxqFSIQgmGhZdclOiHv+3GEeu3/m9W9uUnLypgi07wOVhmBCRceZVfMZ7argpQ/kl9+jgURwcD84JigWKKZH/dBUkDOXzsAuRSuCJlQiNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771270096; c=relaxed/simple;
	bh=GLVcV5h5ROAqwulDIyq6x0d8FmbgVbjIpHxIBepMgA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kClDWGhRYLAWlOqiS/Uz3Vx3b6UphxjIAtVhZxyGWQ56McL5J8/h6VB++W5x5KYCRz204u1au82uYiEz1IE7ksTyA/+fqCLemZYfMAV4XuJ0b16hDnuO92haavqi9DeZmN+igP3QHUbKV7AJqgbcKA99TACzqUBbpWLJ2WOuGl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=idNJYuGL; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1ql2K/l9/459IUU3PUvqL6K8NuidZejJOytXwjdAc9Rkwyinm2szLKdtFHe7z5mLN3Ry01iRcI2/Us2+nmSce260BHarZxvvwMBOYjkwmhTZzUwiueRpNg3UZpDsDyZA8rLmVt8uT/viV2wGRYjoMCKApPMGFFx23oWjZQ6JtvedKy7/ZipZ6YA34szu5Ai4A4MaiCfdcgAWqzB/jggPqbQKiyny1QmTQ4O4/BjdYOo9Px/d2ylHfQaxBvatWLNr9LefD2IJ/fh7XZzVQTIq0iX58dkWAMRU6AD+REqJ54KNf7xZTJoGw0jhs3yjVVR2PxNS73lhHWP08HAlPWC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jzffdr9oFVMK874WyNKULWLWR4TMUSFKB2DVJJBaJM0=;
 b=i+uZYqy9l0Rufm50GzszRmvl3NMngyVDBdwsFpz0cNHIpiYcKIQ9HBpXsNiX1arQtn5ZHH5brIGr7uVWvx/U92i5DUnMjnuEkKrL98rmnE/+YGJs1g1wivMz9NGC8JIMK90mbBgcdMq17YMYgTNYapidnMNj5v4Ow9kiqgxa1cmCQ/deq6Y47VTEiq4e80JeSK0RYKDk7FTiabDlhh/MAt+hE21A8y45prCuSfR9sqAs3egg6dbhnZNPvVA4ddf8Uad/tHb3950x8HADO1F2pOKXRMnguOhyFK/NApXaNGAvCdAHWWB1AWORaR4lM2MY0/S8c4a2kl42xHZas+e1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jzffdr9oFVMK874WyNKULWLWR4TMUSFKB2DVJJBaJM0=;
 b=idNJYuGL2pohz4Ems8m2UExNa75V5HHeL/UIdeE+ckOeKbfqFSmttnZSZI4koJUOA3W8yXuJYtGQDNCzDnwgYCbBdT1R9yaQGeviFHCT4bUBsm526pPb6liE6g7qZpcju0nnhciGZmN7uxhibJFPk5dlQQsJ4fhkAEe1C9KD6HXgG/+VAGnYK0LntkbWdjjyfrtr6iNgk9eKtCCsvUJt2kQ49Syk2WhTrXPXTfr29KpCvNbpiDPoPDPsyD5bT1aQ7se+fSR8iFhRwbb0GCIo5l6A+q8V3ygyuy64O+XMal/yzLCc+4Q67oHlwmj1Hl2eBEYx3UeVzyhDDK1IN6Lnpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB7588.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 19:28:08 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 19:28:08 +0000
Date: Mon, 16 Feb 2026 14:28:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH RESEND v10 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
 Support
Message-ID: <aZNvwOa4sexnlHdy@lizhi-Precision-Tower-5810>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-2-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216105547.13457-2-devendra.verma@amd.com>
X-ClientProxiedBy: PH5P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: fee36be7-f000-4df8-11d7-08de6d918384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Gh6ysvYQO/8bDQL8cy54arLLGceSJ8UWA0JGEyBPognO21h69hu7uxSRWh3?=
 =?us-ascii?Q?KAYfbwS1cuYCljt06K0OzeE3Og/hM7HLtFRVe0XMxtjn7yH3ILc3OvM6ERIE?=
 =?us-ascii?Q?Q8QB47m6bqkzu6NeaZoTNZGLI8S0rpGZqL/7H3doaXdKRvDTK0v274cLF/Se?=
 =?us-ascii?Q?F4c0qFAY3K976l7zR/JA6CDRlRRzv0zYOprh7U9Ve3faFaTihYhQluciaC6r?=
 =?us-ascii?Q?cizQ0WCYES6qr8+jvTaAKxg7S1Ey04nOFApY8hk53MyL0cXHk5xKcWb419q3?=
 =?us-ascii?Q?7YWFgMG+wjkXITDjz4eGPBPviITsYEKBUvgKdp6gtkAoxIgj/oOwtigB0kEY?=
 =?us-ascii?Q?BylfckGjaqhhNmG03CNHVUp1EbhzeVXj6p/4H85fVmmh3Nqt3/uG9XGBm8vz?=
 =?us-ascii?Q?sgnsgfdymw9Ng7o+FgdXRY/flvBvjIoa5pGqmqhSrkAdo9tT7NXjBP4twXoF?=
 =?us-ascii?Q?l/4rc+THIxsk9JUWDxBokDJfqS5Lx4uOMW1sVU9TTIm0UblssuVePqT+gf1V?=
 =?us-ascii?Q?TnuenKoehiY+Ca97nVcNDNmo0kDjYewrB0PqnS8MEzl1H461z3yj6/sS5BCY?=
 =?us-ascii?Q?N3+5eX8NFtvy+MibY2lhvyFvSu/UN3NV/ZoTTqM4CmmfPZF2JV12mKktlrdm?=
 =?us-ascii?Q?vuk7V8yyvC9k4Rxz7adsDvsQyi3+7u9jdpUi5vPrwnXNt+b3Uz8Id+jAvC5X?=
 =?us-ascii?Q?GsYGuhaQDNfWV2oSFF69k84FEDmiV5K86GFvlfrg9Lenrok1+miLVwwvTHeD?=
 =?us-ascii?Q?t3BSj2sf6zs0xcIWwJHBpBo4r29iv+uRYx9D9Um6MtBpHquLdEZ/m5awp3hI?=
 =?us-ascii?Q?nvcxvemW+MC2Z23VtzDNScpzH+AAxtiD4ePyLH07hRfnFskmhjgXCP4UhYED?=
 =?us-ascii?Q?YyA24We4cIDqyHmwyoo39mcJQfhiA/HEwpInyYyZq/fp5Fv5v1w95Zn13ZQO?=
 =?us-ascii?Q?wxh94LuwCZoPMEl05mfM8UmZRrmIB6mz7ianMsD22tbfKW8kg2MVWTJaVWf7?=
 =?us-ascii?Q?DMImQpsAj0f7Uw+amF92wK0OUNiWAKJ5LGitQniURdHdLWtPleaIqOVx/uKc?=
 =?us-ascii?Q?9bJYrdSgNhMqI1nbIUd6VqPTCTU6XpXhCLhlCgK2ZJj9ypmqHeMykuttk5cH?=
 =?us-ascii?Q?9CW6CzMhB1S1if2DxVZSb1WbnauncZbwjEK2rlwmzLwUT0RMpYm4uRr6QKrG?=
 =?us-ascii?Q?PhvtKvFPYTKcc0XaEKPrSbI88HU3bDS7AAwCFMjNw6k8sPYkCQ2h5lv6KTyX?=
 =?us-ascii?Q?lyjLb51SyNAl594ET9jQdJ/cFJwQCeOX1JBRUapHGakdVluGEk/KBJvf98Ik?=
 =?us-ascii?Q?uE8OD7bTYfOGQOIher/8ulBPqqHZBDE4pqHGS2DcHISffYaiaJzM22+g24C8?=
 =?us-ascii?Q?e0LK++2mXejUUI+wVeK5Mgx/GVLObryxc9PUKqClRD35jP+oPMMgIaPzYs9r?=
 =?us-ascii?Q?rTk/qopK1O1LVm7OkLNTklsyv+Zq9zX3SX8NnEZTEvHrufn1KsIA0+Qi79Lz?=
 =?us-ascii?Q?+Q30H3MD5ItPl+x2puWhHUV0jeUGvvmI11uHHx78IIsz4QWp2p/J1pXcIVNZ?=
 =?us-ascii?Q?grM95hAgTqZaFZnh7C5ag5AMLkJ5p0/nQ1200r4rjK0erfF78ncRCVzYmqtz?=
 =?us-ascii?Q?tJeBp8bYgu5PvQBQqdAcf4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1hGY5X2Y0dSxWeOdOVVGA5l+Et9RKt1fEKDZr5ht6ji7oMytB4Dd4Fu50+a?=
 =?us-ascii?Q?Disr+vXe1/a3JInTrvwYZjzw5JaZTdIRdwPBxz+iMbzma22WTVhtwqF75MiS?=
 =?us-ascii?Q?OA4sf0/nd4nXqjmK/4GxBf/fw8MXFmMydDsQ8tp0UnurNZYVxR2KjH9y7HaG?=
 =?us-ascii?Q?G3TBQzPn3t2bCs+frymwjrs833L0vu8feHLtKw+mYn+hgMOzr8PEXVQ7SLpI?=
 =?us-ascii?Q?1MmGFQvlbBnhrrafer97RTC0d1KVb1oQthJlaE2xSVTugj18KWLsBQ4rB4j9?=
 =?us-ascii?Q?gel5iblbVKHq3rb1MKskd00CH7Iwf/6mSuJwIcgONIlL9BcMgHCOQ9WebvQf?=
 =?us-ascii?Q?fgNVIEOLk85oEetey0wM95pqYKr2Nf+90r6wwNHGe0DAAgbLsKgy5CkEf9QI?=
 =?us-ascii?Q?GgEh8IrUdfzTndR11Efn7dkRB9zEVqsLDg57A8nqi1wyaVpvLEXC4gPp7vRb?=
 =?us-ascii?Q?nRzLPDpk3khCgnq9o/sYLfCnZDihDV3Bp0jnneUqHLBjzuNZw+nJFX3KWSYU?=
 =?us-ascii?Q?h4kkgAJHcdILCq4pRxoU7+oBlGmWdeuah7EjsheWNsGXODPBRXsG9LSjXsR9?=
 =?us-ascii?Q?IF/1T9ILTkMILHIcXJ1WXiTuGLbt3DJqQfbq/zeWzCov6EWuSROG/hnz0VNB?=
 =?us-ascii?Q?YTCEGv9ltzFR1d2kuVqOvWJKSUp0WlvzEsmRbTyJHY15bGw2kGGxqsIqiyKq?=
 =?us-ascii?Q?2571yBhbvbEMCg0DlUAlOsYXBUdgfbFkuiqYt0A2jGf8nniOyifbHVfp/3mL?=
 =?us-ascii?Q?d9ExwY0FUOc761dNjQ05iz/buXvZjBzjxFjY+mSBRUqcs0+qfQT0Sog9zBWO?=
 =?us-ascii?Q?eorPEG/6R336pvYQXEGCkCLwftkog1NIPbDtnPzysziZX2+LZ/nFlZh4DO9S?=
 =?us-ascii?Q?hMc1QLofgUnDMXEArS2KyiYAOQ7C4jsFIY7I4+UZRA7fYn8kTWr6pGVUWHej?=
 =?us-ascii?Q?NNuDtVka6fyZYHlViQY/UQY4ayXIgLn2jehVRmKKw7rd0jFS1Ao0unCnQkXn?=
 =?us-ascii?Q?A5PazEwIjjZDwqLIuRhbTZ3vdweY5l0gSsIpfc0CUqqhIK9DWIC0MPmXOwyi?=
 =?us-ascii?Q?XUrsvf/WGE/342C1OBpYu/Fx+KZJxvpTU6xeQbS6oPlX2T8Mc+2utauYBu1a?=
 =?us-ascii?Q?G7sh7ka4ra4C8nLIaJt/XHiEVpGQSpsf8OTyAD8Kdol2cHcaiHEPVCCkUzjX?=
 =?us-ascii?Q?la63nYXhrpw/xtxuiDV1TJrmMGKE3FPxPlRPTiL1VK2cw8Q6ngptiDIjxAb7?=
 =?us-ascii?Q?KeDktTn6J4I9Vaxiv4SqQSt5aO8jjA4JdwfY7QVhAAS+Ip1I1CqKi7FyopGO?=
 =?us-ascii?Q?Ds4rxOKbg29my4nki0mo2M4mDWT538tct2yR6IEp/wfVbcU3k2BzAv73JdDj?=
 =?us-ascii?Q?fEhSsRU3ZWV/diUaeK094q1qm0EowfAV9ey8FRXvcFzkuDFu/IWQc5NDMKg/?=
 =?us-ascii?Q?54h6RfymPZcpYxc6w4BE6HGYPVKfrd0bHNRnYju3kTtQeZhamqIt5MeswooM?=
 =?us-ascii?Q?ysVQks1jMKUom2ZMujWcl7aRlX8gCFUoaucXIr3KbVjU/kQcqL7d/wMixevs?=
 =?us-ascii?Q?shcIbE9U/qUxl25owfjF6hAfaM/+PFrTYUGvZTibboPJNS3Sec76avAzEgR4?=
 =?us-ascii?Q?VE5ZbfqPuWkV2lt3rWLpcxAV31YImzz+SmR6W2TnsUx3hp4CIPnwD/GZ0T0D?=
 =?us-ascii?Q?s0bvw7AFZn6KlnioHKV2MPg8KiSP66HqD+KVaD0ORSV0xzmrE+zw2+/FQka/?=
 =?us-ascii?Q?elMMei2YJw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee36be7-f000-4df8-11d7-08de6d918384
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 19:28:07.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGvo10v5AC9fRG+SVx5/AEhaTHx1y2rImFSyngmnPOO8PUdyxAk6A1Ntb+/ap3w12DmGaRf3+Tj6cRlRY0BWRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7588
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_FROM(0.00)[bounces-8913-lists,dmaengine=lfdr.de];
	TAGGED_RCPT(0.00)[dmaengine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: BAB4914749B
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 04:25:45PM +0530, Devendra K Verma wrote:
> AMD MDB PCIe endpoint support. For AMD specific support
> added the following
>   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
>   - AMD MDB specific driver data
>   - AMD MDB specific VSEC capability to retrieve the device DDR
>     base address.
>
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v10:
> For Xilinx VSEC function kept only HDMA map format as
> Xilinx only supports HDMA.
>
> Changes in v9:
> Moved Xilinx specific VSEC capability functions under
> the vendor ID condition.
>
> Changes in v8:
> Changed the contant names to includer product vendor.
> Moved the vendor specific code to vendor specific functions.
>
> Changes in v7:
> Introduced vendor specific functions to retrieve the
> vsec data.
>
> Changes in v6:
> Included "sizes.h" header and used the appropriate
> definitions instead of constants.
>
> Changes in v5:
> Added the definitions for Xilinx specific VSEC header id,
> revision, and register offsets.
> Corrected the error type when no physical offset found for
> device side memory.
> Corrected the order of variables.
>
> Changes in v4:
> Configured 8 read and 8 write channels for Xilinx vendor
> Added checks to validate vendor ID for vendor
> specific vsec id.
> Added Xilinx specific vendor id for vsec specific to Xilinx
> Added the LL and data region offsets, size as input params to
> function dw_edma_set_chan_region_offset().
> Moved the LL and data region offsets assignment to function
> for Xilinx specific case.
> Corrected comments.
>
> Changes in v3:
> Corrected a typo when assigning AMD (Xilinx) vsec id macro
> and condition check.
>
> Changes in v2:
> Reverted the devmem_phys_off type to u64.
> Renamed the function appropriately to suit the
> functionality for setting the LL & data region offsets.
>
> Changes in v1:
> Removed the pci device id from pci_ids.h file.
> Added the vendor id macro as per the suggested method.
> Changed the type of the newly added devmem_phys_off variable.
> Added to logic to assign offsets for LL and data region blocks
> in case more number of channels are enabled than given in
> amd_mdb_data struct.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 190 ++++++++++++++++++++++++++---
>  1 file changed, 176 insertions(+), 14 deletions(-)
>
...
>
> +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> +					     struct dw_edma_pcie_data *pdata)
> +{
> +	u32 val, map;
> +	u16 vsec;
> +	u64 off;
> +
> +	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
> +
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +	if (PCI_VNDR_HEADER_REV(val) != 0x00 ||
> +	    PCI_VNDR_HEADER_LEN(val) != 0x18)
> +		return;
> +
> +	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
> +	pci_read_config_dword(pdev, vsec + 0x8, &val);
> +	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> +	if (map != EDMA_MF_HDMA_NATIVE)
> +		return;
> +
> +	pdata->mf = map;
> +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> +
> +	pci_read_config_dword(pdev, vsec + 0xc, &val);
> +	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
> +				 FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
> +	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
> +				 FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));

In https://lore.kernel.org/all/20251119224140.8616-1-david.laight.linux@gmail.com/

suggest direct use min()

Frank
> +
> +	pci_read_config_dword(pdev, vsec + 0x14, &val);
> +	off = val;
> +	pci_read_config_dword(pdev, vsec + 0x10, &val);
> +	off <<= 32;
> +	off |= val;
> +	pdata->rg.off = off;
> +
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +					DW_PCIE_XILINX_MDB_VSEC_ID);
> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev,
> +			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> +			      &val);
> +	off = val;
> +	pci_read_config_dword(pdev,
> +			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> +			      &val);
> +	off <<= 32;
> +	off |= val;
> +	pdata->devmem_phys_off = off;
> +}
> +
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> @@ -184,7 +322,29 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
>  	 * for the DMA, if one exists, then reconfigures it.
>  	 */
> -	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> +	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> +		dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> +
> +		/*
> +		 * There is no valid address found for the LL memory
> +		 * space on the device side.
> +		 */
> +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> +			return -ENOMEM;
> +
> +		/*
> +		 * Configure the channel LL and data blocks if number of
> +		 * channels enabled in VSEC capability are more than the
> +		 * channels configured in xilinx_mdb_data.
> +		 */
> +		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> +					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
> +					       DW_PCIE_XILINX_MDB_LL_SIZE,
> +					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
> +					       DW_PCIE_XILINX_MDB_DT_SIZE);
> +	}
>
>  	/* Mapping PCI BAR regions */
>  	mask = BIT(vsec_data->rg.bar);
> @@ -367,6 +527,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
>
>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> +	  (kernel_ulong_t)&xilinx_mdb_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> --
> 2.43.0
>

