Return-Path: <dmaengine+bounces-10032-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPw4FO/M5WlIoAEAu9opvQ
	(envelope-from <dmaengine+bounces-10032-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:51:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2181427768
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27C693002B38
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236DC383C68;
	Mon, 20 Apr 2026 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VYOMy403"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0311383C81;
	Mon, 20 Apr 2026 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667885; cv=fail; b=IwqK1TuBHg0uH3rJ6kCjxQg8JguS3hFm8EB20/gSsc9M64EO83MhENrquu37b+pc0Ckbqza3Bl2sDaUhv1IMTBE7D3kgo/KGykYfJb9sYnUONKkyFx5w4wkvssPYJ6pp1B+C5S9FIGLJ/1Q/knoD7Ljbqlp18fMa0CsDSJqSlRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667885; c=relaxed/simple;
	bh=l+qt8k4BQ7B60Dp3DjbBlkbwkg6b2qrRx6YBlEp26L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MO54zyOSCNUBA7e2r+QxhdLr+m4VXdvaTgyaXCRg02NfbU7oxwxv4y2HkDIqhsXVFaxT3/3OckM6D2I+FdLaaLntob3eIAMtTSOpkBrOtUxQb+NU5qhqIeTyVzYYprXMr26BBNShAyIJULL6XVxTPEb/U58oZpO4jXHldGrNP4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VYOMy403; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygaudbRypMot911IdIa4MenvKHcXgDBx3/atENB9OeG3DUtW2pjXUY1kiPAXHHerQIaaqJHYDCWRj5KC0sVOKXcFaxsO4IL7vi4+tCYpKDzhLCkjuE/2PX35Z+7YR0KvABzRXdwbEj4dglMgkHaaRLBk4Q682Qnomu99pAv1ctMhyfEITLFCmLa3N/xX+cX/cLfBzZZX4v4ZSsMYguqAzq1sted4ubAurdwmpCKjXRUO/T8QZDhJfwqHa2+lqK+Vd7uXaf7o5jHFCRRMBSqbpicQp6OpXfpWHJelSPighA8XQUpwjMiu3YPq3UVADzNuXhz/SpocfXkDQ6I117SlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciE+OU4Cp/6P2zrmTT+Z0Uc++vCPUJ4y+4U4yAY7H6Q=;
 b=F6ylA7oE6ddfGdgoPPQUuoDeYEwM3rLcjVOLvKl5ZOUHx1M1BZUAQtXMzm3H3j1awTEvIDOe/g3rihjv7BE2cGVP5bc0+BAOKG+8ETerIIhUMZTuL5cdB0Yze3epvlVboDXs9jWbqk+IWsLcG55icb6m4DrmjqRJZxH/dVq8wPmrMldqbRh9QEwxSYAf47kLQQ+kqvqQ0KWmybkzpO6n0Ecf2QSMqHpRkW9/1jTsUmSn9AAA+w00fXu5K+BZ5R4xG3J90jA1QyL/8zUWQZ2x+CWyzXILb9kig6/9JPCbj1Owlp0mVtQMNt3l8Bi3sZ+VY2VgR+bUO+8GLhRiIEWP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciE+OU4Cp/6P2zrmTT+Z0Uc++vCPUJ4y+4U4yAY7H6Q=;
 b=VYOMy403dKq5hrGjhhfFkMmrCcuk/I8dT+azRWya4cDJcoDBbvYOOUI8wPXcbP2o/+tOGEQ86EGt3zbB+YnKYsRxO0JtXON9Qp0eoGBue7YiG7yY92MZ9k+pUdWJH6HE4sc5rX7U3jbMgasLPx4iDG9G8pp+tbZe+VucWVWj8yI7QM7FCSnKTA1e6JD2Nfod4u8qxgsyj2HrxcjBdtr2lIEp5jtS+9GejtBDDxC0hhdjbw1Ngt9VhmJ6JalkkMXcFxvURqefSz6/ZkFBqsHBohx/9f9Ms13X+HaAJia+FgUyFO3YaI54VTBvSVv/mMU6TQPDsSeQBu55WIq0tijMow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 20 Apr
 2026 06:51:19 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 06:51:18 +0000
Date: Mon, 20 Apr 2026 02:51:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com, John.Kariuki@amd.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 04/23] dmaengine: sdxi: Feature discovery and initial
 configuration
