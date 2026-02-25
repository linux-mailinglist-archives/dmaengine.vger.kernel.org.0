Return-Path: <dmaengine+bounces-9084-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMbqCI8hn2mPZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9084-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:21:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD3F19A7C7
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16EF630F65E4
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9724623183B;
	Wed, 25 Feb 2026 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aat5GCoX"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38222329C71;
	Wed, 25 Feb 2026 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035166; cv=fail; b=b8Ha0z2i/qDwyZDDx4BOLRxE8vv7FBpCL7SyngOvlrVj0wKCb72napffxy0awVVhmSRCbCtr4COkIfZlPB+l0jJaQL5lW8H8lCnkeIxnCHmwXlrcDGR7nO1iu/CIldXHQryDFUk47bUPhD8eEMshyPxVHoKfdRHKxTGd7U6UOYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035166; c=relaxed/simple;
	bh=sltTo4iTsLQDf+vB5Te31unyz806lcI1d4Hws6CaHx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WA+4O7PfEEtVFMB8tYh/xW8SFEljjovVCr4167bwaJCP5NZOgLFw0UXr4aKCYajliaQeJLx96/1kCemOLuGwqznkc8/ZlqOZSn7CLU/+rmQpfQb5sKNUHBa+zVmm0UEpc1JIgvNbSTDpW68Mu5UkM8lyOCzTdILuzRcCNkWqipw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aat5GCoX; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb55BnEUBgYkmDk+33nLyHMRZiZu4sKvnhXKYFudyIs1lEvromv+fredKrZXgi5FFDqhq5/Mp4dqh4dIFSfcHVLKFTlmstburv2VK5JvtLkhOBu/1huEgRLlGwsCL6L/WbA0AYtmYwDKr98hoNMUp1UnWDmpmsvqHquqRCip7SC0/iIAH2G6CXZ66xeoCh46oWOJsd637XsNzXla018fInGJGX40dBkT+khRUpqeJJX2cppGr5Gom6Sy6ID0Xkbj+QWIb++zrB3rE9bMvVTlEM35IgDp4ywzlVCV4ufmK7ByFi8HNPdiZG8Bj5AUtMDtlSYQwWKsBqHFk9+xFQ/OoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU5+/mH4e4THScL9oOYyJ/vmrag8/yXTCNKNMqupNCk=;
 b=WcYYCl0Op9x8bhOh6i/KbQCGsYePyJ/CTE4WGqVUBh6+B7cITF9nHUi9VO/2AI7onglpofE9R5E6/kzenfvfvlUM9N7IZjpODK5jl82BAgwR6xcqevnN1eACcX1tyesjBVxAAiIwtkX5pOqKkUKqpGqRU1/fZRh/k3otoEn77mbY3hu1Cg3RcYGl6HEtrX76Wrviz+pkdYxgxDMZsiIvwqs7c0jtA2wYpHeFs/zj1ydU9QdIJ4pxTG0AUu+4OuJ5WjfqA0kdz1O+gK1pvzlWlBXhM9K8ypkiRQXSDisA8L+cQUMKyuR5pLWPC4chr3fXNUi9qb+JFCyRHLaHLMUNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU5+/mH4e4THScL9oOYyJ/vmrag8/yXTCNKNMqupNCk=;
 b=aat5GCoX8GsNkNIhpwGWT5bYEP+zVcvUTB+69Z0S68V2Y7P1VwPtJhWwMSPUTKScQK5TWMv+i/n8gsCRpqiOGbKYLW0y7Qv8S0hxufyJHI/7SGRiP2ez82Yc4XH+CshHj26b8YGgxJ2FfXLGrg11Ks09Qbq8Ql6Wrtwk51fpHLNOiUA6Ec/LGEgLo4fjgOMWKEy/SDkOlBgI6YzfUUiT3Xdivm+L92FComDUW+aem2gxeZiusrhxZggT79NfvsKoUWrGwRFPnKzXO4g/bIFnBG5+Kgl45a9asz2lQBcNqdiwNnd34TgotNIjn25s3UGMol31YB5nO10NXLGcyK4m6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7251.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:59:22 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:59:22 +0000