Message-ID: <aeXM4IChNyCX6vGp@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-4-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-4-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SA9PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:806:21::35) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: fa537b84-bacb-4de5-8da4-08de9ea9397e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	Do2TZAjra2W2jZ7PzfMU6pM5TLlcVKKHMhSuozkwYke7A62ZHtKyr7AcSeMCczPaYCvTkyrY7tzLyvoG/yPLD5bsQvEh+5ILy/Iuu2SrmPjJTOuAloIxYGV6RY8SlgFYqSC/RJhrQ7iSHQZQMtUxR3BrAenqCNGOZMyMJ7GUPEVv6x3QxHd74VichZHkkSYqqbdCGfCuLUzrdq8uVF2mn9bTcN59MpNvpJAUAZ8Yl5e0vYsitUyVvBeQfWlPUxzngcOeG/xZLlOIrQK4MJsq9JQs+PerEcoZg8fZU7VSdvrTZwZE5jiHpPu8IkyG9CVh4FuJetyGZ3tt8clPydjl7b7KnaeJX3zvoy8iEvWcxeVw/Y3o7VN/1eNGPzIpRrGtVXPekoQVYOqdduS/dfQRhzNin/LdaTh1XyLSa6RllOx1lLCdI1JBe56BJC81h0gz70TxAUHO4Ft9nJ7ynLpOssz9WhxaJoEmo0pax7HUje6/LXpNjV69z0mEifPlmtv0bkRMUyhPE8T5qQ1yP/ad4l9+ZvoQCAGP3fLNPg8htCfgqYbB+WWbJnoBX4ZuGlfl99R9TKxgGxgojkjd3SWZcBiMAQPPAEFUamngZzUrF41bZXrjOi5HpBS4K6n+eJOfKqZx6lSlIBTDE0rICTAKV9M1Lhq++vYVpsWgfCDZ9P3vG/TktIqUp3XnRHXzrA/mMYyc1UFxpR3uNV/Bj4vn3sGb7DsMZP4sRMDeGNNtgkw9rgXsmTKs4+ZZyp0pUZVvPq1wmrLCacR75HGZGa0N1vPliyqHEQveBI2j47v0nOs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NAoBnNGI/NqvVFDWEtnvqoSmWM8uaBVlbDi/sysaXE1sx+Dk9lY119bV4a/Z?=
 =?us-ascii?Q?udlFoGK9Bt031TXFpYZzTVmntl0Ri7VtHHgEMToolAErSgBqeeELoycbGCw3?=
 =?us-ascii?Q?2kyagxrr8A7Wd24LdGMk/iZ0apUkIRS+VVQVsAkIUAsl/5TQckoHDr1SJEud?=
 =?us-ascii?Q?mYNrwiPNZpUsQvxSAsnC8C5r1PUqF+XM+dLwt6MXC4PHAJbQbtgXnCmfDyu7?=
 =?us-ascii?Q?3x0qI4uL5Le98mAkiGX+XholwrFInrImrvboPQ7b3m7rpTQnlODheb2h0n84?=
 =?us-ascii?Q?AHr6og9irUTR05DZ5dQ9T+P8zHoFDVpjGZ3HP+RitY79OseFXoPvKGUAEV44?=
 =?us-ascii?Q?2ivN3ohi8Gr1VYMJroVJeiuV3Smzb1wqjNXkrKv/WD1okwOvnu+MU4eoVBts?=
 =?us-ascii?Q?vnX7Ad95yoSvHQasXnAFbs8MemHxEII25LjcFcioGoZqYC8EmHDGB2UymxG8?=
 =?us-ascii?Q?LaQx1zz9wnW3l9PGyRoWvdtdqL/hEfSMK2wY2hfEqZPRaWrsTkrx2eOjDjRX?=
 =?us-ascii?Q?AFCkIPAu1XES+KuLggqTdYWFzP98bvV0NCmfdExxmxJkQ2e1A55yOj4c3j6C?=
 =?us-ascii?Q?dcw9nrg/ncneLYBN4rkc6YJqjFuAAZuSYjK8Pv9zysXwA66C8Dk9uEunkJ4s?=
 =?us-ascii?Q?qoGPWe0LzArR3cVlacRTxfbn7ifY71ugQpDm/0yiKdN7BUdHmEVg+Ertu2t8?=
 =?us-ascii?Q?tMGn3W5ci2zjub7gky14M9rV9AH1mVZkJlO2ougqBd7F9WMjPcB+AyiPT1tm?=
 =?us-ascii?Q?ER9Qhg242SlJKpgk5y6XEG9pcyn/to2iYRjWItkoEccNIvfIPuvAWLUyx5NW?=
 =?us-ascii?Q?49DegKCAmA7qYZuh4HbqAGJB98OQLgM+kbsUv8wzBFLpaaEtgkwnzfuT7sIS?=
 =?us-ascii?Q?Jza5wlmBguUHezx04IJdXD8NqlSWDoTf8wx7awcsC7I4rxZuu5/1u50irq4u?=
 =?us-ascii?Q?i/5bhFT0rx56khlnbq0J6M5YD1NQikFMFUGnN6ZuoJbT2s/qOncQ/4WqITr+?=
 =?us-ascii?Q?WcBamU3FB1B4jGljdjK91+7Oi4tuH3C3PqozrXR/hOqiXg74V++yieA/YHOB?=
 =?us-ascii?Q?E9jB+EKTS6PcjhIugcGYeztu7Q3kbwtxp6cADAA/9ml/qY9gyHw4otupA2YC?=
 =?us-ascii?Q?vGdxrHKtRuIcKfAAQYHFyRLEvpvbOdTMYNZZrq0qcduqIj57pvZfdTTw08so?=
 =?us-ascii?Q?eIGpwXo7U7CmwMSwtHUjye+uHKsyyGN36pG3aQnB9PXHq9xycLiK8L++/Heq?=
 =?us-ascii?Q?hLCzB9IIy2id2Y+tf6/VDvPuUlKlv/5rFUbuSaT0BuL1io89heRE2xqJw5CC?=
 =?us-ascii?Q?D79BmtX3txSeXpuOmyEsWar2TAsVfHcTRGAuOSRwo+0rnqHb3kd3sN+HIeB+?=
 =?us-ascii?Q?bG08hTOVMA3dzMjtlAUSXXLyhRtuEq32CxkKrVvSnt2sq8XrDmaPq6EV1iRm?=
 =?us-ascii?Q?Fsfidj9b4jTpoL4cmKhZajIzFAPQbriADf4+Le5+lEj95iVWbBiVZetrgWp6?=
 =?us-ascii?Q?ZaYS1ftRm1TujQ4NvvNtCfOe5blQjW0H4kYi8RnSwj5llDiXn28nY6veGPjw?=
 =?us-ascii?Q?RGiwZaynZTH+NFtuu/OM/nYOLgaQSSRVVwt+0e7Gg4mhJeSvedv+k5KUNUeJ?=
 =?us-ascii?Q?FGK6GXt45nhkYOoMgej3OawPZAJXET4+SEmdz7px00GnxrYjU3UQYYNh8Aew?=
 =?us-ascii?Q?ev16UcNmI6Z7LPrQe9LYrndG0BYP2ZL/fkrKm7PuzUVOZXQH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa537b84-bacb-4de5-8da4-08de9ea9397e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 06:51:18.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfQHv19n8ABVIvEy6YAs8XuY5qhYZQF0il6uvDJUkioc1Z97pSdcvO5X0DWq2S/hH72tpkYJ6kLBTXMhC2DLyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7102
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10032-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2181427768
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:14AM -0500, Nathan Lynch wrote:
> After bus-specific initialization, force the SDXI function to stopped
> state. This is the expected state from reset, but kexec or driver bugs
> can leave a function in other states from which the initialization
> code must be able to recover.

Move this paragraph to last because this major funciton is
"Discover via the capability register ..."

> +
....
> +/* Get the device to the GSV_STOP state. */
> +static int sdxi_dev_stop(struct sdxi_dev *sdxi)
> +{
> +	unsigned long deadline = jiffies + msecs_to_jiffies(1000);
> +	bool reset_issued = false;
> +
> +	do {
> +		enum sdxi_fn_gsv status = sdxi_dev_gsv(sdxi);
> +
> +		sdxi_dbg(sdxi, "%s: function state: %s\n", __func__, gsv_str(status));
> +
> +		switch (status) {
> +		case SDXI_GSV_ACTIVE:
> +			sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_SF);
> +			break;
> +		case SDXI_GSV_ERROR:
> +			if (!reset_issued) {
> +				sdxi_info(sdxi,
> +					  "function in error state, issuing reset\n");
> +				sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
> +				reset_issued = true;
> +			} else {
> +				fsleep(1000);
> +			}
> +			break;
> +		case SDXI_GSV_STOP:
> +			return 0;
> +		case SDXI_GSV_INIT:
> +		case SDXI_GSV_STOPG_SF:
> +		case SDXI_GSV_STOPG_HD:
> +			/* transitional states, wait */
> +			sdxi_dbg(sdxi, "waiting for stop (gsv = %u)\n",
> +				 status);
> +			fsleep(1000);
> +			break;
> +		default:
> +			sdxi_err(sdxi, "unknown gsv %u, giving up\n", status);
> +			return -EIO;
> +		}
> +	} while (time_before(jiffies, deadline));

does read_poll_timeout() work?

>
> +#define sdxi_dbg(s, fmt, ...) dev_dbg(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
> +#define sdxi_info(s, fmt, ...) dev_info(sdxi_to_dev(s), fmt, ## __VA_ARGS__)
> +#define sdxi_err(s, fmt, ...) dev_err(sdxi_to_dev(s), fmt, ## __VA_ARGS__)

suggest direct use dev_*

Frank