Date: Wed, 25 Feb 2026 10:59:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] i.MX SDMA cleanups and fixes
Message-ID: <aZ8cVP7E-BOEJKFu@lizhi-Precision-Tower-5810>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
X-ClientProxiedBy: SA1P222CA0144.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 496dced6-1a60-4d8b-6344-08de7486d756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	4c3I9q8oaP3QdyIQ+7hkpbpUdSECbJSeUlKGGEgV/po6C+3RSqrOhAu4TCXRVoLvqIJPwUFg3dWo5NAT0U5lrWS3ewuHD3SFhRV2wLspH+AC7kpgh9QSpc+8VH+fi2vZTXSsoTH0cygD8+zEd+wg8wosaOUCaV1iZCPZOWVWmFkFO0e8Ti0HbJwIvHZJOxdjZJKIppfklqGwU8OCC2sgAsFX3JJrkrf462pwF2rAlMqIXXPaUwnTcCrYpMnKgyQ5JklmWajzV+BD3kGy81hJWkjTdgmk95Z1fkXkjWsZfuPwScbb7DRilnqXUm78y6FvgYEQpPBV1kgD51pKZ37BsqLiBTJIvhPie3ZFhHE3N4qv+48X74+vzKkw48XOww7s72uo4Q/ICvGusyhZzgu5fldRDLxEzf2h8qDPkyL64nx9pCTvl7OrQVQAFpHVxE8GkXO5DkN9HGDU2uZES3DdQFYP2X2G8stM39Ch6qMZ6Rze/xTV47/ayO3NZ1t2R/IeNP01zIL7dZq0qcNfJyI99tVk2q17gh2Ss3bA0EuJfo4BfwYOqN+UrN5yB1SewlzItk69o2zrBpm+gLmVSjOAH1NF7u5lDJ/FAjDPMDfQvFYbfda/fWu2O+cpfpcv8Q6lii2VS2ivICiPMm4dJzu+8yultJifa16s37uzK0lFKkzpSHaADqa7KcLd8k0vz08SDBnVc9HMWu10e1hMnAEgKhM85i2io0JKaKky8Wx16/+LDBfLPkdGiW0mkRTmLaC1pUtw0KeMd3BmyNP0vAapfg28yJDSO0svY8hgYxEFnio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MK6FVu3cbnZIt3/Sc8rqum1oSqnULpVfEsKuw5FYjieuu0PRFr7f7Pz0LxZL?=
 =?us-ascii?Q?q0yj+zo5CrNE9qcu4J3PGET6OlJWbgk0u6wLsERsj9ok7akV1rR+YvOKHxlg?=
 =?us-ascii?Q?B1qWLhRxcDDSj7JCjKA4zvz7YQ0qFxOjU0W23+Vck0qV82CVTErlwJUbu3di?=
 =?us-ascii?Q?l1/tY/qACo1jv74uL3KOzP7JqZUX1kxwWULDJAPge/ybldm5gwOhvCMxGQ6A?=
 =?us-ascii?Q?X8+7Xg5JY57GZDxDKQqhSuKQ81ro4mzrjSJV3g3NRoZcZZxT+jLPHeLdtRzl?=
 =?us-ascii?Q?klGEgQhAfG/F1y5I3kluyL2qbkdpKigNGFnPuIzciaBWHxnuap7BHjEnzxCC?=
 =?us-ascii?Q?wAKy27eksHdHsF8Y/XYgEMu2YtysP68y0jPSCroPtuHkusZDznDrBW7mQGEF?=
 =?us-ascii?Q?qzwocKRjUaIxnY/E7VGEUdUAMgqypZ49tuszN+grsiS8jdOsC9JoIekowFk9?=
 =?us-ascii?Q?OMkgNmUMtH3TylcF5oKv8cPDMrXb+H8xx5pkd2bpIIjn8NKiDk0srIicTQt6?=
 =?us-ascii?Q?WGTOdHypG8RaaKAn7cvCsAFVKOrnlTM19W0fzzzC1JNGsVLX4FRwDCEjZg5C?=
 =?us-ascii?Q?Xx/gSPu06sHzaJzQnFHlPol92qMGaUa2NOtjD5Z5vJ6XP0Qit8YgR/hhNXV3?=
 =?us-ascii?Q?4lfqO4tH193TyGG71vGNPhJZ4NZ29spRupMCNYIkJUfiF0Cvxhnm7+c5ZL9+?=
 =?us-ascii?Q?b7mzsUlkySwJ8UeIYy1gCu6nRN+TWecyLJWAuA+i5v3kKYtqZV7jm1HVTGov?=
 =?us-ascii?Q?DBXzEGcDlxM2jjBtI+S2+8qASSnR7BAfo7CpDz94A1rLOZ+n8D3KW3GNG0nJ?=
 =?us-ascii?Q?2UFAV4soAaPhqZVh+udEt4WZcmEGvYXmb9SQp0Cpg4IuYWY7QGaS/Z8cECoi?=
 =?us-ascii?Q?Tf25AQHMuJ3ImjptuF22cmluDigrZiygi3RbEOVBY3gRGuslZZJnCyJp9S4C?=
 =?us-ascii?Q?WiKcCnp7XSheQqRJEArozaCMmA8g0c/uGQrUDIFBipXdAo+pf40lyUH2XZKn?=
 =?us-ascii?Q?2rXMVviQyht5bK7EJtS4x7cslIIhKo12Vr1R4ntHYfmuDyMQRD1+XoiY4Iqx?=
 =?us-ascii?Q?IQrjMEXDWvSX+tZNNGCaXBX0r3tkz+k19crOCM2M6x6jZAjM/ARCRQ2okPf0?=
 =?us-ascii?Q?QyVzXfbjw07i22SDdF2/BaZWaN5K/Ym2HIyFB1Bl5w5cYIC1vgGs/dIKgz4+?=
 =?us-ascii?Q?F8578WRQLRFltqKAeeg5IFLGaD/jol0NFiLYeJf501FJnlxMWs+i6IHh6+MW?=
 =?us-ascii?Q?APRUmThfYRXjvocRt+NBqnOg7QVq1mrSJ8X1IOS/Cs5W8w9IuzpSajPtcKZL?=
 =?us-ascii?Q?2fZTSddK5siF12eMisVMZW9la6q2cQ4E06486pe4JtpKeLPKHvlCV3PUppCp?=
 =?us-ascii?Q?+FqO+Jf5CMAJjWa6mevK+YrMJi25EvRHOWxZXiXzmjMQpUQLiFPuy6B+Eenw?=
 =?us-ascii?Q?y7sMBtcgibPQPSVn4mflUIzVLM0aFYAs47Tcllbgvycb0Omt+T/FzmiSworg?=
 =?us-ascii?Q?1pVrqzdqK8alJQ+ENXCXOxHFDnvEwOV8s9PnkpbqHTSERqW+ATHoa57B56kV?=
 =?us-ascii?Q?U30UGy8xe7EyDMjZqvS3dXsZviPrg/jtrtMW6G8uVinneqBHEOyftCn2lbGL?=
 =?us-ascii?Q?yltTsvsYktZOdXCnGsrT9hrPMtJXGW6HKvf1u4vt9bQA5h1pAY+ZpL1IA3v2?=
 =?us-ascii?Q?pZp9kx++y+a4UN297oy2ulhdmITmKCPtcLMPRIya8hHjVwyI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496dced6-1a60-4d8b-6344-08de7486d756
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:59:22.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SX8wBS3pyKmYv7qqGOB6NxRZ1L34eMJBE/rYknhp1f0fffravO1awQ7yF3SYhuY20H+jH9PiVzGvmzPDdu5s5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7251
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,mentor.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9084-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,pengutronix.de:email,i.mx:url]
X-Rspamd-Queue-Id: 8CD3F19A7C7
X-Rspamd-Action: no action

On Thu, Sep 11, 2025 at 11:56:41PM +0200, Marco Felsch wrote:
> Hi,
>
> by this series the i.MX SDMA handling for i.MX8M devices is fixed. This
> is required because these SoCs do have multiple SPBA busses.
>
> Furthermore this series does some cleanups to prepare the driver for the
> upcoming DMA devlink support. The DMA devlink support is required to fix
> the consumer <-> provider issue because the current i.MX SDMA driver
> doesn't honor current active DMA users once the i.MX SDMA driver is
> getting removed. Which can lead into very situations e.g. hang the whole
> system.

Marco Felsch:

	Can you help rebase these patches?

Frank

>
> Regards,
>   Marco
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de
> - Split DMA devlink support and SDMA driver fixes&cleanups into two series
> - Make of_dma_controller_free() fix backportable
> - Update struct sdma_channel documentation
> - Shuffle patches to have fixes patches at the very start of the series
> - Fix commit message wording
> - Check return value of devm_add_action_or_reset()
>
> ---
> Marco Felsch (10):
>       dmaengine: imx-sdma: fix missing of_dma_controller_free()
>       dmaengine: imx-sdma: fix spba-bus handling for i.MX8M
>       dmaengine: imx-sdma: drop legacy device_node np check
>       dmaengine: imx-sdma: sdma_remove minor cleanups
>       dmaengine: imx-sdma: cosmetic cleanup
>       dmaengine: imx-sdma: make use of devm_kzalloc for script_addrs
>       dmaengine: imx-sdma: make use of devm_clk_get_prepared()
>       dmaengine: imx-sdma: make use of devm_add_action_or_reset to unregiser the dma_device
>       dmaengine: imx-sdma: make use of devm_add_action_or_reset to unregiser the dma-controller
>       dmaengine: imx-sdma: make use of dev_err_probe()
>
>  drivers/dma/imx-sdma.c | 181 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 96 insertions(+), 85 deletions(-)
> ---
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> change-id: 20250903-v6-16-topic-sdma-4c8fd3bb0738
>
> Best regards,
> --
> Marco Felsch <m.felsch@pengutronix.de>
>

